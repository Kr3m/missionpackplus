export BotAI_Print
code
proc BotAI_Print 2056 12
file "../../../../code/game/ai_main.c"
line 75
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:/*****************************************************************************
;5: * name:		ai_main.c
;6: *
;7: * desc:		Quake3 bot AI
;8: *
;9: * $Archive: /MissionPack/code/game/ai_main.c $
;10: *
;11: *****************************************************************************/
;12:
;13:
;14:#include "g_local.h"
;15:#include "q_shared.h"
;16:#include "botlib.h"		//bot lib interface
;17:#include "be_aas.h"
;18:#include "be_ea.h"
;19:#include "be_ai_char.h"
;20:#include "be_ai_chat.h"
;21:#include "be_ai_gen.h"
;22:#include "be_ai_goal.h"
;23:#include "be_ai_move.h"
;24:#include "be_ai_weap.h"
;25://
;26:#include "ai_main.h"
;27:#include "ai_dmq3.h"
;28:#include "ai_chat.h"
;29:#include "ai_cmd.h"
;30:#include "ai_dmnet.h"
;31:#include "ai_vcmd.h"
;32:
;33://
;34:#include "chars.h"
;35:#include "inv.h"
;36:#include "syn.h"
;37:
;38:#define MAX_PATH		144
;39:
;40://bot states
;41:bot_state_t	*botstates[MAX_CLIENTS];
;42://number of bots
;43:int numbots;
;44://floating point time
;45:float floattime;
;46://time to do a regular update
;47:float regularupdate_time;
;48://
;49:int bot_interbreed;
;50:int bot_interbreedmatchcount;
;51://
;52:vmCvar_t bot_thinktime;
;53:vmCvar_t bot_memorydump;
;54:vmCvar_t bot_saveroutingcache;
;55:vmCvar_t bot_pause;
;56:vmCvar_t bot_report;
;57:vmCvar_t bot_testsolid;
;58:vmCvar_t bot_testclusters;
;59:vmCvar_t bot_developer;
;60:vmCvar_t bot_interbreedchar;
;61:vmCvar_t bot_interbreedbots;
;62:vmCvar_t bot_interbreedcycle;
;63:vmCvar_t bot_interbreedwrite;
;64:
;65:char mapname[MAX_QPATH];
;66:
;67:void ExitLevel( void );
;68:
;69:
;70:/*
;71:==================
;72:BotAI_Print
;73:==================
;74:*/
;75:void QDECL BotAI_Print( int type, const char *fmt, ... ) {
line 79
;76:	char str[2048];
;77:	va_list ap;
;78:
;79:	va_start(ap, fmt);
ADDRLP4 0
ADDRFP4 4+4
ASGNP4
line 80
;80:	ED_vsprintf(str, fmt, ap);
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ED_vsprintf
CALLI4
pop
line 81
;81:	va_end(ap);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 83
;82:
;83:	switch(type) {
ADDRLP4 2052
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 2052
INDIRI4
CNSTI4 1
LTI4 $57
ADDRLP4 2052
INDIRI4
CNSTI4 5
GTI4 $57
ADDRLP4 2052
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $70-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $70
address $59
address $61
address $63
address $65
address $67
code
LABELV $59
line 84
;84:		case PRT_MESSAGE: {
line 85
;85:			G_Printf("%s", str);
ADDRGP4 $60
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 86
;86:			break;
ADDRGP4 $58
JUMPV
LABELV $61
line 88
;87:		}
;88:		case PRT_WARNING: {
line 89
;89:			G_Printf( S_COLOR_YELLOW "Warning: %s", str );
ADDRGP4 $62
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 90
;90:			break;
ADDRGP4 $58
JUMPV
LABELV $63
line 92
;91:		}
;92:		case PRT_ERROR: {
line 93
;93:			G_Printf( S_COLOR_RED "Error: %s", str );
ADDRGP4 $64
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 94
;94:			break;
ADDRGP4 $58
JUMPV
LABELV $65
line 96
;95:		}
;96:		case PRT_FATAL: {
line 97
;97:			G_Printf( S_COLOR_RED "Fatal: %s", str );
ADDRGP4 $66
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 98
;98:			break;
ADDRGP4 $58
JUMPV
LABELV $67
line 100
;99:		}
;100:		case PRT_EXIT: {
line 101
;101:			G_Error( S_COLOR_RED "Exit: %s", str );
ADDRGP4 $68
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 102
;102:			break;
ADDRGP4 $58
JUMPV
LABELV $57
line 104
;103:		}
;104:		default: {
line 105
;105:			G_Printf( "unknown print type\n" );
ADDRGP4 $69
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 106
;106:			break;
LABELV $58
line 109
;107:		}
;108:	}
;109:}
LABELV $55
endproc BotAI_Print 2056 12
export BotAI_Trace
proc BotAI_Trace 56 28
line 117
;110:
;111:
;112:/*
;113:==================
;114:BotAI_Trace
;115:==================
;116:*/
;117:void BotAI_Trace(bsp_trace_t *bsptrace, vec3_t start, vec3_t mins, vec3_t maxs, vec3_t end, int passent, int contentmask) {
line 120
;118:	trace_t trace;
;119:
;120:	trap_Trace(&trace, start, mins, maxs, end, passent, contentmask);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 122
;121:	//copy the trace information
;122:	bsptrace->allsolid = trace.allsolid;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ASGNI4
line 123
;123:	bsptrace->startsolid = trace.startsolid;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0+4
INDIRI4
ASGNI4
line 124
;124:	bsptrace->fraction = trace.fraction;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0+8
INDIRF4
ASGNF4
line 125
;125:	VectorCopy(trace.endpos, bsptrace->endpos);
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 0+12
INDIRB
ASGNB 12
line 126
;126:	bsptrace->plane.dist = trace.plane.dist;
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0+24+12
INDIRF4
ASGNF4
line 127
;127:	VectorCopy(trace.plane.normal, bsptrace->plane.normal);
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 128
;128:	bsptrace->plane.signbits = trace.plane.signbits;
ADDRFP4 0
INDIRP4
CNSTI4 41
ADDP4
ADDRLP4 0+24+17
INDIRU1
ASGNU1
line 129
;129:	bsptrace->plane.type = trace.plane.type;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0+24+16
INDIRU1
ASGNU1
line 130
;130:	bsptrace->surface.value = 0;
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 131
;131:	bsptrace->surface.flags = trace.surfaceFlags;
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 0+44
INDIRI4
ASGNI4
line 132
;132:	bsptrace->ent = trace.entityNum;
ADDRFP4 0
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 0+52
INDIRI4
ASGNI4
line 133
;133:	bsptrace->exp_dist = 0;
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTF4 0
ASGNF4
line 134
;134:	bsptrace->sidenum = 0;
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 135
;135:	bsptrace->contents = trace.contents;
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 0+48
INDIRI4
ASGNI4
line 136
;136:}
LABELV $72
endproc BotAI_Trace 56 28
export BotAI_GetClientState
proc BotAI_GetClientState 4 12
line 143
;137:
;138:/*
;139:==================
;140:BotAI_GetClientState
;141:==================
;142:*/
;143:int BotAI_GetClientState( int clientNum, playerState_t *state ) {
line 146
;144:	gentity_t	*ent;
;145:
;146:	ent = &g_entities[clientNum];
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 147
;147:	if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $87
line 148
;148:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $86
JUMPV
LABELV $87
line 150
;149:	}
;150:	if ( !ent->client ) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $89
line 151
;151:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $86
JUMPV
LABELV $89
line 154
;152:	}
;153:
;154:	memcpy( state, &ent->client->ps, sizeof(playerState_t) );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
CNSTU4 468
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 155
;155:	return qtrue;
CNSTI4 1
RETI4
LABELV $86
endproc BotAI_GetClientState 4 12
export BotAI_GetEntityState
proc BotAI_GetEntityState 8 12
line 164
;156:}
;157:
;158:
;159:/*
;160:==================
;161:BotAI_GetEntityState
;162:==================
;163:*/
;164:qboolean BotAI_GetEntityState( int entityNum, entityState_t *state ) {
line 167
;165:	const gentity_t *ent;
;166:
;167:	ent = g_entities + entityNum;
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 169
;168:
;169:	if ( !ent->inuse || !ent->r.linked ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $94
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
NEI4 $92
LABELV $94
line 170
;170:		memset( state, 0, sizeof( entityState_t ) );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 208
ARGU4
ADDRGP4 memset
CALLP4
pop
line 171
;171:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $91
JUMPV
LABELV $92
line 174
;172:	}
;173:
;174:	if ( ent->r.svFlags & SVF_NOCLIENT ) {
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $95
line 175
;175:		memset( state, 0, sizeof( entityState_t ) );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 208
ARGU4
ADDRGP4 memset
CALLP4
pop
line 176
;176:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $91
JUMPV
LABELV $95
line 179
;177:	}
;178:
;179:	memcpy( state, &ent->s, sizeof(entityState_t) );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTU4 208
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 180
;180:	return qtrue;
CNSTI4 1
RETI4
LABELV $91
endproc BotAI_GetEntityState 8 12
export BotAI_GetSnapshotEntity
proc BotAI_GetSnapshotEntity 8 12
line 189
;181:}
;182:
;183:
;184:/*
;185:==================
;186:BotAI_GetSnapshotEntity
;187:==================
;188:*/
;189:int BotAI_GetSnapshotEntity( int clientNum, int sequence, entityState_t *state ) {
line 192
;190:	int		entNum;
;191:
;192:	entNum = trap_BotGetSnapshotEntity( clientNum, sequence );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 trap_BotGetSnapshotEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 193
;193:	if ( entNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $98
line 194
;194:		memset(state, 0, sizeof(entityState_t));
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 208
ARGU4
ADDRGP4 memset
CALLP4
pop
line 195
;195:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $97
JUMPV
LABELV $98
line 198
;196:	}
;197:
;198:	BotAI_GetEntityState( entNum, state );
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 BotAI_GetEntityState
CALLI4
pop
line 200
;199:
;200:	return sequence + 1;
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
RETI4
LABELV $97
endproc BotAI_GetSnapshotEntity 8 12
export BotAI_BotInitialChat
proc BotAI_BotInitialChat 56 44
line 209
;201:}
;202:
;203:
;204:/*
;205:==================
;206:BotAI_BotInitialChat
;207:==================
;208:*/
;209:void QDECL BotAI_BotInitialChat( bot_state_t *bs, char *type, ... ) {
line 215
;210:	int		i, mcontext;
;211:	va_list	ap;
;212:	char	*p;
;213:	char	*vars[MAX_MATCHVARIABLES];
;214:
;215:	memset(vars, 0, sizeof(vars));
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
CNSTU4 32
ARGU4
ADDRGP4 memset
CALLP4
pop
line 216
;216:	va_start(ap, type);
ADDRLP4 40
ADDRFP4 4+4
ASGNP4
line 217
;217:	p = va_arg(ap, char *);
ADDRLP4 48
ADDRLP4 40
INDIRP4
CNSTU4 4
ADDP4
ASGNP4
ADDRLP4 40
ADDRLP4 48
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 48
INDIRP4
CNSTI4 -4
ADDP4
INDIRP4
ASGNP4
line 218
;218:	for (i = 0; i < MAX_MATCHVARIABLES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $102
line 219
;219:		if( !p ) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $106
line 220
;220:			break;
ADDRGP4 $104
JUMPV
LABELV $106
line 222
;221:		}
;222:		vars[i] = p;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 223
;223:		p = va_arg(ap, char *);
ADDRLP4 52
ADDRLP4 40
INDIRP4
CNSTU4 4
ADDP4
ASGNP4
ADDRLP4 40
ADDRLP4 52
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 52
INDIRP4
CNSTI4 -4
ADDP4
INDIRP4
ASGNP4
line 224
;224:	}
LABELV $103
line 218
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $102
LABELV $104
line 225
;225:	va_end(ap);
ADDRLP4 40
CNSTP4 0
ASGNP4
line 227
;226:
;227:	mcontext = BotSynonymContext(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 BotSynonymContext
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 52
INDIRI4
ASGNI4
line 229
;228:
;229:	trap_BotInitialChat( bs->cs, type, mcontext, vars[0], vars[1], vars[2], vars[3], vars[4], vars[5], vars[6], vars[7] );
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8+4
INDIRP4
ARGP4
ADDRLP4 8+8
INDIRP4
ARGP4
ADDRLP4 8+12
INDIRP4
ARGP4
ADDRLP4 8+16
INDIRP4
ARGP4
ADDRLP4 8+20
INDIRP4
ARGP4
ADDRLP4 8+24
INDIRP4
ARGP4
ADDRLP4 8+28
INDIRP4
ARGP4
ADDRGP4 trap_BotInitialChat
CALLV
pop
line 230
;230:}
LABELV $100
endproc BotAI_BotInitialChat 56 44
export BotTestAAS
proc BotTestAAS 64 16
line 238
;231:
;232:
;233:/*
;234:==================
;235:BotTestAAS
;236:==================
;237:*/
;238:void BotTestAAS(vec3_t origin) {
line 242
;239:	int areanum;
;240:	aas_areainfo_t info;
;241:
;242:	trap_Cvar_Update(&bot_testsolid);
ADDRGP4 bot_testsolid
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 243
;243:	trap_Cvar_Update(&bot_testclusters);
ADDRGP4 bot_testclusters
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 244
;244:	if (bot_testsolid.integer) {
ADDRGP4 bot_testsolid+12
INDIRI4
CNSTI4 0
EQI4 $116
line 245
;245:		if (!trap_AAS_Initialized()) return;
ADDRLP4 56
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $119
ADDRGP4 $115
JUMPV
LABELV $119
line 246
;246:		areanum = BotPointAreaNum(origin);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 60
INDIRI4
ASGNI4
line 247
;247:		if (areanum) BotAI_Print(PRT_MESSAGE, "\rempty area");
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $121
CNSTI4 1
ARGI4
ADDRGP4 $123
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
ADDRGP4 $117
JUMPV
LABELV $121
line 248
;248:		else BotAI_Print(PRT_MESSAGE, "\r^1SOLID area");
CNSTI4 1
ARGI4
ADDRGP4 $124
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 249
;249:	}
ADDRGP4 $117
JUMPV
LABELV $116
line 250
;250:	else if (bot_testclusters.integer) {
ADDRGP4 bot_testclusters+12
INDIRI4
CNSTI4 0
EQI4 $125
line 251
;251:		if (!trap_AAS_Initialized()) return;
ADDRLP4 56
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $128
ADDRGP4 $115
JUMPV
LABELV $128
line 252
;252:		areanum = BotPointAreaNum(origin);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 60
INDIRI4
ASGNI4
line 253
;253:		if (!areanum)
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $130
line 254
;254:			BotAI_Print(PRT_MESSAGE, "\r^1Solid!                              ");
CNSTI4 1
ARGI4
ADDRGP4 $132
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
ADDRGP4 $131
JUMPV
LABELV $130
line 255
;255:		else {
line 256
;256:			trap_AAS_AreaInfo(areanum, &info);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_AAS_AreaInfo
CALLI4
pop
line 257
;257:			BotAI_Print(PRT_MESSAGE, "\rarea %d, cluster %d       ", areanum, info.cluster);
CNSTI4 1
ARGI4
ADDRGP4 $133
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4+12
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 258
;258:		}
LABELV $131
line 259
;259:	}
LABELV $125
LABELV $117
line 260
;260:}
LABELV $115
endproc BotTestAAS 64 16
export BotReportStatus
proc BotReportStatus 560 24
line 267
;261:
;262:/*
;263:==================
;264:BotReportStatus
;265:==================
;266:*/
;267:void BotReportStatus(bot_state_t *bs) {
line 272
;268:	char goalname[MAX_MESSAGE_SIZE];
;269:	char netname[MAX_MESSAGE_SIZE];
;270:	char *leader, flagstatus[32];
;271:	//
;272:	ClientName(bs->client, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 273
;273:	if (Q_stricmp(netname, bs->teamleader) == 0) leader = "L";
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 548
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 548
INDIRI4
CNSTI4 0
NEI4 $136
ADDRLP4 288
ADDRGP4 $138
ASGNP4
ADDRGP4 $137
JUMPV
LABELV $136
line 274
;274:	else leader = " ";
ADDRLP4 288
ADDRGP4 $139
ASGNP4
LABELV $137
line 276
;275:
;276:	strcpy(flagstatus, "  ");
ADDRLP4 256
ARGP4
ADDRGP4 $140
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 277
;277:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $141
line 278
;278:		if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 552
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 552
INDIRI4
CNSTI4 0
EQI4 $142
line 279
;279:			if (BotTeam(bs) == TEAM_RED) strcpy(flagstatus, S_COLOR_RED"F ");
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 556
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 556
INDIRI4
CNSTI4 1
NEI4 $145
ADDRLP4 256
ARGP4
ADDRGP4 $147
ARGP4
ADDRGP4 strcpy
CALLP4
pop
ADDRGP4 $142
JUMPV
LABELV $145
line 280
;280:			else strcpy(flagstatus, S_COLOR_BLUE"F ");
ADDRLP4 256
ARGP4
ADDRGP4 $148
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 281
;281:		}
line 282
;282:	}
ADDRGP4 $142
JUMPV
LABELV $141
line 284
;283:#ifdef MISSIONPACK
;284:	else if (gametype == GT_1FCTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $149
line 285
;285:		if (Bot1FCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 552
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 552
INDIRI4
CNSTI4 0
EQI4 $150
line 286
;286:			if (BotTeam(bs) == TEAM_RED) strcpy(flagstatus, S_COLOR_RED"F ");
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 556
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 556
INDIRI4
CNSTI4 1
NEI4 $153
ADDRLP4 256
ARGP4
ADDRGP4 $147
ARGP4
ADDRGP4 strcpy
CALLP4
pop
ADDRGP4 $150
JUMPV
LABELV $153
line 287
;287:			else strcpy(flagstatus, S_COLOR_BLUE"F ");
ADDRLP4 256
ARGP4
ADDRGP4 $148
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 288
;288:		}
line 289
;289:	}
ADDRGP4 $150
JUMPV
LABELV $149
line 290
;290:	else if (gametype == GT_HARVESTER) {
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $155
line 291
;291:		if (BotHarvesterCarryingCubes(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 552
ADDRGP4 BotHarvesterCarryingCubes
CALLI4
ASGNI4
ADDRLP4 552
INDIRI4
CNSTI4 0
EQI4 $157
line 292
;292:			if (BotTeam(bs) == TEAM_RED) Com_sprintf(flagstatus, sizeof(flagstatus), S_COLOR_RED"%2d", bs->inventory[INVENTORY_REDCUBE]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 556
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 556
INDIRI4
CNSTI4 1
NEI4 $159
ADDRLP4 256
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $161
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 5144
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
ADDRGP4 $160
JUMPV
LABELV $159
line 293
;293:			else Com_sprintf(flagstatus, sizeof(flagstatus), S_COLOR_BLUE"%2d", bs->inventory[INVENTORY_BLUECUBE]);
ADDRLP4 256
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $162
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 5148
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
LABELV $160
line 294
;294:		}
LABELV $157
line 295
;295:	}
LABELV $155
LABELV $150
LABELV $142
line 298
;296:#endif
;297:
;298:	switch(bs->ltgtype) {
ADDRLP4 552
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
ADDRLP4 552
INDIRI4
CNSTI4 1
LTI4 $163
ADDRLP4 552
INDIRI4
CNSTI4 13
GTI4 $163
ADDRLP4 552
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $191-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $191
address $166
address $168
address $170
address $180
address $182
address $184
address $176
address $176
address $178
address $172
address $174
address $188
address $186
code
LABELV $166
line 300
;299:		case LTG_TEAMHELP:
;300:		{
line 301
;301:			EasyClientName(bs->teammate, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 302
;302:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: helping %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $167
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 303
;303:			break;
ADDRGP4 $164
JUMPV
LABELV $168
line 306
;304:		}
;305:		case LTG_TEAMACCOMPANY:
;306:		{
line 307
;307:			EasyClientName(bs->teammate, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 308
;308:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: accompanying %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $169
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 309
;309:			break;
ADDRGP4 $164
JUMPV
LABELV $170
line 312
;310:		}
;311:		case LTG_DEFENDKEYAREA:
;312:		{
line 313
;313:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6668
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 314
;314:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: defending %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $171
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 315
;315:			break;
ADDRGP4 $164
JUMPV
LABELV $172
line 318
;316:		}
;317:		case LTG_GETITEM:
;318:		{
line 319
;319:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6668
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 320
;320:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: getting item %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $173
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 321
;321:			break;
ADDRGP4 $164
JUMPV
LABELV $174
line 324
;322:		}
;323:		case LTG_KILL:
;324:		{
line 325
;325:			ClientName(bs->teamgoal.entitynum, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6664
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 326
;326:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: killing %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $175
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 327
;327:			break;
ADDRGP4 $164
JUMPV
LABELV $176
line 331
;328:		}
;329:		case LTG_CAMP:
;330:		case LTG_CAMPORDER:
;331:		{
line 332
;332:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: camping\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $177
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 333
;333:			break;
ADDRGP4 $164
JUMPV
LABELV $178
line 336
;334:		}
;335:		case LTG_PATROL:
;336:		{
line 337
;337:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: patrolling\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $179
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 338
;338:			break;
ADDRGP4 $164
JUMPV
LABELV $180
line 341
;339:		}
;340:		case LTG_GETFLAG:
;341:		{
line 342
;342:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: capturing flag\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $181
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 343
;343:			break;
ADDRGP4 $164
JUMPV
LABELV $182
line 346
;344:		}
;345:		case LTG_RUSHBASE:
;346:		{
line 347
;347:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: rushing base\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $183
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 348
;348:			break;
ADDRGP4 $164
JUMPV
LABELV $184
line 351
;349:		}
;350:		case LTG_RETURNFLAG:
;351:		{
line 352
;352:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: returning flag\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $185
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 353
;353:			break;
ADDRGP4 $164
JUMPV
LABELV $186
line 356
;354:		}
;355:		case LTG_ATTACKENEMYBASE:
;356:		{
line 357
;357:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: attacking the enemy base\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $187
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 358
;358:			break;
ADDRGP4 $164
JUMPV
LABELV $188
line 361
;359:		}
;360:		case LTG_HARVEST:
;361:		{
line 362
;362:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: harvesting\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $189
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 363
;363:			break;
ADDRGP4 $164
JUMPV
LABELV $163
line 366
;364:		}
;365:		default:
;366:		{
line 367
;367:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: roaming\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $190
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 368
;368:			break;
LABELV $164
line 371
;369:		}
;370:	}
;371:}
LABELV $135
endproc BotReportStatus 560 24
export BotTeamplayReport
proc BotTeamplayReport 1048 12
line 378
;372:
;373:/*
;374:==================
;375:BotTeamplayReport
;376:==================
;377:*/
;378:void BotTeamplayReport(void) {
line 382
;379:	int i;
;380:	char buf[MAX_INFO_STRING];
;381:
;382:	BotAI_Print(PRT_MESSAGE, S_COLOR_RED"RED\n");
CNSTI4 1
ARGI4
ADDRGP4 $194
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 383
;383:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $198
JUMPV
LABELV $195
line 385
;384:		//
;385:		if ( !botstates[i] || !botstates[i]->inuse ) continue;
ADDRLP4 1032
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1032
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $202
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1032
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $200
LABELV $202
ADDRGP4 $196
JUMPV
LABELV $200
line 387
;386:		//
;387:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
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
line 389
;388:		//if no config string or no name
;389:		if (!buf[0] || !*Info_ValueForKey(buf, "n")) continue;
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $206
ADDRLP4 4
ARGP4
ADDRGP4 $205
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $203
LABELV $206
ADDRGP4 $196
JUMPV
LABELV $203
line 391
;390:		//skip spectators
;391:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_RED) {
ADDRLP4 4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 1040
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1044
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 1
NEI4 $207
line 392
;392:			BotReportStatus(botstates[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotReportStatus
CALLV
pop
line 393
;393:		}
LABELV $207
line 394
;394:	}
LABELV $196
line 383
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $198
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $195
line 395
;395:	BotAI_Print(PRT_MESSAGE, S_COLOR_BLUE"BLUE\n");
CNSTI4 1
ARGI4
ADDRGP4 $210
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 396
;396:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $214
JUMPV
LABELV $211
line 398
;397:		//
;398:		if ( !botstates[i] || !botstates[i]->inuse ) continue;
ADDRLP4 1032
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1032
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $218
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1032
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $216
LABELV $218
ADDRGP4 $212
JUMPV
LABELV $216
line 400
;399:		//
;400:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
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
line 402
;401:		//if no config string or no name
;402:		if (!buf[0] || !*Info_ValueForKey(buf, "n")) continue;
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $221
ADDRLP4 4
ARGP4
ADDRGP4 $205
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $219
LABELV $221
ADDRGP4 $212
JUMPV
LABELV $219
line 404
;403:		//skip spectators
;404:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_BLUE) {
ADDRLP4 4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 1040
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1044
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 2
NEI4 $222
line 405
;405:			BotReportStatus(botstates[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotReportStatus
CALLV
pop
line 406
;406:		}
LABELV $222
line 407
;407:	}
LABELV $212
line 396
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $214
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $211
line 408
;408:}
LABELV $193
endproc BotTeamplayReport 1048 12
export BotSetInfoConfigString
proc BotSetInfoConfigString 880 16
line 415
;409:
;410:/*
;411:==================
;412:BotSetInfoConfigString
;413:==================
;414:*/
;415:void BotSetInfoConfigString(bot_state_t *bs) {
line 422
;416:	char goalname[MAX_MESSAGE_SIZE];
;417:	char netname[MAX_MESSAGE_SIZE];
;418:	char action[MAX_MESSAGE_SIZE];
;419:	char *leader, carrying[32], *cs;
;420:	bot_goal_t goal;
;421:	//
;422:	ClientName(bs->client, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 256
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 423
;423:	if (Q_stricmp(netname, bs->teamleader) == 0) leader = "L";
ADDRLP4 256
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 864
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 864
INDIRI4
CNSTI4 0
NEI4 $225
ADDRLP4 544
ADDRGP4 $138
ASGNP4
ADDRGP4 $226
JUMPV
LABELV $225
line 424
;424:	else leader = " ";
ADDRLP4 544
ADDRGP4 $139
ASGNP4
LABELV $226
line 426
;425:
;426:	strcpy(carrying, "  ");
ADDRLP4 512
ARGP4
ADDRGP4 $140
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 427
;427:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $227
line 428
;428:		if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 868
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 868
INDIRI4
CNSTI4 0
EQI4 $228
line 429
;429:			strcpy(carrying, "F ");
ADDRLP4 512
ARGP4
ADDRGP4 $231
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 430
;430:		}
line 431
;431:	}
ADDRGP4 $228
JUMPV
LABELV $227
line 433
;432:#ifdef MISSIONPACK
;433:	else if (gametype == GT_1FCTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $232
line 434
;434:		if (Bot1FCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 868
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 868
INDIRI4
CNSTI4 0
EQI4 $233
line 435
;435:			strcpy(carrying, "F ");
ADDRLP4 512
ARGP4
ADDRGP4 $231
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 436
;436:		}
line 437
;437:	}
ADDRGP4 $233
JUMPV
LABELV $232
line 438
;438:	else if (gametype == GT_HARVESTER) {
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $236
line 439
;439:		if (BotHarvesterCarryingCubes(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 868
ADDRGP4 BotHarvesterCarryingCubes
CALLI4
ASGNI4
ADDRLP4 868
INDIRI4
CNSTI4 0
EQI4 $238
line 440
;440:			if (BotTeam(bs) == TEAM_RED) Com_sprintf(carrying, sizeof(carrying), "%2d", bs->inventory[INVENTORY_REDCUBE]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 872
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 872
INDIRI4
CNSTI4 1
NEI4 $240
ADDRLP4 512
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $242
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 5144
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
ADDRGP4 $241
JUMPV
LABELV $240
line 441
;441:			else Com_sprintf(carrying, sizeof(carrying), "%2d", bs->inventory[INVENTORY_BLUECUBE]);
ADDRLP4 512
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $242
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 5148
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
LABELV $241
line 442
;442:		}
LABELV $238
line 443
;443:	}
LABELV $236
LABELV $233
LABELV $228
line 446
;444:#endif
;445:
;446:	switch(bs->ltgtype) {
ADDRLP4 868
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
ADDRLP4 868
INDIRI4
CNSTI4 1
LTI4 $243
ADDRLP4 868
INDIRI4
CNSTI4 13
GTI4 $243
ADDRLP4 868
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $272-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $272
address $246
address $248
address $250
address $260
address $262
address $264
address $256
address $256
address $258
address $252
address $254
address $268
address $266
code
LABELV $246
line 448
;447:		case LTG_TEAMHELP:
;448:		{
line 449
;449:			EasyClientName(bs->teammate, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 450
;450:			Com_sprintf(action, sizeof(action), "helping %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $247
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 451
;451:			break;
ADDRGP4 $244
JUMPV
LABELV $248
line 454
;452:		}
;453:		case LTG_TEAMACCOMPANY:
;454:		{
line 455
;455:			EasyClientName(bs->teammate, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 456
;456:			Com_sprintf(action, sizeof(action), "accompanying %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $249
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 457
;457:			break;
ADDRGP4 $244
JUMPV
LABELV $250
line 460
;458:		}
;459:		case LTG_DEFENDKEYAREA:
;460:		{
line 461
;461:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6668
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 462
;462:			Com_sprintf(action, sizeof(action), "defending %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $251
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 463
;463:			break;
ADDRGP4 $244
JUMPV
LABELV $252
line 466
;464:		}
;465:		case LTG_GETITEM:
;466:		{
line 467
;467:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6668
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 468
;468:			Com_sprintf(action, sizeof(action), "getting item %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $253
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 469
;469:			break;
ADDRGP4 $244
JUMPV
LABELV $254
line 472
;470:		}
;471:		case LTG_KILL:
;472:		{
line 473
;473:			ClientName(bs->teamgoal.entitynum, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6664
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 474
;474:			Com_sprintf(action, sizeof(action), "killing %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $255
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 475
;475:			break;
ADDRGP4 $244
JUMPV
LABELV $256
line 479
;476:		}
;477:		case LTG_CAMP:
;478:		case LTG_CAMPORDER:
;479:		{
line 480
;480:			Com_sprintf(action, sizeof(action), "camping");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $257
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 481
;481:			break;
ADDRGP4 $244
JUMPV
LABELV $258
line 484
;482:		}
;483:		case LTG_PATROL:
;484:		{
line 485
;485:			Com_sprintf(action, sizeof(action), "patrolling");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $259
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 486
;486:			break;
ADDRGP4 $244
JUMPV
LABELV $260
line 489
;487:		}
;488:		case LTG_GETFLAG:
;489:		{
line 490
;490:			Com_sprintf(action, sizeof(action), "capturing flag");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $261
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 491
;491:			break;
ADDRGP4 $244
JUMPV
LABELV $262
line 494
;492:		}
;493:		case LTG_RUSHBASE:
;494:		{
line 495
;495:			Com_sprintf(action, sizeof(action), "rushing base");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $263
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 496
;496:			break;
ADDRGP4 $244
JUMPV
LABELV $264
line 499
;497:		}
;498:		case LTG_RETURNFLAG:
;499:		{
line 500
;500:			Com_sprintf(action, sizeof(action), "returning flag");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $265
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 501
;501:			break;
ADDRGP4 $244
JUMPV
LABELV $266
line 504
;502:		}
;503:		case LTG_ATTACKENEMYBASE:
;504:		{
line 505
;505:			Com_sprintf(action, sizeof(action), "attacking the enemy base");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $267
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 506
;506:			break;
ADDRGP4 $244
JUMPV
LABELV $268
line 509
;507:		}
;508:		case LTG_HARVEST:
;509:		{
line 510
;510:			Com_sprintf(action, sizeof(action), "harvesting");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $269
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 511
;511:			break;
ADDRGP4 $244
JUMPV
LABELV $243
line 514
;512:		}
;513:		default:
;514:		{
line 515
;515:			trap_BotGetTopGoal(bs->gs, &goal);
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRLP4 808
ARGP4
ADDRGP4 trap_BotGetTopGoal
CALLI4
pop
line 516
;516:			trap_BotGoalName(goal.number, goalname, sizeof(goalname));
ADDRLP4 808+44
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 517
;517:			Com_sprintf(action, sizeof(action), "roaming %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $271
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 518
;518:			break;
LABELV $244
line 521
;519:		}
;520:	}
;521:  	cs = va("l\\%s\\c\\%s\\a\\%s",
ADDRGP4 $274
ARGP4
ADDRLP4 544
INDIRP4
ARGP4
ADDRLP4 512
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 876
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 548
ADDRLP4 876
INDIRP4
ASGNP4
line 525
;522:				leader,
;523:				carrying,
;524:				action);
;525:  	trap_SetConfigstring (CS_BOTINFO + bs->client, cs);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 25
ADDI4
ARGI4
ADDRLP4 548
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 526
;526:}
LABELV $224
endproc BotSetInfoConfigString 880 16
export BotUpdateInfoConfigStrings
proc BotUpdateInfoConfigStrings 1040 12
line 533
;527:
;528:/*
;529:==============
;530:BotUpdateInfoConfigStrings
;531:==============
;532:*/
;533:void BotUpdateInfoConfigStrings(void) {
line 537
;534:	int i;
;535:	char buf[MAX_INFO_STRING];
;536:
;537:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $279
JUMPV
LABELV $276
line 539
;538:		//
;539:		if ( !botstates[i] || !botstates[i]->inuse )
ADDRLP4 1032
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1032
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $283
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1032
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $281
LABELV $283
line 540
;540:			continue;
ADDRGP4 $277
JUMPV
LABELV $281
line 542
;541:		//
;542:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
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
line 544
;543:		//if no config string or no name
;544:		if (!buf[0] || !*Info_ValueForKey(buf, "n"))
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $286
ADDRLP4 4
ARGP4
ADDRGP4 $205
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $284
LABELV $286
line 545
;545:			continue;
ADDRGP4 $277
JUMPV
LABELV $284
line 546
;546:		BotSetInfoConfigString(botstates[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotSetInfoConfigString
CALLV
pop
line 547
;547:	}
LABELV $277
line 537
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $279
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $276
line 548
;548:}
LABELV $275
endproc BotUpdateInfoConfigStrings 1040 12
export BotInterbreedBots
proc BotInterbreedBots 288 20
line 555
;549:
;550:/*
;551:==============
;552:BotInterbreedBots
;553:==============
;554:*/
;555:void BotInterbreedBots(void) {
line 561
;556:	float ranks[MAX_CLIENTS];
;557:	int parent1, parent2, child;
;558:	int i;
;559:
;560:	// get rankings for all the bots
;561:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $288
line 562
;562:		if ( botstates[i] && botstates[i]->inuse ) {
ADDRLP4 276
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 276
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $292
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 276
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $292
line 563
;563:			ranks[i] = botstates[i]->num_kills * 2 - botstates[i]->num_deaths;
ADDRLP4 284
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 284
INDIRP4
ADDP4
INDIRP4
CNSTI4 6032
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 284
INDIRP4
ADDP4
INDIRP4
CNSTI4 6028
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 564
;564:		}
ADDRGP4 $293
JUMPV
LABELV $292
line 565
;565:		else {
line 566
;566:			ranks[i] = -1;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 3212836864
ASGNF4
line 567
;567:		}
LABELV $293
line 568
;568:	}
LABELV $289
line 561
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $288
line 570
;569:
;570:	if (trap_GeneticParentsAndChildSelection(MAX_CLIENTS, ranks, &parent1, &parent2, &child)) {
CNSTI4 64
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 264
ARGP4
ADDRLP4 268
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 272
ADDRGP4 trap_GeneticParentsAndChildSelection
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
EQI4 $294
line 571
;571:		trap_BotInterbreedGoalFuzzyLogic(botstates[parent1]->gs, botstates[parent2]->gs, botstates[child]->gs);
ADDRLP4 276
ADDRGP4 botstates
ASGNP4
ADDRLP4 264
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 276
INDIRP4
ADDP4
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRLP4 268
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 276
INDIRP4
ADDP4
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 276
INDIRP4
ADDP4
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotInterbreedGoalFuzzyLogic
CALLV
pop
line 572
;572:		trap_BotMutateGoalFuzzyLogic(botstates[child]->gs, 1);
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_BotMutateGoalFuzzyLogic
CALLV
pop
line 573
;573:	}
LABELV $294
line 575
;574:	// reset the kills and deaths
;575:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $296
line 576
;576:		if (botstates[i] && botstates[i]->inuse) {
ADDRLP4 280
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 280
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $300
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 280
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $300
line 577
;577:			botstates[i]->num_kills = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 6032
ADDP4
CNSTI4 0
ASGNI4
line 578
;578:			botstates[i]->num_deaths = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 6028
ADDP4
CNSTI4 0
ASGNI4
line 579
;579:		}
LABELV $300
line 580
;580:	}
LABELV $297
line 575
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $296
line 581
;581:}
LABELV $287
endproc BotInterbreedBots 288 20
export BotWriteInterbreeded
proc BotWriteInterbreeded 32 8
line 588
;582:
;583:/*
;584:==============
;585:BotWriteInterbreeded
;586:==============
;587:*/
;588:void BotWriteInterbreeded(char *filename) {
line 592
;589:	float rank, bestrank;
;590:	int i, bestbot;
;591:
;592:	bestrank = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 593
;593:	bestbot = -1;
ADDRLP4 12
CNSTI4 -1
ASGNI4
line 595
;594:	// get the best bot
;595:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $303
line 596
;596:		if ( botstates[i] && botstates[i]->inuse ) {
ADDRLP4 20
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $307
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $307
line 597
;597:			rank = botstates[i]->num_kills * 2 - botstates[i]->num_deaths;
ADDRLP4 28
ADDRGP4 botstates
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 28
INDIRP4
ADDP4
INDIRP4
CNSTI4 6032
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 28
INDIRP4
ADDP4
INDIRP4
CNSTI4 6028
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 598
;598:		}
ADDRGP4 $308
JUMPV
LABELV $307
line 599
;599:		else {
line 600
;600:			rank = -1;
ADDRLP4 4
CNSTF4 3212836864
ASGNF4
line 601
;601:		}
LABELV $308
line 602
;602:		if (rank > bestrank) {
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $309
line 603
;603:			bestrank = rank;
ADDRLP4 8
ADDRLP4 4
INDIRF4
ASGNF4
line 604
;604:			bestbot = i;
ADDRLP4 12
ADDRLP4 0
INDIRI4
ASGNI4
line 605
;605:		}
LABELV $309
line 606
;606:	}
LABELV $304
line 595
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $303
line 607
;607:	if (bestbot >= 0) {
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $311
line 609
;608:		//write out the new goal fuzzy logic
;609:		trap_BotSaveGoalFuzzyLogic(botstates[bestbot]->gs, filename);
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_BotSaveGoalFuzzyLogic
CALLV
pop
line 610
;610:	}
LABELV $311
line 611
;611:}
LABELV $302
endproc BotWriteInterbreeded 32 8
export BotInterbreedEndMatch
proc BotInterbreedEndMatch 8 8
line 620
;612:
;613:/*
;614:==============
;615:BotInterbreedEndMatch
;616:
;617:add link back into ExitLevel?
;618:==============
;619:*/
;620:void BotInterbreedEndMatch(void) {
line 622
;621:
;622:	if (!bot_interbreed) return;
ADDRGP4 bot_interbreed
INDIRI4
CNSTI4 0
NEI4 $314
ADDRGP4 $313
JUMPV
LABELV $314
line 623
;623:	bot_interbreedmatchcount++;
ADDRLP4 0
ADDRGP4 bot_interbreedmatchcount
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 624
;624:	if (bot_interbreedmatchcount >= bot_interbreedcycle.integer) {
ADDRGP4 bot_interbreedmatchcount
INDIRI4
ADDRGP4 bot_interbreedcycle+12
INDIRI4
LTI4 $316
line 625
;625:		bot_interbreedmatchcount = 0;
ADDRGP4 bot_interbreedmatchcount
CNSTI4 0
ASGNI4
line 627
;626:		//
;627:		trap_Cvar_Update(&bot_interbreedwrite);
ADDRGP4 bot_interbreedwrite
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 628
;628:		if (strlen(bot_interbreedwrite.string)) {
ADDRGP4 bot_interbreedwrite+16
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 4
INDIRU4
CNSTU4 0
EQU4 $319
line 629
;629:			BotWriteInterbreeded(bot_interbreedwrite.string);
ADDRGP4 bot_interbreedwrite+16
ARGP4
ADDRGP4 BotWriteInterbreeded
CALLV
pop
line 630
;630:			trap_Cvar_Set("bot_interbreedwrite", "");
ADDRGP4 $323
ARGP4
ADDRGP4 $324
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 631
;631:		}
LABELV $319
line 632
;632:		BotInterbreedBots();
ADDRGP4 BotInterbreedBots
CALLV
pop
line 633
;633:	}
LABELV $316
line 634
;634:}
LABELV $313
endproc BotInterbreedEndMatch 8 8
export BotInterbreeding
proc BotInterbreeding 16 20
line 641
;635:
;636:/*
;637:==============
;638:BotInterbreeding
;639:==============
;640:*/
;641:void BotInterbreeding(void) {
line 644
;642:	int i;
;643:
;644:	trap_Cvar_Update(&bot_interbreedchar);
ADDRGP4 bot_interbreedchar
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 645
;645:	if (!strlen(bot_interbreedchar.string)) return;
ADDRGP4 bot_interbreedchar+16
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 4
INDIRU4
CNSTU4 0
NEU4 $326
ADDRGP4 $325
JUMPV
LABELV $326
line 647
;646:	//make sure we are in tournament mode
;647:	if (gametype != GT_TOURNAMENT) {
ADDRGP4 gametype
INDIRI4
CNSTI4 1
EQI4 $329
line 648
;648:		trap_Cvar_Set("g_gametype", va("%d", GT_TOURNAMENT));
ADDRGP4 $332
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $331
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 649
;649:		ExitLevel();
ADDRGP4 ExitLevel
CALLV
pop
line 650
;650:		return;
ADDRGP4 $325
JUMPV
LABELV $329
line 653
;651:	}
;652:	//shutdown all the bots
;653:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $336
JUMPV
LABELV $333
line 654
;654:		if (botstates[i] && botstates[i]->inuse) {
ADDRLP4 12
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $338
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $338
line 655
;655:			BotAIShutdownClient(botstates[i]->client, qfalse);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 BotAIShutdownClient
CALLI4
pop
line 656
;656:		}
LABELV $338
line 657
;657:	}
LABELV $334
line 653
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $336
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $333
line 659
;658:	//make sure all item weight configs are reloaded and Not shared
;659:	trap_BotLibVarSet("bot_reloadcharacters", "1");
ADDRGP4 $340
ARGP4
ADDRGP4 $341
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 661
;660:	//add a number of bots using the desired bot character
;661:	for (i = 0; i < bot_interbreedbots.integer; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $345
JUMPV
LABELV $342
line 662
;662:		trap_SendConsoleCommand( EXEC_INSERT, va("addbot %s 4 free %i %s%d\n",
ADDRGP4 $347
ARGP4
ADDRGP4 bot_interbreedchar+16
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 50
MULI4
ARGI4
ADDRGP4 bot_interbreedchar+16
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 664
;663:						bot_interbreedchar.string, i * 50, bot_interbreedchar.string, i) );
;664:	}
LABELV $343
line 661
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $345
ADDRLP4 0
INDIRI4
ADDRGP4 bot_interbreedbots+12
INDIRI4
LTI4 $342
line 666
;665:	//
;666:	trap_Cvar_Set("bot_interbreedchar", "");
ADDRGP4 $350
ARGP4
ADDRGP4 $324
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 667
;667:	bot_interbreed = qtrue;
ADDRGP4 bot_interbreed
CNSTI4 1
ASGNI4
line 668
;668:}
LABELV $325
endproc BotInterbreeding 16 20
export BotEntityInfo
proc BotEntityInfo 0 8
line 675
;669:
;670:/*
;671:==============
;672:BotEntityInfo
;673:==============
;674:*/
;675:void BotEntityInfo(int entnum, aas_entityinfo_t *info) {
line 676
;676:	trap_AAS_EntityInfo(entnum, info);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_AAS_EntityInfo
CALLV
pop
line 677
;677:}
LABELV $351
endproc BotEntityInfo 0 8
export NumBots
proc NumBots 0 0
line 684
;678:
;679:/*
;680:==============
;681:NumBots
;682:==============
;683:*/
;684:int NumBots(void) {
line 685
;685:	return numbots;
ADDRGP4 numbots
INDIRI4
RETI4
LABELV $352
endproc NumBots 0 0
export BotTeamLeader
proc BotTeamLeader 16 4
line 693
;686:}
;687:
;688:/*
;689:==============
;690:BotTeamLeader
;691:==============
;692:*/
;693:int BotTeamLeader(bot_state_t *bs) {
line 696
;694:	int leader;
;695:
;696:	leader = ClientFromName(bs->teamleader);
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 697
;697:	if (leader < 0) return qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $354
CNSTI4 0
RETI4
ADDRGP4 $353
JUMPV
LABELV $354
line 698
;698:	if (!botstates[leader] || !botstates[leader]->inuse) return qfalse;
ADDRLP4 12
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $358
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $356
LABELV $358
CNSTI4 0
RETI4
ADDRGP4 $353
JUMPV
LABELV $356
line 699
;699:	return qtrue;
CNSTI4 1
RETI4
LABELV $353
endproc BotTeamLeader 16 4
export AngleDifference
proc AngleDifference 4 0
line 707
;700:}
;701:
;702:/*
;703:==============
;704:AngleDifference
;705:==============
;706:*/
;707:float AngleDifference(float ang1, float ang2) {
line 710
;708:	float diff;
;709:
;710:	diff = ang1 - ang2;
ADDRLP4 0
ADDRFP4 0
INDIRF4
ADDRFP4 4
INDIRF4
SUBF4
ASGNF4
line 711
;711:	if (ang1 > ang2) {
ADDRFP4 0
INDIRF4
ADDRFP4 4
INDIRF4
LEF4 $360
line 712
;712:		if (diff > 180.0) diff -= 360.0;
ADDRLP4 0
INDIRF4
CNSTF4 1127481344
LEF4 $361
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 713
;713:	}
ADDRGP4 $361
JUMPV
LABELV $360
line 714
;714:	else {
line 715
;715:		if (diff < -180.0) diff += 360.0;
ADDRLP4 0
INDIRF4
CNSTF4 3274964992
GEF4 $364
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $364
line 716
;716:	}
LABELV $361
line 717
;717:	return diff;
ADDRLP4 0
INDIRF4
RETF4
LABELV $359
endproc AngleDifference 4 0
export BotChangeViewAngle
proc BotChangeViewAngle 16 4
line 725
;718:}
;719:
;720:/*
;721:==============
;722:BotChangeViewAngle
;723:==============
;724:*/
;725:float BotChangeViewAngle(float angle, float ideal_angle, float speed) {
line 728
;726:	float move;
;727:
;728:	angle = AngleMod(angle);
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 729
;729:	ideal_angle = AngleMod(ideal_angle);
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 4
ADDRLP4 8
INDIRF4
ASGNF4
line 730
;730:	if (angle == ideal_angle) return angle;
ADDRFP4 0
INDIRF4
ADDRFP4 4
INDIRF4
NEF4 $367
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $366
JUMPV
LABELV $367
line 731
;731:	move = ideal_angle - angle;
ADDRLP4 0
ADDRFP4 4
INDIRF4
ADDRFP4 0
INDIRF4
SUBF4
ASGNF4
line 732
;732:	if (ideal_angle > angle) {
ADDRFP4 4
INDIRF4
ADDRFP4 0
INDIRF4
LEF4 $369
line 733
;733:		if (move > 180.0) move -= 360.0;
ADDRLP4 0
INDIRF4
CNSTF4 1127481344
LEF4 $370
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 734
;734:	}
ADDRGP4 $370
JUMPV
LABELV $369
line 735
;735:	else {
line 736
;736:		if (move < -180.0) move += 360.0;
ADDRLP4 0
INDIRF4
CNSTF4 3274964992
GEF4 $373
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $373
line 737
;737:	}
LABELV $370
line 738
;738:	if (move > 0) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $375
line 739
;739:		if (move > speed) move = speed;
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
LEF4 $376
ADDRLP4 0
ADDRFP4 8
INDIRF4
ASGNF4
line 740
;740:	}
ADDRGP4 $376
JUMPV
LABELV $375
line 741
;741:	else {
line 742
;742:		if (move < -speed) move = -speed;
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
NEGF4
GEF4 $379
ADDRLP4 0
ADDRFP4 8
INDIRF4
NEGF4
ASGNF4
LABELV $379
line 743
;743:	}
LABELV $376
line 744
;744:	return AngleMod(angle + move);
ADDRFP4 0
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 12
INDIRF4
RETF4
LABELV $366
endproc BotChangeViewAngle 16 4
export BotChangeViewAngles
proc BotChangeViewAngles 96 16
line 752
;745:}
;746:
;747:/*
;748:==============
;749:BotChangeViewAngles
;750:==============
;751:*/
;752:void BotChangeViewAngles(bot_state_t *bs, float thinktime) {
line 756
;753:	float diff, factor, maxchange, anglespeed, disired_speed;
;754:	int i;
;755:
;756:	if (bs->ideal_viewangles[PITCH] > 180) bs->ideal_viewangles[PITCH] -= 360;
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
INDIRF4
CNSTF4 1127481344
LEF4 $382
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $382
line 758
;757:	//
;758:	if (bs->enemy >= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
CNSTI4 0
LTI4 $384
line 759
;759:		factor = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_VIEW_FACTOR, 0.01f, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTF4 1008981770
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 28
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 28
INDIRF4
ASGNF4
line 760
;760:		maxchange = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_VIEW_MAXCHANGE, 1, 1800);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
CNSTF4 1065353216
ARGF4
CNSTF4 1155596288
ARGF4
ADDRLP4 32
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 32
INDIRF4
ASGNF4
line 761
;761:	}
ADDRGP4 $385
JUMPV
LABELV $384
line 762
;762:	else {
line 763
;763:		factor = 0.05f;
ADDRLP4 16
CNSTF4 1028443341
ASGNF4
line 764
;764:		maxchange = 360;
ADDRLP4 8
CNSTF4 1135869952
ASGNF4
line 765
;765:	}
LABELV $385
line 766
;766:	if (maxchange < 240) maxchange = 240;
ADDRLP4 8
INDIRF4
CNSTF4 1131413504
GEF4 $386
ADDRLP4 8
CNSTF4 1131413504
ASGNF4
LABELV $386
line 767
;767:	maxchange *= thinktime;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
line 768
;768:	for (i = 0; i < 2; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $388
line 770
;769:		//
;770:		if (bot_challenge.integer) {
ADDRGP4 bot_challenge+12
INDIRI4
CNSTI4 0
EQI4 $392
line 772
;771:			//smooth slowdown view model
;772:			diff = fabs(AngleDifference(bs->viewangles[i], bs->ideal_viewangles[i]));
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 6576
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 AngleDifference
CALLF4
ASGNF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 40
INDIRF4
ASGNF4
line 773
;773:			anglespeed = diff * factor;
ADDRLP4 4
ADDRLP4 12
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 774
;774:			if (anglespeed > maxchange) anglespeed = maxchange;
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $395
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
LABELV $395
line 775
;775:			bs->viewangles[i] = BotChangeViewAngle(bs->viewangles[i],
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 48
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 48
INDIRP4
CNSTI4 6576
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 52
ADDRGP4 BotChangeViewAngle
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 48
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
ADDRLP4 52
INDIRF4
ASGNF4
line 777
;776:											bs->ideal_viewangles[i], anglespeed);
;777:		}
ADDRGP4 $393
JUMPV
LABELV $392
line 778
;778:		else {
line 780
;779:			//over reaction view model
;780:			bs->viewangles[i] = AngleMod(bs->viewangles[i]);
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
ADDRLP4 36
INDIRF4
ASGNF4
line 781
;781:			bs->ideal_viewangles[i] = AngleMod(bs->ideal_viewangles[i]);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 44
INDIRP4
CNSTI4 6576
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 44
INDIRP4
CNSTI4 6576
ADDP4
ADDP4
ADDRLP4 48
INDIRF4
ASGNF4
line 782
;782:			diff = AngleDifference(bs->viewangles[i], bs->ideal_viewangles[i]);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 56
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 56
INDIRP4
CNSTI4 6576
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
ADDRGP4 AngleDifference
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 60
INDIRF4
ASGNF4
line 783
;783:			disired_speed = diff * factor;
ADDRLP4 20
ADDRLP4 12
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 784
;784:			bs->viewanglespeed[i] += (bs->viewanglespeed[i] - disired_speed);
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
INDIRP4
CNSTI4 6588
ADDP4
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
INDIRP4
CNSTI4 6588
ADDP4
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
ADDF4
ASGNF4
line 785
;785:			if (bs->viewanglespeed[i] > 180) bs->viewanglespeed[i] = maxchange;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6588
ADDP4
ADDP4
INDIRF4
CNSTF4 1127481344
LEF4 $397
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6588
ADDP4
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
LABELV $397
line 786
;786:			if (bs->viewanglespeed[i] < -180) bs->viewanglespeed[i] = -maxchange;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6588
ADDP4
ADDP4
INDIRF4
CNSTF4 3274964992
GEF4 $399
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6588
ADDP4
ADDP4
ADDRLP4 8
INDIRF4
NEGF4
ASGNF4
LABELV $399
line 787
;787:			anglespeed = bs->viewanglespeed[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6588
ADDP4
ADDP4
INDIRF4
ASGNF4
line 788
;788:			if (anglespeed > maxchange) anglespeed = maxchange;
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $401
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
LABELV $401
line 789
;789:			if (anglespeed < -maxchange) anglespeed = -maxchange;
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
NEGF4
GEF4 $403
ADDRLP4 4
ADDRLP4 8
INDIRF4
NEGF4
ASGNF4
LABELV $403
line 790
;790:			bs->viewangles[i] += anglespeed;
ADDRLP4 76
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 791
;791:			bs->viewangles[i] = AngleMod(bs->viewangles[i]);
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 84
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 88
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 84
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
ADDRLP4 88
INDIRF4
ASGNF4
line 793
;792:			//demping
;793:			bs->viewanglespeed[i] *= 0.45 * (1 - factor);
ADDRLP4 92
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6588
ADDP4
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDRLP4 16
INDIRF4
SUBF4
CNSTF4 1055286886
MULF4
MULF4
ASGNF4
line 794
;794:		}
LABELV $393
line 797
;795:		//BotAI_Print(PRT_MESSAGE, "ideal_angles %f %f\n", bs->ideal_viewangles[0], bs->ideal_viewangles[1], bs->ideal_viewangles[2]);`
;796:		//bs->viewangles[i] = bs->ideal_viewangles[i];
;797:	}
LABELV $389
line 768
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $388
line 799
;798:	//bs->viewangles[PITCH] = 0;
;799:	if (bs->viewangles[PITCH] > 180) bs->viewangles[PITCH] -= 360;
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
INDIRF4
CNSTF4 1127481344
LEF4 $405
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $405
line 801
;800:	//elementary action: view
;801:	trap_EA_View(bs->client, bs->viewangles);
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
ADDRGP4 trap_EA_View
CALLV
pop
line 802
;802:}
LABELV $381
endproc BotChangeViewAngles 96 16
export BotInputToUserCommand
proc BotInputToUserCommand 136 16
line 809
;803:
;804:/*
;805:==============
;806:BotInputToUserCommand
;807:==============
;808:*/
;809:void BotInputToUserCommand(bot_input_t *bi, usercmd_t *ucmd, int delta_angles[3], int time) {
line 816
;810:	vec3_t angles, forward, right;
;811:	short temp;
;812:	int j;
;813:	float f, r, u, m;
;814:
;815:	//clear the whole structure
;816:	memset(ucmd, 0, sizeof(usercmd_t));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 24
ARGU4
ADDRGP4 memset
CALLP4
pop
line 820
;817:	//
;818:	//Com_Printf("dir = %f %f %f speed = %f\n", bi->dir[0], bi->dir[1], bi->dir[2], bi->speed);
;819:	//the duration for the user command in milli seconds
;820:	ucmd->serverTime = time;
ADDRFP4 4
INDIRP4
ADDRFP4 12
INDIRI4
ASGNI4
line 822
;821:	//
;822:	if (bi->actionflags & ACTION_DELAYEDJUMP) {
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $408
line 823
;823:		bi->actionflags |= ACTION_JUMP;
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 824
;824:		bi->actionflags &= ~ACTION_DELAYEDJUMP;
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 -32769
BANDI4
ASGNI4
line 825
;825:	}
LABELV $408
line 827
;826:	//set the buttons
;827:	if (bi->actionflags & ACTION_RESPAWN) ucmd->buttons = BUTTON_ATTACK;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $410
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 1
ASGNI4
LABELV $410
line 828
;828:	if (bi->actionflags & ACTION_ATTACK) ucmd->buttons |= BUTTON_ATTACK;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $412
ADDRLP4 60
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
LABELV $412
line 829
;829:	if (bi->actionflags & ACTION_TALK) ucmd->buttons |= BUTTON_TALK;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 65536
BANDI4
CNSTI4 0
EQI4 $414
ADDRLP4 64
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
LABELV $414
line 830
;830:	if (bi->actionflags & ACTION_GESTURE) ucmd->buttons |= BUTTON_GESTURE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 131072
BANDI4
CNSTI4 0
EQI4 $416
ADDRLP4 68
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
LABELV $416
line 831
;831:	if (bi->actionflags & ACTION_USE) ucmd->buttons |= BUTTON_USE_HOLDABLE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $418
ADDRLP4 72
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
LABELV $418
line 832
;832:	if (bi->actionflags & ACTION_WALK) ucmd->buttons |= BUTTON_WALKING;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 524288
BANDI4
CNSTI4 0
EQI4 $420
ADDRLP4 76
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
LABELV $420
line 833
;833:	if (bi->actionflags & ACTION_AFFIRMATIVE) ucmd->buttons |= BUTTON_AFFIRMATIVE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 1048576
BANDI4
CNSTI4 0
EQI4 $422
ADDRLP4 80
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
LABELV $422
line 834
;834:	if (bi->actionflags & ACTION_NEGATIVE) ucmd->buttons |= BUTTON_NEGATIVE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 2097152
BANDI4
CNSTI4 0
EQI4 $424
ADDRLP4 84
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
LABELV $424
line 835
;835:	if (bi->actionflags & ACTION_GETFLAG) ucmd->buttons |= BUTTON_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 8388608
BANDI4
CNSTI4 0
EQI4 $426
ADDRLP4 88
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
LABELV $426
line 836
;836:	if (bi->actionflags & ACTION_GUARDBASE) ucmd->buttons |= BUTTON_GUARDBASE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 16777216
BANDI4
CNSTI4 0
EQI4 $428
ADDRLP4 92
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
LABELV $428
line 837
;837:	if (bi->actionflags & ACTION_PATROL) ucmd->buttons |= BUTTON_PATROL;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 33554432
BANDI4
CNSTI4 0
EQI4 $430
ADDRLP4 96
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
LABELV $430
line 838
;838:	if (bi->actionflags & ACTION_FOLLOWME) ucmd->buttons |= BUTTON_FOLLOWME;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 134217728
BANDI4
CNSTI4 0
EQI4 $432
ADDRLP4 100
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
LABELV $432
line 840
;839:	//
;840:	ucmd->weapon = bi->weapon;
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 843
;841:	//set the view angles
;842:	//NOTE: the ucmd->angles are the angles WITHOUT the delta angles
;843:	ucmd->angles[PITCH] = ANGLE2SHORT(bi->viewangles[PITCH]);
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1127615329
MULF4
CVFI4 4
CNSTI4 65535
BANDI4
ASGNI4
line 844
;844:	ucmd->angles[YAW] = ANGLE2SHORT(bi->viewangles[YAW]);
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
CNSTF4 1127615329
MULF4
CVFI4 4
CNSTI4 65535
BANDI4
ASGNI4
line 845
;845:	ucmd->angles[ROLL] = ANGLE2SHORT(bi->viewangles[ROLL]);
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1127615329
MULF4
CVFI4 4
CNSTI4 65535
BANDI4
ASGNI4
line 847
;846:	//subtract the delta angles
;847:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $434
line 848
;848:		temp = ucmd->angles[j] - delta_angles[j];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRI4
SUBI4
CVII2 4
ASGNI2
line 856
;849:		/*NOTE: disabled because temp should be mod first
;850:		if ( j == PITCH ) {
;851:			// don't let the player look up or down more than 90 degrees
;852:			if ( temp > 16000 ) temp = 16000;
;853:			else if ( temp < -16000 ) temp = -16000;
;854:		}
;855:		*/
;856:		ucmd->angles[j] = temp;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
ADDRLP4 4
INDIRI2
CVII4 2
ASGNI4
line 857
;857:	}
LABELV $435
line 847
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $434
line 861
;858:	//NOTE: movement is relative to the REAL view angles
;859:	//get the horizontal forward and right vector
;860:	//get the pitch in the range [-180, 180]
;861:	if (bi->dir[2]) angles[PITCH] = bi->viewangles[PITCH];
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 0
EQF4 $438
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
ADDRGP4 $439
JUMPV
LABELV $438
line 862
;862:	else angles[PITCH] = 0;
ADDRLP4 24
CNSTF4 0
ASGNF4
LABELV $439
line 863
;863:	angles[YAW] = bi->viewangles[YAW];
ADDRLP4 24+4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 864
;864:	angles[ROLL] = 0;
ADDRLP4 24+8
CNSTF4 0
ASGNF4
line 865
;865:	AngleVectors(angles, forward, right, NULL);
ADDRLP4 24
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 36
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 867
;866:	//bot input speed is in the range [0, 400]
;867:	bi->speed = bi->speed * 127 / 400;
ADDRLP4 104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 104
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 104
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CNSTF4 1050840924
MULF4
ASGNF4
line 870
;868:
;869:	//set the view independent movement
;870:	f = DotProduct( forward, bi->dir );
ADDRLP4 108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 12
INDIRF4
ADDRLP4 108
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 108
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 12+8
INDIRF4
ADDRLP4 108
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 871
;871:	r = DotProduct( right, bi->dir );
ADDRLP4 112
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
ADDRLP4 36
INDIRF4
ADDRLP4 112
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 36+4
INDIRF4
ADDRLP4 112
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 36+8
INDIRF4
ADDRLP4 112
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 872
;872:	u = fabs( forward[2] ) * bi->dir[2];
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRLP4 116
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 52
ADDRLP4 116
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ASGNF4
line 873
;873:	m = fabs( f );
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 120
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 120
INDIRF4
ASGNF4
line 875
;874:
;875:	if ( fabs( r ) > m ) {
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 124
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 124
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $447
line 876
;876:		m = fabs( r );
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 128
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 128
INDIRF4
ASGNF4
line 877
;877:	}
LABELV $447
line 879
;878:
;879:	if ( fabs( u ) > m) {
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 128
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 128
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $449
line 880
;880:		m = fabs( u );
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 132
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 132
INDIRF4
ASGNF4
line 881
;881:	}
LABELV $449
line 883
;882:
;883:	if ( m > 0 ) {
ADDRLP4 8
INDIRF4
CNSTF4 0
LEF4 $451
line 884
;884:		f *= bi->speed / m;
ADDRLP4 56
ADDRLP4 56
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
DIVF4
MULF4
ASGNF4
line 885
;885:		r *= bi->speed / m;
ADDRLP4 48
ADDRLP4 48
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
DIVF4
MULF4
ASGNF4
line 886
;886:		u *= bi->speed / m;
ADDRLP4 52
ADDRLP4 52
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
DIVF4
MULF4
ASGNF4
line 887
;887:	}
LABELV $451
line 889
;888:
;889:	ucmd->forwardmove = f;
ADDRFP4 4
INDIRP4
CNSTI4 21
ADDP4
ADDRLP4 56
INDIRF4
CVFI4 4
CVII1 4
ASGNI1
line 890
;890:	ucmd->rightmove = r;
ADDRFP4 4
INDIRP4
CNSTI4 22
ADDP4
ADDRLP4 48
INDIRF4
CVFI4 4
CVII1 4
ASGNI1
line 891
;891:	ucmd->upmove = u;
ADDRFP4 4
INDIRP4
CNSTI4 23
ADDP4
ADDRLP4 52
INDIRF4
CVFI4 4
CVII1 4
ASGNI1
line 893
;892:
;893:	if (bi->actionflags & ACTION_MOVEFORWARD) ucmd->forwardmove = 127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $453
ADDRFP4 4
INDIRP4
CNSTI4 21
ADDP4
CNSTI1 127
ASGNI1
LABELV $453
line 894
;894:	if (bi->actionflags & ACTION_MOVEBACK) ucmd->forwardmove = -127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $455
ADDRFP4 4
INDIRP4
CNSTI4 21
ADDP4
CNSTI1 -127
ASGNI1
LABELV $455
line 895
;895:	if (bi->actionflags & ACTION_MOVELEFT) ucmd->rightmove = -127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $457
ADDRFP4 4
INDIRP4
CNSTI4 22
ADDP4
CNSTI1 -127
ASGNI1
LABELV $457
line 896
;896:	if (bi->actionflags & ACTION_MOVERIGHT) ucmd->rightmove = 127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $459
ADDRFP4 4
INDIRP4
CNSTI4 22
ADDP4
CNSTI1 127
ASGNI1
LABELV $459
line 898
;897:	//jump/moveup
;898:	if (bi->actionflags & ACTION_JUMP) ucmd->upmove = 127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $461
ADDRFP4 4
INDIRP4
CNSTI4 23
ADDP4
CNSTI1 127
ASGNI1
LABELV $461
line 900
;899:	//crouch/movedown
;900:	if (bi->actionflags & ACTION_CROUCH) ucmd->upmove = -127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $463
ADDRFP4 4
INDIRP4
CNSTI4 23
ADDP4
CNSTI1 -127
ASGNI1
LABELV $463
line 901
;901:}
LABELV $407
endproc BotInputToUserCommand 136 16
export BotUpdateInput
proc BotUpdateInput 60 16
line 908
;902:
;903:/*
;904:==============
;905:BotUpdateInput
;906:==============
;907:*/
;908:void BotUpdateInput(bot_state_t *bs, int time, int elapsed_time) {
line 913
;909:	bot_input_t bi;
;910:	int j;
;911:
;912:	//add the delta angles to the bot's current view angles
;913:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $466
line 914
;914:		bs->viewangles[j] = AngleMod(bs->viewangles[j] + SHORT2ANGLE(bs->cur_ps.delta_angles[j]));
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 48
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 48
INDIRP4
CNSTI4 72
ADDP4
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1001652224
MULF4
ADDF4
ARGF4
ADDRLP4 52
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 48
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
ADDRLP4 52
INDIRF4
ASGNF4
line 915
;915:	}
LABELV $467
line 913
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $466
line 917
;916:	//change the bot view angles
;917:	BotChangeViewAngles(bs, (float) elapsed_time / 1000);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ARGF4
ADDRGP4 BotChangeViewAngles
CALLV
pop
line 919
;918:	//retrieve the bot input
;919:	trap_EA_GetInput(bs->client, (float) time / 1000, &bi);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 trap_EA_GetInput
CALLV
pop
line 921
;920:	//respawn hack
;921:	if (bi.actionflags & ACTION_RESPAWN) {
ADDRLP4 4+32
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $470
line 922
;922:		if (bs->lastucmd.buttons & BUTTON_ATTACK) bi.actionflags &= ~(ACTION_RESPAWN|ACTION_ATTACK);
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $473
ADDRLP4 4+32
ADDRLP4 4+32
INDIRI4
CNSTI4 -10
BANDI4
ASGNI4
LABELV $473
line 923
;923:	}
LABELV $470
line 925
;924:	//convert the bot input to a usercmd
;925:	BotInputToUserCommand(&bi, &bs->lastucmd, bs->cur_ps.delta_angles, time);
ADDRLP4 4
ARGP4
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 72
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 BotInputToUserCommand
CALLV
pop
line 927
;926:	//subtract the delta angles
;927:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $476
line 928
;928:		bs->viewangles[j] = AngleMod(bs->viewangles[j] - SHORT2ANGLE(bs->cur_ps.delta_angles[j]));
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 52
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 52
INDIRP4
CNSTI4 72
ADDP4
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1001652224
MULF4
SUBF4
ARGF4
ADDRLP4 56
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 52
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
ADDRLP4 56
INDIRF4
ASGNF4
line 929
;929:	}
LABELV $477
line 927
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $476
line 930
;930:}
LABELV $465
endproc BotUpdateInput 60 16
export BotAIRegularUpdate
proc BotAIRegularUpdate 0 0
line 937
;931:
;932:/*
;933:==============
;934:BotAIRegularUpdate
;935:==============
;936:*/
;937:void BotAIRegularUpdate(void) {
line 938
;938:	if (regularupdate_time < FloatTime()) {
ADDRGP4 regularupdate_time
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $481
line 939
;939:		trap_BotUpdateEntityItems();
ADDRGP4 trap_BotUpdateEntityItems
CALLV
pop
line 940
;940:		regularupdate_time = FloatTime() + 0.3;
ADDRGP4 regularupdate_time
ADDRGP4 floattime
INDIRF4
CNSTF4 1050253722
ADDF4
ASGNF4
line 941
;941:	}
LABELV $481
line 942
;942:}
LABELV $480
endproc BotAIRegularUpdate 0 0
export RemoveColorEscapeSequences
proc RemoveColorEscapeSequences 20 0
line 949
;943:
;944:/*
;945:==============
;946:RemoveColorEscapeSequences
;947:==============
;948:*/
;949:void RemoveColorEscapeSequences( char *text ) {
line 952
;950:	int i, l;
;951:
;952:	l = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 953
;953:	for ( i = 0; text[i]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $487
JUMPV
LABELV $484
line 954
;954:		if (Q_IsColorString(&text[i])) {
ADDRLP4 8
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $488
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $488
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $488
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $488
line 955
;955:			i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 956
;956:			continue;
ADDRGP4 $485
JUMPV
LABELV $488
line 958
;957:		}
;958:		if (text[i] > 0x7E)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 126
LEI4 $490
line 959
;959:			continue;
ADDRGP4 $485
JUMPV
LABELV $490
line 960
;960:		text[l++] = text[i];
ADDRLP4 12
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRI4
ADDRLP4 16
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 961
;961:	}
LABELV $485
line 953
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $487
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $484
line 962
;962:	text[l] = '\0';
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 963
;963:}
LABELV $483
endproc RemoveColorEscapeSequences 20 0
export BotAI
proc BotAI 1088 12
line 970
;964:
;965:/*
;966:==============
;967:BotAI
;968:==============
;969:*/
;970:int BotAI(int client, float thinktime) {
line 975
;971:	bot_state_t *bs;
;972:	char buf[1024], *args;
;973:	int j;
;974:
;975:	trap_EA_ResetInput(client);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 trap_EA_ResetInput
CALLV
pop
line 977
;976:	//
;977:	bs = botstates[client];
ADDRLP4 4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 978
;978:	if (!bs || !bs->inuse) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $495
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $493
LABELV $495
line 979
;979:		BotAI_Print(PRT_FATAL, "BotAI: client %d is not setup\n", client);
CNSTI4 4
ARGI4
ADDRGP4 $496
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 980
;980:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $492
JUMPV
LABELV $493
line 984
;981:	}
;982:
;983:	//retrieve the current client state
;984:	BotAI_GetClientState( client, &bs->cur_ps );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
ADDRGP4 $498
JUMPV
LABELV $497
line 987
;985:
;986:	//retrieve any waiting server commands
;987:	while( trap_BotGetServerCommand(client, buf, sizeof(buf)) ) {
line 989
;988:		//have buf point to the command and args to the command arguments
;989:		args = strchr( buf, ' ');
ADDRLP4 12
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 1040
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 1040
INDIRP4
ASGNP4
line 990
;990:		if (!args) continue;
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $500
ADDRGP4 $498
JUMPV
LABELV $500
line 991
;991:		*args++ = '\0';
ADDRLP4 1044
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 1044
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 1044
INDIRP4
CNSTI1 0
ASGNI1
line 994
;992:
;993:		//remove color espace sequences from the arguments
;994:		RemoveColorEscapeSequences( args );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 RemoveColorEscapeSequences
CALLV
pop
line 996
;995:
;996:		if (!Q_stricmp(buf, "cp "))
ADDRLP4 12
ARGP4
ADDRGP4 $504
ARGP4
ADDRLP4 1048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $502
line 997
;997:			{ /*CenterPrintf*/ }
ADDRGP4 $503
JUMPV
LABELV $502
line 998
;998:		else if (!Q_stricmp(buf, "cs"))
ADDRLP4 12
ARGP4
ADDRGP4 $507
ARGP4
ADDRLP4 1052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $505
line 999
;999:			{ /*ConfigStringModified*/ }
ADDRGP4 $506
JUMPV
LABELV $505
line 1000
;1000:		else if (!Q_stricmp(buf, "print")) {
ADDRLP4 12
ARGP4
ADDRGP4 $510
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $508
line 1002
;1001:			//remove first and last quote from the chat message
;1002:			memmove(args, args+1, strlen(args));
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1060
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 1060
INDIRU4
ARGU4
ADDRGP4 memmove
CALLP4
pop
line 1003
;1003:			args[strlen(args)-1] = '\0';
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1068
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 1068
INDIRU4
CNSTU4 1
SUBU4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1004
;1004:			trap_BotQueueConsoleMessage(bs->cs, CMS_NORMAL, args);
ADDRLP4 4
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_BotQueueConsoleMessage
CALLV
pop
line 1005
;1005:		}
ADDRGP4 $509
JUMPV
LABELV $508
line 1006
;1006:		else if (!Q_stricmp(buf, "chat")) {
ADDRLP4 12
ARGP4
ADDRGP4 $513
ARGP4
ADDRLP4 1060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $511
line 1008
;1007:			//remove first and last quote from the chat message
;1008:			memmove(args, args+1, strlen(args));
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1064
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 1064
INDIRU4
ARGU4
ADDRGP4 memmove
CALLP4
pop
line 1009
;1009:			args[strlen(args)-1] = '\0';
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1072
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 1072
INDIRU4
CNSTU4 1
SUBU4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1010
;1010:			trap_BotQueueConsoleMessage(bs->cs, CMS_CHAT, args);
ADDRLP4 4
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_BotQueueConsoleMessage
CALLV
pop
line 1011
;1011:		}
ADDRGP4 $512
JUMPV
LABELV $511
line 1012
;1012:		else if (!Q_stricmp(buf, "tchat")) {
ADDRLP4 12
ARGP4
ADDRGP4 $516
ARGP4
ADDRLP4 1064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $514
line 1014
;1013:			//remove first and last quote from the chat message
;1014:			memmove(args, args+1, strlen(args));
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1068
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 1068
INDIRU4
ARGU4
ADDRGP4 memmove
CALLP4
pop
line 1015
;1015:			args[strlen(args)-1] = '\0';
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1076
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 1076
INDIRU4
CNSTU4 1
SUBU4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1016
;1016:			trap_BotQueueConsoleMessage(bs->cs, CMS_CHAT, args);
ADDRLP4 4
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_BotQueueConsoleMessage
CALLV
pop
line 1017
;1017:		}
ADDRGP4 $515
JUMPV
LABELV $514
line 1019
;1018:#ifdef MISSIONPACK
;1019:		else if (!Q_stricmp(buf, "vchat")) {
ADDRLP4 12
ARGP4
ADDRGP4 $519
ARGP4
ADDRLP4 1068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
NEI4 $517
line 1020
;1020:			BotVoiceChatCommand(bs, SAY_ALL, args);
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 BotVoiceChatCommand
CALLI4
pop
line 1021
;1021:		}
ADDRGP4 $518
JUMPV
LABELV $517
line 1022
;1022:		else if (!Q_stricmp(buf, "vtchat")) {
ADDRLP4 12
ARGP4
ADDRGP4 $522
ARGP4
ADDRLP4 1072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $520
line 1023
;1023:			BotVoiceChatCommand(bs, SAY_TEAM, args);
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 BotVoiceChatCommand
CALLI4
pop
line 1024
;1024:		}
ADDRGP4 $521
JUMPV
LABELV $520
line 1025
;1025:		else if (!Q_stricmp(buf, "vtell")) {
ADDRLP4 12
ARGP4
ADDRGP4 $525
ARGP4
ADDRLP4 1076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
NEI4 $523
line 1026
;1026:			BotVoiceChatCommand(bs, SAY_TELL, args);
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 BotVoiceChatCommand
CALLI4
pop
line 1027
;1027:		}
ADDRGP4 $524
JUMPV
LABELV $523
line 1029
;1028:#endif
;1029:		else if (!Q_stricmp(buf, "scores"))
ADDRLP4 12
ARGP4
ADDRGP4 $528
ARGP4
ADDRLP4 1080
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1080
INDIRI4
CNSTI4 0
NEI4 $526
line 1030
;1030:			{ /*FIXME: parse scores?*/ }
ADDRGP4 $527
JUMPV
LABELV $526
line 1031
;1031:		else if (!Q_stricmp(buf, "clientLevelShot"))
ADDRLP4 12
ARGP4
ADDRGP4 $531
ARGP4
ADDRLP4 1084
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1084
INDIRI4
CNSTI4 0
NEI4 $529
line 1032
;1032:			{ /*ignore*/ }
LABELV $529
LABELV $527
LABELV $524
LABELV $521
LABELV $518
LABELV $515
LABELV $512
LABELV $509
LABELV $506
LABELV $503
line 1033
;1033:	}
LABELV $498
line 987
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1040
ADDRGP4 trap_BotGetServerCommand
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $497
line 1035
;1034:	//add the delta angles to the bot's current view angles
;1035:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $532
line 1036
;1036:		bs->viewangles[j] = AngleMod(bs->viewangles[j] + SHORT2ANGLE(bs->cur_ps.delta_angles[j]));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1001652224
MULF4
ADDF4
ARGF4
ADDRLP4 1052
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
ADDRLP4 1052
INDIRF4
ASGNF4
line 1037
;1037:	}
LABELV $533
line 1035
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $532
line 1039
;1038:	//increase the local time of the bot
;1039:	bs->ltime += thinktime;
ADDRLP4 1044
ADDRLP4 4
INDIRP4
CNSTI4 6060
ADDP4
ASGNP4
ADDRLP4 1044
INDIRP4
ADDRLP4 1044
INDIRP4
INDIRF4
ADDRFP4 4
INDIRF4
ADDF4
ASGNF4
line 1041
;1040:	//
;1041:	bs->thinktime = thinktime;
ADDRLP4 4
INDIRP4
CNSTI4 4904
ADDP4
ADDRFP4 4
INDIRF4
ASGNF4
line 1043
;1042:	//origin of the bot
;1043:	VectorCopy(bs->cur_ps.origin, bs->origin);
ADDRLP4 4
INDIRP4
CNSTI4 4908
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1045
;1044:	//eye coordinates of the bot
;1045:	VectorCopy(bs->cur_ps.origin, bs->eye);
ADDRLP4 4
INDIRP4
CNSTI4 4936
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1046
;1046:	bs->eye[2] += bs->cur_ps.viewheight;
ADDRLP4 1060
ADDRLP4 4
INDIRP4
CNSTI4 4944
ADDP4
ASGNP4
ADDRLP4 1060
INDIRP4
ADDRLP4 1060
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1048
;1047:	//get the area the bot is in
;1048:	bs->areanum = BotPointAreaNum(bs->origin);
ADDRLP4 4
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 1068
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 4948
ADDP4
ADDRLP4 1068
INDIRI4
ASGNI4
line 1050
;1049:	//the real AI
;1050:	BotDeathmatchAI(bs, thinktime);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRGP4 BotDeathmatchAI
CALLV
pop
line 1052
;1051:	//set the weapon selection every AI frame
;1052:	trap_EA_SelectWeapon(bs->client, bs->weaponnum);
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_SelectWeapon
CALLV
pop
line 1054
;1053:	//subtract the delta angles
;1054:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $536
line 1055
;1055:		bs->viewangles[j] = AngleMod(bs->viewangles[j] - SHORT2ANGLE(bs->cur_ps.delta_angles[j]));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1001652224
MULF4
SUBF4
ARGF4
ADDRLP4 1084
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
ADDRLP4 1084
INDIRF4
ASGNF4
line 1056
;1056:	}
LABELV $537
line 1054
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $536
line 1058
;1057:	//everything was ok
;1058:	return qtrue;
CNSTI4 1
RETI4
LABELV $492
endproc BotAI 1088 12
export BotScheduleBotThink
proc BotScheduleBotThink 16 0
line 1066
;1059:}
;1060:
;1061:/*
;1062:==================
;1063:BotScheduleBotThink
;1064:==================
;1065:*/
;1066:void BotScheduleBotThink(void) {
line 1069
;1067:	int i, botnum;
;1068:
;1069:	botnum = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1071
;1070:
;1071:	for( i = 0; i < MAX_CLIENTS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $541
line 1072
;1072:		if( !botstates[i] || !botstates[i]->inuse ) {
ADDRLP4 12
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $547
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $545
LABELV $547
line 1073
;1073:			continue;
ADDRGP4 $542
JUMPV
LABELV $545
line 1076
;1074:		}
;1075:		//initialize the bot think residual time
;1076:		botstates[i]->botthink_residual = bot_thinktime.integer * botnum / numbots;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 bot_thinktime+12
INDIRI4
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 numbots
INDIRI4
DIVI4
ASGNI4
line 1077
;1077:		botnum++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1078
;1078:	}
LABELV $542
line 1071
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $541
line 1079
;1079:}
LABELV $540
endproc BotScheduleBotThink 16 0
export BotWriteSessionData
proc BotWriteSessionData 20 72
line 1086
;1080:
;1081:/*
;1082:==============
;1083:BotWriteSessionData
;1084:==============
;1085:*/
;1086:void BotWriteSessionData(bot_state_t *bs) {
line 1090
;1087:	const char	*s;
;1088:	const char	*var;
;1089:
;1090:	s = va(
ADDRGP4 $550
ARGP4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 6756
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6764
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6780
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6808
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6816
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6820
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6812
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6768
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6772
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6776
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6784
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6788
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6792
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6796
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6800
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6804
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 1114
;1091:			"%i %i %i %i %i %i %i %i"
;1092:			" %f %f %f"
;1093:			" %f %f %f"
;1094:			" %f %f %f",
;1095:		bs->lastgoal_decisionmaker,
;1096:		bs->lastgoal_ltgtype,
;1097:		bs->lastgoal_teammate,
;1098:		bs->lastgoal_teamgoal.areanum,
;1099:		bs->lastgoal_teamgoal.entitynum,
;1100:		bs->lastgoal_teamgoal.flags,
;1101:		bs->lastgoal_teamgoal.iteminfo,
;1102:		bs->lastgoal_teamgoal.number,
;1103:		bs->lastgoal_teamgoal.origin[0],
;1104:		bs->lastgoal_teamgoal.origin[1],
;1105:		bs->lastgoal_teamgoal.origin[2],
;1106:		bs->lastgoal_teamgoal.mins[0],
;1107:		bs->lastgoal_teamgoal.mins[1],
;1108:		bs->lastgoal_teamgoal.mins[2],
;1109:		bs->lastgoal_teamgoal.maxs[0],
;1110:		bs->lastgoal_teamgoal.maxs[1],
;1111:		bs->lastgoal_teamgoal.maxs[2]
;1112:		);
;1113:
;1114:	var = va( "botsession%i", bs->client );
ADDRGP4 $551
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 1116
;1115:
;1116:	trap_Cvar_Set( var, s );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1117
;1117:}
LABELV $549
endproc BotWriteSessionData 20 72
export BotReadSessionData
proc BotReadSessionData 1036 76
line 1124
;1118:
;1119:/*
;1120:==============
;1121:BotReadSessionData
;1122:==============
;1123:*/
;1124:void BotReadSessionData(bot_state_t *bs) {
line 1128
;1125:	char	s[MAX_STRING_CHARS];
;1126:	const char	*var;
;1127:
;1128:	var = va( "botsession%i", bs->client );
ADDRGP4 $551
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 1028
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1024
ADDRLP4 1028
INDIRP4
ASGNP4
line 1129
;1129:	trap_Cvar_VariableStringBuffer( var, s, sizeof(s) );
ADDRLP4 1024
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1131
;1130:
;1131:	Q_sscanf(s,
ADDRLP4 0
ARGP4
ADDRGP4 $550
ARGP4
ADDRLP4 1032
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1032
INDIRP4
CNSTI4 6756
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6760
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6764
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6780
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6808
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6816
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6820
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6812
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6768
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6772
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6776
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6784
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6788
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6792
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6796
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6800
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6804
ADDP4
ARGP4
ADDRGP4 Q_sscanf
CALLI4
pop
line 1154
;1132:			"%i %i %i %i %i %i %i %i"
;1133:			" %f %f %f"
;1134:			" %f %f %f"
;1135:			" %f %f %f",
;1136:		&bs->lastgoal_decisionmaker,
;1137:		&bs->lastgoal_ltgtype,
;1138:		&bs->lastgoal_teammate,
;1139:		&bs->lastgoal_teamgoal.areanum,
;1140:		&bs->lastgoal_teamgoal.entitynum,
;1141:		&bs->lastgoal_teamgoal.flags,
;1142:		&bs->lastgoal_teamgoal.iteminfo,
;1143:		&bs->lastgoal_teamgoal.number,
;1144:		&bs->lastgoal_teamgoal.origin[0],
;1145:		&bs->lastgoal_teamgoal.origin[1],
;1146:		&bs->lastgoal_teamgoal.origin[2],
;1147:		&bs->lastgoal_teamgoal.mins[0],
;1148:		&bs->lastgoal_teamgoal.mins[1],
;1149:		&bs->lastgoal_teamgoal.mins[2],
;1150:		&bs->lastgoal_teamgoal.maxs[0],
;1151:		&bs->lastgoal_teamgoal.maxs[1],
;1152:		&bs->lastgoal_teamgoal.maxs[2]
;1153:		);
;1154:}
LABELV $552
endproc BotReadSessionData 1036 76
export BotAISetupClient
proc BotAISetupClient 512 16
line 1161
;1155:
;1156:/*
;1157:==============
;1158:BotAISetupClient
;1159:==============
;1160:*/
;1161:qboolean BotAISetupClient( int client, struct bot_settings_s *settings, qboolean restart ) {
line 1166
;1162:	char filename[MAX_PATH], name[MAX_PATH], gender[MAX_PATH];
;1163:	bot_state_t *bs;
;1164:	int errnum;
;1165:
;1166:	if (!botstates[client]) botstates[client] = G_Alloc(sizeof(bot_state_t));
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $554
CNSTU4 9092
ARGU4
ADDRLP4 440
ADDRGP4 G_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
ADDRLP4 440
INDIRP4
ASGNP4
LABELV $554
line 1167
;1167:	bs = botstates[client];
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 1168
;1168:	if ( bs == NULL ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $556
line 1169
;1169:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $553
JUMPV
LABELV $556
line 1172
;1170:	}
;1171:
;1172:	if (bs && bs->inuse) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $558
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $558
line 1173
;1173:		BotAI_Print(PRT_FATAL, "BotAISetupClient: client %d already setup\n", client);
CNSTI4 4
ARGI4
ADDRGP4 $560
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 1174
;1174:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $553
JUMPV
LABELV $558
line 1177
;1175:	}
;1176:
;1177:	if (!trap_AAS_Initialized()) {
ADDRLP4 448
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 448
INDIRI4
CNSTI4 0
NEI4 $561
line 1178
;1178:		BotAI_Print(PRT_FATAL, "AAS not initialized\n");
CNSTI4 4
ARGI4
ADDRGP4 $563
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1179
;1179:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $553
JUMPV
LABELV $561
line 1183
;1180:	}
;1181:
;1182:	//load the bot character
;1183:	bs->character = trap_BotLoadCharacter(settings->characterfile, settings->skill);
ADDRLP4 452
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 452
INDIRP4
ARGP4
ADDRLP4 452
INDIRP4
CNSTI4 144
ADDP4
INDIRF4
ARGF4
ADDRLP4 456
ADDRGP4 trap_BotLoadCharacter
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
ADDRLP4 456
INDIRI4
ASGNI4
line 1184
;1184:	if (!bs->character) {
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $564
line 1185
;1185:		BotAI_Print(PRT_FATAL, "couldn't load skill %f from %s\n", settings->skill, settings->characterfile);
CNSTI4 4
ARGI4
ADDRGP4 $566
ARGP4
ADDRLP4 460
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 460
INDIRP4
CNSTI4 144
ADDP4
INDIRF4
ARGF4
ADDRLP4 460
INDIRP4
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1186
;1186:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $553
JUMPV
LABELV $564
line 1189
;1187:	}
;1188:	//copy the settings
;1189:	memcpy(&bs->settings, settings, sizeof(bot_settings_t));
ADDRLP4 0
INDIRP4
CNSTI4 4608
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTU4 292
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 1191
;1190:	//allocate a goal state
;1191:	bs->gs = trap_BotAllocGoalState(client);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 460
ADDRGP4 trap_BotAllocGoalState
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 6528
ADDP4
ADDRLP4 460
INDIRI4
ASGNI4
line 1193
;1192:	//load the item weights
;1193:	trap_Characteristic_String(bs->character, CHARACTERISTIC_ITEMWEIGHTS, filename, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 40
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1194
;1194:	errnum = trap_BotLoadItemWeights(bs->gs, filename);
ADDRLP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 464
ADDRGP4 trap_BotLoadItemWeights
CALLI4
ASGNI4
ADDRLP4 148
ADDRLP4 464
INDIRI4
ASGNI4
line 1195
;1195:	if (errnum != BLERR_NOERROR) {
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $567
line 1196
;1196:		trap_BotFreeGoalState(bs->gs);
ADDRLP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeGoalState
CALLV
pop
line 1197
;1197:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $553
JUMPV
LABELV $567
line 1200
;1198:	}
;1199:	//allocate a weapon state
;1200:	bs->ws = trap_BotAllocWeaponState();
ADDRLP4 468
ADDRGP4 trap_BotAllocWeaponState
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 6536
ADDP4
ADDRLP4 468
INDIRI4
ASGNI4
line 1202
;1201:	//load the weapon weights
;1202:	trap_Characteristic_String(bs->character, CHARACTERISTIC_WEAPONWEIGHTS, filename, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1203
;1203:	errnum = trap_BotLoadWeaponWeights(bs->ws, filename);
ADDRLP4 0
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 472
ADDRGP4 trap_BotLoadWeaponWeights
CALLI4
ASGNI4
ADDRLP4 148
ADDRLP4 472
INDIRI4
ASGNI4
line 1204
;1204:	if (errnum != BLERR_NOERROR) {
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $569
line 1205
;1205:		trap_BotFreeGoalState(bs->gs);
ADDRLP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeGoalState
CALLV
pop
line 1206
;1206:		trap_BotFreeWeaponState(bs->ws);
ADDRLP4 0
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeWeaponState
CALLV
pop
line 1207
;1207:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $553
JUMPV
LABELV $569
line 1210
;1208:	}
;1209:	//allocate a chat state
;1210:	bs->cs = trap_BotAllocChatState();
ADDRLP4 476
ADDRGP4 trap_BotAllocChatState
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 6532
ADDP4
ADDRLP4 476
INDIRI4
ASGNI4
line 1212
;1211:	//load the chat file
;1212:	trap_Characteristic_String(bs->character, CHARACTERISTIC_CHAT_FILE, filename, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 21
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1213
;1213:	trap_Characteristic_String(bs->character, CHARACTERISTIC_CHAT_NAME, name, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 22
ARGI4
ADDRLP4 296
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1214
;1214:	errnum = trap_BotLoadChatFile(bs->cs, filename, name);
ADDRLP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 296
ARGP4
ADDRLP4 480
ADDRGP4 trap_BotLoadChatFile
CALLI4
ASGNI4
ADDRLP4 148
ADDRLP4 480
INDIRI4
ASGNI4
line 1215
;1215:	if (errnum != BLERR_NOERROR) {
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $571
line 1216
;1216:		trap_BotFreeChatState(bs->cs);
ADDRLP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeChatState
CALLV
pop
line 1217
;1217:		trap_BotFreeGoalState(bs->gs);
ADDRLP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeGoalState
CALLV
pop
line 1218
;1218:		trap_BotFreeWeaponState(bs->ws);
ADDRLP4 0
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeWeaponState
CALLV
pop
line 1219
;1219:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $553
JUMPV
LABELV $571
line 1222
;1220:	}
;1221:	//get the gender characteristic
;1222:	trap_Characteristic_String(bs->character, CHARACTERISTIC_GENDER, gender, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 152
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1224
;1223:	//set the chat gender
;1224:	if (*gender == 'f' || *gender == 'F') trap_BotSetChatGender(bs->cs, CHAT_GENDERFEMALE);
ADDRLP4 484
ADDRLP4 152
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 484
INDIRI4
CNSTI4 102
EQI4 $575
ADDRLP4 484
INDIRI4
CNSTI4 70
NEI4 $573
LABELV $575
ADDRLP4 0
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
ADDRGP4 $574
JUMPV
LABELV $573
line 1225
;1225:	else if (*gender == 'm' || *gender == 'M') trap_BotSetChatGender(bs->cs, CHAT_GENDERMALE);
ADDRLP4 488
ADDRLP4 152
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 488
INDIRI4
CNSTI4 109
EQI4 $578
ADDRLP4 488
INDIRI4
CNSTI4 77
NEI4 $576
LABELV $578
ADDRLP4 0
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
ADDRGP4 $577
JUMPV
LABELV $576
line 1226
;1226:	else trap_BotSetChatGender(bs->cs, CHAT_GENDERLESS);
ADDRLP4 0
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
LABELV $577
LABELV $574
line 1228
;1227:
;1228:	bs->inuse = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 1
ASGNI4
line 1229
;1229:	bs->client = client;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1230
;1230:	bs->entitynum = client;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1231
;1231:	bs->setupcount = 4;
ADDRLP4 0
INDIRP4
CNSTI4 6016
ADDP4
CNSTI4 4
ASGNI4
line 1232
;1232:	bs->entergame_time = FloatTime();
ADDRLP4 0
INDIRP4
CNSTI4 6064
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1233
;1233:	bs->ms = trap_BotAllocMoveState();
ADDRLP4 492
ADDRGP4 trap_BotAllocMoveState
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 6524
ADDP4
ADDRLP4 492
INDIRI4
ASGNI4
line 1234
;1234:	bs->walker = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_WALKER, 0, 1);
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 48
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 500
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 6056
ADDP4
ADDRLP4 500
INDIRF4
ASGNF4
line 1235
;1235:	numbots++;
ADDRLP4 504
ADDRGP4 numbots
ASGNP4
ADDRLP4 504
INDIRP4
ADDRLP4 504
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1237
;1236:
;1237:	if (trap_Cvar_VariableIntegerValue("bot_testichat")) {
ADDRGP4 $581
ARGP4
ADDRLP4 508
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 508
INDIRI4
CNSTI4 0
EQI4 $579
line 1238
;1238:		trap_BotLibVarSet("bot_testichat", "1");
ADDRGP4 $581
ARGP4
ADDRGP4 $341
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1239
;1239:		BotChatTest(bs);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BotChatTest
CALLV
pop
line 1240
;1240:	}
LABELV $579
line 1242
;1241:	//NOTE: reschedule the bot thinking
;1242:	BotScheduleBotThink();
ADDRGP4 BotScheduleBotThink
CALLV
pop
line 1244
;1243:	//if interbreeding start with a mutation
;1244:	if (bot_interbreed) {
ADDRGP4 bot_interbreed
INDIRI4
CNSTI4 0
EQI4 $582
line 1245
;1245:		trap_BotMutateGoalFuzzyLogic(bs->gs, 1);
ADDRLP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_BotMutateGoalFuzzyLogic
CALLV
pop
line 1246
;1246:	}
LABELV $582
line 1248
;1247:	// if we kept the bot client
;1248:	if (restart) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $584
line 1249
;1249:		BotReadSessionData(bs);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BotReadSessionData
CALLV
pop
line 1250
;1250:	}
LABELV $584
line 1252
;1251:	//bot has been setup succesfully
;1252:	return qtrue;
CNSTI4 1
RETI4
LABELV $553
endproc BotAISetupClient 512 16
export BotAIShutdownClient
proc BotAIShutdownClient 16 12
line 1260
;1253:}
;1254:
;1255:/*
;1256:==============
;1257:BotAIShutdownClient
;1258:==============
;1259:*/
;1260:int BotAIShutdownClient(int client, qboolean restart) {
line 1263
;1261:	bot_state_t *bs;
;1262:
;1263:	bs = botstates[client];
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 1264
;1264:	if (!bs || !bs->inuse) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $589
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $587
LABELV $589
line 1266
;1265:		//BotAI_Print(PRT_ERROR, "BotAIShutdownClient: client %d already shutdown\n", client);
;1266:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $586
JUMPV
LABELV $587
line 1269
;1267:	}
;1268:
;1269:	if (restart) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $590
line 1270
;1270:		BotWriteSessionData(bs);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BotWriteSessionData
CALLV
pop
line 1271
;1271:	}
LABELV $590
line 1273
;1272:
;1273:	if (BotChat_ExitGame(bs)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotChat_ExitGame
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $592
line 1274
;1274:		trap_BotEnterChat(bs->cs, bs->client, CHAT_ALL);
ADDRLP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1275
;1275:	}
LABELV $592
line 1277
;1276:
;1277:	trap_BotFreeMoveState(bs->ms);
ADDRLP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeMoveState
CALLV
pop
line 1279
;1278:	//free the goal state
;1279:	trap_BotFreeGoalState(bs->gs);
ADDRLP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeGoalState
CALLV
pop
line 1281
;1280:	//free the chat file
;1281:	trap_BotFreeChatState(bs->cs);
ADDRLP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeChatState
CALLV
pop
line 1283
;1282:	//free the weapon weights
;1283:	trap_BotFreeWeaponState(bs->ws);
ADDRLP4 0
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeWeaponState
CALLV
pop
line 1285
;1284:	//free the bot character
;1285:	trap_BotFreeCharacter(bs->character);
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeCharacter
CALLV
pop
line 1287
;1286:	//
;1287:	BotFreeWaypoints(bs->checkpoints);
ADDRLP4 0
INDIRP4
CNSTI4 9076
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 1288
;1288:	BotFreeWaypoints(bs->patrolpoints);
ADDRLP4 0
INDIRP4
CNSTI4 9080
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 1290
;1289:	//clear activate goal stack
;1290:	BotClearActivateGoalStack(bs);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BotClearActivateGoalStack
CALLV
pop
line 1292
;1291:	//clear the bot state
;1292:	memset(bs, 0, sizeof(bot_state_t));
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 9092
ARGU4
ADDRGP4 memset
CALLP4
pop
line 1294
;1293:	//set the inuse flag to qfalse
;1294:	bs->inuse = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1296
;1295:	//there's one bot less
;1296:	numbots--;
ADDRLP4 12
ADDRGP4 numbots
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1298
;1297:	//everything went ok
;1298:	return qtrue;
CNSTI4 1
RETI4
LABELV $586
endproc BotAIShutdownClient 16 12
export BotResetState
proc BotResetState 796 12
line 1310
;1299:}
;1300:
;1301:
;1302:/*
;1303:==============
;1304:BotResetState
;1305:
;1306:called when a bot enters the intermission or observer mode and
;1307:when the level is changed
;1308:==============
;1309:*/
;1310:void BotResetState(bot_state_t *bs) {
line 1319
;1311:	int client, entitynum, inuse;
;1312:	int movestate, goalstate, chatstate, weaponstate;
;1313:	bot_settings_t settings;
;1314:	int character;
;1315:	playerState_t ps;							//current player state
;1316:	float entergame_time;
;1317:
;1318:	//save some things that should not be reset here
;1319:	memcpy(&settings, &bs->settings, sizeof(bot_settings_t));
ADDRLP4 28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4608
ADDP4
ARGP4
CNSTU4 292
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 1320
;1320:	memcpy(&ps, &bs->cur_ps, sizeof(playerState_t));
ADDRLP4 324
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTU4 468
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 1321
;1321:	inuse = bs->inuse;
ADDRLP4 8
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 1322
;1322:	client = bs->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1323
;1323:	entitynum = bs->entitynum;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1324
;1324:	character = bs->character;
ADDRLP4 320
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ASGNI4
line 1325
;1325:	movestate = bs->ms;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ASGNI4
line 1326
;1326:	goalstate = bs->gs;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ASGNI4
line 1327
;1327:	chatstate = bs->cs;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ASGNI4
line 1328
;1328:	weaponstate = bs->ws;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ASGNI4
line 1329
;1329:	entergame_time = bs->entergame_time;
ADDRLP4 792
ADDRFP4 0
INDIRP4
CNSTI4 6064
ADDP4
INDIRF4
ASGNF4
line 1331
;1330:	//free checkpoints and patrol points
;1331:	BotFreeWaypoints(bs->checkpoints);
ADDRFP4 0
INDIRP4
CNSTI4 9076
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 1332
;1332:	BotFreeWaypoints(bs->patrolpoints);
ADDRFP4 0
INDIRP4
CNSTI4 9080
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 1334
;1333:	//reset the whole state
;1334:	memset(bs, 0, sizeof(bot_state_t));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 9092
ARGU4
ADDRGP4 memset
CALLP4
pop
line 1336
;1335:	//copy back some state stuff that should not be reset
;1336:	bs->ms = movestate;
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1337
;1337:	bs->gs = goalstate;
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1338
;1338:	bs->cs = chatstate;
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 1339
;1339:	bs->ws = weaponstate;
ADDRFP4 0
INDIRP4
CNSTI4 6536
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 1340
;1340:	memcpy(&bs->cur_ps, &ps, sizeof(playerState_t));
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 324
ARGP4
CNSTU4 468
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 1341
;1341:	memcpy(&bs->settings, &settings, sizeof(bot_settings_t));
ADDRFP4 0
INDIRP4
CNSTI4 4608
ADDP4
ARGP4
ADDRLP4 28
ARGP4
CNSTU4 292
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 1342
;1342:	bs->inuse = inuse;
ADDRFP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ASGNI4
line 1343
;1343:	bs->client = client;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1344
;1344:	bs->entitynum = entitynum;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1345
;1345:	bs->character = character;
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
ADDRLP4 320
INDIRI4
ASGNI4
line 1346
;1346:	bs->entergame_time = entergame_time;
ADDRFP4 0
INDIRP4
CNSTI4 6064
ADDP4
ADDRLP4 792
INDIRF4
ASGNF4
line 1348
;1347:	//reset several states
;1348:	if (bs->ms) trap_BotResetMoveState(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
CNSTI4 0
EQI4 $595
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetMoveState
CALLV
pop
LABELV $595
line 1349
;1349:	if (bs->gs) trap_BotResetGoalState(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
CNSTI4 0
EQI4 $597
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetGoalState
CALLV
pop
LABELV $597
line 1350
;1350:	if (bs->ws) trap_BotResetWeaponState(bs->ws);
ADDRFP4 0
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
CNSTI4 0
EQI4 $599
ADDRFP4 0
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetWeaponState
CALLV
pop
LABELV $599
line 1351
;1351:	if (bs->gs) trap_BotResetAvoidGoals(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
CNSTI4 0
EQI4 $601
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidGoals
CALLV
pop
LABELV $601
line 1352
;1352:	if (bs->ms) trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
CNSTI4 0
EQI4 $603
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
LABELV $603
line 1353
;1353:}
LABELV $594
endproc BotResetState 796 12
export BotAILoadMap
proc BotAILoadMap 1040 12
line 1360
;1354:
;1355:/*
;1356:==============
;1357:BotAILoadMap
;1358:==============
;1359:*/
;1360:int BotAILoadMap( int restart ) {
line 1364
;1361:	char		serverinfo[MAX_INFO_STRING];
;1362:	int			i;
;1363:
;1364:	trap_GetServerinfo( serverinfo, sizeof( serverinfo ) );
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetServerinfo
CALLV
pop
line 1365
;1365:	Q_strncpyz( mapname, Info_ValueForKey( serverinfo, "mapname" ), sizeof( mapname ) );
ADDRLP4 4
ARGP4
ADDRGP4 $606
ARGP4
ADDRLP4 1028
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 mapname
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1367
;1366:
;1367:	if ( !restart ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $607
line 1368
;1368:		trap_BotLibLoadMap( mapname );
ADDRGP4 mapname
ARGP4
ADDRGP4 trap_BotLibLoadMap
CALLI4
pop
line 1369
;1369:	}
LABELV $607
line 1371
;1370:
;1371:	for ( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $612
JUMPV
LABELV $609
line 1372
;1372:		if ( botstates[i] && botstates[i]->inuse ) {
ADDRLP4 1036
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1036
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $614
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1036
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $614
line 1373
;1373:			BotResetState( botstates[i] );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotResetState
CALLV
pop
line 1374
;1374:			botstates[i]->setupcount = 4;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 6016
ADDP4
CNSTI4 4
ASGNI4
line 1375
;1375:		}
LABELV $614
line 1376
;1376:	}
LABELV $610
line 1371
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $612
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $609
line 1378
;1377:
;1378:	BotSetupDeathmatchAI();
ADDRGP4 BotSetupDeathmatchAI
CALLV
pop
line 1380
;1379:
;1380:	return qtrue;
CNSTI4 1
RETI4
LABELV $605
endproc BotAILoadMap 1040 12
bss
align 4
LABELV $617
skip 4
align 4
LABELV $618
skip 4
align 4
LABELV $619
skip 4
align 4
LABELV $620
skip 4096
align 4
LABELV $621
skip 4
export BotAIStartFrame
code
proc BotAIStartFrame 156 12
line 1392
;1381:}
;1382:
;1383:#ifdef MISSIONPACK
;1384:void ProximityMine_Trigger( gentity_t *trigger, gentity_t *other, trace_t *trace );
;1385:#endif
;1386:
;1387:/*
;1388:==================
;1389:BotAIStartFrame
;1390:==================
;1391:*/
;1392:int BotAIStartFrame(int time) {
line 1402
;1393:	int i;
;1394:	gentity_t	*ent;
;1395:	bot_entitystate_t state;
;1396:	int elapsed_time, thinktime;
;1397:	static int local_time;
;1398:	static int botlib_residual;
;1399:	static int lastbotthink_time;
;1400:	static qboolean skip[MAX_GENTITIES], *s;
;1401:
;1402:	G_CheckBotSpawn();
ADDRGP4 G_CheckBotSpawn
CALLV
pop
line 1404
;1403:
;1404:	trap_Cvar_Update(&bot_rocketjump);
ADDRGP4 bot_rocketjump
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1405
;1405:	trap_Cvar_Update(&bot_grapple);
ADDRGP4 bot_grapple
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1406
;1406:	trap_Cvar_Update(&bot_fastchat);
ADDRGP4 bot_fastchat
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1407
;1407:	trap_Cvar_Update(&bot_nochat);
ADDRGP4 bot_nochat
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1408
;1408:	trap_Cvar_Update(&bot_testrchat);
ADDRGP4 bot_testrchat
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1409
;1409:	trap_Cvar_Update(&bot_thinktime);
ADDRGP4 bot_thinktime
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1410
;1410:	trap_Cvar_Update(&bot_memorydump);
ADDRGP4 bot_memorydump
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1411
;1411:	trap_Cvar_Update(&bot_saveroutingcache);
ADDRGP4 bot_saveroutingcache
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1412
;1412:	trap_Cvar_Update(&bot_pause);
ADDRGP4 bot_pause
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1413
;1413:	trap_Cvar_Update(&bot_report);
ADDRGP4 bot_report
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1415
;1414:
;1415:	if (bot_report.integer) {
ADDRGP4 bot_report+12
INDIRI4
CNSTI4 0
EQI4 $622
line 1418
;1416://		BotTeamplayReport();
;1417://		trap_Cvar_Set("bot_report", "0");
;1418:		BotUpdateInfoConfigStrings();
ADDRGP4 BotUpdateInfoConfigStrings
CALLV
pop
line 1419
;1419:	}
LABELV $622
line 1421
;1420:
;1421:	if (bot_pause.integer) {
ADDRGP4 bot_pause+12
INDIRI4
CNSTI4 0
EQI4 $625
line 1423
;1422:		// execute bot user commands every frame
;1423:		for( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $631
JUMPV
LABELV $628
line 1424
;1424:			if( !botstates[i] || !botstates[i]->inuse ) {
ADDRLP4 132
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 132
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $635
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 132
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $633
LABELV $635
line 1425
;1425:				continue;
ADDRGP4 $629
JUMPV
LABELV $633
line 1427
;1426:			}
;1427:			if( g_entities[i].client->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $636
line 1428
;1428:				continue;
ADDRGP4 $629
JUMPV
LABELV $636
line 1430
;1429:			}
;1430:			botstates[i]->lastucmd.forwardmove = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 509
ADDP4
CNSTI1 0
ASGNI1
line 1431
;1431:			botstates[i]->lastucmd.rightmove = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 510
ADDP4
CNSTI1 0
ASGNI1
line 1432
;1432:			botstates[i]->lastucmd.upmove = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 511
ADDP4
CNSTI1 0
ASGNI1
line 1433
;1433:			botstates[i]->lastucmd.buttons = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 504
ADDP4
CNSTI4 0
ASGNI4
line 1434
;1434:			botstates[i]->lastucmd.serverTime = time;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1435
;1435:			trap_BotUserCommand(botstates[i]->client, &botstates[i]->lastucmd);
ADDRLP4 140
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 140
INDIRP4
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 140
INDIRP4
ADDP4
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRGP4 trap_BotUserCommand
CALLV
pop
line 1436
;1436:		}
LABELV $629
line 1423
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $631
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $628
line 1437
;1437:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $616
JUMPV
LABELV $625
line 1440
;1438:	}
;1439:
;1440:	if (bot_memorydump.integer) {
ADDRGP4 bot_memorydump+12
INDIRI4
CNSTI4 0
EQI4 $639
line 1441
;1441:		trap_BotLibVarSet("memorydump", "1");
ADDRGP4 $642
ARGP4
ADDRGP4 $341
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1442
;1442:		trap_Cvar_Set("bot_memorydump", "0");
ADDRGP4 $643
ARGP4
ADDRGP4 $644
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1443
;1443:	}
LABELV $639
line 1444
;1444:	if (bot_saveroutingcache.integer) {
ADDRGP4 bot_saveroutingcache+12
INDIRI4
CNSTI4 0
EQI4 $645
line 1445
;1445:		trap_BotLibVarSet("saveroutingcache", "1");
ADDRGP4 $648
ARGP4
ADDRGP4 $341
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1446
;1446:		trap_Cvar_Set("bot_saveroutingcache", "0");
ADDRGP4 $649
ARGP4
ADDRGP4 $644
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1447
;1447:	}
LABELV $645
line 1449
;1448:	//check if bot interbreeding is activated
;1449:	BotInterbreeding();
ADDRGP4 BotInterbreeding
CALLV
pop
line 1451
;1450:	//cap the bot think time
;1451:	if (bot_thinktime.integer > 200) {
ADDRGP4 bot_thinktime+12
INDIRI4
CNSTI4 200
LEI4 $650
line 1452
;1452:		trap_Cvar_Set("bot_thinktime", "200");
ADDRGP4 $653
ARGP4
ADDRGP4 $654
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1453
;1453:	}
LABELV $650
line 1455
;1454:	//if the bot think time changed we should reschedule the bots
;1455:	if (bot_thinktime.integer != lastbotthink_time) {
ADDRGP4 bot_thinktime+12
INDIRI4
ADDRGP4 $619
INDIRI4
EQI4 $655
line 1456
;1456:		lastbotthink_time = bot_thinktime.integer;
ADDRGP4 $619
ADDRGP4 bot_thinktime+12
INDIRI4
ASGNI4
line 1457
;1457:		BotScheduleBotThink();
ADDRGP4 BotScheduleBotThink
CALLV
pop
line 1458
;1458:	}
LABELV $655
line 1460
;1459:
;1460:	elapsed_time = time - local_time;
ADDRLP4 120
ADDRFP4 0
INDIRI4
ADDRGP4 $617
INDIRI4
SUBI4
ASGNI4
line 1461
;1461:	local_time = time;
ADDRGP4 $617
ADDRFP4 0
INDIRI4
ASGNI4
line 1463
;1462:
;1463:	botlib_residual += elapsed_time;
ADDRLP4 128
ADDRGP4 $618
ASGNP4
ADDRLP4 128
INDIRP4
ADDRLP4 128
INDIRP4
INDIRI4
ADDRLP4 120
INDIRI4
ADDI4
ASGNI4
line 1465
;1464:
;1465:	if (elapsed_time > bot_thinktime.integer) thinktime = elapsed_time;
ADDRLP4 120
INDIRI4
ADDRGP4 bot_thinktime+12
INDIRI4
LEI4 $659
ADDRLP4 124
ADDRLP4 120
INDIRI4
ASGNI4
ADDRGP4 $660
JUMPV
LABELV $659
line 1466
;1466:	else thinktime = bot_thinktime.integer;
ADDRLP4 124
ADDRGP4 bot_thinktime+12
INDIRI4
ASGNI4
LABELV $660
line 1469
;1467:
;1468:	// update the bot library
;1469:	if ( botlib_residual >= thinktime ) {
ADDRGP4 $618
INDIRI4
ADDRLP4 124
INDIRI4
LTI4 $663
line 1470
;1470:		botlib_residual -= thinktime;
ADDRLP4 132
ADDRGP4 $618
ASGNP4
ADDRLP4 132
INDIRP4
ADDRLP4 132
INDIRP4
INDIRI4
ADDRLP4 124
INDIRI4
SUBI4
ASGNI4
line 1472
;1471:
;1472:		trap_BotLibStartFrame((float) time / 1000);
ADDRFP4 0
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ARGF4
ADDRGP4 trap_BotLibStartFrame
CALLI4
pop
line 1474
;1473:
;1474:		if (!trap_AAS_Initialized()) return qfalse;
ADDRLP4 136
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 0
NEI4 $665
CNSTI4 0
RETI4
ADDRGP4 $616
JUMPV
LABELV $665
line 1477
;1475:
;1476:		//update entities in the botlib
;1477:		s = skip;
ADDRGP4 $621
ADDRGP4 $620
ASGNP4
line 1478
;1478:		ent = g_entities;
ADDRLP4 4
ADDRGP4 g_entities
ASGNP4
line 1479
;1479:		for ( i = 0; i < level.num_entities; i++, s++, ent++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $670
JUMPV
LABELV $667
line 1480
;1480:			ent = &g_entities[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1481
;1481:			if ( !ent->inuse || !ent->r.linked || ent->r.svFlags & SVF_NOCLIENT ) {
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $675
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
EQI4 $675
ADDRLP4 4
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $672
LABELV $675
line 1482
;1482:				if ( *s == qfalse ) {
ADDRGP4 $621
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $668
line 1483
;1483:					*s = qtrue;
ADDRGP4 $621
INDIRP4
CNSTI4 1
ASGNI4
line 1484
;1484:					trap_BotLibUpdateEntity( i, NULL );
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1485
;1485:				}
line 1486
;1486:				continue;
ADDRGP4 $668
JUMPV
LABELV $672
line 1489
;1487:			}
;1488:			// do not update missiles
;1489:			if ( ent->s.eType == ET_MISSILE && ent->s.weapon != WP_GRAPPLING_HOOK ) {
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $678
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 10
EQI4 $678
line 1490
;1490:				if ( *s == qfalse ) {
ADDRGP4 $621
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $668
line 1491
;1491:					*s = qtrue;
ADDRGP4 $621
INDIRP4
CNSTI4 1
ASGNI4
line 1492
;1492:					trap_BotLibUpdateEntity( i, NULL );
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1493
;1493:				}
line 1494
;1494:				continue;
ADDRGP4 $668
JUMPV
LABELV $678
line 1497
;1495:			}
;1496:			// do not update event only entities
;1497:			if ( ent->s.eType > ET_EVENTS ) {
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
LEI4 $682
line 1498
;1498:				if ( *s == qfalse ) {
ADDRGP4 $621
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $668
line 1499
;1499:					*s = qtrue;
ADDRGP4 $621
INDIRP4
CNSTI4 1
ASGNI4
line 1500
;1500:					trap_BotLibUpdateEntity( i, NULL );
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1501
;1501:				}
line 1502
;1502:				continue;
ADDRGP4 $668
JUMPV
LABELV $682
line 1506
;1503:			}
;1504:#ifdef MISSIONPACK
;1505:			// never link prox mine triggers
;1506:			if (ent->r.contents == CONTENTS_TRIGGER) {
ADDRLP4 4
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
CNSTI4 1073741824
NEI4 $686
line 1507
;1507:				if (ent->touch == ProximityMine_Trigger) {
ADDRLP4 4
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 ProximityMine_Trigger
CVPU4 4
NEU4 $688
line 1508
;1508:					trap_BotLibUpdateEntity(i, NULL);
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1509
;1509:					continue;
ADDRGP4 $668
JUMPV
LABELV $688
line 1511
;1510:				}
;1511:			}
LABELV $686
line 1514
;1512:#endif
;1513:			//
;1514:			memset(&state, 0, sizeof(bot_entitystate_t));
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
CNSTU4 112
ARGU4
ADDRGP4 memset
CALLP4
pop
line 1516
;1515:			//
;1516:			VectorCopy(ent->r.currentOrigin, state.origin);
ADDRLP4 8+8
ADDRLP4 4
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 1517
;1517:			if (i < MAX_CLIENTS) {
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $691
line 1518
;1518:				VectorCopy(ent->s.apos.trBase, state.angles);
ADDRLP4 8+20
ADDRLP4 4
INDIRP4
CNSTI4 60
ADDP4
INDIRB
ASGNB 12
line 1519
;1519:			} else {
ADDRGP4 $692
JUMPV
LABELV $691
line 1520
;1520:				VectorCopy(ent->r.currentAngles, state.angles);
ADDRLP4 8+20
ADDRLP4 4
INDIRP4
CNSTI4 500
ADDP4
INDIRB
ASGNB 12
line 1521
;1521:			}
LABELV $692
line 1522
;1522:			VectorCopy(ent->s.origin2, state.old_origin);
ADDRLP4 8+32
ADDRLP4 4
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 1523
;1523:			VectorCopy(ent->r.mins, state.mins);
ADDRLP4 8+44
ADDRLP4 4
INDIRP4
CNSTI4 436
ADDP4
INDIRB
ASGNB 12
line 1524
;1524:			VectorCopy(ent->r.maxs, state.maxs);
ADDRLP4 8+56
ADDRLP4 4
INDIRP4
CNSTI4 448
ADDP4
INDIRB
ASGNB 12
line 1525
;1525:			state.type = ent->s.eType;
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1526
;1526:			state.flags = ent->s.eFlags;
ADDRLP4 8+4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1527
;1527:			if (ent->r.bmodel) state.solid = SOLID_BSP;
ADDRLP4 4
INDIRP4
CNSTI4 432
ADDP4
INDIRI4
CNSTI4 0
EQI4 $699
ADDRLP4 8+72
CNSTI4 3
ASGNI4
ADDRGP4 $700
JUMPV
LABELV $699
line 1528
;1528:			else state.solid = SOLID_BBOX;
ADDRLP4 8+72
CNSTI4 2
ASGNI4
LABELV $700
line 1529
;1529:			state.groundent = ent->s.groundEntityNum;
ADDRLP4 8+68
ADDRLP4 4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ASGNI4
line 1530
;1530:			state.modelindex = ent->s.modelindex;
ADDRLP4 8+76
ADDRLP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ASGNI4
line 1531
;1531:			state.modelindex2 = ent->s.modelindex2;
ADDRLP4 8+80
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ASGNI4
line 1532
;1532:			state.frame = ent->s.frame;
ADDRLP4 8+84
ADDRLP4 4
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ASGNI4
line 1533
;1533:			state.event = ent->s.event;
ADDRLP4 8+88
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ASGNI4
line 1534
;1534:			state.eventParm = ent->s.eventParm;
ADDRLP4 8+92
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 1535
;1535:			state.powerups = ent->s.powerups;
ADDRLP4 8+96
ADDRLP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
line 1536
;1536:			state.legsAnim = ent->s.legsAnim;
ADDRLP4 8+104
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 1537
;1537:			state.torsoAnim = ent->s.torsoAnim;
ADDRLP4 8+108
ADDRLP4 4
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ASGNI4
line 1538
;1538:			state.weapon = ent->s.weapon;
ADDRLP4 8+100
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
line 1540
;1539:			//
;1540:			*s = qfalse;
ADDRGP4 $621
INDIRP4
CNSTI4 0
ASGNI4
line 1541
;1541:			trap_BotLibUpdateEntity( i, &state );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1542
;1542:		}
LABELV $668
line 1479
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 140
ADDRGP4 $621
ASGNP4
ADDRLP4 140
INDIRP4
ADDRLP4 140
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 824
ADDP4
ASGNP4
LABELV $670
ADDRLP4 0
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $667
line 1544
;1543:
;1544:		BotAIRegularUpdate();
ADDRGP4 BotAIRegularUpdate
CALLV
pop
line 1545
;1545:	}
LABELV $663
line 1547
;1546:
;1547:	floattime = trap_AAS_Time();
ADDRLP4 132
ADDRGP4 trap_AAS_Time
CALLF4
ASGNF4
ADDRGP4 floattime
ADDRLP4 132
INDIRF4
ASGNF4
line 1550
;1548:
;1549:	// execute scheduled bot AI
;1550:	for( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $716
JUMPV
LABELV $713
line 1551
;1551:		if( !botstates[i] || !botstates[i]->inuse ) {
ADDRLP4 140
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 140
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $720
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 140
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $718
LABELV $720
line 1552
;1552:			continue;
ADDRGP4 $714
JUMPV
LABELV $718
line 1555
;1553:		}
;1554:		//
;1555:		botstates[i]->botthink_residual += elapsed_time;
ADDRLP4 144
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 144
INDIRP4
ADDRLP4 144
INDIRP4
INDIRI4
ADDRLP4 120
INDIRI4
ADDI4
ASGNI4
line 1557
;1556:		//
;1557:		if ( botstates[i]->botthink_residual >= thinktime ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 124
INDIRI4
LTI4 $721
line 1558
;1558:			botstates[i]->botthink_residual -= thinktime;
ADDRLP4 148
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
ADDRLP4 148
INDIRP4
INDIRI4
ADDRLP4 124
INDIRI4
SUBI4
ASGNI4
line 1560
;1559:
;1560:			if (!trap_AAS_Initialized()) return qfalse;
ADDRLP4 152
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $723
CNSTI4 0
RETI4
ADDRGP4 $616
JUMPV
LABELV $723
line 1562
;1561:
;1562:			if (g_entities[i].client->pers.connected == CON_CONNECTED) {
ADDRLP4 0
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $725
line 1563
;1563:				BotAI(i, (float) thinktime / 1000);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 124
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ARGF4
ADDRGP4 BotAI
CALLI4
pop
line 1564
;1564:			}
LABELV $725
line 1565
;1565:		}
LABELV $721
line 1566
;1566:	}
LABELV $714
line 1550
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $716
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $713
line 1570
;1567:
;1568:
;1569:	// execute bot user commands every frame
;1570:	for( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $731
JUMPV
LABELV $728
line 1571
;1571:		if( !botstates[i] || !botstates[i]->inuse ) {
ADDRLP4 140
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 140
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $735
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 140
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $733
LABELV $735
line 1572
;1572:			continue;
ADDRGP4 $729
JUMPV
LABELV $733
line 1574
;1573:		}
;1574:		if( g_entities[i].client->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $736
line 1575
;1575:			continue;
ADDRGP4 $729
JUMPV
LABELV $736
line 1578
;1576:		}
;1577:
;1578:		BotUpdateInput(botstates[i], time, elapsed_time);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 120
INDIRI4
ARGI4
ADDRGP4 BotUpdateInput
CALLV
pop
line 1579
;1579:		trap_BotUserCommand(botstates[i]->client, &botstates[i]->lastucmd);
ADDRLP4 148
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
INDIRP4
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
INDIRP4
ADDP4
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRGP4 trap_BotUserCommand
CALLV
pop
line 1580
;1580:	}
LABELV $729
line 1570
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $731
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $728
line 1582
;1581:
;1582:	return qtrue;
CNSTI4 1
RETI4
LABELV $616
endproc BotAIStartFrame 156 12
export BotInitLibrary
proc BotInitLibrary 260 16
line 1590
;1583:}
;1584:
;1585:/*
;1586:==============
;1587:BotInitLibrary
;1588:==============
;1589:*/
;1590:int BotInitLibrary( void ) {
line 1594
;1591:	char buf[MAX_CVAR_VALUE_STRING];
;1592:
;1593:	//set the maxclients and maxentities library variables before calling BotSetupLibrary
;1594:	trap_Cvar_VariableStringBuffer( "sv_maxclients", buf, sizeof( buf ) );
ADDRGP4 $740
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1595
;1595:	if ( !buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $741
line 1596
;1596:		strcpy( buf, "8" );
ADDRLP4 0
ARGP4
ADDRGP4 $743
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $741
line 1597
;1597:	trap_BotLibVarSet( "maxclients", buf );
ADDRGP4 $744
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1599
;1598:
;1599:	Com_sprintf(buf, sizeof(buf), "%d", MAX_GENTITIES);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $332
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1600
;1600:	trap_BotLibVarSet("maxentities", buf);
ADDRGP4 $745
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1602
;1601:	//bsp checksum
;1602:	trap_Cvar_VariableStringBuffer("sv_mapChecksum", buf, sizeof(buf));
ADDRGP4 $746
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1603
;1603:	if ( buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $747
line 1604
;1604:		trap_BotLibVarSet( "sv_mapChecksum", buf );
ADDRGP4 $746
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $747
line 1607
;1605:
;1606:	//maximum number of aas links
;1607:	trap_Cvar_VariableStringBuffer("max_aaslinks", buf, sizeof(buf));
ADDRGP4 $749
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1608
;1608:	if ( buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $750
line 1609
;1609:		trap_BotLibVarSet( "max_aaslinks", buf );
ADDRGP4 $749
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $750
line 1612
;1610:
;1611:	//maximum number of items in a level
;1612:	trap_Cvar_VariableStringBuffer("max_levelitems", buf, sizeof(buf));
ADDRGP4 $752
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1613
;1613:	if ( buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $753
line 1614
;1614:		trap_BotLibVarSet( "max_levelitems", buf );
ADDRGP4 $752
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $753
line 1617
;1615:
;1616:	//game type
;1617:	trap_Cvar_VariableStringBuffer("g_gametype", buf, sizeof(buf));
ADDRGP4 $331
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1618
;1618:	if ( !buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $755
line 1619
;1619:		strcpy( buf, "0" );
ADDRLP4 0
ARGP4
ADDRGP4 $644
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $755
line 1620
;1620:	trap_BotLibVarSet("g_gametype", buf);
ADDRGP4 $331
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1622
;1621:	//bot developer mode and log file
;1622:	trap_BotLibVarSet("bot_developer", bot_developer.string);
ADDRGP4 $757
ARGP4
ADDRGP4 bot_developer+16
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1623
;1623:	trap_BotLibVarSet("log", buf);
ADDRGP4 $759
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1625
;1624:	//no chatting
;1625:	trap_Cvar_VariableStringBuffer("bot_nochat", buf, sizeof(buf));
ADDRGP4 $760
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1626
;1626:	if ( buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $761
line 1627
;1627:		trap_BotLibVarSet( "nochat", "0" );
ADDRGP4 $763
ARGP4
ADDRGP4 $644
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $761
line 1630
;1628:
;1629:	//visualize jump pads
;1630:	trap_Cvar_VariableStringBuffer("bot_visualizejumppads", buf, sizeof(buf));
ADDRGP4 $764
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1631
;1631:	if ( buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $765
line 1632
;1632:		trap_BotLibVarSet( "bot_visualizejumppads", buf );
ADDRGP4 $764
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $765
line 1635
;1633:	
;1634:	//forced clustering calculations
;1635:	trap_Cvar_VariableStringBuffer("bot_forceclustering", buf, sizeof(buf));
ADDRGP4 $767
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1636
;1636:	if ( buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $768
line 1637
;1637:		trap_BotLibVarSet( "forceclustering", buf );
ADDRGP4 $770
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $768
line 1640
;1638:	
;1639:	//forced reachability calculations
;1640:	trap_Cvar_VariableStringBuffer("bot_forcereachability", buf, sizeof(buf));
ADDRGP4 $771
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1641
;1641:	if ( buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $772
line 1642
;1642:		trap_BotLibVarSet( "forcereachability", buf );
ADDRGP4 $774
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $772
line 1645
;1643:	
;1644:	//force writing of AAS to file
;1645:	trap_Cvar_VariableStringBuffer("bot_forcewrite", buf, sizeof(buf));
ADDRGP4 $775
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1646
;1646:	if ( buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $776
line 1647
;1647:		trap_BotLibVarSet( "forcewrite", buf );
ADDRGP4 $778
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $776
line 1650
;1648:	
;1649:	//no AAS optimization
;1650:	trap_Cvar_VariableStringBuffer("bot_aasoptimize", buf, sizeof(buf));
ADDRGP4 $779
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1651
;1651:	if ( buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $780
line 1652
;1652:		trap_BotLibVarSet( "aasoptimize", buf );
ADDRGP4 $782
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $780
line 1655
;1653:	
;1654:	//
;1655:	trap_Cvar_VariableStringBuffer("bot_saveroutingcache", buf, sizeof(buf));
ADDRGP4 $649
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1656
;1656:	if ( buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $783
line 1657
;1657:		trap_BotLibVarSet( "saveroutingcache", buf );
ADDRGP4 $648
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $783
line 1660
;1658:	
;1659:	//reload instead of cache bot character files
;1660:	trap_Cvar_VariableStringBuffer("bot_reloadcharacters", buf, sizeof(buf));
ADDRGP4 $340
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1661
;1661:	if ( !buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $785
line 1662
;1662:		strcpy( buf, "0" );
ADDRLP4 0
ARGP4
ADDRGP4 $644
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $785
line 1663
;1663:	trap_BotLibVarSet("bot_reloadcharacters", buf);
ADDRGP4 $340
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1665
;1664:	//base directory
;1665:	trap_Cvar_VariableStringBuffer("fs_basepath", buf, sizeof(buf));
ADDRGP4 $787
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1666
;1666:	if ( buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $788
line 1667
;1667:		trap_BotLibVarSet( "basedir", buf );
ADDRGP4 $790
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $788
line 1670
;1668:
;1669:	//home directory
;1670:	trap_Cvar_VariableStringBuffer("fs_homepath", buf, sizeof(buf));
ADDRGP4 $791
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1671
;1671:	if ( buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $792
line 1672
;1672:		trap_BotLibVarSet( "homedir", buf );
ADDRGP4 $794
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $792
line 1675
;1673:
;1674:	//game directory
;1675:	trap_Cvar_VariableStringBuffer( "fs_game", buf, sizeof( buf ) );
ADDRGP4 $795
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1676
;1676:	if ( buf[0] ) 
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $796
line 1677
;1677:		trap_BotLibVarSet( "gamedir", buf );
ADDRGP4 $798
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $796
line 1680
;1678:
;1679:#ifdef MISSIONPACK
;1680:	trap_BotLibDefine("MISSIONPACK");
ADDRGP4 $799
ARGP4
ADDRGP4 trap_BotLibDefine
CALLI4
pop
line 1683
;1681:#endif
;1682:	//setup the bot library
;1683:	return trap_BotLibSetup();
ADDRLP4 256
ADDRGP4 trap_BotLibSetup
CALLI4
ASGNI4
ADDRLP4 256
INDIRI4
RETI4
LABELV $739
endproc BotInitLibrary 260 16
export BotAISetup
proc BotAISetup 8 16
line 1691
;1684:}
;1685:
;1686:/*
;1687:==============
;1688:BotAISetup
;1689:==============
;1690:*/
;1691:int BotAISetup( int restart ) {
line 1694
;1692:	int			errnum;
;1693:
;1694:	trap_Cvar_Register(&bot_thinktime, "bot_thinktime", "100", CVAR_CHEAT);
ADDRGP4 bot_thinktime
ARGP4
ADDRGP4 $653
ARGP4
ADDRGP4 $801
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1695
;1695:	trap_Cvar_Register(&bot_memorydump, "bot_memorydump", "0", CVAR_CHEAT);
ADDRGP4 bot_memorydump
ARGP4
ADDRGP4 $643
ARGP4
ADDRGP4 $644
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1696
;1696:	trap_Cvar_Register(&bot_saveroutingcache, "bot_saveroutingcache", "0", CVAR_CHEAT);
ADDRGP4 bot_saveroutingcache
ARGP4
ADDRGP4 $649
ARGP4
ADDRGP4 $644
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1697
;1697:	trap_Cvar_Register(&bot_pause, "bot_pause", "0", CVAR_CHEAT);
ADDRGP4 bot_pause
ARGP4
ADDRGP4 $802
ARGP4
ADDRGP4 $644
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1698
;1698:	trap_Cvar_Register(&bot_report, "bot_report", "0", CVAR_CHEAT);
ADDRGP4 bot_report
ARGP4
ADDRGP4 $803
ARGP4
ADDRGP4 $644
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1699
;1699:	trap_Cvar_Register(&bot_testsolid, "bot_testsolid", "0", CVAR_CHEAT);
ADDRGP4 bot_testsolid
ARGP4
ADDRGP4 $804
ARGP4
ADDRGP4 $644
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1700
;1700:	trap_Cvar_Register(&bot_testclusters, "bot_testclusters", "0", CVAR_CHEAT);
ADDRGP4 bot_testclusters
ARGP4
ADDRGP4 $805
ARGP4
ADDRGP4 $644
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1701
;1701:	trap_Cvar_Register(&bot_developer, "bot_developer", "0", CVAR_CHEAT);
ADDRGP4 bot_developer
ARGP4
ADDRGP4 $757
ARGP4
ADDRGP4 $644
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1702
;1702:	trap_Cvar_Register(&bot_interbreedchar, "bot_interbreedchar", "", 0);
ADDRGP4 bot_interbreedchar
ARGP4
ADDRGP4 $350
ARGP4
ADDRGP4 $324
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1703
;1703:	trap_Cvar_Register(&bot_interbreedbots, "bot_interbreedbots", "10", 0);
ADDRGP4 bot_interbreedbots
ARGP4
ADDRGP4 $806
ARGP4
ADDRGP4 $807
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1704
;1704:	trap_Cvar_Register(&bot_interbreedcycle, "bot_interbreedcycle", "20", 0);
ADDRGP4 bot_interbreedcycle
ARGP4
ADDRGP4 $808
ARGP4
ADDRGP4 $809
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1705
;1705:	trap_Cvar_Register(&bot_interbreedwrite, "bot_interbreedwrite", "", 0);
ADDRGP4 bot_interbreedwrite
ARGP4
ADDRGP4 $323
ARGP4
ADDRGP4 $324
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1708
;1706:
;1707:	//if the game is restarted for a tournament
;1708:	if (restart) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $810
line 1709
;1709:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $800
JUMPV
LABELV $810
line 1713
;1710:	}
;1711:
;1712:	//initialize the bot states
;1713:	memset( botstates, 0, sizeof(botstates) );
ADDRGP4 botstates
ARGP4
CNSTI4 0
ARGI4
CNSTU4 256
ARGU4
ADDRGP4 memset
CALLP4
pop
line 1715
;1714:
;1715:	errnum = BotInitLibrary();
ADDRLP4 4
ADDRGP4 BotInitLibrary
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1716
;1716:	if ( errnum != BLERR_NOERROR )
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $812
line 1717
;1717:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $800
JUMPV
LABELV $812
line 1719
;1718:
;1719:	return qtrue;
CNSTI4 1
RETI4
LABELV $800
endproc BotAISetup 8 16
export BotAIShutdown
proc BotAIShutdown 12 8
line 1727
;1720:}
;1721:
;1722:/*
;1723:==============
;1724:BotAIShutdown
;1725:==============
;1726:*/
;1727:int BotAIShutdown( int restart ) {
line 1732
;1728:
;1729:	int i;
;1730:
;1731:	//if the game is restarted for a tournament
;1732:	if ( restart ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $815
line 1734
;1733:		//shutdown all the bots in the botlib
;1734:		for ( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $820
JUMPV
LABELV $817
line 1735
;1735:			if ( botstates[i] && botstates[i]->inuse ) {
ADDRLP4 8
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $822
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $822
line 1736
;1736:				BotAIShutdownClient(botstates[i]->client, restart);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 BotAIShutdownClient
CALLI4
pop
line 1737
;1737:			}
LABELV $822
line 1738
;1738:		}
LABELV $818
line 1734
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $820
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $817
line 1740
;1739:		//don't shutdown the bot library
;1740:	}
ADDRGP4 $816
JUMPV
LABELV $815
line 1741
;1741:	else {
line 1742
;1742:		trap_BotLibShutdown();
ADDRGP4 trap_BotLibShutdown
CALLI4
pop
line 1743
;1743:	}
LABELV $816
line 1744
;1744:	return qtrue;
CNSTI4 1
RETI4
LABELV $814
endproc BotAIShutdown 12 8
import ProximityMine_Trigger
import ExitLevel
bss
export bot_interbreedwrite
align 4
LABELV bot_interbreedwrite
skip 272
export bot_interbreedcycle
align 4
LABELV bot_interbreedcycle
skip 272
export bot_interbreedbots
align 4
LABELV bot_interbreedbots
skip 272
export bot_interbreedchar
align 4
LABELV bot_interbreedchar
skip 272
export bot_developer
align 4
LABELV bot_developer
skip 272
export bot_testclusters
align 4
LABELV bot_testclusters
skip 272
export bot_testsolid
align 4
LABELV bot_testsolid
skip 272
export bot_report
align 4
LABELV bot_report
skip 272
export bot_pause
align 4
LABELV bot_pause
skip 272
export bot_saveroutingcache
align 4
LABELV bot_saveroutingcache
skip 272
export bot_memorydump
align 4
LABELV bot_memorydump
skip 272
export bot_thinktime
align 4
LABELV bot_thinktime
skip 272
export bot_interbreedmatchcount
align 4
LABELV bot_interbreedmatchcount
skip 4
export bot_interbreed
align 4
LABELV bot_interbreed
skip 4
export regularupdate_time
align 4
LABELV regularupdate_time
skip 4
export numbots
align 4
LABELV numbots
skip 4
export botstates
align 4
LABELV botstates
skip 256
import BotVoiceChat_Defend
import BotVoiceChatCommand
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
import neutralobelisk
import blueobelisk
import redobelisk
import ctf_neutralflag
import ctf_blueflag
import ctf_redflag
import bot_challenge
import bot_testrchat
import bot_nochat
import bot_fastchat
import bot_rocketjump
import bot_grapple
export mapname
align 1
LABELV mapname
skip 64
import gametype
import BotMapScripts
import BotPointAreaNum
import ClientOnSameTeamFromName
import ClientFromName
import stristr
import BotFindWayPoint
import BotCreateWayPoint
import BotAlternateRoute
import BotGetAlternateRouteGoal
import BotEnemyCubeCarrierVisible
import BotTeamCubeCarrierVisible
import BotHarvesterRetreatGoals
import BotHarvesterSeekGoals
import BotGoHarvest
import BotObeliskRetreatGoals
import BotObeliskSeekGoals
import Bot1FCTFRetreatGoals
import Bot1FCTFSeekGoals
import BotHarvesterCarryingCubes
import Bot1FCTFCarryingFlag
import BotCTFRetreatGoals
import BotCTFSeekGoals
import BotRememberLastOrderedTask
import BotCTFCarryingFlag
import BotOppositeTeam
import BotTeam
import BotClearActivateGoalStack
import BotPopFromActivateGoalStack
import BotEnableActivateGoalAreas
import BotAIPredictObstacles
import BotAIBlocked
import BotCheckAttack
import BotAimAtEnemy
import BotEntityVisible
import BotRoamGoal
import BotFindEnemy
import InFieldOfVision
import BotVisibleTeamMatesAndEnemies
import BotEnemyFlagCarrierVisible
import BotTeamFlagCarrierVisible
import BotTeamFlagCarrier
import TeamPlayIsOn
import BotSameTeam
import BotAttackMove
import BotWantsToCamp
import BotHasPersistantPowerupAndWeapon
import BotCanAndWantsToRocketJump
import BotWantsToHelp
import BotWantsToChase
import BotWantsToRetreat
import BotFeelingBad
import BotAggression
import BotTeamGoals
import BotSetLastOrderedTask
import BotSynonymContext
import ClientSkin
import EasyClientName
import ClientName
import BotSetTeamStatus
import EntityHasKamikaze
import EntityIsShooting
import EntityIsInvisible
import EntityIsDead
import BotInLavaOrSlime
import BotIntermission
import BotIsObserver
import BotIsDead
import BotBattleUseItems
import BotUpdateBattleInventory
import BotUpdateInventory
import BotSetupForMovement
import BotChooseWeapon
import BotFreeWaypoints
import BotDeathmatchAI
import BotShutdownDeathmatchAI
import BotSetupDeathmatchAI
export floattime
align 4
LABELV floattime
skip 4
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
LABELV $809
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $808
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 98
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 99
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $807
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $806
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 98
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $805
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 99
byte 1 108
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $804
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 115
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 0
align 1
LABELV $803
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 114
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $802
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 112
byte 1 97
byte 1 117
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $801
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $799
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 73
byte 1 79
byte 1 78
byte 1 80
byte 1 65
byte 1 67
byte 1 75
byte 1 0
align 1
LABELV $798
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $795
byte 1 102
byte 1 115
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $794
byte 1 104
byte 1 111
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $791
byte 1 102
byte 1 115
byte 1 95
byte 1 104
byte 1 111
byte 1 109
byte 1 101
byte 1 112
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $790
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 100
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $787
byte 1 102
byte 1 115
byte 1 95
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 112
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $782
byte 1 97
byte 1 97
byte 1 115
byte 1 111
byte 1 112
byte 1 116
byte 1 105
byte 1 109
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $779
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 97
byte 1 97
byte 1 115
byte 1 111
byte 1 112
byte 1 116
byte 1 105
byte 1 109
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $778
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 119
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $775
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 119
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $774
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 101
byte 1 97
byte 1 99
byte 1 104
byte 1 97
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $771
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 101
byte 1 97
byte 1 99
byte 1 104
byte 1 97
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $770
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 99
byte 1 108
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $767
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 99
byte 1 108
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $764
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 118
byte 1 105
byte 1 115
byte 1 117
byte 1 97
byte 1 108
byte 1 105
byte 1 122
byte 1 101
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 112
byte 1 97
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $763
byte 1 110
byte 1 111
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $760
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
LABELV $759
byte 1 108
byte 1 111
byte 1 103
byte 1 0
align 1
LABELV $757
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 100
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 111
byte 1 112
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $752
byte 1 109
byte 1 97
byte 1 120
byte 1 95
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $749
byte 1 109
byte 1 97
byte 1 120
byte 1 95
byte 1 97
byte 1 97
byte 1 115
byte 1 108
byte 1 105
byte 1 110
byte 1 107
byte 1 115
byte 1 0
align 1
LABELV $746
byte 1 115
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 112
byte 1 67
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 115
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $745
byte 1 109
byte 1 97
byte 1 120
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 105
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $744
byte 1 109
byte 1 97
byte 1 120
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $743
byte 1 56
byte 1 0
align 1
LABELV $740
byte 1 115
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $654
byte 1 50
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $653
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 107
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $649
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 114
byte 1 111
byte 1 117
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 0
align 1
LABELV $648
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 114
byte 1 111
byte 1 117
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 0
align 1
LABELV $644
byte 1 48
byte 1 0
align 1
LABELV $643
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 100
byte 1 117
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $642
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 100
byte 1 117
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $606
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $581
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $566
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $563
byte 1 65
byte 1 65
byte 1 83
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 105
byte 1 116
byte 1 105
byte 1 97
byte 1 108
byte 1 105
byte 1 122
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $560
byte 1 66
byte 1 111
byte 1 116
byte 1 65
byte 1 73
byte 1 83
byte 1 101
byte 1 116
byte 1 117
byte 1 112
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 117
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $551
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $550
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 0
align 1
LABELV $531
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 76
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $528
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $525
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $522
byte 1 118
byte 1 116
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $519
byte 1 118
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $516
byte 1 116
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $513
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $510
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $507
byte 1 99
byte 1 115
byte 1 0
align 1
LABELV $504
byte 1 99
byte 1 112
byte 1 32
byte 1 0
align 1
LABELV $496
byte 1 66
byte 1 111
byte 1 116
byte 1 65
byte 1 73
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 117
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $350
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 98
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $347
byte 1 97
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 52
byte 1 32
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $341
byte 1 49
byte 1 0
align 1
LABELV $340
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 114
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $332
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $331
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
LABELV $324
byte 1 0
align 1
LABELV $323
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 98
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 119
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $274
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 99
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 97
byte 1 92
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $271
byte 1 114
byte 1 111
byte 1 97
byte 1 109
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $269
byte 1 104
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $267
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $265
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $263
byte 1 114
byte 1 117
byte 1 115
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $261
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $259
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $257
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $255
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $253
byte 1 103
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $251
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $249
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $247
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $242
byte 1 37
byte 1 50
byte 1 100
byte 1 0
align 1
LABELV $231
byte 1 70
byte 1 32
byte 1 0
align 1
LABELV $210
byte 1 94
byte 1 52
byte 1 66
byte 1 76
byte 1 85
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $209
byte 1 116
byte 1 0
align 1
LABELV $205
byte 1 110
byte 1 0
align 1
LABELV $194
byte 1 94
byte 1 49
byte 1 82
byte 1 69
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $190
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 114
byte 1 111
byte 1 97
byte 1 109
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $189
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 104
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $187
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $185
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $183
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 114
byte 1 117
byte 1 115
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $181
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $179
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $177
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $175
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $173
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $171
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $169
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $167
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $162
byte 1 94
byte 1 52
byte 1 37
byte 1 50
byte 1 100
byte 1 0
align 1
LABELV $161
byte 1 94
byte 1 49
byte 1 37
byte 1 50
byte 1 100
byte 1 0
align 1
LABELV $148
byte 1 94
byte 1 52
byte 1 70
byte 1 32
byte 1 0
align 1
LABELV $147
byte 1 94
byte 1 49
byte 1 70
byte 1 32
byte 1 0
align 1
LABELV $140
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $139
byte 1 32
byte 1 0
align 1
LABELV $138
byte 1 76
byte 1 0
align 1
LABELV $133
byte 1 13
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 32
byte 1 37
byte 1 100
byte 1 44
byte 1 32
byte 1 99
byte 1 108
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $132
byte 1 13
byte 1 94
byte 1 49
byte 1 83
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 33
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $124
byte 1 13
byte 1 94
byte 1 49
byte 1 83
byte 1 79
byte 1 76
byte 1 73
byte 1 68
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 0
align 1
LABELV $123
byte 1 13
byte 1 101
byte 1 109
byte 1 112
byte 1 116
byte 1 121
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 0
align 1
LABELV $69
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $68
byte 1 94
byte 1 49
byte 1 69
byte 1 120
byte 1 105
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $66
byte 1 94
byte 1 49
byte 1 70
byte 1 97
byte 1 116
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $64
byte 1 94
byte 1 49
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $62
byte 1 94
byte 1 51
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $60
byte 1 37
byte 1 115
byte 1 0
