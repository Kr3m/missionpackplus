code
proc BotSetUserInfo 1024 12
file "../../../../code/game/ai_dmq3.c"
line 98
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:/*****************************************************************************
;5: * name:		ai_dmq3.c
;6: *
;7: * desc:		Quake3 bot AI
;8: *
;9: * $Archive: /MissionPack/code/game/ai_dmq3.c $
;10: *
;11: *****************************************************************************/
;12:
;13:
;14:#include "g_local.h"
;15:#include "botlib.h"
;16:#include "be_aas.h"
;17:#include "be_ea.h"
;18:#include "be_ai_char.h"
;19:#include "be_ai_chat.h"
;20:#include "be_ai_gen.h"
;21:#include "be_ai_goal.h"
;22:#include "be_ai_move.h"
;23:#include "be_ai_weap.h"
;24://
;25:#include "ai_main.h"
;26:#include "ai_dmq3.h"
;27:#include "ai_chat.h"
;28:#include "ai_cmd.h"
;29:#include "ai_dmnet.h"
;30:#include "ai_team.h"
;31://
;32:#include "chars.h"				//characteristics
;33:#include "inv.h"				//indexes into the inventory
;34:#include "syn.h"				//synonyms
;35:#include "match.h"				//string matching types and vars
;36:
;37:// for the voice chats
;38:#ifdef MISSIONPACK
;39:#include "../../ui/menudef.h" // sos001205 - for q3_ui also
;40:#endif
;41:
;42:// from aasfile.h
;43:#define AREACONTENTS_MOVER				1024
;44:#define AREACONTENTS_MODELNUMSHIFT		24
;45:#define AREACONTENTS_MAXMODELNUM		0xFF
;46:#define AREACONTENTS_MODELNUM			(AREACONTENTS_MAXMODELNUM << AREACONTENTS_MODELNUMSHIFT)
;47:
;48:#define IDEAL_ATTACKDIST			140
;49:
;50:#define MAX_WAYPOINTS		128
;51://
;52:bot_waypoint_t botai_waypoints[MAX_WAYPOINTS];
;53:bot_waypoint_t *botai_freewaypoints;
;54:
;55://NOTE: not using a cvars which can be updated because the game should be reloaded anyway
;56:int gametype;		//game type
;57://int maxclients;	//maximum number of clients
;58:
;59:vmCvar_t bot_grapple;
;60:vmCvar_t bot_rocketjump;
;61:vmCvar_t bot_fastchat;
;62:vmCvar_t bot_nochat;
;63:vmCvar_t bot_testrchat;
;64:vmCvar_t bot_challenge;
;65:vmCvar_t bot_predictobstacles;
;66:vmCvar_t g_spSkill;
;67:
;68:extern vmCvar_t bot_developer;
;69:
;70:vec3_t lastteleport_origin;		//last teleport event origin
;71:float lastteleport_time;		//last teleport event time
;72:int max_bspmodelindex;			//maximum BSP model index
;73:
;74://CTF flag goals
;75:bot_goal_t ctf_redflag;
;76:bot_goal_t ctf_blueflag;
;77:#ifdef MISSIONPACK
;78:bot_goal_t ctf_neutralflag;
;79:bot_goal_t redobelisk;
;80:bot_goal_t blueobelisk;
;81:bot_goal_t neutralobelisk;
;82:#endif
;83:
;84:#define MAX_ALTROUTEGOALS		32
;85:
;86:int altroutegoals_setup;
;87:aas_altroutegoal_t red_altroutegoals[MAX_ALTROUTEGOALS];
;88:int red_numaltroutegoals;
;89:aas_altroutegoal_t blue_altroutegoals[MAX_ALTROUTEGOALS];
;90:int blue_numaltroutegoals;
;91:
;92:
;93:/*
;94:==================
;95:BotSetUserInfo
;96:==================
;97:*/
;98:static void BotSetUserInfo( bot_state_t *bs, const char *key, const char *value ) {
line 101
;99:	char userinfo[MAX_INFO_STRING];
;100:
;101:	trap_GetUserinfo( bs->client, userinfo, sizeof( userinfo ) );
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 102
;102:	Info_SetValueForKey( userinfo, key, value );
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLI4
pop
line 103
;103:	trap_SetUserinfo( bs->client, userinfo );
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_SetUserinfo
CALLV
pop
line 104
;104:	ClientUserinfoChanged( bs->client );
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLI4
pop
line 105
;105:}
LABELV $55
endproc BotSetUserInfo 1024 12
export BotCTFCarryingFlag
proc BotCTFCarryingFlag 0 0
line 113
;106:
;107:
;108:/*
;109:==================
;110:BotCTFCarryingFlag
;111:==================
;112:*/
;113:int BotCTFCarryingFlag(bot_state_t *bs) {
line 114
;114:	if (gametype != GT_CTF) return CTF_FLAG_NONE;
ADDRGP4 gametype
INDIRI4
CNSTI4 4
EQI4 $57
CNSTI4 0
RETI4
ADDRGP4 $56
JUMPV
LABELV $57
line 116
;115:
;116:	if (bs->inventory[INVENTORY_REDFLAG] > 0) return CTF_FLAG_RED;
ADDRFP4 0
INDIRP4
CNSTI4 5132
ADDP4
INDIRI4
CNSTI4 0
LEI4 $59
CNSTI4 1
RETI4
ADDRGP4 $56
JUMPV
LABELV $59
line 117
;117:	else if (bs->inventory[INVENTORY_BLUEFLAG] > 0) return CTF_FLAG_BLUE;
ADDRFP4 0
INDIRP4
CNSTI4 5136
ADDP4
INDIRI4
CNSTI4 0
LEI4 $61
CNSTI4 2
RETI4
ADDRGP4 $56
JUMPV
LABELV $61
line 118
;118:	return CTF_FLAG_NONE;
CNSTI4 0
RETI4
LABELV $56
endproc BotCTFCarryingFlag 0 0
export BotTeam
proc BotTeam 1044 12
line 126
;119:}
;120:
;121:/*
;122:==================
;123:BotTeam
;124:==================
;125:*/
;126:int BotTeam(bot_state_t *bs) {
line 129
;127:	char info[1024];
;128:
;129:	if (bs->client < 0 || bs->client >= MAX_CLIENTS) {
ADDRLP4 1024
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1024
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
LTI4 $66
ADDRLP4 1024
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 64
LTI4 $64
LABELV $66
line 131
;130:		//BotAI_Print(PRT_ERROR, "BotCTFTeam: client out of range\n");
;131:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $63
JUMPV
LABELV $64
line 133
;132:	}
;133:	trap_GetConfigstring(CS_PLAYERS+bs->client, info, sizeof(info));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 135
;134:	//
;135:	if (atoi(Info_ValueForKey(info, "t")) == TEAM_RED) return TEAM_RED;
ADDRLP4 0
ARGP4
ADDRGP4 $69
ARGP4
ADDRLP4 1028
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 1032
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $67
CNSTI4 1
RETI4
ADDRGP4 $63
JUMPV
LABELV $67
line 136
;136:	else if (atoi(Info_ValueForKey(info, "t")) == TEAM_BLUE) return TEAM_BLUE;
ADDRLP4 0
ARGP4
ADDRGP4 $69
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 1040
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 2
NEI4 $70
CNSTI4 2
RETI4
ADDRGP4 $63
JUMPV
LABELV $70
line 137
;137:	return TEAM_FREE;
CNSTI4 0
RETI4
LABELV $63
endproc BotTeam 1044 12
export BotOppositeTeam
proc BotOppositeTeam 12 4
line 145
;138:}
;139:
;140:/*
;141:==================
;142:BotOppositeTeam
;143:==================
;144:*/
;145:int BotOppositeTeam(bot_state_t *bs) {
line 146
;146:	switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $76
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $77
ADDRGP4 $73
JUMPV
LABELV $76
line 147
;147:		case TEAM_RED: return TEAM_BLUE;
CNSTI4 2
RETI4
ADDRGP4 $72
JUMPV
LABELV $77
line 148
;148:		case TEAM_BLUE: return TEAM_RED;
CNSTI4 1
RETI4
ADDRGP4 $72
JUMPV
LABELV $73
line 149
;149:		default: return TEAM_FREE;
CNSTI4 0
RETI4
LABELV $72
endproc BotOppositeTeam 12 4
export BotEnemyFlag
proc BotEnemyFlag 4 4
line 158
;150:	}
;151:}
;152:
;153:/*
;154:==================
;155:BotEnemyFlag
;156:==================
;157:*/
;158:bot_goal_t *BotEnemyFlag(bot_state_t *bs) {
line 159
;159:	if (BotTeam(bs) == TEAM_RED) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $79
line 160
;160:		return &ctf_blueflag;
ADDRGP4 ctf_blueflag
RETP4
ADDRGP4 $78
JUMPV
LABELV $79
line 162
;161:	}
;162:	else {
line 163
;163:		return &ctf_redflag;
ADDRGP4 ctf_redflag
RETP4
LABELV $78
endproc BotEnemyFlag 4 4
export BotTeamFlag
proc BotTeamFlag 4 4
line 172
;164:	}
;165:}
;166:
;167:/*
;168:==================
;169:BotTeamFlag
;170:==================
;171:*/
;172:bot_goal_t *BotTeamFlag(bot_state_t *bs) {
line 173
;173:	if (BotTeam(bs) == TEAM_RED) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $82
line 174
;174:		return &ctf_redflag;
ADDRGP4 ctf_redflag
RETP4
ADDRGP4 $81
JUMPV
LABELV $82
line 176
;175:	}
;176:	else {
line 177
;177:		return &ctf_blueflag;
ADDRGP4 ctf_blueflag
RETP4
LABELV $81
endproc BotTeamFlag 4 4
export EntityIsDead
proc EntityIsDead 472 8
line 187
;178:	}
;179:}
;180:
;181:
;182:/*
;183:==================
;184:EntityIsDead
;185:==================
;186:*/
;187:qboolean EntityIsDead(aas_entityinfo_t *entinfo) {
line 190
;188:	playerState_t ps;
;189:
;190:	if (entinfo->number >= 0 && entinfo->number < MAX_CLIENTS) {
ADDRLP4 468
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 468
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
LTI4 $85
ADDRLP4 468
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 64
GEI4 $85
line 192
;191:		//retrieve the current client state
;192:		BotAI_GetClientState( entinfo->number, &ps );
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
line 193
;193:		if (ps.pm_type != PM_NORMAL) return qtrue;
ADDRLP4 0+4
INDIRI4
CNSTI4 0
EQI4 $87
CNSTI4 1
RETI4
ADDRGP4 $84
JUMPV
LABELV $87
line 194
;194:	}
LABELV $85
line 195
;195:	return qfalse;
CNSTI4 0
RETI4
LABELV $84
endproc EntityIsDead 472 8
export EntityCarriesFlag
proc EntityCarriesFlag 0 0
line 203
;196:}
;197:
;198:/*
;199:==================
;200:EntityCarriesFlag
;201:==================
;202:*/
;203:qboolean EntityCarriesFlag(aas_entityinfo_t *entinfo) {
line 204
;204:	if ( entinfo->powerups & ( 1 << PW_REDFLAG ) )
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $91
line 205
;205:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $90
JUMPV
LABELV $91
line 206
;206:	if ( entinfo->powerups & ( 1 << PW_BLUEFLAG ) )
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $93
line 207
;207:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $90
JUMPV
LABELV $93
line 209
;208:#ifdef MISSIONPACK
;209:	if ( entinfo->powerups & ( 1 << PW_NEUTRALFLAG ) )
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $95
line 210
;210:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $90
JUMPV
LABELV $95
line 212
;211:#endif
;212:	return qfalse;
CNSTI4 0
RETI4
LABELV $90
endproc EntityCarriesFlag 0 0
export EntityIsInvisible
proc EntityIsInvisible 4 4
line 220
;213:}
;214:
;215:/*
;216:==================
;217:EntityIsInvisible
;218:==================
;219:*/
;220:qboolean EntityIsInvisible(aas_entityinfo_t *entinfo) {
line 222
;221:	// the flag is always visible
;222:	if (EntityCarriesFlag(entinfo)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $98
line 223
;223:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $97
JUMPV
LABELV $98
line 225
;224:	}
;225:	if (entinfo->powerups & (1 << PW_INVIS)) {
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $100
line 226
;226:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $97
JUMPV
LABELV $100
line 228
;227:	}
;228:	return qfalse;
CNSTI4 0
RETI4
LABELV $97
endproc EntityIsInvisible 4 4
export EntityIsShooting
proc EntityIsShooting 0 0
line 236
;229:}
;230:
;231:/*
;232:==================
;233:EntityIsShooting
;234:==================
;235:*/
;236:qboolean EntityIsShooting(aas_entityinfo_t *entinfo) {
line 237
;237:	if (entinfo->flags & EF_FIRING) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $103
line 238
;238:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $102
JUMPV
LABELV $103
line 240
;239:	}
;240:	return qfalse;
CNSTI4 0
RETI4
LABELV $102
endproc EntityIsShooting 0 0
export EntityIsChatting
proc EntityIsChatting 0 0
line 248
;241:}
;242:
;243:/*
;244:==================
;245:EntityIsChatting
;246:==================
;247:*/
;248:qboolean EntityIsChatting(aas_entityinfo_t *entinfo) {
line 249
;249:	if (entinfo->flags & EF_TALK) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $106
line 250
;250:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $105
JUMPV
LABELV $106
line 252
;251:	}
;252:	return qfalse;
CNSTI4 0
RETI4
LABELV $105
endproc EntityIsChatting 0 0
export EntityHasQuad
proc EntityHasQuad 0 0
line 260
;253:}
;254:
;255:/*
;256:==================
;257:EntityHasQuad
;258:==================
;259:*/
;260:qboolean EntityHasQuad(aas_entityinfo_t *entinfo) {
line 261
;261:	if (entinfo->powerups & (1 << PW_QUAD)) {
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $109
line 262
;262:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $108
JUMPV
LABELV $109
line 264
;263:	}
;264:	return qfalse;
CNSTI4 0
RETI4
LABELV $108
endproc EntityHasQuad 0 0
export EntityHasKamikaze
proc EntityHasKamikaze 0 0
line 273
;265:}
;266:
;267:#ifdef MISSIONPACK
;268:/*
;269:==================
;270:EntityHasKamikze
;271:==================
;272:*/
;273:qboolean EntityHasKamikaze(aas_entityinfo_t *entinfo) {
line 274
;274:	if (entinfo->flags & EF_KAMIKAZE) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $112
line 275
;275:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $111
JUMPV
LABELV $112
line 277
;276:	}
;277:	return qfalse;
CNSTI4 0
RETI4
LABELV $111
endproc EntityHasKamikaze 0 0
export EntityCarriesCubes
proc EntityCarriesCubes 208 8
line 285
;278:}
;279:
;280:/*
;281:==================
;282:EntityCarriesCubes
;283:==================
;284:*/
;285:qboolean EntityCarriesCubes(aas_entityinfo_t *entinfo) {
line 288
;286:	entityState_t state;
;287:
;288:	if (gametype != GT_HARVESTER)
ADDRGP4 gametype
INDIRI4
CNSTI4 7
EQI4 $115
line 289
;289:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $114
JUMPV
LABELV $115
line 291
;290:	//FIXME: get this info from the aas_entityinfo_t ?
;291:	BotAI_GetEntityState(entinfo->number, &state);
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotAI_GetEntityState
CALLI4
pop
line 292
;292:	if (state.generic1 > 0)
ADDRLP4 0+204
INDIRI4
CNSTI4 0
LEI4 $117
line 293
;293:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $114
JUMPV
LABELV $117
line 294
;294:	return qfalse;
CNSTI4 0
RETI4
LABELV $114
endproc EntityCarriesCubes 208 8
export Bot1FCTFCarryingFlag
proc Bot1FCTFCarryingFlag 0 0
line 302
;295:}
;296:
;297:/*
;298:==================
;299:Bot1FCTFCarryingFlag
;300:==================
;301:*/
;302:int Bot1FCTFCarryingFlag(bot_state_t *bs) {
line 303
;303:	if (gametype != GT_1FCTF) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 5
EQI4 $121
CNSTI4 0
RETI4
ADDRGP4 $120
JUMPV
LABELV $121
line 305
;304:
;305:	if (bs->inventory[INVENTORY_NEUTRALFLAG] > 0) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 5140
ADDP4
INDIRI4
CNSTI4 0
LEI4 $123
CNSTI4 1
RETI4
ADDRGP4 $120
JUMPV
LABELV $123
line 306
;306:	return qfalse;
CNSTI4 0
RETI4
LABELV $120
endproc Bot1FCTFCarryingFlag 0 0
export BotHarvesterCarryingCubes
proc BotHarvesterCarryingCubes 0 0
line 314
;307:}
;308:
;309:/*
;310:==================
;311:BotHarvesterCarryingCubes
;312:==================
;313:*/
;314:int BotHarvesterCarryingCubes(bot_state_t *bs) {
line 315
;315:	if (gametype != GT_HARVESTER) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 7
EQI4 $126
CNSTI4 0
RETI4
ADDRGP4 $125
JUMPV
LABELV $126
line 317
;316:
;317:	if (bs->inventory[INVENTORY_REDCUBE] > 0) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 5144
ADDP4
INDIRI4
CNSTI4 0
LEI4 $128
CNSTI4 1
RETI4
ADDRGP4 $125
JUMPV
LABELV $128
line 318
;318:	if (bs->inventory[INVENTORY_BLUECUBE] > 0) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 5148
ADDP4
INDIRI4
CNSTI4 0
LEI4 $130
CNSTI4 1
RETI4
ADDRGP4 $125
JUMPV
LABELV $130
line 319
;319:	return qfalse;
CNSTI4 0
RETI4
LABELV $125
endproc BotHarvesterCarryingCubes 0 0
export BotRememberLastOrderedTask
proc BotRememberLastOrderedTask 16 12
line 328
;320:}
;321:#endif
;322:
;323:/*
;324:==================
;325:BotRememberLastOrderedTask
;326:==================
;327:*/
;328:void BotRememberLastOrderedTask(bot_state_t *bs) {
line 329
;329:	if (!bs->ordered) {
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $133
line 330
;330:		return;
ADDRGP4 $132
JUMPV
LABELV $133
line 332
;331:	}
;332:	bs->lastgoal_decisionmaker = bs->decisionmaker;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 6756
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 6608
ADDP4
INDIRI4
ASGNI4
line 333
;333:	bs->lastgoal_ltgtype = bs->ltgtype;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6760
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
line 334
;334:	memcpy(&bs->lastgoal_teamgoal, &bs->teamgoal, sizeof(bot_goal_t));
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 6768
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
CNSTU4 56
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 335
;335:	bs->lastgoal_teammate = bs->teammate;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 6764
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ASGNI4
line 336
;336:}
LABELV $132
endproc BotRememberLastOrderedTask 16 12
export BotSetTeamStatus
proc BotSetTeamStatus 164 12
line 343
;337:
;338:/*
;339:==================
;340:BotSetTeamStatus
;341:==================
;342:*/
;343:void BotSetTeamStatus(bot_state_t *bs) {
line 348
;344:#ifdef MISSIONPACK
;345:	int teamtask;
;346:	aas_entityinfo_t entinfo;
;347:
;348:	teamtask = TEAMTASK_PATROL;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 350
;349:
;350:	switch(bs->ltgtype) {
ADDRLP4 144
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 1
LTI4 $136
ADDRLP4 144
INDIRI4
CNSTI4 13
GTI4 $136
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $156-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $156
address $137
address $140
address $146
address $147
address $148
address $149
address $150
address $150
address $151
address $152
address $153
address $154
address $155
code
line 352
;351:		case LTG_TEAMHELP:
;352:			break;
LABELV $140
line 354
;353:		case LTG_TEAMACCOMPANY:
;354:			BotEntityInfo(bs->teammate, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 355
;355:			if ( ( (gametype == GT_CTF || gametype == GT_1FCTF) && EntityCarriesFlag(&entinfo))
ADDRLP4 152
ADDRGP4 gametype
INDIRI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 4
EQI4 $145
ADDRLP4 152
INDIRI4
CNSTI4 5
NEI4 $144
LABELV $145
ADDRLP4 4
ARGP4
ADDRLP4 156
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
NEI4 $143
LABELV $144
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $141
ADDRLP4 4
ARGP4
ADDRLP4 160
ADDRGP4 EntityCarriesCubes
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
EQI4 $141
LABELV $143
line 356
;356:				|| ( gametype == GT_HARVESTER && EntityCarriesCubes(&entinfo)) ) {
line 357
;357:				teamtask = TEAMTASK_ESCORT;
ADDRLP4 0
CNSTI4 6
ASGNI4
line 358
;358:			}
ADDRGP4 $137
JUMPV
LABELV $141
line 359
;359:			else {
line 360
;360:				teamtask = TEAMTASK_FOLLOW;
ADDRLP4 0
CNSTI4 4
ASGNI4
line 361
;361:			}
line 362
;362:			break;
ADDRGP4 $137
JUMPV
LABELV $146
line 364
;363:		case LTG_DEFENDKEYAREA:
;364:			teamtask = TEAMTASK_DEFENSE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 365
;365:			break;
ADDRGP4 $137
JUMPV
LABELV $147
line 367
;366:		case LTG_GETFLAG:
;367:			teamtask = TEAMTASK_OFFENSE;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 368
;368:			break;
ADDRGP4 $137
JUMPV
LABELV $148
line 370
;369:		case LTG_RUSHBASE:
;370:			teamtask = TEAMTASK_DEFENSE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 371
;371:			break;
ADDRGP4 $137
JUMPV
LABELV $149
line 373
;372:		case LTG_RETURNFLAG:
;373:			teamtask = TEAMTASK_RETRIEVE;
ADDRLP4 0
CNSTI4 5
ASGNI4
line 374
;374:			break;
ADDRGP4 $137
JUMPV
LABELV $150
line 377
;375:		case LTG_CAMP:
;376:		case LTG_CAMPORDER:
;377:			teamtask = TEAMTASK_CAMP;
ADDRLP4 0
CNSTI4 7
ASGNI4
line 378
;378:			break;
ADDRGP4 $137
JUMPV
LABELV $151
line 380
;379:		case LTG_PATROL:
;380:			teamtask = TEAMTASK_PATROL;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 381
;381:			break;
ADDRGP4 $137
JUMPV
LABELV $152
line 383
;382:		case LTG_GETITEM:
;383:			teamtask = TEAMTASK_PATROL;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 384
;384:			break;
ADDRGP4 $137
JUMPV
LABELV $153
line 386
;385:		case LTG_KILL:
;386:			teamtask = TEAMTASK_PATROL;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 387
;387:			break;
ADDRGP4 $137
JUMPV
LABELV $154
line 389
;388:		case LTG_HARVEST:
;389:			teamtask = TEAMTASK_OFFENSE;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 390
;390:			break;
ADDRGP4 $137
JUMPV
LABELV $155
line 392
;391:		case LTG_ATTACKENEMYBASE:
;392:			teamtask = TEAMTASK_OFFENSE;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 393
;393:			break;
ADDRGP4 $137
JUMPV
LABELV $136
line 395
;394:		default:
;395:			teamtask = TEAMTASK_PATROL;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 396
;396:			break;
LABELV $137
line 398
;397:	}
;398:	BotSetUserInfo(bs, "teamtask", va("%d", teamtask));
ADDRGP4 $159
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $158
ARGP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRGP4 BotSetUserInfo
CALLV
pop
line 400
;399:#endif
;400:}
LABELV $135
endproc BotSetTeamStatus 164 12
export BotSetLastOrderedTask
proc BotSetLastOrderedTask 60 16
line 407
;401:
;402:/*
;403:==================
;404:BotSetLastOrderedTask
;405:==================
;406:*/
;407:int BotSetLastOrderedTask(bot_state_t *bs) {
line 409
;408:
;409:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $161
line 411
;410:		// don't go back to returning the flag if it's at the base
;411:		if ( bs->lastgoal_ltgtype == LTG_RETURNFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 6
NEI4 $163
line 412
;412:			if ( BotTeam(bs) == TEAM_RED ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $165
line 413
;413:				if ( bs->redflagstatus == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
CNSTI4 0
NEI4 $166
line 414
;414:					bs->lastgoal_ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
CNSTI4 0
ASGNI4
line 415
;415:				}
line 416
;416:			}
ADDRGP4 $166
JUMPV
LABELV $165
line 417
;417:			else {
line 418
;418:				if ( bs->blueflagstatus == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 6960
ADDP4
INDIRI4
CNSTI4 0
NEI4 $169
line 419
;419:					bs->lastgoal_ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
CNSTI4 0
ASGNI4
line 420
;420:				}
LABELV $169
line 421
;421:			}
LABELV $166
line 422
;422:		}
LABELV $163
line 423
;423:	}
LABELV $161
line 425
;424:
;425:	if ( bs->lastgoal_ltgtype ) {
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $171
line 426
;426:		bs->decisionmaker = bs->lastgoal_decisionmaker;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 6756
ADDP4
INDIRI4
ASGNI4
line 427
;427:		bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 1
ASGNI4
line 428
;428:		bs->ltgtype = bs->lastgoal_ltgtype;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6600
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
ASGNI4
line 429
;429:		memcpy(&bs->teamgoal, &bs->lastgoal_teamgoal, sizeof(bot_goal_t));
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 6768
ADDP4
ARGP4
CNSTU4 56
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 430
;430:		bs->teammate = bs->lastgoal_teammate;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 6604
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 6764
ADDP4
INDIRI4
ASGNI4
line 431
;431:		bs->teamgoal_time = FloatTime() + 300;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1133903872
ADDF4
ASGNF4
line 432
;432:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 434
;433:		//
;434:		if ( gametype == GT_CTF ) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $173
line 435
;435:			if ( bs->ltgtype == LTG_GETFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
NEI4 $175
line 439
;436:				bot_goal_t *tb, *eb;
;437:				int tt, et;
;438:
;439:				tb = BotTeamFlag(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 BotTeamFlag
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 32
INDIRP4
ASGNP4
line 440
;440:				eb = BotEnemyFlag(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 BotEnemyFlag
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 36
INDIRP4
ASGNP4
line 441
;441:				tt = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, tb->areanum, TFL_DEFAULT);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 44
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 44
INDIRI4
ASGNI4
line 442
;442:				et = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, eb->areanum, TFL_DEFAULT);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 52
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 52
INDIRI4
ASGNI4
line 444
;443:				// if the travel time towards the enemy base is larger than towards our base
;444:				if (et > tt) {
ADDRLP4 28
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $177
line 446
;445:					//get an alternative route goal towards the enemy base
;446:					BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 447
;447:				}
LABELV $177
line 448
;448:			}
LABELV $175
line 449
;449:		}
LABELV $173
line 450
;450:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $160
JUMPV
LABELV $171
line 452
;451:	}
;452:	return qfalse;
CNSTI4 0
RETI4
LABELV $160
endproc BotSetLastOrderedTask 60 16
export BotRefuseOrder
proc BotRefuseOrder 8 12
line 460
;453:}
;454:
;455:/*
;456:==================
;457:BotRefuseOrder
;458:==================
;459:*/
;460:void BotRefuseOrder(bot_state_t *bs) {
line 461
;461:	if (!bs->ordered)
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $180
line 462
;462:		return;
ADDRGP4 $179
JUMPV
LABELV $180
line 464
;463:	// if the bot was ordered to do something
;464:	if ( bs->order_time && bs->order_time > FloatTime() - 10 ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 6616
ADDP4
INDIRF4
CNSTF4 0
EQF4 $182
ADDRLP4 0
INDIRP4
CNSTI4 6616
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1092616192
SUBF4
LEF4 $182
line 465
;465:		trap_EA_Action(bs->client, ACTION_NEGATIVE);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 2097152
ARGI4
ADDRGP4 trap_EA_Action
CALLV
pop
line 467
;466:#ifdef MISSIONPACK
;467:		BotVoiceChat(bs, bs->decisionmaker, VOICECHAT_NO);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 6608
ADDP4
INDIRI4
ARGI4
ADDRGP4 $184
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 469
;468:#endif
;469:		bs->order_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
CNSTF4 0
ASGNF4
line 470
;470:	}
LABELV $182
line 471
;471:}
LABELV $179
endproc BotRefuseOrder 8 12
export BotCTFSeekGoals
proc BotCTFSeekGoals 228 12
line 478
;472:
;473:/*
;474:==================
;475:BotCTFSeekGoals
;476:==================
;477:*/
;478:void BotCTFSeekGoals(bot_state_t *bs) {
line 485
;479:	float rnd, l1, l2;
;480:	int flagstatus, c;
;481:	vec3_t dir;
;482:	aas_entityinfo_t entinfo;
;483:
;484:	//when carrying a flag in ctf the bot should rush to the base
;485:	if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 172
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
EQI4 $186
line 487
;486:		//if not already rushing to the base
;487:		if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $188
line 488
;488:			BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 489
;489:			bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 5
ASGNI4
line 490
;490:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 491
;491:			bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 492
;492:			bs->decisionmaker = bs->client;
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 176
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 176
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 493
;493:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 495
;494:			//
;495:			switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 184
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 180
ADDRLP4 184
INDIRI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 1
EQI4 $193
ADDRLP4 180
INDIRI4
CNSTI4 2
EQI4 $198
ADDRGP4 $190
JUMPV
LABELV $193
line 496
;496:				case TEAM_RED: VectorSubtract(bs->origin, ctf_blueflag.origin, dir); break;
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
ADDRLP4 192
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRGP4 ctf_blueflag
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160+4
ADDRLP4 192
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRGP4 ctf_blueflag+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRGP4 ctf_blueflag+8
INDIRF4
SUBF4
ASGNF4
ADDRGP4 $191
JUMPV
LABELV $198
line 497
;497:				case TEAM_BLUE: VectorSubtract(bs->origin, ctf_redflag.origin, dir); break;
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
ADDRLP4 196
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRGP4 ctf_redflag
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160+4
ADDRLP4 196
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRGP4 ctf_redflag+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRGP4 ctf_redflag+8
INDIRF4
SUBF4
ASGNF4
ADDRGP4 $191
JUMPV
LABELV $190
line 498
;498:				default: VectorSet(dir, 999, 999, 999); break;
ADDRLP4 160
CNSTF4 1148829696
ASGNF4
ADDRLP4 160+4
CNSTF4 1148829696
ASGNF4
ADDRLP4 160+8
CNSTF4 1148829696
ASGNF4
LABELV $191
line 501
;499:			}
;500:			// if the bot picked up the flag very close to the enemy base
;501:			if ( VectorLength(dir) < 128 ) {
ADDRLP4 160
ARGP4
ADDRLP4 192
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 192
INDIRF4
CNSTF4 1124073472
GEF4 $205
line 503
;502:				// get an alternative route goal through the enemy base
;503:				BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 504
;504:			} else {
ADDRGP4 $206
JUMPV
LABELV $205
line 506
;505:				// don't use any alt route goal, just get the hell out of the base
;506:				bs->altroutegoal.areanum = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6692
ADDP4
CNSTI4 0
ASGNI4
line 507
;507:			}
LABELV $206
line 508
;508:			BotSetUserInfo(bs, "teamtask", va("%d", TEAMTASK_OFFENSE));
ADDRGP4 $159
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 196
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $158
ARGP4
ADDRLP4 196
INDIRP4
ARGP4
ADDRGP4 BotSetUserInfo
CALLV
pop
line 510
;509:#ifdef MISSIONPACK
;510:			BotVoiceChat(bs, -1, VOICECHAT_IHAVEFLAG);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $207
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 512
;511:#endif
;512:		}
ADDRGP4 $185
JUMPV
LABELV $188
line 513
;513:		else if (bs->rushbaseaway_time > FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $185
line 514
;514:			if (BotTeam(bs) == TEAM_RED) flagstatus = bs->redflagstatus;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 176
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 1
NEI4 $210
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $211
JUMPV
LABELV $210
line 515
;515:			else flagstatus = bs->blueflagstatus;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6960
ADDP4
INDIRI4
ASGNI4
LABELV $211
line 517
;516:			//if the flag is back
;517:			if (flagstatus == 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $185
line 518
;518:				bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 519
;519:			}
line 520
;520:		}
line 521
;521:		return;
ADDRGP4 $185
JUMPV
LABELV $186
line 524
;522:	}
;523:	// if the bot decided to follow someone
;524:	if ( bs->ltgtype == LTG_TEAMACCOMPANY && !bs->ordered ) {
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 176
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
NEI4 $214
ADDRLP4 176
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $214
line 526
;525:		// if the team mate being accompanied no longer carries the flag
;526:		BotEntityInfo(bs->teammate, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 527
;527:		if (!EntityCarriesFlag(&entinfo)) {
ADDRLP4 16
ARGP4
ADDRLP4 180
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
NEI4 $216
line 528
;528:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 529
;529:		}
LABELV $216
line 530
;530:	}
LABELV $214
line 532
;531:	//
;532:	if (BotTeam(bs) == TEAM_RED) flagstatus = bs->redflagstatus * 2 + bs->blueflagstatus;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 180
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 1
NEI4 $218
ADDRLP4 184
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 184
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 184
INDIRP4
CNSTI4 6960
ADDP4
INDIRI4
ADDI4
ASGNI4
ADDRGP4 $219
JUMPV
LABELV $218
line 533
;533:	else flagstatus = bs->blueflagstatus * 2 + bs->redflagstatus;
ADDRLP4 188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 188
INDIRP4
CNSTI4 6960
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 188
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
ADDI4
ASGNI4
LABELV $219
line 535
;534:	//if our team has the enemy flag and our flag is at the base
;535:	if (flagstatus == 1) {
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $220
line 537
;536:		//
;537:		if (bs->owndecision_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
GEF4 $185
line 539
;538:			//if Not defending the base already
;539:			if (!(bs->ltgtype == LTG_DEFENDKEYAREA &&
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 3
NEI4 $228
ADDRLP4 192
INDIRP4
CNSTI4 6668
ADDP4
INDIRI4
ADDRGP4 ctf_redflag+44
INDIRI4
EQI4 $185
ADDRLP4 192
INDIRP4
CNSTI4 6668
ADDP4
INDIRI4
ADDRGP4 ctf_blueflag+44
INDIRI4
EQI4 $185
LABELV $228
line 541
;540:					(bs->teamgoal.number == ctf_redflag.number ||
;541:					bs->teamgoal.number == ctf_blueflag.number))) {
line 543
;542:				//if there is a visible team mate flag carrier
;543:				c = BotTeamFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 BotTeamFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 156
ADDRLP4 196
INDIRI4
ASGNI4
line 544
;544:				if (c >= 0 &&
ADDRLP4 200
ADDRLP4 156
INDIRI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
LTI4 $185
ADDRLP4 204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 204
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
NEI4 $231
ADDRLP4 204
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ADDRLP4 200
INDIRI4
EQI4 $185
LABELV $231
line 546
;545:						// and not already following the team mate flag carrier
;546:						(bs->ltgtype != LTG_TEAMACCOMPANY || bs->teammate != c)) {
line 548
;547:					//
;548:					BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 550
;549:					//follow the flag carrier
;550:					bs->decisionmaker = bs->client;
ADDRLP4 208
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 208
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 208
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 551
;551:					bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 553
;552:					//the team mate
;553:					bs->teammate = c;
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
ADDRLP4 156
INDIRI4
ASGNI4
line 555
;554:					//last time the team mate was visible
;555:					bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6748
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 557
;556:					//no message
;557:					bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 559
;558:					//no arrive message
;559:					bs->arrive_time = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6172
ADDP4
CNSTF4 1065353216
ASGNF4
line 562
;560:					//
;561:#ifdef MISSIONPACK
;562:					BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
ADDRLP4 212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 212
INDIRP4
ARGP4
ADDRLP4 212
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRGP4 $232
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 565
;563:#endif
;564:					//get the team goal time
;565:					bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 566
;566:					bs->ltgtype = LTG_TEAMACCOMPANY;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 2
ASGNI4
line 567
;567:					bs->formation_dist = 3.5 * 32;		//3.5 meter
ADDRFP4 0
INDIRP4
CNSTI4 7016
ADDP4
CNSTF4 1121976320
ASGNF4
line 568
;568:					BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 569
;569:					bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 570
;570:				}
line 571
;571:			}
line 572
;572:		}
line 573
;573:		return;
ADDRGP4 $185
JUMPV
LABELV $220
line 576
;574:	}
;575:	//if the enemy has our flag
;576:	else if (flagstatus == 2) {
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $233
line 578
;577:		//
;578:		if (bs->owndecision_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
GEF4 $185
line 580
;579:			//if enemy flag carrier is visible
;580:			c = BotEnemyFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 192
ADDRGP4 BotEnemyFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 156
ADDRLP4 192
INDIRI4
ASGNI4
line 581
;581:			if (c >= 0) {
ADDRLP4 156
INDIRI4
CNSTI4 0
LTI4 $237
line 583
;582:				//FIXME: fight enemy flag carrier
;583:			}
LABELV $237
line 585
;584:			//if not already doing something important
;585:			if (bs->ltgtype != LTG_GETFLAG &&
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 196
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
EQI4 $185
ADDRLP4 196
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 6
EQI4 $185
ADDRLP4 196
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 1
EQI4 $185
ADDRLP4 196
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $185
ADDRLP4 196
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 8
EQI4 $185
ADDRLP4 196
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 9
EQI4 $185
ADDRLP4 196
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 10
EQI4 $185
line 591
;586:				bs->ltgtype != LTG_RETURNFLAG &&
;587:				bs->ltgtype != LTG_TEAMHELP &&
;588:				bs->ltgtype != LTG_TEAMACCOMPANY &&
;589:				bs->ltgtype != LTG_CAMPORDER &&
;590:				bs->ltgtype != LTG_PATROL &&
;591:				bs->ltgtype != LTG_GETITEM) {
line 593
;592:
;593:				BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 594
;594:				bs->decisionmaker = bs->client;
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 200
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 595
;595:				bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 597
;596:				//
;597:				if (random() < 0.5) {
ADDRLP4 204
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
GEF4 $241
line 599
;598:					//go for the enemy flag
;599:					bs->ltgtype = LTG_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 4
ASGNI4
line 600
;600:				}
ADDRGP4 $242
JUMPV
LABELV $241
line 601
;601:				else {
line 602
;602:					bs->ltgtype = LTG_RETURNFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 6
ASGNI4
line 603
;603:				}
LABELV $242
line 605
;604:				//no team message
;605:				bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 607
;606:				//set the time the bot will stop getting the flag
;607:				bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 609
;608:				//get an alternative route goal towards the enemy base
;609:				BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 611
;610:				//
;611:				BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 612
;612:				bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 613
;613:			}
line 614
;614:		}
line 615
;615:		return;
ADDRGP4 $185
JUMPV
LABELV $233
line 618
;616:	}
;617:	//if both flags Not at their bases
;618:	else if (flagstatus == 3) {
ADDRLP4 0
INDIRI4
CNSTI4 3
NEI4 $243
line 620
;619:		//
;620:		if (bs->owndecision_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
GEF4 $185
line 622
;621:			// if not trying to return the flag and not following the team flag carrier
;622:			if ( bs->ltgtype != LTG_RETURNFLAG && bs->ltgtype != LTG_TEAMACCOMPANY ) {
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 6
EQI4 $185
ADDRLP4 192
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $185
line 624
;623:				//
;624:				c = BotTeamFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 BotTeamFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 156
ADDRLP4 196
INDIRI4
ASGNI4
line 626
;625:				// if there is a visible team mate flag carrier
;626:				if (c >= 0) {
ADDRLP4 156
INDIRI4
CNSTI4 0
LTI4 $249
line 627
;627:					BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 629
;628:					//follow the flag carrier
;629:					bs->decisionmaker = bs->client;
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 200
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 630
;630:					bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 632
;631:					//the team mate
;632:					bs->teammate = c;
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
ADDRLP4 156
INDIRI4
ASGNI4
line 634
;633:					//last time the team mate was visible
;634:					bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6748
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 636
;635:					//no message
;636:					bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 638
;637:					//no arrive message
;638:					bs->arrive_time = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6172
ADDP4
CNSTF4 1065353216
ASGNF4
line 641
;639:					//
;640:#ifdef MISSIONPACK
;641:					BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
ADDRLP4 204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 204
INDIRP4
ARGP4
ADDRLP4 204
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRGP4 $232
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 644
;642:#endif
;643:					//get the team goal time
;644:					bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 645
;645:					bs->ltgtype = LTG_TEAMACCOMPANY;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 2
ASGNI4
line 646
;646:					bs->formation_dist = 3.5 * 32;		//3.5 meter
ADDRFP4 0
INDIRP4
CNSTI4 7016
ADDP4
CNSTF4 1121976320
ASGNF4
line 648
;647:					//
;648:					BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 649
;649:					bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 650
;650:				}
ADDRGP4 $185
JUMPV
LABELV $249
line 651
;651:				else {
line 652
;652:					BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 653
;653:					bs->decisionmaker = bs->client;
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 200
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 654
;654:					bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 656
;655:					//get the enemy flag
;656:					bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 204
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 204
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1073741824
MULF4
ADDF4
ASGNF4
line 658
;657:					//get the flag
;658:					bs->ltgtype = LTG_RETURNFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 6
ASGNI4
line 660
;659:					//set the time the bot will stop getting the flag
;660:					bs->teamgoal_time = FloatTime() + CTF_RETURNFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 662
;661:					//get an alternative route goal towards the enemy base
;662:					BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 664
;663:					//
;664:					BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 665
;665:					bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 666
;666:				}
line 667
;667:			}
line 668
;668:		}
line 669
;669:		return;
ADDRGP4 $185
JUMPV
LABELV $243
line 672
;670:	}
;671:	// don't just do something wait for the bot team leader to give orders
;672:	if (BotTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 192
ADDRGP4 BotTeamLeader
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
EQI4 $251
line 673
;673:		return;
ADDRGP4 $185
JUMPV
LABELV $251
line 676
;674:	}
;675:	// if the bot is ordered to do something
;676:	if ( bs->lastgoal_ltgtype ) {
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $253
line 677
;677:		bs->teamgoal_time += 60;
ADDRLP4 196
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ASGNP4
ADDRLP4 196
INDIRP4
ADDRLP4 196
INDIRP4
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 678
;678:	}
LABELV $253
line 680
;679:	// if the bot decided to do something on it's own and has a last ordered goal
;680:	if ( !bs->ordered && bs->lastgoal_ltgtype ) {
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 196
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $255
ADDRLP4 196
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $255
line 681
;681:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 682
;682:	}
LABELV $255
line 684
;683:	//if already a CTF or team goal
;684:	if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 1
EQI4 $268
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $268
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 3
EQI4 $268
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
EQI4 $268
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $268
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 6
EQI4 $268
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 8
EQI4 $268
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 9
EQI4 $268
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 10
EQI4 $268
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 14
EQI4 $268
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 15
NEI4 $257
LABELV $268
line 694
;685:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;686:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;687:			bs->ltgtype == LTG_GETFLAG ||
;688:			bs->ltgtype == LTG_RUSHBASE ||
;689:			bs->ltgtype == LTG_RETURNFLAG ||
;690:			bs->ltgtype == LTG_CAMPORDER ||
;691:			bs->ltgtype == LTG_PATROL ||
;692:			bs->ltgtype == LTG_GETITEM ||
;693:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;694:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
line 695
;695:		return;
ADDRGP4 $185
JUMPV
LABELV $257
line 698
;696:	}
;697:	//
;698:	if (BotSetLastOrderedTask(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 204
ADDRGP4 BotSetLastOrderedTask
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 0
EQI4 $269
line 699
;699:		return;
ADDRGP4 $185
JUMPV
LABELV $269
line 701
;700:	//
;701:	if (bs->owndecision_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
LEF4 $271
line 702
;702:		return;;
ADDRGP4 $185
JUMPV
LABELV $271
line 704
;703:	//if the bot is roaming
;704:	if (bs->ctfroam_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6164
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $273
line 705
;705:		return;
ADDRGP4 $185
JUMPV
LABELV $273
line 707
;706:	//if the bot has anough aggression to decide what to do
;707:	if (BotAggression(bs) < 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 208
INDIRF4
CNSTF4 1112014848
GEF4 $275
line 708
;708:		return;
ADDRGP4 $185
JUMPV
LABELV $275
line 710
;709:	//set the time to send a message to the team mates
;710:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 212
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 212
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1073741824
MULF4
ADDF4
ASGNF4
line 712
;711:	//
;712:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $277
line 713
;713:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $279
line 714
;714:			l1 = 0.7f;
ADDRLP4 8
CNSTF4 1060320051
ASGNF4
line 715
;715:		}
ADDRGP4 $280
JUMPV
LABELV $279
line 716
;716:		else {
line 717
;717:			l1 = 0.2f;
ADDRLP4 8
CNSTF4 1045220557
ASGNF4
line 718
;718:		}
LABELV $280
line 719
;719:		l2 = 0.9f;
ADDRLP4 12
CNSTF4 1063675494
ASGNF4
line 720
;720:	}
ADDRGP4 $278
JUMPV
LABELV $277
line 721
;721:	else {
line 722
;722:		l1 = 0.4f;
ADDRLP4 8
CNSTF4 1053609165
ASGNF4
line 723
;723:		l2 = 0.7f;
ADDRLP4 12
CNSTF4 1060320051
ASGNF4
line 724
;724:	}
LABELV $278
line 726
;725:	//get the flag or defend the base
;726:	rnd = random();
ADDRLP4 216
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 216
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ASGNF4
line 727
;727:	if (rnd < l1 && ctf_redflag.areanum && ctf_blueflag.areanum) {
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
GEF4 $281
ADDRGP4 ctf_redflag+12
INDIRI4
CNSTI4 0
EQI4 $281
ADDRGP4 ctf_blueflag+12
INDIRI4
CNSTI4 0
EQI4 $281
line 728
;728:		bs->decisionmaker = bs->client;
ADDRLP4 220
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 220
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 220
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 729
;729:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 730
;730:		bs->ltgtype = LTG_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 4
ASGNI4
line 732
;731:		//set the time the bot will stop getting the flag
;732:		bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 734
;733:		//get an alternative route goal towards the enemy base
;734:		BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 224
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 224
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 735
;735:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 736
;736:	}
ADDRGP4 $282
JUMPV
LABELV $281
line 737
;737:	else if (rnd < l2 && ctf_redflag.areanum && ctf_blueflag.areanum) {
ADDRLP4 4
INDIRF4
ADDRLP4 12
INDIRF4
GEF4 $285
ADDRGP4 ctf_redflag+12
INDIRI4
CNSTI4 0
EQI4 $285
ADDRGP4 ctf_blueflag+12
INDIRI4
CNSTI4 0
EQI4 $285
line 738
;738:		bs->decisionmaker = bs->client;
ADDRLP4 220
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 220
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 220
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 739
;739:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 741
;740:		//
;741:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 224
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 224
INDIRI4
CNSTI4 1
NEI4 $289
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTU4 56
ARGU4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $290
JUMPV
LABELV $289
line 742
;742:		else memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTU4 56
ARGU4
ADDRGP4 memcpy
CALLP4
pop
LABELV $290
line 744
;743:		//set the ltg type
;744:		bs->ltgtype = LTG_DEFENDKEYAREA;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 3
ASGNI4
line 746
;745:		//set the time the bot stops defending the base
;746:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 747
;747:		bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6144
ADDP4
CNSTF4 0
ASGNF4
line 748
;748:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 749
;749:	}
ADDRGP4 $286
JUMPV
LABELV $285
line 750
;750:	else {
line 751
;751:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 753
;752:		//set the time the bot will stop roaming
;753:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6164
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 754
;754:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 755
;755:	}
LABELV $286
LABELV $282
line 756
;756:	bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 760
;757:#ifdef DEBUG
;758:	BotPrintTeamGoal(bs);
;759:#endif //DEBUG
;760:}
LABELV $185
endproc BotCTFSeekGoals 228 12
export BotCTFRetreatGoals
proc BotCTFRetreatGoals 8 4
line 767
;761:
;762:/*
;763:==================
;764:BotCTFRetreatGoals
;765:==================
;766:*/
;767:void BotCTFRetreatGoals(bot_state_t *bs) {
line 769
;768:	//when carrying a flag in ctf the bot should rush to the base
;769:	if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $292
line 771
;770:		//if not already rushing to the base
;771:		if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $294
line 772
;772:			BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 773
;773:			bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 5
ASGNI4
line 774
;774:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 775
;775:			bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 776
;776:			bs->decisionmaker = bs->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 777
;777:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 778
;778:			BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 779
;779:		}
LABELV $294
line 780
;780:	}
LABELV $292
line 781
;781:}
LABELV $291
endproc BotCTFRetreatGoals 8 4
export Bot1FCTFSeekGoals
proc Bot1FCTFSeekGoals 200 12
line 789
;782:
;783:#ifdef MISSIONPACK
;784:/*
;785:==================
;786:Bot1FCTFSeekGoals
;787:==================
;788:*/
;789:void Bot1FCTFSeekGoals(bot_state_t *bs) {
line 795
;790:	aas_entityinfo_t entinfo;
;791:	float rnd, l1, l2;
;792:	int c;
;793:
;794:	//when carrying a flag in ctf the bot should rush to the base
;795:	if (Bot1FCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 156
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $297
line 797
;796:		//if not already rushing to the base
;797:		if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $296
line 798
;798:			BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 799
;799:			bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 5
ASGNI4
line 800
;800:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 801
;801:			bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 802
;802:			bs->decisionmaker = bs->client;
ADDRLP4 160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 160
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 803
;803:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 805
;804:			//get an alternative route goal towards the enemy base
;805:			BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 807
;806:			//
;807:			BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 809
;808:#ifdef MISSIONPACK
;809:			BotVoiceChat(bs, -1, VOICECHAT_IHAVEFLAG);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $207
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 811
;810:#endif
;811:		}
line 812
;812:		return;
ADDRGP4 $296
JUMPV
LABELV $297
line 815
;813:	}
;814:	// if the bot decided to follow someone
;815:	if ( bs->ltgtype == LTG_TEAMACCOMPANY && !bs->ordered ) {
ADDRLP4 160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
NEI4 $301
ADDRLP4 160
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $301
line 817
;816:		// if the team mate being accompanied no longer carries the flag
;817:		BotEntityInfo(bs->teammate, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 818
;818:		if (!EntityCarriesFlag(&entinfo)) {
ADDRLP4 12
ARGP4
ADDRLP4 164
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
NEI4 $303
line 819
;819:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 820
;820:		}
LABELV $303
line 821
;821:	}
LABELV $301
line 823
;822:	//our team has the flag
;823:	if (bs->neutralflagstatus == 1) {
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
INDIRI4
CNSTI4 1
NEI4 $305
line 824
;824:		if (bs->owndecision_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
GEF4 $296
line 826
;825:			// if not already following someone
;826:			if (bs->ltgtype != LTG_TEAMACCOMPANY) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $309
line 828
;827:				//if there is a visible team mate flag carrier
;828:				c = BotTeamFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 BotTeamFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 152
ADDRLP4 164
INDIRI4
ASGNI4
line 829
;829:				if (c >= 0) {
ADDRLP4 152
INDIRI4
CNSTI4 0
LTI4 $311
line 830
;830:					BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 832
;831:					//follow the flag carrier
;832:					bs->decisionmaker = bs->client;
ADDRLP4 168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 168
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 168
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 833
;833:					bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 835
;834:					//the team mate
;835:					bs->teammate = c;
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
ADDRLP4 152
INDIRI4
ASGNI4
line 837
;836:					//last time the team mate was visible
;837:					bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6748
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 839
;838:					//no message
;839:					bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 841
;840:					//no arrive message
;841:					bs->arrive_time = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6172
ADDP4
CNSTF4 1065353216
ASGNF4
line 844
;842:					//
;843:#ifdef MISSIONPACK
;844:					BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
ADDRLP4 172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 172
INDIRP4
ARGP4
ADDRLP4 172
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRGP4 $232
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 847
;845:#endif
;846:					//get the team goal time
;847:					bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 848
;848:					bs->ltgtype = LTG_TEAMACCOMPANY;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 2
ASGNI4
line 849
;849:					bs->formation_dist = 3.5 * 32;		//3.5 meter
ADDRFP4 0
INDIRP4
CNSTI4 7016
ADDP4
CNSTF4 1121976320
ASGNF4
line 850
;850:					BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 851
;851:					bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 852
;852:					return;
ADDRGP4 $296
JUMPV
LABELV $311
line 854
;853:				}
;854:			}
LABELV $309
line 856
;855:			//if already a CTF or team goal
;856:			if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 164
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 1
EQI4 $324
ADDRLP4 164
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $324
ADDRLP4 164
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 3
EQI4 $324
ADDRLP4 164
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
EQI4 $324
ADDRLP4 164
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $324
ADDRLP4 164
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 8
EQI4 $324
ADDRLP4 164
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 9
EQI4 $324
ADDRLP4 164
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 13
EQI4 $324
ADDRLP4 164
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 10
EQI4 $324
ADDRLP4 164
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 14
EQI4 $324
ADDRLP4 164
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 15
NEI4 $313
LABELV $324
line 866
;857:					bs->ltgtype == LTG_TEAMACCOMPANY ||
;858:					bs->ltgtype == LTG_DEFENDKEYAREA ||
;859:					bs->ltgtype == LTG_GETFLAG ||
;860:					bs->ltgtype == LTG_RUSHBASE ||
;861:					bs->ltgtype == LTG_CAMPORDER ||
;862:					bs->ltgtype == LTG_PATROL ||
;863:					bs->ltgtype == LTG_ATTACKENEMYBASE ||
;864:					bs->ltgtype == LTG_GETITEM ||
;865:					bs->ltgtype == LTG_MAKELOVE_UNDER ||
;866:					bs->ltgtype == LTG_MAKELOVE_ONTOP) {
line 867
;867:				return;
ADDRGP4 $296
JUMPV
LABELV $313
line 870
;868:			}
;869:			//if not already attacking the enemy base
;870:			if (bs->ltgtype != LTG_ATTACKENEMYBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 13
EQI4 $296
line 871
;871:				BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 872
;872:				bs->decisionmaker = bs->client;
ADDRLP4 168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 168
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 168
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 873
;873:				bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 875
;874:				//
;875:				if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 172
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 1
NEI4 $327
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTU4 56
ARGU4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $328
JUMPV
LABELV $327
line 876
;876:				else memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTU4 56
ARGU4
ADDRGP4 memcpy
CALLP4
pop
LABELV $328
line 878
;877:				//set the ltg type
;878:				bs->ltgtype = LTG_ATTACKENEMYBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 13
ASGNI4
line 880
;879:				//set the time the bot will stop getting the flag
;880:				bs->teamgoal_time = FloatTime() + TEAM_ATTACKENEMYBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 881
;881:				BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 882
;882:				bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 883
;883:			}
line 884
;884:		}
line 885
;885:		return;
ADDRGP4 $296
JUMPV
LABELV $305
line 888
;886:	}
;887:	//enemy team has the flag
;888:	else if (bs->neutralflagstatus == 2) {
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
INDIRI4
CNSTI4 2
NEI4 $329
line 889
;889:		if (bs->owndecision_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
GEF4 $296
line 890
;890:			c = BotEnemyFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 BotEnemyFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 152
ADDRLP4 164
INDIRI4
ASGNI4
line 891
;891:			if (c >= 0) {
ADDRLP4 152
INDIRI4
CNSTI4 0
LTI4 $333
line 893
;892:				//FIXME: attack enemy flag carrier
;893:			}
LABELV $333
line 895
;894:			//if already a CTF or team goal
;895:			if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 1
EQI4 $340
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $340
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 8
EQI4 $340
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 9
EQI4 $340
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 10
NEI4 $335
LABELV $340
line 899
;896:					bs->ltgtype == LTG_TEAMACCOMPANY ||
;897:					bs->ltgtype == LTG_CAMPORDER ||
;898:					bs->ltgtype == LTG_PATROL ||
;899:					bs->ltgtype == LTG_GETITEM) {
line 900
;900:				return;
ADDRGP4 $296
JUMPV
LABELV $335
line 903
;901:			}
;902:			// if not already defending the base
;903:			if (bs->ltgtype != LTG_DEFENDKEYAREA) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 3
EQI4 $296
line 904
;904:				BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 905
;905:				bs->decisionmaker = bs->client;
ADDRLP4 172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 172
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 172
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 906
;906:				bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 908
;907:				//
;908:				if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 176
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 1
NEI4 $343
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTU4 56
ARGU4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $344
JUMPV
LABELV $343
line 909
;909:				else memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTU4 56
ARGU4
ADDRGP4 memcpy
CALLP4
pop
LABELV $344
line 911
;910:				//set the ltg type
;911:				bs->ltgtype = LTG_DEFENDKEYAREA;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 3
ASGNI4
line 913
;912:				//set the time the bot stops defending the base
;913:				bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 914
;914:				bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6144
ADDP4
CNSTF4 0
ASGNF4
line 915
;915:				BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 916
;916:				bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 917
;917:			}
line 918
;918:		}
line 919
;919:		return;
ADDRGP4 $296
JUMPV
LABELV $329
line 922
;920:	}
;921:	// don't just do something wait for the bot team leader to give orders
;922:	if (BotTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 BotTeamLeader
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
EQI4 $345
line 923
;923:		return;
ADDRGP4 $296
JUMPV
LABELV $345
line 926
;924:	}
;925:	// if the bot is ordered to do something
;926:	if ( bs->lastgoal_ltgtype ) {
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $347
line 927
;927:		bs->teamgoal_time += 60;
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ASGNP4
ADDRLP4 168
INDIRP4
ADDRLP4 168
INDIRP4
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 928
;928:	}
LABELV $347
line 930
;929:	// if the bot decided to do something on it's own and has a last ordered goal
;930:	if ( !bs->ordered && bs->lastgoal_ltgtype ) {
ADDRLP4 168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 168
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $349
ADDRLP4 168
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $349
line 931
;931:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 932
;932:	}
LABELV $349
line 934
;933:	//if already a CTF or team goal
;934:	if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 172
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 1
EQI4 $363
ADDRLP4 172
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $363
ADDRLP4 172
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 3
EQI4 $363
ADDRLP4 172
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
EQI4 $363
ADDRLP4 172
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $363
ADDRLP4 172
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 6
EQI4 $363
ADDRLP4 172
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 8
EQI4 $363
ADDRLP4 172
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 9
EQI4 $363
ADDRLP4 172
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 13
EQI4 $363
ADDRLP4 172
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 10
EQI4 $363
ADDRLP4 172
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 14
EQI4 $363
ADDRLP4 172
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 15
NEI4 $351
LABELV $363
line 945
;935:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;936:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;937:			bs->ltgtype == LTG_GETFLAG ||
;938:			bs->ltgtype == LTG_RUSHBASE ||
;939:			bs->ltgtype == LTG_RETURNFLAG ||
;940:			bs->ltgtype == LTG_CAMPORDER ||
;941:			bs->ltgtype == LTG_PATROL ||
;942:			bs->ltgtype == LTG_ATTACKENEMYBASE ||
;943:			bs->ltgtype == LTG_GETITEM ||
;944:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;945:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
line 946
;946:		return;
ADDRGP4 $296
JUMPV
LABELV $351
line 949
;947:	}
;948:	//
;949:	if (BotSetLastOrderedTask(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 176
ADDRGP4 BotSetLastOrderedTask
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
EQI4 $364
line 950
;950:		return;
ADDRGP4 $296
JUMPV
LABELV $364
line 952
;951:	//
;952:	if (bs->owndecision_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
LEF4 $366
line 953
;953:		return;;
ADDRGP4 $296
JUMPV
LABELV $366
line 955
;954:	//if the bot is roaming
;955:	if (bs->ctfroam_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6164
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $368
line 956
;956:		return;
ADDRGP4 $296
JUMPV
LABELV $368
line 958
;957:	//if the bot has anough aggression to decide what to do
;958:	if (BotAggression(bs) < 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 180
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 180
INDIRF4
CNSTF4 1112014848
GEF4 $370
line 959
;959:		return;
ADDRGP4 $296
JUMPV
LABELV $370
line 961
;960:	//set the time to send a message to the team mates
;961:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 184
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 184
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1073741824
MULF4
ADDF4
ASGNF4
line 963
;962:	//
;963:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $372
line 964
;964:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $374
line 965
;965:			l1 = 0.7f;
ADDRLP4 4
CNSTF4 1060320051
ASGNF4
line 966
;966:		}
ADDRGP4 $375
JUMPV
LABELV $374
line 967
;967:		else {
line 968
;968:			l1 = 0.2f;
ADDRLP4 4
CNSTF4 1045220557
ASGNF4
line 969
;969:		}
LABELV $375
line 970
;970:		l2 = 0.9f;
ADDRLP4 8
CNSTF4 1063675494
ASGNF4
line 971
;971:	}
ADDRGP4 $373
JUMPV
LABELV $372
line 972
;972:	else {
line 973
;973:		l1 = 0.4f;
ADDRLP4 4
CNSTF4 1053609165
ASGNF4
line 974
;974:		l2 = 0.7f;
ADDRLP4 8
CNSTF4 1060320051
ASGNF4
line 975
;975:	}
LABELV $373
line 977
;976:	//get the flag or defend the base
;977:	rnd = random();
ADDRLP4 188
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 188
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ASGNF4
line 978
;978:	if (rnd < l1 && ctf_neutralflag.areanum) {
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
GEF4 $376
ADDRGP4 ctf_neutralflag+12
INDIRI4
CNSTI4 0
EQI4 $376
line 979
;979:		bs->decisionmaker = bs->client;
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 192
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 980
;980:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 981
;981:		bs->ltgtype = LTG_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 4
ASGNI4
line 983
;982:		//set the time the bot will stop getting the flag
;983:		bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 984
;984:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 985
;985:	}
ADDRGP4 $377
JUMPV
LABELV $376
line 986
;986:	else if (rnd < l2 && ctf_redflag.areanum && ctf_blueflag.areanum) {
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRF4
GEF4 $379
ADDRGP4 ctf_redflag+12
INDIRI4
CNSTI4 0
EQI4 $379
ADDRGP4 ctf_blueflag+12
INDIRI4
CNSTI4 0
EQI4 $379
line 987
;987:		bs->decisionmaker = bs->client;
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 192
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 988
;988:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 990
;989:		//
;990:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 1
NEI4 $383
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTU4 56
ARGU4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $384
JUMPV
LABELV $383
line 991
;991:		else memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTU4 56
ARGU4
ADDRGP4 memcpy
CALLP4
pop
LABELV $384
line 993
;992:		//set the ltg type
;993:		bs->ltgtype = LTG_DEFENDKEYAREA;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 3
ASGNI4
line 995
;994:		//set the time the bot stops defending the base
;995:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 996
;996:		bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6144
ADDP4
CNSTF4 0
ASGNF4
line 997
;997:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 998
;998:	}
ADDRGP4 $380
JUMPV
LABELV $379
line 999
;999:	else {
line 1000
;1000:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 1002
;1001:		//set the time the bot will stop roaming
;1002:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6164
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 1003
;1003:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1004
;1004:	}
LABELV $380
LABELV $377
line 1005
;1005:	bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 1009
;1006:#ifdef DEBUG
;1007:	BotPrintTeamGoal(bs);
;1008:#endif //DEBUG
;1009:}
LABELV $296
endproc Bot1FCTFSeekGoals 200 12
export Bot1FCTFRetreatGoals
proc Bot1FCTFRetreatGoals 12 8
line 1016
;1010:
;1011:/*
;1012:==================
;1013:Bot1FCTFRetreatGoals
;1014:==================
;1015:*/
;1016:void Bot1FCTFRetreatGoals(bot_state_t *bs) {
line 1018
;1017:	//when carrying a flag in ctf the bot should rush to the enemy base
;1018:	if (Bot1FCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $386
line 1020
;1019:		//if not already rushing to the base
;1020:		if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $388
line 1021
;1021:			BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 1022
;1022:			bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 5
ASGNI4
line 1023
;1023:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 1024
;1024:			bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 1025
;1025:			bs->decisionmaker = bs->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1026
;1026:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 1028
;1027:			//get an alternative route goal towards the enemy base
;1028:			BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 1029
;1029:			BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1030
;1030:		}
LABELV $388
line 1031
;1031:	}
LABELV $386
line 1032
;1032:}
LABELV $385
endproc Bot1FCTFRetreatGoals 12 8
export BotObeliskSeekGoals
proc BotObeliskSeekGoals 48 12
line 1039
;1033:
;1034:/*
;1035:==================
;1036:BotObeliskSeekGoals
;1037:==================
;1038:*/
;1039:void BotObeliskSeekGoals(bot_state_t *bs) {
line 1043
;1040:	float rnd, l1, l2;
;1041:
;1042:	// don't just do something wait for the bot team leader to give orders
;1043:	if (BotTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 BotTeamLeader
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $391
line 1044
;1044:		return;
ADDRGP4 $390
JUMPV
LABELV $391
line 1047
;1045:	}
;1046:	// if the bot is ordered to do something
;1047:	if ( bs->lastgoal_ltgtype ) {
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $393
line 1048
;1048:		bs->teamgoal_time += 60;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 1049
;1049:	}
LABELV $393
line 1051
;1050:	//if already a team goal
;1051:	if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 1
EQI4 $407
ADDRLP4 16
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $407
ADDRLP4 16
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 3
EQI4 $407
ADDRLP4 16
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
EQI4 $407
ADDRLP4 16
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $407
ADDRLP4 16
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 6
EQI4 $407
ADDRLP4 16
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 8
EQI4 $407
ADDRLP4 16
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 9
EQI4 $407
ADDRLP4 16
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 13
EQI4 $407
ADDRLP4 16
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 10
EQI4 $407
ADDRLP4 16
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 14
EQI4 $407
ADDRLP4 16
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 15
NEI4 $395
LABELV $407
line 1062
;1052:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;1053:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;1054:			bs->ltgtype == LTG_GETFLAG ||
;1055:			bs->ltgtype == LTG_RUSHBASE ||
;1056:			bs->ltgtype == LTG_RETURNFLAG ||
;1057:			bs->ltgtype == LTG_CAMPORDER ||
;1058:			bs->ltgtype == LTG_PATROL ||
;1059:			bs->ltgtype == LTG_ATTACKENEMYBASE ||
;1060:			bs->ltgtype == LTG_GETITEM ||
;1061:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;1062:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
line 1063
;1063:		return;
ADDRGP4 $390
JUMPV
LABELV $395
line 1066
;1064:	}
;1065:	//
;1066:	if (BotSetLastOrderedTask(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 BotSetLastOrderedTask
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $408
line 1067
;1067:		return;
ADDRGP4 $390
JUMPV
LABELV $408
line 1069
;1068:	//if the bot is roaming
;1069:	if (bs->ctfroam_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6164
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $410
line 1070
;1070:		return;
ADDRGP4 $390
JUMPV
LABELV $410
line 1072
;1071:	//if the bot has anough aggression to decide what to do
;1072:	if (BotAggression(bs) < 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 24
INDIRF4
CNSTF4 1112014848
GEF4 $412
line 1073
;1073:		return;
ADDRGP4 $390
JUMPV
LABELV $412
line 1075
;1074:	//set the time to send a message to the team mates
;1075:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 28
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 28
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1073741824
MULF4
ADDF4
ASGNF4
line 1077
;1076:	//
;1077:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $414
line 1078
;1078:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $416
line 1079
;1079:			l1 = 0.7f;
ADDRLP4 4
CNSTF4 1060320051
ASGNF4
line 1080
;1080:		}
ADDRGP4 $417
JUMPV
LABELV $416
line 1081
;1081:		else {
line 1082
;1082:			l1 = 0.2f;
ADDRLP4 4
CNSTF4 1045220557
ASGNF4
line 1083
;1083:		}
LABELV $417
line 1084
;1084:		l2 = 0.9f;
ADDRLP4 8
CNSTF4 1063675494
ASGNF4
line 1085
;1085:	}
ADDRGP4 $415
JUMPV
LABELV $414
line 1086
;1086:	else {
line 1087
;1087:		l1 = 0.4f;
ADDRLP4 4
CNSTF4 1053609165
ASGNF4
line 1088
;1088:		l2 = 0.7f;
ADDRLP4 8
CNSTF4 1060320051
ASGNF4
line 1089
;1089:	}
LABELV $415
line 1091
;1090:	//get the flag or defend the base
;1091:	rnd = random();
ADDRLP4 32
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 32
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ASGNF4
line 1092
;1092:	if (rnd < l1 && redobelisk.areanum && blueobelisk.areanum) {
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
GEF4 $418
ADDRGP4 redobelisk+12
INDIRI4
CNSTI4 0
EQI4 $418
ADDRGP4 blueobelisk+12
INDIRI4
CNSTI4 0
EQI4 $418
line 1093
;1093:		bs->decisionmaker = bs->client;
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1094
;1094:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 1096
;1095:		//
;1096:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 1
NEI4 $422
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 blueobelisk
ARGP4
CNSTU4 56
ARGU4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $423
JUMPV
LABELV $422
line 1097
;1097:		else memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 redobelisk
ARGP4
CNSTU4 56
ARGU4
ADDRGP4 memcpy
CALLP4
pop
LABELV $423
line 1099
;1098:		//set the ltg type
;1099:		bs->ltgtype = LTG_ATTACKENEMYBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 13
ASGNI4
line 1101
;1100:		//set the time the bot will stop attacking the enemy base
;1101:		bs->teamgoal_time = FloatTime() + TEAM_ATTACKENEMYBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 1103
;1102:		//get an alternate route goal towards the enemy base
;1103:		BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 1104
;1104:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1105
;1105:	}
ADDRGP4 $419
JUMPV
LABELV $418
line 1106
;1106:	else if (rnd < l2 && redobelisk.areanum && blueobelisk.areanum) {
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRF4
GEF4 $424
ADDRGP4 redobelisk+12
INDIRI4
CNSTI4 0
EQI4 $424
ADDRGP4 blueobelisk+12
INDIRI4
CNSTI4 0
EQI4 $424
line 1107
;1107:		bs->decisionmaker = bs->client;
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1108
;1108:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 1110
;1109:		//
;1110:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 1
NEI4 $428
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 redobelisk
ARGP4
CNSTU4 56
ARGU4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $429
JUMPV
LABELV $428
line 1111
;1111:		else memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 blueobelisk
ARGP4
CNSTU4 56
ARGU4
ADDRGP4 memcpy
CALLP4
pop
LABELV $429
line 1113
;1112:		//set the ltg type
;1113:		bs->ltgtype = LTG_DEFENDKEYAREA;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 3
ASGNI4
line 1115
;1114:		//set the time the bot stops defending the base
;1115:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 1116
;1116:		bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6144
ADDP4
CNSTF4 0
ASGNF4
line 1117
;1117:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1118
;1118:	}
ADDRGP4 $425
JUMPV
LABELV $424
line 1119
;1119:	else {
line 1120
;1120:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 1122
;1121:		//set the time the bot will stop roaming
;1122:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6164
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 1123
;1123:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1124
;1124:	}
LABELV $425
LABELV $419
line 1125
;1125:}
LABELV $390
endproc BotObeliskSeekGoals 48 12
export BotGoHarvest
proc BotGoHarvest 4 12
line 1132
;1126:
;1127:/*
;1128:==================
;1129:BotGoHarvest
;1130:==================
;1131:*/
;1132:void BotGoHarvest(bot_state_t *bs) {
line 1134
;1133:	//
;1134:	if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $431
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 blueobelisk
ARGP4
CNSTU4 56
ARGU4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $432
JUMPV
LABELV $431
line 1135
;1135:	else memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 redobelisk
ARGP4
CNSTU4 56
ARGU4
ADDRGP4 memcpy
CALLP4
pop
LABELV $432
line 1137
;1136:	//set the ltg type
;1137:	bs->ltgtype = LTG_HARVEST;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 12
ASGNI4
line 1139
;1138:	//set the time the bot will stop harvesting
;1139:	bs->teamgoal_time = FloatTime() + TEAM_HARVEST_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 1140
;1140:	bs->harvestaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6160
ADDP4
CNSTF4 0
ASGNF4
line 1141
;1141:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1142
;1142:}
LABELV $430
endproc BotGoHarvest 4 12
export BotObeliskRetreatGoals
proc BotObeliskRetreatGoals 0 0
line 1149
;1143:
;1144:/*
;1145:==================
;1146:BotObeliskRetreatGoals
;1147:==================
;1148:*/
;1149:void BotObeliskRetreatGoals(bot_state_t *bs) {
line 1151
;1150:	//nothing special
;1151:}
LABELV $433
endproc BotObeliskRetreatGoals 0 0
export BotHarvesterSeekGoals
proc BotHarvesterSeekGoals 200 12
line 1158
;1152:
;1153:/*
;1154:==================
;1155:BotHarvesterSeekGoals
;1156:==================
;1157:*/
;1158:void BotHarvesterSeekGoals(bot_state_t *bs) {
line 1164
;1159:	aas_entityinfo_t entinfo;
;1160:	float rnd, l1, l2;
;1161:	int c;
;1162:
;1163:	//when carrying cubes in harvester the bot should rush to the base
;1164:	if (BotHarvesterCarryingCubes(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 156
ADDRGP4 BotHarvesterCarryingCubes
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $435
line 1166
;1165:		//if not already rushing to the base
;1166:		if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $434
line 1167
;1167:			BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 1168
;1168:			bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 5
ASGNI4
line 1169
;1169:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 1170
;1170:			bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 1171
;1171:			bs->decisionmaker = bs->client;
ADDRLP4 160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 160
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1172
;1172:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 1174
;1173:			//get an alternative route goal towards the enemy base
;1174:			BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 1176
;1175:			//
;1176:			BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1177
;1177:		}
line 1178
;1178:		return;
ADDRGP4 $434
JUMPV
LABELV $435
line 1181
;1179:	}
;1180:	// don't just do something wait for the bot team leader to give orders
;1181:	if (BotTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 160
ADDRGP4 BotTeamLeader
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
EQI4 $439
line 1182
;1182:		return;
ADDRGP4 $434
JUMPV
LABELV $439
line 1185
;1183:	}
;1184:	// if the bot decided to follow someone
;1185:	if ( bs->ltgtype == LTG_TEAMACCOMPANY && !bs->ordered ) {
ADDRLP4 164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 164
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
NEI4 $441
ADDRLP4 164
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $441
line 1187
;1186:		// if the team mate being accompanied no longer carries the flag
;1187:		BotEntityInfo(bs->teammate, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1188
;1188:		if (!EntityCarriesCubes(&entinfo)) {
ADDRLP4 16
ARGP4
ADDRLP4 168
ADDRGP4 EntityCarriesCubes
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
NEI4 $443
line 1189
;1189:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 1190
;1190:		}
LABELV $443
line 1191
;1191:	}
LABELV $441
line 1193
;1192:	// if the bot is ordered to do something
;1193:	if ( bs->lastgoal_ltgtype ) {
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $445
line 1194
;1194:		bs->teamgoal_time += 60;
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ASGNP4
ADDRLP4 168
INDIRP4
ADDRLP4 168
INDIRP4
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 1195
;1195:	}
LABELV $445
line 1197
;1196:	//if not yet doing something
;1197:	if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 1
EQI4 $458
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $458
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 3
EQI4 $458
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
EQI4 $458
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 8
EQI4 $458
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 9
EQI4 $458
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 13
EQI4 $458
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 12
EQI4 $458
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 10
EQI4 $458
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 14
EQI4 $458
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 15
NEI4 $447
LABELV $458
line 1207
;1198:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;1199:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;1200:			bs->ltgtype == LTG_GETFLAG ||
;1201:			bs->ltgtype == LTG_CAMPORDER ||
;1202:			bs->ltgtype == LTG_PATROL ||
;1203:			bs->ltgtype == LTG_ATTACKENEMYBASE ||
;1204:			bs->ltgtype == LTG_HARVEST ||
;1205:			bs->ltgtype == LTG_GETITEM ||
;1206:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;1207:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
line 1208
;1208:		return;
ADDRGP4 $434
JUMPV
LABELV $447
line 1211
;1209:	}
;1210:	//
;1211:	if (BotSetLastOrderedTask(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 172
ADDRGP4 BotSetLastOrderedTask
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
EQI4 $459
line 1212
;1212:		return;
ADDRGP4 $434
JUMPV
LABELV $459
line 1214
;1213:	//if the bot is roaming
;1214:	if (bs->ctfroam_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6164
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $461
line 1215
;1215:		return;
ADDRGP4 $434
JUMPV
LABELV $461
line 1217
;1216:	//if the bot has anough aggression to decide what to do
;1217:	if (BotAggression(bs) < 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 176
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 176
INDIRF4
CNSTF4 1112014848
GEF4 $463
line 1218
;1218:		return;
ADDRGP4 $434
JUMPV
LABELV $463
line 1220
;1219:	//set the time to send a message to the team mates
;1220:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 180
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 180
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1073741824
MULF4
ADDF4
ASGNF4
line 1222
;1221:	//
;1222:	c = BotEnemyCubeCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 184
ADDRGP4 BotEnemyCubeCarrierVisible
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 184
INDIRI4
ASGNI4
line 1223
;1223:	if (c >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $465
line 1225
;1224:		//FIXME: attack enemy cube carrier
;1225:	}
LABELV $465
line 1226
;1226:	if (bs->ltgtype != LTG_TEAMACCOMPANY) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $467
line 1228
;1227:		//if there is a visible team mate carrying cubes
;1228:		c = BotTeamCubeCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 188
ADDRGP4 BotTeamCubeCarrierVisible
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 188
INDIRI4
ASGNI4
line 1229
;1229:		if (c >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $469
line 1231
;1230:			//follow the team mate carrying cubes
;1231:			bs->decisionmaker = bs->client;
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 192
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1232
;1232:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 1234
;1233:			//the team mate
;1234:			bs->teammate = c;
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1236
;1235:			//last time the team mate was visible
;1236:			bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6748
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1238
;1237:			//no message
;1238:			bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 1240
;1239:			//no arrive message
;1240:			bs->arrive_time = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6172
ADDP4
CNSTF4 1065353216
ASGNF4
line 1243
;1241:			//
;1242:#ifdef MISSIONPACK
;1243:			BotVoiceChat(bs, bs->teammate, VOICECHAT_ONFOLLOW);
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 196
INDIRP4
ARGP4
ADDRLP4 196
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRGP4 $232
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 1246
;1244:#endif
;1245:			//get the team goal time
;1246:			bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 1247
;1247:			bs->ltgtype = LTG_TEAMACCOMPANY;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 2
ASGNI4
line 1248
;1248:			bs->formation_dist = 3.5 * 32;		//3.5 meter
ADDRFP4 0
INDIRP4
CNSTI4 7016
ADDP4
CNSTF4 1121976320
ASGNF4
line 1249
;1249:			BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1250
;1250:			return;
ADDRGP4 $434
JUMPV
LABELV $469
line 1252
;1251:		}
;1252:	}
LABELV $467
line 1254
;1253:	//
;1254:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $471
line 1255
;1255:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $473
line 1256
;1256:			l1 = 0.7f;
ADDRLP4 8
CNSTF4 1060320051
ASGNF4
line 1257
;1257:		}
ADDRGP4 $474
JUMPV
LABELV $473
line 1258
;1258:		else {
line 1259
;1259:			l1 = 0.2f;
ADDRLP4 8
CNSTF4 1045220557
ASGNF4
line 1260
;1260:		}
LABELV $474
line 1261
;1261:		l2 = 0.9f;
ADDRLP4 12
CNSTF4 1063675494
ASGNF4
line 1262
;1262:	}
ADDRGP4 $472
JUMPV
LABELV $471
line 1263
;1263:	else {
line 1264
;1264:		l1 = 0.4f;
ADDRLP4 8
CNSTF4 1053609165
ASGNF4
line 1265
;1265:		l2 = 0.7f;
ADDRLP4 12
CNSTF4 1060320051
ASGNF4
line 1266
;1266:	}
LABELV $472
line 1268
;1267:	//
;1268:	rnd = random();
ADDRLP4 188
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 188
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ASGNF4
line 1269
;1269:	if (rnd < l1 && redobelisk.areanum && blueobelisk.areanum) {
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
GEF4 $475
ADDRGP4 redobelisk+12
INDIRI4
CNSTI4 0
EQI4 $475
ADDRGP4 blueobelisk+12
INDIRI4
CNSTI4 0
EQI4 $475
line 1270
;1270:		bs->decisionmaker = bs->client;
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 192
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1271
;1271:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 1272
;1272:		BotGoHarvest(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotGoHarvest
CALLV
pop
line 1273
;1273:	}
ADDRGP4 $476
JUMPV
LABELV $475
line 1274
;1274:	else if (rnd < l2 && redobelisk.areanum && blueobelisk.areanum) {
ADDRLP4 4
INDIRF4
ADDRLP4 12
INDIRF4
GEF4 $479
ADDRGP4 redobelisk+12
INDIRI4
CNSTI4 0
EQI4 $479
ADDRGP4 blueobelisk+12
INDIRI4
CNSTI4 0
EQI4 $479
line 1275
;1275:		bs->decisionmaker = bs->client;
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 192
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1276
;1276:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 1278
;1277:		//
;1278:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 1
NEI4 $483
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 redobelisk
ARGP4
CNSTU4 56
ARGU4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $484
JUMPV
LABELV $483
line 1279
;1279:		else memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 blueobelisk
ARGP4
CNSTU4 56
ARGU4
ADDRGP4 memcpy
CALLP4
pop
LABELV $484
line 1281
;1280:		//set the ltg type
;1281:		bs->ltgtype = LTG_DEFENDKEYAREA;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 3
ASGNI4
line 1283
;1282:		//set the time the bot stops defending the base
;1283:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 1284
;1284:		bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6144
ADDP4
CNSTF4 0
ASGNF4
line 1285
;1285:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1286
;1286:	}
ADDRGP4 $480
JUMPV
LABELV $479
line 1287
;1287:	else {
line 1288
;1288:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 1290
;1289:		//set the time the bot will stop roaming
;1290:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6164
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 1291
;1291:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1292
;1292:	}
LABELV $480
LABELV $476
line 1293
;1293:}
LABELV $434
endproc BotHarvesterSeekGoals 200 12
export BotHarvesterRetreatGoals
proc BotHarvesterRetreatGoals 8 4
line 1300
;1294:
;1295:/*
;1296:==================
;1297:BotHarvesterRetreatGoals
;1298:==================
;1299:*/
;1300:void BotHarvesterRetreatGoals(bot_state_t *bs) {
line 1302
;1301:	//when carrying cubes in harvester the bot should rush to the base
;1302:	if (BotHarvesterCarryingCubes(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotHarvesterCarryingCubes
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $486
line 1304
;1303:		//if not already rushing to the base
;1304:		if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $485
line 1305
;1305:			BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 1306
;1306:			bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 5
ASGNI4
line 1307
;1307:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 1308
;1308:			bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 1309
;1309:			bs->decisionmaker = bs->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1310
;1310:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 1311
;1311:			BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1312
;1312:		}
line 1313
;1313:		return;
LABELV $486
line 1315
;1314:	}
;1315:}
LABELV $485
endproc BotHarvesterRetreatGoals 8 4
export BotTeamGoals
proc BotTeamGoals 0 4
line 1323
;1316:#endif
;1317:
;1318:/*
;1319:==================
;1320:BotTeamGoals
;1321:==================
;1322:*/
;1323:void BotTeamGoals(bot_state_t *bs, int retreat) {
line 1325
;1324:
;1325:	if ( retreat ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $491
line 1326
;1326:		if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $493
line 1327
;1327:			BotCTFRetreatGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFRetreatGoals
CALLV
pop
line 1328
;1328:		}
ADDRGP4 $492
JUMPV
LABELV $493
line 1330
;1329:#ifdef MISSIONPACK
;1330:		else if (gametype == GT_1FCTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $495
line 1331
;1331:			Bot1FCTFRetreatGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Bot1FCTFRetreatGoals
CALLV
pop
line 1332
;1332:		}
ADDRGP4 $492
JUMPV
LABELV $495
line 1333
;1333:		else if (gametype == GT_OBELISK) {
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $497
line 1334
;1334:			BotObeliskRetreatGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotObeliskRetreatGoals
CALLV
pop
line 1335
;1335:		}
ADDRGP4 $492
JUMPV
LABELV $497
line 1336
;1336:		else if (gametype == GT_HARVESTER) {
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $492
line 1337
;1337:			BotHarvesterRetreatGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotHarvesterRetreatGoals
CALLV
pop
line 1338
;1338:		}
line 1340
;1339:#endif
;1340:	}
ADDRGP4 $492
JUMPV
LABELV $491
line 1341
;1341:	else {
line 1342
;1342:		if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $501
line 1344
;1343:			//decide what to do in CTF mode
;1344:			BotCTFSeekGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFSeekGoals
CALLV
pop
line 1345
;1345:		}
ADDRGP4 $502
JUMPV
LABELV $501
line 1347
;1346:#ifdef MISSIONPACK
;1347:		else if (gametype == GT_1FCTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $503
line 1348
;1348:			Bot1FCTFSeekGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Bot1FCTFSeekGoals
CALLV
pop
line 1349
;1349:		}
ADDRGP4 $504
JUMPV
LABELV $503
line 1350
;1350:		else if (gametype == GT_OBELISK) {
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $505
line 1351
;1351:			BotObeliskSeekGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotObeliskSeekGoals
CALLV
pop
line 1352
;1352:		}
ADDRGP4 $506
JUMPV
LABELV $505
line 1353
;1353:		else if (gametype == GT_HARVESTER) {
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $507
line 1354
;1354:			BotHarvesterSeekGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotHarvesterSeekGoals
CALLV
pop
line 1355
;1355:		}
LABELV $507
LABELV $506
LABELV $504
LABELV $502
line 1357
;1356:#endif
;1357:	}
LABELV $492
line 1360
;1358:	// reset the order time which is used to see if
;1359:	// we decided to refuse an order
;1360:	bs->order_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
CNSTF4 0
ASGNF4
line 1361
;1361:}
LABELV $490
endproc BotTeamGoals 0 4
export BotPointAreaNum
proc BotPointAreaNum 68 20
line 1368
;1362:
;1363:/*
;1364:==================
;1365:BotPointAreaNum
;1366:==================
;1367:*/
;1368:int BotPointAreaNum(vec3_t origin) {
line 1372
;1369:	int areanum, numareas, areas[10];
;1370:	vec3_t end;
;1371:
;1372:	areanum = trap_AAS_PointAreaNum(origin);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 trap_AAS_PointAreaNum
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 60
INDIRI4
ASGNI4
line 1373
;1373:	if (areanum) return areanum;
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $510
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $509
JUMPV
LABELV $510
line 1374
;1374:	VectorCopy(origin, end);
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 1375
;1375:	end[2] += 10;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 1376
;1376:	numareas = trap_AAS_TraceAreas(origin, end, areas, NULL, 10);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 20
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 64
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 64
INDIRI4
ASGNI4
line 1377
;1377:	if (numareas > 0) return areas[0];
ADDRLP4 16
INDIRI4
CNSTI4 0
LEI4 $513
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $509
JUMPV
LABELV $513
line 1378
;1378:	return 0;
CNSTI4 0
RETI4
LABELV $509
endproc BotPointAreaNum 68 20
export ClientName
proc ClientName 1028 12
line 1387
;1379:}
;1380:
;1381:
;1382:/*
;1383:==================
;1384:ClientName
;1385:==================
;1386:*/
;1387:char *ClientName( int client, char *name, int size ) {
line 1390
;1388:	char buf[ MAX_INFO_STRING ];
;1389:
;1390:	if ( (unsigned) client >= MAX_CLIENTS ) {
ADDRFP4 0
INDIRI4
CVIU4 4
CNSTU4 64
LTU4 $516
line 1391
;1391:		BotAI_Print( PRT_ERROR, "ClientName: client out of range\n" );
CNSTI4 3
ARGI4
ADDRGP4 $518
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1392
;1392:		Q_strncpyz( name, "[client out of range]", size );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $519
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1393
;1393:		return name;
ADDRFP4 4
INDIRP4
RETP4
ADDRGP4 $515
JUMPV
LABELV $516
line 1396
;1394:	}
;1395:
;1396:	trap_GetConfigstring( CS_PLAYERS + client, buf, sizeof( buf ) );
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1397
;1397:	Q_strncpyz( name, Info_ValueForKey( buf, "n" ), size );
ADDRLP4 0
ARGP4
ADDRGP4 $520
ARGP4
ADDRLP4 1024
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1398
;1398:	Q_CleanStr( name );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1400
;1399:
;1400:	return name;
ADDRFP4 4
INDIRP4
RETP4
LABELV $515
endproc ClientName 1028 12
export ClientSkin
proc ClientSkin 1028 12
line 1409
;1401:}
;1402:
;1403:
;1404:/*
;1405:==================
;1406:ClientSkin
;1407:==================
;1408:*/
;1409:char *ClientSkin( int client, char *skin, int size ) {
line 1412
;1410:	char buf[ MAX_INFO_STRING ];
;1411:
;1412:	if ( (unsigned) client >= MAX_CLIENTS ) {
ADDRFP4 0
INDIRI4
CVIU4 4
CNSTU4 64
LTU4 $522
line 1413
;1413:		BotAI_Print(PRT_ERROR, "ClientSkin: client out of range\n");
CNSTI4 3
ARGI4
ADDRGP4 $524
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1414
;1414:		return "[client out of range]";
ADDRGP4 $519
RETP4
ADDRGP4 $521
JUMPV
LABELV $522
line 1417
;1415:	}
;1416:
;1417:	trap_GetConfigstring( CS_PLAYERS + client, buf, sizeof( buf ) );
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1418
;1418:	Q_strncpyz( skin, Info_ValueForKey( buf, "model" ), size );
ADDRLP4 0
ARGP4
ADDRGP4 $525
ARGP4
ADDRLP4 1024
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1420
;1419:
;1420:	return skin;
ADDRFP4 4
INDIRP4
RETP4
LABELV $521
endproc ClientSkin 1028 12
export ClientFromName
proc ClientFromName 1036 12
line 1429
;1421:}
;1422:
;1423:
;1424:/*
;1425:==================
;1426:ClientFromName
;1427:==================
;1428:*/
;1429:int ClientFromName( const char *name ) {
line 1433
;1430:	int i;
;1431:	char buf[ MAX_INFO_STRING ];
;1432:
;1433:	for ( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 1024
CNSTI4 0
ASGNI4
ADDRGP4 $530
JUMPV
LABELV $527
line 1434
;1434:		trap_GetConfigstring( CS_PLAYERS + i, buf, sizeof( buf ) );
ADDRLP4 1024
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1435
;1435:		Q_CleanStr( buf );
ADDRLP4 0
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1436
;1436:		if ( !Q_stricmp( Info_ValueForKey( buf, "n" ), name ) )
ADDRLP4 0
ARGP4
ADDRGP4 $520
ARGP4
ADDRLP4 1028
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $532
line 1437
;1437:			return i;
ADDRLP4 1024
INDIRI4
RETI4
ADDRGP4 $526
JUMPV
LABELV $532
line 1438
;1438:	}
LABELV $528
line 1433
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $530
ADDRLP4 1024
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $527
line 1439
;1439:	return -1;
CNSTI4 -1
RETI4
LABELV $526
endproc ClientFromName 1036 12
export ClientOnSameTeamFromName
proc ClientOnSameTeamFromName 1040 12
line 1448
;1440:}
;1441:
;1442:
;1443:/*
;1444:==================
;1445:ClientOnSameTeamFromName
;1446:==================
;1447:*/
;1448:int ClientOnSameTeamFromName( bot_state_t *bs, const char *name ) {
line 1452
;1449:	char buf[MAX_INFO_STRING];
;1450:	int i;
;1451:
;1452:	for ( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $538
JUMPV
LABELV $535
line 1453
;1453:		if ( !BotSameTeam( bs, i ) )
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1028
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
NEI4 $540
line 1454
;1454:			continue;
ADDRGP4 $536
JUMPV
LABELV $540
line 1455
;1455:		trap_GetConfigstring( CS_PLAYERS + i, buf, sizeof( buf ) );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1456
;1456:		Q_CleanStr( buf );
ADDRLP4 4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1457
;1457:		if ( !Q_stricmp( Info_ValueForKey( buf, "n" ), name ) )
ADDRLP4 4
ARGP4
ADDRGP4 $520
ARGP4
ADDRLP4 1032
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1032
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $542
line 1458
;1458:			return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $534
JUMPV
LABELV $542
line 1459
;1459:	}
LABELV $536
line 1452
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $538
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $535
line 1461
;1460:
;1461:	return -1;
CNSTI4 -1
RETI4
LABELV $534
endproc ClientOnSameTeamFromName 1040 12
export stristr
proc stristr 12 4
line 1470
;1462:}
;1463:
;1464:
;1465:/*
;1466:==================
;1467:stristr
;1468:==================
;1469:*/
;1470:const char *stristr(const char *str, const char *charset) {
ADDRGP4 $546
JUMPV
LABELV $545
line 1473
;1471:	int i;
;1472:
;1473:	while(*str) {
line 1474
;1474:		for (i = 0; charset[i] && str[i]; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $551
JUMPV
LABELV $548
line 1475
;1475:			if (toupper(charset[i]) != toupper(str[i])) break;
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 4
ADDRGP4 toupper
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 toupper
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $552
ADDRGP4 $550
JUMPV
LABELV $552
line 1476
;1476:		}
LABELV $549
line 1474
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $551
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $554
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $548
LABELV $554
LABELV $550
line 1477
;1477:		if (!charset[i]) return str;
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $555
ADDRFP4 0
INDIRP4
RETP4
ADDRGP4 $544
JUMPV
LABELV $555
line 1478
;1478:		str++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1479
;1479:	}
LABELV $546
line 1473
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $545
line 1480
;1480:	return NULL;
CNSTP4 0
RETP4
LABELV $544
endproc stristr 12 4
export EasyClientName
proc EasyClientName 192 12
line 1489
;1481:}
;1482:
;1483:
;1484:/*
;1485:==================
;1486:EasyClientName
;1487:==================
;1488:*/
;1489:char *EasyClientName(int client, char *buf, int size) {
line 1494
;1490:	int i;
;1491:	char *str1, *str2, *ptr, c;
;1492:	char name[128];
;1493:
;1494:	ClientName( client, name, sizeof( name ) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 5
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1495
;1495:	for (i = 0; name[i]; i++) name[i] &= 127;
ADDRLP4 136
CNSTI4 0
ASGNI4
ADDRGP4 $561
JUMPV
LABELV $558
ADDRLP4 148
ADDRLP4 136
INDIRI4
ADDRLP4 5
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
ADDRLP4 148
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
BANDI4
CVII1 4
ASGNI1
LABELV $559
ADDRLP4 136
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $561
ADDRLP4 136
INDIRI4
ADDRLP4 5
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $558
line 1497
;1496:	//remove all spaces
;1497:	for (ptr = strchr(name, ' '); ptr; ptr = strchr(name, ' ')) {
ADDRLP4 5
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 152
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 152
INDIRP4
ASGNP4
ADDRGP4 $565
JUMPV
LABELV $562
line 1498
;1498:		memmove(ptr, ptr+1, strlen(ptr+1)+1);
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 156
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 156
INDIRU4
CNSTU4 1
ADDU4
ARGU4
ADDRGP4 memmove
CALLP4
pop
line 1499
;1499:	}
LABELV $563
line 1497
ADDRLP4 5
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 156
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 156
INDIRP4
ASGNP4
LABELV $565
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $562
line 1501
;1500:	//check for [x] and ]x[ clan names
;1501:	str1 = strchr(name, '[');
ADDRLP4 5
ARGP4
CNSTI4 91
ARGI4
ADDRLP4 160
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 140
ADDRLP4 160
INDIRP4
ASGNP4
line 1502
;1502:	str2 = strchr(name, ']');
ADDRLP4 5
ARGP4
CNSTI4 93
ARGI4
ADDRLP4 164
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 144
ADDRLP4 164
INDIRP4
ASGNP4
line 1503
;1503:	if (str1 && str2) {
ADDRLP4 140
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $566
ADDRLP4 144
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $566
line 1504
;1504:		if (str2 > str1) memmove(str1, str2+1, strlen(str2+1)+1);
ADDRLP4 144
INDIRP4
CVPU4 4
ADDRLP4 140
INDIRP4
CVPU4 4
LEU4 $568
ADDRLP4 144
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 168
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 140
INDIRP4
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 168
INDIRU4
CNSTU4 1
ADDU4
ARGU4
ADDRGP4 memmove
CALLP4
pop
ADDRGP4 $569
JUMPV
LABELV $568
line 1505
;1505:		else memmove(str2, str1+1, strlen(str1+1)+1);
ADDRLP4 140
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 172
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 144
INDIRP4
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 172
INDIRU4
CNSTU4 1
ADDU4
ARGU4
ADDRGP4 memmove
CALLP4
pop
LABELV $569
line 1506
;1506:	}
LABELV $566
line 1508
;1507:	//remove Mr prefix
;1508:	if ((name[0] == 'm' || name[0] == 'M') &&
ADDRLP4 168
ADDRLP4 5
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 109
EQI4 $574
ADDRLP4 168
INDIRI4
CNSTI4 77
NEI4 $570
LABELV $574
ADDRLP4 5+1
INDIRI1
CVII4 1
CNSTI4 114
EQI4 $575
ADDRLP4 5+1
INDIRI1
CVII4 1
CNSTI4 82
NEI4 $570
LABELV $575
line 1509
;1509:			(name[1] == 'r' || name[1] == 'R')) {
line 1510
;1510:		memmove(name, name+2, strlen(name+2)+1);
ADDRLP4 5+2
ARGP4
ADDRLP4 172
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 5
ARGP4
ADDRLP4 5+2
ARGP4
ADDRLP4 172
INDIRU4
CNSTU4 1
ADDU4
ARGU4
ADDRGP4 memmove
CALLP4
pop
line 1511
;1511:	}
LABELV $570
line 1513
;1512:	//only allow lower case alphabet characters
;1513:	ptr = name;
ADDRLP4 0
ADDRLP4 5
ASGNP4
ADDRGP4 $579
JUMPV
LABELV $578
line 1514
;1514:	while(*ptr) {
line 1515
;1515:		c = *ptr;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
ASGNI1
line 1516
;1516:		if ((c >= 'a' && c <= 'z') ||
ADDRLP4 172
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 97
LTI4 $584
ADDRLP4 172
INDIRI4
CNSTI4 122
LEI4 $585
LABELV $584
ADDRLP4 176
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 48
LTI4 $586
ADDRLP4 176
INDIRI4
CNSTI4 57
LEI4 $585
LABELV $586
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 95
NEI4 $581
LABELV $585
line 1517
;1517:				(c >= '0' && c <= '9') || c == '_') {
line 1518
;1518:			ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1519
;1519:		}
ADDRGP4 $582
JUMPV
LABELV $581
line 1520
;1520:		else if (c >= 'A' && c <= 'Z') {
ADDRLP4 180
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 65
LTI4 $587
ADDRLP4 180
INDIRI4
CNSTI4 90
GTI4 $587
line 1521
;1521:			*ptr += 'a' - 'A';
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
ADDI4
CVII1 4
ASGNI1
line 1522
;1522:			ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1523
;1523:		}
ADDRGP4 $588
JUMPV
LABELV $587
line 1524
;1524:		else {
line 1525
;1525:			memmove(ptr, ptr+1, strlen(ptr + 1)+1);
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 184
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 184
INDIRU4
CNSTU4 1
ADDU4
ARGU4
ADDRGP4 memmove
CALLP4
pop
line 1526
;1526:		}
LABELV $588
LABELV $582
line 1527
;1527:	}
LABELV $579
line 1514
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $578
line 1529
;1528:	
;1529:	Q_strncpyz( buf, name, size );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 5
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1531
;1530:
;1531:	return buf;
ADDRFP4 4
INDIRP4
RETP4
LABELV $557
endproc EasyClientName 192 12
export BotSynonymContext
proc BotSynonymContext 12 4
line 1539
;1532:}
;1533:
;1534:/*
;1535:==================
;1536:BotSynonymContext
;1537:==================
;1538:*/
;1539:int BotSynonymContext(bot_state_t *bs) {
line 1542
;1540:	int context;
;1541:
;1542:	context = CONTEXT_NORMAL|CONTEXT_NEARBYITEM|CONTEXT_NAMES;
ADDRLP4 0
CNSTI4 1027
ASGNI4
line 1544
;1543:	//
;1544:	if (gametype == GT_CTF
ADDRLP4 4
ADDRGP4 gametype
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
EQI4 $592
ADDRLP4 4
INDIRI4
CNSTI4 5
NEI4 $590
LABELV $592
line 1548
;1545:#ifdef MISSIONPACK
;1546:		|| gametype == GT_1FCTF
;1547:#endif
;1548:		) {
line 1549
;1549:		if (BotTeam(bs) == TEAM_RED) context |= CONTEXT_CTFREDTEAM;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
NEI4 $593
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 4
BORI4
ASGNI4
ADDRGP4 $591
JUMPV
LABELV $593
line 1550
;1550:		else context |= CONTEXT_CTFBLUETEAM;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 1551
;1551:	}
ADDRGP4 $591
JUMPV
LABELV $590
line 1553
;1552:#ifdef MISSIONPACK
;1553:	else if (gametype == GT_OBELISK) {
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $595
line 1554
;1554:		if (BotTeam(bs) == TEAM_RED) context |= CONTEXT_OBELISKREDTEAM;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
NEI4 $597
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 32
BORI4
ASGNI4
ADDRGP4 $596
JUMPV
LABELV $597
line 1555
;1555:		else context |= CONTEXT_OBELISKBLUETEAM;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 1556
;1556:	}
ADDRGP4 $596
JUMPV
LABELV $595
line 1557
;1557:	else if (gametype == GT_HARVESTER) {
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $599
line 1558
;1558:		if (BotTeam(bs) == TEAM_RED) context |= CONTEXT_HARVESTERREDTEAM;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
NEI4 $601
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 128
BORI4
ASGNI4
ADDRGP4 $602
JUMPV
LABELV $601
line 1559
;1559:		else context |= CONTEXT_HARVESTERBLUETEAM;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 256
BORI4
ASGNI4
LABELV $602
line 1560
;1560:	}
LABELV $599
LABELV $596
LABELV $591
line 1562
;1561:#endif
;1562:	return context;
ADDRLP4 0
INDIRI4
RETI4
LABELV $589
endproc BotSynonymContext 12 4
export BotChooseWeapon
proc BotChooseWeapon 20 8
line 1570
;1563:}
;1564:
;1565:/*
;1566:==================
;1567:BotChooseWeapon
;1568:==================
;1569:*/
;1570:void BotChooseWeapon(bot_state_t *bs) {
line 1573
;1571:	int newweaponnum;
;1572:
;1573:	if (bs->cur_ps.weaponstate == WEAPON_RAISING ||
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 1
EQI4 $606
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 2
NEI4 $604
LABELV $606
line 1574
;1574:			bs->cur_ps.weaponstate == WEAPON_DROPPING) {
line 1575
;1575:		trap_EA_SelectWeapon(bs->client, bs->weaponnum);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_SelectWeapon
CALLV
pop
line 1576
;1576:	}
ADDRGP4 $605
JUMPV
LABELV $604
line 1577
;1577:	else {
line 1578
;1578:		newweaponnum = trap_BotChooseBestFightWeapon(bs->ws, bs->inventory);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 4952
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 trap_BotChooseBestFightWeapon
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 1579
;1579:		if (bs->weaponnum != newweaponnum) bs->weaponchange_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $607
ADDRFP4 0
INDIRP4
CNSTI4 6192
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
LABELV $607
line 1580
;1580:		bs->weaponnum = newweaponnum;
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1582
;1581:		//BotAI_Print(PRT_MESSAGE, "bs->weaponnum = %d\n", bs->weaponnum);
;1582:		trap_EA_SelectWeapon(bs->client, bs->weaponnum);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_SelectWeapon
CALLV
pop
line 1583
;1583:	}
LABELV $605
line 1584
;1584:}
LABELV $603
endproc BotChooseWeapon 20 8
export BotSetupForMovement
proc BotSetupForMovement 76 12
line 1591
;1585:
;1586:/*
;1587:==================
;1588:BotSetupForMovement
;1589:==================
;1590:*/
;1591:void BotSetupForMovement(bot_state_t *bs) {
line 1594
;1592:	bot_initmove_t initmove;
;1593:
;1594:	memset(&initmove, 0, sizeof(bot_initmove_t));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTU4 68
ARGU4
ADDRGP4 memset
CALLP4
pop
line 1595
;1595:	VectorCopy(bs->cur_ps.origin, initmove.origin);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1596
;1596:	VectorCopy(bs->cur_ps.velocity, initmove.velocity);
ADDRLP4 0+12
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRB
ASGNB 12
line 1597
;1597:	VectorClear(initmove.viewoffset);
ADDRLP4 0+24
CNSTF4 0
ASGNF4
ADDRLP4 0+24+4
CNSTF4 0
ASGNF4
ADDRLP4 0+24+8
CNSTF4 0
ASGNF4
line 1598
;1598:	initmove.viewoffset[2] += bs->cur_ps.viewheight;
ADDRLP4 0+24+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1599
;1599:	initmove.entitynum = bs->entitynum;
ADDRLP4 0+36
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1600
;1600:	initmove.client = bs->client;
ADDRLP4 0+40
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1601
;1601:	initmove.thinktime = bs->thinktime;
ADDRLP4 0+44
ADDRFP4 0
INDIRP4
CNSTI4 4904
ADDP4
INDIRF4
ASGNF4
line 1603
;1602:	//set the onground flag
;1603:	if (bs->cur_ps.groundEntityNum != ENTITYNUM_NONE) initmove.or_moveflags |= MFL_ONGROUND;
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $621
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 2
BORI4
ASGNI4
LABELV $621
line 1605
;1604:	//set the teleported flag
;1605:	if ((bs->cur_ps.pm_flags & PMF_TIME_KNOCKBACK) && (bs->cur_ps.pm_time > 0)) {
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $624
ADDRLP4 68
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
LEI4 $624
line 1606
;1606:		initmove.or_moveflags |= MFL_TELEPORTED;
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 1607
;1607:	}
LABELV $624
line 1609
;1608:	//set the waterjump flag
;1609:	if ((bs->cur_ps.pm_flags & PMF_TIME_WATERJUMP) && (bs->cur_ps.pm_time > 0)) {
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $627
ADDRLP4 72
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
LEI4 $627
line 1610
;1610:		initmove.or_moveflags |= MFL_WATERJUMP;
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 1611
;1611:	}
LABELV $627
line 1613
;1612:	//set presence type
;1613:	if (bs->cur_ps.pm_flags & PMF_DUCKED) initmove.presencetype = PRESENCE_CROUCH;
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $630
ADDRLP4 0+48
CNSTI4 4
ASGNI4
ADDRGP4 $631
JUMPV
LABELV $630
line 1614
;1614:	else initmove.presencetype = PRESENCE_NORMAL;
ADDRLP4 0+48
CNSTI4 2
ASGNI4
LABELV $631
line 1616
;1615:	//
;1616:	if (bs->walker > 0.5) initmove.or_moveflags |= MFL_WALK;
ADDRFP4 0
INDIRP4
CNSTI4 6056
ADDP4
INDIRF4
CNSTF4 1056964608
LEF4 $634
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 512
BORI4
ASGNI4
LABELV $634
line 1618
;1617:	//
;1618:	VectorCopy(bs->viewangles, initmove.viewangles);
ADDRLP4 0+52
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
INDIRB
ASGNB 12
line 1620
;1619:	//
;1620:	trap_BotInitMoveState(bs->ms, &initmove);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotInitMoveState
CALLV
pop
line 1621
;1621:}
LABELV $609
endproc BotSetupForMovement 76 12
export BotCheckItemPickup
proc BotCheckItemPickup 28 12
line 1628
;1622:
;1623:/*
;1624:==================
;1625:BotCheckItemPickup
;1626:==================
;1627:*/
;1628:void BotCheckItemPickup(bot_state_t *bs, int *oldinventory) {
line 1632
;1629:#ifdef MISSIONPACK
;1630:	int offence, leader;
;1631:
;1632:	if (gametype <= GT_TEAM)
ADDRGP4 gametype
INDIRI4
CNSTI4 3
GTI4 $639
line 1633
;1633:		return;
ADDRGP4 $638
JUMPV
LABELV $639
line 1635
;1634:
;1635:	offence = -1;
ADDRLP4 0
CNSTI4 -1
ASGNI4
line 1637
;1636:	// go into offence if picked up the kamikaze or invulnerability
;1637:	if (!oldinventory[INVENTORY_KAMIKAZE] && bs->inventory[INVENTORY_KAMIKAZE] >= 1) {
ADDRFP4 4
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
CNSTI4 0
NEI4 $641
ADDRFP4 0
INDIRP4
CNSTI4 5080
ADDP4
INDIRI4
CNSTI4 1
LTI4 $641
line 1638
;1638:		offence = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1639
;1639:	}
LABELV $641
line 1640
;1640:	if (!oldinventory[INVENTORY_INVULNERABILITY] && bs->inventory[INVENTORY_INVULNERABILITY] >= 1) {
ADDRFP4 4
INDIRP4
CNSTI4 136
ADDP4
INDIRI4
CNSTI4 0
NEI4 $643
ADDRFP4 0
INDIRP4
CNSTI4 5088
ADDP4
INDIRI4
CNSTI4 1
LTI4 $643
line 1641
;1641:		offence = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1642
;1642:	}
LABELV $643
line 1644
;1643:	// if not already wearing the kamikaze or invulnerability
;1644:	if (!bs->inventory[INVENTORY_KAMIKAZE] && !bs->inventory[INVENTORY_INVULNERABILITY]) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 5080
ADDP4
INDIRI4
CNSTI4 0
NEI4 $645
ADDRLP4 8
INDIRP4
CNSTI4 5088
ADDP4
INDIRI4
CNSTI4 0
NEI4 $645
line 1645
;1645:		if (!oldinventory[INVENTORY_SCOUT] && bs->inventory[INVENTORY_SCOUT] >= 1) {
ADDRFP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 0
NEI4 $647
ADDRFP4 0
INDIRP4
CNSTI4 5116
ADDP4
INDIRI4
CNSTI4 1
LTI4 $647
line 1646
;1646:			offence = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1647
;1647:		}
LABELV $647
line 1648
;1648:		if (!oldinventory[INVENTORY_GUARD] && bs->inventory[INVENTORY_GUARD] >= 1) {
ADDRFP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 0
NEI4 $649
ADDRFP4 0
INDIRP4
CNSTI4 5120
ADDP4
INDIRI4
CNSTI4 1
LTI4 $649
line 1649
;1649:			offence = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1650
;1650:		}
LABELV $649
line 1651
;1651:		if (!oldinventory[INVENTORY_DOUBLER] && bs->inventory[INVENTORY_DOUBLER] >= 1) {
ADDRFP4 4
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
CNSTI4 0
NEI4 $651
ADDRFP4 0
INDIRP4
CNSTI4 5124
ADDP4
INDIRI4
CNSTI4 1
LTI4 $651
line 1652
;1652:			offence = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1653
;1653:		}
LABELV $651
line 1654
;1654:		if (!oldinventory[INVENTORY_AMMOREGEN] && bs->inventory[INVENTORY_AMMOREGEN] >= 1) {
ADDRFP4 4
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 0
NEI4 $653
ADDRFP4 0
INDIRP4
CNSTI4 5128
ADDP4
INDIRI4
CNSTI4 1
LTI4 $653
line 1655
;1655:			offence = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1656
;1656:		}
LABELV $653
line 1657
;1657:	}
LABELV $645
line 1659
;1658:
;1659:	if (offence >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $655
line 1660
;1660:		leader = ClientFromName(bs->teamleader);
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
line 1661
;1661:		if (offence) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $657
line 1662
;1662:			if (!(bs->teamtaskpreference & TEAMTP_ATTACKER)) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $659
line 1664
;1663:				// if we have a bot team leader
;1664:				if (BotTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 BotTeamLeader
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $661
line 1667
;1665:					// tell the leader we want to be on offence
;1666:#ifdef MISSIONPACK
;1667:					BotVoiceChat(bs, leader, VOICECHAT_WANTONOFFENSE);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 $663
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 1671
;1668:#endif
;1669:					//BotAI_BotInitialChat(bs, "wantoffence", NULL);
;1670:					//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;1671:				}
ADDRGP4 $662
JUMPV
LABELV $661
line 1672
;1672:				else if (g_spSkill.integer <= 3) {
ADDRGP4 g_spSkill+12
INDIRI4
CNSTI4 3
GTI4 $664
line 1673
;1673:					if ( bs->ltgtype != LTG_GETFLAG &&
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
EQI4 $667
ADDRLP4 20
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 13
EQI4 $667
ADDRLP4 20
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 12
EQI4 $667
line 1675
;1674:						 bs->ltgtype != LTG_ATTACKENEMYBASE &&
;1675:						 bs->ltgtype != LTG_HARVEST ) {
line 1677
;1676:						//
;1677:						if ((gametype != GT_CTF || (bs->redflagstatus == 0 && bs->blueflagstatus == 0)) &&
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $671
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
CNSTI4 0
NEI4 $669
ADDRLP4 24
INDIRP4
CNSTI4 6960
ADDP4
INDIRI4
CNSTI4 0
NEI4 $669
LABELV $671
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $672
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
INDIRI4
CNSTI4 0
NEI4 $669
LABELV $672
line 1678
;1678:							(gametype != GT_1FCTF || bs->neutralflagstatus == 0) ) {
line 1681
;1679:							// tell the leader we want to be on offence
;1680:#ifdef MISSIONPACK
;1681:							BotVoiceChat(bs, leader, VOICECHAT_WANTONOFFENSE);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 $663
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 1685
;1682:#endif
;1683:							//BotAI_BotInitialChat(bs, "wantoffence", NULL);
;1684:							//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;1685:						}
LABELV $669
line 1686
;1686:					}
LABELV $667
line 1687
;1687:				}
LABELV $664
LABELV $662
line 1688
;1688:				bs->teamtaskpreference |= TEAMTP_ATTACKER;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 1689
;1689:			}
LABELV $659
line 1690
;1690:			bs->teamtaskpreference &= ~TEAMTP_DEFENDER;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 1691
;1691:		}
ADDRGP4 $658
JUMPV
LABELV $657
line 1692
;1692:		else {
line 1693
;1693:			if (!(bs->teamtaskpreference & TEAMTP_DEFENDER)) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $673
line 1695
;1694:				// if we have a bot team leader
;1695:				if (BotTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 BotTeamLeader
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $675
line 1698
;1696:					// tell the leader we want to be on defense
;1697:#ifdef MISSIONPACK
;1698:					BotVoiceChat(bs, -1, VOICECHAT_WANTONDEFENSE);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $677
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 1702
;1699:#endif
;1700:					//BotAI_BotInitialChat(bs, "wantdefence", NULL);
;1701:					//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;1702:				}
ADDRGP4 $676
JUMPV
LABELV $675
line 1703
;1703:				else if (g_spSkill.integer <= 3) {
ADDRGP4 g_spSkill+12
INDIRI4
CNSTI4 3
GTI4 $678
line 1704
;1704:					if ( bs->ltgtype != LTG_DEFENDKEYAREA ) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 3
EQI4 $681
line 1706
;1705:						//
;1706:						if ((gametype != GT_CTF || (bs->redflagstatus == 0 && bs->blueflagstatus == 0)) &&
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $685
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
CNSTI4 0
NEI4 $683
ADDRLP4 20
INDIRP4
CNSTI4 6960
ADDP4
INDIRI4
CNSTI4 0
NEI4 $683
LABELV $685
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $686
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
INDIRI4
CNSTI4 0
NEI4 $683
LABELV $686
line 1707
;1707:							(gametype != GT_1FCTF || bs->neutralflagstatus == 0) ) {
line 1710
;1708:							// tell the leader we want to be on defense
;1709:#ifdef MISSIONPACK
;1710:							BotVoiceChat(bs, -1, VOICECHAT_WANTONDEFENSE);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $677
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 1714
;1711:#endif
;1712:							//BotAI_BotInitialChat(bs, "wantdefence", NULL);
;1713:							//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;1714:						}
LABELV $683
line 1715
;1715:					}
LABELV $681
line 1716
;1716:				}
LABELV $678
LABELV $676
line 1717
;1717:				bs->teamtaskpreference |= TEAMTP_DEFENDER;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1718
;1718:			}
LABELV $673
line 1719
;1719:			bs->teamtaskpreference &= ~TEAMTP_ATTACKER;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 1720
;1720:		}
LABELV $658
line 1721
;1721:	}
LABELV $655
line 1723
;1722:#endif
;1723:}
LABELV $638
endproc BotCheckItemPickup 28 12
export BotUpdateInventory
proc BotUpdateInventory 1332 12
line 1730
;1724:
;1725:/*
;1726:==================
;1727:BotUpdateInventory
;1728:==================
;1729:*/
;1730:void BotUpdateInventory(bot_state_t *bs) {
line 1733
;1731:	int oldinventory[MAX_ITEMS];
;1732:
;1733:	memcpy(oldinventory, bs->inventory, sizeof(oldinventory));
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4952
ADDP4
ARGP4
CNSTU4 1024
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 1735
;1734:	//armor
;1735:	bs->inventory[INVENTORY_ARMOR] = bs->cur_ps.stats[STAT_ARMOR];
ADDRLP4 1024
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1024
INDIRP4
CNSTI4 4956
ADDP4
ADDRLP4 1024
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
ASGNI4
line 1737
;1736:	//weapons
;1737:	bs->inventory[INVENTORY_GAUNTLET] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_GAUNTLET)) != 0;
ADDRLP4 1032
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1032
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $689
ADDRLP4 1028
CNSTI4 1
ASGNI4
ADDRGP4 $690
JUMPV
LABELV $689
ADDRLP4 1028
CNSTI4 0
ASGNI4
LABELV $690
ADDRLP4 1032
INDIRP4
CNSTI4 4968
ADDP4
ADDRLP4 1028
INDIRI4
ASGNI4
line 1738
;1738:	bs->inventory[INVENTORY_SHOTGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_SHOTGUN)) != 0;
ADDRLP4 1040
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1040
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $692
ADDRLP4 1036
CNSTI4 1
ASGNI4
ADDRGP4 $693
JUMPV
LABELV $692
ADDRLP4 1036
CNSTI4 0
ASGNI4
LABELV $693
ADDRLP4 1040
INDIRP4
CNSTI4 4972
ADDP4
ADDRLP4 1036
INDIRI4
ASGNI4
line 1739
;1739:	bs->inventory[INVENTORY_MACHINEGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_MACHINEGUN)) != 0;
ADDRLP4 1048
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1048
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $695
ADDRLP4 1044
CNSTI4 1
ASGNI4
ADDRGP4 $696
JUMPV
LABELV $695
ADDRLP4 1044
CNSTI4 0
ASGNI4
LABELV $696
ADDRLP4 1048
INDIRP4
CNSTI4 4976
ADDP4
ADDRLP4 1044
INDIRI4
ASGNI4
line 1740
;1740:	bs->inventory[INVENTORY_GRENADELAUNCHER] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_GRENADE_LAUNCHER)) != 0;
ADDRLP4 1056
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1056
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $698
ADDRLP4 1052
CNSTI4 1
ASGNI4
ADDRGP4 $699
JUMPV
LABELV $698
ADDRLP4 1052
CNSTI4 0
ASGNI4
LABELV $699
ADDRLP4 1056
INDIRP4
CNSTI4 4980
ADDP4
ADDRLP4 1052
INDIRI4
ASGNI4
line 1741
;1741:	bs->inventory[INVENTORY_ROCKETLAUNCHER] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_ROCKET_LAUNCHER)) != 0;
ADDRLP4 1064
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1064
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $701
ADDRLP4 1060
CNSTI4 1
ASGNI4
ADDRGP4 $702
JUMPV
LABELV $701
ADDRLP4 1060
CNSTI4 0
ASGNI4
LABELV $702
ADDRLP4 1064
INDIRP4
CNSTI4 4984
ADDP4
ADDRLP4 1060
INDIRI4
ASGNI4
line 1742
;1742:	bs->inventory[INVENTORY_LIGHTNING] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_LIGHTNING)) != 0;
ADDRLP4 1072
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1072
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $704
ADDRLP4 1068
CNSTI4 1
ASGNI4
ADDRGP4 $705
JUMPV
LABELV $704
ADDRLP4 1068
CNSTI4 0
ASGNI4
LABELV $705
ADDRLP4 1072
INDIRP4
CNSTI4 4988
ADDP4
ADDRLP4 1068
INDIRI4
ASGNI4
line 1743
;1743:	bs->inventory[INVENTORY_RAILGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_RAILGUN)) != 0;
ADDRLP4 1080
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1080
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $707
ADDRLP4 1076
CNSTI4 1
ASGNI4
ADDRGP4 $708
JUMPV
LABELV $707
ADDRLP4 1076
CNSTI4 0
ASGNI4
LABELV $708
ADDRLP4 1080
INDIRP4
CNSTI4 4992
ADDP4
ADDRLP4 1076
INDIRI4
ASGNI4
line 1744
;1744:	bs->inventory[INVENTORY_PLASMAGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_PLASMAGUN)) != 0;
ADDRLP4 1088
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1088
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $710
ADDRLP4 1084
CNSTI4 1
ASGNI4
ADDRGP4 $711
JUMPV
LABELV $710
ADDRLP4 1084
CNSTI4 0
ASGNI4
LABELV $711
ADDRLP4 1088
INDIRP4
CNSTI4 4996
ADDP4
ADDRLP4 1084
INDIRI4
ASGNI4
line 1745
;1745:	bs->inventory[INVENTORY_BFG10K] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_BFG)) != 0;
ADDRLP4 1096
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1096
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $713
ADDRLP4 1092
CNSTI4 1
ASGNI4
ADDRGP4 $714
JUMPV
LABELV $713
ADDRLP4 1092
CNSTI4 0
ASGNI4
LABELV $714
ADDRLP4 1096
INDIRP4
CNSTI4 5004
ADDP4
ADDRLP4 1092
INDIRI4
ASGNI4
line 1746
;1746:	bs->inventory[INVENTORY_GRAPPLINGHOOK] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_GRAPPLING_HOOK)) != 0;
ADDRLP4 1104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1104
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $716
ADDRLP4 1100
CNSTI4 1
ASGNI4
ADDRGP4 $717
JUMPV
LABELV $716
ADDRLP4 1100
CNSTI4 0
ASGNI4
LABELV $717
ADDRLP4 1104
INDIRP4
CNSTI4 5008
ADDP4
ADDRLP4 1100
INDIRI4
ASGNI4
line 1748
;1747:#ifdef MISSIONPACK
;1748:	bs->inventory[INVENTORY_NAILGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_NAILGUN)) != 0;;
ADDRLP4 1112
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1112
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $719
ADDRLP4 1108
CNSTI4 1
ASGNI4
ADDRGP4 $720
JUMPV
LABELV $719
ADDRLP4 1108
CNSTI4 0
ASGNI4
LABELV $720
ADDRLP4 1112
INDIRP4
CNSTI4 5012
ADDP4
ADDRLP4 1108
INDIRI4
ASGNI4
line 1749
;1749:	bs->inventory[INVENTORY_PROXLAUNCHER] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_PROX_LAUNCHER)) != 0;;
ADDRLP4 1120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1120
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $722
ADDRLP4 1116
CNSTI4 1
ASGNI4
ADDRGP4 $723
JUMPV
LABELV $722
ADDRLP4 1116
CNSTI4 0
ASGNI4
LABELV $723
ADDRLP4 1120
INDIRP4
CNSTI4 5016
ADDP4
ADDRLP4 1116
INDIRI4
ASGNI4
line 1750
;1750:	bs->inventory[INVENTORY_CHAINGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_CHAINGUN)) != 0;;
ADDRLP4 1128
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1128
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $725
ADDRLP4 1124
CNSTI4 1
ASGNI4
ADDRGP4 $726
JUMPV
LABELV $725
ADDRLP4 1124
CNSTI4 0
ASGNI4
LABELV $726
ADDRLP4 1128
INDIRP4
CNSTI4 5020
ADDP4
ADDRLP4 1124
INDIRI4
ASGNI4
line 1753
;1751:#endif
;1752:	//ammo
;1753:	bs->inventory[INVENTORY_SHELLS] = bs->cur_ps.ammo[WP_SHOTGUN];
ADDRLP4 1132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1132
INDIRP4
CNSTI4 5024
ADDP4
ADDRLP4 1132
INDIRP4
CNSTI4 404
ADDP4
INDIRI4
ASGNI4
line 1754
;1754:	bs->inventory[INVENTORY_BULLETS] = bs->cur_ps.ammo[WP_MACHINEGUN];
ADDRLP4 1136
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1136
INDIRP4
CNSTI4 5028
ADDP4
ADDRLP4 1136
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ASGNI4
line 1755
;1755:	bs->inventory[INVENTORY_GRENADES] = bs->cur_ps.ammo[WP_GRENADE_LAUNCHER];
ADDRLP4 1140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1140
INDIRP4
CNSTI4 5032
ADDP4
ADDRLP4 1140
INDIRP4
CNSTI4 408
ADDP4
INDIRI4
ASGNI4
line 1756
;1756:	bs->inventory[INVENTORY_CELLS] = bs->cur_ps.ammo[WP_PLASMAGUN];
ADDRLP4 1144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1144
INDIRP4
CNSTI4 5036
ADDP4
ADDRLP4 1144
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
ASGNI4
line 1757
;1757:	bs->inventory[INVENTORY_LIGHTNINGAMMO] = bs->cur_ps.ammo[WP_LIGHTNING];
ADDRLP4 1148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1148
INDIRP4
CNSTI4 5040
ADDP4
ADDRLP4 1148
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
ASGNI4
line 1758
;1758:	bs->inventory[INVENTORY_ROCKETS] = bs->cur_ps.ammo[WP_ROCKET_LAUNCHER];
ADDRLP4 1152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1152
INDIRP4
CNSTI4 5044
ADDP4
ADDRLP4 1152
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
ASGNI4
line 1759
;1759:	bs->inventory[INVENTORY_SLUGS] = bs->cur_ps.ammo[WP_RAILGUN];
ADDRLP4 1156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1156
INDIRP4
CNSTI4 5048
ADDP4
ADDRLP4 1156
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
ASGNI4
line 1760
;1760:	bs->inventory[INVENTORY_BFGAMMO] = bs->cur_ps.ammo[WP_BFG];
ADDRLP4 1160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1160
INDIRP4
CNSTI4 5052
ADDP4
ADDRLP4 1160
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
ASGNI4
line 1762
;1761:#ifdef MISSIONPACK
;1762:	bs->inventory[INVENTORY_NAILS] = bs->cur_ps.ammo[WP_NAILGUN];
ADDRLP4 1164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1164
INDIRP4
CNSTI4 5056
ADDP4
ADDRLP4 1164
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ASGNI4
line 1763
;1763:	bs->inventory[INVENTORY_MINES] = bs->cur_ps.ammo[WP_PROX_LAUNCHER];
ADDRLP4 1168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1168
INDIRP4
CNSTI4 5060
ADDP4
ADDRLP4 1168
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
ASGNI4
line 1764
;1764:	bs->inventory[INVENTORY_BELT] = bs->cur_ps.ammo[WP_CHAINGUN];
ADDRLP4 1172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1172
INDIRP4
CNSTI4 5064
ADDP4
ADDRLP4 1172
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
ASGNI4
line 1767
;1765:#endif
;1766:	//powerups
;1767:	bs->inventory[INVENTORY_HEALTH] = bs->cur_ps.stats[STAT_HEALTH];
ADDRLP4 1176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1176
INDIRP4
CNSTI4 5068
ADDP4
ADDRLP4 1176
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ASGNI4
line 1768
;1768:	bs->inventory[INVENTORY_TELEPORTER] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_TELEPORTER;
ADDRLP4 1184
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1184
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 26
NEI4 $728
ADDRLP4 1180
CNSTI4 1
ASGNI4
ADDRGP4 $729
JUMPV
LABELV $728
ADDRLP4 1180
CNSTI4 0
ASGNI4
LABELV $729
ADDRLP4 1184
INDIRP4
CNSTI4 5072
ADDP4
ADDRLP4 1180
INDIRI4
ASGNI4
line 1769
;1769:	bs->inventory[INVENTORY_MEDKIT] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_MEDKIT;
ADDRLP4 1192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1192
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 27
NEI4 $731
ADDRLP4 1188
CNSTI4 1
ASGNI4
ADDRGP4 $732
JUMPV
LABELV $731
ADDRLP4 1188
CNSTI4 0
ASGNI4
LABELV $732
ADDRLP4 1192
INDIRP4
CNSTI4 5076
ADDP4
ADDRLP4 1188
INDIRI4
ASGNI4
line 1771
;1770:#ifdef MISSIONPACK
;1771:	bs->inventory[INVENTORY_KAMIKAZE] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_KAMIKAZE;
ADDRLP4 1200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1200
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 36
NEI4 $734
ADDRLP4 1196
CNSTI4 1
ASGNI4
ADDRGP4 $735
JUMPV
LABELV $734
ADDRLP4 1196
CNSTI4 0
ASGNI4
LABELV $735
ADDRLP4 1200
INDIRP4
CNSTI4 5080
ADDP4
ADDRLP4 1196
INDIRI4
ASGNI4
line 1772
;1772:	bs->inventory[INVENTORY_PORTAL] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_PORTAL;
ADDRLP4 1208
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1208
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 37
NEI4 $737
ADDRLP4 1204
CNSTI4 1
ASGNI4
ADDRGP4 $738
JUMPV
LABELV $737
ADDRLP4 1204
CNSTI4 0
ASGNI4
LABELV $738
ADDRLP4 1208
INDIRP4
CNSTI4 5084
ADDP4
ADDRLP4 1204
INDIRI4
ASGNI4
line 1773
;1773:	bs->inventory[INVENTORY_INVULNERABILITY] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_INVULNERABILITY;
ADDRLP4 1216
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1216
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 38
NEI4 $740
ADDRLP4 1212
CNSTI4 1
ASGNI4
ADDRGP4 $741
JUMPV
LABELV $740
ADDRLP4 1212
CNSTI4 0
ASGNI4
LABELV $741
ADDRLP4 1216
INDIRP4
CNSTI4 5088
ADDP4
ADDRLP4 1212
INDIRI4
ASGNI4
line 1775
;1774:#endif
;1775:	bs->inventory[INVENTORY_QUAD] = bs->cur_ps.powerups[PW_QUAD] != 0;
ADDRLP4 1224
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1224
INDIRP4
CNSTI4 332
ADDP4
INDIRI4
CNSTI4 0
EQI4 $743
ADDRLP4 1220
CNSTI4 1
ASGNI4
ADDRGP4 $744
JUMPV
LABELV $743
ADDRLP4 1220
CNSTI4 0
ASGNI4
LABELV $744
ADDRLP4 1224
INDIRP4
CNSTI4 5092
ADDP4
ADDRLP4 1220
INDIRI4
ASGNI4
line 1776
;1776:	bs->inventory[INVENTORY_ENVIRONMENTSUIT] = bs->cur_ps.powerups[PW_BATTLESUIT] != 0;
ADDRLP4 1232
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1232
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $746
ADDRLP4 1228
CNSTI4 1
ASGNI4
ADDRGP4 $747
JUMPV
LABELV $746
ADDRLP4 1228
CNSTI4 0
ASGNI4
LABELV $747
ADDRLP4 1232
INDIRP4
CNSTI4 5096
ADDP4
ADDRLP4 1228
INDIRI4
ASGNI4
line 1777
;1777:	bs->inventory[INVENTORY_HASTE] = bs->cur_ps.powerups[PW_HASTE] != 0;
ADDRLP4 1240
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1240
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $749
ADDRLP4 1236
CNSTI4 1
ASGNI4
ADDRGP4 $750
JUMPV
LABELV $749
ADDRLP4 1236
CNSTI4 0
ASGNI4
LABELV $750
ADDRLP4 1240
INDIRP4
CNSTI4 5100
ADDP4
ADDRLP4 1236
INDIRI4
ASGNI4
line 1778
;1778:	bs->inventory[INVENTORY_INVISIBILITY] = bs->cur_ps.powerups[PW_INVIS] != 0;
ADDRLP4 1248
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1248
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $752
ADDRLP4 1244
CNSTI4 1
ASGNI4
ADDRGP4 $753
JUMPV
LABELV $752
ADDRLP4 1244
CNSTI4 0
ASGNI4
LABELV $753
ADDRLP4 1248
INDIRP4
CNSTI4 5104
ADDP4
ADDRLP4 1244
INDIRI4
ASGNI4
line 1779
;1779:	bs->inventory[INVENTORY_REGEN] = bs->cur_ps.powerups[PW_REGEN] != 0;
ADDRLP4 1256
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1256
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $755
ADDRLP4 1252
CNSTI4 1
ASGNI4
ADDRGP4 $756
JUMPV
LABELV $755
ADDRLP4 1252
CNSTI4 0
ASGNI4
LABELV $756
ADDRLP4 1256
INDIRP4
CNSTI4 5108
ADDP4
ADDRLP4 1252
INDIRI4
ASGNI4
line 1780
;1780:	bs->inventory[INVENTORY_FLIGHT] = bs->cur_ps.powerups[PW_FLIGHT] != 0;
ADDRLP4 1264
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1264
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
CNSTI4 0
EQI4 $758
ADDRLP4 1260
CNSTI4 1
ASGNI4
ADDRGP4 $759
JUMPV
LABELV $758
ADDRLP4 1260
CNSTI4 0
ASGNI4
LABELV $759
ADDRLP4 1264
INDIRP4
CNSTI4 5112
ADDP4
ADDRLP4 1260
INDIRI4
ASGNI4
line 1782
;1781:#ifdef MISSIONPACK
;1782:	bs->inventory[INVENTORY_SCOUT] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_SCOUT;
ADDRLP4 1272
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1272
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 42
NEI4 $761
ADDRLP4 1268
CNSTI4 1
ASGNI4
ADDRGP4 $762
JUMPV
LABELV $761
ADDRLP4 1268
CNSTI4 0
ASGNI4
LABELV $762
ADDRLP4 1272
INDIRP4
CNSTI4 5116
ADDP4
ADDRLP4 1268
INDIRI4
ASGNI4
line 1783
;1783:	bs->inventory[INVENTORY_GUARD] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_GUARD;
ADDRLP4 1280
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1280
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 43
NEI4 $764
ADDRLP4 1276
CNSTI4 1
ASGNI4
ADDRGP4 $765
JUMPV
LABELV $764
ADDRLP4 1276
CNSTI4 0
ASGNI4
LABELV $765
ADDRLP4 1280
INDIRP4
CNSTI4 5120
ADDP4
ADDRLP4 1276
INDIRI4
ASGNI4
line 1784
;1784:	bs->inventory[INVENTORY_DOUBLER] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_DOUBLER;
ADDRLP4 1288
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1288
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 44
NEI4 $767
ADDRLP4 1284
CNSTI4 1
ASGNI4
ADDRGP4 $768
JUMPV
LABELV $767
ADDRLP4 1284
CNSTI4 0
ASGNI4
LABELV $768
ADDRLP4 1288
INDIRP4
CNSTI4 5124
ADDP4
ADDRLP4 1284
INDIRI4
ASGNI4
line 1785
;1785:	bs->inventory[INVENTORY_AMMOREGEN] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_AMMOREGEN;
ADDRLP4 1296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1296
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 45
NEI4 $770
ADDRLP4 1292
CNSTI4 1
ASGNI4
ADDRGP4 $771
JUMPV
LABELV $770
ADDRLP4 1292
CNSTI4 0
ASGNI4
LABELV $771
ADDRLP4 1296
INDIRP4
CNSTI4 5128
ADDP4
ADDRLP4 1292
INDIRI4
ASGNI4
line 1787
;1786:#endif
;1787:	bs->inventory[INVENTORY_REDFLAG] = bs->cur_ps.powerups[PW_REDFLAG] != 0;
ADDRLP4 1304
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1304
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
EQI4 $773
ADDRLP4 1300
CNSTI4 1
ASGNI4
ADDRGP4 $774
JUMPV
LABELV $773
ADDRLP4 1300
CNSTI4 0
ASGNI4
LABELV $774
ADDRLP4 1304
INDIRP4
CNSTI4 5132
ADDP4
ADDRLP4 1300
INDIRI4
ASGNI4
line 1788
;1788:	bs->inventory[INVENTORY_BLUEFLAG] = bs->cur_ps.powerups[PW_BLUEFLAG] != 0;
ADDRLP4 1312
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1312
INDIRP4
CNSTI4 360
ADDP4
INDIRI4
CNSTI4 0
EQI4 $776
ADDRLP4 1308
CNSTI4 1
ASGNI4
ADDRGP4 $777
JUMPV
LABELV $776
ADDRLP4 1308
CNSTI4 0
ASGNI4
LABELV $777
ADDRLP4 1312
INDIRP4
CNSTI4 5136
ADDP4
ADDRLP4 1308
INDIRI4
ASGNI4
line 1790
;1789:#ifdef MISSIONPACK
;1790:	bs->inventory[INVENTORY_NEUTRALFLAG] = bs->cur_ps.powerups[PW_NEUTRALFLAG] != 0;
ADDRLP4 1320
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1320
INDIRP4
CNSTI4 364
ADDP4
INDIRI4
CNSTI4 0
EQI4 $779
ADDRLP4 1316
CNSTI4 1
ASGNI4
ADDRGP4 $780
JUMPV
LABELV $779
ADDRLP4 1316
CNSTI4 0
ASGNI4
LABELV $780
ADDRLP4 1320
INDIRP4
CNSTI4 5140
ADDP4
ADDRLP4 1316
INDIRI4
ASGNI4
line 1791
;1791:	if (BotTeam(bs) == TEAM_RED) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1324
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 1324
INDIRI4
CNSTI4 1
NEI4 $781
line 1792
;1792:		bs->inventory[INVENTORY_REDCUBE] = bs->cur_ps.generic1;
ADDRLP4 1328
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1328
INDIRP4
CNSTI4 5144
ADDP4
ADDRLP4 1328
INDIRP4
CNSTI4 456
ADDP4
INDIRI4
ASGNI4
line 1793
;1793:		bs->inventory[INVENTORY_BLUECUBE] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5148
ADDP4
CNSTI4 0
ASGNI4
line 1794
;1794:	}
ADDRGP4 $782
JUMPV
LABELV $781
line 1795
;1795:	else {
line 1796
;1796:		bs->inventory[INVENTORY_REDCUBE] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5144
ADDP4
CNSTI4 0
ASGNI4
line 1797
;1797:		bs->inventory[INVENTORY_BLUECUBE] = bs->cur_ps.generic1;
ADDRLP4 1328
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1328
INDIRP4
CNSTI4 5148
ADDP4
ADDRLP4 1328
INDIRP4
CNSTI4 456
ADDP4
INDIRI4
ASGNI4
line 1798
;1798:	}
LABELV $782
line 1800
;1799:#endif
;1800:	BotCheckItemPickup(bs, oldinventory);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckItemPickup
CALLV
pop
line 1801
;1801:}
LABELV $687
endproc BotUpdateInventory 1332 12
export BotUpdateBattleInventory
proc BotUpdateBattleInventory 160 8
line 1808
;1802:
;1803:/*
;1804:==================
;1805:BotUpdateBattleInventory
;1806:==================
;1807:*/
;1808:void BotUpdateBattleInventory(bot_state_t *bs, int enemy) {
line 1812
;1809:	vec3_t dir;
;1810:	aas_entityinfo_t entinfo;
;1811:
;1812:	BotEntityInfo(enemy, &entinfo);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1813
;1813:	VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12+24
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12+24+4
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 12+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1814
;1814:	bs->inventory[ENEMY_HEIGHT] = (int) dir[2];
ADDRFP4 0
INDIRP4
CNSTI4 5756
ADDP4
ADDRLP4 0+8
INDIRF4
CVFI4 4
ASGNI4
line 1815
;1815:	dir[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 1816
;1816:	bs->inventory[ENEMY_HORIZONTAL_DIST] = (int) VectorLength(dir);
ADDRLP4 0
ARGP4
ADDRLP4 156
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 5752
ADDP4
ADDRLP4 156
INDIRF4
CVFI4 4
ASGNI4
line 1818
;1817:	//FIXME: add num visible enemies and num visible team mates to the inventory
;1818:}
LABELV $783
endproc BotUpdateBattleInventory 160 8
export BotUseKamikaze
proc BotUseKamikaze 284 28
line 1828
;1819:
;1820:#ifdef MISSIONPACK
;1821:/*
;1822:==================
;1823:BotUseKamikaze
;1824:==================
;1825:*/
;1826:#define KAMIKAZE_DIST		1024
;1827:
;1828:void BotUseKamikaze(bot_state_t *bs) {
line 1836
;1829:	int c, teammates, enemies;
;1830:	aas_entityinfo_t entinfo;
;1831:	vec3_t dir, target;
;1832:	bot_goal_t *goal;
;1833:	bsp_trace_t trace;
;1834:
;1835:	//if the bot has no kamikaze
;1836:	if (bs->inventory[INVENTORY_KAMIKAZE] <= 0)
ADDRFP4 0
INDIRP4
CNSTI4 5080
ADDP4
INDIRI4
CNSTI4 0
GTI4 $794
line 1837
;1837:		return;
ADDRGP4 $793
JUMPV
LABELV $794
line 1838
;1838:	if (bs->kamikaze_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6104
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $796
line 1839
;1839:		return;
ADDRGP4 $793
JUMPV
LABELV $796
line 1840
;1840:	bs->kamikaze_time = FloatTime() + 0.2;
ADDRFP4 0
INDIRP4
CNSTI4 6104
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 1841
;1841:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $798
line 1843
;1842:		//never use kamikaze if the team flag carrier is visible
;1843:		if (BotCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
EQI4 $800
line 1844
;1844:			return;
ADDRGP4 $793
JUMPV
LABELV $800
line 1845
;1845:		c = BotTeamFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 268
ADDRGP4 BotTeamFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 268
INDIRI4
ASGNI4
line 1846
;1846:		if (c >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $802
line 1847
;1847:			BotEntityInfo(c, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1848
;1848:			VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 272
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16+24
INDIRF4
ADDRLP4 272
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 16+24+4
INDIRF4
ADDRLP4 272
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 16+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1849
;1849:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST))
ADDRLP4 4
ARGP4
ADDRLP4 276
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 276
INDIRF4
CNSTF4 1233125376
GEF4 $811
line 1850
;1850:				return;
ADDRGP4 $793
JUMPV
LABELV $811
line 1851
;1851:		}
LABELV $802
line 1852
;1852:		c = BotEnemyFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
ADDRGP4 BotEnemyFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 272
INDIRI4
ASGNI4
line 1853
;1853:		if (c >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $799
line 1854
;1854:			BotEntityInfo(c, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1855
;1855:			VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 276
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16+24
INDIRF4
ADDRLP4 276
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 16+24+4
INDIRF4
ADDRLP4 276
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 16+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1856
;1856:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST)) {
ADDRLP4 4
ARGP4
ADDRLP4 280
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 280
INDIRF4
CNSTF4 1233125376
GEF4 $799
line 1857
;1857:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 1858
;1858:				return;
ADDRGP4 $793
JUMPV
line 1860
;1859:			}
;1860:		}
line 1861
;1861:	}
LABELV $798
line 1862
;1862:	else if (gametype == GT_1FCTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $824
line 1864
;1863:		//never use kamikaze if the team flag carrier is visible
;1864:		if (Bot1FCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
EQI4 $826
line 1865
;1865:			return;
ADDRGP4 $793
JUMPV
LABELV $826
line 1866
;1866:		c = BotTeamFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 268
ADDRGP4 BotTeamFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 268
INDIRI4
ASGNI4
line 1867
;1867:		if (c >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $828
line 1868
;1868:			BotEntityInfo(c, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1869
;1869:			VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 272
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16+24
INDIRF4
ADDRLP4 272
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 16+24+4
INDIRF4
ADDRLP4 272
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 16+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1870
;1870:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST))
ADDRLP4 4
ARGP4
ADDRLP4 276
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 276
INDIRF4
CNSTF4 1233125376
GEF4 $837
line 1871
;1871:				return;
ADDRGP4 $793
JUMPV
LABELV $837
line 1872
;1872:		}
LABELV $828
line 1873
;1873:		c = BotEnemyFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
ADDRGP4 BotEnemyFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 272
INDIRI4
ASGNI4
line 1874
;1874:		if (c >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $825
line 1875
;1875:			BotEntityInfo(c, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1876
;1876:			VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 276
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16+24
INDIRF4
ADDRLP4 276
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 16+24+4
INDIRF4
ADDRLP4 276
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 16+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1877
;1877:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST)) {
ADDRLP4 4
ARGP4
ADDRLP4 280
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 280
INDIRF4
CNSTF4 1233125376
GEF4 $825
line 1878
;1878:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 1879
;1879:				return;
ADDRGP4 $793
JUMPV
line 1881
;1880:			}
;1881:		}
line 1882
;1882:	}
LABELV $824
line 1883
;1883:	else if (gametype == GT_OBELISK) {
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $850
line 1884
;1884:		switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 268
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 264
ADDRLP4 268
INDIRI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 1
EQI4 $855
ADDRGP4 $852
JUMPV
LABELV $855
line 1885
;1885:			case TEAM_RED: goal = &blueobelisk; break;
ADDRLP4 176
ADDRGP4 blueobelisk
ASGNP4
ADDRGP4 $853
JUMPV
LABELV $852
line 1886
;1886:			default: goal = &redobelisk; break;
ADDRLP4 176
ADDRGP4 redobelisk
ASGNP4
LABELV $853
line 1889
;1887:		}
;1888:		//if the obelisk is visible
;1889:		VectorCopy(goal->origin, target);
ADDRLP4 164
ADDRLP4 176
INDIRP4
INDIRB
ASGNB 12
line 1890
;1890:		target[2] += 1;
ADDRLP4 164+8
ADDRLP4 164+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1891
;1891:		VectorSubtract(bs->origin, target, dir);
ADDRLP4 272
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 272
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 164
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 272
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 164+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 164+8
INDIRF4
SUBF4
ASGNF4
line 1892
;1892:		if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST * 0.9)) {
ADDRLP4 4
ARGP4
ADDRLP4 276
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 276
INDIRF4
CNSTF4 1229937705
GEF4 $851
line 1893
;1893:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
ADDRLP4 180
ARGP4
ADDRLP4 280
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 280
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 164
ARGP4
ADDRLP4 280
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 1894
;1894:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
ADDRLP4 180+8
INDIRF4
CNSTF4 1065353216
GEF4 $867
ADDRLP4 180+80
INDIRI4
ADDRLP4 176
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $851
LABELV $867
line 1895
;1895:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 1896
;1896:				return;
ADDRGP4 $793
JUMPV
line 1898
;1897:			}
;1898:		}
line 1899
;1899:	}
LABELV $850
line 1900
;1900:	else if (gametype == GT_HARVESTER) {
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $868
line 1902
;1901:		//
;1902:		if (BotHarvesterCarryingCubes(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 BotHarvesterCarryingCubes
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
EQI4 $870
line 1903
;1903:			return;
ADDRGP4 $793
JUMPV
LABELV $870
line 1905
;1904:		//never use kamikaze if a team mate carrying cubes is visible
;1905:		c = BotTeamCubeCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 268
ADDRGP4 BotTeamCubeCarrierVisible
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 268
INDIRI4
ASGNI4
line 1906
;1906:		if (c >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $872
line 1907
;1907:			BotEntityInfo(c, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1908
;1908:			VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 272
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16+24
INDIRF4
ADDRLP4 272
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 16+24+4
INDIRF4
ADDRLP4 272
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 16+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1909
;1909:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST))
ADDRLP4 4
ARGP4
ADDRLP4 276
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 276
INDIRF4
CNSTF4 1233125376
GEF4 $881
line 1910
;1910:				return;
ADDRGP4 $793
JUMPV
LABELV $881
line 1911
;1911:		}
LABELV $872
line 1912
;1912:		c = BotEnemyCubeCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
ADDRGP4 BotEnemyCubeCarrierVisible
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 272
INDIRI4
ASGNI4
line 1913
;1913:		if (c >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $883
line 1914
;1914:			BotEntityInfo(c, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1915
;1915:			VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 276
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16+24
INDIRF4
ADDRLP4 276
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 16+24+4
INDIRF4
ADDRLP4 276
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 16+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1916
;1916:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST)) {
ADDRLP4 4
ARGP4
ADDRLP4 280
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 280
INDIRF4
CNSTF4 1233125376
GEF4 $892
line 1917
;1917:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 1918
;1918:				return;
ADDRGP4 $793
JUMPV
LABELV $892
line 1920
;1919:			}
;1920:		}
LABELV $883
line 1921
;1921:	}
LABELV $868
LABELV $851
LABELV $825
LABELV $799
line 1923
;1922:	//
;1923:	BotVisibleTeamMatesAndEnemies(bs, &teammates, &enemies, KAMIKAZE_DIST);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 160
ARGP4
ADDRLP4 156
ARGP4
CNSTF4 1149239296
ARGF4
ADDRGP4 BotVisibleTeamMatesAndEnemies
CALLV
pop
line 1925
;1924:	//
;1925:	if (enemies > 2 && enemies > teammates+1) {
ADDRLP4 264
ADDRLP4 156
INDIRI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 2
LEI4 $894
ADDRLP4 264
INDIRI4
ADDRLP4 160
INDIRI4
CNSTI4 1
ADDI4
LEI4 $894
line 1926
;1926:		trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 1927
;1927:		return;
LABELV $894
line 1929
;1928:	}
;1929:}
LABELV $793
endproc BotUseKamikaze 284 28
export BotUseInvulnerability
proc BotUseInvulnerability 144 28
line 1936
;1930:
;1931:/*
;1932:==================
;1933:BotUseInvulnerability
;1934:==================
;1935:*/
;1936:void BotUseInvulnerability(bot_state_t *bs) {
line 1943
;1937:	int c;
;1938:	vec3_t dir, target;
;1939:	bot_goal_t *goal;
;1940:	bsp_trace_t trace;
;1941:
;1942:	//if the bot has no invulnerability
;1943:	if (bs->inventory[INVENTORY_INVULNERABILITY] <= 0)
ADDRFP4 0
INDIRP4
CNSTI4 5088
ADDP4
INDIRI4
CNSTI4 0
GTI4 $897
line 1944
;1944:		return;
ADDRGP4 $896
JUMPV
LABELV $897
line 1945
;1945:	if (bs->invulnerability_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6108
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $899
line 1946
;1946:		return;
ADDRGP4 $896
JUMPV
LABELV $899
line 1947
;1947:	bs->invulnerability_time = FloatTime() + 0.2;
ADDRFP4 0
INDIRP4
CNSTI4 6108
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 1948
;1948:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $901
line 1950
;1949:		//never use kamikaze if the team flag carrier is visible
;1950:		if (BotCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 116
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
EQI4 $903
line 1951
;1951:			return;
ADDRGP4 $896
JUMPV
LABELV $903
line 1952
;1952:		c = BotEnemyFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 120
ADDRGP4 BotEnemyFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 120
INDIRI4
ASGNI4
line 1953
;1953:		if (c >= 0)
ADDRLP4 24
INDIRI4
CNSTI4 0
LTI4 $905
line 1954
;1954:			return;
ADDRGP4 $896
JUMPV
LABELV $905
line 1956
;1955:		//if near enemy flag and the flag is visible
;1956:		switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 128
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 124
ADDRLP4 128
INDIRI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 1
EQI4 $910
ADDRGP4 $907
JUMPV
LABELV $910
line 1957
;1957:			case TEAM_RED: goal = &ctf_blueflag; break;
ADDRLP4 28
ADDRGP4 ctf_blueflag
ASGNP4
ADDRGP4 $908
JUMPV
LABELV $907
line 1958
;1958:			default: goal = &ctf_redflag; break;
ADDRLP4 28
ADDRGP4 ctf_redflag
ASGNP4
LABELV $908
line 1961
;1959:		}
;1960:		//if the obelisk is visible
;1961:		VectorCopy(goal->origin, target);
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRB
ASGNB 12
line 1962
;1962:		target[2] += 1;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1963
;1963:		VectorSubtract(bs->origin, target, dir);
ADDRLP4 132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 132
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 132
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 1964
;1964:		if (VectorLengthSquared(dir) < Square(200)) {
ADDRLP4 12
ARGP4
ADDRLP4 136
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 136
INDIRF4
CNSTF4 1193033728
GEF4 $902
line 1965
;1965:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
ADDRLP4 32
ARGP4
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 1966
;1966:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
ADDRLP4 32+8
INDIRF4
CNSTF4 1065353216
GEF4 $922
ADDRLP4 32+80
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $902
LABELV $922
line 1967
;1967:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 1968
;1968:				return;
ADDRGP4 $896
JUMPV
line 1970
;1969:			}
;1970:		}
line 1971
;1971:	}
LABELV $901
line 1972
;1972:	else if (gametype == GT_1FCTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $923
line 1974
;1973:		//never use kamikaze if the team flag carrier is visible
;1974:		if (Bot1FCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 116
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
EQI4 $925
line 1975
;1975:			return;
ADDRGP4 $896
JUMPV
LABELV $925
line 1976
;1976:		c = BotEnemyFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 120
ADDRGP4 BotEnemyFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 120
INDIRI4
ASGNI4
line 1977
;1977:		if (c >= 0)
ADDRLP4 24
INDIRI4
CNSTI4 0
LTI4 $927
line 1978
;1978:			return;
ADDRGP4 $896
JUMPV
LABELV $927
line 1980
;1979:		//if near enemy flag and the flag is visible
;1980:		switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 128
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 124
ADDRLP4 128
INDIRI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 1
EQI4 $932
ADDRGP4 $929
JUMPV
LABELV $932
line 1981
;1981:			case TEAM_RED: goal = &ctf_blueflag; break;
ADDRLP4 28
ADDRGP4 ctf_blueflag
ASGNP4
ADDRGP4 $930
JUMPV
LABELV $929
line 1982
;1982:			default: goal = &ctf_redflag; break;
ADDRLP4 28
ADDRGP4 ctf_redflag
ASGNP4
LABELV $930
line 1985
;1983:		}
;1984:		//if the obelisk is visible
;1985:		VectorCopy(goal->origin, target);
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRB
ASGNB 12
line 1986
;1986:		target[2] += 1;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1987
;1987:		VectorSubtract(bs->origin, target, dir);
ADDRLP4 132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 132
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 132
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 1988
;1988:		if (VectorLengthSquared(dir) < Square(200)) {
ADDRLP4 12
ARGP4
ADDRLP4 136
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 136
INDIRF4
CNSTF4 1193033728
GEF4 $924
line 1989
;1989:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
ADDRLP4 32
ARGP4
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 1990
;1990:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
ADDRLP4 32+8
INDIRF4
CNSTF4 1065353216
GEF4 $944
ADDRLP4 32+80
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $924
LABELV $944
line 1991
;1991:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 1992
;1992:				return;
ADDRGP4 $896
JUMPV
line 1994
;1993:			}
;1994:		}
line 1995
;1995:	}
LABELV $923
line 1996
;1996:	else if (gametype == GT_OBELISK) {
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $945
line 1997
;1997:		switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 120
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 116
ADDRLP4 120
INDIRI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 1
EQI4 $950
ADDRGP4 $947
JUMPV
LABELV $950
line 1998
;1998:			case TEAM_RED: goal = &blueobelisk; break;
ADDRLP4 28
ADDRGP4 blueobelisk
ASGNP4
ADDRGP4 $948
JUMPV
LABELV $947
line 1999
;1999:			default: goal = &redobelisk; break;
ADDRLP4 28
ADDRGP4 redobelisk
ASGNP4
LABELV $948
line 2002
;2000:		}
;2001:		//if the obelisk is visible
;2002:		VectorCopy(goal->origin, target);
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRB
ASGNB 12
line 2003
;2003:		target[2] += 1;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2004
;2004:		VectorSubtract(bs->origin, target, dir);
ADDRLP4 124
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 124
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 124
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 2005
;2005:		if (VectorLengthSquared(dir) < Square(300)) {
ADDRLP4 12
ARGP4
ADDRLP4 128
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 128
INDIRF4
CNSTF4 1202702336
GEF4 $946
line 2006
;2006:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
ADDRLP4 32
ARGP4
ADDRLP4 132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 132
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 132
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2007
;2007:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
ADDRLP4 32+8
INDIRF4
CNSTF4 1065353216
GEF4 $962
ADDRLP4 32+80
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $946
LABELV $962
line 2008
;2008:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 2009
;2009:				return;
ADDRGP4 $896
JUMPV
line 2011
;2010:			}
;2011:		}
line 2012
;2012:	}
LABELV $945
line 2013
;2013:	else if (gametype == GT_HARVESTER) {
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $963
line 2015
;2014:		//
;2015:		if (BotHarvesterCarryingCubes(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 116
ADDRGP4 BotHarvesterCarryingCubes
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
EQI4 $965
line 2016
;2016:			return;
ADDRGP4 $896
JUMPV
LABELV $965
line 2017
;2017:		c = BotEnemyCubeCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 120
ADDRGP4 BotEnemyCubeCarrierVisible
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 120
INDIRI4
ASGNI4
line 2018
;2018:		if (c >= 0)
ADDRLP4 24
INDIRI4
CNSTI4 0
LTI4 $967
line 2019
;2019:			return;
ADDRGP4 $896
JUMPV
LABELV $967
line 2021
;2020:		//if near enemy base and enemy base is visible
;2021:		switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 128
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 124
ADDRLP4 128
INDIRI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 1
EQI4 $972
ADDRGP4 $969
JUMPV
LABELV $972
line 2022
;2022:			case TEAM_RED: goal = &blueobelisk; break;
ADDRLP4 28
ADDRGP4 blueobelisk
ASGNP4
ADDRGP4 $970
JUMPV
LABELV $969
line 2023
;2023:			default: goal = &redobelisk; break;
ADDRLP4 28
ADDRGP4 redobelisk
ASGNP4
LABELV $970
line 2026
;2024:		}
;2025:		//if the obelisk is visible
;2026:		VectorCopy(goal->origin, target);
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRB
ASGNB 12
line 2027
;2027:		target[2] += 1;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2028
;2028:		VectorSubtract(bs->origin, target, dir);
ADDRLP4 132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 132
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 132
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 2029
;2029:		if (VectorLengthSquared(dir) < Square(200)) {
ADDRLP4 12
ARGP4
ADDRLP4 136
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 136
INDIRF4
CNSTF4 1193033728
GEF4 $978
line 2030
;2030:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
ADDRLP4 32
ARGP4
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2031
;2031:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
ADDRLP4 32+8
INDIRF4
CNSTF4 1065353216
GEF4 $984
ADDRLP4 32+80
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $980
LABELV $984
line 2032
;2032:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 2033
;2033:				return;
LABELV $980
line 2035
;2034:			}
;2035:		}
LABELV $978
line 2036
;2036:	}
LABELV $963
LABELV $946
LABELV $924
LABELV $902
line 2037
;2037:}
LABELV $896
endproc BotUseInvulnerability 144 28
export BotBattleUseItems
proc BotBattleUseItems 12 4
line 2045
;2038:#endif
;2039:
;2040:/*
;2041:==================
;2042:BotBattleUseItems
;2043:==================
;2044:*/
;2045:void BotBattleUseItems(bot_state_t *bs) {
line 2046
;2046:	if (bs->inventory[INVENTORY_HEALTH] < 40) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 40
GEI4 $986
line 2047
;2047:		if (bs->inventory[INVENTORY_TELEPORTER] > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 5072
ADDP4
INDIRI4
CNSTI4 0
LEI4 $988
line 2048
;2048:			if (!BotCTFCarryingFlag(bs)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $990
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $990
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotHarvesterCarryingCubes
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $990
line 2053
;2049:#ifdef MISSIONPACK
;2050:				&& !Bot1FCTFCarryingFlag(bs)
;2051:				&& !BotHarvesterCarryingCubes(bs)
;2052:#endif
;2053:				) {
line 2054
;2054:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 2055
;2055:			}
LABELV $990
line 2056
;2056:		}
LABELV $988
line 2057
;2057:	}
LABELV $986
line 2058
;2058:	if (bs->inventory[INVENTORY_HEALTH] < 60) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 60
GEI4 $992
line 2059
;2059:		if (bs->inventory[INVENTORY_MEDKIT] > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 5076
ADDP4
INDIRI4
CNSTI4 0
LEI4 $994
line 2060
;2060:			trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 2061
;2061:		}
LABELV $994
line 2062
;2062:	}
LABELV $992
line 2064
;2063:#ifdef MISSIONPACK
;2064:	BotUseKamikaze(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotUseKamikaze
CALLV
pop
line 2065
;2065:	BotUseInvulnerability(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotUseInvulnerability
CALLV
pop
line 2067
;2066:#endif
;2067:}
LABELV $985
endproc BotBattleUseItems 12 4
export BotSetTeleportTime
proc BotSetTeleportTime 8 0
line 2074
;2068:
;2069:/*
;2070:==================
;2071:BotSetTeleportTime
;2072:==================
;2073:*/
;2074:void BotSetTeleportTime(bot_state_t *bs) {
line 2075
;2075:	if ((bs->cur_ps.eFlags ^ bs->last_eFlags) & EF_TELEPORT_BIT) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $997
line 2076
;2076:		bs->teleport_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6180
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2077
;2077:	}
LABELV $997
line 2078
;2078:	bs->last_eFlags = bs->cur_ps.eFlags;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 484
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
ASGNI4
line 2079
;2079:}
LABELV $996
endproc BotSetTeleportTime 8 0
export BotIsDead
proc BotIsDead 4 0
line 2086
;2080:
;2081:/*
;2082:==================
;2083:BotIsDead
;2084:==================
;2085:*/
;2086:qboolean BotIsDead(bot_state_t *bs) {
line 2087
;2087:	return (bs->cur_ps.pm_type == PM_DEAD);
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1001
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1002
JUMPV
LABELV $1001
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1002
ADDRLP4 0
INDIRI4
RETI4
LABELV $999
endproc BotIsDead 4 0
export BotIsObserver
proc BotIsObserver 1032 12
line 2095
;2088:}
;2089:
;2090:/*
;2091:==================
;2092:BotIsObserver
;2093:==================
;2094:*/
;2095:qboolean BotIsObserver(bot_state_t *bs) {
line 2097
;2096:	char buf[MAX_INFO_STRING];
;2097:	if (bs->cur_ps.pm_type == PM_SPECTATOR) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1004
CNSTI4 1
RETI4
ADDRGP4 $1003
JUMPV
LABELV $1004
line 2098
;2098:	trap_GetConfigstring(CS_PLAYERS+bs->client, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 2099
;2099:	if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) return qtrue;
ADDRLP4 0
ARGP4
ADDRGP4 $69
ARGP4
ADDRLP4 1024
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRLP4 1028
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 3
NEI4 $1006
CNSTI4 1
RETI4
ADDRGP4 $1003
JUMPV
LABELV $1006
line 2100
;2100:	return qfalse;
CNSTI4 0
RETI4
LABELV $1003
endproc BotIsObserver 1032 12
export BotIntermission
proc BotIntermission 8 0
line 2108
;2101:}
;2102:
;2103:/*
;2104:==================
;2105:BotIntermission
;2106:==================
;2107:*/
;2108:qboolean BotIntermission(bot_state_t *bs) {
line 2110
;2109:	//NOTE: we shouldn't be looking at the game code...
;2110:	if (level.intermissiontime) return qtrue;
ADDRGP4 level+7604
INDIRI4
CNSTI4 0
EQI4 $1009
CNSTI4 1
RETI4
ADDRGP4 $1008
JUMPV
LABELV $1009
line 2111
;2111:	return (bs->cur_ps.pm_type == PM_FREEZE || bs->cur_ps.pm_type == PM_INTERMISSION);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 4
EQI4 $1015
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1013
LABELV $1015
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1014
JUMPV
LABELV $1013
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1014
ADDRLP4 0
INDIRI4
RETI4
LABELV $1008
endproc BotIntermission 8 0
export BotInLavaOrSlime
proc BotInLavaOrSlime 16 4
line 2119
;2112:}
;2113:
;2114:/*
;2115:==================
;2116:BotInLavaOrSlime
;2117:==================
;2118:*/
;2119:qboolean BotInLavaOrSlime(bot_state_t *bs) {
line 2122
;2120:	vec3_t feet;
;2121:
;2122:	VectorCopy(bs->origin, feet);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 2123
;2123:	feet[2] -= 23;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1102577664
SUBF4
ASGNF4
line 2124
;2124:	return (trap_AAS_PointContents(feet) & (CONTENTS_LAVA|CONTENTS_SLIME));
ADDRLP4 0
ARGP4
ADDRLP4 12
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 24
BANDI4
RETI4
LABELV $1016
endproc BotInLavaOrSlime 16 4
data
align 4
LABELV $1019
byte 4 3238002688
byte 4 3238002688
byte 4 3238002688
align 4
LABELV $1020
byte 4 1090519040
byte 4 1090519040
byte 4 1090519040
export BotCreateWayPoint
code
proc BotCreateWayPoint 32 12
line 2132
;2125:}
;2126:
;2127:/*
;2128:==================
;2129:BotCreateWayPoint
;2130:==================
;2131:*/
;2132:bot_waypoint_t *BotCreateWayPoint(char *name, vec3_t origin, int areanum) {
line 2134
;2133:	bot_waypoint_t *wp;
;2134:	vec3_t waypointmins = {-8, -8, -8}, waypointmaxs = {8, 8, 8};
ADDRLP4 4
ADDRGP4 $1019
INDIRB
ASGNB 12
ADDRLP4 16
ADDRGP4 $1020
INDIRB
ASGNB 12
line 2136
;2135:
;2136:	wp = botai_freewaypoints;
ADDRLP4 0
ADDRGP4 botai_freewaypoints
INDIRP4
ASGNP4
line 2137
;2137:	if ( !wp ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1021
line 2138
;2138:		BotAI_Print( PRT_WARNING, "BotCreateWayPoint: Out of waypoints\n" );
CNSTI4 2
ARGI4
ADDRGP4 $1023
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 2139
;2139:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $1018
JUMPV
LABELV $1021
line 2141
;2140:	}
;2141:	botai_freewaypoints = botai_freewaypoints->next;
ADDRLP4 28
ADDRGP4 botai_freewaypoints
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
line 2143
;2142:
;2143:	Q_strncpyz( wp->name, name, sizeof(wp->name) );
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2144
;2144:	VectorCopy(origin, wp->goal.origin);
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 2145
;2145:	VectorCopy(waypointmins, wp->goal.mins);
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 2146
;2146:	VectorCopy(waypointmaxs, wp->goal.maxs);
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 16
INDIRB
ASGNB 12
line 2147
;2147:	wp->goal.areanum = areanum;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 2148
;2148:	wp->next = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
CNSTP4 0
ASGNP4
line 2149
;2149:	wp->prev = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
CNSTP4 0
ASGNP4
line 2150
;2150:	return wp;
ADDRLP4 0
INDIRP4
RETP4
LABELV $1018
endproc BotCreateWayPoint 32 12
export BotFindWayPoint
proc BotFindWayPoint 8 8
line 2158
;2151:}
;2152:
;2153:/*
;2154:==================
;2155:BotFindWayPoint
;2156:==================
;2157:*/
;2158:bot_waypoint_t *BotFindWayPoint(bot_waypoint_t *waypoints, char *name) {
line 2161
;2159:	bot_waypoint_t *wp;
;2160:
;2161:	for (wp = waypoints; wp; wp = wp->next) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $1028
JUMPV
LABELV $1025
line 2162
;2162:		if (!Q_stricmp(wp->name, name)) return wp;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1029
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $1024
JUMPV
LABELV $1029
line 2163
;2163:	}
LABELV $1026
line 2161
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
LABELV $1028
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1025
line 2164
;2164:	return NULL;
CNSTP4 0
RETP4
LABELV $1024
endproc BotFindWayPoint 8 8
export BotFreeWaypoints
proc BotFreeWaypoints 4 0
line 2172
;2165:}
;2166:
;2167:/*
;2168:==================
;2169:BotFreeWaypoints
;2170:==================
;2171:*/
;2172:void BotFreeWaypoints(bot_waypoint_t *wp) {
line 2175
;2173:	bot_waypoint_t *nextwp;
;2174:
;2175:	for (; wp; wp = nextwp) {
ADDRGP4 $1035
JUMPV
LABELV $1032
line 2176
;2176:		nextwp = wp->next;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
line 2177
;2177:		wp->next = botai_freewaypoints;
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRGP4 botai_freewaypoints
INDIRP4
ASGNP4
line 2178
;2178:		botai_freewaypoints = wp;
ADDRGP4 botai_freewaypoints
ADDRFP4 0
INDIRP4
ASGNP4
line 2179
;2179:	}
LABELV $1033
line 2175
ADDRFP4 0
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $1035
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1032
line 2180
;2180:}
LABELV $1031
endproc BotFreeWaypoints 4 0
export BotInitWaypoints
proc BotInitWaypoints 4 0
line 2187
;2181:
;2182:/*
;2183:==================
;2184:BotInitWaypoints
;2185:==================
;2186:*/
;2187:void BotInitWaypoints(void) {
line 2190
;2188:	int i;
;2189:
;2190:	botai_freewaypoints = NULL;
ADDRGP4 botai_freewaypoints
CNSTP4 0
ASGNP4
line 2191
;2191:	for (i = 0; i < MAX_WAYPOINTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1037
line 2192
;2192:		botai_waypoints[i].next = botai_freewaypoints;
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 botai_waypoints+92
ADDP4
ADDRGP4 botai_freewaypoints
INDIRP4
ASGNP4
line 2193
;2193:		botai_freewaypoints = &botai_waypoints[i];
ADDRGP4 botai_freewaypoints
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 botai_waypoints
ADDP4
ASGNP4
line 2194
;2194:	}
LABELV $1038
line 2191
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 128
LTI4 $1037
line 2195
;2195:}
LABELV $1036
endproc BotInitWaypoints 4 0
export TeamPlayIsOn
proc TeamPlayIsOn 4 0
line 2202
;2196:
;2197:/*
;2198:==================
;2199:TeamPlayIsOn
;2200:==================
;2201:*/
;2202:int TeamPlayIsOn(void) {
line 2203
;2203:	return ( gametype >= GT_TEAM );
ADDRGP4 gametype
INDIRI4
CNSTI4 3
LTI4 $1044
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1045
JUMPV
LABELV $1044
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1045
ADDRLP4 0
INDIRI4
RETI4
LABELV $1042
endproc TeamPlayIsOn 4 0
export BotAggression
proc BotAggression 28 0
line 2211
;2204:}
;2205:
;2206:/*
;2207:==================
;2208:BotAggression
;2209:==================
;2210:*/
;2211:float BotAggression(bot_state_t *bs) {
line 2213
;2212:	//if the bot has quad
;2213:	if (bs->inventory[INVENTORY_QUAD]) {
ADDRFP4 0
INDIRP4
CNSTI4 5092
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1047
line 2215
;2214:		//if the bot is not holding the gauntlet or the enemy is really nearby
;2215:		if (bs->weaponnum != WP_GAUNTLET ||
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1051
ADDRLP4 0
INDIRP4
CNSTI4 5752
ADDP4
INDIRI4
CNSTI4 80
GEI4 $1049
LABELV $1051
line 2216
;2216:			bs->inventory[ENEMY_HORIZONTAL_DIST] < 80) {
line 2217
;2217:			return 70;
CNSTF4 1116471296
RETF4
ADDRGP4 $1046
JUMPV
LABELV $1049
line 2219
;2218:		}
;2219:	}
LABELV $1047
line 2221
;2220:	//if the enemy is located way higher than the bot
;2221:	if (bs->inventory[ENEMY_HEIGHT] > 200) return 0;
ADDRFP4 0
INDIRP4
CNSTI4 5756
ADDP4
INDIRI4
CNSTI4 200
LEI4 $1052
CNSTF4 0
RETF4
ADDRGP4 $1046
JUMPV
LABELV $1052
line 2223
;2222:	//if the bot is very low on health
;2223:	if (bs->inventory[INVENTORY_HEALTH] < 60) return 0;
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 60
GEI4 $1054
CNSTF4 0
RETF4
ADDRGP4 $1046
JUMPV
LABELV $1054
line 2225
;2224:	//if the bot is low on health
;2225:	if (bs->inventory[INVENTORY_HEALTH] < 80) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 80
GEI4 $1056
line 2227
;2226:		//if the bot has insufficient armor
;2227:		if (bs->inventory[INVENTORY_ARMOR] < 40) return 0;
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
CNSTI4 40
GEI4 $1058
CNSTF4 0
RETF4
ADDRGP4 $1046
JUMPV
LABELV $1058
line 2228
;2228:	}
LABELV $1056
line 2230
;2229:	//if the bot can use the bfg
;2230:	if (bs->inventory[INVENTORY_BFG10K] > 0 &&
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 5004
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1060
ADDRLP4 0
INDIRP4
CNSTI4 5052
ADDP4
INDIRI4
CNSTI4 7
LEI4 $1060
line 2231
;2231:			bs->inventory[INVENTORY_BFGAMMO] > 7) return 100;
CNSTF4 1120403456
RETF4
ADDRGP4 $1046
JUMPV
LABELV $1060
line 2233
;2232:	//if the bot can use the railgun
;2233:	if (bs->inventory[INVENTORY_RAILGUN] > 0 &&
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4992
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1062
ADDRLP4 4
INDIRP4
CNSTI4 5048
ADDP4
INDIRI4
CNSTI4 5
LEI4 $1062
line 2234
;2234:			bs->inventory[INVENTORY_SLUGS] > 5) return 95;
CNSTF4 1119748096
RETF4
ADDRGP4 $1046
JUMPV
LABELV $1062
line 2236
;2235:	//if the bot can use the lightning gun
;2236:	if (bs->inventory[INVENTORY_LIGHTNING] > 0 &&
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 4988
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1064
ADDRLP4 8
INDIRP4
CNSTI4 5040
ADDP4
INDIRI4
CNSTI4 50
LEI4 $1064
line 2237
;2237:			bs->inventory[INVENTORY_LIGHTNINGAMMO] > 50) return 90;
CNSTF4 1119092736
RETF4
ADDRGP4 $1046
JUMPV
LABELV $1064
line 2239
;2238:	//if the bot can use the rocketlauncher
;2239:	if (bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 &&
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1066
ADDRLP4 12
INDIRP4
CNSTI4 5044
ADDP4
INDIRI4
CNSTI4 5
LEI4 $1066
line 2240
;2240:			bs->inventory[INVENTORY_ROCKETS] > 5) return 90;
CNSTF4 1119092736
RETF4
ADDRGP4 $1046
JUMPV
LABELV $1066
line 2242
;2241:	//if the bot can use the plasmagun
;2242:	if (bs->inventory[INVENTORY_PLASMAGUN] > 0 &&
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 4996
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1068
ADDRLP4 16
INDIRP4
CNSTI4 5036
ADDP4
INDIRI4
CNSTI4 40
LEI4 $1068
line 2243
;2243:			bs->inventory[INVENTORY_CELLS] > 40) return 85;
CNSTF4 1118437376
RETF4
ADDRGP4 $1046
JUMPV
LABELV $1068
line 2245
;2244:	//if the bot can use the grenade launcher
;2245:	if (bs->inventory[INVENTORY_GRENADELAUNCHER] > 0 &&
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 4980
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1070
ADDRLP4 20
INDIRP4
CNSTI4 5032
ADDP4
INDIRI4
CNSTI4 10
LEI4 $1070
line 2246
;2246:			bs->inventory[INVENTORY_GRENADES] > 10) return 80;
CNSTF4 1117782016
RETF4
ADDRGP4 $1046
JUMPV
LABELV $1070
line 2248
;2247:	//if the bot can use the shotgun
;2248:	if (bs->inventory[INVENTORY_SHOTGUN] > 0 &&
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 4972
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1072
ADDRLP4 24
INDIRP4
CNSTI4 5024
ADDP4
INDIRI4
CNSTI4 10
LEI4 $1072
line 2249
;2249:			bs->inventory[INVENTORY_SHELLS] > 10) return 50;
CNSTF4 1112014848
RETF4
ADDRGP4 $1046
JUMPV
LABELV $1072
line 2251
;2250:	//otherwise the bot is not feeling too good
;2251:	return 0;
CNSTF4 0
RETF4
LABELV $1046
endproc BotAggression 28 0
export BotFeelingBad
proc BotFeelingBad 0 0
line 2259
;2252:}
;2253:
;2254:/*
;2255:==================
;2256:BotFeelingBad
;2257:==================
;2258:*/
;2259:float BotFeelingBad(bot_state_t *bs) {
line 2260
;2260:	if (bs->weaponnum == WP_GAUNTLET) {
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1075
line 2261
;2261:		return 100;
CNSTF4 1120403456
RETF4
ADDRGP4 $1074
JUMPV
LABELV $1075
line 2263
;2262:	}
;2263:	if (bs->inventory[INVENTORY_HEALTH] < 40) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 40
GEI4 $1077
line 2264
;2264:		return 100;
CNSTF4 1120403456
RETF4
ADDRGP4 $1074
JUMPV
LABELV $1077
line 2266
;2265:	}
;2266:	if (bs->weaponnum == WP_MACHINEGUN) {
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1079
line 2267
;2267:		return 90;
CNSTF4 1119092736
RETF4
ADDRGP4 $1074
JUMPV
LABELV $1079
line 2269
;2268:	}
;2269:	if (bs->inventory[INVENTORY_HEALTH] < 60) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 60
GEI4 $1081
line 2270
;2270:		return 80;
CNSTF4 1117782016
RETF4
ADDRGP4 $1074
JUMPV
LABELV $1081
line 2272
;2271:	}
;2272:	return 0;
CNSTF4 0
RETF4
LABELV $1074
endproc BotFeelingBad 0 0
export BotWantsToRetreat
proc BotWantsToRetreat 144 8
line 2280
;2273:}
;2274:
;2275:/*
;2276:==================
;2277:BotWantsToRetreat
;2278:==================
;2279:*/
;2280:int BotWantsToRetreat(bot_state_t *bs) {
line 2283
;2281:	aas_entityinfo_t entinfo;
;2282:
;2283:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $1084
line 2285
;2284:		//always retreat when carrying a CTF flag
;2285:		if (BotCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1085
line 2286
;2286:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1083
JUMPV
line 2287
;2287:	}
LABELV $1084
line 2289
;2288:#ifdef MISSIONPACK
;2289:	else if (gametype == GT_1FCTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $1088
line 2291
;2290:		//if carrying the flag then always retreat
;2291:		if (Bot1FCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1089
line 2292
;2292:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1083
JUMPV
line 2293
;2293:	}
LABELV $1088
line 2294
;2294:	else if (gametype == GT_OBELISK) {
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $1092
line 2296
;2295:		//the bots should be dedicated to attacking the enemy obelisk
;2296:		if (bs->ltgtype == LTG_ATTACKENEMYBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 13
NEI4 $1094
line 2297
;2297:			if (bs->enemy != redobelisk.entitynum &&
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ADDRGP4 redobelisk+40
INDIRI4
EQI4 $1096
ADDRLP4 140
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ADDRGP4 blueobelisk+40
INDIRI4
EQI4 $1096
line 2298
;2298:						bs->enemy != blueobelisk.entitynum) {
line 2299
;2299:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1083
JUMPV
LABELV $1096
line 2301
;2300:			}
;2301:		}
LABELV $1094
line 2302
;2302:		if (BotFeelingBad(bs) > 50) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotFeelingBad
CALLF4
ASGNF4
ADDRLP4 140
INDIRF4
CNSTF4 1112014848
LEF4 $1100
line 2303
;2303:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1083
JUMPV
LABELV $1100
line 2305
;2304:		}
;2305:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1083
JUMPV
LABELV $1092
line 2307
;2306:	}
;2307:	else if (gametype == GT_HARVESTER) {
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $1102
line 2309
;2308:		//if carrying cubes then always retreat
;2309:		if (BotHarvesterCarryingCubes(bs)) return qtrue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotHarvesterCarryingCubes
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1104
CNSTI4 1
RETI4
ADDRGP4 $1083
JUMPV
LABELV $1104
line 2310
;2310:	}
LABELV $1102
LABELV $1089
LABELV $1085
line 2313
;2311:#endif
;2312:	//
;2313:	if (bs->enemy >= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
CNSTI4 0
LTI4 $1106
line 2315
;2314:		//if the enemy is carrying a flag
;2315:		BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2316
;2316:		if (EntityCarriesFlag(&entinfo))
ADDRLP4 0
ARGP4
ADDRLP4 140
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1108
line 2317
;2317:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1083
JUMPV
LABELV $1108
line 2318
;2318:	}
LABELV $1106
line 2320
;2319:	//if the bot is getting the flag
;2320:	if (bs->ltgtype == LTG_GETFLAG)
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
NEI4 $1110
line 2321
;2321:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1083
JUMPV
LABELV $1110
line 2323
;2322:	//
;2323:	if (BotAggression(bs) < 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 140
INDIRF4
CNSTF4 1112014848
GEF4 $1112
line 2324
;2324:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1083
JUMPV
LABELV $1112
line 2325
;2325:	return qfalse;
CNSTI4 0
RETI4
LABELV $1083
endproc BotWantsToRetreat 144 8
export BotWantsToChase
proc BotWantsToChase 148 8
line 2333
;2326:}
;2327:
;2328:/*
;2329:==================
;2330:BotWantsToChase
;2331:==================
;2332:*/
;2333:int BotWantsToChase(bot_state_t *bs) {
line 2336
;2334:	aas_entityinfo_t entinfo;
;2335:
;2336:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $1115
line 2338
;2337:		//never chase when carrying a CTF flag
;2338:		if (BotCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1117
line 2339
;2339:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1114
JUMPV
LABELV $1117
line 2341
;2340:		//always chase if the enemy is carrying a flag
;2341:		BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2342
;2342:		if (EntityCarriesFlag(&entinfo))
ADDRLP4 0
ARGP4
ADDRLP4 144
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $1116
line 2343
;2343:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1114
JUMPV
line 2344
;2344:	}
LABELV $1115
line 2346
;2345:#ifdef MISSIONPACK
;2346:	else if (gametype == GT_1FCTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $1121
line 2348
;2347:		//never chase if carrying the flag
;2348:		if (Bot1FCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1123
line 2349
;2349:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1114
JUMPV
LABELV $1123
line 2351
;2350:		//always chase if the enemy is carrying a flag
;2351:		BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2352
;2352:		if (EntityCarriesFlag(&entinfo))
ADDRLP4 0
ARGP4
ADDRLP4 144
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $1122
line 2353
;2353:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1114
JUMPV
line 2354
;2354:	}
LABELV $1121
line 2355
;2355:	else if (gametype == GT_OBELISK) {
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $1127
line 2357
;2356:		//the bots should be dedicated to attacking the enemy obelisk
;2357:		if (bs->ltgtype == LTG_ATTACKENEMYBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 13
NEI4 $1128
line 2358
;2358:			if (bs->enemy != redobelisk.entitynum &&
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ADDRGP4 redobelisk+40
INDIRI4
EQI4 $1128
ADDRLP4 140
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ADDRGP4 blueobelisk+40
INDIRI4
EQI4 $1128
line 2359
;2359:						bs->enemy != blueobelisk.entitynum) {
line 2360
;2360:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1114
JUMPV
line 2362
;2361:			}
;2362:		}
line 2363
;2363:	}
LABELV $1127
line 2364
;2364:	else if (gametype == GT_HARVESTER) {
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $1135
line 2366
;2365:		//never chase if carrying cubes
;2366:		if (BotHarvesterCarryingCubes(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotHarvesterCarryingCubes
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1137
line 2367
;2367:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1114
JUMPV
LABELV $1137
line 2368
;2368:	}
LABELV $1135
LABELV $1128
LABELV $1122
LABELV $1116
line 2371
;2369:#endif
;2370:	//if the bot is getting the flag
;2371:	if (bs->ltgtype == LTG_GETFLAG)
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
NEI4 $1139
line 2372
;2372:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1114
JUMPV
LABELV $1139
line 2374
;2373:	//
;2374:	if (BotAggression(bs) > 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 140
INDIRF4
CNSTF4 1112014848
LEF4 $1141
line 2375
;2375:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1114
JUMPV
LABELV $1141
line 2376
;2376:	return qfalse;
CNSTI4 0
RETI4
LABELV $1114
endproc BotWantsToChase 148 8
export BotWantsToHelp
proc BotWantsToHelp 0 0
line 2384
;2377:}
;2378:
;2379:/*
;2380:==================
;2381:BotWantsToHelp
;2382:==================
;2383:*/
;2384:int BotWantsToHelp(bot_state_t *bs) {
line 2385
;2385:	return qtrue;
CNSTI4 1
RETI4
LABELV $1143
endproc BotWantsToHelp 0 0
export BotCanAndWantsToRocketJump
proc BotCanAndWantsToRocketJump 8 16
line 2393
;2386:}
;2387:
;2388:/*
;2389:==================
;2390:BotCanAndWantsToRocketJump
;2391:==================
;2392:*/
;2393:int BotCanAndWantsToRocketJump(bot_state_t *bs) {
line 2397
;2394:	float rocketjumper;
;2395:
;2396:	//if rocket jumping is disabled
;2397:	if (!bot_rocketjump.integer) return qfalse;
ADDRGP4 bot_rocketjump+12
INDIRI4
CNSTI4 0
NEI4 $1145
CNSTI4 0
RETI4
ADDRGP4 $1144
JUMPV
LABELV $1145
line 2399
;2398:	//if no rocket launcher
;2399:	if (bs->inventory[INVENTORY_ROCKETLAUNCHER] <= 0) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1148
CNSTI4 0
RETI4
ADDRGP4 $1144
JUMPV
LABELV $1148
line 2401
;2400:	//if low on rockets
;2401:	if (bs->inventory[INVENTORY_ROCKETS] < 3) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5044
ADDP4
INDIRI4
CNSTI4 3
GEI4 $1150
CNSTI4 0
RETI4
ADDRGP4 $1144
JUMPV
LABELV $1150
line 2403
;2402:	//never rocket jump with the Quad
;2403:	if (bs->inventory[INVENTORY_QUAD]) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5092
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1152
CNSTI4 0
RETI4
ADDRGP4 $1144
JUMPV
LABELV $1152
line 2405
;2404:	//if low on health
;2405:	if (bs->inventory[INVENTORY_HEALTH] < 60) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 60
GEI4 $1154
CNSTI4 0
RETI4
ADDRGP4 $1144
JUMPV
LABELV $1154
line 2407
;2406:	//if not full health
;2407:	if (bs->inventory[INVENTORY_HEALTH] < 90) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 90
GEI4 $1156
line 2409
;2408:		//if the bot has insufficient armor
;2409:		if (bs->inventory[INVENTORY_ARMOR] < 40) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
CNSTI4 40
GEI4 $1158
CNSTI4 0
RETI4
ADDRGP4 $1144
JUMPV
LABELV $1158
line 2410
;2410:	}
LABELV $1156
line 2411
;2411:	rocketjumper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_WEAPONJUMPING, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 38
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 4
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 2412
;2412:	if (rocketjumper < 0.5) return qfalse;
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
GEF4 $1160
CNSTI4 0
RETI4
ADDRGP4 $1144
JUMPV
LABELV $1160
line 2413
;2413:	return qtrue;
CNSTI4 1
RETI4
LABELV $1144
endproc BotCanAndWantsToRocketJump 8 16
export BotHasPersistantPowerupAndWeapon
proc BotHasPersistantPowerupAndWeapon 36 0
line 2421
;2414:}
;2415:
;2416:/*
;2417:==================
;2418:BotHasPersistantPowerupAndWeapon
;2419:==================
;2420:*/
;2421:int BotHasPersistantPowerupAndWeapon(bot_state_t *bs) {
line 2424
;2422:#ifdef MISSIONPACK
;2423:	// if the bot does not have a persistant powerup
;2424:	if (!bs->inventory[INVENTORY_SCOUT] &&
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 5116
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1163
ADDRLP4 0
INDIRP4
CNSTI4 5120
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1163
ADDRLP4 0
INDIRP4
CNSTI4 5124
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1163
ADDRLP4 0
INDIRP4
CNSTI4 5128
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1163
line 2427
;2425:		!bs->inventory[INVENTORY_GUARD] &&
;2426:		!bs->inventory[INVENTORY_DOUBLER] &&
;2427:		!bs->inventory[INVENTORY_AMMOREGEN] ) {
line 2428
;2428:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1162
JUMPV
LABELV $1163
line 2432
;2429:	}
;2430:#endif
;2431:	//if the bot is very low on health
;2432:	if (bs->inventory[INVENTORY_HEALTH] < 60) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 60
GEI4 $1165
CNSTI4 0
RETI4
ADDRGP4 $1162
JUMPV
LABELV $1165
line 2434
;2433:	//if the bot is low on health
;2434:	if (bs->inventory[INVENTORY_HEALTH] < 80) {
ADDRFP4 0
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 80
GEI4 $1167
line 2436
;2435:		//if the bot has insufficient armor
;2436:		if (bs->inventory[INVENTORY_ARMOR] < 40) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
CNSTI4 40
GEI4 $1169
CNSTI4 0
RETI4
ADDRGP4 $1162
JUMPV
LABELV $1169
line 2437
;2437:	}
LABELV $1167
line 2439
;2438:	//if the bot can use the bfg
;2439:	if (bs->inventory[INVENTORY_BFG10K] > 0 &&
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 5004
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1171
ADDRLP4 4
INDIRP4
CNSTI4 5052
ADDP4
INDIRI4
CNSTI4 7
LEI4 $1171
line 2440
;2440:			bs->inventory[INVENTORY_BFGAMMO] > 7) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1162
JUMPV
LABELV $1171
line 2442
;2441:	//if the bot can use the railgun
;2442:	if (bs->inventory[INVENTORY_RAILGUN] > 0 &&
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 4992
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1173
ADDRLP4 8
INDIRP4
CNSTI4 5048
ADDP4
INDIRI4
CNSTI4 5
LEI4 $1173
line 2443
;2443:			bs->inventory[INVENTORY_SLUGS] > 5) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1162
JUMPV
LABELV $1173
line 2445
;2444:	//if the bot can use the lightning gun
;2445:	if (bs->inventory[INVENTORY_LIGHTNING] > 0 &&
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4988
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1175
ADDRLP4 12
INDIRP4
CNSTI4 5040
ADDP4
INDIRI4
CNSTI4 50
LEI4 $1175
line 2446
;2446:			bs->inventory[INVENTORY_LIGHTNINGAMMO] > 50) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1162
JUMPV
LABELV $1175
line 2448
;2447:	//if the bot can use the rocketlauncher
;2448:	if (bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 &&
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1177
ADDRLP4 16
INDIRP4
CNSTI4 5044
ADDP4
INDIRI4
CNSTI4 5
LEI4 $1177
line 2449
;2449:			bs->inventory[INVENTORY_ROCKETS] > 5) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1162
JUMPV
LABELV $1177
line 2451
;2450:	//
;2451:	if (bs->inventory[INVENTORY_NAILGUN] > 0 &&
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 5012
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1179
ADDRLP4 20
INDIRP4
CNSTI4 5056
ADDP4
INDIRI4
CNSTI4 5
LEI4 $1179
line 2452
;2452:			bs->inventory[INVENTORY_NAILS] > 5) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1162
JUMPV
LABELV $1179
line 2454
;2453:	//
;2454:	if (bs->inventory[INVENTORY_PROXLAUNCHER] > 0 &&
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 5016
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1181
ADDRLP4 24
INDIRP4
CNSTI4 5060
ADDP4
INDIRI4
CNSTI4 5
LEI4 $1181
line 2455
;2455:			bs->inventory[INVENTORY_MINES] > 5) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1162
JUMPV
LABELV $1181
line 2457
;2456:	//
;2457:	if (bs->inventory[INVENTORY_CHAINGUN] > 0 &&
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 5020
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1183
ADDRLP4 28
INDIRP4
CNSTI4 5064
ADDP4
INDIRI4
CNSTI4 40
LEI4 $1183
line 2458
;2458:			bs->inventory[INVENTORY_BELT] > 40) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1162
JUMPV
LABELV $1183
line 2460
;2459:	//if the bot can use the plasmagun
;2460:	if (bs->inventory[INVENTORY_PLASMAGUN] > 0 &&
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 4996
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1185
ADDRLP4 32
INDIRP4
CNSTI4 5036
ADDP4
INDIRI4
CNSTI4 20
LEI4 $1185
line 2461
;2461:			bs->inventory[INVENTORY_CELLS] > 20) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1162
JUMPV
LABELV $1185
line 2462
;2462:	return qfalse;
CNSTI4 0
RETI4
LABELV $1162
endproc BotHasPersistantPowerupAndWeapon 36 0
export BotGoCamp
proc BotGoCamp 16 16
line 2470
;2463:}
;2464:
;2465:/*
;2466:==================
;2467:BotGoCamp
;2468:==================
;2469:*/
;2470:void BotGoCamp(bot_state_t *bs, bot_goal_t *goal) {
line 2473
;2471:	float camper;
;2472:
;2473:	bs->decisionmaker = bs->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 2475
;2474:	//set message time to zero so bot will NOT show any message
;2475:	bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 2477
;2476:	//set the ltg type
;2477:	bs->ltgtype = LTG_CAMP;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 7
ASGNI4
line 2479
;2478:	//set the team goal
;2479:	memcpy(&bs->teamgoal, goal, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTU4 56
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 2481
;2480:	//get the team goal time
;2481:	camper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CAMPER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 44
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 8
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 2482
;2482:	if (camper > 0.99) bs->teamgoal_time = FloatTime() + 99999;
ADDRLP4 0
INDIRF4
CNSTF4 1065185444
LEF4 $1188
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1203982208
ADDF4
ASGNF4
ADDRGP4 $1189
JUMPV
LABELV $1188
line 2483
;2483:	else bs->teamgoal_time = FloatTime() + 120 + 180 * camper + random() * 15;
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ADDRLP4 0
INDIRF4
CNSTF4 1127481344
MULF4
ADDF4
ADDRLP4 12
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 972030432
MULF4
ADDF4
ASGNF4
LABELV $1189
line 2485
;2484:	//set the last time the bot started camping
;2485:	bs->camp_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6184
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2487
;2486:	//the teammate that requested the camping
;2487:	bs->teammate = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
CNSTI4 0
ASGNI4
line 2489
;2488:	//do NOT type arrive message
;2489:	bs->arrive_time = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6172
ADDP4
CNSTF4 1065353216
ASGNF4
line 2490
;2490:}
LABELV $1187
endproc BotGoCamp 16 16
export BotWantsToCamp
proc BotWantsToCamp 172 16
line 2497
;2491:
;2492:/*
;2493:==================
;2494:BotWantsToCamp
;2495:==================
;2496:*/
;2497:int BotWantsToCamp(bot_state_t *bs) {
line 2502
;2498:	float camper;
;2499:	int cs, traveltime, besttraveltime;
;2500:	bot_goal_t goal, bestgoal;
;2501:
;2502:	camper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CAMPER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 44
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 128
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 124
ADDRLP4 128
INDIRF4
ASGNF4
line 2503
;2503:	if (camper < 0.1) return qfalse;
ADDRLP4 124
INDIRF4
CNSTF4 1036831949
GEF4 $1191
CNSTI4 0
RETI4
ADDRGP4 $1190
JUMPV
LABELV $1191
line 2505
;2504:	//if the bot has a team goal
;2505:	if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 132
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 1
EQI4 $1201
ADDRLP4 132
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1201
ADDRLP4 132
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 3
EQI4 $1201
ADDRLP4 132
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
EQI4 $1201
ADDRLP4 132
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $1201
ADDRLP4 132
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 7
EQI4 $1201
ADDRLP4 132
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 8
EQI4 $1201
ADDRLP4 132
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 9
NEI4 $1193
LABELV $1201
line 2512
;2506:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;2507:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;2508:			bs->ltgtype == LTG_GETFLAG ||
;2509:			bs->ltgtype == LTG_RUSHBASE ||
;2510:			bs->ltgtype == LTG_CAMP ||
;2511:			bs->ltgtype == LTG_CAMPORDER ||
;2512:			bs->ltgtype == LTG_PATROL) {
line 2513
;2513:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1190
JUMPV
LABELV $1193
line 2516
;2514:	}
;2515:	//if camped recently
;2516:	if (bs->camp_time > FloatTime() - 60 + 300 * (1-camper)) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6184
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
SUBF4
CNSTF4 1065353216
ADDRLP4 124
INDIRF4
SUBF4
CNSTF4 1133903872
MULF4
ADDF4
LEF4 $1202
CNSTI4 0
RETI4
ADDRGP4 $1190
JUMPV
LABELV $1202
line 2518
;2517:	//
;2518:	if (random() > camper) {
ADDRLP4 136
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ADDRLP4 124
INDIRF4
LEF4 $1204
line 2519
;2519:		bs->camp_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6184
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2520
;2520:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1190
JUMPV
LABELV $1204
line 2523
;2521:	}
;2522:	//if the bot isn't healthy anough
;2523:	if (BotAggression(bs) < 50) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 140
INDIRF4
CNSTF4 1112014848
GEF4 $1206
CNSTI4 0
RETI4
ADDRGP4 $1190
JUMPV
LABELV $1206
line 2525
;2524:	//the bot should have at least have the rocket launcher, the railgun or the bfg10k with some ammo
;2525:	if ((bs->inventory[INVENTORY_ROCKETLAUNCHER] <= 0 || bs->inventory[INVENTORY_ROCKETS] < 10) &&
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1210
ADDRLP4 144
INDIRP4
CNSTI4 5044
ADDP4
INDIRI4
CNSTI4 10
GEI4 $1208
LABELV $1210
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 148
INDIRP4
CNSTI4 4992
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1211
ADDRLP4 148
INDIRP4
CNSTI4 5048
ADDP4
INDIRI4
CNSTI4 10
GEI4 $1208
LABELV $1211
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 152
INDIRP4
CNSTI4 5004
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1212
ADDRLP4 152
INDIRP4
CNSTI4 5052
ADDP4
INDIRI4
CNSTI4 10
GEI4 $1208
LABELV $1212
line 2527
;2526:		(bs->inventory[INVENTORY_RAILGUN] <= 0 || bs->inventory[INVENTORY_SLUGS] < 10) &&
;2527:		(bs->inventory[INVENTORY_BFG10K] <= 0 || bs->inventory[INVENTORY_BFGAMMO] < 10)) {
line 2528
;2528:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1190
JUMPV
LABELV $1208
line 2531
;2529:	}
;2530:	//find the closest camp spot
;2531:	besttraveltime = 99999;
ADDRLP4 64
CNSTI4 99999
ASGNI4
line 2532
;2532:	for (cs = trap_BotGetNextCampSpotGoal(0, &goal); cs; cs = trap_BotGetNextCampSpotGoal(cs, &goal)) {
CNSTI4 0
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 156
ADDRGP4 trap_BotGetNextCampSpotGoal
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 156
INDIRI4
ASGNI4
ADDRGP4 $1216
JUMPV
LABELV $1213
line 2533
;2533:		traveltime = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, goal.areanum, TFL_DEFAULT);
ADDRLP4 160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 160
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 8+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 164
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 164
INDIRI4
ASGNI4
line 2534
;2534:		if (traveltime && traveltime < besttraveltime) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1218
ADDRLP4 0
INDIRI4
ADDRLP4 64
INDIRI4
GEI4 $1218
line 2535
;2535:			besttraveltime = traveltime;
ADDRLP4 64
ADDRLP4 0
INDIRI4
ASGNI4
line 2536
;2536:			memcpy(&bestgoal, &goal, sizeof(bot_goal_t));
ADDRLP4 68
ARGP4
ADDRLP4 8
ARGP4
CNSTU4 56
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 2537
;2537:		}
LABELV $1218
line 2538
;2538:	}
LABELV $1214
line 2532
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 160
ADDRGP4 trap_BotGetNextCampSpotGoal
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 160
INDIRI4
ASGNI4
LABELV $1216
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1213
line 2539
;2539:	if (besttraveltime > 150) return qfalse;
ADDRLP4 64
INDIRI4
CNSTI4 150
LEI4 $1220
CNSTI4 0
RETI4
ADDRGP4 $1190
JUMPV
LABELV $1220
line 2541
;2540:	//ok found a camp spot, go camp there
;2541:	BotGoCamp(bs, &bestgoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 BotGoCamp
CALLV
pop
line 2542
;2542:	bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 2544
;2543:	//
;2544:	return qtrue;
CNSTI4 1
RETI4
LABELV $1190
endproc BotWantsToCamp 172 16
export BotDontAvoid
proc BotDontAvoid 68 12
line 2552
;2545:}
;2546:
;2547:/*
;2548:==================
;2549:BotDontAvoid
;2550:==================
;2551:*/
;2552:void BotDontAvoid(bot_state_t *bs, char *itemname) {
line 2556
;2553:	bot_goal_t goal;
;2554:	int num;
;2555:
;2556:	num = trap_BotGetLevelItemGoal(-1, itemname, &goal);
CNSTI4 -1
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 60
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 60
INDIRI4
ASGNI4
ADDRGP4 $1224
JUMPV
LABELV $1223
line 2557
;2557:	while(num >= 0) {
line 2558
;2558:		trap_BotRemoveFromAvoidGoals(bs->gs, goal.number);
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRLP4 4+44
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveFromAvoidGoals
CALLV
pop
line 2559
;2559:		num = trap_BotGetLevelItemGoal(num, itemname, &goal);
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 64
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 64
INDIRI4
ASGNI4
line 2560
;2560:	}
LABELV $1224
line 2557
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1223
line 2561
;2561:}
LABELV $1222
endproc BotDontAvoid 68 12
export BotGoForPowerups
proc BotGoForPowerups 0 8
line 2568
;2562:
;2563:/*
;2564:==================
;2565:BotGoForPowerups
;2566:==================
;2567:*/
;2568:void BotGoForPowerups(bot_state_t *bs) {
line 2571
;2569:
;2570:	//don't avoid any of the powerups anymore
;2571:	BotDontAvoid(bs, "Quad Damage");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1228
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2572
;2572:	BotDontAvoid(bs, "Regeneration");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1229
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2573
;2573:	BotDontAvoid(bs, "Battle Suit");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1230
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2574
;2574:	BotDontAvoid(bs, "Speed");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1231
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2575
;2575:	BotDontAvoid(bs, "Invisibility");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1232
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2579
;2576:	//BotDontAvoid(bs, "Flight");
;2577:	//reset the long term goal time so the bot will go for the powerup
;2578:	//NOTE: the long term goal type doesn't change
;2579:	bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6068
ADDP4
CNSTF4 0
ASGNF4
line 2580
;2580:}
LABELV $1227
endproc BotGoForPowerups 0 8
export BotRoamGoal
proc BotRoamGoal 168 28
line 2587
;2581:
;2582:/*
;2583:==================
;2584:BotRoamGoal
;2585:==================
;2586:*/
;2587:void BotRoamGoal(bot_state_t *bs, vec3_t goal) {
line 2593
;2588:	int pc, i;
;2589:	float len, rnd;
;2590:	vec3_t dir, bestorg, belowbestorg;
;2591:	bsp_trace_t trace;
;2592:
;2593:	for (i = 0; i < 10; i++) {
ADDRLP4 116
CNSTI4 0
ASGNI4
LABELV $1234
line 2595
;2594:		//start at the bot origin
;2595:		VectorCopy(bs->origin, bestorg);
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 2596
;2596:		rnd = random();
ADDRLP4 136
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 112
ADDRLP4 136
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ASGNF4
line 2597
;2597:		if (rnd > 0.25) {
ADDRLP4 112
INDIRF4
CNSTF4 1048576000
LEF4 $1238
line 2599
;2598:			//add a random value to the x-coordinate
;2599:			if (random() < 0.5) bestorg[0] -= 800 * random() + 100;
ADDRLP4 140
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
GEF4 $1240
ADDRLP4 144
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 144
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1145569280
MULF4
CNSTF4 1120403456
ADDF4
SUBF4
ASGNF4
ADDRGP4 $1241
JUMPV
LABELV $1240
line 2600
;2600:			else bestorg[0] += 800 * random() + 100;
ADDRLP4 148
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 148
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1145569280
MULF4
CNSTF4 1120403456
ADDF4
ADDF4
ASGNF4
LABELV $1241
line 2601
;2601:		}
LABELV $1238
line 2602
;2602:		if (rnd < 0.75) {
ADDRLP4 112
INDIRF4
CNSTF4 1061158912
GEF4 $1242
line 2604
;2603:			//add a random value to the y-coordinate
;2604:			if (random() < 0.5) bestorg[1] -= 800 * random() + 100;
ADDRLP4 140
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
GEF4 $1244
ADDRLP4 144
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 144
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1145569280
MULF4
CNSTF4 1120403456
ADDF4
SUBF4
ASGNF4
ADDRGP4 $1245
JUMPV
LABELV $1244
line 2605
;2605:			else bestorg[1] += 800 * random() + 100;
ADDRLP4 148
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 148
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1145569280
MULF4
CNSTF4 1120403456
ADDF4
ADDF4
ASGNF4
LABELV $1245
line 2606
;2606:		}
LABELV $1242
line 2608
;2607:		//add a random value to the z-coordinate (NOTE: 48 = maxjump?)
;2608:		bestorg[2] += 2 * 48 * crandom();
ADDRLP4 140
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 140
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
CNSTF4 1119879168
MULF4
ADDF4
ASGNF4
line 2610
;2609:		//trace a line from the origin to the roam target
;2610:		BotAI_Trace(&trace, bs->origin, NULL, NULL, bestorg, bs->entitynum, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2612
;2611:		//direction and length towards the roam target
;2612:		VectorSubtract(trace.endpos, bs->origin, dir);
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 24+12
INDIRF4
ADDRLP4 148
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 24+12+4
INDIRF4
ADDRLP4 148
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 24+12+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2613
;2613:		len = VectorNormalize(dir);
ADDRLP4 0
ARGP4
ADDRLP4 152
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 108
ADDRLP4 152
INDIRF4
ASGNF4
line 2615
;2614:		//if the roam target is far away anough
;2615:		if (len > 200) {
ADDRLP4 108
INDIRF4
CNSTF4 1128792064
LEF4 $1256
line 2617
;2616:			//the roam target is in the given direction before walls
;2617:			VectorScale(dir, len * trace.fraction - 40, dir);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
CNSTF4 1109393408
SUBF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
CNSTF4 1109393408
SUBF4
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
CNSTF4 1109393408
SUBF4
MULF4
ASGNF4
line 2618
;2618:			VectorAdd(bs->origin, dir, bestorg);
ADDRLP4 160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 160
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 160
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 2620
;2619:			//get the coordinates of the floor below the roam target
;2620:			belowbestorg[0] = bestorg[0];
ADDRLP4 120
ADDRLP4 12
INDIRF4
ASGNF4
line 2621
;2621:			belowbestorg[1] = bestorg[1];
ADDRLP4 120+4
ADDRLP4 12+4
INDIRF4
ASGNF4
line 2622
;2622:			belowbestorg[2] = bestorg[2] - 800;
ADDRLP4 120+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1145569280
SUBF4
ASGNF4
line 2623
;2623:			BotAI_Trace(&trace, bestorg, NULL, NULL, belowbestorg, bs->entitynum, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRLP4 12
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 120
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2625
;2624:			//
;2625:			if (!trace.startsolid) {
ADDRLP4 24+4
INDIRI4
CNSTI4 0
NEI4 $1273
line 2626
;2626:				trace.endpos[2]++;
ADDRLP4 24+12+8
ADDRLP4 24+12+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2627
;2627:				pc = trap_PointContents(trace.endpos, bs->entitynum);
ADDRLP4 24+12
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 164
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 132
ADDRLP4 164
INDIRI4
ASGNI4
line 2628
;2628:				if (!(pc & (CONTENTS_LAVA | CONTENTS_SLIME))) {
ADDRLP4 132
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
NEI4 $1279
line 2629
;2629:					VectorCopy(bestorg, goal);
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRB
ASGNB 12
line 2630
;2630:					return;
ADDRGP4 $1233
JUMPV
LABELV $1279
line 2632
;2631:				}
;2632:			}
LABELV $1273
line 2633
;2633:		}
LABELV $1256
line 2634
;2634:	}
LABELV $1235
line 2593
ADDRLP4 116
ADDRLP4 116
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 10
LTI4 $1234
line 2635
;2635:	VectorCopy(bestorg, goal);
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRB
ASGNB 12
line 2636
;2636:}
LABELV $1233
endproc BotRoamGoal 168 28
data
align 4
LABELV $1283
byte 4 0
byte 4 0
byte 4 1065353216
export BotAttackMove
code
proc BotAttackMove 392 16
line 2643
;2637:
;2638:/*
;2639:==================
;2640:BotAttackMove
;2641:==================
;2642:*/
;2643:bot_moveresult_t BotAttackMove(bot_state_t *bs, int tfl) {
line 2647
;2644:	int movetype, i, attackentity;
;2645:	float attack_skill, jumper, croucher, dist, strafechange_time;
;2646:	float attack_dist, attack_range;
;2647:	vec3_t forward, backward, sideward, hordir, up = {0, 0, 1};
ADDRLP4 56
ADDRGP4 $1283
INDIRB
ASGNB 12
line 2652
;2648:	aas_entityinfo_t entinfo;
;2649:	bot_moveresult_t moveresult;
;2650:	bot_goal_t goal;
;2651:
;2652:	attackentity = bs->enemy;
ADDRLP4 332
ADDRFP4 4
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ASGNI4
line 2654
;2653:	//
;2654:	if (bs->attackchase_time > FloatTime()) {
ADDRFP4 4
INDIRP4
CNSTI4 6124
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $1284
line 2656
;2655:		//create the chase goal
;2656:		goal.entitynum = attackentity;
ADDRLP4 136+40
ADDRLP4 332
INDIRI4
ASGNI4
line 2657
;2657:		goal.areanum = bs->lastenemyareanum;
ADDRLP4 136+12
ADDRFP4 4
INDIRP4
CNSTI4 6544
ADDP4
INDIRI4
ASGNI4
line 2658
;2658:		VectorCopy(bs->lastenemyorigin, goal.origin);
ADDRLP4 136
ADDRFP4 4
INDIRP4
CNSTI4 6548
ADDP4
INDIRB
ASGNB 12
line 2659
;2659:		VectorSet(goal.mins, -8, -8, -8);
ADDRLP4 136+16
CNSTF4 3238002688
ASGNF4
ADDRLP4 136+16+4
CNSTF4 3238002688
ASGNF4
ADDRLP4 136+16+8
CNSTF4 3238002688
ASGNF4
line 2660
;2660:		VectorSet(goal.maxs, 8, 8, 8);
ADDRLP4 136+28
CNSTF4 1090519040
ASGNF4
ADDRLP4 136+28+4
CNSTF4 1090519040
ASGNF4
ADDRLP4 136+28+8
CNSTF4 1090519040
ASGNF4
line 2662
;2661:		//initialize the movement state
;2662:		BotSetupForMovement(bs);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 2664
;2663:		//move towards the goal
;2664:		trap_BotMoveToGoal(&moveresult, bs->ms, &goal, tfl);
ADDRLP4 80
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 136
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveToGoal
CALLV
pop
line 2665
;2665:		return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $1281
JUMPV
LABELV $1284
line 2668
;2666:	}
;2667:	//
;2668:	memset(&moveresult, 0, sizeof(bot_moveresult_t));
ADDRLP4 80
ARGP4
CNSTI4 0
ARGI4
CNSTU4 52
ARGU4
ADDRGP4 memset
CALLP4
pop
line 2670
;2669:	//
;2670:	attack_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_ATTACK_SKILL, 0, 1);
ADDRFP4 4
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 348
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 132
ADDRLP4 348
INDIRF4
ASGNF4
line 2671
;2671:	jumper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_JUMPER, 0, 1);
ADDRFP4 4
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 37
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 352
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 340
ADDRLP4 352
INDIRF4
ASGNF4
line 2672
;2672:	croucher = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CROUCHER, 0, 1);
ADDRFP4 4
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 36
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 356
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 344
ADDRLP4 356
INDIRF4
ASGNF4
line 2674
;2673:	//if the bot is really stupid
;2674:	if (attack_skill < 0.2) return moveresult;
ADDRLP4 132
INDIRF4
CNSTF4 1045220557
GEF4 $1298
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $1281
JUMPV
LABELV $1298
line 2676
;2675:	//initialize the movement state
;2676:	BotSetupForMovement(bs);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 2678
;2677:	//get the enemy entity info
;2678:	BotEntityInfo(attackentity, &entinfo);
ADDRLP4 332
INDIRI4
ARGI4
ADDRLP4 192
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2680
;2679:	//direction towards the enemy
;2680:	VectorSubtract(entinfo.origin, bs->origin, forward);
ADDRLP4 360
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 192+24
INDIRF4
ADDRLP4 360
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 192+24+4
INDIRF4
ADDRLP4 360
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 192+24+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2682
;2681:	//the distance towards the enemy
;2682:	dist = VectorNormalize(forward);
ADDRLP4 24
ARGP4
ADDRLP4 364
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 68
ADDRLP4 364
INDIRF4
ASGNF4
line 2683
;2683:	VectorNegate(forward, backward);
ADDRLP4 36
ADDRLP4 24
INDIRF4
NEGF4
ASGNF4
ADDRLP4 36+4
ADDRLP4 24+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 36+8
ADDRLP4 24+8
INDIRF4
NEGF4
ASGNF4
line 2685
;2684:	//walk, crouch or jump
;2685:	movetype = MOVE_WALK;
ADDRLP4 52
CNSTI4 1
ASGNI4
line 2687
;2686:	//
;2687:	if (bs->attackcrouch_time < FloatTime() - 1) {
ADDRFP4 4
INDIRP4
CNSTI4 6120
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $1311
line 2688
;2688:		if (random() < jumper) {
ADDRLP4 368
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ADDRLP4 340
INDIRF4
GEF4 $1313
line 2689
;2689:			movetype = MOVE_JUMP;
ADDRLP4 52
CNSTI4 4
ASGNI4
line 2690
;2690:		}
ADDRGP4 $1314
JUMPV
LABELV $1313
line 2692
;2691:		//wait at least one second before crouching again
;2692:		else if (bs->attackcrouch_time < FloatTime() - 1 && random() < croucher) {
ADDRFP4 4
INDIRP4
CNSTI4 6120
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $1315
ADDRLP4 372
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 372
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ADDRLP4 344
INDIRF4
GEF4 $1315
line 2693
;2693:			bs->attackcrouch_time = FloatTime() + croucher * 5;
ADDRFP4 4
INDIRP4
CNSTI4 6120
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 344
INDIRF4
CNSTF4 1084227584
MULF4
ADDF4
ASGNF4
line 2694
;2694:		}
LABELV $1315
LABELV $1314
line 2695
;2695:	}
LABELV $1311
line 2696
;2696:	if (bs->attackcrouch_time > FloatTime()) movetype = MOVE_CROUCH;
ADDRFP4 4
INDIRP4
CNSTI4 6120
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $1317
ADDRLP4 52
CNSTI4 2
ASGNI4
LABELV $1317
line 2698
;2697:	//if the bot should jump
;2698:	if (movetype == MOVE_JUMP) {
ADDRLP4 52
INDIRI4
CNSTI4 4
NEI4 $1319
line 2700
;2699:		//if jumped last frame
;2700:		if (bs->attackjump_time > FloatTime()) {
ADDRFP4 4
INDIRP4
CNSTI4 6128
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $1321
line 2701
;2701:			movetype = MOVE_WALK;
ADDRLP4 52
CNSTI4 1
ASGNI4
line 2702
;2702:		}
ADDRGP4 $1322
JUMPV
LABELV $1321
line 2703
;2703:		else {
line 2704
;2704:			bs->attackjump_time = FloatTime() + 1;
ADDRFP4 4
INDIRP4
CNSTI4 6128
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2705
;2705:		}
LABELV $1322
line 2706
;2706:	}
LABELV $1319
line 2707
;2707:	if (bs->cur_ps.weapon == WP_GAUNTLET) {
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1323
line 2708
;2708:		attack_dist = 0;
ADDRLP4 72
CNSTF4 0
ASGNF4
line 2709
;2709:		attack_range = 0;
ADDRLP4 76
CNSTF4 0
ASGNF4
line 2710
;2710:	}
ADDRGP4 $1324
JUMPV
LABELV $1323
line 2711
;2711:	else {
line 2712
;2712:		attack_dist = IDEAL_ATTACKDIST;
ADDRLP4 72
CNSTF4 1124859904
ASGNF4
line 2713
;2713:		attack_range = 40;
ADDRLP4 76
CNSTF4 1109393408
ASGNF4
line 2714
;2714:	}
LABELV $1324
line 2716
;2715:	//if the bot is stupid
;2716:	if (attack_skill <= 0.4) {
ADDRLP4 132
INDIRF4
CNSTF4 1053609165
GTF4 $1325
line 2718
;2717:		//just walk to or away from the enemy
;2718:		if (dist > attack_dist + attack_range) {
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
ADDF4
LEF4 $1327
line 2719
;2719:			if (trap_BotMoveInDirection(bs->ms, forward, 400, movetype)) return moveresult;
ADDRFP4 4
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 368
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 0
EQI4 $1329
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $1281
JUMPV
LABELV $1329
line 2720
;2720:		}
LABELV $1327
line 2721
;2721:		if (dist < attack_dist - attack_range) {
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
SUBF4
GEF4 $1331
line 2722
;2722:			if (trap_BotMoveInDirection(bs->ms, backward, 400, movetype)) return moveresult;
ADDRFP4 4
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 368
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 0
EQI4 $1333
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $1281
JUMPV
LABELV $1333
line 2723
;2723:		}
LABELV $1331
line 2724
;2724:		return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $1281
JUMPV
LABELV $1325
line 2727
;2725:	}
;2726:	//increase the strafe time
;2727:	bs->attackstrafe_time += bs->thinktime;
ADDRLP4 368
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 372
ADDRLP4 368
INDIRP4
CNSTI4 6116
ADDP4
ASGNP4
ADDRLP4 372
INDIRP4
ADDRLP4 372
INDIRP4
INDIRF4
ADDRLP4 368
INDIRP4
CNSTI4 4904
ADDP4
INDIRF4
ADDF4
ASGNF4
line 2729
;2728:	//get the strafe change time
;2729:	strafechange_time = 0.4 + (1 - attack_skill) * 0.2;
ADDRLP4 336
CNSTF4 1065353216
ADDRLP4 132
INDIRF4
SUBF4
CNSTF4 1045220557
MULF4
CNSTF4 1053609165
ADDF4
ASGNF4
line 2730
;2730:	if (attack_skill > 0.7) strafechange_time += crandom() * 0.2;
ADDRLP4 132
INDIRF4
CNSTF4 1060320051
LEF4 $1335
ADDRLP4 376
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 336
ADDRLP4 336
INDIRF4
ADDRLP4 376
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1053609165
MULF4
ADDF4
ASGNF4
LABELV $1335
line 2732
;2731:	//if the strafe direction should be changed
;2732:	if (bs->attackstrafe_time > strafechange_time) {
ADDRFP4 4
INDIRP4
CNSTI4 6116
ADDP4
INDIRF4
ADDRLP4 336
INDIRF4
LEF4 $1337
line 2734
;2733:		//some magic number :)
;2734:		if (random() > 0.935) {
ADDRLP4 380
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 380
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1064262697
LEF4 $1339
line 2736
;2735:			//flip the strafe direction
;2736:			bs->flags ^= BFL_STRAFERIGHT;
ADDRLP4 384
ADDRFP4 4
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 384
INDIRP4
ADDRLP4 384
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 2737
;2737:			bs->attackstrafe_time = 0;
ADDRFP4 4
INDIRP4
CNSTI4 6116
ADDP4
CNSTF4 0
ASGNF4
line 2738
;2738:		}
LABELV $1339
line 2739
;2739:	}
LABELV $1337
line 2741
;2740:	//
;2741:	for (i = 0; i < 2; i++) {
ADDRLP4 48
CNSTI4 0
ASGNI4
LABELV $1341
line 2742
;2742:		hordir[0] = forward[0];
ADDRLP4 12
ADDRLP4 24
INDIRF4
ASGNF4
line 2743
;2743:		hordir[1] = forward[1];
ADDRLP4 12+4
ADDRLP4 24+4
INDIRF4
ASGNF4
line 2744
;2744:		hordir[2] = 0;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 2745
;2745:		VectorNormalize(hordir);
ADDRLP4 12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 2747
;2746:		//get the sideward vector
;2747:		CrossProduct(hordir, up, sideward);
ADDRLP4 12
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 2749
;2748:		//reverse the vector depending on the strafe direction
;2749:		if (bs->flags & BFL_STRAFERIGHT) VectorNegate(sideward, sideward);
ADDRFP4 4
INDIRP4
CNSTI4 5980
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1348
ADDRLP4 0
ADDRLP4 0
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
NEGF4
ASGNF4
LABELV $1348
line 2751
;2750:		//randomly go back a little
;2751:		if (random() > 0.9) {
ADDRLP4 380
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 380
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1063675494
LEF4 $1354
line 2752
;2752:			VectorAdd(sideward, backward, sideward);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
ASGNF4
line 2753
;2753:		}
ADDRGP4 $1355
JUMPV
LABELV $1354
line 2754
;2754:		else {
line 2756
;2755:			//walk forward or backward to get at the ideal attack distance
;2756:			if (dist > attack_dist + attack_range) {
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
ADDF4
LEF4 $1362
line 2757
;2757:				VectorAdd(sideward, forward, sideward);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDF4
ASGNF4
line 2758
;2758:			}
ADDRGP4 $1363
JUMPV
LABELV $1362
line 2759
;2759:			else if (dist < attack_dist - attack_range) {
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
SUBF4
GEF4 $1370
line 2760
;2760:				VectorAdd(sideward, backward, sideward);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
ASGNF4
line 2761
;2761:			}
LABELV $1370
LABELV $1363
line 2762
;2762:		}
LABELV $1355
line 2764
;2763:		//perform the movement
;2764:		if (trap_BotMoveInDirection(bs->ms, sideward, 400, movetype))
ADDRFP4 4
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 384
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 384
INDIRI4
CNSTI4 0
EQI4 $1378
line 2765
;2765:			return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $1281
JUMPV
LABELV $1378
line 2767
;2766:		//movement failed, flip the strafe direction
;2767:		bs->flags ^= BFL_STRAFERIGHT;
ADDRLP4 388
ADDRFP4 4
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 388
INDIRP4
ADDRLP4 388
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 2768
;2768:		bs->attackstrafe_time = 0;
ADDRFP4 4
INDIRP4
CNSTI4 6116
ADDP4
CNSTF4 0
ASGNF4
line 2769
;2769:	}
LABELV $1342
line 2741
ADDRLP4 48
ADDRLP4 48
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 2
LTI4 $1341
line 2772
;2770:	//bot couldn't do any usefull movement
;2771://	bs->attackchase_time = AAS_Time() + 6;
;2772:	return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
LABELV $1281
endproc BotAttackMove 392 16
export BotSameTeam
proc BotSameTeam 0 0
line 2780
;2773:}
;2774:
;2775:/*
;2776:==================
;2777:BotSameTeam
;2778:==================
;2779:*/
;2780:int BotSameTeam(bot_state_t *bs, int entnum) {
line 2784
;2781:
;2782:	extern gclient_t g_clients[ MAX_CLIENTS ];
;2783:
;2784:	if ( (unsigned) bs->client >= MAX_CLIENTS ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CVIU4 4
CNSTU4 64
LTU4 $1381
line 2786
;2785:		//BotAI_Print(PRT_ERROR, "BotSameTeam: client out of range\n");
;2786:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1380
JUMPV
LABELV $1381
line 2788
;2787:	}
;2788:	if ( (unsigned) entnum >= MAX_CLIENTS ) {
ADDRFP4 4
INDIRI4
CVIU4 4
CNSTU4 64
LTU4 $1383
line 2790
;2789:		//BotAI_Print(PRT_ERROR, "BotSameTeam: client out of range\n");
;2790:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1380
JUMPV
LABELV $1383
line 2792
;2791:	}
;2792:	if ( gametype >= GT_TEAM ) {
ADDRGP4 gametype
INDIRI4
CNSTI4 3
LTI4 $1385
line 2793
;2793:		if ( g_clients[bs->client].sess.sessionTeam == g_clients[entnum].sess.sessionTeam )
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 g_clients+624
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 g_clients+624
ADDP4
INDIRI4
NEI4 $1387
line 2794
;2794:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1380
JUMPV
LABELV $1387
line 2795
;2795:	}
LABELV $1385
line 2796
;2796:	return qfalse;
CNSTI4 0
RETI4
LABELV $1380
endproc BotSameTeam 0 0
export InFieldOfVision
proc InFieldOfVision 28 4
line 2805
;2797:}
;2798:
;2799:/*
;2800:==================
;2801:InFieldOfVision
;2802:==================
;2803:*/
;2804:qboolean InFieldOfVision(vec3_t viewangles, float fov, vec3_t angles)
;2805:{
line 2809
;2806:	int i;
;2807:	float diff, angle;
;2808:
;2809:	for (i = 0; i < 2; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1392
line 2810
;2810:		angle = AngleMod(viewangles[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 12
INDIRF4
ASGNF4
line 2811
;2811:		angles[i] = AngleMod(angles[i]);
ADDRLP4 20
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
ADDP4
ADDRLP4 24
INDIRF4
ASGNF4
line 2812
;2812:		diff = angles[i] - angle;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
ASGNF4
line 2813
;2813:		if (angles[i] > angle) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $1396
line 2814
;2814:			if (diff > 180.0) diff -= 360.0;
ADDRLP4 4
INDIRF4
CNSTF4 1127481344
LEF4 $1397
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 2815
;2815:		}
ADDRGP4 $1397
JUMPV
LABELV $1396
line 2816
;2816:		else {
line 2817
;2817:			if (diff < -180.0) diff += 360.0;
ADDRLP4 4
INDIRF4
CNSTF4 3274964992
GEF4 $1400
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $1400
line 2818
;2818:		}
LABELV $1397
line 2819
;2819:		if (diff > 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $1402
line 2820
;2820:			if (diff > fov * 0.5) return qfalse;
ADDRLP4 4
INDIRF4
ADDRFP4 4
INDIRF4
CNSTF4 1056964608
MULF4
LEF4 $1403
CNSTI4 0
RETI4
ADDRGP4 $1391
JUMPV
line 2821
;2821:		}
LABELV $1402
line 2822
;2822:		else {
line 2823
;2823:			if (diff < -fov * 0.5) return qfalse;
ADDRLP4 4
INDIRF4
ADDRFP4 4
INDIRF4
NEGF4
CNSTF4 1056964608
MULF4
GEF4 $1406
CNSTI4 0
RETI4
ADDRGP4 $1391
JUMPV
LABELV $1406
line 2824
;2824:		}
LABELV $1403
line 2825
;2825:	}
LABELV $1393
line 2809
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $1392
line 2826
;2826:	return qtrue;
CNSTI4 1
RETI4
LABELV $1391
endproc InFieldOfVision 28 4
export BotEntityVisible
proc BotEntityVisible 360 28
line 2836
;2827:}
;2828:
;2829:/*
;2830:==================
;2831:BotEntityVisible
;2832:
;2833:returns visibility in the range [0, 1] taking fog and water surfaces into account
;2834:==================
;2835:*/
;2836:float BotEntityVisible(int viewer, vec3_t eye, vec3_t viewangles, float fov, int ent) {
line 2844
;2837:	int i, contents_mask, passent, hitent, infog, inwater, otherinfog, pc;
;2838:	float squaredfogdist, waterfactor, vis, bestvis;
;2839:	bsp_trace_t trace;
;2840:	aas_entityinfo_t entinfo;
;2841:	vec3_t dir, entangles, start, end, middle;
;2842:
;2843:	//calculate middle of bounding box
;2844:	BotEntityInfo(ent, &entinfo);
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 148
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2845
;2845:	if (!entinfo.valid)
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1409
line 2846
;2846:		return 0;
CNSTF4 0
RETF4
ADDRGP4 $1408
JUMPV
LABELV $1409
line 2847
;2847:	VectorAdd(entinfo.mins, entinfo.maxs, middle);
ADDRLP4 84
ADDRLP4 148+72
INDIRF4
ADDRLP4 148+84
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 148+72+4
INDIRF4
ADDRLP4 148+84+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+8
ADDRLP4 148+72+8
INDIRF4
ADDRLP4 148+84+8
INDIRF4
ADDF4
ASGNF4
line 2848
;2848:	VectorScale(middle, 0.5, middle);
ADDRLP4 84
ADDRLP4 84
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 84+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 84+8
ADDRLP4 84+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 2849
;2849:	VectorAdd(entinfo.origin, middle, middle);
ADDRLP4 84
ADDRLP4 148+24
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 148+24+4
INDIRF4
ADDRLP4 84+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+8
ADDRLP4 148+24+8
INDIRF4
ADDRLP4 84+8
INDIRF4
ADDF4
ASGNF4
line 2851
;2850:	//check if entity is within field of vision
;2851:	VectorSubtract(middle, eye, dir);
ADDRLP4 332
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 136
ADDRLP4 84
INDIRF4
ADDRLP4 332
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 84+4
INDIRF4
ADDRLP4 332
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+8
ADDRLP4 84+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2852
;2852:	vectoangles(dir, entangles);
ADDRLP4 136
ARGP4
ADDRLP4 320
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2853
;2853:	if (!InFieldOfVision(viewangles, fov, entangles)) return 0;
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 320
ARGP4
ADDRLP4 336
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 336
INDIRI4
CNSTI4 0
NEI4 $1440
CNSTF4 0
RETF4
ADDRGP4 $1408
JUMPV
LABELV $1440
line 2855
;2854:	//
;2855:	pc = trap_AAS_PointContents(eye);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 340
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 316
ADDRLP4 340
INDIRI4
ASGNI4
line 2856
;2856:	infog = (pc & CONTENTS_FOG);
ADDRLP4 312
ADDRLP4 316
INDIRI4
CNSTI4 64
BANDI4
ASGNI4
line 2857
;2857:	inwater = (pc & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER));
ADDRLP4 308
ADDRLP4 316
INDIRI4
CNSTI4 56
BANDI4
ASGNI4
line 2859
;2858:	//
;2859:	bestvis = 0;
ADDRLP4 296
CNSTF4 0
ASGNF4
line 2860
;2860:	for (i = 0; i < 3; i++) {
ADDRLP4 100
CNSTI4 0
ASGNI4
LABELV $1442
line 2864
;2861:		//if the point is not in potential visible sight
;2862:		//if (!AAS_inPVS(eye, middle)) continue;
;2863:		//
;2864:		contents_mask = CONTENTS_SOLID|CONTENTS_PLAYERCLIP;
ADDRLP4 96
CNSTI4 65537
ASGNI4
line 2865
;2865:		passent = viewer;
ADDRLP4 116
ADDRFP4 0
INDIRI4
ASGNI4
line 2866
;2866:		hitent = ent;
ADDRLP4 132
ADDRFP4 16
INDIRI4
ASGNI4
line 2867
;2867:		VectorCopy(eye, start);
ADDRLP4 120
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 2868
;2868:		VectorCopy(middle, end);
ADDRLP4 104
ADDRLP4 84
INDIRB
ASGNB 12
line 2870
;2869:		//if the entity is in water, lava or slime
;2870:		if (trap_AAS_PointContents(middle) & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER)) {
ADDRLP4 84
ARGP4
ADDRLP4 344
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 344
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $1446
line 2871
;2871:			contents_mask |= (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER);
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 56
BORI4
ASGNI4
line 2872
;2872:		}
LABELV $1446
line 2874
;2873:		//if eye is in water, lava or slime
;2874:		if (inwater) {
ADDRLP4 308
INDIRI4
CNSTI4 0
EQI4 $1448
line 2875
;2875:			if (!(contents_mask & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER))) {
ADDRLP4 96
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
NEI4 $1450
line 2876
;2876:				passent = ent;
ADDRLP4 116
ADDRFP4 16
INDIRI4
ASGNI4
line 2877
;2877:				hitent = viewer;
ADDRLP4 132
ADDRFP4 0
INDIRI4
ASGNI4
line 2878
;2878:				VectorCopy(middle, start);
ADDRLP4 120
ADDRLP4 84
INDIRB
ASGNB 12
line 2879
;2879:				VectorCopy(eye, end);
ADDRLP4 104
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 2880
;2880:			}
LABELV $1450
line 2881
;2881:			contents_mask ^= (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER);
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 56
BXORI4
ASGNI4
line 2882
;2882:		}
LABELV $1448
line 2884
;2883:		//trace from start to end
;2884:		BotAI_Trace(&trace, start, NULL, NULL, end, passent, contents_mask);
ADDRLP4 0
ARGP4
ADDRLP4 120
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 116
INDIRI4
ARGI4
ADDRLP4 96
INDIRI4
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2886
;2885:		//if water was hit
;2886:		waterfactor = 1.0;
ADDRLP4 288
CNSTF4 1065353216
ASGNF4
line 2887
;2887:		if (trace.contents & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER)) {
ADDRLP4 0+76
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $1452
line 2889
;2888:			//if the water surface is translucent
;2889:			if (1) {
line 2891
;2890:				//trace through the water
;2891:				contents_mask &= ~(CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER);
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 -57
BANDI4
ASGNI4
line 2892
;2892:				BotAI_Trace(&trace, trace.endpos, NULL, NULL, end, passent, contents_mask);
ADDRLP4 0
ARGP4
ADDRLP4 0+12
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 116
INDIRI4
ARGI4
ADDRLP4 96
INDIRI4
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2893
;2893:				waterfactor = 0.5;
ADDRLP4 288
CNSTF4 1056964608
ASGNF4
line 2894
;2894:			}
LABELV $1455
line 2895
;2895:		}
LABELV $1452
line 2897
;2896:		//if a full trace or the hitent was hit
;2897:		if (trace.fraction >= 1 || trace.ent == hitent) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
GEF4 $1462
ADDRLP4 0+80
INDIRI4
ADDRLP4 132
INDIRI4
NEI4 $1458
LABELV $1462
line 2900
;2898:			//check for fog, assuming there's only one fog brush where
;2899:			//either the viewer or the entity is in or both are in
;2900:			otherinfog = (trap_AAS_PointContents(middle) & CONTENTS_FOG);
ADDRLP4 84
ARGP4
ADDRLP4 348
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 304
ADDRLP4 348
INDIRI4
CNSTI4 64
BANDI4
ASGNI4
line 2901
;2901:			if (infog && otherinfog) {
ADDRLP4 312
INDIRI4
CNSTI4 0
EQI4 $1463
ADDRLP4 304
INDIRI4
CNSTI4 0
EQI4 $1463
line 2902
;2902:				VectorSubtract(trace.endpos, eye, dir);
ADDRLP4 352
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 136
ADDRLP4 0+12
INDIRF4
ADDRLP4 352
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 0+12+4
INDIRF4
ADDRLP4 352
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+8
ADDRLP4 0+12+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2903
;2903:				squaredfogdist = VectorLengthSquared(dir);
ADDRLP4 136
ARGP4
ADDRLP4 356
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 300
ADDRLP4 356
INDIRF4
ASGNF4
line 2904
;2904:			}
ADDRGP4 $1464
JUMPV
LABELV $1463
line 2905
;2905:			else if (infog) {
ADDRLP4 312
INDIRI4
CNSTI4 0
EQI4 $1472
line 2906
;2906:				VectorCopy(trace.endpos, start);
ADDRLP4 120
ADDRLP4 0+12
INDIRB
ASGNB 12
line 2907
;2907:				BotAI_Trace(&trace, start, NULL, NULL, eye, viewer, CONTENTS_FOG);
ADDRLP4 0
ARGP4
ADDRLP4 120
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2908
;2908:				VectorSubtract(eye, trace.endpos, dir);
ADDRLP4 352
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 136
ADDRLP4 352
INDIRP4
INDIRF4
ADDRLP4 0+12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 352
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0+12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0+12+8
INDIRF4
SUBF4
ASGNF4
line 2909
;2909:				squaredfogdist = VectorLengthSquared(dir);
ADDRLP4 136
ARGP4
ADDRLP4 356
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 300
ADDRLP4 356
INDIRF4
ASGNF4
line 2910
;2910:			}
ADDRGP4 $1473
JUMPV
LABELV $1472
line 2911
;2911:			else if (otherinfog) {
ADDRLP4 304
INDIRI4
CNSTI4 0
EQI4 $1482
line 2912
;2912:				VectorCopy(trace.endpos, end);
ADDRLP4 104
ADDRLP4 0+12
INDIRB
ASGNB 12
line 2913
;2913:				BotAI_Trace(&trace, eye, NULL, NULL, end, viewer, CONTENTS_FOG);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 104
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2914
;2914:				VectorSubtract(end, trace.endpos, dir);
ADDRLP4 136
ADDRLP4 104
INDIRF4
ADDRLP4 0+12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 104+4
INDIRF4
ADDRLP4 0+12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+8
ADDRLP4 104+8
INDIRF4
ADDRLP4 0+12+8
INDIRF4
SUBF4
ASGNF4
line 2915
;2915:				squaredfogdist = VectorLengthSquared(dir);
ADDRLP4 136
ARGP4
ADDRLP4 352
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 300
ADDRLP4 352
INDIRF4
ASGNF4
line 2916
;2916:			}
ADDRGP4 $1483
JUMPV
LABELV $1482
line 2917
;2917:			else {
line 2919
;2918:				//if the entity and the viewer are not in fog assume there's no fog in between
;2919:				squaredfogdist = 0;
ADDRLP4 300
CNSTF4 0
ASGNF4
line 2920
;2920:			}
LABELV $1483
LABELV $1473
LABELV $1464
line 2922
;2921:			//decrease visibility with the view distance through fog
;2922:			vis = 1 / ((squaredfogdist * 0.001) < 1 ? 1 : (squaredfogdist * 0.001));
ADDRLP4 300
INDIRF4
CNSTF4 981668463
MULF4
CNSTF4 1065353216
GEF4 $1495
ADDRLP4 352
CNSTF4 1065353216
ASGNF4
ADDRGP4 $1496
JUMPV
LABELV $1495
ADDRLP4 352
ADDRLP4 300
INDIRF4
CNSTF4 981668463
MULF4
ASGNF4
LABELV $1496
ADDRLP4 292
CNSTF4 1065353216
ADDRLP4 352
INDIRF4
DIVF4
ASGNF4
line 2924
;2923:			//if entering water visibility is reduced
;2924:			vis *= waterfactor;
ADDRLP4 292
ADDRLP4 292
INDIRF4
ADDRLP4 288
INDIRF4
MULF4
ASGNF4
line 2926
;2925:			//
;2926:			if (vis > bestvis) bestvis = vis;
ADDRLP4 292
INDIRF4
ADDRLP4 296
INDIRF4
LEF4 $1497
ADDRLP4 296
ADDRLP4 292
INDIRF4
ASGNF4
LABELV $1497
line 2928
;2927:			//if pretty much no fog
;2928:			if (bestvis >= 0.95) return bestvis;
ADDRLP4 296
INDIRF4
CNSTF4 1064514355
LTF4 $1499
ADDRLP4 296
INDIRF4
RETF4
ADDRGP4 $1408
JUMPV
LABELV $1499
line 2929
;2929:		}
LABELV $1458
line 2931
;2930:		//check bottom and top of bounding box as well
;2931:		if (i == 0) middle[2] += entinfo.mins[2];
ADDRLP4 100
INDIRI4
CNSTI4 0
NEI4 $1501
ADDRLP4 84+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 148+72+8
INDIRF4
ADDF4
ASGNF4
ADDRGP4 $1502
JUMPV
LABELV $1501
line 2932
;2932:		else if (i == 1) middle[2] += entinfo.maxs[2] - entinfo.mins[2];
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $1506
ADDRLP4 84+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 148+84+8
INDIRF4
ADDRLP4 148+72+8
INDIRF4
SUBF4
ADDF4
ASGNF4
LABELV $1506
LABELV $1502
line 2933
;2933:	}
LABELV $1443
line 2860
ADDRLP4 100
ADDRLP4 100
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 3
LTI4 $1442
line 2934
;2934:	return bestvis;
ADDRLP4 296
INDIRF4
RETF4
LABELV $1408
endproc BotEntityVisible 360 28
export BotFindEnemy
proc BotFindEnemy 464 28
line 2942
;2935:}
;2936:
;2937:/*
;2938:==================
;2939:BotFindEnemy
;2940:==================
;2941:*/
;2942:int BotFindEnemy(bot_state_t *bs, int curenemy) {
line 2949
;2943:	int i, healthdecrease;
;2944:	float f, alertness, easyfragger, vis;
;2945:	float squaredist, cursquaredist;
;2946:	aas_entityinfo_t entinfo, curenemyinfo;
;2947:	vec3_t dir, angles;
;2948:
;2949:	alertness = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_ALERTNESS, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 46
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 336
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 164
ADDRLP4 336
INDIRF4
ASGNF4
line 2950
;2950:	easyfragger = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_EASY_FRAGGER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 45
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 340
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 176
ADDRLP4 340
INDIRF4
ASGNF4
line 2952
;2951:	//check if the health decreased
;2952:	healthdecrease = bs->lasthealth > bs->inventory[INVENTORY_HEALTH];
ADDRLP4 348
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 348
INDIRP4
CNSTI4 5988
ADDP4
INDIRI4
ADDRLP4 348
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
LEI4 $1515
ADDRLP4 344
CNSTI4 1
ASGNI4
ADDRGP4 $1516
JUMPV
LABELV $1515
ADDRLP4 344
CNSTI4 0
ASGNI4
LABELV $1516
ADDRLP4 160
ADDRLP4 344
INDIRI4
ASGNI4
line 2954
;2953:	//remember the current health value
;2954:	bs->lasthealth = bs->inventory[INVENTORY_HEALTH];
ADDRLP4 352
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 352
INDIRP4
CNSTI4 5988
ADDP4
ADDRLP4 352
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
ASGNI4
line 2956
;2955:	//
;2956:	if (curenemy >= 0) {
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $1517
line 2957
;2957:		BotEntityInfo(curenemy, &curenemyinfo);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 196
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2958
;2958:		if (EntityCarriesFlag(&curenemyinfo)) return qfalse;
ADDRLP4 196
ARGP4
ADDRLP4 356
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 356
INDIRI4
CNSTI4 0
EQI4 $1519
CNSTI4 0
RETI4
ADDRGP4 $1513
JUMPV
LABELV $1519
line 2959
;2959:		VectorSubtract(curenemyinfo.origin, bs->origin, dir);
ADDRLP4 360
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 196+24
INDIRF4
ADDRLP4 360
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 196+24+4
INDIRF4
ADDRLP4 360
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 196+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2960
;2960:		cursquaredist = VectorLengthSquared(dir);
ADDRLP4 144
ARGP4
ADDRLP4 364
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 192
ADDRLP4 364
INDIRF4
ASGNF4
line 2961
;2961:	}
ADDRGP4 $1518
JUMPV
LABELV $1517
line 2962
;2962:	else {
line 2963
;2963:		cursquaredist = 0;
ADDRLP4 192
CNSTF4 0
ASGNF4
line 2964
;2964:	}
LABELV $1518
line 2966
;2965:#ifdef MISSIONPACK
;2966:	if (gametype == GT_OBELISK) {
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $1528
line 2971
;2967:		vec3_t target;
;2968:		bot_goal_t *goal;
;2969:		bsp_trace_t trace;
;2970:
;2971:		if (BotTeam(bs) == TEAM_RED)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 456
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 456
INDIRI4
CNSTI4 1
NEI4 $1530
line 2972
;2972:			goal = &blueobelisk;
ADDRLP4 356
ADDRGP4 blueobelisk
ASGNP4
ADDRGP4 $1531
JUMPV
LABELV $1530
line 2974
;2973:		else
;2974:			goal = &redobelisk;
ADDRLP4 356
ADDRGP4 redobelisk
ASGNP4
LABELV $1531
line 2976
;2975:		//if the obelisk is visible
;2976:		VectorCopy(goal->origin, target);
ADDRLP4 360
ADDRLP4 356
INDIRP4
INDIRB
ASGNB 12
line 2977
;2977:		target[2] += 1;
ADDRLP4 360+8
ADDRLP4 360+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2978
;2978:		BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
ADDRLP4 372
ARGP4
ADDRLP4 460
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 460
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 360
ARGP4
ADDRLP4 460
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2979
;2979:		if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
ADDRLP4 372+8
INDIRF4
CNSTF4 1065353216
GEF4 $1537
ADDRLP4 372+80
INDIRI4
ADDRLP4 356
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $1533
LABELV $1537
line 2980
;2980:			if (goal->entitynum == bs->enemy) {
ADDRLP4 356
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
NEI4 $1538
line 2981
;2981:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1513
JUMPV
LABELV $1538
line 2983
;2982:			}
;2983:			bs->enemy = goal->entitynum;
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
ADDRLP4 356
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
line 2984
;2984:			bs->enemysight_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2985
;2985:			bs->enemysuicide = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6012
ADDP4
CNSTI4 0
ASGNI4
line 2986
;2986:			bs->enemydeath_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6136
ADDP4
CNSTF4 0
ASGNF4
line 2987
;2987:			bs->enemyvisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6088
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2988
;2988:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1513
JUMPV
LABELV $1533
line 2990
;2989:		}
;2990:	}
LABELV $1528
line 2993
;2991:#endif
;2992:	//
;2993:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRGP4 $1543
JUMPV
LABELV $1540
line 2995
;2994:
;2995:		if (i == bs->client) continue;
ADDRLP4 140
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1545
ADDRGP4 $1541
JUMPV
LABELV $1545
line 2997
;2996:		//if it's the current enemy
;2997:		if (i == curenemy) continue;
ADDRLP4 140
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $1547
ADDRGP4 $1541
JUMPV
LABELV $1547
line 2999
;2998:		//if the enemy has targeting disabled
;2999:		if (g_entities[i].flags & FL_NOTARGET) continue;
ADDRLP4 140
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities+536
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1549
ADDRGP4 $1541
JUMPV
LABELV $1549
line 3001
;3000:		//
;3001:		BotEntityInfo(i, &entinfo);
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3003
;3002:		//
;3003:		if (!entinfo.valid) continue;
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1552
ADDRGP4 $1541
JUMPV
LABELV $1552
line 3005
;3004:		//if the enemy isn't dead and the enemy isn't the bot self
;3005:		if (EntityIsDead(&entinfo) || entinfo.number == bs->entitynum) continue;
ADDRLP4 0
ARGP4
ADDRLP4 356
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 356
INDIRI4
CNSTI4 0
NEI4 $1557
ADDRLP4 0+20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $1554
LABELV $1557
ADDRGP4 $1541
JUMPV
LABELV $1554
line 3007
;3006:		//if the enemy is invisible and not shooting
;3007:		if (EntityIsInvisible(&entinfo) && !EntityIsShooting(&entinfo)) {
ADDRLP4 0
ARGP4
ADDRLP4 360
ADDRGP4 EntityIsInvisible
CALLI4
ASGNI4
ADDRLP4 360
INDIRI4
CNSTI4 0
EQI4 $1558
ADDRLP4 0
ARGP4
ADDRLP4 364
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 364
INDIRI4
CNSTI4 0
NEI4 $1558
line 3008
;3008:			continue;
ADDRGP4 $1541
JUMPV
LABELV $1558
line 3011
;3009:		}
;3010:		//if not an easy fragger don't shoot at chatting players
;3011:		if (easyfragger < 0.5 && EntityIsChatting(&entinfo)) continue;
ADDRLP4 176
INDIRF4
CNSTF4 1056964608
GEF4 $1560
ADDRLP4 0
ARGP4
ADDRLP4 368
ADDRGP4 EntityIsChatting
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 0
EQI4 $1560
ADDRGP4 $1541
JUMPV
LABELV $1560
line 3013
;3012:		//
;3013:		if (lastteleport_time > FloatTime() - 3) {
ADDRGP4 lastteleport_time
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1077936128
SUBF4
LEF4 $1562
line 3014
;3014:			VectorSubtract(entinfo.origin, lastteleport_origin, dir);
ADDRLP4 144
ADDRLP4 0+24
INDIRF4
ADDRGP4 lastteleport_origin
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 0+24+4
INDIRF4
ADDRGP4 lastteleport_origin+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 0+24+8
INDIRF4
ADDRGP4 lastteleport_origin+8
INDIRF4
SUBF4
ASGNF4
line 3015
;3015:			if (VectorLengthSquared(dir) < Square(70)) continue;
ADDRLP4 144
ARGP4
ADDRLP4 372
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 372
INDIRF4
CNSTF4 1167663104
GEF4 $1573
ADDRGP4 $1541
JUMPV
LABELV $1573
line 3016
;3016:		}
LABELV $1562
line 3018
;3017:		//calculate the distance towards the enemy
;3018:		VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 372
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 0+24
INDIRF4
ADDRLP4 372
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 372
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3019
;3019:		squaredist = VectorLengthSquared(dir);
ADDRLP4 144
ARGP4
ADDRLP4 376
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 376
INDIRF4
ASGNF4
line 3021
;3020:		//if this entity is not carrying a flag
;3021:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 0
ARGP4
ADDRLP4 380
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 380
INDIRI4
CNSTI4 0
NEI4 $1582
line 3022
;3022:		{
line 3024
;3023:			//if this enemy is further away than the current one
;3024:			if (curenemy >= 0 && squaredist > cursquaredist) continue;
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $1584
ADDRLP4 156
INDIRF4
ADDRLP4 192
INDIRF4
LEF4 $1584
ADDRGP4 $1541
JUMPV
LABELV $1584
line 3025
;3025:		} //end if
LABELV $1582
line 3027
;3026:		//if the bot has no
;3027:		if (squaredist > Square(900.0 + alertness * 4000.0)) continue;
ADDRLP4 156
INDIRF4
ADDRLP4 164
INDIRF4
CNSTF4 1165623296
MULF4
CNSTF4 1147207680
ADDF4
ADDRLP4 164
INDIRF4
CNSTF4 1165623296
MULF4
CNSTF4 1147207680
ADDF4
MULF4
LEF4 $1586
ADDRGP4 $1541
JUMPV
LABELV $1586
line 3029
;3028:		//if on the same team
;3029:		if (BotSameTeam(bs, i)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 388
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 388
INDIRI4
CNSTI4 0
EQI4 $1588
ADDRGP4 $1541
JUMPV
LABELV $1588
line 3031
;3030:		//if the bot's health decreased or the enemy is shooting
;3031:		if (curenemy < 0 && (healthdecrease || EntityIsShooting(&entinfo)))
ADDRFP4 4
INDIRI4
CNSTI4 0
GEI4 $1590
ADDRLP4 160
INDIRI4
CNSTI4 0
NEI4 $1592
ADDRLP4 0
ARGP4
ADDRLP4 392
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 392
INDIRI4
CNSTI4 0
EQI4 $1590
LABELV $1592
line 3032
;3032:			f = 360;
ADDRLP4 168
CNSTF4 1135869952
ASGNF4
ADDRGP4 $1591
JUMPV
LABELV $1590
line 3034
;3033:		else
;3034:			f = 90 + 90 - (90 - (squaredist > Square(810) ? Square(810) : squaredist) / (810 * 9));
ADDRLP4 156
INDIRF4
CNSTF4 1226845760
LEF4 $1594
ADDRLP4 396
CNSTF4 1226845760
ASGNF4
ADDRGP4 $1595
JUMPV
LABELV $1594
ADDRLP4 396
ADDRLP4 156
INDIRF4
ASGNF4
LABELV $1595
ADDRLP4 168
CNSTF4 1127481344
CNSTF4 1119092736
ADDRLP4 396
INDIRF4
CNSTF4 957339244
MULF4
SUBF4
SUBF4
ASGNF4
LABELV $1591
line 3036
;3035:		//check if the enemy is visible
;3036:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, f, i);
ADDRLP4 400
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 400
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 400
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 400
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
ADDRLP4 168
INDIRF4
ARGF4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 404
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 172
ADDRLP4 404
INDIRF4
ASGNF4
line 3037
;3037:		if (vis <= 0) continue;
ADDRLP4 172
INDIRF4
CNSTF4 0
GTF4 $1596
ADDRGP4 $1541
JUMPV
LABELV $1596
line 3039
;3038:		//if the enemy is quite far away, not shooting and the bot is not damaged
;3039:		if (curenemy < 0 && squaredist > Square(100) && !healthdecrease && !EntityIsShooting(&entinfo))
ADDRFP4 4
INDIRI4
CNSTI4 0
GEI4 $1598
ADDRLP4 156
INDIRF4
CNSTF4 1176256512
LEF4 $1598
ADDRLP4 160
INDIRI4
CNSTI4 0
NEI4 $1598
ADDRLP4 0
ARGP4
ADDRLP4 408
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 408
INDIRI4
CNSTI4 0
NEI4 $1598
line 3040
;3040:		{
line 3042
;3041:			//check if we can avoid this enemy
;3042:			VectorSubtract(bs->origin, entinfo.origin, dir);
ADDRLP4 412
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 412
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 0+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 412
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 0+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 0+24+8
INDIRF4
SUBF4
ASGNF4
line 3043
;3043:			vectoangles(dir, angles);
ADDRLP4 144
ARGP4
ADDRLP4 180
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3045
;3044:			//if the bot isn't in the fov of the enemy
;3045:			if (!InFieldOfVision(entinfo.angles, 90, angles)) {
ADDRLP4 0+36
ARGP4
CNSTF4 1119092736
ARGF4
ADDRLP4 180
ARGP4
ADDRLP4 416
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 416
INDIRI4
CNSTI4 0
NEI4 $1607
line 3047
;3046:				//update some stuff for this enemy
;3047:				BotUpdateBattleInventory(bs, i);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRGP4 BotUpdateBattleInventory
CALLV
pop
line 3049
;3048:				//if the bot doesn't really want to fight
;3049:				if (BotWantsToRetreat(bs)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 420
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 420
INDIRI4
CNSTI4 0
EQI4 $1610
ADDRGP4 $1541
JUMPV
LABELV $1610
line 3050
;3050:			}
LABELV $1607
line 3051
;3051:		}
LABELV $1598
line 3053
;3052:		//found an enemy
;3053:		bs->enemy = entinfo.number;
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
ADDRLP4 0+20
INDIRI4
ASGNI4
line 3054
;3054:		if (curenemy >= 0) bs->enemysight_time = FloatTime() - 2;
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $1613
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
ADDRGP4 $1614
JUMPV
LABELV $1613
line 3055
;3055:		else bs->enemysight_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
LABELV $1614
line 3056
;3056:		bs->enemysuicide = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6012
ADDP4
CNSTI4 0
ASGNI4
line 3057
;3057:		bs->enemydeath_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6136
ADDP4
CNSTF4 0
ASGNF4
line 3058
;3058:		bs->enemyvisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6088
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 3059
;3059:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1513
JUMPV
LABELV $1541
line 2993
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1543
ADDRLP4 140
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1540
line 3061
;3060:	}
;3061:	return qfalse;
CNSTI4 0
RETI4
LABELV $1513
endproc BotFindEnemy 464 28
export BotTeamFlagCarrierVisible
proc BotTeamFlagCarrierVisible 164 20
line 3069
;3062:}
;3063:
;3064:/*
;3065:==================
;3066:BotTeamFlagCarrierVisible
;3067:==================
;3068:*/
;3069:int BotTeamFlagCarrierVisible(bot_state_t *bs) {
line 3074
;3070:	int i;
;3071:	float vis;
;3072:	aas_entityinfo_t entinfo;
;3073:
;3074:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1619
JUMPV
LABELV $1616
line 3075
;3075:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1621
line 3076
;3076:			continue;
ADDRGP4 $1617
JUMPV
LABELV $1621
line 3078
;3077:		//
;3078:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3080
;3079:		//if this player is active
;3080:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1623
line 3081
;3081:			continue;
ADDRGP4 $1617
JUMPV
LABELV $1623
line 3083
;3082:		//if this player is carrying a flag
;3083:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 148
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1625
line 3084
;3084:			continue;
ADDRGP4 $1617
JUMPV
LABELV $1625
line 3086
;3085:		//if the flag carrier is not on the same team
;3086:		if (!BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $1627
line 3087
;3087:			continue;
ADDRGP4 $1617
JUMPV
LABELV $1627
line 3089
;3088:		//if the flag carrier is not visible
;3089:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 156
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 156
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 144
ADDRLP4 160
INDIRF4
ASGNF4
line 3090
;3090:		if (vis <= 0)
ADDRLP4 144
INDIRF4
CNSTF4 0
GTF4 $1629
line 3091
;3091:			continue;
ADDRGP4 $1617
JUMPV
LABELV $1629
line 3093
;3092:		//
;3093:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1615
JUMPV
LABELV $1617
line 3074
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1619
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1616
line 3095
;3094:	}
;3095:	return -1;
CNSTI4 -1
RETI4
LABELV $1615
endproc BotTeamFlagCarrierVisible 164 20
export BotTeamFlagCarrier
proc BotTeamFlagCarrier 152 8
line 3103
;3096:}
;3097:
;3098:/*
;3099:==================
;3100:BotTeamFlagCarrier
;3101:==================
;3102:*/
;3103:int BotTeamFlagCarrier(bot_state_t *bs) {
line 3107
;3104:	int i;
;3105:	aas_entityinfo_t entinfo;
;3106:
;3107:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1635
JUMPV
LABELV $1632
line 3108
;3108:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1637
line 3109
;3109:			continue;
ADDRGP4 $1633
JUMPV
LABELV $1637
line 3111
;3110:		//
;3111:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3113
;3112:		//if this player is active
;3113:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1639
line 3114
;3114:			continue;
ADDRGP4 $1633
JUMPV
LABELV $1639
line 3116
;3115:		//if this player is carrying a flag
;3116:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 144
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $1641
line 3117
;3117:			continue;
ADDRGP4 $1633
JUMPV
LABELV $1641
line 3119
;3118:		//if the flag carrier is not on the same team
;3119:		if (!BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 148
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1643
line 3120
;3120:			continue;
ADDRGP4 $1633
JUMPV
LABELV $1643
line 3122
;3121:		//
;3122:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1631
JUMPV
LABELV $1633
line 3107
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1635
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1632
line 3124
;3123:	}
;3124:	return -1;
CNSTI4 -1
RETI4
LABELV $1631
endproc BotTeamFlagCarrier 152 8
export BotEnemyFlagCarrierVisible
proc BotEnemyFlagCarrierVisible 164 20
line 3132
;3125:}
;3126:
;3127:/*
;3128:==================
;3129:BotEnemyFlagCarrierVisible
;3130:==================
;3131:*/
;3132:int BotEnemyFlagCarrierVisible(bot_state_t *bs) {
line 3137
;3133:	int i;
;3134:	float vis;
;3135:	aas_entityinfo_t entinfo;
;3136:
;3137:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1649
JUMPV
LABELV $1646
line 3138
;3138:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1651
line 3139
;3139:			continue;
ADDRGP4 $1647
JUMPV
LABELV $1651
line 3141
;3140:		//
;3141:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3143
;3142:		//if this player is active
;3143:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1653
line 3144
;3144:			continue;
ADDRGP4 $1647
JUMPV
LABELV $1653
line 3146
;3145:		//if this player is carrying a flag
;3146:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 148
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1655
line 3147
;3147:			continue;
ADDRGP4 $1647
JUMPV
LABELV $1655
line 3149
;3148:		//if the flag carrier is on the same team
;3149:		if (BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $1657
line 3150
;3150:			continue;
ADDRGP4 $1647
JUMPV
LABELV $1657
line 3152
;3151:		//if the flag carrier is not visible
;3152:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 156
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 156
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 144
ADDRLP4 160
INDIRF4
ASGNF4
line 3153
;3153:		if (vis <= 0)
ADDRLP4 144
INDIRF4
CNSTF4 0
GTF4 $1659
line 3154
;3154:			continue;
ADDRGP4 $1647
JUMPV
LABELV $1659
line 3156
;3155:		//
;3156:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1645
JUMPV
LABELV $1647
line 3137
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1649
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1646
line 3158
;3157:	}
;3158:	return -1;
CNSTI4 -1
RETI4
LABELV $1645
endproc BotEnemyFlagCarrierVisible 164 20
export BotVisibleTeamMatesAndEnemies
proc BotVisibleTeamMatesAndEnemies 192 20
line 3166
;3159:}
;3160:
;3161:/*
;3162:==================
;3163:BotVisibleTeamMatesAndEnemies
;3164:==================
;3165:*/
;3166:void BotVisibleTeamMatesAndEnemies(bot_state_t *bs, int *teammates, int *enemies, float range) {
line 3172
;3167:	int i;
;3168:	float vis;
;3169:	aas_entityinfo_t entinfo;
;3170:	vec3_t dir;
;3171:
;3172:	if (teammates)
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1662
line 3173
;3173:		*teammates = 0;
ADDRFP4 4
INDIRP4
CNSTI4 0
ASGNI4
LABELV $1662
line 3174
;3174:	if (enemies)
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1664
line 3175
;3175:		*enemies = 0;
ADDRFP4 8
INDIRP4
CNSTI4 0
ASGNI4
LABELV $1664
line 3176
;3176:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1669
JUMPV
LABELV $1666
line 3177
;3177:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1671
line 3178
;3178:			continue;
ADDRGP4 $1667
JUMPV
LABELV $1671
line 3180
;3179:		//
;3180:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3182
;3181:		//if this player is active
;3182:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1673
line 3183
;3183:			continue;
ADDRGP4 $1667
JUMPV
LABELV $1673
line 3185
;3184:		//if this player is carrying a flag
;3185:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 160
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
NEI4 $1675
line 3186
;3186:			continue;
ADDRGP4 $1667
JUMPV
LABELV $1675
line 3188
;3187:		//if not within range
;3188:		VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 4+24
INDIRF4
ADDRLP4 164
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 4+24+4
INDIRF4
ADDRLP4 164
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 4+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3189
;3189:		if (VectorLengthSquared(dir) > Square(range))
ADDRLP4 144
ARGP4
ADDRLP4 168
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 172
ADDRFP4 12
INDIRF4
ASGNF4
ADDRLP4 168
INDIRF4
ADDRLP4 172
INDIRF4
ADDRLP4 172
INDIRF4
MULF4
LEF4 $1684
line 3190
;3190:			continue;
ADDRGP4 $1667
JUMPV
LABELV $1684
line 3192
;3191:		//if the flag carrier is not visible
;3192:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 176
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 176
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 176
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 180
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 180
INDIRF4
ASGNF4
line 3193
;3193:		if (vis <= 0)
ADDRLP4 156
INDIRF4
CNSTF4 0
GTF4 $1686
line 3194
;3194:			continue;
ADDRGP4 $1667
JUMPV
LABELV $1686
line 3196
;3195:		//if the flag carrier is on the same team
;3196:		if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 184
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 0
EQI4 $1688
line 3197
;3197:			if (teammates)
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1689
line 3198
;3198:				(*teammates)++;
ADDRLP4 188
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 188
INDIRP4
ADDRLP4 188
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3199
;3199:		}
ADDRGP4 $1689
JUMPV
LABELV $1688
line 3200
;3200:		else {
line 3201
;3201:			if (enemies)
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1692
line 3202
;3202:				(*enemies)++;
ADDRLP4 188
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 188
INDIRP4
ADDRLP4 188
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1692
line 3203
;3203:		}
LABELV $1689
line 3204
;3204:	}
LABELV $1667
line 3176
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1669
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1666
line 3205
;3205:}
LABELV $1661
endproc BotVisibleTeamMatesAndEnemies 192 20
export BotTeamCubeCarrierVisible
proc BotTeamCubeCarrierVisible 164 20
line 3213
;3206:
;3207:#ifdef MISSIONPACK
;3208:/*
;3209:==================
;3210:BotTeamCubeCarrierVisible
;3211:==================
;3212:*/
;3213:int BotTeamCubeCarrierVisible(bot_state_t *bs) {
line 3218
;3214:	int i;
;3215:	float vis;
;3216:	aas_entityinfo_t entinfo;
;3217:
;3218:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1698
JUMPV
LABELV $1695
line 3219
;3219:		if (i == bs->client) continue;
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1700
ADDRGP4 $1696
JUMPV
LABELV $1700
line 3221
;3220:		//
;3221:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3223
;3222:		//if this player is active
;3223:		if (!entinfo.valid) continue;
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1702
ADDRGP4 $1696
JUMPV
LABELV $1702
line 3225
;3224:		//if this player is carrying a flag
;3225:		if (!EntityCarriesCubes(&entinfo)) continue;
ADDRLP4 4
ARGP4
ADDRLP4 148
ADDRGP4 EntityCarriesCubes
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1704
ADDRGP4 $1696
JUMPV
LABELV $1704
line 3227
;3226:		//if the flag carrier is not on the same team
;3227:		if (!BotSameTeam(bs, i)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $1706
ADDRGP4 $1696
JUMPV
LABELV $1706
line 3229
;3228:		//if the flag carrier is not visible
;3229:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 156
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 156
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 144
ADDRLP4 160
INDIRF4
ASGNF4
line 3230
;3230:		if (vis <= 0) continue;
ADDRLP4 144
INDIRF4
CNSTF4 0
GTF4 $1708
ADDRGP4 $1696
JUMPV
LABELV $1708
line 3232
;3231:		//
;3232:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1694
JUMPV
LABELV $1696
line 3218
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1698
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1695
line 3234
;3233:	}
;3234:	return -1;
CNSTI4 -1
RETI4
LABELV $1694
endproc BotTeamCubeCarrierVisible 164 20
export BotEnemyCubeCarrierVisible
proc BotEnemyCubeCarrierVisible 164 20
line 3242
;3235:}
;3236:
;3237:/*
;3238:==================
;3239:BotEnemyCubeCarrierVisible
;3240:==================
;3241:*/
;3242:int BotEnemyCubeCarrierVisible(bot_state_t *bs) {
line 3247
;3243:	int i;
;3244:	float vis;
;3245:	aas_entityinfo_t entinfo;
;3246:
;3247:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1714
JUMPV
LABELV $1711
line 3248
;3248:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1716
line 3249
;3249:			continue;
ADDRGP4 $1712
JUMPV
LABELV $1716
line 3251
;3250:		//
;3251:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3253
;3252:		//if this player is active
;3253:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1718
line 3254
;3254:			continue;
ADDRGP4 $1712
JUMPV
LABELV $1718
line 3256
;3255:		//if this player is carrying a flag
;3256:		if (!EntityCarriesCubes(&entinfo)) continue;
ADDRLP4 4
ARGP4
ADDRLP4 148
ADDRGP4 EntityCarriesCubes
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1720
ADDRGP4 $1712
JUMPV
LABELV $1720
line 3258
;3257:		//if the flag carrier is on the same team
;3258:		if (BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $1722
line 3259
;3259:			continue;
ADDRGP4 $1712
JUMPV
LABELV $1722
line 3261
;3260:		//if the flag carrier is not visible
;3261:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 156
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 156
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 144
ADDRLP4 160
INDIRF4
ASGNF4
line 3262
;3262:		if (vis <= 0)
ADDRLP4 144
INDIRF4
CNSTF4 0
GTF4 $1724
line 3263
;3263:			continue;
ADDRGP4 $1712
JUMPV
LABELV $1724
line 3265
;3264:		//
;3265:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1710
JUMPV
LABELV $1712
line 3247
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1714
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1711
line 3267
;3266:	}
;3267:	return -1;
CNSTI4 -1
RETI4
LABELV $1710
endproc BotEnemyCubeCarrierVisible 164 20
data
align 4
LABELV $1727
byte 4 3229614080
byte 4 3229614080
byte 4 3229614080
align 4
LABELV $1728
byte 4 1082130432
byte 4 1082130432
byte 4 1082130432
export BotAimAtEnemy
code
proc BotAimAtEnemy 1128 52
line 3276
;3268:}
;3269:#endif
;3270:
;3271:/*
;3272:==================
;3273:BotAimAtEnemy
;3274:==================
;3275:*/
;3276:void BotAimAtEnemy(bot_state_t *bs) {
line 3280
;3277:	int i, enemyvisible;
;3278:	float dist, f, aim_skill, aim_accuracy, speed, reactiontime;
;3279:	vec3_t dir, bestorigin, end, start, groundtarget, cmdmove, enemyvelocity;
;3280:	vec3_t mins = {-4,-4,-4}, maxs = {4, 4, 4};
ADDRLP4 860
ADDRGP4 $1727
INDIRB
ASGNB 12
ADDRLP4 872
ADDRGP4 $1728
INDIRB
ASGNB 12
line 3288
;3281:	weaponinfo_t wi;
;3282:	aas_entityinfo_t entinfo;
;3283:	bot_goal_t goal;
;3284:	bsp_trace_t trace;
;3285:	vec3_t target;
;3286:
;3287:	//if the bot has no enemy
;3288:	if (bs->enemy < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1729
line 3289
;3289:		return;
ADDRGP4 $1726
JUMPV
LABELV $1729
line 3292
;3290:	}
;3291:	//get the enemy entity information
;3292:	BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3294
;3293:	//if this is not a player (should be an obelisk)
;3294:	if (bs->enemy >= MAX_CLIENTS) {
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
CNSTI4 64
LTI4 $1731
line 3296
;3295:		//if the obelisk is visible
;3296:		VectorCopy(entinfo.origin, target);
ADDRLP4 824
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3299
;3297:#ifdef MISSIONPACK
;3298:		// if attacking an obelisk
;3299:		if ( bs->enemy == redobelisk.entitynum ||
ADDRLP4 984
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 984
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ADDRGP4 redobelisk+40
INDIRI4
EQI4 $1738
ADDRLP4 984
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ADDRGP4 blueobelisk+40
INDIRI4
NEI4 $1734
LABELV $1738
line 3300
;3300:			bs->enemy == blueobelisk.entitynum ) {
line 3301
;3301:			target[2] += 32;
ADDRLP4 824+8
ADDRLP4 824+8
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 3302
;3302:		}
LABELV $1734
line 3305
;3303:#endif
;3304:		//aim at the obelisk
;3305:		VectorSubtract(target, bs->eye, dir);
ADDRLP4 988
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 824
INDIRF4
ADDRLP4 988
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 824+4
INDIRF4
ADDRLP4 988
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 824+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3306
;3306:		vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 140
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3308
;3307:		//set the aim target before trying to attack
;3308:		VectorCopy(target, bs->aimtarget);
ADDRFP4 0
INDIRP4
CNSTI4 6220
ADDP4
ADDRLP4 824
INDIRB
ASGNB 12
line 3309
;3309:		return;
ADDRGP4 $1726
JUMPV
LABELV $1731
line 3314
;3310:	}
;3311:	//
;3312:	//BotAI_Print(PRT_MESSAGE, "client %d: aiming at client %d\n", bs->entitynum, bs->enemy);
;3313:	//
;3314:	aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 16
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 984
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 984
INDIRF4
ASGNF4
line 3315
;3315:	aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 7
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 988
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 988
INDIRF4
ASGNF4
line 3317
;3316:	//
;3317:	if (aim_skill > 0.95) {
ADDRLP4 736
INDIRF4
CNSTF4 1064514355
LEF4 $1744
line 3319
;3318:		//don't aim too early
;3319:		reactiontime = 0.5 * trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_REACTIONTIME, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 992
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 856
ADDRLP4 992
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3320
;3320:		if (bs->enemysight_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 856
INDIRF4
SUBF4
LEF4 $1746
ADDRGP4 $1726
JUMPV
LABELV $1746
line 3321
;3321:		if (bs->teleport_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 6180
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 856
INDIRF4
SUBF4
LEF4 $1748
ADDRGP4 $1726
JUMPV
LABELV $1748
line 3322
;3322:	}
LABELV $1744
line 3325
;3323:
;3324:	//get the weapon information
;3325:	trap_BotGetWeaponInfo(bs->ws, bs->weaponnum, &wi);
ADDRLP4 992
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 992
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRLP4 992
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ARGI4
ADDRLP4 160
ARGP4
ADDRGP4 trap_BotGetWeaponInfo
CALLV
pop
line 3327
;3326:	//get the weapon specific aim accuracy and or aim skill
;3327:	if (wi.number == WP_MACHINEGUN) {
ADDRLP4 160+4
INDIRI4
CNSTI4 2
NEI4 $1750
line 3328
;3328:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_MACHINEGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 8
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3329
;3329:	}
ADDRGP4 $1751
JUMPV
LABELV $1750
line 3330
;3330:	else if (wi.number == WP_SHOTGUN) {
ADDRLP4 160+4
INDIRI4
CNSTI4 3
NEI4 $1753
line 3331
;3331:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_SHOTGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 9
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3332
;3332:	}
ADDRGP4 $1754
JUMPV
LABELV $1753
line 3333
;3333:	else if (wi.number == WP_GRENADE_LAUNCHER) {
ADDRLP4 160+4
INDIRI4
CNSTI4 4
NEI4 $1756
line 3334
;3334:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_GRENADELAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 11
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3335
;3335:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_GRENADELAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 18
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1000
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 1000
INDIRF4
ASGNF4
line 3336
;3336:	}
ADDRGP4 $1757
JUMPV
LABELV $1756
line 3337
;3337:	else if (wi.number == WP_ROCKET_LAUNCHER) {
ADDRLP4 160+4
INDIRI4
CNSTI4 5
NEI4 $1759
line 3338
;3338:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_ROCKETLAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 10
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3339
;3339:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_ROCKETLAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 17
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1000
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 1000
INDIRF4
ASGNF4
line 3340
;3340:	}
ADDRGP4 $1760
JUMPV
LABELV $1759
line 3341
;3341:	else if (wi.number == WP_LIGHTNING) {
ADDRLP4 160+4
INDIRI4
CNSTI4 6
NEI4 $1762
line 3342
;3342:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_LIGHTNING, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 12
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3343
;3343:	}
ADDRGP4 $1763
JUMPV
LABELV $1762
line 3344
;3344:	else if (wi.number == WP_RAILGUN) {
ADDRLP4 160+4
INDIRI4
CNSTI4 7
NEI4 $1765
line 3345
;3345:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_RAILGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 14
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3346
;3346:	}
ADDRGP4 $1766
JUMPV
LABELV $1765
line 3347
;3347:	else if (wi.number == WP_PLASMAGUN) {
ADDRLP4 160+4
INDIRI4
CNSTI4 8
NEI4 $1768
line 3348
;3348:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_PLASMAGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 13
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3349
;3349:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_PLASMAGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 19
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1000
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 1000
INDIRF4
ASGNF4
line 3350
;3350:	}
ADDRGP4 $1769
JUMPV
LABELV $1768
line 3351
;3351:	else if (wi.number == WP_BFG) {
ADDRLP4 160+4
INDIRI4
CNSTI4 9
NEI4 $1771
line 3352
;3352:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_BFG10K, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 15
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3353
;3353:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_BFG10K, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 20
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1000
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 1000
INDIRF4
ASGNF4
line 3354
;3354:	}
LABELV $1771
LABELV $1769
LABELV $1766
LABELV $1763
LABELV $1760
LABELV $1757
LABELV $1754
LABELV $1751
line 3356
;3355:	//
;3356:	if (aim_accuracy <= 0) aim_accuracy = 0.0001f;
ADDRLP4 156
INDIRF4
CNSTF4 0
GTF4 $1774
ADDRLP4 156
CNSTF4 953267991
ASGNF4
LABELV $1774
line 3358
;3357:	//get the enemy entity information
;3358:	BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3360
;3359:	//if the enemy is invisible then shoot crappy most of the time
;3360:	if (EntityIsInvisible(&entinfo)) {
ADDRLP4 0
ARGP4
ADDRLP4 996
ADDRGP4 EntityIsInvisible
CALLI4
ASGNI4
ADDRLP4 996
INDIRI4
CNSTI4 0
EQI4 $1776
line 3361
;3361:		if (random() > 0.1) aim_accuracy *= 0.4f;
ADDRLP4 1000
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1000
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1036831949
LEF4 $1778
ADDRLP4 156
ADDRLP4 156
INDIRF4
CNSTF4 1053609165
MULF4
ASGNF4
LABELV $1778
line 3362
;3362:	}
LABELV $1776
line 3364
;3363:	//
;3364:	VectorSubtract(entinfo.origin, entinfo.lastvisorigin, enemyvelocity);
ADDRLP4 712
ADDRLP4 0+24
INDIRF4
ADDRLP4 0+60
INDIRF4
SUBF4
ASGNF4
ADDRLP4 712+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 0+60+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 712+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 0+60+8
INDIRF4
SUBF4
ASGNF4
line 3365
;3365:	VectorScale(enemyvelocity, 1 / entinfo.update_time, enemyvelocity);
ADDRLP4 712
ADDRLP4 712
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 712+4
ADDRLP4 712+4
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 712+8
ADDRLP4 712+8
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
line 3367
;3366:	//enemy origin and velocity is remembered every 0.5 seconds
;3367:	if (bs->enemyposition_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6140
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1799
line 3369
;3368:		//
;3369:		bs->enemyposition_time = FloatTime() + 0.5;
ADDRFP4 0
INDIRP4
CNSTI4 6140
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 3370
;3370:		VectorCopy(enemyvelocity, bs->enemyvelocity);
ADDRFP4 0
INDIRP4
CNSTI4 6232
ADDP4
ADDRLP4 712
INDIRB
ASGNB 12
line 3371
;3371:		VectorCopy(entinfo.origin, bs->enemyorigin);
ADDRFP4 0
INDIRP4
CNSTI4 6244
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3372
;3372:	}
LABELV $1799
line 3374
;3373:	//if not extremely skilled
;3374:	if (aim_skill < 0.9) {
ADDRLP4 736
INDIRF4
CNSTF4 1063675494
GEF4 $1802
line 3375
;3375:		VectorSubtract(entinfo.origin, bs->enemyorigin, dir);
ADDRLP4 1000
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1000
INDIRP4
CNSTI4 6244
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1000
INDIRP4
CNSTI4 6248
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 6252
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3377
;3376:		//if the enemy moved a bit
;3377:		if (VectorLengthSquared(dir) > Square(48)) {
ADDRLP4 140
ARGP4
ADDRLP4 1004
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1004
INDIRF4
CNSTF4 1158676480
LEF4 $1811
line 3379
;3378:			//if the enemy changed direction
;3379:			if (DotProduct(bs->enemyvelocity, enemyvelocity) < 0) {
ADDRLP4 1008
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1008
INDIRP4
CNSTI4 6232
ADDP4
INDIRF4
ADDRLP4 712
INDIRF4
MULF4
ADDRLP4 1008
INDIRP4
CNSTI4 6236
ADDP4
INDIRF4
ADDRLP4 712+4
INDIRF4
MULF4
ADDF4
ADDRLP4 1008
INDIRP4
CNSTI4 6240
ADDP4
INDIRF4
ADDRLP4 712+8
INDIRF4
MULF4
ADDF4
CNSTF4 0
GEF4 $1813
line 3381
;3380:				//aim accuracy should be worse now
;3381:				aim_accuracy *= 0.7f;
ADDRLP4 156
ADDRLP4 156
INDIRF4
CNSTF4 1060320051
MULF4
ASGNF4
line 3382
;3382:			}
LABELV $1813
line 3383
;3383:		}
LABELV $1811
line 3384
;3384:	}
LABELV $1802
line 3386
;3385:	//check visibility of enemy
;3386:	enemyvisible = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, bs->enemy);
ADDRLP4 1000
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1000
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 1000
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 1000
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 1000
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 1004
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 836
ADDRLP4 1004
INDIRF4
CVFI4 4
ASGNI4
line 3388
;3387:	//if the enemy is visible
;3388:	if (enemyvisible) {
ADDRLP4 836
INDIRI4
CNSTI4 0
EQI4 $1817
line 3390
;3389:		//
;3390:		VectorCopy(entinfo.origin, bestorigin);
ADDRLP4 724
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3391
;3391:		bestorigin[2] += 8;
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 3394
;3392:		//get the start point shooting from
;3393:		//NOTE: the x and y projectile start offsets are ignored
;3394:		VectorCopy(bs->origin, start);
ADDRLP4 844
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 3395
;3395:		start[2] += bs->cur_ps.viewheight;
ADDRLP4 844+8
ADDRLP4 844+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 3396
;3396:		start[2] += wi.offset[2];
ADDRLP4 844+8
ADDRLP4 844+8
INDIRF4
ADDRLP4 160+292+8
INDIRF4
ADDF4
ASGNF4
line 3398
;3397:		//
;3398:		BotAI_Trace(&trace, start, mins, maxs, bestorigin, bs->entitynum, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 844
ARGP4
ADDRLP4 860
ARGP4
ADDRLP4 872
ARGP4
ADDRLP4 724
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3400
;3399:		//if the enemy is NOT hit
;3400:		if (trace.fraction <= 1 && trace.ent != entinfo.number) {
ADDRLP4 740+8
INDIRF4
CNSTF4 1065353216
GTF4 $1825
ADDRLP4 740+80
INDIRI4
ADDRLP4 0+20
INDIRI4
EQI4 $1825
line 3401
;3401:			bestorigin[2] += 16;
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 3402
;3402:		}
LABELV $1825
line 3404
;3403:		//if it is not an instant hit weapon the bot might want to predict the enemy
;3404:		if (wi.speed) {
ADDRLP4 160+272
INDIRF4
CNSTF4 0
EQF4 $1831
line 3406
;3405:			//
;3406:			VectorSubtract(bestorigin, bs->origin, dir);
ADDRLP4 1008
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 724
INDIRF4
ADDRLP4 1008
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 724+4
INDIRF4
ADDRLP4 1008
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 724+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3407
;3407:			dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1012
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1012
INDIRF4
ASGNF4
line 3408
;3408:			VectorSubtract(entinfo.origin, bs->enemyorigin, dir);
ADDRLP4 1016
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1016
INDIRP4
CNSTI4 6244
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1016
INDIRP4
CNSTI4 6248
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 6252
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3410
;3409:			//if the enemy is NOT pretty far away and strafing just small steps left and right
;3410:			if (!(dist > 100 && VectorLengthSquared(dir) < Square(32))) {
ADDRLP4 840
INDIRF4
CNSTF4 1120403456
LEF4 $1847
ADDRLP4 140
ARGP4
ADDRLP4 1020
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1020
INDIRF4
CNSTF4 1149239296
LTF4 $1845
LABELV $1847
line 3412
;3411:				//if skilled anough do exact prediction
;3412:				if (aim_skill > 0.8 &&
ADDRLP4 736
INDIRF4
CNSTF4 1061997773
LEF4 $1848
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1848
line 3414
;3413:						//if the weapon is ready to fire
;3414:						bs->cur_ps.weaponstate == WEAPON_READY) {
line 3418
;3415:					aas_clientmove_t move;
;3416:					vec3_t origin;
;3417:
;3418:					VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 1120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1120
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1120
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3420
;3419:					//distance towards the enemy
;3420:					dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1124
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1124
INDIRF4
ASGNF4
line 3422
;3421:					//direction the enemy is moving in
;3422:					VectorSubtract(entinfo.origin, entinfo.lastvisorigin, dir);
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 0+60
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 0+60+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 0+60+8
INDIRF4
SUBF4
ASGNF4
line 3424
;3423:					//
;3424:					VectorScale(dir, 1 / entinfo.update_time, dir);
ADDRLP4 140
ADDRLP4 140
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 140+4
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 140+8
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
line 3426
;3425:					//
;3426:					VectorCopy(entinfo.origin, origin);
ADDRLP4 1024
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3427
;3427:					origin[2] += 1;
ADDRLP4 1024+8
ADDRLP4 1024+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3429
;3428:					//
;3429:					VectorClear(cmdmove);
ADDRLP4 968
CNSTF4 0
ASGNF4
ADDRLP4 968+4
CNSTF4 0
ASGNF4
ADDRLP4 968+8
CNSTF4 0
ASGNF4
line 3431
;3430:					//AAS_ClearShownDebugLines();
;3431:					trap_AAS_PredictClientMovement(&move, bs->enemy, origin,
ADDRLP4 1036
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 1024
ARGP4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 140
ARGP4
ADDRLP4 968
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 840
INDIRF4
CNSTF4 1092616192
MULF4
ADDRLP4 160+272
INDIRF4
DIVF4
CVFI4 4
ARGI4
CNSTF4 1036831949
ARGF4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_AAS_PredictClientMovement
CALLI4
pop
line 3435
;3432:														PRESENCE_CROUCH, qfalse,
;3433:														dir, cmdmove, 0,
;3434:														dist * 10 / wi.speed, 0.1f, 0, 0, qfalse);
;3435:					VectorCopy(move.endpos, bestorigin);
ADDRLP4 724
ADDRLP4 1036
INDIRB
ASGNB 12
line 3437
;3436:					//BotAI_Print(PRT_MESSAGE, "%1.1f predicted speed = %f, frames = %f\n", FloatTime(), VectorLength(dir), dist * 10 / wi.speed);
;3437:				}
ADDRGP4 $1849
JUMPV
LABELV $1848
line 3439
;3438:				//if not that skilled do linear prediction
;3439:				else if (aim_skill > 0.4) {
ADDRLP4 736
INDIRF4
CNSTF4 1053609165
LEF4 $1881
line 3440
;3440:					VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 1024
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1024
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1024
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3442
;3441:					//distance towards the enemy
;3442:					dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1028
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1028
INDIRF4
ASGNF4
line 3444
;3443:					//direction the enemy is moving in
;3444:					VectorSubtract(entinfo.origin, entinfo.lastvisorigin, dir);
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 0+60
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 0+60+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 0+60+8
INDIRF4
SUBF4
ASGNF4
line 3445
;3445:					dir[2] = 0;
ADDRLP4 140+8
CNSTF4 0
ASGNF4
line 3447
;3446:					//
;3447:					speed = VectorNormalize(dir) / entinfo.update_time;
ADDRLP4 140
ARGP4
ADDRLP4 1032
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 980
ADDRLP4 1032
INDIRF4
ADDRLP4 0+16
INDIRF4
DIVF4
ASGNF4
line 3450
;3448:					//botimport.Print(PRT_MESSAGE, "speed = %f, wi->speed = %f\n", speed, wi->speed);
;3449:					//best spot to aim at
;3450:					VectorMA(entinfo.origin, (dist / wi.speed) * speed, dir, bestorigin);
ADDRLP4 1036
ADDRLP4 840
INDIRF4
ASGNF4
ADDRLP4 1040
ADDRLP4 980
INDIRF4
ASGNF4
ADDRLP4 724
ADDRLP4 0+24
INDIRF4
ADDRLP4 140
INDIRF4
ADDRLP4 1036
INDIRF4
ADDRLP4 160+272
INDIRF4
DIVF4
ADDRLP4 1040
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 724+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 140+4
INDIRF4
ADDRLP4 1036
INDIRF4
ADDRLP4 160+272
INDIRF4
DIVF4
ADDRLP4 1040
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 724+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 140+8
INDIRF4
ADDRLP4 840
INDIRF4
ADDRLP4 160+272
INDIRF4
DIVF4
ADDRLP4 980
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 3451
;3451:				}
LABELV $1881
LABELV $1849
line 3452
;3452:			}
LABELV $1845
line 3453
;3453:		}
LABELV $1831
line 3455
;3454:		//if the projectile does radial damage
;3455:		if (aim_skill > 0.6 && wi.proj.damagetype & DAMAGETYPE_RADIAL) {
ADDRLP4 736
INDIRF4
CNSTF4 1058642330
LEF4 $1916
ADDRLP4 160+344+180
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1916
line 3457
;3456:			//if the enemy isn't standing significantly higher than the bot
;3457:			if (entinfo.origin[2] < bs->origin[2] + 16) {
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
GEF4 $1920
line 3459
;3458:				//try to aim at the ground in front of the enemy
;3459:				VectorCopy(entinfo.origin, end);
ADDRLP4 956
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3460
;3460:				end[2] -= 64;
ADDRLP4 956+8
ADDRLP4 956+8
INDIRF4
CNSTF4 1115684864
SUBF4
ASGNF4
line 3461
;3461:				BotAI_Trace(&trace, entinfo.origin, NULL, NULL, end, entinfo.number, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 0+24
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 956
ARGP4
ADDRLP4 0+20
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3463
;3462:				//
;3463:				VectorCopy(bestorigin, groundtarget);
ADDRLP4 944
ADDRLP4 724
INDIRB
ASGNB 12
line 3464
;3464:				if (trace.startsolid) groundtarget[2] = entinfo.origin[2] - 16;
ADDRLP4 740+4
INDIRI4
CNSTI4 0
EQI4 $1928
ADDRLP4 944+8
ADDRLP4 0+24+8
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
ADDRGP4 $1929
JUMPV
LABELV $1928
line 3465
;3465:				else groundtarget[2] = trace.endpos[2] - 8;
ADDRLP4 944+8
ADDRLP4 740+12+8
INDIRF4
CNSTF4 1090519040
SUBF4
ASGNF4
LABELV $1929
line 3467
;3466:				//trace a line from projectile start to ground target
;3467:				BotAI_Trace(&trace, start, NULL, NULL, groundtarget, bs->entitynum, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 844
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 944
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3469
;3468:				//if hitpoint is not vertically too far from the ground target
;3469:				if (fabs(trace.endpos[2] - groundtarget[2]) < 50) {
ADDRLP4 740+12+8
INDIRF4
ADDRLP4 944+8
INDIRF4
SUBF4
ARGF4
ADDRLP4 1008
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 1008
INDIRF4
CNSTF4 1112014848
GEF4 $1937
line 3470
;3470:					VectorSubtract(trace.endpos, groundtarget, dir);
ADDRLP4 140
ADDRLP4 740+12
INDIRF4
ADDRLP4 944
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 740+12+4
INDIRF4
ADDRLP4 944+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 740+12+8
INDIRF4
ADDRLP4 944+8
INDIRF4
SUBF4
ASGNF4
line 3472
;3471:					//if the hitpoint is near enough the ground target
;3472:					if (VectorLengthSquared(dir) < Square(60)) {
ADDRLP4 140
ARGP4
ADDRLP4 1012
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1012
INDIRF4
CNSTF4 1163984896
GEF4 $1951
line 3473
;3473:						VectorSubtract(trace.endpos, start, dir);
ADDRLP4 140
ADDRLP4 740+12
INDIRF4
ADDRLP4 844
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 740+12+4
INDIRF4
ADDRLP4 844+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 740+12+8
INDIRF4
ADDRLP4 844+8
INDIRF4
SUBF4
ASGNF4
line 3475
;3474:						//if the hitpoint is far enough from the bot
;3475:						if (VectorLengthSquared(dir) > Square(100)) {
ADDRLP4 140
ARGP4
ADDRLP4 1016
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1016
INDIRF4
CNSTF4 1176256512
LEF4 $1962
line 3477
;3476:							//check if the bot is visible from the ground target
;3477:							trace.endpos[2] += 1;
ADDRLP4 740+12+8
ADDRLP4 740+12+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3478
;3478:							BotAI_Trace(&trace, trace.endpos, NULL, NULL, entinfo.origin, entinfo.number, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 740+12
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0+24
ARGP4
ADDRLP4 0+20
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3479
;3479:							if (trace.fraction >= 1) {
ADDRLP4 740+8
INDIRF4
CNSTF4 1065353216
LTF4 $1969
line 3481
;3480:								//botimport.Print(PRT_MESSAGE, "%1.1f aiming at ground\n", AAS_Time());
;3481:								VectorCopy(groundtarget, bestorigin);
ADDRLP4 724
ADDRLP4 944
INDIRB
ASGNB 12
line 3482
;3482:							}
LABELV $1969
line 3483
;3483:						}
LABELV $1962
line 3484
;3484:					}
LABELV $1951
line 3485
;3485:				}
LABELV $1937
line 3486
;3486:			}
LABELV $1920
line 3487
;3487:		}
LABELV $1916
line 3488
;3488:		bestorigin[0] += 20 * crandom() * (1 - aim_accuracy);
ADDRLP4 1008
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 724
ADDRLP4 724
INDIRF4
ADDRLP4 1008
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
CNSTF4 1101004800
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3489
;3489:		bestorigin[1] += 20 * crandom() * (1 - aim_accuracy);
ADDRLP4 1012
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 724+4
ADDRLP4 724+4
INDIRF4
ADDRLP4 1012
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
CNSTF4 1101004800
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3490
;3490:		bestorigin[2] += 10 * crandom() * (1 - aim_accuracy);
ADDRLP4 1016
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
ADDRLP4 1016
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
CNSTF4 1092616192
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3491
;3491:	}
ADDRGP4 $1818
JUMPV
LABELV $1817
line 3492
;3492:	else {
line 3494
;3493:		//
;3494:		VectorCopy(bs->lastenemyorigin, bestorigin);
ADDRLP4 724
ADDRFP4 0
INDIRP4
CNSTI4 6548
ADDP4
INDIRB
ASGNB 12
line 3495
;3495:		bestorigin[2] += 8;
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 3497
;3496:		//if the bot is skilled enough
;3497:		if (aim_skill > 0.5) {
ADDRLP4 736
INDIRF4
CNSTF4 1056964608
LEF4 $1975
line 3499
;3498:			//do prediction shots around corners
;3499:			if (wi.number == WP_BFG ||
ADDRLP4 160+4
INDIRI4
CNSTI4 9
EQI4 $1983
ADDRLP4 160+4
INDIRI4
CNSTI4 5
EQI4 $1983
ADDRLP4 160+4
INDIRI4
CNSTI4 4
NEI4 $1977
LABELV $1983
line 3501
;3500:				wi.number == WP_ROCKET_LAUNCHER ||
;3501:				wi.number == WP_GRENADE_LAUNCHER) {
line 3503
;3502:				//create the chase goal
;3503:				goal.entitynum = bs->client;
ADDRLP4 884+40
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 3504
;3504:				goal.areanum = bs->areanum;
ADDRLP4 884+12
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ASGNI4
line 3505
;3505:				VectorCopy(bs->eye, goal.origin);
ADDRLP4 884
ADDRFP4 0
INDIRP4
CNSTI4 4936
ADDP4
INDIRB
ASGNB 12
line 3506
;3506:				VectorSet(goal.mins, -8, -8, -8);
ADDRLP4 884+16
CNSTF4 3238002688
ASGNF4
ADDRLP4 884+16+4
CNSTF4 3238002688
ASGNF4
ADDRLP4 884+16+8
CNSTF4 3238002688
ASGNF4
line 3507
;3507:				VectorSet(goal.maxs, 8, 8, 8);
ADDRLP4 884+28
CNSTF4 1090519040
ASGNF4
ADDRLP4 884+28+4
CNSTF4 1090519040
ASGNF4
ADDRLP4 884+28+8
CNSTF4 1090519040
ASGNF4
line 3509
;3508:				//
;3509:				if (trap_BotPredictVisiblePosition(bs->lastenemyorigin, bs->lastenemyareanum, &goal, TFL_DEFAULT, target)) {
ADDRLP4 1008
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1008
INDIRP4
CNSTI4 6548
ADDP4
ARGP4
ADDRLP4 1008
INDIRP4
CNSTI4 6544
ADDP4
INDIRI4
ARGI4
ADDRLP4 884
ARGP4
CNSTI4 18616254
ARGI4
ADDRLP4 824
ARGP4
ADDRLP4 1012
ADDRGP4 trap_BotPredictVisiblePosition
CALLI4
ASGNI4
ADDRLP4 1012
INDIRI4
CNSTI4 0
EQI4 $1996
line 3510
;3510:					VectorSubtract(target, bs->eye, dir);
ADDRLP4 1016
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 824
INDIRF4
ADDRLP4 1016
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 824+4
INDIRF4
ADDRLP4 1016
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 824+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3511
;3511:					if (VectorLengthSquared(dir) > Square(80)) {
ADDRLP4 140
ARGP4
ADDRLP4 1020
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1020
INDIRF4
CNSTF4 1170735104
LEF4 $2002
line 3512
;3512:						VectorCopy(target, bestorigin);
ADDRLP4 724
ADDRLP4 824
INDIRB
ASGNB 12
line 3513
;3513:						bestorigin[2] -= 20;
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1101004800
SUBF4
ASGNF4
line 3514
;3514:					}
LABELV $2002
line 3515
;3515:				}
LABELV $1996
line 3516
;3516:				aim_accuracy = 1;
ADDRLP4 156
CNSTF4 1065353216
ASGNF4
line 3517
;3517:			}
LABELV $1977
line 3518
;3518:		}
LABELV $1975
line 3519
;3519:	}
LABELV $1818
line 3521
;3520:	//
;3521:	if (enemyvisible) {
ADDRLP4 836
INDIRI4
CNSTI4 0
EQI4 $2005
line 3522
;3522:		BotAI_Trace(&trace, bs->eye, NULL, NULL, bestorigin, bs->entitynum, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 1008
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1008
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 724
ARGP4
ADDRLP4 1008
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3523
;3523:		VectorCopy(trace.endpos, bs->aimtarget);
ADDRFP4 0
INDIRP4
CNSTI4 6220
ADDP4
ADDRLP4 740+12
INDIRB
ASGNB 12
line 3524
;3524:	}
ADDRGP4 $2006
JUMPV
LABELV $2005
line 3525
;3525:	else {
line 3526
;3526:		VectorCopy(bestorigin, bs->aimtarget);
ADDRFP4 0
INDIRP4
CNSTI4 6220
ADDP4
ADDRLP4 724
INDIRB
ASGNB 12
line 3527
;3527:	}
LABELV $2006
line 3529
;3528:	//get aim direction
;3529:	VectorSubtract(bestorigin, bs->eye, dir);
ADDRLP4 1008
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 724
INDIRF4
ADDRLP4 1008
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 724+4
INDIRF4
ADDRLP4 1008
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 724+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3531
;3530:	//
;3531:	if (wi.number == WP_MACHINEGUN ||
ADDRLP4 160+4
INDIRI4
CNSTI4 2
EQI4 $2020
ADDRLP4 160+4
INDIRI4
CNSTI4 3
EQI4 $2020
ADDRLP4 160+4
INDIRI4
CNSTI4 6
EQI4 $2020
ADDRLP4 160+4
INDIRI4
CNSTI4 7
NEI4 $2012
LABELV $2020
line 3534
;3532:		wi.number == WP_SHOTGUN ||
;3533:		wi.number == WP_LIGHTNING ||
;3534:		wi.number == WP_RAILGUN) {
line 3536
;3535:		//distance towards the enemy
;3536:		dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1012
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1012
INDIRF4
ASGNF4
line 3537
;3537:		if (dist > 150) dist = 150;
ADDRLP4 840
INDIRF4
CNSTF4 1125515264
LEF4 $2021
ADDRLP4 840
CNSTF4 1125515264
ASGNF4
LABELV $2021
line 3538
;3538:		f = 0.6 + dist / 150 * 0.4;
ADDRLP4 940
ADDRLP4 840
INDIRF4
CNSTF4 992920382
MULF4
CNSTF4 1058642330
ADDF4
ASGNF4
line 3539
;3539:		aim_accuracy *= f;
ADDRLP4 156
ADDRLP4 156
INDIRF4
ADDRLP4 940
INDIRF4
MULF4
ASGNF4
line 3540
;3540:	}
LABELV $2012
line 3542
;3541:	//add some random stuff to the aim direction depending on the aim accuracy
;3542:	if (aim_accuracy < 0.8) {
ADDRLP4 156
INDIRF4
CNSTF4 1061997773
GEF4 $2023
line 3543
;3543:		VectorNormalize(dir);
ADDRLP4 140
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 3544
;3544:		for (i = 0; i < 3; i++) dir[i] += 0.3 * crandom() * (1 - aim_accuracy);
ADDRLP4 152
CNSTI4 0
ASGNI4
LABELV $2025
ADDRLP4 1012
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1016
ADDRLP4 152
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 140
ADDP4
ASGNP4
ADDRLP4 1016
INDIRP4
ADDRLP4 1016
INDIRP4
INDIRF4
ADDRLP4 1012
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
CNSTF4 1050253722
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
LABELV $2026
ADDRLP4 152
ADDRLP4 152
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 3
LTI4 $2025
line 3545
;3545:	}
LABELV $2023
line 3547
;3546:	//set the ideal view angles
;3547:	vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 140
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3549
;3548:	//take the weapon spread into account for lower skilled bots
;3549:	bs->ideal_viewangles[PITCH] += 6 * wi.vspread * crandom() * (1 - aim_accuracy);
ADDRLP4 1012
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1016
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ASGNP4
ADDRLP4 1016
INDIRP4
ADDRLP4 1016
INDIRP4
INDIRF4
ADDRLP4 160+268
INDIRF4
CNSTF4 1086324736
MULF4
ADDRLP4 1012
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3550
;3550:	bs->ideal_viewangles[PITCH] = AngleMod(bs->ideal_viewangles[PITCH]);
ADDRLP4 1020
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1020
INDIRP4
CNSTI4 6576
ADDP4
INDIRF4
ARGF4
ADDRLP4 1024
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1020
INDIRP4
CNSTI4 6576
ADDP4
ADDRLP4 1024
INDIRF4
ASGNF4
line 3551
;3551:	bs->ideal_viewangles[YAW] += 6 * wi.hspread * crandom() * (1 - aim_accuracy);
ADDRLP4 1028
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1032
ADDRFP4 0
INDIRP4
CNSTI4 6580
ADDP4
ASGNP4
ADDRLP4 1032
INDIRP4
ADDRLP4 1032
INDIRP4
INDIRF4
ADDRLP4 160+264
INDIRF4
CNSTF4 1086324736
MULF4
ADDRLP4 1028
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3552
;3552:	bs->ideal_viewangles[YAW] = AngleMod(bs->ideal_viewangles[YAW]);
ADDRLP4 1036
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1036
INDIRP4
CNSTI4 6580
ADDP4
INDIRF4
ARGF4
ADDRLP4 1040
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1036
INDIRP4
CNSTI4 6580
ADDP4
ADDRLP4 1040
INDIRF4
ASGNF4
line 3554
;3553:	//if the bots should be really challenging
;3554:	if (bot_challenge.integer) {
ADDRGP4 bot_challenge+12
INDIRI4
CNSTI4 0
EQI4 $2031
line 3556
;3555:		//if the bot is really accurate and has the enemy in view for some time
;3556:		if (aim_accuracy > 0.9 && bs->enemysight_time < FloatTime() - 1) {
ADDRLP4 156
INDIRF4
CNSTF4 1063675494
LEF4 $2034
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $2034
line 3558
;3557:			//set the view angles directly
;3558:			if (bs->ideal_viewangles[PITCH] > 180) bs->ideal_viewangles[PITCH] -= 360;
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
INDIRF4
CNSTF4 1127481344
LEF4 $2036
ADDRLP4 1044
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ASGNP4
ADDRLP4 1044
INDIRP4
ADDRLP4 1044
INDIRP4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $2036
line 3559
;3559:			VectorCopy(bs->ideal_viewangles, bs->viewangles);
ADDRLP4 1048
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1048
INDIRP4
CNSTI4 6564
ADDP4
ADDRLP4 1048
INDIRP4
CNSTI4 6576
ADDP4
INDIRB
ASGNB 12
line 3560
;3560:			trap_EA_View(bs->client, bs->viewangles);
ADDRLP4 1052
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1052
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 1052
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
ADDRGP4 trap_EA_View
CALLV
pop
line 3561
;3561:		}
LABELV $2034
line 3562
;3562:	}
LABELV $2031
line 3563
;3563:}
LABELV $1726
endproc BotAimAtEnemy 1128 52
data
align 4
LABELV $2039
byte 4 3238002688
byte 4 3238002688
byte 4 3238002688
align 4
LABELV $2040
byte 4 1090519040
byte 4 1090519040
byte 4 1090519040
export BotCheckAttack
code
proc BotCheckAttack 1024 28
line 3570
;3564:
;3565:/*
;3566:==================
;3567:BotCheckAttack
;3568:==================
;3569:*/
;3570:void BotCheckAttack(bot_state_t *bs) {
line 3580
;3571:	float points, reactiontime, fov, firethrottle;
;3572:	int attackentity;
;3573:	bsp_trace_t bsptrace;
;3574:	//float selfpreservation;
;3575:	vec3_t forward, right, start, end, dir, angles;
;3576:	weaponinfo_t wi;
;3577:	bsp_trace_t trace;
;3578:	aas_entityinfo_t entinfo;
;3579:	weapon_t weapon;
;3580:	vec3_t mins = {-8, -8, -8}, maxs = {8, 8, 8};
ADDRLP4 952
ADDRGP4 $2039
INDIRB
ASGNB 12
ADDRLP4 964
ADDRGP4 $2040
INDIRB
ASGNB 12
line 3582
;3581:
;3582:	attackentity = bs->enemy;
ADDRLP4 576
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ASGNI4
line 3584
;3583:	//
;3584:	BotEntityInfo(attackentity, &entinfo);
ADDRLP4 576
INDIRI4
ARGI4
ADDRLP4 792
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3586
;3585:	// if not attacking a player
;3586:	if (attackentity >= MAX_CLIENTS) {
ADDRLP4 576
INDIRI4
CNSTI4 64
LTI4 $2041
line 3589
;3587:#ifdef MISSIONPACK
;3588:		// if attacking an obelisk
;3589:		if ( entinfo.number == redobelisk.entitynum ||
ADDRLP4 792+20
INDIRI4
ADDRGP4 redobelisk+40
INDIRI4
EQI4 $2049
ADDRLP4 792+20
INDIRI4
ADDRGP4 blueobelisk+40
INDIRI4
NEI4 $2043
LABELV $2049
line 3590
;3590:			entinfo.number == blueobelisk.entitynum ) {
line 3592
;3591:			// if obelisk is respawning return
;3592:			if ( g_entities[entinfo.number].activator &&
ADDRLP4 792+20
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities+772
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2050
ADDRLP4 792+20
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities+772
ADDP4
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
CNSTI4 2
NEI4 $2050
line 3593
;3593:				g_entities[entinfo.number].activator->s.frame == 2 ) {
line 3594
;3594:				return;
ADDRGP4 $2038
JUMPV
LABELV $2050
line 3596
;3595:			}
;3596:		}
LABELV $2043
line 3598
;3597:#endif
;3598:	}
LABELV $2041
line 3600
;3599:	//
;3600:	reactiontime = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_REACTIONTIME, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 980
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 704
ADDRLP4 980
INDIRF4
ASGNF4
line 3601
;3601:	if (bs->enemysight_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 704
INDIRF4
SUBF4
LEF4 $2056
ADDRGP4 $2038
JUMPV
LABELV $2056
line 3602
;3602:	if (bs->teleport_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 6180
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 704
INDIRF4
SUBF4
LEF4 $2058
ADDRGP4 $2038
JUMPV
LABELV $2058
line 3604
;3603:	//if changing weapons
;3604:	if (bs->weaponchange_time > FloatTime() - 0.1) return;
ADDRFP4 0
INDIRP4
CNSTI4 6192
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1036831949
SUBF4
LEF4 $2060
ADDRGP4 $2038
JUMPV
LABELV $2060
line 3606
;3605:	//check fire throttle characteristic
;3606:	if (bs->firethrottlewait_time > FloatTime()) return;
ADDRFP4 0
INDIRP4
CNSTI4 6196
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $2062
ADDRGP4 $2038
JUMPV
LABELV $2062
line 3607
;3607:	firethrottle = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_FIRETHROTTLE, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 47
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 984
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 936
ADDRLP4 984
INDIRF4
ASGNF4
line 3608
;3608:	if (bs->firethrottleshoot_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6200
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $2064
line 3609
;3609:		if (random() > firethrottle) {
ADDRLP4 988
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 988
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ADDRLP4 936
INDIRF4
LEF4 $2066
line 3610
;3610:			bs->firethrottlewait_time = FloatTime() + firethrottle;
ADDRFP4 0
INDIRP4
CNSTI4 6196
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 936
INDIRF4
ADDF4
ASGNF4
line 3611
;3611:			bs->firethrottleshoot_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6200
ADDP4
CNSTF4 0
ASGNF4
line 3612
;3612:		}
ADDRGP4 $2067
JUMPV
LABELV $2066
line 3613
;3613:		else {
line 3614
;3614:			bs->firethrottleshoot_time = FloatTime() + 1 - firethrottle;
ADDRFP4 0
INDIRP4
CNSTI4 6200
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ADDRLP4 936
INDIRF4
SUBF4
ASGNF4
line 3615
;3615:			bs->firethrottlewait_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6196
ADDP4
CNSTF4 0
ASGNF4
line 3616
;3616:		}
LABELV $2067
line 3617
;3617:	}
LABELV $2064
line 3620
;3618:	//
;3619:	//
;3620:	VectorSubtract(bs->aimtarget, bs->eye, dir);
ADDRLP4 988
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 580
ADDRLP4 988
INDIRP4
CNSTI4 6220
ADDP4
INDIRF4
ADDRLP4 988
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 580+4
ADDRLP4 988
INDIRP4
CNSTI4 6224
ADDP4
INDIRF4
ADDRLP4 988
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 992
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 580+8
ADDRLP4 992
INDIRP4
CNSTI4 6228
ADDP4
INDIRF4
ADDRLP4 992
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3622
;3621:	//
;3622:	if (bs->weaponnum == WP_GAUNTLET) {
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
CNSTI4 1
NEI4 $2070
line 3623
;3623:		if (VectorLengthSquared(dir) > Square(60)) {
ADDRLP4 580
ARGP4
ADDRLP4 996
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 996
INDIRF4
CNSTF4 1163984896
LEF4 $2072
line 3624
;3624:			return;
ADDRGP4 $2038
JUMPV
LABELV $2072
line 3626
;3625:		}
;3626:	}
LABELV $2070
line 3627
;3627:	if (VectorLengthSquared(dir) < Square(100))
ADDRLP4 580
ARGP4
ADDRLP4 996
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 996
INDIRF4
CNSTF4 1176256512
GEF4 $2074
line 3628
;3628:		fov = 120;
ADDRLP4 932
CNSTF4 1123024896
ASGNF4
ADDRGP4 $2075
JUMPV
LABELV $2074
line 3630
;3629:	else
;3630:		fov = 50;
ADDRLP4 932
CNSTF4 1112014848
ASGNF4
LABELV $2075
line 3632
;3631:	//
;3632:	vectoangles(dir, angles);
ADDRLP4 580
ARGP4
ADDRLP4 940
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3633
;3633:	if (!InFieldOfVision(bs->viewangles, fov, angles))
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
ADDRLP4 932
INDIRF4
ARGF4
ADDRLP4 940
ARGP4
ADDRLP4 1000
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 1000
INDIRI4
CNSTI4 0
NEI4 $2076
line 3634
;3634:		return;
ADDRGP4 $2038
JUMPV
LABELV $2076
line 3635
;3635:	BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, bs->aimtarget, bs->client, CONTENTS_SOLID|CONTENTS_PLAYERCLIP);
ADDRLP4 708
ARGP4
ADDRLP4 1004
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1004
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 1004
INDIRP4
CNSTI4 6220
ADDP4
ARGP4
ADDRLP4 1004
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 65537
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3636
;3636:	if (bsptrace.fraction < 1 && bsptrace.ent != attackentity)
ADDRLP4 708+8
INDIRF4
CNSTF4 1065353216
GEF4 $2078
ADDRLP4 708+80
INDIRI4
ADDRLP4 576
INDIRI4
EQI4 $2078
line 3637
;3637:		return;
ADDRGP4 $2038
JUMPV
LABELV $2078
line 3640
;3638:
;3639:	//get the weapon info
;3640:	trap_BotGetWeaponInfo(bs->ws, bs->weaponnum, &wi);
ADDRLP4 1008
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1008
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRLP4 1008
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRGP4 trap_BotGetWeaponInfo
CALLV
pop
line 3642
;3641:	//get the start point shooting from
;3642:	VectorCopy(bs->origin, start);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 3643
;3643:	start[2] += bs->cur_ps.viewheight;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 3644
;3644:	AngleVectors(bs->viewangles, forward, right, NULL);
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 676
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 3645
;3645:	start[0] += forward[0] * wi.offset[0] + right[0] * wi.offset[1];
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
ADDRLP4 24+292
INDIRF4
MULF4
ADDRLP4 676
INDIRF4
ADDRLP4 24+292+4
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 3646
;3646:	start[1] += forward[1] * wi.offset[0] + right[1] * wi.offset[1];
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 24+292
INDIRF4
MULF4
ADDRLP4 676+4
INDIRF4
ADDRLP4 24+292+4
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 3647
;3647:	start[2] += forward[2] * wi.offset[0] + right[2] * wi.offset[1] + wi.offset[2];
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDRLP4 24+292
INDIRF4
MULF4
ADDRLP4 676+8
INDIRF4
ADDRLP4 24+292+4
INDIRF4
MULF4
ADDF4
ADDRLP4 24+292+8
INDIRF4
ADDF4
ADDF4
ASGNF4
line 3649
;3648:	//end point aiming at
;3649:	VectorMA(start, 1000, forward, end);
ADDRLP4 688
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 1148846080
MULF4
ADDF4
ASGNF4
ADDRLP4 688+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
CNSTF4 1148846080
MULF4
ADDF4
ASGNF4
ADDRLP4 688+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
CNSTF4 1148846080
MULF4
ADDF4
ASGNF4
line 3651
;3650:	//a little back to make sure not inside a very close enemy
;3651:	VectorMA(start, -12, forward, start);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 3242196992
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
CNSTF4 3242196992
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
CNSTF4 3242196992
MULF4
ADDF4
ASGNF4
line 3652
;3652:	BotAI_Trace(&trace, start, mins, maxs, end, bs->entitynum, MASK_SHOT);
ADDRLP4 592
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 952
ARGP4
ADDRLP4 964
ARGP4
ADDRLP4 688
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3654
;3653:	//if the entity is a client
;3654:	if (trace.ent >= 0 && trace.ent < MAX_CLIENTS) {
ADDRLP4 592+80
INDIRI4
CNSTI4 0
LTI4 $2112
ADDRLP4 592+80
INDIRI4
CNSTI4 64
GEI4 $2112
line 3655
;3655:		if (trace.ent != attackentity) {
ADDRLP4 592+80
INDIRI4
ADDRLP4 576
INDIRI4
EQI4 $2116
line 3657
;3656:			//if a teammate is hit
;3657:			if (BotSameTeam(bs, trace.ent))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 592+80
INDIRI4
ARGI4
ADDRLP4 1012
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1012
INDIRI4
CNSTI4 0
EQI4 $2119
line 3658
;3658:				return;
ADDRGP4 $2038
JUMPV
LABELV $2119
line 3659
;3659:		}
LABELV $2116
line 3660
;3660:	}
LABELV $2112
line 3662
;3661:	//if won't hit the enemy or not attacking a player (obelisk)
;3662:	if (trace.ent != attackentity || attackentity >= MAX_CLIENTS) {
ADDRLP4 592+80
INDIRI4
ADDRLP4 576
INDIRI4
NEI4 $2125
ADDRLP4 576
INDIRI4
CNSTI4 64
LTI4 $2122
LABELV $2125
line 3664
;3663:		//if the projectile does radial damage
;3664:		if (wi.proj.damagetype & DAMAGETYPE_RADIAL) {
ADDRLP4 24+344+180
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $2126
line 3665
;3665:			if (trace.fraction * 1000 < wi.proj.radius) {
ADDRLP4 592+8
INDIRF4
CNSTF4 1148846080
MULF4
ADDRLP4 24+344+172
INDIRF4
GEF4 $2130
line 3666
;3666:				points = (wi.proj.damage - 0.5 * trace.fraction * 1000) * 0.5;
ADDRLP4 976
ADDRLP4 24+344+168
INDIRI4
CVIF4 4
ADDRLP4 592+8
INDIRF4
CNSTF4 1140457472
MULF4
SUBF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3667
;3667:				if (points > 0) {
ADDRLP4 976
INDIRF4
CNSTF4 0
LEF4 $2138
line 3668
;3668:					return;
ADDRGP4 $2038
JUMPV
LABELV $2138
line 3670
;3669:				}
;3670:			}
LABELV $2130
line 3672
;3671:			//FIXME: check if a teammate gets radial damage
;3672:		}
LABELV $2126
line 3673
;3673:	}
LABELV $2122
line 3675
;3674:
;3675:	weapon = bs->cur_ps.weapon;
ADDRLP4 700
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ASGNI4
line 3676
;3676:	if ( weapon >= WP_MACHINEGUN && weapon <= WP_BFG && !bs->cur_ps.ammo[ weapon ] ) {
ADDRLP4 700
INDIRI4
CNSTI4 2
LTI4 $2140
ADDRLP4 700
INDIRI4
CNSTI4 9
GTI4 $2140
ADDRLP4 700
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 392
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2140
line 3677
;3677:		return;
ADDRGP4 $2038
JUMPV
LABELV $2140
line 3681
;3678:	}
;3679:
;3680:	//if fire has to be release to activate weapon
;3681:	if (wi.flags & WFL_FIRERELEASED) {
ADDRLP4 24+176
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2142
line 3682
;3682:		if (bs->flags & BFL_ATTACKED) {
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $2143
line 3683
;3683:			trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 3684
;3684:		}
line 3685
;3685:	}
ADDRGP4 $2143
JUMPV
LABELV $2142
line 3686
;3686:	else {
line 3687
;3687:		trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 3688
;3688:	}
LABELV $2143
line 3689
;3689:	bs->flags ^= BFL_ATTACKED;
ADDRLP4 1020
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 1020
INDIRP4
ADDRLP4 1020
INDIRP4
INDIRI4
CNSTI4 2
BXORI4
ASGNI4
line 3690
;3690:}
LABELV $2038
endproc BotCheckAttack 1024 28
data
align 4
LABELV $2151
byte 4 1143930880
byte 4 1129054208
byte 4 1143472128
align 4
LABELV $2152
byte 4 1148256256
byte 4 1139408896
byte 4 1143603200
align 4
LABELV $2153
byte 4 1134034944
byte 4 1135607808
byte 4 1147535360
export BotMapScripts
code
proc BotMapScripts 264 16
line 3697
;3691:
;3692:/*
;3693:==================
;3694:BotMapScripts
;3695:==================
;3696:*/
;3697:void BotMapScripts(bot_state_t *bs) {
line 3703
;3698:	int i, shootbutton;
;3699:	float aim_accuracy;
;3700:	aas_entityinfo_t entinfo;
;3701:	vec3_t dir;
;3702:
;3703:	if (!Q_stricmp(mapname, "q3tourney6")) {
ADDRGP4 mapname
ARGP4
ADDRGP4 $2150
ARGP4
ADDRLP4 164
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
NEI4 $2148
line 3704
;3704:		vec3_t mins = {700, 204, 672}, maxs = {964, 468, 680};
ADDRLP4 168
ADDRGP4 $2151
INDIRB
ASGNB 12
ADDRLP4 180
ADDRGP4 $2152
INDIRB
ASGNB 12
line 3705
;3705:		vec3_t buttonorg = {304, 352, 920};
ADDRLP4 192
ADDRGP4 $2153
INDIRB
ASGNB 12
line 3707
;3706:		//NOTE: NEVER use the func_bobbing in q3tourney6
;3707:		bs->tfl &= ~TFL_FUNCBOB;
ADDRLP4 204
ADDRFP4 0
INDIRP4
CNSTI4 5976
ADDP4
ASGNP4
ADDRLP4 204
INDIRP4
ADDRLP4 204
INDIRP4
INDIRI4
CNSTI4 -16777217
BANDI4
ASGNI4
line 3709
;3708:		//if the bot is below the bounding box
;3709:		if (bs->origin[0] > mins[0] && bs->origin[0] < maxs[0]) {
ADDRLP4 208
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 208
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 168
INDIRF4
LEF4 $2154
ADDRLP4 208
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 180
INDIRF4
GEF4 $2154
line 3710
;3710:			if (bs->origin[1] > mins[1] && bs->origin[1] < maxs[1]) {
ADDRLP4 212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 212
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 168+4
INDIRF4
LEF4 $2156
ADDRLP4 212
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 180+4
INDIRF4
GEF4 $2156
line 3711
;3711:				if (bs->origin[2] < mins[2]) {
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 168+8
INDIRF4
GEF4 $2160
line 3712
;3712:					return;
ADDRGP4 $2147
JUMPV
LABELV $2160
line 3714
;3713:				}
;3714:			}
LABELV $2156
line 3715
;3715:		}
LABELV $2154
line 3716
;3716:		shootbutton = qfalse;
ADDRLP4 144
CNSTI4 0
ASGNI4
line 3718
;3717:		//if an enemy is below this bounding box then shoot the button
;3718:		for (i = 0; i < level.maxclients; i++) {
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRGP4 $2166
JUMPV
LABELV $2163
line 3720
;3719:
;3720:			if (i == bs->client) continue;
ADDRLP4 140
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2168
ADDRGP4 $2164
JUMPV
LABELV $2168
line 3722
;3721:			//
;3722:			BotEntityInfo(i, &entinfo);
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3724
;3723:			//
;3724:			if (!entinfo.valid) continue;
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2170
ADDRGP4 $2164
JUMPV
LABELV $2170
line 3726
;3725:			//if the enemy isn't dead and the enemy isn't the bot self
;3726:			if (EntityIsDead(&entinfo) || entinfo.number == bs->entitynum) continue;
ADDRLP4 0
ARGP4
ADDRLP4 212
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 212
INDIRI4
CNSTI4 0
NEI4 $2175
ADDRLP4 0+20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $2172
LABELV $2175
ADDRGP4 $2164
JUMPV
LABELV $2172
line 3728
;3727:			//
;3728:			if (entinfo.origin[0] > mins[0] && entinfo.origin[0] < maxs[0]) {
ADDRLP4 0+24
INDIRF4
ADDRLP4 168
INDIRF4
LEF4 $2176
ADDRLP4 0+24
INDIRF4
ADDRLP4 180
INDIRF4
GEF4 $2176
line 3729
;3729:				if (entinfo.origin[1] > mins[1] && entinfo.origin[1] < maxs[1]) {
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 168+4
INDIRF4
LEF4 $2180
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 180+4
INDIRF4
GEF4 $2180
line 3730
;3730:					if (entinfo.origin[2] < mins[2]) {
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 168+8
INDIRF4
GEF4 $2188
line 3732
;3731:						//if there's a team mate below the crusher
;3732:						if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 216
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 216
INDIRI4
CNSTI4 0
EQI4 $2193
line 3733
;3733:							shootbutton = qfalse;
ADDRLP4 144
CNSTI4 0
ASGNI4
line 3734
;3734:							break;
ADDRGP4 $2165
JUMPV
LABELV $2193
line 3736
;3735:						}
;3736:						else {
line 3737
;3737:							shootbutton = qtrue;
ADDRLP4 144
CNSTI4 1
ASGNI4
line 3738
;3738:						}
line 3739
;3739:					}
LABELV $2188
line 3740
;3740:				}
LABELV $2180
line 3741
;3741:			}
LABELV $2176
line 3742
;3742:		}
LABELV $2164
line 3718
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2166
ADDRLP4 140
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $2163
LABELV $2165
line 3743
;3743:		if (shootbutton) {
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $2149
line 3744
;3744:			bs->flags |= BFL_IDEALVIEWSET;
ADDRLP4 212
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 212
INDIRP4
ADDRLP4 212
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 3745
;3745:			VectorSubtract(buttonorg, bs->eye, dir);
ADDRLP4 216
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 148
ADDRLP4 192
INDIRF4
ADDRLP4 216
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 148+4
ADDRLP4 192+4
INDIRF4
ADDRLP4 216
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 148+8
ADDRLP4 192+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3746
;3746:			vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 148
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3747
;3747:			aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 7
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 220
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 160
ADDRLP4 220
INDIRF4
ASGNF4
line 3748
;3748:			bs->ideal_viewangles[PITCH] += 8 * crandom() * (1 - aim_accuracy);
ADDRLP4 224
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 228
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ASGNP4
ADDRLP4 228
INDIRP4
ADDRLP4 228
INDIRP4
INDIRF4
ADDRLP4 224
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
CNSTF4 1090519040
MULF4
CNSTF4 1065353216
ADDRLP4 160
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3749
;3749:			bs->ideal_viewangles[PITCH] = AngleMod(bs->ideal_viewangles[PITCH]);
ADDRLP4 232
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 232
INDIRP4
CNSTI4 6576
ADDP4
INDIRF4
ARGF4
ADDRLP4 236
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 232
INDIRP4
CNSTI4 6576
ADDP4
ADDRLP4 236
INDIRF4
ASGNF4
line 3750
;3750:			bs->ideal_viewangles[YAW] += 8 * crandom() * (1 - aim_accuracy);
ADDRLP4 240
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 244
ADDRFP4 0
INDIRP4
CNSTI4 6580
ADDP4
ASGNP4
ADDRLP4 244
INDIRP4
ADDRLP4 244
INDIRP4
INDIRF4
ADDRLP4 240
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
CNSTF4 1090519040
MULF4
CNSTF4 1065353216
ADDRLP4 160
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3751
;3751:			bs->ideal_viewangles[YAW] = AngleMod(bs->ideal_viewangles[YAW]);
ADDRLP4 248
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 248
INDIRP4
CNSTI4 6580
ADDP4
INDIRF4
ARGF4
ADDRLP4 252
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 248
INDIRP4
CNSTI4 6580
ADDP4
ADDRLP4 252
INDIRF4
ASGNF4
line 3753
;3752:			//
;3753:			if (InFieldOfVision(bs->viewangles, 20, bs->ideal_viewangles)) {
ADDRLP4 256
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 256
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1101004800
ARGF4
ADDRLP4 256
INDIRP4
CNSTI4 6576
ADDP4
ARGP4
ADDRLP4 260
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
EQI4 $2149
line 3754
;3754:				trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 3755
;3755:			}
line 3756
;3756:		}
line 3757
;3757:	}
ADDRGP4 $2149
JUMPV
LABELV $2148
line 3758
;3758:	else if (!Q_stricmp(mapname, "mpq3tourney6")) {
ADDRGP4 mapname
ARGP4
ADDRGP4 $2205
ARGP4
ADDRLP4 168
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
NEI4 $2203
line 3760
;3759:		//NOTE: NEVER use the func_bobbing in mpq3tourney6
;3760:		bs->tfl &= ~TFL_FUNCBOB;
ADDRLP4 172
ADDRFP4 0
INDIRP4
CNSTI4 5976
ADDP4
ASGNP4
ADDRLP4 172
INDIRP4
ADDRLP4 172
INDIRP4
INDIRI4
CNSTI4 -16777217
BANDI4
ASGNI4
line 3761
;3761:	}
LABELV $2203
LABELV $2149
line 3762
;3762:}
LABELV $2147
endproc BotMapScripts 264 16
data
align 4
LABELV VEC_UP
byte 4 0
byte 4 3212836864
byte 4 0
align 4
LABELV MOVEDIR_UP
byte 4 0
byte 4 0
byte 4 1065353216
align 4
LABELV VEC_DOWN
byte 4 0
byte 4 3221225472
byte 4 0
align 4
LABELV MOVEDIR_DOWN
byte 4 0
byte 4 0
byte 4 3212836864
export BotSetMovedir
code
proc BotSetMovedir 8 16
line 3775
;3763:
;3764:/*
;3765:==================
;3766:BotSetMovedir
;3767:==================
;3768:*/
;3769:// bk001205 - made these static
;3770:static vec3_t VEC_UP		= {0, -1,  0};
;3771:static vec3_t MOVEDIR_UP	= {0,  0,  1};
;3772:static vec3_t VEC_DOWN		= {0, -2,  0};
;3773:static vec3_t MOVEDIR_DOWN	= {0,  0, -1};
;3774:
;3775:void BotSetMovedir(vec3_t angles, vec3_t movedir) {
line 3776
;3776:	if (VectorCompare(angles, VEC_UP)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 VEC_UP
ARGP4
ADDRLP4 0
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2207
line 3777
;3777:		VectorCopy(MOVEDIR_UP, movedir);
ADDRFP4 4
INDIRP4
ADDRGP4 MOVEDIR_UP
INDIRB
ASGNB 12
line 3778
;3778:	}
ADDRGP4 $2208
JUMPV
LABELV $2207
line 3779
;3779:	else if (VectorCompare(angles, VEC_DOWN)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 VEC_DOWN
ARGP4
ADDRLP4 4
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2209
line 3780
;3780:		VectorCopy(MOVEDIR_DOWN, movedir);
ADDRFP4 4
INDIRP4
ADDRGP4 MOVEDIR_DOWN
INDIRB
ASGNB 12
line 3781
;3781:	}
ADDRGP4 $2210
JUMPV
LABELV $2209
line 3782
;3782:	else {
line 3783
;3783:		AngleVectors(angles, movedir, NULL, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 3784
;3784:	}
LABELV $2210
LABELV $2208
line 3785
;3785:}
LABELV $2206
endproc BotSetMovedir 8 16
export BotModelMinsMaxs
proc BotModelMinsMaxs 40 0
line 3794
;3786:
;3787:/*
;3788:==================
;3789:BotModelMinsMaxs
;3790:
;3791:this is ugly
;3792:==================
;3793:*/
;3794:int BotModelMinsMaxs(int modelindex, int eType, int contents, vec3_t mins, vec3_t maxs) {
line 3798
;3795:	gentity_t *ent;
;3796:	int i;
;3797:
;3798:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 3799
;3799:	for (i = 0; i < level.num_entities; i++, ent++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2215
JUMPV
LABELV $2212
line 3800
;3800:		if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2217
line 3801
;3801:			continue;
ADDRGP4 $2213
JUMPV
LABELV $2217
line 3803
;3802:		}
;3803:		if ( eType && ent->s.eType != eType) {
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $2219
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $2219
line 3804
;3804:			continue;
ADDRGP4 $2213
JUMPV
LABELV $2219
line 3806
;3805:		}
;3806:		if ( contents && ent->r.contents != contents) {
ADDRLP4 12
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2221
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $2221
line 3807
;3807:			continue;
ADDRGP4 $2213
JUMPV
LABELV $2221
line 3809
;3808:		}
;3809:		if (ent->s.modelindex == modelindex) {
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $2223
line 3810
;3810:			if (mins)
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2225
line 3811
;3811:				VectorAdd(ent->r.currentOrigin, ent->r.mins, mins);
ADDRFP4 12
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDF4
ASGNF4
LABELV $2225
line 3812
;3812:			if (maxs)
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2227
line 3813
;3813:				VectorAdd(ent->r.currentOrigin, ent->r.maxs, maxs);
ADDRFP4 16
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
ASGNF4
LABELV $2227
line 3814
;3814:			return i;
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $2211
JUMPV
LABELV $2223
line 3816
;3815:		}
;3816:	}
LABELV $2213
line 3799
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 824
ADDP4
ASGNP4
LABELV $2215
ADDRLP4 4
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $2212
line 3817
;3817:	if (mins)
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2229
line 3818
;3818:		VectorClear(mins);
ADDRFP4 12
INDIRP4
CNSTF4 0
ASGNF4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
LABELV $2229
line 3819
;3819:	if (maxs)
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2231
line 3820
;3820:		VectorClear(maxs);
ADDRFP4 16
INDIRP4
CNSTF4 0
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
LABELV $2231
line 3821
;3821:	return 0;
CNSTI4 0
RETI4
LABELV $2211
endproc BotModelMinsMaxs 40 0
data
align 4
LABELV $2234
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
align 4
LABELV $2235
byte 4 3212836864
byte 4 3212836864
byte 4 3212836864
export BotFuncButtonActivateGoal
code
proc BotFuncButtonActivateGoal 628 28
line 3829
;3822:}
;3823:
;3824:/*
;3825:==================
;3826:BotFuncButtonGoal
;3827:==================
;3828:*/
;3829:int BotFuncButtonActivateGoal(bot_state_t *bs, int bspent, bot_activategoal_t *activategoal) {
line 3835
;3830:	int i, areas[10], numareas, modelindex, entitynum;
;3831:	char model[128];
;3832:	float lip, dist, health, angle;
;3833:	vec3_t size, start, end, mins, maxs, angles, points[10];
;3834:	vec3_t movedir, origin, goalorigin, bboxmins, bboxmaxs;
;3835:	vec3_t extramins = {1, 1, 1}, extramaxs = {-1, -1, -1};
ADDRLP4 304
ADDRGP4 $2234
INDIRB
ASGNB 12
ADDRLP4 316
ADDRGP4 $2235
INDIRB
ASGNB 12
line 3838
;3836:	bsp_trace_t bsptrace;
;3837:
;3838:	activategoal->shoot = qfalse;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 3839
;3839:	VectorClear(activategoal->target);
ADDRFP4 8
INDIRP4
CNSTI4 80
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 84
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 88
ADDP4
CNSTF4 0
ASGNF4
line 3841
;3840:	//create a bot goal towards the button
;3841:	trap_AAS_ValueForBSPEpairKey(bspent, "model", model, sizeof(model));
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $525
ARGP4
ADDRLP4 160
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 3842
;3842:	if (!*model)
ADDRLP4 160
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2236
line 3843
;3843:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2233
JUMPV
LABELV $2236
line 3844
;3844:	modelindex = atoi(model+1);
ADDRLP4 160+1
ARGP4
ADDRLP4 560
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 288
ADDRLP4 560
INDIRI4
ASGNI4
line 3845
;3845:	if (!modelindex)
ADDRLP4 288
INDIRI4
CNSTI4 0
NEI4 $2239
line 3846
;3846:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2233
JUMPV
LABELV $2239
line 3847
;3847:	VectorClear(angles);
ADDRLP4 96
CNSTF4 0
ASGNF4
ADDRLP4 96+4
CNSTF4 0
ASGNF4
ADDRLP4 96+8
CNSTF4 0
ASGNF4
line 3848
;3848:	entitynum = BotModelMinsMaxs(modelindex, ET_MOVER, 0, mins, maxs);
ADDRLP4 288
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 72
ARGP4
ADDRLP4 84
ARGP4
ADDRLP4 564
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 344
ADDRLP4 564
INDIRI4
ASGNI4
line 3850
;3849:	//get the lip of the button
;3850:	trap_AAS_FloatForBSPEpairKey(bspent, "lip", &lip);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $2243
ARGP4
ADDRLP4 328
ARGP4
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
pop
line 3851
;3851:	if (!lip) lip = 4;
ADDRLP4 328
INDIRF4
CNSTF4 0
NEF4 $2244
ADDRLP4 328
CNSTF4 1082130432
ASGNF4
LABELV $2244
line 3853
;3852:	//get the move direction from the angle
;3853:	trap_AAS_FloatForBSPEpairKey(bspent, "angle", &angle);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $2246
ARGP4
ADDRLP4 352
ARGP4
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
pop
line 3854
;3854:	VectorSet(angles, 0, angle, 0);
ADDRLP4 96
CNSTF4 0
ASGNF4
ADDRLP4 96+4
ADDRLP4 352
INDIRF4
ASGNF4
ADDRLP4 96+8
CNSTF4 0
ASGNF4
line 3855
;3855:	BotSetMovedir(angles, movedir);
ADDRLP4 96
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 BotSetMovedir
CALLV
pop
line 3857
;3856:	//button size
;3857:	VectorSubtract(maxs, mins, size);
ADDRLP4 112
ADDRLP4 84
INDIRF4
ADDRLP4 72
INDIRF4
SUBF4
ASGNF4
ADDRLP4 112+4
ADDRLP4 84+4
INDIRF4
ADDRLP4 72+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 112+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 72+8
INDIRF4
SUBF4
ASGNF4
line 3859
;3858:	//button origin
;3859:	VectorAdd(mins, maxs, origin);
ADDRLP4 16
ADDRLP4 72
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 72+4
INDIRF4
ADDRLP4 84+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 72+8
INDIRF4
ADDRLP4 84+8
INDIRF4
ADDF4
ASGNF4
line 3860
;3860:	VectorScale(origin, 0.5, origin);
ADDRLP4 16
ADDRLP4 16
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 16+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 16+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3862
;3861:	//touch distance of the button
;3862:	dist = fabs(movedir[0]) * size[0] + fabs(movedir[1]) * size[1] + fabs(movedir[2]) * size[2];
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 568
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4+4
INDIRF4
ARGF4
ADDRLP4 572
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4+8
INDIRF4
ARGF4
ADDRLP4 576
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 568
INDIRF4
ADDRLP4 112
INDIRF4
MULF4
ADDRLP4 572
INDIRF4
ADDRLP4 112+4
INDIRF4
MULF4
ADDF4
ADDRLP4 576
INDIRF4
ADDRLP4 112+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3863
;3863:	dist *= 0.5;
ADDRLP4 28
ADDRLP4 28
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3865
;3864:	//
;3865:	trap_AAS_FloatForBSPEpairKey(bspent, "health", &health);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $2269
ARGP4
ADDRLP4 348
ARGP4
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
pop
line 3867
;3866:	//if the button is shootable
;3867:	if (health) {
ADDRLP4 348
INDIRF4
CNSTF4 0
EQF4 $2270
line 3869
;3868:		//calculate the shoot target
;3869:		VectorMA(origin, -dist, movedir, goalorigin);
ADDRLP4 580
ADDRLP4 28
INDIRF4
NEGF4
ASGNF4
ADDRLP4 124
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 580
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 580
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 28
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 3871
;3870:		//
;3871:		VectorCopy(goalorigin, activategoal->target);
ADDRFP4 8
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 124
INDIRB
ASGNB 12
line 3872
;3872:		activategoal->shoot = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 1
ASGNI4
line 3874
;3873:		//
;3874:		BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, goalorigin, bs->entitynum, MASK_SHOT);
ADDRLP4 356
ARGP4
ADDRLP4 584
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 584
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 124
ARGP4
ADDRLP4 584
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3876
;3875:		// if the button is visible from the current position
;3876:		if (bsptrace.fraction >= 1.0 || bsptrace.ent == entitynum) {
ADDRLP4 356+8
INDIRF4
CNSTF4 1065353216
GEF4 $2282
ADDRLP4 356+80
INDIRI4
ADDRLP4 344
INDIRI4
NEI4 $2278
LABELV $2282
line 3878
;3877:			//
;3878:			activategoal->goal.entitynum = entitynum; //NOTE: this is the entity number of the shootable button
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 344
INDIRI4
ASGNI4
line 3879
;3879:			activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 3880
;3880:			activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 3881
;3881:			VectorCopy(bs->origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 3882
;3882:			activategoal->goal.areanum = bs->areanum;
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ASGNI4
line 3883
;3883:			VectorSet(activategoal->goal.mins, -8, -8, -8);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 3238002688
ASGNF4
line 3884
;3884:			VectorSet(activategoal->goal.maxs, 8, 8, 8);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1090519040
ASGNF4
line 3886
;3885:			//
;3886:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2233
JUMPV
LABELV $2278
line 3888
;3887:		}
;3888:		else {
line 3891
;3889:			//create a goal from where the button is visible and shoot at the button from there
;3890:			//add bounding box size to the dist
;3891:			trap_AAS_PresenceTypeBoundingBox(PRESENCE_CROUCH, bboxmins, bboxmaxs);
CNSTI4 4
ARGI4
ADDRLP4 136
ARGP4
ADDRLP4 148
ARGP4
ADDRGP4 trap_AAS_PresenceTypeBoundingBox
CALLV
pop
line 3892
;3892:			for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2283
line 3893
;3893:				if (movedir[i] < 0) dist += fabs(movedir[i]) * fabs(bboxmaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $2287
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 588
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
ADDP4
INDIRF4
ARGF4
ADDRLP4 592
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 588
INDIRF4
ADDRLP4 592
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $2288
JUMPV
LABELV $2287
line 3894
;3894:				else dist += fabs(movedir[i]) * fabs(bboxmins[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 596
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 136
ADDP4
INDIRF4
ARGF4
ADDRLP4 600
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 596
INDIRF4
ADDRLP4 600
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $2288
line 3895
;3895:			}
LABELV $2284
line 3892
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $2283
line 3897
;3896:			//calculate the goal origin
;3897:			VectorMA(origin, -dist, movedir, goalorigin);
ADDRLP4 588
ADDRLP4 28
INDIRF4
NEGF4
ASGNF4
ADDRLP4 124
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 588
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 588
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 28
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 3899
;3898:			//
;3899:			VectorCopy(goalorigin, start);
ADDRLP4 292
ADDRLP4 124
INDIRB
ASGNB 12
line 3900
;3900:			start[2] += 24;
ADDRLP4 292+8
ADDRLP4 292+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 3901
;3901:			VectorCopy(start, end);
ADDRLP4 332
ADDRLP4 292
INDIRB
ASGNB 12
line 3902
;3902:			end[2] -= 512;
ADDRLP4 332+8
ADDRLP4 332+8
INDIRF4
CNSTF4 1140850688
SUBF4
ASGNF4
line 3903
;3903:			numareas = trap_AAS_TraceAreas(start, end, areas, points, 10);
ADDRLP4 292
ARGP4
ADDRLP4 332
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 440
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 592
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 108
ADDRLP4 592
INDIRI4
ASGNI4
line 3905
;3904:			//
;3905:			for (i = numareas-1; i >= 0; i--) {
ADDRLP4 0
ADDRLP4 108
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $2300
JUMPV
LABELV $2297
line 3906
;3906:				if (trap_AAS_AreaReachability(areas[i])) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ARGI4
ADDRLP4 596
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 596
INDIRI4
CNSTI4 0
EQI4 $2301
line 3907
;3907:					break;
ADDRGP4 $2299
JUMPV
LABELV $2301
line 3909
;3908:				}
;3909:			}
LABELV $2298
line 3905
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $2300
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $2297
LABELV $2299
line 3910
;3910:			if (i < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $2303
line 3912
;3911:				// FIXME: trace forward and maybe in other directions to find a valid area
;3912:			}
LABELV $2303
line 3913
;3913:			if (i >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $2305
line 3915
;3914:				//
;3915:				VectorCopy(points[i], activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 440
ADDP4
INDIRB
ASGNB 12
line 3916
;3916:				activategoal->goal.areanum = areas[i];
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ASGNI4
line 3917
;3917:				VectorSet(activategoal->goal.mins, 8, 8, 8);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1090519040
ASGNF4
line 3918
;3918:				VectorSet(activategoal->goal.maxs, -8, -8, -8);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 3238002688
ASGNF4
line 3920
;3919:				//
;3920:				for (i = 0; i < 3; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2307
line 3921
;3921:				{
line 3922
;3922:					if (movedir[i] < 0) activategoal->goal.maxs[i] += fabs(movedir[i]) * fabs(extramaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $2311
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 600
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 316
ADDP4
INDIRF4
ARGF4
ADDRLP4 604
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 608
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 608
INDIRP4
ADDRLP4 608
INDIRP4
INDIRF4
ADDRLP4 600
INDIRF4
ADDRLP4 604
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $2312
JUMPV
LABELV $2311
line 3923
;3923:					else activategoal->goal.mins[i] += fabs(movedir[i]) * fabs(extramins[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 616
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 304
ADDP4
INDIRF4
ARGF4
ADDRLP4 620
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 624
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDP4
ASGNP4
ADDRLP4 624
INDIRP4
ADDRLP4 624
INDIRP4
INDIRF4
ADDRLP4 616
INDIRF4
ADDRLP4 620
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $2312
line 3924
;3924:				} //end for
LABELV $2308
line 3920
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $2307
line 3926
;3925:				//
;3926:				activategoal->goal.entitynum = entitynum;
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 344
INDIRI4
ASGNI4
line 3927
;3927:				activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 3928
;3928:				activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 3929
;3929:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2233
JUMPV
LABELV $2305
line 3931
;3930:			}
;3931:		}
line 3932
;3932:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2233
JUMPV
LABELV $2270
line 3934
;3933:	}
;3934:	else {
line 3936
;3935:		//add bounding box size to the dist
;3936:		trap_AAS_PresenceTypeBoundingBox(PRESENCE_CROUCH, bboxmins, bboxmaxs);
CNSTI4 4
ARGI4
ADDRLP4 136
ARGP4
ADDRLP4 148
ARGP4
ADDRGP4 trap_AAS_PresenceTypeBoundingBox
CALLV
pop
line 3937
;3937:		for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2313
line 3938
;3938:			if (movedir[i] < 0) dist += fabs(movedir[i]) * fabs(bboxmaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $2317
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 580
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
ADDP4
INDIRF4
ARGF4
ADDRLP4 584
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 580
INDIRF4
ADDRLP4 584
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $2318
JUMPV
LABELV $2317
line 3939
;3939:			else dist += fabs(movedir[i]) * fabs(bboxmins[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 588
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 136
ADDP4
INDIRF4
ARGF4
ADDRLP4 592
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 588
INDIRF4
ADDRLP4 592
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $2318
line 3940
;3940:		}
LABELV $2314
line 3937
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $2313
line 3942
;3941:		//calculate the goal origin
;3942:		VectorMA(origin, -dist, movedir, goalorigin);
ADDRLP4 580
ADDRLP4 28
INDIRF4
NEGF4
ASGNF4
ADDRLP4 124
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 580
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 580
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 28
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 3944
;3943:		//
;3944:		VectorCopy(goalorigin, start);
ADDRLP4 292
ADDRLP4 124
INDIRB
ASGNB 12
line 3945
;3945:		start[2] += 24;
ADDRLP4 292+8
ADDRLP4 292+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 3946
;3946:		VectorCopy(start, end);
ADDRLP4 332
ADDRLP4 292
INDIRB
ASGNB 12
line 3947
;3947:		end[2] -= 100;
ADDRLP4 332+8
ADDRLP4 332+8
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 3948
;3948:		numareas = trap_AAS_TraceAreas(start, end, areas, NULL, 10);
ADDRLP4 292
ARGP4
ADDRLP4 332
ARGP4
ADDRLP4 32
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 584
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 108
ADDRLP4 584
INDIRI4
ASGNI4
line 3950
;3949:		//
;3950:		for (i = 0; i < numareas; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2330
JUMPV
LABELV $2327
line 3951
;3951:			if (trap_AAS_AreaReachability(areas[i])) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ARGI4
ADDRLP4 588
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 588
INDIRI4
CNSTI4 0
EQI4 $2331
line 3952
;3952:				break;
ADDRGP4 $2329
JUMPV
LABELV $2331
line 3954
;3953:			}
;3954:		}
LABELV $2328
line 3950
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2330
ADDRLP4 0
INDIRI4
ADDRLP4 108
INDIRI4
LTI4 $2327
LABELV $2329
line 3955
;3955:		if (i < numareas) {
ADDRLP4 0
INDIRI4
ADDRLP4 108
INDIRI4
GEI4 $2333
line 3957
;3956:			//
;3957:			VectorCopy(origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 16
INDIRB
ASGNB 12
line 3958
;3958:			activategoal->goal.areanum = areas[i];
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ASGNI4
line 3959
;3959:			VectorSubtract(mins, origin, activategoal->goal.mins);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 72
INDIRF4
ADDRLP4 16
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 72+4
INDIRF4
ADDRLP4 16+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 72+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
ASGNF4
line 3960
;3960:			VectorSubtract(maxs, origin, activategoal->goal.maxs);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 84
INDIRF4
ADDRLP4 16
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 84+4
INDIRF4
ADDRLP4 16+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 84+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
ASGNF4
line 3962
;3961:			//
;3962:			for (i = 0; i < 3; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2343
line 3963
;3963:			{
line 3964
;3964:				if (movedir[i] < 0) activategoal->goal.maxs[i] += fabs(movedir[i]) * fabs(extramaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $2347
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 592
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 316
ADDP4
INDIRF4
ARGF4
ADDRLP4 596
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 600
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 600
INDIRP4
ADDRLP4 600
INDIRP4
INDIRF4
ADDRLP4 592
INDIRF4
ADDRLP4 596
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $2348
JUMPV
LABELV $2347
line 3965
;3965:				else activategoal->goal.mins[i] += fabs(movedir[i]) * fabs(extramins[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 608
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 304
ADDP4
INDIRF4
ARGF4
ADDRLP4 612
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 616
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDP4
ASGNP4
ADDRLP4 616
INDIRP4
ADDRLP4 616
INDIRP4
INDIRF4
ADDRLP4 608
INDIRF4
ADDRLP4 612
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $2348
line 3966
;3966:			} //end for
LABELV $2344
line 3962
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $2343
line 3968
;3967:			//
;3968:			activategoal->goal.entitynum = entitynum;
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 344
INDIRI4
ASGNI4
line 3969
;3969:			activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 3970
;3970:			activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 3971
;3971:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2233
JUMPV
LABELV $2333
line 3973
;3972:		}
;3973:	}
line 3974
;3974:	return qfalse;
CNSTI4 0
RETI4
LABELV $2233
endproc BotFuncButtonActivateGoal 628 28
export BotFuncDoorActivateGoal
proc BotFuncDoorActivateGoal 1076 20
line 3982
;3975:}
;3976:
;3977:/*
;3978:==================
;3979:BotFuncDoorGoal
;3980:==================
;3981:*/
;3982:int BotFuncDoorActivateGoal(bot_state_t *bs, int bspent, bot_activategoal_t *activategoal) {
line 3989
;3983:	int modelindex, entitynum;
;3984:	char model[MAX_INFO_STRING];
;3985:	vec3_t mins, maxs, origin;
;3986:	//vec3_t angles;
;3987:
;3988:	//shoot at the shootable door
;3989:	trap_AAS_ValueForBSPEpairKey(bspent, "model", model, sizeof(model));
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $525
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 3990
;3990:	if (!*model)
ADDRLP4 12
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2350
line 3991
;3991:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2349
JUMPV
LABELV $2350
line 3992
;3992:	modelindex = atoi(model+1);
ADDRLP4 12+1
ARGP4
ADDRLP4 1068
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1060
ADDRLP4 1068
INDIRI4
ASGNI4
line 3993
;3993:	if (!modelindex)
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $2353
line 3994
;3994:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2349
JUMPV
LABELV $2353
line 3996
;3995:	//VectorClear(angles);
;3996:	entitynum = BotModelMinsMaxs(modelindex, ET_MOVER, 0, mins, maxs);
ADDRLP4 1060
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 1036
ARGP4
ADDRLP4 1048
ARGP4
ADDRLP4 1072
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 1064
ADDRLP4 1072
INDIRI4
ASGNI4
line 3998
;3997:	//door origin
;3998:	VectorAdd(mins, maxs, origin);
ADDRLP4 0
ADDRLP4 1036
INDIRF4
ADDRLP4 1048
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 1036+4
INDIRF4
ADDRLP4 1048+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 1036+8
INDIRF4
ADDRLP4 1048+8
INDIRF4
ADDF4
ASGNF4
line 3999
;3999:	VectorScale(origin, 0.5, origin);
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 4000
;4000:	VectorCopy(origin, activategoal->target);
ADDRFP4 8
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 4001
;4001:	activategoal->shoot = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 1
ASGNI4
line 4003
;4002:	//
;4003:	activategoal->goal.entitynum = entitynum; //NOTE: this is the entity number of the shootable door
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 1064
INDIRI4
ASGNI4
line 4004
;4004:	activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 4005
;4005:	activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 4006
;4006:	VectorCopy(bs->origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 4007
;4007:	activategoal->goal.areanum = bs->areanum;
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ASGNI4
line 4008
;4008:	VectorSet(activategoal->goal.mins, -8, -8, -8);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 3238002688
ASGNF4
line 4009
;4009:	VectorSet(activategoal->goal.maxs, 8, 8, 8);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1090519040
ASGNF4
line 4010
;4010:	return qtrue;
CNSTI4 1
RETI4
LABELV $2349
endproc BotFuncDoorActivateGoal 1076 20
export BotTriggerMultipleActivateGoal
proc BotTriggerMultipleActivateGoal 272 20
line 4018
;4011:}
;4012:
;4013:/*
;4014:==================
;4015:BotTriggerMultipleGoal
;4016:==================
;4017:*/
;4018:int BotTriggerMultipleActivateGoal(bot_state_t *bs, int bspent, bot_activategoal_t *activategoal) {
line 4025
;4019:	int i, areas[10], numareas, modelindex, entitynum;
;4020:	char model[128];
;4021:	vec3_t start, end, mins, maxs;
;4022:	//vec3_t angles;
;4023:	vec3_t origin, goalorigin;
;4024:
;4025:	activategoal->shoot = qfalse;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 4026
;4026:	VectorClear(activategoal->target);
ADDRFP4 8
INDIRP4
CNSTI4 80
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 84
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 88
ADDP4
CNSTF4 0
ASGNF4
line 4028
;4027:	//create a bot goal towards the trigger
;4028:	trap_AAS_ValueForBSPEpairKey(bspent, "model", model, sizeof(model));
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $525
ARGP4
ADDRLP4 84
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4029
;4029:	if (!*model)
ADDRLP4 84
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2366
line 4030
;4030:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2365
JUMPV
LABELV $2366
line 4031
;4031:	modelindex = atoi(model+1);
ADDRLP4 84+1
ARGP4
ADDRLP4 256
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 224
ADDRLP4 256
INDIRI4
ASGNI4
line 4032
;4032:	if (!modelindex)
ADDRLP4 224
INDIRI4
CNSTI4 0
NEI4 $2369
line 4033
;4033:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2365
JUMPV
LABELV $2369
line 4035
;4034:	//VectorClear(angles);
;4035:	entitynum = BotModelMinsMaxs(modelindex, 0, CONTENTS_TRIGGER, mins, maxs);
ADDRLP4 224
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1073741824
ARGI4
ADDRLP4 60
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 260
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 252
ADDRLP4 260
INDIRI4
ASGNI4
line 4037
;4036:	//trigger origin
;4037:	VectorAdd(mins, maxs, origin);
ADDRLP4 4
ADDRLP4 60
INDIRF4
ADDRLP4 72
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 60+4
INDIRF4
ADDRLP4 72+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 60+8
INDIRF4
ADDRLP4 72+8
INDIRF4
ADDF4
ASGNF4
line 4038
;4038:	VectorScale(origin, 0.5, origin);
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 4039
;4039:	VectorCopy(origin, goalorigin);
ADDRLP4 240
ADDRLP4 4
INDIRB
ASGNB 12
line 4041
;4040:	//
;4041:	VectorCopy(goalorigin, start);
ADDRLP4 212
ADDRLP4 240
INDIRB
ASGNB 12
line 4042
;4042:	start[2] += 24;
ADDRLP4 212+8
ADDRLP4 212+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 4043
;4043:	VectorCopy(start, end);
ADDRLP4 228
ADDRLP4 212
INDIRB
ASGNB 12
line 4044
;4044:	end[2] -= 100;
ADDRLP4 228+8
ADDRLP4 228+8
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 4045
;4045:	numareas = trap_AAS_TraceAreas(start, end, areas, NULL, 10);
ADDRLP4 212
ARGP4
ADDRLP4 228
ARGP4
ADDRLP4 20
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 264
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 264
INDIRI4
ASGNI4
line 4047
;4046:	//
;4047:	for (i = 0; i < numareas; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2386
JUMPV
LABELV $2383
line 4048
;4048:		if (trap_AAS_AreaReachability(areas[i])) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 268
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 0
EQI4 $2387
line 4049
;4049:			break;
ADDRGP4 $2385
JUMPV
LABELV $2387
line 4051
;4050:		}
;4051:	}
LABELV $2384
line 4047
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2386
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $2383
LABELV $2385
line 4052
;4052:	if (i < numareas) {
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
GEI4 $2389
line 4053
;4053:		VectorCopy(origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 4054
;4054:		activategoal->goal.areanum = areas[i];
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
ADDP4
INDIRI4
ASGNI4
line 4055
;4055:		VectorSubtract(mins, origin, activategoal->goal.mins);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 60
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 60+4
INDIRF4
ADDRLP4 4+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 60+8
INDIRF4
ADDRLP4 4+8
INDIRF4
SUBF4
ASGNF4
line 4056
;4056:		VectorSubtract(maxs, origin, activategoal->goal.maxs);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 72
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 72+4
INDIRF4
ADDRLP4 4+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 72+8
INDIRF4
ADDRLP4 4+8
INDIRF4
SUBF4
ASGNF4
line 4058
;4057:		//
;4058:		activategoal->goal.entitynum = entitynum;
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 252
INDIRI4
ASGNI4
line 4059
;4059:		activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 4060
;4060:		activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 4061
;4061:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2365
JUMPV
LABELV $2389
line 4063
;4062:	}
;4063:	return qfalse;
CNSTI4 0
RETI4
LABELV $2365
endproc BotTriggerMultipleActivateGoal 272 20
export BotPopFromActivateGoalStack
proc BotPopFromActivateGoalStack 4 8
line 4071
;4064:}
;4065:
;4066:/*
;4067:==================
;4068:BotPopFromActivateGoalStack
;4069:==================
;4070:*/
;4071:int BotPopFromActivateGoalStack(bot_state_t *bs) {
line 4072
;4072:	if (!bs->activatestack)
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2400
line 4073
;4073:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2399
JUMPV
LABELV $2400
line 4074
;4074:	BotEnableActivateGoalAreas(bs->activatestack, qtrue);
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4075
;4075:	bs->activatestack->inuse = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 0
ASGNI4
line 4076
;4076:	bs->activatestack->justused_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 68
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4077
;4077:	bs->activatestack = bs->activatestack->next;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 7120
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 4078
;4078:	return qtrue;
CNSTI4 1
RETI4
LABELV $2399
endproc BotPopFromActivateGoalStack 4 8
export BotPushOntoActivateGoalStack
proc BotPushOntoActivateGoalStack 20 12
line 4086
;4079:}
;4080:
;4081:/*
;4082:==================
;4083:BotPushOntoActivateGoalStack
;4084:==================
;4085:*/
;4086:int BotPushOntoActivateGoalStack(bot_state_t *bs, bot_activategoal_t *activategoal) {
line 4090
;4087:	int i, best;
;4088:	float besttime;
;4089:
;4090:	best = -1;
ADDRLP4 8
CNSTI4 -1
ASGNI4
line 4091
;4091:	besttime = FloatTime() + 9999;
ADDRLP4 4
ADDRGP4 floattime
INDIRF4
CNSTF4 1176255488
ADDF4
ASGNF4
line 4093
;4092:	//
;4093:	for (i = 0; i < MAX_ACTIVATESTACK; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2403
line 4094
;4094:		if (!bs->activategoalheap[i].inuse) {
ADDRLP4 0
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2407
line 4095
;4095:			if (bs->activategoalheap[i].justused_time < besttime) {
ADDRLP4 0
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
CNSTI4 68
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
GEF4 $2409
line 4096
;4096:				besttime = bs->activategoalheap[i].justused_time;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
CNSTI4 68
ADDP4
INDIRF4
ASGNF4
line 4097
;4097:				best = i;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ASGNI4
line 4098
;4098:			}
LABELV $2409
line 4099
;4099:		}
LABELV $2407
line 4100
;4100:	}
LABELV $2404
line 4093
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $2403
line 4101
;4101:	if (best != -1) {
ADDRLP4 8
INDIRI4
CNSTI4 -1
EQI4 $2411
line 4102
;4102:		memcpy(&bs->activategoalheap[best], activategoal, sizeof(bot_activategoal_t));
ADDRLP4 8
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTU4 244
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 4103
;4103:		bs->activategoalheap[best].inuse = qtrue;
ADDRLP4 8
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
CNSTI4 1
ASGNI4
line 4104
;4104:		bs->activategoalheap[best].next = bs->activatestack;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRI4
CNSTI4 244
MULI4
ADDRLP4 12
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
CNSTI4 240
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
ASGNP4
line 4105
;4105:		bs->activatestack = &bs->activategoalheap[best];
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 7120
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 244
MULI4
ADDRLP4 16
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
ASGNP4
line 4106
;4106:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2402
JUMPV
LABELV $2411
line 4108
;4107:	}
;4108:	return qfalse;
CNSTI4 0
RETI4
LABELV $2402
endproc BotPushOntoActivateGoalStack 20 12
export BotClearActivateGoalStack
proc BotClearActivateGoalStack 0 4
line 4116
;4109:}
;4110:
;4111:/*
;4112:==================
;4113:BotClearActivateGoalStack
;4114:==================
;4115:*/
;4116:void BotClearActivateGoalStack(bot_state_t *bs) {
ADDRGP4 $2415
JUMPV
LABELV $2414
line 4118
;4117:	while(bs->activatestack)
;4118:		BotPopFromActivateGoalStack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotPopFromActivateGoalStack
CALLI4
pop
LABELV $2415
line 4117
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2414
line 4119
;4119:}
LABELV $2413
endproc BotClearActivateGoalStack 0 4
export BotEnableActivateGoalAreas
proc BotEnableActivateGoalAreas 12 8
line 4126
;4120:
;4121:/*
;4122:==================
;4123:BotEnableActivateGoalAreas
;4124:==================
;4125:*/
;4126:void BotEnableActivateGoalAreas(bot_activategoal_t *activategoal, int enable) {
line 4129
;4127:	int i;
;4128:
;4129:	if (activategoal->areasdisabled == !enable)
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $2421
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $2422
JUMPV
LABELV $2421
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $2422
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $2418
line 4130
;4130:		return;
ADDRGP4 $2417
JUMPV
LABELV $2418
line 4131
;4131:	for (i = 0; i < activategoal->numareas; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2426
JUMPV
LABELV $2423
line 4132
;4132:		trap_AAS_EnableRoutingArea( activategoal->areas[i], enable );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 trap_AAS_EnableRoutingArea
CALLI4
pop
LABELV $2424
line 4131
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2426
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
LTI4 $2423
line 4133
;4133:	activategoal->areasdisabled = !enable;
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $2428
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $2429
JUMPV
LABELV $2428
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $2429
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 4134
;4134:}
LABELV $2417
endproc BotEnableActivateGoalAreas 12 8
export BotIsGoingToActivateEntity
proc BotIsGoingToActivateEntity 8 0
line 4141
;4135:
;4136:/*
;4137:==================
;4138:BotIsGoingToActivateEntity
;4139:==================
;4140:*/
;4141:int BotIsGoingToActivateEntity(bot_state_t *bs, int entitynum) {
line 4145
;4142:	bot_activategoal_t *a;
;4143:	int i;
;4144:
;4145:	for (a = bs->activatestack; a; a = a->next) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $2434
JUMPV
LABELV $2431
line 4146
;4146:		if (a->time < FloatTime())
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $2435
line 4147
;4147:			continue;
ADDRGP4 $2432
JUMPV
LABELV $2435
line 4148
;4148:		if (a->goal.entitynum == entitynum)
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $2437
line 4149
;4149:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2430
JUMPV
LABELV $2437
line 4150
;4150:	}
LABELV $2432
line 4145
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
LABELV $2434
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2431
line 4151
;4151:	for (i = 0; i < MAX_ACTIVATESTACK; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $2439
line 4152
;4152:		if (bs->activategoalheap[i].inuse)
ADDRLP4 4
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2443
line 4153
;4153:			continue;
ADDRGP4 $2440
JUMPV
LABELV $2443
line 4155
;4154:		//
;4155:		if (bs->activategoalheap[i].goal.entitynum == entitynum) {
ADDRLP4 4
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
CNSTI4 44
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $2445
line 4157
;4156:			// if the bot went for this goal less than 2 seconds ago
;4157:			if (bs->activategoalheap[i].justused_time > FloatTime() - 2)
ADDRLP4 4
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
CNSTI4 68
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
LEF4 $2447
line 4158
;4158:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2430
JUMPV
LABELV $2447
line 4159
;4159:		}
LABELV $2445
line 4160
;4160:	}
LABELV $2440
line 4151
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 8
LTI4 $2439
line 4161
;4161:	return qfalse;
CNSTI4 0
RETI4
LABELV $2430
endproc BotIsGoingToActivateEntity 8 0
export BotGetActivateGoal
proc BotGetActivateGoal 3304 20
line 4174
;4162:}
;4163:
;4164:/*
;4165:==================
;4166:BotGetActivateGoal
;4167:
;4168:  returns the number of the bsp entity to activate
;4169:  goal->entitynum will be set to the game entity to activate
;4170:==================
;4171:*/
;4172://#define OBSTACLEDEBUG
;4173:
;4174:int BotGetActivateGoal(bot_state_t *bs, int entitynum, bot_activategoal_t *activategoal) {
line 4185
;4175:	int i, ent, cur_entities[10], spawnflags, modelindex, areas[MAX_ACTIVATEAREAS*2], numareas, t;
;4176:	char model[MAX_INFO_STRING], tmpmodel[128];
;4177:	char target[128], classname[128];
;4178:	float health;
;4179:	char targetname[10][128];
;4180:	aas_entityinfo_t entinfo;
;4181:	aas_areainfo_t areainfo;
;4182:	vec3_t origin, absmins, absmaxs;
;4183:	//vec3_t angles;
;4184:
;4185:	memset(activategoal, 0, sizeof(bot_activategoal_t));
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 244
ARGU4
ADDRGP4 memset
CALLP4
pop
line 4186
;4186:	BotEntityInfo(entitynum, &entinfo);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 3052
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4187
;4187:	Com_sprintf(model, sizeof( model ), "*%d", entinfo.modelindex);
ADDRLP4 1712
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2450
ARGP4
ADDRLP4 3052+104
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4188
;4188:	for (ent = trap_AAS_NextBSPEntity(0); ent; ent = trap_AAS_NextBSPEntity(ent)) {
CNSTI4 0
ARGI4
ADDRLP4 3240
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 3240
INDIRI4
ASGNI4
ADDRGP4 $2455
JUMPV
LABELV $2452
line 4189
;4189:		if (!trap_AAS_ValueForBSPEpairKey(ent, "model", tmpmodel, sizeof(tmpmodel))) continue;
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $525
ARGP4
ADDRLP4 1584
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3244
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3244
INDIRI4
CNSTI4 0
NEI4 $2456
ADDRGP4 $2453
JUMPV
LABELV $2456
line 4190
;4190:		if (!strcmp(model, tmpmodel)) break;
ADDRLP4 1712
ARGP4
ADDRLP4 1584
ARGP4
ADDRLP4 3248
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3248
INDIRI4
CNSTI4 0
NEI4 $2458
ADDRGP4 $2454
JUMPV
LABELV $2458
line 4191
;4191:	}
LABELV $2453
line 4188
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 3244
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 3244
INDIRI4
ASGNI4
LABELV $2455
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2452
LABELV $2454
line 4192
;4192:	if (!ent) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2460
line 4193
;4193:		BotAI_Print(PRT_ERROR, "BotGetActivateGoal: no entity found with model %s\n", model);
CNSTI4 3
ARGI4
ADDRGP4 $2462
ARGP4
ADDRLP4 1712
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4194
;4194:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2449
JUMPV
LABELV $2460
line 4196
;4195:	}
;4196:	trap_AAS_ValueForBSPEpairKey(ent, "classname", classname, sizeof(classname));
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2463
ARGP4
ADDRLP4 1456
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4197
;4197:	if (!*classname) {
ADDRLP4 1456
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2464
line 4198
;4198:		BotAI_Print(PRT_ERROR, "BotGetActivateGoal: entity with model %s has no classname\n", model);
CNSTI4 3
ARGI4
ADDRGP4 $2466
ARGP4
ADDRLP4 1712
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4199
;4199:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2449
JUMPV
LABELV $2464
line 4202
;4200:	}
;4201:	//if it is a door
;4202:	if (!strcmp(classname, "func_door")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2469
ARGP4
ADDRLP4 3248
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3248
INDIRI4
CNSTI4 0
NEI4 $2467
line 4203
;4203:		if (trap_AAS_FloatForBSPEpairKey(ent, "health", &health)) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2269
ARGP4
ADDRLP4 3208
ARGP4
ADDRLP4 3252
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3252
INDIRI4
CNSTI4 0
EQI4 $2470
line 4205
;4204:			//if the door has health then the door must be shot to open
;4205:			if (health) {
ADDRLP4 3208
INDIRF4
CNSTF4 0
EQF4 $2472
line 4206
;4206:				BotFuncDoorActivateGoal(bs, ent, activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 BotFuncDoorActivateGoal
CALLI4
pop
line 4207
;4207:				return ent;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $2449
JUMPV
LABELV $2472
line 4209
;4208:			}
;4209:		}
LABELV $2470
line 4211
;4210:		//
;4211:		trap_AAS_IntForBSPEpairKey(ent, "spawnflags", &spawnflags);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2474
ARGP4
ADDRLP4 3204
ARGP4
ADDRGP4 trap_AAS_IntForBSPEpairKey
CALLI4
pop
line 4213
;4212:		// if the door starts open then just wait for the door to return
;4213:		if ( spawnflags & 1 )
ADDRLP4 3204
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2475
line 4214
;4214:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $2449
JUMPV
LABELV $2475
line 4216
;4215:		//get the door origin
;4216:		if (!trap_AAS_VectorForBSPEpairKey(ent, "origin", origin)) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2479
ARGP4
ADDRLP4 3192
ARGP4
ADDRLP4 3256
ADDRGP4 trap_AAS_VectorForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3256
INDIRI4
CNSTI4 0
NEI4 $2477
line 4217
;4217:			VectorClear(origin);
ADDRLP4 3192
CNSTF4 0
ASGNF4
ADDRLP4 3192+4
CNSTF4 0
ASGNF4
ADDRLP4 3192+8
CNSTF4 0
ASGNF4
line 4218
;4218:		}
LABELV $2477
line 4220
;4219:		//if the door is open or opening already
;4220:		if (!VectorCompare(origin, entinfo.origin))
ADDRLP4 3192
ARGP4
ADDRLP4 3052+24
ARGP4
ADDRLP4 3260
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 3260
INDIRI4
CNSTI4 0
NEI4 $2482
line 4221
;4221:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $2449
JUMPV
LABELV $2482
line 4223
;4222:		// store all the areas the door is in
;4223:		trap_AAS_ValueForBSPEpairKey(ent, "model", model, sizeof(model));
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $525
ARGP4
ADDRLP4 1712
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4224
;4224:		if (*model) {
ADDRLP4 1712
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $2485
line 4225
;4225:			modelindex = atoi(model+1);
ADDRLP4 1712+1
ARGP4
ADDRLP4 3264
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 3212
ADDRLP4 3264
INDIRI4
ASGNI4
line 4226
;4226:			if (modelindex) {
ADDRLP4 3212
INDIRI4
CNSTI4 0
EQI4 $2488
line 4228
;4227:				//VectorClear(angles);
;4228:				BotModelMinsMaxs(modelindex, ET_MOVER, 0, absmins, absmaxs);
ADDRLP4 3212
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 3216
ARGP4
ADDRLP4 3228
ARGP4
ADDRGP4 BotModelMinsMaxs
CALLI4
pop
line 4230
;4229:				//
;4230:				numareas = trap_AAS_BBoxAreas(absmins, absmaxs, areas, MAX_ACTIVATEAREAS*2);
ADDRLP4 3216
ARGP4
ADDRLP4 3228
ARGP4
ADDRLP4 2740
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 3268
ADDRGP4 trap_AAS_BBoxAreas
CALLI4
ASGNI4
ADDRLP4 3048
ADDRLP4 3268
INDIRI4
ASGNI4
line 4232
;4231:				// store the areas with reachabilities first
;4232:				for (i = 0; i < numareas; i++) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $2493
JUMPV
LABELV $2490
line 4233
;4233:					if (activategoal->numareas >= MAX_ACTIVATEAREAS)
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 32
LTI4 $2494
line 4234
;4234:						break;
ADDRGP4 $2492
JUMPV
LABELV $2494
line 4235
;4235:					if ( !trap_AAS_AreaReachability(areas[i]) ) {
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 3272
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3272
INDIRI4
CNSTI4 0
NEI4 $2496
line 4236
;4236:						continue;
ADDRGP4 $2491
JUMPV
LABELV $2496
line 4238
;4237:					}
;4238:					trap_AAS_AreaInfo(areas[i], &areainfo);
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 2996
ARGP4
ADDRGP4 trap_AAS_AreaInfo
CALLI4
pop
line 4239
;4239:					if (areainfo.contents & AREACONTENTS_MOVER) {
ADDRLP4 2996
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $2498
line 4240
;4240:						activategoal->areas[activategoal->numareas++] = areas[i];
ADDRLP4 3280
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 3276
ADDRLP4 3280
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 3280
INDIRP4
ADDRLP4 3276
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 3276
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 104
ADDP4
ADDP4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ASGNI4
line 4241
;4241:					}
LABELV $2498
line 4242
;4242:				}
LABELV $2491
line 4232
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2493
ADDRLP4 132
INDIRI4
ADDRLP4 3048
INDIRI4
LTI4 $2490
LABELV $2492
line 4244
;4243:				// store any remaining areas
;4244:				for (i = 0; i < numareas; i++) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $2503
JUMPV
LABELV $2500
line 4245
;4245:					if (activategoal->numareas >= MAX_ACTIVATEAREAS)
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 32
LTI4 $2504
line 4246
;4246:						break;
ADDRGP4 $2502
JUMPV
LABELV $2504
line 4247
;4247:					if ( trap_AAS_AreaReachability(areas[i]) ) {
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 3272
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3272
INDIRI4
CNSTI4 0
EQI4 $2506
line 4248
;4248:						continue;
ADDRGP4 $2501
JUMPV
LABELV $2506
line 4250
;4249:					}
;4250:					trap_AAS_AreaInfo(areas[i], &areainfo);
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 2996
ARGP4
ADDRGP4 trap_AAS_AreaInfo
CALLI4
pop
line 4251
;4251:					if (areainfo.contents & AREACONTENTS_MOVER) {
ADDRLP4 2996
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $2508
line 4252
;4252:						activategoal->areas[activategoal->numareas++] = areas[i];
ADDRLP4 3280
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 3276
ADDRLP4 3280
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 3280
INDIRP4
ADDRLP4 3276
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 3276
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 104
ADDP4
ADDP4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ASGNI4
line 4253
;4253:					}
LABELV $2508
line 4254
;4254:				}
LABELV $2501
line 4244
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2503
ADDRLP4 132
INDIRI4
ADDRLP4 3048
INDIRI4
LTI4 $2500
LABELV $2502
line 4255
;4255:			}
LABELV $2488
line 4256
;4256:		}
LABELV $2485
line 4257
;4257:	}
LABELV $2467
line 4259
;4258:	// if the bot is blocked by or standing on top of a button
;4259:	if (!strcmp(classname, "func_button")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2512
ARGP4
ADDRLP4 3252
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3252
INDIRI4
CNSTI4 0
NEI4 $2510
line 4260
;4260:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2449
JUMPV
LABELV $2510
line 4263
;4261:	}
;4262:	// get the targetname so we can find an entity with a matching target
;4263:	if (!trap_AAS_ValueForBSPEpairKey(ent, "targetname", targetname[0], sizeof(targetname[0]))) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2515
ARGP4
ADDRLP4 136
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3256
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3256
INDIRI4
CNSTI4 0
NEI4 $2513
line 4264
;4264:		if (bot_developer.integer) {
ADDRGP4 bot_developer+12
INDIRI4
CNSTI4 0
EQI4 $2516
line 4265
;4265:			BotAI_Print(PRT_ERROR, "BotGetActivateGoal: entity with model \"%s\" has no targetname\n", model);
CNSTI4 3
ARGI4
ADDRGP4 $2519
ARGP4
ADDRLP4 1712
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4266
;4266:		}
LABELV $2516
line 4267
;4267:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2449
JUMPV
LABELV $2513
line 4270
;4268:	}
;4269:	// allow tree-like activation
;4270:	cur_entities[0] = trap_AAS_NextBSPEntity(0);
CNSTI4 0
ARGI4
ADDRLP4 3260
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 1416
ADDRLP4 3260
INDIRI4
ASGNI4
line 4271
;4271:	for (i = 0; i >= 0 && i < 10;) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $2523
JUMPV
LABELV $2520
line 4272
;4272:		for (ent = cur_entities[i]; ent; ent = trap_AAS_NextBSPEntity(ent)) {
ADDRLP4 0
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1416
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $2527
JUMPV
LABELV $2524
line 4273
;4273:			if (!trap_AAS_ValueForBSPEpairKey(ent, "target", target, sizeof(target))) continue;
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2530
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3264
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3264
INDIRI4
CNSTI4 0
NEI4 $2528
ADDRGP4 $2525
JUMPV
LABELV $2528
line 4274
;4274:			if (!strcmp(targetname[i], target)) {
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 3268
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3268
INDIRI4
CNSTI4 0
NEI4 $2531
line 4275
;4275:				cur_entities[i] = trap_AAS_NextBSPEntity(ent);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 3272
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1416
ADDP4
ADDRLP4 3272
INDIRI4
ASGNI4
line 4276
;4276:				break;
ADDRGP4 $2526
JUMPV
LABELV $2531
line 4278
;4277:			}
;4278:		}
LABELV $2525
line 4272
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 3264
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 3264
INDIRI4
ASGNI4
LABELV $2527
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2524
LABELV $2526
line 4279
;4279:		if (!ent) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2533
line 4280
;4280:			if (bot_developer.integer) {
ADDRGP4 bot_developer+12
INDIRI4
CNSTI4 0
EQI4 $2535
line 4281
;4281:				BotAI_Print(PRT_ERROR, "BotGetActivateGoal: no entity with target \"%s\"\n", targetname[i]);
CNSTI4 3
ARGI4
ADDRGP4 $2538
ARGP4
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136
ADDP4
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4282
;4282:			}
LABELV $2535
line 4283
;4283:			i--;
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 4284
;4284:			continue;
ADDRGP4 $2521
JUMPV
LABELV $2533
line 4286
;4285:		}
;4286:		if (!trap_AAS_ValueForBSPEpairKey(ent, "classname", classname, sizeof(classname))) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2463
ARGP4
ADDRLP4 1456
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3268
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3268
INDIRI4
CNSTI4 0
NEI4 $2539
line 4287
;4287:			if (bot_developer.integer) {
ADDRGP4 bot_developer+12
INDIRI4
CNSTI4 0
EQI4 $2521
line 4288
;4288:				BotAI_Print(PRT_ERROR, "BotGetActivateGoal: entity with target \"%s\" has no classname\n", targetname[i]);
CNSTI4 3
ARGI4
ADDRGP4 $2544
ARGP4
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136
ADDP4
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4289
;4289:			}
line 4290
;4290:			continue;
ADDRGP4 $2521
JUMPV
LABELV $2539
line 4293
;4291:		}
;4292:		// BSP button model
;4293:		if (!strcmp(classname, "func_button")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2512
ARGP4
ADDRLP4 3272
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3272
INDIRI4
CNSTI4 0
NEI4 $2545
line 4295
;4294:			//
;4295:			if (!BotFuncButtonActivateGoal(bs, ent, activategoal))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 3276
ADDRGP4 BotFuncButtonActivateGoal
CALLI4
ASGNI4
ADDRLP4 3276
INDIRI4
CNSTI4 0
NEI4 $2547
line 4296
;4296:				continue;
ADDRGP4 $2521
JUMPV
LABELV $2547
line 4298
;4297:			// if the bot tries to activate this button already
;4298:			if ( bs->activatestack && bs->activatestack->inuse &&
ADDRLP4 3280
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 3280
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2549
ADDRLP4 3280
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $2549
ADDRLP4 3280
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
NEI4 $2549
ADDRLP4 3284
ADDRGP4 floattime
INDIRF4
ASGNF4
ADDRLP4 3280
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRLP4 3284
INDIRF4
LEF4 $2549
ADDRLP4 3280
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDRLP4 3284
INDIRF4
CNSTF4 1073741824
SUBF4
GEF4 $2549
line 4302
;4299:				 bs->activatestack->goal.entitynum == activategoal->goal.entitynum &&
;4300:				 bs->activatestack->time > FloatTime() &&
;4301:				 bs->activatestack->start_time < FloatTime() - 2)
;4302:				continue;
ADDRGP4 $2521
JUMPV
LABELV $2549
line 4304
;4303:			// if the bot is in a reachability area
;4304:			if ( trap_AAS_AreaReachability(bs->areanum) ) {
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 3288
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3288
INDIRI4
CNSTI4 0
EQI4 $2551
line 4306
;4305:				// disable all areas the blocking entity is in
;4306:				BotEnableActivateGoalAreas( activategoal, qfalse );
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4308
;4307:				//
;4308:				t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, activategoal->goal.areanum, bs->tfl);
ADDRLP4 3292
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 3292
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 3292
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 3292
INDIRP4
CNSTI4 5976
ADDP4
INDIRI4
ARGI4
ADDRLP4 3296
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 2736
ADDRLP4 3296
INDIRI4
ASGNI4
line 4310
;4309:				// if the button is not reachable
;4310:				if (!t) {
ADDRLP4 2736
INDIRI4
CNSTI4 0
NEI4 $2553
line 4311
;4311:					continue;
ADDRGP4 $2521
JUMPV
LABELV $2553
line 4313
;4312:				}
;4313:				activategoal->time = FloatTime() + t * 0.01 + 5;
ADDRFP4 8
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 2736
INDIRI4
CVIF4 4
CNSTF4 1008981770
MULF4
ADDF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 4314
;4314:			}
LABELV $2551
line 4315
;4315:			return ent;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $2449
JUMPV
LABELV $2545
line 4318
;4316:		}
;4317:		// invisible trigger multiple box
;4318:		else if (!strcmp(classname, "trigger_multiple")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2557
ARGP4
ADDRLP4 3276
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3276
INDIRI4
CNSTI4 0
NEI4 $2555
line 4320
;4319:			//
;4320:			if (!BotTriggerMultipleActivateGoal(bs, ent, activategoal))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 3280
ADDRGP4 BotTriggerMultipleActivateGoal
CALLI4
ASGNI4
ADDRLP4 3280
INDIRI4
CNSTI4 0
NEI4 $2558
line 4321
;4321:				continue;
ADDRGP4 $2521
JUMPV
LABELV $2558
line 4323
;4322:			// if the bot tries to activate this trigger already
;4323:			if ( bs->activatestack && bs->activatestack->inuse &&
ADDRLP4 3284
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 3284
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2560
ADDRLP4 3284
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $2560
ADDRLP4 3284
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
NEI4 $2560
ADDRLP4 3288
ADDRGP4 floattime
INDIRF4
ASGNF4
ADDRLP4 3284
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRLP4 3288
INDIRF4
LEF4 $2560
ADDRLP4 3284
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDRLP4 3288
INDIRF4
CNSTF4 1073741824
SUBF4
GEF4 $2560
line 4327
;4324:				 bs->activatestack->goal.entitynum == activategoal->goal.entitynum &&
;4325:				 bs->activatestack->time > FloatTime() &&
;4326:				 bs->activatestack->start_time < FloatTime() - 2)
;4327:				continue;
ADDRGP4 $2521
JUMPV
LABELV $2560
line 4329
;4328:			// if the bot is in a reachability area
;4329:			if ( trap_AAS_AreaReachability(bs->areanum) ) {
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 3292
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3292
INDIRI4
CNSTI4 0
EQI4 $2562
line 4331
;4330:				// disable all areas the blocking entity is in
;4331:				BotEnableActivateGoalAreas( activategoal, qfalse );
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4333
;4332:				//
;4333:				t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, activategoal->goal.areanum, bs->tfl);
ADDRLP4 3296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 3296
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 3296
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 3296
INDIRP4
CNSTI4 5976
ADDP4
INDIRI4
ARGI4
ADDRLP4 3300
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 2736
ADDRLP4 3300
INDIRI4
ASGNI4
line 4335
;4334:				// if the trigger is not reachable
;4335:				if (!t) {
ADDRLP4 2736
INDIRI4
CNSTI4 0
NEI4 $2564
line 4336
;4336:					continue;
ADDRGP4 $2521
JUMPV
LABELV $2564
line 4338
;4337:				}
;4338:				activategoal->time = FloatTime() + t * 0.01 + 5;
ADDRFP4 8
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 2736
INDIRI4
CVIF4 4
CNSTF4 1008981770
MULF4
ADDF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 4339
;4339:			}
LABELV $2562
line 4340
;4340:			return ent;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $2449
JUMPV
LABELV $2555
line 4342
;4341:		}
;4342:		else if (!strcmp(classname, "func_timer")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2568
ARGP4
ADDRLP4 3280
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3280
INDIRI4
CNSTI4 0
NEI4 $2566
line 4344
;4343:			// just skip the func_timer
;4344:			continue;
ADDRGP4 $2521
JUMPV
LABELV $2566
line 4347
;4345:		}
;4346:		// the actual button or trigger might be linked through a target_relay or target_delay
;4347:		else if (!strcmp(classname, "target_relay") || !strcmp(classname, "target_delay")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2571
ARGP4
ADDRLP4 3284
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3284
INDIRI4
CNSTI4 0
EQI4 $2573
ADDRLP4 1456
ARGP4
ADDRGP4 $2572
ARGP4
ADDRLP4 3288
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3288
INDIRI4
CNSTI4 0
NEI4 $2569
LABELV $2573
line 4348
;4348:			if (trap_AAS_ValueForBSPEpairKey(ent, "targetname", targetname[i+1], sizeof(targetname[0]))) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2515
ARGP4
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136+128
ADDP4
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3292
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3292
INDIRI4
CNSTI4 0
EQI4 $2574
line 4349
;4349:				i++;
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4350
;4350:				cur_entities[i] = trap_AAS_NextBSPEntity(0);
CNSTI4 0
ARGI4
ADDRLP4 3296
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1416
ADDP4
ADDRLP4 3296
INDIRI4
ASGNI4
line 4351
;4351:			}
LABELV $2574
line 4352
;4352:		}
LABELV $2569
line 4353
;4353:	}
LABELV $2521
line 4271
LABELV $2523
ADDRLP4 132
INDIRI4
CNSTI4 0
LTI4 $2577
ADDRLP4 132
INDIRI4
CNSTI4 10
LTI4 $2520
LABELV $2577
line 4357
;4354:#ifdef OBSTACLEDEBUG
;4355:	BotAI_Print(PRT_ERROR, "BotGetActivateGoal: no valid activator for entity with target \"%s\"\n", targetname[0]);
;4356:#endif
;4357:	return 0;
CNSTI4 0
RETI4
LABELV $2449
endproc BotGetActivateGoal 3304 20
export BotGoForActivateGoal
proc BotGoForActivateGoal 144 8
line 4365
;4358:}
;4359:
;4360:/*
;4361:==================
;4362:BotGoForActivateGoal
;4363:==================
;4364:*/
;4365:int BotGoForActivateGoal(bot_state_t *bs, bot_activategoal_t *activategoal) {
line 4368
;4366:	aas_entityinfo_t activateinfo;
;4367:
;4368:	activategoal->inuse = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 1
ASGNI4
line 4369
;4369:	if (!activategoal->time)
ADDRFP4 4
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
CNSTF4 0
NEF4 $2579
line 4370
;4370:		activategoal->time = FloatTime() + 10;
ADDRFP4 4
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
LABELV $2579
line 4371
;4371:	activategoal->start_time = FloatTime();
ADDRFP4 4
INDIRP4
CNSTI4 64
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4372
;4372:	BotEntityInfo(activategoal->goal.entitynum, &activateinfo);
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4373
;4373:	VectorCopy(activateinfo.origin, activategoal->origin);
ADDRFP4 4
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 4375
;4374:	//
;4375:	if (BotPushOntoActivateGoalStack(bs, activategoal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotPushOntoActivateGoalStack
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $2582
line 4377
;4376:		// enter the activate entity AI node
;4377:		AIEnter_Seek_ActivateEntity(bs, "BotGoForActivateGoal");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2584
ARGP4
ADDRGP4 AIEnter_Seek_ActivateEntity
CALLV
pop
line 4378
;4378:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2578
JUMPV
LABELV $2582
line 4380
;4379:	}
;4380:	else {
line 4382
;4381:		// enable any routing areas that were disabled
;4382:		BotEnableActivateGoalAreas(activategoal, qtrue);
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4383
;4383:		return qfalse;
CNSTI4 0
RETI4
LABELV $2578
endproc BotGoForActivateGoal 144 8
export BotPrintActivateGoalInfo
proc BotPrintActivateGoalInfo 296 36
line 4392
;4384:	}
;4385:}
;4386:
;4387:/*
;4388:==================
;4389:BotPrintActivateGoalInfo
;4390:==================
;4391:*/
;4392:void BotPrintActivateGoalInfo(bot_state_t *bs, bot_activategoal_t *activategoal, int bspent) {
line 4397
;4393:	char netname[MAX_NETNAME];
;4394:	char classname[128];
;4395:	char buf[128];
;4396:
;4397:	ClientName(bs->client, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 4398
;4398:	trap_AAS_ValueForBSPEpairKey(bspent, "classname", classname, sizeof(classname));
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $2463
ARGP4
ADDRLP4 36
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4399
;4399:	if (activategoal->shoot) {
ADDRFP4 4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2586
line 4400
;4400:		Com_sprintf(buf, sizeof(buf), "%s: I have to shoot at a %s from %1.1f %1.1f %1.1f in area %d\n",
ADDRLP4 164
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $2588
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 292
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4406
;4401:						netname, classname,
;4402:						activategoal->goal.origin[0],
;4403:						activategoal->goal.origin[1],
;4404:						activategoal->goal.origin[2],
;4405:						activategoal->goal.areanum);
;4406:	}
ADDRGP4 $2587
JUMPV
LABELV $2586
line 4407
;4407:	else {
line 4408
;4408:		Com_sprintf(buf, sizeof(buf), "%s: I have to activate a %s at %1.1f %1.1f %1.1f in area %d\n",
ADDRLP4 164
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $2589
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 292
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4414
;4409:						netname, classname,
;4410:						activategoal->goal.origin[0],
;4411:						activategoal->goal.origin[1],
;4412:						activategoal->goal.origin[2],
;4413:						activategoal->goal.areanum);
;4414:	}
LABELV $2587
line 4415
;4415:	trap_EA_Say(bs->client, buf);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 164
ARGP4
ADDRGP4 trap_EA_Say
CALLV
pop
line 4416
;4416:}
LABELV $2585
endproc BotPrintActivateGoalInfo 296 36
export BotRandomMove
proc BotRandomMove 28 16
line 4423
;4417:
;4418:/*
;4419:==================
;4420:BotRandomMove
;4421:==================
;4422:*/
;4423:void BotRandomMove(bot_state_t *bs, bot_moveresult_t *moveresult) {
line 4426
;4424:	vec3_t dir, angles;
;4425:
;4426:	angles[0] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 4427
;4427:	angles[1] = random() * 360;
ADDRLP4 24
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
ADDRLP4 24
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1010041192
MULF4
ASGNF4
line 4428
;4428:	angles[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 4429
;4429:	AngleVectors(angles, dir, NULL, NULL);
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 4431
;4430:
;4431:	trap_BotMoveInDirection(bs->ms, dir, 400, MOVE_WALK);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTF4 1137180672
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotMoveInDirection
CALLI4
pop
line 4433
;4432:
;4433:	moveresult->failure = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 0
ASGNI4
line 4434
;4434:	VectorCopy(dir, moveresult->movedir);
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 12
INDIRB
ASGNB 12
line 4435
;4435:}
LABELV $2590
endproc BotRandomMove 28 16
data
align 4
LABELV $2594
byte 4 0
byte 4 0
byte 4 1065353216
export BotAIBlocked
code
proc BotAIBlocked 468 16
line 4448
;4436:
;4437:/*
;4438:==================
;4439:BotAIBlocked
;4440:
;4441:Very basic handling of bots being blocked by other entities.
;4442:Check what kind of entity is blocking the bot and try to activate
;4443:it. If that's not an option then try to walk around or over the entity.
;4444:Before the bot ends in this part of the AI it should predict which doors to
;4445:open, which buttons to activate etc.
;4446:==================
;4447:*/
;4448:void BotAIBlocked(bot_state_t *bs, bot_moveresult_t *moveresult, int activate) {
line 4450
;4449:	int movetype, bspent;
;4450:	vec3_t hordir, start, /*end, mins, maxs,*/ sideward, angles, up = {0, 0, 1};
ADDRLP4 192
ADDRGP4 $2594
INDIRB
ASGNB 12
line 4455
;4451:	aas_entityinfo_t entinfo;
;4452:	bot_activategoal_t activategoal;
;4453:
;4454:	// if the bot is not blocked by anything
;4455:	if (!moveresult->blocked) {
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2595
line 4456
;4456:		bs->notblocked_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6204
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4457
;4457:		return;
ADDRGP4 $2593
JUMPV
LABELV $2595
line 4460
;4458:	}
;4459:	// if stuck in a solid area
;4460:	if ( moveresult->type == RESULTTYPE_INSOLIDAREA ) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 8
NEI4 $2597
line 4462
;4461:		// move in a random direction in the hope to get out
;4462:		BotRandomMove(bs, moveresult);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRandomMove
CALLV
pop
line 4464
;4463:		//
;4464:		return;
ADDRGP4 $2593
JUMPV
LABELV $2597
line 4467
;4465:	}
;4466:	// get info for the entity that is blocking the bot
;4467:	BotEntityInfo(moveresult->blockentity, &entinfo);
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4473
;4468:#ifdef OBSTACLEDEBUG
;4469:	ClientName(bs->client, netname, sizeof(netname));
;4470:	BotAI_Print(PRT_MESSAGE, "%s: I'm blocked by model %d\n", netname, entinfo.modelindex);
;4471:#endif
;4472:	// if blocked by a bsp model and the bot wants to activate it
;4473:	if (activate && entinfo.modelindex > 0 && entinfo.modelindex <= max_bspmodelindex) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $2599
ADDRLP4 24+104
INDIRI4
CNSTI4 0
LEI4 $2599
ADDRLP4 24+104
INDIRI4
ADDRGP4 max_bspmodelindex
INDIRI4
GTI4 $2599
line 4475
;4474:		// find the bsp entity which should be activated in order to get the blocking entity out of the way
;4475:		bspent = BotGetActivateGoal(bs, entinfo.number, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24+20
INDIRI4
ARGI4
ADDRLP4 204
ARGP4
ADDRLP4 452
ADDRGP4 BotGetActivateGoal
CALLI4
ASGNI4
ADDRLP4 448
ADDRLP4 452
INDIRI4
ASGNI4
line 4476
;4476:		if (bspent) {
ADDRLP4 448
INDIRI4
CNSTI4 0
EQI4 $2604
line 4478
;4477:			//
;4478:			if (bs->activatestack && !bs->activatestack->inuse)
ADDRLP4 456
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 456
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2606
ADDRLP4 456
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $2606
line 4479
;4479:				bs->activatestack = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
CNSTP4 0
ASGNP4
LABELV $2606
line 4481
;4480:			// if not already trying to activate this entity
;4481:			if (!BotIsGoingToActivateEntity(bs, activategoal.goal.entitynum)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 204+4+40
INDIRI4
ARGI4
ADDRLP4 460
ADDRGP4 BotIsGoingToActivateEntity
CALLI4
ASGNI4
ADDRLP4 460
INDIRI4
CNSTI4 0
NEI4 $2608
line 4483
;4482:				//
;4483:				BotGoForActivateGoal(bs, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 204
ARGP4
ADDRGP4 BotGoForActivateGoal
CALLI4
pop
line 4484
;4484:			}
LABELV $2608
line 4488
;4485:			// if ontop of an obstacle or
;4486:			// if the bot is not in a reachability area it'll still
;4487:			// need some dynamic obstacle avoidance, otherwise return
;4488:			if (!(moveresult->flags & MOVERESULT_ONTOPOFOBSTACLE) &&
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $2605
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 464
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 464
INDIRI4
CNSTI4 0
EQI4 $2605
line 4490
;4489:				trap_AAS_AreaReachability(bs->areanum))
;4490:				return;
ADDRGP4 $2593
JUMPV
line 4491
;4491:		}
LABELV $2604
line 4492
;4492:		else {
line 4494
;4493:			// enable any routing areas that were disabled
;4494:			BotEnableActivateGoalAreas(&activategoal, qtrue);
ADDRLP4 204
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4495
;4495:		}
LABELV $2605
line 4496
;4496:	}
LABELV $2599
line 4498
;4497:	// just some basic dynamic obstacle avoidance code
;4498:	hordir[0] = moveresult->movedir[0];
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ASGNF4
line 4499
;4499:	hordir[1] = moveresult->movedir[1];
ADDRLP4 0+4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ASGNF4
line 4500
;4500:	hordir[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 4502
;4501:	// if no direction just take a random direction
;4502:	if (VectorNormalize(hordir) < 0.1) {
ADDRLP4 0
ARGP4
ADDRLP4 452
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 452
INDIRF4
CNSTF4 1036831949
GEF4 $2616
line 4503
;4503:		VectorSet(angles, 0, 360 * random(), 0);
ADDRLP4 180
CNSTF4 0
ASGNF4
ADDRLP4 456
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 180+4
ADDRLP4 456
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1135869952
MULF4
ASGNF4
ADDRLP4 180+8
CNSTF4 0
ASGNF4
line 4504
;4504:		AngleVectors(angles, hordir, NULL, NULL);
ADDRLP4 180
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 4505
;4505:	}
LABELV $2616
line 4509
;4506:	//
;4507:	//if (moveresult->flags & MOVERESULT_ONTOPOFOBSTACLE) movetype = MOVE_JUMP;
;4508:	//else
;4509:	movetype = MOVE_WALK;
ADDRLP4 164
CNSTI4 1
ASGNI4
line 4512
;4510:	// if there's an obstacle at the bot's feet and head then
;4511:	// the bot might be able to crouch through
;4512:	VectorCopy(bs->origin, start);
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 4513
;4513:	start[2] += 18;
ADDRLP4 168+8
ADDRLP4 168+8
INDIRF4
CNSTF4 1099956224
ADDF4
ASGNF4
line 4521
;4514:	//VectorMA(start, 5, hordir, end);
;4515:	//VectorSet(mins, -16, -16, -24);
;4516:	//VectorSet(maxs, 16, 16, 4);
;4517:	//
;4518:	//bsptrace = AAS_Trace(start, mins, maxs, end, bs->entitynum, MASK_PLAYERSOLID);
;4519:	//if (bsptrace.fraction >= 1) movetype = MOVE_CROUCH;
;4520:	// get the sideward vector
;4521:	CrossProduct(hordir, up, sideward);
ADDRLP4 0
ARGP4
ADDRLP4 192
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 4523
;4522:	//
;4523:	if (bs->flags & BFL_AVOIDRIGHT) VectorNegate(sideward, sideward);
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $2621
ADDRLP4 12
ADDRLP4 12
INDIRF4
NEGF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
NEGF4
ASGNF4
LABELV $2621
line 4525
;4524:	// try to crouch straight forward?
;4525:	if (!trap_BotMoveInDirection(bs->ms, hordir, 400, movetype)) {
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 164
INDIRI4
ARGI4
ADDRLP4 456
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 456
INDIRI4
CNSTI4 0
NEI4 $2627
line 4527
;4526:		// perform the movement
;4527:		if (!trap_BotMoveInDirection(bs->ms, sideward, 400, movetype)) {
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 164
INDIRI4
ARGI4
ADDRLP4 460
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 460
INDIRI4
CNSTI4 0
NEI4 $2629
line 4529
;4528:			// flip the avoid direction flag
;4529:			bs->flags ^= BFL_AVOIDRIGHT;
ADDRLP4 464
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 464
INDIRP4
ADDRLP4 464
INDIRP4
INDIRI4
CNSTI4 16
BXORI4
ASGNI4
line 4532
;4530:			// flip the direction
;4531:			// VectorNegate(sideward, sideward);
;4532:			VectorMA(sideward, -1, hordir, sideward);
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRF4
CNSTF4 3212836864
MULF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 0+4
INDIRF4
CNSTF4 3212836864
MULF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 0+8
INDIRF4
CNSTF4 3212836864
MULF4
ADDF4
ASGNF4
line 4534
;4533:			// move in the other direction
;4534:			trap_BotMoveInDirection(bs->ms, sideward, 400, movetype);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 164
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveInDirection
CALLI4
pop
line 4535
;4535:		}
LABELV $2629
line 4536
;4536:	}
LABELV $2627
line 4538
;4537:	//
;4538:	if (bs->notblocked_time < FloatTime() - 0.4) {
ADDRFP4 0
INDIRP4
CNSTI4 6204
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1053609165
SUBF4
GEF4 $2637
line 4541
;4539:		// just reset goals and hope the bot will go into another direction?
;4540:		// is this still needed??
;4541:		if (bs->ainode == AINode_Seek_NBG) bs->nbg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 AINode_Seek_NBG
CVPU4 4
NEU4 $2639
ADDRFP4 0
INDIRP4
CNSTI4 6072
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $2640
JUMPV
LABELV $2639
line 4542
;4542:		else if (bs->ainode == AINode_Seek_LTG) bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 AINode_Seek_LTG
CVPU4 4
NEU4 $2641
ADDRFP4 0
INDIRP4
CNSTI4 6068
ADDP4
CNSTF4 0
ASGNF4
LABELV $2641
LABELV $2640
line 4543
;4543:	}
LABELV $2637
line 4544
;4544:}
LABELV $2593
endproc BotAIBlocked 468 16
export BotAIPredictObstacles
proc BotAIPredictObstacles 316 44
line 4556
;4545:
;4546:/*
;4547:==================
;4548:BotAIPredictObstacles
;4549:
;4550:Predict the route towards the goal and check if the bot
;4551:will be blocked by certain obstacles. When the bot has obstacles
;4552:on it's path the bot should figure out if they can be removed
;4553:by activating certain entities.
;4554:==================
;4555:*/
;4556:int BotAIPredictObstacles(bot_state_t *bs, bot_goal_t *goal) {
line 4561
;4557:	int modelnum, entitynum, bspent;
;4558:	bot_activategoal_t activategoal;
;4559:	aas_predictroute_t route;
;4560:
;4561:	if (!bot_predictobstacles.integer)
ADDRGP4 bot_predictobstacles+12
INDIRI4
CNSTI4 0
NEI4 $2644
line 4562
;4562:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2643
JUMPV
LABELV $2644
line 4565
;4563:
;4564:	// always predict when the goal change or at regular intervals
;4565:	if (bs->predictobstacles_goalareanum == goal->areanum &&
ADDRLP4 292
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 6216
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $2647
ADDRLP4 292
INDIRP4
CNSTI4 6212
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1086324736
SUBF4
LEF4 $2647
line 4566
;4566:		bs->predictobstacles_time > FloatTime() - 6) {
line 4567
;4567:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2643
JUMPV
LABELV $2647
line 4569
;4568:	}
;4569:	bs->predictobstacles_goalareanum = goal->areanum;
ADDRFP4 0
INDIRP4
CNSTI4 6216
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 4570
;4570:	bs->predictobstacles_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6212
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4573
;4571:
;4572:	// predict at most 100 areas or 10 seconds ahead
;4573:	trap_AAS_PredictRoute(&route, bs->areanum, bs->origin,
ADDRLP4 0
ARGP4
ADDRLP4 296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 296
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 296
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 296
INDIRP4
CNSTI4 5976
ADDP4
INDIRI4
ARGI4
CNSTI4 100
ARGI4
CNSTI4 1000
ARGI4
CNSTI4 6
ARGI4
CNSTI4 1024
ARGI4
CNSTI4 67108864
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_AAS_PredictRoute
CALLI4
pop
line 4578
;4574:							goal->areanum, bs->tfl, 100, 1000,
;4575:							RSE_USETRAVELTYPE|RSE_ENTERCONTENTS,
;4576:							AREACONTENTS_MOVER, TFL_BRIDGE, 0);
;4577:	// if bot has to travel through an area with a mover
;4578:	if (route.stopevent & RSE_ENTERCONTENTS) {
ADDRLP4 0+16
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $2649
line 4580
;4579:		// if the bot will run into a mover
;4580:		if (route.endcontents & AREACONTENTS_MOVER) {
ADDRLP4 0+20
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $2650
line 4582
;4581:			//NOTE: this only works with bspc 2.1 or higher
;4582:			modelnum = (route.endcontents & AREACONTENTS_MODELNUM) >> AREACONTENTS_MODELNUMSHIFT;
ADDRLP4 36
ADDRLP4 0+20
INDIRI4
CNSTI4 255
CNSTI4 24
LSHI4
BANDI4
CNSTI4 24
RSHI4
ASGNI4
line 4583
;4583:			if (modelnum) {
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $2650
line 4585
;4584:				//
;4585:				entitynum = BotModelMinsMaxs(modelnum, ET_MOVER, 0, NULL, NULL);
ADDRLP4 36
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 300
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 300
INDIRI4
ASGNI4
line 4586
;4586:				if (entitynum) {
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $2650
line 4588
;4587:					//NOTE: BotGetActivateGoal already checks if the door is open or not
;4588:					bspent = BotGetActivateGoal(bs, entitynum, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 48
ARGP4
ADDRLP4 304
ADDRGP4 BotGetActivateGoal
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 304
INDIRI4
ASGNI4
line 4589
;4589:					if (bspent) {
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $2650
line 4591
;4590:						//
;4591:						if (bs->activatestack && !bs->activatestack->inuse)
ADDRLP4 308
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 308
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2662
ADDRLP4 308
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $2662
line 4592
;4592:							bs->activatestack = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
CNSTP4 0
ASGNP4
LABELV $2662
line 4594
;4593:						// if not already trying to activate this entity
;4594:						if (!BotIsGoingToActivateEntity(bs, activategoal.goal.entitynum)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48+4+40
INDIRI4
ARGI4
ADDRLP4 312
ADDRGP4 BotIsGoingToActivateEntity
CALLI4
ASGNI4
ADDRLP4 312
INDIRI4
CNSTI4 0
NEI4 $2664
line 4598
;4595:							//
;4596:							//BotAI_Print(PRT_MESSAGE, "blocked by mover model %d, entity %d ?\n", modelnum, entitynum);
;4597:							//
;4598:							BotGoForActivateGoal(bs, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ARGP4
ADDRGP4 BotGoForActivateGoal
CALLI4
pop
line 4599
;4599:							return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2643
JUMPV
LABELV $2664
line 4601
;4600:						}
;4601:						else {
line 4603
;4602:							// enable any routing areas that were disabled
;4603:							BotEnableActivateGoalAreas(&activategoal, qtrue);
ADDRLP4 48
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4604
;4604:						}
line 4605
;4605:					}
line 4606
;4606:				}
line 4607
;4607:			}
line 4608
;4608:		}
line 4609
;4609:	}
ADDRGP4 $2650
JUMPV
LABELV $2649
line 4610
;4610:	else if (route.stopevent & RSE_USETRAVELTYPE) {
ADDRLP4 0+16
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $2668
line 4611
;4611:		if (route.endtravelflags & TFL_BRIDGE) {
ADDRLP4 0+24
INDIRI4
CNSTI4 67108864
BANDI4
CNSTI4 0
EQI4 $2671
line 4613
;4612:			//FIXME: check if the bridge is available to travel over
;4613:		}
LABELV $2671
line 4614
;4614:	}
LABELV $2668
LABELV $2650
line 4615
;4615:	return qfalse;
CNSTI4 0
RETI4
LABELV $2643
endproc BotAIPredictObstacles 316 44
export BotCheckConsoleMessages
proc BotCheckConsoleMessages 1008 48
line 4623
;4616:}
;4617:
;4618:/*
;4619:==================
;4620:BotCheckConsoleMessages
;4621:==================
;4622:*/
;4623:void BotCheckConsoleMessages(bot_state_t *bs) {
line 4631
;4624:	char botname[MAX_NETNAME], message[MAX_MESSAGE_SIZE], netname[MAX_NETNAME], *ptr;
;4625:	float chat_reply;
;4626:	int context, handle;
;4627:	bot_consolemessage_t m;
;4628:	bot_match_t match;
;4629:
;4630:	//the name of this bot
;4631:	ClientName(bs->client, botname, sizeof(botname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 908
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
ADDRGP4 $2676
JUMPV
LABELV $2675
line 4633
;4632:	//
;4633:	while((handle = trap_BotNextConsoleMessage(bs->cs, &m)) != 0) {
line 4635
;4634:		//if the chat state is flooded with messages the bot will read them quickly
;4635:		if (trap_BotNumConsoleMessages(bs->cs) < 10) {
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 948
ADDRGP4 trap_BotNumConsoleMessages
CALLI4
ASGNI4
ADDRLP4 948
INDIRI4
CNSTI4 10
GEI4 $2678
line 4637
;4636:			//if it is a chat message the bot needs some time to read it
;4637:			if (m.type == CMS_CHAT && m.time > FloatTime() - (1 + random())) break;
ADDRLP4 0+8
INDIRI4
CNSTI4 1
NEI4 $2680
ADDRLP4 952
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 952
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1065353216
ADDF4
SUBF4
LEF4 $2680
ADDRGP4 $2677
JUMPV
LABELV $2680
line 4638
;4638:		}
LABELV $2678
line 4640
;4639:		//
;4640:		ptr = m.message;
ADDRLP4 276
ADDRLP4 0+12
ASGNP4
line 4643
;4641:		//if it is a chat message then don't unify white spaces and don't
;4642:		//replace synonyms in the netname
;4643:		if (m.type == CMS_CHAT) {
ADDRLP4 0+8
INDIRI4
CNSTI4 1
NEI4 $2685
line 4645
;4644:			//
;4645:			if (trap_BotFindMatch(m.message, &match, MTCONTEXT_REPLYCHAT)) {
ADDRLP4 0+12
ARGP4
ADDRLP4 288
ARGP4
CNSTU4 128
ARGU4
ADDRLP4 952
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 952
INDIRI4
CNSTI4 0
EQI4 $2688
line 4646
;4646:				ptr = m.message + match.variables[MESSAGE].offset;
ADDRLP4 276
ADDRLP4 288+264+16
INDIRI1
CVII4 1
ADDRLP4 0+12
ADDP4
ASGNP4
line 4647
;4647:			}
LABELV $2688
line 4648
;4648:		}
LABELV $2685
line 4650
;4649:		//unify the white spaces in the message
;4650:		trap_UnifyWhiteSpaces(ptr);
ADDRLP4 276
INDIRP4
ARGP4
ADDRGP4 trap_UnifyWhiteSpaces
CALLV
pop
line 4652
;4651:		//replace synonyms in the right context
;4652:		context = BotSynonymContext(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 952
ADDRGP4 BotSynonymContext
CALLI4
ASGNI4
ADDRLP4 284
ADDRLP4 952
INDIRI4
ASGNI4
line 4653
;4653:		trap_BotReplaceSynonyms(ptr, context);
ADDRLP4 276
INDIRP4
ARGP4
ADDRLP4 284
INDIRI4
CVIU4 4
ARGU4
ADDRGP4 trap_BotReplaceSynonyms
CALLV
pop
line 4655
;4654:		//if there's no match
;4655:		if (!BotMatchMessage(bs, m.message)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+12
ARGP4
ADDRLP4 956
ADDRGP4 BotMatchMessage
CALLI4
ASGNI4
ADDRLP4 956
INDIRI4
CNSTI4 0
NEI4 $2694
line 4657
;4656:			//if it is a chat message
;4657:			if (m.type == CMS_CHAT && !bot_nochat.integer) {
ADDRLP4 0+8
INDIRI4
CNSTI4 1
NEI4 $2697
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
NEI4 $2697
line 4659
;4658:				//
;4659:				if (!trap_BotFindMatch(m.message, &match, MTCONTEXT_REPLYCHAT)) {
ADDRLP4 0+12
ARGP4
ADDRLP4 288
ARGP4
CNSTU4 128
ARGU4
ADDRLP4 960
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 960
INDIRI4
CNSTI4 0
NEI4 $2701
line 4660
;4660:					trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4661
;4661:					continue;
ADDRGP4 $2676
JUMPV
LABELV $2701
line 4664
;4662:				}
;4663:				//don't use eliza chats with team messages
;4664:				if (match.subtype & ST_TEAM) {
ADDRLP4 288+260
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $2704
line 4665
;4665:					trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4666
;4666:					continue;
ADDRGP4 $2676
JUMPV
LABELV $2704
line 4669
;4667:				}
;4668:				//
;4669:				trap_BotMatchVariable(&match, NETNAME, netname, sizeof(netname));
ADDRLP4 288
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 872
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 4670
;4670:				trap_BotMatchVariable(&match, MESSAGE, message, sizeof(message));
ADDRLP4 288
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 616
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 4672
;4671:				//if this is a message from the bot self
;4672:				if (bs->client == ClientFromName(netname)) {
ADDRLP4 872
ARGP4
ADDRLP4 964
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 964
INDIRI4
NEI4 $2707
line 4673
;4673:					trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4674
;4674:					continue;
ADDRGP4 $2676
JUMPV
LABELV $2707
line 4677
;4675:				}
;4676:				//unify the message
;4677:				trap_UnifyWhiteSpaces(message);
ADDRLP4 616
ARGP4
ADDRGP4 trap_UnifyWhiteSpaces
CALLV
pop
line 4679
;4678:				//
;4679:				trap_Cvar_Update(&bot_testrchat);
ADDRGP4 bot_testrchat
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 4680
;4680:				if (bot_testrchat.integer) {
ADDRGP4 bot_testrchat+12
INDIRI4
CNSTI4 0
EQI4 $2709
line 4682
;4681:					//
;4682:					trap_BotLibVarSet("bot_testrchat", "1");
ADDRGP4 $2712
ARGP4
ADDRGP4 $2713
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 4684
;4683:					//if bot replies with a chat message
;4684:					if (trap_BotReplyChat(bs->cs, message, context, CONTEXT_REPLY,
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 616
ARGP4
ADDRLP4 284
INDIRI4
ARGI4
CNSTI4 16
ARGI4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 908
ARGP4
ADDRLP4 872
ARGP4
ADDRLP4 968
ADDRGP4 trap_BotReplyChat
CALLI4
ASGNI4
ADDRLP4 968
INDIRI4
CNSTI4 0
EQI4 $2714
line 4688
;4685:															NULL, NULL,
;4686:															NULL, NULL,
;4687:															NULL, NULL,
;4688:															botname, netname)) {
line 4689
;4689:						BotAI_Print(PRT_MESSAGE, "------------------------\n");
CNSTI4 1
ARGI4
ADDRGP4 $2716
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4690
;4690:					}
ADDRGP4 $2710
JUMPV
LABELV $2714
line 4691
;4691:					else {
line 4692
;4692:						BotAI_Print(PRT_MESSAGE, "**** no valid reply ****\n");
CNSTI4 1
ARGI4
ADDRGP4 $2717
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4693
;4693:					}
line 4694
;4694:				}
ADDRGP4 $2710
JUMPV
LABELV $2709
line 4696
;4695:				//if at a valid chat position and not chatting already and not in teamplay
;4696:				else if (bs->ainode != AINode_Stand && BotValidChatPosition(bs) && !TeamPlayIsOn()) {
ADDRLP4 968
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 968
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 AINode_Stand
CVPU4 4
EQU4 $2718
ADDRLP4 968
INDIRP4
ARGP4
ADDRLP4 972
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 972
INDIRI4
CNSTI4 0
EQI4 $2718
ADDRLP4 976
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 976
INDIRI4
CNSTI4 0
NEI4 $2718
line 4697
;4697:					chat_reply = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_REPLY, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 35
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 980
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 944
ADDRLP4 980
INDIRF4
ASGNF4
line 4698
;4698:					if (random() < 1.5 / (NumBots()+1) && random() < chat_reply) {
ADDRLP4 984
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 988
ADDRGP4 NumBots
CALLI4
ASGNI4
ADDRLP4 984
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1069547520
ADDRLP4 988
INDIRI4
CNSTI4 1
ADDI4
CVIF4 4
DIVF4
GEF4 $2720
ADDRLP4 992
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 992
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ADDRLP4 944
INDIRF4
GEF4 $2720
line 4700
;4699:						//if bot replies with a chat message
;4700:						if (trap_BotReplyChat(bs->cs, message, context, CONTEXT_REPLY,
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 616
ARGP4
ADDRLP4 284
INDIRI4
ARGI4
CNSTI4 16
ARGI4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 908
ARGP4
ADDRLP4 872
ARGP4
ADDRLP4 996
ADDRGP4 trap_BotReplyChat
CALLI4
ASGNI4
ADDRLP4 996
INDIRI4
CNSTI4 0
EQI4 $2722
line 4704
;4701:																NULL, NULL,
;4702:																NULL, NULL,
;4703:																NULL, NULL,
;4704:																botname, netname)) {
line 4706
;4705:							//remove the console message
;4706:							trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4707
;4707:							bs->stand_time = FloatTime() + BotChatTime(bs);
ADDRLP4 1000
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1000
INDIRP4
ARGP4
ADDRLP4 1004
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 1000
INDIRP4
CNSTI4 6096
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 1004
INDIRF4
ADDF4
ASGNF4
line 4708
;4708:							AIEnter_Stand(bs, "BotCheckConsoleMessages: reply chat");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2724
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 4710
;4709:							//EA_Say(bs->client, bs->cs.chatmessage);
;4710:							break;
ADDRGP4 $2677
JUMPV
LABELV $2722
line 4712
;4711:						}
;4712:					}
LABELV $2720
line 4713
;4713:				}
LABELV $2718
LABELV $2710
line 4714
;4714:			}
LABELV $2697
line 4715
;4715:		}
LABELV $2694
line 4717
;4716:		//remove the console message
;4717:		trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4718
;4718:	}
LABELV $2676
line 4633
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 948
ADDRGP4 trap_BotNextConsoleMessage
CALLI4
ASGNI4
ADDRLP4 280
ADDRLP4 948
INDIRI4
ASGNI4
ADDRLP4 948
INDIRI4
CNSTI4 0
NEI4 $2675
LABELV $2677
line 4719
;4719:}
LABELV $2674
endproc BotCheckConsoleMessages 1008 48
export BotCheckForGrenades
proc BotCheckForGrenades 4 16
line 4726
;4720:
;4721:/*
;4722:==================
;4723:BotCheckEvents
;4724:==================
;4725:*/
;4726:void BotCheckForGrenades(bot_state_t *bs, entityState_t *state) {
line 4728
;4727:	// if this is not a grenade
;4728:	if (state->eType != ET_MISSILE || state->weapon != WP_GRENADE_LAUNCHER)
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $2728
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 4
EQI4 $2726
LABELV $2728
line 4729
;4729:		return;
ADDRGP4 $2725
JUMPV
LABELV $2726
line 4731
;4730:	// try to avoid the grenade
;4731:	trap_BotAddAvoidSpot(bs->ms, state->pos.trBase, 160, AVOID_ALWAYS);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTF4 1126170624
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotAddAvoidSpot
CALLV
pop
line 4732
;4732:}
LABELV $2725
endproc BotCheckForGrenades 4 16
export BotCheckForProxMines
proc BotCheckForProxMines 28 16
line 4740
;4733:
;4734:#ifdef MISSIONPACK
;4735:/*
;4736:==================
;4737:BotCheckForProxMines
;4738:==================
;4739:*/
;4740:void BotCheckForProxMines(bot_state_t *bs, entityState_t *state) {
line 4742
;4741:	// if this is not a prox mine
;4742:	if (state->eType != ET_MISSILE || state->weapon != WP_PROX_LAUNCHER)
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $2732
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 12
EQI4 $2730
LABELV $2732
line 4743
;4743:		return;
ADDRGP4 $2729
JUMPV
LABELV $2730
line 4745
;4744:	// if this prox mine is from someone on our own team
;4745:	if (state->generic1 == BotTeam(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRFP4 4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $2733
line 4746
;4746:		return;
ADDRGP4 $2729
JUMPV
LABELV $2733
line 4748
;4747:	// if the bot doesn't have a weapon to deactivate the mine
;4748:	if (!(bs->inventory[INVENTORY_PLASMAGUN] > 0 && bs->inventory[INVENTORY_CELLS] > 0) &&
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 4996
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2737
ADDRLP4 8
INDIRP4
CNSTI4 5036
ADDP4
INDIRI4
CNSTI4 0
GTI4 $2735
LABELV $2737
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2738
ADDRLP4 12
INDIRP4
CNSTI4 5044
ADDP4
INDIRI4
CNSTI4 0
GTI4 $2735
LABELV $2738
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 5004
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2739
ADDRLP4 16
INDIRP4
CNSTI4 5052
ADDP4
INDIRI4
CNSTI4 0
GTI4 $2735
LABELV $2739
line 4750
;4749:		!(bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 && bs->inventory[INVENTORY_ROCKETS] > 0) &&
;4750:		!(bs->inventory[INVENTORY_BFG10K] > 0 && bs->inventory[INVENTORY_BFGAMMO] > 0) ) {
line 4751
;4751:		return;
ADDRGP4 $2729
JUMPV
LABELV $2735
line 4754
;4752:	}
;4753:	// try to avoid the prox mine
;4754:	trap_BotAddAvoidSpot(bs->ms, state->pos.trBase, 160, AVOID_ALWAYS);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTF4 1126170624
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotAddAvoidSpot
CALLV
pop
line 4756
;4755:	//
;4756:	if (bs->numproxmines >= MAX_PROXMINES)
ADDRFP4 0
INDIRP4
CNSTI4 6516
ADDP4
INDIRI4
CNSTI4 64
LTI4 $2740
line 4757
;4757:		return;
ADDRGP4 $2729
JUMPV
LABELV $2740
line 4758
;4758:	bs->proxmines[bs->numproxmines] = state->number;
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 6516
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
CNSTI4 6260
ADDP4
ADDP4
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
line 4759
;4759:	bs->numproxmines++;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 6516
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4760
;4760:}
LABELV $2729
endproc BotCheckForProxMines 28 16
export BotCheckForKamikazeBody
proc BotCheckForKamikazeBody 0 0
line 4767
;4761:
;4762:/*
;4763:==================
;4764:BotCheckForKamikazeBody
;4765:==================
;4766:*/
;4767:void BotCheckForKamikazeBody(bot_state_t *bs, entityState_t *state) {
line 4769
;4768:	// if this entity is not wearing the kamikaze
;4769:	if (!(state->eFlags & EF_KAMIKAZE))
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
NEI4 $2743
line 4770
;4770:		return;
ADDRGP4 $2742
JUMPV
LABELV $2743
line 4772
;4771:	// if this entity isn't dead
;4772:	if (!(state->eFlags & EF_DEAD))
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $2745
line 4773
;4773:		return;
ADDRGP4 $2742
JUMPV
LABELV $2745
line 4775
;4774:	//remember this kamikaze body
;4775:	bs->kamikazebody = state->number;
ADDRFP4 0
INDIRP4
CNSTI4 6256
ADDP4
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
line 4776
;4776:}
LABELV $2742
endproc BotCheckForKamikazeBody 0 0
export BotCheckEvents
proc BotCheckEvents 316 12
line 4784
;4777:#endif
;4778:
;4779:/*
;4780:==================
;4781:BotCheckEvents
;4782:==================
;4783:*/
;4784:void BotCheckEvents(bot_state_t *bs, entityState_t *state) {
line 4793
;4785:	int event;
;4786:	char buf[128];
;4787:#ifdef MISSIONPACK
;4788:	aas_entityinfo_t entinfo;
;4789:#endif
;4790:
;4791:	//NOTE: this sucks, we're accessing the gentity_t directly
;4792:	//but there's no other fast way to do it right now
;4793:	if (bs->entityeventTime[state->number] == g_entities[state->number].eventTime) {
ADDRLP4 272
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDP4
INDIRI4
ADDRLP4 272
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities+552
ADDP4
INDIRI4
NEI4 $2748
line 4794
;4794:		return;
ADDRGP4 $2747
JUMPV
LABELV $2748
line 4796
;4795:	}
;4796:	bs->entityeventTime[state->number] = g_entities[state->number].eventTime;
ADDRLP4 276
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 276
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDP4
ADDRLP4 276
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities+552
ADDP4
INDIRI4
ASGNI4
line 4798
;4797:	//if it's an event only entity
;4798:	if (state->eType > ET_EVENTS) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
LEI4 $2752
line 4799
;4799:		event = (state->eType - ET_EVENTS) & ~EV_EVENT_BITS;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
SUBI4
CNSTI4 -769
BANDI4
ASGNI4
line 4800
;4800:	}
ADDRGP4 $2753
JUMPV
LABELV $2752
line 4801
;4801:	else {
line 4802
;4802:		event = state->event & ~EV_EVENT_BITS;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
ASGNI4
line 4803
;4803:	}
LABELV $2753
line 4805
;4804:	//
;4805:	switch(event) {
ADDRLP4 280
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 280
INDIRI4
CNSTI4 1
LTI4 $2754
ADDRLP4 280
INDIRI4
CNSTI4 76
GTI4 $2754
ADDRLP4 280
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2832-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $2832
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2755
address $2754
address $2754
address $2817
address $2754
address $2754
address $2818
address $2774
address $2786
address $2754
address $2754
address $2754
address $2754
address $2754
address $2754
address $2754
address $2754
address $2754
address $2754
address $2754
address $2754
address $2756
address $2754
address $2754
address $2754
address $2754
address $2754
address $2754
address $2754
address $2754
address $2754
address $2754
address $2754
address $2754
address $2754
address $2754
address $2754
address $2755
code
LABELV $2756
line 4808
;4806:		//client obituary event
;4807:		case EV_OBITUARY:
;4808:		{
line 4811
;4809:			int target, attacker, mod;
;4810:
;4811:			target = state->otherEntityNum;
ADDRLP4 284
ADDRFP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 4812
;4812:			attacker = state->otherEntityNum2;
ADDRLP4 288
ADDRFP4 4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 4813
;4813:			mod = state->eventParm;
ADDRLP4 292
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 4815
;4814:			//
;4815:			if (target == bs->client) {
ADDRLP4 284
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2757
line 4816
;4816:				bs->botdeathtype = mod;
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
ADDRLP4 292
INDIRI4
ASGNI4
line 4817
;4817:				bs->lastkilledby = attacker;
ADDRFP4 0
INDIRP4
CNSTI4 5996
ADDP4
ADDRLP4 288
INDIRI4
ASGNI4
line 4819
;4818:				//
;4819:				if (target == attacker ||
ADDRLP4 296
ADDRLP4 284
INDIRI4
ASGNI4
ADDRLP4 296
INDIRI4
ADDRLP4 288
INDIRI4
EQI4 $2762
ADDRLP4 296
INDIRI4
CNSTI4 1023
EQI4 $2762
ADDRLP4 296
INDIRI4
CNSTI4 1022
NEI4 $2759
LABELV $2762
line 4821
;4820:					target == ENTITYNUM_NONE ||
;4821:					target == ENTITYNUM_WORLD) bs->botsuicide = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6008
ADDP4
CNSTI4 1
ASGNI4
ADDRGP4 $2760
JUMPV
LABELV $2759
line 4822
;4822:				else bs->botsuicide = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6008
ADDP4
CNSTI4 0
ASGNI4
LABELV $2760
line 4824
;4823:				//
;4824:				bs->num_deaths++;
ADDRLP4 300
ADDRFP4 0
INDIRP4
CNSTI4 6028
ADDP4
ASGNP4
ADDRLP4 300
INDIRP4
ADDRLP4 300
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4825
;4825:			}
ADDRGP4 $2758
JUMPV
LABELV $2757
line 4827
;4826:			//else if this client was killed by the bot
;4827:			else if (attacker == bs->client) {
ADDRLP4 288
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2763
line 4828
;4828:				bs->enemydeathtype = mod;
ADDRFP4 0
INDIRP4
CNSTI4 6004
ADDP4
ADDRLP4 292
INDIRI4
ASGNI4
line 4829
;4829:				bs->lastkilledplayer = target;
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
ADDRLP4 284
INDIRI4
ASGNI4
line 4830
;4830:				bs->killedenemy_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6168
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4832
;4831:				//
;4832:				bs->num_kills++;
ADDRLP4 296
ADDRFP4 0
INDIRP4
CNSTI4 6032
ADDP4
ASGNP4
ADDRLP4 296
INDIRP4
ADDRLP4 296
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4833
;4833:			}
ADDRGP4 $2764
JUMPV
LABELV $2763
line 4834
;4834:			else if (attacker == bs->enemy && target == attacker) {
ADDRLP4 296
ADDRLP4 288
INDIRI4
ASGNI4
ADDRLP4 296
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
NEI4 $2765
ADDRLP4 284
INDIRI4
ADDRLP4 296
INDIRI4
NEI4 $2765
line 4835
;4835:				bs->enemysuicide = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6012
ADDP4
CNSTI4 1
ASGNI4
line 4836
;4836:			}
LABELV $2765
LABELV $2764
LABELV $2758
line 4839
;4837:			//
;4838:#ifdef MISSIONPACK			
;4839:			if (gametype == GT_1FCTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $2755
line 4841
;4840:				//
;4841:				BotEntityInfo(target, &entinfo);
ADDRLP4 284
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4842
;4842:				if ( entinfo.powerups & ( 1 << PW_NEUTRALFLAG ) ) {
ADDRLP4 132+124
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $2755
line 4843
;4843:					if (!BotSameTeam(bs, target)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 284
INDIRI4
ARGI4
ADDRLP4 300
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 300
INDIRI4
CNSTI4 0
NEI4 $2755
line 4844
;4844:						bs->neutralflagstatus = 3;	//enemy dropped the flag
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
CNSTI4 3
ASGNI4
line 4845
;4845:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4846
;4846:					}
line 4847
;4847:				}
line 4848
;4848:			}
line 4850
;4849:#endif
;4850:			break;
ADDRGP4 $2755
JUMPV
LABELV $2774
line 4853
;4851:		}
;4852:		case EV_GLOBAL_SOUND:
;4853:		{
line 4854
;4854:			if (state->eventParm < 0 || state->eventParm >= MAX_SOUNDS) {
ADDRLP4 284
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 284
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LTI4 $2777
ADDRLP4 284
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 256
LTI4 $2775
LABELV $2777
line 4855
;4855:				BotAI_Print(PRT_ERROR, "EV_GLOBAL_SOUND: eventParm (%d) out of range\n", state->eventParm);
CNSTI4 3
ARGI4
ADDRGP4 $2778
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 4856
;4856:				break;
ADDRGP4 $2755
JUMPV
LABELV $2775
line 4858
;4857:			}
;4858:			trap_GetConfigstring(CS_SOUNDS + state->eventParm, buf, sizeof(buf));
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 4872
;4859:			/*
;4860:			if (!strcmp(buf, "sound/teamplay/flagret_red.wav")) {
;4861:				//red flag is returned
;4862:				bs->redflagstatus = 0;
;4863:				bs->flagstatuschanged = qtrue;
;4864:			}
;4865:			else if (!strcmp(buf, "sound/teamplay/flagret_blu.wav")) {
;4866:				//blue flag is returned
;4867:				bs->blueflagstatus = 0;
;4868:				bs->flagstatuschanged = qtrue;
;4869:			}
;4870:			else*/
;4871:#ifdef MISSIONPACK
;4872:			if (!strcmp(buf, "sound/items/kamikazerespawn.wav" )) {
ADDRLP4 4
ARGP4
ADDRGP4 $2781
ARGP4
ADDRLP4 288
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
NEI4 $2779
line 4874
;4873:				//the kamikaze respawned so dont avoid it
;4874:				BotDontAvoid(bs, "Kamikaze");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2782
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 4875
;4875:			}
ADDRGP4 $2755
JUMPV
LABELV $2779
line 4878
;4876:			else
;4877:#endif
;4878:				if (!strcmp(buf, "sound/items/poweruprespawn.wav")) {
ADDRLP4 4
ARGP4
ADDRGP4 $2785
ARGP4
ADDRLP4 292
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 0
NEI4 $2755
line 4880
;4879:				//powerup respawned... go get it
;4880:				BotGoForPowerups(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotGoForPowerups
CALLV
pop
line 4881
;4881:			}
line 4882
;4882:			break;
ADDRGP4 $2755
JUMPV
LABELV $2786
line 4885
;4883:		}
;4884:		case EV_GLOBAL_TEAM_SOUND:
;4885:		{
line 4886
;4886:			if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $2787
line 4887
;4887:				switch(state->eventParm) {
ADDRLP4 284
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 0
LTI4 $2755
ADDRLP4 284
INDIRI4
CNSTI4 5
GTI4 $2755
ADDRLP4 284
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2798
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $2798
address $2792
address $2793
address $2794
address $2795
address $2796
address $2797
code
LABELV $2792
line 4889
;4888:					case GTS_RED_CAPTURE:
;4889:						bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6960
ADDP4
CNSTI4 0
ASGNI4
line 4890
;4890:						bs->redflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
CNSTI4 0
ASGNI4
line 4891
;4891:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4892
;4892:						break; //see BotMatch_CTF
ADDRGP4 $2755
JUMPV
LABELV $2793
line 4894
;4893:					case GTS_BLUE_CAPTURE:
;4894:						bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6960
ADDP4
CNSTI4 0
ASGNI4
line 4895
;4895:						bs->redflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
CNSTI4 0
ASGNI4
line 4896
;4896:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4897
;4897:						break; //see BotMatch_CTF
ADDRGP4 $2755
JUMPV
LABELV $2794
line 4900
;4898:					case GTS_RED_RETURN:
;4899:						//blue flag is returned
;4900:						bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6960
ADDP4
CNSTI4 0
ASGNI4
line 4901
;4901:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4902
;4902:						break;
ADDRGP4 $2755
JUMPV
LABELV $2795
line 4905
;4903:					case GTS_BLUE_RETURN:
;4904:						//red flag is returned
;4905:						bs->redflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
CNSTI4 0
ASGNI4
line 4906
;4906:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4907
;4907:						break;
ADDRGP4 $2755
JUMPV
LABELV $2796
line 4910
;4908:					case GTS_RED_TAKEN:
;4909:						//blue flag is taken
;4910:						bs->blueflagstatus = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6960
ADDP4
CNSTI4 1
ASGNI4
line 4911
;4911:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4912
;4912:						break; //see BotMatch_CTF
ADDRGP4 $2755
JUMPV
LABELV $2797
line 4915
;4913:					case GTS_BLUE_TAKEN:
;4914:						//red flag is taken
;4915:						bs->redflagstatus = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
CNSTI4 1
ASGNI4
line 4916
;4916:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4917
;4917:						break; //see BotMatch_CTF
line 4919
;4918:				}
;4919:			}
ADDRGP4 $2755
JUMPV
LABELV $2787
line 4921
;4920:#ifdef MISSIONPACK
;4921:			else if (gametype == GT_1FCTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $2755
line 4922
;4922:				switch(state->eventParm) {
ADDRLP4 284
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 0
LTI4 $2755
ADDRLP4 284
INDIRI4
CNSTI4 5
GTI4 $2755
ADDRLP4 284
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2816
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $2816
address $2804
address $2805
address $2806
address $2807
address $2808
address $2812
code
LABELV $2804
line 4924
;4923:					case GTS_RED_CAPTURE:
;4924:						bs->neutralflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
CNSTI4 0
ASGNI4
line 4925
;4925:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4926
;4926:						break;
ADDRGP4 $2755
JUMPV
LABELV $2805
line 4928
;4927:					case GTS_BLUE_CAPTURE:
;4928:						bs->neutralflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
CNSTI4 0
ASGNI4
line 4929
;4929:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4930
;4930:						break;
ADDRGP4 $2755
JUMPV
LABELV $2806
line 4933
;4931:					case GTS_RED_RETURN:
;4932:						//flag has returned
;4933:						bs->neutralflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
CNSTI4 0
ASGNI4
line 4934
;4934:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4935
;4935:						break;
ADDRGP4 $2755
JUMPV
LABELV $2807
line 4938
;4936:					case GTS_BLUE_RETURN:
;4937:						//flag has returned
;4938:						bs->neutralflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
CNSTI4 0
ASGNI4
line 4939
;4939:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4940
;4940:						break;
ADDRGP4 $2755
JUMPV
LABELV $2808
line 4942
;4941:					case GTS_RED_TAKEN:
;4942:						bs->neutralflagstatus = BotTeam(bs) == TEAM_RED ? 2 : 1; //FIXME: check Team_TakeFlagSound in g_team.c
ADDRLP4 296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 296
INDIRP4
ARGP4
ADDRLP4 300
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 300
INDIRI4
CNSTI4 1
NEI4 $2810
ADDRLP4 292
CNSTI4 2
ASGNI4
ADDRGP4 $2811
JUMPV
LABELV $2810
ADDRLP4 292
CNSTI4 1
ASGNI4
LABELV $2811
ADDRLP4 296
INDIRP4
CNSTI4 6964
ADDP4
ADDRLP4 292
INDIRI4
ASGNI4
line 4943
;4943:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4944
;4944:						break;
ADDRGP4 $2755
JUMPV
LABELV $2812
line 4946
;4945:					case GTS_BLUE_TAKEN:
;4946:						bs->neutralflagstatus = BotTeam(bs) == TEAM_BLUE ? 2 : 1; //FIXME: check Team_TakeFlagSound in g_team.c
ADDRLP4 308
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 308
INDIRP4
ARGP4
ADDRLP4 312
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 312
INDIRI4
CNSTI4 2
NEI4 $2814
ADDRLP4 304
CNSTI4 2
ASGNI4
ADDRGP4 $2815
JUMPV
LABELV $2814
ADDRLP4 304
CNSTI4 1
ASGNI4
LABELV $2815
ADDRLP4 308
INDIRP4
CNSTI4 6964
ADDP4
ADDRLP4 304
INDIRI4
ASGNI4
line 4947
;4947:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4948
;4948:						break;
line 4950
;4949:				}
;4950:			}
line 4952
;4951:#endif
;4952:			break;
ADDRGP4 $2755
JUMPV
LABELV $2817
line 4955
;4953:		}
;4954:		case EV_PLAYER_TELEPORT_IN:
;4955:		{
line 4956
;4956:			VectorCopy(state->origin, lastteleport_origin);
ADDRGP4 lastteleport_origin
ADDRFP4 4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 4957
;4957:			lastteleport_time = FloatTime();
ADDRGP4 lastteleport_time
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4958
;4958:			break;
ADDRGP4 $2755
JUMPV
LABELV $2818
line 4961
;4959:		}
;4960:		case EV_GENERAL_SOUND:
;4961:		{
line 4963
;4962:			//if this sound is played on the bot
;4963:			if (state->number == bs->client) {
ADDRFP4 4
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2755
line 4964
;4964:				if (state->eventParm < 0 || state->eventParm >= MAX_SOUNDS) {
ADDRLP4 284
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 284
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LTI4 $2823
ADDRLP4 284
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 256
LTI4 $2821
LABELV $2823
line 4965
;4965:					BotAI_Print(PRT_ERROR, "EV_GENERAL_SOUND: eventParm (%d) out of range\n", state->eventParm);
CNSTI4 3
ARGI4
ADDRGP4 $2824
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 4966
;4966:					break;
ADDRGP4 $2755
JUMPV
LABELV $2821
line 4969
;4967:				}
;4968:				//check out the sound
;4969:				trap_GetConfigstring(CS_SOUNDS + state->eventParm, buf, sizeof(buf));
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 4971
;4970:				//if falling into a death pit
;4971:				if (!strcmp(buf, "*falling1.wav")) {
ADDRLP4 4
ARGP4
ADDRGP4 $2827
ARGP4
ADDRLP4 288
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
NEI4 $2755
line 4973
;4972:					//if the bot has a personal teleporter
;4973:					if (bs->inventory[INVENTORY_TELEPORTER] > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 5072
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2755
line 4975
;4974:						//use the holdable item
;4975:						trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 4976
;4976:					}
line 4977
;4977:				}
line 4978
;4978:			}
line 4979
;4979:			break;
line 5006
;4980:		}
;4981:		case EV_FOOTSTEP:
;4982:		case EV_FOOTSTEP_METAL:
;4983:		case EV_FOOTSPLASH:
;4984:		case EV_FOOTWADE:
;4985:		case EV_SWIM:
;4986:		case EV_FALL_SHORT:
;4987:		case EV_FALL_MEDIUM:
;4988:		case EV_FALL_FAR:
;4989:		case EV_STEP_4:
;4990:		case EV_STEP_8:
;4991:		case EV_STEP_12:
;4992:		case EV_STEP_16:
;4993:		case EV_JUMP_PAD:
;4994:		case EV_JUMP:
;4995:		case EV_TAUNT:
;4996:		case EV_WATER_TOUCH:
;4997:		case EV_WATER_LEAVE:
;4998:		case EV_WATER_UNDER:
;4999:		case EV_WATER_CLEAR:
;5000:		case EV_ITEM_PICKUP:
;5001:		case EV_GLOBAL_ITEM_PICKUP:
;5002:		case EV_NOAMMO:
;5003:		case EV_CHANGE_WEAPON:
;5004:		case EV_FIRE_WEAPON:
;5005:			//FIXME: either add to sound queue or mark player as someone making noise
;5006:			break;
line 5023
;5007:		case EV_USE_ITEM0:
;5008:		case EV_USE_ITEM1:
;5009:		case EV_USE_ITEM2:
;5010:		case EV_USE_ITEM3:
;5011:		case EV_USE_ITEM4:
;5012:		case EV_USE_ITEM5:
;5013:		case EV_USE_ITEM6:
;5014:		case EV_USE_ITEM7:
;5015:		case EV_USE_ITEM8:
;5016:		case EV_USE_ITEM9:
;5017:		case EV_USE_ITEM10:
;5018:		case EV_USE_ITEM11:
;5019:		case EV_USE_ITEM12:
;5020:		case EV_USE_ITEM13:
;5021:		case EV_USE_ITEM14:
;5022:		case EV_USE_ITEM15:
;5023:			break;
LABELV $2754
LABELV $2755
line 5025
;5024:	}
;5025:}
LABELV $2747
endproc BotCheckEvents 316 12
export BotCheckSnapshot
proc BotCheckSnapshot 216 16
line 5032
;5026:
;5027:/*
;5028:==================
;5029:BotCheckSnapshot
;5030:==================
;5031:*/
;5032:void BotCheckSnapshot(bot_state_t *bs) {
line 5037
;5033:	int ent;
;5034:	entityState_t state;
;5035:
;5036:	//remove all avoid spots
;5037:	trap_BotAddAvoidSpot(bs->ms, vec3_origin, 0, AVOID_CLEAR);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRGP4 vec3_origin
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotAddAvoidSpot
CALLV
pop
line 5039
;5038:	//reset kamikaze body
;5039:	bs->kamikazebody = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6256
ADDP4
CNSTI4 0
ASGNI4
line 5041
;5040:	//reset number of proxmines
;5041:	bs->numproxmines = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6516
ADDP4
CNSTI4 0
ASGNI4
line 5043
;5042:	//
;5043:	ent = 0;
ADDRLP4 208
CNSTI4 0
ASGNI4
ADDRGP4 $2836
JUMPV
LABELV $2835
line 5044
;5044:	while( ( ent = BotAI_GetSnapshotEntity( bs->client, ent, &state ) ) != -1 ) {
line 5046
;5045:		//check the entity state for events
;5046:		BotCheckEvents(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckEvents
CALLV
pop
line 5048
;5047:		//check for grenades the bot should avoid
;5048:		BotCheckForGrenades(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckForGrenades
CALLV
pop
line 5052
;5049:		//
;5050:#ifdef MISSIONPACK
;5051:		//check for proximity mines which the bot should deactivate
;5052:		BotCheckForProxMines(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckForProxMines
CALLV
pop
line 5054
;5053:		//check for dead bodies with the kamikaze effect which should be gibbed
;5054:		BotCheckForKamikazeBody(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckForKamikazeBody
CALLV
pop
line 5056
;5055:#endif
;5056:	}
LABELV $2836
line 5044
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 208
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 212
ADDRGP4 BotAI_GetSnapshotEntity
CALLI4
ASGNI4
ADDRLP4 208
ADDRLP4 212
INDIRI4
ASGNI4
ADDRLP4 212
INDIRI4
CNSTI4 -1
NEI4 $2835
line 5058
;5057:	//check the player state for events
;5058:	BotAI_GetEntityState(bs->client, &state);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotAI_GetEntityState
CALLI4
pop
line 5060
;5059:	//copy the player state events to the entity state
;5060:	state.event = bs->cur_ps.externalEvent;
ADDRLP4 0+180
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 5061
;5061:	state.eventParm = bs->cur_ps.externalEventParm;
ADDRLP4 0+184
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ASGNI4
line 5063
;5062:	//
;5063:	BotCheckEvents(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckEvents
CALLV
pop
line 5064
;5064:}
LABELV $2834
endproc BotCheckSnapshot 216 16
export BotCheckAir
proc BotCheckAir 4 4
line 5071
;5065:
;5066:/*
;5067:==================
;5068:BotCheckAir
;5069:==================
;5070:*/
;5071:void BotCheckAir(bot_state_t *bs) {
line 5072
;5072:	if (bs->inventory[INVENTORY_ENVIRONMENTSUIT] <= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 5096
ADDP4
INDIRI4
CNSTI4 0
GTI4 $2841
line 5073
;5073:		if (trap_AAS_PointContents(bs->eye) & (CONTENTS_WATER|CONTENTS_SLIME|CONTENTS_LAVA)) {
ADDRFP4 0
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $2843
line 5074
;5074:			return;
ADDRGP4 $2840
JUMPV
LABELV $2843
line 5076
;5075:		}
;5076:	}
LABELV $2841
line 5077
;5077:	bs->lastair_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6176
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 5078
;5078:}
LABELV $2840
endproc BotCheckAir 4 4
export BotAlternateRoute
proc BotAlternateRoute 16 16
line 5085
;5079:
;5080:/*
;5081:==================
;5082:BotAlternateRoute
;5083:==================
;5084:*/
;5085:bot_goal_t *BotAlternateRoute(bot_state_t *bs, bot_goal_t *goal) {
line 5089
;5086:	int t;
;5087:
;5088:	// if the bot has an alternative route goal
;5089:	if (bs->altroutegoal.areanum) {
ADDRFP4 0
INDIRP4
CNSTI4 6692
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2846
line 5091
;5090:		//
;5091:		if (bs->reachedaltroutegoal_time)
ADDRFP4 0
INDIRP4
CNSTI4 6736
ADDP4
INDIRF4
CNSTF4 0
EQF4 $2848
line 5092
;5092:			return goal;
ADDRFP4 4
INDIRP4
RETP4
ADDRGP4 $2845
JUMPV
LABELV $2848
line 5094
;5093:		// travel time towards alternative route goal
;5094:		t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, bs->altroutegoal.areanum, bs->tfl);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 6692
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 5976
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 5095
;5095:		if (t && t < 20) {
ADDRLP4 12
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2850
ADDRLP4 12
INDIRI4
CNSTI4 20
GEI4 $2850
line 5097
;5096:			//BotAI_Print(PRT_MESSAGE, "reached alternate route goal\n");
;5097:			bs->reachedaltroutegoal_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6736
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 5098
;5098:		}
LABELV $2850
line 5099
;5099:		memcpy(goal, &bs->altroutegoal, sizeof(bot_goal_t));
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6680
ADDP4
ARGP4
CNSTU4 56
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 5100
;5100:		return &bs->altroutegoal;
ADDRFP4 0
INDIRP4
CNSTI4 6680
ADDP4
RETP4
ADDRGP4 $2845
JUMPV
LABELV $2846
line 5102
;5101:	}
;5102:	return goal;
ADDRFP4 4
INDIRP4
RETP4
LABELV $2845
endproc BotAlternateRoute 16 16
export BotGetAlternateRouteGoal
proc BotGetAlternateRouteGoal 20 0
line 5110
;5103:}
;5104:
;5105:/*
;5106:==================
;5107:BotGetAlternateRouteGoal
;5108:==================
;5109:*/
;5110:int BotGetAlternateRouteGoal(bot_state_t *bs, int base) {
line 5115
;5111:	aas_altroutegoal_t *altroutegoals;
;5112:	bot_goal_t *goal;
;5113:	int numaltroutegoals, rnd;
;5114:
;5115:	if (base == TEAM_RED) {
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $2853
line 5116
;5116:		altroutegoals = red_altroutegoals;
ADDRLP4 12
ADDRGP4 red_altroutegoals
ASGNP4
line 5117
;5117:		numaltroutegoals = red_numaltroutegoals;
ADDRLP4 4
ADDRGP4 red_numaltroutegoals
INDIRI4
ASGNI4
line 5118
;5118:	}
ADDRGP4 $2854
JUMPV
LABELV $2853
line 5119
;5119:	else {
line 5120
;5120:		altroutegoals = blue_altroutegoals;
ADDRLP4 12
ADDRGP4 blue_altroutegoals
ASGNP4
line 5121
;5121:		numaltroutegoals = blue_numaltroutegoals;
ADDRLP4 4
ADDRGP4 blue_numaltroutegoals
INDIRI4
ASGNI4
line 5122
;5122:	}
LABELV $2854
line 5123
;5123:	if (!numaltroutegoals)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2855
line 5124
;5124:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2852
JUMPV
LABELV $2855
line 5125
;5125:	rnd = (float) random() * numaltroutegoals;
ADDRLP4 16
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ADDRLP4 4
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 5126
;5126:	if (rnd >= numaltroutegoals)
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $2857
line 5127
;5127:		rnd = numaltroutegoals-1;
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $2857
line 5128
;5128:	goal = &bs->altroutegoal;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6680
ADDP4
ASGNP4
line 5129
;5129:	goal->areanum = altroutegoals[rnd].areanum;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 24
MULI4
ADDRLP4 12
INDIRP4
ADDP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 5130
;5130:	VectorCopy(altroutegoals[rnd].origin, goal->origin);
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
CNSTI4 24
MULI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRB
ASGNB 12
line 5131
;5131:	VectorSet(goal->mins, -8, -8, -8);
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3238002688
ASGNF4
line 5132
;5132:	VectorSet(goal->maxs, 8, 8, 8);
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1090519040
ASGNF4
line 5133
;5133:	goal->entitynum = 0;
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
CNSTI4 0
ASGNI4
line 5134
;5134:	goal->iteminfo = 0;
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 5135
;5135:	goal->number = 0;
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 5136
;5136:	goal->flags = 0;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 5138
;5137:	//
;5138:	bs->reachedaltroutegoal_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6736
ADDP4
CNSTF4 0
ASGNF4
line 5139
;5139:	return qtrue;
CNSTI4 1
RETI4
LABELV $2852
endproc BotGetAlternateRouteGoal 20 0
export BotSetupAlternativeRouteGoals
proc BotSetupAlternativeRouteGoals 12 32
line 5147
;5140:}
;5141:
;5142:/*
;5143:==================
;5144:BotSetupAlternateRouteGoals
;5145:==================
;5146:*/
;5147:void BotSetupAlternativeRouteGoals(void) {
line 5149
;5148:
;5149:	if (altroutegoals_setup)
ADDRGP4 altroutegoals_setup
INDIRI4
CNSTI4 0
EQI4 $2860
line 5150
;5150:		return;
ADDRGP4 $2859
JUMPV
LABELV $2860
line 5152
;5151:#ifdef MISSIONPACK
;5152:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $2862
line 5153
;5153:		if (trap_BotGetLevelItemGoal(-1, "Neutral Flag", &ctf_neutralflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2866
ARGP4
ADDRGP4 ctf_neutralflag
ARGP4
ADDRLP4 0
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $2864
line 5154
;5154:			BotAI_Print(PRT_WARNING, "no alt routes without Neutral Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $2867
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $2864
line 5155
;5155:		if (ctf_neutralflag.areanum) {
ADDRGP4 ctf_neutralflag+12
INDIRI4
CNSTI4 0
EQI4 $2863
line 5157
;5156:			//
;5157:			red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
ADDRGP4 ctf_neutralflag
ARGP4
ADDRGP4 ctf_neutralflag+12
INDIRI4
ARGI4
ADDRGP4 ctf_redflag
ARGP4
ADDRGP4 ctf_redflag+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRGP4 red_altroutegoals
ARGP4
CNSTI4 32
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 4
ADDRGP4 trap_AAS_AlternativeRouteGoals
CALLI4
ASGNI4
ADDRGP4 red_numaltroutegoals
ADDRLP4 4
INDIRI4
ASGNI4
line 5163
;5158:										ctf_neutralflag.origin, ctf_neutralflag.areanum,
;5159:										ctf_redflag.origin, ctf_redflag.areanum, TFL_DEFAULT,
;5160:										red_altroutegoals, MAX_ALTROUTEGOALS,
;5161:										ALTROUTEGOAL_CLUSTERPORTALS|
;5162:										ALTROUTEGOAL_VIEWPORTALS);
;5163:			blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
ADDRGP4 ctf_neutralflag
ARGP4
ADDRGP4 ctf_neutralflag+12
INDIRI4
ARGI4
ADDRGP4 ctf_blueflag
ARGP4
ADDRGP4 ctf_blueflag+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRGP4 blue_altroutegoals
ARGP4
CNSTI4 32
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 8
ADDRGP4 trap_AAS_AlternativeRouteGoals
CALLI4
ASGNI4
ADDRGP4 blue_numaltroutegoals
ADDRLP4 8
INDIRI4
ASGNI4
line 5169
;5164:										ctf_neutralflag.origin, ctf_neutralflag.areanum,
;5165:										ctf_blueflag.origin, ctf_blueflag.areanum, TFL_DEFAULT,
;5166:										blue_altroutegoals, MAX_ALTROUTEGOALS,
;5167:										ALTROUTEGOAL_CLUSTERPORTALS|
;5168:										ALTROUTEGOAL_VIEWPORTALS);
;5169:		}
line 5170
;5170:	}
ADDRGP4 $2863
JUMPV
LABELV $2862
line 5171
;5171:	else if (gametype == GT_1FCTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $2875
line 5173
;5172:		//
;5173:		red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
ADDRGP4 ctf_neutralflag
ARGP4
ADDRGP4 ctf_neutralflag+12
INDIRI4
ARGI4
ADDRGP4 ctf_redflag
ARGP4
ADDRGP4 ctf_redflag+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRGP4 red_altroutegoals
ARGP4
CNSTI4 32
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 0
ADDRGP4 trap_AAS_AlternativeRouteGoals
CALLI4
ASGNI4
ADDRGP4 red_numaltroutegoals
ADDRLP4 0
INDIRI4
ASGNI4
line 5179
;5174:									ctf_neutralflag.origin, ctf_neutralflag.areanum,
;5175:									ctf_redflag.origin, ctf_redflag.areanum, TFL_DEFAULT,
;5176:									red_altroutegoals, MAX_ALTROUTEGOALS,
;5177:									ALTROUTEGOAL_CLUSTERPORTALS|
;5178:									ALTROUTEGOAL_VIEWPORTALS);
;5179:		blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
ADDRGP4 ctf_neutralflag
ARGP4
ADDRGP4 ctf_neutralflag+12
INDIRI4
ARGI4
ADDRGP4 ctf_blueflag
ARGP4
ADDRGP4 ctf_blueflag+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRGP4 blue_altroutegoals
ARGP4
CNSTI4 32
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 4
ADDRGP4 trap_AAS_AlternativeRouteGoals
CALLI4
ASGNI4
ADDRGP4 blue_numaltroutegoals
ADDRLP4 4
INDIRI4
ASGNI4
line 5185
;5180:									ctf_neutralflag.origin, ctf_neutralflag.areanum,
;5181:									ctf_blueflag.origin, ctf_blueflag.areanum, TFL_DEFAULT,
;5182:									blue_altroutegoals, MAX_ALTROUTEGOALS,
;5183:									ALTROUTEGOAL_CLUSTERPORTALS|
;5184:									ALTROUTEGOAL_VIEWPORTALS);
;5185:	}
ADDRGP4 $2876
JUMPV
LABELV $2875
line 5186
;5186:	else if (gametype == GT_OBELISK) {
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $2881
line 5187
;5187:		if (trap_BotGetLevelItemGoal(-1, "Neutral Obelisk", &neutralobelisk) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2885
ARGP4
ADDRGP4 neutralobelisk
ARGP4
ADDRLP4 0
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $2883
line 5188
;5188:			BotAI_Print(PRT_WARNING, "Harvester without neutral obelisk\n");
CNSTI4 2
ARGI4
ADDRGP4 $2886
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $2883
line 5190
;5189:		//
;5190:		red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
ADDRGP4 neutralobelisk
ARGP4
ADDRGP4 neutralobelisk+12
INDIRI4
ARGI4
ADDRGP4 redobelisk
ARGP4
ADDRGP4 redobelisk+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRGP4 red_altroutegoals
ARGP4
CNSTI4 32
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 4
ADDRGP4 trap_AAS_AlternativeRouteGoals
CALLI4
ASGNI4
ADDRGP4 red_numaltroutegoals
ADDRLP4 4
INDIRI4
ASGNI4
line 5196
;5191:									neutralobelisk.origin, neutralobelisk.areanum,
;5192:									redobelisk.origin, redobelisk.areanum, TFL_DEFAULT,
;5193:									red_altroutegoals, MAX_ALTROUTEGOALS,
;5194:									ALTROUTEGOAL_CLUSTERPORTALS|
;5195:									ALTROUTEGOAL_VIEWPORTALS);
;5196:		blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
ADDRGP4 neutralobelisk
ARGP4
ADDRGP4 neutralobelisk+12
INDIRI4
ARGI4
ADDRGP4 blueobelisk
ARGP4
ADDRGP4 blueobelisk+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRGP4 blue_altroutegoals
ARGP4
CNSTI4 32
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 8
ADDRGP4 trap_AAS_AlternativeRouteGoals
CALLI4
ASGNI4
ADDRGP4 blue_numaltroutegoals
ADDRLP4 8
INDIRI4
ASGNI4
line 5202
;5197:									neutralobelisk.origin, neutralobelisk.areanum,
;5198:									blueobelisk.origin, blueobelisk.areanum, TFL_DEFAULT,
;5199:									blue_altroutegoals, MAX_ALTROUTEGOALS,
;5200:									ALTROUTEGOAL_CLUSTERPORTALS|
;5201:									ALTROUTEGOAL_VIEWPORTALS);
;5202:	}
ADDRGP4 $2882
JUMPV
LABELV $2881
line 5203
;5203:	else if (gametype == GT_HARVESTER) {
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $2891
line 5205
;5204:		//
;5205:		red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
ADDRGP4 neutralobelisk
ARGP4
ADDRGP4 neutralobelisk+12
INDIRI4
ARGI4
ADDRGP4 redobelisk
ARGP4
ADDRGP4 redobelisk+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRGP4 red_altroutegoals
ARGP4
CNSTI4 32
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 0
ADDRGP4 trap_AAS_AlternativeRouteGoals
CALLI4
ASGNI4
ADDRGP4 red_numaltroutegoals
ADDRLP4 0
INDIRI4
ASGNI4
line 5211
;5206:									neutralobelisk.origin, neutralobelisk.areanum,
;5207:									redobelisk.origin, redobelisk.areanum, TFL_DEFAULT,
;5208:									red_altroutegoals, MAX_ALTROUTEGOALS,
;5209:									ALTROUTEGOAL_CLUSTERPORTALS|
;5210:									ALTROUTEGOAL_VIEWPORTALS);
;5211:		blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
ADDRGP4 neutralobelisk
ARGP4
ADDRGP4 neutralobelisk+12
INDIRI4
ARGI4
ADDRGP4 blueobelisk
ARGP4
ADDRGP4 blueobelisk+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRGP4 blue_altroutegoals
ARGP4
CNSTI4 32
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 4
ADDRGP4 trap_AAS_AlternativeRouteGoals
CALLI4
ASGNI4
ADDRGP4 blue_numaltroutegoals
ADDRLP4 4
INDIRI4
ASGNI4
line 5217
;5212:									neutralobelisk.origin, neutralobelisk.areanum,
;5213:									blueobelisk.origin, blueobelisk.areanum, TFL_DEFAULT,
;5214:									blue_altroutegoals, MAX_ALTROUTEGOALS,
;5215:									ALTROUTEGOAL_CLUSTERPORTALS|
;5216:									ALTROUTEGOAL_VIEWPORTALS);
;5217:	}
LABELV $2891
LABELV $2882
LABELV $2876
LABELV $2863
line 5219
;5218:#endif
;5219:	altroutegoals_setup = qtrue;
ADDRGP4 altroutegoals_setup
CNSTI4 1
ASGNI4
line 5220
;5220:}
LABELV $2859
endproc BotSetupAlternativeRouteGoals 12 32
export BotDeathmatchAI
proc BotDeathmatchAI 1492 20
line 5227
;5221:
;5222:/*
;5223:==================
;5224:BotDeathmatchAI
;5225:==================
;5226:*/
;5227:void BotDeathmatchAI(bot_state_t *bs, float thinktime) {
line 5233
;5228:	char gender[144], name[144], buf[144];
;5229:	char userinfo[MAX_INFO_STRING];
;5230:	int i;
;5231:
;5232:	//if the bot has just been setup
;5233:	if (bs->setupcount > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2898
line 5234
;5234:		bs->setupcount--;
ADDRLP4 1460
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
ASGNP4
ADDRLP4 1460
INDIRP4
ADDRLP4 1460
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 5235
;5235:		if (bs->setupcount > 0) return;
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2900
ADDRGP4 $2897
JUMPV
LABELV $2900
line 5237
;5236:		//get the gender characteristic
;5237:		trap_Characteristic_String(bs->character, CHARACTERISTIC_GENDER, gender, sizeof(gender));
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 148
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 5239
;5238:		//set the bot gender
;5239:		trap_GetUserinfo(bs->client, userinfo, sizeof(userinfo));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 5240
;5240:		Info_SetValueForKey(userinfo, "sex", gender);
ADDRLP4 292
ARGP4
ADDRGP4 $2902
ARGP4
ADDRLP4 148
ARGP4
ADDRGP4 Info_SetValueForKey
CALLI4
pop
line 5241
;5241:		trap_SetUserinfo(bs->client, userinfo);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
ADDRGP4 trap_SetUserinfo
CALLV
pop
line 5243
;5242:		//set the team
;5243:		if ( !bs->map_restart && g_gametype.integer != GT_TOURNAMENT ) {
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2903
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
EQI4 $2903
line 5244
;5244:			Com_sprintf(buf, sizeof(buf), "team %s", bs->settings.team);
ADDRLP4 1316
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 $2906
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4756
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5245
;5245:			trap_EA_Command(bs->client, buf);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 1316
ARGP4
ADDRGP4 trap_EA_Command
CALLV
pop
line 5246
;5246:		}
LABELV $2903
line 5248
;5247:		//set the chat gender
;5248:		if (gender[0] == 'm') trap_BotSetChatGender(bs->cs, CHAT_GENDERMALE);
ADDRLP4 148
INDIRI1
CVII4 1
CNSTI4 109
NEI4 $2907
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
ADDRGP4 $2908
JUMPV
LABELV $2907
line 5249
;5249:		else if (gender[0] == 'f')  trap_BotSetChatGender(bs->cs, CHAT_GENDERFEMALE);
ADDRLP4 148
INDIRI1
CVII4 1
CNSTI4 102
NEI4 $2909
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
ADDRGP4 $2910
JUMPV
LABELV $2909
line 5250
;5250:		else  trap_BotSetChatGender(bs->cs, CHAT_GENDERLESS);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
LABELV $2910
LABELV $2908
line 5252
;5251:		//set the chat name
;5252:		ClientName(bs->client, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 5253
;5253:		trap_BotSetChatName(bs->cs, name, bs->client);
ADDRLP4 1464
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1464
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 1464
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotSetChatName
CALLV
pop
line 5255
;5254:		//
;5255:		bs->lastframe_health = bs->inventory[INVENTORY_HEALTH];
ADDRLP4 1468
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1468
INDIRP4
CNSTI4 6044
ADDP4
ADDRLP4 1468
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
ASGNI4
line 5256
;5256:		bs->lasthitcount = bs->cur_ps.persistant[PERS_HITS];
ADDRLP4 1472
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1472
INDIRP4
CNSTI4 6048
ADDP4
ADDRLP4 1472
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
ASGNI4
line 5258
;5257:		//
;5258:		bs->setupcount = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
CNSTI4 0
ASGNI4
line 5260
;5259:		//
;5260:		BotSetupAlternativeRouteGoals();
ADDRGP4 BotSetupAlternativeRouteGoals
CALLV
pop
line 5261
;5261:	}
LABELV $2898
line 5263
;5262:	//no ideal view set
;5263:	bs->flags &= ~BFL_IDEALVIEWSET;
ADDRLP4 1460
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 1460
INDIRP4
ADDRLP4 1460
INDIRP4
INDIRI4
CNSTI4 -33
BANDI4
ASGNI4
line 5265
;5264:	//
;5265:	if (!BotIntermission(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1464
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 1464
INDIRI4
CNSTI4 0
NEI4 $2911
line 5267
;5266:		//set the teleport time
;5267:		BotSetTeleportTime(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeleportTime
CALLV
pop
line 5269
;5268:		//update some inventory values
;5269:		BotUpdateInventory(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotUpdateInventory
CALLV
pop
line 5271
;5270:		//check out the snapshot
;5271:		BotCheckSnapshot(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckSnapshot
CALLV
pop
line 5273
;5272:		//check for air
;5273:		BotCheckAir(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckAir
CALLV
pop
line 5274
;5274:	}
LABELV $2911
line 5276
;5275:	//check the console messages
;5276:	BotCheckConsoleMessages(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckConsoleMessages
CALLV
pop
line 5278
;5277:	//if not in the intermission and not in observer mode
;5278:	if (!BotIntermission(bs) && !BotIsObserver(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1468
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 1468
INDIRI4
CNSTI4 0
NEI4 $2913
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1472
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 1472
INDIRI4
CNSTI4 0
NEI4 $2913
line 5280
;5279:		//do team AI
;5280:		BotTeamAI(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotTeamAI
CALLV
pop
line 5281
;5281:	}
LABELV $2913
line 5283
;5282:	//if the bot has no ai node
;5283:	if (!bs->ainode) {
ADDRFP4 0
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2915
line 5284
;5284:		AIEnter_Seek_LTG(bs, "BotDeathmatchAI: no ai node");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2917
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 5285
;5285:	}
LABELV $2915
line 5287
;5286:	//if the bot entered the game less than 8 seconds ago
;5287:	if (!bs->entergamechat && bs->entergame_time > FloatTime() - 8) {
ADDRLP4 1476
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1476
INDIRP4
CNSTI4 6024
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2918
ADDRLP4 1476
INDIRP4
CNSTI4 6064
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1090519040
SUBF4
LEF4 $2918
line 5288
;5288:		if (BotChat_EnterGame(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1480
ADDRGP4 BotChat_EnterGame
CALLI4
ASGNI4
ADDRLP4 1480
INDIRI4
CNSTI4 0
EQI4 $2920
line 5289
;5289:			bs->stand_time = FloatTime() + BotChatTime(bs);
ADDRLP4 1484
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1484
INDIRP4
ARGP4
ADDRLP4 1488
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 1484
INDIRP4
CNSTI4 6096
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 1488
INDIRF4
ADDF4
ASGNF4
line 5290
;5290:			AIEnter_Stand(bs, "BotDeathmatchAI: chat enter game");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2922
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 5291
;5291:		}
LABELV $2920
line 5292
;5292:		bs->entergamechat = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6024
ADDP4
CNSTI4 1
ASGNI4
line 5293
;5293:	}
LABELV $2918
line 5295
;5294:	//reset the node switches from the previous frame
;5295:	BotResetNodeSwitches();
ADDRGP4 BotResetNodeSwitches
CALLV
pop
line 5297
;5296:	//execute AI nodes
;5297:	for (i = 0; i < MAX_NODESWITCHES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2923
line 5298
;5298:		if (bs->ainode(bs)) break;
ADDRLP4 1480
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1480
INDIRP4
ARGP4
ADDRLP4 1484
ADDRLP4 1480
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1484
INDIRI4
CNSTI4 0
EQI4 $2927
ADDRGP4 $2925
JUMPV
LABELV $2927
line 5299
;5299:	}
LABELV $2924
line 5297
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 50
LTI4 $2923
LABELV $2925
line 5301
;5300:	//if the bot removed itself :)
;5301:	if (!bs->inuse) return;
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $2929
ADDRGP4 $2897
JUMPV
LABELV $2929
line 5303
;5302:	//if the bot executed too many AI nodes
;5303:	if (i >= MAX_NODESWITCHES) {
ADDRLP4 0
INDIRI4
CNSTI4 50
LTI4 $2931
line 5304
;5304:		trap_BotDumpGoalStack(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotDumpGoalStack
CALLV
pop
line 5305
;5305:		trap_BotDumpAvoidGoals(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotDumpAvoidGoals
CALLV
pop
line 5306
;5306:		BotDumpNodeSwitches(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotDumpNodeSwitches
CALLV
pop
line 5307
;5307:		ClientName(bs->client, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 5308
;5308:		BotAI_Print(PRT_ERROR, "%s at %1.1f switched more than %d AI nodes\n", name, FloatTime(), MAX_NODESWITCHES);
CNSTI4 3
ARGI4
ADDRGP4 $2933
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 floattime
INDIRF4
ARGF4
CNSTI4 50
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 5309
;5309:	}
LABELV $2931
line 5311
;5310:	//
;5311:	bs->lastframe_health = bs->inventory[INVENTORY_HEALTH];
ADDRLP4 1480
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1480
INDIRP4
CNSTI4 6044
ADDP4
ADDRLP4 1480
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
ASGNI4
line 5312
;5312:	bs->lasthitcount = bs->cur_ps.persistant[PERS_HITS];
ADDRLP4 1484
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1484
INDIRP4
CNSTI4 6048
ADDP4
ADDRLP4 1484
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
ASGNI4
line 5313
;5313:}
LABELV $2897
endproc BotDeathmatchAI 1492 20
export BotSetEntityNumForGoalWithModel
proc BotSetEntityNumForGoalWithModel 44 4
line 5320
;5314:
;5315:/*
;5316:==================
;5317:BotSetEntityNumForGoalWithModel
;5318:==================
;5319:*/
;5320:void BotSetEntityNumForGoalWithModel(bot_goal_t *goal, int eType, char *modelname) {
line 5325
;5321:	gentity_t *ent;
;5322:	int i, modelindex;
;5323:	vec3_t dir;
;5324:
;5325:	modelindex = G_ModelIndex( modelname );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 G_ModelIndex
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 24
INDIRI4
ASGNI4
line 5326
;5326:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 5327
;5327:	for (i = 0; i < level.num_entities; i++, ent++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 $2938
JUMPV
LABELV $2935
line 5328
;5328:		if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2940
line 5329
;5329:			continue;
ADDRGP4 $2936
JUMPV
LABELV $2940
line 5331
;5330:		}
;5331:		if ( eType && ent->s.eType != eType) {
ADDRLP4 28
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2942
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $2942
line 5332
;5332:			continue;
ADDRGP4 $2936
JUMPV
LABELV $2942
line 5334
;5333:		}
;5334:		if (ent->s.modelindex != modelindex) {
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $2944
line 5335
;5335:			continue;
ADDRGP4 $2936
JUMPV
LABELV $2944
line 5337
;5336:		}
;5337:		VectorSubtract(goal->origin, ent->s.origin, dir);
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5338
;5338:		if (VectorLengthSquared(dir) < Square(10)) {
ADDRLP4 4
ARGP4
ADDRLP4 40
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 40
INDIRF4
CNSTF4 1120403456
GEF4 $2948
line 5339
;5339:			goal->entitynum = i;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 5340
;5340:			return;
ADDRGP4 $2934
JUMPV
LABELV $2948
line 5342
;5341:		}
;5342:	}
LABELV $2936
line 5327
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 824
ADDP4
ASGNP4
LABELV $2938
ADDRLP4 16
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $2935
line 5343
;5343:}
LABELV $2934
endproc BotSetEntityNumForGoalWithModel 44 4
export BotSetEntityNumForGoal
proc BotSetEntityNumForGoal 36 8
line 5350
;5344:
;5345:/*
;5346:==================
;5347:BotSetEntityNumForGoal
;5348:==================
;5349:*/
;5350:void BotSetEntityNumForGoal(bot_goal_t *goal, char *classname) {
line 5355
;5351:	gentity_t *ent;
;5352:	int i;
;5353:	vec3_t dir;
;5354:
;5355:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 5356
;5356:	for (i = 0; i < level.num_entities; i++, ent++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 $2954
JUMPV
LABELV $2951
line 5357
;5357:		if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2956
line 5358
;5358:			continue;
ADDRGP4 $2952
JUMPV
LABELV $2956
line 5360
;5359:		}
;5360:		if ( !Q_stricmp(ent->classname, classname) ) {
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $2958
line 5361
;5361:			continue;
ADDRGP4 $2952
JUMPV
LABELV $2958
line 5363
;5362:		}
;5363:		VectorSubtract(goal->origin, ent->s.origin, dir);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5364
;5364:		if (VectorLengthSquared(dir) < Square(10)) {
ADDRLP4 4
ARGP4
ADDRLP4 32
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
CNSTF4 1120403456
GEF4 $2962
line 5365
;5365:			goal->entitynum = i;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 5366
;5366:			return;
ADDRGP4 $2950
JUMPV
LABELV $2962
line 5368
;5367:		}
;5368:	}
LABELV $2952
line 5356
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 824
ADDP4
ASGNP4
LABELV $2954
ADDRLP4 16
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $2951
line 5369
;5369:}
LABELV $2950
endproc BotSetEntityNumForGoal 36 8
export BotGoalForBSPEntity
proc BotGoalForBSPEntity 1128 20
line 5376
;5370:
;5371:/*
;5372:==================
;5373:BotGoalForBSPEntity
;5374:==================
;5375:*/
;5376:int BotGoalForBSPEntity( char *classname, bot_goal_t *goal ) {
line 5381
;5377:	char value[MAX_INFO_STRING];
;5378:	vec3_t origin, start, end;
;5379:	int ent, numareas, areas[10];
;5380:
;5381:	memset(goal, 0, sizeof(bot_goal_t));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 56
ARGU4
ADDRGP4 memset
CALLP4
pop
line 5382
;5382:	for (ent = trap_AAS_NextBSPEntity(0); ent; ent = trap_AAS_NextBSPEntity(ent)) {
CNSTI4 0
ARGI4
ADDRLP4 1108
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1108
INDIRI4
ASGNI4
ADDRGP4 $2968
JUMPV
LABELV $2965
line 5383
;5383:		if (!trap_AAS_ValueForBSPEpairKey(ent, "classname", value, sizeof(value)))
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2463
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1112
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 1112
INDIRI4
CNSTI4 0
NEI4 $2969
line 5384
;5384:			continue;
ADDRGP4 $2966
JUMPV
LABELV $2969
line 5385
;5385:		if (!strcmp(value, classname)) {
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1116
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1116
INDIRI4
CNSTI4 0
NEI4 $2971
line 5386
;5386:			if (!trap_AAS_VectorForBSPEpairKey(ent, "origin", origin))
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2479
ARGP4
ADDRLP4 1028
ARGP4
ADDRLP4 1120
ADDRGP4 trap_AAS_VectorForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 1120
INDIRI4
CNSTI4 0
NEI4 $2973
line 5387
;5387:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2964
JUMPV
LABELV $2973
line 5388
;5388:			VectorCopy(origin, goal->origin);
ADDRFP4 4
INDIRP4
ADDRLP4 1028
INDIRB
ASGNB 12
line 5389
;5389:			VectorCopy(origin, start);
ADDRLP4 1040
ADDRLP4 1028
INDIRB
ASGNB 12
line 5390
;5390:			start[2] -= 32;
ADDRLP4 1040+8
ADDRLP4 1040+8
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 5391
;5391:			VectorCopy(origin, end);
ADDRLP4 1052
ADDRLP4 1028
INDIRB
ASGNB 12
line 5392
;5392:			end[2] += 32;
ADDRLP4 1052+8
ADDRLP4 1052+8
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 5393
;5393:			numareas = trap_AAS_TraceAreas(start, end, areas, NULL, 10);
ADDRLP4 1040
ARGP4
ADDRLP4 1052
ARGP4
ADDRLP4 1068
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 1124
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 1064
ADDRLP4 1124
INDIRI4
ASGNI4
line 5394
;5394:			if (!numareas)
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $2977
line 5395
;5395:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2964
JUMPV
LABELV $2977
line 5396
;5396:			goal->areanum = areas[0];
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 1068
INDIRI4
ASGNI4
line 5397
;5397:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2964
JUMPV
LABELV $2971
line 5399
;5398:		}
;5399:	}
LABELV $2966
line 5382
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1112
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1112
INDIRI4
ASGNI4
LABELV $2968
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2965
line 5400
;5400:	return qfalse;
CNSTI4 0
RETI4
LABELV $2964
endproc BotGoalForBSPEntity 1128 20
export BotSetupDeathmatchAI
proc BotSetupDeathmatchAI 152 16
line 5408
;5401:}
;5402:
;5403:/*
;5404:==================
;5405:BotSetupDeathmatchAI
;5406:==================
;5407:*/
;5408:void BotSetupDeathmatchAI(void) {
line 5412
;5409:	int ent, modelnum;
;5410:	char model[128];
;5411:
;5412:	gametype = trap_Cvar_VariableIntegerValue( "g_gametype" );
ADDRGP4 $2980
ARGP4
ADDRLP4 136
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 gametype
ADDRLP4 136
INDIRI4
ASGNI4
line 5414
;5413:
;5414:	trap_Cvar_Register(&bot_rocketjump, "bot_rocketjump", "1", 0);
ADDRGP4 bot_rocketjump
ARGP4
ADDRGP4 $2981
ARGP4
ADDRGP4 $2713
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5415
;5415:	trap_Cvar_Register(&bot_grapple, "bot_grapple", "0", 0);
ADDRGP4 bot_grapple
ARGP4
ADDRGP4 $2982
ARGP4
ADDRGP4 $2983
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5416
;5416:	trap_Cvar_Register(&bot_fastchat, "bot_fastchat", "0", 0);
ADDRGP4 bot_fastchat
ARGP4
ADDRGP4 $2984
ARGP4
ADDRGP4 $2983
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5417
;5417:	trap_Cvar_Register(&bot_nochat, "bot_nochat", "0", 0);
ADDRGP4 bot_nochat
ARGP4
ADDRGP4 $2985
ARGP4
ADDRGP4 $2983
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5418
;5418:	trap_Cvar_Register(&bot_testrchat, "bot_testrchat", "0", 0);
ADDRGP4 bot_testrchat
ARGP4
ADDRGP4 $2712
ARGP4
ADDRGP4 $2983
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5419
;5419:	trap_Cvar_Register(&bot_challenge, "bot_challenge", "0", 0);
ADDRGP4 bot_challenge
ARGP4
ADDRGP4 $2986
ARGP4
ADDRGP4 $2983
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5420
;5420:	trap_Cvar_Register(&bot_predictobstacles, "bot_predictobstacles", "1", 0);
ADDRGP4 bot_predictobstacles
ARGP4
ADDRGP4 $2987
ARGP4
ADDRGP4 $2713
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5421
;5421:	trap_Cvar_Register(&g_spSkill, "g_spSkill", "2", 0);
ADDRGP4 g_spSkill
ARGP4
ADDRGP4 $2988
ARGP4
ADDRGP4 $2989
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5423
;5422:	//
;5423:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $2990
line 5424
;5424:		if (trap_BotGetLevelItemGoal(-1, "Red Flag", &ctf_redflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2994
ARGP4
ADDRGP4 ctf_redflag
ARGP4
ADDRLP4 140
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
GEI4 $2992
line 5425
;5425:			BotAI_Print(PRT_WARNING, "CTF without Red Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $2995
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $2992
line 5426
;5426:		if (trap_BotGetLevelItemGoal(-1, "Blue Flag", &ctf_blueflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2998
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
ADDRLP4 144
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
GEI4 $2991
line 5427
;5427:			BotAI_Print(PRT_WARNING, "CTF without Blue Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $2999
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 5428
;5428:	}
ADDRGP4 $2991
JUMPV
LABELV $2990
line 5430
;5429:#ifdef MISSIONPACK
;5430:	else if (gametype == GT_1FCTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $3000
line 5431
;5431:		if (trap_BotGetLevelItemGoal(-1, "Neutral Flag", &ctf_neutralflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2866
ARGP4
ADDRGP4 ctf_neutralflag
ARGP4
ADDRLP4 140
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
GEI4 $3002
line 5432
;5432:			BotAI_Print(PRT_WARNING, "One Flag CTF without Neutral Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $3004
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $3002
line 5433
;5433:		if (trap_BotGetLevelItemGoal(-1, "Red Flag", &ctf_redflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2994
ARGP4
ADDRGP4 ctf_redflag
ARGP4
ADDRLP4 144
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
GEI4 $3005
line 5434
;5434:			BotAI_Print(PRT_WARNING, "One Flag CTF without Red Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $3007
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $3005
line 5435
;5435:		if (trap_BotGetLevelItemGoal(-1, "Blue Flag", &ctf_blueflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2998
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
ADDRLP4 148
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
GEI4 $3001
line 5436
;5436:			BotAI_Print(PRT_WARNING, "One Flag CTF without Blue Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $3010
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 5437
;5437:	}
ADDRGP4 $3001
JUMPV
LABELV $3000
line 5438
;5438:	else if (gametype == GT_OBELISK) {
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $3011
line 5439
;5439:		if (trap_BotGetLevelItemGoal(-1, "Red Obelisk", &redobelisk) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $3015
ARGP4
ADDRGP4 redobelisk
ARGP4
ADDRLP4 140
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
GEI4 $3013
line 5440
;5440:			BotAI_Print(PRT_WARNING, "Obelisk without red obelisk\n");
CNSTI4 2
ARGI4
ADDRGP4 $3016
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $3013
line 5441
;5441:		BotSetEntityNumForGoal(&redobelisk, "team_redobelisk");
ADDRGP4 redobelisk
ARGP4
ADDRGP4 $3017
ARGP4
ADDRGP4 BotSetEntityNumForGoal
CALLV
pop
line 5442
;5442:		if (trap_BotGetLevelItemGoal(-1, "Blue Obelisk", &blueobelisk) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $3020
ARGP4
ADDRGP4 blueobelisk
ARGP4
ADDRLP4 144
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
GEI4 $3018
line 5443
;5443:			BotAI_Print(PRT_WARNING, "Obelisk without blue obelisk\n");
CNSTI4 2
ARGI4
ADDRGP4 $3021
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $3018
line 5444
;5444:		BotSetEntityNumForGoal(&blueobelisk, "team_blueobelisk");
ADDRGP4 blueobelisk
ARGP4
ADDRGP4 $3022
ARGP4
ADDRGP4 BotSetEntityNumForGoal
CALLV
pop
line 5445
;5445:	}
ADDRGP4 $3012
JUMPV
LABELV $3011
line 5446
;5446:	else if (gametype == GT_HARVESTER) {
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $3023
line 5447
;5447:		if (trap_BotGetLevelItemGoal(-1, "Red Obelisk", &redobelisk) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $3015
ARGP4
ADDRGP4 redobelisk
ARGP4
ADDRLP4 140
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
GEI4 $3025
line 5448
;5448:			BotAI_Print(PRT_WARNING, "Harvester without red obelisk\n");
CNSTI4 2
ARGI4
ADDRGP4 $3027
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $3025
line 5449
;5449:		BotSetEntityNumForGoal(&redobelisk, "team_redobelisk");
ADDRGP4 redobelisk
ARGP4
ADDRGP4 $3017
ARGP4
ADDRGP4 BotSetEntityNumForGoal
CALLV
pop
line 5450
;5450:		if (trap_BotGetLevelItemGoal(-1, "Blue Obelisk", &blueobelisk) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $3020
ARGP4
ADDRGP4 blueobelisk
ARGP4
ADDRLP4 144
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
GEI4 $3028
line 5451
;5451:			BotAI_Print(PRT_WARNING, "Harvester without blue obelisk\n");
CNSTI4 2
ARGI4
ADDRGP4 $3030
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $3028
line 5452
;5452:		BotSetEntityNumForGoal(&blueobelisk, "team_blueobelisk");
ADDRGP4 blueobelisk
ARGP4
ADDRGP4 $3022
ARGP4
ADDRGP4 BotSetEntityNumForGoal
CALLV
pop
line 5453
;5453:		if (trap_BotGetLevelItemGoal(-1, "Neutral Obelisk", &neutralobelisk) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2885
ARGP4
ADDRGP4 neutralobelisk
ARGP4
ADDRLP4 148
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
GEI4 $3031
line 5454
;5454:			BotAI_Print(PRT_WARNING, "Harvester without neutral obelisk\n");
CNSTI4 2
ARGI4
ADDRGP4 $2886
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $3031
line 5455
;5455:		BotSetEntityNumForGoal(&neutralobelisk, "team_neutralobelisk");
ADDRGP4 neutralobelisk
ARGP4
ADDRGP4 $3033
ARGP4
ADDRGP4 BotSetEntityNumForGoal
CALLV
pop
line 5456
;5456:	}
LABELV $3023
LABELV $3012
LABELV $3001
LABELV $2991
line 5459
;5457:#endif
;5458:
;5459:	max_bspmodelindex = 0;
ADDRGP4 max_bspmodelindex
CNSTI4 0
ASGNI4
line 5460
;5460:	for (ent = trap_AAS_NextBSPEntity(0); ent; ent = trap_AAS_NextBSPEntity(ent)) {
CNSTI4 0
ARGI4
ADDRLP4 140
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 140
INDIRI4
ASGNI4
ADDRGP4 $3037
JUMPV
LABELV $3034
line 5461
;5461:		if (!trap_AAS_ValueForBSPEpairKey(ent, "model", model, sizeof(model))) continue;
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $525
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 144
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $3038
ADDRGP4 $3035
JUMPV
LABELV $3038
line 5462
;5462:		if (model[0] == '*') {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $3040
line 5463
;5463:			modelnum = atoi(model+1);
ADDRLP4 4+1
ARGP4
ADDRLP4 148
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 132
ADDRLP4 148
INDIRI4
ASGNI4
line 5464
;5464:			if (modelnum > max_bspmodelindex)
ADDRLP4 132
INDIRI4
ADDRGP4 max_bspmodelindex
INDIRI4
LEI4 $3043
line 5465
;5465:				max_bspmodelindex = modelnum;
ADDRGP4 max_bspmodelindex
ADDRLP4 132
INDIRI4
ASGNI4
LABELV $3043
line 5466
;5466:		}
LABELV $3040
line 5467
;5467:	}
LABELV $3035
line 5460
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 144
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 144
INDIRI4
ASGNI4
LABELV $3037
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $3034
line 5469
;5468:	//initialize the waypoint heap
;5469:	BotInitWaypoints();
ADDRGP4 BotInitWaypoints
CALLV
pop
line 5470
;5470:}
LABELV $2979
endproc BotSetupDeathmatchAI 152 16
export BotShutdownDeathmatchAI
proc BotShutdownDeathmatchAI 0 0
line 5477
;5471:
;5472:/*
;5473:==================
;5474:BotShutdownDeathmatchAI
;5475:==================
;5476:*/
;5477:void BotShutdownDeathmatchAI(void) {
line 5478
;5478:	altroutegoals_setup = qfalse;
ADDRGP4 altroutegoals_setup
CNSTI4 0
ASGNI4
line 5479
;5479:}
LABELV $3045
endproc BotShutdownDeathmatchAI 0 0
import g_clients
bss
export blue_numaltroutegoals
align 4
LABELV blue_numaltroutegoals
skip 4
export blue_altroutegoals
align 4
LABELV blue_altroutegoals
skip 768
export red_numaltroutegoals
align 4
LABELV red_numaltroutegoals
skip 4
export red_altroutegoals
align 4
LABELV red_altroutegoals
skip 768
export altroutegoals_setup
align 4
LABELV altroutegoals_setup
skip 4
export max_bspmodelindex
align 4
LABELV max_bspmodelindex
skip 4
export lastteleport_time
align 4
LABELV lastteleport_time
skip 4
export lastteleport_origin
align 4
LABELV lastteleport_origin
skip 12
import bot_developer
export g_spSkill
align 4
LABELV g_spSkill
skip 272
export bot_predictobstacles
align 4
LABELV bot_predictobstacles
skip 272
export botai_freewaypoints
align 4
LABELV botai_freewaypoints
skip 4
export botai_waypoints
align 4
LABELV botai_waypoints
skip 12800
import BotVoiceChatOnly
import BotVoiceChat
import BotSetTeamMateTaskPreference
import BotGetTeamMateTaskPreference
import BotTeamAI
import BotDumpNodeSwitches
import BotResetNodeSwitches
import AINode_Battle_NBG
import AINode_Battle_Retreat
import AINode_Battle_Chase
import AINode_Battle_Fight
import AINode_Seek_LTG
import AINode_Seek_NBG
import AINode_Seek_ActivateEntity
import AINode_Stand
import AINode_Respawn
import AINode_Observer
import AINode_Intermission
import AIEnter_Battle_NBG
import AIEnter_Battle_Retreat
import AIEnter_Battle_Chase
import AIEnter_Battle_Fight
import AIEnter_Seek_Camp
import AIEnter_Seek_LTG
import AIEnter_Seek_NBG
import AIEnter_Seek_ActivateEntity
import AIEnter_Stand
import AIEnter_Respawn
import AIEnter_Observer
import AIEnter_Intermission
import BotPrintTeamGoal
import BotMatchMessage
import notleader
import BotChatTest
import BotValidChatPosition
import BotChatTime
import BotChat_Random
import BotChat_EnemySuicide
import BotChat_Kill
import BotChat_Death
import BotChat_HitNoKill
import BotChat_HitNoDeath
import BotChat_HitTalking
import BotChat_EndLevel
import BotChat_StartLevel
import BotChat_ExitGame
import BotChat_EnterGame
export neutralobelisk
align 4
LABELV neutralobelisk
skip 56
export blueobelisk
align 4
LABELV blueobelisk
skip 56
export redobelisk
align 4
LABELV redobelisk
skip 56
export ctf_neutralflag
align 4
LABELV ctf_neutralflag
skip 56
export ctf_blueflag
align 4
LABELV ctf_blueflag
skip 56
export ctf_redflag
align 4
LABELV ctf_redflag
skip 56
export bot_challenge
align 4
LABELV bot_challenge
skip 272
export bot_testrchat
align 4
LABELV bot_testrchat
skip 272
export bot_nochat
align 4
LABELV bot_nochat
skip 272
export bot_fastchat
align 4
LABELV bot_fastchat
skip 272
export bot_rocketjump
align 4
LABELV bot_rocketjump
skip 272
export bot_grapple
align 4
LABELV bot_grapple
skip 272
import mapname
export gametype
align 4
LABELV gametype
skip 4
import BotTeamLeader
import BotAI_GetSnapshotEntity
import BotAI_GetEntityState
import BotAI_GetClientState
import BotAI_Trace
import BotAI_BotInitialChat
import BotAI_Print
import floattime
import BotEntityInfo
import NumBots
import BotResetState
import BotResetWeaponState
import BotFreeWeaponState
import BotAllocWeaponState
import BotLoadWeaponWeights
import BotGetWeaponInfo
import BotChooseBestFightWeapon
import BotShutdownWeaponAI
import BotSetupWeaponAI
import BotShutdownMoveAI
import BotSetupMoveAI
import BotSetBrushModelTypes
import BotAddAvoidSpot
import BotInitMoveState
import BotFreeMoveState
import BotAllocMoveState
import BotPredictVisiblePosition
import BotMovementViewTarget
import BotReachabilityArea
import BotResetLastAvoidReach
import BotResetAvoidReach
import BotMoveInDirection
import BotMoveToGoal
import BotResetMoveState
import BotShutdownGoalAI
import BotSetupGoalAI
import BotFreeGoalState
import BotAllocGoalState
import BotFreeItemWeights
import BotLoadItemWeights
import BotMutateGoalFuzzyLogic
import BotSaveGoalFuzzyLogic
import BotInterbreedGoalFuzzyLogic
import BotUpdateEntityItems
import BotInitLevelItems
import BotSetAvoidGoalTime
import BotAvoidGoalTime
import BotGetMapLocationGoal
import BotGetNextCampSpotGoal
import BotGetLevelItemGoal
import BotItemGoalInVisButNotVisible
import BotTouchingGoal
import BotChooseNBGItem
import BotChooseLTGItem
import BotGetSecondGoal
import BotGetTopGoal
import BotGoalName
import BotDumpGoalStack
import BotDumpAvoidGoals
import BotEmptyGoalStack
import BotPopGoal
import BotPushGoal
import BotRemoveFromAvoidGoals
import BotResetAvoidGoals
import BotResetGoalState
import GeneticParentsAndChildSelection
import BotSetChatName
import BotSetChatGender
import BotLoadChatFile
import BotReplaceSynonyms
import UnifyWhiteSpaces
import BotMatchVariable
import BotFindMatch
import StringContains
import BotGetChatMessage
import BotEnterChat
import BotChatLength
import BotReplyChat
import BotNumInitialChats
import BotInitialChat
import BotNumConsoleMessages
import BotNextConsoleMessage
import BotRemoveConsoleMessage
import BotQueueConsoleMessage
import BotFreeChatState
import BotAllocChatState
import BotShutdownChatAI
import BotSetupChatAI
import BotShutdownCharacters
import Characteristic_String
import Characteristic_BInteger
import Characteristic_Integer
import Characteristic_BFloat
import Characteristic_Float
import BotFreeCharacter
import BotLoadCharacter
import EA_Shutdown
import EA_Setup
import EA_ResetInput
import EA_GetInput
import EA_EndRegular
import EA_View
import EA_Move
import EA_DelayedJump
import EA_Jump
import EA_SelectWeapon
import EA_Use
import EA_Gesture
import EA_Talk
import EA_Respawn
import EA_Attack
import EA_MoveRight
import EA_MoveLeft
import EA_MoveBack
import EA_MoveForward
import EA_MoveDown
import EA_MoveUp
import EA_Walk
import EA_Crouch
import EA_Action
import EA_Command
import EA_SayTeam
import EA_Say
import GetBotLibAPI
import svf_self_portal2
import G_RailgunRadiusDamage
import trap_SnapVector
import trap_GeneticParentsAndChildSelection
import trap_BotResetWeaponState
import trap_BotFreeWeaponState
import trap_BotAllocWeaponState
import trap_BotLoadWeaponWeights
import trap_BotGetWeaponInfo
import trap_BotChooseBestFightWeapon
import trap_BotAddAvoidSpot
import trap_BotInitMoveState
import trap_BotFreeMoveState
import trap_BotAllocMoveState
import trap_BotPredictVisiblePosition
import trap_BotMovementViewTarget
import trap_BotReachabilityArea
import trap_BotResetLastAvoidReach
import trap_BotResetAvoidReach
import trap_BotMoveInDirection
import trap_BotMoveToGoal
import trap_BotResetMoveState
import trap_BotFreeGoalState
import trap_BotAllocGoalState
import trap_BotMutateGoalFuzzyLogic
import trap_BotSaveGoalFuzzyLogic
import trap_BotInterbreedGoalFuzzyLogic
import trap_BotFreeItemWeights
import trap_BotLoadItemWeights
import trap_BotUpdateEntityItems
import trap_BotInitLevelItems
import trap_BotSetAvoidGoalTime
import trap_BotAvoidGoalTime
import trap_BotGetLevelItemGoal
import trap_BotGetMapLocationGoal
import trap_BotGetNextCampSpotGoal
import trap_BotItemGoalInVisButNotVisible
import trap_BotTouchingGoal
import trap_BotChooseNBGItem
import trap_BotChooseLTGItem
import trap_BotGetSecondGoal
import trap_BotGetTopGoal
import trap_BotGoalName
import trap_BotDumpGoalStack
import trap_BotDumpAvoidGoals
import trap_BotEmptyGoalStack
import trap_BotPopGoal
import trap_BotPushGoal
import trap_BotResetAvoidGoals
import trap_BotRemoveFromAvoidGoals
import trap_BotResetGoalState
import trap_BotSetChatName
import trap_BotSetChatGender
import trap_BotLoadChatFile
import trap_BotReplaceSynonyms
import trap_UnifyWhiteSpaces
import trap_BotMatchVariable
import trap_BotFindMatch
import trap_StringContains
import trap_BotGetChatMessage
import trap_BotEnterChat
import trap_BotChatLength
import trap_BotReplyChat
import trap_BotNumInitialChats
import trap_BotInitialChat
import trap_BotNumConsoleMessages
import trap_BotNextConsoleMessage
import trap_BotRemoveConsoleMessage
import trap_BotQueueConsoleMessage
import trap_BotFreeChatState
import trap_BotAllocChatState
import trap_Characteristic_String
import trap_Characteristic_BInteger
import trap_Characteristic_Integer
import trap_Characteristic_BFloat
import trap_Characteristic_Float
import trap_BotFreeCharacter
import trap_BotLoadCharacter
import trap_EA_ResetInput
import trap_EA_GetInput
import trap_EA_EndRegular
import trap_EA_View
import trap_EA_Move
import trap_EA_DelayedJump
import trap_EA_Jump
import trap_EA_SelectWeapon
import trap_EA_MoveRight
import trap_EA_MoveLeft
import trap_EA_MoveBack
import trap_EA_MoveForward
import trap_EA_MoveDown
import trap_EA_MoveUp
import trap_EA_Crouch
import trap_EA_Respawn
import trap_EA_Use
import trap_EA_Attack
import trap_EA_Talk
import trap_EA_Gesture
import trap_EA_Action
import trap_EA_Command
import trap_EA_SayTeam
import trap_EA_Say
import trap_AAS_PredictClientMovement
import trap_AAS_Swimming
import trap_AAS_AlternativeRouteGoals
import trap_AAS_PredictRoute
import trap_AAS_EnableRoutingArea
import trap_AAS_AreaTravelTimeToGoalArea
import trap_AAS_AreaReachability
import trap_AAS_IntForBSPEpairKey
import trap_AAS_FloatForBSPEpairKey
import trap_AAS_VectorForBSPEpairKey
import trap_AAS_ValueForBSPEpairKey
import trap_AAS_NextBSPEntity
import trap_AAS_PointContents
import trap_AAS_TraceAreas
import trap_AAS_PointReachabilityAreaIndex
import trap_AAS_PointAreaNum
import trap_AAS_Time
import trap_AAS_PresenceTypeBoundingBox
import trap_AAS_Initialized
import trap_AAS_EntityInfo
import trap_AAS_AreaInfo
import trap_AAS_BBoxAreas
import trap_BotUserCommand
import trap_BotGetServerCommand
import trap_BotGetSnapshotEntity
import trap_BotLibTest
import trap_BotLibUpdateEntity
import trap_BotLibLoadMap
import trap_BotLibStartFrame
import trap_BotLibDefine
import trap_BotLibVarGet
import trap_BotLibVarSet
import trap_BotLibShutdown
import trap_BotLibSetup
import trap_DebugPolygonDelete
import trap_DebugPolygonCreate
import trap_GetEntityToken
import trap_GetUsercmd
import trap_BotFreeClient
import trap_BotAllocateClient
import trap_EntityContact
import trap_EntitiesInBox
import trap_UnlinkEntity
import trap_LinkEntity
import trap_AreasConnected
import trap_AdjustAreaPortalState
import trap_InPVSIgnorePortals
import trap_InPVS
import trap_PointContents
import trap_TraceCapsule
import trap_Trace
import trap_SetBrushModel
import trap_GetServerinfo
import trap_SetUserinfo
import trap_GetUserinfo
import trap_GetConfigstring
import trap_SetConfigstring
import trap_SendServerCommand
import trap_DropClient
import trap_LocateGameData
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_VariableIntegerValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_RealTime
import trap_Milliseconds
import trap_Error
import trap_Print
import g_startHealth
import g_startArmor
import g_noSelfDamage
import g_railJump
import g_instagib
import g_rotation
import pmove_msec
import pmove_fixed
import g_smoothClients
import g_proxMineTimeout
import g_enableBreath
import g_enableDust
import g_singlePlayer
import g_blueteam
import g_redteam
import g_cubeTimeout
import g_obeliskRespawnDelay
import g_obeliskRegenAmount
import g_obeliskRegenPeriod
import g_obeliskHealth
import g_predictPVS
import g_unlagged
import g_listEntity
import g_allowVote
import g_podiumDrop
import g_podiumDist
import g_blood
import g_motd
import g_debugAlloc
import g_debugDamage
import g_debugMove
import g_inactivity
import g_forcerespawn
import g_weaponTeamRespawn
import g_weaponRespawn
import g_quadfactor
import g_knockback
import g_gravity
import g_speed
import g_dedicated
import g_needpass
import g_filterBan
import g_banIPs
import g_password
import g_logSync
import g_log
import g_warmup
import g_teamForceBalance
import g_autoJoin
import g_friendlyFire
import g_synchronousClients
import g_capturelimit
import g_timelimit
import g_fraglimit
import g_dmflags
import g_maxGameClients
import g_maxclients
import g_gametype
import sv_fps
import g_mapname
import g_cheats
import g_entities
import level
import AddTeamScore
import Pickup_Team
import CheckTeamStatus
import TeamplayInfoMessage
import Team_GetLocationMsg
import Team_GetLocation
import SelectCTFSpawnPoint
import Team_FreeEntity
import Team_ReturnFlag
import Team_InitGame
import Team_CheckHurtCarrier
import Team_FragBonuses
import Team_DroppedFlagThink
import TeamColorString
import OtherTeamName
import TeamName
import OtherTeam
import G_MapExist
import G_LoadMap
import ParseMapRotation
import BotTestAAS
import BotAIStartFrame
import BotAIShutdownClient
import BotAISetupClient
import BotAILoadMap
import BotAIShutdown
import BotAISetup
import BotInterbreedEndMatch
import Svcmd_BotList_f
import Svcmd_AddBot_f
import G_BotConnect
import G_RemoveQueuedBotBegin
import G_CheckBotSpawn
import G_GetBotInfoByName
import G_GetBotInfoByNumber
import G_InitBots
import G_PredictPlayerMove
import G_UnTimeShiftClient
import G_UndoTimeShiftFor
import G_DoTimeShiftFor
import G_UnTimeShiftAllClients
import G_TimeShiftAllClients
import G_StoreHistory
import G_ResetHistory
import Svcmd_AbortPodium_f
import SpawnModelsOnVictoryPads
import UpdateTournamentInfo
import G_ClearClientSessionData
import G_WriteClientSessionData
import G_ReadClientSessionData
import G_InitSessionData
import G_WriteSessionData
import G_InitWorldSession
import Svcmd_GameMem_f
import G_InitMemory
import G_Alloc
import Team_ResetFlags
import CheckObeliskAttack
import Team_CheckDroppedItem
import OnSameTeam
import G_RunClient
import ClientEndFrame
import ClientThink
import ClientCommand
import ClientBegin
import ClientDisconnect
import ClientUserinfoChanged
import ClientConnect
import G_BroadcastServerCommand
import G_Error
import G_Printf
import G_LogPrintf
import G_RunThink
import CheckTeamLeader
import SetLeader
import FindIntermissionPoint
import MoveClientToIntermission
import DeathmatchScoreboardMessage
import G_StartKamikaze
import FireWeapon
import G_FilterPacket
import G_ProcessIPBans
import ConsoleCommand
import SpotWouldTelefrag
import CalculateRanks
import AddScore
import player_die
import G_GenericDeathCleanup
import ClientSpawn
import ClientRestoreStats
import ClientBackupStats
import InitBodyQue
import BeginIntermission
import respawn
import CopyToBodyQue
import SelectSpawnPoint
import SetClientViewAngle
import PickTeam
import TeamLeader
import TeamConnectedCount
import TeamCount
import Weapon_HookThink
import Weapon_HookFree
import CheckGauntletAttack
import SnapVectorTowards
import CalcMuzzlePoint
import LogAccuracyHit
import DropPortalDestination
import DropPortalSource
import TeleportPlayer
import trigger_teleporter_touch
import Touch_DoorTrigger
import G_RunMover
import fire_prox
import fire_nail
import fire_grapple
import fire_bfg
import fire_rocket
import fire_grenade
import fire_plasma
import fire_blaster
import G_RunMissile
import TossClientCubes
import TossClientPersistantPowerups
import TossClientItems
import body_die
import G_InvulnerabilityEffect
import G_RadiusDamage
import G_Damage
import CanDamage
import BuildShaderStateConfig
import AddRemap
import G_SetOrigin
import G_AddEvent
import G_AddPredictableEvent
import vectoyaw
import vtos
import tv
import G_TouchSolids
import G_TouchTriggers
import G_EntitiesFree
import G_FreeEntity
import G_Sound
import G_TempEntity
import G_Spawn
import G_InitGentity
import G_SetMovedir
import G_UseTargets
import G_PickTarget
import G_Find
import G_KillBox
import G_TeamCommand
import G_SoundIndex
import G_ModelIndex
import SaveRegisteredItems
import RegisterItem
import ClearRegisteredItems
import Touch_Item
import ArmorIndex
import Think_Weapon
import FinishSpawningItem
import G_SpawnItem
import SetRespawn
import LaunchItem
import Drop_Item
import PrecacheItem
import UseHoldableItem
import SpawnTime
import RespawnItem
import G_RunItem
import G_CheckTeamItems
import G_RevertVote
import Cmd_FollowCycle_f
import SetTeam
import BroadcastTeamChange
import StopFollowing
import Cmd_Score_f
import G_NewString
import G_SpawnEntitiesFromString
import G_SpawnVector
import G_SpawnInt
import G_SpawnFloat
import G_SpawnString
import BigEndian
import replace1
import Q_stradd
import Q_strcpy
import BG_StripColor
import BG_CleanName
import DecodedString
import EncodedString
import strtok
import Q_stristr
import BG_sprintf
import BG_PlayerTouchesItem
import BG_PlayerStateToEntityStateExtraPolate
import BG_PlayerStateToEntityState
import BG_TouchJumpPad
import BG_AddPredictableEventToPlayerstate
import BG_EvaluateTrajectoryDelta
import BG_EvaluateTrajectory
import BG_CanItemBeGrabbed
import BG_FindItemForHoldable
import BG_FindItemForPowerup
import BG_FindItemForWeapon
import BG_FindItem
import bg_numItems
import bg_itemlist
import Pmove
import PM_UpdateViewAngles
import Com_Printf
import Com_Error
import Info_NextPair
import Info_ValidateKeyValue
import Info_Validate
import Info_SetValueForKey_Big
import Info_SetValueForKey
import Info_ValueForKey
import va
import Q_CleanStr
import Q_PrintStrlen
import Q_strcat
import Q_strncpyz
import Q_strrchr
import Q_strupr
import Q_strlwr
import Q_stricmpn
import Q_strncmp
import Q_stricmp
import Q_isalpha
import Q_isupper
import Q_islower
import Q_isprint
import locase
import Com_sprintf
import Parse3DMatrix
import Parse2DMatrix
import Parse1DMatrix
import SkipRestOfLine
import SkipBracedSection
import COM_MatchToken
import Com_Split
import COM_ParseSep
import Com_InitSeparators
import SkipTillSeparators
import COM_ParseWarning
import COM_ParseError
import COM_Compress
import COM_ParseExt
import COM_Parse
import COM_GetCurrentParseLine
import COM_BeginParseSession
import COM_DefaultExtension
import COM_StripExtension
import COM_SkipPath
import Com_Clamp
import PerpendicularVector
import AngleVectors
import MatrixMultiply
import MakeNormalVectors
import RotateAroundDirection
import RotatePointAroundVector
import ProjectPointOnPlane
import PlaneFromPoints
import AngleDelta
import AngleNormalize180
import AngleNormalize360
import AnglesSubtract
import AngleSubtract
import LerpAngle
import AngleMod
import BoxOnPlaneSide
import SetPlaneSignbits
import AxisCopy
import AxisClear
import AnglesToAxis
import vectoangles
import Q_crandom
import Q_random
import Q_rand
import Q_acos
import Q_log2
import VectorRotate
import Vector4Scale
import VectorNormalize2
import VectorNormalize
import CrossProduct
import VectorInverse
import VectorNormalizeFast
import DistanceSquared
import Distance
import VectorLengthSquared
import VectorLength
import VectorCompare
import AddPointToBounds
import ClearBounds
import RadiusFromBounds
import NormalizeColor
import ColorBytes4
import ColorBytes3
import _VectorMA
import _VectorScale
import _VectorCopy
import _VectorAdd
import _VectorSubtract
import _DotProduct
import ByteToDir
import DirToByte
import ClampShort
import ClampChar
import Q_rsqrt
import Q_fabs
import axisDefault
import vec3_origin
import g_color_table
import colorDkGrey
import colorMdGrey
import colorLtGrey
import colorWhite
import colorCyan
import colorMagenta
import colorYellow
import colorBlue
import colorGreen
import colorRed
import colorBlack
import bytedirs
import Hunk_Alloc
import acos
import fabs
import abs
import tan
import atan2
import cos
import sin
import sqrt
import floor
import ceil
import memcpy
import memset
import memmove
import Q_sscanf
import ED_vsprintf
import atoi
import atof
import toupper
import tolower
import strncpy
import strstr
import strchr
import strcmp
import strcpy
import strcat
import strlen
import rand
import srand
import qsort
lit
align 1
LABELV $3033
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 110
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $3030
byte 1 72
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 10
byte 1 0
align 1
LABELV $3027
byte 1 72
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 10
byte 1 0
align 1
LABELV $3022
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $3021
byte 1 79
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 10
byte 1 0
align 1
LABELV $3020
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 79
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $3017
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $3016
byte 1 79
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 10
byte 1 0
align 1
LABELV $3015
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 79
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $3010
byte 1 79
byte 1 110
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 67
byte 1 84
byte 1 70
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $3007
byte 1 79
byte 1 110
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 67
byte 1 84
byte 1 70
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $3004
byte 1 79
byte 1 110
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 67
byte 1 84
byte 1 70
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 78
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $2999
byte 1 67
byte 1 84
byte 1 70
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $2998
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $2995
byte 1 67
byte 1 84
byte 1 70
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $2994
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $2989
byte 1 50
byte 1 0
align 1
LABELV $2988
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $2987
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 111
byte 1 98
byte 1 115
byte 1 116
byte 1 97
byte 1 99
byte 1 108
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $2986
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 99
byte 1 104
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $2985
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 110
byte 1 111
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $2984
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 102
byte 1 97
byte 1 115
byte 1 116
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $2983
byte 1 48
byte 1 0
align 1
LABELV $2982
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2981
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $2980
byte 1 103
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $2933
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 101
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 65
byte 1 73
byte 1 32
byte 1 110
byte 1 111
byte 1 100
byte 1 101
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2922
byte 1 66
byte 1 111
byte 1 116
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 65
byte 1 73
byte 1 58
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2917
byte 1 66
byte 1 111
byte 1 116
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 65
byte 1 73
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 97
byte 1 105
byte 1 32
byte 1 110
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $2906
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $2902
byte 1 115
byte 1 101
byte 1 120
byte 1 0
align 1
LABELV $2886
byte 1 72
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 110
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 32
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 10
byte 1 0
align 1
LABELV $2885
byte 1 78
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 32
byte 1 79
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $2867
byte 1 110
byte 1 111
byte 1 32
byte 1 97
byte 1 108
byte 1 116
byte 1 32
byte 1 114
byte 1 111
byte 1 117
byte 1 116
byte 1 101
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 78
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $2866
byte 1 78
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $2827
byte 1 42
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $2824
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 69
byte 1 78
byte 1 69
byte 1 82
byte 1 65
byte 1 76
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 58
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 80
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 41
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2785
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $2782
byte 1 75
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $2781
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 107
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 101
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $2778
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 76
byte 1 79
byte 1 66
byte 1 65
byte 1 76
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 58
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 80
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 41
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2724
byte 1 66
byte 1 111
byte 1 116
byte 1 67
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 67
byte 1 111
byte 1 110
byte 1 115
byte 1 111
byte 1 108
byte 1 101
byte 1 77
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 115
byte 1 58
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 121
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $2717
byte 1 42
byte 1 42
byte 1 42
byte 1 42
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 121
byte 1 32
byte 1 42
byte 1 42
byte 1 42
byte 1 42
byte 1 10
byte 1 0
align 1
LABELV $2716
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 10
byte 1 0
align 1
LABELV $2713
byte 1 49
byte 1 0
align 1
LABELV $2712
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 114
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $2589
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 73
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $2588
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 73
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $2584
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 111
byte 1 70
byte 1 111
byte 1 114
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $2572
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $2571
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 114
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $2568
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2557
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 109
byte 1 117
byte 1 108
byte 1 116
byte 1 105
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2544
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2538
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $2530
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $2519
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2515
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2512
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $2479
byte 1 111
byte 1 114
byte 1 105
byte 1 103
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $2474
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $2469
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $2466
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2463
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2462
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2450
byte 1 42
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $2269
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $2246
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2243
byte 1 108
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $2205
byte 1 109
byte 1 112
byte 1 113
byte 1 51
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 54
byte 1 0
align 1
LABELV $2150
byte 1 113
byte 1 51
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 54
byte 1 0
align 1
LABELV $1232
byte 1 73
byte 1 110
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $1231
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1230
byte 1 66
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 83
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $1229
byte 1 82
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 101
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1228
byte 1 81
byte 1 117
byte 1 97
byte 1 100
byte 1 32
byte 1 68
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $1023
byte 1 66
byte 1 111
byte 1 116
byte 1 67
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 87
byte 1 97
byte 1 121
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 79
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 119
byte 1 97
byte 1 121
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $677
byte 1 119
byte 1 97
byte 1 110
byte 1 116
byte 1 111
byte 1 110
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $663
byte 1 119
byte 1 97
byte 1 110
byte 1 116
byte 1 111
byte 1 110
byte 1 111
byte 1 102
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $525
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $524
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 83
byte 1 107
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $520
byte 1 110
byte 1 0
align 1
LABELV $519
byte 1 91
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 93
byte 1 0
align 1
LABELV $518
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $232
byte 1 111
byte 1 110
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $207
byte 1 105
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $184
byte 1 110
byte 1 111
byte 1 0
align 1
LABELV $159
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $158
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $69
byte 1 116
byte 1 0
