#ifdef EXTERN_G_CVAR
	#define G_CVAR( vmCvar, cvarName, defaultString, cvarFlags, modificationCount, trackChange, teamShader ) extern vmCvar_t vmCvar;
#endif

#ifdef DECLARE_G_CVAR
	#define G_CVAR( vmCvar, cvarName, defaultString, cvarFlags, modificationCount, trackChange, teamShader ) vmCvar_t vmCvar;
#endif

#ifdef G_CVAR_LIST
	#define G_CVAR( vmCvar, cvarName, defaultString, cvarFlags, modificationCount, trackChange, teamShader ) { & vmCvar, cvarName, defaultString, cvarFlags, modificationCount, trackChange, teamShader },
#endif

// don't override the cheat state set by the system
G_CVAR( g_cheats, "sv_cheats", "", 0, 0, qfalse, qfalse )

//G_CVAR( g_restarted, "g_restarted", "0", CVAR_ROM, 0, qfalse, qfalse )
G_CVAR( g_mapname, "mapname", "", CVAR_SERVERINFO | CVAR_ROM, 0, qfalse, qfalse )
G_CVAR( sv_fps, "sv_fps", "30", CVAR_ARCHIVE, 0, qfalse, qfalse )

// latched vars
G_CVAR( g_gametype, "g_gametype", "0", CVAR_SERVERINFO | CVAR_USERINFO | CVAR_LATCH, 0, qfalse, qfalse )

G_CVAR( g_maxclients, "sv_maxclients", "8", CVAR_SERVERINFO | CVAR_LATCH | CVAR_ARCHIVE, 0, qfalse, qfalse ) // allow this many total, including spectators
G_CVAR( g_maxGameClients, "g_maxGameClients", "0", CVAR_SERVERINFO | CVAR_LATCH | CVAR_ARCHIVE, 0, qfalse, qfalse ) // allow this many active

// change anytime vars
G_CVAR( g_dmflags, "dmflags", "0", CVAR_SERVERINFO | CVAR_ARCHIVE, 0, qtrue, qfalse )
G_CVAR( g_fraglimit, "fraglimit", "20", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART, 0, qtrue, qfalse )
G_CVAR( g_timelimit, "timelimit", "0", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART, 0, qtrue, qfalse )
G_CVAR( g_capturelimit, "capturelimit", "8", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART, 0, qtrue, qfalse )

G_CVAR( g_synchronousClients, "g_synchronousClients", "0", CVAR_SYSTEMINFO, 0, qfalse, qfalse )

G_CVAR( g_friendlyFire, "g_friendlyFire", "0", CVAR_ARCHIVE, 0, qtrue, qfalse )

G_CVAR( g_autoJoin, "g_autoJoin", "1", CVAR_ARCHIVE, 0, qfalse, qfalse )
G_CVAR( g_teamForceBalance, "g_teamForceBalance", "0", CVAR_ARCHIVE, 0, qfalse, qfalse )

G_CVAR( g_warmup, "g_warmup", "20", CVAR_ARCHIVE, 0, qtrue, qfalse )
G_CVAR( g_log, "g_log", "games.log", CVAR_ARCHIVE, 0, qfalse, qfalse )
G_CVAR( g_logSync, "g_logSync", "0", CVAR_ARCHIVE, 0, qfalse, qfalse )

G_CVAR( g_password, "g_password", "", CVAR_USERINFO, 0, qfalse, qfalse )

G_CVAR( g_banIPs, "g_banIPs", "", CVAR_ARCHIVE, 0, qfalse, qfalse )
G_CVAR( g_filterBan, "g_filterBan", "1", CVAR_ARCHIVE, 0, qfalse, qfalse )

G_CVAR( g_needpass, "g_needpass", "0", CVAR_SERVERINFO | CVAR_ROM, 0, qfalse, qfalse )

G_CVAR( g_dedicated, "dedicated", "0", 0, 0, qfalse, qfalse )

G_CVAR( g_speed, "g_speed", "320", 0, 0, qtrue, qfalse )
G_CVAR( g_gravity, "g_gravity", "800", 0, 0, qtrue, qfalse )
G_CVAR( g_knockback, "g_knockback", "1000", 0, 0, qtrue, qfalse )
G_CVAR( g_quadfactor, "g_quadfactor", "3", 0, 0, qtrue, qfalse )
G_CVAR( g_weaponRespawn, "g_weaponrespawn", "5", 0, 0, qtrue, qfalse )
G_CVAR( g_weaponTeamRespawn, "g_weaponTeamRespawn", "5", 0, 0, qtrue, qfalse )
G_CVAR( g_ammoRespawn, "g_ammoRespawn", "5", 0, 0, qtrue, qfalse )
G_CVAR( g_ammoTeamRespawn, "g_ammoTeamRespawn", "5", 0, 0, qtrue, qfalse )
G_CVAR( g_armorRespawn, "g_armorRespawn", "25", 0, 0, qtrue, qfalse )
G_CVAR( g_armorTeamRespawn, "g_armorTeamRespawn", "25", 0, 0, qtrue, qfalse )
G_CVAR( g_healthRespawn, "g_healthRespawn", "35", 0, 0, qtrue, qfalse )
G_CVAR( g_healthTeamRespawn, "g_healthTeamRespawn", "35", 0, 0, qtrue, qfalse )
G_CVAR( g_megahealthRespawn, "g_megahealthRespawn", "35", 0, 0, qtrue, qfalse )
G_CVAR( g_megahealthTeamRespawn, "g_megahealthTeamRespawn", "35", 0, 0, qtrue, qfalse )
G_CVAR( g_powerupRespawn, "g_powerupRespawn", "120", 0, 0, qtrue, qfalse )
G_CVAR( g_powerupTeamRespawn, "g_powerupTeamRespawn", "120", 0, 0, qtrue, qfalse )
G_CVAR( g_holdableRespawn, "g_holdableRespawn", "60", 0, 0, qtrue, qfalse )
G_CVAR( g_holdableTeamRespawn, "g_holdableTeamRespawn", "60", 0, 0, qtrue, qfalse )
G_CVAR( g_forcerespawn, "g_forcerespawn", "20", 0, 0, qtrue, qfalse )
G_CVAR( g_inactivity, "g_inactivity", "0", 0, 0, qtrue, qfalse )
G_CVAR( g_debugMove, "g_debugMove", "0", 0, 0, qfalse, qfalse )
G_CVAR( g_debugDamage, "g_debugDamage", "0", 0, 0, qfalse, qfalse )
G_CVAR( g_debugAlloc, "g_debugAlloc", "0", 0, 0, qfalse, qfalse )
G_CVAR( g_motd, "g_motd", "", 0, 0, qfalse, qfalse )
G_CVAR( g_blood, "com_blood", "1", 0, 0, qfalse, qfalse )

G_CVAR( g_podiumDist, "g_podiumDist", "80", 0, 0, qfalse, qfalse )
G_CVAR( g_podiumDrop, "g_podiumDrop", "70", 0, 0, qfalse, qfalse )

G_CVAR( g_allowVote, "g_allowVote", "1", CVAR_ARCHIVE, 0, qfalse, qfalse )
G_CVAR( g_listEntity, "g_listEntity", "0", 0, 0, qfalse, qfalse )

G_CVAR( g_unlagged, "g_unlagged", "1", CVAR_SERVERINFO | CVAR_ARCHIVE, 0, qfalse, qfalse )
G_CVAR( g_predictPVS, "g_predictPVS", "0", CVAR_ARCHIVE, 0, qfalse, qfalse )

#ifdef MISSIONPACK
G_CVAR( g_obeliskHealth, "g_obeliskHealth", "2500", 0, 0, qfalse, qfalse )
G_CVAR( g_obeliskRegenPeriod, "g_obeliskRegenPeriod", "1", 0, 0, qfalse, qfalse )
G_CVAR( g_obeliskRegenAmount, "g_obeliskRegenAmount", "15", 0, 0, qfalse, qfalse )
G_CVAR( g_obeliskRespawnDelay, "g_obeliskRespawnDelay", "10", CVAR_SERVERINFO, 0, qfalse, qfalse )

G_CVAR( g_cubeTimeout, "g_cubeTimeout", "30", 0, 0, qfalse, qfalse )
G_CVAR( g_redteam, "g_redteam", "Stroggs", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_USERINFO, 0, qtrue, qtrue )
G_CVAR( g_blueteam, "g_blueteam", "Pagans", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_USERINFO, 0, qtrue, qtrue )
G_CVAR( g_singlePlayer, "ui_singlePlayerActive", "", 0, 0, qfalse, qfalse )

G_CVAR( g_enableDust, "g_enableDust", "0", CVAR_SERVERINFO, 0, qtrue, qfalse )
G_CVAR( g_enableBreath, "g_enableBreath", "0", CVAR_SERVERINFO, 0, qtrue, qfalse )
G_CVAR( g_proxMineTimeout, "g_proxMineTimeout", "20000", 0, 0, qfalse, qfalse )
#endif
G_CVAR( g_smoothClients, "g_smoothClients", "1", 0, 0, qfalse, qfalse )
G_CVAR( pmove_fixed, "pmove_fixed", "0", CVAR_SYSTEMINFO, 0, qfalse, qfalse )
G_CVAR( pmove_msec, "pmove_msec", "8", CVAR_SYSTEMINFO, 0, qfalse, qfalse )
G_CVAR( g_instagib, "g_instagib", "0", CVAR_SYSTEMINFO | CVAR_LATCH, 0, qtrue, qtrue )
G_CVAR( g_railJump, "g_railJump", "0", CVAR_ARCHIVE, 0, qtrue, qtrue )
G_CVAR( g_railJumpDamage, "g_railJumpDamage", "100", CVAR_ARCHIVE, 0, qtrue, qtrue )
G_CVAR( g_noSelfDamage, "g_noSelfDamage", "0", CVAR_ARCHIVE, 0, qtrue,qtrue )

G_CVAR( g_startArmor, "g_startArmor", "0", 0, 0, qfalse, qfalse )
G_CVAR( g_startHealth, "g_startHealth", "0", 0, 0, qfalse, qfalse )

G_CVAR( g_grapple, "g_grapple", "0", 0, 0, qtrue, qfalse )
G_CVAR( g_grappleDelayTime, "g_grappleDelayTime", "400", CVAR_SERVERINFO, 0, qtrue, qfalse )
G_CVAR( g_grappleHoldTime, "g_grappleHoldTime", "0", 0, 0, qtrue, qfalse )
G_CVAR( g_grappleSpeed, "g_grappleSpeed", "800", 0, 0, qtrue, qfalse )
G_CVAR( g_grapplePull, "g_grapplePull", "800", CVAR_SERVERINFO, 0, qtrue, qfalse )
G_CVAR( g_grappleDamage, "g_grappleDamage", "0", 0, 0, qfalse, qfalse )

G_CVAR( g_startAmmoMG, "g_startAmmoMG", "50", 0, 0, qfalse, qfalse )
G_CVAR( g_startAmmoSG, "g_startAmmoSG", "10", 0, 0, qfalse, qfalse )
G_CVAR( g_startAmmoGL, "g_startAmmoGL", "5", 0, 0, qfalse, qfalse )
G_CVAR( g_startAmmoRL, "g_startAmmoRL", "5", 0, 0, qfalse, qfalse )
G_CVAR( g_startAmmoLG, "g_startAmmoLG", "60", 0, 0, qfalse, qfalse )
G_CVAR( g_startAmmoRG, "g_startAmmoRG", "10", 0, 0, qfalse, qfalse )
G_CVAR( g_startAmmoPG, "g_startAmmoPG", "30", 0, 0, qfalse, qfalse )
G_CVAR( g_startAmmoBFG, "g_startAmmoBFG", "15", 0, 0, qfalse, qfalse )

G_CVAR( g_damageG, "g_damageG", "50", 0, 0, qfalse, qfalse )

G_CVAR( g_damageMG, "g_damageMG", "7", 0, 0, qfalse, qfalse )
G_CVAR( g_damageTeamMG, "g_damageTeamMG", "5", 0, 0, qfalse, qfalse )

G_CVAR( g_damageSG, "g_damageSG", "10", 0, 0, qfalse, qfalse )
G_CVAR( g_sgPellets, "g_sgPellets", "11", 0, 0, qfalse, qfalse )
G_CVAR( g_sgPelletSpread, "g_sgPelletSpread", "700", 0, 0, qfalse, qfalse )

G_CVAR( g_damageGL, "g_damageGL", "100", 0, 0, qfalse, qfalse )
G_CVAR( g_splashDamageGL, "g_splashDamageGL", "100", 0, 0, qfalse, qfalse )
G_CVAR( g_splashRadiusGL, "g_splashRadiusGL", "150", 0, 0, qfalse, qfalse )

G_CVAR( g_damageRL, "g_damageRL", "100", 0, 0, qfalse, qfalse )
G_CVAR( g_splashDamageRL, "g_splashDamageRL", "100", 0, 0, qfalse, qfalse )
G_CVAR( g_splashRadiusRL, "g_splashRadiusRL", "120", 0, 0, qfalse, qfalse )
G_CVAR( g_velocityRL, "g_velocityRL", "900", 0, 0, qfalse, qfalse )

G_CVAR( g_damageLG, "g_damageLG", "8", 0, 0, qfalse, qfalse )

G_CVAR( g_damageRG, "g_damageRG", "100", 0, 0, qfalse, qfalse )

G_CVAR( g_damagePG, "g_damagePG", "20", 0, 0, qfalse, qfalse )
G_CVAR( g_splashDamagePG, "g_splashDamagePG", "15", 0, 0, qfalse, qfalse )
G_CVAR( g_splashRadiusPG, "g_splashRadiusPG", "20", 0, 0, qfalse, qfalse )

G_CVAR( g_damageBFG, "g_damageBFG", "100", 0, 0, qfalse, qfalse )
G_CVAR( g_splashDamageBFG, "g_splashDamageBFG", "100", 0, 0, qfalse, qfalse )
G_CVAR( g_splashRadiusBFG, "g_splashRadiusBFG", "120", 0, 0, qfalse, qfalse )

#ifdef MISSIONPACK
G_CVAR( g_startAmmoNG, "g_startAmmoNG", "20", 0, 0, qfalse, qfalse )
G_CVAR( g_startAmmoPL, "g_startAmmoPL", "10", 0, 0, qfalse, qfalse )
G_CVAR( g_startAmmoCG, "g_startAmmoCG", "100", 0, 0, qfalse, qfalse )

G_CVAR( g_damageNG, "g_damageNG", "20", 0, 0, qfalse, qfalse )
G_CVAR( g_damagePL, "g_damagePL", "100", 0, 0, qfalse, qfalse )
G_CVAR( g_splashRadiusPL, "g_splashRadiusPL", "150", 0, 0, qfalse, qfalse )
G_CVAR( g_damageCG, "g_damageCG", "7", 0, 0, qfalse, qfalse )
#endif

G_CVAR( g_tossWeapon, "g_tossWeapon", "1", CVAR_ARCHIVE, 0, qtrue, qtrue )
G_CVAR( g_startingWeapon, "g_startingWeapon", "", 0, 0, qfalse, qfalse )

G_CVAR( g_removeammo, "removeammo", "0", 0, 0, qfalse, qfalse )
G_CVAR( g_removeitem, "removeitem", "0", 0, 0, qfalse, qfalse )
G_CVAR( g_removepowerup, "removepowerup", "0", 0, 0, qfalse, qfalse )
G_CVAR( g_removeweapon, "removeweapon", "0", 0, 0, qfalse, qfalse )
G_CVAR( g_wpflags, "wpflags", "0", 0, 0, qfalse, qfalse )

G_CVAR( g_1FRespawn, "g_1FRespawn", "0", 0, 0, qfalse, qfalse)

G_CVAR( g_rotation, "g_rotation", "0", CVAR_ARCHIVE, 0, qfalse, qfalse )

#undef G_CVAR
