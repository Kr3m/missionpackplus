export BotGetItemTeamGoal
code
proc BotGetItemTeamGoal 12 12
file "../../../../code/game/ai_cmd.c"
line 141
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:/*****************************************************************************
;5: * name:		ai_cmd.c
;6: *
;7: * desc:		Quake3 bot AI
;8: *
;9: * $Archive: /MissionPack/code/game/ai_cmd.c $
;10: *
;11: *****************************************************************************/
;12:
;13:#include "g_local.h"
;14:#include "botlib.h"
;15:#include "be_aas.h"
;16:#include "be_ea.h"
;17:#include "be_ai_char.h"
;18:#include "be_ai_chat.h"
;19:#include "be_ai_gen.h"
;20:#include "be_ai_goal.h"
;21:#include "be_ai_move.h"
;22:#include "be_ai_weap.h"
;23://
;24:#include "ai_main.h"
;25:#include "ai_dmq3.h"
;26:#include "ai_chat.h"
;27:#include "ai_cmd.h"
;28:#include "ai_dmnet.h"
;29:#include "ai_team.h"
;30://
;31:#include "chars.h"				//characteristics
;32:#include "inv.h"				//indexes into the inventory
;33:#include "syn.h"				//synonyms
;34:#include "match.h"				//string matching types and vars
;35:
;36:// for the voice chats
;37:#ifdef MISSIONPACK
;38:#include "../../ui/menudef.h"
;39:#endif
;40:
;41:int notleader[MAX_CLIENTS];
;42:
;43:#ifdef DEBUG
;44:/*
;45:==================
;46:BotPrintTeamGoal
;47:==================
;48:*/
;49:void BotPrintTeamGoal(bot_state_t *bs) {
;50:	char netname[MAX_NETNAME];
;51:	float t;
;52:
;53:	ClientName(bs->client, netname, sizeof(netname));
;54:	t = bs->teamgoal_time - FloatTime();
;55:	switch(bs->ltgtype) {
;56:		case LTG_TEAMHELP:
;57:		{
;58:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna help a team mate for %1.0f secs\n", netname, t);
;59:			break;
;60:		}
;61:		case LTG_TEAMACCOMPANY:
;62:		{
;63:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna accompany a team mate for %1.0f secs\n", netname, t);
;64:			break;
;65:		}
;66:		case LTG_GETFLAG:
;67:		{
;68:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna get the flag for %1.0f secs\n", netname, t);
;69:			break;
;70:		}
;71:		case LTG_RUSHBASE:
;72:		{
;73:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna rush to the base for %1.0f secs\n", netname, t);
;74:			break;
;75:		}
;76:		case LTG_RETURNFLAG:
;77:		{
;78:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna try to return the flag for %1.0f secs\n", netname, t);
;79:			break;
;80:		}
;81:#ifdef MISSIONPACK
;82:		case LTG_ATTACKENEMYBASE:
;83:		{
;84:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna attack the enemy base for %1.0f secs\n", netname, t);
;85:			break;
;86:		}
;87:		case LTG_HARVEST:
;88:		{
;89:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna harvest for %1.0f secs\n", netname, t);
;90:			break;
;91:		}
;92:#endif
;93:		case LTG_DEFENDKEYAREA:
;94:		{
;95:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna defend a key area for %1.0f secs\n", netname, t);
;96:			break;
;97:		}
;98:		case LTG_GETITEM:
;99:		{
;100:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna get an item for %1.0f secs\n", netname, t);
;101:			break;
;102:		}
;103:		case LTG_KILL:
;104:		{
;105:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna kill someone for %1.0f secs\n", netname, t);
;106:			break;
;107:		}
;108:		case LTG_CAMP:
;109:		case LTG_CAMPORDER:
;110:		{
;111:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna camp for %1.0f secs\n", netname, t);
;112:			break;
;113:		}
;114:		case LTG_PATROL:
;115:		{
;116:			BotAI_Print(PRT_MESSAGE, "%s: I'm gonna patrol for %1.0f secs\n", netname, t);
;117:			break;
;118:		}
;119:		default:
;120:		{
;121:			if (bs->ctfroam_time > FloatTime()) {
;122:				t = bs->ctfroam_time - FloatTime();
;123:				BotAI_Print(PRT_MESSAGE, "%s: I'm gonna roam for %1.0f secs\n", netname, t);
;124:			}
;125:			else {
;126:				BotAI_Print(PRT_MESSAGE, "%s: I've got a regular goal\n", netname);
;127:			}
;128:		}
;129:	}
;130:}
;131:#endif //DEBUG
;132:
;133:/*
;134:==================
;135:BotGetItemTeamGoal
;136:
;137:FIXME: add stuff like "upper rocket launcher"
;138:"the rl near the railgun", "lower grenade launcher" etc.
;139:==================
;140:*/
;141:int BotGetItemTeamGoal(char *goalname, bot_goal_t *goal) {
line 144
;142:	int i;
;143:
;144:	if (!strlen(goalname)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 4
INDIRU4
CNSTU4 0
NEU4 $56
CNSTI4 0
RETI4
ADDRGP4 $55
JUMPV
LABELV $56
line 145
;145:	i = -1;
ADDRLP4 0
CNSTI4 -1
ASGNI4
LABELV $58
line 146
;146:	do {
line 147
;147:		i = trap_BotGetLevelItemGoal(i, goalname, goal);
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 148
;148:		if (i > 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $61
line 150
;149:			//do NOT defend dropped items
;150:			if (goal->flags & GFL_DROPPED)
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $63
line 151
;151:				continue;
ADDRGP4 $59
JUMPV
LABELV $63
line 152
;152:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $55
JUMPV
LABELV $61
line 154
;153:		}
;154:	} while(i > 0);
LABELV $59
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $58
line 155
;155:	return qfalse;
CNSTI4 0
RETI4
LABELV $55
endproc BotGetItemTeamGoal 12 12
export BotGetMessageTeamGoal
proc BotGetMessageTeamGoal 12 12
line 163
;156:}
;157:
;158:/*
;159:==================
;160:BotGetMessageTeamGoal
;161:==================
;162:*/
;163:int BotGetMessageTeamGoal(bot_state_t *bs, char *goalname, bot_goal_t *goal) {
line 166
;164:	bot_waypoint_t *cp;
;165:
;166:	if (BotGetItemTeamGoal(goalname, goal)) return qtrue;
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotGetItemTeamGoal
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $66
CNSTI4 1
RETI4
ADDRGP4 $65
JUMPV
LABELV $66
line 168
;167:
;168:	cp = BotFindWayPoint(bs->checkpoints, goalname);
ADDRFP4 0
INDIRP4
CNSTI4 9076
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotFindWayPoint
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 169
;169:	if (cp) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $68
line 170
;170:		memcpy(goal, &cp->goal, sizeof(bot_goal_t));
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ARGP4
CNSTU4 56
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 171
;171:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $65
JUMPV
LABELV $68
line 173
;172:	}
;173:	return qfalse;
CNSTI4 0
RETI4
LABELV $65
endproc BotGetMessageTeamGoal 12 12
export BotGetTime
proc BotGetTime 600 16
line 181
;174:}
;175:
;176:/*
;177:==================
;178:BotGetTime
;179:==================
;180:*/
;181:float BotGetTime(bot_match_t *match) {
line 187
;182:	bot_match_t timematch;
;183:	char timestring[MAX_MESSAGE_SIZE];
;184:	float t;
;185:
;186:	//if the matched string has a time
;187:	if (match->subtype & ST_TIME) {
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $71
line 189
;188:		//get the time string
;189:		trap_BotMatchVariable(match, TIME, timestring, MAX_MESSAGE_SIZE);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 191
;190:		//match it to find out if the time is in seconds or minutes
;191:		if (trap_BotFindMatch(timestring, &timematch, MTCONTEXT_TIME)) {
ADDRLP4 0
ARGP4
ADDRLP4 256
ARGP4
CNSTU4 8
ARGU4
ADDRLP4 588
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 588
INDIRI4
CNSTI4 0
EQI4 $73
line 192
;192:			if (timematch.type == MSG_FOREVER) {
ADDRLP4 256+256
INDIRI4
CNSTI4 107
NEI4 $75
line 193
;193:				t = 99999999.0f;
ADDRLP4 584
CNSTF4 1287568416
ASGNF4
line 194
;194:			}
ADDRGP4 $76
JUMPV
LABELV $75
line 195
;195:			else if (timematch.type == MSG_FORAWHILE) {
ADDRLP4 256+256
INDIRI4
CNSTI4 109
NEI4 $78
line 196
;196:				t = 10 * 60; // 10 minutes
ADDRLP4 584
CNSTF4 1142292480
ASGNF4
line 197
;197:			}
ADDRGP4 $79
JUMPV
LABELV $78
line 198
;198:			else if (timematch.type == MSG_FORALONGTIME) {
ADDRLP4 256+256
INDIRI4
CNSTI4 108
NEI4 $81
line 199
;199:				t = 30 * 60; // 30 minutes
ADDRLP4 584
CNSTF4 1155596288
ASGNF4
line 200
;200:			}
ADDRGP4 $82
JUMPV
LABELV $81
line 201
;201:			else {
line 202
;202:				trap_BotMatchVariable(&timematch, TIME, timestring, MAX_MESSAGE_SIZE);
ADDRLP4 256
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 203
;203:				if (timematch.type == MSG_MINUTES) t = atof(timestring) * 60;
ADDRLP4 256+256
INDIRI4
CNSTI4 105
NEI4 $84
ADDRLP4 0
ARGP4
ADDRLP4 592
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 584
ADDRLP4 592
INDIRF4
CNSTF4 1114636288
MULF4
ASGNF4
ADDRGP4 $85
JUMPV
LABELV $84
line 204
;204:				else if (timematch.type == MSG_SECONDS) t = atof(timestring);
ADDRLP4 256+256
INDIRI4
CNSTI4 106
NEI4 $87
ADDRLP4 0
ARGP4
ADDRLP4 596
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 584
ADDRLP4 596
INDIRF4
ASGNF4
ADDRGP4 $88
JUMPV
LABELV $87
line 205
;205:				else t = 0;
ADDRLP4 584
CNSTF4 0
ASGNF4
LABELV $88
LABELV $85
line 206
;206:			}
LABELV $82
LABELV $79
LABELV $76
line 208
;207:			//if there's a valid time
;208:			if (t > 0) return FloatTime() + t;
ADDRLP4 584
INDIRF4
CNSTF4 0
LEF4 $90
ADDRGP4 floattime
INDIRF4
ADDRLP4 584
INDIRF4
ADDF4
RETF4
ADDRGP4 $70
JUMPV
LABELV $90
line 209
;209:		}
LABELV $73
line 210
;210:	}
LABELV $71
line 211
;211:	return 0;
CNSTF4 0
RETF4
LABELV $70
endproc BotGetTime 600 16
export FindClientByName
proc FindClientByName 1032 12
line 220
;212:}
;213:
;214:
;215:/*
;216:==================
;217:FindClientByName
;218:==================
;219:*/
;220:int FindClientByName( const char *name ) {
line 224
;221:	char buf[ MAX_INFO_STRING ];
;222:	int i;
;223:
;224:	for ( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $96
JUMPV
LABELV $93
line 225
;225:		ClientName( i, buf, sizeof( buf ) );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 226
;226:		if ( !Q_stricmp( buf, name ) ) 
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1028
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
NEI4 $98
line 227
;227:			return i; // exact match
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $92
JUMPV
LABELV $98
line 228
;228:	}
LABELV $94
line 224
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $96
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $93
line 230
;229:
;230:	for ( i = 0; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $103
JUMPV
LABELV $100
line 231
;231:		ClientName(i, buf, sizeof( buf ) );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 232
;232:		if ( stristr( buf, name ) )
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1028
ADDRGP4 stristr
CALLP4
ASGNP4
ADDRLP4 1028
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $105
line 233
;233:			return i; // partial match
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $92
JUMPV
LABELV $105
line 234
;234:	}
LABELV $101
line 230
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $103
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $100
line 236
;235:
;236:	return -1;
CNSTI4 -1
RETI4
LABELV $92
endproc FindClientByName 1032 12
export FindEnemyByName
proc FindEnemyByName 1036 12
line 245
;237:}
;238:
;239:
;240:/*
;241:==================
;242:FindEnemyByName
;243:==================
;244:*/
;245:int FindEnemyByName( bot_state_t *bs, const char *name ) {
line 249
;246:	char buf[MAX_INFO_STRING];
;247:	int i;
;248:
;249:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $111
JUMPV
LABELV $108
line 250
;250:		if (BotSameTeam(bs, i)) continue;
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
EQI4 $113
ADDRGP4 $109
JUMPV
LABELV $113
line 251
;251:		ClientName(i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 252
;252:		if (!Q_stricmp(buf, name)) return i;
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1032
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $115
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $107
JUMPV
LABELV $115
line 253
;253:	}
LABELV $109
line 249
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $111
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $108
line 255
;254:
;255:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $120
JUMPV
LABELV $117
line 256
;256:		if (BotSameTeam(bs, i)) continue;
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
EQI4 $122
ADDRGP4 $118
JUMPV
LABELV $122
line 257
;257:		ClientName(i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 258
;258:		if (stristr(buf, name)) return i;
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1032
ADDRGP4 stristr
CALLP4
ASGNP4
ADDRLP4 1032
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $124
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $107
JUMPV
LABELV $124
line 259
;259:	}
LABELV $118
line 255
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $120
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $117
line 261
;260:
;261:	return -1;
CNSTI4 -1
RETI4
LABELV $107
endproc FindEnemyByName 1036 12
export NumPlayersOnSameTeam
proc NumPlayersOnSameTeam 1036 12
line 270
;262:}
;263:
;264:
;265:/*
;266:==================
;267:NumPlayersOnSameTeam
;268:==================
;269:*/
;270:int NumPlayersOnSameTeam(bot_state_t *bs) {
line 274
;271:	int i, num;
;272:	char buf[MAX_INFO_STRING];
;273:
;274:	num = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 275
;275:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $130
JUMPV
LABELV $127
line 276
;276:		trap_GetConfigstring(CS_PLAYERS+i, buf, MAX_INFO_STRING);
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
line 277
;277:		if (buf[0]) {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $132
line 278
;278:			if (BotSameTeam(bs, i+1)) num++;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 1032
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
EQI4 $134
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $134
line 279
;279:		}
LABELV $132
line 280
;280:	}
LABELV $128
line 275
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $130
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $127
line 281
;281:	return num;
ADDRLP4 1028
INDIRI4
RETI4
LABELV $126
endproc NumPlayersOnSameTeam 1036 12
export BotGetPatrolWaypoints
proc BotGetPatrolWaypoints 672 16
line 289
;282:}
;283:
;284:/*
;285:==================
;286:TeamPlayIsOn
;287:==================
;288:*/
;289:int BotGetPatrolWaypoints(bot_state_t *bs, bot_match_t *match) {
line 296
;290:	char keyarea[MAX_MESSAGE_SIZE];
;291:	int patrolflags;
;292:	bot_waypoint_t *wp, *newwp, *newpatrolpoints;
;293:	bot_match_t keyareamatch;
;294:	bot_goal_t goal;
;295:
;296:	newpatrolpoints = NULL;
ADDRLP4 592
CNSTP4 0
ASGNP4
line 297
;297:	patrolflags = 0;
ADDRLP4 652
CNSTI4 0
ASGNI4
line 299
;298:	//
;299:	trap_BotMatchVariable(match, KEYAREA, keyarea, MAX_MESSAGE_SIZE);
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
ADDRGP4 $138
JUMPV
LABELV $137
line 301
;300:	//
;301:	while(1) {
line 302
;302:		if (!trap_BotFindMatch(keyarea, &keyareamatch, MTCONTEXT_PATROLKEYAREA)) {
ADDRLP4 8
ARGP4
ADDRLP4 264
ARGP4
CNSTU4 64
ARGU4
ADDRLP4 656
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 656
INDIRI4
CNSTI4 0
NEI4 $140
line 303
;303:			trap_EA_SayTeam(bs->client, "what do you say?");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $142
ARGP4
ADDRGP4 trap_EA_SayTeam
CALLV
pop
line 304
;304:			BotFreeWaypoints(newpatrolpoints);
ADDRLP4 592
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 305
;305:			bs->patrolpoints = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 9080
ADDP4
CNSTP4 0
ASGNP4
line 306
;306:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $136
JUMPV
LABELV $140
line 308
;307:		}
;308:		trap_BotMatchVariable(&keyareamatch, KEYAREA, keyarea, MAX_MESSAGE_SIZE);
ADDRLP4 264
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 309
;309:		if (!BotGetMessageTeamGoal(bs, keyarea, &goal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 596
ARGP4
ADDRLP4 660
ADDRGP4 BotGetMessageTeamGoal
CALLI4
ASGNI4
ADDRLP4 660
INDIRI4
CNSTI4 0
NEI4 $143
line 312
;310:			//BotAI_BotInitialChat(bs, "cannotfind", keyarea, NULL);
;311:			//trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
;312:			BotFreeWaypoints(newpatrolpoints);
ADDRLP4 592
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 313
;313:			bs->patrolpoints = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 9080
ADDP4
CNSTP4 0
ASGNP4
line 314
;314:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $136
JUMPV
LABELV $143
line 317
;315:		}
;316:		//create a new waypoint
;317:		newwp = BotCreateWayPoint(keyarea, goal.origin, goal.areanum);
ADDRLP4 8
ARGP4
ADDRLP4 596
ARGP4
ADDRLP4 596+12
INDIRI4
ARGI4
ADDRLP4 664
ADDRGP4 BotCreateWayPoint
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 664
INDIRP4
ASGNP4
line 318
;318:		if (!newwp)
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $146
line 319
;319:			break;
ADDRGP4 $139
JUMPV
LABELV $146
line 321
;320:		//add the waypoint to the patrol points
;321:		newwp->next = NULL;
ADDRLP4 4
INDIRP4
CNSTI4 92
ADDP4
CNSTP4 0
ASGNP4
line 322
;322:		for (wp = newpatrolpoints; wp && wp->next; wp = wp->next);
ADDRLP4 0
ADDRLP4 592
INDIRP4
ASGNP4
ADDRGP4 $151
JUMPV
LABELV $148
LABELV $149
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
LABELV $151
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $152
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $148
LABELV $152
line 323
;323:		if (!wp) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $153
line 324
;324:			newpatrolpoints = newwp;
ADDRLP4 592
ADDRLP4 4
INDIRP4
ASGNP4
line 325
;325:			newwp->prev = NULL;
ADDRLP4 4
INDIRP4
CNSTI4 96
ADDP4
CNSTP4 0
ASGNP4
line 326
;326:		}
ADDRGP4 $154
JUMPV
LABELV $153
line 327
;327:		else {
line 328
;328:			wp->next = newwp;
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 329
;329:			newwp->prev = wp;
ADDRLP4 4
INDIRP4
CNSTI4 96
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 330
;330:		}
LABELV $154
line 332
;331:		//
;332:		if (keyareamatch.subtype & ST_BACK) {
ADDRLP4 264+260
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $155
line 333
;333:			patrolflags = PATROL_LOOP;
ADDRLP4 652
CNSTI4 1
ASGNI4
line 334
;334:			break;
ADDRGP4 $139
JUMPV
LABELV $155
line 336
;335:		}
;336:		else if (keyareamatch.subtype & ST_REVERSE) {
ADDRLP4 264+260
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $158
line 337
;337:			patrolflags = PATROL_REVERSE;
ADDRLP4 652
CNSTI4 2
ASGNI4
line 338
;338:			break;
ADDRGP4 $139
JUMPV
LABELV $158
line 340
;339:		}
;340:		else if (keyareamatch.subtype & ST_MORE) {
ADDRLP4 264+260
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $139
line 341
;341:			trap_BotMatchVariable(&keyareamatch, MORE, keyarea, MAX_MESSAGE_SIZE);
ADDRLP4 264
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 342
;342:		}
line 343
;343:		else {
line 344
;344:			break;
LABELV $162
line 346
;345:		}
;346:	}
LABELV $138
line 301
ADDRGP4 $137
JUMPV
LABELV $139
line 348
;347:	//
;348:	if (!newpatrolpoints || !newpatrolpoints->next) {
ADDRLP4 592
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $166
ADDRLP4 592
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $164
LABELV $166
line 349
;349:		trap_EA_SayTeam(bs->client, "I need more key points to patrol\n");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $167
ARGP4
ADDRGP4 trap_EA_SayTeam
CALLV
pop
line 350
;350:		BotFreeWaypoints(newpatrolpoints);
ADDRLP4 592
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 351
;351:		newpatrolpoints = NULL;
ADDRLP4 592
CNSTP4 0
ASGNP4
line 352
;352:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $136
JUMPV
LABELV $164
line 355
;353:	}
;354:	//
;355:	BotFreeWaypoints(bs->patrolpoints);
ADDRFP4 0
INDIRP4
CNSTI4 9080
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 356
;356:	bs->patrolpoints = newpatrolpoints;
ADDRFP4 0
INDIRP4
CNSTI4 9080
ADDP4
ADDRLP4 592
INDIRP4
ASGNP4
line 358
;357:	//
;358:	bs->curpatrolpoint = bs->patrolpoints;
ADDRLP4 660
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 660
INDIRP4
CNSTI4 9084
ADDP4
ADDRLP4 660
INDIRP4
CNSTI4 9080
ADDP4
INDIRP4
ASGNP4
line 359
;359:	bs->patrolflags = patrolflags;
ADDRFP4 0
INDIRP4
CNSTI4 9088
ADDP4
ADDRLP4 652
INDIRI4
ASGNI4
line 361
;360:	//
;361:	return qtrue;
CNSTI4 1
RETI4
LABELV $136
endproc BotGetPatrolWaypoints 672 16
export BotAddressedToBot
proc BotAddressedToBot 1572 16
line 369
;362:}
;363:
;364:/*
;365:==================
;366:BotAddressedToBot
;367:==================
;368:*/
;369:int BotAddressedToBot(bot_state_t *bs, bot_match_t *match) {
line 377
;370:	char addressedto[MAX_MESSAGE_SIZE];
;371:	char netname[MAX_MESSAGE_SIZE];
;372:	char name[MAX_MESSAGE_SIZE];
;373:	char botname[128];
;374:	int client;
;375:	bot_match_t addresseematch;
;376:
;377:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 840
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 378
;378:	client = ClientOnSameTeamFromName(bs, netname);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 840
ARGP4
ADDRLP4 1228
ADDRGP4 ClientOnSameTeamFromName
CALLI4
ASGNI4
ADDRLP4 1096
ADDRLP4 1228
INDIRI4
ASGNI4
line 379
;379:	if (client < 0) return qfalse;
ADDRLP4 1096
INDIRI4
CNSTI4 0
GEI4 $169
CNSTI4 0
RETI4
ADDRGP4 $168
JUMPV
LABELV $169
line 381
;380:	//if the message is addressed to someone
;381:	if (match->subtype & ST_ADDRESSED) {
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $171
line 382
;382:		trap_BotMatchVariable(match, ADDRESSEE, addressedto, sizeof(addressedto));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 584
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 384
;383:		//the name of this bot
;384:		ClientName(bs->client, botname, 128);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 1100
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 ClientName
CALLP4
pop
ADDRGP4 $174
JUMPV
LABELV $173
line 386
;385:		//
;386:		while(trap_BotFindMatch(addressedto, &addresseematch, MTCONTEXT_ADDRESSEE)) {
line 387
;387:			if (addresseematch.type == MSG_EVERYONE) {
ADDRLP4 0+256
INDIRI4
CNSTI4 101
NEI4 $176
line 388
;388:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $168
JUMPV
LABELV $176
line 390
;389:			}
;390:			else if (addresseematch.type == MSG_MULTIPLENAMES) {
ADDRLP4 0+256
INDIRI4
CNSTI4 102
NEI4 $179
line 391
;391:				trap_BotMatchVariable(&addresseematch, TEAMMATE, name, sizeof(name));
ADDRLP4 0
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 328
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 392
;392:				if (strlen(name)) {
ADDRLP4 328
ARGP4
ADDRLP4 1232
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 1232
INDIRU4
CNSTU4 0
EQU4 $182
line 393
;393:					if (stristr(botname, name)) return qtrue;
ADDRLP4 1100
ARGP4
ADDRLP4 328
ARGP4
ADDRLP4 1236
ADDRGP4 stristr
CALLP4
ASGNP4
ADDRLP4 1236
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $184
CNSTI4 1
RETI4
ADDRGP4 $168
JUMPV
LABELV $184
line 394
;394:					if (stristr(bs->subteam, name)) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6984
ADDP4
ARGP4
ADDRLP4 328
ARGP4
ADDRLP4 1240
ADDRGP4 stristr
CALLP4
ASGNP4
ADDRLP4 1240
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $186
CNSTI4 1
RETI4
ADDRGP4 $168
JUMPV
LABELV $186
line 395
;395:				}
LABELV $182
line 396
;396:				trap_BotMatchVariable(&addresseematch, MORE, addressedto, MAX_MESSAGE_SIZE);
ADDRLP4 0
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 584
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 397
;397:			}
ADDRGP4 $180
JUMPV
LABELV $179
line 398
;398:			else {
line 399
;399:				trap_BotMatchVariable(&addresseematch, TEAMMATE, name, MAX_MESSAGE_SIZE);
ADDRLP4 0
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 328
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 400
;400:				if (strlen(name)) {
ADDRLP4 328
ARGP4
ADDRLP4 1232
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 1232
INDIRU4
CNSTU4 0
EQU4 $175
line 401
;401:					if (stristr(botname, name)) return qtrue;
ADDRLP4 1100
ARGP4
ADDRLP4 328
ARGP4
ADDRLP4 1236
ADDRGP4 stristr
CALLP4
ASGNP4
ADDRLP4 1236
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $190
CNSTI4 1
RETI4
ADDRGP4 $168
JUMPV
LABELV $190
line 402
;402:					if (stristr(bs->subteam, name)) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6984
ADDP4
ARGP4
ADDRLP4 328
ARGP4
ADDRLP4 1240
ADDRGP4 stristr
CALLP4
ASGNP4
ADDRLP4 1240
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $175
CNSTI4 1
RETI4
ADDRGP4 $168
JUMPV
line 403
;403:				}
line 404
;404:				break;
LABELV $180
line 406
;405:			}
;406:		}
LABELV $174
line 386
ADDRLP4 584
ARGP4
ADDRLP4 0
ARGP4
CNSTU4 32
ARGU4
ADDRLP4 1232
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 1232
INDIRI4
CNSTI4 0
NEI4 $173
LABELV $175
line 409
;407:		//Com_sprintf(buf, sizeof(buf), "not addressed to me but %s", addressedto);
;408:		//trap_EA_Say(bs->client, buf);
;409:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $168
JUMPV
LABELV $171
line 411
;410:	}
;411:	else {
line 414
;412:		bot_match_t tellmatch;
;413:
;414:		tellmatch.type = 0;
ADDRLP4 1232+256
CNSTI4 0
ASGNI4
line 416
;415:		//if this message wasn't directed solely to this bot
;416:		if (!trap_BotFindMatch(match->string, &tellmatch, MTCONTEXT_REPLYCHAT) ||
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1232
ARGP4
CNSTU4 128
ARGU4
ADDRLP4 1560
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 1560
INDIRI4
CNSTI4 0
EQI4 $198
ADDRLP4 1232+256
INDIRI4
CNSTI4 202
EQI4 $195
LABELV $198
line 417
;417:				tellmatch.type != MSG_CHATTELL) {
line 419
;418:			//make sure not everyone reacts to this message
;419:			if (random() > (float ) 1.0 / (NumPlayersOnSameTeam(bs)-1)) return qfalse;
ADDRLP4 1564
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1568
ADDRGP4 NumPlayersOnSameTeam
CALLI4
ASGNI4
ADDRLP4 1564
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1065353216
ADDRLP4 1568
INDIRI4
CNSTI4 1
SUBI4
CVIF4 4
DIVF4
LEF4 $199
CNSTI4 0
RETI4
ADDRGP4 $168
JUMPV
LABELV $199
line 420
;420:		}
LABELV $195
line 421
;421:	}
line 422
;422:	return qtrue;
CNSTI4 1
RETI4
LABELV $168
endproc BotAddressedToBot 1572 16
export BotGPSToPosition
proc BotGPSToPosition 20 12
line 430
;423:}
;424:
;425:/*
;426:==================
;427:BotGPSToPosition
;428:==================
;429:*/
;430:int BotGPSToPosition(char *buf, vec3_t position) {
line 431
;431:	int i, j = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 434
;432:	int num, sign;
;433:
;434:	for (i = 0; i < 3; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $202
line 435
;435:		num = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $207
JUMPV
LABELV $206
line 436
;436:		while(buf[j] == ' ') j++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $207
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 32
EQI4 $206
line 437
;437:		if (buf[j] == '-') {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $209
line 438
;438:			j++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 439
;439:			sign = -1;
ADDRLP4 12
CNSTI4 -1
ASGNI4
line 440
;440:		}
ADDRGP4 $212
JUMPV
LABELV $209
line 441
;441:		else {
line 442
;442:			sign = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 443
;443:		}
ADDRGP4 $212
JUMPV
LABELV $211
line 444
;444:		while (buf[j]) {
line 445
;445:			if (buf[j] >= '0' && buf[j] <= '9') {
ADDRLP4 16
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 48
LTI4 $214
ADDRLP4 16
INDIRI4
CNSTI4 57
GTI4 $214
line 446
;446:				num = num * 10 + buf[j] - '0';
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 10
MULI4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ADDI4
CNSTI4 48
SUBI4
ASGNI4
line 447
;447:				j++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 448
;448:			}
ADDRGP4 $215
JUMPV
LABELV $214
line 449
;449:			else {
line 450
;450:				j++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 451
;451:				break;
ADDRGP4 $213
JUMPV
LABELV $215
line 453
;452:			}
;453:		}
LABELV $212
line 444
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $211
LABELV $213
line 454
;454:		BotAI_Print(PRT_MESSAGE, "%d\n", sign * num);
CNSTI4 1
ARGI4
ADDRGP4 $216
ARGP4
ADDRLP4 12
INDIRI4
ADDRLP4 4
INDIRI4
MULI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 455
;455:		position[i] = (float) sign * num;
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRLP4 12
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 456
;456:	}
LABELV $203
line 434
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 3
LTI4 $202
line 457
;457:	return qtrue;
CNSTI4 1
RETI4
LABELV $201
endproc BotGPSToPosition 20 12
export BotMatch_HelpAccompany
proc BotMatch_HelpAccompany 1272 16
line 465
;458:}
;459:
;460:/*
;461:==================
;462:BotMatch_HelpAccompany
;463:==================
;464:*/
;465:void BotMatch_HelpAccompany(bot_state_t *bs, bot_match_t *match) {
line 473
;466:	int client, other, areanum;
;467:	char teammate[MAX_MESSAGE_SIZE];
;468:	char netname[MAX_MESSAGE_SIZE];
;469:	char itemname[MAX_MESSAGE_SIZE];
;470:	bot_match_t teammatematch;
;471:	aas_entityinfo_t entinfo;
;472:
;473:	if (!TeamPlayIsOn()) return;
ADDRLP4 1248
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 1248
INDIRI4
CNSTI4 0
NEI4 $218
ADDRGP4 $217
JUMPV
LABELV $218
line 475
;474:	//if not addressed to this bot
;475:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1252
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 1252
INDIRI4
CNSTI4 0
NEI4 $220
ADDRGP4 $217
JUMPV
LABELV $220
line 477
;476:	//get the team mate name
;477:	trap_BotMatchVariable(match, TEAMMATE, teammate, sizeof(teammate));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 479
;478:	//get the client to help
;479:	if (trap_BotFindMatch(teammate, &teammatematch, MTCONTEXT_TEAMMATE) &&
ADDRLP4 260
ARGP4
ADDRLP4 656
ARGP4
CNSTU4 16
ARGU4
ADDRLP4 1256
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 1256
INDIRI4
CNSTI4 0
EQI4 $222
ADDRLP4 656+256
INDIRI4
CNSTI4 100
NEI4 $222
line 481
;480:			//if someone asks for him or herself
;481:			teammatematch.type == MSG_ME) {
line 483
;482:		//get the netname
;483:		trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 484
;484:		client = ClientFromName(netname);
ADDRLP4 4
ARGP4
ADDRLP4 1260
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1260
INDIRI4
ASGNI4
line 485
;485:		other = qfalse;
ADDRLP4 984
CNSTI4 0
ASGNI4
line 486
;486:	}
ADDRGP4 $223
JUMPV
LABELV $222
line 487
;487:	else {
line 489
;488:		//asked for someone else
;489:		client = FindClientByName(teammate);
ADDRLP4 260
ARGP4
ADDRLP4 1260
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1260
INDIRI4
ASGNI4
line 491
;490:		//if this is the bot self
;491:		if (client == bs->client) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $225
line 492
;492:			other = qfalse;
ADDRLP4 984
CNSTI4 0
ASGNI4
line 493
;493:		}
ADDRGP4 $226
JUMPV
LABELV $225
line 494
;494:		else if (!BotSameTeam(bs, client)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1264
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1264
INDIRI4
CNSTI4 0
NEI4 $227
line 496
;495:			//FIXME: say "I don't help the enemy"
;496:			return;
ADDRGP4 $217
JUMPV
LABELV $227
line 498
;497:		}
;498:		else {
line 499
;499:			other = qtrue;
ADDRLP4 984
CNSTI4 1
ASGNI4
line 500
;500:		}
LABELV $226
line 501
;501:	}
LABELV $223
line 503
;502:	//if the bot doesn't know who to help (FindClientByName returned -1)
;503:	if (client < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $229
line 504
;504:		if (other) BotAI_BotInitialChat(bs, "whois", teammate, NULL);
ADDRLP4 984
INDIRI4
CNSTI4 0
EQI4 $231
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $233
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $232
JUMPV
LABELV $231
line 505
;505:		else BotAI_BotInitialChat(bs, "whois", netname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $233
ARGP4
ADDRLP4 4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
LABELV $232
line 506
;506:		client = ClientFromName(netname);
ADDRLP4 4
ARGP4
ADDRLP4 1260
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1260
INDIRI4
ASGNI4
line 507
;507:		trap_BotEnterChat(bs->cs, client, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 508
;508:		return;
ADDRGP4 $217
JUMPV
LABELV $229
line 511
;509:	}
;510:	//don't help or accompany yourself
;511:	if (client == bs->client) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $234
line 512
;512:		return;
ADDRGP4 $217
JUMPV
LABELV $234
line 515
;513:	}
;514:	//
;515:	bs->teamgoal.entitynum = -1;
ADDRFP4 0
INDIRP4
CNSTI4 6664
ADDP4
CNSTI4 -1
ASGNI4
line 516
;516:	BotEntityInfo(client, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 516
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 518
;517:	//if info is valid (in PVS)
;518:	if (entinfo.valid) {
ADDRLP4 516
INDIRI4
CNSTI4 0
EQI4 $236
line 519
;519:		areanum = BotPointAreaNum(entinfo.origin);
ADDRLP4 516+24
ARGP4
ADDRLP4 1260
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 988
ADDRLP4 1260
INDIRI4
ASGNI4
line 520
;520:		if (areanum) {// && trap_AAS_AreaReachability(areanum)) {
ADDRLP4 988
INDIRI4
CNSTI4 0
EQI4 $239
line 521
;521:			bs->teamgoal.entitynum = client;
ADDRFP4 0
INDIRP4
CNSTI4 6664
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 522
;522:			bs->teamgoal.areanum = areanum;
ADDRFP4 0
INDIRP4
CNSTI4 6636
ADDP4
ADDRLP4 988
INDIRI4
ASGNI4
line 523
;523:			VectorCopy(entinfo.origin, bs->teamgoal.origin);
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ADDRLP4 516+24
INDIRB
ASGNB 12
line 524
;524:			VectorSet(bs->teamgoal.mins, -8, -8, -8);
ADDRFP4 0
INDIRP4
CNSTI4 6640
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6644
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6648
ADDP4
CNSTF4 3238002688
ASGNF4
line 525
;525:			VectorSet(bs->teamgoal.maxs, 8, 8, 8);
ADDRFP4 0
INDIRP4
CNSTI4 6652
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6656
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6660
ADDP4
CNSTF4 1090519040
ASGNF4
line 526
;526:		}
LABELV $239
line 527
;527:	}
LABELV $236
line 529
;528:	//if no teamgoal yet
;529:	if (bs->teamgoal.entitynum < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6664
ADDP4
INDIRI4
CNSTI4 0
GEI4 $242
line 531
;530:		//if near an item
;531:		if (match->subtype & ST_NEARITEM) {
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $244
line 533
;532:			//get the match variable
;533:			trap_BotMatchVariable(match, ITEM, itemname, sizeof(itemname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 992
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 535
;534:			//
;535:			if (!BotGetMessageTeamGoal(bs, itemname, &bs->teamgoal)) {
ADDRLP4 1260
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1260
INDIRP4
ARGP4
ADDRLP4 992
ARGP4
ADDRLP4 1260
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRLP4 1264
ADDRGP4 BotGetMessageTeamGoal
CALLI4
ASGNI4
ADDRLP4 1264
INDIRI4
CNSTI4 0
NEI4 $246
line 538
;536:				//BotAI_BotInitialChat(bs, "cannotfind", itemname, NULL);
;537:				//trap_BotEnterChat(bs->cs, bs->client, CHAT_TEAM);
;538:				return;
ADDRGP4 $217
JUMPV
LABELV $246
line 540
;539:			}
;540:		}
LABELV $244
line 541
;541:	}
LABELV $242
line 543
;542:	//
;543:	if (bs->teamgoal.entitynum < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6664
ADDP4
INDIRI4
CNSTI4 0
GEI4 $248
line 544
;544:		if (other) BotAI_BotInitialChat(bs, "whereis", teammate, NULL);
ADDRLP4 984
INDIRI4
CNSTI4 0
EQI4 $250
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $252
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $251
JUMPV
LABELV $250
line 545
;545:		else BotAI_BotInitialChat(bs, "whereareyou", netname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $253
ARGP4
ADDRLP4 4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
LABELV $251
line 546
;546:		client = ClientFromName(netname);
ADDRLP4 4
ARGP4
ADDRLP4 1260
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1260
INDIRI4
ASGNI4
line 547
;547:		trap_BotEnterChat(bs->cs, client, CHAT_TEAM);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 548
;548:		return;
ADDRGP4 $217
JUMPV
LABELV $248
line 551
;549:	}
;550:	//the team mate
;551:	bs->teammate = client;
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 553
;552:	//
;553:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 555
;554:	//
;555:	client = ClientFromName(netname);
ADDRLP4 4
ARGP4
ADDRLP4 1260
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1260
INDIRI4
ASGNI4
line 557
;556:	//the team mate who ordered
;557:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 558
;558:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 1
ASGNI4
line 559
;559:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 561
;560:	//last time the team mate was assumed visible
;561:	bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6748
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 563
;562:	//set the time to send a message to the team mates
;563:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 1264
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 1264
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
line 565
;564:	//get the team goal time
;565:	bs->teamgoal_time = BotGetTime(match);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1268
ADDRGP4 BotGetTime
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRLP4 1268
INDIRF4
ASGNF4
line 567
;566:	//set the ltg type
;567:	if (match->type == MSG_HELP) {
ADDRFP4 4
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 3
NEI4 $254
line 568
;568:		bs->ltgtype = LTG_TEAMHELP;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 1
ASGNI4
line 569
;569:		if (!bs->teamgoal_time) bs->teamgoal_time = FloatTime() + TEAM_HELP_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
INDIRF4
CNSTF4 0
NEF4 $255
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 570
;570:	}
ADDRGP4 $255
JUMPV
LABELV $254
line 571
;571:	else {
line 572
;572:		bs->ltgtype = LTG_TEAMACCOMPANY;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 2
ASGNI4
line 573
;573:		if (!bs->teamgoal_time) bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
INDIRF4
CNSTF4 0
NEF4 $258
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
LABELV $258
line 574
;574:		bs->formation_dist = 3.5 * 32;		//3.5 meter
ADDRFP4 0
INDIRP4
CNSTI4 7016
ADDP4
CNSTF4 1121976320
ASGNF4
line 575
;575:		bs->arrive_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6172
ADDP4
CNSTF4 0
ASGNF4
line 577
;576:		//
;577:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 579
;578:		// remember last ordered task
;579:		BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 580
;580:	}
LABELV $255
line 584
;581:#ifdef DEBUG
;582:	BotPrintTeamGoal(bs);
;583:#endif //DEBUG
;584:}
LABELV $217
endproc BotMatch_HelpAccompany 1272 16
export BotMatch_DefendKeyArea
proc BotMatch_DefendKeyArea 544 16
line 591
;585:
;586:/*
;587:==================
;588:BotMatch_DefendKeyArea
;589:==================
;590:*/
;591:void BotMatch_DefendKeyArea(bot_state_t *bs, bot_match_t *match) {
line 596
;592:	char itemname[MAX_MESSAGE_SIZE];
;593:	char netname[MAX_MESSAGE_SIZE];
;594:	int client;
;595:
;596:	if (!TeamPlayIsOn()) return;
ADDRLP4 516
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 516
INDIRI4
CNSTI4 0
NEI4 $261
ADDRGP4 $260
JUMPV
LABELV $261
line 598
;597:	//if not addressed to this bot
;598:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 520
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 520
INDIRI4
CNSTI4 0
NEI4 $263
ADDRGP4 $260
JUMPV
LABELV $263
line 600
;599:	//get the match variable
;600:	trap_BotMatchVariable(match, KEYAREA, itemname, sizeof(itemname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 602
;601:	//
;602:	if (!BotGetMessageTeamGoal(bs, itemname, &bs->teamgoal)) {
ADDRLP4 524
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 524
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 524
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRLP4 528
ADDRGP4 BotGetMessageTeamGoal
CALLI4
ASGNI4
ADDRLP4 528
INDIRI4
CNSTI4 0
NEI4 $265
line 605
;603:		//BotAI_BotInitialChat(bs, "cannotfind", itemname, NULL);
;604:		//trap_BotEnterChat(bs->cs, bs->client, CHAT_TEAM);
;605:		return;
ADDRGP4 $260
JUMPV
LABELV $265
line 608
;606:	}
;607:	//
;608:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 256
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 610
;609:	//
;610:	client = ClientFromName(netname);
ADDRLP4 256
ARGP4
ADDRLP4 532
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 512
ADDRLP4 532
INDIRI4
ASGNI4
line 612
;611:	//the team mate who ordered
;612:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 512
INDIRI4
ASGNI4
line 613
;613:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 1
ASGNI4
line 614
;614:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 616
;615:	//set the time to send a message to the team mates
;616:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 536
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 536
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
line 618
;617:	//set the ltg type
;618:	bs->ltgtype = LTG_DEFENDKEYAREA;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 3
ASGNI4
line 620
;619:	//get the team goal time
;620:	bs->teamgoal_time = BotGetTime(match);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 540
ADDRGP4 BotGetTime
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRLP4 540
INDIRF4
ASGNF4
line 622
;621:	//set the team goal time
;622:	if (!bs->teamgoal_time) bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
INDIRF4
CNSTF4 0
NEF4 $267
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
LABELV $267
line 624
;623:	//away from defending
;624:	bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6144
ADDP4
CNSTF4 0
ASGNF4
line 626
;625:	//
;626:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 628
;627:	// remember last ordered task
;628:	BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 632
;629:#ifdef DEBUG
;630:	BotPrintTeamGoal(bs);
;631:#endif //DEBUG
;632:}
LABELV $260
endproc BotMatch_DefendKeyArea 544 16
export BotMatch_GetItem
proc BotMatch_GetItem 540 16
line 639
;633:
;634:/*
;635:==================
;636:BotMatch_GetItem
;637:==================
;638:*/
;639:void BotMatch_GetItem(bot_state_t *bs, bot_match_t *match) {
line 644
;640:	char itemname[MAX_MESSAGE_SIZE];
;641:	char netname[MAX_MESSAGE_SIZE];
;642:	int client;
;643:
;644:	if (!TeamPlayIsOn()) return;
ADDRLP4 516
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 516
INDIRI4
CNSTI4 0
NEI4 $270
ADDRGP4 $269
JUMPV
LABELV $270
line 646
;645:	//if not addressed to this bot
;646:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 520
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 520
INDIRI4
CNSTI4 0
NEI4 $272
ADDRGP4 $269
JUMPV
LABELV $272
line 648
;647:	//get the match variable
;648:	trap_BotMatchVariable(match, ITEM, itemname, sizeof(itemname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 650
;649:	//
;650:	if (!BotGetMessageTeamGoal(bs, itemname, &bs->teamgoal)) {
ADDRLP4 524
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 524
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 524
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRLP4 528
ADDRGP4 BotGetMessageTeamGoal
CALLI4
ASGNI4
ADDRLP4 528
INDIRI4
CNSTI4 0
NEI4 $274
line 653
;651:		//BotAI_BotInitialChat(bs, "cannotfind", itemname, NULL);
;652:		//trap_BotEnterChat(bs->cs, bs->client, CHAT_TEAM);
;653:		return;
ADDRGP4 $269
JUMPV
LABELV $274
line 655
;654:	}
;655:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 256
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 656
;656:	client = ClientOnSameTeamFromName(bs, netname);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 532
ADDRGP4 ClientOnSameTeamFromName
CALLI4
ASGNI4
ADDRLP4 512
ADDRLP4 532
INDIRI4
ASGNI4
line 658
;657:	//
;658:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 512
INDIRI4
ASGNI4
line 659
;659:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 1
ASGNI4
line 660
;660:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 662
;661:	//set the time to send a message to the team mates
;662:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 536
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 536
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
line 664
;663:	//set the ltg type
;664:	bs->ltgtype = LTG_GETITEM;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 10
ASGNI4
line 666
;665:	//set the team goal time
;666:	bs->teamgoal_time = FloatTime() + TEAM_GETITEM_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 668
;667:	//
;668:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 672
;669:#ifdef DEBUG
;670:	BotPrintTeamGoal(bs);
;671:#endif //DEBUG
;672:}
LABELV $269
endproc BotMatch_GetItem 540 16
export BotMatch_Camp
proc BotMatch_Camp 688 16
line 679
;673:
;674:/*
;675:==================
;676:BotMatch_Camp
;677:==================
;678:*/
;679:void BotMatch_Camp(bot_state_t *bs, bot_match_t *match) {
line 685
;680:	int client, areanum;
;681:	char netname[MAX_MESSAGE_SIZE];
;682:	char itemname[MAX_MESSAGE_SIZE];
;683:	aas_entityinfo_t entinfo;
;684:
;685:	if (!TeamPlayIsOn()) return;
ADDRLP4 660
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 660
INDIRI4
CNSTI4 0
NEI4 $277
ADDRGP4 $276
JUMPV
LABELV $277
line 687
;686:	//if not addressed to this bot
;687:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 664
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 664
INDIRI4
CNSTI4 0
NEI4 $279
ADDRGP4 $276
JUMPV
LABELV $279
line 689
;688:	//
;689:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 691
;690:	//asked for someone else
;691:	client = FindClientByName(netname);
ADDRLP4 4
ARGP4
ADDRLP4 668
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 668
INDIRI4
ASGNI4
line 693
;692:	//if there's no valid client with this name
;693:	if (client < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $281
line 694
;694:		BotAI_BotInitialChat(bs, "whois", netname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $233
ARGP4
ADDRLP4 4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 695
;695:		trap_BotEnterChat(bs->cs, bs->client, CHAT_TEAM);
ADDRLP4 672
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 672
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 672
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 696
;696:		return;
ADDRGP4 $276
JUMPV
LABELV $281
line 699
;697:	}
;698:	//get the match variable
;699:	trap_BotMatchVariable(match, KEYAREA, itemname, sizeof(itemname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 701
;700:	//in CTF it could be the base
;701:	if (match->subtype & ST_THERE) {
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $283
line 703
;702:		//camp at the spot the bot is currently standing
;703:		bs->teamgoal.entitynum = bs->entitynum;
ADDRLP4 672
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 672
INDIRP4
CNSTI4 6664
ADDP4
ADDRLP4 672
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 704
;704:		bs->teamgoal.areanum = bs->areanum;
ADDRLP4 676
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 676
INDIRP4
CNSTI4 6636
ADDP4
ADDRLP4 676
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ASGNI4
line 705
;705:		VectorCopy(bs->origin, bs->teamgoal.origin);
ADDRLP4 680
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 680
INDIRP4
CNSTI4 6624
ADDP4
ADDRLP4 680
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 706
;706:		VectorSet(bs->teamgoal.mins, -8, -8, -8);
ADDRFP4 0
INDIRP4
CNSTI4 6640
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6644
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6648
ADDP4
CNSTF4 3238002688
ASGNF4
line 707
;707:		VectorSet(bs->teamgoal.maxs, 8, 8, 8);
ADDRFP4 0
INDIRP4
CNSTI4 6652
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6656
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6660
ADDP4
CNSTF4 1090519040
ASGNF4
line 708
;708:	}
ADDRGP4 $284
JUMPV
LABELV $283
line 709
;709:	else if (match->subtype & ST_HERE) {
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $285
line 711
;710:		//if this is the bot self
;711:		if (client == bs->client) return;
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $287
ADDRGP4 $276
JUMPV
LABELV $287
line 713
;712:		//
;713:		bs->teamgoal.entitynum = -1;
ADDRFP4 0
INDIRP4
CNSTI4 6664
ADDP4
CNSTI4 -1
ASGNI4
line 714
;714:		BotEntityInfo(client, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 516
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 716
;715:		//if info is valid (in PVS)
;716:		if (entinfo.valid) {
ADDRLP4 516
INDIRI4
CNSTI4 0
EQI4 $289
line 717
;717:			areanum = BotPointAreaNum(entinfo.origin);
ADDRLP4 516+24
ARGP4
ADDRLP4 672
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 656
ADDRLP4 672
INDIRI4
ASGNI4
line 718
;718:			if (areanum) {// && trap_AAS_AreaReachability(areanum)) {
ADDRLP4 656
INDIRI4
CNSTI4 0
EQI4 $292
line 721
;719:				//NOTE: just assume the bot knows where the person is
;720:				//if (BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, client)) {
;721:					bs->teamgoal.entitynum = client;
ADDRFP4 0
INDIRP4
CNSTI4 6664
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 722
;722:					bs->teamgoal.areanum = areanum;
ADDRFP4 0
INDIRP4
CNSTI4 6636
ADDP4
ADDRLP4 656
INDIRI4
ASGNI4
line 723
;723:					VectorCopy(entinfo.origin, bs->teamgoal.origin);
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ADDRLP4 516+24
INDIRB
ASGNB 12
line 724
;724:					VectorSet(bs->teamgoal.mins, -8, -8, -8);
ADDRFP4 0
INDIRP4
CNSTI4 6640
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6644
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6648
ADDP4
CNSTF4 3238002688
ASGNF4
line 725
;725:					VectorSet(bs->teamgoal.maxs, 8, 8, 8);
ADDRFP4 0
INDIRP4
CNSTI4 6652
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6656
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6660
ADDP4
CNSTF4 1090519040
ASGNF4
line 727
;726:				//}
;727:			}
LABELV $292
line 728
;728:		}
LABELV $289
line 730
;729:		//if the other is not visible
;730:		if (bs->teamgoal.entitynum < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6664
ADDP4
INDIRI4
CNSTI4 0
GEI4 $286
line 731
;731:			BotAI_BotInitialChat(bs, "whereareyou", netname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $253
ARGP4
ADDRLP4 4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 732
;732:			client = ClientFromName(netname);
ADDRLP4 4
ARGP4
ADDRLP4 672
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 672
INDIRI4
ASGNI4
line 733
;733:			trap_BotEnterChat(bs->cs, client, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 734
;734:			return;
ADDRGP4 $276
JUMPV
line 736
;735:		}
;736:	}
LABELV $285
line 737
;737:	else if (!BotGetMessageTeamGoal(bs, itemname, &bs->teamgoal)) {
ADDRLP4 672
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 672
INDIRP4
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 672
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRLP4 676
ADDRGP4 BotGetMessageTeamGoal
CALLI4
ASGNI4
ADDRLP4 676
INDIRI4
CNSTI4 0
NEI4 $297
line 741
;738:		//BotAI_BotInitialChat(bs, "cannotfind", itemname, NULL);
;739:		//client = ClientFromName(netname);
;740:		//trap_BotEnterChat(bs->cs, client, CHAT_TELL);
;741:		return;
ADDRGP4 $276
JUMPV
LABELV $297
LABELV $286
LABELV $284
line 744
;742:	}
;743:	//
;744:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 745
;745:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 1
ASGNI4
line 746
;746:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 748
;747:	//set the time to send a message to the team mates
;748:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 680
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 680
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
line 750
;749:	//set the ltg type
;750:	bs->ltgtype = LTG_CAMPORDER;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 8
ASGNI4
line 752
;751:	//get the team goal time
;752:	bs->teamgoal_time = BotGetTime(match);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 684
ADDRGP4 BotGetTime
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRLP4 684
INDIRF4
ASGNF4
line 754
;753:	//set the team goal time
;754:	if (!bs->teamgoal_time) bs->teamgoal_time = FloatTime() + TEAM_CAMP_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
INDIRF4
CNSTF4 0
NEF4 $299
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
LABELV $299
line 756
;755:	//not arrived yet
;756:	bs->arrive_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6172
ADDP4
CNSTF4 0
ASGNF4
line 758
;757:	//
;758:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 760
;759:	// remember last ordered task
;760:	BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 764
;761:#ifdef DEBUG
;762:	BotPrintTeamGoal(bs);
;763:#endif //DEBUG
;764:}
LABELV $276
endproc BotMatch_Camp 688 16
export BotMatch_Patrol
proc BotMatch_Patrol 284 16
line 771
;765:
;766:/*
;767:==================
;768:BotMatch_Patrol
;769:==================
;770:*/
;771:void BotMatch_Patrol(bot_state_t *bs, bot_match_t *match) {
line 775
;772:	char netname[MAX_MESSAGE_SIZE];
;773:	int client;
;774:
;775:	if (!TeamPlayIsOn()) return;
ADDRLP4 260
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $302
ADDRGP4 $301
JUMPV
LABELV $302
line 777
;776:	//if not addressed to this bot
;777:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
NEI4 $304
ADDRGP4 $301
JUMPV
LABELV $304
line 779
;778:	//get the patrol waypoints
;779:	if (!BotGetPatrolWaypoints(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 268
ADDRGP4 BotGetPatrolWaypoints
CALLI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 0
NEI4 $306
ADDRGP4 $301
JUMPV
LABELV $306
line 781
;780:	//
;781:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 783
;782:	//
;783:	client = FindClientByName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 272
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 272
INDIRI4
ASGNI4
line 785
;784:	//
;785:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 256
INDIRI4
ASGNI4
line 786
;786:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 1
ASGNI4
line 787
;787:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 789
;788:	//set the time to send a message to the team mates
;789:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 276
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 276
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
line 791
;790:	//set the ltg type
;791:	bs->ltgtype = LTG_PATROL;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 9
ASGNI4
line 793
;792:	//get the team goal time
;793:	bs->teamgoal_time = BotGetTime(match);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 280
ADDRGP4 BotGetTime
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRLP4 280
INDIRF4
ASGNF4
line 795
;794:	//set the team goal time if not set already
;795:	if (!bs->teamgoal_time) bs->teamgoal_time = FloatTime() + TEAM_PATROL_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
INDIRF4
CNSTF4 0
NEF4 $308
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
LABELV $308
line 797
;796:	//
;797:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 799
;798:	// remember last ordered task
;799:	BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 803
;800:#ifdef DEBUG
;801:	BotPrintTeamGoal(bs);
;802:#endif //DEBUG
;803:}
LABELV $301
endproc BotMatch_Patrol 284 16
export BotMatch_GetFlag
proc BotMatch_GetFlag 276 16
line 810
;804:
;805:/*
;806:==================
;807:BotMatch_GetFlag
;808:==================
;809:*/
;810:void BotMatch_GetFlag(bot_state_t *bs, bot_match_t *match) {
line 814
;811:	char netname[MAX_MESSAGE_SIZE];
;812:	int client;
;813:
;814:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $311
line 815
;815:		if (!ctf_redflag.areanum || !ctf_blueflag.areanum)
ADDRGP4 ctf_redflag+12
INDIRI4
CNSTI4 0
EQI4 $317
ADDRGP4 ctf_blueflag+12
INDIRI4
CNSTI4 0
NEI4 $312
LABELV $317
line 816
;816:			return;
ADDRGP4 $310
JUMPV
line 817
;817:	}
LABELV $311
line 819
;818:#ifdef MISSIONPACK
;819:	else if (gametype == GT_1FCTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $310
line 820
;820:		if (!ctf_neutralflag.areanum || !ctf_redflag.areanum || !ctf_blueflag.areanum)
ADDRGP4 ctf_neutralflag+12
INDIRI4
CNSTI4 0
EQI4 $326
ADDRGP4 ctf_redflag+12
INDIRI4
CNSTI4 0
EQI4 $326
ADDRGP4 ctf_blueflag+12
INDIRI4
CNSTI4 0
NEI4 $319
LABELV $326
line 821
;821:			return;
ADDRGP4 $310
JUMPV
line 822
;822:	}
line 824
;823:#endif
;824:	else {
line 825
;825:		return;
LABELV $319
LABELV $312
line 828
;826:	}
;827:	//if not addressed to this bot
;828:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 260
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $327
ADDRGP4 $310
JUMPV
LABELV $327
line 830
;829:	//
;830:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 832
;831:	//
;832:	client = FindClientByName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 264
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 264
INDIRI4
ASGNI4
line 834
;833:	//
;834:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 256
INDIRI4
ASGNI4
line 835
;835:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 1
ASGNI4
line 836
;836:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 838
;837:	//set the time to send a message to the team mates
;838:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 268
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 268
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
line 840
;839:	//set the ltg type
;840:	bs->ltgtype = LTG_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 4
ASGNI4
line 842
;841:	//set the team goal time
;842:	bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 844
;843:	// get an alternate route in ctf
;844:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $329
line 846
;845:		//get an alternative route goal towards the enemy base
;846:		BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 847
;847:	}
LABELV $329
line 849
;848:	//
;849:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 851
;850:	// remember last ordered task
;851:	BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 855
;852:#ifdef DEBUG
;853:	BotPrintTeamGoal(bs);
;854:#endif //DEBUG
;855:}
LABELV $310
endproc BotMatch_GetFlag 276 16
export BotMatch_AttackEnemyBase
proc BotMatch_AttackEnemyBase 276 16
line 862
;856:
;857:/*
;858:==================
;859:BotMatch_AttackEnemyBase
;860:==================
;861:*/
;862:void BotMatch_AttackEnemyBase(bot_state_t *bs, bot_match_t *match) {
line 866
;863:	char netname[MAX_MESSAGE_SIZE];
;864:	int client;
;865:
;866:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $332
line 867
;867:		BotMatch_GetFlag(bs, match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotMatch_GetFlag
CALLV
pop
line 868
;868:	}
ADDRGP4 $333
JUMPV
LABELV $332
line 870
;869:#ifdef MISSIONPACK
;870:	else if (gametype == GT_1FCTF || gametype == GT_OBELISK || gametype == GT_HARVESTER) {
ADDRLP4 260
ADDRGP4 gametype
INDIRI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 5
EQI4 $337
ADDRLP4 260
INDIRI4
CNSTI4 6
EQI4 $337
ADDRLP4 260
INDIRI4
CNSTI4 7
NEI4 $331
LABELV $337
line 871
;871:		if (!redobelisk.areanum || !blueobelisk.areanum)
ADDRGP4 redobelisk+12
INDIRI4
CNSTI4 0
EQI4 $342
ADDRGP4 blueobelisk+12
INDIRI4
CNSTI4 0
NEI4 $335
LABELV $342
line 872
;872:			return;
ADDRGP4 $331
JUMPV
line 873
;873:	}
line 875
;874:#endif
;875:	else {
line 876
;876:		return;
LABELV $335
LABELV $333
line 879
;877:	}
;878:	//if not addressed to this bot
;879:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
NEI4 $343
ADDRGP4 $331
JUMPV
LABELV $343
line 881
;880:	//
;881:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 883
;882:	//
;883:	client = FindClientByName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 268
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 268
INDIRI4
ASGNI4
line 885
;884:	//
;885:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 256
INDIRI4
ASGNI4
line 886
;886:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 1
ASGNI4
line 887
;887:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 889
;888:	//set the time to send a message to the team mates
;889:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 272
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 272
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
line 891
;890:	//set the ltg type
;891:	bs->ltgtype = LTG_ATTACKENEMYBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 13
ASGNI4
line 893
;892:	//set the team goal time
;893:	bs->teamgoal_time = FloatTime() + TEAM_ATTACKENEMYBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 894
;894:	bs->attackaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6156
ADDP4
CNSTF4 0
ASGNF4
line 896
;895:	//
;896:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 898
;897:	// remember last ordered task
;898:	BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 902
;899:#ifdef DEBUG
;900:	BotPrintTeamGoal(bs);
;901:#endif //DEBUG
;902:}
LABELV $331
endproc BotMatch_AttackEnemyBase 276 16
export BotMatch_Harvest
proc BotMatch_Harvest 272 16
line 910
;903:
;904:#ifdef MISSIONPACK
;905:/*
;906:==================
;907:BotMatch_Harvest
;908:==================
;909:*/
;910:void BotMatch_Harvest(bot_state_t *bs, bot_match_t *match) {
line 914
;911:	char netname[MAX_MESSAGE_SIZE];
;912:	int client;
;913:
;914:	if (gametype == GT_HARVESTER) {
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $345
line 915
;915:		if (!neutralobelisk.areanum || !redobelisk.areanum || !blueobelisk.areanum)
ADDRGP4 neutralobelisk+12
INDIRI4
CNSTI4 0
EQI4 $354
ADDRGP4 redobelisk+12
INDIRI4
CNSTI4 0
EQI4 $354
ADDRGP4 blueobelisk+12
INDIRI4
CNSTI4 0
NEI4 $347
LABELV $354
line 916
;916:			return;
ADDRGP4 $345
JUMPV
line 917
;917:	}
line 918
;918:	else {
line 919
;919:		return;
LABELV $347
line 922
;920:	}
;921:	//if not addressed to this bot
;922:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 260
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $355
ADDRGP4 $345
JUMPV
LABELV $355
line 924
;923:	//
;924:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 926
;925:	//
;926:	client = FindClientByName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 264
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 264
INDIRI4
ASGNI4
line 928
;927:	//
;928:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 256
INDIRI4
ASGNI4
line 929
;929:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 1
ASGNI4
line 930
;930:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 932
;931:	//set the time to send a message to the team mates
;932:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 268
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 268
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
line 934
;933:	//set the ltg type
;934:	bs->ltgtype = LTG_HARVEST;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 12
ASGNI4
line 936
;935:	//set the team goal time
;936:	bs->teamgoal_time = FloatTime() + TEAM_HARVEST_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 937
;937:	bs->harvestaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6160
ADDP4
CNSTF4 0
ASGNF4
line 939
;938:	//
;939:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 941
;940:	// remember last ordered task
;941:	BotRememberLastOrderedTask(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRememberLastOrderedTask
CALLV
pop
line 945
;942:#ifdef DEBUG
;943:	BotPrintTeamGoal(bs);
;944:#endif //DEBUG
;945:}
LABELV $345
endproc BotMatch_Harvest 272 16
export BotMatch_RushBase
proc BotMatch_RushBase 276 16
line 953
;946:#endif
;947:
;948:/*
;949:==================
;950:BotMatch_RushBase
;951:==================
;952:*/
;953:void BotMatch_RushBase(bot_state_t *bs, bot_match_t *match) {
line 957
;954:	char netname[MAX_MESSAGE_SIZE];
;955:	int client;
;956:
;957:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $358
line 958
;958:		if (!ctf_redflag.areanum || !ctf_blueflag.areanum)
ADDRGP4 ctf_redflag+12
INDIRI4
CNSTI4 0
EQI4 $364
ADDRGP4 ctf_blueflag+12
INDIRI4
CNSTI4 0
NEI4 $359
LABELV $364
line 959
;959:			return;
ADDRGP4 $357
JUMPV
line 960
;960:	}
LABELV $358
line 962
;961:#ifdef MISSIONPACK
;962:	else if (gametype == GT_1FCTF || gametype == GT_HARVESTER) {
ADDRLP4 260
ADDRGP4 gametype
INDIRI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 5
EQI4 $367
ADDRLP4 260
INDIRI4
CNSTI4 7
NEI4 $357
LABELV $367
line 963
;963:		if (!redobelisk.areanum || !blueobelisk.areanum)
ADDRGP4 redobelisk+12
INDIRI4
CNSTI4 0
EQI4 $372
ADDRGP4 blueobelisk+12
INDIRI4
CNSTI4 0
NEI4 $366
LABELV $372
line 964
;964:			return;
ADDRGP4 $357
JUMPV
line 965
;965:	}
line 967
;966:#endif
;967:	else {
line 968
;968:		return;
LABELV $366
LABELV $359
line 971
;969:	}
;970:	//if not addressed to this bot
;971:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
NEI4 $373
ADDRGP4 $357
JUMPV
LABELV $373
line 973
;972:	//
;973:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 975
;974:	//
;975:	client = FindClientByName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 268
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 268
INDIRI4
ASGNI4
line 977
;976:	//
;977:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 256
INDIRI4
ASGNI4
line 978
;978:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 1
ASGNI4
line 979
;979:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 981
;980:	//set the time to send a message to the team mates
;981:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 272
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 272
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
line 983
;982:	//set the ltg type
;983:	bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 5
ASGNI4
line 985
;984:	//set the team goal time
;985:	bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 986
;986:	bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 988
;987:	//
;988:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 992
;989:#ifdef DEBUG
;990:	BotPrintTeamGoal(bs);
;991:#endif //DEBUG
;992:}
LABELV $357
endproc BotMatch_RushBase 276 16
export BotMatch_TaskPreference
proc BotMatch_TaskPreference 320 16
line 999
;993:
;994:/*
;995:==================
;996:BotMatch_TaskPreference
;997:==================
;998:*/
;999:void BotMatch_TaskPreference(bot_state_t *bs, bot_match_t *match) {
line 1004
;1000:	char netname[MAX_NETNAME];
;1001:	char teammatename[MAX_MESSAGE_SIZE];
;1002:	int teammate, preference;
;1003:
;1004:	ClientName(bs->client, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1005
;1005:	if (Q_stricmp(netname, bs->teamleader) != 0) return;
ADDRLP4 260
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 300
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 300
INDIRI4
CNSTI4 0
EQI4 $376
ADDRGP4 $375
JUMPV
LABELV $376
line 1007
;1006:
;1007:	trap_BotMatchVariable(match, NETNAME, teammatename, sizeof(teammatename));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1008
;1008:	teammate = ClientFromName(teammatename);
ADDRLP4 4
ARGP4
ADDRLP4 304
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 304
INDIRI4
ASGNI4
line 1009
;1009:	if (teammate < 0) return;
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $378
ADDRGP4 $375
JUMPV
LABELV $378
line 1011
;1010:
;1011:	preference = BotGetTeamMateTaskPreference(bs, teammate);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 308
ADDRGP4 BotGetTeamMateTaskPreference
CALLI4
ASGNI4
ADDRLP4 296
ADDRLP4 308
INDIRI4
ASGNI4
line 1012
;1012:	switch(match->subtype)
ADDRLP4 312
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
ASGNI4
ADDRLP4 312
INDIRI4
CNSTI4 1
EQI4 $383
ADDRLP4 312
INDIRI4
CNSTI4 2
EQI4 $384
ADDRLP4 312
INDIRI4
CNSTI4 4
EQI4 $385
ADDRGP4 $380
JUMPV
line 1013
;1013:	{
LABELV $383
line 1015
;1014:		case ST_DEFENDER:
;1015:		{
line 1016
;1016:			preference &= ~TEAMTP_ATTACKER;
ADDRLP4 296
ADDRLP4 296
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 1017
;1017:			preference |= TEAMTP_DEFENDER;
ADDRLP4 296
ADDRLP4 296
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1018
;1018:			break;
ADDRGP4 $381
JUMPV
LABELV $384
line 1021
;1019:		}
;1020:		case ST_ATTACKER:
;1021:		{
line 1022
;1022:			preference &= ~TEAMTP_DEFENDER;
ADDRLP4 296
ADDRLP4 296
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 1023
;1023:			preference |= TEAMTP_ATTACKER;
ADDRLP4 296
ADDRLP4 296
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 1024
;1024:			break;
ADDRGP4 $381
JUMPV
LABELV $385
line 1027
;1025:		}
;1026:		case ST_ROAMER:
;1027:		{
line 1028
;1028:			preference &= ~(TEAMTP_ATTACKER|TEAMTP_DEFENDER);
ADDRLP4 296
ADDRLP4 296
INDIRI4
CNSTI4 -4
BANDI4
ASGNI4
line 1029
;1029:			break;
LABELV $380
LABELV $381
line 1032
;1030:		}
;1031:	}
;1032:	BotSetTeamMateTaskPreference(bs, teammate, preference);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 296
INDIRI4
ARGI4
ADDRGP4 BotSetTeamMateTaskPreference
CALLV
pop
line 1034
;1033:	//
;1034:	EasyClientName(teammate, teammatename, sizeof(teammatename));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 1035
;1035:	BotAI_BotInitialChat(bs, "keepinmind", teammatename, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $386
ARGP4
ADDRLP4 4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1036
;1036:	trap_BotEnterChat(bs->cs, teammate, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1038
;1037:#ifdef MISSIONPACK
;1038:	BotVoiceChatOnly(bs, teammate, VOICECHAT_YES);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $387
ARGP4
ADDRGP4 BotVoiceChatOnly
CALLV
pop
line 1040
;1039:#endif
;1040:	trap_EA_Action(bs->client, ACTION_AFFIRMATIVE);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1048576
ARGI4
ADDRGP4 trap_EA_Action
CALLV
pop
line 1041
;1041:}
LABELV $375
endproc BotMatch_TaskPreference 320 16
export BotMatch_ReturnFlag
proc BotMatch_ReturnFlag 276 16
line 1048
;1042:
;1043:/*
;1044:==================
;1045:BotMatch_ReturnFlag
;1046:==================
;1047:*/
;1048:void BotMatch_ReturnFlag(bot_state_t *bs, bot_match_t *match) {
line 1054
;1049:	char netname[MAX_MESSAGE_SIZE];
;1050:	int client;
;1051:
;1052:	//if not in CTF mode
;1053:	if (
;1054:		gametype != GT_CTF
ADDRLP4 260
ADDRGP4 gametype
INDIRI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 4
EQI4 $389
ADDRLP4 260
INDIRI4
CNSTI4 5
EQI4 $389
line 1059
;1055:#ifdef MISSIONPACK
;1056:		&& gametype != GT_1FCTF
;1057:#endif
;1058:		)
;1059:		return;
ADDRGP4 $388
JUMPV
LABELV $389
line 1061
;1060:	//if not addressed to this bot
;1061:	if (!BotAddressedToBot(bs, match))
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
NEI4 $391
line 1062
;1062:		return;
ADDRGP4 $388
JUMPV
LABELV $391
line 1064
;1063:	//
;1064:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1066
;1065:	//
;1066:	client = FindClientByName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 268
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 268
INDIRI4
ASGNI4
line 1068
;1067:	//
;1068:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 256
INDIRI4
ASGNI4
line 1069
;1069:	bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 1
ASGNI4
line 1070
;1070:	bs->order_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1072
;1071:	//set the time to send a message to the team mates
;1072:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 272
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 272
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
line 1074
;1073:	//set the ltg type
;1074:	bs->ltgtype = LTG_RETURNFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 6
ASGNI4
line 1076
;1075:	//set the team goal time
;1076:	bs->teamgoal_time = FloatTime() + CTF_RETURNFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 1077
;1077:	bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 1079
;1078:	//
;1079:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1083
;1080:#ifdef DEBUG
;1081:	BotPrintTeamGoal(bs);
;1082:#endif //DEBUG
;1083:}
LABELV $388
endproc BotMatch_ReturnFlag 276 16
export BotMatch_JoinSubteam
proc BotMatch_JoinSubteam 528 16
line 1090
;1084:
;1085:/*
;1086:==================
;1087:BotMatch_JoinSubteam
;1088:==================
;1089:*/
;1090:void BotMatch_JoinSubteam(bot_state_t *bs, bot_match_t *match) {
line 1095
;1091:	char teammate[MAX_MESSAGE_SIZE];
;1092:	char netname[MAX_MESSAGE_SIZE];
;1093:	int client;
;1094:
;1095:	if (!TeamPlayIsOn()) return;
ADDRLP4 516
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 516
INDIRI4
CNSTI4 0
NEI4 $394
ADDRGP4 $393
JUMPV
LABELV $394
line 1097
;1096:	//if not addressed to this bot
;1097:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 520
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 520
INDIRI4
CNSTI4 0
NEI4 $396
ADDRGP4 $393
JUMPV
LABELV $396
line 1099
;1098:	//get the sub team name
;1099:	trap_BotMatchVariable(match, TEAMNAME, teammate, sizeof(teammate));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1101
;1100:	//set the sub team name
;1101:	Q_strncpyz( bs->subteam, teammate, sizeof( bs->subteam ) );
ADDRFP4 0
INDIRP4
CNSTI4 6984
ADDP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1103
;1102:	//
;1103:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 256
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1104
;1104:	BotAI_BotInitialChat(bs, "joinedteam", teammate, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $398
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1105
;1105:	client = ClientFromName(netname);
ADDRLP4 256
ARGP4
ADDRLP4 524
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 512
ADDRLP4 524
INDIRI4
ASGNI4
line 1106
;1106:	trap_BotEnterChat(bs->cs, client, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 512
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1107
;1107:}
LABELV $393
endproc BotMatch_JoinSubteam 528 16
export BotMatch_LeaveSubteam
proc BotMatch_LeaveSubteam 280 16
line 1114
;1108:
;1109:/*
;1110:==================
;1111:BotMatch_LeaveSubteam
;1112:==================
;1113:*/
;1114:void BotMatch_LeaveSubteam(bot_state_t *bs, bot_match_t *match) {
line 1118
;1115:	char netname[MAX_MESSAGE_SIZE];
;1116:	int client;
;1117:
;1118:	if (!TeamPlayIsOn()) return;
ADDRLP4 260
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $400
ADDRGP4 $399
JUMPV
LABELV $400
line 1120
;1119:	//if not addressed to this bot
;1120:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
NEI4 $402
ADDRGP4 $399
JUMPV
LABELV $402
line 1122
;1121:	//
;1122:	if (strlen(bs->subteam))
ADDRFP4 0
INDIRP4
CNSTI4 6984
ADDP4
ARGP4
ADDRLP4 268
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 268
INDIRU4
CNSTU4 0
EQU4 $404
line 1123
;1123:	{
line 1124
;1124:		BotAI_BotInitialChat(bs, "leftteam", bs->subteam, NULL);
ADDRLP4 272
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 272
INDIRP4
ARGP4
ADDRGP4 $406
ARGP4
ADDRLP4 272
INDIRP4
CNSTI4 6984
ADDP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1125
;1125:		trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1126
;1126:		client = ClientFromName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 276
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 276
INDIRI4
ASGNI4
line 1127
;1127:		trap_BotEnterChat(bs->cs, client, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1128
;1128:	} //end if
LABELV $404
line 1129
;1129:	strcpy(bs->subteam, "");
ADDRFP4 0
INDIRP4
CNSTI4 6984
ADDP4
ARGP4
ADDRGP4 $407
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1130
;1130:}
LABELV $399
endproc BotMatch_LeaveSubteam 280 16
export BotMatch_WhichTeam
proc BotMatch_WhichTeam 16 16
line 1137
;1131:
;1132:/*
;1133:==================
;1134:BotMatch_LeaveSubteam
;1135:==================
;1136:*/
;1137:void BotMatch_WhichTeam(bot_state_t *bs, bot_match_t *match) {
line 1138
;1138:	if (!TeamPlayIsOn()) return;
ADDRLP4 0
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $409
ADDRGP4 $408
JUMPV
LABELV $409
line 1140
;1139:	//if not addressed to this bot
;1140:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $411
ADDRGP4 $408
JUMPV
LABELV $411
line 1142
;1141:	//
;1142:	if (strlen(bs->subteam)) {
ADDRFP4 0
INDIRP4
CNSTI4 6984
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 8
INDIRU4
CNSTU4 0
EQU4 $413
line 1143
;1143:		BotAI_BotInitialChat(bs, "inteam", bs->subteam, NULL);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $415
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 6984
ADDP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1144
;1144:	}
ADDRGP4 $414
JUMPV
LABELV $413
line 1145
;1145:	else {
line 1146
;1146:		BotAI_BotInitialChat(bs, "noteam", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $416
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1147
;1147:	}
LABELV $414
line 1148
;1148:	trap_BotEnterChat(bs->cs, bs->client, CHAT_TEAM);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1149
;1149:}
LABELV $408
endproc BotMatch_WhichTeam 16 16
export BotMatch_CheckPoint
proc BotMatch_CheckPoint 564 24
line 1156
;1150:
;1151:/*
;1152:==================
;1153:BotMatch_CheckPoint
;1154:==================
;1155:*/
;1156:void BotMatch_CheckPoint(bot_state_t *bs, bot_match_t *match) {
line 1163
;1157:	int areanum, client;
;1158:	char buf[MAX_MESSAGE_SIZE];
;1159:	char netname[MAX_MESSAGE_SIZE];
;1160:	vec3_t position;
;1161:	bot_waypoint_t *cp;
;1162:
;1163:	if (!TeamPlayIsOn()) return;
ADDRLP4 536
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 536
INDIRI4
CNSTI4 0
NEI4 $418
ADDRGP4 $417
JUMPV
LABELV $418
line 1165
;1164:	//
;1165:	trap_BotMatchVariable(match, POSITION, buf, MAX_MESSAGE_SIZE);
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1166
;1166:	VectorClear(position);
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 4+4
CNSTF4 0
ASGNF4
ADDRLP4 4+8
CNSTF4 0
ASGNF4
line 1168
;1167:	//
;1168:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 276
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1169
;1169:	client = ClientFromName(netname);
ADDRLP4 276
ARGP4
ADDRLP4 540
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 532
ADDRLP4 540
INDIRI4
ASGNI4
line 1171
;1170:	//BotGPSToPosition(buf, position);
;1171:	Q_sscanf(buf, "%f %f %f", &position[0], &position[1], &position[2]);
ADDRLP4 16
ARGP4
ADDRGP4 $422
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 4+4
ARGP4
ADDRLP4 4+8
ARGP4
ADDRGP4 Q_sscanf
CALLI4
pop
line 1172
;1172:	position[2] += 0.5;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 1173
;1173:	areanum = BotPointAreaNum(position);
ADDRLP4 4
ARGP4
ADDRLP4 544
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 272
ADDRLP4 544
INDIRI4
ASGNI4
line 1174
;1174:	if (!areanum) {
ADDRLP4 272
INDIRI4
CNSTI4 0
NEI4 $426
line 1175
;1175:		if (BotAddressedToBot(bs, match)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 548
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 548
INDIRI4
CNSTI4 0
EQI4 $417
line 1176
;1176:			BotAI_BotInitialChat(bs, "checkpoint_invalid", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $430
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1177
;1177:			trap_BotEnterChat(bs->cs, client, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 532
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1178
;1178:		}
line 1179
;1179:		return;
ADDRGP4 $417
JUMPV
LABELV $426
line 1182
;1180:	}
;1181:	//
;1182:	trap_BotMatchVariable(match, NAME, buf, MAX_MESSAGE_SIZE);
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1184
;1183:	//check if there already exists a checkpoint with this name
;1184:	cp = BotFindWayPoint(bs->checkpoints, buf);
ADDRFP4 0
INDIRP4
CNSTI4 9076
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 548
ADDRGP4 BotFindWayPoint
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 548
INDIRP4
ASGNP4
line 1185
;1185:	if (cp) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $431
line 1186
;1186:		if (cp->next) cp->next->prev = cp->prev;
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $433
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CNSTI4 96
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
ASGNP4
LABELV $433
line 1187
;1187:		if (cp->prev) cp->prev->next = cp->next;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $435
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $436
JUMPV
LABELV $435
line 1188
;1188:		else bs->checkpoints = cp->next;
ADDRFP4 0
INDIRP4
CNSTI4 9076
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
LABELV $436
line 1189
;1189:		cp->inuse = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1190
;1190:	}
LABELV $431
line 1192
;1191:	//create a new check point
;1192:	cp = BotCreateWayPoint(buf, position, areanum);
ADDRLP4 16
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 272
INDIRI4
ARGI4
ADDRLP4 552
ADDRGP4 BotCreateWayPoint
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 552
INDIRP4
ASGNP4
line 1194
;1193:	//add the check point to the bot's known chech points
;1194:	cp->next = bs->checkpoints;
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 9076
ADDP4
INDIRP4
ASGNP4
line 1195
;1195:	if (bs->checkpoints) bs->checkpoints->prev = cp;
ADDRFP4 0
INDIRP4
CNSTI4 9076
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $437
ADDRFP4 0
INDIRP4
CNSTI4 9076
ADDP4
INDIRP4
CNSTI4 96
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $437
line 1196
;1196:	bs->checkpoints = cp;
ADDRFP4 0
INDIRP4
CNSTI4 9076
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1198
;1197:	//
;1198:	if (BotAddressedToBot(bs, match)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 556
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 556
INDIRI4
CNSTI4 0
EQI4 $439
line 1199
;1199:		Com_sprintf(buf, sizeof(buf), "%1.0f %1.0f %1.0f", cp->goal.origin[0],
ADDRLP4 16
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $441
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
ARGF4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1203
;1200:													cp->goal.origin[1],
;1201:													cp->goal.origin[2]);
;1202:
;1203:		BotAI_BotInitialChat(bs, "checkpoint_confirm", cp->name, buf, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $442
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 16
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1204
;1204:		trap_BotEnterChat(bs->cs, client, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 532
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1205
;1205:	}
LABELV $439
line 1206
;1206:}
LABELV $417
endproc BotMatch_CheckPoint 564 24
export BotMatch_FormationSpace
proc BotMatch_FormationSpace 280 16
line 1213
;1207:
;1208:/*
;1209:==================
;1210:BotMatch_FormationSpace
;1211:==================
;1212:*/
;1213:void BotMatch_FormationSpace(bot_state_t *bs, bot_match_t *match) {
line 1217
;1214:	char buf[MAX_MESSAGE_SIZE];
;1215:	float space;
;1216:
;1217:	if (!TeamPlayIsOn()) return;
ADDRLP4 260
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $444
ADDRGP4 $443
JUMPV
LABELV $444
line 1219
;1218:	//if not addressed to this bot
;1219:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
NEI4 $446
ADDRGP4 $443
JUMPV
LABELV $446
line 1221
;1220:	//
;1221:	trap_BotMatchVariable(match, NUMBER, buf, MAX_MESSAGE_SIZE);
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1223
;1222:	//if it's the distance in feet
;1223:	if (match->subtype & ST_FEET) space = 0.3048 * 32 * atof(buf);
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $448
ADDRLP4 4
ARGP4
ADDRLP4 268
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 268
INDIRF4
CNSTF4 1092357823
MULF4
ASGNF4
ADDRGP4 $449
JUMPV
LABELV $448
line 1225
;1224:	//else it's in meters
;1225:	else space = 32 * atof(buf);
ADDRLP4 4
ARGP4
ADDRLP4 272
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 272
INDIRF4
CNSTF4 1107296256
MULF4
ASGNF4
LABELV $449
line 1227
;1226:	//check if the formation intervening space is valid
;1227:	if (space < 48 || space > 500) space = 100;
ADDRLP4 0
INDIRF4
CNSTF4 1111490560
LTF4 $452
ADDRLP4 0
INDIRF4
CNSTF4 1140457472
LEF4 $450
LABELV $452
ADDRLP4 0
CNSTF4 1120403456
ASGNF4
LABELV $450
line 1228
;1228:	bs->formation_dist = space;
ADDRFP4 0
INDIRP4
CNSTI4 7016
ADDP4
ADDRLP4 0
INDIRF4
ASGNF4
line 1229
;1229:}
LABELV $443
endproc BotMatch_FormationSpace 280 16
export BotMatch_Dismiss
proc BotMatch_Dismiss 272 16
line 1236
;1230:
;1231:/*
;1232:==================
;1233:BotMatch_Dismiss
;1234:==================
;1235:*/
;1236:void BotMatch_Dismiss(bot_state_t *bs, bot_match_t *match) {
line 1240
;1237:	char netname[MAX_MESSAGE_SIZE];
;1238:	int client;
;1239:
;1240:	if (!TeamPlayIsOn()) return;
ADDRLP4 260
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $454
ADDRGP4 $453
JUMPV
LABELV $454
line 1242
;1241:	//if not addressed to this bot
;1242:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
NEI4 $456
ADDRGP4 $453
JUMPV
LABELV $456
line 1243
;1243:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1244
;1244:	client = ClientFromName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 268
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 268
INDIRI4
ASGNI4
line 1246
;1245:	//
;1246:	bs->decisionmaker = client;
ADDRFP4 0
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 256
INDIRI4
ASGNI4
line 1248
;1247:	//
;1248:	bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 1249
;1249:	bs->lead_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6884
ADDP4
CNSTF4 0
ASGNF4
line 1250
;1250:	bs->lastgoal_ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
CNSTI4 0
ASGNI4
line 1252
;1251:	//
;1252:	BotAI_BotInitialChat(bs, "dismissed", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $458
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1253
;1253:	trap_BotEnterChat(bs->cs, client, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1254
;1254:}
LABELV $453
endproc BotMatch_Dismiss 272 16
export BotMatch_Suicide
proc BotMatch_Suicide 272 16
line 1261
;1255:
;1256:/*
;1257:==================
;1258:BotMatch_Suicide
;1259:==================
;1260:*/
;1261:void BotMatch_Suicide(bot_state_t *bs, bot_match_t *match) {
line 1266
;1262:	char netname[MAX_MESSAGE_SIZE];
;1263:#ifdef MISSIONPACK
;1264:	int client;
;1265:#endif
;1266:	if (!TeamPlayIsOn()) return;
ADDRLP4 260
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $460
ADDRGP4 $459
JUMPV
LABELV $460
line 1268
;1267:	//if not addressed to this bot
;1268:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
NEI4 $462
ADDRGP4 $459
JUMPV
LABELV $462
line 1270
;1269:	//
;1270:	trap_EA_Command(bs->client, "kill");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $464
ARGP4
ADDRGP4 trap_EA_Command
CALLV
pop
line 1272
;1271:	//
;1272:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1275
;1273:	//
;1274:#ifdef MISSIONPACK
;1275:	client = ClientFromName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 268
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 268
INDIRI4
ASGNI4
line 1276
;1276:	BotVoiceChat(bs, client, VOICECHAT_TAUNT);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
ARGI4
ADDRGP4 $465
ARGP4
ADDRGP4 BotVoiceChat
CALLV
pop
line 1278
;1277:#endif
;1278:	trap_EA_Action(bs->client, ACTION_AFFIRMATIVE);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1048576
ARGI4
ADDRGP4 trap_EA_Action
CALLV
pop
line 1279
;1279:}
LABELV $459
endproc BotMatch_Suicide 272 16
export BotMatch_StartTeamLeaderShip
proc BotMatch_StartTeamLeaderShip 268 16
line 1286
;1280:
;1281:/*
;1282:==================
;1283:BotMatch_StartTeamLeaderShip
;1284:==================
;1285:*/
;1286:void BotMatch_StartTeamLeaderShip(bot_state_t *bs, bot_match_t *match) {
line 1290
;1287:	int client;
;1288:	char teammate[MAX_MESSAGE_SIZE];
;1289:
;1290:	if (!TeamPlayIsOn()) return;
ADDRLP4 260
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $467
ADDRGP4 $466
JUMPV
LABELV $467
line 1292
;1291:	//if chats for him or herself
;1292:	if (match->subtype & ST_I) {
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $469
line 1294
;1293:		//get the team mate that will be the team leader
;1294:		trap_BotMatchVariable(match, NETNAME, teammate, sizeof(teammate));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1295
;1295:		Q_strncpyz( bs->teamleader, teammate, sizeof( bs->teamleader ) );
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1296
;1296:	}
ADDRGP4 $470
JUMPV
LABELV $469
line 1298
;1297:	//chats for someone else
;1298:	else {
line 1300
;1299:		//get the team mate that will be the team leader
;1300:		trap_BotMatchVariable(match, TEAMMATE, teammate, sizeof(teammate));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1301
;1301:		client = FindClientByName(teammate);
ADDRLP4 0
ARGP4
ADDRLP4 264
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 264
INDIRI4
ASGNI4
line 1302
;1302:		if (client >= 0) ClientName(client, bs->teamleader, sizeof(bs->teamleader));
ADDRLP4 256
INDIRI4
CNSTI4 0
LTI4 $471
ADDRLP4 256
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
LABELV $471
line 1303
;1303:	}
LABELV $470
line 1304
;1304:}
LABELV $466
endproc BotMatch_StartTeamLeaderShip 268 16
export BotMatch_StopTeamLeaderShip
proc BotMatch_StopTeamLeaderShip 528 16
line 1311
;1305:
;1306:/*
;1307:==================
;1308:BotMatch_StopTeamLeaderShip
;1309:==================
;1310:*/
;1311:void BotMatch_StopTeamLeaderShip(bot_state_t *bs, bot_match_t *match) {
line 1316
;1312:	int client;
;1313:	char teammate[MAX_MESSAGE_SIZE];
;1314:	char netname[MAX_MESSAGE_SIZE];
;1315:
;1316:	if (!TeamPlayIsOn()) return;
ADDRLP4 516
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 516
INDIRI4
CNSTI4 0
NEI4 $474
ADDRGP4 $473
JUMPV
LABELV $474
line 1318
;1317:	//get the team mate that stops being the team leader
;1318:	trap_BotMatchVariable(match, TEAMMATE, teammate, sizeof(teammate));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1320
;1319:	//if chats for him or herself
;1320:	if (match->subtype & ST_I) {
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $476
line 1321
;1321:		trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1322
;1322:		client = FindClientByName(netname);
ADDRLP4 260
ARGP4
ADDRLP4 520
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 520
INDIRI4
ASGNI4
line 1323
;1323:	}
ADDRGP4 $477
JUMPV
LABELV $476
line 1325
;1324:	//chats for someone else
;1325:	else {
line 1326
;1326:		client = FindClientByName(teammate);
ADDRLP4 4
ARGP4
ADDRLP4 520
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 520
INDIRI4
ASGNI4
line 1327
;1327:	} //end else
LABELV $477
line 1328
;1328:	if (client >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $478
line 1329
;1329:		if (!Q_stricmp(bs->teamleader, ClientName(client, netname, sizeof(netname)))) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 520
ADDRGP4 ClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 520
INDIRP4
ARGP4
ADDRLP4 524
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 524
INDIRI4
CNSTI4 0
NEI4 $480
line 1330
;1330:			bs->teamleader[0] = '\0';
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
CNSTI1 0
ASGNI1
line 1331
;1331:			notleader[client] = qtrue;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 notleader
ADDP4
CNSTI4 1
ASGNI4
line 1332
;1332:		}
LABELV $480
line 1333
;1333:	}
LABELV $478
line 1334
;1334:}
LABELV $473
endproc BotMatch_StopTeamLeaderShip 528 16
export BotMatch_WhoIsTeamLeader
proc BotMatch_WhoIsTeamLeader 264 12
line 1341
;1335:
;1336:/*
;1337:==================
;1338:BotMatch_WhoIsTeamLeader
;1339:==================
;1340:*/
;1341:void BotMatch_WhoIsTeamLeader(bot_state_t *bs, bot_match_t *match) {
line 1344
;1342:	char netname[MAX_MESSAGE_SIZE];
;1343:
;1344:	if (!TeamPlayIsOn()) return;
ADDRLP4 256
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 256
INDIRI4
CNSTI4 0
NEI4 $483
ADDRGP4 $482
JUMPV
LABELV $483
line 1346
;1345:
;1346:	ClientName(bs->client, netname, sizeof(netname));
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
line 1348
;1347:	//if this bot IS the team leader
;1348:	if (!Q_stricmp(netname, bs->teamleader)) {
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 260
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
NEI4 $485
line 1349
;1349:		trap_EA_SayTeam(bs->client, "I'm the team leader\n");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $487
ARGP4
ADDRGP4 trap_EA_SayTeam
CALLV
pop
line 1350
;1350:	}
LABELV $485
line 1351
;1351:}
LABELV $482
endproc BotMatch_WhoIsTeamLeader 264 12
export BotMatch_WhatAreYouDoing
proc BotMatch_WhatAreYouDoing 532 16
line 1358
;1352:
;1353:/*
;1354:==================
;1355:BotMatch_WhatAreYouDoing
;1356:==================
;1357:*/
;1358:void BotMatch_WhatAreYouDoing(bot_state_t *bs, bot_match_t *match) {
line 1364
;1359:	char netname[MAX_MESSAGE_SIZE];
;1360:	char goalname[MAX_MESSAGE_SIZE];
;1361:	int client;
;1362:
;1363:	//if not addressed to this bot
;1364:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 516
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 516
INDIRI4
CNSTI4 0
NEI4 $489
ADDRGP4 $488
JUMPV
LABELV $489
line 1366
;1365:	//
;1366:	switch(bs->ltgtype) {
ADDRLP4 520
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
ADDRLP4 520
INDIRI4
CNSTI4 1
LTI4 $491
ADDRLP4 520
INDIRI4
CNSTI4 13
GTI4 $491
ADDRLP4 520
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $519-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $519
address $494
address $496
address $498
address $508
address $510
address $512
address $504
address $504
address $506
address $500
address $502
address $516
address $514
code
LABELV $494
line 1368
;1367:		case LTG_TEAMHELP:
;1368:		{
line 1369
;1369:			EasyClientName(bs->teammate, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 1370
;1370:			BotAI_BotInitialChat(bs, "helping", netname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $495
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1371
;1371:			break;
ADDRGP4 $492
JUMPV
LABELV $496
line 1374
;1372:		}
;1373:		case LTG_TEAMACCOMPANY:
;1374:		{
line 1375
;1375:			EasyClientName(bs->teammate, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 1376
;1376:			BotAI_BotInitialChat(bs, "accompanying", netname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $497
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1377
;1377:			break;
ADDRGP4 $492
JUMPV
LABELV $498
line 1380
;1378:		}
;1379:		case LTG_DEFENDKEYAREA:
;1380:		{
line 1381
;1381:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6668
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 1382
;1382:			BotAI_BotInitialChat(bs, "defending", goalname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $499
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1383
;1383:			break;
ADDRGP4 $492
JUMPV
LABELV $500
line 1386
;1384:		}
;1385:		case LTG_GETITEM:
;1386:		{
line 1387
;1387:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6668
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 1388
;1388:			BotAI_BotInitialChat(bs, "gettingitem", goalname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $501
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1389
;1389:			break;
ADDRGP4 $492
JUMPV
LABELV $502
line 1392
;1390:		}
;1391:		case LTG_KILL:
;1392:		{
line 1393
;1393:			ClientName(bs->teamgoal.entitynum, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 6664
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
line 1394
;1394:			BotAI_BotInitialChat(bs, "killing", netname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $503
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1395
;1395:			break;
ADDRGP4 $492
JUMPV
LABELV $504
line 1399
;1396:		}
;1397:		case LTG_CAMP:
;1398:		case LTG_CAMPORDER:
;1399:		{
line 1400
;1400:			BotAI_BotInitialChat(bs, "camping", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $505
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1401
;1401:			break;
ADDRGP4 $492
JUMPV
LABELV $506
line 1404
;1402:		}
;1403:		case LTG_PATROL:
;1404:		{
line 1405
;1405:			BotAI_BotInitialChat(bs, "patrolling", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $507
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1406
;1406:			break;
ADDRGP4 $492
JUMPV
LABELV $508
line 1409
;1407:		}
;1408:		case LTG_GETFLAG:
;1409:		{
line 1410
;1410:			BotAI_BotInitialChat(bs, "capturingflag", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $509
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1411
;1411:			break;
ADDRGP4 $492
JUMPV
LABELV $510
line 1414
;1412:		}
;1413:		case LTG_RUSHBASE:
;1414:		{
line 1415
;1415:			BotAI_BotInitialChat(bs, "rushingbase", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $511
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1416
;1416:			break;
ADDRGP4 $492
JUMPV
LABELV $512
line 1419
;1417:		}
;1418:		case LTG_RETURNFLAG:
;1419:		{
line 1420
;1420:			BotAI_BotInitialChat(bs, "returningflag", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $513
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1421
;1421:			break;
ADDRGP4 $492
JUMPV
LABELV $514
line 1425
;1422:		}
;1423:#ifdef MISSIONPACK
;1424:		case LTG_ATTACKENEMYBASE:
;1425:		{
line 1426
;1426:			BotAI_BotInitialChat(bs, "attackingenemybase", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $515
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1427
;1427:			break;
ADDRGP4 $492
JUMPV
LABELV $516
line 1430
;1428:		}
;1429:		case LTG_HARVEST:
;1430:		{
line 1431
;1431:			BotAI_BotInitialChat(bs, "harvesting", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $517
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1432
;1432:			break;
ADDRGP4 $492
JUMPV
LABELV $491
line 1436
;1433:		}
;1434:#endif
;1435:		default:
;1436:		{
line 1437
;1437:			BotAI_BotInitialChat(bs, "roaming", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $518
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1438
;1438:			break;
LABELV $492
line 1442
;1439:		}
;1440:	}
;1441:	//chat what the bot is doing
;1442:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1443
;1443:	client = ClientFromName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 528
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 256
ADDRLP4 528
INDIRI4
ASGNI4
line 1444
;1444:	trap_BotEnterChat(bs->cs, client, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 256
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1445
;1445:}
LABELV $488
endproc BotMatch_WhatAreYouDoing 532 16
export BotMatch_WhatIsMyCommand
proc BotMatch_WhatIsMyCommand 40 12
line 1452
;1446:
;1447:/*
;1448:==================
;1449:BotMatch_WhatIsMyCommand
;1450:==================
;1451:*/
;1452:void BotMatch_WhatIsMyCommand(bot_state_t *bs, bot_match_t *match) {
line 1455
;1453:	char netname[MAX_NETNAME];
;1454:
;1455:	ClientName(bs->client, netname, sizeof(netname));
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
line 1456
;1456:	if (Q_stricmp(netname, bs->teamleader) != 0) return;
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $522
ADDRGP4 $521
JUMPV
LABELV $522
line 1457
;1457:	bs->forceorders = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
CNSTI4 1
ASGNI4
line 1458
;1458:}
LABELV $521
endproc BotMatch_WhatIsMyCommand 40 12
export BotNearestVisibleItem
proc BotNearestVisibleItem 248 28
line 1465
;1459:
;1460:/*
;1461:==================
;1462:BotNearestVisibleItem
;1463:==================
;1464:*/
;1465:float BotNearestVisibleItem(bot_state_t *bs, char *itemname, bot_goal_t *goal) {
line 1473
;1466:	int i;
;1467:	char name[64];
;1468:	bot_goal_t tmpgoal;
;1469:	float dist, bestdist;
;1470:	vec3_t dir;
;1471:	bsp_trace_t trace;
;1472:
;1473:	bestdist = 999999;
ADDRLP4 140
CNSTF4 1232348144
ASGNF4
line 1474
;1474:	i = -1;
ADDRLP4 68
CNSTI4 -1
ASGNI4
LABELV $525
line 1475
;1475:	do {
line 1476
;1476:		i = trap_BotGetLevelItemGoal(i, itemname, &tmpgoal);
ADDRLP4 68
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 228
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 68
ADDRLP4 228
INDIRI4
ASGNI4
line 1477
;1477:		trap_BotGoalName(tmpgoal.number, name, sizeof(name));
ADDRLP4 0+44
INDIRI4
ARGI4
ADDRLP4 72
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 1478
;1478:		if (Q_stricmp(itemname, name) != 0)
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 232
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 232
INDIRI4
CNSTI4 0
EQI4 $529
line 1479
;1479:			continue;
ADDRGP4 $526
JUMPV
LABELV $529
line 1480
;1480:		VectorSubtract(tmpgoal.origin, bs->origin, dir);
ADDRLP4 236
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 0
INDIRF4
ADDRLP4 236
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 236
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56+8
ADDRLP4 0+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1481
;1481:		dist = VectorLength(dir);
ADDRLP4 56
ARGP4
ADDRLP4 240
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 136
ADDRLP4 240
INDIRF4
ASGNF4
line 1482
;1482:		if (dist < bestdist) {
ADDRLP4 136
INDIRF4
ADDRLP4 140
INDIRF4
GEF4 $535
line 1484
;1483:			//trace from start to end
;1484:			BotAI_Trace(&trace, bs->eye, NULL, NULL, tmpgoal.origin, bs->client, CONTENTS_SOLID|CONTENTS_PLAYERCLIP);
ADDRLP4 144
ARGP4
ADDRLP4 244
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 244
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
ADDRLP4 244
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
line 1485
;1485:			if (trace.fraction >= 1.0) {
ADDRLP4 144+8
INDIRF4
CNSTF4 1065353216
LTF4 $537
line 1486
;1486:				bestdist = dist;
ADDRLP4 140
ADDRLP4 136
INDIRF4
ASGNF4
line 1487
;1487:				memcpy(goal, &tmpgoal, sizeof(bot_goal_t));
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTU4 56
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 1488
;1488:			}
LABELV $537
line 1489
;1489:		}
LABELV $535
line 1490
;1490:	} while(i > 0);
LABELV $526
ADDRLP4 68
INDIRI4
CNSTI4 0
GTI4 $525
line 1491
;1491:	return bestdist;
ADDRLP4 140
INDIRF4
RETF4
LABELV $524
endproc BotNearestVisibleItem 248 28
data
align 4
LABELV $541
address $542
address $543
address $544
address $545
address $546
address $547
address $548
address $549
address $550
address $551
address $552
address $553
address $554
address $555
address $556
address $557
address $558
address $559
address $560
address $561
address $562
address $563
address $564
address $565
address $566
address $567
address $568
address $569
byte 4 0
export BotMatch_WhereAreYou
code
proc BotMatch_WhereAreYou 496 20
line 1499
;1492:}
;1493:
;1494:/*
;1495:==================
;1496:BotMatch_WhereAreYou
;1497:==================
;1498:*/
;1499:void BotMatch_WhereAreYou(bot_state_t *bs, bot_match_t *match) {
line 1504
;1500:	float dist, bestdist;
;1501:	int i, bestitem, redtt, bluett, client;
;1502:	bot_goal_t goal;
;1503:	char netname[MAX_MESSAGE_SIZE];
;1504:	char *nearbyitems[] = {
ADDRLP4 8
ADDRGP4 $541
INDIRB
ASGNB 116
line 1538
;1505:		"Shotgun",
;1506:		"Grenade Launcher",
;1507:		"Rocket Launcher",
;1508:		"Plasmagun",
;1509:		"Railgun",
;1510:		"Lightning Gun",
;1511:		"BFG10K",
;1512:		"Quad Damage",
;1513:		"Regeneration",
;1514:		"Battle Suit",
;1515:		"Speed",
;1516:		"Invisibility",
;1517:		"Flight",
;1518:		"Armor",
;1519:		"Heavy Armor",
;1520:		"Red Flag",
;1521:		"Blue Flag",
;1522:#ifdef MISSIONPACK
;1523:		"Nailgun",
;1524:		"Prox Launcher",
;1525:		"Chaingun",
;1526:		"Scout",
;1527:		"Guard",
;1528:		"Doubler",
;1529:		"Ammo Regen",
;1530:		"Neutral Flag",
;1531:		"Red Obelisk",
;1532:		"Blue Obelisk",
;1533:		"Neutral Obelisk",
;1534:#endif
;1535:		NULL
;1536:	};
;1537:	//
;1538:	if (!TeamPlayIsOn())
ADDRLP4 456
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 456
INDIRI4
CNSTI4 0
NEI4 $570
line 1539
;1539:		return;
ADDRGP4 $540
JUMPV
LABELV $570
line 1541
;1540:	//if not addressed to this bot
;1541:	if (!BotAddressedToBot(bs, match))
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 460
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 460
INDIRI4
CNSTI4 0
NEI4 $572
line 1542
;1542:		return;
ADDRGP4 $540
JUMPV
LABELV $572
line 1544
;1543:
;1544:	bestitem = -1;
ADDRLP4 184
CNSTI4 -1
ASGNI4
line 1545
;1545:	bestdist = 999999;
ADDRLP4 124
CNSTF4 1232348144
ASGNF4
line 1546
;1546:	for (i = 0; nearbyitems[i]; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $577
JUMPV
LABELV $574
line 1547
;1547:		dist = BotNearestVisibleItem(bs, nearbyitems[i], &goal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 128
ARGP4
ADDRLP4 464
ADDRGP4 BotNearestVisibleItem
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 464
INDIRF4
ASGNF4
line 1548
;1548:		if (dist < bestdist) {
ADDRLP4 4
INDIRF4
ADDRLP4 124
INDIRF4
GEF4 $578
line 1549
;1549:			bestdist = dist;
ADDRLP4 124
ADDRLP4 4
INDIRF4
ASGNF4
line 1550
;1550:			bestitem = i;
ADDRLP4 184
ADDRLP4 0
INDIRI4
ASGNI4
line 1551
;1551:		}
LABELV $578
line 1552
;1552:	}
LABELV $575
line 1546
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $577
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $574
line 1553
;1553:	if (bestitem != -1) {
ADDRLP4 184
INDIRI4
CNSTI4 -1
EQI4 $580
line 1554
;1554:		if (gametype == GT_CTF
ADDRLP4 464
ADDRGP4 gametype
INDIRI4
ASGNI4
ADDRLP4 464
INDIRI4
CNSTI4 4
EQI4 $584
ADDRLP4 464
INDIRI4
CNSTI4 5
NEI4 $582
LABELV $584
line 1558
;1555:#ifdef MISSIONPACK
;1556:			|| gametype == GT_1FCTF
;1557:#endif
;1558:			) {
line 1559
;1559:			redtt = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, ctf_redflag.areanum, TFL_DEFAULT);
ADDRLP4 468
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 468
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 468
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRGP4 ctf_redflag+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 472
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 444
ADDRLP4 472
INDIRI4
ASGNI4
line 1560
;1560:			bluett = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, ctf_blueflag.areanum, TFL_DEFAULT);
ADDRLP4 476
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 476
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 476
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRGP4 ctf_blueflag+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 480
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 448
ADDRLP4 480
INDIRI4
ASGNI4
line 1561
;1561:			if (redtt < (redtt + bluett) * 0.4) {
ADDRLP4 484
ADDRLP4 444
INDIRI4
ASGNI4
ADDRLP4 484
INDIRI4
CVIF4 4
ADDRLP4 484
INDIRI4
ADDRLP4 448
INDIRI4
ADDI4
CVIF4 4
CNSTF4 1053609165
MULF4
GEF4 $587
line 1562
;1562:				BotAI_BotInitialChat(bs, "teamlocation", nearbyitems[bestitem], "red", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $589
ARGP4
ADDRLP4 184
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
ARGP4
ADDRGP4 $590
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1563
;1563:			}
ADDRGP4 $583
JUMPV
LABELV $587
line 1564
;1564:			else if (bluett < (redtt + bluett) * 0.4) {
ADDRLP4 488
ADDRLP4 448
INDIRI4
ASGNI4
ADDRLP4 488
INDIRI4
CVIF4 4
ADDRLP4 444
INDIRI4
ADDRLP4 488
INDIRI4
ADDI4
CVIF4 4
CNSTF4 1053609165
MULF4
GEF4 $591
line 1565
;1565:				BotAI_BotInitialChat(bs, "teamlocation", nearbyitems[bestitem], "blue", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $589
ARGP4
ADDRLP4 184
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
ARGP4
ADDRGP4 $593
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1566
;1566:			}
ADDRGP4 $583
JUMPV
LABELV $591
line 1567
;1567:			else {
line 1568
;1568:				BotAI_BotInitialChat(bs, "location", nearbyitems[bestitem], NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $594
ARGP4
ADDRLP4 184
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1569
;1569:			}
line 1570
;1570:		}
ADDRGP4 $583
JUMPV
LABELV $582
line 1572
;1571:#ifdef MISSIONPACK
;1572:		else if (gametype == GT_OBELISK || gametype == GT_HARVESTER) {
ADDRLP4 468
ADDRGP4 gametype
INDIRI4
ASGNI4
ADDRLP4 468
INDIRI4
CNSTI4 6
EQI4 $597
ADDRLP4 468
INDIRI4
CNSTI4 7
NEI4 $595
LABELV $597
line 1573
;1573:			redtt = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, redobelisk.areanum, TFL_DEFAULT);
ADDRLP4 472
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 472
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 472
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRGP4 redobelisk+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 476
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 444
ADDRLP4 476
INDIRI4
ASGNI4
line 1574
;1574:			bluett = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, blueobelisk.areanum, TFL_DEFAULT);
ADDRLP4 480
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 480
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 480
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRGP4 blueobelisk+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 484
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 448
ADDRLP4 484
INDIRI4
ASGNI4
line 1575
;1575:			if (redtt < (redtt + bluett) * 0.4) {
ADDRLP4 488
ADDRLP4 444
INDIRI4
ASGNI4
ADDRLP4 488
INDIRI4
CVIF4 4
ADDRLP4 488
INDIRI4
ADDRLP4 448
INDIRI4
ADDI4
CVIF4 4
CNSTF4 1053609165
MULF4
GEF4 $600
line 1576
;1576:				BotAI_BotInitialChat(bs, "teamlocation", nearbyitems[bestitem], "red", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $589
ARGP4
ADDRLP4 184
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
ARGP4
ADDRGP4 $590
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1577
;1577:			}
ADDRGP4 $596
JUMPV
LABELV $600
line 1578
;1578:			else if (bluett < (redtt + bluett) * 0.4) {
ADDRLP4 492
ADDRLP4 448
INDIRI4
ASGNI4
ADDRLP4 492
INDIRI4
CVIF4 4
ADDRLP4 444
INDIRI4
ADDRLP4 492
INDIRI4
ADDI4
CVIF4 4
CNSTF4 1053609165
MULF4
GEF4 $602
line 1579
;1579:				BotAI_BotInitialChat(bs, "teamlocation", nearbyitems[bestitem], "blue", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $589
ARGP4
ADDRLP4 184
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
ARGP4
ADDRGP4 $593
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1580
;1580:			}
ADDRGP4 $596
JUMPV
LABELV $602
line 1581
;1581:			else {
line 1582
;1582:				BotAI_BotInitialChat(bs, "location", nearbyitems[bestitem], NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $594
ARGP4
ADDRLP4 184
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1583
;1583:			}
line 1584
;1584:		}
ADDRGP4 $596
JUMPV
LABELV $595
line 1586
;1585:#endif
;1586:		else {
line 1587
;1587:			BotAI_BotInitialChat(bs, "location", nearbyitems[bestitem], NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $594
ARGP4
ADDRLP4 184
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1588
;1588:		}
LABELV $596
LABELV $583
line 1589
;1589:		trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 188
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1590
;1590:		client = ClientFromName(netname);
ADDRLP4 188
ARGP4
ADDRLP4 472
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 452
ADDRLP4 472
INDIRI4
ASGNI4
line 1591
;1591:		trap_BotEnterChat(bs->cs, client, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 452
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1592
;1592:	}
LABELV $580
line 1593
;1593:}
LABELV $540
endproc BotMatch_WhereAreYou 496 20
export BotMatch_LeadTheWay
proc BotMatch_LeadTheWay 680 16
line 1600
;1594:
;1595:/*
;1596:==================
;1597:BotMatch_LeadTheWay
;1598:==================
;1599:*/
;1600:void BotMatch_LeadTheWay(bot_state_t *bs, bot_match_t *match) {
line 1605
;1601:	aas_entityinfo_t entinfo;
;1602:	char netname[MAX_MESSAGE_SIZE], teammate[MAX_MESSAGE_SIZE];
;1603:	int client, areanum, other;
;1604:
;1605:	if (!TeamPlayIsOn()) return;
ADDRLP4 664
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 664
INDIRI4
CNSTI4 0
NEI4 $605
ADDRGP4 $604
JUMPV
LABELV $605
line 1607
;1606:	//if not addressed to this bot
;1607:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 668
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 668
INDIRI4
CNSTI4 0
NEI4 $607
ADDRGP4 $604
JUMPV
LABELV $607
line 1609
;1608:	//if someone asks for someone else
;1609:	if (match->subtype & ST_SOMEONE) {
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $609
line 1611
;1610:		//get the team mate name
;1611:		trap_BotMatchVariable(match, TEAMMATE, teammate, sizeof(teammate));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 400
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1612
;1612:		client = FindClientByName(teammate);
ADDRLP4 400
ARGP4
ADDRLP4 672
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 672
INDIRI4
ASGNI4
line 1614
;1613:		//if this is the bot self
;1614:		if (client == bs->client) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $611
line 1615
;1615:			other = qfalse;
ADDRLP4 656
CNSTI4 0
ASGNI4
line 1616
;1616:		}
ADDRGP4 $610
JUMPV
LABELV $611
line 1617
;1617:		else if (!BotSameTeam(bs, client)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 676
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 676
INDIRI4
CNSTI4 0
NEI4 $613
line 1619
;1618:			//FIXME: say "I don't help the enemy"
;1619:			return;
ADDRGP4 $604
JUMPV
LABELV $613
line 1621
;1620:		}
;1621:		else {
line 1622
;1622:			other = qtrue;
ADDRLP4 656
CNSTI4 1
ASGNI4
line 1623
;1623:		}
line 1624
;1624:	}
ADDRGP4 $610
JUMPV
LABELV $609
line 1625
;1625:	else {
line 1627
;1626:		//get the netname
;1627:		trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 144
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1628
;1628:		client = ClientFromName(netname);
ADDRLP4 144
ARGP4
ADDRLP4 672
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 672
INDIRI4
ASGNI4
line 1629
;1629:		other = qfalse;
ADDRLP4 656
CNSTI4 0
ASGNI4
line 1630
;1630:	}
LABELV $610
line 1632
;1631:	//if the bot doesn't know who to help (FindClientByName returned -1)
;1632:	if (client < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $615
line 1633
;1633:		BotAI_BotInitialChat(bs, "whois", netname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $233
ARGP4
ADDRLP4 144
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1634
;1634:		trap_BotEnterChat(bs->cs, bs->client, CHAT_TEAM);
ADDRLP4 672
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 672
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 672
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1635
;1635:		return;
ADDRGP4 $604
JUMPV
LABELV $615
line 1638
;1636:	}
;1637:	//
;1638:	bs->lead_teamgoal.entitynum = -1;
ADDRFP4 0
INDIRP4
CNSTI4 6868
ADDP4
CNSTI4 -1
ASGNI4
line 1639
;1639:	BotEntityInfo(client, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1641
;1640:	//if info is valid (in PVS)
;1641:	if (entinfo.valid) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $617
line 1642
;1642:		areanum = BotPointAreaNum(entinfo.origin);
ADDRLP4 4+24
ARGP4
ADDRLP4 672
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 660
ADDRLP4 672
INDIRI4
ASGNI4
line 1643
;1643:		if (areanum) { // && trap_AAS_AreaReachability(areanum)) {
ADDRLP4 660
INDIRI4
CNSTI4 0
EQI4 $620
line 1644
;1644:			bs->lead_teamgoal.entitynum = client;
ADDRFP4 0
INDIRP4
CNSTI4 6868
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1645
;1645:			bs->lead_teamgoal.areanum = areanum;
ADDRFP4 0
INDIRP4
CNSTI4 6840
ADDP4
ADDRLP4 660
INDIRI4
ASGNI4
line 1646
;1646:			VectorCopy(entinfo.origin, bs->lead_teamgoal.origin);
ADDRFP4 0
INDIRP4
CNSTI4 6828
ADDP4
ADDRLP4 4+24
INDIRB
ASGNB 12
line 1647
;1647:			VectorSet(bs->lead_teamgoal.mins, -8, -8, -8);
ADDRFP4 0
INDIRP4
CNSTI4 6844
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6848
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6852
ADDP4
CNSTF4 3238002688
ASGNF4
line 1648
;1648:			VectorSet(bs->lead_teamgoal.maxs, 8, 8, 8);
ADDRFP4 0
INDIRP4
CNSTI4 6856
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6860
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 6864
ADDP4
CNSTF4 1090519040
ASGNF4
line 1649
;1649:		}
LABELV $620
line 1650
;1650:	}
LABELV $617
line 1652
;1651:
;1652:	if (bs->teamgoal.entitynum < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6664
ADDP4
INDIRI4
CNSTI4 0
GEI4 $623
line 1653
;1653:		if (other) BotAI_BotInitialChat(bs, "whereis", teammate, NULL);
ADDRLP4 656
INDIRI4
CNSTI4 0
EQI4 $625
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $252
ARGP4
ADDRLP4 400
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $626
JUMPV
LABELV $625
line 1654
;1654:		else BotAI_BotInitialChat(bs, "whereareyou", netname, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $253
ARGP4
ADDRLP4 144
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
LABELV $626
line 1655
;1655:		trap_BotEnterChat(bs->cs, bs->client, CHAT_TEAM);
ADDRLP4 672
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 672
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 672
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1656
;1656:		return;
ADDRGP4 $604
JUMPV
LABELV $623
line 1658
;1657:	}
;1658:	bs->lead_teammate = client;
ADDRFP4 0
INDIRP4
CNSTI4 6824
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1659
;1659:	bs->lead_time = FloatTime() + TEAM_LEAD_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6884
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 1660
;1660:	bs->leadvisible_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6888
ADDP4
CNSTF4 0
ASGNF4
line 1661
;1661:	bs->leadmessage_time = -(FloatTime() + 2 * random());
ADDRLP4 672
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6892
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 672
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1073741824
MULF4
ADDF4
NEGF4
ASGNF4
line 1662
;1662:}
LABELV $604
endproc BotMatch_LeadTheWay 680 16
export BotMatch_Kill
proc BotMatch_Kill 532 16
line 1669
;1663:
;1664:/*
;1665:==================
;1666:BotMatch_Kill
;1667:==================
;1668:*/
;1669:void BotMatch_Kill(bot_state_t *bs, bot_match_t *match) {
line 1674
;1670:	char enemy[MAX_MESSAGE_SIZE];
;1671:	char netname[MAX_MESSAGE_SIZE];
;1672:	int client;
;1673:
;1674:	if (!TeamPlayIsOn()) return;
ADDRLP4 516
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 516
INDIRI4
CNSTI4 0
NEI4 $628
ADDRGP4 $627
JUMPV
LABELV $628
line 1676
;1675:	//if not addressed to this bot
;1676:	if (!BotAddressedToBot(bs, match)) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 520
ADDRGP4 BotAddressedToBot
CALLI4
ASGNI4
ADDRLP4 520
INDIRI4
CNSTI4 0
NEI4 $630
ADDRGP4 $627
JUMPV
LABELV $630
line 1678
;1677:
;1678:	trap_BotMatchVariable(match, ENEMY, enemy, sizeof(enemy));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1680
;1679:	//
;1680:	client = FindEnemyByName(bs, enemy);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 524
ADDRGP4 FindEnemyByName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 524
INDIRI4
ASGNI4
line 1681
;1681:	if (client < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $632
line 1682
;1682:		BotAI_BotInitialChat(bs, "whois", enemy, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $233
ARGP4
ADDRLP4 4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1683
;1683:		trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1684
;1684:		client = ClientFromName(netname);
ADDRLP4 260
ARGP4
ADDRLP4 528
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 528
INDIRI4
ASGNI4
line 1685
;1685:		trap_BotEnterChat(bs->cs, client, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1686
;1686:		return;
ADDRGP4 $627
JUMPV
LABELV $632
line 1688
;1687:	}
;1688:	bs->teamgoal.entitynum = client;
ADDRFP4 0
INDIRP4
CNSTI4 6664
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1690
;1689:	//set the time to send a message to the team mates
;1690:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 528
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 528
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
line 1692
;1691:	//set the ltg type
;1692:	bs->ltgtype = LTG_KILL;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 11
ASGNI4
line 1694
;1693:	//set the team goal time
;1694:	bs->teamgoal_time = FloatTime() + TEAM_KILL_SOMEONE;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 1696
;1695:	//
;1696:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1700
;1697:#ifdef DEBUG
;1698:	BotPrintTeamGoal(bs);
;1699:#endif //DEBUG
;1700:}
LABELV $627
endproc BotMatch_Kill 532 16
export BotMatch_CTF
proc BotMatch_CTF 176 16
line 1707
;1701:
;1702:/*
;1703:==================
;1704:BotMatch_CTF
;1705:==================
;1706:*/
;1707:void BotMatch_CTF(bot_state_t *bs, bot_match_t *match) {
line 1711
;1708:
;1709:	char flag[128], netname[MAX_NETNAME];
;1710:
;1711:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $635
line 1712
;1712:		trap_BotMatchVariable(match, FLAG, flag, sizeof(flag));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1713
;1713:		if (match->subtype & ST_GOTFLAG) {
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $637
line 1714
;1714:			if (!Q_stricmp(flag, "red")) {
ADDRLP4 0
ARGP4
ADDRGP4 $590
ARGP4
ADDRLP4 164
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
NEI4 $639
line 1715
;1715:				bs->redflagstatus = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
CNSTI4 1
ASGNI4
line 1716
;1716:				if (BotTeam(bs) == TEAM_BLUE) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 168
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 2
NEI4 $640
line 1717
;1717:					trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 128
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1718
;1718:					bs->flagcarrier = ClientFromName(netname);
ADDRLP4 128
ARGP4
ADDRLP4 172
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
ADDRLP4 172
INDIRI4
ASGNI4
line 1719
;1719:				}
line 1720
;1720:			}
ADDRGP4 $640
JUMPV
LABELV $639
line 1721
;1721:			else {
line 1722
;1722:				bs->blueflagstatus = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6960
ADDP4
CNSTI4 1
ASGNI4
line 1723
;1723:				if (BotTeam(bs) == TEAM_RED) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 168
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 1
NEI4 $643
line 1724
;1724:					trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 128
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1725
;1725:					bs->flagcarrier = ClientFromName(netname);
ADDRLP4 128
ARGP4
ADDRLP4 172
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
ADDRLP4 172
INDIRI4
ASGNI4
line 1726
;1726:				}
LABELV $643
line 1727
;1727:			}
LABELV $640
line 1728
;1728:			bs->flagstatuschanged = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 1729
;1729:			bs->lastflagcapture_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6948
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1730
;1730:		}
ADDRGP4 $636
JUMPV
LABELV $637
line 1731
;1731:		else if (match->subtype & ST_CAPTUREDFLAG) {
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $645
line 1732
;1732:			bs->redflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
CNSTI4 0
ASGNI4
line 1733
;1733:			bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6960
ADDP4
CNSTI4 0
ASGNI4
line 1734
;1734:			bs->flagcarrier = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
CNSTI4 0
ASGNI4
line 1735
;1735:			bs->flagstatuschanged = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 1736
;1736:		}
ADDRGP4 $636
JUMPV
LABELV $645
line 1737
;1737:		else if (match->subtype & ST_RETURNEDFLAG) {
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $636
line 1738
;1738:			if (!Q_stricmp(flag, "red")) bs->redflagstatus = 0;
ADDRLP4 0
ARGP4
ADDRGP4 $590
ARGP4
ADDRLP4 164
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
NEI4 $649
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
CNSTI4 0
ASGNI4
ADDRGP4 $650
JUMPV
LABELV $649
line 1739
;1739:			else bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6960
ADDP4
CNSTI4 0
ASGNI4
LABELV $650
line 1740
;1740:			bs->flagstatuschanged = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 1741
;1741:		}
line 1742
;1742:	}
ADDRGP4 $636
JUMPV
LABELV $635
line 1744
;1743:#ifdef MISSIONPACK
;1744:	else if (gametype == GT_1FCTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $651
line 1745
;1745:		if (match->subtype & ST_1FCTFGOTFLAG) {
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 65535
BANDI4
CNSTI4 0
EQI4 $653
line 1746
;1746:			trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 128
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1747
;1747:			bs->flagcarrier = ClientFromName(netname);
ADDRLP4 128
ARGP4
ADDRLP4 164
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
ADDRLP4 164
INDIRI4
ASGNI4
line 1748
;1748:		}
LABELV $653
line 1749
;1749:	}
LABELV $651
LABELV $636
line 1751
;1750:#endif
;1751:}
LABELV $634
endproc BotMatch_CTF 176 16
export BotMatch_EnterGame
proc BotMatch_EnterGame 44 16
line 1753
;1752:
;1753:void BotMatch_EnterGame(bot_state_t *bs, bot_match_t *match) {
line 1757
;1754:	int client;
;1755:	char netname[MAX_NETNAME];
;1756:
;1757:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1758
;1758:	client = FindClientByName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 40
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 40
INDIRI4
ASGNI4
line 1759
;1759:	if (client >= 0) {
ADDRLP4 36
INDIRI4
CNSTI4 0
LTI4 $656
line 1760
;1760:		notleader[client] = qfalse;
ADDRLP4 36
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 notleader
ADDP4
CNSTI4 0
ASGNI4
line 1761
;1761:	}
LABELV $656
line 1765
;1762:	//NOTE: eliza chats will catch this
;1763:	//Com_sprintf(buf, sizeof(buf), "heya %s", netname);
;1764:	//EA_Say(bs->client, buf);
;1765:}
LABELV $655
endproc BotMatch_EnterGame 44 16
export BotMatch_NewLeader
proc BotMatch_NewLeader 48 16
line 1767
;1766:
;1767:void BotMatch_NewLeader(bot_state_t *bs, bot_match_t *match) {
line 1771
;1768:	int client;
;1769:	char netname[MAX_NETNAME];
;1770:
;1771:	trap_BotMatchVariable(match, NETNAME, netname, sizeof(netname));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 1772
;1772:	client = FindClientByName(netname);
ADDRLP4 0
ARGP4
ADDRLP4 40
ADDRGP4 FindClientByName
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 40
INDIRI4
ASGNI4
line 1773
;1773:	if (!BotSameTeam(bs, client))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $659
line 1774
;1774:		return;
ADDRGP4 $658
JUMPV
LABELV $659
line 1775
;1775:	Q_strncpyz(bs->teamleader, netname, sizeof(bs->teamleader));
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1776
;1776:}
LABELV $658
endproc BotMatch_NewLeader 48 16
export BotMatchMessage
proc BotMatchMessage 336 12
line 1783
;1777:
;1778:/*
;1779:==================
;1780:BotMatchMessage
;1781:==================
;1782:*/
;1783:int BotMatchMessage(bot_state_t *bs, char *message) {
line 1786
;1784:	bot_match_t match;
;1785:
;1786:	match.type = 0;
ADDRLP4 0+256
CNSTI4 0
ASGNI4
line 1788
;1787:	//if it is an unknown message
;1788:	if (!trap_BotFindMatch(message, &match, MTCONTEXT_MISC
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTU4 262
ARGU4
ADDRLP4 328
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 328
INDIRI4
CNSTI4 0
NEI4 $663
line 1790
;1789:											|MTCONTEXT_INITIALTEAMCHAT
;1790:											|MTCONTEXT_CTF)) {
line 1791
;1791:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $661
JUMPV
LABELV $663
line 1794
;1792:	}
;1793:	//react to the found message
;1794:	switch(match.type)
ADDRLP4 332
ADDRLP4 0+256
INDIRI4
ASGNI4
ADDRLP4 332
INDIRI4
CNSTI4 1
LTI4 $665
ADDRLP4 332
INDIRI4
CNSTI4 33
GTI4 $703
ADDRLP4 332
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $704-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $704
address $699
address $698
address $668
address $668
address $669
address $675
address $672
address $690
address $691
address $692
address $666
address $693
address $680
address $681
address $684
address $686
address $687
address $666
address $689
address $670
address $683
address $671
address $696
address $679
address $697
address $695
address $676
address $694
address $682
address $677
address $673
address $674
address $701
code
LABELV $703
ADDRLP4 0+256
INDIRI4
CNSTI4 300
EQI4 $678
ADDRGP4 $665
JUMPV
line 1795
;1795:	{
LABELV $668
line 1798
;1796:		case MSG_HELP:					//someone calling for help
;1797:		case MSG_ACCOMPANY:				//someone calling for company
;1798:		{
line 1799
;1799:			BotMatch_HelpAccompany(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_HelpAccompany
CALLV
pop
line 1800
;1800:			break;
ADDRGP4 $666
JUMPV
LABELV $669
line 1803
;1801:		}
;1802:		case MSG_DEFENDKEYAREA:			//teamplay defend a key area
;1803:		{
line 1804
;1804:			BotMatch_DefendKeyArea(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_DefendKeyArea
CALLV
pop
line 1805
;1805:			break;
ADDRGP4 $666
JUMPV
LABELV $670
line 1808
;1806:		}
;1807:		case MSG_CAMP:					//camp somewhere
;1808:		{
line 1809
;1809:			BotMatch_Camp(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_Camp
CALLV
pop
line 1810
;1810:			break;
ADDRGP4 $666
JUMPV
LABELV $671
line 1813
;1811:		}
;1812:		case MSG_PATROL:				//patrol between several key areas
;1813:		{
line 1814
;1814:			BotMatch_Patrol(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_Patrol
CALLV
pop
line 1815
;1815:			break;
ADDRGP4 $666
JUMPV
LABELV $672
line 1819
;1816:		}
;1817:		//CTF & 1FCTF
;1818:		case MSG_GETFLAG:				//ctf get the enemy flag
;1819:		{
line 1820
;1820:			BotMatch_GetFlag(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_GetFlag
CALLV
pop
line 1821
;1821:			break;
ADDRGP4 $666
JUMPV
LABELV $673
line 1826
;1822:		}
;1823:#ifdef MISSIONPACK
;1824:		//CTF & 1FCTF & Obelisk & Harvester
;1825:		case MSG_ATTACKENEMYBASE:
;1826:		{
line 1827
;1827:			BotMatch_AttackEnemyBase(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_AttackEnemyBase
CALLV
pop
line 1828
;1828:			break;
ADDRGP4 $666
JUMPV
LABELV $674
line 1832
;1829:		}
;1830:		//Harvester
;1831:		case MSG_HARVEST:
;1832:		{
line 1833
;1833:			BotMatch_Harvest(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_Harvest
CALLV
pop
line 1834
;1834:			break;
ADDRGP4 $666
JUMPV
LABELV $675
line 1839
;1835:		}
;1836:#endif
;1837:		//CTF & 1FCTF & Harvester
;1838:		case MSG_RUSHBASE:				//ctf rush to the base
;1839:		{
line 1840
;1840:			BotMatch_RushBase(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_RushBase
CALLV
pop
line 1841
;1841:			break;
ADDRGP4 $666
JUMPV
LABELV $676
line 1845
;1842:		}
;1843:		//CTF & 1FCTF
;1844:		case MSG_RETURNFLAG:
;1845:		{
line 1846
;1846:			BotMatch_ReturnFlag(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_ReturnFlag
CALLV
pop
line 1847
;1847:			break;
ADDRGP4 $666
JUMPV
LABELV $677
line 1851
;1848:		}
;1849:		//CTF & 1FCTF & Obelisk & Harvester
;1850:		case MSG_TASKPREFERENCE:
;1851:		{
line 1852
;1852:			BotMatch_TaskPreference(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_TaskPreference
CALLV
pop
line 1853
;1853:			break;
ADDRGP4 $666
JUMPV
LABELV $678
line 1857
;1854:		}
;1855:		//CTF & 1FCTF
;1856:		case MSG_CTF:
;1857:		{
line 1858
;1858:			BotMatch_CTF(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_CTF
CALLV
pop
line 1859
;1859:			break;
ADDRGP4 $666
JUMPV
LABELV $679
line 1862
;1860:		}
;1861:		case MSG_GETITEM:
;1862:		{
line 1863
;1863:			BotMatch_GetItem(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_GetItem
CALLV
pop
line 1864
;1864:			break;
ADDRGP4 $666
JUMPV
LABELV $680
line 1867
;1865:		}
;1866:		case MSG_JOINSUBTEAM:			//join a sub team
;1867:		{
line 1868
;1868:			BotMatch_JoinSubteam(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_JoinSubteam
CALLV
pop
line 1869
;1869:			break;
ADDRGP4 $666
JUMPV
LABELV $681
line 1872
;1870:		}
;1871:		case MSG_LEAVESUBTEAM:			//leave a sub team
;1872:		{
line 1873
;1873:			BotMatch_LeaveSubteam(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_LeaveSubteam
CALLV
pop
line 1874
;1874:			break;
ADDRGP4 $666
JUMPV
LABELV $682
line 1877
;1875:		}
;1876:		case MSG_WHICHTEAM:
;1877:		{
line 1878
;1878:			BotMatch_WhichTeam(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_WhichTeam
CALLV
pop
line 1879
;1879:			break;
ADDRGP4 $666
JUMPV
LABELV $683
line 1882
;1880:		}
;1881:		case MSG_CHECKPOINT:			//remember a check point
;1882:		{
line 1883
;1883:			BotMatch_CheckPoint(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_CheckPoint
CALLV
pop
line 1884
;1884:			break;
ADDRGP4 $666
JUMPV
LABELV $684
line 1887
;1885:		}
;1886:		case MSG_CREATENEWFORMATION:	//start the creation of a new formation
;1887:		{
line 1888
;1888:			trap_EA_SayTeam(bs->client, "the part of my brain to create formations has been damaged");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $685
ARGP4
ADDRGP4 trap_EA_SayTeam
CALLV
pop
line 1889
;1889:			break;
ADDRGP4 $666
JUMPV
LABELV $686
line 1892
;1890:		}
;1891:		case MSG_FORMATIONPOSITION:		//tell someone his/her position in the formation
;1892:		{
line 1893
;1893:			trap_EA_SayTeam(bs->client, "the part of my brain to create formations has been damaged");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $685
ARGP4
ADDRGP4 trap_EA_SayTeam
CALLV
pop
line 1894
;1894:			break;
ADDRGP4 $666
JUMPV
LABELV $687
line 1897
;1895:		}
;1896:		case MSG_FORMATIONSPACE:		//set the formation space
;1897:		{
line 1898
;1898:			BotMatch_FormationSpace(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_FormationSpace
CALLV
pop
line 1899
;1899:			break;
ADDRGP4 $666
JUMPV
line 1902
;1900:		}
;1901:		case MSG_DOFORMATION:			//form a certain formation
;1902:		{
line 1903
;1903:			break;
LABELV $689
line 1906
;1904:		}
;1905:		case MSG_DISMISS:				//dismiss someone
;1906:		{
line 1907
;1907:			BotMatch_Dismiss(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_Dismiss
CALLV
pop
line 1908
;1908:			break;
ADDRGP4 $666
JUMPV
LABELV $690
line 1911
;1909:		}
;1910:		case MSG_STARTTEAMLEADERSHIP:	//someone will become the team leader
;1911:		{
line 1912
;1912:			BotMatch_StartTeamLeaderShip(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_StartTeamLeaderShip
CALLV
pop
line 1913
;1913:			break;
ADDRGP4 $666
JUMPV
LABELV $691
line 1916
;1914:		}
;1915:		case MSG_STOPTEAMLEADERSHIP:	//someone will stop being the team leader
;1916:		{
line 1917
;1917:			BotMatch_StopTeamLeaderShip(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_StopTeamLeaderShip
CALLV
pop
line 1918
;1918:			break;
ADDRGP4 $666
JUMPV
LABELV $692
line 1921
;1919:		}
;1920:		case MSG_WHOISTEAMLAEDER:
;1921:		{
line 1922
;1922:			BotMatch_WhoIsTeamLeader(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_WhoIsTeamLeader
CALLV
pop
line 1923
;1923:			break;
ADDRGP4 $666
JUMPV
LABELV $693
line 1926
;1924:		}
;1925:		case MSG_WHATAREYOUDOING:		//ask a bot what he/she is doing
;1926:		{
line 1927
;1927:			BotMatch_WhatAreYouDoing(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_WhatAreYouDoing
CALLV
pop
line 1928
;1928:			break;
ADDRGP4 $666
JUMPV
LABELV $694
line 1931
;1929:		}
;1930:		case MSG_WHATISMYCOMMAND:
;1931:		{
line 1932
;1932:			BotMatch_WhatIsMyCommand(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_WhatIsMyCommand
CALLV
pop
line 1933
;1933:			break;
ADDRGP4 $666
JUMPV
LABELV $695
line 1936
;1934:		}
;1935:		case MSG_WHEREAREYOU:
;1936:		{
line 1937
;1937:			BotMatch_WhereAreYou(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_WhereAreYou
CALLV
pop
line 1938
;1938:			break;
ADDRGP4 $666
JUMPV
LABELV $696
line 1941
;1939:		}
;1940:		case MSG_LEADTHEWAY:
;1941:		{
line 1942
;1942:			BotMatch_LeadTheWay(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_LeadTheWay
CALLV
pop
line 1943
;1943:			break;
ADDRGP4 $666
JUMPV
LABELV $697
line 1946
;1944:		}
;1945:		case MSG_KILL:
;1946:		{
line 1947
;1947:			BotMatch_Kill(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_Kill
CALLV
pop
line 1948
;1948:			break;
ADDRGP4 $666
JUMPV
LABELV $698
line 1951
;1949:		}
;1950:		case MSG_ENTERGAME:				//someone entered the game
;1951:		{
line 1952
;1952:			BotMatch_EnterGame(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_EnterGame
CALLV
pop
line 1953
;1953:			break;
ADDRGP4 $666
JUMPV
LABELV $699
line 1956
;1954:		}
;1955:		case MSG_NEWLEADER:
;1956:		{
line 1957
;1957:			BotMatch_NewLeader(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_NewLeader
CALLV
pop
line 1958
;1958:			break;
ADDRGP4 $666
JUMPV
line 1961
;1959:		}
;1960:		case MSG_WAIT:
;1961:		{
line 1962
;1962:			break;
LABELV $701
line 1965
;1963:		}
;1964:		case MSG_SUICIDE:
;1965:		{
line 1966
;1966:			BotMatch_Suicide(bs, &match);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotMatch_Suicide
CALLV
pop
line 1967
;1967:			break;
ADDRGP4 $666
JUMPV
LABELV $665
line 1970
;1968:		}
;1969:		default:
;1970:		{
line 1971
;1971:			BotAI_Print(PRT_MESSAGE, "unknown match type\n");
CNSTI4 1
ARGI4
ADDRGP4 $702
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1972
;1972:			break;
LABELV $666
line 1975
;1973:		}
;1974:	}
;1975:	return qtrue;
CNSTI4 1
RETI4
LABELV $661
endproc BotMatchMessage 336 12
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
bss
export notleader
align 4
LABELV notleader
skip 256
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
import mapname
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
LABELV $702
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $685
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 109
byte 1 121
byte 1 32
byte 1 98
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 99
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $594
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $593
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $590
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $589
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $569
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
LABELV $568
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
LABELV $567
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
LABELV $566
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
LABELV $565
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 32
byte 1 82
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $564
byte 1 68
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $563
byte 1 71
byte 1 117
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $562
byte 1 83
byte 1 99
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $561
byte 1 67
byte 1 104
byte 1 97
byte 1 105
byte 1 110
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $560
byte 1 80
byte 1 114
byte 1 111
byte 1 120
byte 1 32
byte 1 76
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $559
byte 1 78
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $558
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
LABELV $557
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
LABELV $556
byte 1 72
byte 1 101
byte 1 97
byte 1 118
byte 1 121
byte 1 32
byte 1 65
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $555
byte 1 65
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $554
byte 1 70
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $553
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
LABELV $552
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $551
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
LABELV $550
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
LABELV $549
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
LABELV $548
byte 1 66
byte 1 70
byte 1 71
byte 1 49
byte 1 48
byte 1 75
byte 1 0
align 1
LABELV $547
byte 1 76
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $546
byte 1 82
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $545
byte 1 80
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $544
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 32
byte 1 76
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $543
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 76
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $542
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $518
byte 1 114
byte 1 111
byte 1 97
byte 1 109
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $517
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
LABELV $515
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $513
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $511
byte 1 114
byte 1 117
byte 1 115
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $509
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $507
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
LABELV $505
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $503
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $501
byte 1 103
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 0
align 1
LABELV $499
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $497
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
byte 1 0
align 1
LABELV $495
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $487
byte 1 73
byte 1 39
byte 1 109
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $465
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $464
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $458
byte 1 100
byte 1 105
byte 1 115
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $442
byte 1 99
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 95
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 114
byte 1 109
byte 1 0
align 1
LABELV $441
byte 1 37
byte 1 49
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 48
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 48
byte 1 102
byte 1 0
align 1
LABELV $430
byte 1 99
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 0
align 1
LABELV $422
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
LABELV $416
byte 1 110
byte 1 111
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $415
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $407
byte 1 0
align 1
LABELV $406
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $398
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $387
byte 1 121
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $386
byte 1 107
byte 1 101
byte 1 101
byte 1 112
byte 1 105
byte 1 110
byte 1 109
byte 1 105
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $253
byte 1 119
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 97
byte 1 114
byte 1 101
byte 1 121
byte 1 111
byte 1 117
byte 1 0
align 1
LABELV $252
byte 1 119
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 105
byte 1 115
byte 1 0
align 1
LABELV $233
byte 1 119
byte 1 104
byte 1 111
byte 1 105
byte 1 115
byte 1 0
align 1
LABELV $216
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $167
byte 1 73
byte 1 32
byte 1 110
byte 1 101
byte 1 101
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $142
byte 1 119
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 100
byte 1 111
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 115
byte 1 97
byte 1 121
byte 1 63
byte 1 0
