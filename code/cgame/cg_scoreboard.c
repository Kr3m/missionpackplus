// Copyright (C) 1999-2000 Id Software, Inc.
//
// cg_scoreboard -- draw the scoreboard on top of the game screen
#include "cg_local.h"
#ifdef MISSIONPACK
#include "../ui/ui_shared.h"
#endif


#define	SCOREBOARD_X		(0)

#define SB_HEADER			86
#define SB_TOP				(SB_HEADER+32)

// Where the status bar starts, so we don't overwrite it
#define SB_STATUSBAR		420

#define SB_NORMAL_HEIGHT	40
#define SB_INTER_HEIGHT		16 // interleaved height

#define SB_MAXCLIENTS_NORMAL  ((SB_STATUSBAR - SB_TOP) / SB_NORMAL_HEIGHT)
#define SB_MAXCLIENTS_INTER   ((SB_STATUSBAR - SB_TOP) / SB_INTER_HEIGHT - 1)

// Used when interleaved



#define SB_LEFT_BOTICON_X	(SCOREBOARD_X+0)
#define SB_LEFT_HEAD_X		(SCOREBOARD_X+32)
#define SB_RIGHT_BOTICON_X	(SCOREBOARD_X+64)
#define SB_RIGHT_HEAD_X		(SCOREBOARD_X+96)
// Normal
#define SB_BOTICON_X		(SCOREBOARD_X+32)
#define SB_HEAD_X			(SCOREBOARD_X+64)

#define SB_SCORELINE_X		112

#define SB_RATING_WIDTH	    (6 * BIGCHAR_WIDTH) // width 6
#define SB_SCORE_X			(SB_SCORELINE_X + BIGCHAR_WIDTH) // width 6
#define SB_RATING_X			(SB_SCORELINE_X + 6 * BIGCHAR_WIDTH) // width 6
#define SB_PING_X			(SB_SCORELINE_X + 12 * BIGCHAR_WIDTH + 8) // width 5
#define SB_TIME_X			(SB_SCORELINE_X + 17 * BIGCHAR_WIDTH + 8) // width 5
#define SB_NAME_X			(SB_SCORELINE_X + 22 * BIGCHAR_WIDTH) // width 15

// The new and improved score board
//
// In cases where the number of clients is high, the score board heads are interleaved
// here's the layout

//
//	0   32   80  112  144   240  320  400   <-- pixel position
//  bot head bot head score ping time name
//
//  wins/losses are drawn on bot icon now

static qboolean localClient; // true if local client has been displayed


/*
=================
CG_DrawScoreboard
=================
*/
static void CG_DrawClientScore( int y, score_t *score, float *color, float fade, qboolean largeFormat ) {
	char	string[ 64 ];
	vec3_t	headAngles;
	clientInfo_t	*ci;
	int iconx, headx;
	vec4_t c;

	if ( score->client < 0 || score->client >= cgs.maxclients ) {
		Com_Printf( "Bad score->client: %i\n", score->client );
		return;
	}

	ci = &cgs.clientinfo[score->client];
	if ( !ci->infoValid )
		return;

	iconx = SB_BOTICON_X + (SB_RATING_WIDTH / 2);
	headx = SB_HEAD_X + (SB_RATING_WIDTH / 2);

	trap_R_SetColor( NULL );

	// draw the handicap or bot skill marker (unless player has flag)
	if ( ci->powerups & ( 1 << PW_NEUTRALFLAG ) ) {
		if( largeFormat ) {
			CG_DrawFlagModel( iconx, y - ( 32 - BIGCHAR_HEIGHT ) / 2, 32, 32, TEAM_FREE, qfalse );
		}
		else {
			CG_DrawFlagModel( iconx, y, 16, 16, TEAM_FREE, qfalse );
		}
	} else if ( ci->powerups & ( 1 << PW_REDFLAG ) ) {
		if( largeFormat ) {
			CG_DrawFlagModel( iconx, y - ( 32 - BIGCHAR_HEIGHT ) / 2, 32, 32, TEAM_RED, qfalse );
		}
		else {
			CG_DrawFlagModel( iconx, y, 16, 16, TEAM_RED, qfalse );
		}
	} else if ( ci->powerups & ( 1 << PW_BLUEFLAG ) ) {
		if( largeFormat ) {
			CG_DrawFlagModel( iconx, y - ( 32 - BIGCHAR_HEIGHT ) / 2, 32, 32, TEAM_BLUE, qfalse );
		}
		else {
			CG_DrawFlagModel( iconx, y, 16, 16, TEAM_BLUE, qfalse );
		}
	} else {
		if ( ci->botSkill > 0 && ci->botSkill <= 5 ) {
			if ( cg_drawIcons.integer ) {
				if( largeFormat ) {
					CG_DrawPic( iconx, y - ( 32 - BIGCHAR_HEIGHT ) / 2, 32, 32, cgs.media.botSkillShaders[ ci->botSkill - 1 ] );
				}
				else {
					CG_DrawPic( iconx, y, 16, 16, cgs.media.botSkillShaders[ ci->botSkill - 1 ] );
				}
			}
		} else if ( ci->handicap < 100 ) {
			BG_sprintf( string, "%i", ci->handicap );
			if ( cgs.gametype == GT_TOURNAMENT )
				CG_DrawString( iconx, y - SMALLCHAR_HEIGHT/2, string, color, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, DS_FORCE_COLOR );
			else
				CG_DrawString( iconx, y, string, color, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, DS_FORCE_COLOR );
		}

		// draw the wins / losses
		if ( cgs.gametype == GT_TOURNAMENT ) {
			BG_sprintf( string, "%i/%i", ci->wins, ci->losses );
			if( ci->handicap < 100 && !ci->botSkill ) {
				CG_DrawString( iconx, y + SMALLCHAR_HEIGHT/2, string, color, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, DS_FORCE_COLOR );
			} else {
				CG_DrawString( iconx, y, string, color, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, DS_FORCE_COLOR );
			}
		}
	}

	// draw the face
	VectorClear( headAngles );
	headAngles[YAW] = 180;
	if( largeFormat ) {
		CG_DrawHead( headx, y - ( ICON_SIZE - BIGCHAR_HEIGHT ) / 2, ICON_SIZE, ICON_SIZE,
			score->client, headAngles );
	}
	else {
		CG_DrawHead( headx, y, 16, 16, score->client, headAngles );
	}

#ifdef MISSIONPACK
	// draw the team task
	if ( ci->teamTask != TEAMTASK_NONE ) {
		if ( ci->teamTask == TEAMTASK_OFFENSE ) {
			CG_DrawPic( headx + 48, y, 16, 16, cgs.media.assaultShader );
		}
		else if ( ci->teamTask == TEAMTASK_DEFENSE ) {
			CG_DrawPic( headx + 48, y, 16, 16, cgs.media.defendShader );
		}
	}
#endif
	// draw the score line
	if ( score->ping == -1 ) {
		BG_sprintf( string, " connecting" );
	} else if ( ci->team == TEAM_SPECTATOR ) {
		BG_sprintf( string, " SPECT %3i %4i", score->ping, score->time );
	} else {
		BG_sprintf( string, "%5i %4i %4i", score->score, score->ping, score->time );
	}

	// highlight your position
	if ( score->client == cg.snap->ps.clientNum ) {
		float	hcolor[4];
		int		rank;

		localClient = qtrue;

		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR
			|| cgs.gametype >= GT_TEAM ) {
			rank = -1;
		} else {
			rank = cg.snap->ps.persistant[PERS_RANK] & ~RANK_TIED_FLAG;
		}
		if ( rank == 0 ) {
			hcolor[0] = 0;
			hcolor[1] = 0;
			hcolor[2] = 0.7f;
		} else if ( rank == 1 ) {
			hcolor[0] = 0.7f;
			hcolor[1] = 0;
			hcolor[2] = 0;
		} else if ( rank == 2 ) {
			hcolor[0] = 0.7f;
			hcolor[1] = 0.7f;
			hcolor[2] = 0;
		} else {
			hcolor[0] = 0.7f;
			hcolor[1] = 0.7f;
			hcolor[2] = 0.7f;
		}

		hcolor[3] = fade * 0.7;
		CG_FillRect( SB_SCORELINE_X + BIGCHAR_WIDTH + (SB_RATING_WIDTH / 2), y,
			640 - SB_SCORELINE_X - BIGCHAR_WIDTH - (SB_RATING_WIDTH/2),
			BIGCHAR_HEIGHT+1, hcolor );
	}

	VectorSet( c, 1, 1, 1 ); c[3] = fade;
	// score
	CG_DrawString( SB_SCORELINE_X + (SB_RATING_WIDTH / 2), y, string, c, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW );
	// name
	CG_DrawString( SB_SCORELINE_X + (SB_RATING_WIDTH / 2) + BIGCHAR_WIDTH*16, y, ci->name, c, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_PROPORTIONAL );

	// add the "ready" marker for intermission exiting
	if ( cg.snap->ps.stats[ STAT_CLIENTS_READY ] & ( 1 << score->client ) ) {
		CG_DrawString( iconx, y, "READY", color, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_FORCE_COLOR );
	}

	// set bounds for scoreboard clicks
	score->minx = SB_SCORELINE_X;
	score->maxx = SCREEN_WIDTH - 8;
	score->miny = y;
	score->maxy = y + BIGCHAR_HEIGHT;
	if ( largeFormat )
	{
		score->miny -= ( ICON_SIZE - BIGCHAR_HEIGHT ) / 2;
		score->maxy += ( ICON_SIZE - BIGCHAR_HEIGHT ) / 2;
	}
}

/*
=================
CG_ScoreboardClick
=================
*/
void CG_ScoreboardClick( void )
{
	score_t	*score;
	int i;

	if ( cg.intermissionStarted )
		return;

	if ( !cg.snap || cg.snap->ps.pm_type == PM_INTERMISSION )
		return;

	score = cg.scores;
	for ( i = 0; i < cg.numScores; i++, score++ ) {
		if ( score->team >= TEAM_SPECTATOR ) {
			continue;
		}
		if ( cgs.cursorX < score->minx || cgs.cursorX > score->maxx )
			continue;
		if ( cgs.cursorY < score->miny || cgs.cursorY > score->maxy )
			continue;
		if ( !cgs.clientinfo[ score->client ].infoValid ) {
			continue;
		}

		if ( !cg.demoPlayback ) {
			trap_SendClientCommand( va( "follow %i", score->client ) );
		}
	}
}


/*
=================
CG_TeamScoreboard
=================
*/
static int CG_TeamScoreboard( int y, team_t team, float fade, int maxClients, int lineHeight ) {
	int		i;
	score_t	*score;
	float	color[4];
	int		count;
	clientInfo_t	*ci;

	color[0] = color[1] = color[2] = 1.0;
	color[3] = fade;

	count = 0;
	for ( i = 0 ; i < cg.numScores && count < maxClients ; i++ ) {
		score = &cg.scores[i];
		ci = &cgs.clientinfo[ score->client ];

		if ( team != ci->team || !ci->infoValid ) {
			continue;
		}

		CG_DrawClientScore( y + lineHeight * count, score, color, fade, lineHeight == SB_NORMAL_HEIGHT );

		count++;
	}

	return count;
}

/*
=================
CG_DrawScoreboard

Draw the normal in-game scoreboard
=================
*/
qboolean CG_DrawOldScoreboard( void ) {
	int		y, i, n1, n2;
	float	fade;
	float	*fadeColor;
	char	*s;
	int maxClients;
	int lineHeight;
	int topBorderSize, bottomBorderSize;

	// don't draw anything if the menu or console is up
	if ( cg_paused.integer ) {
		cg.deferredPlayerLoading = 0;
		return qfalse;
	}

	if ( cgs.gametype == GT_SINGLE_PLAYER && cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
		cg.deferredPlayerLoading = 0;
		return qfalse;
	}

	// don't draw scoreboard during death while warmup up
	if ( cg.warmup && !cg.showScores ) {
		return qfalse;
	}

	if ( cg.showScores || cg.predictedPlayerState.pm_type == PM_DEAD ||
		 cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
		fade = 1.0;
		fadeColor = colorWhite;
	} else {
		fadeColor = CG_FadeColor( cg.scoreFadeTime, FADE_TIME );

		if ( !fadeColor ) {
			// next time scoreboard comes up, don't print killer
			cg.deferredPlayerLoading = 0;
			cg.killerName[0] = 0;
			return qfalse;
		}
		fade = fadeColor[3];
	}

	// fragged by ... line
	if ( cg.killerName[0] ) {
		s = va( "Fragged by %s", cg.killerName );
		CG_DrawString( 320, 40, s, fadeColor, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_CENTER | DS_PROPORTIONAL );
	}

	// current rank
	if ( cgs.gametype < GT_TEAM) {
		if (cg.snap->ps.persistant[PERS_TEAM] != TEAM_SPECTATOR ) {
			s = va( "%s place with %i",
				CG_PlaceString( cg.snap->ps.persistant[PERS_RANK] + 1 ),
				cg.snap->ps.persistant[PERS_SCORE] );

			CG_DrawString( 320, 60, s, fadeColor, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_CENTER | DS_PROPORTIONAL );
		}
	} else {
		if ( cg.teamScores[0] == cg.teamScores[1] ) {
			s = va("Teams are tied at %i", cg.teamScores[0] );
		} else if ( cg.teamScores[0] >= cg.teamScores[1] ) {
			s = va("Red leads %i to %i",cg.teamScores[0], cg.teamScores[1] );
		} else {
			s = va("Blue leads %i to %i",cg.teamScores[1], cg.teamScores[0] );
		}

		CG_DrawString( 320, 60, s, fadeColor, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_CENTER | DS_PROPORTIONAL );
	}

	// scoreboard
	y = SB_HEADER;

	CG_DrawPic( SB_SCORE_X + (SB_RATING_WIDTH / 2), y, 64, 32, cgs.media.scoreboardScore );
	CG_DrawPic( SB_PING_X - (SB_RATING_WIDTH / 2), y, 64, 32, cgs.media.scoreboardPing );
	CG_DrawPic( SB_TIME_X - (SB_RATING_WIDTH / 2), y, 64, 32, cgs.media.scoreboardTime );
	CG_DrawPic( SB_NAME_X - (SB_RATING_WIDTH / 2), y, 64, 32, cgs.media.scoreboardName );

	y = SB_TOP;

	// If there are more than SB_MAXCLIENTS_NORMAL, use the interleaved scores
	if ( cg.numScores > SB_MAXCLIENTS_NORMAL ) {
		maxClients = SB_MAXCLIENTS_INTER;
		lineHeight = SB_INTER_HEIGHT;
		topBorderSize = 8;
		bottomBorderSize = 16;
	} else {
		maxClients = SB_MAXCLIENTS_NORMAL;
		lineHeight = SB_NORMAL_HEIGHT;
		topBorderSize = 16;
		bottomBorderSize = 16;
	}

	localClient = qfalse;

	if ( cgs.gametype >= GT_TEAM ) {
		//
		// teamplay scoreboard
		//
		y += lineHeight/2;

		if ( cg.teamScores[0] >= cg.teamScores[1] ) {
			n1 = CG_TeamScoreboard( y, TEAM_RED, fade, maxClients, lineHeight );
			CG_DrawTeamBackground( 0, y - topBorderSize, 640, n1 * lineHeight + bottomBorderSize, 0.33f, TEAM_RED );
			y += (n1 * lineHeight) + BIGCHAR_HEIGHT;
			maxClients -= n1;
			n2 = CG_TeamScoreboard( y, TEAM_BLUE, fade, maxClients, lineHeight );
			CG_DrawTeamBackground( 0, y - topBorderSize, 640, n2 * lineHeight + bottomBorderSize, 0.33f, TEAM_BLUE );
			y += (n2 * lineHeight) + BIGCHAR_HEIGHT;
			maxClients -= n2;
		} else {
			n1 = CG_TeamScoreboard( y, TEAM_BLUE, fade, maxClients, lineHeight );
			CG_DrawTeamBackground( 0, y - topBorderSize, 640, n1 * lineHeight + bottomBorderSize, 0.33f, TEAM_BLUE );
			y += (n1 * lineHeight) + BIGCHAR_HEIGHT;
			maxClients -= n1;
			n2 = CG_TeamScoreboard( y, TEAM_RED, fade, maxClients, lineHeight );
			CG_DrawTeamBackground( 0, y - topBorderSize, 640, n2 * lineHeight + bottomBorderSize, 0.33f, TEAM_RED );
			y += (n2 * lineHeight) + BIGCHAR_HEIGHT;
			maxClients -= n2;
		}
		n1 = CG_TeamScoreboard( y, TEAM_SPECTATOR, fade, maxClients, lineHeight );
		y += (n1 * lineHeight) + BIGCHAR_HEIGHT;

	} else {
		//
		// free for all scoreboard
		//
		n1 = CG_TeamScoreboard( y, TEAM_FREE, fade, maxClients, lineHeight );
		y += (n1 * lineHeight) + BIGCHAR_HEIGHT;
		n2 = CG_TeamScoreboard( y, TEAM_SPECTATOR, fade, maxClients - n1, lineHeight );
		y += (n2 * lineHeight) + BIGCHAR_HEIGHT;
	}

	if (!localClient) {
		// draw local client at the bottom
		for ( i = 0 ; i < cg.numScores ; i++ ) {
			if ( cg.scores[i].client == cg.snap->ps.clientNum ) {
				CG_DrawClientScore( y, &cg.scores[i], fadeColor, fade, lineHeight == SB_NORMAL_HEIGHT );
				break;
			}
		}
	}

	// load any models that have been deferred
	if ( ++cg.deferredPlayerLoading > 10 ) {
		CG_LoadDeferredPlayers();
	}

	return qtrue;
}

//================================================================================


/*
=================
CG_DrawTourneyScoreboard

Draw the oversize scoreboard for tournements
=================
*/
void CG_DrawOldTourneyScoreboard( void ) {
	const char		*s;
	vec4_t			color;
	int				min, sec;
	clientInfo_t	*ci;
	int				y;
	int				i;

	// request more scores regularly
	if ( cg.scoresRequestTime + 2000 < cg.time ) {
		cg.scoresRequestTime = cg.time;
		trap_SendClientCommand( "score" );
	}

	// draw the dialog background
	color[0] = color[1] = color[2] = 0.2f;
	color[3] = 1;
	CG_FillScreen( color );

	// print the mesage of the day
	s = CG_ConfigString( CS_MOTD );
	if ( !s[0] ) {
		s = "Scoreboard";
	}

	// print optional title
	CG_DrawString( 320, 8, s, colorWhite, GIANT_WIDTH, GIANT_HEIGHT, 0, DS_SHADOW | DS_FORCE_COLOR | DS_CENTER | DS_PROPORTIONAL );

	// print server time
	sec = cg.time / 1000;
	min = sec / 60;
	sec %= 60;

	s = va( "%i:%02i", min, sec );

	CG_DrawString( 320, 64, s, colorWhite, GIANT_WIDTH, GIANT_HEIGHT, 0, DS_SHADOW | DS_FORCE_COLOR | DS_CENTER | DS_PROPORTIONAL );

	// print the two scores

	y = 160;
	if ( cgs.gametype >= GT_TEAM ) {
		//
		// teamplay scoreboard
		//
		CG_DrawString( 8, y, "Red Team", colorWhite, GIANT_WIDTH, GIANT_HEIGHT, 0, DS_SHADOW );
		s = va( "%i", cg.teamScores[0] );
		CG_DrawString( 632, y, s, colorWhite, GIANT_WIDTH, GIANT_HEIGHT, 0, DS_SHADOW | DS_RIGHT );

		y += 64;

		CG_DrawString( 8, y, "Blue Team", colorWhite, GIANT_WIDTH, GIANT_HEIGHT, 0, DS_SHADOW );
		s = va( "%i", cg.teamScores[1] );
		CG_DrawString( 632, y, s, colorWhite, GIANT_WIDTH, GIANT_HEIGHT, 0, DS_SHADOW | DS_RIGHT );

	} else {
		//
		// free for all scoreboard
		//
		for ( i = 0 ; i < MAX_CLIENTS ; i++ ) {
			ci = &cgs.clientinfo[i];
			if ( !ci->infoValid ) {
				continue;
			}
			if ( ci->team != TEAM_FREE ) {
				continue;
			}

			CG_DrawString( 8, y, ci->name, colorWhite, GIANT_WIDTH, GIANT_HEIGHT, 0, DS_SHADOW | DS_FORCE_COLOR | DS_PROPORTIONAL );
			s = va( "%i", ci->score );
			CG_DrawString( 632, y, s, colorWhite, GIANT_WIDTH, GIANT_HEIGHT, 0, DS_SHADOW | DS_RIGHT );
			y += 64;
		}
	}
}

#ifdef MISSIONPACK
/*
=================
CG_DrawATDRoundScores

Draws the round-score panel during inter-round warmup.
Geometry mirrors the menudef layout (640x120 panel at the top of screen):

  rect 0   0  640 120  -- panel
  rect 2   2  636 116  -- border
  rect 114 2    2 116  -- left divider (after label column)
  rect 2  40  636   2  -- header divider
  "Round"  / round numbers  at y=10 h=20  scale 0.30
  Red label / red scores    at y=55 h=20  scale 0.35 / 0.30
  Blue label / blue scores  at y=85 h=20  scale 0.35 / 0.30

  10 score columns, pitch 53px, first column left-edge at x=140, cell width 40.
  Numbers are centered within their 40px cell.
  Shows "-" for unplayed rounds; shifts window left once more than 10 rounds.
=================
*/
void CG_DrawATDRoundScores( float fade ) {
	/*
	 * Layout: 640x120 panel centred vertically on the 480px screen.
	 * Label column: x=2..114 (112px).  Score area: x=116..638 (522px).
	 * 10 columns, each 52px wide (522/10 = 52.2 → 52).
	 * COL0_LEFT=116, PITCH=52, centering uses the full 52px slot.
	 */
	static const float	SCALE_NUM  = 0.28f;	/* round numbers + score values */
	static const float	SCALE_LBL  = 0.33f;	/* team name labels */
	static const float	COL_PITCH  = 52.0f;
	static const float	COL0_LEFT  = 116.0f;
	static const float	LABEL_X    = 10.0f;
	static const float	PANEL_H    = 120.0f;
	static const float	PANEL_Y    = ( 480.0f - 120.0f ) * 0.5f;
	static const int	DISP_COLS  = 10;

	int		completedHalves, completedFull, windowStart;
	int		i, half0, half1;
	float	textH, cx, baseY;
	vec4_t	cBg, cBorder, cWhite, cRed, cBlu;
	const char	*s;

	completedHalves = cgs.atdCompletedRounds;
	if ( completedHalves <= 0 ) {
		return;
	}

	completedFull = ( completedHalves + 1 ) / 2;
	windowStart   = completedFull > DISP_COLS ? completedFull - DISP_COLS : 0;

	textH = (float)CG_Text_Height( "R", SCALE_NUM, 0 );

	/* colors */
	cBg[0]     = 0.0f;  cBg[1]     = 0.0f;  cBg[2]     = 0.0f;  cBg[3]     = 0.7f * fade;
	cBorder[0] = 1.0f;  cBorder[1] = 1.0f;  cBorder[2] = 1.0f;  cBorder[3] = fade;
	cWhite[0]  = 1.0f;  cWhite[1]  = 1.0f;  cWhite[2]  = 1.0f;  cWhite[3]  = fade;
	cRed[0]    = 1.0f;  cRed[1]    = 0.3f;  cRed[2]    = 0.3f;  cRed[3]    = fade;
	cBlu[0]    = 0.4f;  cBlu[1]    = 0.6f;  cBlu[2]    = 1.0f;  cBlu[3]    = fade;

	/* --- panel background + border --- */
	CG_FillRect( 0,   PANEL_Y,            640,  PANEL_H,       cBg );
	CG_DrawRect( 2,   PANEL_Y + 2,        636,  PANEL_H - 4,   1.0f, cBorder );
	/* vertical divider after label column */
	CG_FillRect( 114, PANEL_Y + 2,        2,    PANEL_H - 4,   cBorder );
	/* horizontal divider below header */
	CG_FillRect( 2,   PANEL_Y + 40,       636,  2,             cBorder );

	/* --- header row (y=10, h=20) --- */
	baseY = PANEL_Y + 10.0f + ( 20.0f + textH ) * 0.5f;
	CG_Text_Paint( LABEL_X, baseY, SCALE_NUM, cWhite, "Round", 0, 0, ITEM_TEXTSTYLE_SHADOWED );
	for ( i = 0; i < DISP_COLS; i++ ) {
		s  = va( "%i", windowStart + i + 1 );
		cx = COL0_LEFT + (float)i * COL_PITCH
		     + ( COL_PITCH - (float)CG_Text_Width( s, SCALE_NUM, 0 ) ) * 0.5f;
		CG_Text_Paint( cx, baseY, SCALE_NUM, cWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWED );
	}

	/* --- red row (y=55, h=20) --- */
	baseY = PANEL_Y + 55.0f + ( 20.0f + textH ) * 0.5f;
	s = cgs.redTeam[0] ? cgs.redTeam : DEFAULT_REDTEAM_NAME;
	CG_Text_Paint( LABEL_X, baseY, SCALE_LBL, cRed, s, 0, 0, ITEM_TEXTSTYLE_SHADOWED );
	for ( i = 0; i < DISP_COLS; i++ ) {
		half0 = ( windowStart + i ) * 2;
		s  = ( ( windowStart + i ) < completedFull && half0 < completedHalves )
		     ? va( "%i", cgs.atdRoundScoresRed[half0] ) : "-";
		cx = COL0_LEFT + (float)i * COL_PITCH
		     + ( COL_PITCH - (float)CG_Text_Width( s, SCALE_NUM, 0 ) ) * 0.5f;
		CG_Text_Paint( cx, baseY, SCALE_NUM, cRed, s, 0, 0, ITEM_TEXTSTYLE_SHADOWED );
	}

	/* --- blue row (y=85, h=20) --- */
	baseY = PANEL_Y + 85.0f + ( 20.0f + textH ) * 0.5f;
	s = cgs.blueTeam[0] ? cgs.blueTeam : DEFAULT_BLUETEAM_NAME;
	CG_Text_Paint( LABEL_X, baseY, SCALE_LBL, cBlu, s, 0, 0, ITEM_TEXTSTYLE_SHADOWED );
	for ( i = 0; i < DISP_COLS; i++ ) {
		half0 = ( windowStart + i ) * 2;
		half1 = half0 + 1;
		s  = ( ( windowStart + i ) < completedFull && half1 < completedHalves )
		     ? va( "%i", cgs.atdRoundScoresBlue[half1] ) : "-";
		cx = COL0_LEFT + (float)i * COL_PITCH
		     + ( COL_PITCH - (float)CG_Text_Width( s, SCALE_NUM, 0 ) ) * 0.5f;
		CG_Text_Paint( cx, baseY, SCALE_NUM, cBlu, s, 0, 0, ITEM_TEXTSTYLE_SHADOWED );
	}
}
#endif /* MISSIONPACK */
