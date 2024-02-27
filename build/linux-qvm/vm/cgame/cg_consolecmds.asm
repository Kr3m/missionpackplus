code
proc CG_TargetCommand_f 20 12
file "../../../../code/cgame/cg_consolecmds.c"
line 18
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_consolecmds.c -- text commands typed in at the local console, or
;4:// executed by a key binding
;5:
;6:#include "cg_local.h"
;7:#ifdef MISSIONPACK
;8:#include "../ui/ui_shared.h"
;9:extern menuDef_t *menuScoreboard;
;10:#endif
;11:
;12:
;13:/*
;14:=================
;15:CG_TargetCommand_f
;16:=================
;17:*/
;18:static void CG_TargetCommand_f( void ) {
line 22
;19:	int		targetNum;
;20:	char	cmd[4];
;21:
;22:	targetNum = CG_CrosshairPlayer();
ADDRLP4 8
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 23
;23:	if ( targetNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $82
line 24
;24:		return;
ADDRGP4 $81
JUMPV
LABELV $82
line 27
;25:	}
;26:
;27:	trap_Argv( 1, cmd, sizeof( cmd ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 28
;28:	trap_SendConsoleCommand( va( "gc %i %i", targetNum, atoi( cmd ) ) );
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 $84
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 29
;29:}
LABELV $81
endproc CG_TargetCommand_f 20 12
proc CG_SizeUp_f 4 8
line 40
;30:
;31:
;32:
;33:/*
;34:=================
;35:CG_SizeUp_f
;36:
;37:Keybinding command
;38:=================
;39:*/
;40:static void CG_SizeUp_f (void) {
line 41
;41:	trap_Cvar_Set("cg_viewsize", va("%i",(int)(cg_viewsize.integer+10)));
ADDRGP4 $87
ARGP4
ADDRGP4 cg_viewsize+12
INDIRI4
CNSTI4 10
ADDI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $86
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 42
;42:}
LABELV $85
endproc CG_SizeUp_f 4 8
proc CG_SizeDown_f 4 8
line 52
;43:
;44:
;45:/*
;46:=================
;47:CG_SizeDown_f
;48:
;49:Keybinding command
;50:=================
;51:*/
;52:static void CG_SizeDown_f (void) {
line 53
;53:	trap_Cvar_Set("cg_viewsize", va("%i",(int)(cg_viewsize.integer-10)));
ADDRGP4 $87
ARGP4
ADDRGP4 cg_viewsize+12
INDIRI4
CNSTI4 10
SUBI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $86
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 54
;54:}
LABELV $89
endproc CG_SizeDown_f 4 8
proc CG_Viewpos_f 0 20
line 64
;55:
;56:
;57:/*
;58:=============
;59:CG_Viewpos_f
;60:
;61:Debugging command to print the current position
;62:=============
;63:*/
;64:static void CG_Viewpos_f (void) {
line 65
;65:	CG_Printf ("(%i %i %i) : %i\n", (int)cg.refdef.vieworg[0],
ADDRGP4 $92
ARGP4
ADDRGP4 cg+109056+24
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cg+109056+24+4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cg+109056+24+8
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cg+109424+4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 68
;66:		(int)cg.refdef.vieworg[1], (int)cg.refdef.vieworg[2], 
;67:		(int)cg.refdefViewAngles[YAW]);
;68:}
LABELV $91
endproc CG_Viewpos_f 0 20
proc CG_ScoresDown_f 0 4
line 71
;69:
;70:
;71:static void CG_ScoresDown_f( void ) {
line 74
;72:
;73:#ifdef MISSIONPACK
;74:	CG_BuildSpectatorString();
ADDRGP4 CG_BuildSpectatorString
CALLV
pop
line 76
;75:#endif
;76:	if ( cg.scoresRequestTime + 2000 < cg.time && !cg.demoPlayback ) {
ADDRGP4 cg+110472
INDIRI4
CNSTI4 2000
ADDI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $104
ADDRGP4 cg+8
INDIRI4
CNSTI4 0
NEI4 $104
line 79
;77:		// the scores are more than two seconds out of data,
;78:		// so request new ones
;79:		cg.scoresRequestTime = cg.time;
ADDRGP4 cg+110472
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 80
;80:		trap_SendClientCommand( "score" );
ADDRGP4 $111
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 84
;81:
;82:		// leave the current scores up if they were already
;83:		// displayed, but if this is the first hit, clear them out
;84:		if ( !cg.showScores ) {
ADDRGP4 cg+115356
INDIRI4
CNSTI4 0
NEI4 $105
line 85
;85:			cg.showScores = qtrue;
ADDRGP4 cg+115356
CNSTI4 1
ASGNI4
line 86
;86:			cg.numScores = 0;
ADDRGP4 cg+110476
CNSTI4 0
ASGNI4
line 87
;87:		}
line 88
;88:	} else {
ADDRGP4 $105
JUMPV
LABELV $104
line 91
;89:		// show the cached contents even if they just pressed if it
;90:		// is within two seconds
;91:		cg.showScores = qtrue;
ADDRGP4 cg+115356
CNSTI4 1
ASGNI4
line 92
;92:	}
LABELV $105
line 97
;93:
;94:#ifndef MISSIONPACK
;95:	CG_SetScoreCatcher( cg.showScores );
;96:#endif
;97:}
LABELV $103
endproc CG_ScoresDown_f 0 4
proc CG_ScoresUp_f 0 0
line 100
;98:
;99:
;100:static void CG_ScoresUp_f( void ) {
line 102
;101:
;102:	if ( cgs.filterKeyUpEvent ) {
ADDRGP4 cgs+150092
INDIRI4
CNSTI4 0
EQI4 $119
line 103
;103:		cgs.filterKeyUpEvent = qfalse;
ADDRGP4 cgs+150092
CNSTI4 0
ASGNI4
line 104
;104:		return;
ADDRGP4 $118
JUMPV
LABELV $119
line 107
;105:	}
;106:
;107:	if ( cg.showScores ) {
ADDRGP4 cg+115356
INDIRI4
CNSTI4 0
EQI4 $123
line 108
;108:		cg.showScores = qfalse;
ADDRGP4 cg+115356
CNSTI4 0
ASGNI4
line 109
;109:		cg.scoreFadeTime = cg.time;
ADDRGP4 cg+115364
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 110
;110:	}
LABELV $123
line 115
;111:
;112:#ifndef MISSIONPACK
;113:	CG_SetScoreCatcher( cg.showScores );
;114:#endif
;115:}
LABELV $118
endproc CG_ScoresUp_f 0 0
proc CG_LoadHud_f 1028 12
line 122
;116:
;117:
;118:#ifdef MISSIONPACK
;119:extern menuDef_t *menuScoreboard;
;120:void Menu_Reset( void );			// FIXME: add to right include file
;121:
;122:static void CG_LoadHud_f( void) {
line 125
;123:  char buff[1024];
;124:	const char *hudSet;
;125:  memset(buff, 0, sizeof(buff));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTU4 1024
ARGU4
ADDRGP4 memset
CALLP4
pop
line 127
;126:
;127:	String_Init();
ADDRGP4 String_Init
CALLV
pop
line 128
;128:	Menu_Reset();
ADDRGP4 Menu_Reset
CALLV
pop
line 130
;129:	
;130:	trap_Cvar_VariableStringBuffer("cg_hudFiles", buff, sizeof(buff));
ADDRGP4 $130
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 131
;131:	hudSet = buff;
ADDRLP4 1024
ADDRLP4 0
ASGNP4
line 132
;132:	if (hudSet[0] == '\0') {
ADDRLP4 1024
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $131
line 133
;133:		hudSet = "ui/hud.txt";
ADDRLP4 1024
ADDRGP4 $133
ASGNP4
line 134
;134:	}
LABELV $131
line 136
;135:
;136:	CG_LoadMenus(hudSet);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 CG_LoadMenus
CALLV
pop
line 137
;137:  menuScoreboard = NULL;
ADDRGP4 menuScoreboard
CNSTP4 0
ASGNP4
line 138
;138:}
LABELV $129
endproc CG_LoadHud_f 1028 12
proc CG_scrollScoresDown_f 0 12
line 141
;139:
;140:
;141:static void CG_scrollScoresDown_f( void) {
line 142
;142:	if (menuScoreboard && cg.scoreBoardShowing) {
ADDRGP4 menuScoreboard
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $135
ADDRGP4 cg+115360
INDIRI4
CNSTI4 0
EQI4 $135
line 143
;143:		Menu_ScrollFeeder(menuScoreboard, FEEDER_SCOREBOARD, qtrue);
ADDRGP4 menuScoreboard
INDIRP4
ARGP4
CNSTI4 11
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ScrollFeeder
CALLV
pop
line 144
;144:		Menu_ScrollFeeder(menuScoreboard, FEEDER_REDTEAM_LIST, qtrue);
ADDRGP4 menuScoreboard
INDIRP4
ARGP4
CNSTI4 5
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ScrollFeeder
CALLV
pop
line 145
;145:		Menu_ScrollFeeder(menuScoreboard, FEEDER_BLUETEAM_LIST, qtrue);
ADDRGP4 menuScoreboard
INDIRP4
ARGP4
CNSTI4 6
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ScrollFeeder
CALLV
pop
line 146
;146:	}
LABELV $135
line 147
;147:}
LABELV $134
endproc CG_scrollScoresDown_f 0 12
proc CG_scrollScoresUp_f 0 12
line 150
;148:
;149:
;150:static void CG_scrollScoresUp_f( void) {
line 151
;151:	if (menuScoreboard && cg.scoreBoardShowing) {
ADDRGP4 menuScoreboard
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $139
ADDRGP4 cg+115360
INDIRI4
CNSTI4 0
EQI4 $139
line 152
;152:		Menu_ScrollFeeder(menuScoreboard, FEEDER_SCOREBOARD, qfalse);
ADDRGP4 menuScoreboard
INDIRP4
ARGP4
CNSTI4 11
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ScrollFeeder
CALLV
pop
line 153
;153:		Menu_ScrollFeeder(menuScoreboard, FEEDER_REDTEAM_LIST, qfalse);
ADDRGP4 menuScoreboard
INDIRP4
ARGP4
CNSTI4 5
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ScrollFeeder
CALLV
pop
line 154
;154:		Menu_ScrollFeeder(menuScoreboard, FEEDER_BLUETEAM_LIST, qfalse);
ADDRGP4 menuScoreboard
INDIRP4
ARGP4
CNSTI4 6
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ScrollFeeder
CALLV
pop
line 155
;155:	}
LABELV $139
line 156
;156:}
LABELV $138
endproc CG_scrollScoresUp_f 0 12
proc CG_spWin_f 0 12
line 159
;157:
;158:
;159:static void CG_spWin_f( void) {
line 160
;160:	trap_Cvar_Set("cg_cameraOrbit", "2");
ADDRGP4 $143
ARGP4
ADDRGP4 $144
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 161
;161:	trap_Cvar_Set("cg_cameraOrbitDelay", "35");
ADDRGP4 $145
ARGP4
ADDRGP4 $146
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 162
;162:	trap_Cvar_Set("cg_thirdPerson", "1");
ADDRGP4 $147
ARGP4
ADDRGP4 $148
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 163
;163:	trap_Cvar_Set("cg_thirdPersonAngle", "0");
ADDRGP4 $149
ARGP4
ADDRGP4 $150
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 164
;164:	trap_Cvar_Set("cg_thirdPersonRange", "100");
ADDRGP4 $151
ARGP4
ADDRGP4 $152
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 165
;165:	CG_AddBufferedSound(cgs.media.winnerSound);
ADDRGP4 cgs+148772+864
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 167
;166:	//trap_S_StartLocalSound(cgs.media.winnerSound, CHAN_ANNOUNCER);
;167:	CG_CenterPrint("YOU WIN!", SCREEN_HEIGHT * .30, 0);
ADDRGP4 $155
ARGP4
CNSTI4 144
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 168
;168:}
LABELV $142
endproc CG_spWin_f 0 12
proc CG_spLose_f 0 12
line 170
;169:
;170:static void CG_spLose_f( void) {
line 171
;171:	trap_Cvar_Set("cg_cameraOrbit", "2");
ADDRGP4 $143
ARGP4
ADDRGP4 $144
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 172
;172:	trap_Cvar_Set("cg_cameraOrbitDelay", "35");
ADDRGP4 $145
ARGP4
ADDRGP4 $146
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 173
;173:	trap_Cvar_Set("cg_thirdPerson", "1");
ADDRGP4 $147
ARGP4
ADDRGP4 $148
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 174
;174:	trap_Cvar_Set("cg_thirdPersonAngle", "0");
ADDRGP4 $149
ARGP4
ADDRGP4 $150
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 175
;175:	trap_Cvar_Set("cg_thirdPersonRange", "100");
ADDRGP4 $151
ARGP4
ADDRGP4 $152
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 176
;176:	CG_AddBufferedSound(cgs.media.loserSound);
ADDRGP4 cgs+148772+868
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 178
;177:	//trap_S_StartLocalSound(cgs.media.loserSound, CHAN_ANNOUNCER);
;178:	CG_CenterPrint("YOU LOSE...", SCREEN_HEIGHT * .30, 0);
ADDRGP4 $159
ARGP4
CNSTI4 144
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 179
;179:}
LABELV $156
endproc CG_spLose_f 0 12
proc CG_TellTarget_f 264 20
line 188
;180:
;181:#endif
;182:
;183:/*
;184:==================
;185:CG_TellTarget_f
;186:==================
;187:*/
;188:static void CG_TellTarget_f( void ) {
line 193
;189:	int		clientNum;
;190:	char	command[128];
;191:	char	message[128];
;192:
;193:	clientNum = CG_CrosshairPlayer();
ADDRLP4 260
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 194
;194:	if ( clientNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $161
line 195
;195:		return;
ADDRGP4 $160
JUMPV
LABELV $161
line 198
;196:	}
;197:
;198:	trap_Args( message, sizeof( message ) );
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 199
;199:	Com_sprintf( command, sizeof( command ), "tell %i %s", clientNum, message );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $163
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 200
;200:	trap_SendClientCommand( command );
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 201
;201:}
LABELV $160
endproc CG_TellTarget_f 264 20
proc CG_TellAttacker_f 264 20
line 209
;202:
;203:
;204:/*
;205:==================
;206:CG_TellAttacker_f
;207:==================
;208:*/
;209:static void CG_TellAttacker_f( void ) {
line 214
;210:	int		clientNum;
;211:	char	command[128];
;212:	char	message[128];
;213:
;214:	clientNum = CG_LastAttacker();
ADDRLP4 260
ADDRGP4 CG_LastAttacker
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 215
;215:	if ( clientNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $165
line 216
;216:		return;
ADDRGP4 $164
JUMPV
LABELV $165
line 219
;217:	}
;218:
;219:	trap_Args( message, sizeof( message ) );
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 220
;220:	Com_sprintf( command, sizeof( command ), "tell %i %s", clientNum, message );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $163
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 221
;221:	trap_SendClientCommand( command );
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 222
;222:}
LABELV $164
endproc CG_TellAttacker_f 264 20
proc CG_VoiceTellTarget_f 264 20
line 231
;223:
;224:
;225:#ifdef MISSIONPACK
;226:/*
;227:==================
;228:CG_VoiceTellTarget_f
;229:==================
;230:*/
;231:static void CG_VoiceTellTarget_f( void ) {
line 236
;232:	int		clientNum;
;233:	char	command[128];
;234:	char	message[128];
;235:
;236:	clientNum = CG_CrosshairPlayer();
ADDRLP4 260
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 237
;237:	if ( clientNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $168
line 238
;238:		return;
ADDRGP4 $167
JUMPV
LABELV $168
line 241
;239:	}
;240:
;241:	trap_Args( message, sizeof( message ) );
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 242
;242:	Com_sprintf( command, sizeof( command ), "vtell %i %s", clientNum, message );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $170
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 243
;243:	trap_SendClientCommand( command );
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 244
;244:}
LABELV $167
endproc CG_VoiceTellTarget_f 264 20
proc CG_VoiceTellAttacker_f 264 20
line 252
;245:
;246:
;247:/*
;248:==================
;249:CG_VoiceTellAttacker_f
;250:==================
;251:*/
;252:static void CG_VoiceTellAttacker_f( void ) {
line 257
;253:	int		clientNum;
;254:	char	command[128];
;255:	char	message[128];
;256:
;257:	clientNum = CG_LastAttacker();
ADDRLP4 260
ADDRGP4 CG_LastAttacker
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 258
;258:	if ( clientNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $172
line 259
;259:		return;
ADDRGP4 $171
JUMPV
LABELV $172
line 262
;260:	}
;261:
;262:	trap_Args( message, sizeof( message ) );
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 263
;263:	Com_sprintf( command, sizeof( command ), "vtell %i %s", clientNum, message );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $170
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 264
;264:	trap_SendClientCommand( command );
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 265
;265:}
LABELV $171
endproc CG_VoiceTellAttacker_f 264 20
proc CG_NextTeamMember_f 0 0
line 267
;266:
;267:static void CG_NextTeamMember_f( void ) {
line 268
;268:  CG_SelectNextPlayer();
ADDRGP4 CG_SelectNextPlayer
CALLV
pop
line 269
;269:}
LABELV $174
endproc CG_NextTeamMember_f 0 0
proc CG_PrevTeamMember_f 0 0
line 271
;270:
;271:static void CG_PrevTeamMember_f( void ) {
line 272
;272:  CG_SelectPrevPlayer();
ADDRGP4 CG_SelectPrevPlayer
CALLV
pop
line 273
;273:}
LABELV $175
endproc CG_PrevTeamMember_f 0 0
proc CG_NextOrder_f 16 0
line 277
;274:
;275:// ASS U ME's enumeration order as far as task specific orders, OFFENSE is zero, CAMP is last
;276://
;277:static void CG_NextOrder_f( void ) {
line 278
;278:	clientInfo_t *ci = cgs.clientinfo + cg.snap->ps.clientNum;
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 279
;279:	if (ci) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $179
line 280
;280:		if (!ci->teamLeader && sortedTeamPlayers[cg_currentSelectedPlayer.integer] != cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 0
NEI4 $181
ADDRGP4 cg_currentSelectedPlayer+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $181
line 281
;281:			return;
ADDRGP4 $176
JUMPV
LABELV $181
line 283
;282:		}
;283:	}
LABELV $179
line 284
;284:	if (cgs.currentOrder < TEAMTASK_CAMP) {
ADDRGP4 cgs+148712
INDIRI4
CNSTI4 7
GEI4 $185
line 285
;285:		cgs.currentOrder++;
ADDRLP4 4
ADDRGP4 cgs+148712
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 287
;286:
;287:		if (cgs.currentOrder == TEAMTASK_RETRIEVE) {
ADDRGP4 cgs+148712
INDIRI4
CNSTI4 5
NEI4 $189
line 288
;288:			if (!CG_OtherTeamHasFlag()) {
ADDRLP4 8
ADDRGP4 CG_OtherTeamHasFlag
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $192
line 289
;289:				cgs.currentOrder++;
ADDRLP4 12
ADDRGP4 cgs+148712
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 290
;290:			}
LABELV $192
line 291
;291:		}
LABELV $189
line 293
;292:
;293:		if (cgs.currentOrder == TEAMTASK_ESCORT) {
ADDRGP4 cgs+148712
INDIRI4
CNSTI4 6
NEI4 $186
line 294
;294:			if (!CG_YourTeamHasFlag()) {
ADDRLP4 8
ADDRGP4 CG_YourTeamHasFlag
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $186
line 295
;295:				cgs.currentOrder++;
ADDRLP4 12
ADDRGP4 cgs+148712
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 296
;296:			}
line 297
;297:		}
line 299
;298:
;299:	} else {
ADDRGP4 $186
JUMPV
LABELV $185
line 300
;300:		cgs.currentOrder = TEAMTASK_OFFENSE;
ADDRGP4 cgs+148712
CNSTI4 1
ASGNI4
line 301
;301:	}
LABELV $186
line 302
;302:	cgs.orderPending = qtrue;
ADDRGP4 cgs+148716
CNSTI4 1
ASGNI4
line 303
;303:	cgs.orderTime = cg.time + 3000;
ADDRGP4 cgs+148720
ADDRGP4 cg+107604
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 304
;304:}
LABELV $176
endproc CG_NextOrder_f 16 0
proc CG_ConfirmOrder_f 8 12
line 307
;305:
;306:
;307:static void CG_ConfirmOrder_f (void ) {
line 308
;308:	trap_SendConsoleCommand(va("cmd vtell %d %s\n", cgs.acceptLeader, VOICECHAT_YES));
ADDRGP4 $206
ARGP4
ADDRGP4 cgs+148736
INDIRI4
ARGI4
ADDRGP4 $208
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 309
;309:	trap_SendConsoleCommand("+button5; wait; -button5");
ADDRGP4 $209
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 310
;310:	if (cg.time < cgs.acceptOrderTime) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+148728
INDIRI4
GEI4 $210
line 311
;311:		trap_SendClientCommand(va("teamtask %d\n", cgs.acceptTask));
ADDRGP4 $214
ARGP4
ADDRGP4 cgs+148732
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 312
;312:		cgs.acceptOrderTime = 0;
ADDRGP4 cgs+148728
CNSTI4 0
ASGNI4
line 313
;313:	}
LABELV $210
line 314
;314:}
LABELV $205
endproc CG_ConfirmOrder_f 8 12
proc CG_DenyOrder_f 4 12
line 316
;315:
;316:static void CG_DenyOrder_f (void ) {
line 317
;317:	trap_SendConsoleCommand(va("cmd vtell %d %s\n", cgs.acceptLeader, VOICECHAT_NO));
ADDRGP4 $206
ARGP4
ADDRGP4 cgs+148736
INDIRI4
ARGI4
ADDRGP4 $219
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 318
;318:	trap_SendConsoleCommand("+button6; wait; -button6");
ADDRGP4 $220
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 319
;319:	if (cg.time < cgs.acceptOrderTime) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+148728
INDIRI4
GEI4 $221
line 320
;320:		cgs.acceptOrderTime = 0;
ADDRGP4 cgs+148728
CNSTI4 0
ASGNI4
line 321
;321:	}
LABELV $221
line 322
;322:}
LABELV $217
endproc CG_DenyOrder_f 4 12
proc CG_TaskOffense_f 4 8
line 324
;323:
;324:static void CG_TaskOffense_f (void ) {
line 325
;325:	if (cgs.gametype == GT_CTF || cgs.gametype == GT_1FCTF) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 4
EQI4 $231
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 5
NEI4 $227
LABELV $231
line 326
;326:		trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONGETFLAG));
ADDRGP4 $232
ARGP4
ADDRGP4 $233
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 327
;327:	} else {
ADDRGP4 $228
JUMPV
LABELV $227
line 328
;328:		trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONOFFENSE));
ADDRGP4 $232
ARGP4
ADDRGP4 $234
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 329
;329:	}
LABELV $228
line 330
;330:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_OFFENSE));
ADDRGP4 $214
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 331
;331:}
LABELV $226
endproc CG_TaskOffense_f 4 8
proc CG_TaskDefense_f 8 8
line 333
;332:
;333:static void CG_TaskDefense_f (void ) {
line 334
;334:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONDEFENSE));
ADDRGP4 $232
ARGP4
ADDRGP4 $236
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 335
;335:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_DEFENSE));
ADDRGP4 $214
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 336
;336:}
LABELV $235
endproc CG_TaskDefense_f 8 8
proc CG_TaskPatrol_f 8 8
line 338
;337:
;338:static void CG_TaskPatrol_f (void ) {
line 339
;339:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONPATROL));
ADDRGP4 $232
ARGP4
ADDRGP4 $238
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 340
;340:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_PATROL));
ADDRGP4 $214
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 341
;341:}
LABELV $237
endproc CG_TaskPatrol_f 8 8
proc CG_TaskCamp_f 8 8
line 343
;342:
;343:static void CG_TaskCamp_f (void ) {
line 344
;344:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONCAMPING));
ADDRGP4 $232
ARGP4
ADDRGP4 $240
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 345
;345:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_CAMP));
ADDRGP4 $214
ARGP4
CNSTI4 7
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 346
;346:}
LABELV $239
endproc CG_TaskCamp_f 8 8
proc CG_TaskFollow_f 8 8
line 348
;347:
;348:static void CG_TaskFollow_f (void ) {
line 349
;349:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONFOLLOW));
ADDRGP4 $232
ARGP4
ADDRGP4 $242
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 350
;350:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_FOLLOW));
ADDRGP4 $214
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 351
;351:}
LABELV $241
endproc CG_TaskFollow_f 8 8
proc CG_TaskRetrieve_f 8 8
line 353
;352:
;353:static void CG_TaskRetrieve_f (void ) {
line 354
;354:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONRETURNFLAG));
ADDRGP4 $232
ARGP4
ADDRGP4 $244
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 355
;355:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_RETRIEVE));
ADDRGP4 $214
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 356
;356:}
LABELV $243
endproc CG_TaskRetrieve_f 8 8
proc CG_TaskEscort_f 8 8
line 358
;357:
;358:static void CG_TaskEscort_f (void ) {
line 359
;359:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONFOLLOWCARRIER));
ADDRGP4 $232
ARGP4
ADDRGP4 $246
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 360
;360:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_ESCORT));
ADDRGP4 $214
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 361
;361:}
LABELV $245
endproc CG_TaskEscort_f 8 8
proc CG_TaskOwnFlag_f 4 8
line 363
;362:
;363:static void CG_TaskOwnFlag_f (void ) {
line 364
;364:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_IHAVEFLAG));
ADDRGP4 $232
ARGP4
ADDRGP4 $248
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 365
;365:}
LABELV $247
endproc CG_TaskOwnFlag_f 4 8
proc CG_TauntKillInsult_f 0 4
line 367
;366:
;367:static void CG_TauntKillInsult_f (void ) {
line 368
;368:	trap_SendConsoleCommand("cmd vsay kill_insult\n");
ADDRGP4 $250
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 369
;369:}
LABELV $249
endproc CG_TauntKillInsult_f 0 4
proc CG_TauntPraise_f 0 4
line 371
;370:
;371:static void CG_TauntPraise_f (void ) {
line 372
;372:	trap_SendConsoleCommand("cmd vsay praise\n");
ADDRGP4 $252
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 373
;373:}
LABELV $251
endproc CG_TauntPraise_f 0 4
proc CG_TauntTaunt_f 0 4
line 375
;374:
;375:static void CG_TauntTaunt_f (void ) {
line 376
;376:	trap_SendConsoleCommand("cmd vtaunt\n");
ADDRGP4 $254
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 377
;377:}
LABELV $253
endproc CG_TauntTaunt_f 0 4
proc CG_TauntDeathInsult_f 0 4
line 379
;378:
;379:static void CG_TauntDeathInsult_f (void ) {
line 380
;380:	trap_SendConsoleCommand("cmd vsay death_insult\n");
ADDRGP4 $256
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 381
;381:}
LABELV $255
endproc CG_TauntDeathInsult_f 0 4
proc CG_TauntGauntlet_f 0 4
line 383
;382:
;383:static void CG_TauntGauntlet_f (void ) {
line 384
;384:	trap_SendConsoleCommand("cmd vsay kill_gauntlet\n");
ADDRGP4 $258
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 385
;385:}
LABELV $257
endproc CG_TauntGauntlet_f 0 4
proc CG_TaskSuicide_f 136 16
line 387
;386:
;387:static void CG_TaskSuicide_f (void ) {
line 391
;388:	int		clientNum;
;389:	char	command[128];
;390:
;391:	clientNum = CG_CrosshairPlayer();
ADDRLP4 132
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 132
INDIRI4
ASGNI4
line 392
;392:	if ( clientNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $260
line 393
;393:		return;
ADDRGP4 $259
JUMPV
LABELV $260
line 396
;394:	}
;395:
;396:	Com_sprintf( command, 128, "tell %i suicide", clientNum );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $262
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 397
;397:	trap_SendClientCommand( command );
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 398
;398:}
LABELV $259
endproc CG_TaskSuicide_f 136 16
proc CG_StartOrbit_f 1028 12
line 439
;399:
;400:
;401:
;402:/*
;403:==================
;404:CG_TeamMenu_f
;405:==================
;406:*/
;407:/*
;408:static void CG_TeamMenu_f( void ) {
;409:  if (trap_Key_GetCatcher() & KEYCATCH_CGAME) {
;410:    CG_EventHandling(CGAME_EVENT_NONE);
;411:    trap_Key_SetCatcher(0);
;412:  } else {
;413:    CG_EventHandling(CGAME_EVENT_TEAMMENU);
;414:    //trap_Key_SetCatcher(KEYCATCH_CGAME);
;415:  }
;416:}
;417:*/
;418:
;419:/*
;420:==================
;421:CG_EditHud_f
;422:==================
;423:*/
;424:/*
;425:static void CG_EditHud_f( void ) {
;426:  //cls.keyCatchers ^= KEYCATCH_CGAME;
;427:  //VM_Call (cgvm, CG_EVENT_HANDLING, (cls.keyCatchers & KEYCATCH_CGAME) ? CGAME_EVENT_EDITHUD : CGAME_EVENT_NONE);
;428:}
;429:*/
;430:
;431:#endif
;432:
;433:/*
;434:==================
;435:CG_StartOrbit_f
;436:==================
;437:*/
;438:
;439:static void CG_StartOrbit_f( void ) {
line 442
;440:	char var[MAX_TOKEN_CHARS];
;441:
;442:	trap_Cvar_VariableStringBuffer( "developer", var, sizeof( var ) );
ADDRGP4 $264
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 443
;443:	if ( !atoi(var) ) {
ADDRLP4 0
ARGP4
ADDRLP4 1024
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 0
NEI4 $265
line 444
;444:		return;
ADDRGP4 $263
JUMPV
LABELV $265
line 446
;445:	}
;446:	if (cg_cameraOrbit.value != 0) {
ADDRGP4 cg_cameraOrbit+8
INDIRF4
CNSTF4 0
EQF4 $267
line 447
;447:		trap_Cvar_Set ("cg_cameraOrbit", "0");
ADDRGP4 $143
ARGP4
ADDRGP4 $150
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 448
;448:		trap_Cvar_Set("cg_thirdPerson", "0");
ADDRGP4 $147
ARGP4
ADDRGP4 $150
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 449
;449:	} else {
ADDRGP4 $268
JUMPV
LABELV $267
line 450
;450:		trap_Cvar_Set("cg_cameraOrbit", "5");
ADDRGP4 $143
ARGP4
ADDRGP4 $270
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 451
;451:		trap_Cvar_Set("cg_thirdPerson", "1");
ADDRGP4 $147
ARGP4
ADDRGP4 $148
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 452
;452:		trap_Cvar_Set("cg_thirdPersonAngle", "0");
ADDRGP4 $149
ARGP4
ADDRGP4 $150
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 453
;453:		trap_Cvar_Set("cg_thirdPersonRange", "100");
ADDRGP4 $151
ARGP4
ADDRGP4 $152
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 454
;454:	}
LABELV $268
line 455
;455:}
LABELV $263
endproc CG_StartOrbit_f 1028 12
data
align 4
LABELV commands
address $272
address CG_TestGun_f
address $273
address CG_TestModel_f
address $274
address CG_TestModelNextFrame_f
address $275
address CG_TestModelPrevFrame_f
address $276
address CG_TestModelNextSkin_f
address $277
address CG_TestModelPrevSkin_f
address $278
address CG_Viewpos_f
address $279
address CG_ScoresDown_f
address $280
address CG_ScoresUp_f
address $281
address CG_ZoomDown_f
address $282
address CG_ZoomUp_f
address $283
address CG_SizeUp_f
address $284
address CG_SizeDown_f
address $285
address CG_NextWeapon_f
address $286
address CG_PrevWeapon_f
address $287
address CG_Weapon_f
address $288
address CG_LastWeapon_f
address $289
address CG_TargetCommand_f
address $290
address CG_TellTarget_f
address $291
address CG_TellAttacker_f
address $292
address CG_VoiceTellTarget_f
address $293
address CG_VoiceTellAttacker_f
address $294
address CG_LoadHud_f
address $295
address CG_NextTeamMember_f
address $296
address CG_PrevTeamMember_f
address $297
address CG_NextOrder_f
address $298
address CG_ConfirmOrder_f
address $299
address CG_DenyOrder_f
address $300
address CG_TaskOffense_f
address $301
address CG_TaskDefense_f
address $302
address CG_TaskPatrol_f
address $303
address CG_TaskCamp_f
address $304
address CG_TaskFollow_f
address $305
address CG_TaskRetrieve_f
address $306
address CG_TaskEscort_f
address $307
address CG_TaskSuicide_f
address $308
address CG_TaskOwnFlag_f
address $309
address CG_TauntKillInsult_f
address $310
address CG_TauntPraise_f
address $311
address CG_TauntTaunt_f
address $312
address CG_TauntDeathInsult_f
address $313
address CG_TauntGauntlet_f
address $314
address CG_spWin_f
address $315
address CG_spLose_f
address $316
address CG_scrollScoresDown_f
address $317
address CG_scrollScoresUp_f
address $318
address CG_StartOrbit_f
address $319
address CG_LoadDeferredPlayers
export CG_ConsoleCommand
code
proc CG_ConsoleCommand 16 8
line 539
;456:
;457:/*
;458:static void CG_Camera_f( void ) {
;459:	char name[1024];
;460:	trap_Argv( 1, name, sizeof(name));
;461:	if (trap_loadCamera(name)) {
;462:		cg.cameraMode = qtrue;
;463:		trap_startCamera(cg.time);
;464:	} else {
;465:		CG_Printf ("Unable to load camera %s\n",name);
;466:	}
;467:}
;468:*/
;469:
;470:
;471:typedef struct {
;472:	const char *cmd;
;473:	void	(*function)(void);
;474:} consoleCommand_t;
;475:
;476:static consoleCommand_t	commands[] = {
;477:	{ "testgun", CG_TestGun_f },
;478:	{ "testmodel", CG_TestModel_f },
;479:	{ "nextframe", CG_TestModelNextFrame_f },
;480:	{ "prevframe", CG_TestModelPrevFrame_f },
;481:	{ "nextskin", CG_TestModelNextSkin_f },
;482:	{ "prevskin", CG_TestModelPrevSkin_f },
;483:	{ "viewpos", CG_Viewpos_f },
;484:	{ "+scores", CG_ScoresDown_f },
;485:	{ "-scores", CG_ScoresUp_f },
;486:	{ "+zoom", CG_ZoomDown_f },
;487:	{ "-zoom", CG_ZoomUp_f },
;488:	{ "sizeup", CG_SizeUp_f },
;489:	{ "sizedown", CG_SizeDown_f },
;490:	{ "weapnext", CG_NextWeapon_f },
;491:	{ "weapprev", CG_PrevWeapon_f },
;492:	{ "weapon", CG_Weapon_f },
;493:	{ "lastweapon", CG_LastWeapon_f },
;494:	{ "tcmd", CG_TargetCommand_f },
;495:	{ "tell_target", CG_TellTarget_f },
;496:	{ "tell_attacker", CG_TellAttacker_f },
;497:#ifdef MISSIONPACK
;498:	{ "vtell_target", CG_VoiceTellTarget_f },
;499:	{ "vtell_attacker", CG_VoiceTellAttacker_f },
;500:	{ "loadhud", CG_LoadHud_f },
;501:	{ "nextTeamMember", CG_NextTeamMember_f },
;502:	{ "prevTeamMember", CG_PrevTeamMember_f },
;503:	{ "nextOrder", CG_NextOrder_f },
;504:	{ "confirmOrder", CG_ConfirmOrder_f },
;505:	{ "denyOrder", CG_DenyOrder_f },
;506:	{ "taskOffense", CG_TaskOffense_f },
;507:	{ "taskDefense", CG_TaskDefense_f },
;508:	{ "taskPatrol", CG_TaskPatrol_f },
;509:	{ "taskCamp", CG_TaskCamp_f },
;510:	{ "taskFollow", CG_TaskFollow_f },
;511:	{ "taskRetrieve", CG_TaskRetrieve_f },
;512:	{ "taskEscort", CG_TaskEscort_f },
;513:	{ "taskSuicide", CG_TaskSuicide_f },
;514:	{ "taskOwnFlag", CG_TaskOwnFlag_f },
;515:	{ "tauntKillInsult", CG_TauntKillInsult_f },
;516:	{ "tauntPraise", CG_TauntPraise_f },
;517:	{ "tauntTaunt", CG_TauntTaunt_f },
;518:	{ "tauntDeathInsult", CG_TauntDeathInsult_f },
;519:	{ "tauntGauntlet", CG_TauntGauntlet_f },
;520:	{ "spWin", CG_spWin_f },
;521:	{ "spLose", CG_spLose_f },
;522:	{ "scoresDown", CG_scrollScoresDown_f },
;523:	{ "scoresUp", CG_scrollScoresUp_f },
;524:#endif
;525:	{ "startOrbit", CG_StartOrbit_f },
;526:	//{ "camera", CG_Camera_f },
;527:	{ "loaddeferred", CG_LoadDeferredPlayers }	
;528:};
;529:
;530:
;531:/*
;532:=================
;533:CG_ConsoleCommand
;534:
;535:The string has been tokenized and can be retrieved with
;536:Cmd_Argc() / Cmd_Argv()
;537:=================
;538:*/
;539:qboolean CG_ConsoleCommand( void ) {
line 543
;540:	const char	*cmd;
;541:	int		i;
;542:
;543:	cmd = CG_Argv(0);
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 545
;544:
;545:	for ( i = 0 ; i < ARRAY_LEN( commands ) ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $324
JUMPV
LABELV $321
line 546
;546:		if ( !Q_stricmp( cmd, commands[i].cmd ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commands
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $325
line 547
;547:			commands[i].function();
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commands+4
ADDP4
INDIRP4
CALLV
pop
line 548
;548:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $320
JUMPV
LABELV $325
line 550
;549:		}
;550:	}
LABELV $322
line 545
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $324
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 48
LTU4 $321
line 552
;551:
;552:	return qfalse;
CNSTI4 0
RETI4
LABELV $320
endproc CG_ConsoleCommand 16 8
export CG_InitConsoleCommands
proc CG_InitConsoleCommands 4 4
line 564
;553:}
;554:
;555:
;556:/*
;557:=================
;558:CG_InitConsoleCommands
;559:
;560:Let the client system know about all of our commands
;561:so it can perform tab completion
;562:=================
;563:*/
;564:void CG_InitConsoleCommands( void ) {
line 567
;565:	int		i;
;566:
;567:	for ( i = 0 ; i < ARRAY_LEN( commands ) ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $332
JUMPV
LABELV $329
line 568
;568:		trap_AddCommand( commands[i].cmd );
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commands
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 569
;569:	}
LABELV $330
line 567
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $332
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 48
LTU4 $329
line 575
;570:
;571:	//
;572:	// the game server will interpret these commands, which will be automatically
;573:	// forwarded to the server after they are not recognized locally
;574:	//
;575:	trap_AddCommand ("kill");
ADDRGP4 $333
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 576
;576:	trap_AddCommand ("say");
ADDRGP4 $334
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 577
;577:	trap_AddCommand ("say_team");
ADDRGP4 $335
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 578
;578:	trap_AddCommand ("tell");
ADDRGP4 $336
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 580
;579:#ifdef MISSIONPACK
;580:	trap_AddCommand ("vsay");
ADDRGP4 $337
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 581
;581:	trap_AddCommand ("vsay_team");
ADDRGP4 $338
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 582
;582:	trap_AddCommand ("vtell");
ADDRGP4 $339
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 583
;583:	trap_AddCommand ("vtaunt");
ADDRGP4 $340
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 584
;584:	trap_AddCommand ("vosay");
ADDRGP4 $341
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 585
;585:	trap_AddCommand ("vosay_team");
ADDRGP4 $342
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 586
;586:	trap_AddCommand ("votell");
ADDRGP4 $343
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 588
;587:#endif
;588:	trap_AddCommand ("give");
ADDRGP4 $344
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 589
;589:	trap_AddCommand ("loaded");
ADDRGP4 $345
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 590
;590:	trap_AddCommand ("god");
ADDRGP4 $346
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 591
;591:	trap_AddCommand ("notarget");
ADDRGP4 $347
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 592
;592:	trap_AddCommand ("noclip");
ADDRGP4 $348
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 593
;593:	trap_AddCommand ("team");
ADDRGP4 $349
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 594
;594:	trap_AddCommand ("follow");
ADDRGP4 $350
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 595
;595:	trap_AddCommand ("levelshot");
ADDRGP4 $351
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 596
;596:	trap_AddCommand ("addbot");
ADDRGP4 $352
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 597
;597:	trap_AddCommand ("setviewpos");
ADDRGP4 $353
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 598
;598:	trap_AddCommand ("callvote");
ADDRGP4 $354
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 599
;599:	trap_AddCommand ("vote");
ADDRGP4 $355
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 600
;600:	trap_AddCommand ("callteamvote");
ADDRGP4 $356
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 601
;601:	trap_AddCommand ("teamvote");
ADDRGP4 $357
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 602
;602:	trap_AddCommand ("stats");
ADDRGP4 $358
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 603
;603:	trap_AddCommand ("teamtask");
ADDRGP4 $359
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 604
;604:	trap_AddCommand ("loaddefered");	// spelled wrong, but not changing for demo
ADDRGP4 $360
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 605
;605:}
LABELV $328
endproc CG_InitConsoleCommands 4 4
import menuScoreboard
import trap_PC_SourceFileAndLine
import trap_PC_ReadToken
import trap_PC_FreeSource
import trap_PC_LoadSource
import trap_PC_AddGlobalDefine
import Controls_SetDefaults
import Controls_SetConfig
import Controls_GetConfig
import UI_OutOfMemory
import UI_InitMemory
import UI_Alloc
import Display_CacheAll
import Menu_SetFeederSelection
import Menu_Paint
import Menus_CloseAll
import LerpColor
import Display_HandleKey
import Menus_CloseByName
import Menus_ShowByName
import Menus_FindByName
import Menus_OpenByName
import Display_KeyBindPending
import Display_CursorType
import Display_MouseMove
import Display_CaptureItem
import Display_GetContext
import Menus_Activate
import Menus_AnyFullScreenVisible
import Menu_Reset
import Menus_ActivateByName
import Menu_PaintAll
import Menu_New
import Menu_Count
import PC_Script_Parse
import PC_String_Parse
import PC_Rect_Parse
import PC_Int_Parse
import PC_Color_Parse
import PC_Float_Parse
import Script_Parse
import String_Parse
import Rect_Parse
import Int_Parse
import Color_Parse
import Float_Parse
import Menu_ScrollFeeder
import Menu_HandleMouseMove
import Menu_HandleKey
import Menu_GetFocused
import Menu_PostParse
import Item_Init
import Menu_Init
import Display_ExpandMacros
import Init_Display
import String_Report
import String_Init
import String_Alloc
import trap_R_AddLinearLightToScene
import trap_R_AddRefEntityToScene2
import linearLight
import intShaderTime
import CG_NewParticleArea
import initparticles
import CG_ParticleExplosion
import CG_ParticleMisc
import CG_ParticleDust
import CG_ParticleSparks
import CG_ParticleBulletDebris
import CG_ParticleSnowFlurry
import CG_AddParticleShrapnel
import CG_ParticleSmoke
import CG_ParticleSnow
import CG_AddParticles
import CG_ClearParticles
import trap_GetEntityToken
import trap_getCameraInfo
import trap_startCamera
import trap_loadCamera
import trap_SnapVector
import trap_CIN_SetExtents
import trap_CIN_DrawCinematic
import trap_CIN_RunCinematic
import trap_CIN_StopCinematic
import trap_CIN_PlayCinematic
import trap_Key_GetKey
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_IsDown
import trap_R_RegisterFont
import trap_MemoryRemaining
import testPrintFloat
import testPrintInt
import trap_SetUserCmdValue
import trap_GetUserCmd
import trap_GetCurrentCmdNumber
import trap_GetServerCommand
import trap_GetSnapshot
import trap_GetCurrentSnapshotNumber
import trap_GetGameState
import trap_GetGlconfig
import trap_R_inPVS
import trap_R_RemapShader
import trap_R_LerpTag
import trap_R_ModelBounds
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_LightForPoint
import trap_R_AddAdditiveLightToScene
import trap_R_AddLightToScene
import trap_R_AddPolysToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterShader
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_R_LoadWorldMap
import trap_S_StopBackgroundTrack
import trap_S_StartBackgroundTrack
import trap_S_RegisterSound
import trap_S_Respatialize
import trap_S_UpdateEntityPosition
import trap_S_AddRealLoopingSound
import trap_S_AddLoopingSound
import trap_S_ClearLoopingSounds
import trap_S_StartLocalSound
import trap_S_StopLoopingSound
import trap_S_StartSound
import trap_CM_MarkFragments
import trap_CM_TransformedCapsuleTrace
import trap_CM_TransformedBoxTrace
import trap_CM_CapsuleTrace
import trap_CM_BoxTrace
import trap_CM_TransformedPointContents
import trap_CM_PointContents
import trap_CM_TempBoxModel
import trap_CM_InlineModel
import trap_CM_NumInlineModels
import trap_CM_LoadMap
import trap_UpdateScreen
import trap_SendClientCommand
import trap_RemoveCommand
import trap_AddCommand
import trap_RealTime
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_Cvar_VariableStringBuffer
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import CG_CheckChangedPredictableEvents
import CG_TransitionPlayerState
import CG_Respawn
import CG_PlayBufferedVoiceChats
import CG_VoiceChatLocal
import CG_LoadVoiceChats
import CG_ShaderStateChanged
import CG_SetConfigValues
import CG_ParseSysteminfo
import CG_ParseServerinfo
import CG_ExecuteNewServerCommands
import CG_ScoreboardClick
import CG_DrawOldTourneyScoreboard
import CG_DrawOldScoreboard
import CG_DrawInformation
import CG_LoadingClient
import CG_LoadingItem
import CG_LoadingString
import CG_ProcessSnapshots
import CG_MakeExplosion
import CG_Bleed
import CG_BigExplode
import CG_GibPlayer
import CG_ScorePlum
import CG_LightningBoltBeam
import CG_InvulnerabilityJuiced
import CG_InvulnerabilityImpact
import CG_ObeliskPain
import CG_ObeliskExplode
import CG_KamikazeEffect
import CG_SpawnEffect
import CG_BubbleTrail
import CG_SmokePuff
import CG_AddLocalEntities
import CG_AllocLocalEntity
import CG_InitLocalEntities
import CG_ImpactMark
import CG_AddMarks
import CG_InitMarkPolys
import CG_OutOfAmmoChange
import CG_DrawWeaponSelect
import CG_AddPlayerWeapon
import CG_AddViewWeapon
import CG_GrappleTrail
import CG_RailTrail
import CG_Bullet
import CG_ShotgunFire
import CG_MissileHitPlayer
import CG_MissileHitWall
import CG_FireWeapon
import CG_RegisterItemVisuals
import CG_RegisterWeapon
import CG_Weapon_f
import CG_LastWeapon_f
import CG_PrevWeapon_f
import CG_NextWeapon_f
import CG_PositionRotatedEntityOnTag
import CG_PositionEntityOnTag
import CG_AdjustPositionForMover
import CG_Beam
import CG_AddPacketEntities
import CG_SetEntitySoundPosition
import CG_PainEvent
import CG_EntityEvent
import CG_PlaceString
import CG_CheckEvents
import CG_PlayDroppedEvents
import CG_LoadDeferredPlayers
import CG_PredictPlayerState
import CG_Trace
import CG_PointContents
import CG_BuildSolidList
import CG_CustomSound
import CG_NewClientInfo
import CG_AddRefEntityWithPowerups
import CG_ResetPlayerEntity
import CG_Player
import CG_TrackClientTeamChange
import CG_ForceModelChange
import CG_StatusHandle
import CG_OtherTeamHasFlag
import CG_YourTeamHasFlag
import CG_GameTypeString
import CG_CheckOrderPending
import CG_Text_PaintChar
import CG_Draw3DModel
import CG_GetKillerText
import CG_GetGameStatusText
import CG_GetTeamColor
import CG_InitTeamChat
import CG_SetPrintString
import CG_ShowResponseHead
import CG_RunMenuScript
import CG_OwnerDrawVisible
import CG_GetValue
import CG_SelectNextPlayer
import CG_SelectPrevPlayer
import CG_Text_Height
import CG_Text_Width
import CG_Text_Paint
import CG_OwnerDraw
import CG_DrawTeamBackground
import CG_DrawFlagModel
import CG_DrawActive
import CG_DrawHead
import CG_CenterPrint
import CG_AddLagometerSnapshotInfo
import CG_AddLagometerFrameInfo
import teamChat2
import teamChat1
import systemChat
import drawTeamOverlayModificationCount
import numSortedTeamPlayers
import sortedTeamPlayers
import CG_SelectFont
import CG_LoadFonts
import CG_DrawString
import CG_DrawTopBottom
import CG_DrawSides
import CG_DrawRect
import UI_DrawProportionalString
import CG_GetColorForHealth
import CG_ColorForHealth
import CG_TileClear
import CG_TeamColor
import CG_FadeColorTime
import CG_FadeColor
import CG_DrawStrlen
import CG_DrawStringExt
import CG_DrawPic
import CG_FillScreen
import CG_FillRect
import CG_AdjustFrom640
import CG_DrawActiveFrame
import CG_AddBufferedSound
import CG_ZoomUp_f
import CG_ZoomDown_f
import CG_TestModelPrevSkin_f
import CG_TestModelNextSkin_f
import CG_TestModelPrevFrame_f
import CG_TestModelNextFrame_f
import CG_TestGun_f
import CG_TestModel_f
import CG_SetScoreCatcher
import CG_BuildSpectatorString
import CG_GetSelectedScore
import CG_SetScoreSelection
import CG_RankRunFrame
import CG_EventHandling
import CG_MouseEvent
import CG_KeyEvent
import CG_LoadMenus
import CG_LastAttacker
import CG_CrosshairPlayer
import CG_UpdateCvars
import CG_StartMusic
import CG_Error
import CG_Printf
import CG_Argv
import CG_ConfigString
import eventnames
import cg_crosshairColor
import cg_kickScale
import cg_followKiller
import cg_fovAdjust
import cg_deadBodyDarken
import cg_teamColors
import cg_teamModel
import cg_enemyColors
import cg_enemyModel
import cg_hitSounds
import cg_trueLightning
import cg_oldPlasma
import cg_oldRocket
import cg_oldRail
import cg_bigFont
import cg_smallFont
import cg_noProjectileTrail
import cg_noTaunt
import cg_cameraMode
import cg_smoothClients
import cg_scorePlum
import cg_timescale
import cg_timescaleFadeSpeed
import cg_timescaleFadeEnd
import cg_cameraOrbitDelay
import cg_cameraOrbit
import cg_hudFiles
import cg_obeliskRespawnDelay
import cg_recordSPDemoName
import cg_recordSPDemo
import cg_singlePlayerActive
import cg_enableBreath
import cg_enableDust
import cg_singlePlayer
import cg_currentSelectedPlayerName
import cg_currentSelectedPlayer
import cg_blueTeamName
import cg_redTeamName
import cg_blood
import cg_paused
import cg_buildScript
import cg_noVoiceText
import cg_noVoiceChats
import cg_teamChatsOnly
import cg_drawFriend
import cg_stats
import cg_teamOverlayUserinfo
import cg_drawTeamOverlay
import cg_deferPlayers
import cg_predictItems
import cg_forceModel
import cg_teamChatHeight
import cg_teamChatTime
import cg_thirdPerson
import cg_thirdPersonAngle
import cg_thirdPersonRange
import cg_tracerLength
import cg_tracerWidth
import cg_tracerChance
import cg_footsteps
import cg_showmiss
import cg_noPlayerAnims
import cg_nopredict
import cg_errorDecay
import cg_debugEvents
import cg_debugPosition
import cg_debugAnim
import cg_animSpeed
import cg_swingSpeed
import cg_bobroll
import cg_bobpitch
import cg_bobup
import cg_runroll
import cg_runpitch
import cg_centertime
import cg_gun_z
import cg_gun_y
import cg_gun_x
import cg_gun_frame
import cg_railTrailRadius
import cg_railTrailTime
import cg_lagometer
import cg_addMarks
import cg_simpleItems
import cg_brassTime
import cg_crosshairY
import cg_crosshairX
import cg_crosshairHealth
import cg_crosshairSize
import cg_drawWeaponSelect
import cg_drawRewards
import cg_drawCrosshairNames
import cg_drawCrosshair
import cg_drawSpeed
import cg_drawAttacker
import cg_drawAmmoWarning
import cg_drawIcons
import cg_draw3dIcons
import cg_drawSnapshot
import cg_drawFPS
import cg_drawTimer
import cg_drawStatus
import cg_draw2D
import cg_gibs
import cg_shadows
import cg_viewsize
import cg_fov
import cg_zoomFov
import cg_drawGun
import cg_autoswitch
import cg_ignore
import cg_markPolys
import cg_items
import cg_weapons
import cg_entities
import cg
import cgs
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
LABELV $360
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $359
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
LABELV $358
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $357
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $356
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $355
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $354
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $353
byte 1 115
byte 1 101
byte 1 116
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 112
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $352
byte 1 97
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $351
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $350
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $349
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $348
byte 1 110
byte 1 111
byte 1 99
byte 1 108
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $347
byte 1 110
byte 1 111
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $346
byte 1 103
byte 1 111
byte 1 100
byte 1 0
align 1
LABELV $345
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $344
byte 1 103
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $343
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $342
byte 1 118
byte 1 111
byte 1 115
byte 1 97
byte 1 121
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $341
byte 1 118
byte 1 111
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $340
byte 1 118
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $339
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $338
byte 1 118
byte 1 115
byte 1 97
byte 1 121
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $337
byte 1 118
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $336
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $335
byte 1 115
byte 1 97
byte 1 121
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $334
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $333
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $319
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $318
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 79
byte 1 114
byte 1 98
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $317
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 85
byte 1 112
byte 1 0
align 1
LABELV $316
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 68
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $315
byte 1 115
byte 1 112
byte 1 76
byte 1 111
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $314
byte 1 115
byte 1 112
byte 1 87
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $313
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 71
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $312
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 73
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $311
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 84
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $310
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 80
byte 1 114
byte 1 97
byte 1 105
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $309
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 75
byte 1 105
byte 1 108
byte 1 108
byte 1 73
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $308
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 79
byte 1 119
byte 1 110
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $307
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 83
byte 1 117
byte 1 105
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $306
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 69
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $305
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 82
byte 1 101
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $304
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 70
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $303
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 67
byte 1 97
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $302
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 80
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $301
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 68
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $300
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 79
byte 1 102
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $299
byte 1 100
byte 1 101
byte 1 110
byte 1 121
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $298
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 114
byte 1 109
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $297
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $296
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 77
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $295
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 77
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $294
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 104
byte 1 117
byte 1 100
byte 1 0
align 1
LABELV $293
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 95
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $292
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 95
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $291
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 95
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $290
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 95
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $289
byte 1 116
byte 1 99
byte 1 109
byte 1 100
byte 1 0
align 1
LABELV $288
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $287
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $286
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 0
align 1
LABELV $285
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $284
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $283
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $282
byte 1 45
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $281
byte 1 43
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $280
byte 1 45
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $279
byte 1 43
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $278
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 112
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $277
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $276
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $275
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $274
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $273
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $272
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $270
byte 1 53
byte 1 0
align 1
LABELV $264
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
LABELV $262
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 115
byte 1 117
byte 1 105
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $258
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 118
byte 1 115
byte 1 97
byte 1 121
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 103
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $256
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 118
byte 1 115
byte 1 97
byte 1 121
byte 1 32
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 105
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $254
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 118
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $252
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 118
byte 1 115
byte 1 97
byte 1 121
byte 1 32
byte 1 112
byte 1 114
byte 1 97
byte 1 105
byte 1 115
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $250
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 118
byte 1 115
byte 1 97
byte 1 121
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 105
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $248
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
LABELV $246
byte 1 111
byte 1 110
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $244
byte 1 111
byte 1 110
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $242
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
LABELV $240
byte 1 111
byte 1 110
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $238
byte 1 111
byte 1 110
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $236
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
LABELV $234
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
LABELV $233
byte 1 111
byte 1 110
byte 1 103
byte 1 101
byte 1 116
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $232
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 118
byte 1 115
byte 1 97
byte 1 121
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $220
byte 1 43
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 54
byte 1 59
byte 1 32
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 59
byte 1 32
byte 1 45
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 54
byte 1 0
align 1
LABELV $219
byte 1 110
byte 1 111
byte 1 0
align 1
LABELV $214
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $209
byte 1 43
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 53
byte 1 59
byte 1 32
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 59
byte 1 32
byte 1 45
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 53
byte 1 0
align 1
LABELV $208
byte 1 121
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $206
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $170
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $163
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $159
byte 1 89
byte 1 79
byte 1 85
byte 1 32
byte 1 76
byte 1 79
byte 1 83
byte 1 69
byte 1 46
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $155
byte 1 89
byte 1 79
byte 1 85
byte 1 32
byte 1 87
byte 1 73
byte 1 78
byte 1 33
byte 1 0
align 1
LABELV $152
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $151
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 80
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 82
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $150
byte 1 48
byte 1 0
align 1
LABELV $149
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 80
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 65
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $148
byte 1 49
byte 1 0
align 1
LABELV $147
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 80
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $146
byte 1 51
byte 1 53
byte 1 0
align 1
LABELV $145
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 101
byte 1 114
byte 1 97
byte 1 79
byte 1 114
byte 1 98
byte 1 105
byte 1 116
byte 1 68
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $144
byte 1 50
byte 1 0
align 1
LABELV $143
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 101
byte 1 114
byte 1 97
byte 1 79
byte 1 114
byte 1 98
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $133
byte 1 117
byte 1 105
byte 1 47
byte 1 104
byte 1 117
byte 1 100
byte 1 46
byte 1 116
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $130
byte 1 99
byte 1 103
byte 1 95
byte 1 104
byte 1 117
byte 1 100
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $111
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $92
byte 1 40
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 41
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $87
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $86
byte 1 99
byte 1 103
byte 1 95
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $84
byte 1 103
byte 1 99
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 0
