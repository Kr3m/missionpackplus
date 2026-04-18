// Copyright (C) 1999-2000 Id Software, Inc.
//
// g_and.c -- Attack & Defend (GT_CTFS) round management

#include "g_local.h"

#ifdef MISSIONPACK

/* Broadcast a global non-attenuated sound to all clients (GT_CTFS round/match announces). */
void G_ATDGlobalSound( const char *path ) {
	gentity_t *te = G_TempEntity( level.intermission_origin, EV_GLOBAL_SOUND );
	te->s.eventParm = G_SoundIndex( path );
	te->r.svFlags |= SVF_BROADCAST;
}

/* Send a global non-attenuated sound to a single client. */
void G_ATDClientSound( int clientNum, const char *path ) {
	gentity_t *te = G_TempEntity( g_entities[clientNum].r.currentOrigin, EV_GLOBAL_SOUND );
	te->s.eventParm = G_SoundIndex( path );
	te->r.svFlags |= SVF_SINGLECLIENT;
	te->r.singleClient = clientNum;
}

/*
==============
G_ATDInitGame

Initialise Attack & Defend state at map load.
Must be called before G_CheckTeamItems() so Team_InitGame encodes the
correct attacking team into CS_FLAGSTATUS.
==============
*/
void G_ATDInitGame( void ) {
	if ( g_gametype.integer != GT_CTFS ) {
		return;
	}

	level.atdRoundNumber        = 1;
	level.atdRoundNumberStarted = 0;
	level.atdRoundStartTime     = level.time + g_warmup.integer * 1000;
	level.atdRoundRespawned     = qfalse;
	level.atdEliminationSides   = 1; // BLUE always defends round 1, RED always attacks
	level.atdRoundRedPlayers    = 0;
	level.atdRoundBluePlayers   = 0;
	level.atdRoundStartRed      = 0;
	level.atdRoundStartBlue     = 0;
	level.atdFlagToucherNum     = -1;
	level.atdElimTime           = 0;
	level.atdElimTouchScored    = qfalse;
	Com_Memset( level.atdRoundScoresRed,  0, sizeof( level.atdRoundScoresRed  ) );
	Com_Memset( level.atdRoundScoresBlue, 0, sizeof( level.atdRoundScoresBlue ) );
	/* Clear the round score configstring so clients start fresh. */
	trap_SetConfigstring( CS_ATD_ROUNDSCORES, "" );
	trap_SetConfigstring( CS_ATD_ROUNDSTART, "0" );
	trap_SetConfigstring( CS_ATD_RESPAWNED, "0" );
	/* CS_WARMUP will be set after the initial match warmup ends (G_ATDEndRound). */
}

/*
==============
G_ATDWarmupEnd

Called from G_WarmupEnd when GT_CTFS is active.  After the initial match
warmup, enter the first round's inter-round timer rather than jumping
straight into play.  Overwrites the CS_WARMUP that G_WarmupEnd just
cleared so the ATD countdown is visible to clients.
==============
*/
void G_ATDWarmupEnd( void ) {
	if ( g_gametype.integer != GT_CTFS ) {
		return;
	}

	level.atdRoundStartTime = level.time + atd_rounddelay.integer * 1000;
	level.atdRoundRespawned = qfalse;
	trap_SetConfigstring( CS_WARMUP, va( "%i", level.atdRoundStartTime ) );
}

/*
==============
G_ATDTeamLivingCount

Count players on a team with health > 0 (alive this round).
==============
*/
static int G_ATDTeamLivingCount( team_t team ) {
	int			i, count = 0;
	gclient_t	*cl;

	for ( i = 0; i < level.maxclients; i++ ) {
		cl = &level.clients[i];
		if ( cl->pers.connected != CON_CONNECTED ) {
			continue;
		}
		if ( cl->sess.sessionTeam != team ) {
			continue;
		}
		if ( cl->ps.stats[STAT_HEALTH] > 0 ) {
			count++;
		}
	}
	return count;
}

/*
==============
G_ATDUpdateRoundScoreCS

Builds the CS_ATD_ROUNDSCORES configstring from current per-half-round data
and pushes it to all clients.  Must be called before atdRoundNumber is
incremented so that atdRoundNumber equals the number of completed halves.
==============
*/
static void G_ATDUpdateRoundScoreCS( void ) {
	int  i, completedHalves, windowFirst, totalInWindow, offset;
	/* Each pair: up to "-2147483648 -2147483648" = 22 chars + separators.
	   Plus a leading offset integer (up to 10 chars) + space.
	   Buffer: 1 offset token + MAX_ATD_ROUNDS_WINDOW pairs, each <=23 chars. */
	char buf[12 + MAX_ATD_ROUNDS_WINDOW * 24];

	completedHalves = level.atdRoundNumber; /* not yet incremented */
	if ( completedHalves > MAX_ATD_ROUNDS_STORED ) completedHalves = MAX_ATD_ROUNDS_STORED;

	/* Transmit only the most recent MAX_ATD_ROUNDS_WINDOW half-rounds.
	   Prefix the CS with the absolute index of the first transmitted half. */
	windowFirst    = completedHalves > MAX_ATD_ROUNDS_WINDOW
	                 ? completedHalves - MAX_ATD_ROUNDS_WINDOW : 0;
	totalInWindow  = completedHalves - windowFirst;

	offset  = Com_sprintf( buf, (int)sizeof(buf), "%i", windowFirst );
	for ( i = 0; i < totalInWindow; i++ ) {
		offset += Com_sprintf( buf + offset, (int)sizeof(buf) - offset,
		                       " %i %i",
		                       level.atdRoundScoresRed[windowFirst + i],
		                       level.atdRoundScoresBlue[windowFirst + i] );
	}
	trap_SetConfigstring( CS_ATD_ROUNDSCORES, buf );
}

static int G_ATDEffectiveScoreLimit( void ) {
	int scorelimit = atd_scorelimit.integer;

	/* GT_CTFS historically uses scorelimit, but many server configs tune team
	   limits through capturelimit. Use the higher of both to avoid ending early
	   when those cvars are out of sync. */
	if ( g_capturelimit.integer > scorelimit ) {
		scorelimit = g_capturelimit.integer;
	}

	return scorelimit;
}

/*
==============
G_BroadcastScoresToAllClients

Send current scoreboard state to all connected clients.
Called before game-ending conditions to ensure final scores reach clients
before intermission is triggered.
==============
*/
static void G_BroadcastScoresToAllClients( void ) {
	int i;

	for ( i = 0; i < level.numConnectedClients; i++ ) {
		gclient_t *cl = &level.clients[level.sortedClients[i]];
		if ( cl->pers.connected != CON_DISCONNECTED ) {
			DeathmatchScoreboardMessage( &g_entities[level.sortedClients[i]] );
		}
	}
}

/*
==============
G_ATDEndRound

Called when an ATD round concludes (cap, elimination, or time).
Resets flags, advances the round counter, and begins the next warmup.
==============
*/
void G_ATDEndRound( void ) {
	int halfIdx;
	int scorelimit;
	int i;
	gclient_t *cl;

	Team_ResetFlags();
	ClearBodyQue();

	/* Reset health and armor for all active players so they enter the warmup
	   at full health rather than carrying over end-of-round damage. */
	for ( i = 0; i < level.maxclients; i++ ) {
		cl = &level.clients[i];
		if ( cl->pers.connected != CON_CONNECTED ) {
			continue;
		}
		if ( cl->sess.sessionTeam == TEAM_SPECTATOR ) {
			continue;
		}
		if ( g_entities[i].health <= 0 ) {
			continue;
		}
		g_entities[i].health =
			cl->ps.stats[STAT_HEALTH] = cl->ps.stats[STAT_MAX_HEALTH];
		cl->ps.stats[STAT_ARMOR]  = cl->ps.stats[STAT_MAX_HEALTH];
	}

	/* Record this half-round's per-team score delta before advancing the counter. */
	halfIdx = level.atdRoundNumber - 1; /* 0-based */
	if ( halfIdx >= 0 && halfIdx < MAX_ATD_ROUNDS_STORED ) {
		level.atdRoundScoresRed[halfIdx]  = level.teamScores[TEAM_RED]  - level.atdRoundStartRed;
		level.atdRoundScoresBlue[halfIdx] = level.teamScores[TEAM_BLUE] - level.atdRoundStartBlue;
	}
	G_ATDUpdateRoundScoreCS();

	level.atdRoundNumber++;

	/* Scorelimit check at round boundary.
	   Blue always attacks last. Determine which team just attacked using the same
	   formula as G_ATDCheckRules so the two stay in sync.
	   - After Red's attack: Blue always gets their response turn, never end the game here.
	     Notify players if Red is already at the scorelimit.
	   - After Blue's attack: resolve the winner if any team reached the scorelimit.
	     Blue > Red → Blue wins. Red > Blue → Red wins. Tied → another round pair. */
	scorelimit = G_ATDEffectiveScoreLimit();
	if ( scorelimit > 0 ) {
		int red  = level.teamScores[TEAM_RED];
		int blue = level.teamScores[TEAM_BLUE];
		/* Which team attacked the round that just finished?
		   Mirror the formula in G_CheckATDRound (before the increment,
		   atdRoundNumber was level.atdRoundNumber - 1). */
		qboolean blueJustAttacked =
			( ( level.atdEliminationSides + level.atdRoundNumber - 1 ) % 2 != 0 );

		if ( !blueJustAttacked ) {
			/* Red just attacked — Blue always gets their response round.
			   Inform players if Red is already at or past the scorelimit. */
			if ( red >= scorelimit ) {
				int lead = red - blue;
				if ( lead > 4 ) {
					G_BroadcastServerCommand( -1, va(
						"print \"^1Red^7 has hit the scorelimit with a ^1%i^7-point lead"
						" — ^4Blue^7 plays a consolation round.\n\"", lead ) );
				} else {
					G_BroadcastServerCommand( -1,
						"print \"^1Red^7 has hit the scorelimit — ^4Blue^7 plays a final round!\n\"" );
				}
			}
		} else {
			/* Blue just attacked — resolve the winner if scorelimit is reached. */
			if ( red >= scorelimit || blue >= scorelimit ) {
				if ( blue > red ) {
					CalculateRanks();
					G_BroadcastScoresToAllClients();
					G_BroadcastServerCommand( -1, "print \"^4Blue^7 wins!\n\"" );
					G_ATDGlobalSound( "sound/vo/blue_wins.wav" );
					LogExit( "Scorelimit hit." );
					return;
				} else if ( red > blue ) {
					CalculateRanks();
					G_BroadcastScoresToAllClients();
					G_BroadcastServerCommand( -1, "print \"^1Red^7 wins!\n\"" );
					G_ATDGlobalSound( "sound/vo/red_wins.wav" );
					LogExit( "Scorelimit hit." );
					return;
				}
				/* Tied at or above scorelimit — play another round pair. */
			}
		}
	}

	level.atdRoundStartTime   = level.time + atd_rounddelay.integer * 1000;
	level.atdRoundRespawned   = qfalse;
	level.atdRoundFreezeTime  = 0;
	level.atdRoundRedPlayers  = 0;
	level.atdRoundBluePlayers = 0;
	level.atdRound30SecWarned = qfalse;
	level.atdFlagToucherNum   = -1;
	level.atdElimTime         = 0;
	level.atdElimTouchScored  = qfalse;
	/* Clear the active-round timer on clients — round is now in warmup phase. */
	trap_SetConfigstring( CS_ATD_ROUNDSTART, "0" );
	trap_SetConfigstring( CS_ATD_RESPAWNED, "0" );
	/* Show a countdown to all clients during the inter-round freeze. */
	trap_SetConfigstring( CS_WARMUP, va( "%i", level.atdRoundStartTime ) );
	/* Re-init flags so Team_SetFlagStatus fires with the new round's attacking team
	   encoded in the CS_FLAGSTATUS configstring.                                    */
	Team_DirtyFlagStatus();
	Team_InitGame();
	CalculateRanks();
}

/*
==============
G_CheckATDRound

Per-frame check for round start/end conditions in GT_CTFS.
Called from G_RunFrame whenever gametype is GT_CTFS.
==============
*/
void G_CheckATDRound( void ) {
	int		i;
	int		atkTeam, defTeam;
	int		livesAtk, liesDef;
	gentity_t	*ent;

	if ( level.intermissiontime ) {
		return;
	}
	/* Also guard once LogExit has been called (intermission queued but not yet
	   started).  Without this, the 2-second delay window lets G_CheckATDRound
	   "start" a phantom next-round and then immediately trigger a spurious
	   wins_round sound if any players happen to be dead at that moment. */
	if ( level.intermissionQueued ) {
		return;
	}
	if ( level.warmupTime != 0 ) {
		return; // still in overall match warmup
	}

	atkTeam = ((level.atdEliminationSides + level.atdRoundNumber) % 2 == 0)
	           ? TEAM_RED : TEAM_BLUE;
	defTeam = OtherTeam( atkTeam );

	/* ---- warmup phase between rounds ---- */
	if ( level.atdRoundNumber != level.atdRoundNumberStarted ) {
		/* Halfway through warmup, respawn everyone so they start at their spawns. */
		if ( !level.atdRoundRespawned &&
		     level.time >= level.atdRoundStartTime - ( atd_rounddelay.integer * 500 ) ) {
			level.atdRoundRespawned  = qtrue;
			level.atdRoundFreezeTime = level.time + 500;
			trap_SetConfigstring( CS_ATD_RESPAWNED, va( "%i", level.atdRoundFreezeTime ) );
			for ( i = 0; i < level.maxclients; i++ ) {
				ent = g_entities + i;
				if ( !ent->inuse || !ent->client ) {
					continue;
				}
				if ( ent->client->pers.connected != CON_CONNECTED ) {
					continue;
				}
				/* Restore ATD dead-spectators to their original team before
				   respawning.  spectatorState is reset here too so the engine
				   no longer treats them as spectators when ClientSpawn runs. */
				if ( ent->client->atdDeadSpecTeam != TEAM_FREE ) {
					ent->client->sess.sessionTeam    = ent->client->atdDeadSpecTeam;
					ent->client->sess.spectatorState = SPECTATOR_NOT;
					ent->client->atdDeadSpecTeam     = TEAM_FREE;
					ent->client->sess.spectatorClient = i;
				}
				if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
					continue;
				}
				respawn( ent );
			}
			/* respawn() -> ClientSpawn() -> CopyToBodyQue() creates fresh body
			   entities for each dead player.  Clear them now so no corpse
			   leftovers are visible for the rest of the warmup. */
			ClearBodyQue();
		}

		/* When warmup expires, officially start the round. */
		if ( level.time >= level.atdRoundStartTime ) {
			/* Re-seed both flags at the exact moment the half-round goes live.
			   This guarantees clean flag state even if any entity logic during
			   inter-round warmup changed flag entities unexpectedly. */
			Team_ResetFlags();

			level.atdRoundNumberStarted = level.atdRoundNumber;
			level.atdRound30SecWarned   = qfalse;
			level.atdTouchScored        = qfalse;
			level.atdRoundRedPlayers    = G_ATDTeamLivingCount( TEAM_RED );
			level.atdRoundBluePlayers   = G_ATDTeamLivingCount( TEAM_BLUE );
			level.atdRoundStartRed      = level.teamScores[TEAM_RED];
			level.atdRoundStartBlue     = level.teamScores[TEAM_BLUE];
			/* Publish the exact round-start time so clients can render the countdown. */
			trap_SetConfigstring( CS_ATD_ROUNDSTART, va( "%i", level.atdRoundStartTime ) );
			/* Clear the inter-round countdown and unfreeze players. */
			trap_SetConfigstring( CS_WARMUP, "" );
			G_BroadcastServerCommand( -1, va( "print \"Round %i — %s attacks, %s defends!\n\"",
				( level.atdRoundNumber + 1 ) / 2,
				( atkTeam == TEAM_RED ) ? "^1Red^7" : "^4Blue^7",
				( defTeam == TEAM_RED ) ? "^1Red^7" : "^4Blue^7" ) );
		}
		return;
	}

	/* ---- round is active — check end conditions ---- */

	/* 1. 30-second warning — fire a dedicated broadcast event. */
	if ( g_roundtimelimit.integer > 30 && !level.atdRound30SecWarned &&
	     level.time >= level.atdRoundStartTime + ( g_roundtimelimit.integer - 30 ) * 1000 ) {
		gentity_t *te;
		level.atdRound30SecWarned = qtrue;
		te = G_TempEntity( level.intermission_origin, EV_ATD_30SEC_WARNING );
		te->r.svFlags |= SVF_BROADCAST;
	}

	/* 2. Round time expired — no points awarded, round draws. */
	if ( g_roundtimelimit.integer > 0 &&
	     level.time >= level.atdRoundStartTime + g_roundtimelimit.integer * 1000 ) {
		G_BroadcastServerCommand( -1, "print \"Round time expired. No capture this round.\n\"" );
		G_ATDGlobalSound( "sound/vo_evil/round_draw.wav" );
		G_ATDEndRound();
		return;
	}

	/* 2. We need at least one player per team to have been present before
	   triggering an elimination win (prevents false wins on empty teams). */
	if ( level.atdRoundRedPlayers == 0 || level.atdRoundBluePlayers == 0 ) {
		return;
	}

	livesAtk = G_ATDTeamLivingCount( atkTeam );
	liesDef  = G_ATDTeamLivingCount( defTeam );

	/* 3. Entire attacking team wiped — round ends, no score (only offense can score). */
	if ( livesAtk == 0 ) {
		G_BroadcastServerCommand( -1, "print \"Attacking team eliminated! Round over.\n\"" );
		G_ATDEndRound();
		if ( !level.intermissionQueued ) {
			G_ATDGlobalSound( defTeam == TEAM_RED ? "sound/vo/red_wins_round.wav" : "sound/vo/blue_wins_round.wav" );
		}
		return;
	}

	/* 4. Entire defending team wiped — attackers earn 2 pts.
	   g_threewave: defer 3 seconds to allow a final flag touch for +1 before ending. */
	if ( liesDef == 0 ) {
		if ( g_threewave.integer && level.atdElimTime == 0 ) {
			/* First frame of elimination: start the 3-second touch window. */
			level.atdElimTime = level.time;
			G_BroadcastServerCommand( -1, "print \"Defending team eliminated! Touch the flag for a bonus point!\n\"" );
		}
		/* Wait out the 3-second window before ending the round. */
		if ( level.atdElimTime > 0 && level.time >= level.atdElimTime + 3000 ) {
			AddTeamScore( level.intermission_origin, atkTeam, 2 );
			G_BroadcastServerCommand( -1, "print \"Defending team eliminated! Attackers score 2 points!\n\"" );
			G_ATDEndRound();
			if ( !level.intermissionQueued ) {
				G_ATDGlobalSound( atkTeam == TEAM_RED ? "sound/vo/red_wins_round.wav" : "sound/vo/blue_wins_round.wav" );
			}
			return;
		}
		if ( !g_threewave.integer ) {
			G_BroadcastServerCommand( -1, "print \"Defending team eliminated! Attackers score 2 points!\n\"" );
			AddTeamScore( level.intermission_origin, atkTeam, 2 );
			G_ATDEndRound();
			if ( !level.intermissionQueued ) {
				G_ATDGlobalSound( atkTeam == TEAM_RED ? "sound/vo/red_wins_round.wav" : "sound/vo/blue_wins_round.wav" );
			}
			return;
		}
	}
}

#endif /* MISSIONPACK */
