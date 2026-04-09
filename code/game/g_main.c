// Copyright (C) 1999-2000 Id Software, Inc.
//

#include "g_local.h"

level_locals_t	level;

typedef struct {
	vmCvar_t	*vmCvar;
	const char	*cvarName;
	const char	*defaultString;
	int			cvarFlags;
	int			modificationCount;	// for tracking changes
	qboolean	trackChange;		// track this variable, and announce if changed
	qboolean	teamShader;			// track and if changed, update shader state
} cvarTable_t;

gentity_t		g_entities[MAX_GENTITIES];
gclient_t		g_clients[MAX_CLIENTS];

void G_ItemReplaced( gentity_t *ent );
void G_RegisterWeapon( void );
void G_SpawnWeapon( gclient_t *client );
qboolean G_RemoveAmmo( gitem_t *item );
qboolean G_RemoveItem( gitem_t *item );
qboolean G_RemovePowerup( gitem_t *item );
qboolean G_RemoveWeapon( gitem_t *item );
void G_SetInfiniteAmmo ( gclient_t *client );
void Hook_Fire( gentity_t *ent );

#define DECLARE_G_CVAR
	#include "g_cvar.h"
#undef DECLARE_G_CVAR

static cvarTable_t gameCvarTable[] = {
	// noset vars
	{ NULL, "gamename", GAMEVERSION , CVAR_SERVERINFO | CVAR_ROM, 0, qfalse  },
	{ NULL, "gamedate", __DATE__ , CVAR_ROM, 0, qfalse  },

#define G_CVAR_LIST
	#include "g_cvar.h"
#undef G_CVAR_LIST

};


static void G_InitGame( int levelTime, int randomSeed, int restart );
static void G_RunFrame( int levelTime );
static void G_ShutdownGame( int restart );
static void CheckExitRules( void );
static void SendScoreboardMessageToAllClients( void );

// extension interface
#ifdef Q3_VM
qboolean (*trap_GetValue)( char *value, int valueSize, const char *key );
#else
int dll_com_trapGetValue;
#endif

int	svf_self_portal2;

/*
================
vmMain

This is the only way control passes into the module.
This must be the very first function compiled into the .q3vm file
================
*/
DLLEXPORT intptr_t vmMain( int command, int arg0, int arg1, int arg2 ) {
	switch ( command ) {
	case GAME_INIT:
		G_InitGame( arg0, arg1, arg2 );
		return 0;
	case GAME_SHUTDOWN:
		G_ShutdownGame( arg0 );
		return 0;
	case GAME_CLIENT_CONNECT:
		return (intptr_t)ClientConnect( arg0, arg1, arg2 );
	case GAME_CLIENT_THINK:
		ClientThink( arg0 );
		return 0;
	case GAME_CLIENT_USERINFO_CHANGED:
		ClientUserinfoChanged( arg0 );
		return 0;
	case GAME_CLIENT_DISCONNECT:
		ClientDisconnect( arg0 );
		return 0;
	case GAME_CLIENT_BEGIN:
		ClientBegin( arg0 );
		return 0;
	case GAME_CLIENT_COMMAND:
		ClientCommand( arg0 );
		return 0;
	case GAME_RUN_FRAME:
		G_RunFrame( arg0 );
		return 0;
	case GAME_CONSOLE_COMMAND:
		return ConsoleCommand();
	case BOTAI_START_FRAME:
		return BotAIStartFrame( arg0 );
	}

	return -1;
}


void QDECL G_Printf( const char *fmt, ... ) {
	va_list		argptr;
	char		text[BIG_INFO_STRING];
	int			len;

	va_start( argptr, fmt );
	len = ED_vsprintf( text, fmt, argptr );
	va_end( argptr );

	text[4095] = '\0'; // truncate to 1.32b/c max print buffer size

	trap_Print( text );
}


void G_BroadcastServerCommand( int ignoreClient, const char *command ) {
	int i;
	for ( i = 0; i < level.maxclients; i++ ) {
		if ( i == ignoreClient )
			continue;
		if ( level.clients[ i ].pers.connected == CON_CONNECTED ) {
			trap_SendServerCommand( i, command );
		}
	}
}


void QDECL G_Error( const char *fmt, ... ) {
	va_list		argptr;
	char		text[1024];

	va_start( argptr, fmt );
	ED_vsprintf( text, fmt, argptr );
	va_end( argptr );

	trap_Error( text );
}


/*
================
G_FindTeams

Chain together all entities with a matching team field.
Entity teams are used for item groups and multi-entity mover groups.

All but the first will have the FL_TEAMSLAVE flag set and teammaster field set
All but the last will have the teamchain field set to the next one
================
*/
void G_FindTeams( void ) {
	gentity_t	*e, *e2;
	int		i, j;
	int		c, c2;

	c = 0;
	c2 = 0;
	for ( i=MAX_CLIENTS, e=g_entities+i ; i < level.num_entities ; i++,e++ ){
		if (!e->inuse)
			continue;
		if (!e->team)
			continue;
		if (e->flags & FL_TEAMSLAVE)
			continue;
		e->teammaster = e;
		c++;
		c2++;
		for (j=i+1, e2=e+1 ; j < level.num_entities ; j++,e2++)
		{
			if (!e2->inuse)
				continue;
			if (!e2->team)
				continue;
			if (e2->flags & FL_TEAMSLAVE)
				continue;
			if (!strcmp(e->team, e2->team))
			{
				c2++;
				e2->teamchain = e->teamchain;
				e->teamchain = e2;
				e2->teammaster = e;
				e2->flags |= FL_TEAMSLAVE;

				// make sure that targets only point at the master
				if ( e2->targetname ) {
					e->targetname = e2->targetname;
					e2->targetname = NULL;
				}
			}
		}
	}

	G_Printf ("%i teams with %i entities\n", c, c2);
}


void G_RemapTeamShaders( void ) {
#ifdef MISSIONPACK
	char string[1024];
	float f = level.time * 0.001;

    if( g_redteam.string[0] != '\0' ) {
        Com_sprintf( string, sizeof(string), "team_icon/%s_red", g_redteam.string );
        AddRemap("textures/ctf2/redteam01", string, f);
        AddRemap("textures/ctf2/redteam02", string, f);
        AddRemap("textures/ctf2/redteam03", string, f);
    } else {
        AddRemap("textures/ctf2/redteam01", "textures/ctf2/redteam01", f);
        AddRemap("textures/ctf2/redteam02", "textures/ctf2/redteam02", f);
        AddRemap("textures/ctf2/redteam03", "textures/ctf2/redteam03", f);
    }

    if( g_blueteam.string[0] != '\0' ) {
        Com_sprintf( string, sizeof(string), "team_icon/%s_blue", g_blueteam.string );
        AddRemap("textures/ctf2/blueteam01", string, f);
        AddRemap("textures/ctf2/blueteam02", string, f);
        AddRemap("textures/ctf2/blueteam03", string, f);
    } else {
        AddRemap("textures/ctf2/blueteam01", "textures/ctf2/blueteam01", f);
        AddRemap("textures/ctf2/blueteam02", "textures/ctf2/blueteam02", f);
        AddRemap("textures/ctf2/blueteam03", "textures/ctf2/blueteam03", f);
    }

    trap_SetConfigstring(CS_SHADERSTATE, BuildShaderStateConfig());
#endif
}


/*
=================
G_RegisterCvars
=================
*/
void G_RegisterCvars( void ) {
	qboolean remapped = qfalse;
	cvarTable_t *cv;
	int i;

	for ( i = 0, cv = gameCvarTable ; i < ARRAY_LEN( gameCvarTable ) ; i++, cv++ ) {
		trap_Cvar_Register( cv->vmCvar, cv->cvarName,
			cv->defaultString, cv->cvarFlags );
		if ( cv->vmCvar )
			cv->modificationCount = cv->vmCvar->modificationCount;

		if (cv->teamShader) {
			remapped = qtrue;
		}
	}

	if (remapped) {
		G_RemapTeamShaders();
	}

	// check some things
	if ( g_gametype.integer < 0 || g_gametype.integer >= GT_MAX_GAME_TYPE ) {
		G_Printf( "g_gametype %i is out of range, defaulting to 0\n", g_gametype.integer );
		trap_Cvar_Set( "g_gametype", "0" );
		trap_Cvar_Update( &g_gametype );
	}

	level.warmupModificationCount = g_warmup.modificationCount;

	// force g_doWarmup to 1
	trap_Cvar_Register( NULL, "g_doWarmup", "1", CVAR_ROM );
	trap_Cvar_Set( "g_doWarmup", "1" );
}

/*
=================
G_RegisterWeapon
=================
*/
void G_RegisterWeapon(void) {

	if ( g_wpflags.integer & 2 ) {
		// the machinegun might already be registered
		gitem_t *item;
		item = BG_FindItemForWeapon( WP_SHOTGUN );
		if ( !Registered( item ) ) RegisterItem( item );
	}
	if ( g_wpflags.integer & 4 )
		RegisterItem( BG_FindItemForWeapon( WP_GRENADE_LAUNCHER ) );
	if ( g_wpflags.integer & 8 )
		RegisterItem( BG_FindItemForWeapon( WP_ROCKET_LAUNCHER ) );
	if ( g_wpflags.integer & 16 )
		RegisterItem( BG_FindItemForWeapon( WP_LIGHTNING ) );
	if ( g_wpflags.integer & 32 )
		RegisterItem( BG_FindItemForWeapon( WP_RAILGUN ) );
	if ( g_wpflags.integer & 64 )
		RegisterItem( BG_FindItemForWeapon( WP_PLASMAGUN ) );
	if ( g_wpflags.integer & 128 )
		RegisterItem( BG_FindItemForWeapon( WP_BFG ) );
#ifdef MISSIONPACK
	if ( g_wpflags.integer & 256 )
		RegisterItem( BG_FindItemForWeapon( WP_NAILGUN ) );
	if ( g_wpflags.integer & 512 )
		RegisterItem( BG_FindItemForWeapon( WP_PROX_LAUNCHER ) );
	if ( g_wpflags.integer & 1024 )
		RegisterItem( BG_FindItemForWeapon( WP_CHAINGUN ) );
#endif
	if ( g_grapple.integer > 0 )
		RegisterItem( BG_FindItemForWeapon( WP_GRAPPLING_HOOK ) );
}

static int getAmmoValue( const char *ammocvar ) {
	int ammo = 0;
	ammo = trap_Cvar_VariableIntegerValue(ammocvar);
	if (ammo < 0)
		return 0;
	if (ammo > 999)
		return 200;
	return ammo;
}

/*
=================
G_SpawnWeapon
=================
*/
void G_SpawnWeapon ( gclient_t *client ) {
	client->ps.ammo[ WP_MACHINEGUN ] = getAmmoValue ( "g_startAmmoMG" );

	if( g_instagib.integer ) {
		g_wpflags.integer = 32;
	}

	else {
		if ( g_removeweapon.integer & 1 && !( g_wpflags.integer & 1 ) ) {
			client->ps.stats[ STAT_WEAPONS ] &= ~( 1 << WP_MACHINEGUN );
			client->ps.ammo[ WP_MACHINEGUN ] = 0;
		}
		if ( g_wpflags.integer & 2 ) {
			client->ps.stats[ STAT_WEAPONS ] |= 1 << WP_SHOTGUN;
			client->ps.ammo[ WP_SHOTGUN ] = getAmmoValue ( "g_startAmmoSG" );
		}
		if ( g_wpflags.integer & 4 ) {
			client->ps.stats[ STAT_WEAPONS ] |= 1 << WP_GRENADE_LAUNCHER;
			client->ps.ammo[ WP_GRENADE_LAUNCHER ] = getAmmoValue ( "g_startAmmoGL" );
		}
		if ( g_wpflags.integer & 8 ) {
			client->ps.stats[ STAT_WEAPONS ] |= 1 << WP_ROCKET_LAUNCHER;
			client->ps.ammo[ WP_ROCKET_LAUNCHER ] = getAmmoValue ( "g_startAmmoRL" );
		}
		if ( g_wpflags.integer & 16 ) {
			client->ps.stats[ STAT_WEAPONS ] |= 1 << WP_LIGHTNING;
			client->ps.ammo[ WP_LIGHTNING ] = getAmmoValue ( "g_startAmmoLG" );
		}
		if ( g_wpflags.integer & 32 ) {
			client->ps.stats[ STAT_WEAPONS ] |= 1 << WP_RAILGUN;
			client->ps.ammo[ WP_RAILGUN ] = getAmmoValue ( "g_startAmmoRG" );
		}
		if ( g_wpflags.integer & 64 ) {
			client->ps.stats[ STAT_WEAPONS ] |= 1 << WP_PLASMAGUN;
			client->ps.ammo[ WP_PLASMAGUN ] = getAmmoValue ( "g_startAmmoPG" );
		}
		if ( g_wpflags.integer & 128 ) {
			client->ps.stats[ STAT_WEAPONS ] |= 1 << WP_BFG;
			client->ps.ammo[ WP_BFG ] = getAmmoValue ( "g_startAmmoBFG" );
		}
#ifdef MISSIONPACK
		if ( g_wpflags.integer & 256 ) {
			client->ps.stats[ STAT_WEAPONS ] |= 1 << WP_NAILGUN;
			client->ps.ammo[ WP_NAILGUN ] = getAmmoValue ( "g_startAmmoNG" );
		}
		if ( g_wpflags.integer & 512 ) {
			client->ps.stats[ STAT_WEAPONS ] |= 1 << WP_PROX_LAUNCHER;
			client->ps.ammo[ WP_PROX_LAUNCHER ] = getAmmoValue ( "g_startAmmoPL" );
		}
		if ( g_wpflags.integer & 1024 ) {
			client->ps.stats[ STAT_WEAPONS ] |= 1 << WP_CHAINGUN;
			client->ps.ammo[ WP_CHAINGUN ] = getAmmoValue ( "g_startAmmoCG" );
		}
#endif
	}
}

/*
=================
G_RemoveWeapon
=================
*/
qboolean G_RemoveWeapon ( gitem_t *item ) {
	if ( ( ( g_removeweapon.integer & 1 ) && ( !Q_stricmp( item->classname, "weapon_machinegun" ) ) )
		|| ( ( g_removeweapon.integer & 2 ) && ( !Q_stricmp( item->classname, "weapon_shotgun" ) ) )
		|| ( ( g_removeweapon.integer & 4 ) && ( !Q_stricmp( item->classname, "weapon_grenadelauncher" ) ) )
		|| ( ( g_removeweapon.integer & 8 ) && ( !Q_stricmp( item->classname, "weapon_rocketlauncher" ) ) )
		|| ( ( g_removeweapon.integer & 16 ) && ( !Q_stricmp( item->classname, "weapon_lightning" ) ) )
		|| ( ( g_removeweapon.integer & 32 ) && ( !Q_stricmp( item->classname, "weapon_railgun" ) ) )
		|| ( ( g_removeweapon.integer & 64 ) && ( !Q_stricmp( item->classname, "weapon_plasmagun" ) ) )
		|| ( ( g_removeweapon.integer & 128 ) && ( !Q_stricmp( item->classname, "weapon_bfg" ) ) ) )
			return qtrue;
#ifdef MISSIONPACK
	if ( ( ( g_removeweapon.integer & 256 ) && ( !Q_stricmp( item->classname, "weapon_nailgun" ) ) )
		|| ( ( g_removeweapon.integer & 512 ) && ( !Q_stricmp( item->classname, "weapon_prox_launcher" ) ) )
		|| ( ( g_removeweapon.integer & 1024 ) && ( !Q_stricmp( item->classname, "weapon_chaingun" ) ) ) )
			return qtrue;
#endif
	return qfalse;
}

/*
=================
G_RemoveAmmo
=================
*/
qboolean G_RemoveAmmo ( gitem_t *item ) {
	if ( ( ( g_removeammo.integer & 1 ) && ( !Q_stricmp( item->classname, "ammo_bullets" ) ) )
		|| ( ( g_removeammo.integer & 2 ) && ( !Q_stricmp( item->classname, "ammo_shells" ) ) )
		|| ( ( g_removeammo.integer & 4 ) && ( !Q_stricmp( item->classname, "ammo_grenades" ) ) )
		|| ( ( g_removeammo.integer & 8 ) && ( !Q_stricmp( item->classname, "ammo_rockets" ) ) )
		|| ( ( g_removeammo.integer & 16 ) && ( !Q_stricmp( item->classname, "ammo_lightning" ) ) )
		|| ( ( g_removeammo.integer & 32 ) && ( !Q_stricmp( item->classname, "ammo_slugs" ) ) )
		|| ( ( g_removeammo.integer & 64 ) && ( !Q_stricmp( item->classname, "ammo_cells" ) ) )
		|| ( ( g_removeammo.integer & 128 ) && ( !Q_stricmp( item->classname, "ammo_bfg" ) ) ) )
			return qtrue;
#ifdef MISSIONPACK
	if ( ( ( g_removeammo.integer & 256 ) && ( !Q_stricmp( item->classname, "ammo_nails" ) ) )
		|| ( ( g_removeammo.integer & 512 ) && ( !Q_stricmp( item->classname, "ammo_mines" ) ) )
		|| ( ( g_removeammo.integer & 1024 ) && ( !Q_stricmp( item->classname, "ammo_belt" ) ) ) )
			return qtrue;
#endif
	return qfalse;
}

/*
=================
G_RemoveItem
=================
*/
qboolean G_RemoveItem ( gitem_t *item ) {
	if ( ( ( g_removeitem.integer & 1 ) && ( !Q_stricmp( item->classname, "item_armor_shard" ) ) )
		|| ( ( g_removeitem.integer & 2 ) && ( !Q_stricmp( item->classname, "item_armor_combat" ) ) )
		|| ( ( g_removeitem.integer & 4 ) && ( !Q_stricmp( item->classname, "item_armor_body" ) ) )
		|| ( ( g_removeitem.integer & 8 ) && ( !Q_stricmp( item->classname, "item_health_small" ) ) )
		|| ( ( g_removeitem.integer & 16 ) && ( !Q_stricmp( item->classname, "item_health" ) ) )
		|| ( ( g_removeitem.integer & 32 ) && ( !Q_stricmp( item->classname, "item_health_large" ) ) )
		|| ( ( g_removeitem.integer & 64 ) && ( !Q_stricmp( item->classname, "item_health_mega" ) ) )
		|| ( ( g_removeitem.integer & 128 ) && ( !Q_stricmp( item->classname, "holdable_teleporter" ) ) )
		|| ( ( g_removeitem.integer & 256 ) && ( !Q_stricmp( item->classname, "holdable_medkit" ) ) ) )
			return qtrue;
#ifdef MISSIONPACK
	if ( ( ( g_removeitem.integer & 512 ) && ( !Q_stricmp( item->classname, "holdable_kamikaze" ) ) )
		|| ( ( g_removeitem.integer & 1024 ) && ( !Q_stricmp( item->classname, "holdable_portal" ) ) )
		|| ( ( g_removeitem.integer & 2048 ) && ( !Q_stricmp( item->classname, "holdable_invulnerability" ) ) ) )
			return qtrue;
#endif
	return qfalse;
}

/*
=================
G_RemovePowerup
=================
*/
qboolean G_RemovePowerup ( gitem_t *item ) {
	if ( ( ( g_removepowerup.integer & 1 ) && ( !Q_stricmp( item->classname, "item_quad" ) ) )
		|| ( ( g_removepowerup.integer & 2 ) && ( !Q_stricmp( item->classname, "item_enviro" ) ) )
		|| ( ( g_removepowerup.integer & 4 ) && ( !Q_stricmp( item->classname, "item_haste" ) ) )
		|| ( ( g_removepowerup.integer & 8 ) && ( !Q_stricmp( item->classname, "item_invis" ) ) )
		|| ( ( g_removepowerup.integer & 16 ) && ( !Q_stricmp( item->classname, "item_regen" ) ) )
		|| ( ( g_removepowerup.integer & 32 ) && ( !Q_stricmp( item->classname, "item_flight" ) ) ) )
			return qtrue;
#ifdef MISSIONPACK
	if ( ( ( g_removepowerup.integer & 64 ) && ( !Q_stricmp( item->classname, "item_scout" ) ) )
		|| ( ( g_removepowerup.integer & 128 ) && ( !Q_stricmp( item->classname, "item_guard" ) ) )
		|| ( ( g_removepowerup.integer & 256 ) && ( !Q_stricmp( item->classname, "item_doubler" ) ) )
		|| ( ( g_removepowerup.integer & 512 ) && ( !Q_stricmp( item->classname, "item_ammoregen" ) ) ) )
			return qtrue;
#endif
	return qfalse;
}

/*
=================
G_SetInfiniteAmmo
=================
*/
void G_SetInfiniteAmmo ( gclient_t *client ) {
	int     i;
	for ( i = 0; i < MAX_WEAPONS; i++ ) {
		client->ps.ammo[ i ] = 999;
	}
}

/*
=================
G_UpdateCvars
=================
*/
static void G_UpdateCvars( void ) {
	int			i;
	cvarTable_t	*cv;
	qboolean remapped = qfalse;

	for ( i = 0, cv = gameCvarTable ; i < ARRAY_LEN( gameCvarTable ) ; i++, cv++ ) {
		if ( cv->vmCvar ) {
			trap_Cvar_Update( cv->vmCvar );

			if ( cv->modificationCount != cv->vmCvar->modificationCount ) {
				cv->modificationCount = cv->vmCvar->modificationCount;

				if ( cv->trackChange ) {
					G_BroadcastServerCommand( -1, va("print \"Server: %s changed to %s\n\"",
						cv->cvarName, cv->vmCvar->string ) );
				}

				if ( cv->vmCvar == &g_runes ) {
					Com_Printf( "%s will be changed upon restarting.\n", cv->cvarName );
				}

				if (cv->teamShader) {
					remapped = qtrue;
				}
			}
		}
	}

	if (remapped) {
		G_RemapTeamShaders();
	}
}


static void G_LocateSpawnSpots( void )
{
	gentity_t			*ent;
	int i, n;

	level.spawnSpots[ SPAWN_SPOT_INTERMISSION ] = NULL;

	// locate all spawn spots
	n = 0;
	ent = g_entities + MAX_CLIENTS;
	for ( i = MAX_CLIENTS; i < MAX_GENTITIES; i++, ent++ ) {

		if ( !ent->inuse || !ent->classname )
			continue;

		// intermission/ffa spots
		if ( !Q_stricmpn( ent->classname, "info_player_", 12 ) ) {
			if ( !Q_stricmp( ent->classname+12, "intermission" ) ) {
				if ( level.spawnSpots[ SPAWN_SPOT_INTERMISSION ] == NULL ) {
					level.spawnSpots[ SPAWN_SPOT_INTERMISSION ] = ent; // put in the last slot
					ent->fteam = TEAM_FREE;
				}
				continue;
			}
			if ( !Q_stricmp( ent->classname+12, "deathmatch" ) ) {
				level.spawnSpots[n] = ent; n++;
				level.numSpawnSpotsFFA++;
				ent->fteam = TEAM_FREE;
				ent->count = 1;
				continue;
			}
			continue;
		}

		// team spawn spots
		if ( !Q_stricmpn( ent->classname, "team_CTF_", 9 ) ) {
			if ( !Q_stricmp( ent->classname+9, "redspawn" ) ) {
				level.spawnSpots[n] = ent; n++;
				level.numSpawnSpotsTeam++;
				ent->fteam = TEAM_RED;
				ent->count = 1; // means its not initial spawn point
				continue;
			}
			if ( !Q_stricmp( ent->classname+9, "bluespawn" ) ) {
				level.spawnSpots[n] = ent; n++;
				level.numSpawnSpotsTeam++;
				ent->fteam = TEAM_BLUE;
				ent->count = 1;
				continue;
			}
			// base spawn spots
			if ( !Q_stricmp( ent->classname+9, "redplayer" ) ) {
				level.spawnSpots[n] = ent; n++;
				level.numSpawnSpotsTeam++;
				ent->fteam = TEAM_RED;
				ent->count = 0;
				continue;
			}
			if ( !Q_stricmp( ent->classname+9, "blueplayer" ) ) {
				level.spawnSpots[n] = ent; n++;
				level.numSpawnSpotsTeam++;
				ent->fteam = TEAM_BLUE;
				ent->count = 0;
				continue;
			}
		}
	}
	level.numSpawnSpots = n;
}


/*
============
G_InitGame

============
*/
static void G_InitGame( int levelTime, int randomSeed, int restart ) {
	char value[ MAX_CVAR_VALUE_STRING ];
	int	i;

	G_Printf ("------- Game Initialization -------\n");
	G_Printf ("gamename: %s\n", GAMEVERSION);
	G_Printf ("gamedate: %s\n", __DATE__);

	// extension interface
	trap_Cvar_VariableStringBuffer( "//trap_GetValue", value, sizeof( value ) );
	if ( value[0] ) {
#ifdef Q3_VM
		trap_GetValue = (void*)~atoi( value );
#else
		dll_com_trapGetValue = atoi( value );
#endif
		if ( trap_GetValue( value, sizeof( value ), "SVF_SELF_PORTAL2_Q3E" ) ) {
			svf_self_portal2 = atoi( value );
		} else {
			svf_self_portal2 = 0;
		}
	}

	srand( randomSeed );

	G_RegisterCvars();
	G_PrintDelagMaxTimeshift();

	G_ProcessIPBans();

	G_InitMemory();

	// set some level globals
	memset( &level, 0, sizeof( level ) );
	level.time = levelTime;

	level.startTime = levelTime;

	level.previousTime = levelTime;
	level.msec = FRAMETIME;

	level.snd_fry = G_SoundIndex("sound/player/fry.wav");	// FIXME standing in lava / slime

	if ( g_gametype.integer != GT_SINGLE_PLAYER && g_log.string[0] ) {
		if ( g_logSync.integer ) {
			trap_FS_FOpenFile( g_log.string, &level.logFile, FS_APPEND_SYNC );
		} else {
			trap_FS_FOpenFile( g_log.string, &level.logFile, FS_APPEND );
		}
		if ( level.logFile == FS_INVALID_HANDLE ) {
			G_Printf( "WARNING: Couldn't open logfile: %s\n", g_log.string );
		} else {
			char	serverinfo[MAX_INFO_STRING];

			trap_GetServerinfo( serverinfo, sizeof( serverinfo ) );

			G_LogPrintf("------------------------------------------------------------\n" );
			G_LogPrintf("InitGame: %s\n", serverinfo );
		}
	} else {
		G_Printf( "Not logging to disk.\n" );
	}

	G_InitWorldSession();

	// initialize all entities for this game
	memset( g_entities, 0, MAX_GENTITIES * sizeof(g_entities[0]) );
	level.gentities = g_entities;

	// initialize all clients for this game
	level.maxclients = g_maxclients.integer;
	memset( g_clients, 0, MAX_CLIENTS * sizeof(g_clients[0]) );
	level.clients = g_clients;

	// set client fields on player ents
	for ( i=0 ; i<level.maxclients ; i++ ) {
		g_entities[i].client = level.clients + i;
	}

	// always leave room for the max number of clients,
	// even if they aren't all used, so numbers inside that
	// range are NEVER anything but clients
	level.num_entities = MAX_CLIENTS;

	for ( i = 0 ; i < MAX_CLIENTS ; i++ ) {
		g_entities[ i ].classname = "clientslot";
	}

	// let the server system know where the entites are
	trap_LocateGameData( level.gentities, level.num_entities, sizeof( gentity_t ),
		&level.clients[0].ps, sizeof( level.clients[0] ) );

	// reserve some spots for dead player bodies
	InitBodyQue();

	ClearRegisteredItems();

	// parse the key/value pairs and spawn gentities
	G_SpawnEntitiesFromString();

	// general initialization
	G_FindTeams();

	// Attack & Defend (GT_CTFS) round initialisation — must precede G_CheckTeamItems()
	// so Team_InitGame encodes the correct attacking team into CS_FLAGSTATUS.
#ifdef MISSIONPACK
	if ( g_gametype.integer == GT_CTFS ) {
		level.atdRoundNumber        = 1;
		level.atdRoundNumberStarted = 0;
		level.atdRoundStartTime     = level.time + g_warmup.integer * 1000;
		level.atdRoundRespawned     = qfalse;
		level.atdEliminationSides   = 1; // BLUE always defends round 1, RED always attacks
		level.atdRoundRedPlayers    = 0;
		level.atdRoundBluePlayers   = 0;
		level.atdRoundStartRed      = 0;
		level.atdRoundStartBlue     = 0;
		Com_Memset( level.atdRoundScoresRed,  0, sizeof( level.atdRoundScoresRed  ) );
		Com_Memset( level.atdRoundScoresBlue, 0, sizeof( level.atdRoundScoresBlue ) );
		/* Clear the round score configstring so clients start fresh. */
		trap_SetConfigstring( CS_ATD_ROUNDSCORES, "" );
		trap_SetConfigstring( CS_ATD_ROUNDSTART, "0" );
		/* CS_WARMUP will be set after the initial match warmup ends (G_ATDEndRound). */
	}
#endif

	// make sure we have flags for CTF, etc
	if( g_gametype.integer >= GT_TEAM ) {
		G_CheckTeamItems();
	}

	SaveRegisteredItems();

	G_LocateSpawnSpots();

	G_Printf ("-----------------------------------\n");

	if( g_gametype.integer == GT_SINGLE_PLAYER || trap_Cvar_VariableIntegerValue( "com_buildScript" ) ) {
		G_ModelIndex( SP_PODIUM_MODEL );
	}

	if ( trap_Cvar_VariableIntegerValue( "bot_enable" ) ) {
		BotAISetup( restart );
		BotAILoadMap( restart );
		G_InitBots( restart );
	}

	G_RemapTeamShaders();

	// don't forget to reset times
	trap_SetConfigstring( CS_INTERMISSION, "" );

	if ( g_gametype.integer != GT_SINGLE_PLAYER ) {
		// launch rotation system on first map load
		if ( trap_Cvar_VariableIntegerValue( SV_ROTATION ) == 0 ) {
			trap_Cvar_Set( SV_ROTATION, "1" );
			level.denyMapRestart = qtrue;
			ParseMapRotation();
		}
	}
}


/*
=================
G_ShutdownGame
=================
*/
static void G_ShutdownGame( int restart )
{
	G_Printf ("==== ShutdownGame ====\n");

	if ( level.logFile != FS_INVALID_HANDLE ) {
		G_LogPrintf("ShutdownGame:\n" );
		G_LogPrintf("------------------------------------------------------------\n" );
		trap_FS_FCloseFile( level.logFile );
		level.logFile = FS_INVALID_HANDLE;
	}

	// write all the client session data so we can get it back
	G_WriteSessionData();

	if ( trap_Cvar_VariableIntegerValue( "bot_enable" ) ) {
		BotAIShutdown( restart );
	}
}



//===================================================================

#ifndef GAME_HARD_LINKED
// this is only here so the functions in q_shared.c and bg_*.c can link

void QDECL Com_Error( int level, const char *fmt, ... ) {
	va_list		argptr;
	char		text[4096];

	va_start( argptr, fmt );
	ED_vsprintf( text, fmt, argptr );
	va_end( argptr );

	trap_Error( text );
}


void QDECL Com_Printf( const char *fmt, ... ) {
	va_list		argptr;
	char		text[4096];

	va_start( argptr, fmt );
	ED_vsprintf( text, fmt, argptr );
	va_end( argptr );

	trap_Print( text );
}

#endif

/*
========================================================================

PLAYER COUNTING / SCORE SORTING

========================================================================
*/

/*
=============
AddTournamentPlayer

If there are less than two tournament players, put a
spectator in the game and restart
=============
*/
void AddTournamentPlayer( void ) {
	int			i;
	gclient_t	*client;
	gclient_t	*nextInLine;

	if ( level.numPlayingClients >= 2 ) {
		return;
	}

	// never change during intermission
	if ( level.intermissiontime ) {
		return;
	}

	nextInLine = NULL;

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		client = &level.clients[i];
		if ( client->pers.connected != CON_CONNECTED ) {
			continue;
		}
		if ( client->sess.sessionTeam != TEAM_SPECTATOR ) {
			continue;
		}
		// never select the dedicated follow or scoreboard clients
		if ( client->sess.spectatorState == SPECTATOR_SCOREBOARD ||
			client->sess.spectatorClient < 0  ) {
			continue;
		}

		if ( !nextInLine || client->sess.spectatorTime > nextInLine->sess.spectatorTime ) {
			nextInLine = client;
		}
	}

	if ( !nextInLine ) {
		return;
	}

	level.warmupTime = -1;

	// set them to free-for-all team
	SetTeam( &g_entities[ nextInLine - level.clients ], "f" );
}


/*
=======================
RemoveTournamentLoser

Make the loser a spectator at the back of the line
=======================
*/
void RemoveTournamentLoser( void ) {
	int			clientNum;

	if ( level.numPlayingClients != 2 ) {
		return;
	}

	clientNum = level.sortedClients[1];

	if ( level.clients[ clientNum ].pers.connected != CON_CONNECTED ) {
		return;
	}

	// make them a spectator
	SetTeam( &g_entities[ clientNum ], "s" );
}


/*
=======================
RemoveTournamentWinner
=======================
*/
void RemoveTournamentWinner( void ) {
	int			clientNum;

	if ( level.numPlayingClients != 2 ) {
		return;
	}

	clientNum = level.sortedClients[0];

	if ( level.clients[ clientNum ].pers.connected != CON_CONNECTED ) {
		return;
	}

	// make them a spectator
	SetTeam( &g_entities[ clientNum ], "s" );
}


/*
=======================
AdjustTournamentScores
=======================
*/
void AdjustTournamentScores( void ) {
	int			clientNum;

	clientNum = level.sortedClients[0];
	if ( level.clients[ clientNum ].pers.connected == CON_CONNECTED ) {
		level.clients[ clientNum ].sess.wins++;
		ClientUserinfoChanged( clientNum );
	}

	clientNum = level.sortedClients[1];
	if ( level.clients[ clientNum ].pers.connected == CON_CONNECTED ) {
		level.clients[ clientNum ].sess.losses++;
		ClientUserinfoChanged( clientNum );
	}

}


/*
=============
SortRanks
=============
*/
static int QDECL SortRanks( const void *a, const void *b ) {
	gclient_t	*ca, *cb;

	ca = &level.clients[*(int *)a];
	cb = &level.clients[*(int *)b];

	// sort special clients last
	if ( ca->sess.spectatorState == SPECTATOR_SCOREBOARD || ca->sess.spectatorClient < 0 ) {
		return 1;
	}
	if ( cb->sess.spectatorState == SPECTATOR_SCOREBOARD || cb->sess.spectatorClient < 0  ) {
		return -1;
	}

	// then connecting clients
	if ( ca->pers.connected == CON_CONNECTING ) {
		return 1;
	}
	if ( cb->pers.connected == CON_CONNECTING ) {
		return -1;
	}

	// then spectators
	if ( ca->sess.sessionTeam == TEAM_SPECTATOR && cb->sess.sessionTeam == TEAM_SPECTATOR ) {
		if ( ca->sess.spectatorTime > cb->sess.spectatorTime ) {
			return -1;
		}
		if ( ca->sess.spectatorTime < cb->sess.spectatorTime ) {
			return 1;
		}
		return 0;
	}
	if ( ca->sess.sessionTeam == TEAM_SPECTATOR ) {
		return 1;
	}
	if ( cb->sess.sessionTeam == TEAM_SPECTATOR ) {
		return -1;
	}

	// then sort by score
	if ( ca->ps.persistant[PERS_SCORE]
		> cb->ps.persistant[PERS_SCORE] ) {
		return -1;
	}
	if ( ca->ps.persistant[PERS_SCORE]
		< cb->ps.persistant[PERS_SCORE] ) {
		return 1;
	}
	return 0;
}


/*
============
CalculateRanks

Recalculates the score ranks of all players
This will be called on every client connect, begin, disconnect, death,
and team change.
============
*/
void CalculateRanks( void ) {
	int		i;
	int		rank;
	int		score;
	int		newScore;
	gclient_t	*cl;

	if ( level.restarted )
		return;

	level.follow1 = -1;
	level.follow2 = -1;
	level.numConnectedClients = 0;
	level.numNonSpectatorClients = 0;
	level.numPlayingClients = 0;
	level.numVotingClients = 0;		// don't count bots
	for (i = 0; i < ARRAY_LEN(level.numteamVotingClients); i++) {
		level.numteamVotingClients[i] = 0;
	}
	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if ( level.clients[i].pers.connected != CON_DISCONNECTED ) {
			level.sortedClients[level.numConnectedClients] = i;
			level.numConnectedClients++;

			if ( level.clients[i].sess.sessionTeam != TEAM_SPECTATOR ) {
				level.numNonSpectatorClients++;

				// decide if this should be auto-followed
				if ( level.clients[i].pers.connected == CON_CONNECTED ) {
					level.numPlayingClients++;
					if ( !(g_entities[i].r.svFlags & SVF_BOT) ) {
						level.numVotingClients++;
						if ( level.clients[i].sess.sessionTeam == TEAM_RED )
							level.numteamVotingClients[0]++;
						else if ( level.clients[i].sess.sessionTeam == TEAM_BLUE )
							level.numteamVotingClients[1]++;
					}
					if ( level.follow1 == -1 ) {
						level.follow1 = i;
					} else if ( level.follow2 == -1 ) {
						level.follow2 = i;
					}
				}
			}
		}
	}

	qsort( level.sortedClients, level.numConnectedClients,
		sizeof(level.sortedClients[0]), SortRanks );

	// set the rank value for all clients that are connected and not spectators
	if ( g_gametype.integer >= GT_TEAM ) {
		// in team games, rank is just the order of the teams, 0=red, 1=blue, 2=tied
		for ( i = 0;  i < level.numConnectedClients; i++ ) {
			cl = &level.clients[ level.sortedClients[i] ];
			if ( level.teamScores[TEAM_RED] == level.teamScores[TEAM_BLUE] ) {
				cl->ps.persistant[PERS_RANK] = 2;
			} else if ( level.teamScores[TEAM_RED] > level.teamScores[TEAM_BLUE] ) {
				cl->ps.persistant[PERS_RANK] = 0;
			} else {
				cl->ps.persistant[PERS_RANK] = 1;
			}
		}
	} else {
		rank = -1;
		score = MAX_QINT;
		for ( i = 0;  i < level.numPlayingClients; i++ ) {
			cl = &level.clients[ level.sortedClients[i] ];
			newScore = cl->ps.persistant[PERS_SCORE];
			if ( i == 0 || newScore != score ) {
				rank = i;
				// assume we aren't tied until the next client is checked
				level.clients[ level.sortedClients[i] ].ps.persistant[PERS_RANK] = rank;
			} else {
				// we are tied with the previous client
				level.clients[ level.sortedClients[i-1] ].ps.persistant[PERS_RANK] = rank | RANK_TIED_FLAG;
				level.clients[ level.sortedClients[i] ].ps.persistant[PERS_RANK] = rank | RANK_TIED_FLAG;
			}
			score = newScore;
			if ( g_gametype.integer == GT_SINGLE_PLAYER && level.numPlayingClients == 1 ) {
				level.clients[ level.sortedClients[i] ].ps.persistant[PERS_RANK] = rank | RANK_TIED_FLAG;
			}
		}
	}

	// set the CS_SCORES1/2 configstrings, which will be visible to everyone
	if ( g_gametype.integer >= GT_TEAM ) {
		trap_SetConfigstring( CS_SCORES1, va("%i", level.teamScores[TEAM_RED] ) );
		trap_SetConfigstring( CS_SCORES2, va("%i", level.teamScores[TEAM_BLUE] ) );
	} else {
		if ( level.numConnectedClients == 0 ) {
			trap_SetConfigstring( CS_SCORES1, va("%i", SCORE_NOT_PRESENT) );
			trap_SetConfigstring( CS_SCORES2, va("%i", SCORE_NOT_PRESENT) );
		} else if ( level.numConnectedClients == 1 ) {
			trap_SetConfigstring( CS_SCORES1, va("%i", level.clients[ level.sortedClients[0] ].ps.persistant[PERS_SCORE] ) );
			trap_SetConfigstring( CS_SCORES2, va("%i", SCORE_NOT_PRESENT) );
		} else {
			trap_SetConfigstring( CS_SCORES1, va("%i", level.clients[ level.sortedClients[0] ].ps.persistant[PERS_SCORE] ) );
			trap_SetConfigstring( CS_SCORES2, va("%i", level.clients[ level.sortedClients[1] ].ps.persistant[PERS_SCORE] ) );
		}
	}

	// see if it is time to end the level
	CheckExitRules();

	// if we are at the intermission, send the new info to everyone
	if ( level.intermissiontime ) {
		SendScoreboardMessageToAllClients();
	}
}


/*
========================================================================

MAP CHANGING

========================================================================
*/

/*
========================
SendScoreboardMessageToAllClients

Do this at BeginIntermission time and whenever ranks are recalculated
due to enters/exits/forced team changes
========================
*/
static void SendScoreboardMessageToAllClients( void ) {
	int		i;

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if ( level.clients[ i ].pers.connected == CON_CONNECTED ) {
			DeathmatchScoreboardMessage( g_entities + i );
		}
	}
}


/*
========================
MoveClientToIntermission

When the intermission starts, this will be called for all players.
If a new client connects, this will be called after the spawn function.
========================
*/
void MoveClientToIntermission( gentity_t *ent ) {

	gclient_t * client;

	client = ent->client;

	// take out of follow mode if needed
	if ( client->sess.spectatorState == SPECTATOR_FOLLOW ) {
		StopFollowing( ent, qtrue );
	}

	// move to the spot
	VectorCopy( level.intermission_origin, ent->s.origin );
	VectorCopy( level.intermission_origin, client->ps.origin );
	SetClientViewAngle( ent, level.intermission_angle );
	client->ps.pm_type = PM_INTERMISSION;

	// clean up powerup info
	memset( client->ps.powerups, 0, sizeof( client->ps.powerups ) );

	client->ps.eFlags = ( client->ps.eFlags & ~EF_PERSISTANT ) | ( client->ps.eFlags & EF_PERSISTANT );

	ent->s.eFlags = client->ps.eFlags;
	ent->s.eType = ET_GENERAL;
	ent->s.modelindex = 0;
	ent->s.loopSound = 0;
	ent->s.event = 0;
	ent->r.contents = 0;

	ent->s.legsAnim = LEGS_IDLE;
	ent->s.torsoAnim = TORSO_STAND;
}


/*
==================
FindIntermissionPoint

This is also used for spectator spawns
==================
*/
void FindIntermissionPoint( void ) {
	gentity_t	*ent, *target;
	vec3_t		dir;

	if ( level.intermission_spot ) // search only once
		return;

	// find the intermission spot
	ent = level.spawnSpots[ SPAWN_SPOT_INTERMISSION ];

	if ( !ent ) { // the map creator forgot to put in an intermission point...
		SelectSpawnPoint( NULL, vec3_origin, level.intermission_origin, level.intermission_angle );
	} else {
		VectorCopy (ent->s.origin, level.intermission_origin);
		VectorCopy (ent->s.angles, level.intermission_angle);
		// if it has a target, look towards it
		if ( ent->target ) {
			target = G_PickTarget( ent->target );
			if ( target ) {
				VectorSubtract( target->s.origin, level.intermission_origin, dir );
				vectoangles( dir, level.intermission_angle );
			}
		}
	}

	level.intermission_spot = qtrue;
}


/*
==================
BeginIntermission
==================
*/
void BeginIntermission( void ) {
	int			i;
	gentity_t	*client;

	if ( level.intermissiontime ) {
		return;	// already active
	}

	// if in tournement mode, change the wins / losses
	if ( g_gametype.integer == GT_TOURNAMENT ) {
		AdjustTournamentScores();
	}

	level.intermissiontime = level.time;
	FindIntermissionPoint();

	// move all clients to the intermission point
	for ( i = 0 ; i < level.maxclients ; i++ ) {
		client = g_entities + i;
		if ( !client->inuse )
			continue;

		// respawn if dead
		if ( client->health <= 0 ) {
			respawn( client );
		}

		MoveClientToIntermission( client );
	}

#ifdef MISSIONPACK
	if (g_singlePlayer.integer) {
		trap_Cvar_Set("ui_singlePlayerActive", "0");
		UpdateTournamentInfo();
	}
#else
	// if single player game
	if ( g_gametype.integer == GT_SINGLE_PLAYER ) {
		UpdateTournamentInfo();
		SpawnModelsOnVictoryPads();
	}
#endif

	// send the current scoring to all clients
	SendScoreboardMessageToAllClients();
}


/*
=============
ExitLevel

When the intermission has been exited, the server is either killed
or moved to a new level based on the "nextmap" cvar
=============
*/
void ExitLevel( void ) {
	int		i;
	gclient_t *cl;

	//bot interbreeding
	BotInterbreedEndMatch();

	// if we are running a tournement map, kick the loser to spectator status,
	// which will automatically grab the next spectator and restart
	if ( g_gametype.integer == GT_TOURNAMENT  ) {
		if ( !level.restarted ) {
			RemoveTournamentLoser();
			trap_SendConsoleCommand( EXEC_APPEND, "map_restart 0\n" );
			level.restarted = qtrue;
			level.intermissiontime = 0;
		}
		return;
	}

	level.intermissiontime = 0;

	// reset all the scores so we don't enter the intermission again
	level.teamScores[TEAM_RED] = 0;
	level.teamScores[TEAM_BLUE] = 0;
	for ( i = 0 ; i < level.maxclients ; i++ ) {
		cl = level.clients + i;
		if ( cl->pers.connected != CON_CONNECTED ) {
			continue;
		}
		cl->ps.persistant[PERS_SCORE] = 0;
	}

	// we need to do this here before changing to CON_CONNECTING
	G_WriteSessionData();

	// change all client states to connecting, so the early players into the
	// next level will know the others aren't done reconnecting
	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if ( level.clients[i].pers.connected == CON_CONNECTED ) {
			level.clients[i].pers.connected = CON_CONNECTING;
		}
	}

	if ( !ParseMapRotation() ) {
		char val[ MAX_CVAR_VALUE_STRING ];

		trap_Cvar_VariableStringBuffer( "nextmap", val, sizeof( val ) );

		if ( !val[0] || !Q_stricmpn( val, "map_restart ", 12 ) )
			G_LoadMap( NULL );
		else
			trap_SendConsoleCommand( EXEC_APPEND, "vstr nextmap\n" );
	}
}


/*
=================
G_LogPrintf

Print to the logfile with a time stamp if it is open
=================
*/
void QDECL G_LogPrintf( const char *fmt, ... ) {
	va_list		argptr;
	char		string[BIG_INFO_STRING];
	int			min, tsec, sec, len, n;

	tsec = level.time / 100;
	sec = tsec / 10;
	tsec %= 10;
	min = sec / 60;
	sec -= min * 60;

	len = Com_sprintf( string, sizeof( string ), "%3i:%02i.%i ", min, sec, tsec );

	va_start( argptr, fmt );
	ED_vsprintf( string + len, fmt,argptr );
	va_end( argptr );

	n = (int)strlen( string );

	if ( g_dedicated.integer ) {
		G_Printf( "%s", string + len );
	}

	if ( level.logFile == FS_INVALID_HANDLE ) {
		return;
	}

	trap_FS_Write( string, n, level.logFile );
}


/*
================
LogExit

Append information about this game to the log file
================
*/
void LogExit( const char *string ) {
	int				i, numSorted;
	gclient_t		*cl;
#ifdef MISSIONPACK
	qboolean won = qtrue;
#endif
	G_LogPrintf( "Exit: %s\n", string );

	level.intermissionQueued = level.time;

	// this will keep the clients from playing any voice sounds
	// that will get cut off when the queued intermission starts
	trap_SetConfigstring( CS_INTERMISSION, "1" );

	// don't send more than 32 scores (FIXME?)
	numSorted = level.numConnectedClients;
	if ( numSorted > 32 ) {
		numSorted = 32;
	}

	if ( g_gametype.integer >= GT_TEAM ) {
		G_LogPrintf( "red:%i  blue:%i\n",
			level.teamScores[TEAM_RED], level.teamScores[TEAM_BLUE] );
	}

	for (i=0 ; i < numSorted ; i++) {
		int		ping;

		cl = &level.clients[level.sortedClients[i]];

		if ( cl->sess.sessionTeam == TEAM_SPECTATOR ) {
			continue;
		}
		if ( cl->pers.connected == CON_CONNECTING ) {
			continue;
		}

		ping = cl->ps.ping < 999 ? cl->ps.ping : 999;

		G_LogPrintf( "score: %i  ping: %i  client: %i %s\n", cl->ps.persistant[PERS_SCORE], ping, level.sortedClients[i],	cl->pers.netname );
#ifdef MISSIONPACK
		if (g_singlePlayer.integer && g_gametype.integer == GT_TOURNAMENT) {
			if (g_entities[cl - level.clients].r.svFlags & SVF_BOT && cl->ps.persistant[PERS_RANK] == 0) {
				won = qfalse;
			}
		}
#endif

	}

#ifdef MISSIONPACK
	if (g_singlePlayer.integer) {
		if (g_gametype.integer >= GT_CTF) {
			won = level.teamScores[TEAM_RED] > level.teamScores[TEAM_BLUE];
		}
		trap_SendConsoleCommand( EXEC_APPEND, (won) ? "spWin\n" : "spLose\n" );
	}
#endif


}


/*
=================
CheckIntermissionExit

The level will stay at the intermission for a minimum of 5 seconds
If all players wish to continue, the level will then exit.
If one or more players have not acknowledged the continue, the game will
wait 10 seconds before going on.
=================
*/
void CheckIntermissionExit( void ) {
	int			ready, notReady;
	int			i;
	gclient_t	*cl;
	int			readyMask;

	if ( g_gametype.integer == GT_SINGLE_PLAYER )
		return;

	// see which players are ready
	ready = 0;
	notReady = 0;
	readyMask = 0;
	for ( i = 0 ; i < level.maxclients ; i++) {
		cl = level.clients + i;
		if ( cl->pers.connected != CON_CONNECTED ) {
			continue;
		}

		if ( g_entities[i].r.svFlags & SVF_BOT ) {
			cl->readyToExit = qtrue;
		}

		if ( cl->readyToExit ) {
			ready++;
			if ( i < 16 ) {
				readyMask |= 1 << i;
			}
		} else {
			notReady++;
		}
	}

	// vote in progress
	if ( level.voteTime || level.voteExecuteTime ) {
		ready  = 0;
		notReady = 1;
	}

	// copy the readyMask to each player's stats so
	// it can be displayed on the scoreboard
	for ( i = 0 ; i < level.maxclients ; i++) {
		cl = level.clients + i;
		if ( cl->pers.connected != CON_CONNECTED ) {
			continue;
		}
		cl->ps.stats[STAT_CLIENTS_READY] = readyMask;
	}

	// never exit in less than five seconds
	if ( level.time < level.intermissiontime + 5000 ) {
		return;
	}

	// if nobody wants to go, clear timer
	if ( !ready && notReady ) {
		level.readyToExit = qfalse;
		return;
	}

	// if everyone wants to go, go now
	if ( !notReady ) {
		ExitLevel();
		return;
	}

	// the first person to ready starts the ten second timeout
	if ( !level.readyToExit ) {
		level.readyToExit = qtrue;
		level.exitTime = level.time + 10000;
	}

	// if we have waited ten seconds since at least one player
	// wanted to exit, go ahead
	if ( level.time < level.exitTime ) {
		return;
	}

	ExitLevel();
}


/*
=============
ScoreIsTied
=============
*/
static qboolean ScoreIsTied( void ) {
	int		a, b;

	if ( level.numPlayingClients < 2 ) {
		return qfalse;
	}

	if ( g_gametype.integer >= GT_TEAM ) {
		return level.teamScores[TEAM_RED] == level.teamScores[TEAM_BLUE];
	}

	a = level.clients[level.sortedClients[0]].ps.persistant[PERS_SCORE];
	b = level.clients[level.sortedClients[1]].ps.persistant[PERS_SCORE];

	return a == b;
}


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
#endif

/*
=================
CheckExitRules

There will be a delay between the time the exit is qualified for
and the time everyone is moved to the intermission spot, so you
can see the last frag.
=================
*/
static void CheckExitRules( void ) {
 	int			i;
	gclient_t	*cl;

	// if at the intermission, wait for all non-bots to
	// signal ready, then go to next level
	if ( level.intermissiontime ) {
		CheckIntermissionExit();
		return;
	}

	if ( level.intermissionQueued ) {
#ifdef MISSIONPACK
		int time = (g_singlePlayer.integer) ? SP_INTERMISSION_DELAY_TIME : INTERMISSION_DELAY_TIME;
		if ( level.time - level.intermissionQueued >= time ) {
			level.intermissionQueued = 0;
			BeginIntermission();
		}
#else
		if ( level.time - level.intermissionQueued >= INTERMISSION_DELAY_TIME ) {
			level.intermissionQueued = 0;
			BeginIntermission();
		}
#endif
		return;
	}

	// check for sudden death
	if ( ScoreIsTied() ) {
		// always wait for sudden death
		return;
	}

	if ( g_timelimit.integer && !level.warmupTime ) {
		if ( level.time - level.startTime >= g_timelimit.integer*60000 ) {
			G_BroadcastServerCommand( -1, "print \"Timelimit hit.\n\"");
			LogExit( "Timelimit hit." );
			return;
		}
	}

	if ( level.numPlayingClients < 2 ) {
		return;
	}

	if ( g_gametype.integer < GT_CTF && g_fraglimit.integer ) {
		if ( level.teamScores[TEAM_RED] >= g_fraglimit.integer ) {
			G_BroadcastServerCommand( -1, "print \"Red hit the fraglimit.\n\"" );
			LogExit( "Fraglimit hit." );
			return;
		}

		if ( level.teamScores[TEAM_BLUE] >= g_fraglimit.integer ) {
			G_BroadcastServerCommand( -1, "print \"Blue hit the fraglimit.\n\"" );
			LogExit( "Fraglimit hit." );
			return;
		}

		for ( i = 0 ; i < level.maxclients ; i++ ) {
			cl = level.clients + i;
			if ( cl->pers.connected != CON_CONNECTED ) {
				continue;
			}
			if ( cl->sess.sessionTeam != TEAM_FREE ) {
				continue;
			}

			if ( cl->ps.persistant[PERS_SCORE] >= g_fraglimit.integer ) {
				LogExit( "Fraglimit hit." );
				G_BroadcastServerCommand( -1, va("print \"%s" S_COLOR_WHITE " hit the fraglimit.\n\"",
					cl->pers.netname ) );
				return;
			}
		}
	}

#ifdef MISSIONPACK
	if ( g_gametype.integer >= GT_CTF && g_gametype.integer != GT_CTFS && g_capturelimit.integer ) {
#else
	if ( g_gametype.integer >= GT_CTF && g_capturelimit.integer ) {
#endif

		if ( level.teamScores[TEAM_RED] >= g_capturelimit.integer ) {
			G_BroadcastServerCommand( -1, "print \"Red hit the capturelimit.\n\"" );
			LogExit( "Capturelimit hit." );
			return;
		}

		if ( level.teamScores[TEAM_BLUE] >= g_capturelimit.integer ) {
			G_BroadcastServerCommand( -1, "print \"Blue hit the capturelimit.\n\"" );
			LogExit( "Capturelimit hit." );
			return;
		}
	}

}


static void ClearBodyQue( void ) {
	int	i;
	gentity_t	*ent;

	for ( i = 0 ; i < BODY_QUEUE_SIZE ; i++ ) {
		ent = level.bodyQue[ i ];
		if ( ent->r.linked || ent->physicsObject ) {
			trap_UnlinkEntity( ent );
			ent->physicsObject = qfalse;
		}
	}
}


static void G_WarmupEnd( void )
{
	gclient_t *client;
	gentity_t *ent;
	int i, t;

	// remove corpses
	ClearBodyQue();

	// return flags
	Team_ResetFlags();

	memset( level.teamScores, 0, sizeof( level.teamScores ) );

	level.warmupTime = 0;
	level.startTime = level.time;

	trap_SetConfigstring( CS_SCORES1, "0" );
	trap_SetConfigstring( CS_SCORES2, "0" );
	trap_SetConfigstring( CS_WARMUP, "" );
	trap_SetConfigstring( CS_LEVEL_START_TIME, va( "%i", level.startTime ) );

	client = level.clients;
	for ( i = 0; i < level.maxclients; i++, client++ ) {

		if ( client->pers.connected != CON_CONNECTED )
			continue;

		// reset player awards
		client->ps.persistant[PERS_IMPRESSIVE_COUNT] = 0;
		client->ps.persistant[PERS_EXCELLENT_COUNT] = 0;
		client->ps.persistant[PERS_DEFEND_COUNT] = 0;
		client->ps.persistant[PERS_ASSIST_COUNT] = 0;
		client->ps.persistant[PERS_GAUNTLET_FRAG_COUNT] = 0;

		client->ps.persistant[PERS_SCORE] = 0;
		client->ps.persistant[PERS_CAPTURES] = 0;

		client->ps.persistant[PERS_ATTACKER] = ENTITYNUM_NONE;
		client->ps.persistant[PERS_ATTACKEE_ARMOR] = 0;
		client->damage.enemy = client->damage.team = 0;

		client->ps.stats[STAT_CLIENTS_READY] = 0;
		client->ps.stats[STAT_HOLDABLE_ITEM] = 0;

		memset( &client->ps.powerups, 0, sizeof( client->ps.powerups ) );

		ClientUserinfoChanged( i ); // set max.health etc.

		if ( client->sess.sessionTeam != TEAM_SPECTATOR ) {
			ClientSpawn( level.gentities + i );
		}

		trap_SendServerCommand( i, "map_restart" );
	}

	// respawn items, remove projectiles, etc.
	ent = level.gentities + MAX_CLIENTS;
	for ( i = MAX_CLIENTS; i < level.num_entities ; i++, ent++ ) {

		if ( !ent->inuse || ent->freeAfterEvent )
			continue;

		if ( ent->tag == TAG_DONTSPAWN ) {
			ent->nextthink = 0;
			continue;
		}

		if ( ent->s.eType == ET_ITEM && ent->item ) {

			// already processed in Team_ResetFlags()
			if ( ent->item->giTag == PW_NEUTRALFLAG || ent->item->giTag == PW_REDFLAG || ent->item->giTag == PW_BLUEFLAG )
				continue;

			// remove dropped items
			if ( ent->flags & FL_DROPPED_ITEM ) {
				ent->nextthink = level.time;
				continue;
			}

			// respawn picked up items
			t = SpawnTime( ent, qtrue );
			if ( t != 0 ) {
				// hide items with defined spawn time
				ent->s.eFlags |= EF_NODRAW;
				ent->r.svFlags |= SVF_NOCLIENT;
				ent->r.contents = 0;
				ent->activator = NULL;
				ent->think = RespawnItem;
			} else {
				t = FRAMETIME;
				if ( ent->activator ) {
					ent->activator = NULL;
					ent->think = RespawnItem;
				}
			}
			if ( ent->random ) {
				t += (crandom() * ent->random) * 1000;
				if ( t < FRAMETIME ) {
					t = FRAMETIME;
				}
			}
			ent->nextthink = level.time + t;

		} else if ( ent->s.eType == ET_MISSILE ) {
			// remove all launched missiles
			G_FreeEntity( ent );
		}
	}
#ifdef MISSIONPACK
	/* GT_CTFS: after the initial match warmup, enter the first round's inter-round
	   timer rather than jumping straight into play.  Overwrite the CS_WARMUP that
	   G_WarmupEnd just cleared so the ATD countdown is visible to clients. */
	if ( g_gametype.integer == GT_CTFS ) {
		level.atdRoundStartTime = level.time + atd_rounddelay.integer * 1000;
		level.atdRoundRespawned = qfalse;
		trap_SetConfigstring( CS_WARMUP, va( "%i", level.atdRoundStartTime ) );
	}
#endif
}


/*
========================================================================

FUNCTIONS CALLED EVERY FRAME

========================================================================
*/


/*
=============
CheckTournament

Once a frame, check for changes in tournement player state
=============
*/
static void CheckTournament( void ) {

	// check because we run 3 game frames before calling Connect and/or ClientBegin
	// for clients on a map_restart
	if ( level.numPlayingClients == 0 ) {
		return;
	}

	if ( g_gametype.integer == GT_TOURNAMENT ) {

		// pull in a spectator if needed
		if ( level.numPlayingClients < 2 ) {
			AddTournamentPlayer();
		}

		// if we don't have two players, go back to "waiting for players"
		if ( level.numPlayingClients != 2 ) {
			if ( level.warmupTime != -1 ) {
				level.warmupTime = -1;
				trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
				G_LogPrintf( "Warmup:\n" );
			}
			return;
		}

		if ( level.warmupTime == 0 ) {
			return;
		}

		// if the warmup is changed at the console, restart it
		if ( g_warmup.modificationCount != level.warmupModificationCount ) {
			level.warmupModificationCount = g_warmup.modificationCount;
			level.warmupTime = -1;
		}

		// if all players have arrived, start the countdown
		if ( level.warmupTime < 0 ) {
			if ( level.numPlayingClients == 2 ) {
				if ( g_warmup.integer > 0 ) {
					level.warmupTime = level.time + g_warmup.integer * 1000;
				} else {
					level.warmupTime = 0;
				}

				trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
			}
			return;
		}

		// if the warmup time has counted down, restart
		if ( level.time > level.warmupTime ) {
			G_WarmupEnd();
			return;
		}
	} else if ( g_gametype.integer != GT_SINGLE_PLAYER && level.warmupTime != 0 ) {
		int		counts[TEAM_NUM_TEAMS];
		qboolean	notEnough = qfalse;

		if ( g_gametype.integer >= GT_TEAM ) {
			counts[TEAM_BLUE] = TeamConnectedCount( -1, TEAM_BLUE );
			counts[TEAM_RED] = TeamConnectedCount( -1, TEAM_RED );

			if (counts[TEAM_RED] < 1 || counts[TEAM_BLUE] < 1) {
				notEnough = qtrue;
			}
		} else if ( level.numPlayingClients < 2 ) {
			notEnough = qtrue;
		}

		if ( notEnough ) {
			if ( level.warmupTime != -1 ) {
				level.warmupTime = -1;
				trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
				G_LogPrintf( "Warmup:\n" );
			}
			return; // still waiting for team members
		}

		if ( level.warmupTime == 0 ) {
			return;
		}

		// if the warmup is changed at the console, restart it
		if ( g_warmup.modificationCount != level.warmupModificationCount ) {
			level.warmupModificationCount = g_warmup.modificationCount;
			level.warmupTime = -1;
		}

		// if all players have arrived, start the countdown
		if ( level.warmupTime < 0 ) {
			if ( g_warmup.integer > 0 ) {
				level.warmupTime = level.time + g_warmup.integer * 1000;
			} else {
				level.warmupTime = 0;
			}

			trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
			return;
		}

		// if the warmup time has counted down, restart
		if ( level.time > level.warmupTime ) {
			G_WarmupEnd();
			return;
		}
	}
}


/*
==================
CheckVote
==================
*/
static void CheckVote( void ) {

	if ( level.voteExecuteTime ) {
		 if ( level.voteExecuteTime < level.time ) {
			level.voteExecuteTime = 0;
			trap_SendConsoleCommand( EXEC_APPEND, va( "%s\n", level.voteString ) );
		 }
		 return;
	}

	if ( !level.voteTime ) {
		return;
	}

	if ( level.time - level.voteTime >= VOTE_TIME ) {
		G_BroadcastServerCommand( -1, "print \"Vote failed.\n\"" );
	} else {
		// ATVI Q3 1.32 Patch #9, WNF
		if ( level.voteYes > level.numVotingClients/2 ) {
			// execute the command, then remove the vote
			G_BroadcastServerCommand( -1, "print \"Vote passed.\n\"" );
			level.voteExecuteTime = level.time + 3000;
		} else if ( level.voteNo >= level.numVotingClients/2 ) {
			// same behavior as a timeout
			G_BroadcastServerCommand( -1, "print \"Vote failed.\n\"" );
		} else {
			// still waiting for a majority
			return;
		}
	}

	level.voteTime = 0;
	trap_SetConfigstring( CS_VOTE_TIME, "" );
}


/*
==================
PrintTeam
==================
*/
static void PrintTeam( team_t team, const char *message ) {
	int i;

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if ( level.clients[i].sess.sessionTeam != team )
			continue;
		if ( level.clients[i].pers.connected != CON_CONNECTED )
			continue;
		trap_SendServerCommand( i, message );
	}
}


/*
==================
SetLeader
==================
*/
void SetLeader( team_t team, int client ) {
	int i;

	if ( level.clients[client].pers.connected == CON_DISCONNECTED ) {
		PrintTeam( team, va("print \"%s "S_COLOR_STRIP"is not connected\n\"", level.clients[client].pers.netname) );
		return;
	}
	if (level.clients[client].sess.sessionTeam != team) {
		PrintTeam( team, va("print \"%s "S_COLOR_STRIP"is not on the team anymore\n\"", level.clients[client].pers.netname) );
		return;
	}
	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if (level.clients[i].sess.sessionTeam != team)
			continue;
		if (level.clients[i].sess.teamLeader) {
			level.clients[i].sess.teamLeader = qfalse;
			ClientUserinfoChanged( i );
		}
	}
	level.clients[client].sess.teamLeader = qtrue;
	ClientUserinfoChanged( client );
	PrintTeam( team, va("print \"%s is the new team leader\n\"", level.clients[client].pers.netname) );
}


/*
==================
CheckTeamLeader
==================
*/
void CheckTeamLeader( team_t team ) {
	int i;
	int	max_score, max_id;
	int	max_bot_score, max_bot_id;

	for ( i = 0 ; i < level.maxclients ; i++ ) {

		if ( level.clients[i].sess.sessionTeam != team || level.clients[i].pers.connected == CON_DISCONNECTED )
			continue;

		if ( level.clients[i].sess.teamLeader )
			return;
	}

	// no leaders? find player with highest score
	max_score = SHRT_MIN;
	max_id = -1;
	max_bot_score = SHRT_MIN;
	max_bot_id = -1;

	for ( i = 0 ; i < level.maxclients ; i++ ) {

		if ( level.clients[i].sess.sessionTeam != team )
			continue;

		if ( g_entities[i].r.svFlags & SVF_BOT ) {
			if ( level.clients[i].ps.persistant[PERS_SCORE] > max_bot_score ) {
				max_bot_score = level.clients[i].ps.persistant[PERS_SCORE];
				max_bot_id = i;
			}
		} else {
			if ( level.clients[i].ps.persistant[PERS_SCORE] > max_score ) {
				max_score = level.clients[i].ps.persistant[PERS_SCORE];
				max_id = i;
			}
		}
	}

	if ( max_id != -1 ) {
		SetLeader( team, max_id );
		return;
	}

	if ( max_bot_id != -1 ) {
		SetLeader( team, max_bot_id );
		return;
	}
}


/*
==================
CheckTeamVote
==================
*/
static void CheckTeamVote( team_t team ) {
	int cs_offset;

	if ( team == TEAM_RED )
		cs_offset = 0;
	else if ( team == TEAM_BLUE )
		cs_offset = 1;
	else
		return;

	if ( !level.teamVoteTime[cs_offset] ) {
		return;
	}
	if ( level.time - level.teamVoteTime[cs_offset] >= VOTE_TIME ) {
		G_BroadcastServerCommand( -1, "print \"Team vote failed.\n\"" );
	} else {
		if ( level.teamVoteYes[cs_offset] > level.numteamVotingClients[cs_offset]/2 ) {
			// execute the command, then remove the vote
			G_BroadcastServerCommand( -1, "print \"Team vote passed.\n\"" );
			//
			if ( !Q_strncmp( "leader", level.teamVoteString[cs_offset], 6) ) {
				//set the team leader
				SetLeader(team, atoi(level.teamVoteString[cs_offset] + 7));
			}
			else {
				trap_SendConsoleCommand( EXEC_APPEND, va("%s\n", level.teamVoteString[cs_offset] ) );
			}
		} else if ( level.teamVoteNo[cs_offset] >= level.numteamVotingClients[cs_offset]/2 ) {
			// same behavior as a timeout
			G_BroadcastServerCommand( -1, "print \"Team vote failed.\n\"" );
		} else {
			// still waiting for a majority
			return;
		}
	}
	level.teamVoteTime[cs_offset] = 0;
	trap_SetConfigstring( CS_TEAMVOTE_TIME + cs_offset, "" );

}


/*
==================
CheckCvars
==================
*/
void CheckCvars( void ) {
	static int lastMod = -1;

	if ( lastMod != g_password.modificationCount ) {
		lastMod = g_password.modificationCount;
		if ( g_password.string[0] && Q_stricmp( g_password.string, "none" ) != 0 ) {
			trap_Cvar_Set( "g_needpass", "1" );
		} else {
			trap_Cvar_Set( "g_needpass", "0" );
		}
	}
}


/*
=============
G_RunThink

Runs thinking code for this frame if necessary
=============
*/
void G_RunThink( gentity_t *ent ) {
	int	thinktime;

	thinktime = ent->nextthink;
	if (thinktime <= 0) {
		return;
	}
	if (thinktime > level.time) {
		return;
	}

	ent->nextthink = 0;
	if ( !ent->think ) {
		G_Error ( "NULL ent->think");
	} else {
		ent->think (ent);
	}
}


#ifdef MISSIONPACK
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
	int  i, completedHalves, offset;
	char buf[MAX_ATD_ROUNDS * 14 + 2];

	completedHalves = level.atdRoundNumber; /* not yet incremented */
	if ( completedHalves > MAX_ATD_ROUNDS ) completedHalves = MAX_ATD_ROUNDS;

	offset  = 0;
	buf[0]  = '\0';
	for ( i = 0; i < completedHalves; i++ ) {
		offset += Com_sprintf( buf + offset, (int)sizeof(buf) - offset,
		                       i == 0 ? "%i %i" : " %i %i",
		                       level.atdRoundScoresRed[i],
		                       level.atdRoundScoresBlue[i] );
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
G_ATDEndRound

Called when an ATD round concludes (cap, elimination, or time).
Resets flags, advances the round counter, and begins the next warmup.
==============
*/
void G_ATDEndRound( void ) {
	int halfIdx;
	int scorelimit;

	Team_ResetFlags();

	/* Record this half-round's per-team score delta before advancing the counter. */
	halfIdx = level.atdRoundNumber - 1; /* 0-based */
	if ( halfIdx >= 0 && halfIdx < MAX_ATD_ROUNDS ) {
		level.atdRoundScoresRed[halfIdx]  = level.teamScores[TEAM_RED]  - level.atdRoundStartRed;
		level.atdRoundScoresBlue[halfIdx] = level.teamScores[TEAM_BLUE] - level.atdRoundStartBlue;
	}
	G_ATDUpdateRoundScoreCS();

	level.atdRoundNumber++;

	/* Scorelimit check at round boundary.
	   Games only end when both teams have had equal offensive turns, i.e. when
	   an even number of rounds have been completed (each team attacks once per
	   two-round pair).  If a team hits the scorelimit on an odd-numbered round
	   (the other team still needs their matching attack turn), broadcast a
	   warning and let one more round play out. */
	scorelimit = G_ATDEffectiveScoreLimit();
	if ( scorelimit > 0 ) {
		int roundsPlayed  = level.atdRoundNumber - 1;
		qboolean balanced = ( roundsPlayed % 2 == 0 );
		int red           = level.teamScores[TEAM_RED];
		int blue          = level.teamScores[TEAM_BLUE];

		if ( balanced && ( red >= scorelimit || blue >= scorelimit ) ) {
			if ( red > blue ) {
				G_BroadcastServerCommand( -1, "print \"^1Red^7 wins!\n\"" );
				G_ATDGlobalSound( "sound/vo/red_wins.wav" );
				LogExit( "Scorelimit hit." );
				return;
			} else if ( blue > red ) {
				G_BroadcastServerCommand( -1, "print \"^4Blue^7 wins!\n\"" );
				G_ATDGlobalSound( "sound/vo/blue_wins.wav" );
				LogExit( "Scorelimit hit." );
				return;
			}
			/* Tied at or above scorelimit — continue to next round pair. */
		} else if ( !balanced && ( red >= scorelimit || blue >= scorelimit ) ) {
			team_t lead = ( red >= blue ) ? TEAM_RED : TEAM_BLUE;
			G_BroadcastServerCommand( -1, va(
				"print \"%s has reached the scorelimit — %s gets a final round!\n\"",
				( lead == TEAM_RED ) ? "^1Red^7" : "^4Blue^7",
				( lead == TEAM_RED ) ? "^4Blue^7" : "^1Red^7" ) );
		}
	}

	level.atdRoundStartTime   = level.time + atd_rounddelay.integer * 1000;
	level.atdRoundRespawned   = qfalse;
	level.atdRoundRedPlayers  = 0;
	level.atdRoundBluePlayers = 0;
	level.atdRound30SecWarned = qfalse;
	/* Clear the active-round timer on clients — round is now in warmup phase. */
	trap_SetConfigstring( CS_ATD_ROUNDSTART, "0" );
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
static void G_CheckATDRound( void ) {
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
			level.atdRoundRespawned = qtrue;
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
					ent->client->sess.spectatorClient = -1;
				}
				if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
					continue;
				}
				respawn( ent );
			}
		}

		/* When warmup expires, officially start the round. */
		if ( level.time >= level.atdRoundStartTime ) {
			/* Re-seed both flags at the exact moment the half-round goes live.
			   This guarantees clean flag state even if any entity logic during
			   inter-round warmup changed flag entities unexpectedly. */
			Team_ResetFlags();

			level.atdRoundNumberStarted = level.atdRoundNumber;
			level.atdRound30SecWarned   = qfalse;
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

	/* 4. Entire defending team wiped — attackers earn 2 pts. */
	if ( liesDef == 0 ) {
		G_BroadcastServerCommand( -1, "print \"Defending team eliminated! Attackers score 2 points!\n\"" );
		AddTeamScore( level.intermission_origin, atkTeam, 2 );
		G_ATDEndRound();
		if ( !level.intermissionQueued ) {
			G_ATDGlobalSound( atkTeam == TEAM_RED ? "sound/vo/red_wins_round.wav" : "sound/vo/blue_wins_round.wav" );
		}
		return;
	}
}
#endif /* MISSIONPACK */


/*
================
G_RunFrame

Advances the non-player objects in the world
================
*/
static void G_RunFrame( int levelTime ) {
	int			i;
	gentity_t	*ent;
	gclient_t	*client;
	static	gentity_t *missiles[ MAX_GENTITIES - MAX_CLIENTS ];
	int		numMissiles;

	// if we are waiting for the level to restart, do nothing
	if ( level.restarted ) {
		return;
	}

	level.framenum++;
	level.previousTime = level.time;
	level.time = levelTime;
	level.msec = level.time - level.previousTime;

	// get any cvar changes
	G_UpdateCvars();

	numMissiles = 0;

	//
	// go through all allocated objects
	//
	ent = &g_entities[0];
	for (i=0 ; i<level.num_entities ; i++, ent++) {
		if ( !ent->inuse ) {
			continue;
		}

		// clear events that are too old
		if ( level.time - ent->eventTime > EVENT_VALID_MSEC ) {
			if ( ent->s.event ) {
				ent->s.event = 0;	// &= EV_EVENT_BITS;
				if ( ent->client ) {
					ent->client->ps.externalEvent = 0;
					// predicted events should never be set to zero
					//ent->client->ps.events[0] = 0;
					//ent->client->ps.events[1] = 0;
				}
			}
			if ( ent->freeAfterEvent ) {
				// tempEntities or dropped items completely go away after their event
				G_FreeEntity( ent );
				continue;
			} else if ( ent->unlinkAfterEvent ) {
				// items that will respawn will hide themselves after their pickup event
				ent->unlinkAfterEvent = qfalse;
				trap_UnlinkEntity( ent );
			}
		}

		// temporary entities don't think
		if ( ent->freeAfterEvent ) {
			continue;
		}

		if ( !ent->r.linked && ent->neverFree ) {
			continue;
		}

		if ( ent->s.eType == ET_MISSILE ) {
			// queue for unlagged pass
			missiles[ numMissiles ] = ent;
			numMissiles++;
			continue;
		}

		if ( ent->s.eType == ET_ITEM || ent->physicsObject ) {
			G_RunItem( ent );
			continue;
		}

		if ( ent->s.eType == ET_MOVER ) {
			G_RunMover( ent );
			continue;
		}

		if ( i < MAX_CLIENTS ) {
			client = ent->client;
			client->sess.spectatorTime += level.msec;
			if ( client->pers.connected == CON_CONNECTED )
				G_RunClient( ent );
			continue;
		}

		G_RunThink( ent );
	}

	if ( numMissiles ) {
		// unlagged
		G_TimeShiftAllClients( level.previousTime, NULL );
		// run missiles
		for ( i = 0; i < numMissiles; i++ )
			G_RunMissile( missiles[ i ] );
		// unlagged
		G_UnTimeShiftAllClients( NULL );
	}

	// perform final fixups on the players
	ent = &g_entities[0];
	for (i = 0 ; i < level.maxclients ; i++, ent++ ) {
		if ( ent->inuse ) {
			ClientEndFrame( ent );
		}
	}

	// see if it is time to do a tournement restart
	CheckTournament();

	// see if it is time to end the level
	CheckExitRules();

#ifdef MISSIONPACK
	// Attack & Defend round management
	if ( g_gametype.integer == GT_CTFS ) {
		G_CheckATDRound();
	}
#endif

	// update to team status?
	CheckTeamStatus();

	// cancel vote if timed out
	CheckVote();

	// check team votes
	CheckTeamVote( TEAM_RED );
	CheckTeamVote( TEAM_BLUE );

	// for tracking changes
	CheckCvars();

	if (g_listEntity.integer) {
		for (i = 0; i < MAX_GENTITIES; i++) {
			G_Printf("%4i: %s\n", i, g_entities[i].classname);
		}
		trap_Cvar_Set("g_listEntity", "0");
	}

	// unlagged
	level.frameStartTime = trap_Milliseconds();
}
