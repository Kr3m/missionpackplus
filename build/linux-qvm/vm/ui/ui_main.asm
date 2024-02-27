data
align 4
LABELV MonthAbbrev
address $88
address $89
address $90
address $91
address $92
address $93
address $94
address $95
address $96
address $97
address $98
address $99
align 4
LABELV skillLevels
address $100
address $101
address $102
address $103
address $104
align 4
LABELV numSkillLevels
byte 4 5
align 4
LABELV netSources
address $105
address $106
address $107
address $108
align 4
LABELV numNetSources
byte 4 4
align 4
LABELV serverFilters
address $109
address $110
address $111
address $110
address $112
address $113
address $114
address $115
address $116
address $117
address $118
address $119
address $120
address $121
align 4
LABELV teamArenaGameTypes
address $122
address $123
address $124
address $125
address $126
address $127
address $128
address $129
address $130
align 4
LABELV numTeamArenaGameTypes
byte 4 9
align 4
LABELV teamArenaGameNames
address $131
address $132
address $133
address $134
address $135
address $136
address $137
address $138
address $139
align 4
LABELV numTeamArenaGameNames
byte 4 9
align 4
LABELV numServerFilters
byte 4 7
align 4
LABELV sortKeys
address $140
address $141
address $142
address $143
address $144
align 4
LABELV numSortKeys
byte 4 5
align 4
LABELV netnames
address $145
address $146
address $147
byte 4 0
align 4
LABELV gamecodetoui
byte 4 4
byte 4 2
byte 4 3
byte 4 0
byte 4 5
byte 4 1
byte 4 6
export vmMain
code
proc vmMain 12 8
file "../../../../code/ui/ui_main.c"
line 147
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:/*
;4:=======================================================================
;5:
;6:USER INTERFACE MAIN
;7:
;8:=======================================================================
;9:*/
;10:
;11:// use this to get a demo build without an explicit demo build, i.e. to get the demo ui files to build
;12://#define PRE_RELEASE_TADEMO
;13:
;14:#include "ui_local.h"
;15:
;16:uiInfo_t uiInfo;
;17:
;18:static const char *MonthAbbrev[] = {
;19:	"Jan","Feb","Mar",
;20:	"Apr","May","Jun",
;21:	"Jul","Aug","Sep",
;22:	"Oct","Nov","Dec"
;23:};
;24:
;25:
;26:static const char *skillLevels[] = {
;27:  "I Can Win",
;28:  "Bring It On",
;29:  "Hurt Me Plenty",
;30:  "Hardcore",
;31:  "Nightmare"
;32:};
;33:
;34:static const int numSkillLevels = sizeof(skillLevels) / sizeof(const char*);
;35:
;36:
;37:static const char *netSources[] = {
;38:	"Local",
;39:	"Mplayer",
;40:	"Internet",
;41:	"Favorites"
;42:};
;43:static const int numNetSources = sizeof(netSources) / sizeof(const char*);
;44:
;45:static const serverFilter_t serverFilters[] = {
;46:	{"All", "" },
;47:	{"Quake 3 Arena", "" },
;48:	{"Team Arena", "missionpack" },
;49:	{"Rocket Arena", "arena" },
;50:	{"Alliance", "alliance20" },
;51:	{"Weapons Factory Arena", "wfa" },
;52:	{"OSP", "osp" },
;53:};
;54:
;55:static const char *teamArenaGameTypes[] = {
;56:	"FFA",
;57:	"TOURNAMENT",
;58:	"SP",
;59:	"TEAM DM",
;60:	"CTF",
;61:	"1FCTF",
;62:	"OVERLOAD",
;63:	"HARVESTER",
;64:	"TEAMTOURNAMENT"
;65:};
;66:
;67:static int const numTeamArenaGameTypes = sizeof(teamArenaGameTypes) / sizeof(const char*);
;68:
;69:
;70:static const char *teamArenaGameNames[] = {
;71:	"Free For All",
;72:	"Tournament",
;73:	"Single Player",
;74:	"Team Deathmatch",
;75:	"Capture the Flag",
;76:	"One Flag CTF",
;77:	"Overload",
;78:	"Harvester",
;79:	"Team Tournament",
;80:};
;81:
;82:static int const numTeamArenaGameNames = sizeof(teamArenaGameNames) / sizeof(const char*);
;83:
;84:
;85:static const int numServerFilters = sizeof(serverFilters) / sizeof(serverFilter_t);
;86:
;87:static const char *sortKeys[] = {
;88:	"Server Name",
;89:	"Map Name",
;90:	"Open Player Spots",
;91:	"Game Type",
;92:	"Ping Time"
;93:};
;94:static const int numSortKeys = sizeof(sortKeys) / sizeof(const char*);
;95:
;96:static char* netnames[] = {
;97:	"???",
;98:	"UDP",
;99:	"IPX",
;100:	NULL
;101:};
;102:
;103:#ifndef MISSIONPACK // bk001206
;104:static char quake3worldMessage[] = "Visit www.quake3world.com - News, Community, Events, Files";
;105:#endif
;106:
;107:static int gamecodetoui[] = {4,2,3,0,5,1,6};
;108:
;109:
;110:static void UI_StartServerRefresh(qboolean full);
;111:static void UI_StopServerRefresh( void );
;112:static void UI_DoServerRefresh( void );
;113:static void UI_FeederSelection(float feederID, int index);
;114:static void UI_BuildServerDisplayList(qboolean force);
;115:static void UI_BuildServerStatus(qboolean force);
;116:static void UI_BuildFindPlayerList(qboolean force);
;117:static int QDECL UI_ServersQsortCompare( const void *arg1, const void *arg2 );
;118:static int UI_MapCountByGameType(qboolean singlePlayer);
;119:static int UI_HeadCountByTeam( void );
;120:static void UI_ParseGameInfo(const char *teamFile);
;121:static void UI_ParseTeamInfo(const char *teamFile);
;122:static const char *UI_SelectedMap(int index, int *actual);
;123:static const char *UI_SelectedHead(int index, int *actual);
;124:static int UI_GetIndexFromSelection(int actual);
;125:
;126:int ProcessNewUI( int command, int arg0, int arg1, int arg2, int arg3, int arg4, int arg5, int arg6 );
;127:
;128:/*
;129:================
;130:vmMain
;131:
;132:This is the only way control passes into the module.
;133:This must be the very first function compiled into the .qvm file
;134:================
;135:*/
;136:vmCvar_t  ui_new;
;137:vmCvar_t  ui_debug;
;138:vmCvar_t  ui_initialized;
;139:vmCvar_t  ui_teamArenaFirstRun;
;140:
;141:void _UI_Init( qboolean );
;142:void _UI_Shutdown( void );
;143:void _UI_KeyEvent( int key, qboolean down );
;144:void _UI_MouseEvent( int dx, int dy );
;145:void _UI_Refresh( int realtime );
;146:qboolean _UI_IsFullscreen( void );
;147:int vmMain( int command, int arg0, int arg1, int arg2, int arg3, int arg4, int arg5, int arg6, int arg7, int arg8, int arg9, int arg10, int arg11  ) {
line 148
;148:  switch ( command ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $149
ADDRLP4 0
INDIRI4
CNSTI4 10
GTI4 $149
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $162
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $162
address $151
address $152
address $153
address $154
address $155
address $156
address $157
address $158
address $159
address $160
address $161
code
LABELV $151
line 150
;149:	  case UI_GETAPIVERSION:
;150:		  return UI_API_VERSION;
CNSTI4 6
RETI4
ADDRGP4 $148
JUMPV
LABELV $152
line 153
;151:
;152:	  case UI_INIT:
;153:		  _UI_Init(arg0);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 _UI_Init
CALLV
pop
line 154
;154:		  return 0;
CNSTI4 0
RETI4
ADDRGP4 $148
JUMPV
LABELV $153
line 157
;155:
;156:	  case UI_SHUTDOWN:
;157:		  _UI_Shutdown();
ADDRGP4 _UI_Shutdown
CALLV
pop
line 158
;158:		  return 0;
CNSTI4 0
RETI4
ADDRGP4 $148
JUMPV
LABELV $154
line 161
;159:
;160:	  case UI_KEY_EVENT:
;161:		  _UI_KeyEvent( arg0, arg1 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 _UI_KeyEvent
CALLV
pop
line 162
;162:		  return 0;
CNSTI4 0
RETI4
ADDRGP4 $148
JUMPV
LABELV $155
line 165
;163:
;164:	  case UI_MOUSE_EVENT:
;165:		  _UI_MouseEvent( arg0, arg1 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 _UI_MouseEvent
CALLV
pop
line 166
;166:		  return 0;
CNSTI4 0
RETI4
ADDRGP4 $148
JUMPV
LABELV $156
line 169
;167:
;168:	  case UI_REFRESH:
;169:		  _UI_Refresh( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 _UI_Refresh
CALLV
pop
line 170
;170:		  return 0;
CNSTI4 0
RETI4
ADDRGP4 $148
JUMPV
LABELV $157
line 173
;171:
;172:	  case UI_IS_FULLSCREEN:
;173:		  return _UI_IsFullscreen();
ADDRLP4 4
ADDRGP4 _UI_IsFullscreen
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $148
JUMPV
LABELV $158
line 176
;174:
;175:	  case UI_SET_ACTIVE_MENU:
;176:		  _UI_SetActiveMenu( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 _UI_SetActiveMenu
CALLV
pop
line 177
;177:		  return 0;
CNSTI4 0
RETI4
ADDRGP4 $148
JUMPV
LABELV $159
line 180
;178:
;179:	  case UI_CONSOLE_COMMAND:
;180:		  return UI_ConsoleCommand(arg0);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 UI_ConsoleCommand
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $148
JUMPV
LABELV $160
line 183
;181:
;182:	  case UI_DRAW_CONNECT_SCREEN:
;183:		  UI_DrawConnectScreen( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 UI_DrawConnectScreen
CALLV
pop
line 184
;184:		  return 0;
CNSTI4 0
RETI4
ADDRGP4 $148
JUMPV
LABELV $161
line 186
;185:	  case UI_HASUNIQUECDKEY: // mod authors need to observe this
;186:	    return qtrue; // bk010117 - change this to qfalse for mods!
CNSTI4 1
RETI4
ADDRGP4 $148
JUMPV
LABELV $149
line 190
;187:
;188:	}
;189:
;190:	return -1;
CNSTI4 -1
RETI4
LABELV $148
endproc vmMain 12 8
export AssetCache
proc AssetCache 60 8
line 195
;191:}
;192:
;193:
;194:
;195:void AssetCache() {
line 201
;196:	int n;
;197:	//if (Assets.textFont == NULL) {
;198:	//}
;199:	//Assets.background = trap_R_RegisterShaderNoMip( ASSET_BACKGROUND );
;200:	//Com_Printf("Menu Size: %i bytes\n", sizeof(Menus));
;201:	uiInfo.uiDC.Assets.gradientBar = trap_R_RegisterShaderNoMip( ASSET_GRADIENTBAR );
ADDRGP4 $166
ARGP4
ADDRLP4 4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61660
ADDRLP4 4
INDIRI4
ASGNI4
line 202
;202:	uiInfo.uiDC.Assets.fxBasePic = trap_R_RegisterShaderNoMip( ART_FX_BASE );
ADDRGP4 $169
ARGP4
ADDRLP4 8
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61768
ADDRLP4 8
INDIRI4
ASGNI4
line 203
;203:	uiInfo.uiDC.Assets.fxPic = trap_R_RegisterShaderNoMip( ART_FX_WHITE );
ADDRGP4 $172
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61772
ADDRLP4 12
INDIRI4
ASGNI4
line 204
;204:	uiInfo.uiDC.Assets.scrollBar = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR );
ADDRGP4 $175
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61680
ADDRLP4 16
INDIRI4
ASGNI4
line 205
;205:	uiInfo.uiDC.Assets.scrollBarArrowDown = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWDOWN );
ADDRGP4 $178
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61668
ADDRLP4 20
INDIRI4
ASGNI4
line 206
;206:	uiInfo.uiDC.Assets.scrollBarArrowUp = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWUP );
ADDRGP4 $181
ARGP4
ADDRLP4 24
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61664
ADDRLP4 24
INDIRI4
ASGNI4
line 207
;207:	uiInfo.uiDC.Assets.scrollBarArrowLeft = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWLEFT );
ADDRGP4 $184
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61672
ADDRLP4 28
INDIRI4
ASGNI4
line 208
;208:	uiInfo.uiDC.Assets.scrollBarArrowRight = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWRIGHT );
ADDRGP4 $187
ARGP4
ADDRLP4 32
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61676
ADDRLP4 32
INDIRI4
ASGNI4
line 209
;209:	uiInfo.uiDC.Assets.scrollBarThumb = trap_R_RegisterShaderNoMip( ASSET_SCROLL_THUMB );
ADDRGP4 $190
ARGP4
ADDRLP4 36
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61684
ADDRLP4 36
INDIRI4
ASGNI4
line 210
;210:	uiInfo.uiDC.Assets.sliderBar = trap_R_RegisterShaderNoMip( ASSET_SLIDER_BAR );
ADDRGP4 $193
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61700
ADDRLP4 40
INDIRI4
ASGNI4
line 211
;211:	uiInfo.uiDC.Assets.sliderThumb = trap_R_RegisterShaderNoMip( ASSET_SLIDER_THUMB );
ADDRGP4 $196
ARGP4
ADDRLP4 44
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61704
ADDRLP4 44
INDIRI4
ASGNI4
line 213
;212:
;213:	for( n = 0; n < NUM_CROSSHAIRS; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $197
line 214
;214:		uiInfo.uiDC.Assets.crosshairShader[n] = trap_R_RegisterShaderNoMip( va("gfx/2d/crosshair%c", 'a' + n ) );
ADDRGP4 $203
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 97
ADDI4
ARGI4
ADDRLP4 52
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+228+61776
ADDP4
ADDRLP4 56
INDIRI4
ASGNI4
line 215
;215:	}
LABELV $198
line 213
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LTI4 $197
line 217
;216:
;217:	uiInfo.newHighScoreSound = trap_S_RegisterSound("sound/feedback/voc_newhighscore.wav", qfalse);
ADDRGP4 $205
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 48
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 uiInfo+119496
ADDRLP4 48
INDIRI4
ASGNI4
line 218
;218:}
LABELV $163
endproc AssetCache 60 8
export _UI_DrawSides
proc _UI_DrawSides 4 36
line 220
;219:
;220:void _UI_DrawSides(float x, float y, float w, float h, float size) {
line 221
;221:	UI_AdjustFrom640( &x, &y, &w, &h );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 UI_AdjustFrom640
CALLV
pop
line 222
;222:	size *= uiInfo.uiDC.xscale;
ADDRFP4 16
ADDRFP4 16
INDIRF4
ADDRGP4 uiInfo+200
INDIRF4
MULF4
ASGNF4
line 223
;223:	trap_R_DrawStretchPic( x, y, size, h, 0, 0, 0, 0, uiInfo.uiDC.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 uiInfo+73376
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 224
;224:	trap_R_DrawStretchPic( x + w - size, y, size, h, 0, 0, 0, 0, uiInfo.uiDC.whiteShader );
ADDRLP4 0
ADDRFP4 16
INDIRF4
ASGNF4
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
ADDF4
ADDRLP4 0
INDIRF4
SUBF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 uiInfo+73376
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 225
;225:}
LABELV $206
endproc _UI_DrawSides 4 36
export _UI_DrawTopBottom
proc _UI_DrawTopBottom 4 36
line 227
;226:
;227:void _UI_DrawTopBottom(float x, float y, float w, float h, float size) {
line 228
;228:	UI_AdjustFrom640( &x, &y, &w, &h );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 UI_AdjustFrom640
CALLV
pop
line 229
;229:	size *= uiInfo.uiDC.yscale;
ADDRFP4 16
ADDRFP4 16
INDIRF4
ADDRGP4 uiInfo+196
INDIRF4
MULF4
ASGNF4
line 230
;230:	trap_R_DrawStretchPic( x, y, w, size, 0, 0, 0, 0, uiInfo.uiDC.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 uiInfo+73376
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 231
;231:	trap_R_DrawStretchPic( x, y + h - size, w, size, 0, 0, 0, 0, uiInfo.uiDC.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 0
ADDRFP4 16
INDIRF4
ASGNF4
ADDRFP4 4
INDIRF4
ADDRFP4 12
INDIRF4
ADDF4
ADDRLP4 0
INDIRF4
SUBF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 uiInfo+73376
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 232
;232:}
LABELV $210
endproc _UI_DrawTopBottom 4 36
export _UI_DrawRect
proc _UI_DrawRect 0 20
line 240
;233:/*
;234:================
;235:UI_DrawRect
;236:
;237:Coordinates are 640*480 virtual values
;238:=================
;239:*/
;240:void _UI_DrawRect( float x, float y, float width, float height, float size, const float *color ) {
line 241
;241:	trap_R_SetColor( color );
ADDRFP4 20
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 243
;242:
;243:  _UI_DrawTopBottom(x, y, width, height, size);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRGP4 _UI_DrawTopBottom
CALLV
pop
line 244
;244:  _UI_DrawSides(x, y, width, height, size);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRGP4 _UI_DrawSides
CALLV
pop
line 246
;245:
;246:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 247
;247:}
LABELV $214
endproc _UI_DrawRect 0 20
export Text_Width
proc Text_Width 40 4
line 249
;248:
;249:int Text_Width(const char *text, float scale, int limit) {
line 254
;250:  int count,len;
;251:	float out;
;252:	glyphInfo_t *glyph;
;253:	float useScale;
;254:	const char *s = text;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 255
;255:	fontInfo_t *font = &uiInfo.uiDC.Assets.textFont;
ADDRLP4 12
ADDRGP4 uiInfo+228+12
ASGNP4
line 256
;256:	if (scale <= ui_smallFont.value) {
ADDRFP4 4
INDIRF4
ADDRGP4 ui_smallFont+8
INDIRF4
GTF4 $218
line 257
;257:		font = &uiInfo.uiDC.Assets.smallFont;
ADDRLP4 12
ADDRGP4 uiInfo+228+20560
ASGNP4
line 258
;258:	} else if (scale >= ui_bigFont.value) {
ADDRGP4 $219
JUMPV
LABELV $218
ADDRFP4 4
INDIRF4
ADDRGP4 ui_bigFont+8
INDIRF4
LTF4 $223
line 259
;259:		font = &uiInfo.uiDC.Assets.bigFont;
ADDRLP4 12
ADDRGP4 uiInfo+228+41108
ASGNP4
line 260
;260:	}
LABELV $223
LABELV $219
line 261
;261:	useScale = scale * font->glyphScale;
ADDRLP4 24
ADDRFP4 4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 20480
ADDP4
INDIRF4
MULF4
ASGNF4
line 262
;262:  out = 0;
ADDRLP4 20
CNSTF4 0
ASGNF4
line 263
;263:  if (text) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $228
line 264
;264:    len = strlen(text);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 8
ADDRLP4 28
INDIRU4
CVUI4 4
ASGNI4
line 265
;265:		if (limit > 0 && len > limit) {
ADDRLP4 32
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
LEI4 $230
ADDRLP4 8
INDIRI4
ADDRLP4 32
INDIRI4
LEI4 $230
line 266
;266:			len = limit;
ADDRLP4 8
ADDRFP4 8
INDIRI4
ASGNI4
line 267
;267:		}
LABELV $230
line 268
;268:		count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $233
JUMPV
LABELV $232
line 269
;269:		while (s && *s && count < len) {
line 270
;270:			if ( Q_IsColorString(s) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $235
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $235
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $235
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $235
line 271
;271:				s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 272
;272:				continue;
ADDRGP4 $233
JUMPV
LABELV $235
line 273
;273:			} else {
line 274
;274:				glyph = &font->glyphs[(int)*s];
ADDRLP4 16
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 80
MULI4
ADDRLP4 12
INDIRP4
ADDP4
ASGNP4
line 275
;275:				out += glyph->xSkip;
ADDRLP4 20
ADDRLP4 20
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 276
;276:				s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 277
;277:				count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 278
;278:			}
line 279
;279:    }
LABELV $233
line 269
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $238
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $238
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $232
LABELV $238
line 280
;280:  }
LABELV $228
line 281
;281:  return out * useScale;
ADDRLP4 20
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
CVFI4 4
RETI4
LABELV $215
endproc Text_Width 40 4
export Text_Height
proc Text_Height 40 4
line 284
;282:}
;283:
;284:int Text_Height(const char *text, float scale, int limit) {
line 289
;285:  int len, count;
;286:	float max;
;287:	glyphInfo_t *glyph;
;288:	float useScale;
;289:	const char *s = text; // bk001206 - unsigned
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 290
;290:	fontInfo_t *font = &uiInfo.uiDC.Assets.textFont;
ADDRLP4 20
ADDRGP4 uiInfo+228+12
ASGNP4
line 291
;291:	if (scale <= ui_smallFont.value) {
ADDRFP4 4
INDIRF4
ADDRGP4 ui_smallFont+8
INDIRF4
GTF4 $242
line 292
;292:		font = &uiInfo.uiDC.Assets.smallFont;
ADDRLP4 20
ADDRGP4 uiInfo+228+20560
ASGNP4
line 293
;293:	} else if (scale >= ui_bigFont.value) {
ADDRGP4 $243
JUMPV
LABELV $242
ADDRFP4 4
INDIRF4
ADDRGP4 ui_bigFont+8
INDIRF4
LTF4 $247
line 294
;294:		font = &uiInfo.uiDC.Assets.bigFont;
ADDRLP4 20
ADDRGP4 uiInfo+228+41108
ASGNP4
line 295
;295:	}
LABELV $247
LABELV $243
line 296
;296:	useScale = scale * font->glyphScale;
ADDRLP4 24
ADDRFP4 4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 20480
ADDP4
INDIRF4
MULF4
ASGNF4
line 297
;297:  max = 0;
ADDRLP4 16
CNSTF4 0
ASGNF4
line 298
;298:  if (text) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $252
line 299
;299:    len = strlen(text);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 8
ADDRLP4 28
INDIRU4
CVUI4 4
ASGNI4
line 300
;300:		if (limit > 0 && len > limit) {
ADDRLP4 32
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
LEI4 $254
ADDRLP4 8
INDIRI4
ADDRLP4 32
INDIRI4
LEI4 $254
line 301
;301:			len = limit;
ADDRLP4 8
ADDRFP4 8
INDIRI4
ASGNI4
line 302
;302:		}
LABELV $254
line 303
;303:		count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $257
JUMPV
LABELV $256
line 304
;304:		while (s && *s && count < len) {
line 305
;305:			if ( Q_IsColorString(s) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $259
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $259
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $259
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $259
line 306
;306:				s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 307
;307:				continue;
ADDRGP4 $257
JUMPV
LABELV $259
line 308
;308:			} else {
line 309
;309:				glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
ADDRLP4 12
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 80
MULI4
ADDRLP4 20
INDIRP4
ADDP4
ASGNP4
line 310
;310:	      if (max < glyph->height) {
ADDRLP4 16
INDIRF4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
GEF4 $261
line 311
;311:		      max = glyph->height;
ADDRLP4 16
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
line 312
;312:			  }
LABELV $261
line 313
;313:				s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 314
;314:				count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 315
;315:			}
line 316
;316:    }
LABELV $257
line 304
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $264
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $264
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $256
LABELV $264
line 317
;317:  }
LABELV $252
line 318
;318:  return max * useScale;
ADDRLP4 16
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
CVFI4 4
RETI4
LABELV $239
endproc Text_Height 40 4
export Text_PaintChar
proc Text_PaintChar 8 36
line 321
;319:}
;320:
;321:void Text_PaintChar(float x, float y, float width, float height, float scale, float s, float t, float s2, float t2, qhandle_t hShader) {
line 323
;322:  float w, h;
;323:  w = width * scale;
ADDRLP4 0
ADDRFP4 8
INDIRF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 324
;324:  h = height * scale;
ADDRLP4 4
ADDRFP4 12
INDIRF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 325
;325:  UI_AdjustFrom640( &x, &y, &w, &h );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 UI_AdjustFrom640
CALLV
pop
line 326
;326:  trap_R_DrawStretchPic( x, y, w, h, s, t, s2, t2, hShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRFP4 20
INDIRF4
ARGF4
ADDRFP4 24
INDIRF4
ARGF4
ADDRFP4 28
INDIRF4
ARGF4
ADDRFP4 32
INDIRF4
ARGF4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 327
;327:}
LABELV $265
endproc Text_PaintChar 8 36
export Text_Paint
proc Text_Paint 76 40
line 329
;328:
;329:void Text_Paint(float x, float y, float scale, vec4_t color, const char *text, float adjust, int limit, int style) {
line 334
;330:  int len, count;
;331:	vec4_t newColor;
;332:	glyphInfo_t *glyph;
;333:	float useScale;
;334:	fontInfo_t *font = &uiInfo.uiDC.Assets.textFont;
ADDRLP4 28
ADDRGP4 uiInfo+228+12
ASGNP4
line 335
;335:	if (scale <= ui_smallFont.value) {
ADDRFP4 8
INDIRF4
ADDRGP4 ui_smallFont+8
INDIRF4
GTF4 $269
line 336
;336:		font = &uiInfo.uiDC.Assets.smallFont;
ADDRLP4 28
ADDRGP4 uiInfo+228+20560
ASGNP4
line 337
;337:	} else if (scale >= ui_bigFont.value) {
ADDRGP4 $270
JUMPV
LABELV $269
ADDRFP4 8
INDIRF4
ADDRGP4 ui_bigFont+8
INDIRF4
LTF4 $274
line 338
;338:		font = &uiInfo.uiDC.Assets.bigFont;
ADDRLP4 28
ADDRGP4 uiInfo+228+41108
ASGNP4
line 339
;339:	}
LABELV $274
LABELV $270
line 340
;340:	useScale = scale * font->glyphScale;
ADDRLP4 20
ADDRFP4 8
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 20480
ADDP4
INDIRF4
MULF4
ASGNF4
line 341
;341:  if (text) {
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $279
line 342
;342:    const char *s = text; // bk001206 - unsigned
ADDRLP4 36
ADDRFP4 16
INDIRP4
ASGNP4
line 343
;343:		trap_R_SetColor( color );
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 344
;344:		memcpy(&newColor[0], &color[0], sizeof(vec4_t));
ADDRLP4 4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTU4 16
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 345
;345:    len = strlen(text);
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 32
ADDRLP4 40
INDIRU4
CVUI4 4
ASGNI4
line 346
;346:		if (limit > 0 && len > limit) {
ADDRLP4 44
ADDRFP4 24
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
LEI4 $281
ADDRLP4 32
INDIRI4
ADDRLP4 44
INDIRI4
LEI4 $281
line 347
;347:			len = limit;
ADDRLP4 32
ADDRFP4 24
INDIRI4
ASGNI4
line 348
;348:		}
LABELV $281
line 349
;349:		count = 0;
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 $284
JUMPV
LABELV $283
line 350
;350:		while (s && *s && count < len) {
line 351
;351:			glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
ADDRLP4 0
ADDRLP4 36
INDIRP4
INDIRI1
CVII4 1
CNSTI4 80
MULI4
ADDRLP4 28
INDIRP4
ADDP4
ASGNP4
line 354
;352:      //int yadj = Assets.textFont.glyphs[text[i]].bottom + Assets.textFont.glyphs[text[i]].top;
;353:      //float yadj = scale * (Assets.textFont.glyphs[text[i]].imageHeight - Assets.textFont.glyphs[text[i]].height);
;354:			if ( Q_IsColorString( s ) ) {
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $286
ADDRLP4 36
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $286
ADDRLP4 36
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $286
ADDRLP4 36
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $286
line 355
;355:				memcpy( newColor, g_color_table[ColorIndex(*(s+1))], sizeof( newColor ) );
ADDRLP4 4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
CNSTI4 7
BANDI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
CNSTU4 16
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 356
;356:				newColor[3] = color[3];
ADDRLP4 4+12
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 357
;357:				trap_R_SetColor( newColor );
ADDRLP4 4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 358
;358:				s += 2;
ADDRLP4 36
ADDRLP4 36
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 359
;359:				continue;
ADDRGP4 $284
JUMPV
LABELV $286
line 360
;360:			} else {
line 361
;361:				float yadj = useScale * glyph->top;
ADDRLP4 52
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 362
;362:				if (style == ITEM_TEXTSTYLE_SHADOWED || style == ITEM_TEXTSTYLE_SHADOWEDMORE) {
ADDRLP4 56
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 3
EQI4 $291
ADDRLP4 56
INDIRI4
CNSTI4 6
NEI4 $289
LABELV $291
line 363
;363:					int ofs = style == ITEM_TEXTSTYLE_SHADOWED ? 1 : 2;
ADDRFP4 28
INDIRI4
CNSTI4 3
NEI4 $293
ADDRLP4 64
CNSTI4 1
ASGNI4
ADDRGP4 $294
JUMPV
LABELV $293
ADDRLP4 64
CNSTI4 2
ASGNI4
LABELV $294
ADDRLP4 60
ADDRLP4 64
INDIRI4
ASGNI4
line 364
;364:					colorBlack[3] = newColor[3];
ADDRGP4 colorBlack+12
ADDRLP4 4+12
INDIRF4
ASGNF4
line 365
;365:					trap_R_SetColor( colorBlack );
ADDRGP4 colorBlack
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 366
;366:					Text_PaintChar(x + ofs, y - yadj + ofs, 
ADDRLP4 68
ADDRLP4 60
INDIRI4
CVIF4 4
ASGNF4
ADDRFP4 0
INDIRF4
ADDRLP4 68
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ADDRLP4 52
INDIRF4
SUBF4
ADDRLP4 68
INDIRF4
ADDF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ARGF4
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
INDIRI4
ARGI4
ADDRGP4 Text_PaintChar
CALLV
pop
line 375
;367:														glyph->imageWidth,
;368:														glyph->imageHeight,
;369:														useScale, 
;370:														glyph->s,
;371:														glyph->t,
;372:														glyph->s2,
;373:														glyph->t2,
;374:														glyph->glyph);
;375:					trap_R_SetColor( newColor );
ADDRLP4 4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 376
;376:					colorBlack[3] = 1.0;
ADDRGP4 colorBlack+12
CNSTF4 1065353216
ASGNF4
line 377
;377:				}
LABELV $289
line 378
;378:				Text_PaintChar(x, y - yadj, 
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ADDRLP4 52
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ARGF4
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
INDIRI4
ARGI4
ADDRGP4 Text_PaintChar
CALLV
pop
line 388
;379:													glyph->imageWidth,
;380:													glyph->imageHeight,
;381:													useScale, 
;382:													glyph->s,
;383:													glyph->t,
;384:													glyph->s2,
;385:													glyph->t2,
;386:													glyph->glyph);
;387:
;388:				x += (glyph->xSkip * useScale) + adjust;
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 20
INDIRF4
MULF4
ADDRFP4 20
INDIRF4
ADDF4
ADDF4
ASGNF4
line 389
;389:				s++;
ADDRLP4 36
ADDRLP4 36
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 390
;390:				count++;
ADDRLP4 24
ADDRLP4 24
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 391
;391:			}
line 392
;392:    }
LABELV $284
line 350
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $299
ADDRLP4 36
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $299
ADDRLP4 24
INDIRI4
ADDRLP4 32
INDIRI4
LTI4 $283
LABELV $299
line 393
;393:	  trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 394
;394:  }
LABELV $279
line 395
;395:}
LABELV $266
endproc Text_Paint 76 40
export Text_PaintWithCursor
proc Text_PaintWithCursor 80 40
ADDRFP4 24
ADDRFP4 24
INDIRI4
CVII1 4
ASGNI1
line 397
;396:
;397:void Text_PaintWithCursor(float x, float y, float scale, vec4_t color, const char *text, int cursorPos, char cursor, int limit, int style) {
line 403
;398:  int len, count;
;399:	vec4_t newColor;
;400:	glyphInfo_t *glyph, *glyph2;
;401:	float yadj;
;402:	float useScale;
;403:	fontInfo_t *font = &uiInfo.uiDC.Assets.textFont;
ADDRLP4 36
ADDRGP4 uiInfo+228+12
ASGNP4
line 404
;404:	if (scale <= ui_smallFont.value) {
ADDRFP4 8
INDIRF4
ADDRGP4 ui_smallFont+8
INDIRF4
GTF4 $303
line 405
;405:		font = &uiInfo.uiDC.Assets.smallFont;
ADDRLP4 36
ADDRGP4 uiInfo+228+20560
ASGNP4
line 406
;406:	} else if (scale >= ui_bigFont.value) {
ADDRGP4 $304
JUMPV
LABELV $303
ADDRFP4 8
INDIRF4
ADDRGP4 ui_bigFont+8
INDIRF4
LTF4 $308
line 407
;407:		font = &uiInfo.uiDC.Assets.bigFont;
ADDRLP4 36
ADDRGP4 uiInfo+228+41108
ASGNP4
line 408
;408:	}
LABELV $308
LABELV $304
line 409
;409:	useScale = scale * font->glyphScale;
ADDRLP4 4
ADDRFP4 8
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 20480
ADDP4
INDIRF4
MULF4
ASGNF4
line 410
;410:  if (text) {
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $313
line 411
;411:    const char *s = text; // bk001206 - unsigned
ADDRLP4 44
ADDRFP4 16
INDIRP4
ASGNP4
line 412
;412:		trap_R_SetColor( color );
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 413
;413:		memcpy(&newColor[0], &color[0], sizeof(vec4_t));
ADDRLP4 12
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTU4 16
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 414
;414:    len = strlen(text);
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 40
ADDRLP4 48
INDIRU4
CVUI4 4
ASGNI4
line 415
;415:		if (limit > 0 && len > limit) {
ADDRLP4 52
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
LEI4 $315
ADDRLP4 40
INDIRI4
ADDRLP4 52
INDIRI4
LEI4 $315
line 416
;416:			len = limit;
ADDRLP4 40
ADDRFP4 28
INDIRI4
ASGNI4
line 417
;417:		}
LABELV $315
line 418
;418:		count = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 419
;419:		glyph2 = &font->glyphs[ (int) cursor]; // bk001206 - possible signed char
ADDRLP4 8
ADDRFP4 24
INDIRI1
CVII4 1
CNSTI4 80
MULI4
ADDRLP4 36
INDIRP4
ADDP4
ASGNP4
ADDRGP4 $318
JUMPV
LABELV $317
line 420
;420:		while (s && *s && count < len) {
line 421
;421:			glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
ADDRLP4 0
ADDRLP4 44
INDIRP4
INDIRI1
CVII4 1
CNSTI4 80
MULI4
ADDRLP4 36
INDIRP4
ADDP4
ASGNP4
line 424
;422:      //int yadj = Assets.textFont.glyphs[text[i]].bottom + Assets.textFont.glyphs[text[i]].top;
;423:      //float yadj = scale * (Assets.textFont.glyphs[text[i]].imageHeight - Assets.textFont.glyphs[text[i]].height);
;424:			if ( Q_IsColorString( s ) ) {
ADDRLP4 44
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $320
ADDRLP4 44
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $320
ADDRLP4 44
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $320
ADDRLP4 44
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $320
line 425
;425:				memcpy( newColor, g_color_table[ColorIndex(*(s+1))], sizeof( newColor ) );
ADDRLP4 12
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
CNSTI4 7
BANDI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
CNSTU4 16
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 426
;426:				newColor[3] = color[3];
ADDRLP4 12+12
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 427
;427:				trap_R_SetColor( newColor );
ADDRLP4 12
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 428
;428:				s += 2;
ADDRLP4 44
ADDRLP4 44
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 429
;429:				continue;
ADDRGP4 $318
JUMPV
LABELV $320
line 430
;430:			} else {
line 431
;431:				yadj = useScale * glyph->top;
ADDRLP4 32
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 432
;432:				if (style == ITEM_TEXTSTYLE_SHADOWED || style == ITEM_TEXTSTYLE_SHADOWEDMORE) {
ADDRLP4 60
ADDRFP4 32
INDIRI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 3
EQI4 $325
ADDRLP4 60
INDIRI4
CNSTI4 6
NEI4 $323
LABELV $325
line 433
;433:					int ofs = style == ITEM_TEXTSTYLE_SHADOWED ? 1 : 2;
ADDRFP4 32
INDIRI4
CNSTI4 3
NEI4 $327
ADDRLP4 68
CNSTI4 1
ASGNI4
ADDRGP4 $328
JUMPV
LABELV $327
ADDRLP4 68
CNSTI4 2
ASGNI4
LABELV $328
ADDRLP4 64
ADDRLP4 68
INDIRI4
ASGNI4
line 434
;434:					colorBlack[3] = newColor[3];
ADDRGP4 colorBlack+12
ADDRLP4 12+12
INDIRF4
ASGNF4
line 435
;435:					trap_R_SetColor( colorBlack );
ADDRGP4 colorBlack
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 436
;436:					Text_PaintChar(x + ofs, y - yadj + ofs, 
ADDRLP4 72
ADDRLP4 64
INDIRI4
CVIF4 4
ASGNF4
ADDRFP4 0
INDIRF4
ADDRLP4 72
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ADDRLP4 32
INDIRF4
SUBF4
ADDRLP4 72
INDIRF4
ADDF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ARGF4
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
INDIRI4
ARGI4
ADDRGP4 Text_PaintChar
CALLV
pop
line 445
;437:														glyph->imageWidth,
;438:														glyph->imageHeight,
;439:														useScale, 
;440:														glyph->s,
;441:														glyph->t,
;442:														glyph->s2,
;443:														glyph->t2,
;444:														glyph->glyph);
;445:					colorBlack[3] = 1.0;
ADDRGP4 colorBlack+12
CNSTF4 1065353216
ASGNF4
line 446
;446:					trap_R_SetColor( newColor );
ADDRLP4 12
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 447
;447:				}
LABELV $323
line 448
;448:				Text_PaintChar(x, y - yadj, 
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ADDRLP4 32
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ARGF4
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
INDIRI4
ARGI4
ADDRGP4 Text_PaintChar
CALLV
pop
line 458
;449:													glyph->imageWidth,
;450:													glyph->imageHeight,
;451:													useScale, 
;452:													glyph->s,
;453:													glyph->t,
;454:													glyph->s2,
;455:													glyph->t2,
;456:													glyph->glyph);
;457:
;458:	      yadj = useScale * glyph2->top;
ADDRLP4 32
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 459
;459:		    if (count == cursorPos && !((uiInfo.uiDC.realTime/BLINK_DIVISOR) & 1)) {
ADDRLP4 28
INDIRI4
ADDRFP4 20
INDIRI4
NEI4 $332
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 200
DIVI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $332
line 460
;460:					Text_PaintChar(x, y - yadj, 
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ADDRLP4 32
INDIRF4
SUBF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 Text_PaintChar
CALLV
pop
line 469
;461:														glyph2->imageWidth,
;462:														glyph2->imageHeight,
;463:														useScale, 
;464:														glyph2->s,
;465:														glyph2->t,
;466:														glyph2->s2,
;467:														glyph2->t2,
;468:														glyph2->glyph);
;469:				}
LABELV $332
line 471
;470:
;471:				x += (glyph->xSkip * useScale);
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
MULF4
ADDF4
ASGNF4
line 472
;472:				s++;
ADDRLP4 44
ADDRLP4 44
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 473
;473:				count++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 474
;474:			}
line 475
;475:    }
LABELV $318
line 420
ADDRLP4 44
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $336
ADDRLP4 44
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $336
ADDRLP4 28
INDIRI4
ADDRLP4 40
INDIRI4
LTI4 $317
LABELV $336
line 477
;476:    // need to paint cursor at end of text
;477:    if (cursorPos == len && !((uiInfo.uiDC.realTime/BLINK_DIVISOR) & 1)) {
ADDRFP4 20
INDIRI4
ADDRLP4 40
INDIRI4
NEI4 $337
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 200
DIVI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $337
line 478
;478:        yadj = useScale * glyph2->top;
ADDRLP4 32
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 479
;479:        Text_PaintChar(x, y - yadj, 
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ADDRLP4 32
INDIRF4
SUBF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 Text_PaintChar
CALLV
pop
line 489
;480:                          glyph2->imageWidth,
;481:                          glyph2->imageHeight,
;482:                          useScale, 
;483:                          glyph2->s,
;484:                          glyph2->t,
;485:                          glyph2->s2,
;486:                          glyph2->t2,
;487:                          glyph2->glyph);
;488:
;489:    }
LABELV $337
line 491
;490:
;491:	  trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 492
;492:  }
LABELV $313
line 493
;493:}
LABELV $300
endproc Text_PaintWithCursor 80 40
proc Text_Paint_Limit 68 40
line 496
;494:
;495:
;496:static void Text_Paint_Limit(float *maxX, float x, float y, float scale, vec4_t color, const char* text, float adjust, int limit) {
line 500
;497:  int len, count;
;498:	vec4_t newColor;
;499:	glyphInfo_t *glyph;
;500:  if (text) {
ADDRFP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $341
line 501
;501:    const char *s = text; // bk001206 - unsigned
ADDRLP4 28
ADDRFP4 20
INDIRP4
ASGNP4
line 502
;502:		float max = *maxX;
ADDRLP4 40
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 504
;503:		float useScale;
;504:		fontInfo_t *font = &uiInfo.uiDC.Assets.textFont;
ADDRLP4 36
ADDRGP4 uiInfo+228+12
ASGNP4
line 505
;505:		if (scale <= ui_smallFont.value) {
ADDRFP4 12
INDIRF4
ADDRGP4 ui_smallFont+8
INDIRF4
GTF4 $345
line 506
;506:			font = &uiInfo.uiDC.Assets.smallFont;
ADDRLP4 36
ADDRGP4 uiInfo+228+20560
ASGNP4
line 507
;507:		} else if (scale > ui_bigFont.value) {
ADDRGP4 $346
JUMPV
LABELV $345
ADDRFP4 12
INDIRF4
ADDRGP4 ui_bigFont+8
INDIRF4
LEF4 $350
line 508
;508:			font = &uiInfo.uiDC.Assets.bigFont;
ADDRLP4 36
ADDRGP4 uiInfo+228+41108
ASGNP4
line 509
;509:		}
LABELV $350
LABELV $346
line 510
;510:		useScale = scale * font->glyphScale;
ADDRLP4 32
ADDRFP4 12
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 20480
ADDP4
INDIRF4
MULF4
ASGNF4
line 511
;511:		trap_R_SetColor( color );
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 512
;512:    len = strlen(text);					 
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 24
ADDRLP4 44
INDIRU4
CVUI4 4
ASGNI4
line 513
;513:		if (limit > 0 && len > limit) {
ADDRLP4 48
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
LEI4 $355
ADDRLP4 24
INDIRI4
ADDRLP4 48
INDIRI4
LEI4 $355
line 514
;514:			len = limit;
ADDRLP4 24
ADDRFP4 28
INDIRI4
ASGNI4
line 515
;515:		}
LABELV $355
line 516
;516:		count = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 $358
JUMPV
LABELV $357
line 517
;517:		while (s && *s && count < len) {
line 518
;518:			glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRI1
CVII4 1
CNSTI4 80
MULI4
ADDRLP4 36
INDIRP4
ADDP4
ASGNP4
line 519
;519:			if ( Q_IsColorString( s ) ) {
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $360
ADDRLP4 28
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $360
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $360
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $360
line 520
;520:				memcpy( newColor, g_color_table[ColorIndex(*(s+1))], sizeof( newColor ) );
ADDRLP4 4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
CNSTI4 7
BANDI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
CNSTU4 16
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 521
;521:				newColor[3] = color[3];
ADDRLP4 4+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 522
;522:				trap_R_SetColor( newColor );
ADDRLP4 4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 523
;523:				s += 2;
ADDRLP4 28
ADDRLP4 28
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 524
;524:				continue;
ADDRGP4 $358
JUMPV
LABELV $360
line 525
;525:			} else {
line 526
;526:	      float yadj = useScale * glyph->top;
ADDRLP4 56
ADDRLP4 32
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 527
;527:				if (Text_Width(s, useScale, 1) + x > max) {
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 60
ADDRGP4 Text_Width
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CVIF4 4
ADDRFP4 4
INDIRF4
ADDF4
ADDRLP4 40
INDIRF4
LEF4 $363
line 528
;528:					*maxX = 0;
ADDRFP4 0
INDIRP4
CNSTF4 0
ASGNF4
line 529
;529:					break;
ADDRGP4 $359
JUMPV
LABELV $363
line 531
;530:				}
;531:		    Text_PaintChar(x, y - yadj, 
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ADDRLP4 56
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ARGF4
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
INDIRI4
ARGI4
ADDRGP4 Text_PaintChar
CALLV
pop
line 540
;532:			                 glyph->imageWidth,
;533:				               glyph->imageHeight,
;534:				               useScale, 
;535:						           glyph->s,
;536:								       glyph->t,
;537:								       glyph->s2,
;538:									     glyph->t2,
;539:										   glyph->glyph);
;540:	      x += (glyph->xSkip * useScale) + adjust;
ADDRFP4 4
ADDRFP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 32
INDIRF4
MULF4
ADDRFP4 24
INDIRF4
ADDF4
ADDF4
ASGNF4
line 541
;541:				*maxX = x;
ADDRFP4 0
INDIRP4
ADDRFP4 4
INDIRF4
ASGNF4
line 542
;542:				count++;
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 543
;543:				s++;
ADDRLP4 28
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 544
;544:	    }
line 545
;545:		}
LABELV $358
line 517
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $366
ADDRLP4 28
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $366
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
LTI4 $357
LABELV $366
LABELV $359
line 546
;546:	  trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 547
;547:  }
LABELV $341
line 549
;548:
;549:}
LABELV $340
endproc Text_Paint_Limit 68 40
export UI_ShowPostGame
proc UI_ShowPostGame 0 8
line 552
;550:
;551:
;552:void UI_ShowPostGame(qboolean newHigh) {
line 553
;553:	trap_Cvar_Set ("cg_cameraOrbit", "0");
ADDRGP4 $368
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 554
;554:	trap_Cvar_Set("cg_thirdPerson", "0");
ADDRGP4 $370
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 555
;555:	trap_Cvar_Set( "sv_killserver", "1" );
ADDRGP4 $371
ARGP4
ADDRGP4 $372
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 556
;556:	uiInfo.soundHighScore = newHigh;
ADDRGP4 uiInfo+73448
ADDRFP4 0
INDIRI4
ASGNI4
line 557
;557:  _UI_SetActiveMenu(UIMENU_POSTGAME);
CNSTI4 6
ARGI4
ADDRGP4 _UI_SetActiveMenu
CALLV
pop
line 558
;558:}
LABELV $367
endproc UI_ShowPostGame 0 8
export UI_DrawCenteredPic
proc UI_DrawCenteredPic 8 20
line 565
;559:/*
;560:=================
;561:_UI_Refresh
;562:=================
;563:*/
;564:
;565:void UI_DrawCenteredPic(qhandle_t image, int w, int h) {
line 567
;566:  int x, y;
;567:  x = (SCREEN_WIDTH - w) / 2;
ADDRLP4 0
CNSTI4 640
ADDRFP4 4
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 568
;568:  y = (SCREEN_HEIGHT - h) / 2;
ADDRLP4 4
CNSTI4 480
ADDRFP4 8
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 569
;569:  UI_DrawHandlePic(x, y, w, h, image);
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 570
;570:}
LABELV $374
endproc UI_DrawCenteredPic 8 20
data
export frameCount
align 4
LABELV frameCount
byte 4 0
bss
align 4
LABELV $376
skip 4
align 4
LABELV $377
skip 16
export _UI_Refresh
code
proc _UI_Refresh 3104 20
line 577
;571:
;572:int frameCount = 0;
;573:int startTime;
;574:
;575:#define	UI_FPS_FRAMES	4
;576:void _UI_Refresh( int realtime )
;577:{
line 585
;578:	static int index;
;579:	static int	previousTimes[UI_FPS_FRAMES];
;580:
;581:	//if ( !( trap_Key_GetCatcher() & KEYCATCH_UI ) ) {
;582:	//	return;
;583:	//}
;584:
;585:	uiInfo.uiDC.frameTime = realtime - uiInfo.uiDC.realTime;
ADDRGP4 uiInfo+212
ADDRFP4 0
INDIRI4
ADDRGP4 uiInfo+208
INDIRI4
SUBI4
ASGNI4
line 586
;586:	uiInfo.uiDC.realTime = realtime;
ADDRGP4 uiInfo+208
ADDRFP4 0
INDIRI4
ASGNI4
line 588
;587:
;588:	previousTimes[index % UI_FPS_FRAMES] = uiInfo.uiDC.frameTime;
ADDRGP4 $376
INDIRI4
CNSTI4 4
MODI4
CNSTI4 2
LSHI4
ADDRGP4 $377
ADDP4
ADDRGP4 uiInfo+212
INDIRI4
ASGNI4
line 589
;589:	index++;
ADDRLP4 0
ADDRGP4 $376
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 590
;590:	if ( index > UI_FPS_FRAMES ) {
ADDRGP4 $376
INDIRI4
CNSTI4 4
LEI4 $382
line 593
;591:		int i, total;
;592:		// average multiple frames together to smooth changes out a bit
;593:		total = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 594
;594:		for ( i = 0 ; i < UI_FPS_FRAMES ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $384
line 595
;595:			total += previousTimes[i];
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $377
ADDP4
INDIRI4
ADDI4
ASGNI4
line 596
;596:		}
LABELV $385
line 594
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
LTI4 $384
line 597
;597:		if ( !total ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $388
line 598
;598:			total = 1;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 599
;599:		}
LABELV $388
line 600
;600:		uiInfo.uiDC.FPS = 1000 * UI_FPS_FRAMES / total;
ADDRGP4 uiInfo+73388
CNSTI4 4000
ADDRLP4 8
INDIRI4
DIVI4
CVIF4 4
ASGNF4
line 601
;601:	}
LABELV $382
line 603
;602:
;603:	UI_UpdateCvars();
ADDRGP4 UI_UpdateCvars
CALLV
pop
line 605
;604:
;605:	if ( ( trap_Key_GetCatcher() & KEYCATCH_UI ) ) {
ADDRLP4 4
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $391
line 606
;606:		UI_VideoCheck( realtime );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 UI_VideoCheck
CALLV
pop
line 607
;607:	}
LABELV $391
line 609
;608:
;609:	if (Menu_Count() > 0) {
ADDRLP4 8
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LEI4 $393
line 611
;610:		// paint all the menus
;611:		Menu_PaintAll();
ADDRGP4 Menu_PaintAll
CALLV
pop
line 613
;612:		// refresh server browser list
;613:		UI_DoServerRefresh();
ADDRGP4 UI_DoServerRefresh
CALLV
pop
line 615
;614:		// refresh server status
;615:		UI_BuildServerStatus(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_BuildServerStatus
CALLV
pop
line 617
;616:		// refresh find player list
;617:		UI_BuildFindPlayerList(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_BuildFindPlayerList
CALLV
pop
line 618
;618:	} 
LABELV $393
line 621
;619:	
;620:	// draw cursor
;621:	UI_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 UI_SetColor
CALLV
pop
line 622
;622:	if (Menu_Count() > 0) {
ADDRLP4 12
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
LEI4 $395
line 624
;623:		uiClientState_t	cstate;
;624:		trap_GetClientState( &cstate );
ADDRLP4 16
ARGP4
ADDRGP4 trap_GetClientState
CALLV
pop
line 625
;625:		if(cstate.connState <= CA_DISCONNECTED || cstate.connState >= CA_ACTIVE) {
ADDRLP4 3100
ADDRLP4 16
INDIRI4
ASGNI4
ADDRLP4 3100
INDIRI4
CNSTI4 1
LEI4 $399
ADDRLP4 3100
INDIRI4
CNSTI4 8
LTI4 $397
LABELV $399
line 626
;626:			UI_DrawHandlePic( uiInfo.uiDC.cursorx-16, uiInfo.uiDC.cursory-16, 32, 32, uiInfo.uiDC.Assets.cursor);
ADDRGP4 uiInfo+216
INDIRF4
CNSTF4 1098907648
SUBF4
ARGF4
ADDRGP4 uiInfo+220
INDIRF4
CNSTF4 1098907648
SUBF4
ARGF4
CNSTF4 1107296256
ARGF4
CNSTF4 1107296256
ARGF4
ADDRGP4 uiInfo+228+61656
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 627
;627:		}
LABELV $397
line 628
;628:	}
LABELV $395
line 631
;629:
;630:#ifndef NDEBUG
;631:	if (uiInfo.uiDC.debug)
ADDRGP4 uiInfo+224
INDIRI4
CNSTI4 0
EQI4 $404
line 632
;632:	{
line 636
;633:		// cursor coordinates
;634:		//FIXME
;635:		//UI_DrawString( 0, 0, va("(%d,%d)",uis.cursorx,uis.cursory), UI_LEFT|UI_SMALLFONT, colorRed );
;636:	}
LABELV $404
line 639
;637:#endif
;638:
;639:}
LABELV $375
endproc _UI_Refresh 3104 20
export _UI_Shutdown
proc _UI_Shutdown 0 0
line 646
;640:
;641:/*
;642:=================
;643:_UI_Shutdown
;644:=================
;645:*/
;646:void _UI_Shutdown( void ) {
line 647
;647:	trap_LAN_SaveCachedServers();
ADDRGP4 trap_LAN_SaveCachedServers
CALLV
pop
line 648
;648:}
LABELV $407
endproc _UI_Shutdown 0 0
data
export defaultMenu
align 4
LABELV defaultMenu
byte 4 0
bss
align 1
LABELV $409
skip 32768
export GetMenuBuffer
code
proc GetMenuBuffer 16 16
line 652
;649:
;650:char *defaultMenu = NULL;
;651:
;652:char *GetMenuBuffer(const char *filename) {
line 657
;653:	int	len;
;654:	fileHandle_t	f;
;655:	static char buf[MAX_MENUFILE];
;656:
;657:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 658
;658:	if ( !f ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $410
line 659
;659:		trap_Print( va( S_COLOR_RED "menu file not found: %s, using default\n", filename ) );
ADDRGP4 $412
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 660
;660:		return defaultMenu;
ADDRGP4 defaultMenu
INDIRP4
RETP4
ADDRGP4 $408
JUMPV
LABELV $410
line 662
;661:	}
;662:	if ( len >= MAX_MENUFILE ) {
ADDRLP4 0
INDIRI4
CNSTI4 32768
LTI4 $413
line 663
;663:		trap_Print( va( S_COLOR_RED "menu file too large: %s is %i, max allowed is %i", filename, len, MAX_MENUFILE ) );
ADDRGP4 $415
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 32768
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 664
;664:		trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 665
;665:		return defaultMenu;
ADDRGP4 defaultMenu
INDIRP4
RETP4
ADDRGP4 $408
JUMPV
LABELV $413
line 668
;666:	}
;667:
;668:	trap_FS_Read( buf, len, f );
ADDRGP4 $409
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 669
;669:	buf[len] = 0;
ADDRLP4 0
INDIRI4
ADDRGP4 $409
ADDP4
CNSTI1 0
ASGNI1
line 670
;670:	trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 672
;671:	//COM_Compress(buf);
;672:  return buf;
ADDRGP4 $409
RETP4
LABELV $408
endproc GetMenuBuffer 16 16
export Asset_Parse
proc Asset_Parse 1124 12
line 676
;673:
;674:}
;675:
;676:qboolean Asset_Parse(int handle) {
line 680
;677:	pc_token_t token;
;678:	const char *tempStr;
;679:
;680:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1044
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $417
line 681
;681:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $416
JUMPV
LABELV $417
line 682
;682:	if (Q_stricmp(token.string, "{") != 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $422
ARGP4
ADDRLP4 1048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
EQI4 $424
line 683
;683:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $416
JUMPV
LABELV $423
line 686
;684:	}
;685:    
;686:	while ( 1 ) {
line 688
;687:
;688:		memset(&token, 0, sizeof(pc_token_t));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTU4 1040
ARGU4
ADDRGP4 memset
CALLP4
pop
line 690
;689:
;690:		if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1052
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $426
line 691
;691:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $416
JUMPV
LABELV $426
line 693
;692:
;693:		if (Q_stricmp(token.string, "}") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $431
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $428
line 694
;694:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $416
JUMPV
LABELV $428
line 698
;695:		}
;696:
;697:		// font
;698:		if (Q_stricmp(token.string, "font") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $435
ARGP4
ADDRLP4 1060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $432
line 700
;699:			int pointSize;
;700:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle,&pointSize)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 1068
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
EQI4 $438
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1064
ARGP4
ADDRLP4 1072
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $436
LABELV $438
line 701
;701:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $416
JUMPV
LABELV $436
line 703
;702:			}
;703:			trap_R_RegisterFont(tempStr, pointSize, &uiInfo.uiDC.Assets.textFont);
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1064
INDIRI4
ARGI4
ADDRGP4 uiInfo+228+12
ARGP4
ADDRGP4 trap_R_RegisterFont
CALLV
pop
line 704
;704:			uiInfo.uiDC.Assets.fontRegistered = qtrue;
ADDRGP4 uiInfo+228+61764
CNSTI4 1
ASGNI4
line 705
;705:			continue;
ADDRGP4 $424
JUMPV
LABELV $432
line 708
;706:		}
;707:
;708:		if (Q_stricmp(token.string, "smallFont") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $446
ARGP4
ADDRLP4 1064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $443
line 710
;709:			int pointSize;
;710:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle,&pointSize)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 1072
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
EQI4 $449
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1068
ARGP4
ADDRLP4 1076
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
NEI4 $447
LABELV $449
line 711
;711:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $416
JUMPV
LABELV $447
line 713
;712:			}
;713:			trap_R_RegisterFont(tempStr, pointSize, &uiInfo.uiDC.Assets.smallFont);
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1068
INDIRI4
ARGI4
ADDRGP4 uiInfo+228+20560
ARGP4
ADDRGP4 trap_R_RegisterFont
CALLV
pop
line 714
;714:			continue;
ADDRGP4 $424
JUMPV
LABELV $443
line 717
;715:		}
;716:
;717:		if (Q_stricmp(token.string, "bigFont") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $455
ARGP4
ADDRLP4 1068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
NEI4 $452
line 719
;718:			int pointSize;
;719:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle,&pointSize)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 1076
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
EQI4 $458
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1072
ARGP4
ADDRLP4 1080
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 1080
INDIRI4
CNSTI4 0
NEI4 $456
LABELV $458
line 720
;720:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $416
JUMPV
LABELV $456
line 722
;721:			}
;722:			trap_R_RegisterFont(tempStr, pointSize, &uiInfo.uiDC.Assets.bigFont);
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1072
INDIRI4
ARGI4
ADDRGP4 uiInfo+228+41108
ARGP4
ADDRGP4 trap_R_RegisterFont
CALLV
pop
line 723
;723:			continue;
ADDRGP4 $424
JUMPV
LABELV $452
line 728
;724:		}
;725:
;726:
;727:		// gradientbar
;728:		if (Q_stricmp(token.string, "gradientbar") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $464
ARGP4
ADDRLP4 1072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $461
line 729
;729:			if (!PC_String_Parse(handle, &tempStr)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 1076
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
NEI4 $465
line 730
;730:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $416
JUMPV
LABELV $465
line 732
;731:			}
;732:			uiInfo.uiDC.Assets.gradientBar = trap_R_RegisterShaderNoMip(tempStr);
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1080
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61660
ADDRLP4 1080
INDIRI4
ASGNI4
line 733
;733:			continue;
ADDRGP4 $424
JUMPV
LABELV $461
line 737
;734:		}
;735:
;736:		// enterMenuSound
;737:		if (Q_stricmp(token.string, "menuEnterSound") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $472
ARGP4
ADDRLP4 1076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
NEI4 $469
line 738
;738:			if (!PC_String_Parse(handle, &tempStr)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 1080
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 1080
INDIRI4
CNSTI4 0
NEI4 $473
line 739
;739:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $416
JUMPV
LABELV $473
line 741
;740:			}
;741:			uiInfo.uiDC.Assets.menuEnterSound = trap_S_RegisterSound( tempStr, qfalse );
ADDRLP4 1040
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1084
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61708
ADDRLP4 1084
INDIRI4
ASGNI4
line 742
;742:			continue;
ADDRGP4 $424
JUMPV
LABELV $469
line 746
;743:		}
;744:
;745:		// exitMenuSound
;746:		if (Q_stricmp(token.string, "menuExitSound") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $480
ARGP4
ADDRLP4 1080
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1080
INDIRI4
CNSTI4 0
NEI4 $477
line 747
;747:			if (!PC_String_Parse(handle, &tempStr)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 1084
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 1084
INDIRI4
CNSTI4 0
NEI4 $481
line 748
;748:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $416
JUMPV
LABELV $481
line 750
;749:			}
;750:			uiInfo.uiDC.Assets.menuExitSound = trap_S_RegisterSound( tempStr, qfalse );
ADDRLP4 1040
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1088
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61712
ADDRLP4 1088
INDIRI4
ASGNI4
line 751
;751:			continue;
ADDRGP4 $424
JUMPV
LABELV $477
line 755
;752:		}
;753:
;754:		// itemFocusSound
;755:		if (Q_stricmp(token.string, "itemFocusSound") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $488
ARGP4
ADDRLP4 1084
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1084
INDIRI4
CNSTI4 0
NEI4 $485
line 756
;756:			if (!PC_String_Parse(handle, &tempStr)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 1088
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 1088
INDIRI4
CNSTI4 0
NEI4 $489
line 757
;757:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $416
JUMPV
LABELV $489
line 759
;758:			}
;759:			uiInfo.uiDC.Assets.itemFocusSound = trap_S_RegisterSound( tempStr, qfalse );
ADDRLP4 1040
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1092
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61720
ADDRLP4 1092
INDIRI4
ASGNI4
line 760
;760:			continue;
ADDRGP4 $424
JUMPV
LABELV $485
line 764
;761:		}
;762:
;763:		// menuBuzzSound
;764:		if (Q_stricmp(token.string, "menuBuzzSound") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $496
ARGP4
ADDRLP4 1088
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1088
INDIRI4
CNSTI4 0
NEI4 $493
line 765
;765:			if (!PC_String_Parse(handle, &tempStr)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 1092
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 1092
INDIRI4
CNSTI4 0
NEI4 $497
line 766
;766:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $416
JUMPV
LABELV $497
line 768
;767:			}
;768:			uiInfo.uiDC.Assets.menuBuzzSound = trap_S_RegisterSound( tempStr, qfalse );
ADDRLP4 1040
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1096
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61716
ADDRLP4 1096
INDIRI4
ASGNI4
line 769
;769:			continue;
ADDRGP4 $424
JUMPV
LABELV $493
line 772
;770:		}
;771:
;772:		if (Q_stricmp(token.string, "cursor") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $504
ARGP4
ADDRLP4 1092
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1092
INDIRI4
CNSTI4 0
NEI4 $501
line 773
;773:			if (!PC_String_Parse(handle, &uiInfo.uiDC.Assets.cursorStr)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+228+4
ARGP4
ADDRLP4 1096
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 1096
INDIRI4
CNSTI4 0
NEI4 $505
line 774
;774:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $416
JUMPV
LABELV $505
line 776
;775:			}
;776:			uiInfo.uiDC.Assets.cursor = trap_R_RegisterShaderNoMip( uiInfo.uiDC.Assets.cursorStr);
ADDRGP4 uiInfo+228+4
INDIRP4
ARGP4
ADDRLP4 1100
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61656
ADDRLP4 1100
INDIRI4
ASGNI4
line 777
;777:			continue;
ADDRGP4 $424
JUMPV
LABELV $501
line 780
;778:		}
;779:
;780:		if (Q_stricmp(token.string, "fadeClamp") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $516
ARGP4
ADDRLP4 1096
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1096
INDIRI4
CNSTI4 0
NEI4 $513
line 781
;781:			if (!PC_Float_Parse(handle, &uiInfo.uiDC.Assets.fadeClamp)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+228+61724
ARGP4
ADDRLP4 1100
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 1100
INDIRI4
CNSTI4 0
NEI4 $424
line 782
;782:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $416
JUMPV
line 784
;783:			}
;784:			continue;
LABELV $513
line 787
;785:		}
;786:
;787:		if (Q_stricmp(token.string, "fadeCycle") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $524
ARGP4
ADDRLP4 1100
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1100
INDIRI4
CNSTI4 0
NEI4 $521
line 788
;788:			if (!PC_Int_Parse(handle, &uiInfo.uiDC.Assets.fadeCycle)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+228+61728
ARGP4
ADDRLP4 1104
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 1104
INDIRI4
CNSTI4 0
NEI4 $424
line 789
;789:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $416
JUMPV
line 791
;790:			}
;791:			continue;
LABELV $521
line 794
;792:		}
;793:
;794:		if (Q_stricmp(token.string, "fadeAmount") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $532
ARGP4
ADDRLP4 1104
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1104
INDIRI4
CNSTI4 0
NEI4 $529
line 795
;795:			if (!PC_Float_Parse(handle, &uiInfo.uiDC.Assets.fadeAmount)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+228+61732
ARGP4
ADDRLP4 1108
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 0
NEI4 $424
line 796
;796:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $416
JUMPV
line 798
;797:			}
;798:			continue;
LABELV $529
line 801
;799:		}
;800:
;801:		if (Q_stricmp(token.string, "shadowX") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $540
ARGP4
ADDRLP4 1108
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 0
NEI4 $537
line 802
;802:			if (!PC_Float_Parse(handle, &uiInfo.uiDC.Assets.shadowX)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+228+61736
ARGP4
ADDRLP4 1112
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 1112
INDIRI4
CNSTI4 0
NEI4 $424
line 803
;803:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $416
JUMPV
line 805
;804:			}
;805:			continue;
LABELV $537
line 808
;806:		}
;807:
;808:		if (Q_stricmp(token.string, "shadowY") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $548
ARGP4
ADDRLP4 1112
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1112
INDIRI4
CNSTI4 0
NEI4 $545
line 809
;809:			if (!PC_Float_Parse(handle, &uiInfo.uiDC.Assets.shadowY)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+228+61740
ARGP4
ADDRLP4 1116
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 1116
INDIRI4
CNSTI4 0
NEI4 $424
line 810
;810:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $416
JUMPV
line 812
;811:			}
;812:			continue;
LABELV $545
line 815
;813:		}
;814:
;815:		if (Q_stricmp(token.string, "shadowColor") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $556
ARGP4
ADDRLP4 1116
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1116
INDIRI4
CNSTI4 0
NEI4 $553
line 816
;816:			if (!PC_Color_Parse(handle, &uiInfo.uiDC.Assets.shadowColor)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+228+61744
ARGP4
ADDRLP4 1120
ADDRGP4 PC_Color_Parse
CALLI4
ASGNI4
ADDRLP4 1120
INDIRI4
CNSTI4 0
NEI4 $557
line 817
;817:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $416
JUMPV
LABELV $557
line 819
;818:			}
;819:			uiInfo.uiDC.Assets.shadowFadeClamp = uiInfo.uiDC.Assets.shadowColor[3];
ADDRGP4 uiInfo+228+61760
ADDRGP4 uiInfo+228+61744+12
INDIRF4
ASGNF4
line 820
;820:			continue;
LABELV $553
line 823
;821:		}
;822:
;823:	}
LABELV $424
line 686
ADDRGP4 $423
JUMPV
line 824
;824:	return qfalse;
CNSTI4 0
RETI4
LABELV $416
endproc Asset_Parse 1124 12
export Font_Report
proc Font_Report 8 12
line 827
;825:}
;826:
;827:void Font_Report() {
line 829
;828:  int i;
;829:  Com_Printf("Font Info\n");
ADDRGP4 $567
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 830
;830:  Com_Printf("=========\n");
ADDRGP4 $568
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 831
;831:  for ( i = 32; i < 96; i++) {
ADDRLP4 0
CNSTI4 32
ASGNI4
LABELV $569
line 832
;832:    Com_Printf("Glyph handle %i: %i\n", i, uiInfo.uiDC.Assets.textFont.glyphs[i].glyph);
ADDRGP4 $573
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 80
MULI4
ADDRGP4 uiInfo+228+12+44
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 833
;833:  }
LABELV $570
line 831
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 96
LTI4 $569
line 834
;834:}
LABELV $566
endproc Font_Report 8 12
export UI_Report
proc UI_Report 0 0
line 836
;835:
;836:void UI_Report() {
line 837
;837:  String_Report();
ADDRGP4 String_Report
CALLV
pop
line 840
;838:  //Font_Report();
;839:
;840:}
LABELV $577
endproc UI_Report 0 0
export UI_ParseMenu
proc UI_ParseMenu 1060 12
line 842
;841:
;842:void UI_ParseMenu(const char *menuFile) {
line 846
;843:	int handle;
;844:	pc_token_t token;
;845:
;846:	Com_Printf("Parsing menu file:%s\n", menuFile);
ADDRGP4 $579
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 848
;847:
;848:	handle = trap_PC_LoadSource(menuFile);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1044
ADDRGP4 trap_PC_LoadSource
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1044
INDIRI4
ASGNI4
line 849
;849:	if (!handle) {
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $583
line 850
;850:		return;
ADDRGP4 $578
JUMPV
LABELV $582
line 853
;851:	}
;852:
;853:	while ( 1 ) {
line 854
;854:		memset(&token, 0, sizeof(pc_token_t));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTU4 1040
ARGU4
ADDRGP4 memset
CALLP4
pop
line 855
;855:		if (!trap_PC_ReadToken( handle, &token )) {
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1048
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $585
line 856
;856:			break;
ADDRGP4 $584
JUMPV
LABELV $585
line 869
;857:		}
;858:
;859:		//if ( Q_stricmp( token, "{" ) ) {
;860:		//	Com_Printf( "Missing { in menu file\n" );
;861:		//	break;
;862:		//}
;863:
;864:		//if ( menuCount == MAX_MENUS ) {
;865:		//	Com_Printf( "Too many menus!\n" );
;866:		//	break;
;867:		//}
;868:
;869:		if ( token.string[0] == '}' ) {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $587
line 870
;870:			break;
ADDRGP4 $584
JUMPV
LABELV $587
line 873
;871:		}
;872:
;873:		if (Q_stricmp(token.string, "assetGlobalDef") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $593
ARGP4
ADDRLP4 1052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $590
line 874
;874:			if (Asset_Parse(handle)) {
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 1056
ADDRGP4 Asset_Parse
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
EQI4 $584
line 875
;875:				continue;
ADDRGP4 $583
JUMPV
line 876
;876:			} else {
line 877
;877:				break;
LABELV $590
line 881
;878:			}
;879:		}
;880:
;881:		if (Q_stricmp(token.string, "menudef") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $599
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $596
line 883
;882:			// start a new menu
;883:			Menu_New(handle);
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 Menu_New
CALLV
pop
line 884
;884:		}
LABELV $596
line 885
;885:	}
LABELV $583
line 853
ADDRGP4 $582
JUMPV
LABELV $584
line 886
;886:	trap_PC_FreeSource(handle);
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 trap_PC_FreeSource
CALLI4
pop
line 887
;887:}
LABELV $578
endproc UI_ParseMenu 1060 12
export Load_Menu
proc Load_Menu 1048 8
line 889
;888:
;889:qboolean Load_Menu(int handle) {
line 892
;890:	pc_token_t token;
;891:
;892:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1040
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $601
line 893
;893:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $600
JUMPV
LABELV $601
line 894
;894:	if (token.string[0] != '{') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $607
line 895
;895:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $600
JUMPV
LABELV $606
line 898
;896:	}
;897:
;898:	while ( 1 ) {
line 900
;899:
;900:		if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1044
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $609
line 901
;901:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $600
JUMPV
LABELV $609
line 903
;902:    
;903:		if ( token.string[0] == 0 ) {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $611
line 904
;904:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $600
JUMPV
LABELV $611
line 907
;905:		}
;906:
;907:		if ( token.string[0] == '}' ) {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $614
line 908
;908:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $600
JUMPV
LABELV $614
line 911
;909:		}
;910:
;911:		UI_ParseMenu(token.string); 
ADDRLP4 0+16
ARGP4
ADDRGP4 UI_ParseMenu
CALLV
pop
line 912
;912:	}
LABELV $607
line 898
ADDRGP4 $606
JUMPV
line 913
;913:	return qfalse;
CNSTI4 0
RETI4
LABELV $600
endproc Load_Menu 1048 8
export UI_LoadMenus
proc UI_LoadMenus 1068 8
line 916
;914:}
;915:
;916:void UI_LoadMenus(const char *menuFile, qboolean reset) {
line 921
;917:	pc_token_t token;
;918:	int handle;
;919:	int start;
;920:
;921:	start = trap_Milliseconds();
ADDRLP4 1048
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 1044
ADDRLP4 1048
INDIRI4
ASGNI4
line 923
;922:
;923:	handle = trap_PC_LoadSource( menuFile );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1052
ADDRGP4 trap_PC_LoadSource
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1052
INDIRI4
ASGNI4
line 924
;924:	if (!handle) {
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $619
line 925
;925:		trap_Error( va( S_COLOR_YELLOW "menu file not found: %s, using default\n", menuFile ) );
ADDRGP4 $621
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1056
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1056
INDIRP4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 926
;926:		handle = trap_PC_LoadSource( "ui/menus.txt" );
ADDRGP4 $622
ARGP4
ADDRLP4 1060
ADDRGP4 trap_PC_LoadSource
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1060
INDIRI4
ASGNI4
line 927
;927:		if (!handle) {
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $623
line 928
;928:			trap_Error( va( S_COLOR_RED "default menu file not found: ui/menus.txt, unable to continue!\n", menuFile ) );
ADDRGP4 $625
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1064
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1064
INDIRP4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 929
;929:		}
LABELV $623
line 930
;930:	}
LABELV $619
line 932
;931:
;932:	ui_new.integer = 1;
ADDRGP4 ui_new+12
CNSTI4 1
ASGNI4
line 934
;933:
;934:	if (reset) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $630
line 935
;935:		Menu_Reset();
ADDRGP4 Menu_Reset
CALLV
pop
line 936
;936:	}
ADDRGP4 $630
JUMPV
LABELV $629
line 938
;937:
;938:	while ( 1 ) {
line 939
;939:		if (!trap_PC_ReadToken(handle, &token))
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1056
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $632
line 940
;940:			break;
ADDRGP4 $631
JUMPV
LABELV $632
line 941
;941:		if( token.string[0] == 0 || token.string[0] == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $638
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $634
LABELV $638
line 942
;942:			break;
ADDRGP4 $631
JUMPV
LABELV $634
line 945
;943:		}
;944:
;945:		if ( token.string[0] == '}' ) {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $639
line 946
;946:			break;
ADDRGP4 $631
JUMPV
LABELV $639
line 949
;947:		}
;948:
;949:		if (Q_stricmp(token.string, "loadmenu") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $645
ARGP4
ADDRLP4 1060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $642
line 950
;950:			if (Load_Menu(handle)) {
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 1064
ADDRGP4 Load_Menu
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
EQI4 $631
line 951
;951:				continue;
line 952
;952:			} else {
line 953
;953:				break;
LABELV $642
line 956
;954:			}
;955:		}
;956:	}
LABELV $630
line 938
ADDRGP4 $629
JUMPV
LABELV $631
line 958
;957:
;958:	Com_Printf("UI menu load time = %d milli seconds\n", trap_Milliseconds() - start);
ADDRLP4 1056
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRGP4 $648
ARGP4
ADDRLP4 1056
INDIRI4
ADDRLP4 1044
INDIRI4
SUBI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 960
;959:
;960:	trap_PC_FreeSource( handle );
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 trap_PC_FreeSource
CALLI4
pop
line 961
;961:}
LABELV $618
endproc UI_LoadMenus 1068 8
export UI_Load
proc UI_Load 1048 8
line 963
;962:
;963:void UI_Load() {
line 965
;964:	char lastName[1024];
;965:  menuDef_t *menu = Menu_GetFocused();
ADDRLP4 1032
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 1032
INDIRP4
ASGNP4
line 966
;966:	char *menuSet = UI_Cvar_VariableString("ui_menuFiles");
ADDRGP4 $650
ARGP4
ADDRLP4 1036
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1036
INDIRP4
ASGNP4
line 967
;967:	if (menu && menu->window.name) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $651
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $651
line 968
;968:		strcpy(lastName, menu->window.name);
ADDRLP4 8
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 969
;969:	}
LABELV $651
line 970
;970:	if (menuSet == NULL || menuSet[0] == '\0') {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $655
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $653
LABELV $655
line 971
;971:		menuSet = "ui/menus.txt";
ADDRLP4 0
ADDRGP4 $622
ASGNP4
line 972
;972:	}
LABELV $653
line 974
;973:
;974:	String_Init();
ADDRGP4 String_Init
CALLV
pop
line 979
;975:
;976:#ifdef PRE_RELEASE_TADEMO
;977:	UI_ParseGameInfo("demogameinfo.txt");
;978:#else
;979:	UI_ParseGameInfo("gameinfo.txt");
ADDRGP4 $656
ARGP4
ADDRGP4 UI_ParseGameInfo
CALLV
pop
line 980
;980:	UI_LoadArenas();
ADDRGP4 UI_LoadArenas
CALLV
pop
line 983
;981:#endif
;982:
;983:	UI_LoadMenus(menuSet, qtrue);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 UI_LoadMenus
CALLV
pop
line 984
;984:	Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 985
;985:	Menus_ActivateByName(lastName);
ADDRLP4 8
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 987
;986:
;987:}
LABELV $649
endproc UI_Load 1048 8
data
align 4
LABELV handicapValues
address $657
address $658
address $659
address $660
address $661
address $662
address $663
address $664
address $665
address $666
address $667
address $668
address $669
address $670
address $671
address $672
address $673
address $674
address $675
address $676
byte 4 0
code
proc UI_DrawHandicap 20 32
line 994
;988:
;989:static const char *handicapValues[] = {"None","95","90","85","80","75","70","65","60","55","50","45","40","35","30","25","20","15","10","5",NULL};
;990:#ifndef MISSIONPACK // bk001206
;991:static int numHandicaps = sizeof(handicapValues) / sizeof(const char*);
;992:#endif
;993:
;994:static void UI_DrawHandicap(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 997
;995:  int i, h;
;996:
;997:  h = Com_Clamp( 5, 100, trap_Cvar_VariableValue("handicap") );
ADDRGP4 $678
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1084227584
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 998
;998:  i = 20 - h / 5;
ADDRLP4 0
CNSTI4 20
ADDRLP4 4
INDIRI4
CNSTI4 5
DIVI4
SUBI4
ASGNI4
line 1000
;999:
;1000:  Text_Paint(rect->x, rect->y, scale, color, handicapValues[i], 0, 0, textStyle);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 handicapValues
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1001
;1001:}
LABELV $677
endproc UI_DrawHandicap 20 32
proc UI_DrawClanName 8 32
line 1003
;1002:
;1003:static void UI_DrawClanName(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1004
;1004:  Text_Paint(rect->x, rect->y, scale, color, UI_Cvar_VariableString("ui_teamName"), 0, 0, textStyle);
ADDRGP4 $680
ARGP4
ADDRLP4 0
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1005
;1005:}
LABELV $679
endproc UI_DrawClanName 8 32
proc UI_SetCapFragLimits 16 8
line 1008
;1006:
;1007:
;1008:static void UI_SetCapFragLimits(qboolean uiVars) {
line 1009
;1009:	int cap = 5;
ADDRLP4 0
CNSTI4 5
ASGNI4
line 1010
;1010:	int frag = 10;
ADDRLP4 4
CNSTI4 10
ASGNI4
line 1011
;1011:	if (uiInfo.gameTypes[ui_gameType.integer].gtEnum == GT_OBELISK) {
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592+4
ADDP4
INDIRI4
CNSTI4 6
NEI4 $682
line 1012
;1012:		cap = 4;
ADDRLP4 0
CNSTI4 4
ASGNI4
line 1013
;1013:	} else if (uiInfo.gameTypes[ui_gameType.integer].gtEnum == GT_HARVESTER) {
ADDRGP4 $683
JUMPV
LABELV $682
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592+4
ADDP4
INDIRI4
CNSTI4 7
NEI4 $687
line 1014
;1014:		cap = 15;
ADDRLP4 0
CNSTI4 15
ASGNI4
line 1015
;1015:	}
LABELV $687
LABELV $683
line 1016
;1016:	if (uiVars) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $692
line 1017
;1017:		trap_Cvar_Set("ui_captureLimit", va("%d", cap));
ADDRGP4 $695
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $694
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1018
;1018:		trap_Cvar_Set("ui_fragLimit", va("%d", frag));
ADDRGP4 $695
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $696
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1019
;1019:	} else {
ADDRGP4 $693
JUMPV
LABELV $692
line 1020
;1020:		trap_Cvar_Set("capturelimit", va("%d", cap));
ADDRGP4 $695
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $697
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1021
;1021:		trap_Cvar_Set("fraglimit", va("%d", frag));
ADDRGP4 $695
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $698
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1022
;1022:	}
LABELV $693
line 1023
;1023:}
LABELV $681
endproc UI_SetCapFragLimits 16 8
proc UI_DrawGameType 4 32
line 1025
;1024:// ui_gameType assumes gametype 0 is -1 ALL and will not show
;1025:static void UI_DrawGameType(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1026
;1026:  Text_Paint(rect->x, rect->y, scale, color, uiInfo.gameTypes[ui_gameType.integer].gameType, 0, 0, textStyle);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1027
;1027:}
LABELV $699
endproc UI_DrawGameType 4 32
proc UI_DrawNetGameType 4 32
line 1029
;1028:
;1029:static void UI_DrawNetGameType(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1030
;1030:	if (ui_netGameType.integer < 0 || ui_netGameType.integer > uiInfo.numGameTypes) {
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 0
LTI4 $708
ADDRGP4 ui_netGameType+12
INDIRI4
ADDRGP4 uiInfo+78588
INDIRI4
LEI4 $703
LABELV $708
line 1031
;1031:		trap_Cvar_Set("ui_netGameType", "0");
ADDRGP4 $709
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1032
;1032:		trap_Cvar_Set("ui_actualNetGameType", "0");
ADDRGP4 $710
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1033
;1033:	}
LABELV $703
line 1034
;1034:  Text_Paint(rect->x, rect->y, scale, color, uiInfo.gameTypes[ui_netGameType.integer].gameType , 0, 0, textStyle);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1035
;1035:}
LABELV $702
endproc UI_DrawNetGameType 4 32
proc UI_DrawJoinGameType 4 32
line 1037
;1036:
;1037:static void UI_DrawJoinGameType(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1038
;1038:	if (ui_joinGameType.integer < 0 || ui_joinGameType.integer > uiInfo.numJoinGameTypes) {
ADDRGP4 ui_joinGameType+12
INDIRI4
CNSTI4 0
LTI4 $719
ADDRGP4 ui_joinGameType+12
INDIRI4
ADDRGP4 uiInfo+78720
INDIRI4
LEI4 $714
LABELV $719
line 1039
;1039:		trap_Cvar_Set("ui_joinGameType", "0");
ADDRGP4 $720
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1040
;1040:	}
LABELV $714
line 1041
;1041:  Text_Paint(rect->x, rect->y, scale, color, uiInfo.joinGameTypes[ui_joinGameType.integer].gameType , 0, 0, textStyle);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 ui_joinGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78724
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1042
;1042:}
LABELV $713
endproc UI_DrawJoinGameType 4 32
proc UI_TeamIndexFromName 12 8
line 1046
;1043:
;1044:
;1045:
;1046:static int UI_TeamIndexFromName(const char *name) {
line 1049
;1047:  int i;
;1048:
;1049:  if (name && *name) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $724
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $724
line 1050
;1050:    for (i = 0; i < uiInfo.teamCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $729
JUMPV
LABELV $726
line 1051
;1051:      if (Q_stricmp(name, uiInfo.teamList[i].teamName) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $731
line 1052
;1052:        return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $723
JUMPV
LABELV $731
line 1054
;1053:      }
;1054:    }
LABELV $727
line 1050
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $729
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+75768
INDIRI4
LTI4 $726
line 1055
;1055:  } 
LABELV $724
line 1057
;1056:
;1057:  return 0;
CNSTI4 0
RETI4
LABELV $723
endproc UI_TeamIndexFromName 12 8
proc UI_DrawClanLogo 48 20
line 1061
;1058:
;1059:}
;1060:
;1061:static void UI_DrawClanLogo(rectDef_t *rect, float scale, vec4_t color) {
line 1063
;1062:  int i;
;1063:  i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1064
;1064:  if (i >= 0 && i < uiInfo.teamCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $735
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+75768
INDIRI4
GEI4 $735
line 1065
;1065:  	trap_R_SetColor( color );
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1067
;1066:
;1067:		if (uiInfo.teamList[i].teamIcon == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+28
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $738
line 1068
;1068:      uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+28
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 1069
;1069:      uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal",uiInfo.teamList[i].imageName));
ADDRGP4 $748
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+32
ADDP4
ADDRLP4 32
INDIRI4
ASGNI4
line 1070
;1070:      uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $753
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+36
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 1071
;1071:		}
LABELV $738
line 1073
;1072:
;1073:  	UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+28
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1074
;1074:    trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1075
;1075:  }
LABELV $735
line 1076
;1076:}
LABELV $734
endproc UI_DrawClanLogo 48 20
proc UI_DrawClanCinematic 28 24
line 1078
;1077:
;1078:static void UI_DrawClanCinematic(rectDef_t *rect, float scale, vec4_t color) {
line 1080
;1079:  int i;
;1080:  i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1081
;1081:  if (i >= 0 && i < uiInfo.teamCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $759
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+75768
INDIRI4
GEI4 $759
line 1083
;1082:
;1083:		if (uiInfo.teamList[i].cinematic >= -2) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+40
ADDP4
INDIRI4
CNSTI4 -2
LTI4 $762
line 1084
;1084:			if (uiInfo.teamList[i].cinematic == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+40
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $766
line 1085
;1085:				uiInfo.teamList[i].cinematic = trap_CIN_PlayCinematic(va("%s.roq", uiInfo.teamList[i].imageName), 0, 0, 0, 0, (CIN_loop | CIN_silent) );
ADDRGP4 $772
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 24
ADDRGP4 trap_CIN_PlayCinematic
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+40
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 1086
;1086:			}
LABELV $766
line 1087
;1087:			if (uiInfo.teamList[i].cinematic >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+40
ADDP4
INDIRI4
CNSTI4 0
LTI4 $775
line 1088
;1088:			  trap_CIN_RunCinematic(uiInfo.teamList[i].cinematic);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+40
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_RunCinematic
CALLI4
pop
line 1089
;1089:				trap_CIN_SetExtents(uiInfo.teamList[i].cinematic, rect->x, rect->y, rect->w, rect->h);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+40
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 trap_CIN_SetExtents
CALLV
pop
line 1090
;1090:	 			trap_CIN_DrawCinematic(uiInfo.teamList[i].cinematic);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+40
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_DrawCinematic
CALLV
pop
line 1091
;1091:			} else {
ADDRGP4 $763
JUMPV
LABELV $775
line 1092
;1092:			  	trap_R_SetColor( color );
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1093
;1093:				UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon_Metal);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+32
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1094
;1094:				trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1095
;1095:				uiInfo.teamList[i].cinematic = -2;
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+40
ADDP4
CNSTI4 -2
ASGNI4
line 1096
;1096:			}
line 1097
;1097:		} else {
ADDRGP4 $763
JUMPV
LABELV $762
line 1098
;1098:	  	trap_R_SetColor( color );
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1099
;1099:			UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+28
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1100
;1100:			trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1101
;1101:		}
LABELV $763
line 1102
;1102:	}
LABELV $759
line 1104
;1103:
;1104:}
LABELV $758
endproc UI_DrawClanCinematic 28 24
proc UI_DrawPreviewCinematic 12 24
line 1106
;1105:
;1106:static void UI_DrawPreviewCinematic(rectDef_t *rect, float scale, vec4_t color) {
line 1107
;1107:	if (uiInfo.previewMovie > -2) {
ADDRGP4 uiInfo+99272
INDIRI4
CNSTI4 -2
LEI4 $792
line 1108
;1108:		uiInfo.previewMovie = trap_CIN_PlayCinematic(va("%s.roq", uiInfo.movieList[uiInfo.movieIndex]), 0, 0, 0, 0, (CIN_loop | CIN_silent) );
ADDRGP4 $772
ARGP4
ADDRGP4 uiInfo+99268
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+98240
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 4
ADDRGP4 trap_CIN_PlayCinematic
CALLI4
ASGNI4
ADDRGP4 uiInfo+99272
ADDRLP4 4
INDIRI4
ASGNI4
line 1109
;1109:		if (uiInfo.previewMovie >= 0) {
ADDRGP4 uiInfo+99272
INDIRI4
CNSTI4 0
LTI4 $798
line 1110
;1110:		  trap_CIN_RunCinematic(uiInfo.previewMovie);
ADDRGP4 uiInfo+99272
INDIRI4
ARGI4
ADDRGP4 trap_CIN_RunCinematic
CALLI4
pop
line 1111
;1111:			trap_CIN_SetExtents(uiInfo.previewMovie, rect->x, rect->y, rect->w, rect->h);
ADDRGP4 uiInfo+99272
INDIRI4
ARGI4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 trap_CIN_SetExtents
CALLV
pop
line 1112
;1112: 			trap_CIN_DrawCinematic(uiInfo.previewMovie);
ADDRGP4 uiInfo+99272
INDIRI4
ARGI4
ADDRGP4 trap_CIN_DrawCinematic
CALLV
pop
line 1113
;1113:		} else {
ADDRGP4 $799
JUMPV
LABELV $798
line 1114
;1114:			uiInfo.previewMovie = -2;
ADDRGP4 uiInfo+99272
CNSTI4 -2
ASGNI4
line 1115
;1115:		}
LABELV $799
line 1116
;1116:	} 
LABELV $792
line 1118
;1117:
;1118:}
LABELV $791
endproc UI_DrawPreviewCinematic 12 24
proc UI_DrawSkill 16 32
line 1122
;1119:
;1120:
;1121:
;1122:static void UI_DrawSkill(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1124
;1123:  int i;
;1124:	i = trap_Cvar_VariableValue( "g_spSkill" );
ADDRGP4 $806
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 1125
;1125:  if (i < 1 || i > numSkillLevels) {
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $809
ADDRLP4 0
INDIRI4
ADDRGP4 numSkillLevels
INDIRI4
LEI4 $807
LABELV $809
line 1126
;1126:    i = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1127
;1127:  }
LABELV $807
line 1128
;1128:  Text_Paint(rect->x, rect->y, scale, color, skillLevels[i-1],0, 0, textStyle);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 skillLevels-4
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1129
;1129:}
LABELV $805
endproc UI_DrawSkill 16 32
proc UI_DrawTeamName 32 32
line 1132
;1130:
;1131:
;1132:static void UI_DrawTeamName(rectDef_t *rect, float scale, vec4_t color, qboolean blue, int textStyle) {
line 1134
;1133:  int i;
;1134:  i = UI_TeamIndexFromName(UI_Cvar_VariableString((blue) ? "ui_blueTeam" : "ui_redTeam"));
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $815
ADDRLP4 4
ADDRGP4 $812
ASGNP4
ADDRGP4 $816
JUMPV
LABELV $815
ADDRLP4 4
ADDRGP4 $813
ASGNP4
LABELV $816
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 1135
;1135:  if (i >= 0 && i < uiInfo.teamCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $817
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+75768
INDIRI4
GEI4 $817
line 1136
;1136:    Text_Paint(rect->x, rect->y, scale, color, va("%s: %s", (blue) ? "Blue" : "Red", uiInfo.teamList[i].teamName),0, 0, textStyle);
ADDRGP4 $820
ARGP4
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $825
ADDRLP4 20
ADDRGP4 $821
ASGNP4
ADDRGP4 $826
JUMPV
LABELV $825
ADDRLP4 20
ADDRGP4 $822
ASGNP4
LABELV $826
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1137
;1137:  }
LABELV $817
line 1138
;1138:}
LABELV $811
endproc UI_DrawTeamName 32 32
proc UI_DrawTeamMember 28 32
line 1140
;1139:
;1140:static void UI_DrawTeamMember(rectDef_t *rect, float scale, vec4_t color, qboolean blue, int num, int textStyle) {
line 1144
;1141:	// 0 - None
;1142:	// 1 - Human
;1143:	// 2..NumCharacters - Bot
;1144:	int value = trap_Cvar_VariableValue(va(blue ? "ui_blueteam%i" : "ui_redteam%i", num));
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $831
ADDRLP4 8
ADDRGP4 $828
ASGNP4
ADDRGP4 $832
JUMPV
LABELV $831
ADDRLP4 8
ADDRGP4 $829
ASGNP4
LABELV $832
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
CVFI4 4
ASGNI4
line 1146
;1145:	const char *text;
;1146:	if (value <= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $833
line 1147
;1147:		text = "Closed";
ADDRLP4 4
ADDRGP4 $835
ASGNP4
line 1148
;1148:	} else if (value == 1) {
ADDRGP4 $834
JUMPV
LABELV $833
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $836
line 1149
;1149:		text = "Human";
ADDRLP4 4
ADDRGP4 $838
ASGNP4
line 1150
;1150:	} else {
ADDRGP4 $837
JUMPV
LABELV $836
line 1151
;1151:		value -= 2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 1153
;1152:
;1153:		if (ui_actualNetGameType.integer >= GT_TEAM) {
ADDRGP4 ui_actualNetGameType+12
INDIRI4
CNSTI4 3
LTI4 $839
line 1154
;1154:			if (value >= uiInfo.characterCount) {
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+73452
INDIRI4
LTI4 $842
line 1155
;1155:				value = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1156
;1156:			}
LABELV $842
line 1157
;1157:			text = uiInfo.characterList[value].name;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460
ADDP4
INDIRP4
ASGNP4
line 1158
;1158:		} else {
ADDRGP4 $840
JUMPV
LABELV $839
line 1159
;1159:			if (value >= UI_GetNumBots()) {
ADDRLP4 20
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 20
INDIRI4
LTI4 $846
line 1160
;1160:				value = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1161
;1161:			}
LABELV $846
line 1162
;1162:			text = UI_GetBotNameByNumber(value);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 UI_GetBotNameByNumber
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
line 1163
;1163:		}
LABELV $840
line 1164
;1164:	}
LABELV $837
LABELV $834
line 1165
;1165:  Text_Paint(rect->x, rect->y, scale, color, text, 0, 0, textStyle);
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 20
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1166
;1166:}
LABELV $827
endproc UI_DrawTeamMember 28 32
proc UI_DrawEffects 28 20
line 1168
;1167:
;1168:static void UI_DrawEffects(rectDef_t *rect, float scale, vec4_t color) {
line 1170
;1169:	vec4_t colors;
;1170:	int c = uiInfo.effectsColor;
ADDRLP4 16
ADDRGP4 uiInfo+136916
INDIRI4
ASGNI4
line 1171
;1171:	UI_DrawHandlePic( rect->x, rect->y - 14, 128, 8, uiInfo.uiDC.Assets.fxBasePic );
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1096810496
SUBF4
ARGF4
CNSTF4 1124073472
ARGF4
CNSTF4 1090519040
ARGF4
ADDRGP4 uiInfo+228+61768
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1174
;1172:
;1173:	//c = item->curvalue + 1;
;1174:	colors[0] = (c >> 0) & 1;
ADDRLP4 0
ADDRLP4 16
INDIRI4
CNSTI4 1
BANDI4
CVIF4 4
ASGNF4
line 1175
;1175:	colors[1] = (c >> 1) & 1;
ADDRLP4 0+4
ADDRLP4 16
INDIRI4
CNSTI4 1
RSHI4
CNSTI4 1
BANDI4
CVIF4 4
ASGNF4
line 1176
;1176:	colors[2] = (c >> 2) & 1;
ADDRLP4 0+8
ADDRLP4 16
INDIRI4
CNSTI4 2
RSHI4
CNSTI4 1
BANDI4
CVIF4 4
ASGNF4
line 1177
;1177:	colors[3] = 1.0;
ADDRLP4 0+12
CNSTF4 1065353216
ASGNF4
line 1178
;1178:	UI_SetColor( colors );
ADDRLP4 0
ARGP4
ADDRGP4 UI_SetColor
CALLV
pop
line 1179
;1179:	UI_DrawHandlePic( rect->x + uiInfo.effectsColor * 16 + 8, rect->y - 16, 16, 12, uiInfo.uiDC.Assets.fxPic );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRGP4 uiInfo+136916
INDIRI4
CNSTI4 4
LSHI4
CVIF4 4
ADDF4
CNSTF4 1090519040
ADDF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
ARGF4
CNSTF4 1098907648
ARGF4
CNSTF4 1094713344
ARGF4
ADDRGP4 uiInfo+228+61772
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1180
;1180:	UI_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 UI_SetColor
CALLV
pop
line 1181
;1181:}
LABELV $848
endproc UI_DrawEffects 28 20
proc UI_DrawMapPreview 20 20
line 1183
;1182:
;1183:static void UI_DrawMapPreview(rectDef_t *rect, float scale, vec4_t color, qboolean net) {
line 1184
;1184:	int map = (net) ? ui_currentNetMap.integer : ui_currentMap.integer;
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $862
ADDRLP4 4
ADDRGP4 ui_currentNetMap+12
INDIRI4
ASGNI4
ADDRGP4 $863
JUMPV
LABELV $862
ADDRLP4 4
ADDRGP4 ui_currentMap+12
INDIRI4
ASGNI4
LABELV $863
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1185
;1185:	if (map < 0 || map > uiInfo.mapCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $867
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+83236
INDIRI4
LEI4 $864
LABELV $867
line 1186
;1186:		if (net) {
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $868
line 1187
;1187:			ui_currentNetMap.integer = 0;
ADDRGP4 ui_currentNetMap+12
CNSTI4 0
ASGNI4
line 1188
;1188:			trap_Cvar_Set("ui_currentNetMap", "0");
ADDRGP4 $871
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1189
;1189:		} else {
ADDRGP4 $869
JUMPV
LABELV $868
line 1190
;1190:			ui_currentMap.integer = 0;
ADDRGP4 ui_currentMap+12
CNSTI4 0
ASGNI4
line 1191
;1191:			trap_Cvar_Set("ui_currentMap", "0");
ADDRGP4 $873
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1192
;1192:		}
LABELV $869
line 1193
;1193:		map = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1194
;1194:	}
LABELV $864
line 1196
;1195:
;1196:	if (uiInfo.mapList[map].levelShot == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+92
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $874
line 1197
;1197:		uiInfo.mapList[map].levelShot = trap_R_RegisterShaderNoMip(uiInfo.mapList[map].imageName);
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+8
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+92
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1198
;1198:	}
LABELV $874
line 1200
;1199:
;1200:	if (uiInfo.mapList[map].levelShot > 0) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+92
ADDP4
INDIRI4
CNSTI4 0
LEI4 $882
line 1201
;1201:		UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.mapList[map].levelShot);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+92
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1202
;1202:	} else {
ADDRGP4 $883
JUMPV
LABELV $882
line 1203
;1203:		UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, trap_R_RegisterShaderNoMip("menu/art/unknownmap"));
ADDRGP4 $888
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1204
;1204:	}
LABELV $883
line 1205
;1205:}						 
LABELV $858
endproc UI_DrawMapPreview 20 20
proc UI_DrawMapTimeToBeat 20 32
line 1208
;1206:
;1207:
;1208:static void UI_DrawMapTimeToBeat(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1210
;1209:	int minutes, seconds, time;
;1210:	if (ui_currentMap.integer < 0 || ui_currentMap.integer > uiInfo.mapCount) {
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 0
LTI4 $895
ADDRGP4 ui_currentMap+12
INDIRI4
ADDRGP4 uiInfo+83236
INDIRI4
LEI4 $890
LABELV $895
line 1211
;1211:		ui_currentMap.integer = 0;
ADDRGP4 ui_currentMap+12
CNSTI4 0
ASGNI4
line 1212
;1212:		trap_Cvar_Set("ui_currentMap", "0");
ADDRGP4 $873
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1213
;1213:	}
LABELV $890
line 1215
;1214:
;1215:	time = uiInfo.mapList[ui_currentMap.integer].timeToBeat[uiInfo.gameTypes[ui_gameType.integer].gtEnum];
ADDRLP4 0
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592+4
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+28
ADDP4
ADDP4
INDIRI4
ASGNI4
line 1217
;1216:
;1217:	minutes = time / 60;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 60
DIVI4
ASGNI4
line 1218
;1218:	seconds = time % 60;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 60
MODI4
ASGNI4
line 1220
;1219:
;1220:  Text_Paint(rect->x, rect->y, scale, color, va("%02i:%02i", minutes, seconds), 0, 0, textStyle);
ADDRGP4 $903
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1221
;1221:}
LABELV $889
endproc UI_DrawMapTimeToBeat 20 32
proc UI_DrawMapCinematic 24 24
line 1225
;1222:
;1223:
;1224:
;1225:static void UI_DrawMapCinematic(rectDef_t *rect, float scale, vec4_t color, qboolean net) {
line 1227
;1226:
;1227:	int map = (net) ? ui_currentNetMap.integer : ui_currentMap.integer; 
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $908
ADDRLP4 4
ADDRGP4 ui_currentNetMap+12
INDIRI4
ASGNI4
ADDRGP4 $909
JUMPV
LABELV $908
ADDRLP4 4
ADDRGP4 ui_currentMap+12
INDIRI4
ASGNI4
LABELV $909
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1228
;1228:	if (map < 0 || map > uiInfo.mapCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $913
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+83236
INDIRI4
LEI4 $910
LABELV $913
line 1229
;1229:		if (net) {
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $914
line 1230
;1230:			ui_currentNetMap.integer = 0;
ADDRGP4 ui_currentNetMap+12
CNSTI4 0
ASGNI4
line 1231
;1231:			trap_Cvar_Set("ui_currentNetMap", "0");
ADDRGP4 $871
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1232
;1232:		} else {
ADDRGP4 $915
JUMPV
LABELV $914
line 1233
;1233:			ui_currentMap.integer = 0;
ADDRGP4 ui_currentMap+12
CNSTI4 0
ASGNI4
line 1234
;1234:			trap_Cvar_Set("ui_currentMap", "0");
ADDRGP4 $873
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1235
;1235:		}
LABELV $915
line 1236
;1236:		map = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1237
;1237:	}
LABELV $910
line 1239
;1238:
;1239:	if (uiInfo.mapList[map].cinematic >= -1) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+24
ADDP4
INDIRI4
CNSTI4 -1
LTI4 $918
line 1240
;1240:		if (uiInfo.mapList[map].cinematic == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+24
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $922
line 1241
;1241:			uiInfo.mapList[map].cinematic = trap_CIN_PlayCinematic(va("%s.roq", uiInfo.mapList[map].mapLoadName), 0, 0, 0, 0, (CIN_loop | CIN_silent) );
ADDRGP4 $772
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 20
ADDRGP4 trap_CIN_PlayCinematic
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+24
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 1242
;1242:		}
LABELV $922
line 1243
;1243:		if (uiInfo.mapList[map].cinematic >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+24
ADDP4
INDIRI4
CNSTI4 0
LTI4 $930
line 1244
;1244:		  trap_CIN_RunCinematic(uiInfo.mapList[map].cinematic);
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+24
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_RunCinematic
CALLI4
pop
line 1245
;1245:		  trap_CIN_SetExtents(uiInfo.mapList[map].cinematic, rect->x, rect->y, rect->w, rect->h);
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+24
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 trap_CIN_SetExtents
CALLV
pop
line 1246
;1246: 			trap_CIN_DrawCinematic(uiInfo.mapList[map].cinematic);
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+24
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_DrawCinematic
CALLV
pop
line 1247
;1247:		} else {
ADDRGP4 $919
JUMPV
LABELV $930
line 1248
;1248:			uiInfo.mapList[map].cinematic = -2;
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+24
ADDP4
CNSTI4 -2
ASGNI4
line 1249
;1249:		}
line 1250
;1250:	} else {
ADDRGP4 $919
JUMPV
LABELV $918
line 1251
;1251:		UI_DrawMapPreview(rect, scale, color, net);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 UI_DrawMapPreview
CALLV
pop
line 1252
;1252:	}
LABELV $919
line 1253
;1253:}
LABELV $904
endproc UI_DrawMapCinematic 24 24
data
align 4
LABELV updateModel
byte 4 1
align 4
LABELV q3Model
byte 4 0
bss
align 4
LABELV $943
skip 1276
code
proc UI_DrawPlayerModel 616 28
line 1260
;1254:
;1255:
;1256:
;1257:static qboolean updateModel = qtrue;
;1258:static qboolean q3Model = qfalse;
;1259:
;1260:static void UI_DrawPlayerModel(rectDef_t *rect) {
line 1268
;1261:  static playerInfo_t info;
;1262:  char model[MAX_QPATH];
;1263:  char team[256];
;1264:	char head[256];
;1265:	vec3_t	viewangles;
;1266:	vec3_t	moveangles;
;1267:
;1268:	  if (trap_Cvar_VariableValue("ui_Q3Model")) {
ADDRGP4 $946
ARGP4
ADDRLP4 600
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 600
INDIRF4
CNSTF4 0
EQF4 $944
line 1269
;1269:	  strcpy(model, UI_Cvar_VariableString("model"));
ADDRGP4 $947
ARGP4
ADDRLP4 604
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 12
ARGP4
ADDRLP4 604
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1270
;1270:		strcpy(head, UI_Cvar_VariableString("headmodel"));
ADDRGP4 $948
ARGP4
ADDRLP4 608
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 332
ARGP4
ADDRLP4 608
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1271
;1271:		if (!q3Model) {
ADDRGP4 q3Model
INDIRI4
CNSTI4 0
NEI4 $949
line 1272
;1272:			q3Model = qtrue;
ADDRGP4 q3Model
CNSTI4 1
ASGNI4
line 1273
;1273:			updateModel = qtrue;
ADDRGP4 updateModel
CNSTI4 1
ASGNI4
line 1274
;1274:		}
LABELV $949
line 1275
;1275:		team[0] = '\0';
ADDRLP4 76
CNSTI1 0
ASGNI1
line 1276
;1276:	} else {
ADDRGP4 $945
JUMPV
LABELV $944
line 1278
;1277:
;1278:		strcpy(team, UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 604
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 76
ARGP4
ADDRLP4 604
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1279
;1279:		strcpy(model, UI_Cvar_VariableString("team_model"));
ADDRGP4 $951
ARGP4
ADDRLP4 608
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 12
ARGP4
ADDRLP4 608
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1280
;1280:		strcpy(head, UI_Cvar_VariableString("team_headmodel"));
ADDRGP4 $952
ARGP4
ADDRLP4 612
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 332
ARGP4
ADDRLP4 612
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1281
;1281:		if (q3Model) {
ADDRGP4 q3Model
INDIRI4
CNSTI4 0
EQI4 $953
line 1282
;1282:			q3Model = qfalse;
ADDRGP4 q3Model
CNSTI4 0
ASGNI4
line 1283
;1283:			updateModel = qtrue;
ADDRGP4 updateModel
CNSTI4 1
ASGNI4
line 1284
;1284:		}
LABELV $953
line 1285
;1285:	}
LABELV $945
line 1286
;1286:  if (updateModel) {
ADDRGP4 updateModel
INDIRI4
CNSTI4 0
EQI4 $955
line 1287
;1287:  	memset( &info, 0, sizeof(playerInfo_t) );
ADDRGP4 $943
ARGP4
CNSTI4 0
ARGI4
CNSTU4 1276
ARGU4
ADDRGP4 memset
CALLP4
pop
line 1288
;1288:  	viewangles[YAW]   = 180 - 10;
ADDRLP4 0+4
CNSTF4 1126825984
ASGNF4
line 1289
;1289:  	viewangles[PITCH] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1290
;1290:  	viewangles[ROLL]  = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 1291
;1291:  	VectorClear( moveangles );
ADDRLP4 588
CNSTF4 0
ASGNF4
ADDRLP4 588+4
CNSTF4 0
ASGNF4
ADDRLP4 588+8
CNSTF4 0
ASGNF4
line 1292
;1292:    UI_PlayerInfo_SetModel( &info, model, head, team);
ADDRGP4 $943
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 332
ARGP4
ADDRLP4 76
ARGP4
ADDRGP4 UI_PlayerInfo_SetModel
CALLV
pop
line 1293
;1293:    UI_PlayerInfo_SetInfo( &info, LEGS_IDLE, TORSO_STAND, viewangles, vec3_origin, WP_MACHINEGUN, qfalse );
ADDRGP4 $943
ARGP4
CNSTI4 22
ARGI4
CNSTI4 11
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 vec3_origin
ARGP4
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_PlayerInfo_SetInfo
CALLV
pop
line 1295
;1294://		UI_RegisterClientModelname( &info, model, head, team);
;1295:    updateModel = qfalse;
ADDRGP4 updateModel
CNSTI4 0
ASGNI4
line 1296
;1296:  }
LABELV $955
line 1298
;1297:
;1298:  UI_DrawPlayer( rect->x, rect->y, rect->w, rect->h, &info, uiInfo.uiDC.realTime / 2);
ADDRLP4 604
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 604
INDIRP4
INDIRF4
ARGF4
ADDRLP4 604
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 604
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 604
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRGP4 $943
ARGP4
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 2
DIVI4
ARGI4
ADDRGP4 UI_DrawPlayer
CALLV
pop
line 1300
;1299:
;1300:}
LABELV $942
endproc UI_DrawPlayerModel 616 28
proc UI_DrawNetSource 8 32
line 1302
;1301:
;1302:static void UI_DrawNetSource(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1303
;1303:	if (ui_netSource.integer < 0 || ui_netSource.integer > numNetSources) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
LTI4 $967
ADDRGP4 ui_netSource+12
INDIRI4
ADDRGP4 numNetSources
INDIRI4
LEI4 $963
LABELV $967
line 1304
;1304:		ui_netSource.integer = 0;
ADDRGP4 ui_netSource+12
CNSTI4 0
ASGNI4
line 1305
;1305:	}
LABELV $963
line 1306
;1306:  Text_Paint(rect->x, rect->y, scale, color, va("Source: %s", netSources[ui_netSource.integer]), 0, 0, textStyle);
ADDRGP4 $969
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 netSources
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1307
;1307:}
LABELV $962
endproc UI_DrawNetSource 8 32
proc UI_DrawNetMapPreview 8 20
line 1309
;1308:
;1309:static void UI_DrawNetMapPreview(rectDef_t *rect, float scale, vec4_t color) {
line 1311
;1310:
;1311:	if (uiInfo.serverStatus.currentServerPreview > 0) {
ADDRGP4 uiInfo+99276+10428
INDIRI4
CNSTI4 0
LEI4 $972
line 1312
;1312:		UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.serverStatus.currentServerPreview);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRGP4 uiInfo+99276+10428
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1313
;1313:	} else {
ADDRGP4 $973
JUMPV
LABELV $972
line 1314
;1314:		UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, trap_R_RegisterShaderNoMip("menu/art/unknownmap"));
ADDRGP4 $888
ARGP4
ADDRLP4 0
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1315
;1315:	}
LABELV $973
line 1316
;1316:}
LABELV $971
endproc UI_DrawNetMapPreview 8 20
proc UI_DrawNetMapCinematic 4 20
line 1318
;1317:
;1318:static void UI_DrawNetMapCinematic(rectDef_t *rect, float scale, vec4_t color) {
line 1319
;1319:	if (ui_currentNetMap.integer < 0 || ui_currentNetMap.integer > uiInfo.mapCount) {
ADDRGP4 ui_currentNetMap+12
INDIRI4
CNSTI4 0
LTI4 $984
ADDRGP4 ui_currentNetMap+12
INDIRI4
ADDRGP4 uiInfo+83236
INDIRI4
LEI4 $979
LABELV $984
line 1320
;1320:		ui_currentNetMap.integer = 0;
ADDRGP4 ui_currentNetMap+12
CNSTI4 0
ASGNI4
line 1321
;1321:		trap_Cvar_Set("ui_currentNetMap", "0");
ADDRGP4 $871
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1322
;1322:	}
LABELV $979
line 1324
;1323:
;1324:	if (uiInfo.serverStatus.currentServerCinematic >= 0) {
ADDRGP4 uiInfo+99276+10432
INDIRI4
CNSTI4 0
LTI4 $986
line 1325
;1325:	  trap_CIN_RunCinematic(uiInfo.serverStatus.currentServerCinematic);
ADDRGP4 uiInfo+99276+10432
INDIRI4
ARGI4
ADDRGP4 trap_CIN_RunCinematic
CALLI4
pop
line 1326
;1326:	  trap_CIN_SetExtents(uiInfo.serverStatus.currentServerCinematic, rect->x, rect->y, rect->w, rect->h);
ADDRGP4 uiInfo+99276+10432
INDIRI4
ARGI4
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 trap_CIN_SetExtents
CALLV
pop
line 1327
;1327: 	  trap_CIN_DrawCinematic(uiInfo.serverStatus.currentServerCinematic);
ADDRGP4 uiInfo+99276+10432
INDIRI4
ARGI4
ADDRGP4 trap_CIN_DrawCinematic
CALLV
pop
line 1328
;1328:	} else {
ADDRGP4 $987
JUMPV
LABELV $986
line 1329
;1329:		UI_DrawNetMapPreview(rect, scale, color);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 UI_DrawNetMapPreview
CALLV
pop
line 1330
;1330:	}
LABELV $987
line 1331
;1331:}
LABELV $978
endproc UI_DrawNetMapCinematic 4 20
proc UI_DrawNetFilter 8 32
line 1335
;1332:
;1333:
;1334:
;1335:static void UI_DrawNetFilter(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1339
;1336:	/*if (ui_serverFilterType.integer < 0 || ui_serverFilterType.integer > numServerFilters) {
;1337:		ui_serverFilterType.integer = 0;
;1338:	}*/
;1339:  Text_Paint(rect->x, rect->y, scale, color, va("Filter: %s", serverFilters[0/*ui_serverFilterType.integer*/].description), 0, 0, textStyle);
ADDRGP4 $997
ARGP4
ADDRGP4 serverFilters
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1340
;1340:}
LABELV $996
endproc UI_DrawNetFilter 8 32
proc UI_DrawTier 20 32
line 1343
;1341:
;1342:
;1343:static void UI_DrawTier(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1345
;1344:  int i;
;1345:	i = trap_Cvar_VariableValue( "ui_currentTier" );
ADDRGP4 $999
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 1346
;1346:  if (i < 0 || i >= uiInfo.tierCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1003
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+96040
INDIRI4
LTI4 $1000
LABELV $1003
line 1347
;1347:    i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1348
;1348:  }
LABELV $1000
line 1349
;1349:  Text_Paint(rect->x, rect->y, scale, color, va("Tier: %s", uiInfo.tierList[i].tierName),0, 0, textStyle);
ADDRGP4 $1004
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 uiInfo+96044
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1350
;1350:}
LABELV $998
endproc UI_DrawTier 20 32
proc UI_DrawTierMap 28 20
line 1352
;1351:
;1352:static void UI_DrawTierMap(rectDef_t *rect, int index) {
line 1354
;1353:  int i;
;1354:	i = trap_Cvar_VariableValue( "ui_currentTier" );
ADDRGP4 $999
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 1355
;1355:  if (i < 0 || i >= uiInfo.tierCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1010
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+96040
INDIRI4
LTI4 $1007
LABELV $1010
line 1356
;1356:    i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1357
;1357:  }
LABELV $1007
line 1359
;1358:
;1359:	if (uiInfo.tierList[i].mapHandles[index] == -1) {
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 uiInfo+96044+28
ADDP4
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1011
line 1360
;1360:		uiInfo.tierList[i].mapHandles[index] = trap_R_RegisterShaderNoMip(va("levelshots/%s", uiInfo.tierList[i].maps[index]));
ADDRGP4 $1017
ARGP4
ADDRLP4 12
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 uiInfo+96044+4
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 uiInfo+96044+28
ADDP4
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 1361
;1361:	}
LABELV $1011
line 1363
;1362:												 
;1363:	UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.tierList[i].mapHandles[index]);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 uiInfo+96044+28
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1364
;1364:}
LABELV $1006
endproc UI_DrawTierMap 28 20
proc UI_EnglishMapName 8 8
line 1366
;1365:
;1366:static const char *UI_EnglishMapName(const char *map) {
line 1368
;1367:	int i;
;1368:	for (i = 0; i < uiInfo.mapCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1026
JUMPV
LABELV $1023
line 1369
;1369:		if (Q_stricmp(map, uiInfo.mapList[i].mapLoadName) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1028
line 1370
;1370:			return uiInfo.mapList[i].mapName;
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240
ADDP4
INDIRP4
RETP4
ADDRGP4 $1022
JUMPV
LABELV $1028
line 1372
;1371:		}
;1372:	}
LABELV $1024
line 1368
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1026
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+83236
INDIRI4
LTI4 $1023
line 1373
;1373:	return "";
ADDRGP4 $110
RETP4
LABELV $1022
endproc UI_EnglishMapName 8 8
proc UI_DrawTierMapName 32 32
line 1376
;1374:}
;1375:
;1376:static void UI_DrawTierMapName(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1378
;1377:  int i, j;
;1378:	i = trap_Cvar_VariableValue( "ui_currentTier" );
ADDRGP4 $999
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
CVFI4 4
ASGNI4
line 1379
;1379:  if (i < 0 || i >= uiInfo.tierCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1037
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+96040
INDIRI4
LTI4 $1034
LABELV $1037
line 1380
;1380:    i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1381
;1381:  }
LABELV $1034
line 1382
;1382:	j = trap_Cvar_VariableValue("ui_currentMap");
ADDRGP4 $873
ARGP4
ADDRLP4 16
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 16
INDIRF4
CVFI4 4
ASGNI4
line 1383
;1383:	if (j < 0 || j > MAPS_PER_TIER) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $1040
ADDRLP4 4
INDIRI4
CNSTI4 3
LEI4 $1038
LABELV $1040
line 1384
;1384:		j = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1385
;1385:	}
LABELV $1038
line 1387
;1386:
;1387:  Text_Paint(rect->x, rect->y, scale, color, UI_EnglishMapName(uiInfo.tierList[i].maps[j]), 0, 0, textStyle);
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 uiInfo+96044+4
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 UI_EnglishMapName
CALLP4
ASGNP4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1388
;1388:}
LABELV $1033
endproc UI_DrawTierMapName 32 32
proc UI_DrawTierGameType 28 32
line 1390
;1389:
;1390:static void UI_DrawTierGameType(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1392
;1391:  int i, j;
;1392:	i = trap_Cvar_VariableValue( "ui_currentTier" );
ADDRGP4 $999
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
CVFI4 4
ASGNI4
line 1393
;1393:  if (i < 0 || i >= uiInfo.tierCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1047
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+96040
INDIRI4
LTI4 $1044
LABELV $1047
line 1394
;1394:    i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1395
;1395:  }
LABELV $1044
line 1396
;1396:	j = trap_Cvar_VariableValue("ui_currentMap");
ADDRGP4 $873
ARGP4
ADDRLP4 16
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 16
INDIRF4
CVFI4 4
ASGNI4
line 1397
;1397:	if (j < 0 || j > MAPS_PER_TIER) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $1050
ADDRLP4 4
INDIRI4
CNSTI4 3
LEI4 $1048
LABELV $1050
line 1398
;1398:		j = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1399
;1399:	}
LABELV $1048
line 1401
;1400:
;1401:  Text_Paint(rect->x, rect->y, scale, color, uiInfo.gameTypes[uiInfo.tierList[i].gameTypes[j]].gameType , 0, 0, textStyle);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 uiInfo+96044+16
ADDP4
ADDP4
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1402
;1402:}
LABELV $1043
endproc UI_DrawTierGameType 28 32
proc UI_AIFromName 8 8
line 1412
;1403:
;1404:
;1405:#ifndef MISSIONPACK // bk001206
;1406:static const char *UI_OpponentLeaderName() {
;1407:  int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
;1408:	return uiInfo.teamList[i].teamMembers[0];
;1409:}
;1410:#endif
;1411:
;1412:static const char *UI_AIFromName(const char *name) {
line 1414
;1413:	int j;
;1414:	for (j = 0; j < uiInfo.aliasCount; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1058
JUMPV
LABELV $1055
line 1415
;1415:		if (Q_stricmp(uiInfo.aliasList[j].name, name) == 0) {
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+75000
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1060
line 1416
;1416:			return uiInfo.aliasList[j].ai;
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+75000+4
ADDP4
INDIRP4
RETP4
ADDRGP4 $1054
JUMPV
LABELV $1060
line 1418
;1417:		}
;1418:	}
LABELV $1056
line 1414
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1058
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+74996
INDIRI4
LTI4 $1055
line 1419
;1419:	return "James";
ADDRGP4 $1065
RETP4
LABELV $1054
endproc UI_AIFromName 8 8
data
align 4
LABELV updateOpponentModel
byte 4 1
bss
align 4
LABELV $1067
skip 1276
code
proc UI_DrawOpponent 416 28
line 1469
;1420:}
;1421:
;1422:#ifndef MISSIONPACK // bk001206
;1423:static const int UI_AIIndex(const char *name) {
;1424:	int j;
;1425:	for (j = 0; j < uiInfo.characterCount; j++) {
;1426:		if (Q_stricmp(name, uiInfo.characterList[j].name) == 0) {
;1427:			return j;
;1428:		}
;1429:	}
;1430:	return 0;
;1431:}
;1432:#endif
;1433:
;1434:#ifndef MISSIONPACK // bk001206
;1435:static const int UI_AIIndexFromName(const char *name) {
;1436:	int j;
;1437:	for (j = 0; j < uiInfo.aliasCount; j++) {
;1438:		if (Q_stricmp(uiInfo.aliasList[j].name, name) == 0) {
;1439:			return UI_AIIndex(uiInfo.aliasList[j].ai);
;1440:		}
;1441:	}
;1442:	return 0;
;1443:}
;1444:#endif
;1445:
;1446:
;1447:#ifndef MISSIONPACK // bk001206
;1448:static const char *UI_OpponentLeaderHead() {
;1449:	const char *leader = UI_OpponentLeaderName();
;1450:	return UI_AIFromName(leader);
;1451:}
;1452:#endif
;1453:
;1454:#ifndef MISSIONPACK // bk001206
;1455:static const char *UI_OpponentLeaderModel() {
;1456:	int i;
;1457:	const char *head = UI_OpponentLeaderHead();
;1458:	for (i = 0; i < uiInfo.characterCount; i++) {
;1459:		if (Q_stricmp(head, uiInfo.characterList[i].name) == 0) {
;1460:			return uiInfo.characterList[i].base;
;1461:		}
;1462:	}
;1463:	return "James";
;1464:}
;1465:#endif
;1466:
;1467:
;1468:static qboolean updateOpponentModel = qtrue;
;1469:static void UI_DrawOpponent(rectDef_t *rect) {
line 1477
;1470:  static playerInfo_t info2;
;1471:  char model[MAX_QPATH];
;1472:  char headmodel[MAX_QPATH];
;1473:  char team[256];
;1474:	vec3_t	viewangles;
;1475:	vec3_t	moveangles;
;1476:  
;1477:	if (updateOpponentModel) {
ADDRGP4 updateOpponentModel
INDIRI4
CNSTI4 0
EQI4 $1068
line 1479
;1478:		
;1479:		strcpy(model, UI_Cvar_VariableString("ui_opponentModel"));
ADDRGP4 $1070
ARGP4
ADDRLP4 408
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 12
ARGP4
ADDRLP4 408
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1480
;1480:	  strcpy(headmodel, UI_Cvar_VariableString("ui_opponentModel"));
ADDRGP4 $1070
ARGP4
ADDRLP4 412
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 76
ARGP4
ADDRLP4 412
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1481
;1481:		team[0] = '\0';
ADDRLP4 152
CNSTI1 0
ASGNI1
line 1483
;1482:
;1483:  	memset( &info2, 0, sizeof(playerInfo_t) );
ADDRGP4 $1067
ARGP4
CNSTI4 0
ARGI4
CNSTU4 1276
ARGU4
ADDRGP4 memset
CALLP4
pop
line 1484
;1484:  	viewangles[YAW]   = 180 - 10;
ADDRLP4 0+4
CNSTF4 1126825984
ASGNF4
line 1485
;1485:  	viewangles[PITCH] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1486
;1486:  	viewangles[ROLL]  = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 1487
;1487:  	VectorClear( moveangles );
ADDRLP4 140
CNSTF4 0
ASGNF4
ADDRLP4 140+4
CNSTF4 0
ASGNF4
ADDRLP4 140+8
CNSTF4 0
ASGNF4
line 1488
;1488:    UI_PlayerInfo_SetModel( &info2, model, headmodel, "");
ADDRGP4 $1067
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 76
ARGP4
ADDRGP4 $110
ARGP4
ADDRGP4 UI_PlayerInfo_SetModel
CALLV
pop
line 1489
;1489:    UI_PlayerInfo_SetInfo( &info2, LEGS_IDLE, TORSO_STAND, viewangles, vec3_origin, WP_MACHINEGUN, qfalse );
ADDRGP4 $1067
ARGP4
CNSTI4 22
ARGI4
CNSTI4 11
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 vec3_origin
ARGP4
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_PlayerInfo_SetInfo
CALLV
pop
line 1490
;1490:		UI_RegisterClientModelname( &info2, model, headmodel, team);
ADDRGP4 $1067
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 152
ARGP4
ADDRGP4 UI_RegisterClientModelname
CALLI4
pop
line 1491
;1491:    updateOpponentModel = qfalse;
ADDRGP4 updateOpponentModel
CNSTI4 0
ASGNI4
line 1492
;1492:  }
LABELV $1068
line 1494
;1493:
;1494:  UI_DrawPlayer( rect->x, rect->y, rect->w, rect->h, &info2, uiInfo.uiDC.realTime / 2);
ADDRLP4 408
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 408
INDIRP4
INDIRF4
ARGF4
ADDRLP4 408
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 408
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 408
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRGP4 $1067
ARGP4
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 2
DIVI4
ARGI4
ADDRGP4 UI_DrawPlayer
CALLV
pop
line 1496
;1495:
;1496:}
LABELV $1066
endproc UI_DrawOpponent 416 28
proc UI_NextOpponent 24 8
line 1498
;1497:
;1498:static void UI_NextOpponent() {
line 1499
;1499:  int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1077
ARGP4
ADDRLP4 8
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 1500
;1500:  int j = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 16
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
ASGNI4
line 1501
;1501:	i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1502
;1502:	if (i >= uiInfo.teamCount) {
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+75768
INDIRI4
LTI4 $1078
line 1503
;1503:		i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1504
;1504:	}
LABELV $1078
line 1505
;1505:	if (i == j) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $1081
line 1506
;1506:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1507
;1507:		if ( i >= uiInfo.teamCount) {
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+75768
INDIRI4
LTI4 $1083
line 1508
;1508:			i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1509
;1509:		}
LABELV $1083
line 1510
;1510:	}
LABELV $1081
line 1511
;1511: 	trap_Cvar_Set( "ui_opponentName", uiInfo.teamList[i].teamName );
ADDRGP4 $1077
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1512
;1512:}
LABELV $1076
endproc UI_NextOpponent 24 8
proc UI_PriorOpponent 24 8
line 1514
;1513:
;1514:static void UI_PriorOpponent() {
line 1515
;1515:  int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1077
ARGP4
ADDRLP4 8
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 1516
;1516:  int j = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 16
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
ASGNI4
line 1517
;1517:	i--;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1518
;1518:	if (i < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1088
line 1519
;1519:		i = uiInfo.teamCount - 1;
ADDRLP4 0
ADDRGP4 uiInfo+75768
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1520
;1520:	}
LABELV $1088
line 1521
;1521:	if (i == j) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $1091
line 1522
;1522:		i--;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1523
;1523:		if ( i < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1093
line 1524
;1524:			i = uiInfo.teamCount - 1;
ADDRLP4 0
ADDRGP4 uiInfo+75768
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1525
;1525:		}
LABELV $1093
line 1526
;1526:	}
LABELV $1091
line 1527
;1527: 	trap_Cvar_Set( "ui_opponentName", uiInfo.teamList[i].teamName );
ADDRGP4 $1077
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1528
;1528:}
LABELV $1087
endproc UI_PriorOpponent 24 8
proc UI_DrawPlayerLogo 44 20
line 1530
;1529:
;1530:static void	UI_DrawPlayerLogo(rectDef_t *rect, vec3_t color) {
line 1531
;1531:  int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1533
;1532:
;1533:	if (uiInfo.teamList[i].teamIcon == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+28
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1098
line 1534
;1534:    uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+28
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1535
;1535:    uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal",uiInfo.teamList[i].imageName));
ADDRGP4 $748
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+32
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1536
;1536:    uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $753
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+36
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1537
;1537:	}
LABELV $1098
line 1539
;1538:
;1539: 	trap_R_SetColor( color );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1540
;1540:	UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+28
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1541
;1541: 	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1542
;1542:}
LABELV $1097
endproc UI_DrawPlayerLogo 44 20
proc UI_DrawPlayerLogoMetal 44 20
line 1544
;1543:
;1544:static void	UI_DrawPlayerLogoMetal(rectDef_t *rect, vec3_t color) {
line 1545
;1545:  int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1546
;1546:	if (uiInfo.teamList[i].teamIcon == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+28
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1117
line 1547
;1547:    uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+28
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1548
;1548:    uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal",uiInfo.teamList[i].imageName));
ADDRGP4 $748
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+32
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1549
;1549:    uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $753
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+36
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1550
;1550:	}
LABELV $1117
line 1552
;1551:
;1552: 	trap_R_SetColor( color );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1553
;1553:	UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon_Metal );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+32
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1554
;1554: 	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1555
;1555:}
LABELV $1116
endproc UI_DrawPlayerLogoMetal 44 20
proc UI_DrawPlayerLogoName 44 20
line 1557
;1556:
;1557:static void	UI_DrawPlayerLogoName(rectDef_t *rect, vec3_t color) {
line 1558
;1558:  int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1559
;1559:	if (uiInfo.teamList[i].teamIcon == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+28
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1136
line 1560
;1560:    uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+28
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1561
;1561:    uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal",uiInfo.teamList[i].imageName));
ADDRGP4 $748
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+32
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1562
;1562:    uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $753
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+36
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1563
;1563:	}
LABELV $1136
line 1565
;1564:
;1565: 	trap_R_SetColor( color );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1566
;1566:	UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon_Name );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+36
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1567
;1567: 	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1568
;1568:}
LABELV $1135
endproc UI_DrawPlayerLogoName 44 20
proc UI_DrawOpponentLogo 44 20
line 1570
;1569:
;1570:static void	UI_DrawOpponentLogo(rectDef_t *rect, vec3_t color) {
line 1571
;1571:  int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1077
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1572
;1572:	if (uiInfo.teamList[i].teamIcon == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+28
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1155
line 1573
;1573:    uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+28
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1574
;1574:    uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal",uiInfo.teamList[i].imageName));
ADDRGP4 $748
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+32
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1575
;1575:    uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $753
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+36
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1576
;1576:	}
LABELV $1155
line 1578
;1577:
;1578: 	trap_R_SetColor( color );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1579
;1579:	UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+28
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1580
;1580: 	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1581
;1581:}
LABELV $1154
endproc UI_DrawOpponentLogo 44 20
proc UI_DrawOpponentLogoMetal 44 20
line 1583
;1582:
;1583:static void	UI_DrawOpponentLogoMetal(rectDef_t *rect, vec3_t color) {
line 1584
;1584:  int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1077
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1585
;1585:	if (uiInfo.teamList[i].teamIcon == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+28
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1174
line 1586
;1586:    uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+28
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1587
;1587:    uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal",uiInfo.teamList[i].imageName));
ADDRGP4 $748
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+32
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1588
;1588:    uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $753
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+36
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1589
;1589:	}
LABELV $1174
line 1591
;1590:
;1591: 	trap_R_SetColor( color );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1592
;1592:	UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon_Metal );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+32
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1593
;1593: 	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1594
;1594:}
LABELV $1173
endproc UI_DrawOpponentLogoMetal 44 20
proc UI_DrawOpponentLogoName 44 20
line 1596
;1595:
;1596:static void	UI_DrawOpponentLogoName(rectDef_t *rect, vec3_t color) {
line 1597
;1597:  int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1077
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1598
;1598:	if (uiInfo.teamList[i].teamIcon == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+28
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1193
line 1599
;1599:    uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+28
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1600
;1600:    uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal",uiInfo.teamList[i].imageName));
ADDRGP4 $748
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+32
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1601
;1601:    uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $753
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+36
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1602
;1602:	}
LABELV $1193
line 1604
;1603:
;1604: 	trap_R_SetColor( color );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1605
;1605:	UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon_Name );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+36
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1606
;1606: 	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1607
;1607:}
LABELV $1192
endproc UI_DrawOpponentLogoName 44 20
proc UI_DrawAllMapsSelection 16 32
line 1609
;1608:
;1609:static void UI_DrawAllMapsSelection(rectDef_t *rect, float scale, vec4_t color, int textStyle, qboolean net) {
line 1610
;1610:	int map = (net) ? ui_currentNetMap.integer : ui_currentMap.integer;
ADDRFP4 16
INDIRI4
CNSTI4 0
EQI4 $1215
ADDRLP4 4
ADDRGP4 ui_currentNetMap+12
INDIRI4
ASGNI4
ADDRGP4 $1216
JUMPV
LABELV $1215
ADDRLP4 4
ADDRGP4 ui_currentMap+12
INDIRI4
ASGNI4
LABELV $1216
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1611
;1611:	if (map >= 0 && map < uiInfo.mapCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1217
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+83236
INDIRI4
GEI4 $1217
line 1612
;1612:	  Text_Paint(rect->x, rect->y, scale, color, uiInfo.mapList[map].mapName, 0, 0, textStyle);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1613
;1613:	}
LABELV $1217
line 1614
;1614:}
LABELV $1211
endproc UI_DrawAllMapsSelection 16 32
proc UI_DrawOpponentName 8 32
line 1616
;1615:
;1616:static void UI_DrawOpponentName(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1617
;1617:  Text_Paint(rect->x, rect->y, scale, color, UI_Cvar_VariableString("ui_opponentName"), 0, 0, textStyle);
ADDRGP4 $1077
ARGP4
ADDRLP4 0
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1618
;1618:}
LABELV $1221
endproc UI_DrawOpponentName 8 32
proc UI_OwnerDrawWidth 112 12
line 1621
;1619:
;1620:
;1621:static int UI_OwnerDrawWidth(int ownerDraw, float scale) {
line 1624
;1622:	int i, h, value;
;1623:	const char *text;
;1624:	const char *s = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 1626
;1625:
;1626:  switch (ownerDraw) {
ADDRLP4 20
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 200
LTI4 $1224
ADDRLP4 20
INDIRI4
CNSTI4 247
GTI4 $1287
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1288-800
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1288
address $1225
address $1224
address $1224
address $1226
address $1224
address $1227
address $1224
address $1230
address $1235
address $1240
address $1245
address $1245
address $1245
address $1245
address $1245
address $1255
address $1255
address $1255
address $1255
address $1255
address $1264
address $1224
address $1273
address $1224
address $1224
address $1224
address $1224
address $1224
address $1224
address $1224
address $1224
address $1224
address $1224
address $1224
address $1224
address $1224
address $1224
address $1224
address $1224
address $1224
address $1224
address $1224
address $1224
address $1224
address $1224
address $1224
address $1224
address $1284
code
LABELV $1287
ADDRFP4 0
INDIRI4
CNSTI4 250
EQI4 $1279
ADDRGP4 $1224
JUMPV
LABELV $1225
line 1628
;1627:    case UI_HANDICAP:
;1628:			  h = Com_Clamp( 5, 100, trap_Cvar_VariableValue("handicap") );
ADDRGP4 $678
ARGP4
ADDRLP4 24
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1084227584
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 28
INDIRF4
CVFI4 4
ASGNI4
line 1629
;1629:				i = 20 - h / 5;
ADDRLP4 4
CNSTI4 20
ADDRLP4 16
INDIRI4
CNSTI4 5
DIVI4
SUBI4
ASGNI4
line 1630
;1630:				s = handicapValues[i];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 handicapValues
ADDP4
INDIRP4
ASGNP4
line 1631
;1631:      break;
ADDRGP4 $1224
JUMPV
LABELV $1226
line 1633
;1632:    case UI_CLANNAME:
;1633:				s = UI_Cvar_VariableString("ui_teamName");
ADDRGP4 $680
ARGP4
ADDRLP4 32
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 1634
;1634:      break;
ADDRGP4 $1224
JUMPV
LABELV $1227
line 1636
;1635:    case UI_GAMETYPE:
;1636:				s = uiInfo.gameTypes[ui_gameType.integer].gameType;
ADDRLP4 0
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592
ADDP4
INDIRP4
ASGNP4
line 1637
;1637:      break;
ADDRGP4 $1224
JUMPV
LABELV $1230
line 1639
;1638:    case UI_SKILL:
;1639:				i = trap_Cvar_VariableValue( "g_spSkill" );
ADDRGP4 $806
ARGP4
ADDRLP4 36
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 36
INDIRF4
CVFI4 4
ASGNI4
line 1640
;1640:				if (i < 1 || i > numSkillLevels) {
ADDRLP4 40
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 1
LTI4 $1233
ADDRLP4 40
INDIRI4
ADDRGP4 numSkillLevels
INDIRI4
LEI4 $1231
LABELV $1233
line 1641
;1641:					i = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1642
;1642:				}
LABELV $1231
line 1643
;1643:			  s = skillLevels[i-1];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 skillLevels-4
ADDP4
INDIRP4
ASGNP4
line 1644
;1644:      break;
ADDRGP4 $1224
JUMPV
LABELV $1235
line 1646
;1645:    case UI_BLUETEAMNAME:
;1646:			  i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_blueTeam"));
ADDRGP4 $812
ARGP4
ADDRLP4 44
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 48
INDIRI4
ASGNI4
line 1647
;1647:			  if (i >= 0 && i < uiInfo.teamCount) {
ADDRLP4 52
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
LTI4 $1224
ADDRLP4 52
INDIRI4
ADDRGP4 uiInfo+75768
INDIRI4
GEI4 $1224
line 1648
;1648:			    s = va("%s: %s", "Blue", uiInfo.teamList[i].teamName);
ADDRGP4 $820
ARGP4
ADDRGP4 $821
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772
ADDP4
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 56
INDIRP4
ASGNP4
line 1649
;1649:			  }
line 1650
;1650:      break;
ADDRGP4 $1224
JUMPV
LABELV $1240
line 1652
;1651:    case UI_REDTEAMNAME:
;1652:			  i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_redTeam"));
ADDRGP4 $813
ARGP4
ADDRLP4 56
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 60
INDIRI4
ASGNI4
line 1653
;1653:			  if (i >= 0 && i < uiInfo.teamCount) {
ADDRLP4 64
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
LTI4 $1224
ADDRLP4 64
INDIRI4
ADDRGP4 uiInfo+75768
INDIRI4
GEI4 $1224
line 1654
;1654:			    s = va("%s: %s", "Red", uiInfo.teamList[i].teamName);
ADDRGP4 $820
ARGP4
ADDRGP4 $822
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772
ADDP4
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 68
INDIRP4
ASGNP4
line 1655
;1655:			  }
line 1656
;1656:      break;
ADDRGP4 $1224
JUMPV
LABELV $1245
line 1662
;1657:    case UI_BLUETEAM1:
;1658:		case UI_BLUETEAM2:
;1659:		case UI_BLUETEAM3:
;1660:		case UI_BLUETEAM4:
;1661:		case UI_BLUETEAM5:
;1662:			value = trap_Cvar_VariableValue(va("ui_blueteam%i", ownerDraw-UI_BLUETEAM1 + 1));
ADDRGP4 $828
ARGP4
ADDRFP4 0
INDIRI4
CNSTI4 210
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 68
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 72
INDIRF4
CVFI4 4
ASGNI4
line 1663
;1663:			if (value <= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
GTI4 $1246
line 1664
;1664:				text = "Closed";
ADDRLP4 12
ADDRGP4 $835
ASGNP4
line 1665
;1665:			} else if (value == 1) {
ADDRGP4 $1247
JUMPV
LABELV $1246
ADDRLP4 8
INDIRI4
CNSTI4 1
NEI4 $1248
line 1666
;1666:				text = "Human";
ADDRLP4 12
ADDRGP4 $838
ASGNP4
line 1667
;1667:			} else {
ADDRGP4 $1249
JUMPV
LABELV $1248
line 1668
;1668:				value -= 2;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 1669
;1669:				if (value >= uiInfo.aliasCount) {
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+74996
INDIRI4
LTI4 $1250
line 1670
;1670:					value = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1671
;1671:				}
LABELV $1250
line 1672
;1672:				text = uiInfo.aliasList[value].name;
ADDRLP4 12
ADDRLP4 8
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+75000
ADDP4
INDIRP4
ASGNP4
line 1673
;1673:			}
LABELV $1249
LABELV $1247
line 1674
;1674:			s = va("%i. %s", ownerDraw-UI_BLUETEAM1 + 1, text);
ADDRGP4 $1254
ARGP4
ADDRFP4 0
INDIRI4
CNSTI4 210
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 76
INDIRP4
ASGNP4
line 1675
;1675:      break;
ADDRGP4 $1224
JUMPV
LABELV $1255
line 1681
;1676:    case UI_REDTEAM1:
;1677:		case UI_REDTEAM2:
;1678:		case UI_REDTEAM3:
;1679:		case UI_REDTEAM4:
;1680:		case UI_REDTEAM5:
;1681:			value = trap_Cvar_VariableValue(va("ui_redteam%i", ownerDraw-UI_REDTEAM1 + 1));
ADDRGP4 $829
ARGP4
ADDRFP4 0
INDIRI4
CNSTI4 215
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 80
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 84
INDIRF4
CVFI4 4
ASGNI4
line 1682
;1682:			if (value <= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
GTI4 $1256
line 1683
;1683:				text = "Closed";
ADDRLP4 12
ADDRGP4 $835
ASGNP4
line 1684
;1684:			} else if (value == 1) {
ADDRGP4 $1257
JUMPV
LABELV $1256
ADDRLP4 8
INDIRI4
CNSTI4 1
NEI4 $1258
line 1685
;1685:				text = "Human";
ADDRLP4 12
ADDRGP4 $838
ASGNP4
line 1686
;1686:			} else {
ADDRGP4 $1259
JUMPV
LABELV $1258
line 1687
;1687:				value -= 2;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 1688
;1688:				if (value >= uiInfo.aliasCount) {
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+74996
INDIRI4
LTI4 $1260
line 1689
;1689:					value = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1690
;1690:				}
LABELV $1260
line 1691
;1691:				text = uiInfo.aliasList[value].name;
ADDRLP4 12
ADDRLP4 8
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+75000
ADDP4
INDIRP4
ASGNP4
line 1692
;1692:			}
LABELV $1259
LABELV $1257
line 1693
;1693:			s = va("%i. %s", ownerDraw-UI_REDTEAM1 + 1, text);
ADDRGP4 $1254
ARGP4
ADDRFP4 0
INDIRI4
CNSTI4 215
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 88
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 88
INDIRP4
ASGNP4
line 1694
;1694:      break;
ADDRGP4 $1224
JUMPV
LABELV $1264
line 1696
;1695:		case UI_NETSOURCE:
;1696:			if (ui_netSource.integer < 0 || ui_netSource.integer > uiInfo.numJoinGameTypes) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
LTI4 $1270
ADDRGP4 ui_netSource+12
INDIRI4
ADDRGP4 uiInfo+78720
INDIRI4
LEI4 $1265
LABELV $1270
line 1697
;1697:				ui_netSource.integer = 0;
ADDRGP4 ui_netSource+12
CNSTI4 0
ASGNI4
line 1698
;1698:			}
LABELV $1265
line 1699
;1699:			s = va("Source: %s", netSources[ui_netSource.integer]);
ADDRGP4 $969
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 netSources
ADDP4
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 92
INDIRP4
ASGNP4
line 1700
;1700:			break;
ADDRGP4 $1224
JUMPV
LABELV $1273
line 1705
;1701:		case UI_NETFILTER:
;1702:			/*if (ui_serverFilterType.integer < 0 || ui_serverFilterType.integer > numServerFilters) {
;1703:				ui_serverFilterType.integer = 0;
;1704:			}*/
;1705:			s = va("Filter: %s", serverFilters[0/*ui_serverFilterType.integer*/].description );
ADDRGP4 $997
ARGP4
ADDRGP4 serverFilters
INDIRP4
ARGP4
ADDRLP4 96
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 96
INDIRP4
ASGNP4
line 1706
;1706:			break;
ADDRGP4 $1224
JUMPV
line 1708
;1707:		case UI_TIER:
;1708:			break;
line 1710
;1709:		case UI_TIER_MAPNAME:
;1710:			break;
line 1712
;1711:		case UI_TIER_GAMETYPE:
;1712:			break;
line 1714
;1713:		case UI_ALLMAPS_SELECTION:
;1714:			break;
line 1716
;1715:		case UI_OPPONENT_NAME:
;1716:			break;
LABELV $1279
line 1718
;1717:		case UI_KEYBINDSTATUS:
;1718:			if (Display_KeyBindPending()) {
ADDRLP4 100
ADDRGP4 Display_KeyBindPending
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
EQI4 $1280
line 1719
;1719:				s = "Waiting for new key... Press ESCAPE to cancel";
ADDRLP4 0
ADDRGP4 $1282
ASGNP4
line 1720
;1720:			} else {
ADDRGP4 $1224
JUMPV
LABELV $1280
line 1721
;1721:				s = "Press ENTER or CLICK to change, Press BACKSPACE to clear";
ADDRLP4 0
ADDRGP4 $1283
ASGNP4
line 1722
;1722:			}
line 1723
;1723:			break;
ADDRGP4 $1224
JUMPV
LABELV $1284
line 1725
;1724:		case UI_SERVERREFRESHDATE:
;1725:			s = UI_Cvar_VariableString(va("ui_lastServerRefresh_%i", ui_netSource.integer));
ADDRGP4 $1285
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 104
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 108
INDIRP4
ASGNP4
line 1726
;1726:			break;
line 1728
;1727:    default:
;1728:      break;
LABELV $1224
line 1731
;1729:  }
;1730:
;1731:	if (s) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1290
line 1732
;1732:		return Text_Width(s, scale, 0);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 24
ADDRGP4 Text_Width
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
RETI4
ADDRGP4 $1222
JUMPV
LABELV $1290
line 1734
;1733:	}
;1734:	return 0;
CNSTI4 0
RETI4
LABELV $1222
endproc UI_OwnerDrawWidth 112 12
proc UI_DrawBotName 24 32
line 1737
;1735:}
;1736:
;1737:static void UI_DrawBotName(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1738
;1738:	int value = uiInfo.botIndex;
ADDRLP4 0
ADDRGP4 uiInfo+73456
INDIRI4
ASGNI4
line 1739
;1739:	int game = trap_Cvar_VariableValue("g_gametype");
ADDRGP4 $1294
ARGP4
ADDRLP4 12
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 1740
;1740:	const char *text = "";
ADDRLP4 4
ADDRGP4 $110
ASGNP4
line 1741
;1741:	if (game >= GT_TEAM) {
ADDRLP4 8
INDIRI4
CNSTI4 3
LTI4 $1295
line 1742
;1742:		if (value >= uiInfo.characterCount) {
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+73452
INDIRI4
LTI4 $1297
line 1743
;1743:			value = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1744
;1744:		}
LABELV $1297
line 1745
;1745:		text = uiInfo.characterList[value].name;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460
ADDP4
INDIRP4
ASGNP4
line 1746
;1746:	} else {
ADDRGP4 $1296
JUMPV
LABELV $1295
line 1747
;1747:		if (value >= UI_GetNumBots()) {
ADDRLP4 16
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $1301
line 1748
;1748:			value = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1749
;1749:		}
LABELV $1301
line 1750
;1750:		text = UI_GetBotNameByNumber(value);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 UI_GetBotNameByNumber
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
line 1751
;1751:	}
LABELV $1296
line 1752
;1752:  Text_Paint(rect->x, rect->y, scale, color, text, 0, 0, textStyle);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1753
;1753:}
LABELV $1292
endproc UI_DrawBotName 24 32
proc UI_DrawBotSkill 4 32
line 1755
;1754:
;1755:static void UI_DrawBotSkill(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1756
;1756:	if (uiInfo.skillIndex >= 0 && uiInfo.skillIndex < numSkillLevels) {
ADDRGP4 uiInfo+96684
INDIRI4
CNSTI4 0
LTI4 $1304
ADDRGP4 uiInfo+96684
INDIRI4
ADDRGP4 numSkillLevels
INDIRI4
GEI4 $1304
line 1757
;1757:	  Text_Paint(rect->x, rect->y, scale, color, skillLevels[uiInfo.skillIndex], 0, 0, textStyle);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 uiInfo+96684
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 skillLevels
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1758
;1758:	}
LABELV $1304
line 1759
;1759:}
LABELV $1303
endproc UI_DrawBotSkill 4 32
proc UI_DrawRedBlue 8 32
line 1761
;1760:
;1761:static void UI_DrawRedBlue(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1762
;1762:  Text_Paint(rect->x, rect->y, scale, color, (uiInfo.redBlue == 0) ? "Red" : "Blue", 0, 0, textStyle);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 uiInfo+78852
INDIRI4
CNSTI4 0
NEI4 $1312
ADDRLP4 0
ADDRGP4 $822
ASGNP4
ADDRGP4 $1313
JUMPV
LABELV $1312
ADDRLP4 0
ADDRGP4 $821
ASGNP4
LABELV $1313
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1763
;1763:}
LABELV $1309
endproc UI_DrawRedBlue 8 32
proc UI_DrawCrosshair 4 20
line 1765
;1764:
;1765:static void UI_DrawCrosshair(rectDef_t *rect, float scale, vec4_t color) {
line 1766
;1766: 	trap_R_SetColor( color );
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1767
;1767:	if (uiInfo.currentCrosshair < 0 || uiInfo.currentCrosshair >= NUM_CROSSHAIRS) {
ADDRGP4 uiInfo+119488
INDIRI4
CNSTI4 0
LTI4 $1319
ADDRGP4 uiInfo+119488
INDIRI4
CNSTI4 10
LTI4 $1315
LABELV $1319
line 1768
;1768:		uiInfo.currentCrosshair = 0;
ADDRGP4 uiInfo+119488
CNSTI4 0
ASGNI4
line 1769
;1769:	}
LABELV $1315
line 1770
;1770:	UI_DrawHandlePic( rect->x, rect->y - rect->h, rect->w, rect->h, uiInfo.uiDC.Assets.crosshairShader[uiInfo.currentCrosshair]);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRGP4 uiInfo+119488
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+228+61776
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1771
;1771: 	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1772
;1772:}
LABELV $1314
endproc UI_DrawCrosshair 4 20
proc UI_BuildPlayerList 4176 12
line 1779
;1773:
;1774:/*
;1775:===============
;1776:UI_BuildPlayerList
;1777:===============
;1778:*/
;1779:static void UI_BuildPlayerList() {
line 1784
;1780:	uiClientState_t	cs;
;1781:	int		n, count, team, team2, playerTeamNumber;
;1782:	char	info[MAX_INFO_STRING];
;1783:
;1784:	trap_GetClientState( &cs );
ADDRLP4 1040
ARGP4
ADDRGP4 trap_GetClientState
CALLV
pop
line 1785
;1785:	trap_GetConfigString( CS_PLAYERS + cs.clientNum, info, MAX_INFO_STRING );
ADDRLP4 1040+8
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigString
CALLI4
pop
line 1786
;1786:	uiInfo.playerNumber = cs.clientNum;
ADDRGP4 uiInfo+78876
ADDRLP4 1040+8
INDIRI4
ASGNI4
line 1787
;1787:	uiInfo.teamLeader = atoi(Info_ValueForKey(info, "tl"));
ADDRLP4 4
ARGP4
ADDRGP4 $1329
ARGP4
ADDRLP4 4128
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4128
INDIRP4
ARGP4
ADDRLP4 4132
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 uiInfo+78880
ADDRLP4 4132
INDIRI4
ASGNI4
line 1788
;1788:	team = atoi(Info_ValueForKey(info, "t"));
ADDRLP4 4
ARGP4
ADDRGP4 $1330
ARGP4
ADDRLP4 4136
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4136
INDIRP4
ARGP4
ADDRLP4 4140
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1036
ADDRLP4 4140
INDIRI4
ASGNI4
line 1789
;1789:	trap_GetConfigString( CS_SERVERINFO, info, sizeof(info) );
CNSTI4 0
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigString
CALLI4
pop
line 1790
;1790:	count = atoi( Info_ValueForKey( info, "sv_maxclients" ) );
ADDRLP4 4
ARGP4
ADDRGP4 $1331
ARGP4
ADDRLP4 4144
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4144
INDIRP4
ARGP4
ADDRLP4 4148
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 4148
INDIRI4
ASGNI4
line 1791
;1791:	uiInfo.playerCount = 0;
ADDRGP4 uiInfo+78856
CNSTI4 0
ASGNI4
line 1792
;1792:	uiInfo.myTeamCount = 0;
ADDRGP4 uiInfo+78860
CNSTI4 0
ASGNI4
line 1793
;1793:	playerTeamNumber = 0;
ADDRLP4 4124
CNSTI4 0
ASGNI4
line 1794
;1794:	for( n = 0; n < count; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1337
JUMPV
LABELV $1334
line 1795
;1795:		trap_GetConfigString( CS_PLAYERS + n, info, MAX_INFO_STRING );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigString
CALLI4
pop
line 1797
;1796:
;1797:		if (info[0]) {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1338
line 1798
;1798:			Q_strncpyz( uiInfo.playerNames[uiInfo.playerCount], Info_ValueForKey( info, "n" ), MAX_NAME_LENGTH );
ADDRLP4 4
ARGP4
ADDRGP4 $1342
ARGP4
ADDRLP4 4152
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 uiInfo+78856
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+78884
ADDP4
ARGP4
ADDRLP4 4152
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1799
;1799:			Q_CleanStr( uiInfo.playerNames[uiInfo.playerCount] );
ADDRGP4 uiInfo+78856
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+78884
ADDP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1800
;1800:			uiInfo.playerCount++;
ADDRLP4 4156
ADDRGP4 uiInfo+78856
ASGNP4
ADDRLP4 4156
INDIRP4
ADDRLP4 4156
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1801
;1801:			team2 = atoi(Info_ValueForKey(info, "t"));
ADDRLP4 4
ARGP4
ADDRGP4 $1330
ARGP4
ADDRLP4 4160
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4160
INDIRP4
ARGP4
ADDRLP4 4164
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 4164
INDIRI4
ASGNI4
line 1802
;1802:			if (team2 == team) {
ADDRLP4 1032
INDIRI4
ADDRLP4 1036
INDIRI4
NEI4 $1346
line 1803
;1803:				Q_strncpyz( uiInfo.teamNames[uiInfo.myTeamCount], Info_ValueForKey( info, "n" ), MAX_NAME_LENGTH );
ADDRLP4 4
ARGP4
ADDRGP4 $1342
ARGP4
ADDRLP4 4168
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 uiInfo+78860
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+80932
ADDP4
ARGP4
ADDRLP4 4168
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1804
;1804:				Q_CleanStr( uiInfo.teamNames[uiInfo.myTeamCount] );
ADDRGP4 uiInfo+78860
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+80932
ADDP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1805
;1805:				uiInfo.teamClientNums[uiInfo.myTeamCount] = n;
ADDRGP4 uiInfo+78860
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+82980
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1806
;1806:				if (uiInfo.playerNumber == n) {
ADDRGP4 uiInfo+78876
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1354
line 1807
;1807:					playerTeamNumber = uiInfo.myTeamCount;
ADDRLP4 4124
ADDRGP4 uiInfo+78860
INDIRI4
ASGNI4
line 1808
;1808:				}
LABELV $1354
line 1809
;1809:				uiInfo.myTeamCount++;
ADDRLP4 4172
ADDRGP4 uiInfo+78860
ASGNP4
ADDRLP4 4172
INDIRP4
ADDRLP4 4172
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1810
;1810:			}
LABELV $1346
line 1811
;1811:		}
LABELV $1338
line 1812
;1812:	}
LABELV $1335
line 1794
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1337
ADDRLP4 0
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $1334
line 1814
;1813:
;1814:	if (!uiInfo.teamLeader) {
ADDRGP4 uiInfo+78880
INDIRI4
CNSTI4 0
NEI4 $1359
line 1815
;1815:		trap_Cvar_Set("cg_selectedPlayer", va("%d", playerTeamNumber));
ADDRGP4 $695
ARGP4
ADDRLP4 4124
INDIRI4
ARGI4
ADDRLP4 4152
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1362
ARGP4
ADDRLP4 4152
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1816
;1816:	}
LABELV $1359
line 1818
;1817:
;1818:	n = trap_Cvar_VariableValue("cg_selectedPlayer");
ADDRGP4 $1362
ARGP4
ADDRLP4 4152
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4152
INDIRF4
CVFI4 4
ASGNI4
line 1819
;1819:	if (n < 0 || n > uiInfo.myTeamCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1366
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+78860
INDIRI4
LEI4 $1363
LABELV $1366
line 1820
;1820:		n = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1821
;1821:	}
LABELV $1363
line 1822
;1822:	if (n < uiInfo.myTeamCount) {
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+78860
INDIRI4
GEI4 $1367
line 1823
;1823:		trap_Cvar_Set("cg_selectedPlayerName", uiInfo.teamNames[n]);
ADDRGP4 $1370
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+80932
ADDP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1824
;1824:	}
LABELV $1367
line 1825
;1825:}
LABELV $1324
endproc UI_BuildPlayerList 4176 12
proc UI_DrawSelectedPlayer 16 32
line 1828
;1826:
;1827:
;1828:static void UI_DrawSelectedPlayer(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1829
;1829:	if (uiInfo.uiDC.realTime > uiInfo.playerRefresh) {
ADDRGP4 uiInfo+208
INDIRI4
ADDRGP4 uiInfo+78868
INDIRI4
LEI4 $1373
line 1830
;1830:		uiInfo.playerRefresh = uiInfo.uiDC.realTime + 3000;
ADDRGP4 uiInfo+78868
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 1831
;1831:		UI_BuildPlayerList();
ADDRGP4 UI_BuildPlayerList
CALLV
pop
line 1832
;1832:	}
LABELV $1373
line 1833
;1833:  Text_Paint(rect->x, rect->y, scale, color, (uiInfo.teamLeader) ? UI_Cvar_VariableString("cg_selectedPlayerName") : UI_Cvar_VariableString("name") , 0, 0, textStyle);
ADDRGP4 uiInfo+78880
INDIRI4
CNSTI4 0
EQI4 $1382
ADDRGP4 $1370
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRGP4 $1383
JUMPV
LABELV $1382
ADDRGP4 $1380
ARGP4
ADDRLP4 8
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
LABELV $1383
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1834
;1834:}
LABELV $1372
endproc UI_DrawSelectedPlayer 16 32
proc UI_DrawServerRefreshDate 80 32
line 1836
;1835:
;1836:static void UI_DrawServerRefreshDate(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1837
;1837:	if (uiInfo.serverStatus.refreshActive) {
ADDRGP4 uiInfo+99276+2212
INDIRI4
CNSTI4 0
EQI4 $1385
line 1839
;1838:		vec4_t lowLight, newColor;
;1839:		lowLight[0] = 0.8 * color[0]; 
ADDRLP4 0
ADDRFP4 8
INDIRP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 1840
;1840:		lowLight[1] = 0.8 * color[1]; 
ADDRLP4 0+4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 1841
;1841:		lowLight[2] = 0.8 * color[2]; 
ADDRLP4 0+8
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 1842
;1842:		lowLight[3] = 0.8 * color[3]; 
ADDRLP4 0+12
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 1843
;1843:		LerpColor(color,lowLight,newColor,0.5+0.5*sin(uiInfo.uiDC.realTime / PULSE_DIVISOR));
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 32
ADDRGP4 sin
CALLF4
ASGNF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 32
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 1844
;1844:	  Text_Paint(rect->x, rect->y, scale, newColor, va("Getting info for %d servers (ESC to cancel)", trap_LAN_GetServerCount(ui_netSource.integer)), 0, 0, textStyle);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRGP4 $1393
ARGP4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 16
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1845
;1845:	} else {
ADDRGP4 $1386
JUMPV
LABELV $1385
line 1847
;1846:		char buff[64];
;1847:		Q_strncpyz(buff, UI_Cvar_VariableString(va("ui_lastServerRefresh_%i", ui_netSource.integer)), 64);
ADDRGP4 $1285
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1848
;1848:	  Text_Paint(rect->x, rect->y, scale, color, va("Refresh Time: %s", buff), 0, 0, textStyle);
ADDRGP4 $1396
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 72
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
INDIRF4
ARGF4
ADDRLP4 76
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1849
;1849:	}
LABELV $1386
line 1850
;1850:}
LABELV $1384
endproc UI_DrawServerRefreshDate 80 32
proc UI_DrawServerMOTD 24 32
line 1852
;1851:
;1852:static void UI_DrawServerMOTD(rectDef_t *rect, float scale, vec4_t color) {
line 1853
;1853:	if (uiInfo.serverStatus.motdLen) {
ADDRGP4 uiInfo+99276+10436
INDIRI4
CNSTI4 0
EQI4 $1398
line 1856
;1854:		float maxX;
;1855:	 
;1856:		if (uiInfo.serverStatus.motdWidth == -1) {
ADDRGP4 uiInfo+99276+10440
INDIRI4
CNSTI4 -1
NEI4 $1402
line 1857
;1857:			uiInfo.serverStatus.motdWidth = 0;
ADDRGP4 uiInfo+99276+10440
CNSTI4 0
ASGNI4
line 1858
;1858:			uiInfo.serverStatus.motdPaintX = rect->x + 1;
ADDRGP4 uiInfo+99276+10444
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 1859
;1859:			uiInfo.serverStatus.motdPaintX2 = -1;
ADDRGP4 uiInfo+99276+10448
CNSTI4 -1
ASGNI4
line 1860
;1860:		}
LABELV $1402
line 1862
;1861:
;1862:		if (uiInfo.serverStatus.motdOffset > uiInfo.serverStatus.motdLen) {
ADDRGP4 uiInfo+99276+10452
INDIRI4
ADDRGP4 uiInfo+99276+10436
INDIRI4
LEI4 $1412
line 1863
;1863:			uiInfo.serverStatus.motdOffset = 0;
ADDRGP4 uiInfo+99276+10452
CNSTI4 0
ASGNI4
line 1864
;1864:			uiInfo.serverStatus.motdPaintX = rect->x + 1;
ADDRGP4 uiInfo+99276+10444
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 1865
;1865:			uiInfo.serverStatus.motdPaintX2 = -1;
ADDRGP4 uiInfo+99276+10448
CNSTI4 -1
ASGNI4
line 1866
;1866:		}
LABELV $1412
line 1868
;1867:
;1868:		if (uiInfo.uiDC.realTime > uiInfo.serverStatus.motdTime) {
ADDRGP4 uiInfo+208
INDIRI4
ADDRGP4 uiInfo+99276+10456
INDIRI4
LEI4 $1424
line 1869
;1869:			uiInfo.serverStatus.motdTime = uiInfo.uiDC.realTime + 10;
ADDRGP4 uiInfo+99276+10456
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 10
ADDI4
ASGNI4
line 1870
;1870:			if (uiInfo.serverStatus.motdPaintX <= rect->x + 2) {
ADDRGP4 uiInfo+99276+10444
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDF4
GTF4 $1432
line 1871
;1871:				if (uiInfo.serverStatus.motdOffset < uiInfo.serverStatus.motdLen) {
ADDRGP4 uiInfo+99276+10452
INDIRI4
ADDRGP4 uiInfo+99276+10436
INDIRI4
GEI4 $1436
line 1872
;1872:					uiInfo.serverStatus.motdPaintX += Text_Width(&uiInfo.serverStatus.motd[uiInfo.serverStatus.motdOffset], scale, 1) - 1;
ADDRGP4 uiInfo+99276+10452
INDIRI4
ADDRGP4 uiInfo+99276+10460
ADDP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 Text_Width
CALLI4
ASGNI4
ADDRLP4 8
ADDRGP4 uiInfo+99276+10444
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ADDI4
ASGNI4
line 1873
;1873:					uiInfo.serverStatus.motdOffset++;
ADDRLP4 12
ADDRGP4 uiInfo+99276+10452
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1874
;1874:				} else {
ADDRGP4 $1433
JUMPV
LABELV $1436
line 1875
;1875:					uiInfo.serverStatus.motdOffset = 0;
ADDRGP4 uiInfo+99276+10452
CNSTI4 0
ASGNI4
line 1876
;1876:					if (uiInfo.serverStatus.motdPaintX2 >= 0) {
ADDRGP4 uiInfo+99276+10448
INDIRI4
CNSTI4 0
LTI4 $1452
line 1877
;1877:						uiInfo.serverStatus.motdPaintX = uiInfo.serverStatus.motdPaintX2;
ADDRGP4 uiInfo+99276+10444
ADDRGP4 uiInfo+99276+10448
INDIRI4
ASGNI4
line 1878
;1878:					} else {
ADDRGP4 $1453
JUMPV
LABELV $1452
line 1879
;1879:						uiInfo.serverStatus.motdPaintX = rect->x + rect->w - 2;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 uiInfo+99276+10444
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
SUBF4
CVFI4 4
ASGNI4
line 1880
;1880:					}
LABELV $1453
line 1881
;1881:					uiInfo.serverStatus.motdPaintX2 = -1;
ADDRGP4 uiInfo+99276+10448
CNSTI4 -1
ASGNI4
line 1882
;1882:				}
line 1883
;1883:			} else {
ADDRGP4 $1433
JUMPV
LABELV $1432
line 1885
;1884:				//serverStatus.motdPaintX--;
;1885:				uiInfo.serverStatus.motdPaintX -= 2;
ADDRLP4 4
ADDRGP4 uiInfo+99276+10444
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 1886
;1886:				if (uiInfo.serverStatus.motdPaintX2 >= 0) {
ADDRGP4 uiInfo+99276+10448
INDIRI4
CNSTI4 0
LTI4 $1466
line 1888
;1887:					//serverStatus.motdPaintX2--;
;1888:					uiInfo.serverStatus.motdPaintX2 -= 2;
ADDRLP4 8
ADDRGP4 uiInfo+99276+10448
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 1889
;1889:				}
LABELV $1466
line 1890
;1890:			}
LABELV $1433
line 1891
;1891:		}
LABELV $1424
line 1893
;1892:
;1893:		maxX = rect->x + rect->w - 2;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 1894
;1894:		Text_Paint_Limit(&maxX, uiInfo.serverStatus.motdPaintX, rect->y + rect->h - 3, scale, color, &uiInfo.serverStatus.motd[uiInfo.serverStatus.motdOffset], 0, 0); 
ADDRLP4 0
ARGP4
ADDRGP4 uiInfo+99276+10444
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1077936128
SUBF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 uiInfo+99276+10452
INDIRI4
ADDRGP4 uiInfo+99276+10460
ADDP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint_Limit
CALLV
pop
line 1895
;1895:		if (uiInfo.serverStatus.motdPaintX2 >= 0) {
ADDRGP4 uiInfo+99276+10448
INDIRI4
CNSTI4 0
LTI4 $1478
line 1896
;1896:			float maxX2 = rect->x + rect->w - 2;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 1897
;1897:			Text_Paint_Limit(&maxX2, uiInfo.serverStatus.motdPaintX2, rect->y + rect->h - 3, scale, color, uiInfo.serverStatus.motd, 0, uiInfo.serverStatus.motdOffset); 
ADDRLP4 12
ARGP4
ADDRGP4 uiInfo+99276+10448
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1077936128
SUBF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 uiInfo+99276+10460
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 uiInfo+99276+10452
INDIRI4
ARGI4
ADDRGP4 Text_Paint_Limit
CALLV
pop
line 1898
;1898:		}
LABELV $1478
line 1899
;1899:		if (uiInfo.serverStatus.motdOffset && maxX > 0) {
ADDRGP4 uiInfo+99276+10452
INDIRI4
CNSTI4 0
EQI4 $1488
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $1488
line 1901
;1900:			// if we have an offset ( we are skipping the first part of the string ) and we fit the string
;1901:			if (uiInfo.serverStatus.motdPaintX2 == -1) {
ADDRGP4 uiInfo+99276+10448
INDIRI4
CNSTI4 -1
NEI4 $1489
line 1902
;1902:						uiInfo.serverStatus.motdPaintX2 = rect->x + rect->w - 2;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 uiInfo+99276+10448
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
SUBF4
CVFI4 4
ASGNI4
line 1903
;1903:			}
line 1904
;1904:		} else {
ADDRGP4 $1489
JUMPV
LABELV $1488
line 1905
;1905:			uiInfo.serverStatus.motdPaintX2 = -1;
ADDRGP4 uiInfo+99276+10448
CNSTI4 -1
ASGNI4
line 1906
;1906:		}
LABELV $1489
line 1908
;1907:
;1908:	}
LABELV $1398
line 1909
;1909:}
LABELV $1397
endproc UI_DrawServerMOTD 24 32
proc UI_DrawKeyBindStatus 8 32
line 1911
;1910:
;1911:static void UI_DrawKeyBindStatus(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1913
;1912://	int ofs = 0; TTimo: unused
;1913:	if (Display_KeyBindPending()) {
ADDRLP4 0
ADDRGP4 Display_KeyBindPending
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1501
line 1914
;1914:		Text_Paint(rect->x, rect->y, scale, color, "Waiting for new key... Press ESCAPE to cancel", 0, 0, textStyle);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 $1282
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1915
;1915:	} else {
ADDRGP4 $1502
JUMPV
LABELV $1501
line 1916
;1916:		Text_Paint(rect->x, rect->y, scale, color, "Press ENTER or CLICK to change, Press BACKSPACE to clear", 0, 0, textStyle);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 $1283
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1917
;1917:	}
LABELV $1502
line 1918
;1918:}
LABELV $1500
endproc UI_DrawKeyBindStatus 8 32
proc UI_DrawGLInfo 1336 32
line 1920
;1919:
;1920:static void UI_DrawGLInfo(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1926
;1921:	char * eptr;
;1922:	char buff[1024];
;1923:	const char *lines[64];
;1924:	int y, numLines, i;
;1925:
;1926:	Text_Paint(rect->x + 2, rect->y, scale, color, va("VENDOR: %s", uiInfo.uiDC.glconfig.vendor_string), 0, 30, textStyle);
ADDRGP4 $1504
ARGP4
ADDRGP4 uiInfo+62044+1024
ARGP4
ADDRLP4 1296
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1300
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1300
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDF4
ARGF4
ADDRLP4 1300
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 1296
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 30
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1927
;1927:	Text_Paint(rect->x + 2, rect->y + 15, scale, color, va("VERSION: %s: %s", uiInfo.uiDC.glconfig.version_string,uiInfo.uiDC.glconfig.renderer_string), 0, 30, textStyle);
ADDRGP4 $1507
ARGP4
ADDRGP4 uiInfo+62044+2048
ARGP4
ADDRGP4 uiInfo+62044
ARGP4
ADDRLP4 1304
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1308
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1308
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDF4
ARGF4
ADDRLP4 1308
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1097859072
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 1304
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 30
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1928
;1928:	Text_Paint(rect->x + 2, rect->y + 30, scale, color, va ("PIXELFORMAT: color(%d-bits) Z(%d-bits) stencil(%d-bits)", uiInfo.uiDC.glconfig.colorBits, uiInfo.uiDC.glconfig.depthBits, uiInfo.uiDC.glconfig.stencilBits), 0, 30, textStyle);
ADDRGP4 $1511
ARGP4
ADDRGP4 uiInfo+62044+11272
INDIRI4
ARGI4
ADDRGP4 uiInfo+62044+11276
INDIRI4
ARGI4
ADDRGP4 uiInfo+62044+11280
INDIRI4
ARGI4
ADDRLP4 1312
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1316
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1316
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDF4
ARGF4
ADDRLP4 1316
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1106247680
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 1312
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 30
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1934
;1929:
;1930:	// build null terminated extension strings
;1931:  // TTimo: https://zerowing.idsoftware.com/bugzilla/show_bug.cgi?id=399
;1932:  // in TA this was not directly crashing, but displaying a nasty broken shader right in the middle
;1933:  // brought down the string size to 1024, there's not much that can be shown on the screen anyway
;1934:	Q_strncpyz(buff, uiInfo.uiDC.glconfig.extensions_string, 1024);
ADDRLP4 272
ARGP4
ADDRGP4 uiInfo+62044+3072
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1935
;1935:	eptr = buff;
ADDRLP4 0
ADDRLP4 272
ASGNP4
line 1936
;1936:	y = rect->y + 45;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1110704128
ADDF4
CVFI4 4
ASGNI4
line 1937
;1937:	numLines = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $1521
JUMPV
line 1939
;1938:	while ( y < rect->y + rect->h && *eptr )
;1939:	{
LABELV $1523
line 1941
;1940:		while ( *eptr && *eptr == ' ' )
;1941:			*eptr++ = '\0';
ADDRLP4 1320
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 1320
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 1320
INDIRP4
CNSTI1 0
ASGNI1
LABELV $1524
line 1940
ADDRLP4 1324
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1324
INDIRI4
CNSTI4 0
EQI4 $1526
ADDRLP4 1324
INDIRI4
CNSTI4 32
EQI4 $1523
LABELV $1526
line 1944
;1942:
;1943:		// track start of valid string
;1944:		if (*eptr && *eptr != ' ') {
ADDRLP4 1328
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1328
INDIRI4
CNSTI4 0
EQI4 $1530
ADDRLP4 1328
INDIRI4
CNSTI4 32
EQI4 $1530
line 1945
;1945:			lines[numLines++] = eptr;
ADDRLP4 1332
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 12
ADDRLP4 1332
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1332
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1946
;1946:		}
ADDRGP4 $1530
JUMPV
LABELV $1529
line 1949
;1947:
;1948:		while ( *eptr && *eptr != ' ' )
;1949:			eptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $1530
line 1948
ADDRLP4 1332
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1332
INDIRI4
CNSTI4 0
EQI4 $1532
ADDRLP4 1332
INDIRI4
CNSTI4 32
NEI4 $1529
LABELV $1532
line 1950
;1950:	}
LABELV $1521
line 1938
ADDRLP4 1320
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 1320
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 1320
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
GEF4 $1533
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1524
LABELV $1533
line 1952
;1951:
;1952:	i = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $1535
JUMPV
LABELV $1534
line 1953
;1953:	while (i < numLines) {
line 1954
;1954:		Text_Paint(rect->x + 2, y, scale, color, lines[i++], 0, 20, textStyle);
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDF4
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 1324
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 1324
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1324
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 20
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1955
;1955:		if (i < numLines) {
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
GEI4 $1537
line 1956
;1956:			Text_Paint(rect->x + rect->w / 2, y, scale, color, lines[i++], 0, 20, textStyle);
ADDRLP4 1332
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1332
INDIRP4
INDIRF4
ADDRLP4 1332
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1056964608
MULF4
ADDF4
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 1328
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 1328
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1328
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 20
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1957
;1957:		}
LABELV $1537
line 1958
;1958:		y += 10;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 10
ADDI4
ASGNI4
line 1959
;1959:		if (y > rect->y + rect->h - 11) {
ADDRLP4 1328
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 1328
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 1328
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1093664768
SUBF4
LEF4 $1539
line 1960
;1960:			break;
ADDRGP4 $1536
JUMPV
LABELV $1539
line 1962
;1961:		}
;1962:	}
LABELV $1535
line 1953
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
LTI4 $1534
LABELV $1536
line 1965
;1963:
;1964:
;1965:}
LABELV $1503
endproc UI_DrawGLInfo 1336 32
proc UI_OwnerDraw 20 24
line 1969
;1966:
;1967:// FIXME: table drive
;1968://
;1969:static void UI_OwnerDraw(float x, float y, float w, float h, float text_x, float text_y, int ownerDraw, int ownerDrawFlags, int align, float special, float scale, vec4_t color, qhandle_t shader, int textStyle) {
line 1972
;1970:	rectDef_t rect;
;1971:
;1972:  rect.x = x + text_x;
ADDRLP4 0
ADDRFP4 0
INDIRF4
ADDRFP4 16
INDIRF4
ADDF4
ASGNF4
line 1973
;1973:  rect.y = y + text_y;
ADDRLP4 0+4
ADDRFP4 4
INDIRF4
ADDRFP4 20
INDIRF4
ADDF4
ASGNF4
line 1974
;1974:  rect.w = w;
ADDRLP4 0+8
ADDRFP4 8
INDIRF4
ASGNF4
line 1975
;1975:  rect.h = h;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
ASGNF4
line 1977
;1976:
;1977:  switch (ownerDraw) {
ADDRLP4 16
ADDRFP4 24
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 200
LTI4 $1546
ADDRLP4 16
INDIRI4
CNSTI4 256
GTI4 $1546
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1595-800
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1595
address $1547
address $1548
address $1549
address $1550
address $1551
address $1554
address $1557
address $1561
address $1562
address $1563
address $1564
address $1564
address $1564
address $1564
address $1564
address $1565
address $1565
address $1565
address $1565
address $1565
address $1566
address $1567
address $1569
address $1570
address $1571
address $1572
address $1573
address $1574
address $1575
address $1578
address $1576
address $1579
address $1577
address $1580
address $1581
address $1582
address $1583
address $1585
address $1546
address $1586
address $1587
address $1588
address $1589
address $1590
address $1559
address $1555
address $1568
address $1591
address $1592
address $1593
address $1594
address $1552
address $1558
address $1556
address $1553
address $1560
address $1584
code
LABELV $1547
line 1979
;1978:    case UI_HANDICAP:
;1979:      UI_DrawHandicap(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandicap
CALLV
pop
line 1980
;1980:      break;
ADDRGP4 $1546
JUMPV
LABELV $1548
line 1982
;1981:    case UI_EFFECTS:
;1982:      UI_DrawEffects(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawEffects
CALLV
pop
line 1983
;1983:      break;
ADDRGP4 $1546
JUMPV
LABELV $1549
line 1985
;1984:    case UI_PLAYERMODEL:
;1985:      UI_DrawPlayerModel(&rect);
ADDRLP4 0
ARGP4
ADDRGP4 UI_DrawPlayerModel
CALLV
pop
line 1986
;1986:      break;
ADDRGP4 $1546
JUMPV
LABELV $1550
line 1988
;1987:    case UI_CLANNAME:
;1988:      UI_DrawClanName(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawClanName
CALLV
pop
line 1989
;1989:      break;
ADDRGP4 $1546
JUMPV
LABELV $1551
line 1991
;1990:    case UI_CLANLOGO:
;1991:      UI_DrawClanLogo(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawClanLogo
CALLV
pop
line 1992
;1992:      break;
ADDRGP4 $1546
JUMPV
LABELV $1552
line 1994
;1993:    case UI_CLANCINEMATIC:
;1994:      UI_DrawClanCinematic(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawClanCinematic
CALLV
pop
line 1995
;1995:      break;
ADDRGP4 $1546
JUMPV
LABELV $1553
line 1997
;1996:    case UI_PREVIEWCINEMATIC:
;1997:      UI_DrawPreviewCinematic(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawPreviewCinematic
CALLV
pop
line 1998
;1998:      break;
ADDRGP4 $1546
JUMPV
LABELV $1554
line 2000
;1999:    case UI_GAMETYPE:
;2000:      UI_DrawGameType(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawGameType
CALLV
pop
line 2001
;2001:      break;
ADDRGP4 $1546
JUMPV
LABELV $1555
line 2003
;2002:    case UI_NETGAMETYPE:
;2003:      UI_DrawNetGameType(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawNetGameType
CALLV
pop
line 2004
;2004:      break;
ADDRGP4 $1546
JUMPV
LABELV $1556
line 2006
;2005:    case UI_JOINGAMETYPE:
;2006:	  UI_DrawJoinGameType(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawJoinGameType
CALLV
pop
line 2007
;2007:	  break;
ADDRGP4 $1546
JUMPV
LABELV $1557
line 2009
;2008:    case UI_MAPPREVIEW:
;2009:      UI_DrawMapPreview(&rect, scale, color, qtrue);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 UI_DrawMapPreview
CALLV
pop
line 2010
;2010:      break;
ADDRGP4 $1546
JUMPV
LABELV $1558
line 2012
;2011:    case UI_MAP_TIMETOBEAT:
;2012:      UI_DrawMapTimeToBeat(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawMapTimeToBeat
CALLV
pop
line 2013
;2013:      break;
ADDRGP4 $1546
JUMPV
LABELV $1559
line 2015
;2014:    case UI_MAPCINEMATIC:
;2015:      UI_DrawMapCinematic(&rect, scale, color, qfalse);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawMapCinematic
CALLV
pop
line 2016
;2016:      break;
ADDRGP4 $1546
JUMPV
LABELV $1560
line 2018
;2017:    case UI_STARTMAPCINEMATIC:
;2018:      UI_DrawMapCinematic(&rect, scale, color, qtrue);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 UI_DrawMapCinematic
CALLV
pop
line 2019
;2019:      break;
ADDRGP4 $1546
JUMPV
LABELV $1561
line 2021
;2020:    case UI_SKILL:
;2021:      UI_DrawSkill(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawSkill
CALLV
pop
line 2022
;2022:      break;
ADDRGP4 $1546
JUMPV
LABELV $1562
line 2024
;2023:    case UI_BLUETEAMNAME:
;2024:      UI_DrawTeamName(&rect, scale, color, qtrue, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawTeamName
CALLV
pop
line 2025
;2025:      break;
ADDRGP4 $1546
JUMPV
LABELV $1563
line 2027
;2026:    case UI_REDTEAMNAME:
;2027:      UI_DrawTeamName(&rect, scale, color, qfalse, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawTeamName
CALLV
pop
line 2028
;2028:      break;
ADDRGP4 $1546
JUMPV
LABELV $1564
line 2034
;2029:    case UI_BLUETEAM1:
;2030:		case UI_BLUETEAM2:
;2031:		case UI_BLUETEAM3:
;2032:		case UI_BLUETEAM4:
;2033:		case UI_BLUETEAM5:
;2034:      UI_DrawTeamMember(&rect, scale, color, qtrue, ownerDraw - UI_BLUETEAM1 + 1, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRFP4 24
INDIRI4
CNSTI4 210
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawTeamMember
CALLV
pop
line 2035
;2035:      break;
ADDRGP4 $1546
JUMPV
LABELV $1565
line 2041
;2036:    case UI_REDTEAM1:
;2037:		case UI_REDTEAM2:
;2038:		case UI_REDTEAM3:
;2039:		case UI_REDTEAM4:
;2040:		case UI_REDTEAM5:
;2041:      UI_DrawTeamMember(&rect, scale, color, qfalse, ownerDraw - UI_REDTEAM1 + 1, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRFP4 24
INDIRI4
CNSTI4 215
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawTeamMember
CALLV
pop
line 2042
;2042:      break;
ADDRGP4 $1546
JUMPV
LABELV $1566
line 2044
;2043:		case UI_NETSOURCE:
;2044:      UI_DrawNetSource(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawNetSource
CALLV
pop
line 2045
;2045:			break;
ADDRGP4 $1546
JUMPV
LABELV $1567
line 2047
;2046:    case UI_NETMAPPREVIEW:
;2047:      UI_DrawNetMapPreview(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawNetMapPreview
CALLV
pop
line 2048
;2048:      break;
ADDRGP4 $1546
JUMPV
LABELV $1568
line 2050
;2049:    case UI_NETMAPCINEMATIC:
;2050:      UI_DrawNetMapCinematic(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawNetMapCinematic
CALLV
pop
line 2051
;2051:      break;
ADDRGP4 $1546
JUMPV
LABELV $1569
line 2053
;2052:		case UI_NETFILTER:
;2053:      UI_DrawNetFilter(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawNetFilter
CALLV
pop
line 2054
;2054:			break;
ADDRGP4 $1546
JUMPV
LABELV $1570
line 2056
;2055:		case UI_TIER:
;2056:			UI_DrawTier(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawTier
CALLV
pop
line 2057
;2057:			break;
ADDRGP4 $1546
JUMPV
LABELV $1571
line 2059
;2058:		case UI_OPPONENTMODEL:
;2059:			UI_DrawOpponent(&rect);
ADDRLP4 0
ARGP4
ADDRGP4 UI_DrawOpponent
CALLV
pop
line 2060
;2060:			break;
ADDRGP4 $1546
JUMPV
LABELV $1572
line 2062
;2061:		case UI_TIERMAP1:
;2062:			UI_DrawTierMap(&rect, 0);
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawTierMap
CALLV
pop
line 2063
;2063:			break;
ADDRGP4 $1546
JUMPV
LABELV $1573
line 2065
;2064:		case UI_TIERMAP2:
;2065:			UI_DrawTierMap(&rect, 1);
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 UI_DrawTierMap
CALLV
pop
line 2066
;2066:			break;
ADDRGP4 $1546
JUMPV
LABELV $1574
line 2068
;2067:		case UI_TIERMAP3:
;2068:			UI_DrawTierMap(&rect, 2);
ADDRLP4 0
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 UI_DrawTierMap
CALLV
pop
line 2069
;2069:			break;
ADDRGP4 $1546
JUMPV
LABELV $1575
line 2071
;2070:		case UI_PLAYERLOGO:
;2071:			UI_DrawPlayerLogo(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawPlayerLogo
CALLV
pop
line 2072
;2072:			break;
ADDRGP4 $1546
JUMPV
LABELV $1576
line 2074
;2073:		case UI_PLAYERLOGO_METAL:
;2074:			UI_DrawPlayerLogoMetal(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawPlayerLogoMetal
CALLV
pop
line 2075
;2075:			break;
ADDRGP4 $1546
JUMPV
LABELV $1577
line 2077
;2076:		case UI_PLAYERLOGO_NAME:
;2077:			UI_DrawPlayerLogoName(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawPlayerLogoName
CALLV
pop
line 2078
;2078:			break;
ADDRGP4 $1546
JUMPV
LABELV $1578
line 2080
;2079:		case UI_OPPONENTLOGO:
;2080:			UI_DrawOpponentLogo(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawOpponentLogo
CALLV
pop
line 2081
;2081:			break;
ADDRGP4 $1546
JUMPV
LABELV $1579
line 2083
;2082:		case UI_OPPONENTLOGO_METAL:
;2083:			UI_DrawOpponentLogoMetal(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawOpponentLogoMetal
CALLV
pop
line 2084
;2084:			break;
ADDRGP4 $1546
JUMPV
LABELV $1580
line 2086
;2085:		case UI_OPPONENTLOGO_NAME:
;2086:			UI_DrawOpponentLogoName(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawOpponentLogoName
CALLV
pop
line 2087
;2087:			break;
ADDRGP4 $1546
JUMPV
LABELV $1581
line 2089
;2088:		case UI_TIER_MAPNAME:
;2089:			UI_DrawTierMapName(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawTierMapName
CALLV
pop
line 2090
;2090:			break;
ADDRGP4 $1546
JUMPV
LABELV $1582
line 2092
;2091:		case UI_TIER_GAMETYPE:
;2092:			UI_DrawTierGameType(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawTierGameType
CALLV
pop
line 2093
;2093:			break;
ADDRGP4 $1546
JUMPV
LABELV $1583
line 2095
;2094:		case UI_ALLMAPS_SELECTION:
;2095:			UI_DrawAllMapsSelection(&rect, scale, color, textStyle, qtrue);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 UI_DrawAllMapsSelection
CALLV
pop
line 2096
;2096:			break;
ADDRGP4 $1546
JUMPV
LABELV $1584
line 2098
;2097:		case UI_MAPS_SELECTION:
;2098:			UI_DrawAllMapsSelection(&rect, scale, color, textStyle, qfalse);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawAllMapsSelection
CALLV
pop
line 2099
;2099:			break;
ADDRGP4 $1546
JUMPV
LABELV $1585
line 2101
;2100:		case UI_OPPONENT_NAME:
;2101:			UI_DrawOpponentName(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawOpponentName
CALLV
pop
line 2102
;2102:			break;
ADDRGP4 $1546
JUMPV
LABELV $1586
line 2104
;2103:		case UI_BOTNAME:
;2104:			UI_DrawBotName(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawBotName
CALLV
pop
line 2105
;2105:			break;
ADDRGP4 $1546
JUMPV
LABELV $1587
line 2107
;2106:		case UI_BOTSKILL:
;2107:			UI_DrawBotSkill(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawBotSkill
CALLV
pop
line 2108
;2108:			break;
ADDRGP4 $1546
JUMPV
LABELV $1588
line 2110
;2109:		case UI_REDBLUE:
;2110:			UI_DrawRedBlue(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawRedBlue
CALLV
pop
line 2111
;2111:			break;
ADDRGP4 $1546
JUMPV
LABELV $1589
line 2113
;2112:		case UI_CROSSHAIR:
;2113:			UI_DrawCrosshair(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawCrosshair
CALLV
pop
line 2114
;2114:			break;
ADDRGP4 $1546
JUMPV
LABELV $1590
line 2116
;2115:		case UI_SELECTEDPLAYER:
;2116:			UI_DrawSelectedPlayer(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawSelectedPlayer
CALLV
pop
line 2117
;2117:			break;
ADDRGP4 $1546
JUMPV
LABELV $1591
line 2119
;2118:		case UI_SERVERREFRESHDATE:
;2119:			UI_DrawServerRefreshDate(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawServerRefreshDate
CALLV
pop
line 2120
;2120:			break;
ADDRGP4 $1546
JUMPV
LABELV $1592
line 2122
;2121:		case UI_SERVERMOTD:
;2122:			UI_DrawServerMOTD(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawServerMOTD
CALLV
pop
line 2123
;2123:			break;
ADDRGP4 $1546
JUMPV
LABELV $1593
line 2125
;2124:		case UI_GLINFO:
;2125:			UI_DrawGLInfo(&rect,scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawGLInfo
CALLV
pop
line 2126
;2126:			break;
ADDRGP4 $1546
JUMPV
LABELV $1594
line 2128
;2127:		case UI_KEYBINDSTATUS:
;2128:			UI_DrawKeyBindStatus(&rect,scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawKeyBindStatus
CALLV
pop
line 2129
;2129:			break;
line 2131
;2130:    default:
;2131:      break;
LABELV $1546
line 2134
;2132:  }
;2133:
;2134:}
LABELV $1541
endproc UI_OwnerDraw 20 24
proc UI_OwnerDrawVisible 8 8
line 2136
;2135:
;2136:static qboolean UI_OwnerDrawVisible(int flags) {
line 2137
;2137:	qboolean vis = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1599
JUMPV
LABELV $1598
line 2139
;2138:
;2139:	while (flags) {
line 2141
;2140:
;2141:		if (flags & UI_SHOW_FFA) {
ADDRFP4 0
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $1601
line 2142
;2142:			if (trap_Cvar_VariableValue("g_gametype") != GT_FFA) {
ADDRGP4 $1294
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 0
EQF4 $1603
line 2143
;2143:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2144
;2144:			}
LABELV $1603
line 2145
;2145:			flags &= ~UI_SHOW_FFA;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 2146
;2146:		}
LABELV $1601
line 2148
;2147:
;2148:		if (flags & UI_SHOW_NOTFFA) {
ADDRFP4 0
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $1605
line 2149
;2149:			if (trap_Cvar_VariableValue("g_gametype") == GT_FFA) {
ADDRGP4 $1294
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $1607
line 2150
;2150:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2151
;2151:			}
LABELV $1607
line 2152
;2152:			flags &= ~UI_SHOW_NOTFFA;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -513
BANDI4
ASGNI4
line 2153
;2153:		}
LABELV $1605
line 2155
;2154:
;2155:		if (flags & UI_SHOW_LEADER) {
ADDRFP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1609
line 2157
;2156:			// these need to show when this client can give orders to a player or a group
;2157:			if (!uiInfo.teamLeader) {
ADDRGP4 uiInfo+78880
INDIRI4
CNSTI4 0
NEI4 $1611
line 2158
;2158:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2159
;2159:			} else {
ADDRGP4 $1612
JUMPV
LABELV $1611
line 2161
;2160:				// if showing yourself
;2161:				if (ui_selectedPlayer.integer < uiInfo.myTeamCount && uiInfo.teamClientNums[ui_selectedPlayer.integer] == uiInfo.playerNumber) { 
ADDRGP4 ui_selectedPlayer+12
INDIRI4
ADDRGP4 uiInfo+78860
INDIRI4
GEI4 $1614
ADDRGP4 ui_selectedPlayer+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+82980
ADDP4
INDIRI4
ADDRGP4 uiInfo+78876
INDIRI4
NEI4 $1614
line 2162
;2162:					vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2163
;2163:				}
LABELV $1614
line 2164
;2164:			}
LABELV $1612
line 2165
;2165:			flags &= ~UI_SHOW_LEADER;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 2166
;2166:		} 
LABELV $1609
line 2167
;2167:		if (flags & UI_SHOW_NOTLEADER) {
ADDRFP4 0
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1621
line 2169
;2168:			// these need to show when this client is assigning their own status or they are NOT the leader
;2169:			if (uiInfo.teamLeader) {
ADDRGP4 uiInfo+78880
INDIRI4
CNSTI4 0
EQI4 $1623
line 2171
;2170:				// if not showing yourself
;2171:				if (!(ui_selectedPlayer.integer < uiInfo.myTeamCount && uiInfo.teamClientNums[ui_selectedPlayer.integer] == uiInfo.playerNumber)) { 
ADDRGP4 ui_selectedPlayer+12
INDIRI4
ADDRGP4 uiInfo+78860
INDIRI4
GEI4 $1633
ADDRGP4 ui_selectedPlayer+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+82980
ADDP4
INDIRI4
ADDRGP4 uiInfo+78876
INDIRI4
EQI4 $1626
LABELV $1633
line 2172
;2172:					vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2173
;2173:				}
LABELV $1626
line 2175
;2174:				// these need to show when this client can give orders to a player or a group
;2175:			}
LABELV $1623
line 2176
;2176:			flags &= ~UI_SHOW_NOTLEADER;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 2177
;2177:		} 
LABELV $1621
line 2178
;2178:		if (flags & UI_SHOW_FAVORITESERVERS) {
ADDRFP4 0
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1634
line 2180
;2179:			// this assumes you only put this type of display flag on something showing in the proper context
;2180:			if (ui_netSource.integer != AS_FAVORITES) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 3
EQI4 $1636
line 2181
;2181:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2182
;2182:			}
LABELV $1636
line 2183
;2183:			flags &= ~UI_SHOW_FAVORITESERVERS;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -5
BANDI4
ASGNI4
line 2184
;2184:		} 
LABELV $1634
line 2185
;2185:		if (flags & UI_SHOW_NOTFAVORITESERVERS) {
ADDRFP4 0
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $1639
line 2187
;2186:			// this assumes you only put this type of display flag on something showing in the proper context
;2187:			if (ui_netSource.integer == AS_FAVORITES) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 3
NEI4 $1641
line 2188
;2188:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2189
;2189:			}
LABELV $1641
line 2190
;2190:			flags &= ~UI_SHOW_NOTFAVORITESERVERS;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -4097
BANDI4
ASGNI4
line 2191
;2191:		} 
LABELV $1639
line 2192
;2192:		if (flags & UI_SHOW_ANYTEAMGAME) {
ADDRFP4 0
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1644
line 2193
;2193:			if (uiInfo.gameTypes[ui_gameType.integer].gtEnum <= GT_TEAM ) {
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592+4
ADDP4
INDIRI4
CNSTI4 3
GTI4 $1646
line 2194
;2194:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2195
;2195:			}
LABELV $1646
line 2196
;2196:			flags &= ~UI_SHOW_ANYTEAMGAME;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 2197
;2197:		} 
LABELV $1644
line 2198
;2198:		if (flags & UI_SHOW_ANYNONTEAMGAME) {
ADDRFP4 0
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1651
line 2199
;2199:			if (uiInfo.gameTypes[ui_gameType.integer].gtEnum > GT_TEAM ) {
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592+4
ADDP4
INDIRI4
CNSTI4 3
LEI4 $1653
line 2200
;2200:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2201
;2201:			}
LABELV $1653
line 2202
;2202:			flags &= ~UI_SHOW_ANYNONTEAMGAME;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 2203
;2203:		} 
LABELV $1651
line 2204
;2204:		if (flags & UI_SHOW_NETANYTEAMGAME) {
ADDRFP4 0
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1658
line 2205
;2205:			if (uiInfo.gameTypes[ui_netGameType.integer].gtEnum <= GT_TEAM ) {
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592+4
ADDP4
INDIRI4
CNSTI4 3
GTI4 $1660
line 2206
;2206:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2207
;2207:			}
LABELV $1660
line 2208
;2208:			flags &= ~UI_SHOW_NETANYTEAMGAME;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
line 2209
;2209:		} 
LABELV $1658
line 2210
;2210:		if (flags & UI_SHOW_NETANYNONTEAMGAME) {
ADDRFP4 0
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1665
line 2211
;2211:			if (uiInfo.gameTypes[ui_netGameType.integer].gtEnum > GT_TEAM ) {
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592+4
ADDP4
INDIRI4
CNSTI4 3
LEI4 $1667
line 2212
;2212:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2213
;2213:			}
LABELV $1667
line 2214
;2214:			flags &= ~UI_SHOW_NETANYNONTEAMGAME;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 2215
;2215:		} 
LABELV $1665
line 2216
;2216:		if (flags & UI_SHOW_NEWHIGHSCORE) {
ADDRFP4 0
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1672
line 2217
;2217:			if (uiInfo.newHighScoreTime < uiInfo.uiDC.realTime) {
ADDRGP4 uiInfo+73428
INDIRI4
ADDRGP4 uiInfo+208
INDIRI4
GEI4 $1674
line 2218
;2218:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2219
;2219:			} else {
ADDRGP4 $1675
JUMPV
LABELV $1674
line 2220
;2220:				if (uiInfo.soundHighScore) {
ADDRGP4 uiInfo+73448
INDIRI4
CNSTI4 0
EQI4 $1678
line 2221
;2221:					if (trap_Cvar_VariableValue("sv_killserver") == 0) {
ADDRGP4 $371
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $1681
line 2223
;2222:						// wait on server to go down before playing sound
;2223:						trap_S_StartLocalSound(uiInfo.newHighScoreSound, CHAN_ANNOUNCER);
ADDRGP4 uiInfo+119496
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2224
;2224:						uiInfo.soundHighScore = qfalse;
ADDRGP4 uiInfo+73448
CNSTI4 0
ASGNI4
line 2225
;2225:					}
LABELV $1681
line 2226
;2226:				}
LABELV $1678
line 2227
;2227:			}
LABELV $1675
line 2228
;2228:			flags &= ~UI_SHOW_NEWHIGHSCORE;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -33
BANDI4
ASGNI4
line 2229
;2229:		} 
LABELV $1672
line 2230
;2230:		if (flags & UI_SHOW_NEWBESTTIME) {
ADDRFP4 0
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $1685
line 2231
;2231:			if (uiInfo.newBestTime < uiInfo.uiDC.realTime) {
ADDRGP4 uiInfo+73432
INDIRI4
ADDRGP4 uiInfo+208
INDIRI4
GEI4 $1687
line 2232
;2232:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2233
;2233:			}
LABELV $1687
line 2234
;2234:			flags &= ~UI_SHOW_NEWBESTTIME;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 2235
;2235:		} 
LABELV $1685
line 2236
;2236:		if (flags & UI_SHOW_DEMOAVAILABLE) {
ADDRFP4 0
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $1691
line 2237
;2237:			if (!uiInfo.demoAvailable) {
ADDRGP4 uiInfo+73444
INDIRI4
CNSTI4 0
NEI4 $1693
line 2238
;2238:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2239
;2239:			}
LABELV $1693
line 2240
;2240:			flags &= ~UI_SHOW_DEMOAVAILABLE;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -65
BANDI4
ASGNI4
line 2241
;2241:		} else {
ADDRGP4 $1692
JUMPV
LABELV $1691
line 2242
;2242:			flags = 0;
ADDRFP4 0
CNSTI4 0
ASGNI4
line 2243
;2243:		}
LABELV $1692
line 2244
;2244:	}
LABELV $1599
line 2139
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $1598
line 2245
;2245:  return vis;
ADDRLP4 0
INDIRI4
RETI4
LABELV $1597
endproc UI_OwnerDrawVisible 8 8
proc UI_Handicap_HandleKey 20 12
line 2248
;2246:}
;2247:
;2248:static qboolean UI_Handicap_HandleKey(int flags, float *special, int key) {
line 2249
;2249:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1701
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1701
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1701
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1697
LABELV $1701
line 2251
;2250:    int h;
;2251:    h = Com_Clamp( 5, 100, trap_Cvar_VariableValue("handicap") );
ADDRGP4 $678
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1084227584
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 2252
;2252:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1702
line 2253
;2253:	    h -= 5;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 5
SUBI4
ASGNI4
line 2254
;2254:		} else {
ADDRGP4 $1703
JUMPV
LABELV $1702
line 2255
;2255:	    h += 5;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 5
ADDI4
ASGNI4
line 2256
;2256:		}
LABELV $1703
line 2257
;2257:    if (h > 100) {
ADDRLP4 4
INDIRI4
CNSTI4 100
LEI4 $1704
line 2258
;2258:      h = 5;
ADDRLP4 4
CNSTI4 5
ASGNI4
line 2259
;2259:    } else if (h < 0) {
ADDRGP4 $1705
JUMPV
LABELV $1704
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1706
line 2260
;2260:			h = 100;
ADDRLP4 4
CNSTI4 100
ASGNI4
line 2261
;2261:		}
LABELV $1706
LABELV $1705
line 2262
;2262:  	trap_Cvar_Set( "handicap", va( "%i", h) );
ADDRGP4 $1708
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $678
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2263
;2263:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1696
JUMPV
LABELV $1697
line 2265
;2264:  }
;2265:  return qfalse;
CNSTI4 0
RETI4
LABELV $1696
endproc UI_Handicap_HandleKey 20 12
proc UI_Effects_HandleKey 8 8
line 2268
;2266:}
;2267:
;2268:static qboolean UI_Effects_HandleKey(int flags, float *special, int key) {
line 2269
;2269:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1714
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1714
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1714
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1710
LABELV $1714
line 2271
;2270:
;2271:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1715
line 2272
;2272:	    uiInfo.effectsColor--;
ADDRLP4 4
ADDRGP4 uiInfo+136916
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2273
;2273:		} else {
ADDRGP4 $1716
JUMPV
LABELV $1715
line 2274
;2274:	    uiInfo.effectsColor++;
ADDRLP4 4
ADDRGP4 uiInfo+136916
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2275
;2275:		}
LABELV $1716
line 2277
;2276:
;2277:    if( uiInfo.effectsColor > 6 ) {
ADDRGP4 uiInfo+136916
INDIRI4
CNSTI4 6
LEI4 $1719
line 2278
;2278:	  	uiInfo.effectsColor = 0;
ADDRGP4 uiInfo+136916
CNSTI4 0
ASGNI4
line 2279
;2279:		} else if (uiInfo.effectsColor < 0) {
ADDRGP4 $1720
JUMPV
LABELV $1719
ADDRGP4 uiInfo+136916
INDIRI4
CNSTI4 0
GEI4 $1723
line 2280
;2280:	  	uiInfo.effectsColor = 6;
ADDRGP4 uiInfo+136916
CNSTI4 6
ASGNI4
line 2281
;2281:		}
LABELV $1723
LABELV $1720
line 2283
;2282:
;2283:	  trap_Cvar_SetValue( "color1", uiInfo.effectsColor + 1 );
ADDRGP4 $1727
ARGP4
ADDRGP4 uiInfo+136916
INDIRI4
CNSTI4 1
ADDI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2284
;2284:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1709
JUMPV
LABELV $1710
line 2286
;2285:  }
;2286:  return qfalse;
CNSTI4 0
RETI4
LABELV $1709
endproc UI_Effects_HandleKey 8 8
proc UI_ClanName_HandleKey 16 8
line 2289
;2287:}
;2288:
;2289:static qboolean UI_ClanName_HandleKey(int flags, float *special, int key) {
line 2290
;2290:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1734
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1734
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1734
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1730
LABELV $1734
line 2292
;2291:    int i;
;2292:    i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 8
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
line 2293
;2293:		if (uiInfo.teamList[i].cinematic >= 0) {
ADDRLP4 4
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+40
ADDP4
INDIRI4
CNSTI4 0
LTI4 $1735
line 2294
;2294:		  trap_CIN_StopCinematic(uiInfo.teamList[i].cinematic);
ADDRLP4 4
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+40
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 2295
;2295:			uiInfo.teamList[i].cinematic = -1;
ADDRLP4 4
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+40
ADDP4
CNSTI4 -1
ASGNI4
line 2296
;2296:		}
LABELV $1735
line 2297
;2297:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1743
line 2298
;2298:	    i--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2299
;2299:		} else {
ADDRGP4 $1744
JUMPV
LABELV $1743
line 2300
;2300:	    i++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2301
;2301:		}
LABELV $1744
line 2302
;2302:    if (i >= uiInfo.teamCount) {
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+75768
INDIRI4
LTI4 $1745
line 2303
;2303:      i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2304
;2304:    } else if (i < 0) {
ADDRGP4 $1746
JUMPV
LABELV $1745
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1748
line 2305
;2305:			i = uiInfo.teamCount - 1;
ADDRLP4 4
ADDRGP4 uiInfo+75768
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2306
;2306:		}
LABELV $1748
LABELV $1746
line 2307
;2307:  	trap_Cvar_Set( "ui_teamName", uiInfo.teamList[i].teamName);
ADDRGP4 $680
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2308
;2308:	UI_HeadCountByTeam();
ADDRGP4 UI_HeadCountByTeam
CALLI4
pop
line 2309
;2309:	UI_FeederSelection(FEEDER_HEADS, 0);
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 UI_FeederSelection
CALLV
pop
line 2310
;2310:	updateModel = qtrue;
ADDRGP4 updateModel
CNSTI4 1
ASGNI4
line 2311
;2311:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1729
JUMPV
LABELV $1730
line 2313
;2312:  }
;2313:  return qfalse;
CNSTI4 0
RETI4
LABELV $1729
endproc UI_ClanName_HandleKey 16 8
proc UI_GameType_HandleKey 20 16
line 2316
;2314:}
;2315:
;2316:static qboolean UI_GameType_HandleKey(int flags, float *special, int key, qboolean resetMap) {
line 2317
;2317:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1757
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1757
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1757
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1753
LABELV $1757
line 2318
;2318:		int oldCount = UI_MapCountByGameType(qtrue);
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 UI_MapCountByGameType
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 2321
;2319:
;2320:		// hard coded mess here
;2321:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1758
line 2322
;2322:			ui_gameType.integer--;
ADDRLP4 12
ADDRGP4 ui_gameType+12
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2323
;2323:			if (ui_gameType.integer == 2) {
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 2
NEI4 $1761
line 2324
;2324:				ui_gameType.integer = 1;
ADDRGP4 ui_gameType+12
CNSTI4 1
ASGNI4
line 2325
;2325:			} else if (ui_gameType.integer < 2) {
ADDRGP4 $1759
JUMPV
LABELV $1761
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 2
GEI4 $1759
line 2326
;2326:				ui_gameType.integer = uiInfo.numGameTypes - 1;
ADDRGP4 ui_gameType+12
ADDRGP4 uiInfo+78588
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2327
;2327:			}
line 2328
;2328:		} else {
ADDRGP4 $1759
JUMPV
LABELV $1758
line 2329
;2329:			ui_gameType.integer++;
ADDRLP4 12
ADDRGP4 ui_gameType+12
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2330
;2330:			if (ui_gameType.integer >= uiInfo.numGameTypes) {
ADDRGP4 ui_gameType+12
INDIRI4
ADDRGP4 uiInfo+78588
INDIRI4
LTI4 $1771
line 2331
;2331:				ui_gameType.integer = 1;
ADDRGP4 ui_gameType+12
CNSTI4 1
ASGNI4
line 2332
;2332:			} else if (ui_gameType.integer == 2) {
ADDRGP4 $1772
JUMPV
LABELV $1771
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 2
NEI4 $1776
line 2333
;2333:				ui_gameType.integer = 3;
ADDRGP4 ui_gameType+12
CNSTI4 3
ASGNI4
line 2334
;2334:			}
LABELV $1776
LABELV $1772
line 2335
;2335:		}
LABELV $1759
line 2337
;2336:    
;2337:		if (uiInfo.gameTypes[ui_gameType.integer].gtEnum == GT_TOURNAMENT) {
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592+4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1780
line 2338
;2338:			trap_Cvar_Set("ui_Q3Model", "1");
ADDRGP4 $946
ARGP4
ADDRGP4 $372
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2339
;2339:		} else {
ADDRGP4 $1781
JUMPV
LABELV $1780
line 2340
;2340:			trap_Cvar_Set("ui_Q3Model", "0");
ADDRGP4 $946
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2341
;2341:		}
LABELV $1781
line 2343
;2342:
;2343:		trap_Cvar_Set("ui_gameType", va("%d", ui_gameType.integer));
ADDRGP4 $695
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1785
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2344
;2344:		UI_SetCapFragLimits(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_SetCapFragLimits
CALLV
pop
line 2345
;2345:		UI_LoadBestScores(uiInfo.mapList[ui_currentMap.integer].mapLoadName, uiInfo.gameTypes[ui_gameType.integer].gtEnum);
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592+4
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_LoadBestScores
CALLV
pop
line 2346
;2346:		if (resetMap && oldCount != UI_MapCountByGameType(qtrue)) {
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $1793
CNSTI4 1
ARGI4
ADDRLP4 16
ADDRGP4 UI_MapCountByGameType
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $1793
line 2347
;2347:	  	trap_Cvar_Set( "ui_currentMap", "0");
ADDRGP4 $873
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2348
;2348:			Menu_SetFeederSelection(NULL, FEEDER_MAPS, 0, NULL);
CNSTP4 0
ARGP4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 2349
;2349:		}
LABELV $1793
line 2350
;2350:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1752
JUMPV
LABELV $1753
line 2352
;2351:  }
;2352:  return qfalse;
CNSTI4 0
RETI4
LABELV $1752
endproc UI_GameType_HandleKey 20 16
proc UI_NetGameType_HandleKey 12 16
line 2355
;2353:}
;2354:
;2355:static qboolean UI_NetGameType_HandleKey(int flags, float *special, int key) {
line 2356
;2356:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1800
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1800
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1800
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1796
LABELV $1800
line 2358
;2357:
;2358:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1801
line 2359
;2359:			ui_netGameType.integer--;
ADDRLP4 4
ADDRGP4 ui_netGameType+12
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2360
;2360:		} else {
ADDRGP4 $1802
JUMPV
LABELV $1801
line 2361
;2361:			ui_netGameType.integer++;
ADDRLP4 4
ADDRGP4 ui_netGameType+12
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2362
;2362:		}
LABELV $1802
line 2364
;2363:
;2364:    if (ui_netGameType.integer < 0) {
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 0
GEI4 $1805
line 2365
;2365:      ui_netGameType.integer = uiInfo.numGameTypes - 1;
ADDRGP4 ui_netGameType+12
ADDRGP4 uiInfo+78588
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2366
;2366:		} else if (ui_netGameType.integer >= uiInfo.numGameTypes) {
ADDRGP4 $1806
JUMPV
LABELV $1805
ADDRGP4 ui_netGameType+12
INDIRI4
ADDRGP4 uiInfo+78588
INDIRI4
LTI4 $1810
line 2367
;2367:      ui_netGameType.integer = 0;
ADDRGP4 ui_netGameType+12
CNSTI4 0
ASGNI4
line 2368
;2368:    } 
LABELV $1810
LABELV $1806
line 2370
;2369:
;2370:  	trap_Cvar_Set( "ui_netGameType", va("%d", ui_netGameType.integer));
ADDRGP4 $695
ARGP4
ADDRGP4 ui_netGameType+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $709
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2371
;2371:  	trap_Cvar_Set( "ui_actualnetGameType", va("%d", uiInfo.gameTypes[ui_netGameType.integer].gtEnum));
ADDRGP4 $695
ARGP4
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592+4
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1816
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2372
;2372:  	trap_Cvar_Set( "ui_currentNetMap", "0");
ADDRGP4 $871
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2373
;2373:		UI_MapCountByGameType(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_MapCountByGameType
CALLI4
pop
line 2374
;2374:		Menu_SetFeederSelection(NULL, FEEDER_ALLMAPS, 0, NULL);
CNSTP4 0
ARGP4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 2375
;2375:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1795
JUMPV
LABELV $1796
line 2377
;2376:  }
;2377:  return qfalse;
CNSTI4 0
RETI4
LABELV $1795
endproc UI_NetGameType_HandleKey 12 16
proc UI_JoinGameType_HandleKey 8 8
line 2380
;2378:}
;2379:
;2380:static qboolean UI_JoinGameType_HandleKey(int flags, float *special, int key) {
line 2381
;2381:	if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1825
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1825
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1825
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1821
LABELV $1825
line 2383
;2382:
;2383:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1826
line 2384
;2384:			ui_joinGameType.integer--;
ADDRLP4 4
ADDRGP4 ui_joinGameType+12
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2385
;2385:		} else {
ADDRGP4 $1827
JUMPV
LABELV $1826
line 2386
;2386:			ui_joinGameType.integer++;
ADDRLP4 4
ADDRGP4 ui_joinGameType+12
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2387
;2387:		}
LABELV $1827
line 2389
;2388:
;2389:		if (ui_joinGameType.integer < 0) {
ADDRGP4 ui_joinGameType+12
INDIRI4
CNSTI4 0
GEI4 $1830
line 2390
;2390:			ui_joinGameType.integer = uiInfo.numJoinGameTypes - 1;
ADDRGP4 ui_joinGameType+12
ADDRGP4 uiInfo+78720
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2391
;2391:		} else if (ui_joinGameType.integer >= uiInfo.numJoinGameTypes) {
ADDRGP4 $1831
JUMPV
LABELV $1830
ADDRGP4 ui_joinGameType+12
INDIRI4
ADDRGP4 uiInfo+78720
INDIRI4
LTI4 $1835
line 2392
;2392:			ui_joinGameType.integer = 0;
ADDRGP4 ui_joinGameType+12
CNSTI4 0
ASGNI4
line 2393
;2393:		}
LABELV $1835
LABELV $1831
line 2395
;2394:
;2395:		trap_Cvar_Set( "ui_joinGameType", va("%d", ui_joinGameType.integer));
ADDRGP4 $695
ARGP4
ADDRGP4 ui_joinGameType+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $720
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2396
;2396:		UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 2397
;2397:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1820
JUMPV
LABELV $1821
line 2399
;2398:	}
;2399:	return qfalse;
CNSTI4 0
RETI4
LABELV $1820
endproc UI_JoinGameType_HandleKey 8 8
proc UI_Skill_HandleKey 16 8
line 2404
;2400:}
;2401:
;2402:
;2403:
;2404:static qboolean UI_Skill_HandleKey(int flags, float *special, int key) {
line 2405
;2405:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1846
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1846
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1846
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1842
LABELV $1846
line 2406
;2406:  	int i = trap_Cvar_VariableValue( "g_spSkill" );
ADDRGP4 $806
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 8
INDIRF4
CVFI4 4
ASGNI4
line 2408
;2407:
;2408:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1847
line 2409
;2409:	    i--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2410
;2410:		} else {
ADDRGP4 $1848
JUMPV
LABELV $1847
line 2411
;2411:	    i++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2412
;2412:		}
LABELV $1848
line 2414
;2413:
;2414:    if (i < 1) {
ADDRLP4 4
INDIRI4
CNSTI4 1
GEI4 $1849
line 2415
;2415:			i = numSkillLevels;
ADDRLP4 4
ADDRGP4 numSkillLevels
INDIRI4
ASGNI4
line 2416
;2416:		} else if (i > numSkillLevels) {
ADDRGP4 $1850
JUMPV
LABELV $1849
ADDRLP4 4
INDIRI4
ADDRGP4 numSkillLevels
INDIRI4
LEI4 $1851
line 2417
;2417:      i = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 2418
;2418:    }
LABELV $1851
LABELV $1850
line 2420
;2419:
;2420:    trap_Cvar_Set("g_spSkill", va("%i", i));
ADDRGP4 $1708
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $806
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2421
;2421:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1841
JUMPV
LABELV $1842
line 2423
;2422:  }
;2423:  return qfalse;
CNSTI4 0
RETI4
LABELV $1841
endproc UI_Skill_HandleKey 16 8
proc UI_TeamName_HandleKey 24 8
line 2426
;2424:}
;2425:
;2426:static qboolean UI_TeamName_HandleKey(int flags, float *special, int key, qboolean blue) {
line 2427
;2427:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1858
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1858
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1858
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1854
LABELV $1858
line 2429
;2428:    int i;
;2429:    i = UI_TeamIndexFromName(UI_Cvar_VariableString((blue) ? "ui_blueTeam" : "ui_redTeam"));
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $1860
ADDRLP4 8
ADDRGP4 $812
ASGNP4
ADDRGP4 $1861
JUMPV
LABELV $1860
ADDRLP4 8
ADDRGP4 $813
ASGNP4
LABELV $1861
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 2431
;2430:
;2431:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1862
line 2432
;2432:	    i--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2433
;2433:		} else {
ADDRGP4 $1863
JUMPV
LABELV $1862
line 2434
;2434:	    i++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2435
;2435:		}
LABELV $1863
line 2437
;2436:
;2437:    if (i >= uiInfo.teamCount) {
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+75768
INDIRI4
LTI4 $1864
line 2438
;2438:      i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2439
;2439:    } else if (i < 0) {
ADDRGP4 $1865
JUMPV
LABELV $1864
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1867
line 2440
;2440:			i = uiInfo.teamCount - 1;
ADDRLP4 4
ADDRGP4 uiInfo+75768
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2441
;2441:		}
LABELV $1867
LABELV $1865
line 2443
;2442:
;2443:    trap_Cvar_Set( (blue) ? "ui_blueTeam" : "ui_redTeam", uiInfo.teamList[i].teamName);
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $1872
ADDRLP4 20
ADDRGP4 $812
ASGNP4
ADDRGP4 $1873
JUMPV
LABELV $1872
ADDRLP4 20
ADDRGP4 $813
ASGNP4
LABELV $1873
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2445
;2444:
;2445:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1853
JUMPV
LABELV $1854
line 2447
;2446:  }
;2447:  return qfalse;
CNSTI4 0
RETI4
LABELV $1853
endproc UI_TeamName_HandleKey 24 8
proc UI_TeamMember_HandleKey 32 8
line 2450
;2448:}
;2449:
;2450:static qboolean UI_TeamMember_HandleKey(int flags, float *special, int key, qboolean blue, int num) {
line 2451
;2451:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1879
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1879
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1879
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1875
LABELV $1879
line 2455
;2452:		// 0 - None
;2453:		// 1 - Human
;2454:		// 2..NumCharacters - Bot
;2455:		char *cvar = va(blue ? "ui_blueteam%i" : "ui_redteam%i", num);
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $1881
ADDRLP4 12
ADDRGP4 $828
ASGNP4
ADDRGP4 $1882
JUMPV
LABELV $1881
ADDRLP4 12
ADDRGP4 $829
ASGNP4
LABELV $1882
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
ASGNP4
line 2456
;2456:		int value = trap_Cvar_VariableValue(cvar);
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 20
INDIRF4
CVFI4 4
ASGNI4
line 2458
;2457:
;2458:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1883
line 2459
;2459:			value--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2460
;2460:		} else {
ADDRGP4 $1884
JUMPV
LABELV $1883
line 2461
;2461:			value++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2462
;2462:		}
LABELV $1884
line 2464
;2463:
;2464:		if (ui_actualNetGameType.integer >= GT_TEAM) {
ADDRGP4 ui_actualNetGameType+12
INDIRI4
CNSTI4 3
LTI4 $1885
line 2465
;2465:			if (value >= uiInfo.characterCount + 2) {
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+73452
INDIRI4
CNSTI4 2
ADDI4
LTI4 $1888
line 2466
;2466:				value = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2467
;2467:			} else if (value < 0) {
ADDRGP4 $1886
JUMPV
LABELV $1888
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1886
line 2468
;2468:				value = uiInfo.characterCount + 2 - 1;
ADDRLP4 4
ADDRGP4 uiInfo+73452
INDIRI4
CNSTI4 2
ADDI4
CNSTI4 1
SUBI4
ASGNI4
line 2469
;2469:			}
line 2470
;2470:		} else {
ADDRGP4 $1886
JUMPV
LABELV $1885
line 2471
;2471:			if (value >= UI_GetNumBots() + 2) {
ADDRLP4 24
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 24
INDIRI4
CNSTI4 2
ADDI4
LTI4 $1894
line 2472
;2472:				value = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2473
;2473:			} else if (value < 0) {
ADDRGP4 $1895
JUMPV
LABELV $1894
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1896
line 2474
;2474:				value = UI_GetNumBots() + 2 - 1;
ADDRLP4 28
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 28
INDIRI4
CNSTI4 2
ADDI4
CNSTI4 1
SUBI4
ASGNI4
line 2475
;2475:			}
LABELV $1896
LABELV $1895
line 2476
;2476:		}
LABELV $1886
line 2478
;2477:
;2478:		trap_Cvar_Set(cvar, va("%i", value));
ADDRGP4 $1708
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2479
;2479:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1874
JUMPV
LABELV $1875
line 2481
;2480:  }
;2481:  return qfalse;
CNSTI4 0
RETI4
LABELV $1874
endproc UI_TeamMember_HandleKey 32 8
proc UI_NetSource_HandleKey 12 8
line 2484
;2482:}
;2483:
;2484:static qboolean UI_NetSource_HandleKey(int flags, float *special, int key) {
line 2485
;2485:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1903
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1903
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1903
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1899
LABELV $1903
line 2487
;2486:		
;2487:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1904
line 2488
;2488:			ui_netSource.integer--;
ADDRLP4 4
ADDRGP4 ui_netSource+12
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2489
;2489:			if (ui_netSource.integer == AS_MPLAYER)
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 1
NEI4 $1905
line 2490
;2490:				ui_netSource.integer--;
ADDRLP4 8
ADDRGP4 ui_netSource+12
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2491
;2491:		} else {
ADDRGP4 $1905
JUMPV
LABELV $1904
line 2492
;2492:			ui_netSource.integer++;
ADDRLP4 4
ADDRGP4 ui_netSource+12
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2493
;2493:			if (ui_netSource.integer == AS_MPLAYER)
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 1
NEI4 $1912
line 2494
;2494:				ui_netSource.integer++;
ADDRLP4 8
ADDRGP4 ui_netSource+12
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1912
line 2495
;2495:		}
LABELV $1905
line 2497
;2496:    
;2497:		if (ui_netSource.integer >= numNetSources) {
ADDRGP4 ui_netSource+12
INDIRI4
ADDRGP4 numNetSources
INDIRI4
LTI4 $1916
line 2498
;2498:      ui_netSource.integer = 0;
ADDRGP4 ui_netSource+12
CNSTI4 0
ASGNI4
line 2499
;2499:    } else if (ui_netSource.integer < 0) {
ADDRGP4 $1917
JUMPV
LABELV $1916
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
GEI4 $1920
line 2500
;2500:      ui_netSource.integer = numNetSources - 1;
ADDRGP4 ui_netSource+12
ADDRGP4 numNetSources
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2501
;2501:		}
LABELV $1920
LABELV $1917
line 2503
;2502:
;2503:		UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 2504
;2504:		if (ui_netSource.integer != AS_GLOBAL) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 2
EQI4 $1924
line 2505
;2505:			UI_StartServerRefresh(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_StartServerRefresh
CALLV
pop
line 2506
;2506:		}
LABELV $1924
line 2507
;2507:  	trap_Cvar_Set( "ui_netSource", va("%d", ui_netSource.integer));
ADDRGP4 $695
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1927
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2508
;2508:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1898
JUMPV
LABELV $1899
line 2510
;2509:  }
;2510:  return qfalse;
CNSTI4 0
RETI4
LABELV $1898
endproc UI_NetSource_HandleKey 12 8
proc UI_NetFilter_HandleKey 4 4
line 2513
;2511:}
;2512:
;2513:static qboolean UI_NetFilter_HandleKey(int flags, float *special, int key) {
line 2514
;2514:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1934
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1934
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1934
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1930
LABELV $1934
line 2516
;2515:
;2516:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1935
line 2518
;2517:			//ui_serverFilterType.integer--;
;2518:		} else {
LABELV $1935
line 2520
;2519:			//ui_serverFilterType.integer++;
;2520:		}
LABELV $1936
line 2527
;2521:
;2522:   /* if (ui_serverFilterType.integer >= numServerFilters) {
;2523:      ui_serverFilterType.integer = 0;
;2524:    } else if (ui_serverFilterType.integer < 0) {
;2525:      ui_serverFilterType.integer = numServerFilters - 1;
;2526:		}*/
;2527:		UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 2528
;2528:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1929
JUMPV
LABELV $1930
line 2530
;2529:  }
;2530:  return qfalse;
CNSTI4 0
RETI4
LABELV $1929
endproc UI_NetFilter_HandleKey 4 4
proc UI_OpponentName_HandleKey 4 0
line 2533
;2531:}
;2532:
;2533:static qboolean UI_OpponentName_HandleKey(int flags, float *special, int key) {
line 2534
;2534:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1942
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1942
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1942
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1938
LABELV $1942
line 2535
;2535:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1943
line 2536
;2536:			UI_PriorOpponent();
ADDRGP4 UI_PriorOpponent
CALLV
pop
line 2537
;2537:		} else {
ADDRGP4 $1944
JUMPV
LABELV $1943
line 2538
;2538:			UI_NextOpponent();
ADDRGP4 UI_NextOpponent
CALLV
pop
line 2539
;2539:		}
LABELV $1944
line 2540
;2540:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1937
JUMPV
LABELV $1938
line 2542
;2541:  }
;2542:  return qfalse;
CNSTI4 0
RETI4
LABELV $1937
endproc UI_OpponentName_HandleKey 4 0
proc UI_BotName_HandleKey 24 4
line 2545
;2543:}
;2544:
;2545:static qboolean UI_BotName_HandleKey(int flags, float *special, int key) {
line 2546
;2546:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1950
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1950
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1950
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1946
LABELV $1950
line 2547
;2547:		int game = trap_Cvar_VariableValue("g_gametype");
ADDRGP4 $1294
ARGP4
ADDRLP4 12
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 2548
;2548:		int value = uiInfo.botIndex;
ADDRLP4 4
ADDRGP4 uiInfo+73456
INDIRI4
ASGNI4
line 2550
;2549:
;2550:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1952
line 2551
;2551:			value--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2552
;2552:		} else {
ADDRGP4 $1953
JUMPV
LABELV $1952
line 2553
;2553:			value++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2554
;2554:		}
LABELV $1953
line 2556
;2555:
;2556:		if (game >= GT_TEAM) {
ADDRLP4 8
INDIRI4
CNSTI4 3
LTI4 $1954
line 2557
;2557:			if (value >= uiInfo.characterCount + 2) {
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+73452
INDIRI4
CNSTI4 2
ADDI4
LTI4 $1956
line 2558
;2558:				value = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2559
;2559:			} else if (value < 0) {
ADDRGP4 $1955
JUMPV
LABELV $1956
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1955
line 2560
;2560:				value = uiInfo.characterCount + 2 - 1;
ADDRLP4 4
ADDRGP4 uiInfo+73452
INDIRI4
CNSTI4 2
ADDI4
CNSTI4 1
SUBI4
ASGNI4
line 2561
;2561:			}
line 2562
;2562:		} else {
ADDRGP4 $1955
JUMPV
LABELV $1954
line 2563
;2563:			if (value >= UI_GetNumBots() + 2) {
ADDRLP4 16
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 16
INDIRI4
CNSTI4 2
ADDI4
LTI4 $1962
line 2564
;2564:				value = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2565
;2565:			} else if (value < 0) {
ADDRGP4 $1963
JUMPV
LABELV $1962
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1964
line 2566
;2566:				value = UI_GetNumBots() + 2 - 1;
ADDRLP4 20
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
CNSTI4 2
ADDI4
CNSTI4 1
SUBI4
ASGNI4
line 2567
;2567:			}
LABELV $1964
LABELV $1963
line 2568
;2568:		}
LABELV $1955
line 2569
;2569:		uiInfo.botIndex = value;
ADDRGP4 uiInfo+73456
ADDRLP4 4
INDIRI4
ASGNI4
line 2570
;2570:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1945
JUMPV
LABELV $1946
line 2572
;2571:  }
;2572:  return qfalse;
CNSTI4 0
RETI4
LABELV $1945
endproc UI_BotName_HandleKey 24 4
proc UI_BotSkill_HandleKey 8 0
line 2575
;2573:}
;2574:
;2575:static qboolean UI_BotSkill_HandleKey(int flags, float *special, int key) {
line 2576
;2576:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1972
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1972
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1972
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1968
LABELV $1972
line 2577
;2577:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1973
line 2578
;2578:			uiInfo.skillIndex--;
ADDRLP4 4
ADDRGP4 uiInfo+96684
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2579
;2579:		} else {
ADDRGP4 $1974
JUMPV
LABELV $1973
line 2580
;2580:			uiInfo.skillIndex++;
ADDRLP4 4
ADDRGP4 uiInfo+96684
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2581
;2581:		}
LABELV $1974
line 2582
;2582:		if (uiInfo.skillIndex >= numSkillLevels) {
ADDRGP4 uiInfo+96684
INDIRI4
ADDRGP4 numSkillLevels
INDIRI4
LTI4 $1977
line 2583
;2583:			uiInfo.skillIndex = 0;
ADDRGP4 uiInfo+96684
CNSTI4 0
ASGNI4
line 2584
;2584:		} else if (uiInfo.skillIndex < 0) {
ADDRGP4 $1978
JUMPV
LABELV $1977
ADDRGP4 uiInfo+96684
INDIRI4
CNSTI4 0
GEI4 $1981
line 2585
;2585:			uiInfo.skillIndex = numSkillLevels-1;
ADDRGP4 uiInfo+96684
ADDRGP4 numSkillLevels
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2586
;2586:		}
LABELV $1981
LABELV $1978
line 2587
;2587:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1967
JUMPV
LABELV $1968
line 2589
;2588:  }
;2589:	return qfalse;
CNSTI4 0
RETI4
LABELV $1967
endproc UI_BotSkill_HandleKey 8 0
proc UI_RedBlue_HandleKey 8 0
line 2592
;2590:}
;2591:
;2592:static qboolean UI_RedBlue_HandleKey(int flags, float *special, int key) {
line 2593
;2593:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1990
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1990
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1990
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1986
LABELV $1990
line 2594
;2594:		uiInfo.redBlue ^= 1;
ADDRLP4 4
ADDRGP4 uiInfo+78852
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 2595
;2595:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1985
JUMPV
LABELV $1986
line 2597
;2596:	}
;2597:	return qfalse;
CNSTI4 0
RETI4
LABELV $1985
endproc UI_RedBlue_HandleKey 8 0
proc UI_Crosshair_HandleKey 8 8
line 2600
;2598:}
;2599:
;2600:static qboolean UI_Crosshair_HandleKey(int flags, float *special, int key) {
line 2601
;2601:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1997
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1997
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1997
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1993
LABELV $1997
line 2602
;2602:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1998
line 2603
;2603:			uiInfo.currentCrosshair--;
ADDRLP4 4
ADDRGP4 uiInfo+119488
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2604
;2604:		} else {
ADDRGP4 $1999
JUMPV
LABELV $1998
line 2605
;2605:			uiInfo.currentCrosshair++;
ADDRLP4 4
ADDRGP4 uiInfo+119488
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2606
;2606:		}
LABELV $1999
line 2608
;2607:
;2608:		if (uiInfo.currentCrosshair >= NUM_CROSSHAIRS) {
ADDRGP4 uiInfo+119488
INDIRI4
CNSTI4 10
LTI4 $2002
line 2609
;2609:			uiInfo.currentCrosshair = 0;
ADDRGP4 uiInfo+119488
CNSTI4 0
ASGNI4
line 2610
;2610:		} else if (uiInfo.currentCrosshair < 0) {
ADDRGP4 $2003
JUMPV
LABELV $2002
ADDRGP4 uiInfo+119488
INDIRI4
CNSTI4 0
GEI4 $2006
line 2611
;2611:			uiInfo.currentCrosshair = NUM_CROSSHAIRS - 1;
ADDRGP4 uiInfo+119488
CNSTI4 9
ASGNI4
line 2612
;2612:		}
LABELV $2006
LABELV $2003
line 2613
;2613:		trap_Cvar_Set("cg_drawCrosshair", va("%d", uiInfo.currentCrosshair)); 
ADDRGP4 $695
ARGP4
ADDRGP4 uiInfo+119488
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2010
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2614
;2614:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1992
JUMPV
LABELV $1993
line 2616
;2615:	}
;2616:	return qfalse;
CNSTI4 0
RETI4
LABELV $1992
endproc UI_Crosshair_HandleKey 8 8
proc UI_SelectedPlayer_HandleKey 16 8
line 2621
;2617:}
;2618:
;2619:
;2620:
;2621:static qboolean UI_SelectedPlayer_HandleKey(int flags, float *special, int key) {
line 2622
;2622:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $2017
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $2017
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $2017
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $2013
LABELV $2017
line 2625
;2623:		int selected;
;2624:
;2625:		UI_BuildPlayerList();
ADDRGP4 UI_BuildPlayerList
CALLV
pop
line 2626
;2626:		if (!uiInfo.teamLeader) {
ADDRGP4 uiInfo+78880
INDIRI4
CNSTI4 0
NEI4 $2018
line 2627
;2627:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2012
JUMPV
LABELV $2018
line 2629
;2628:		}
;2629:		selected = trap_Cvar_VariableValue("cg_selectedPlayer");
ADDRGP4 $1362
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 8
INDIRF4
CVFI4 4
ASGNI4
line 2631
;2630:		
;2631:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $2021
line 2632
;2632:			selected--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2633
;2633:		} else {
ADDRGP4 $2022
JUMPV
LABELV $2021
line 2634
;2634:			selected++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2635
;2635:		}
LABELV $2022
line 2637
;2636:
;2637:		if (selected > uiInfo.myTeamCount) {
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+78860
INDIRI4
LEI4 $2023
line 2638
;2638:			selected = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2639
;2639:		} else if (selected < 0) {
ADDRGP4 $2024
JUMPV
LABELV $2023
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $2026
line 2640
;2640:			selected = uiInfo.myTeamCount;
ADDRLP4 4
ADDRGP4 uiInfo+78860
INDIRI4
ASGNI4
line 2641
;2641:		}
LABELV $2026
LABELV $2024
line 2643
;2642:
;2643:		if (selected == uiInfo.myTeamCount) {
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+78860
INDIRI4
NEI4 $2029
line 2644
;2644:		 	trap_Cvar_Set( "cg_selectedPlayerName", "Everyone");
ADDRGP4 $1370
ARGP4
ADDRGP4 $2032
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2645
;2645:		} else {
ADDRGP4 $2030
JUMPV
LABELV $2029
line 2646
;2646:		 	trap_Cvar_Set( "cg_selectedPlayerName", uiInfo.teamNames[selected]);
ADDRGP4 $1370
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+80932
ADDP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2647
;2647:		}
LABELV $2030
line 2648
;2648:	 	trap_Cvar_Set( "cg_selectedPlayer", va("%d", selected));
ADDRGP4 $695
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1362
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2649
;2649:	}
LABELV $2013
line 2650
;2650:	return qfalse;
CNSTI4 0
RETI4
LABELV $2012
endproc UI_SelectedPlayer_HandleKey 16 8
proc UI_OwnerDrawHandleKey 48 20
line 2654
;2651:}
;2652:
;2653:
;2654:static qboolean UI_OwnerDrawHandleKey(int ownerDraw, int flags, float *special, int key) {
line 2655
;2655:  switch (ownerDraw) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 200
LTI4 $2036
ADDRLP4 0
INDIRI4
CNSTI4 253
GTI4 $2036
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2056-800
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $2056
address $2037
address $2038
address $2036
address $2039
address $2036
address $2040
address $2036
address $2043
address $2044
address $2045
address $2046
address $2046
address $2046
address $2046
address $2046
address $2047
address $2047
address $2047
address $2047
address $2047
address $2048
address $2036
address $2049
address $2036
address $2036
address $2036
address $2036
address $2036
address $2036
address $2036
address $2036
address $2036
address $2036
address $2036
address $2036
address $2036
address $2036
address $2050
address $2036
address $2051
address $2052
address $2053
address $2054
address $2055
address $2036
address $2041
address $2036
address $2036
address $2036
address $2036
address $2036
address $2036
address $2036
address $2042
code
LABELV $2037
line 2657
;2656:    case UI_HANDICAP:
;2657:      return UI_Handicap_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 UI_Handicap_HandleKey
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $2034
JUMPV
line 2658
;2658:      break;
LABELV $2038
line 2660
;2659:    case UI_EFFECTS:
;2660:      return UI_Effects_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 UI_Effects_HandleKey
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $2034
JUMPV
line 2661
;2661:      break;
LABELV $2039
line 2663
;2662:    case UI_CLANNAME:
;2663:      return UI_ClanName_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 UI_ClanName_HandleKey
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $2034
JUMPV
line 2664
;2664:      break;
LABELV $2040
line 2666
;2665:    case UI_GAMETYPE:
;2666:      return UI_GameType_HandleKey(flags, special, key, qtrue);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 16
ADDRGP4 UI_GameType_HandleKey
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
RETI4
ADDRGP4 $2034
JUMPV
line 2667
;2667:      break;
LABELV $2041
line 2669
;2668:    case UI_NETGAMETYPE:
;2669:      return UI_NetGameType_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 UI_NetGameType_HandleKey
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $2034
JUMPV
line 2670
;2670:      break;
LABELV $2042
line 2672
;2671:    case UI_JOINGAMETYPE:
;2672:      return UI_JoinGameType_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 UI_JoinGameType_HandleKey
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
RETI4
ADDRGP4 $2034
JUMPV
line 2673
;2673:      break;
LABELV $2043
line 2675
;2674:    case UI_SKILL:
;2675:      return UI_Skill_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 UI_Skill_HandleKey
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
RETI4
ADDRGP4 $2034
JUMPV
line 2676
;2676:      break;
LABELV $2044
line 2678
;2677:    case UI_BLUETEAMNAME:
;2678:      return UI_TeamName_HandleKey(flags, special, key, qtrue);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 32
ADDRGP4 UI_TeamName_HandleKey
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
RETI4
ADDRGP4 $2034
JUMPV
line 2679
;2679:      break;
LABELV $2045
line 2681
;2680:    case UI_REDTEAMNAME:
;2681:      return UI_TeamName_HandleKey(flags, special, key, qfalse);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 36
ADDRGP4 UI_TeamName_HandleKey
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
RETI4
ADDRGP4 $2034
JUMPV
line 2682
;2682:      break;
LABELV $2046
line 2688
;2683:    case UI_BLUETEAM1:
;2684:		case UI_BLUETEAM2:
;2685:		case UI_BLUETEAM3:
;2686:		case UI_BLUETEAM4:
;2687:		case UI_BLUETEAM5:
;2688:      UI_TeamMember_HandleKey(flags, special, key, qtrue, ownerDraw - UI_BLUETEAM1 + 1);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRFP4 0
INDIRI4
CNSTI4 210
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 UI_TeamMember_HandleKey
CALLI4
pop
line 2689
;2689:      break;
ADDRGP4 $2036
JUMPV
LABELV $2047
line 2695
;2690:    case UI_REDTEAM1:
;2691:		case UI_REDTEAM2:
;2692:		case UI_REDTEAM3:
;2693:		case UI_REDTEAM4:
;2694:		case UI_REDTEAM5:
;2695:      UI_TeamMember_HandleKey(flags, special, key, qfalse, ownerDraw - UI_REDTEAM1 + 1);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRFP4 0
INDIRI4
CNSTI4 215
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 UI_TeamMember_HandleKey
CALLI4
pop
line 2696
;2696:      break;
ADDRGP4 $2036
JUMPV
LABELV $2048
line 2698
;2697:		case UI_NETSOURCE:
;2698:      UI_NetSource_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 UI_NetSource_HandleKey
CALLI4
pop
line 2699
;2699:			break;
ADDRGP4 $2036
JUMPV
LABELV $2049
line 2701
;2700:		case UI_NETFILTER:
;2701:      UI_NetFilter_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 UI_NetFilter_HandleKey
CALLI4
pop
line 2702
;2702:			break;
ADDRGP4 $2036
JUMPV
LABELV $2050
line 2704
;2703:		case UI_OPPONENT_NAME:
;2704:			UI_OpponentName_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 UI_OpponentName_HandleKey
CALLI4
pop
line 2705
;2705:			break;
ADDRGP4 $2036
JUMPV
LABELV $2051
line 2707
;2706:		case UI_BOTNAME:
;2707:			return UI_BotName_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 UI_BotName_HandleKey
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
RETI4
ADDRGP4 $2034
JUMPV
line 2708
;2708:			break;
LABELV $2052
line 2710
;2709:		case UI_BOTSKILL:
;2710:			return UI_BotSkill_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 UI_BotSkill_HandleKey
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
RETI4
ADDRGP4 $2034
JUMPV
line 2711
;2711:			break;
LABELV $2053
line 2713
;2712:		case UI_REDBLUE:
;2713:			UI_RedBlue_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 UI_RedBlue_HandleKey
CALLI4
pop
line 2714
;2714:			break;
ADDRGP4 $2036
JUMPV
LABELV $2054
line 2716
;2715:		case UI_CROSSHAIR:
;2716:			UI_Crosshair_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 UI_Crosshair_HandleKey
CALLI4
pop
line 2717
;2717:			break;
ADDRGP4 $2036
JUMPV
LABELV $2055
line 2719
;2718:		case UI_SELECTEDPLAYER:
;2719:			UI_SelectedPlayer_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 UI_SelectedPlayer_HandleKey
CALLI4
pop
line 2720
;2720:			break;
line 2722
;2721:    default:
;2722:      break;
LABELV $2036
line 2725
;2723:  }
;2724:
;2725:  return qfalse;
CNSTI4 0
RETI4
LABELV $2034
endproc UI_OwnerDrawHandleKey 48 20
proc UI_GetValue 0 0
line 2729
;2726:}
;2727:
;2728:
;2729:static float UI_GetValue(int ownerDraw) {
line 2730
;2730:  return 0;
CNSTF4 0
RETF4
LABELV $2058
endproc UI_GetValue 0 0
proc UI_ServersQsortCompare 4 20
line 2738
;2731:}
;2732:
;2733:/*
;2734:=================
;2735:UI_ServersQsortCompare
;2736:=================
;2737:*/
;2738:static int QDECL UI_ServersQsortCompare( const void *arg1, const void *arg2 ) {
line 2739
;2739:	return trap_LAN_CompareServers( ui_netSource.integer, uiInfo.serverStatus.sortKey, uiInfo.serverStatus.sortDir, *(int*)arg1, *(int*)arg2);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 uiInfo+99276+2200
INDIRI4
ARGI4
ADDRGP4 uiInfo+99276+2204
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 trap_LAN_CompareServers
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $2059
endproc UI_ServersQsortCompare 4 20
export UI_ServersSort
proc UI_ServersSort 0 16
line 2748
;2740:}
;2741:
;2742:
;2743:/*
;2744:=================
;2745:UI_ServersSort
;2746:=================
;2747:*/
;2748:void UI_ServersSort(int column, qboolean force) {
line 2750
;2749:
;2750:	if ( !force ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $2066
line 2751
;2751:		if ( uiInfo.serverStatus.sortKey == column ) {
ADDRGP4 uiInfo+99276+2200
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $2068
line 2752
;2752:			return;
ADDRGP4 $2065
JUMPV
LABELV $2068
line 2754
;2753:		}
;2754:	}
LABELV $2066
line 2756
;2755:
;2756:	uiInfo.serverStatus.sortKey = column;
ADDRGP4 uiInfo+99276+2200
ADDRFP4 0
INDIRI4
ASGNI4
line 2757
;2757:	qsort( &uiInfo.serverStatus.displayServers[0], uiInfo.serverStatus.numDisplayServers, sizeof(int), UI_ServersQsortCompare);
ADDRGP4 uiInfo+99276+2220
ARGP4
ADDRGP4 uiInfo+99276+10412
INDIRI4
CVIU4 4
ARGU4
CNSTU4 4
ARGU4
ADDRGP4 UI_ServersQsortCompare
ARGP4
ADDRGP4 qsort
CALLV
pop
line 2758
;2758:}
LABELV $2065
endproc UI_ServersSort 0 16
proc UI_LoadMods 2100 16
line 2805
;2759:
;2760:/*
;2761:static void UI_StartSinglePlayer() {
;2762:	int i,j, k, skill;
;2763:	char buff[1024];
;2764:	i = trap_Cvar_VariableValue( "ui_currentTier" );
;2765:  if (i < 0 || i >= tierCount) {
;2766:    i = 0;
;2767:  }
;2768:	j = trap_Cvar_VariableValue("ui_currentMap");
;2769:	if (j < 0 || j > MAPS_PER_TIER) {
;2770:		j = 0;
;2771:	}
;2772:
;2773: 	trap_Cvar_SetValue( "singleplayer", 1 );
;2774: 	trap_Cvar_SetValue( "g_gametype", Com_Clamp( 0, 7, tierList[i].gameTypes[j] ) );
;2775:	trap_Cmd_ExecuteText( EXEC_APPEND, va( "wait ; wait ; map %s\n", tierList[i].maps[j] ) );
;2776:	skill = trap_Cvar_VariableValue( "g_spSkill" );
;2777:
;2778:	if (j == MAPS_PER_TIER-1) {
;2779:		k = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
;2780:		Com_sprintf( buff, sizeof(buff), "wait ; addbot %s %i %s 250 %s\n", UI_AIFromName(teamList[k].teamMembers[0]), skill, "", teamList[k].teamMembers[0]);
;2781:	} else {
;2782:		k = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
;2783:		for (i = 0; i < PLAYERS_PER_TEAM; i++) {
;2784:			Com_sprintf( buff, sizeof(buff), "wait ; addbot %s %i %s 250 %s\n", UI_AIFromName(teamList[k].teamMembers[i]), skill, "Blue", teamList[k].teamMembers[i]);
;2785:			trap_Cmd_ExecuteText( EXEC_APPEND, buff );
;2786:		}
;2787:
;2788:		k = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
;2789:		for (i = 1; i < PLAYERS_PER_TEAM; i++) {
;2790:			Com_sprintf( buff, sizeof(buff), "wait ; addbot %s %i %s 250 %s\n", UI_AIFromName(teamList[k].teamMembers[i]), skill, "Red", teamList[k].teamMembers[i]);
;2791:			trap_Cmd_ExecuteText( EXEC_APPEND, buff );
;2792:		}
;2793:		trap_Cmd_ExecuteText( EXEC_APPEND, "wait 5; team Red\n" );
;2794:	}
;2795:	
;2796:
;2797:}
;2798:*/
;2799:
;2800:/*
;2801:===============
;2802:UI_LoadMods
;2803:===============
;2804:*/
;2805:static void UI_LoadMods() {
line 2813
;2806:	int		numdirs;
;2807:	char	dirlist[2048];
;2808:	char	*dirptr;
;2809:	char	*descptr;
;2810:	int		i;
;2811:	int		dirlen;
;2812:
;2813:	uiInfo.modCount = 1;
ADDRGP4 uiInfo+97200
CNSTI4 1
ASGNI4
line 2814
;2814:	uiInfo.modList[uiInfo.modCount].modName = String_Alloc("Quake III Arena"); 
ADDRGP4 $2082
ARGP4
ADDRLP4 2068
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+97200
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+96688
ADDP4
ADDRLP4 2068
INDIRP4
ASGNP4
line 2815
;2815:	uiInfo.modList[uiInfo.modCount].modDescr = String_Alloc("");
ADDRGP4 $110
ARGP4
ADDRLP4 2072
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+97200
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+96688+4
ADDP4
ADDRLP4 2072
INDIRP4
ASGNP4
line 2817
;2816:
;2817:	numdirs = trap_FS_GetFileList( "$modlist", "", dirlist, sizeof(dirlist) );
ADDRGP4 $2086
ARGP4
ADDRGP4 $110
ARGP4
ADDRLP4 20
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 2076
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 2076
INDIRI4
ASGNI4
line 2818
;2818:	dirptr  = dirlist;
ADDRLP4 0
ADDRLP4 20
ASGNP4
line 2819
;2819:	for( i = 0; i < numdirs; i++ ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $2090
JUMPV
LABELV $2087
line 2820
;2820:		dirlen = strlen( dirptr ) + 1;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 2080
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 8
ADDRLP4 2080
INDIRU4
CNSTU4 1
ADDU4
CVUI4 4
ASGNI4
line 2821
;2821:		descptr = dirptr + dirlen;
ADDRLP4 4
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 2822
;2822:		uiInfo.modList[uiInfo.modCount].modName = String_Alloc(dirptr);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 2084
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+97200
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+96688
ADDP4
ADDRLP4 2084
INDIRP4
ASGNP4
line 2823
;2823:		uiInfo.modList[uiInfo.modCount].modDescr = String_Alloc(descptr);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 2088
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+97200
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+96688+4
ADDP4
ADDRLP4 2088
INDIRP4
ASGNP4
line 2824
;2824:		dirptr += dirlen + strlen(descptr) + 1;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 2092
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 0
ADDRLP4 8
INDIRI4
CVIU4 4
ADDRLP4 2092
INDIRU4
ADDU4
CNSTU4 1
ADDU4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 2826
;2825:
;2826:		uiInfo.modCount++;
ADDRLP4 2096
ADDRGP4 uiInfo+97200
ASGNP4
ADDRLP4 2096
INDIRP4
ADDRLP4 2096
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2827
;2827:		if (uiInfo.modCount >= MAX_MODS) {
ADDRGP4 uiInfo+97200
INDIRI4
CNSTI4 64
LTI4 $2097
line 2828
;2828:			break;
ADDRGP4 $2089
JUMPV
LABELV $2097
line 2830
;2829:		}
;2830:	}
LABELV $2088
line 2819
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2090
ADDRLP4 12
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $2087
LABELV $2089
line 2832
;2831:
;2832:}
LABELV $2078
endproc UI_LoadMods 2100 16
proc UI_LoadTeams 4120 16
line 2840
;2833:
;2834:
;2835:/*
;2836:===============
;2837:UI_LoadTeams
;2838:===============
;2839:*/
;2840:static void UI_LoadTeams() {
line 2845
;2841:	char	teamList[4096];
;2842:	char	*teamName;
;2843:	int		i, len, count;
;2844:
;2845:	count = trap_FS_GetFileList( "", "team", teamList, 4096 );
ADDRGP4 $110
ARGP4
ADDRGP4 $2101
ARGP4
ADDRLP4 16
ARGP4
CNSTI4 4096
ARGI4
ADDRLP4 4112
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 4112
INDIRI4
ASGNI4
line 2847
;2846:
;2847:	if (count) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2102
line 2848
;2848:		teamName = teamList;
ADDRLP4 0
ADDRLP4 16
ASGNP4
line 2849
;2849:		for ( i = 0; i < count; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2107
JUMPV
LABELV $2104
line 2850
;2850:			len = strlen( teamName );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4116
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 8
ADDRLP4 4116
INDIRU4
CVUI4 4
ASGNI4
line 2851
;2851:			UI_ParseTeamInfo(teamName);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 UI_ParseTeamInfo
CALLV
pop
line 2852
;2852:			teamName += len + 1;
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 2853
;2853:		}
LABELV $2105
line 2849
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2107
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
LTI4 $2104
line 2854
;2854:	}
LABELV $2102
line 2856
;2855:
;2856:}
LABELV $2100
endproc UI_LoadTeams 4120 16
proc UI_LoadMovies 4124 16
line 2864
;2857:
;2858:
;2859:/*
;2860:===============
;2861:UI_LoadMovies
;2862:===============
;2863:*/
;2864:static void UI_LoadMovies() {
line 2869
;2865:	char	movielist[4096];
;2866:	char	*moviename;
;2867:	int		i, len;
;2868:
;2869:	uiInfo.movieCount = trap_FS_GetFileList( "video", "roq", movielist, 4096 );
ADDRGP4 $2110
ARGP4
ADDRGP4 $2111
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 4096
ARGI4
ADDRLP4 4108
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRGP4 uiInfo+99264
ADDRLP4 4108
INDIRI4
ASGNI4
line 2871
;2870:
;2871:	if (uiInfo.movieCount) {
ADDRGP4 uiInfo+99264
INDIRI4
CNSTI4 0
EQI4 $2112
line 2872
;2872:		if (uiInfo.movieCount > MAX_MOVIES) {
ADDRGP4 uiInfo+99264
INDIRI4
CNSTI4 256
LEI4 $2115
line 2873
;2873:			uiInfo.movieCount = MAX_MOVIES;
ADDRGP4 uiInfo+99264
CNSTI4 256
ASGNI4
line 2874
;2874:		}
LABELV $2115
line 2875
;2875:		moviename = movielist;
ADDRLP4 0
ADDRLP4 12
ASGNP4
line 2876
;2876:		for ( i = 0; i < uiInfo.movieCount; i++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $2122
JUMPV
LABELV $2119
line 2877
;2877:			len = strlen( moviename );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4112
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 4
ADDRLP4 4112
INDIRU4
CVUI4 4
ASGNI4
line 2878
;2878:			if (!Q_stricmp(moviename +  len - 4,".roq")) {
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
CNSTI4 -4
ADDP4
ARGP4
ADDRGP4 $2126
ARGP4
ADDRLP4 4116
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4116
INDIRI4
CNSTI4 0
NEI4 $2124
line 2879
;2879:				moviename[len-4] = '\0';
ADDRLP4 4
INDIRI4
CNSTI4 4
SUBI4
ADDRLP4 0
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 2880
;2880:			}
LABELV $2124
line 2881
;2881:			Q_strupr(moviename);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 2882
;2882:			uiInfo.movieList[i] = String_Alloc(moviename);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4120
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+98240
ADDP4
ADDRLP4 4120
INDIRP4
ASGNP4
line 2883
;2883:			moviename += len + 1;
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 2884
;2884:		}
LABELV $2120
line 2876
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2122
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+99264
INDIRI4
LTI4 $2119
line 2885
;2885:	}
LABELV $2112
line 2887
;2886:
;2887:}
LABELV $2108
endproc UI_LoadMovies 4124 16
proc UI_LoadDemos 4168 16
line 2896
;2888:
;2889:
;2890:
;2891:/*
;2892:===============
;2893:UI_LoadDemos
;2894:===============
;2895:*/
;2896:static void UI_LoadDemos() {
line 2902
;2897:	char	demolist[4096];
;2898:	char demoExt[32];
;2899:	char	*demoname;
;2900:	int		i, len;
;2901:
;2902:	Com_sprintf(demoExt, sizeof(demoExt), "dm_%d", (int)trap_Cvar_VariableValue("protocol"));
ADDRGP4 $2130
ARGP4
ADDRLP4 4140
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $2129
ARGP4
ADDRLP4 4140
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 2904
;2903:
;2904:	uiInfo.demoCount = trap_FS_GetFileList( "demos", demoExt, demolist, 4096 );
ADDRGP4 $2132
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 44
ARGP4
CNSTI4 4096
ARGI4
ADDRLP4 4144
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRGP4 uiInfo+98232
ADDRLP4 4144
INDIRI4
ASGNI4
line 2906
;2905:
;2906:	Com_sprintf(demoExt, sizeof(demoExt), ".dm_%d", (int)trap_Cvar_VariableValue("protocol"));
ADDRGP4 $2130
ARGP4
ADDRLP4 4148
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $2133
ARGP4
ADDRLP4 4148
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 2908
;2907:
;2908:	if (uiInfo.demoCount) {
ADDRGP4 uiInfo+98232
INDIRI4
CNSTI4 0
EQI4 $2134
line 2909
;2909:		if (uiInfo.demoCount > MAX_DEMOS) {
ADDRGP4 uiInfo+98232
INDIRI4
CNSTI4 256
LEI4 $2137
line 2910
;2910:			uiInfo.demoCount = MAX_DEMOS;
ADDRGP4 uiInfo+98232
CNSTI4 256
ASGNI4
line 2911
;2911:		}
LABELV $2137
line 2912
;2912:		demoname = demolist;
ADDRLP4 0
ADDRLP4 44
ASGNP4
line 2913
;2913:		for ( i = 0; i < uiInfo.demoCount; i++ ) {
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRGP4 $2144
JUMPV
LABELV $2141
line 2914
;2914:			len = strlen( demoname );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4152
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 36
ADDRLP4 4152
INDIRU4
CVUI4 4
ASGNI4
line 2915
;2915:			if (!Q_stricmp(demoname +  len - strlen(demoExt), demoExt)) {
ADDRLP4 4
ARGP4
ADDRLP4 4156
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 36
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
ADDRLP4 4156
INDIRU4
SUBP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 4160
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4160
INDIRI4
CNSTI4 0
NEI4 $2146
line 2916
;2916:				demoname[len-strlen(demoExt)] = '\0';
ADDRLP4 4
ARGP4
ADDRLP4 4164
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 36
INDIRI4
CVIU4 4
ADDRLP4 4164
INDIRU4
SUBU4
ADDRLP4 0
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 2917
;2917:			}
LABELV $2146
line 2918
;2918:			Q_strupr(demoname);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 2919
;2919:			uiInfo.demoList[i] = String_Alloc(demoname);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4164
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRLP4 40
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+97208
ADDP4
ADDRLP4 4164
INDIRP4
ASGNP4
line 2920
;2920:			demoname += len + 1;
ADDRLP4 0
ADDRLP4 36
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 2921
;2921:		}
LABELV $2142
line 2913
ADDRLP4 40
ADDRLP4 40
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2144
ADDRLP4 40
INDIRI4
ADDRGP4 uiInfo+98232
INDIRI4
LTI4 $2141
line 2922
;2922:	}
LABELV $2134
line 2924
;2923:
;2924:}
LABELV $2128
endproc UI_LoadDemos 4168 16
proc UI_SetNextMap 4 16
line 2927
;2925:
;2926:
;2927:static qboolean UI_SetNextMap(int actual, int index) {
line 2929
;2928:	int i;
;2929:	for (i = actual + 1; i < uiInfo.mapCount; i++) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $2153
JUMPV
LABELV $2150
line 2930
;2930:		if (uiInfo.mapList[i].active) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+96
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2155
line 2931
;2931:			Menu_SetFeederSelection(NULL, FEEDER_MAPS, index + 1, "skirmish");
CNSTP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 $2159
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 2932
;2932:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2149
JUMPV
LABELV $2155
line 2934
;2933:		}
;2934:	}
LABELV $2151
line 2929
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2153
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+83236
INDIRI4
LTI4 $2150
line 2935
;2935:	return qfalse;
CNSTI4 0
RETI4
LABELV $2149
endproc UI_SetNextMap 4 16
proc UI_StartSkirmish 1160 32
line 2939
;2936:}
;2937:
;2938:
;2939:static void UI_StartSkirmish(qboolean next) {
line 2944
;2940:	int i, k, g, delay, temp;
;2941:	float skill;
;2942:	char buff[MAX_STRING_CHARS];
;2943:
;2944:	if (next) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $2161
line 2946
;2945:		int actual;
;2946:		int index = trap_Cvar_VariableValue("ui_mapIndex");
ADDRGP4 $2163
ARGP4
ADDRLP4 1056
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1048
ADDRLP4 1056
INDIRF4
CVFI4 4
ASGNI4
line 2947
;2947:	 	UI_MapCountByGameType(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_MapCountByGameType
CALLI4
pop
line 2948
;2948:		UI_SelectedMap(index, &actual);
ADDRLP4 1048
INDIRI4
ARGI4
ADDRLP4 1052
ARGP4
ADDRGP4 UI_SelectedMap
CALLP4
pop
line 2949
;2949:		if (UI_SetNextMap(actual, index)) {
ADDRLP4 1052
INDIRI4
ARGI4
ADDRLP4 1048
INDIRI4
ARGI4
ADDRLP4 1060
ADDRGP4 UI_SetNextMap
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
EQI4 $2164
line 2950
;2950:		} else {
ADDRGP4 $2165
JUMPV
LABELV $2164
line 2951
;2951:			UI_GameType_HandleKey(0, 0, K_MOUSE1, qfalse);
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
CNSTI4 178
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_GameType_HandleKey
CALLI4
pop
line 2952
;2952:			UI_MapCountByGameType(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_MapCountByGameType
CALLI4
pop
line 2953
;2953:			Menu_SetFeederSelection(NULL, FEEDER_MAPS, 0, "skirmish");
CNSTP4 0
ARGP4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 $2159
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 2954
;2954:		}
LABELV $2165
line 2955
;2955:	}
LABELV $2161
line 2957
;2956:
;2957:	g = uiInfo.gameTypes[ui_gameType.integer].gtEnum;
ADDRLP4 1040
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592+4
ADDP4
INDIRI4
ASGNI4
line 2958
;2958:	trap_Cvar_SetValue( "g_gametype", g );
ADDRGP4 $1294
ARGP4
ADDRLP4 1040
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2959
;2959:	trap_Cmd_ExecuteText( EXEC_APPEND, va( "wait ; wait ; map %s\n", uiInfo.mapList[ui_currentMap.integer].mapLoadName) );
ADDRGP4 $2169
ARGP4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1048
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1048
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 2960
;2960:	skill = trap_Cvar_VariableValue( "g_spSkill" );
ADDRGP4 $806
ARGP4
ADDRLP4 1052
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1044
ADDRLP4 1052
INDIRF4
ASGNF4
line 2961
;2961:	trap_Cvar_Set("ui_scoreMap", uiInfo.mapList[ui_currentMap.integer].mapName);
ADDRGP4 $2173
ARGP4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2963
;2962:
;2963:	k = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1077
ARGP4
ADDRLP4 1056
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 1056
INDIRP4
ARGP4
ADDRLP4 1060
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 1060
INDIRI4
ASGNI4
line 2965
;2964:
;2965:	trap_Cvar_Set("ui_singlePlayerActive", "1");
ADDRGP4 $2176
ARGP4
ADDRGP4 $372
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2968
;2966:
;2967:	// set up sp overrides, will be replaced on postgame
;2968:	temp = trap_Cvar_VariableValue( "capturelimit" );
ADDRGP4 $697
ARGP4
ADDRLP4 1064
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1036
ADDRLP4 1064
INDIRF4
CVFI4 4
ASGNI4
line 2969
;2969:	trap_Cvar_Set("ui_saveCaptureLimit", va("%i", temp));
ADDRGP4 $1708
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1068
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2177
ARGP4
ADDRLP4 1068
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2970
;2970:	temp = trap_Cvar_VariableValue( "fraglimit" );
ADDRGP4 $698
ARGP4
ADDRLP4 1072
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1036
ADDRLP4 1072
INDIRF4
CVFI4 4
ASGNI4
line 2971
;2971:	trap_Cvar_Set("ui_saveFragLimit", va("%i", temp));
ADDRGP4 $1708
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1076
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2178
ARGP4
ADDRLP4 1076
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2973
;2972:
;2973:	UI_SetCapFragLimits(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_SetCapFragLimits
CALLV
pop
line 2975
;2974:
;2975:	temp = trap_Cvar_VariableValue( "cg_drawTimer" );
ADDRGP4 $2179
ARGP4
ADDRLP4 1080
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1036
ADDRLP4 1080
INDIRF4
CVFI4 4
ASGNI4
line 2976
;2976:	trap_Cvar_Set("ui_drawTimer", va("%i", temp));
ADDRGP4 $1708
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1084
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2180
ARGP4
ADDRLP4 1084
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2977
;2977:	temp = trap_Cvar_VariableValue( "g_doWarmup" );
ADDRGP4 $2181
ARGP4
ADDRLP4 1088
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1036
ADDRLP4 1088
INDIRF4
CVFI4 4
ASGNI4
line 2978
;2978:	trap_Cvar_Set("ui_doWarmup", va("%i", temp));
ADDRGP4 $1708
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1092
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2182
ARGP4
ADDRLP4 1092
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2979
;2979:	temp = trap_Cvar_VariableValue( "g_friendlyFire" );
ADDRGP4 $2183
ARGP4
ADDRLP4 1096
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1036
ADDRLP4 1096
INDIRF4
CVFI4 4
ASGNI4
line 2980
;2980:	trap_Cvar_Set("ui_friendlyFire", va("%i", temp));
ADDRGP4 $1708
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1100
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2184
ARGP4
ADDRLP4 1100
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2981
;2981:	temp = trap_Cvar_VariableValue( "sv_maxClients" );
ADDRGP4 $2185
ARGP4
ADDRLP4 1104
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1036
ADDRLP4 1104
INDIRF4
CVFI4 4
ASGNI4
line 2982
;2982:	trap_Cvar_Set("ui_maxClients", va("%i", temp));
ADDRGP4 $1708
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1108
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2186
ARGP4
ADDRLP4 1108
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2983
;2983:	temp = trap_Cvar_VariableValue( "g_warmup" );
ADDRGP4 $2187
ARGP4
ADDRLP4 1112
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1036
ADDRLP4 1112
INDIRF4
CVFI4 4
ASGNI4
line 2984
;2984:	trap_Cvar_Set("ui_Warmup", va("%i", temp));
ADDRGP4 $1708
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1116
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2188
ARGP4
ADDRLP4 1116
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2985
;2985:	temp = trap_Cvar_VariableValue( "sv_pure" );
ADDRGP4 $2189
ARGP4
ADDRLP4 1120
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1036
ADDRLP4 1120
INDIRF4
CVFI4 4
ASGNI4
line 2986
;2986:	trap_Cvar_Set("ui_pure", va("%i", temp));
ADDRGP4 $1708
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1124
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2190
ARGP4
ADDRLP4 1124
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2988
;2987:
;2988:	trap_Cvar_Set("cg_cameraOrbit", "0");
ADDRGP4 $368
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2989
;2989:	trap_Cvar_Set("cg_thirdPerson", "0");
ADDRGP4 $370
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2990
;2990:	trap_Cvar_Set("cg_drawTimer", "1");
ADDRGP4 $2179
ARGP4
ADDRGP4 $372
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2991
;2991:	trap_Cvar_Set("g_doWarmup", "1");
ADDRGP4 $2181
ARGP4
ADDRGP4 $372
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2992
;2992:	trap_Cvar_Set("g_warmup", "15");
ADDRGP4 $2187
ARGP4
ADDRGP4 $674
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2993
;2993:	trap_Cvar_Set("sv_pure", "0");
ADDRGP4 $2189
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2994
;2994:	trap_Cvar_Set("g_friendlyFire", "0");
ADDRGP4 $2183
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2995
;2995:	trap_Cvar_Set("g_redTeam", UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 1128
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2191
ARGP4
ADDRLP4 1128
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2996
;2996:	trap_Cvar_Set("g_blueTeam", UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1077
ARGP4
ADDRLP4 1132
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2192
ARGP4
ADDRLP4 1132
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2998
;2997:
;2998:	if (trap_Cvar_VariableValue("ui_recordSPDemo")) {
ADDRGP4 $2195
ARGP4
ADDRLP4 1136
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1136
INDIRF4
CNSTF4 0
EQF4 $2193
line 2999
;2999:		Com_sprintf(buff, MAX_STRING_CHARS, "%s_%i", uiInfo.mapList[ui_currentMap.integer].mapLoadName, g);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2196
ARGP4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3000
;3000:		trap_Cvar_Set("ui_recordSPDemoName", buff);
ADDRGP4 $2200
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3001
;3001:	}
LABELV $2193
line 3003
;3002:
;3003:	delay = 500;
ADDRLP4 1032
CNSTI4 500
ASGNI4
line 3005
;3004:
;3005:	if (g == GT_TOURNAMENT) {
ADDRLP4 1040
INDIRI4
CNSTI4 1
NEI4 $2201
line 3006
;3006:		trap_Cvar_Set("sv_maxClients", "2");
ADDRGP4 $2185
ARGP4
ADDRGP4 $2203
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3007
;3007:		Com_sprintf( buff, sizeof(buff), "wait ; addbot %s %f "", %i \n", uiInfo.mapList[ui_currentMap.integer].opponentName, skill, delay);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2204
ARGP4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+12
ADDP4
INDIRP4
ARGP4
ADDRLP4 1044
INDIRF4
ARGF4
ADDRLP4 1032
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3008
;3008:		trap_Cmd_ExecuteText( EXEC_APPEND, buff );
CNSTI4 2
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3009
;3009:	} else {
ADDRGP4 $2202
JUMPV
LABELV $2201
line 3010
;3010:		temp = uiInfo.mapList[ui_currentMap.integer].teamMembers * 2;
ADDRLP4 1036
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+16
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 3011
;3011:		trap_Cvar_Set("sv_maxClients", va("%d", temp));
ADDRGP4 $695
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1140
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2185
ARGP4
ADDRLP4 1140
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3012
;3012:		for (i =0; i < uiInfo.mapList[ui_currentMap.integer].teamMembers; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2214
JUMPV
LABELV $2211
line 3013
;3013:			Com_sprintf( buff, sizeof(buff), "addbot %s %f %s %i %s\n", UI_AIFromName(uiInfo.teamList[k].teamMembers[i]), skill, (g == GT_FFA) ? "" : "Blue", delay, uiInfo.teamList[k].teamMembers[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1028
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+8
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1148
ADDRGP4 UI_AIFromName
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2218
ARGP4
ADDRLP4 1148
INDIRP4
ARGP4
ADDRLP4 1044
INDIRF4
ARGF4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $2224
ADDRLP4 1144
ADDRGP4 $110
ASGNP4
ADDRGP4 $2225
JUMPV
LABELV $2224
ADDRLP4 1144
ADDRGP4 $821
ASGNP4
LABELV $2225
ADDRLP4 1144
INDIRP4
ARGP4
ADDRLP4 1032
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1028
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+8
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3014
;3014:			trap_Cmd_ExecuteText( EXEC_APPEND, buff );
CNSTI4 2
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3015
;3015:			delay += 500;
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 3016
;3016:		}
LABELV $2212
line 3012
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2214
ADDRLP4 0
INDIRI4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+16
ADDP4
INDIRI4
LTI4 $2211
line 3017
;3017:		k = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 1144
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 1144
INDIRP4
ARGP4
ADDRLP4 1148
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 1148
INDIRI4
ASGNI4
line 3018
;3018:		for (i =0; i < uiInfo.mapList[ui_currentMap.integer].teamMembers-1; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2229
JUMPV
LABELV $2226
line 3019
;3019:			Com_sprintf( buff, sizeof(buff), "addbot %s %f %s %i %s\n", UI_AIFromName(uiInfo.teamList[k].teamMembers[i]), skill, (g == GT_FFA) ? "" : "Red", delay, uiInfo.teamList[k].teamMembers[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1028
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+8
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1156
ADDRGP4 UI_AIFromName
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2218
ARGP4
ADDRLP4 1156
INDIRP4
ARGP4
ADDRLP4 1044
INDIRF4
ARGF4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $2238
ADDRLP4 1152
ADDRGP4 $110
ASGNP4
ADDRGP4 $2239
JUMPV
LABELV $2238
ADDRLP4 1152
ADDRGP4 $822
ASGNP4
LABELV $2239
ADDRLP4 1152
INDIRP4
ARGP4
ADDRLP4 1032
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1028
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+8
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3020
;3020:			trap_Cmd_ExecuteText( EXEC_APPEND, buff );
CNSTI4 2
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3021
;3021:			delay += 500;
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 3022
;3022:		}
LABELV $2227
line 3018
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2229
ADDRLP4 0
INDIRI4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+16
ADDP4
INDIRI4
CNSTI4 1
SUBI4
LTI4 $2226
line 3023
;3023:	}
LABELV $2202
line 3024
;3024:	if (g >= GT_TEAM ) {
ADDRLP4 1040
INDIRI4
CNSTI4 3
LTI4 $2240
line 3025
;3025:		trap_Cmd_ExecuteText( EXEC_APPEND, "wait 5; team Red\n" );
CNSTI4 2
ARGI4
ADDRGP4 $2242
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3026
;3026:	}
LABELV $2240
line 3027
;3027:}
LABELV $2160
endproc UI_StartSkirmish 1160 32
proc UI_Update 36 8
line 3029
;3028:
;3029:static void UI_Update(const char *name) {
line 3030
;3030:	int	val = trap_Cvar_VariableValue(name);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 3032
;3031:
;3032: 	if (Q_stricmp(name, "ui_SetName") == 0) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2246
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2244
line 3033
;3033:		trap_Cvar_Set( "name", UI_Cvar_VariableString("ui_Name"));
ADDRGP4 $2247
ARGP4
ADDRLP4 12
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $1380
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3034
;3034: 	} else if (Q_stricmp(name, "ui_setRate") == 0) {
ADDRGP4 $2245
JUMPV
LABELV $2244
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2250
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2248
line 3035
;3035:		float rate = trap_Cvar_VariableValue("rate");
ADDRGP4 $2251
ARGP4
ADDRLP4 20
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 20
INDIRF4
ASGNF4
line 3036
;3036:		if (rate >= 5000) {
ADDRLP4 16
INDIRF4
CNSTF4 1167867904
LTF4 $2252
line 3037
;3037:			trap_Cvar_Set("cl_maxpackets", "30");
ADDRGP4 $2254
ARGP4
ADDRGP4 $671
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3038
;3038:			trap_Cvar_Set("cl_packetdup", "1");
ADDRGP4 $2255
ARGP4
ADDRGP4 $372
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3039
;3039:		} else if (rate >= 4000) {
ADDRGP4 $2249
JUMPV
LABELV $2252
ADDRLP4 16
INDIRF4
CNSTF4 1165623296
LTF4 $2256
line 3040
;3040:			trap_Cvar_Set("cl_maxpackets", "15");
ADDRGP4 $2254
ARGP4
ADDRGP4 $674
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3041
;3041:			trap_Cvar_Set("cl_packetdup", "2");		// favor less prediction errors when there's packet loss
ADDRGP4 $2255
ARGP4
ADDRGP4 $2203
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3042
;3042:		} else {
ADDRGP4 $2249
JUMPV
LABELV $2256
line 3043
;3043:			trap_Cvar_Set("cl_maxpackets", "15");
ADDRGP4 $2254
ARGP4
ADDRGP4 $674
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3044
;3044:			trap_Cvar_Set("cl_packetdup", "1");		// favor lower bandwidth
ADDRGP4 $2255
ARGP4
ADDRGP4 $372
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3045
;3045:		}
line 3046
;3046: 	} else if (Q_stricmp(name, "ui_GetName") == 0) {
ADDRGP4 $2249
JUMPV
LABELV $2248
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2260
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $2258
line 3047
;3047:		trap_Cvar_Set( "ui_Name", UI_Cvar_VariableString("name"));
ADDRGP4 $1380
ARGP4
ADDRLP4 20
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2247
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3048
;3048: 	} else if (Q_stricmp(name, "r_colorbits") == 0) {
ADDRGP4 $2259
JUMPV
LABELV $2258
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2263
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $2261
line 3049
;3049:		switch (val) {
ADDRLP4 24
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 16
EQI4 $2269
ADDRLP4 24
INDIRI4
CNSTI4 16
GTI4 $2272
LABELV $2271
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2266
ADDRGP4 $2262
JUMPV
LABELV $2272
ADDRLP4 0
INDIRI4
CNSTI4 32
EQI4 $2270
ADDRGP4 $2262
JUMPV
LABELV $2266
line 3051
;3050:			case 0:
;3051:				trap_Cvar_SetValue( "r_depthbits", 0 );
ADDRGP4 $2267
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3052
;3052:				trap_Cvar_SetValue( "r_stencilbits", 0 );
ADDRGP4 $2268
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3053
;3053:			break;
ADDRGP4 $2262
JUMPV
LABELV $2269
line 3055
;3054:			case 16:
;3055:				trap_Cvar_SetValue( "r_depthbits", 16 );
ADDRGP4 $2267
ARGP4
CNSTF4 1098907648
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3056
;3056:				trap_Cvar_SetValue( "r_stencilbits", 0 );
ADDRGP4 $2268
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3057
;3057:			break;
ADDRGP4 $2262
JUMPV
LABELV $2270
line 3059
;3058:			case 32:
;3059:				trap_Cvar_SetValue( "r_depthbits", 24 );
ADDRGP4 $2267
ARGP4
CNSTF4 1103101952
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3060
;3060:			break;
line 3062
;3061:		}
;3062:	} else if (Q_stricmp(name, "r_lodbias") == 0) {
ADDRGP4 $2262
JUMPV
LABELV $2261
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2275
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $2273
line 3063
;3063:		switch (val) {
ADDRLP4 28
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2278
ADDRLP4 28
INDIRI4
CNSTI4 1
EQI4 $2280
ADDRLP4 28
INDIRI4
CNSTI4 2
EQI4 $2281
ADDRGP4 $2274
JUMPV
LABELV $2278
line 3065
;3064:			case 0:
;3065:				trap_Cvar_SetValue( "r_subdivisions", 4 );
ADDRGP4 $2279
ARGP4
CNSTF4 1082130432
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3066
;3066:			break;
ADDRGP4 $2274
JUMPV
LABELV $2280
line 3068
;3067:			case 1:
;3068:				trap_Cvar_SetValue( "r_subdivisions", 12 );
ADDRGP4 $2279
ARGP4
CNSTF4 1094713344
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3069
;3069:			break;
ADDRGP4 $2274
JUMPV
LABELV $2281
line 3071
;3070:			case 2:
;3071:				trap_Cvar_SetValue( "r_subdivisions", 20 );
ADDRGP4 $2279
ARGP4
CNSTF4 1101004800
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3072
;3072:			break;
line 3074
;3073:		}
;3074:	} else if (Q_stricmp(name, "ui_glCustom") == 0) {
ADDRGP4 $2274
JUMPV
LABELV $2273
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2284
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $2282
line 3075
;3075:		switch (val) {
ADDRLP4 32
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
LTI4 $2283
ADDRLP4 32
INDIRI4
CNSTI4 3
GTI4 $2283
ADDRLP4 32
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2303
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $2303
address $2287
address $2299
address $2300
address $2302
code
LABELV $2287
line 3077
;3076:			case 0:	// high quality
;3077:				trap_Cvar_SetValue( "r_fullScreen", 1 );
ADDRGP4 $2288
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3078
;3078:				trap_Cvar_SetValue( "r_subdivisions", 4 );
ADDRGP4 $2279
ARGP4
CNSTF4 1082130432
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3079
;3079:				trap_Cvar_SetValue( "r_vertexlight", 0 );
ADDRGP4 $2289
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3080
;3080:				trap_Cvar_SetValue( "r_lodbias", 0 );
ADDRGP4 $2275
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3081
;3081:				trap_Cvar_SetValue( "r_colorbits", 32 );
ADDRGP4 $2263
ARGP4
CNSTF4 1107296256
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3082
;3082:				trap_Cvar_SetValue( "r_depthbits", 24 );
ADDRGP4 $2267
ARGP4
CNSTF4 1103101952
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3083
;3083:				trap_Cvar_SetValue( "r_picmip", 0 );
ADDRGP4 $2290
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3084
;3084:				trap_Cvar_SetValue( "r_mode", 4 );
ADDRGP4 $2291
ARGP4
CNSTF4 1082130432
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3085
;3085:				trap_Cvar_SetValue( "r_texturebits", 32 );
ADDRGP4 $2292
ARGP4
CNSTF4 1107296256
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3086
;3086:				trap_Cvar_SetValue( "r_fastSky", 0 );
ADDRGP4 $2293
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3087
;3087:				trap_Cvar_SetValue( "r_inGameVideo", 1 );
ADDRGP4 $2294
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3088
;3088:				trap_Cvar_SetValue( "cg_shadows", 1 );
ADDRGP4 $2295
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3089
;3089:				trap_Cvar_SetValue( "cg_brassTime", 2500 );
ADDRGP4 $2296
ARGP4
CNSTF4 1159479296
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3090
;3090:				trap_Cvar_Set( "r_texturemode", "GL_LINEAR_MIPMAP_LINEAR" );
ADDRGP4 $2297
ARGP4
ADDRGP4 $2298
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3091
;3091:			break;
ADDRGP4 $2283
JUMPV
LABELV $2299
line 3093
;3092:			case 1: // normal 
;3093:				trap_Cvar_SetValue( "r_fullScreen", 1 );
ADDRGP4 $2288
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3094
;3094:				trap_Cvar_SetValue( "r_subdivisions", 12 );
ADDRGP4 $2279
ARGP4
CNSTF4 1094713344
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3095
;3095:				trap_Cvar_SetValue( "r_vertexlight", 0 );
ADDRGP4 $2289
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3096
;3096:				trap_Cvar_SetValue( "r_lodbias", 0 );
ADDRGP4 $2275
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3097
;3097:				trap_Cvar_SetValue( "r_colorbits", 0 );
ADDRGP4 $2263
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3098
;3098:				trap_Cvar_SetValue( "r_depthbits", 24 );
ADDRGP4 $2267
ARGP4
CNSTF4 1103101952
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3099
;3099:				trap_Cvar_SetValue( "r_picmip", 1 );
ADDRGP4 $2290
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3100
;3100:				trap_Cvar_SetValue( "r_mode", 3 );
ADDRGP4 $2291
ARGP4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3101
;3101:				trap_Cvar_SetValue( "r_texturebits", 0 );
ADDRGP4 $2292
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3102
;3102:				trap_Cvar_SetValue( "r_fastSky", 0 );
ADDRGP4 $2293
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3103
;3103:				trap_Cvar_SetValue( "r_inGameVideo", 1 );
ADDRGP4 $2294
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3104
;3104:				trap_Cvar_SetValue( "cg_brassTime", 2500 );
ADDRGP4 $2296
ARGP4
CNSTF4 1159479296
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3105
;3105:				trap_Cvar_Set( "r_texturemode", "GL_LINEAR_MIPMAP_LINEAR" );
ADDRGP4 $2297
ARGP4
ADDRGP4 $2298
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3106
;3106:				trap_Cvar_SetValue( "cg_shadows", 0 );
ADDRGP4 $2295
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3107
;3107:			break;
ADDRGP4 $2283
JUMPV
LABELV $2300
line 3109
;3108:			case 2: // fast
;3109:				trap_Cvar_SetValue( "r_fullScreen", 1 );
ADDRGP4 $2288
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3110
;3110:				trap_Cvar_SetValue( "r_subdivisions", 8 );
ADDRGP4 $2279
ARGP4
CNSTF4 1090519040
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3111
;3111:				trap_Cvar_SetValue( "r_vertexlight", 0 );
ADDRGP4 $2289
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3112
;3112:				trap_Cvar_SetValue( "r_lodbias", 1 );
ADDRGP4 $2275
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3113
;3113:				trap_Cvar_SetValue( "r_colorbits", 0 );
ADDRGP4 $2263
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3114
;3114:				trap_Cvar_SetValue( "r_depthbits", 0 );
ADDRGP4 $2267
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3115
;3115:				trap_Cvar_SetValue( "r_picmip", 1 );
ADDRGP4 $2290
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3116
;3116:				trap_Cvar_SetValue( "r_mode", 3 );
ADDRGP4 $2291
ARGP4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3117
;3117:				trap_Cvar_SetValue( "r_texturebits", 0 );
ADDRGP4 $2292
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3118
;3118:				trap_Cvar_SetValue( "cg_shadows", 0 );
ADDRGP4 $2295
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3119
;3119:				trap_Cvar_SetValue( "r_fastSky", 1 );
ADDRGP4 $2293
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3120
;3120:				trap_Cvar_SetValue( "r_inGameVideo", 0 );
ADDRGP4 $2294
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3121
;3121:				trap_Cvar_SetValue( "cg_brassTime", 0 );
ADDRGP4 $2296
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3122
;3122:				trap_Cvar_Set( "r_texturemode", "GL_LINEAR_MIPMAP_NEAREST" );
ADDRGP4 $2297
ARGP4
ADDRGP4 $2301
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3123
;3123:			break;
ADDRGP4 $2283
JUMPV
LABELV $2302
line 3125
;3124:			case 3: // fastest
;3125:				trap_Cvar_SetValue( "r_fullScreen", 1 );
ADDRGP4 $2288
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3126
;3126:				trap_Cvar_SetValue( "r_subdivisions", 20 );
ADDRGP4 $2279
ARGP4
CNSTF4 1101004800
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3127
;3127:				trap_Cvar_SetValue( "r_vertexlight", 1 );
ADDRGP4 $2289
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3128
;3128:				trap_Cvar_SetValue( "r_lodbias", 2 );
ADDRGP4 $2275
ARGP4
CNSTF4 1073741824
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3129
;3129:				trap_Cvar_SetValue( "r_colorbits", 16 );
ADDRGP4 $2263
ARGP4
CNSTF4 1098907648
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3130
;3130:				trap_Cvar_SetValue( "r_depthbits", 16 );
ADDRGP4 $2267
ARGP4
CNSTF4 1098907648
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3131
;3131:				trap_Cvar_SetValue( "r_mode", 3 );
ADDRGP4 $2291
ARGP4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3132
;3132:				trap_Cvar_SetValue( "r_picmip", 2 );
ADDRGP4 $2290
ARGP4
CNSTF4 1073741824
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3133
;3133:				trap_Cvar_SetValue( "r_texturebits", 16 );
ADDRGP4 $2292
ARGP4
CNSTF4 1098907648
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3134
;3134:				trap_Cvar_SetValue( "cg_shadows", 0 );
ADDRGP4 $2295
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3135
;3135:				trap_Cvar_SetValue( "cg_brassTime", 0 );
ADDRGP4 $2296
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3136
;3136:				trap_Cvar_SetValue( "r_fastSky", 1 );
ADDRGP4 $2293
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3137
;3137:				trap_Cvar_SetValue( "r_inGameVideo", 0 );
ADDRGP4 $2294
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3138
;3138:				trap_Cvar_Set( "r_texturemode", "GL_LINEAR_MIPMAP_NEAREST" );
ADDRGP4 $2297
ARGP4
ADDRGP4 $2301
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3139
;3139:			break;
line 3141
;3140:		}
;3141:	} else if (Q_stricmp(name, "ui_mousePitch") == 0) {
ADDRGP4 $2283
JUMPV
LABELV $2282
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2306
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $2304
line 3142
;3142:		if (val == 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2307
line 3143
;3143:			trap_Cvar_SetValue( "m_pitch", 0.022f );
ADDRGP4 $2309
ARGP4
CNSTF4 1018444120
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3144
;3144:		} else {
ADDRGP4 $2308
JUMPV
LABELV $2307
line 3145
;3145:			trap_Cvar_SetValue( "m_pitch", -0.022f );
ADDRGP4 $2309
ARGP4
CNSTF4 3165927768
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3146
;3146:		}
LABELV $2308
line 3147
;3147:	}
LABELV $2304
LABELV $2283
LABELV $2274
LABELV $2262
LABELV $2259
LABELV $2249
LABELV $2245
line 3148
;3148:}
LABELV $2243
endproc UI_Update 36 8
proc UI_RunMenuScript 1304 24
line 3150
;3149:
;3150:static void UI_RunMenuScript(char **args) {
line 3154
;3151:	const char *name, *name2;
;3152:	char buff[1024];
;3153:
;3154:	if (String_Parse(args, &name)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1024
ARGP4
ADDRLP4 1032
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
EQI4 $2311
line 3155
;3155:		if (Q_stricmp(name, "StartServer") == 0) {
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2315
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $2313
line 3158
;3156:			int i, clients, oldclients;
;3157:			float skill;
;3158:			trap_Cvar_Set("cg_thirdPerson", "0");
ADDRGP4 $370
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3159
;3159:			trap_Cvar_Set("cg_cameraOrbit", "0");
ADDRGP4 $368
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3160
;3160:			trap_Cvar_Set("ui_singlePlayerActive", "0");
ADDRGP4 $2176
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3161
;3161:			trap_Cvar_SetValue( "dedicated", Com_Clamp( 0, 2, ui_dedicated.integer ) );
CNSTF4 0
ARGF4
CNSTF4 1073741824
ARGF4
ADDRGP4 ui_dedicated+12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 1056
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $2316
ARGP4
ADDRLP4 1056
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3162
;3162:			trap_Cvar_SetValue( "g_gametype", Com_Clamp( 0, 8, uiInfo.gameTypes[ui_netGameType.integer].gtEnum ) );
CNSTF4 0
ARGF4
CNSTF4 1090519040
ARGF4
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592+4
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 1060
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $1294
ARGP4
ADDRLP4 1060
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3163
;3163:			trap_Cvar_Set("g_redTeam", UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 1064
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2191
ARGP4
ADDRLP4 1064
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3164
;3164:			trap_Cvar_Set("g_blueTeam", UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1077
ARGP4
ADDRLP4 1068
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2192
ARGP4
ADDRLP4 1068
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3165
;3165:			trap_Cmd_ExecuteText( EXEC_APPEND, va( "wait ; wait ; map %s\n", uiInfo.mapList[ui_currentNetMap.integer].mapLoadName ) );
ADDRGP4 $2169
ARGP4
ADDRGP4 ui_currentNetMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1072
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1072
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3166
;3166:			skill = trap_Cvar_VariableValue( "g_spSkill" );
ADDRGP4 $806
ARGP4
ADDRLP4 1076
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1048
ADDRLP4 1076
INDIRF4
ASGNF4
line 3168
;3167:			// set max clients based on spots
;3168:			oldclients = trap_Cvar_VariableValue( "sv_maxClients" );
ADDRGP4 $2185
ARGP4
ADDRLP4 1080
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1052
ADDRLP4 1080
INDIRF4
CVFI4 4
ASGNI4
line 3169
;3169:			clients = 0;
ADDRLP4 1044
CNSTI4 0
ASGNI4
line 3170
;3170:			for (i = 0; i < PLAYERS_PER_TEAM; i++) {
ADDRLP4 1040
CNSTI4 0
ASGNI4
LABELV $2324
line 3171
;3171:				int bot = trap_Cvar_VariableValue( va("ui_blueteam%i", i+1));
ADDRGP4 $828
ARGP4
ADDRLP4 1040
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 1088
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1088
INDIRP4
ARGP4
ADDRLP4 1092
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1084
ADDRLP4 1092
INDIRF4
CVFI4 4
ASGNI4
line 3172
;3172:				if (bot >= 0) {
ADDRLP4 1084
INDIRI4
CNSTI4 0
LTI4 $2328
line 3173
;3173:					clients++;
ADDRLP4 1044
ADDRLP4 1044
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3174
;3174:				}
LABELV $2328
line 3175
;3175:				bot = trap_Cvar_VariableValue( va("ui_redteam%i", i+1));
ADDRGP4 $829
ARGP4
ADDRLP4 1040
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 1096
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1096
INDIRP4
ARGP4
ADDRLP4 1100
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1084
ADDRLP4 1100
INDIRF4
CVFI4 4
ASGNI4
line 3176
;3176:				if (bot >= 0) {
ADDRLP4 1084
INDIRI4
CNSTI4 0
LTI4 $2330
line 3177
;3177:					clients++;
ADDRLP4 1044
ADDRLP4 1044
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3178
;3178:				}
LABELV $2330
line 3179
;3179:			}
LABELV $2325
line 3170
ADDRLP4 1040
ADDRLP4 1040
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 5
LTI4 $2324
line 3180
;3180:			if (clients == 0) {
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $2332
line 3181
;3181:				clients = 8;
ADDRLP4 1044
CNSTI4 8
ASGNI4
line 3182
;3182:			}
LABELV $2332
line 3184
;3183:			
;3184:			if (oldclients > clients) {
ADDRLP4 1052
INDIRI4
ADDRLP4 1044
INDIRI4
LEI4 $2334
line 3185
;3185:				clients = oldclients;
ADDRLP4 1044
ADDRLP4 1052
INDIRI4
ASGNI4
line 3186
;3186:			}
LABELV $2334
line 3188
;3187:
;3188:			trap_Cvar_Set("sv_maxClients", va("%d",clients));
ADDRGP4 $695
ARGP4
ADDRLP4 1044
INDIRI4
ARGI4
ADDRLP4 1084
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2185
ARGP4
ADDRLP4 1084
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3190
;3189:
;3190:			for (i = 0; i < PLAYERS_PER_TEAM; i++) {
ADDRLP4 1040
CNSTI4 0
ASGNI4
LABELV $2336
line 3191
;3191:				int bot = trap_Cvar_VariableValue( va("ui_blueteam%i", i+1));
ADDRGP4 $828
ARGP4
ADDRLP4 1040
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 1092
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1092
INDIRP4
ARGP4
ADDRLP4 1096
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1088
ADDRLP4 1096
INDIRF4
CVFI4 4
ASGNI4
line 3192
;3192:				if (bot > 1) {
ADDRLP4 1088
INDIRI4
CNSTI4 1
LEI4 $2340
line 3193
;3193:					if (ui_actualNetGameType.integer >= GT_TEAM) {
ADDRGP4 ui_actualNetGameType+12
INDIRI4
CNSTI4 3
LTI4 $2342
line 3194
;3194:						Com_sprintf( buff, sizeof(buff), "addbot %s %f %s\n", uiInfo.characterList[bot-2].name, skill, "Blue");
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2345
ARGP4
ADDRLP4 1088
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460-48
ADDP4
INDIRP4
ARGP4
ADDRLP4 1048
INDIRF4
ARGF4
ADDRGP4 $821
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3195
;3195:					} else {
ADDRGP4 $2343
JUMPV
LABELV $2342
line 3196
;3196:						Com_sprintf( buff, sizeof(buff), "addbot %s %f \n", UI_GetBotNameByNumber(bot-2), skill);
ADDRLP4 1088
INDIRI4
CNSTI4 2
SUBI4
ARGI4
ADDRLP4 1100
ADDRGP4 UI_GetBotNameByNumber
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2348
ARGP4
ADDRLP4 1100
INDIRP4
ARGP4
ADDRLP4 1048
INDIRF4
ARGF4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3197
;3197:					}
LABELV $2343
line 3198
;3198:					trap_Cmd_ExecuteText( EXEC_APPEND, buff );
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3199
;3199:				}
LABELV $2340
line 3200
;3200:				bot = trap_Cvar_VariableValue( va("ui_redteam%i", i+1));
ADDRGP4 $829
ARGP4
ADDRLP4 1040
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 1100
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1100
INDIRP4
ARGP4
ADDRLP4 1104
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1088
ADDRLP4 1104
INDIRF4
CVFI4 4
ASGNI4
line 3201
;3201:				if (bot > 1) {
ADDRLP4 1088
INDIRI4
CNSTI4 1
LEI4 $2349
line 3202
;3202:					if (ui_actualNetGameType.integer >= GT_TEAM) {
ADDRGP4 ui_actualNetGameType+12
INDIRI4
CNSTI4 3
LTI4 $2351
line 3203
;3203:						Com_sprintf( buff, sizeof(buff), "addbot %s %f %s\n", uiInfo.characterList[bot-2].name, skill, "Red");
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2345
ARGP4
ADDRLP4 1088
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460-48
ADDP4
INDIRP4
ARGP4
ADDRLP4 1048
INDIRF4
ARGF4
ADDRGP4 $822
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3204
;3204:					} else {
ADDRGP4 $2352
JUMPV
LABELV $2351
line 3205
;3205:						Com_sprintf( buff, sizeof(buff), "addbot %s %f \n", UI_GetBotNameByNumber(bot-2), skill);
ADDRLP4 1088
INDIRI4
CNSTI4 2
SUBI4
ARGI4
ADDRLP4 1108
ADDRGP4 UI_GetBotNameByNumber
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2348
ARGP4
ADDRLP4 1108
INDIRP4
ARGP4
ADDRLP4 1048
INDIRF4
ARGF4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3206
;3206:					}
LABELV $2352
line 3207
;3207:					trap_Cmd_ExecuteText( EXEC_APPEND, buff );
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3208
;3208:				}
LABELV $2349
line 3209
;3209:			}
LABELV $2337
line 3190
ADDRLP4 1040
ADDRLP4 1040
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 5
LTI4 $2336
line 3210
;3210:		} else if (Q_stricmp(name, "updateSPMenu") == 0) {
ADDRGP4 $2314
JUMPV
LABELV $2313
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2358
ARGP4
ADDRLP4 1040
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $2356
line 3211
;3211:			UI_SetCapFragLimits(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_SetCapFragLimits
CALLV
pop
line 3212
;3212:			UI_MapCountByGameType(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_MapCountByGameType
CALLI4
pop
line 3213
;3213:			ui_mapIndex.integer = UI_GetIndexFromSelection(ui_currentMap.integer);
ADDRGP4 ui_currentMap+12
INDIRI4
ARGI4
ADDRLP4 1044
ADDRGP4 UI_GetIndexFromSelection
CALLI4
ASGNI4
ADDRGP4 ui_mapIndex+12
ADDRLP4 1044
INDIRI4
ASGNI4
line 3214
;3214:			trap_Cvar_Set("ui_mapIndex", va("%d", ui_mapIndex.integer));
ADDRGP4 $695
ARGP4
ADDRGP4 ui_mapIndex+12
INDIRI4
ARGI4
ADDRLP4 1048
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2163
ARGP4
ADDRLP4 1048
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3215
;3215:			Menu_SetFeederSelection(NULL, FEEDER_MAPS, ui_mapIndex.integer, "skirmish");
CNSTP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 ui_mapIndex+12
INDIRI4
ARGI4
ADDRGP4 $2159
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 3216
;3216:			UI_GameType_HandleKey(0, 0, K_MOUSE1, qfalse);
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
CNSTI4 178
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_GameType_HandleKey
CALLI4
pop
line 3217
;3217:			UI_GameType_HandleKey(0, 0, K_MOUSE2, qfalse);
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
CNSTI4 179
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_GameType_HandleKey
CALLI4
pop
line 3218
;3218:		} else if (Q_stricmp(name, "resetDefaults") == 0) {
ADDRGP4 $2357
JUMPV
LABELV $2356
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2365
ARGP4
ADDRLP4 1044
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $2363
line 3219
;3219:			trap_Cmd_ExecuteText( EXEC_APPEND, "exec default.cfg\n");
CNSTI4 2
ARGI4
ADDRGP4 $2366
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3220
;3220:			trap_Cmd_ExecuteText( EXEC_APPEND, "cvar_restart\n");
CNSTI4 2
ARGI4
ADDRGP4 $2367
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3221
;3221:			Controls_SetDefaults();
ADDRGP4 Controls_SetDefaults
CALLV
pop
line 3222
;3222:			trap_Cvar_Set("com_introPlayed", "1" );
ADDRGP4 $2368
ARGP4
ADDRGP4 $372
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3223
;3223:			trap_Cmd_ExecuteText( EXEC_APPEND, "vid_restart\n" );
CNSTI4 2
ARGI4
ADDRGP4 $2369
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3224
;3224:		} else if (Q_stricmp(name, "getCDKey") == 0) {
ADDRGP4 $2364
JUMPV
LABELV $2363
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2372
ARGP4
ADDRLP4 1048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $2370
line 3226
;3225:			char out[17];
;3226:			trap_GetCDKey(buff, 17);
ADDRLP4 0
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 trap_GetCDKey
CALLV
pop
line 3227
;3227:			trap_Cvar_Set("cdkey1", "");
ADDRGP4 $2373
ARGP4
ADDRGP4 $110
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3228
;3228:			trap_Cvar_Set("cdkey2", "");
ADDRGP4 $2374
ARGP4
ADDRGP4 $110
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3229
;3229:			trap_Cvar_Set("cdkey3", "");
ADDRGP4 $2375
ARGP4
ADDRGP4 $110
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3230
;3230:			trap_Cvar_Set("cdkey4", "");
ADDRGP4 $2376
ARGP4
ADDRGP4 $110
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3231
;3231:			if (strlen(buff) == CDKEY_LEN) {
ADDRLP4 0
ARGP4
ADDRLP4 1072
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 1072
INDIRU4
CNSTU4 16
NEU4 $2371
line 3232
;3232:				Q_strncpyz(out, buff, 5);
ADDRLP4 1052
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3233
;3233:				trap_Cvar_Set("cdkey1", out);
ADDRGP4 $2373
ARGP4
ADDRLP4 1052
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3234
;3234:				Q_strncpyz(out, buff + 4, 5);
ADDRLP4 1052
ARGP4
ADDRLP4 0+4
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3235
;3235:				trap_Cvar_Set("cdkey2", out);
ADDRGP4 $2374
ARGP4
ADDRLP4 1052
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3236
;3236:				Q_strncpyz(out, buff + 8, 5);
ADDRLP4 1052
ARGP4
ADDRLP4 0+8
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3237
;3237:				trap_Cvar_Set("cdkey3", out);
ADDRGP4 $2375
ARGP4
ADDRLP4 1052
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3238
;3238:				Q_strncpyz(out, buff + 12, 5);
ADDRLP4 1052
ARGP4
ADDRLP4 0+12
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3239
;3239:				trap_Cvar_Set("cdkey4", out);
ADDRGP4 $2376
ARGP4
ADDRLP4 1052
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3240
;3240:			}
line 3242
;3241:
;3242:		} else if (Q_stricmp(name, "verifyCDKey") == 0) {
ADDRGP4 $2371
JUMPV
LABELV $2370
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2384
ARGP4
ADDRLP4 1052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $2382
line 3243
;3243:			buff[0] = '\0';
ADDRLP4 0
CNSTI1 0
ASGNI1
line 3244
;3244:			Q_strcat(buff, 1024, UI_Cvar_VariableString("cdkey1")); 
ADDRGP4 $2373
ARGP4
ADDRLP4 1056
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1056
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 3245
;3245:			Q_strcat(buff, 1024, UI_Cvar_VariableString("cdkey2")); 
ADDRGP4 $2374
ARGP4
ADDRLP4 1060
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1060
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 3246
;3246:			Q_strcat(buff, 1024, UI_Cvar_VariableString("cdkey3")); 
ADDRGP4 $2375
ARGP4
ADDRLP4 1064
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1064
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 3247
;3247:			Q_strcat(buff, 1024, UI_Cvar_VariableString("cdkey4")); 
ADDRGP4 $2376
ARGP4
ADDRLP4 1068
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1068
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 3248
;3248:			trap_Cvar_Set("cdkey", buff);
ADDRGP4 $2385
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3249
;3249:			if (trap_VerifyCDKey(buff, UI_Cvar_VariableString("cdkeychecksum"))) {
ADDRGP4 $2388
ARGP4
ADDRLP4 1072
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 1072
INDIRP4
ARGP4
ADDRLP4 1076
ADDRGP4 trap_VerifyCDKey
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
EQI4 $2386
line 3250
;3250:				trap_Cvar_Set("ui_cdkeyvalid", "CD Key Appears to be valid.");
ADDRGP4 $2389
ARGP4
ADDRGP4 $2390
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3251
;3251:				trap_SetCDKey(buff);
ADDRLP4 0
ARGP4
ADDRGP4 trap_SetCDKey
CALLV
pop
line 3252
;3252:			} else {
ADDRGP4 $2383
JUMPV
LABELV $2386
line 3253
;3253:				trap_Cvar_Set("ui_cdkeyvalid", "CD Key does not appear to be valid.");
ADDRGP4 $2389
ARGP4
ADDRGP4 $2391
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3254
;3254:			}
line 3255
;3255:		} else if (Q_stricmp(name, "loadArenas") == 0) {
ADDRGP4 $2383
JUMPV
LABELV $2382
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2394
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $2392
line 3256
;3256:			UI_LoadArenas();
ADDRGP4 UI_LoadArenas
CALLV
pop
line 3257
;3257:			UI_MapCountByGameType(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_MapCountByGameType
CALLI4
pop
line 3258
;3258:			Menu_SetFeederSelection(NULL, FEEDER_ALLMAPS, 0, "createserver");
CNSTP4 0
ARGP4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 $2395
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 3259
;3259:		} else if (Q_stricmp(name, "saveControls") == 0) {
ADDRGP4 $2393
JUMPV
LABELV $2392
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2398
ARGP4
ADDRLP4 1060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $2396
line 3260
;3260:			Controls_SetConfig(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 Controls_SetConfig
CALLV
pop
line 3261
;3261:		} else if (Q_stricmp(name, "loadControls") == 0) {
ADDRGP4 $2397
JUMPV
LABELV $2396
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2401
ARGP4
ADDRLP4 1064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $2399
line 3262
;3262:			Controls_GetConfig();
ADDRGP4 Controls_GetConfig
CALLV
pop
line 3263
;3263:		} else if (Q_stricmp(name, "clearError") == 0) {
ADDRGP4 $2400
JUMPV
LABELV $2399
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2404
ARGP4
ADDRLP4 1068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
NEI4 $2402
line 3264
;3264:			trap_Cvar_Set("com_errorMessage", "");
ADDRGP4 $2405
ARGP4
ADDRGP4 $110
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3265
;3265:		} else if (Q_stricmp(name, "loadGameInfo") == 0) {
ADDRGP4 $2403
JUMPV
LABELV $2402
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2408
ARGP4
ADDRLP4 1072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $2406
line 3269
;3266:#ifdef PRE_RELEASE_TADEMO
;3267:			UI_ParseGameInfo("demogameinfo.txt");
;3268:#else
;3269:			UI_ParseGameInfo("gameinfo.txt");
ADDRGP4 $656
ARGP4
ADDRGP4 UI_ParseGameInfo
CALLV
pop
line 3271
;3270:#endif
;3271:			UI_LoadBestScores(uiInfo.mapList[ui_currentMap.integer].mapLoadName, uiInfo.gameTypes[ui_gameType.integer].gtEnum);
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592+4
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_LoadBestScores
CALLV
pop
line 3272
;3272:		} else if (Q_stricmp(name, "resetScores") == 0) {
ADDRGP4 $2407
JUMPV
LABELV $2406
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2417
ARGP4
ADDRLP4 1076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
NEI4 $2415
line 3273
;3273:			UI_ClearScores();
ADDRGP4 UI_ClearScores
CALLV
pop
line 3274
;3274:		} else if (Q_stricmp(name, "RefreshServers") == 0) {
ADDRGP4 $2416
JUMPV
LABELV $2415
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2420
ARGP4
ADDRLP4 1080
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1080
INDIRI4
CNSTI4 0
NEI4 $2418
line 3275
;3275:			UI_StartServerRefresh(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_StartServerRefresh
CALLV
pop
line 3276
;3276:			UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 3277
;3277:		} else if (Q_stricmp(name, "RefreshFilter") == 0) {
ADDRGP4 $2419
JUMPV
LABELV $2418
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2423
ARGP4
ADDRLP4 1084
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1084
INDIRI4
CNSTI4 0
NEI4 $2421
line 3278
;3278:			UI_StartServerRefresh(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_StartServerRefresh
CALLV
pop
line 3279
;3279:			UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 3280
;3280:		} else if (Q_stricmp(name, "RunSPDemo") == 0) {
ADDRGP4 $2422
JUMPV
LABELV $2421
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2426
ARGP4
ADDRLP4 1088
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1088
INDIRI4
CNSTI4 0
NEI4 $2424
line 3281
;3281:			if (uiInfo.demoAvailable) {
ADDRGP4 uiInfo+73444
INDIRI4
CNSTI4 0
EQI4 $2425
line 3282
;3282:			  trap_Cmd_ExecuteText( EXEC_APPEND, va("demo %s_%i\n", uiInfo.mapList[ui_currentMap.integer].mapLoadName, uiInfo.gameTypes[ui_gameType.integer].gtEnum));
ADDRGP4 $2430
ARGP4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592+4
ADDP4
INDIRI4
ARGI4
ADDRLP4 1092
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1092
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3283
;3283:			}
line 3284
;3284:		} else if (Q_stricmp(name, "LoadDemos") == 0) {
ADDRGP4 $2425
JUMPV
LABELV $2424
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2439
ARGP4
ADDRLP4 1092
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1092
INDIRI4
CNSTI4 0
NEI4 $2437
line 3285
;3285:			UI_LoadDemos();
ADDRGP4 UI_LoadDemos
CALLV
pop
line 3286
;3286:		} else if (Q_stricmp(name, "LoadMovies") == 0) {
ADDRGP4 $2438
JUMPV
LABELV $2437
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2442
ARGP4
ADDRLP4 1096
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1096
INDIRI4
CNSTI4 0
NEI4 $2440
line 3287
;3287:			UI_LoadMovies();
ADDRGP4 UI_LoadMovies
CALLV
pop
line 3288
;3288:		} else if (Q_stricmp(name, "LoadMods") == 0) {
ADDRGP4 $2441
JUMPV
LABELV $2440
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2445
ARGP4
ADDRLP4 1100
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1100
INDIRI4
CNSTI4 0
NEI4 $2443
line 3289
;3289:			UI_LoadMods();
ADDRGP4 UI_LoadMods
CALLV
pop
line 3290
;3290:		} else if (Q_stricmp(name, "playMovie") == 0) {
ADDRGP4 $2444
JUMPV
LABELV $2443
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2448
ARGP4
ADDRLP4 1104
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1104
INDIRI4
CNSTI4 0
NEI4 $2446
line 3291
;3291:			if (uiInfo.previewMovie >= 0) {
ADDRGP4 uiInfo+99272
INDIRI4
CNSTI4 0
LTI4 $2449
line 3292
;3292:			  trap_CIN_StopCinematic(uiInfo.previewMovie);
ADDRGP4 uiInfo+99272
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 3293
;3293:			}
LABELV $2449
line 3294
;3294:			trap_Cmd_ExecuteText( EXEC_APPEND, va("cinematic %s.roq 2\n", uiInfo.movieList[uiInfo.movieIndex]));
ADDRGP4 $2453
ARGP4
ADDRGP4 uiInfo+99268
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+98240
ADDP4
INDIRP4
ARGP4
ADDRLP4 1108
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1108
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3295
;3295:		} else if (Q_stricmp(name, "RunMod") == 0) {
ADDRGP4 $2447
JUMPV
LABELV $2446
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2458
ARGP4
ADDRLP4 1108
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 0
NEI4 $2456
line 3296
;3296:			trap_Cvar_Set( "fs_game", uiInfo.modList[uiInfo.modIndex].modName);
ADDRGP4 $2459
ARGP4
ADDRGP4 uiInfo+97204
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+96688
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3297
;3297:			trap_Cmd_ExecuteText( EXEC_APPEND, "vid_restart;" );
CNSTI4 2
ARGI4
ADDRGP4 $2462
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3298
;3298:		} else if (Q_stricmp(name, "RunDemo") == 0) {
ADDRGP4 $2457
JUMPV
LABELV $2456
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2465
ARGP4
ADDRLP4 1112
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1112
INDIRI4
CNSTI4 0
NEI4 $2463
line 3299
;3299:			trap_Cmd_ExecuteText( EXEC_APPEND, va("demo %s\n", uiInfo.demoList[uiInfo.demoIndex]));
ADDRGP4 $2466
ARGP4
ADDRGP4 uiInfo+98236
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+97208
ADDP4
INDIRP4
ARGP4
ADDRLP4 1116
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1116
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3300
;3300:		} else if (Q_stricmp(name, "Quake3") == 0) {
ADDRGP4 $2464
JUMPV
LABELV $2463
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2471
ARGP4
ADDRLP4 1116
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1116
INDIRI4
CNSTI4 0
NEI4 $2469
line 3301
;3301:			trap_Cvar_Set( "fs_game", "");
ADDRGP4 $2459
ARGP4
ADDRGP4 $110
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3302
;3302:			trap_Cmd_ExecuteText( EXEC_APPEND, "vid_restart;" );
CNSTI4 2
ARGI4
ADDRGP4 $2462
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3303
;3303:		} else if (Q_stricmp(name, "closeJoin") == 0) {
ADDRGP4 $2470
JUMPV
LABELV $2469
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2474
ARGP4
ADDRLP4 1120
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1120
INDIRI4
CNSTI4 0
NEI4 $2472
line 3304
;3304:			if (uiInfo.serverStatus.refreshActive) {
ADDRGP4 uiInfo+99276+2212
INDIRI4
CNSTI4 0
EQI4 $2475
line 3305
;3305:				UI_StopServerRefresh();
ADDRGP4 UI_StopServerRefresh
CALLV
pop
line 3306
;3306:				uiInfo.serverStatus.nextDisplayRefresh = 0;
ADDRGP4 uiInfo+99276+10420
CNSTI4 0
ASGNI4
line 3307
;3307:				uiInfo.nextServerStatusRefresh = 0;
ADDRGP4 uiInfo+114156
CNSTI4 0
ASGNI4
line 3308
;3308:				uiInfo.nextFindPlayerRefresh = 0;
ADDRGP4 uiInfo+119484
CNSTI4 0
ASGNI4
line 3309
;3309:				UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 3310
;3310:			} else {
ADDRGP4 $2473
JUMPV
LABELV $2475
line 3311
;3311:				Menus_CloseByName("joinserver");
ADDRGP4 $2483
ARGP4
ADDRGP4 Menus_CloseByName
CALLV
pop
line 3312
;3312:				Menus_OpenByName("main");
ADDRGP4 $2484
ARGP4
ADDRGP4 Menus_OpenByName
CALLV
pop
line 3313
;3313:			}
line 3314
;3314:		} else if (Q_stricmp(name, "StopRefresh") == 0) {
ADDRGP4 $2473
JUMPV
LABELV $2472
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2487
ARGP4
ADDRLP4 1124
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1124
INDIRI4
CNSTI4 0
NEI4 $2485
line 3315
;3315:			UI_StopServerRefresh();
ADDRGP4 UI_StopServerRefresh
CALLV
pop
line 3316
;3316:			uiInfo.serverStatus.nextDisplayRefresh = 0;
ADDRGP4 uiInfo+99276+10420
CNSTI4 0
ASGNI4
line 3317
;3317:			uiInfo.nextServerStatusRefresh = 0;
ADDRGP4 uiInfo+114156
CNSTI4 0
ASGNI4
line 3318
;3318:			uiInfo.nextFindPlayerRefresh = 0;
ADDRGP4 uiInfo+119484
CNSTI4 0
ASGNI4
line 3319
;3319:		} else if (Q_stricmp(name, "UpdateFilter") == 0) {
ADDRGP4 $2486
JUMPV
LABELV $2485
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2494
ARGP4
ADDRLP4 1128
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1128
INDIRI4
CNSTI4 0
NEI4 $2492
line 3320
;3320:			if (ui_netSource.integer == AS_LOCAL) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
NEI4 $2495
line 3321
;3321:				UI_StartServerRefresh(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_StartServerRefresh
CALLV
pop
line 3322
;3322:			}
LABELV $2495
line 3323
;3323:			UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 3324
;3324:			UI_FeederSelection(FEEDER_SERVERS, 0);
CNSTF4 1073741824
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 UI_FeederSelection
CALLV
pop
line 3325
;3325:		} else if (Q_stricmp(name, "ServerStatus") == 0) {
ADDRGP4 $2493
JUMPV
LABELV $2492
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2500
ARGP4
ADDRLP4 1132
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1132
INDIRI4
CNSTI4 0
NEI4 $2498
line 3326
;3326:			trap_LAN_GetServerAddressString(ui_netSource.integer, uiInfo.serverStatus.displayServers[uiInfo.serverStatus.currentServer], uiInfo.serverStatusAddress, sizeof(uiInfo.serverStatusAddress));
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 uiInfo+99276+2216
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99276+2220
ADDP4
INDIRI4
ARGI4
ADDRGP4 uiInfo+110760
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_LAN_GetServerAddressString
CALLV
pop
line 3327
;3327:			UI_BuildServerStatus(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerStatus
CALLV
pop
line 3328
;3328:		} else if (Q_stricmp(name, "FoundPlayerServerStatus") == 0) {
ADDRGP4 $2499
JUMPV
LABELV $2498
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2510
ARGP4
ADDRLP4 1136
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1136
INDIRI4
CNSTI4 0
NEI4 $2508
line 3329
;3329:			Q_strncpyz(uiInfo.serverStatusAddress, uiInfo.foundPlayerServerAddresses[uiInfo.currentFoundPlayerServer], sizeof(uiInfo.serverStatusAddress));
ADDRGP4 uiInfo+110760
ARGP4
ADDRGP4 uiInfo+119476
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+117428
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3330
;3330:			UI_BuildServerStatus(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerStatus
CALLV
pop
line 3331
;3331:			Menu_SetFeederSelection(NULL, FEEDER_FINDPLAYER, 0, NULL);
CNSTP4 0
ARGP4
CNSTI4 14
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 3332
;3332:		} else if (Q_stricmp(name, "FindPlayer") == 0) {
ADDRGP4 $2509
JUMPV
LABELV $2508
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2517
ARGP4
ADDRLP4 1140
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1140
INDIRI4
CNSTI4 0
NEI4 $2515
line 3333
;3333:			UI_BuildFindPlayerList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildFindPlayerList
CALLV
pop
line 3335
;3334:			// clear the displayed server status info
;3335:			uiInfo.serverStatusInfo.numLines = 0;
ADDRGP4 uiInfo+110824+3328
CNSTI4 0
ASGNI4
line 3336
;3336:			Menu_SetFeederSelection(NULL, FEEDER_FINDPLAYER, 0, NULL);
CNSTP4 0
ARGP4
CNSTI4 14
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 3337
;3337:		} else if (Q_stricmp(name, "JoinServer") == 0) {
ADDRGP4 $2516
JUMPV
LABELV $2515
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2522
ARGP4
ADDRLP4 1144
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1144
INDIRI4
CNSTI4 0
NEI4 $2520
line 3338
;3338:			trap_Cvar_Set("cg_thirdPerson", "0");
ADDRGP4 $370
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3339
;3339:			trap_Cvar_Set("cg_cameraOrbit", "0");
ADDRGP4 $368
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3340
;3340:			trap_Cvar_Set("ui_singlePlayerActive", "0");
ADDRGP4 $2176
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3341
;3341:			if (uiInfo.serverStatus.currentServer >= 0 && uiInfo.serverStatus.currentServer < uiInfo.serverStatus.numDisplayServers) {
ADDRGP4 uiInfo+99276+2216
INDIRI4
CNSTI4 0
LTI4 $2521
ADDRGP4 uiInfo+99276+2216
INDIRI4
ADDRGP4 uiInfo+99276+10412
INDIRI4
GEI4 $2521
line 3342
;3342:				trap_LAN_GetServerAddressString(ui_netSource.integer, uiInfo.serverStatus.displayServers[uiInfo.serverStatus.currentServer], buff, 1024);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 uiInfo+99276+2216
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99276+2220
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetServerAddressString
CALLV
pop
line 3343
;3343:				trap_Cmd_ExecuteText( EXEC_APPEND, va( "connect %s\n", buff ) );
ADDRGP4 $2536
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1148
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1148
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3344
;3344:			}
line 3345
;3345:		} else if (Q_stricmp(name, "FoundPlayerJoinServer") == 0) {
ADDRGP4 $2521
JUMPV
LABELV $2520
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2539
ARGP4
ADDRLP4 1148
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1148
INDIRI4
CNSTI4 0
NEI4 $2537
line 3346
;3346:			trap_Cvar_Set("ui_singlePlayerActive", "0");
ADDRGP4 $2176
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3347
;3347:			if (uiInfo.currentFoundPlayerServer >= 0 && uiInfo.currentFoundPlayerServer < uiInfo.numFoundPlayerServers) {
ADDRGP4 uiInfo+119476
INDIRI4
CNSTI4 0
LTI4 $2538
ADDRGP4 uiInfo+119476
INDIRI4
ADDRGP4 uiInfo+119480
INDIRI4
GEI4 $2538
line 3348
;3348:				trap_Cmd_ExecuteText( EXEC_APPEND, va( "connect %s\n", uiInfo.foundPlayerServerAddresses[uiInfo.currentFoundPlayerServer] ) );
ADDRGP4 $2536
ARGP4
ADDRGP4 uiInfo+119476
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+117428
ADDP4
ARGP4
ADDRLP4 1152
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1152
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3349
;3349:			}
line 3350
;3350:		} else if (Q_stricmp(name, "Quit") == 0) {
ADDRGP4 $2538
JUMPV
LABELV $2537
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2549
ARGP4
ADDRLP4 1152
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1152
INDIRI4
CNSTI4 0
NEI4 $2547
line 3351
;3351:			trap_Cvar_Set("ui_singlePlayerActive", "0");
ADDRGP4 $2176
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3352
;3352:			trap_Cmd_ExecuteText( EXEC_NOW, "quit");
CNSTI4 0
ARGI4
ADDRGP4 $2550
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3353
;3353:		} else if (Q_stricmp(name, "Controls") == 0) {
ADDRGP4 $2548
JUMPV
LABELV $2547
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2553
ARGP4
ADDRLP4 1156
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1156
INDIRI4
CNSTI4 0
NEI4 $2551
line 3354
;3354:		  trap_Cvar_Set( "cl_paused", "1" );
ADDRGP4 $2554
ARGP4
ADDRGP4 $372
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3355
;3355:			trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 3356
;3356:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 3357
;3357:			Menus_ActivateByName("setup_menu2");
ADDRGP4 $2555
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 3358
;3358:		} else if (Q_stricmp(name, "Leave") == 0) {
ADDRGP4 $2552
JUMPV
LABELV $2551
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2558
ARGP4
ADDRLP4 1160
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1160
INDIRI4
CNSTI4 0
NEI4 $2556
line 3359
;3359:			trap_Cmd_ExecuteText( EXEC_APPEND, "disconnect\n" );
CNSTI4 2
ARGI4
ADDRGP4 $2559
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3360
;3360:			trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 3361
;3361:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 3362
;3362:			Menus_ActivateByName("main");
ADDRGP4 $2484
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 3363
;3363:		} else if (Q_stricmp(name, "ServerSort") == 0) {
ADDRGP4 $2557
JUMPV
LABELV $2556
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2562
ARGP4
ADDRLP4 1164
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1164
INDIRI4
CNSTI4 0
NEI4 $2560
line 3365
;3364:			int sortColumn;
;3365:			if (Int_Parse(args, &sortColumn)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1168
ARGP4
ADDRLP4 1172
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 1172
INDIRI4
CNSTI4 0
EQI4 $2561
line 3367
;3366:				// if same column we're already sorting on then flip the direction
;3367:				if (sortColumn == uiInfo.serverStatus.sortKey) {
ADDRLP4 1168
INDIRI4
ADDRGP4 uiInfo+99276+2200
INDIRI4
NEI4 $2565
line 3368
;3368:					uiInfo.serverStatus.sortDir = !uiInfo.serverStatus.sortDir;
ADDRGP4 uiInfo+99276+2204
INDIRI4
CNSTI4 0
NEI4 $2574
ADDRLP4 1176
CNSTI4 1
ASGNI4
ADDRGP4 $2575
JUMPV
LABELV $2574
ADDRLP4 1176
CNSTI4 0
ASGNI4
LABELV $2575
ADDRGP4 uiInfo+99276+2204
ADDRLP4 1176
INDIRI4
ASGNI4
line 3369
;3369:				}
LABELV $2565
line 3371
;3370:				// make sure we sort again
;3371:				UI_ServersSort(sortColumn, qtrue);
ADDRLP4 1168
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 UI_ServersSort
CALLV
pop
line 3372
;3372:			}
line 3373
;3373:		} else if (Q_stricmp(name, "nextSkirmish") == 0) {
ADDRGP4 $2561
JUMPV
LABELV $2560
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2578
ARGP4
ADDRLP4 1168
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1168
INDIRI4
CNSTI4 0
NEI4 $2576
line 3374
;3374:			UI_StartSkirmish(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_StartSkirmish
CALLV
pop
line 3375
;3375:		} else if (Q_stricmp(name, "SkirmishStart") == 0) {
ADDRGP4 $2577
JUMPV
LABELV $2576
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2581
ARGP4
ADDRLP4 1172
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1172
INDIRI4
CNSTI4 0
NEI4 $2579
line 3376
;3376:			UI_StartSkirmish(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_StartSkirmish
CALLV
pop
line 3377
;3377:		} else if (Q_stricmp(name, "closeingame") == 0) {
ADDRGP4 $2580
JUMPV
LABELV $2579
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2584
ARGP4
ADDRLP4 1176
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1176
INDIRI4
CNSTI4 0
NEI4 $2582
line 3378
;3378:			trap_Key_SetCatcher( trap_Key_GetCatcher() & ~KEYCATCH_UI );
ADDRLP4 1180
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 1180
INDIRI4
CNSTI4 -3
BANDI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 3379
;3379:			trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 3380
;3380:			trap_Cvar_Set( "cl_paused", "0" );
ADDRGP4 $2554
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3381
;3381:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 3382
;3382:		} else if (Q_stricmp(name, "voteMap") == 0) {
ADDRGP4 $2583
JUMPV
LABELV $2582
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2587
ARGP4
ADDRLP4 1180
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1180
INDIRI4
CNSTI4 0
NEI4 $2585
line 3383
;3383:			if (ui_currentNetMap.integer >=0 && ui_currentNetMap.integer < uiInfo.mapCount) {
ADDRGP4 ui_currentNetMap+12
INDIRI4
CNSTI4 0
LTI4 $2586
ADDRGP4 ui_currentNetMap+12
INDIRI4
ADDRGP4 uiInfo+83236
INDIRI4
GEI4 $2586
line 3384
;3384:				trap_Cmd_ExecuteText( EXEC_APPEND, va("callvote map %s\n",uiInfo.mapList[ui_currentNetMap.integer].mapLoadName) );
ADDRGP4 $2593
ARGP4
ADDRGP4 ui_currentNetMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1184
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1184
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3385
;3385:			}
line 3386
;3386:		} else if (Q_stricmp(name, "voteKick") == 0) {
ADDRGP4 $2586
JUMPV
LABELV $2585
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2599
ARGP4
ADDRLP4 1184
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1184
INDIRI4
CNSTI4 0
NEI4 $2597
line 3387
;3387:			if (uiInfo.playerIndex >= 0 && uiInfo.playerIndex < uiInfo.playerCount) {
ADDRGP4 uiInfo+78872
INDIRI4
CNSTI4 0
LTI4 $2598
ADDRGP4 uiInfo+78872
INDIRI4
ADDRGP4 uiInfo+78856
INDIRI4
GEI4 $2598
line 3388
;3388:				trap_Cmd_ExecuteText( EXEC_APPEND, va("callvote kick %s\n",uiInfo.playerNames[uiInfo.playerIndex]) );
ADDRGP4 $2605
ARGP4
ADDRGP4 uiInfo+78872
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+78884
ADDP4
ARGP4
ADDRLP4 1188
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1188
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3389
;3389:			}
line 3390
;3390:		} else if (Q_stricmp(name, "voteGame") == 0) {
ADDRGP4 $2598
JUMPV
LABELV $2597
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2610
ARGP4
ADDRLP4 1188
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1188
INDIRI4
CNSTI4 0
NEI4 $2608
line 3391
;3391:			if (ui_netGameType.integer >= 0 && ui_netGameType.integer < uiInfo.numGameTypes) {
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 0
LTI4 $2609
ADDRGP4 ui_netGameType+12
INDIRI4
ADDRGP4 uiInfo+78588
INDIRI4
GEI4 $2609
line 3392
;3392:				trap_Cmd_ExecuteText( EXEC_APPEND, va("callvote g_gametype %i\n",uiInfo.gameTypes[ui_netGameType.integer].gtEnum) );
ADDRGP4 $2616
ARGP4
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592+4
ADDP4
INDIRI4
ARGI4
ADDRLP4 1192
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1192
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3393
;3393:			}
line 3394
;3394:		} else if (Q_stricmp(name, "voteLeader") == 0) {
ADDRGP4 $2609
JUMPV
LABELV $2608
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2622
ARGP4
ADDRLP4 1192
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1192
INDIRI4
CNSTI4 0
NEI4 $2620
line 3395
;3395:			if (uiInfo.teamIndex >= 0 && uiInfo.teamIndex < uiInfo.myTeamCount) {
ADDRGP4 uiInfo+78864
INDIRI4
CNSTI4 0
LTI4 $2621
ADDRGP4 uiInfo+78864
INDIRI4
ADDRGP4 uiInfo+78860
INDIRI4
GEI4 $2621
line 3396
;3396:				trap_Cmd_ExecuteText( EXEC_APPEND, va("callteamvote leader %s\n",uiInfo.teamNames[uiInfo.teamIndex]) );
ADDRGP4 $2628
ARGP4
ADDRGP4 uiInfo+78864
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+80932
ADDP4
ARGP4
ADDRLP4 1196
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1196
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3397
;3397:			}
line 3398
;3398:		} else if (Q_stricmp(name, "addBot") == 0) {
ADDRGP4 $2621
JUMPV
LABELV $2620
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2633
ARGP4
ADDRLP4 1196
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1196
INDIRI4
CNSTI4 0
NEI4 $2631
line 3399
;3399:			if (trap_Cvar_VariableValue("g_gametype") >= GT_TEAM) {
ADDRGP4 $1294
ARGP4
ADDRLP4 1200
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1200
INDIRF4
CNSTF4 1077936128
LTF4 $2634
line 3400
;3400:				trap_Cmd_ExecuteText( EXEC_APPEND, va("addbot %s %i %s\n", uiInfo.characterList[uiInfo.botIndex].name, uiInfo.skillIndex+1, (uiInfo.redBlue == 0) ? "Red" : "Blue") );
ADDRGP4 $2636
ARGP4
ADDRGP4 uiInfo+73456
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460
ADDP4
INDIRP4
ARGP4
ADDRGP4 uiInfo+96684
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 uiInfo+78852
INDIRI4
CNSTI4 0
NEI4 $2642
ADDRLP4 1204
ADDRGP4 $822
ASGNP4
ADDRGP4 $2643
JUMPV
LABELV $2642
ADDRLP4 1204
ADDRGP4 $821
ASGNP4
LABELV $2643
ADDRLP4 1204
INDIRP4
ARGP4
ADDRLP4 1208
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1208
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3401
;3401:			} else {
ADDRGP4 $2632
JUMPV
LABELV $2634
line 3402
;3402:				trap_Cmd_ExecuteText( EXEC_APPEND, va("addbot %s %i %s\n", UI_GetBotNameByNumber(uiInfo.botIndex), uiInfo.skillIndex+1, (uiInfo.redBlue == 0) ? "Red" : "Blue") );
ADDRGP4 uiInfo+73456
INDIRI4
ARGI4
ADDRLP4 1208
ADDRGP4 UI_GetBotNameByNumber
CALLP4
ASGNP4
ADDRGP4 $2636
ARGP4
ADDRLP4 1208
INDIRP4
ARGP4
ADDRGP4 uiInfo+96684
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 uiInfo+78852
INDIRI4
CNSTI4 0
NEI4 $2648
ADDRLP4 1204
ADDRGP4 $822
ASGNP4
ADDRGP4 $2649
JUMPV
LABELV $2648
ADDRLP4 1204
ADDRGP4 $821
ASGNP4
LABELV $2649
ADDRLP4 1204
INDIRP4
ARGP4
ADDRLP4 1212
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1212
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3403
;3403:			}
line 3404
;3404:		} else if (Q_stricmp(name, "addFavorite") == 0) {
ADDRGP4 $2632
JUMPV
LABELV $2631
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2652
ARGP4
ADDRLP4 1200
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1200
INDIRI4
CNSTI4 0
NEI4 $2650
line 3405
;3405:			if (ui_netSource.integer != AS_FAVORITES) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 3
EQI4 $2651
line 3410
;3406:				char name[MAX_NAME_LENGTH];
;3407:				char addr[MAX_NAME_LENGTH];
;3408:				int res;
;3409:
;3410:				trap_LAN_GetServerInfo(ui_netSource.integer, uiInfo.serverStatus.displayServers[uiInfo.serverStatus.currentServer], buff, MAX_STRING_CHARS);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 uiInfo+99276+2216
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99276+2220
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetServerInfo
CALLV
pop
line 3411
;3411:				name[0] = addr[0] = '\0';
ADDRLP4 1272
CNSTI1 0
ASGNI1
ADDRLP4 1204
ADDRLP4 1272
INDIRI1
ASGNI1
ADDRLP4 1236
ADDRLP4 1272
INDIRI1
ASGNI1
line 3412
;3412:				Q_strncpyz(name, 	Info_ValueForKey(buff, "hostname"), MAX_NAME_LENGTH);
ADDRLP4 0
ARGP4
ADDRGP4 $2661
ARGP4
ADDRLP4 1276
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1236
ARGP4
ADDRLP4 1276
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3413
;3413:				Q_strncpyz(addr, 	Info_ValueForKey(buff, "addr"), MAX_NAME_LENGTH);
ADDRLP4 0
ARGP4
ADDRGP4 $2662
ARGP4
ADDRLP4 1280
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1204
ARGP4
ADDRLP4 1280
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3414
;3414:				if (strlen(name) > 0 && strlen(addr) > 0) {
ADDRLP4 1236
ARGP4
ADDRLP4 1284
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 1284
INDIRU4
CNSTU4 0
EQU4 $2651
ADDRLP4 1204
ARGP4
ADDRLP4 1288
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 1288
INDIRU4
CNSTU4 0
EQU4 $2651
line 3415
;3415:					res = trap_LAN_AddServer(AS_FAVORITES, name, addr);
CNSTI4 3
ARGI4
ADDRLP4 1236
ARGP4
ADDRLP4 1204
ARGP4
ADDRLP4 1292
ADDRGP4 trap_LAN_AddServer
CALLI4
ASGNI4
ADDRLP4 1268
ADDRLP4 1292
INDIRI4
ASGNI4
line 3416
;3416:					if (res == 0) {
ADDRLP4 1268
INDIRI4
CNSTI4 0
NEI4 $2665
line 3418
;3417:						// server already in the list
;3418:						Com_Printf("Favorite already in list\n");
ADDRGP4 $2667
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 3419
;3419:					}
ADDRGP4 $2651
JUMPV
LABELV $2665
line 3420
;3420:					else if (res == -1) {
ADDRLP4 1268
INDIRI4
CNSTI4 -1
NEI4 $2668
line 3422
;3421:						// list full
;3422:						Com_Printf("Favorite list full\n");
ADDRGP4 $2670
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 3423
;3423:					}
ADDRGP4 $2651
JUMPV
LABELV $2668
line 3424
;3424:					else {
line 3426
;3425:						// successfully added
;3426:						Com_Printf("Added favorite server %s\n", addr);
ADDRGP4 $2671
ARGP4
ADDRLP4 1204
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 3427
;3427:					}
line 3428
;3428:				}
line 3429
;3429:			}
line 3430
;3430:		} else if (Q_stricmp(name, "deleteFavorite") == 0) {
ADDRGP4 $2651
JUMPV
LABELV $2650
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2674
ARGP4
ADDRLP4 1204
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1204
INDIRI4
CNSTI4 0
NEI4 $2672
line 3431
;3431:			if (ui_netSource.integer == AS_FAVORITES) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 3
NEI4 $2673
line 3433
;3432:				char addr[MAX_NAME_LENGTH];
;3433:				trap_LAN_GetServerInfo(ui_netSource.integer, uiInfo.serverStatus.displayServers[uiInfo.serverStatus.currentServer], buff, MAX_STRING_CHARS);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 uiInfo+99276+2216
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99276+2220
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetServerInfo
CALLV
pop
line 3434
;3434:				addr[0] = '\0';
ADDRLP4 1208
CNSTI1 0
ASGNI1
line 3435
;3435:				Q_strncpyz(addr, 	Info_ValueForKey(buff, "addr"), MAX_NAME_LENGTH);
ADDRLP4 0
ARGP4
ADDRGP4 $2662
ARGP4
ADDRLP4 1240
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1208
ARGP4
ADDRLP4 1240
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3436
;3436:				if (strlen(addr) > 0) {
ADDRLP4 1208
ARGP4
ADDRLP4 1244
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 1244
INDIRU4
CNSTU4 0
EQU4 $2673
line 3437
;3437:					trap_LAN_RemoveServer(AS_FAVORITES, addr);
CNSTI4 3
ARGI4
ADDRLP4 1208
ARGP4
ADDRGP4 trap_LAN_RemoveServer
CALLV
pop
line 3438
;3438:				}
line 3439
;3439:			}
line 3440
;3440:		} else if (Q_stricmp(name, "createFavorite") == 0) {
ADDRGP4 $2673
JUMPV
LABELV $2672
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2687
ARGP4
ADDRLP4 1208
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1208
INDIRI4
CNSTI4 0
NEI4 $2685
line 3441
;3441:			if (ui_netSource.integer == AS_FAVORITES) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 3
NEI4 $2686
line 3446
;3442:				char name[MAX_NAME_LENGTH];
;3443:				char addr[MAX_NAME_LENGTH];
;3444:				int res;
;3445:
;3446:				name[0] = addr[0] = '\0';
ADDRLP4 1280
CNSTI1 0
ASGNI1
ADDRLP4 1212
ADDRLP4 1280
INDIRI1
ASGNI1
ADDRLP4 1244
ADDRLP4 1280
INDIRI1
ASGNI1
line 3447
;3447:				Q_strncpyz(name, 	UI_Cvar_VariableString("ui_favoriteName"), MAX_NAME_LENGTH);
ADDRGP4 $2691
ARGP4
ADDRLP4 1284
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 1244
ARGP4
ADDRLP4 1284
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3448
;3448:				Q_strncpyz(addr, 	UI_Cvar_VariableString("ui_favoriteAddress"), MAX_NAME_LENGTH);
ADDRGP4 $2692
ARGP4
ADDRLP4 1288
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 1212
ARGP4
ADDRLP4 1288
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3449
;3449:				if (strlen(name) > 0 && strlen(addr) > 0) {
ADDRLP4 1244
ARGP4
ADDRLP4 1292
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 1292
INDIRU4
CNSTU4 0
EQU4 $2686
ADDRLP4 1212
ARGP4
ADDRLP4 1296
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 1296
INDIRU4
CNSTU4 0
EQU4 $2686
line 3450
;3450:					res = trap_LAN_AddServer(AS_FAVORITES, name, addr);
CNSTI4 3
ARGI4
ADDRLP4 1244
ARGP4
ADDRLP4 1212
ARGP4
ADDRLP4 1300
ADDRGP4 trap_LAN_AddServer
CALLI4
ASGNI4
ADDRLP4 1276
ADDRLP4 1300
INDIRI4
ASGNI4
line 3451
;3451:					if (res == 0) {
ADDRLP4 1276
INDIRI4
CNSTI4 0
NEI4 $2695
line 3453
;3452:						// server already in the list
;3453:						Com_Printf("Favorite already in list\n");
ADDRGP4 $2667
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 3454
;3454:					}
ADDRGP4 $2686
JUMPV
LABELV $2695
line 3455
;3455:					else if (res == -1) {
ADDRLP4 1276
INDIRI4
CNSTI4 -1
NEI4 $2697
line 3457
;3456:						// list full
;3457:						Com_Printf("Favorite list full\n");
ADDRGP4 $2670
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 3458
;3458:					}
ADDRGP4 $2686
JUMPV
LABELV $2697
line 3459
;3459:					else {
line 3461
;3460:						// successfully added
;3461:						Com_Printf("Added favorite server %s\n", addr);
ADDRGP4 $2671
ARGP4
ADDRLP4 1212
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 3462
;3462:					}
line 3463
;3463:				}
line 3464
;3464:			}
line 3465
;3465:		} else if (Q_stricmp(name, "orders") == 0) {
ADDRGP4 $2686
JUMPV
LABELV $2685
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2701
ARGP4
ADDRLP4 1212
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1212
INDIRI4
CNSTI4 0
NEI4 $2699
line 3467
;3466:			const char *orders;
;3467:			if (String_Parse(args, &orders)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1216
ARGP4
ADDRLP4 1220
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 1220
INDIRI4
CNSTI4 0
EQI4 $2700
line 3468
;3468:				int selectedPlayer = trap_Cvar_VariableValue("cg_selectedPlayer");
ADDRGP4 $1362
ARGP4
ADDRLP4 1228
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1224
ADDRLP4 1228
INDIRF4
CVFI4 4
ASGNI4
line 3469
;3469:				if (selectedPlayer < uiInfo.myTeamCount) {
ADDRLP4 1224
INDIRI4
ADDRGP4 uiInfo+78860
INDIRI4
GEI4 $2704
line 3470
;3470:					strcpy(buff, orders);
ADDRLP4 0
ARGP4
ADDRLP4 1216
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 3471
;3471:					trap_Cmd_ExecuteText( EXEC_APPEND, va(buff, uiInfo.teamClientNums[selectedPlayer]) );
ADDRLP4 0
ARGP4
ADDRLP4 1224
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+82980
ADDP4
INDIRI4
ARGI4
ADDRLP4 1232
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1232
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3472
;3472:					trap_Cmd_ExecuteText( EXEC_APPEND, "\n" );
CNSTI4 2
ARGI4
ADDRGP4 $2708
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3473
;3473:				} else {
ADDRGP4 $2705
JUMPV
LABELV $2704
line 3475
;3474:					int i;
;3475:					for (i = 0; i < uiInfo.myTeamCount; i++) {
ADDRLP4 1232
CNSTI4 0
ASGNI4
ADDRGP4 $2712
JUMPV
LABELV $2709
line 3476
;3476:						if (Q_stricmp(UI_Cvar_VariableString("name"), uiInfo.teamNames[i]) == 0) {
ADDRGP4 $1380
ARGP4
ADDRLP4 1236
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 1236
INDIRP4
ARGP4
ADDRLP4 1232
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+80932
ADDP4
ARGP4
ADDRLP4 1240
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1240
INDIRI4
CNSTI4 0
NEI4 $2714
line 3477
;3477:							continue;
ADDRGP4 $2710
JUMPV
LABELV $2714
line 3479
;3478:						}
;3479:						strcpy(buff, orders);
ADDRLP4 0
ARGP4
ADDRLP4 1216
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 3480
;3480:						trap_Cmd_ExecuteText( EXEC_APPEND, va(buff, uiInfo.teamNames[i]) );
ADDRLP4 0
ARGP4
ADDRLP4 1232
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+80932
ADDP4
ARGP4
ADDRLP4 1244
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1244
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3481
;3481:						trap_Cmd_ExecuteText( EXEC_APPEND, "\n" );
CNSTI4 2
ARGI4
ADDRGP4 $2708
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3482
;3482:					}
LABELV $2710
line 3475
ADDRLP4 1232
ADDRLP4 1232
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2712
ADDRLP4 1232
INDIRI4
ADDRGP4 uiInfo+78860
INDIRI4
LTI4 $2709
line 3483
;3483:				}
LABELV $2705
line 3484
;3484:				trap_Key_SetCatcher( trap_Key_GetCatcher() & ~KEYCATCH_UI );
ADDRLP4 1232
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 1232
INDIRI4
CNSTI4 -3
BANDI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 3485
;3485:				trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 3486
;3486:				trap_Cvar_Set( "cl_paused", "0" );
ADDRGP4 $2554
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3487
;3487:				Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 3488
;3488:			}
line 3489
;3489:		} else if (Q_stricmp(name, "voiceOrdersTeam") == 0) {
ADDRGP4 $2700
JUMPV
LABELV $2699
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2720
ARGP4
ADDRLP4 1216
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1216
INDIRI4
CNSTI4 0
NEI4 $2718
line 3491
;3490:			const char *orders;
;3491:			if (String_Parse(args, &orders)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1220
ARGP4
ADDRLP4 1224
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 1224
INDIRI4
CNSTI4 0
EQI4 $2719
line 3492
;3492:				int selectedPlayer = trap_Cvar_VariableValue("cg_selectedPlayer");
ADDRGP4 $1362
ARGP4
ADDRLP4 1232
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1228
ADDRLP4 1232
INDIRF4
CVFI4 4
ASGNI4
line 3493
;3493:				if (selectedPlayer == uiInfo.myTeamCount) {
ADDRLP4 1228
INDIRI4
ADDRGP4 uiInfo+78860
INDIRI4
NEI4 $2723
line 3494
;3494:					trap_Cmd_ExecuteText( EXEC_APPEND, orders );
CNSTI4 2
ARGI4
ADDRLP4 1220
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3495
;3495:					trap_Cmd_ExecuteText( EXEC_APPEND, "\n" );
CNSTI4 2
ARGI4
ADDRGP4 $2708
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3496
;3496:				}
LABELV $2723
line 3497
;3497:				trap_Key_SetCatcher( trap_Key_GetCatcher() & ~KEYCATCH_UI );
ADDRLP4 1236
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 1236
INDIRI4
CNSTI4 -3
BANDI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 3498
;3498:				trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 3499
;3499:				trap_Cvar_Set( "cl_paused", "0" );
ADDRGP4 $2554
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3500
;3500:				Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 3501
;3501:			}
line 3502
;3502:		} else if (Q_stricmp(name, "voiceOrders") == 0) {
ADDRGP4 $2719
JUMPV
LABELV $2718
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2728
ARGP4
ADDRLP4 1220
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1220
INDIRI4
CNSTI4 0
NEI4 $2726
line 3504
;3503:			const char *orders;
;3504:			if (String_Parse(args, &orders)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1224
ARGP4
ADDRLP4 1228
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 1228
INDIRI4
CNSTI4 0
EQI4 $2727
line 3505
;3505:				int selectedPlayer = trap_Cvar_VariableValue("cg_selectedPlayer");
ADDRGP4 $1362
ARGP4
ADDRLP4 1236
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1232
ADDRLP4 1236
INDIRF4
CVFI4 4
ASGNI4
line 3506
;3506:				if (selectedPlayer < uiInfo.myTeamCount) {
ADDRLP4 1232
INDIRI4
ADDRGP4 uiInfo+78860
INDIRI4
GEI4 $2731
line 3507
;3507:					strcpy(buff, orders);
ADDRLP4 0
ARGP4
ADDRLP4 1224
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 3508
;3508:					trap_Cmd_ExecuteText( EXEC_APPEND, va(buff, uiInfo.teamClientNums[selectedPlayer]) );
ADDRLP4 0
ARGP4
ADDRLP4 1232
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+82980
ADDP4
INDIRI4
ARGI4
ADDRLP4 1240
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1240
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3509
;3509:					trap_Cmd_ExecuteText( EXEC_APPEND, "\n" );
CNSTI4 2
ARGI4
ADDRGP4 $2708
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3510
;3510:				}
LABELV $2731
line 3511
;3511:				trap_Key_SetCatcher( trap_Key_GetCatcher() & ~KEYCATCH_UI );
ADDRLP4 1240
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 1240
INDIRI4
CNSTI4 -3
BANDI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 3512
;3512:				trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 3513
;3513:				trap_Cvar_Set( "cl_paused", "0" );
ADDRGP4 $2554
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3514
;3514:				Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 3515
;3515:			}
line 3516
;3516:		} else if (Q_stricmp(name, "glCustom") == 0) {
ADDRGP4 $2727
JUMPV
LABELV $2726
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2737
ARGP4
ADDRLP4 1224
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1224
INDIRI4
CNSTI4 0
NEI4 $2735
line 3517
;3517:			trap_Cvar_Set("ui_glCustom", "4");
ADDRGP4 $2284
ARGP4
ADDRGP4 $2738
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3518
;3518:		} else if (Q_stricmp(name, "update") == 0) {
ADDRGP4 $2736
JUMPV
LABELV $2735
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2741
ARGP4
ADDRLP4 1228
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1228
INDIRI4
CNSTI4 0
NEI4 $2739
line 3519
;3519:			if (String_Parse(args, &name2)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1028
ARGP4
ADDRLP4 1232
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 1232
INDIRI4
CNSTI4 0
EQI4 $2740
line 3520
;3520:				UI_Update(name2);
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 UI_Update
CALLV
pop
line 3521
;3521:			}
line 3522
;3522:		} else if (Q_stricmp(name, "setPbClStatus") == 0) {
ADDRGP4 $2740
JUMPV
LABELV $2739
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2746
ARGP4
ADDRLP4 1232
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1232
INDIRI4
CNSTI4 0
NEI4 $2744
line 3524
;3523:			int stat;
;3524:			if ( Int_Parse( args, &stat ) )
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1236
ARGP4
ADDRLP4 1240
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 1240
INDIRI4
CNSTI4 0
EQI4 $2745
line 3525
;3525:				trap_SetPbClStatus( stat );
ADDRLP4 1236
INDIRI4
ARGI4
ADDRGP4 trap_SetPbClStatus
CALLV
pop
line 3526
;3526:		}
ADDRGP4 $2745
JUMPV
LABELV $2744
line 3527
;3527:		else {
line 3528
;3528:			Com_Printf("unknown UI script %s\n", name);
ADDRGP4 $2749
ARGP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 3529
;3529:		}
LABELV $2745
LABELV $2740
LABELV $2736
LABELV $2727
LABELV $2719
LABELV $2700
LABELV $2686
LABELV $2673
LABELV $2651
LABELV $2632
LABELV $2621
LABELV $2609
LABELV $2598
LABELV $2586
LABELV $2583
LABELV $2580
LABELV $2577
LABELV $2561
LABELV $2557
LABELV $2552
LABELV $2548
LABELV $2538
LABELV $2521
LABELV $2516
LABELV $2509
LABELV $2499
LABELV $2493
LABELV $2486
LABELV $2473
LABELV $2470
LABELV $2464
LABELV $2457
LABELV $2447
LABELV $2444
LABELV $2441
LABELV $2438
LABELV $2425
LABELV $2422
LABELV $2419
LABELV $2416
LABELV $2407
LABELV $2403
LABELV $2400
LABELV $2397
LABELV $2393
LABELV $2383
LABELV $2371
LABELV $2364
LABELV $2357
LABELV $2314
line 3530
;3530:	}
LABELV $2311
line 3531
;3531:}
LABELV $2310
endproc UI_RunMenuScript 1304 24
proc UI_GetTeamColor 0 0
line 3533
;3532:
;3533:static void UI_GetTeamColor(vec4_t *color) {
line 3534
;3534:}
LABELV $2750
endproc UI_GetTeamColor 0 0
proc UI_MapCountByGameType 16 0
line 3541
;3535:
;3536:/*
;3537:==================
;3538:UI_MapCountByGameType
;3539:==================
;3540:*/
;3541:static int UI_MapCountByGameType(qboolean singlePlayer) {
line 3543
;3542:	int i, c, game;
;3543:	c = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 3544
;3544:	game = singlePlayer ? uiInfo.gameTypes[ui_gameType.integer].gtEnum : uiInfo.gameTypes[ui_netGameType.integer].gtEnum;
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $2759
ADDRLP4 12
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592+4
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $2760
JUMPV
LABELV $2759
ADDRLP4 12
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592+4
ADDP4
INDIRI4
ASGNI4
LABELV $2760
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
line 3545
;3545:	if (game == GT_SINGLE_PLAYER) {
ADDRLP4 4
INDIRI4
CNSTI4 2
NEI4 $2761
line 3546
;3546:		game++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3547
;3547:	} 
LABELV $2761
line 3548
;3548:	if (game == GT_TEAM) {
ADDRLP4 4
INDIRI4
CNSTI4 3
NEI4 $2763
line 3549
;3549:		game = GT_FFA;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3550
;3550:	}
LABELV $2763
line 3552
;3551:
;3552:	for (i = 0; i < uiInfo.mapCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2768
JUMPV
LABELV $2765
line 3553
;3553:		uiInfo.mapList[i].active = qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+96
ADDP4
CNSTI4 0
ASGNI4
line 3554
;3554:		if ( uiInfo.mapList[i].typeBits & (1 << game)) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+20
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 4
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $2772
line 3555
;3555:			if (singlePlayer) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $2776
line 3556
;3556:				if (!(uiInfo.mapList[i].typeBits & (1 << GT_SINGLE_PLAYER))) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+20
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $2778
line 3557
;3557:					continue;
ADDRGP4 $2766
JUMPV
LABELV $2778
line 3559
;3558:				}
;3559:			}
LABELV $2776
line 3560
;3560:			c++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3561
;3561:			uiInfo.mapList[i].active = qtrue;
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+96
ADDP4
CNSTI4 1
ASGNI4
line 3562
;3562:		}
LABELV $2772
line 3563
;3563:	}
LABELV $2766
line 3552
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2768
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+83236
INDIRI4
LTI4 $2765
line 3564
;3564:	return c;
ADDRLP4 8
INDIRI4
RETI4
LABELV $2751
endproc UI_MapCountByGameType 16 0
export UI_hasSkinForBase
proc UI_hasSkinForBase 1032 20
line 3567
;3565:}
;3566:
;3567:qboolean UI_hasSkinForBase(const char *base, const char *team) {
line 3570
;3568:	char	test[1024];
;3569:	
;3570:	Com_sprintf( test, sizeof( test ), "models/players/%s/%s/lower_default.skin", base, team );
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2785
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3572
;3571:
;3572:	if (trap_FS_FOpenFile(test, 0, FS_READ)) {
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1024
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 0
EQI4 $2786
line 3573
;3573:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2784
JUMPV
LABELV $2786
line 3575
;3574:	}
;3575:	Com_sprintf( test, sizeof( test ), "models/players/characters/%s/%s/lower_default.skin", base, team );
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2788
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3577
;3576:
;3577:	if (trap_FS_FOpenFile(test, 0, FS_READ)) {
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1028
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
EQI4 $2789
line 3578
;3578:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2784
JUMPV
LABELV $2789
line 3580
;3579:	}
;3580:	return qfalse;
CNSTI4 0
RETI4
LABELV $2784
endproc UI_hasSkinForBase 1032 20
data
align 4
LABELV $2792
byte 4 0
code
proc UI_HeadCountByTeam 40 8
line 3588
;3581:}
;3582:
;3583:/*
;3584:==================
;3585:UI_MapCountByTeam
;3586:==================
;3587:*/
;3588:static int UI_HeadCountByTeam() {
line 3592
;3589:	static int init = 0;
;3590:	int i, j, k, c, tIndex;
;3591:	
;3592:	c = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 3593
;3593:	if (!init) {
ADDRGP4 $2792
INDIRI4
CNSTI4 0
NEI4 $2793
line 3594
;3594:		for (i = 0; i < uiInfo.characterCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2798
JUMPV
LABELV $2795
line 3595
;3595:			uiInfo.characterList[i].reference = 0;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460+20
ADDP4
CNSTI4 0
ASGNI4
line 3596
;3596:			for (j = 0; j < uiInfo.teamCount; j++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $2805
JUMPV
LABELV $2802
line 3597
;3597:			  if (UI_hasSkinForBase(uiInfo.characterList[i].base, uiInfo.teamList[j].teamName)) {
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460+12
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 UI_hasSkinForBase
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $2807
line 3598
;3598:					uiInfo.characterList[i].reference |= (1<<j);
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460+20
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
ADDRLP4 8
INDIRI4
LSHI4
BORI4
ASGNI4
line 3599
;3599:			  }
LABELV $2807
line 3600
;3600:			}
LABELV $2803
line 3596
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2805
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+75768
INDIRI4
LTI4 $2802
line 3601
;3601:		}
LABELV $2796
line 3594
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2798
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+73452
INDIRI4
LTI4 $2795
line 3602
;3602:		init = 1;
ADDRGP4 $2792
CNSTI4 1
ASGNI4
line 3603
;3603:	}
LABELV $2793
line 3605
;3604:
;3605:	tIndex = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 20
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 24
INDIRI4
ASGNI4
line 3608
;3606:
;3607:	// do names
;3608:	for (i = 0; i < uiInfo.characterCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2817
JUMPV
LABELV $2814
line 3609
;3609:		uiInfo.characterList[i].active = qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460+16
ADDP4
CNSTI4 0
ASGNI4
line 3610
;3610:		for(j = 0; j < TEAM_MEMBERS; j++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $2821
line 3611
;3611:			if (uiInfo.teamList[tIndex].teamMembers[j] != NULL) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+8
ADDP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2825
line 3612
;3612:				if (uiInfo.characterList[i].reference&(1<<tIndex)) {// && Q_stricmp(uiInfo.teamList[tIndex].teamMembers[j], uiInfo.characterList[i].name)==0) {
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460+20
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 12
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $2829
line 3613
;3613:					uiInfo.characterList[i].active = qtrue;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460+16
ADDP4
CNSTI4 1
ASGNI4
line 3614
;3614:					c++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3615
;3615:					break;
ADDRGP4 $2823
JUMPV
LABELV $2829
line 3617
;3616:				}
;3617:			}
LABELV $2825
line 3618
;3618:		}
LABELV $2822
line 3610
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 5
LTI4 $2821
LABELV $2823
line 3619
;3619:	}
LABELV $2815
line 3608
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2817
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+73452
INDIRI4
LTI4 $2814
line 3622
;3620:
;3621:	// and then aliases
;3622:	for(j = 0; j < TEAM_MEMBERS; j++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $2835
line 3623
;3623:		for(k = 0; k < uiInfo.aliasCount; k++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2842
JUMPV
LABELV $2839
line 3624
;3624:			if (uiInfo.aliasList[k].name != NULL) {
ADDRLP4 4
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+75000
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2844
line 3625
;3625:				if (Q_stricmp(uiInfo.teamList[tIndex].teamMembers[j], uiInfo.aliasList[k].name)==0) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+8
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+75000
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $2847
line 3626
;3626:					for (i = 0; i < uiInfo.characterCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2855
JUMPV
LABELV $2852
line 3627
;3627:						if (uiInfo.characterList[i].headImage != -1 && uiInfo.characterList[i].reference&(1<<tIndex) && Q_stricmp(uiInfo.aliasList[k].ai, uiInfo.characterList[i].name)==0) {
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460+8
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $2857
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460+20
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 12
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $2857
ADDRLP4 4
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+75000+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $2857
line 3628
;3628:							if (uiInfo.characterList[i].active == qfalse) {
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460+16
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2854
line 3629
;3629:								uiInfo.characterList[i].active = qtrue;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460+16
ADDP4
CNSTI4 1
ASGNI4
line 3630
;3630:								c++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3631
;3631:							}
line 3632
;3632:							break;
ADDRGP4 $2854
JUMPV
LABELV $2857
line 3634
;3633:						}
;3634:					}
LABELV $2853
line 3626
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2855
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+73452
INDIRI4
LTI4 $2852
LABELV $2854
line 3635
;3635:				}
LABELV $2847
line 3636
;3636:			}
LABELV $2844
line 3637
;3637:		}
LABELV $2840
line 3623
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2842
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+74996
INDIRI4
LTI4 $2839
line 3638
;3638:	}
LABELV $2836
line 3622
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 5
LTI4 $2835
line 3639
;3639:	return c;
ADDRLP4 16
INDIRI4
RETI4
LABELV $2791
endproc UI_HeadCountByTeam 40 8
proc UI_InsertServerIntoDisplayList 16 0
line 3647
;3640:}
;3641:
;3642:/*
;3643:==================
;3644:UI_InsertServerIntoDisplayList
;3645:==================
;3646:*/
;3647:static void UI_InsertServerIntoDisplayList(int num, int position) {
line 3650
;3648:	int i;
;3649:
;3650:	if (position < 0 || position > uiInfo.serverStatus.numDisplayServers ) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $2877
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+99276+10412
INDIRI4
LEI4 $2873
LABELV $2877
line 3651
;3651:		return;
ADDRGP4 $2872
JUMPV
LABELV $2873
line 3654
;3652:	}
;3653:	//
;3654:	uiInfo.serverStatus.numDisplayServers++;
ADDRLP4 8
ADDRGP4 uiInfo+99276+10412
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3655
;3655:	for (i = uiInfo.serverStatus.numDisplayServers; i > position; i--) {
ADDRLP4 0
ADDRGP4 uiInfo+99276+10412
INDIRI4
ASGNI4
ADDRGP4 $2883
JUMPV
LABELV $2880
line 3656
;3656:		uiInfo.serverStatus.displayServers[i] = uiInfo.serverStatus.displayServers[i-1];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99276+2220
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99276+2220-4
ADDP4
INDIRI4
ASGNI4
line 3657
;3657:	}
LABELV $2881
line 3655
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $2883
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
GTI4 $2880
line 3658
;3658:	uiInfo.serverStatus.displayServers[position] = num;
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99276+2220
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 3659
;3659:}
LABELV $2872
endproc UI_InsertServerIntoDisplayList 16 0
proc UI_RemoveServerFromDisplayList 16 0
line 3666
;3660:
;3661:/*
;3662:==================
;3663:UI_RemoveServerFromDisplayList
;3664:==================
;3665:*/
;3666:static void UI_RemoveServerFromDisplayList(int num) {
line 3669
;3667:	int i, j;
;3668:
;3669:	for (i = 0; i < uiInfo.serverStatus.numDisplayServers; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2897
JUMPV
LABELV $2894
line 3670
;3670:		if (uiInfo.serverStatus.displayServers[i] == num) {
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99276+2220
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $2900
line 3671
;3671:			uiInfo.serverStatus.numDisplayServers--;
ADDRLP4 8
ADDRGP4 uiInfo+99276+10412
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3672
;3672:			for (j = i; j < uiInfo.serverStatus.numDisplayServers; j++) {
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $2909
JUMPV
LABELV $2906
line 3673
;3673:				uiInfo.serverStatus.displayServers[j] = uiInfo.serverStatus.displayServers[j+1];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99276+2220
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99276+2220+4
ADDP4
INDIRI4
ASGNI4
line 3674
;3674:			}
LABELV $2907
line 3672
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2909
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+99276+10412
INDIRI4
LTI4 $2906
line 3675
;3675:			return;
ADDRGP4 $2893
JUMPV
LABELV $2900
line 3677
;3676:		}
;3677:	}
LABELV $2895
line 3669
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2897
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+99276+10412
INDIRI4
LTI4 $2894
line 3678
;3678:}
LABELV $2893
endproc UI_RemoveServerFromDisplayList 16 0
proc UI_BinaryServerInsertion 20 20
line 3685
;3679:
;3680:/*
;3681:==================
;3682:UI_BinaryServerInsertion
;3683:==================
;3684:*/
;3685:static void UI_BinaryServerInsertion(int num) {
line 3689
;3686:	int mid, offset, res, len;
;3687:
;3688:	// use binary search to insert server
;3689:	len = uiInfo.serverStatus.numDisplayServers;
ADDRLP4 12
ADDRGP4 uiInfo+99276+10412
INDIRI4
ASGNI4
line 3690
;3690:	mid = len;
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 3691
;3691:	offset = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 3692
;3692:	res = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2921
JUMPV
LABELV $2920
line 3693
;3693:	while(mid > 0) {
line 3694
;3694:		mid = len >> 1;
ADDRLP4 0
ADDRLP4 12
INDIRI4
CNSTI4 1
RSHI4
ASGNI4
line 3696
;3695:		//
;3696:		res = trap_LAN_CompareServers( ui_netSource.integer, uiInfo.serverStatus.sortKey,
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 uiInfo+99276+2200
INDIRI4
ARGI4
ADDRGP4 uiInfo+99276+2204
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99276+2220
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 trap_LAN_CompareServers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 3699
;3697:					uiInfo.serverStatus.sortDir, num, uiInfo.serverStatus.displayServers[offset+mid]);
;3698:		// if equal
;3699:		if (res == 0) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2930
line 3700
;3700:			UI_InsertServerIntoDisplayList(num, offset+mid);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ARGI4
ADDRGP4 UI_InsertServerIntoDisplayList
CALLV
pop
line 3701
;3701:			return;
ADDRGP4 $2917
JUMPV
LABELV $2930
line 3704
;3702:		}
;3703:		// if larger
;3704:		else if (res == 1) {
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $2932
line 3705
;3705:			offset += mid;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 3706
;3706:			len -= mid;
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ASGNI4
line 3707
;3707:		}
ADDRGP4 $2933
JUMPV
LABELV $2932
line 3709
;3708:		// if smaller
;3709:		else {
line 3710
;3710:			len -= mid;
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ASGNI4
line 3711
;3711:		}
LABELV $2933
line 3712
;3712:	}
LABELV $2921
line 3693
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $2920
line 3713
;3713:	if (res == 1) {
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $2934
line 3714
;3714:		offset++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3715
;3715:	}
LABELV $2934
line 3716
;3716:	UI_InsertServerIntoDisplayList(num, offset);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 UI_InsertServerIntoDisplayList
CALLV
pop
line 3717
;3717:}
LABELV $2917
endproc UI_BinaryServerInsertion 20 20
bss
align 4
LABELV $2937
skip 4
code
proc UI_BuildServerDisplayList 1096 16
line 3724
;3718:
;3719:/*
;3720:==================
;3721:UI_BuildServerDisplayList
;3722:==================
;3723:*/
;3724:static void UI_BuildServerDisplayList(qboolean force) {
line 3730
;3725:	int i, count, clients, maxClients, ping, game, len, visible;
;3726:	char info[MAX_STRING_CHARS];
;3727://	qboolean startRefresh = qtrue; TTimo: unused
;3728:	static int numinvisible;
;3729:
;3730:	if (!(force || uiInfo.uiDC.realTime > uiInfo.serverStatus.nextDisplayRefresh)) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $2938
ADDRGP4 uiInfo+208
INDIRI4
ADDRGP4 uiInfo+99276+10420
INDIRI4
GTI4 $2938
line 3731
;3731:		return;
ADDRGP4 $2936
JUMPV
LABELV $2938
line 3734
;3732:	}
;3733:	// if we shouldn't reset
;3734:	if ( force == 2 ) {
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $2943
line 3735
;3735:		force = 0;
ADDRFP4 0
CNSTI4 0
ASGNI4
line 3736
;3736:	}
LABELV $2943
line 3739
;3737:
;3738:	// do motd updates here too
;3739:	trap_Cvar_VariableStringBuffer( "cl_motdString", uiInfo.serverStatus.motd, sizeof(uiInfo.serverStatus.motd) );
ADDRGP4 $2945
ARGP4
ADDRGP4 uiInfo+99276+10460
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 3740
;3740:	len = strlen(uiInfo.serverStatus.motd);
ADDRGP4 uiInfo+99276+10460
ARGP4
ADDRLP4 1056
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 1052
ADDRLP4 1056
INDIRU4
CVUI4 4
ASGNI4
line 3741
;3741:	if (len == 0) {
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $2952
line 3742
;3742:		strcpy(uiInfo.serverStatus.motd, "Welcome to Team Arena!");
ADDRGP4 uiInfo+99276+10460
ARGP4
ADDRGP4 $2956
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 3743
;3743:		len = strlen(uiInfo.serverStatus.motd);
ADDRGP4 uiInfo+99276+10460
ARGP4
ADDRLP4 1060
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 1052
ADDRLP4 1060
INDIRU4
CVUI4 4
ASGNI4
line 3744
;3744:	} 
LABELV $2952
line 3745
;3745:	if (len != uiInfo.serverStatus.motdLen) {
ADDRLP4 1052
INDIRI4
ADDRGP4 uiInfo+99276+10436
INDIRI4
EQI4 $2959
line 3746
;3746:		uiInfo.serverStatus.motdLen = len;
ADDRGP4 uiInfo+99276+10436
ADDRLP4 1052
INDIRI4
ASGNI4
line 3747
;3747:		uiInfo.serverStatus.motdWidth = -1;
ADDRGP4 uiInfo+99276+10440
CNSTI4 -1
ASGNI4
line 3748
;3748:	} 
LABELV $2959
line 3750
;3749:
;3750:	if (force) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $2967
line 3751
;3751:		numinvisible = 0;
ADDRGP4 $2937
CNSTI4 0
ASGNI4
line 3753
;3752:		// clear number of displayed servers
;3753:		uiInfo.serverStatus.numDisplayServers = 0;
ADDRGP4 uiInfo+99276+10412
CNSTI4 0
ASGNI4
line 3754
;3754:		uiInfo.serverStatus.numPlayersOnServers = 0;
ADDRGP4 uiInfo+99276+10416
CNSTI4 0
ASGNI4
line 3756
;3755:		// set list box index to zero
;3756:		Menu_SetFeederSelection(NULL, FEEDER_SERVERS, 0, NULL);
CNSTP4 0
ARGP4
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 3758
;3757:		// mark all servers as visible so we store ping updates for them
;3758:		trap_LAN_MarkServerVisible(ui_netSource.integer, -1, qtrue);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_LAN_MarkServerVisible
CALLV
pop
line 3759
;3759:	}
LABELV $2967
line 3762
;3760:
;3761:	// get the server count (comes from the master)
;3762:	count = trap_LAN_GetServerCount(ui_netSource.integer);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 1060
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRLP4 1036
ADDRLP4 1060
INDIRI4
ASGNI4
line 3763
;3763:	if (count == -1 || (ui_netSource.integer == AS_LOCAL && count == 0) ) {
ADDRLP4 1036
INDIRI4
CNSTI4 -1
EQI4 $2978
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
NEI4 $2975
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $2975
LABELV $2978
line 3765
;3764:		// still waiting on a response from the master
;3765:		uiInfo.serverStatus.numDisplayServers = 0;
ADDRGP4 uiInfo+99276+10412
CNSTI4 0
ASGNI4
line 3766
;3766:		uiInfo.serverStatus.numPlayersOnServers = 0;
ADDRGP4 uiInfo+99276+10416
CNSTI4 0
ASGNI4
line 3767
;3767:		uiInfo.serverStatus.nextDisplayRefresh = uiInfo.uiDC.realTime + 500;
ADDRGP4 uiInfo+99276+10420
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 3768
;3768:		return;
ADDRGP4 $2936
JUMPV
LABELV $2975
line 3771
;3769:	}
;3770:
;3771:	visible = qfalse;
ADDRLP4 1040
CNSTI4 0
ASGNI4
line 3772
;3772:	for (i = 0; i < count; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2989
JUMPV
LABELV $2986
line 3774
;3773:		// if we already got info for this server
;3774:		if (!trap_LAN_ServerIsVisible(ui_netSource.integer, i)) {
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1068
ADDRGP4 trap_LAN_ServerIsVisible
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
NEI4 $2990
line 3775
;3775:			continue;
ADDRGP4 $2987
JUMPV
LABELV $2990
line 3777
;3776:		}
;3777:		visible = qtrue;
ADDRLP4 1040
CNSTI4 1
ASGNI4
line 3779
;3778:		// get the ping for this server
;3779:		ping = trap_LAN_GetServerPing(ui_netSource.integer, i);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1072
ADDRGP4 trap_LAN_GetServerPing
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 1072
INDIRI4
ASGNI4
line 3780
;3780:		if (ping > 0 || ui_netSource.integer == AS_FAVORITES) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GTI4 $2997
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 3
NEI4 $2994
LABELV $2997
line 3782
;3781:
;3782:			trap_LAN_GetServerInfo(ui_netSource.integer, i, info, MAX_STRING_CHARS);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetServerInfo
CALLV
pop
line 3784
;3783:
;3784:			clients = atoi(Info_ValueForKey(info, "clients"));
ADDRLP4 12
ARGP4
ADDRGP4 $2999
ARGP4
ADDRLP4 1076
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1076
INDIRP4
ARGP4
ADDRLP4 1080
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 1080
INDIRI4
ASGNI4
line 3785
;3785:			uiInfo.serverStatus.numPlayersOnServers += clients;
ADDRLP4 1084
ADDRGP4 uiInfo+99276+10416
ASGNP4
ADDRLP4 1084
INDIRP4
ADDRLP4 1084
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 3787
;3786:
;3787:			if (ui_browserShowEmpty.integer == 0) {
ADDRGP4 ui_browserShowEmpty+12
INDIRI4
CNSTI4 0
NEI4 $3002
line 3788
;3788:				if (clients == 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $3005
line 3789
;3789:					trap_LAN_MarkServerVisible(ui_netSource.integer, i, qfalse);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_MarkServerVisible
CALLV
pop
line 3790
;3790:					continue;
ADDRGP4 $2987
JUMPV
LABELV $3005
line 3792
;3791:				}
;3792:			}
LABELV $3002
line 3794
;3793:
;3794:			if (ui_browserShowFull.integer == 0) {
ADDRGP4 ui_browserShowFull+12
INDIRI4
CNSTI4 0
NEI4 $3008
line 3795
;3795:				maxClients = atoi(Info_ValueForKey(info, "sv_maxclients"));
ADDRLP4 12
ARGP4
ADDRGP4 $1331
ARGP4
ADDRLP4 1088
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1088
INDIRP4
ARGP4
ADDRLP4 1092
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1044
ADDRLP4 1092
INDIRI4
ASGNI4
line 3796
;3796:				if (clients == maxClients) {
ADDRLP4 8
INDIRI4
ADDRLP4 1044
INDIRI4
NEI4 $3011
line 3797
;3797:					trap_LAN_MarkServerVisible(ui_netSource.integer, i, qfalse);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_MarkServerVisible
CALLV
pop
line 3798
;3798:					continue;
ADDRGP4 $2987
JUMPV
LABELV $3011
line 3800
;3799:				}
;3800:			}
LABELV $3008
line 3802
;3801:
;3802:			if (uiInfo.joinGameTypes[ui_joinGameType.integer].gtEnum != -1) {
ADDRGP4 ui_joinGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78724+4
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $3014
line 3803
;3803:				game = atoi(Info_ValueForKey(info, "gametype"));
ADDRLP4 12
ARGP4
ADDRGP4 $3019
ARGP4
ADDRLP4 1088
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1088
INDIRP4
ARGP4
ADDRLP4 1092
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1048
ADDRLP4 1092
INDIRI4
ASGNI4
line 3804
;3804:				if (game != uiInfo.joinGameTypes[ui_joinGameType.integer].gtEnum) {
ADDRLP4 1048
INDIRI4
ADDRGP4 ui_joinGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78724+4
ADDP4
INDIRI4
EQI4 $3020
line 3805
;3805:					trap_LAN_MarkServerVisible(ui_netSource.integer, i, qfalse);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_MarkServerVisible
CALLV
pop
line 3806
;3806:					continue;
ADDRGP4 $2987
JUMPV
LABELV $3020
line 3808
;3807:				}
;3808:			}
LABELV $3014
line 3817
;3809:				
;3810:			/*if (ui_serverFilterType.integer > 0) {
;3811:				if (Q_stricmp(Info_ValueForKey(info, "game"), serverFilters[ui_serverFilterType.integer].basedir) != 0) {
;3812:					trap_LAN_MarkServerVisible(ui_netSource.integer, i, qfalse);
;3813:					continue;
;3814:				}
;3815:			}*/
;3816:			// make sure we never add a favorite server twice
;3817:			if (ui_netSource.integer == AS_FAVORITES) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 3
NEI4 $3026
line 3818
;3818:				UI_RemoveServerFromDisplayList(i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 UI_RemoveServerFromDisplayList
CALLV
pop
line 3819
;3819:			}
LABELV $3026
line 3821
;3820:			// insert the server into the list
;3821:			UI_BinaryServerInsertion(i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 UI_BinaryServerInsertion
CALLV
pop
line 3823
;3822:			// done with this server
;3823:			if (ping > 0) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LEI4 $3029
line 3824
;3824:				trap_LAN_MarkServerVisible(ui_netSource.integer, i, qfalse);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_MarkServerVisible
CALLV
pop
line 3825
;3825:				numinvisible++;
ADDRLP4 1088
ADDRGP4 $2937
ASGNP4
ADDRLP4 1088
INDIRP4
ADDRLP4 1088
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3826
;3826:			}
LABELV $3029
line 3827
;3827:		}
LABELV $2994
line 3828
;3828:	}
LABELV $2987
line 3772
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2989
ADDRLP4 0
INDIRI4
ADDRLP4 1036
INDIRI4
LTI4 $2986
line 3830
;3829:
;3830:	uiInfo.serverStatus.refreshtime = uiInfo.uiDC.realTime;
ADDRGP4 uiInfo+99276+2192
ADDRGP4 uiInfo+208
INDIRI4
ASGNI4
line 3833
;3831:
;3832:	// if there were no servers visible for ping updates
;3833:	if (!visible) {
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $3035
line 3836
;3834://		UI_StopServerRefresh();
;3835://		uiInfo.serverStatus.nextDisplayRefresh = 0;
;3836:	}
LABELV $3035
line 3837
;3837:}
LABELV $2936
endproc UI_BuildServerDisplayList 1096 16
data
export serverStatusCvars
align 4
LABELV serverStatusCvars
address $3038
address $3039
address $3040
address $110
address $3041
address $3042
address $1294
address $3043
address $3044
address $3045
address $3046
address $110
address $2130
address $110
address $3047
address $110
address $698
address $110
byte 4 0
byte 4 0
code
proc UI_SortServerStatusInfo 44 8
line 3862
;3838:
;3839:typedef struct
;3840:{
;3841:	char *name, *altName;
;3842:} serverStatusCvar_t;
;3843:
;3844:serverStatusCvar_t serverStatusCvars[] = {
;3845:	{"sv_hostname", "Name"},
;3846:	{"Address", ""},
;3847:	{"gamename", "Game name"},
;3848:	{"g_gametype", "Game type"},
;3849:	{"mapname", "Map"},
;3850:	{"version", ""},
;3851:	{"protocol", ""},
;3852:	{"timelimit", ""},
;3853:	{"fraglimit", ""},
;3854:	{NULL, NULL}
;3855:};
;3856:
;3857:/*
;3858:==================
;3859:UI_SortServerStatusInfo
;3860:==================
;3861:*/
;3862:static void UI_SortServerStatusInfo( serverStatusInfo_t *info ) {
line 3869
;3863:	int i, j, index;
;3864:	char *tmp1, *tmp2;
;3865:
;3866:	// FIXME: if "gamename" == "baseq3" or "missionpack" then
;3867:	// replace the gametype number by FFA, CTF etc.
;3868:	//
;3869:	index = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3870
;3870:	for (i = 0; serverStatusCvars[i].name; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $3052
JUMPV
LABELV $3049
line 3871
;3871:		for (j = 0; j < info->numLines; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3056
JUMPV
LABELV $3053
line 3872
;3872:			if ( !info->lines[j][1] || info->lines[j][1][0] ) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3059
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $3057
LABELV $3059
line 3873
;3873:				continue;
ADDRGP4 $3054
JUMPV
LABELV $3057
line 3875
;3874:			}
;3875:			if ( !Q_stricmp(serverStatusCvars[i].name, info->lines[j][0]) ) {
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 serverStatusCvars
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $3060
line 3877
;3876:				// swap lines
;3877:				tmp1 = info->lines[index][0];
ADDRLP4 12
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDP4
INDIRP4
ASGNP4
line 3878
;3878:				tmp2 = info->lines[index][3];
ADDRLP4 16
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
INDIRP4
ASGNP4
line 3879
;3879:				info->lines[index][0] = info->lines[j][0];
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 64
ADDP4
ADDP4
INDIRP4
ASGNP4
line 3880
;3880:				info->lines[index][3] = info->lines[j][3];
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 36
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 36
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
INDIRP4
ASGNP4
line 3881
;3881:				info->lines[j][0] = tmp1;
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRLP4 12
INDIRP4
ASGNP4
line 3882
;3882:				info->lines[j][3] = tmp2;
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRLP4 16
INDIRP4
ASGNP4
line 3884
;3883:				//
;3884:				if ( strlen(serverStatusCvars[i].altName) ) {
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 serverStatusCvars+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 40
INDIRU4
CNSTU4 0
EQU4 $3062
line 3885
;3885:					info->lines[index][0] = serverStatusCvars[i].altName;
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 serverStatusCvars+4
ADDP4
INDIRP4
ASGNP4
line 3886
;3886:				}
LABELV $3062
line 3887
;3887:				index++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3888
;3888:			}
LABELV $3060
line 3889
;3889:		}
LABELV $3054
line 3871
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3056
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
LTI4 $3053
line 3890
;3890:	}
LABELV $3050
line 3870
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3052
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 serverStatusCvars
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3049
line 3891
;3891:}
LABELV $3048
endproc UI_SortServerStatusInfo 44 8
proc UI_GetServerStatusInfo 152 16
line 3898
;3892:
;3893:/*
;3894:==================
;3895:UI_GetServerStatusInfo
;3896:==================
;3897:*/
;3898:static int UI_GetServerStatusInfo( const char *serverAddress, serverStatusInfo_t *info ) {
line 3902
;3899:	char *p, *score, *ping, *name;
;3900:	int i, len;
;3901:
;3902:	if (!info) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3067
line 3903
;3903:		trap_LAN_ServerStatus( serverAddress, NULL, 0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_ServerStatus
CALLI4
pop
line 3904
;3904:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3066
JUMPV
LABELV $3067
line 3906
;3905:	}
;3906:	memset(info, 0, sizeof(*info));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 3332
ARGU4
ADDRGP4 memset
CALLP4
pop
line 3907
;3907:	if ( trap_LAN_ServerStatus( serverAddress, info->text, sizeof(info->text)) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 2112
ADDP4
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 24
ADDRGP4 trap_LAN_ServerStatus
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $3069
line 3908
;3908:		Q_strncpyz(info->address, serverAddress, sizeof(info->address));
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3909
;3909:		p = info->text;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 2112
ADDP4
ASGNP4
line 3910
;3910:		info->numLines = 0;
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
CNSTI4 0
ASGNI4
line 3911
;3911:		info->lines[info->numLines][0] = "Address";
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 28
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRGP4 $3040
ASGNP4
line 3912
;3912:		info->lines[info->numLines][1] = "";
ADDRLP4 32
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 4
ADDP4
ADDRGP4 $110
ASGNP4
line 3913
;3913:		info->lines[info->numLines][2] = "";
ADDRLP4 36
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 36
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 8
ADDP4
ADDRGP4 $110
ASGNP4
line 3914
;3914:		info->lines[info->numLines][3] = info->address;
ADDRLP4 40
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 40
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRLP4 40
INDIRP4
ASGNP4
line 3915
;3915:		info->numLines++;
ADDRLP4 44
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $3072
JUMPV
LABELV $3071
line 3917
;3916:		// get the cvars
;3917:		while (p && *p) {
line 3918
;3918:			p = strchr(p, '\\');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 48
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 48
INDIRP4
ASGNP4
line 3919
;3919:			if (!p) break;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3074
ADDRGP4 $3073
JUMPV
LABELV $3074
line 3920
;3920:			*p++ = '\0';
ADDRLP4 52
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 52
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI1 0
ASGNI1
line 3921
;3921:			if (*p == '\\')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $3076
line 3922
;3922:				break;
ADDRGP4 $3073
JUMPV
LABELV $3076
line 3923
;3923:			info->lines[info->numLines][0] = p;
ADDRLP4 56
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 56
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 3924
;3924:			info->lines[info->numLines][1] = "";
ADDRLP4 60
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 60
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 4
ADDP4
ADDRGP4 $110
ASGNP4
line 3925
;3925:			info->lines[info->numLines][2] = "";
ADDRLP4 64
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 64
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 8
ADDP4
ADDRGP4 $110
ASGNP4
line 3926
;3926:			p = strchr(p, '\\');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 68
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 68
INDIRP4
ASGNP4
line 3927
;3927:			if (!p) break;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3078
ADDRGP4 $3073
JUMPV
LABELV $3078
line 3928
;3928:			*p++ = '\0';
ADDRLP4 72
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 72
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI1 0
ASGNI1
line 3929
;3929:			info->lines[info->numLines][3] = p;
ADDRLP4 76
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 76
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 3931
;3930:
;3931:			info->numLines++;
ADDRLP4 80
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3932
;3932:			if (info->numLines >= MAX_SERVERSTATUS_LINES)
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 128
LTI4 $3080
line 3933
;3933:				break;
ADDRGP4 $3073
JUMPV
LABELV $3080
line 3934
;3934:		}
LABELV $3072
line 3917
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3082
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3071
LABELV $3082
LABELV $3073
line 3936
;3935:		// get the player list
;3936:		if (info->numLines < MAX_SERVERSTATUS_LINES-3) {
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 125
GEI4 $3083
line 3938
;3937:			// empty line
;3938:			info->lines[info->numLines][0] = "";
ADDRLP4 52
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 52
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRGP4 $110
ASGNP4
line 3939
;3939:			info->lines[info->numLines][1] = "";
ADDRLP4 56
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 56
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 4
ADDP4
ADDRGP4 $110
ASGNP4
line 3940
;3940:			info->lines[info->numLines][2] = "";
ADDRLP4 60
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 60
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 8
ADDP4
ADDRGP4 $110
ASGNP4
line 3941
;3941:			info->lines[info->numLines][3] = "";
ADDRLP4 64
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 64
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRGP4 $110
ASGNP4
line 3942
;3942:			info->numLines++;
ADDRLP4 68
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3944
;3943:			// header
;3944:			info->lines[info->numLines][0] = "num";
ADDRLP4 72
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 72
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRGP4 $3085
ASGNP4
line 3945
;3945:			info->lines[info->numLines][1] = "score";
ADDRLP4 76
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 76
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 4
ADDP4
ADDRGP4 $3086
ASGNP4
line 3946
;3946:			info->lines[info->numLines][2] = "ping";
ADDRLP4 80
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 80
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 8
ADDP4
ADDRGP4 $3087
ASGNP4
line 3947
;3947:			info->lines[info->numLines][3] = "name";
ADDRLP4 84
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 84
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRGP4 $1380
ASGNP4
line 3948
;3948:			info->numLines++;
ADDRLP4 88
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3950
;3949:			// parse players
;3950:			i = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 3951
;3951:			len = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $3089
JUMPV
LABELV $3088
line 3952
;3952:			while (p && *p) {
line 3953
;3953:				if (*p == '\\')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $3091
line 3954
;3954:					*p++ = '\0';
ADDRLP4 92
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 92
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI1 0
ASGNI1
LABELV $3091
line 3955
;3955:				if (!p)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3093
line 3956
;3956:					break;
ADDRGP4 $3090
JUMPV
LABELV $3093
line 3957
;3957:				score = p;
ADDRLP4 12
ADDRLP4 0
INDIRP4
ASGNP4
line 3958
;3958:				p = strchr(p, ' ');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 96
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 96
INDIRP4
ASGNP4
line 3959
;3959:				if (!p)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3095
line 3960
;3960:					break;
ADDRGP4 $3090
JUMPV
LABELV $3095
line 3961
;3961:				*p++ = '\0';
ADDRLP4 100
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 100
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI1 0
ASGNI1
line 3962
;3962:				ping = p;
ADDRLP4 16
ADDRLP4 0
INDIRP4
ASGNP4
line 3963
;3963:				p = strchr(p, ' ');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 104
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 104
INDIRP4
ASGNP4
line 3964
;3964:				if (!p)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3097
line 3965
;3965:					break;
ADDRGP4 $3090
JUMPV
LABELV $3097
line 3966
;3966:				*p++ = '\0';
ADDRLP4 108
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 108
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
CNSTI1 0
ASGNI1
line 3967
;3967:				name = p;
ADDRLP4 20
ADDRLP4 0
INDIRP4
ASGNP4
line 3968
;3968:				Com_sprintf(&info->pings[len], sizeof(info->pings)-len, "%d", i);
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 3136
ADDP4
ADDP4
ARGP4
CNSTU4 192
ADDRLP4 4
INDIRI4
CVIU4 4
SUBU4
CVUI4 4
ARGI4
ADDRGP4 $695
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3969
;3969:				info->lines[info->numLines][0] = &info->pings[len];
ADDRLP4 116
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 116
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 116
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRLP4 4
INDIRI4
ADDRLP4 116
INDIRP4
CNSTI4 3136
ADDP4
ADDP4
ASGNP4
line 3970
;3970:				len += strlen(&info->pings[len]) + 1;
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 3136
ADDP4
ADDP4
ARGP4
ADDRLP4 124
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 4
ADDRLP4 4
INDIRI4
CVIU4 4
ADDRLP4 124
INDIRU4
CNSTU4 1
ADDU4
ADDU4
CVUI4 4
ASGNI4
line 3971
;3971:				info->lines[info->numLines][1] = score;
ADDRLP4 128
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 128
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 128
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 12
INDIRP4
ASGNP4
line 3972
;3972:				info->lines[info->numLines][2] = ping;
ADDRLP4 132
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 132
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 132
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 16
INDIRP4
ASGNP4
line 3973
;3973:				info->lines[info->numLines][3] = name;
ADDRLP4 136
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 136
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 136
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRLP4 20
INDIRP4
ASGNP4
line 3974
;3974:				info->numLines++;
ADDRLP4 140
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
ASGNP4
ADDRLP4 140
INDIRP4
ADDRLP4 140
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3975
;3975:				if (info->numLines >= MAX_SERVERSTATUS_LINES)
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 128
LTI4 $3099
line 3976
;3976:					break;
ADDRGP4 $3090
JUMPV
LABELV $3099
line 3977
;3977:				p = strchr(p, '\\');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 144
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 144
INDIRP4
ASGNP4
line 3978
;3978:				if (!p)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3101
line 3979
;3979:					break;
ADDRGP4 $3090
JUMPV
LABELV $3101
line 3980
;3980:				*p++ = '\0';
ADDRLP4 148
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 148
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
CNSTI1 0
ASGNI1
line 3982
;3981:				//
;3982:				i++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3983
;3983:			}
LABELV $3089
line 3952
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3103
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3088
LABELV $3103
LABELV $3090
line 3984
;3984:		}
LABELV $3083
line 3985
;3985:		UI_SortServerStatusInfo( info );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 UI_SortServerStatusInfo
CALLV
pop
line 3986
;3986:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3066
JUMPV
LABELV $3069
line 3988
;3987:	}
;3988:	return qfalse;
CNSTI4 0
RETI4
LABELV $3066
endproc UI_GetServerStatusInfo 152 16
proc stristr 12 4
line 3996
;3989:}
;3990:
;3991:/*
;3992:==================
;3993:stristr
;3994:==================
;3995:*/
;3996:static char *stristr(char *str, char *charset) {
ADDRGP4 $3106
JUMPV
LABELV $3105
line 3999
;3997:	int i;
;3998:
;3999:	while(*str) {
line 4000
;4000:		for (i = 0; charset[i] && str[i]; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3111
JUMPV
LABELV $3108
line 4001
;4001:			if (toupper(charset[i]) != toupper(str[i])) break;
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
EQI4 $3112
ADDRGP4 $3110
JUMPV
LABELV $3112
line 4002
;4002:		}
LABELV $3109
line 4000
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3111
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $3114
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3108
LABELV $3114
LABELV $3110
line 4003
;4003:		if (!charset[i]) return str;
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3115
ADDRFP4 0
INDIRP4
RETP4
ADDRGP4 $3104
JUMPV
LABELV $3115
line 4004
;4004:		str++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 4005
;4005:	}
LABELV $3106
line 3999
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3105
line 4006
;4006:	return NULL;
CNSTP4 0
RETP4
LABELV $3104
endproc stristr 12 4
bss
align 4
LABELV $3118
skip 4
align 4
LABELV $3119
skip 4
code
proc UI_BuildFindPlayerList 4424 24
line 4014
;4007:}
;4008:
;4009:/*
;4010:==================
;4011:UI_BuildFindPlayerList
;4012:==================
;4013:*/
;4014:static void UI_BuildFindPlayerList(qboolean force) {
line 4021
;4015:	static int numFound, numTimeOuts;
;4016:	int i, j, resend;
;4017:	serverStatusInfo_t info;
;4018:	char name[MAX_NAME_LENGTH+2];
;4019:	char infoString[MAX_STRING_CHARS];
;4020:
;4021:	if (!force) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $3120
line 4022
;4022:		if (!uiInfo.nextFindPlayerRefresh || uiInfo.nextFindPlayerRefresh > uiInfo.uiDC.realTime) {
ADDRGP4 uiInfo+119484
INDIRI4
CNSTI4 0
EQI4 $3127
ADDRGP4 uiInfo+119484
INDIRI4
ADDRGP4 uiInfo+208
INDIRI4
LEI4 $3121
LABELV $3127
line 4023
;4023:			return;
ADDRGP4 $3117
JUMPV
line 4025
;4024:		}
;4025:	}
LABELV $3120
line 4026
;4026:	else {
line 4027
;4027:		memset(&uiInfo.pendingServerStatus, 0, sizeof(uiInfo.pendingServerStatus));
ADDRGP4 uiInfo+114160
ARGP4
CNSTI4 0
ARGI4
CNSTU4 2244
ARGU4
ADDRGP4 memset
CALLP4
pop
line 4028
;4028:		uiInfo.numFoundPlayerServers = 0;
ADDRGP4 uiInfo+119480
CNSTI4 0
ASGNI4
line 4029
;4029:		uiInfo.currentFoundPlayerServer = 0;
ADDRGP4 uiInfo+119476
CNSTI4 0
ASGNI4
line 4030
;4030:		trap_Cvar_VariableStringBuffer( "ui_findPlayer", uiInfo.findPlayerName, sizeof(uiInfo.findPlayerName));
ADDRGP4 $3132
ARGP4
ADDRGP4 uiInfo+116404
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 4031
;4031:		Q_CleanStr(uiInfo.findPlayerName);
ADDRGP4 uiInfo+116404
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 4033
;4032:		// should have a string of some length
;4033:		if (!strlen(uiInfo.findPlayerName)) {
ADDRGP4 uiInfo+116404
ARGP4
ADDRLP4 4404
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 4404
INDIRU4
CNSTU4 0
NEU4 $3136
line 4034
;4034:			uiInfo.nextFindPlayerRefresh = 0;
ADDRGP4 uiInfo+119484
CNSTI4 0
ASGNI4
line 4035
;4035:			return;
ADDRGP4 $3117
JUMPV
LABELV $3136
line 4038
;4036:		}
;4037:		// set resend time
;4038:		resend = ui_serverStatusTimeOut.integer / 2 - 10;
ADDRLP4 4400
ADDRGP4 ui_serverStatusTimeOut+12
INDIRI4
CNSTI4 2
DIVI4
CNSTI4 10
SUBI4
ASGNI4
line 4039
;4039:		if (resend < 50) {
ADDRLP4 4400
INDIRI4
CNSTI4 50
GEI4 $3141
line 4040
;4040:			resend = 50;
ADDRLP4 4400
CNSTI4 50
ASGNI4
line 4041
;4041:		}
LABELV $3141
line 4042
;4042:		trap_Cvar_Set("cl_serverStatusResendTime", va("%d", resend));
ADDRGP4 $695
ARGP4
ADDRLP4 4400
INDIRI4
ARGI4
ADDRLP4 4408
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $3143
ARGP4
ADDRLP4 4408
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4044
;4043:		// reset all server status requests
;4044:		trap_LAN_ServerStatus( NULL, NULL, 0);
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_ServerStatus
CALLI4
pop
line 4046
;4045:		//
;4046:		uiInfo.numFoundPlayerServers = 1;
ADDRGP4 uiInfo+119480
CNSTI4 1
ASGNI4
line 4047
;4047:		Com_sprintf(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers-1],
ADDRGP4 uiInfo+119480
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+118452-64
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $3151
ARGP4
ADDRGP4 uiInfo+114160
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4050
;4048:						sizeof(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers-1]),
;4049:							"searching %d...", uiInfo.pendingServerStatus.num);
;4050:		numFound = 0;
ADDRGP4 $3118
CNSTI4 0
ASGNI4
line 4051
;4051:		numTimeOuts++;
ADDRLP4 4412
ADDRGP4 $3119
ASGNP4
ADDRLP4 4412
INDIRP4
ADDRLP4 4412
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4052
;4052:	}
LABELV $3121
line 4053
;4053:	for (i = 0; i < MAX_SERVERSTATUSREQUESTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $3153
line 4055
;4054:		// if this pending server is valid
;4055:		if (uiInfo.pendingServerStatus.server[i].valid) {
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114160+4+136
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3157
line 4057
;4056:			// try to get the server status for this server
;4057:			if (UI_GetServerStatusInfo( uiInfo.pendingServerStatus.server[i].adrstr, &info ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114160+4
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 4404
ADDRGP4 UI_GetServerStatusInfo
CALLI4
ASGNI4
ADDRLP4 4404
INDIRI4
CNSTI4 0
EQI4 $3162
line 4059
;4058:				//
;4059:				numFound++;
ADDRLP4 4408
ADDRGP4 $3118
ASGNP4
ADDRLP4 4408
INDIRP4
ADDRLP4 4408
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4061
;4060:				// parse through the server status lines
;4061:				for (j = 0; j < info.numLines; j++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $3169
JUMPV
LABELV $3166
line 4063
;4062:					// should have ping info
;4063:					if ( !info.lines[j][2] || !info.lines[j][2][0] ) {
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 8+64+8
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3177
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 8+64+8
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3171
LABELV $3177
line 4064
;4064:						continue;
ADDRGP4 $3167
JUMPV
LABELV $3171
line 4067
;4065:					}
;4066:					// clean string first
;4067:					Q_strncpyz(name, info.lines[j][3], sizeof(name));
ADDRLP4 3340
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 8+64+12
ADDP4
INDIRP4
ARGP4
CNSTI4 34
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4068
;4068:					Q_CleanStr(name);
ADDRLP4 3340
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 4070
;4069:					// if the player name is a substring
;4070:					if (stristr(name, uiInfo.findPlayerName)) {
ADDRLP4 3340
ARGP4
ADDRGP4 uiInfo+116404
ARGP4
ADDRLP4 4416
ADDRGP4 stristr
CALLP4
ASGNP4
ADDRLP4 4416
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3180
line 4072
;4071:						// add to found server list if we have space (always leave space for a line with the number found)
;4072:						if (uiInfo.numFoundPlayerServers < MAX_FOUNDPLAYER_SERVERS-1) {
ADDRGP4 uiInfo+119480
INDIRI4
CNSTI4 15
GEI4 $3183
line 4074
;4073:							//
;4074:							Q_strncpyz(uiInfo.foundPlayerServerAddresses[uiInfo.numFoundPlayerServers-1],
ADDRGP4 uiInfo+119480
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+117428-64
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114160+4
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4077
;4075:										uiInfo.pendingServerStatus.server[i].adrstr,
;4076:											sizeof(uiInfo.foundPlayerServerAddresses[0]));
;4077:							Q_strncpyz(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers-1],
ADDRGP4 uiInfo+119480
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+118452-64
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114160+4+64
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4080
;4078:										uiInfo.pendingServerStatus.server[i].name,
;4079:											sizeof(uiInfo.foundPlayerServerNames[0]));
;4080:							uiInfo.numFoundPlayerServers++;
ADDRLP4 4420
ADDRGP4 uiInfo+119480
ASGNP4
ADDRLP4 4420
INDIRP4
ADDRLP4 4420
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4081
;4081:						}
ADDRGP4 $3184
JUMPV
LABELV $3183
line 4082
;4082:						else {
line 4084
;4083:							// can't add any more so we're done
;4084:							uiInfo.pendingServerStatus.num = uiInfo.serverStatus.numDisplayServers;
ADDRGP4 uiInfo+114160
ADDRGP4 uiInfo+99276+10412
INDIRI4
ASGNI4
line 4085
;4085:						}
LABELV $3184
line 4086
;4086:					}
LABELV $3180
line 4087
;4087:				}
LABELV $3167
line 4061
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3169
ADDRLP4 4
INDIRI4
ADDRLP4 8+3328
INDIRI4
LTI4 $3166
line 4088
;4088:				Com_sprintf(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers-1],
ADDRGP4 uiInfo+119480
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+118452-64
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $3209
ARGP4
ADDRGP4 uiInfo+114160
INDIRI4
ARGI4
ADDRGP4 $3118
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4092
;4089:								sizeof(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers-1]),
;4090:									"searching %d/%d...", uiInfo.pendingServerStatus.num, numFound);
;4091:				// retrieved the server status so reuse this spot
;4092:				uiInfo.pendingServerStatus.server[i].valid = qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114160+4+136
ADDP4
CNSTI4 0
ASGNI4
line 4093
;4093:			}
LABELV $3162
line 4094
;4094:		}
LABELV $3157
line 4096
;4095:		// if empty pending slot or timed out
;4096:		if (!uiInfo.pendingServerStatus.server[i].valid ||
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114160+4+136
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3224
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114160+4+128
ADDP4
INDIRI4
ADDRGP4 uiInfo+208
INDIRI4
ADDRGP4 ui_serverStatusTimeOut+12
INDIRI4
SUBI4
GEI4 $3214
LABELV $3224
line 4097
;4097:			uiInfo.pendingServerStatus.server[i].startTime < uiInfo.uiDC.realTime - ui_serverStatusTimeOut.integer) {
line 4098
;4098:			if (uiInfo.pendingServerStatus.server[i].valid) {
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114160+4+136
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3225
line 4099
;4099:				numTimeOuts++;
ADDRLP4 4408
ADDRGP4 $3119
ASGNP4
ADDRLP4 4408
INDIRP4
ADDRLP4 4408
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4100
;4100:			}
LABELV $3225
line 4102
;4101:			// reset server status request for this address
;4102:			UI_GetServerStatusInfo( uiInfo.pendingServerStatus.server[i].adrstr, NULL );
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114160+4
ADDP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 UI_GetServerStatusInfo
CALLI4
pop
line 4104
;4103:			// reuse pending slot
;4104:			uiInfo.pendingServerStatus.server[i].valid = qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114160+4+136
ADDP4
CNSTI4 0
ASGNI4
line 4106
;4105:			// if we didn't try to get the status of all servers in the main browser yet
;4106:			if (uiInfo.pendingServerStatus.num < uiInfo.serverStatus.numDisplayServers) {
ADDRGP4 uiInfo+114160
INDIRI4
ADDRGP4 uiInfo+99276+10412
INDIRI4
GEI4 $3235
line 4107
;4107:				uiInfo.pendingServerStatus.server[i].startTime = uiInfo.uiDC.realTime;
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114160+4+128
ADDP4
ADDRGP4 uiInfo+208
INDIRI4
ASGNI4
line 4108
;4108:				trap_LAN_GetServerAddressString(ui_netSource.integer, uiInfo.serverStatus.displayServers[uiInfo.pendingServerStatus.num],
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 uiInfo+114160
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99276+2220
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114160+4
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_LAN_GetServerAddressString
CALLV
pop
line 4110
;4109:							uiInfo.pendingServerStatus.server[i].adrstr, sizeof(uiInfo.pendingServerStatus.server[i].adrstr));
;4110:				trap_LAN_GetServerInfo(ui_netSource.integer, uiInfo.serverStatus.displayServers[uiInfo.pendingServerStatus.num], infoString, sizeof(infoString));
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 uiInfo+114160
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99276+2220
ADDP4
INDIRI4
ARGI4
ADDRLP4 3374
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetServerInfo
CALLV
pop
line 4111
;4111:				Q_strncpyz(uiInfo.pendingServerStatus.server[i].name, Info_ValueForKey(infoString, "hostname"), sizeof(uiInfo.pendingServerStatus.server[0].name));
ADDRLP4 3374
ARGP4
ADDRGP4 $2661
ARGP4
ADDRLP4 4408
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114160+4+64
ADDP4
ARGP4
ADDRLP4 4408
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4112
;4112:				uiInfo.pendingServerStatus.server[i].valid = qtrue;
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114160+4+136
ADDP4
CNSTI4 1
ASGNI4
line 4113
;4113:				uiInfo.pendingServerStatus.num++;
ADDRLP4 4412
ADDRGP4 uiInfo+114160
ASGNP4
ADDRLP4 4412
INDIRP4
ADDRLP4 4412
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4114
;4114:				Com_sprintf(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers-1],
ADDRGP4 uiInfo+119480
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+118452-64
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $3209
ARGP4
ADDRGP4 uiInfo+114160
INDIRI4
ARGI4
ADDRGP4 $3118
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4117
;4115:								sizeof(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers-1]),
;4116:									"searching %d/%d...", uiInfo.pendingServerStatus.num, numFound);
;4117:			}
LABELV $3235
line 4118
;4118:		}
LABELV $3214
line 4119
;4119:	}
LABELV $3154
line 4053
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $3153
line 4120
;4120:	for (i = 0; i < MAX_SERVERSTATUSREQUESTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $3273
line 4121
;4121:		if (uiInfo.pendingServerStatus.server[i].valid) {
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114160+4+136
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3277
line 4122
;4122:			break;
ADDRGP4 $3275
JUMPV
LABELV $3277
line 4124
;4123:		}
;4124:	}
LABELV $3274
line 4120
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $3273
LABELV $3275
line 4126
;4125:	// if still trying to retrieve server status info
;4126:	if (i < MAX_SERVERSTATUSREQUESTS) {
ADDRLP4 0
INDIRI4
CNSTI4 16
GEI4 $3282
line 4127
;4127:		uiInfo.nextFindPlayerRefresh = uiInfo.uiDC.realTime + 25;
ADDRGP4 uiInfo+119484
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 25
ADDI4
ASGNI4
line 4128
;4128:	}
ADDRGP4 $3283
JUMPV
LABELV $3282
line 4129
;4129:	else {
line 4131
;4130:		// add a line that shows the number of servers found
;4131:		if (!uiInfo.numFoundPlayerServers) {
ADDRGP4 uiInfo+119480
INDIRI4
CNSTI4 0
NEI4 $3286
line 4132
;4132:			Com_sprintf(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers-1], sizeof(uiInfo.foundPlayerServerAddresses[0]), "no servers found");
ADDRGP4 uiInfo+119480
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+118452-64
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $3293
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4133
;4133:		}
ADDRGP4 $3287
JUMPV
LABELV $3286
line 4134
;4134:		else {
line 4135
;4135:			Com_sprintf(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers-1], sizeof(uiInfo.foundPlayerServerAddresses[0]),
ADDRGP4 uiInfo+119480
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+118452-64
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $3298
ARGP4
ADDRGP4 uiInfo+119480
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 uiInfo+119480
INDIRI4
CNSTI4 2
NEI4 $3304
ADDRLP4 4404
ADDRGP4 $110
ASGNP4
ADDRGP4 $3305
JUMPV
LABELV $3304
ADDRLP4 4404
ADDRGP4 $3301
ASGNP4
LABELV $3305
ADDRLP4 4404
INDIRP4
ARGP4
ADDRGP4 uiInfo+116404
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4138
;4136:						"%d server%s found with player %s", uiInfo.numFoundPlayerServers-1,
;4137:						uiInfo.numFoundPlayerServers == 2 ? "":"s", uiInfo.findPlayerName);
;4138:		}
LABELV $3287
line 4139
;4139:		uiInfo.nextFindPlayerRefresh = 0;
ADDRGP4 uiInfo+119484
CNSTI4 0
ASGNI4
line 4141
;4140:		// show the server status info for the selected server
;4141:		UI_FeederSelection(FEEDER_FINDPLAYER, uiInfo.currentFoundPlayerServer);
CNSTF4 1096810496
ARGF4
ADDRGP4 uiInfo+119476
INDIRI4
ARGI4
ADDRGP4 UI_FeederSelection
CALLV
pop
line 4142
;4142:	}
LABELV $3283
line 4143
;4143:}
LABELV $3117
endproc UI_BuildFindPlayerList 4424 24
proc UI_BuildServerStatus 4 16
line 4150
;4144:
;4145:/*
;4146:==================
;4147:UI_BuildServerStatus
;4148:==================
;4149:*/
;4150:static void UI_BuildServerStatus(qboolean force) {
line 4152
;4151:
;4152:	if (uiInfo.nextFindPlayerRefresh) {
ADDRGP4 uiInfo+119484
INDIRI4
CNSTI4 0
EQI4 $3309
line 4153
;4153:		return;
ADDRGP4 $3308
JUMPV
LABELV $3309
line 4155
;4154:	}
;4155:	if (!force) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $3312
line 4156
;4156:		if (!uiInfo.nextServerStatusRefresh || uiInfo.nextServerStatusRefresh > uiInfo.uiDC.realTime) {
ADDRGP4 uiInfo+114156
INDIRI4
CNSTI4 0
EQI4 $3319
ADDRGP4 uiInfo+114156
INDIRI4
ADDRGP4 uiInfo+208
INDIRI4
LEI4 $3313
LABELV $3319
line 4157
;4157:			return;
ADDRGP4 $3308
JUMPV
line 4159
;4158:		}
;4159:	}
LABELV $3312
line 4160
;4160:	else {
line 4161
;4161:		Menu_SetFeederSelection(NULL, FEEDER_SERVERSTATUS, 0, NULL);
CNSTP4 0
ARGP4
CNSTI4 13
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 4162
;4162:		uiInfo.serverStatusInfo.numLines = 0;
ADDRGP4 uiInfo+110824+3328
CNSTI4 0
ASGNI4
line 4164
;4163:		// reset all server status requests
;4164:		trap_LAN_ServerStatus( NULL, NULL, 0);
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_ServerStatus
CALLI4
pop
line 4165
;4165:	}
LABELV $3313
line 4166
;4166:	if (uiInfo.serverStatus.currentServer < 0 || uiInfo.serverStatus.currentServer > uiInfo.serverStatus.numDisplayServers || uiInfo.serverStatus.numDisplayServers == 0) {
ADDRGP4 uiInfo+99276+2216
INDIRI4
CNSTI4 0
LTI4 $3333
ADDRGP4 uiInfo+99276+2216
INDIRI4
ADDRGP4 uiInfo+99276+10412
INDIRI4
GTI4 $3333
ADDRGP4 uiInfo+99276+10412
INDIRI4
CNSTI4 0
NEI4 $3322
LABELV $3333
line 4167
;4167:		return;
ADDRGP4 $3308
JUMPV
LABELV $3322
line 4169
;4168:	}
;4169:	if (UI_GetServerStatusInfo( uiInfo.serverStatusAddress, &uiInfo.serverStatusInfo ) ) {
ADDRGP4 uiInfo+110760
ARGP4
ADDRGP4 uiInfo+110824
ARGP4
ADDRLP4 0
ADDRGP4 UI_GetServerStatusInfo
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $3334
line 4170
;4170:		uiInfo.nextServerStatusRefresh = 0;
ADDRGP4 uiInfo+114156
CNSTI4 0
ASGNI4
line 4171
;4171:		UI_GetServerStatusInfo( uiInfo.serverStatusAddress, NULL );
ADDRGP4 uiInfo+110760
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 UI_GetServerStatusInfo
CALLI4
pop
line 4172
;4172:	}
ADDRGP4 $3335
JUMPV
LABELV $3334
line 4173
;4173:	else {
line 4174
;4174:		uiInfo.nextServerStatusRefresh = uiInfo.uiDC.realTime + 500;
ADDRGP4 uiInfo+114156
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 4175
;4175:	}
LABELV $3335
line 4176
;4176:}
LABELV $3308
endproc UI_BuildServerStatus 4 16
proc UI_FeederCount 12 4
line 4183
;4177:
;4178:/*
;4179:==================
;4180:UI_FeederCount
;4181:==================
;4182:*/
;4183:static int UI_FeederCount(float feederID) {
line 4184
;4184:	if (feederID == FEEDER_HEADS) {
ADDRFP4 0
INDIRF4
CNSTF4 0
NEF4 $3343
line 4185
;4185:		return UI_HeadCountByTeam();
ADDRLP4 0
ADDRGP4 UI_HeadCountByTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $3342
JUMPV
LABELV $3343
line 4186
;4186:	} else if (feederID == FEEDER_Q3HEADS) {
ADDRFP4 0
INDIRF4
CNSTF4 1094713344
NEF4 $3345
line 4187
;4187:		return uiInfo.q3HeadCount;
ADDRGP4 uiInfo+119500
INDIRI4
RETI4
ADDRGP4 $3342
JUMPV
LABELV $3345
line 4188
;4188:	} else if (feederID == FEEDER_CINEMATICS) {
ADDRFP4 0
INDIRF4
CNSTF4 1097859072
NEF4 $3348
line 4189
;4189:		return uiInfo.movieCount;
ADDRGP4 uiInfo+99264
INDIRI4
RETI4
ADDRGP4 $3342
JUMPV
LABELV $3348
line 4190
;4190:	} else if (feederID == FEEDER_MAPS || feederID == FEEDER_ALLMAPS) {
ADDRLP4 0
ADDRFP4 0
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
EQF4 $3353
ADDRLP4 0
INDIRF4
CNSTF4 1082130432
NEF4 $3351
LABELV $3353
line 4191
;4191:		return UI_MapCountByGameType(feederID == FEEDER_MAPS ? qtrue : qfalse);
ADDRFP4 0
INDIRF4
CNSTF4 1065353216
NEF4 $3355
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $3356
JUMPV
LABELV $3355
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $3356
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 UI_MapCountByGameType
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $3342
JUMPV
LABELV $3351
line 4192
;4192:	} else if (feederID == FEEDER_SERVERS) {
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
NEF4 $3357
line 4193
;4193:		return uiInfo.serverStatus.numDisplayServers;
ADDRGP4 uiInfo+99276+10412
INDIRI4
RETI4
ADDRGP4 $3342
JUMPV
LABELV $3357
line 4194
;4194:	} else if (feederID == FEEDER_SERVERSTATUS) {
ADDRFP4 0
INDIRF4
CNSTF4 1095761920
NEF4 $3361
line 4195
;4195:		return uiInfo.serverStatusInfo.numLines;
ADDRGP4 uiInfo+110824+3328
INDIRI4
RETI4
ADDRGP4 $3342
JUMPV
LABELV $3361
line 4196
;4196:	} else if (feederID == FEEDER_FINDPLAYER) {
ADDRFP4 0
INDIRF4
CNSTF4 1096810496
NEF4 $3365
line 4197
;4197:		return uiInfo.numFoundPlayerServers;
ADDRGP4 uiInfo+119480
INDIRI4
RETI4
ADDRGP4 $3342
JUMPV
LABELV $3365
line 4198
;4198:	} else if (feederID == FEEDER_PLAYER_LIST) {
ADDRFP4 0
INDIRF4
CNSTF4 1088421888
NEF4 $3368
line 4199
;4199:		if (uiInfo.uiDC.realTime > uiInfo.playerRefresh) {
ADDRGP4 uiInfo+208
INDIRI4
ADDRGP4 uiInfo+78868
INDIRI4
LEI4 $3370
line 4200
;4200:			uiInfo.playerRefresh = uiInfo.uiDC.realTime + 3000;
ADDRGP4 uiInfo+78868
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 4201
;4201:			UI_BuildPlayerList();
ADDRGP4 UI_BuildPlayerList
CALLV
pop
line 4202
;4202:		}
LABELV $3370
line 4203
;4203:		return uiInfo.playerCount;
ADDRGP4 uiInfo+78856
INDIRI4
RETI4
ADDRGP4 $3342
JUMPV
LABELV $3368
line 4204
;4204:	} else if (feederID == FEEDER_TEAM_LIST) {
ADDRFP4 0
INDIRF4
CNSTF4 1090519040
NEF4 $3377
line 4205
;4205:		if (uiInfo.uiDC.realTime > uiInfo.playerRefresh) {
ADDRGP4 uiInfo+208
INDIRI4
ADDRGP4 uiInfo+78868
INDIRI4
LEI4 $3379
line 4206
;4206:			uiInfo.playerRefresh = uiInfo.uiDC.realTime + 3000;
ADDRGP4 uiInfo+78868
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 4207
;4207:			UI_BuildPlayerList();
ADDRGP4 UI_BuildPlayerList
CALLV
pop
line 4208
;4208:		}
LABELV $3379
line 4209
;4209:		return uiInfo.myTeamCount;
ADDRGP4 uiInfo+78860
INDIRI4
RETI4
ADDRGP4 $3342
JUMPV
LABELV $3377
line 4210
;4210:	} else if (feederID == FEEDER_MODS) {
ADDRFP4 0
INDIRF4
CNSTF4 1091567616
NEF4 $3386
line 4211
;4211:		return uiInfo.modCount;
ADDRGP4 uiInfo+97200
INDIRI4
RETI4
ADDRGP4 $3342
JUMPV
LABELV $3386
line 4212
;4212:	} else if (feederID == FEEDER_DEMOS) {
ADDRFP4 0
INDIRF4
CNSTF4 1092616192
NEF4 $3389
line 4213
;4213:		return uiInfo.demoCount;
ADDRGP4 uiInfo+98232
INDIRI4
RETI4
ADDRGP4 $3342
JUMPV
LABELV $3389
line 4215
;4214:	}
;4215:	return 0;
CNSTI4 0
RETI4
LABELV $3342
endproc UI_FeederCount 12 4
proc UI_SelectedMap 8 0
line 4218
;4216:}
;4217:
;4218:static const char *UI_SelectedMap(int index, int *actual) {
line 4220
;4219:	int i, c;
;4220:	c = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 4221
;4221:	*actual = 0;
ADDRFP4 4
INDIRP4
CNSTI4 0
ASGNI4
line 4222
;4222:	for (i = 0; i < uiInfo.mapCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3396
JUMPV
LABELV $3393
line 4223
;4223:		if (uiInfo.mapList[i].active) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+96
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3398
line 4224
;4224:			if (c == index) {
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $3402
line 4225
;4225:				*actual = i;
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ASGNI4
line 4226
;4226:				return uiInfo.mapList[i].mapName;
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240
ADDP4
INDIRP4
RETP4
ADDRGP4 $3392
JUMPV
LABELV $3402
line 4227
;4227:			} else {
line 4228
;4228:				c++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4229
;4229:			}
line 4230
;4230:		}
LABELV $3398
line 4231
;4231:	}
LABELV $3394
line 4222
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3396
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+83236
INDIRI4
LTI4 $3393
line 4232
;4232:	return "";
ADDRGP4 $110
RETP4
LABELV $3392
endproc UI_SelectedMap 8 0
proc UI_SelectedHead 8 0
line 4235
;4233:}
;4234:
;4235:static const char *UI_SelectedHead(int index, int *actual) {
line 4237
;4236:	int i, c;
;4237:	c = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 4238
;4238:	*actual = 0;
ADDRFP4 4
INDIRP4
CNSTI4 0
ASGNI4
line 4239
;4239:	for (i = 0; i < uiInfo.characterCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3409
JUMPV
LABELV $3406
line 4240
;4240:		if (uiInfo.characterList[i].active) {
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460+16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3411
line 4241
;4241:			if (c == index) {
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $3415
line 4242
;4242:				*actual = i;
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ASGNI4
line 4243
;4243:				return uiInfo.characterList[i].name;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460
ADDP4
INDIRP4
RETP4
ADDRGP4 $3405
JUMPV
LABELV $3415
line 4244
;4244:			} else {
line 4245
;4245:				c++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4246
;4246:			}
line 4247
;4247:		}
LABELV $3411
line 4248
;4248:	}
LABELV $3407
line 4239
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3409
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+73452
INDIRI4
LTI4 $3406
line 4249
;4249:	return "";
ADDRGP4 $110
RETP4
LABELV $3405
endproc UI_SelectedHead 8 0
proc UI_GetIndexFromSelection 8 0
line 4252
;4250:}
;4251:
;4252:static int UI_GetIndexFromSelection(int actual) {
line 4254
;4253:	int i, c;
;4254:	c = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 4255
;4255:	for (i = 0; i < uiInfo.mapCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3422
JUMPV
LABELV $3419
line 4256
;4256:		if (uiInfo.mapList[i].active) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+96
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3424
line 4257
;4257:			if (i == actual) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $3428
line 4258
;4258:				return c;
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $3418
JUMPV
LABELV $3428
line 4260
;4259:			}
;4260:				c++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4261
;4261:		}
LABELV $3424
line 4262
;4262:	}
LABELV $3420
line 4255
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3422
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+83236
INDIRI4
LTI4 $3419
line 4263
;4263:  return 0;
CNSTI4 0
RETI4
LABELV $3418
endproc UI_GetIndexFromSelection 8 0
proc UI_UpdatePendingPings 0 4
line 4266
;4264:}
;4265:
;4266:static void UI_UpdatePendingPings() { 
line 4267
;4267:	trap_LAN_ResetPings(ui_netSource.integer);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 trap_LAN_ResetPings
CALLV
pop
line 4268
;4268:	uiInfo.serverStatus.refreshActive = qtrue;
ADDRGP4 uiInfo+99276+2212
CNSTI4 1
ASGNI4
line 4269
;4269:	uiInfo.serverStatus.refreshtime = uiInfo.uiDC.realTime + 1000;
ADDRGP4 uiInfo+99276+2192
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 4271
;4270:
;4271:}
LABELV $3430
endproc UI_UpdatePendingPings 0 4
bss
align 1
LABELV $3438
skip 1024
align 1
LABELV $3439
skip 1024
align 1
LABELV $3440
skip 32
data
align 4
LABELV $3441
byte 4 -1
align 4
LABELV $3442
byte 4 0
code
proc UI_FeederItemText 64 20
line 4273
;4272:
;4273:static const char *UI_FeederItemText(float feederID, int index, int column, qhandle_t *handle) {
line 4279
;4274:	static char info[MAX_STRING_CHARS];
;4275:	static char hostname[1024];
;4276:	static char clientBuff[32];
;4277:	static int lastColumn = -1;
;4278:	static int lastTime = 0;
;4279:	*handle = -1;
ADDRFP4 12
INDIRP4
CNSTI4 -1
ASGNI4
line 4280
;4280:	if (feederID == FEEDER_HEADS) {
ADDRFP4 0
INDIRF4
CNSTF4 0
NEF4 $3443
line 4282
;4281:		int actual;
;4282:		return UI_SelectedHead(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 UI_SelectedHead
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
RETP4
ADDRGP4 $3437
JUMPV
LABELV $3443
line 4283
;4283:	} else if (feederID == FEEDER_Q3HEADS) {
ADDRFP4 0
INDIRF4
CNSTF4 1094713344
NEF4 $3445
line 4284
;4284:		if (index >= 0 && index < uiInfo.q3HeadCount) {
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $3446
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+119500
INDIRI4
GEI4 $3446
line 4285
;4285:			return uiInfo.q3HeadNames[index];
ADDRFP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+119504
ADDP4
RETP4
ADDRGP4 $3437
JUMPV
line 4287
;4286:		}
;4287:	} else if (feederID == FEEDER_MAPS || feederID == FEEDER_ALLMAPS) {
LABELV $3445
ADDRLP4 0
ADDRFP4 0
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
EQF4 $3453
ADDRLP4 0
INDIRF4
CNSTF4 1082130432
NEF4 $3451
LABELV $3453
line 4289
;4288:		int actual;
;4289:		return UI_SelectedMap(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 UI_SelectedMap
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
RETP4
ADDRGP4 $3437
JUMPV
LABELV $3451
line 4290
;4290:	} else if (feederID == FEEDER_SERVERS) {
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
NEF4 $3454
line 4291
;4291:		if (index >= 0 && index < uiInfo.serverStatus.numDisplayServers) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3455
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+99276+10412
INDIRI4
GEI4 $3455
line 4293
;4292:			int ping, game, punkbuster;
;4293:			if (lastColumn != column || lastTime > uiInfo.uiDC.realTime + 5000) {
ADDRGP4 $3441
INDIRI4
ADDRFP4 8
INDIRI4
NEI4 $3463
ADDRGP4 $3442
INDIRI4
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 5000
ADDI4
LEI4 $3460
LABELV $3463
line 4294
;4294:				trap_LAN_GetServerInfo(ui_netSource.integer, uiInfo.serverStatus.displayServers[index], info, MAX_STRING_CHARS);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99276+2220
ADDP4
INDIRI4
ARGI4
ADDRGP4 $3438
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetServerInfo
CALLV
pop
line 4295
;4295:				lastColumn = column;
ADDRGP4 $3441
ADDRFP4 8
INDIRI4
ASGNI4
line 4296
;4296:				lastTime = uiInfo.uiDC.realTime;
ADDRGP4 $3442
ADDRGP4 uiInfo+208
INDIRI4
ASGNI4
line 4297
;4297:			}
LABELV $3460
line 4298
;4298:			ping = atoi(Info_ValueForKey(info, "ping"));
ADDRGP4 $3438
ARGP4
ADDRGP4 $3087
ARGP4
ADDRLP4 20
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 24
INDIRI4
ASGNI4
line 4299
;4299:			if (ping == -1) {
ADDRLP4 8
INDIRI4
CNSTI4 -1
NEI4 $3468
line 4302
;4300:				// if we ever see a ping that is out of date, do a server refresh
;4301:				// UI_UpdatePendingPings();
;4302:			}
LABELV $3468
line 4303
;4303:			switch (column) {
ADDRLP4 28
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
LTI4 $3455
ADDRLP4 28
INDIRI4
CNSTI4 5
GTI4 $3455
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $3498
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $3498
address $3472
address $3481
address $3482
address $3484
address $3488
address $3492
code
LABELV $3472
line 4305
;4304:				case SORT_HOST : 
;4305:					if (ping <= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
GTI4 $3473
line 4306
;4306:						return Info_ValueForKey(info, "addr");
ADDRGP4 $3438
ARGP4
ADDRGP4 $2662
ARGP4
ADDRLP4 32
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
RETP4
ADDRGP4 $3437
JUMPV
LABELV $3473
line 4307
;4307:					} else {
line 4308
;4308:						if ( ui_netSource.integer == AS_LOCAL ) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
NEI4 $3475
line 4309
;4309:							Com_sprintf( hostname, sizeof(hostname), "%s [%s]",
ADDRGP4 $3438
ARGP4
ADDRGP4 $2661
ARGP4
ADDRLP4 32
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $3438
ARGP4
ADDRGP4 $3479
ARGP4
ADDRLP4 36
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 $3439
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $3478
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 40
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 netnames
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4312
;4310:											Info_ValueForKey(info, "hostname"),
;4311:											netnames[atoi(Info_ValueForKey(info, "nettype"))] );
;4312:							return hostname;
ADDRGP4 $3439
RETP4
ADDRGP4 $3437
JUMPV
LABELV $3475
line 4314
;4313:						}
;4314:						else {
line 4315
;4315:							Com_sprintf( hostname, sizeof(hostname), "%s", Info_ValueForKey(info, "hostname"));
ADDRGP4 $3438
ARGP4
ADDRGP4 $2661
ARGP4
ADDRLP4 32
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $3439
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $3480
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4316
;4316:							return hostname;
ADDRGP4 $3439
RETP4
ADDRGP4 $3437
JUMPV
LABELV $3481
line 4319
;4317:						}
;4318:					}
;4319:				case SORT_MAP : return Info_ValueForKey(info, "mapname");
ADDRGP4 $3438
ARGP4
ADDRGP4 $3044
ARGP4
ADDRLP4 32
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
RETP4
ADDRGP4 $3437
JUMPV
LABELV $3482
line 4321
;4320:				case SORT_CLIENTS : 
;4321:					Com_sprintf( clientBuff, sizeof(clientBuff), "%s (%s)", Info_ValueForKey(info, "clients"), Info_ValueForKey(info, "sv_maxclients"));
ADDRGP4 $3438
ARGP4
ADDRGP4 $2999
ARGP4
ADDRLP4 36
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $3438
ARGP4
ADDRGP4 $1331
ARGP4
ADDRLP4 40
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $3440
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $3483
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4322
;4322:					return clientBuff;
ADDRGP4 $3440
RETP4
ADDRGP4 $3437
JUMPV
LABELV $3484
line 4324
;4323:				case SORT_GAME : 
;4324:					game = atoi(Info_ValueForKey(info, "gametype"));
ADDRGP4 $3438
ARGP4
ADDRGP4 $3019
ARGP4
ADDRLP4 44
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 48
INDIRI4
ASGNI4
line 4325
;4325:					if (game >= 0 && game < numTeamArenaGameTypes) {
ADDRLP4 52
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
LTI4 $3485
ADDRLP4 52
INDIRI4
ADDRGP4 numTeamArenaGameTypes
INDIRI4
GEI4 $3485
line 4326
;4326:						return teamArenaGameTypes[game];
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 teamArenaGameTypes
ADDP4
INDIRP4
RETP4
ADDRGP4 $3437
JUMPV
LABELV $3485
line 4327
;4327:					} else {
line 4328
;4328:						return "Unknown";
ADDRGP4 $3487
RETP4
ADDRGP4 $3437
JUMPV
LABELV $3488
line 4331
;4329:					}
;4330:				case SORT_PING : 
;4331:					if (ping <= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
GTI4 $3489
line 4332
;4332:						return "...";
ADDRGP4 $3491
RETP4
ADDRGP4 $3437
JUMPV
LABELV $3489
line 4333
;4333:					} else {
line 4334
;4334:						return Info_ValueForKey(info, "ping");
ADDRGP4 $3438
ARGP4
ADDRGP4 $3087
ARGP4
ADDRLP4 56
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 56
INDIRP4
RETP4
ADDRGP4 $3437
JUMPV
LABELV $3492
line 4337
;4335:					}
;4336:				case SORT_PUNKBUSTER:
;4337:					punkbuster = atoi(Info_ValueForKey(info, "punkbuster"));
ADDRGP4 $3438
ARGP4
ADDRGP4 $3493
ARGP4
ADDRLP4 56
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 60
INDIRI4
ASGNI4
line 4338
;4338:					if ( punkbuster ) {
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $3494
line 4339
;4339:						return "Yes";
ADDRGP4 $3496
RETP4
ADDRGP4 $3437
JUMPV
LABELV $3494
line 4340
;4340:					} else {
line 4341
;4341:						return "No";
ADDRGP4 $3497
RETP4
ADDRGP4 $3437
JUMPV
line 4344
;4342:					}
;4343:			}
;4344:		}
line 4345
;4345:	} else if (feederID == FEEDER_SERVERSTATUS) {
LABELV $3454
ADDRFP4 0
INDIRF4
CNSTF4 1095761920
NEF4 $3499
line 4346
;4346:		if ( index >= 0 && index < uiInfo.serverStatusInfo.numLines ) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3500
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+110824+3328
INDIRI4
GEI4 $3500
line 4347
;4347:			if ( column >= 0 && column < 4 ) {
ADDRLP4 8
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $3500
ADDRLP4 8
INDIRI4
CNSTI4 4
GEI4 $3500
line 4348
;4348:				return uiInfo.serverStatusInfo.lines[index][column];
ADDRFP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 uiInfo+110824+64
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $3437
JUMPV
line 4350
;4349:			}
;4350:		}
line 4351
;4351:	} else if (feederID == FEEDER_FINDPLAYER) {
LABELV $3499
ADDRFP4 0
INDIRF4
CNSTF4 1096810496
NEF4 $3509
line 4352
;4352:		if ( index >= 0 && index < uiInfo.numFoundPlayerServers ) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3510
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+119480
INDIRI4
GEI4 $3510
line 4354
;4353:			//return uiInfo.foundPlayerServerAddresses[index];
;4354:			return uiInfo.foundPlayerServerNames[index];
ADDRFP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+118452
ADDP4
RETP4
ADDRGP4 $3437
JUMPV
line 4356
;4355:		}
;4356:	} else if (feederID == FEEDER_PLAYER_LIST) {
LABELV $3509
ADDRFP4 0
INDIRF4
CNSTF4 1088421888
NEF4 $3515
line 4357
;4357:		if (index >= 0 && index < uiInfo.playerCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3516
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+78856
INDIRI4
GEI4 $3516
line 4358
;4358:			return uiInfo.playerNames[index];
ADDRFP4 4
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+78884
ADDP4
RETP4
ADDRGP4 $3437
JUMPV
line 4360
;4359:		}
;4360:	} else if (feederID == FEEDER_TEAM_LIST) {
LABELV $3515
ADDRFP4 0
INDIRF4
CNSTF4 1090519040
NEF4 $3521
line 4361
;4361:		if (index >= 0 && index < uiInfo.myTeamCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3522
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+78860
INDIRI4
GEI4 $3522
line 4362
;4362:			return uiInfo.teamNames[index];
ADDRFP4 4
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+80932
ADDP4
RETP4
ADDRGP4 $3437
JUMPV
line 4364
;4363:		}
;4364:	} else if (feederID == FEEDER_MODS) {
LABELV $3521
ADDRFP4 0
INDIRF4
CNSTF4 1091567616
NEF4 $3527
line 4365
;4365:		if (index >= 0 && index < uiInfo.modCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3528
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+97200
INDIRI4
GEI4 $3528
line 4366
;4366:			if (uiInfo.modList[index].modDescr && *uiInfo.modList[index].modDescr) {
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+96688+4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3532
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+96688+4
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $3532
line 4367
;4367:				return uiInfo.modList[index].modDescr;
ADDRFP4 4
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+96688+4
ADDP4
INDIRP4
RETP4
ADDRGP4 $3437
JUMPV
LABELV $3532
line 4368
;4368:			} else {
line 4369
;4369:				return uiInfo.modList[index].modName;
ADDRFP4 4
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+96688
ADDP4
INDIRP4
RETP4
ADDRGP4 $3437
JUMPV
line 4372
;4370:			}
;4371:		}
;4372:	} else if (feederID == FEEDER_CINEMATICS) {
LABELV $3527
ADDRFP4 0
INDIRF4
CNSTF4 1097859072
NEF4 $3541
line 4373
;4373:		if (index >= 0 && index < uiInfo.movieCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3542
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+99264
INDIRI4
GEI4 $3542
line 4374
;4374:			return uiInfo.movieList[index];
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+98240
ADDP4
INDIRP4
RETP4
ADDRGP4 $3437
JUMPV
line 4376
;4375:		}
;4376:	} else if (feederID == FEEDER_DEMOS) {
LABELV $3541
ADDRFP4 0
INDIRF4
CNSTF4 1092616192
NEF4 $3547
line 4377
;4377:		if (index >= 0 && index < uiInfo.demoCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3549
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+98232
INDIRI4
GEI4 $3549
line 4378
;4378:			return uiInfo.demoList[index];
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+97208
ADDP4
INDIRP4
RETP4
ADDRGP4 $3437
JUMPV
LABELV $3549
line 4380
;4379:		}
;4380:	}
LABELV $3547
LABELV $3542
LABELV $3528
LABELV $3522
LABELV $3516
LABELV $3510
LABELV $3500
LABELV $3455
LABELV $3446
line 4381
;4381:	return "";
ADDRGP4 $110
RETP4
LABELV $3437
endproc UI_FeederItemText 64 20
proc UI_FeederItemImage 20 8
line 4385
;4382:}
;4383:
;4384:
;4385:static qhandle_t UI_FeederItemImage(float feederID, int index) {
line 4386
;4386:  if (feederID == FEEDER_HEADS) {
ADDRFP4 0
INDIRF4
CNSTF4 0
NEF4 $3554
line 4388
;4387:	int actual;
;4388:	UI_SelectedHead(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 UI_SelectedHead
CALLP4
pop
line 4389
;4389:	index = actual;
ADDRFP4 4
ADDRLP4 0
INDIRI4
ASGNI4
line 4390
;4390:	if (index >= 0 && index < uiInfo.characterCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3555
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+73452
INDIRI4
GEI4 $3555
line 4391
;4391:		if (uiInfo.characterList[index].headImage == -1) {
ADDRFP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460+8
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $3559
line 4392
;4392:			uiInfo.characterList[index].headImage = trap_R_RegisterShaderNoMip(uiInfo.characterList[index].imageName);
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460+8
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 4393
;4393:		}
LABELV $3559
line 4394
;4394:		return uiInfo.characterList[index].headImage;
ADDRFP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460+8
ADDP4
INDIRI4
RETI4
ADDRGP4 $3553
JUMPV
line 4396
;4395:	}
;4396:  } else if (feederID == FEEDER_Q3HEADS) {
LABELV $3554
ADDRFP4 0
INDIRF4
CNSTF4 1094713344
NEF4 $3569
line 4397
;4397:    if (index >= 0 && index < uiInfo.q3HeadCount) {
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $3570
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+119500
INDIRI4
GEI4 $3570
line 4398
;4398:      return uiInfo.q3HeadIcons[index];
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+135888
ADDP4
INDIRI4
RETI4
ADDRGP4 $3553
JUMPV
line 4400
;4399:    }
;4400:	} else if (feederID == FEEDER_ALLMAPS || feederID == FEEDER_MAPS) {
LABELV $3569
ADDRLP4 0
ADDRFP4 0
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 1082130432
EQF4 $3577
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
NEF4 $3575
LABELV $3577
line 4402
;4401:		int actual;
;4402:		UI_SelectedMap(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 UI_SelectedMap
CALLP4
pop
line 4403
;4403:		index = actual;
ADDRFP4 4
ADDRLP4 4
INDIRI4
ASGNI4
line 4404
;4404:		if (index >= 0 && index < uiInfo.mapCount) {
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $3578
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+83236
INDIRI4
GEI4 $3578
line 4405
;4405:			if (uiInfo.mapList[index].levelShot == -1) {
ADDRFP4 4
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+92
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $3581
line 4406
;4406:				uiInfo.mapList[index].levelShot = trap_R_RegisterShaderNoMip(uiInfo.mapList[index].imageName);
ADDRLP4 12
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+8
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+92
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 4407
;4407:			}
LABELV $3581
line 4408
;4408:			return uiInfo.mapList[index].levelShot;
ADDRFP4 4
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+92
ADDP4
INDIRI4
RETI4
ADDRGP4 $3553
JUMPV
LABELV $3578
line 4410
;4409:		}
;4410:	}
LABELV $3575
LABELV $3570
LABELV $3555
line 4411
;4411:  return 0;
CNSTI4 0
RETI4
LABELV $3553
endproc UI_FeederItemImage 20 8
bss
align 1
LABELV $3592
skip 1024
code
proc UI_FeederSelection 36 24
line 4414
;4412:}
;4413:
;4414:static void UI_FeederSelection(float feederID, int index) {
line 4416
;4415:	static char info[MAX_STRING_CHARS];
;4416:  if (feederID == FEEDER_HEADS) {
ADDRFP4 0
INDIRF4
CNSTF4 0
NEF4 $3593
line 4418
;4417:	int actual;
;4418:	UI_SelectedHead(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 UI_SelectedHead
CALLP4
pop
line 4419
;4419:	index = actual;
ADDRFP4 4
ADDRLP4 0
INDIRI4
ASGNI4
line 4420
;4420:    if (index >= 0 && index < uiInfo.characterCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3594
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+73452
INDIRI4
GEI4 $3594
line 4421
;4421:		trap_Cvar_Set( "team_model", va("%s", uiInfo.characterList[index].base));
ADDRGP4 $3480
ARGP4
ADDRFP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460+12
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $951
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4422
;4422:		trap_Cvar_Set( "team_headmodel", va("*%s", uiInfo.characterList[index].name)); 
ADDRGP4 $3600
ARGP4
ADDRFP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $952
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4423
;4423:		updateModel = qtrue;
ADDRGP4 updateModel
CNSTI4 1
ASGNI4
line 4424
;4424:    }
line 4425
;4425:  } else if (feederID == FEEDER_Q3HEADS) {
ADDRGP4 $3594
JUMPV
LABELV $3593
ADDRFP4 0
INDIRF4
CNSTF4 1094713344
NEF4 $3602
line 4426
;4426:    if (index >= 0 && index < uiInfo.q3HeadCount) {
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $3603
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+119500
INDIRI4
GEI4 $3603
line 4427
;4427:      trap_Cvar_Set( "model", uiInfo.q3HeadNames[index]);
ADDRGP4 $947
ARGP4
ADDRFP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+119504
ADDP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4428
;4428:      trap_Cvar_Set( "headmodel", uiInfo.q3HeadNames[index]);
ADDRGP4 $948
ARGP4
ADDRFP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+119504
ADDP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4429
;4429:			updateModel = qtrue;
ADDRGP4 updateModel
CNSTI4 1
ASGNI4
line 4430
;4430:		}
line 4431
;4431:  } else if (feederID == FEEDER_MAPS || feederID == FEEDER_ALLMAPS) {
ADDRGP4 $3603
JUMPV
LABELV $3602
ADDRLP4 0
ADDRFP4 0
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
EQF4 $3611
ADDRLP4 0
INDIRF4
CNSTF4 1082130432
NEF4 $3609
LABELV $3611
line 4433
;4432:		int actual, map;
;4433:		map = (feederID == FEEDER_ALLMAPS) ? ui_currentNetMap.integer : ui_currentMap.integer;
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
NEF4 $3615
ADDRLP4 12
ADDRGP4 ui_currentNetMap+12
INDIRI4
ASGNI4
ADDRGP4 $3616
JUMPV
LABELV $3615
ADDRLP4 12
ADDRGP4 ui_currentMap+12
INDIRI4
ASGNI4
LABELV $3616
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 4434
;4434:		if (uiInfo.mapList[map].cinematic >= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+24
ADDP4
INDIRI4
CNSTI4 0
LTI4 $3617
line 4435
;4435:		  trap_CIN_StopCinematic(uiInfo.mapList[map].cinematic);
ADDRLP4 8
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+24
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 4436
;4436:		  uiInfo.mapList[map].cinematic = -1;
ADDRLP4 8
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+24
ADDP4
CNSTI4 -1
ASGNI4
line 4437
;4437:		}
LABELV $3617
line 4438
;4438:		UI_SelectedMap(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 UI_SelectedMap
CALLP4
pop
line 4439
;4439:		trap_Cvar_Set("ui_mapIndex", va("%d", index));
ADDRGP4 $695
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2163
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4440
;4440:		ui_mapIndex.integer = index;
ADDRGP4 ui_mapIndex+12
ADDRFP4 4
INDIRI4
ASGNI4
line 4442
;4441:
;4442:		if (feederID == FEEDER_MAPS) {
ADDRFP4 0
INDIRF4
CNSTF4 1065353216
NEF4 $3626
line 4443
;4443:			ui_currentMap.integer = actual;
ADDRGP4 ui_currentMap+12
ADDRLP4 4
INDIRI4
ASGNI4
line 4444
;4444:			trap_Cvar_Set("ui_currentMap", va("%d", actual));
ADDRGP4 $695
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $873
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4445
;4445:	  	uiInfo.mapList[ui_currentMap.integer].cinematic = trap_CIN_PlayCinematic(va("%s.roq", uiInfo.mapList[ui_currentMap.integer].mapLoadName), 0, 0, 0, 0, (CIN_loop | CIN_silent) );
ADDRGP4 $772
ARGP4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 28
ADDRGP4 trap_CIN_PlayCinematic
CALLI4
ASGNI4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+24
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 4446
;4446:			UI_LoadBestScores(uiInfo.mapList[ui_currentMap.integer].mapLoadName, uiInfo.gameTypes[ui_gameType.integer].gtEnum);
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592+4
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_LoadBestScores
CALLV
pop
line 4447
;4447:			trap_Cvar_Set("ui_opponentModel", uiInfo.mapList[ui_currentMap.integer].opponentName);
ADDRGP4 $1070
ARGP4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+12
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4448
;4448:			updateOpponentModel = qtrue;
ADDRGP4 updateOpponentModel
CNSTI4 1
ASGNI4
line 4449
;4449:		} else {
ADDRGP4 $3610
JUMPV
LABELV $3626
line 4450
;4450:			ui_currentNetMap.integer = actual;
ADDRGP4 ui_currentNetMap+12
ADDRLP4 4
INDIRI4
ASGNI4
line 4451
;4451:			trap_Cvar_Set("ui_currentNetMap", va("%d", actual));
ADDRGP4 $695
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $871
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4452
;4452:	  	uiInfo.mapList[ui_currentNetMap.integer].cinematic = trap_CIN_PlayCinematic(va("%s.roq", uiInfo.mapList[ui_currentNetMap.integer].mapLoadName), 0, 0, 0, 0, (CIN_loop | CIN_silent) );
ADDRGP4 $772
ARGP4
ADDRGP4 ui_currentNetMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 28
ADDRGP4 trap_CIN_PlayCinematic
CALLI4
ASGNI4
ADDRGP4 ui_currentNetMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+24
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 4453
;4453:		}
line 4455
;4454:
;4455:  } else if (feederID == FEEDER_SERVERS) {
ADDRGP4 $3610
JUMPV
LABELV $3609
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
NEF4 $3651
line 4456
;4456:		const char *mapName = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 4457
;4457:		uiInfo.serverStatus.currentServer = index;
ADDRGP4 uiInfo+99276+2216
ADDRFP4 4
INDIRI4
ASGNI4
line 4458
;4458:		trap_LAN_GetServerInfo(ui_netSource.integer, uiInfo.serverStatus.displayServers[index], info, MAX_STRING_CHARS);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99276+2220
ADDP4
INDIRI4
ARGI4
ADDRGP4 $3592
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetServerInfo
CALLV
pop
line 4459
;4459:		uiInfo.serverStatus.currentServerPreview = trap_R_RegisterShaderNoMip(va("levelshots/%s", Info_ValueForKey(info, "mapname")));
ADDRGP4 $3592
ARGP4
ADDRGP4 $3044
ARGP4
ADDRLP4 8
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $1017
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+99276+10428
ADDRLP4 16
INDIRI4
ASGNI4
line 4460
;4460:		if (uiInfo.serverStatus.currentServerCinematic >= 0) {
ADDRGP4 uiInfo+99276+10432
INDIRI4
CNSTI4 0
LTI4 $3660
line 4461
;4461:		  trap_CIN_StopCinematic(uiInfo.serverStatus.currentServerCinematic);
ADDRGP4 uiInfo+99276+10432
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 4462
;4462:			uiInfo.serverStatus.currentServerCinematic = -1;
ADDRGP4 uiInfo+99276+10432
CNSTI4 -1
ASGNI4
line 4463
;4463:		}
LABELV $3660
line 4464
;4464:		mapName = Info_ValueForKey(info, "mapname");
ADDRGP4 $3592
ARGP4
ADDRGP4 $3044
ARGP4
ADDRLP4 20
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
line 4465
;4465:		if (mapName && *mapName) {
ADDRLP4 24
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3652
ADDRLP4 24
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $3652
line 4466
;4466:			uiInfo.serverStatus.currentServerCinematic = trap_CIN_PlayCinematic(va("%s.roq", mapName), 0, 0, 0, 0, (CIN_loop | CIN_silent) );
ADDRGP4 $772
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 32
ADDRGP4 trap_CIN_PlayCinematic
CALLI4
ASGNI4
ADDRGP4 uiInfo+99276+10432
ADDRLP4 32
INDIRI4
ASGNI4
line 4467
;4467:		}
line 4468
;4468:  } else if (feederID == FEEDER_SERVERSTATUS) {
ADDRGP4 $3652
JUMPV
LABELV $3651
ADDRFP4 0
INDIRF4
CNSTF4 1095761920
NEF4 $3672
line 4470
;4469:		//
;4470:  } else if (feederID == FEEDER_FINDPLAYER) {
ADDRGP4 $3673
JUMPV
LABELV $3672
ADDRFP4 0
INDIRF4
CNSTF4 1096810496
NEF4 $3674
line 4471
;4471:	  uiInfo.currentFoundPlayerServer = index;
ADDRGP4 uiInfo+119476
ADDRFP4 4
INDIRI4
ASGNI4
line 4473
;4472:	  //
;4473:	  if ( index < uiInfo.numFoundPlayerServers-1) {
ADDRFP4 4
INDIRI4
ADDRGP4 uiInfo+119480
INDIRI4
CNSTI4 1
SUBI4
GEI4 $3675
line 4475
;4474:			// build a new server status for this server
;4475:			Q_strncpyz(uiInfo.serverStatusAddress, uiInfo.foundPlayerServerAddresses[uiInfo.currentFoundPlayerServer], sizeof(uiInfo.serverStatusAddress));
ADDRGP4 uiInfo+110760
ARGP4
ADDRGP4 uiInfo+119476
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+117428
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4476
;4476:			Menu_SetFeederSelection(NULL, FEEDER_SERVERSTATUS, 0, NULL);
CNSTP4 0
ARGP4
CNSTI4 13
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 4477
;4477:			UI_BuildServerStatus(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerStatus
CALLV
pop
line 4478
;4478:	  }
line 4479
;4479:  } else if (feederID == FEEDER_PLAYER_LIST) {
ADDRGP4 $3675
JUMPV
LABELV $3674
ADDRFP4 0
INDIRF4
CNSTF4 1088421888
NEF4 $3684
line 4480
;4480:		uiInfo.playerIndex = index;
ADDRGP4 uiInfo+78872
ADDRFP4 4
INDIRI4
ASGNI4
line 4481
;4481:  } else if (feederID == FEEDER_TEAM_LIST) {
ADDRGP4 $3685
JUMPV
LABELV $3684
ADDRFP4 0
INDIRF4
CNSTF4 1090519040
NEF4 $3687
line 4482
;4482:		uiInfo.teamIndex = index;
ADDRGP4 uiInfo+78864
ADDRFP4 4
INDIRI4
ASGNI4
line 4483
;4483:  } else if (feederID == FEEDER_MODS) {
ADDRGP4 $3688
JUMPV
LABELV $3687
ADDRFP4 0
INDIRF4
CNSTF4 1091567616
NEF4 $3690
line 4484
;4484:		uiInfo.modIndex = index;
ADDRGP4 uiInfo+97204
ADDRFP4 4
INDIRI4
ASGNI4
line 4485
;4485:  } else if (feederID == FEEDER_CINEMATICS) {
ADDRGP4 $3691
JUMPV
LABELV $3690
ADDRFP4 0
INDIRF4
CNSTF4 1097859072
NEF4 $3693
line 4486
;4486:		uiInfo.movieIndex = index;
ADDRGP4 uiInfo+99268
ADDRFP4 4
INDIRI4
ASGNI4
line 4487
;4487:		if (uiInfo.previewMovie >= 0) {
ADDRGP4 uiInfo+99272
INDIRI4
CNSTI4 0
LTI4 $3696
line 4488
;4488:		  trap_CIN_StopCinematic(uiInfo.previewMovie);
ADDRGP4 uiInfo+99272
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 4489
;4489:		}
LABELV $3696
line 4490
;4490:		uiInfo.previewMovie = -1;
ADDRGP4 uiInfo+99272
CNSTI4 -1
ASGNI4
line 4491
;4491:  } else if (feederID == FEEDER_DEMOS) {
ADDRGP4 $3694
JUMPV
LABELV $3693
ADDRFP4 0
INDIRF4
CNSTF4 1092616192
NEF4 $3701
line 4492
;4492:		uiInfo.demoIndex = index;
ADDRGP4 uiInfo+98236
ADDRFP4 4
INDIRI4
ASGNI4
line 4493
;4493:	}
LABELV $3701
LABELV $3694
LABELV $3691
LABELV $3688
LABELV $3685
LABELV $3675
LABELV $3673
LABELV $3652
LABELV $3610
LABELV $3603
LABELV $3594
line 4494
;4494:}
LABELV $3591
endproc UI_FeederSelection 36 24
proc Team_Parse 60 12
line 4496
;4495:
;4496:static qboolean Team_Parse(char **p) {
line 4501
;4497:  char *token;
;4498:  const char *tempStr;
;4499:	int i;
;4500:
;4501:  token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 12
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 12
INDIRP4
ASGNP4
line 4503
;4502:
;4503:  if (token[0] != '{') {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $3708
line 4504
;4504:    return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3704
JUMPV
LABELV $3707
line 4507
;4505:  }
;4506:
;4507:  while ( 1 ) {
line 4509
;4508:
;4509:    token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 16
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 4511
;4510:    
;4511:    if (Q_stricmp(token, "}") == 0) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $431
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $3710
line 4512
;4512:      return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3704
JUMPV
LABELV $3710
line 4515
;4513:    }
;4514:
;4515:    if ( !token || token[0] == 0 ) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3714
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3712
LABELV $3714
line 4516
;4516:      return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3704
JUMPV
LABELV $3712
line 4519
;4517:    }
;4518:
;4519:    if (token[0] == '{') {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $3715
line 4521
;4520:      // seven tokens per line, team name and icon, and 5 team member names
;4521:      if (!String_Parse(p, &uiInfo.teamList[uiInfo.teamCount].teamName) || !String_Parse(p, &tempStr)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+75768
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $3721
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 32
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $3717
LABELV $3721
line 4522
;4522:        return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3704
JUMPV
LABELV $3717
line 4526
;4523:      }
;4524:    
;4525:
;4526:			uiInfo.teamList[uiInfo.teamCount].imageName = tempStr;
ADDRGP4 uiInfo+75768
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
ADDRLP4 8
INDIRP4
ASGNP4
line 4527
;4527:	    uiInfo.teamList[uiInfo.teamCount].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[uiInfo.teamCount].imageName);
ADDRGP4 uiInfo+75768
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+75768
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+28
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 4528
;4528:		  uiInfo.teamList[uiInfo.teamCount].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal",uiInfo.teamList[uiInfo.teamCount].imageName));
ADDRGP4 $748
ARGP4
ADDRGP4 uiInfo+75768
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+75768
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+32
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 4529
;4529:			uiInfo.teamList[uiInfo.teamCount].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[uiInfo.teamCount].imageName));
ADDRGP4 $753
ARGP4
ADDRGP4 uiInfo+75768
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+75768
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+36
ADDP4
ADDRLP4 52
INDIRI4
ASGNI4
line 4531
;4530:
;4531:			uiInfo.teamList[uiInfo.teamCount].cinematic = -1;
ADDRGP4 uiInfo+75768
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+40
ADDP4
CNSTI4 -1
ASGNI4
line 4533
;4532:
;4533:			for (i = 0; i < TEAM_MEMBERS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $3746
line 4534
;4534:				uiInfo.teamList[uiInfo.teamCount].teamMembers[i] = NULL;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+75768
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+8
ADDP4
ADDP4
CNSTP4 0
ASGNP4
line 4535
;4535:				if (!String_Parse(p, &uiInfo.teamList[uiInfo.teamCount].teamMembers[i])) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+75768
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+8
ADDP4
ADDP4
ARGP4
ADDRLP4 56
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $3753
line 4536
;4536:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3704
JUMPV
LABELV $3753
line 4538
;4537:				}
;4538:			}
LABELV $3747
line 4533
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 5
LTI4 $3746
line 4540
;4539:
;4540:      Com_Printf("Loaded team %s with team icon %s.\n", uiInfo.teamList[uiInfo.teamCount].teamName, tempStr);
ADDRGP4 $3758
ARGP4
ADDRGP4 uiInfo+75768
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4541
;4541:      if (uiInfo.teamCount < MAX_TEAMS) {
ADDRGP4 uiInfo+75768
INDIRI4
CNSTI4 64
GEI4 $3761
line 4542
;4542:        uiInfo.teamCount++;
ADDRLP4 56
ADDRGP4 uiInfo+75768
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4543
;4543:      } else {
ADDRGP4 $3762
JUMPV
LABELV $3761
line 4544
;4544:        Com_Printf("Too many teams, last team replaced!\n");
ADDRGP4 $3765
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4545
;4545:      }
LABELV $3762
line 4546
;4546:      token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 56
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 56
INDIRP4
ASGNP4
line 4547
;4547:      if (token[0] != '}') {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 125
EQI4 $3766
line 4548
;4548:        return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3704
JUMPV
LABELV $3766
line 4550
;4549:      }
;4550:    }
LABELV $3715
line 4551
;4551:  }
LABELV $3708
line 4507
ADDRGP4 $3707
JUMPV
line 4553
;4552:
;4553:  return qfalse;
CNSTI4 0
RETI4
LABELV $3704
endproc Team_Parse 60 12
proc Character_Parse 64 12
line 4556
;4554:}
;4555:
;4556:static qboolean Character_Parse(char **p) {
line 4560
;4557:  char *token;
;4558:  const char *tempStr;
;4559:
;4560:  token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 4562
;4561:
;4562:  if (token[0] != '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $3772
line 4563
;4563:    return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3768
JUMPV
LABELV $3771
line 4567
;4564:  }
;4565:
;4566:
;4567:  while ( 1 ) {
line 4568
;4568:    token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 12
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 4570
;4569:
;4570:    if (Q_stricmp(token, "}") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $431
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $3774
line 4571
;4571:      return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3768
JUMPV
LABELV $3774
line 4574
;4572:    }
;4573:
;4574:    if ( !token || token[0] == 0 ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3778
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3776
LABELV $3778
line 4575
;4575:      return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3768
JUMPV
LABELV $3776
line 4578
;4576:    }
;4577:
;4578:    if (token[0] == '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $3779
line 4580
;4579:      // two tokens per line, character name and sex
;4580:      if (!String_Parse(p, &uiInfo.characterList[uiInfo.characterCount].name) || !String_Parse(p, &tempStr)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+73452
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $3785
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 28
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $3781
LABELV $3785
line 4581
;4581:        return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3768
JUMPV
LABELV $3781
line 4584
;4582:      }
;4583:    
;4584:      uiInfo.characterList[uiInfo.characterCount].headImage = -1;
ADDRGP4 uiInfo+73452
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460+8
ADDP4
CNSTI4 -1
ASGNI4
line 4585
;4585:			uiInfo.characterList[uiInfo.characterCount].imageName = String_Alloc(va("models/players/heads/%s/icon_default.tga", uiInfo.characterList[uiInfo.characterCount].name));
ADDRGP4 $3792
ARGP4
ADDRGP4 uiInfo+73452
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+73452
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460+4
ADDP4
ADDRLP4 36
INDIRP4
ASGNP4
line 4587
;4586:
;4587:	  if (tempStr && (!Q_stricmp(tempStr, "female"))) {
ADDRLP4 40
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3795
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 $3797
ARGP4
ADDRLP4 44
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $3795
line 4588
;4588:        uiInfo.characterList[uiInfo.characterCount].base = String_Alloc(va("Janet"));
ADDRGP4 $3801
ARGP4
ADDRLP4 48
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+73452
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460+12
ADDP4
ADDRLP4 52
INDIRP4
ASGNP4
line 4589
;4589:      } else if (tempStr && (!Q_stricmp(tempStr, "male"))) {
ADDRGP4 $3796
JUMPV
LABELV $3795
ADDRLP4 48
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3802
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 $3804
ARGP4
ADDRLP4 52
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $3802
line 4590
;4590:        uiInfo.characterList[uiInfo.characterCount].base = String_Alloc(va("James"));
ADDRGP4 $1065
ARGP4
ADDRLP4 56
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+73452
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460+12
ADDP4
ADDRLP4 60
INDIRP4
ASGNP4
line 4591
;4591:	  } else {
ADDRGP4 $3803
JUMPV
LABELV $3802
line 4592
;4592:        uiInfo.characterList[uiInfo.characterCount].base = String_Alloc(va("%s",tempStr));
ADDRGP4 $3480
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+73452
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460+12
ADDP4
ADDRLP4 60
INDIRP4
ASGNP4
line 4593
;4593:	  }
LABELV $3803
LABELV $3796
line 4595
;4594:
;4595:      Com_Printf("Loaded %s character %s.\n", uiInfo.characterList[uiInfo.characterCount].base, uiInfo.characterList[uiInfo.characterCount].name);
ADDRGP4 $3811
ARGP4
ADDRGP4 uiInfo+73452
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460+12
ADDP4
INDIRP4
ARGP4
ADDRGP4 uiInfo+73452
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73460
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4596
;4596:      if (uiInfo.characterCount < MAX_HEADS) {
ADDRGP4 uiInfo+73452
INDIRI4
CNSTI4 64
GEI4 $3817
line 4597
;4597:        uiInfo.characterCount++;
ADDRLP4 56
ADDRGP4 uiInfo+73452
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4598
;4598:      } else {
ADDRGP4 $3818
JUMPV
LABELV $3817
line 4599
;4599:        Com_Printf("Too many characters, last character replaced!\n");
ADDRGP4 $3821
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4600
;4600:      }
LABELV $3818
line 4602
;4601:     
;4602:      token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 56
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 56
INDIRP4
ASGNP4
line 4603
;4603:      if (token[0] != '}') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 125
EQI4 $3822
line 4604
;4604:        return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3768
JUMPV
LABELV $3822
line 4606
;4605:      }
;4606:    }
LABELV $3779
line 4607
;4607:  }
LABELV $3772
line 4567
ADDRGP4 $3771
JUMPV
line 4609
;4608:
;4609:  return qfalse;
CNSTI4 0
RETI4
LABELV $3768
endproc Character_Parse 64 12
proc Alias_Parse 36 12
line 4613
;4610:}
;4611:
;4612:
;4613:static qboolean Alias_Parse(char **p) {
line 4616
;4614:  char *token;
;4615:
;4616:  token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 4618
;4617:
;4618:  if (token[0] != '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $3828
line 4619
;4619:    return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3824
JUMPV
LABELV $3827
line 4622
;4620:  }
;4621:
;4622:  while ( 1 ) {
line 4623
;4623:    token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 4625
;4624:
;4625:    if (Q_stricmp(token, "}") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $431
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $3830
line 4626
;4626:      return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3824
JUMPV
LABELV $3830
line 4629
;4627:    }
;4628:
;4629:    if ( !token || token[0] == 0 ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3834
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3832
LABELV $3834
line 4630
;4630:      return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3824
JUMPV
LABELV $3832
line 4633
;4631:    }
;4632:
;4633:    if (token[0] == '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $3835
line 4635
;4634:      // three tokens per line, character name, bot alias, and preferred action a - all purpose, d - defense, o - offense
;4635:      if (!String_Parse(p, &uiInfo.aliasList[uiInfo.aliasCount].name) || !String_Parse(p, &uiInfo.aliasList[uiInfo.aliasCount].ai) || !String_Parse(p, &uiInfo.aliasList[uiInfo.aliasCount].action)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+74996
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+75000
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $3848
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+74996
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+75000+4
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $3848
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+74996
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+75000+8
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $3837
LABELV $3848
line 4636
;4636:        return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3824
JUMPV
LABELV $3837
line 4639
;4637:      }
;4638:    
;4639:      Com_Printf("Loaded character alias %s using character ai %s.\n", uiInfo.aliasList[uiInfo.aliasCount].name, uiInfo.aliasList[uiInfo.aliasCount].ai);
ADDRGP4 $3849
ARGP4
ADDRGP4 uiInfo+74996
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+75000
ADDP4
INDIRP4
ARGP4
ADDRGP4 uiInfo+74996
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+75000+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4640
;4640:      if (uiInfo.aliasCount < MAX_ALIASES) {
ADDRGP4 uiInfo+74996
INDIRI4
CNSTI4 64
GEI4 $3855
line 4641
;4641:        uiInfo.aliasCount++;
ADDRLP4 32
ADDRGP4 uiInfo+74996
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4642
;4642:      } else {
ADDRGP4 $3856
JUMPV
LABELV $3855
line 4643
;4643:        Com_Printf("Too many aliases, last alias replaced!\n");
ADDRGP4 $3859
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4644
;4644:      }
LABELV $3856
line 4646
;4645:     
;4646:      token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 32
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 4647
;4647:      if (token[0] != '}') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 125
EQI4 $3860
line 4648
;4648:        return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3824
JUMPV
LABELV $3860
line 4650
;4649:      }
;4650:    }
LABELV $3835
line 4651
;4651:  }
LABELV $3828
line 4622
ADDRGP4 $3827
JUMPV
line 4653
;4652:
;4653:  return qfalse;
CNSTI4 0
RETI4
LABELV $3824
endproc Alias_Parse 36 12
proc UI_ParseTeamInfo 44 8
line 4662
;4654:}
;4655:
;4656:
;4657:
;4658:// mode 
;4659:// 0 - high level parsing
;4660:// 1 - team parsing
;4661:// 2 - character parsing
;4662:static void UI_ParseTeamInfo(const char *teamFile) {
line 4665
;4663:	char	*token;
;4664:  char *p;
;4665:  char *buff = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 4668
;4666:  //static int mode = 0; TTimo: unused
;4667:
;4668:  buff = GetMenuBuffer(teamFile);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 GetMenuBuffer
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 4669
;4669:  if (!buff) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3863
line 4670
;4670:    return;
ADDRGP4 $3862
JUMPV
LABELV $3863
line 4673
;4671:  }
;4672:
;4673:  p = buff;
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $3866
JUMPV
LABELV $3865
line 4675
;4674:
;4675:	while ( 1 ) {
line 4676
;4676:		token = COM_ParseExt( &p, qtrue );
ADDRLP4 4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 16
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 4677
;4677:		if( !token || token[0] == 0 || token[0] == '}') {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3871
ADDRLP4 24
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $3871
ADDRLP4 24
INDIRI4
CNSTI4 125
NEI4 $3868
LABELV $3871
line 4678
;4678:			break;
ADDRGP4 $3867
JUMPV
LABELV $3868
line 4681
;4679:		}
;4680:
;4681:		if ( Q_stricmp( token, "}" ) == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $431
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $3872
line 4682
;4682:      break;
ADDRGP4 $3867
JUMPV
LABELV $3872
line 4685
;4683:    }
;4684:
;4685:    if (Q_stricmp(token, "teams") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $3876
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $3874
line 4687
;4686:
;4687:      if (Team_Parse(&p)) {
ADDRLP4 4
ARGP4
ADDRLP4 36
ADDRGP4 Team_Parse
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $3867
line 4688
;4688:        continue;
ADDRGP4 $3866
JUMPV
line 4689
;4689:      } else {
line 4690
;4690:        break;
LABELV $3874
line 4694
;4691:      }
;4692:    }
;4693:
;4694:    if (Q_stricmp(token, "characters") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $3881
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $3879
line 4695
;4695:      Character_Parse(&p);
ADDRLP4 4
ARGP4
ADDRGP4 Character_Parse
CALLI4
pop
line 4696
;4696:    }
LABELV $3879
line 4698
;4697:
;4698:    if (Q_stricmp(token, "aliases") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $3884
ARGP4
ADDRLP4 40
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $3882
line 4699
;4699:      Alias_Parse(&p);
ADDRLP4 4
ARGP4
ADDRGP4 Alias_Parse
CALLI4
pop
line 4700
;4700:    }
LABELV $3882
line 4702
;4701:
;4702:  }
LABELV $3866
line 4675
ADDRGP4 $3865
JUMPV
LABELV $3867
line 4704
;4703:
;4704:}
LABELV $3862
endproc UI_ParseTeamInfo 44 8
proc GameType_Parse 28 8
line 4707
;4705:
;4706:
;4707:static qboolean GameType_Parse(char **p, qboolean join) {
line 4710
;4708:	char *token;
;4709:
;4710:	token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 4712
;4711:
;4712:	if (token[0] != '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $3886
line 4713
;4713:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3885
JUMPV
LABELV $3886
line 4716
;4714:	}
;4715:
;4716:	if (join) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $3888
line 4717
;4717:		uiInfo.numJoinGameTypes = 0;
ADDRGP4 uiInfo+78720
CNSTI4 0
ASGNI4
line 4718
;4718:	} else {
ADDRGP4 $3893
JUMPV
LABELV $3888
line 4719
;4719:		uiInfo.numGameTypes = 0;
ADDRGP4 uiInfo+78588
CNSTI4 0
ASGNI4
line 4720
;4720:	}
ADDRGP4 $3893
JUMPV
LABELV $3892
line 4722
;4721:
;4722:	while ( 1 ) {
line 4723
;4723:		token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 4725
;4724:
;4725:		if (Q_stricmp(token, "}") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $431
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $3895
line 4726
;4726:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3885
JUMPV
LABELV $3895
line 4729
;4727:		}
;4728:
;4729:		if ( !token || token[0] == 0 ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3899
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3897
LABELV $3899
line 4730
;4730:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3885
JUMPV
LABELV $3897
line 4733
;4731:		}
;4732:
;4733:		if (token[0] == '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $3900
line 4735
;4734:			// two tokens per line, character name and sex
;4735:			if (join) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $3902
line 4736
;4736:				if (!String_Parse(p, &uiInfo.joinGameTypes[uiInfo.numJoinGameTypes].gameType) || !Int_Parse(p, &uiInfo.joinGameTypes[uiInfo.numJoinGameTypes].gtEnum)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+78720
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78724
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $3911
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+78720
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78724+4
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $3903
LABELV $3911
line 4737
;4737:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3885
JUMPV
line 4739
;4738:				}
;4739:			} else {
LABELV $3902
line 4740
;4740:				if (!String_Parse(p, &uiInfo.gameTypes[uiInfo.numGameTypes].gameType) || !Int_Parse(p, &uiInfo.gameTypes[uiInfo.numGameTypes].gtEnum)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+78588
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $3919
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+78588
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592+4
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $3912
LABELV $3919
line 4741
;4741:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3885
JUMPV
LABELV $3912
line 4743
;4742:				}
;4743:			}
LABELV $3903
line 4745
;4744:    
;4745:			if (join) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $3920
line 4746
;4746:				if (uiInfo.numJoinGameTypes < MAX_GAMETYPES) {
ADDRGP4 uiInfo+78720
INDIRI4
CNSTI4 16
GEI4 $3922
line 4747
;4747:					uiInfo.numJoinGameTypes++;
ADDRLP4 20
ADDRGP4 uiInfo+78720
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4748
;4748:				} else {
ADDRGP4 $3921
JUMPV
LABELV $3922
line 4749
;4749:					Com_Printf("Too many net game types, last one replace!\n");
ADDRGP4 $3926
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4750
;4750:				}		
line 4751
;4751:			} else {
ADDRGP4 $3921
JUMPV
LABELV $3920
line 4752
;4752:				if (uiInfo.numGameTypes < MAX_GAMETYPES) {
ADDRGP4 uiInfo+78588
INDIRI4
CNSTI4 16
GEI4 $3927
line 4753
;4753:					uiInfo.numGameTypes++;
ADDRLP4 20
ADDRGP4 uiInfo+78588
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4754
;4754:				} else {
ADDRGP4 $3928
JUMPV
LABELV $3927
line 4755
;4755:					Com_Printf("Too many game types, last one replace!\n");
ADDRGP4 $3931
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4756
;4756:				}		
LABELV $3928
line 4757
;4757:			}
LABELV $3921
line 4759
;4758:     
;4759:			token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 20
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 4760
;4760:			if (token[0] != '}') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 125
EQI4 $3932
line 4761
;4761:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3885
JUMPV
LABELV $3932
line 4763
;4762:			}
;4763:		}
LABELV $3900
line 4764
;4764:	}
LABELV $3893
line 4722
ADDRGP4 $3892
JUMPV
line 4765
;4765:	return qfalse;
CNSTI4 0
RETI4
LABELV $3885
endproc GameType_Parse 28 8
proc MapList_Parse 52 8
line 4768
;4766:}
;4767:
;4768:static qboolean MapList_Parse(char **p) {
line 4771
;4769:	char *token;
;4770:
;4771:	token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 4773
;4772:
;4773:	if (token[0] != '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $3935
line 4774
;4774:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3934
JUMPV
LABELV $3935
line 4777
;4775:	}
;4776:
;4777:	uiInfo.mapCount = 0;
ADDRGP4 uiInfo+83236
CNSTI4 0
ASGNI4
ADDRGP4 $3939
JUMPV
LABELV $3938
line 4779
;4778:
;4779:	while ( 1 ) {
line 4780
;4780:		token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 4782
;4781:
;4782:		if (Q_stricmp(token, "}") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $431
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $3941
line 4783
;4783:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3934
JUMPV
LABELV $3941
line 4786
;4784:		}
;4785:
;4786:		if ( !token || token[0] == 0 ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3945
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3943
LABELV $3945
line 4787
;4787:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3934
JUMPV
LABELV $3943
line 4790
;4788:		}
;4789:
;4790:		if (token[0] == '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $3946
line 4791
;4791:			if (!String_Parse(p, &uiInfo.mapList[uiInfo.mapCount].mapName) || !String_Parse(p, &uiInfo.mapList[uiInfo.mapCount].mapLoadName) 
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+83236
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $3959
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+83236
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+4
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $3959
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+83236
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+16
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $3948
LABELV $3959
line 4792
;4792:				||!Int_Parse(p, &uiInfo.mapList[uiInfo.mapCount].teamMembers) ) {
line 4793
;4793:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3934
JUMPV
LABELV $3948
line 4796
;4794:			}
;4795:
;4796:			if (!String_Parse(p, &uiInfo.mapList[uiInfo.mapCount].opponentName)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+83236
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+12
ADDP4
ARGP4
ADDRLP4 32
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $3960
line 4797
;4797:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3934
JUMPV
LABELV $3960
line 4800
;4798:			}
;4799:
;4800:			uiInfo.mapList[uiInfo.mapCount].typeBits = 0;
ADDRGP4 uiInfo+83236
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+20
ADDP4
CNSTI4 0
ASGNI4
ADDRGP4 $3969
JUMPV
LABELV $3968
line 4802
;4801:
;4802:			while (1) {
line 4803
;4803:				token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 36
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
ASGNP4
line 4804
;4804:				if (token[0] >= '0' && token[0] <= '9') {
ADDRLP4 40
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 48
LTI4 $3970
ADDRLP4 40
INDIRI4
CNSTI4 57
GTI4 $3970
line 4805
;4805:					uiInfo.mapList[uiInfo.mapCount].typeBits |= (1 << (token[0] - 0x030));
ADDRLP4 44
ADDRGP4 uiInfo+83236
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+20
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
LSHI4
BORI4
ASGNI4
line 4806
;4806:					if (!Int_Parse(p, &uiInfo.mapList[uiInfo.mapCount].timeToBeat[token[0] - 0x30])) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 2
LSHI4
CNSTI4 192
SUBI4
ADDRGP4 uiInfo+83236
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+28
ADDP4
ADDP4
ARGP4
ADDRLP4 48
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $3972
line 4807
;4807:						return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3934
JUMPV
line 4809
;4808:					}
;4809:				} else {
line 4810
;4810:					break;
LABELV $3972
line 4812
;4811:				} 
;4812:			}
LABELV $3969
line 4802
ADDRGP4 $3968
JUMPV
LABELV $3970
line 4819
;4813:
;4814:			//mapList[mapCount].imageName = String_Alloc(va("levelshots/%s", mapList[mapCount].mapLoadName));
;4815:			//if (uiInfo.mapCount == 0) {
;4816:			  // only load the first cinematic, selection loads the others
;4817:  			//  uiInfo.mapList[uiInfo.mapCount].cinematic = trap_CIN_PlayCinematic(va("%s.roq",uiInfo.mapList[uiInfo.mapCount].mapLoadName), qfalse, qfalse, qtrue, 0, 0, 0, 0);
;4818:			//}
;4819:  		uiInfo.mapList[uiInfo.mapCount].cinematic = -1;
ADDRGP4 uiInfo+83236
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+24
ADDP4
CNSTI4 -1
ASGNI4
line 4820
;4820:			uiInfo.mapList[uiInfo.mapCount].levelShot = trap_R_RegisterShaderNoMip(va("levelshots/%s_small", uiInfo.mapList[uiInfo.mapCount].mapLoadName));
ADDRGP4 $3987
ARGP4
ADDRGP4 uiInfo+83236
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+83236
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+92
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 4822
;4821:
;4822:			if (uiInfo.mapCount < MAX_MAPS) {
ADDRGP4 uiInfo+83236
INDIRI4
CNSTI4 128
GEI4 $3991
line 4823
;4823:				uiInfo.mapCount++;
ADDRLP4 44
ADDRGP4 uiInfo+83236
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4824
;4824:			} else {
ADDRGP4 $3992
JUMPV
LABELV $3991
line 4825
;4825:				Com_Printf("Too many maps, last one replaced!\n");
ADDRGP4 $3995
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4826
;4826:			}
LABELV $3992
line 4827
;4827:		}
LABELV $3946
line 4828
;4828:	}
LABELV $3939
line 4779
ADDRGP4 $3938
JUMPV
line 4829
;4829:	return qfalse;
CNSTI4 0
RETI4
LABELV $3934
endproc MapList_Parse 52 8
proc UI_ParseGameInfo 44 8
line 4832
;4830:}
;4831:
;4832:static void UI_ParseGameInfo(const char *teamFile) {
line 4835
;4833:	char	*token;
;4834:	char *p;
;4835:	char *buff = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 4838
;4836:	//int mode = 0; TTimo: unused
;4837:
;4838:	buff = GetMenuBuffer(teamFile);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 GetMenuBuffer
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 4839
;4839:	if (!buff) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3997
line 4840
;4840:		return;
ADDRGP4 $3996
JUMPV
LABELV $3997
line 4843
;4841:	}
;4842:
;4843:	p = buff;
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $4000
JUMPV
LABELV $3999
line 4845
;4844:
;4845:	while ( 1 ) {
line 4846
;4846:		token = COM_ParseExt( &p, qtrue );
ADDRLP4 4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 16
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 4847
;4847:		if( !token || token[0] == 0 || token[0] == '}') {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $4005
ADDRLP4 24
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $4005
ADDRLP4 24
INDIRI4
CNSTI4 125
NEI4 $4002
LABELV $4005
line 4848
;4848:			break;
ADDRGP4 $4001
JUMPV
LABELV $4002
line 4851
;4849:		}
;4850:
;4851:		if ( Q_stricmp( token, "}" ) == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $431
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $4006
line 4852
;4852:			break;
ADDRGP4 $4001
JUMPV
LABELV $4006
line 4855
;4853:		}
;4854:
;4855:		if (Q_stricmp(token, "gametypes") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $4010
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $4008
line 4857
;4856:
;4857:			if (GameType_Parse(&p, qfalse)) {
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 36
ADDRGP4 GameType_Parse
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $4001
line 4858
;4858:				continue;
ADDRGP4 $4000
JUMPV
line 4859
;4859:			} else {
line 4860
;4860:				break;
LABELV $4008
line 4864
;4861:			}
;4862:		}
;4863:
;4864:		if (Q_stricmp(token, "joingametypes") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $4015
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $4013
line 4866
;4865:
;4866:			if (GameType_Parse(&p, qtrue)) {
ADDRLP4 4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 40
ADDRGP4 GameType_Parse
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $4001
line 4867
;4867:				continue;
ADDRGP4 $4000
JUMPV
line 4868
;4868:			} else {
line 4869
;4869:				break;
LABELV $4013
line 4873
;4870:			}
;4871:		}
;4872:
;4873:		if (Q_stricmp(token, "maps") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $4020
ARGP4
ADDRLP4 40
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $4018
line 4875
;4874:			// start a new menu
;4875:			MapList_Parse(&p);
ADDRLP4 4
ARGP4
ADDRGP4 MapList_Parse
CALLI4
pop
line 4876
;4876:		}
LABELV $4018
line 4878
;4877:
;4878:	}
LABELV $4000
line 4845
ADDRGP4 $3999
JUMPV
LABELV $4001
line 4879
;4879:}
LABELV $3996
endproc UI_ParseGameInfo 44 8
proc UI_Pause 4 8
line 4881
;4880:
;4881:static void UI_Pause(qboolean b) {
line 4882
;4882:	if (b) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $4022
line 4884
;4883:		// pause the game and set the ui keycatcher
;4884:	  trap_Cvar_Set( "cl_paused", "1" );
ADDRGP4 $2554
ARGP4
ADDRGP4 $372
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4885
;4885:		trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 4886
;4886:	} else {
ADDRGP4 $4023
JUMPV
LABELV $4022
line 4888
;4887:		// unpause the game and clear the ui keycatcher
;4888:		trap_Key_SetCatcher( trap_Key_GetCatcher() & ~KEYCATCH_UI );
ADDRLP4 0
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 -3
BANDI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 4889
;4889:		trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 4890
;4890:		trap_Cvar_Set( "cl_paused", "0" );
ADDRGP4 $2554
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4891
;4891:	}
LABELV $4023
line 4892
;4892:}
LABELV $4021
endproc UI_Pause 4 8
proc UI_PlayCinematic 4 24
line 4901
;4893:
;4894:#ifndef MISSIONPACK // bk001206
;4895:static int UI_OwnerDraw_Width(int ownerDraw) {
;4896:  // bk001205 - LCC missing return value
;4897:  return 0;
;4898:}
;4899:#endif
;4900:
;4901:static int UI_PlayCinematic(const char *name, float x, float y, float w, float h) {
line 4902
;4902:  return trap_CIN_PlayCinematic(name, x, y, w, h, (CIN_loop | CIN_silent));
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 8
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 12
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 16
INDIRF4
CVFI4 4
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 0
ADDRGP4 trap_CIN_PlayCinematic
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $4024
endproc UI_PlayCinematic 4 24
proc UI_StopCinematic 20 4
line 4905
;4903:}
;4904:
;4905:static void UI_StopCinematic(int handle) {
line 4906
;4906:	if (handle >= 0) {
ADDRFP4 0
INDIRI4
CNSTI4 0
LTI4 $4026
line 4907
;4907:	  trap_CIN_StopCinematic(handle);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 4908
;4908:	} else {
ADDRGP4 $4027
JUMPV
LABELV $4026
line 4909
;4909:		handle = abs(handle);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 abs
CALLI4
ASGNI4
ADDRFP4 0
ADDRLP4 0
INDIRI4
ASGNI4
line 4910
;4910:		if (handle == UI_MAPCINEMATIC) {
ADDRFP4 0
INDIRI4
CNSTI4 244
NEI4 $4028
line 4911
;4911:			if (uiInfo.mapList[ui_currentMap.integer].cinematic >= 0) {
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+24
ADDP4
INDIRI4
CNSTI4 0
LTI4 $4029
line 4912
;4912:			  trap_CIN_StopCinematic(uiInfo.mapList[ui_currentMap.integer].cinematic);
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+24
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 4913
;4913:			  uiInfo.mapList[ui_currentMap.integer].cinematic = -1;
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+24
ADDP4
CNSTI4 -1
ASGNI4
line 4914
;4914:			}
line 4915
;4915:		} else if (handle == UI_NETMAPCINEMATIC) {
ADDRGP4 $4029
JUMPV
LABELV $4028
ADDRFP4 0
INDIRI4
CNSTI4 246
NEI4 $4041
line 4916
;4916:			if (uiInfo.serverStatus.currentServerCinematic >= 0) {
ADDRGP4 uiInfo+99276+10432
INDIRI4
CNSTI4 0
LTI4 $4042
line 4917
;4917:			  trap_CIN_StopCinematic(uiInfo.serverStatus.currentServerCinematic);
ADDRGP4 uiInfo+99276+10432
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 4918
;4918:				uiInfo.serverStatus.currentServerCinematic = -1;
ADDRGP4 uiInfo+99276+10432
CNSTI4 -1
ASGNI4
line 4919
;4919:			}
line 4920
;4920:		} else if (handle == UI_CLANCINEMATIC) {
ADDRGP4 $4042
JUMPV
LABELV $4041
ADDRFP4 0
INDIRI4
CNSTI4 251
NEI4 $4051
line 4921
;4921:		  int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 8
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
line 4922
;4922:		  if (i >= 0 && i < uiInfo.teamCount) {
ADDRLP4 16
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
LTI4 $4053
ADDRLP4 16
INDIRI4
ADDRGP4 uiInfo+75768
INDIRI4
GEI4 $4053
line 4923
;4923:				if (uiInfo.teamList[i].cinematic >= 0) {
ADDRLP4 4
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+40
ADDP4
INDIRI4
CNSTI4 0
LTI4 $4056
line 4924
;4924:				  trap_CIN_StopCinematic(uiInfo.teamList[i].cinematic);
ADDRLP4 4
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+40
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 4925
;4925:					uiInfo.teamList[i].cinematic = -1;
ADDRLP4 4
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75772+40
ADDP4
CNSTI4 -1
ASGNI4
line 4926
;4926:				}
LABELV $4056
line 4927
;4927:			}
LABELV $4053
line 4928
;4928:		}
LABELV $4051
LABELV $4042
LABELV $4029
line 4929
;4929:	}
LABELV $4027
line 4930
;4930:}
LABELV $4025
endproc UI_StopCinematic 20 4
proc UI_DrawCinematic 0 20
line 4932
;4931:
;4932:static void UI_DrawCinematic(int handle, float x, float y, float w, float h) {
line 4933
;4933:	trap_CIN_SetExtents(handle, x, y, w, h);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 8
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 12
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 16
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 trap_CIN_SetExtents
CALLV
pop
line 4934
;4934:  trap_CIN_DrawCinematic(handle);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 trap_CIN_DrawCinematic
CALLV
pop
line 4935
;4935:}
LABELV $4064
endproc UI_DrawCinematic 0 20
proc UI_RunCinematicFrame 0 4
line 4937
;4936:
;4937:static void UI_RunCinematicFrame(int handle) {
line 4938
;4938:  trap_CIN_RunCinematic(handle);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 trap_CIN_RunCinematic
CALLI4
pop
line 4939
;4939:}
LABELV $4065
endproc UI_RunCinematicFrame 0 4
proc UI_BuildQ3Model_List 4520 20
line 4949
;4940:
;4941:
;4942:
;4943:/*
;4944:=================
;4945:PlayerModel_BuildList
;4946:=================
;4947:*/
;4948:static void UI_BuildQ3Model_List( void )
;4949:{
line 4963
;4950:	int		numdirs;
;4951:	int		numfiles;
;4952:	char	dirlist[2048];
;4953:	char	filelist[2048];
;4954:	char	skinname[64];
;4955:	char	scratch[256];
;4956:	char*	dirptr;
;4957:	char*	fileptr;
;4958:	int		i;
;4959:	int		j, k, dirty;
;4960:	int		dirlen;
;4961:	int		filelen;
;4962:
;4963:	uiInfo.q3HeadCount = 0;
ADDRGP4 uiInfo+119500
CNSTI4 0
ASGNI4
line 4966
;4964:
;4965:	// iterate directory of all player models
;4966:	numdirs = trap_FS_GetFileList("models/players", "/", dirlist, 2048 );
ADDRGP4 $4068
ARGP4
ADDRGP4 $4069
ARGP4
ADDRLP4 2408
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 4456
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 2404
ADDRLP4 4456
INDIRI4
ASGNI4
line 4967
;4967:	dirptr  = dirlist;
ADDRLP4 340
ADDRLP4 2408
ASGNP4
line 4968
;4968:	for (i=0; i<numdirs && uiInfo.q3HeadCount < MAX_PLAYERMODELS; i++,dirptr+=dirlen+1)
ADDRLP4 352
CNSTI4 0
ASGNI4
ADDRGP4 $4073
JUMPV
LABELV $4070
line 4969
;4969:	{
line 4970
;4970:		dirlen = strlen(dirptr);
ADDRLP4 340
INDIRP4
ARGP4
ADDRLP4 4460
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 348
ADDRLP4 4460
INDIRU4
CVUI4 4
ASGNI4
line 4972
;4971:		
;4972:		if (dirlen && dirptr[dirlen-1]=='/') dirptr[dirlen-1]='\0';
ADDRLP4 348
INDIRI4
CNSTI4 0
EQI4 $4075
ADDRLP4 348
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 340
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $4075
ADDRLP4 348
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 340
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
LABELV $4075
line 4974
;4973:
;4974:		if (!strcmp(dirptr,".") || !strcmp(dirptr,".."))
ADDRLP4 340
INDIRP4
ARGP4
ADDRGP4 $4079
ARGP4
ADDRLP4 4468
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 4468
INDIRI4
CNSTI4 0
EQI4 $4081
ADDRLP4 340
INDIRP4
ARGP4
ADDRGP4 $4080
ARGP4
ADDRLP4 4472
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 4472
INDIRI4
CNSTI4 0
NEI4 $4077
LABELV $4081
line 4975
;4975:			continue;
ADDRGP4 $4071
JUMPV
LABELV $4077
line 4978
;4976:			
;4977:		// iterate all skin files in directory
;4978:		numfiles = trap_FS_GetFileList( va("models/players/%s",dirptr), "tga", filelist, 2048 );
ADDRGP4 $4082
ARGP4
ADDRLP4 340
INDIRP4
ARGP4
ADDRLP4 4476
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4476
INDIRP4
ARGP4
ADDRGP4 $4083
ARGP4
ADDRLP4 356
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 4480
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 344
ADDRLP4 4480
INDIRI4
ASGNI4
line 4979
;4979:		fileptr  = filelist;
ADDRLP4 328
ADDRLP4 356
ASGNP4
line 4980
;4980:		for (j=0; j<numfiles && uiInfo.q3HeadCount < MAX_PLAYERMODELS;j++,fileptr+=filelen+1)
ADDRLP4 332
CNSTI4 0
ASGNI4
ADDRGP4 $4087
JUMPV
LABELV $4084
line 4981
;4981:		{
line 4982
;4982:			filelen = strlen(fileptr);
ADDRLP4 328
INDIRP4
ARGP4
ADDRLP4 4484
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 336
ADDRLP4 4484
INDIRU4
CVUI4 4
ASGNI4
line 4984
;4983:
;4984:			COM_StripExtension(fileptr,skinname,sizeof(skinname));
ADDRLP4 328
INDIRP4
ARGP4
ADDRLP4 260
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 COM_StripExtension
CALLV
pop
line 4987
;4985:
;4986:			// look for icon_????
;4987:			if (Q_stricmpn(skinname, "icon_", 5) == 0 && !(Q_stricmp(skinname,"icon_blue") == 0 || Q_stricmp(skinname,"icon_red") == 0))
ADDRLP4 260
ARGP4
ADDRGP4 $4091
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 4488
ADDRGP4 Q_stricmpn
CALLI4
ASGNI4
ADDRLP4 4488
INDIRI4
CNSTI4 0
NEI4 $4089
ADDRLP4 260
ARGP4
ADDRGP4 $4092
ARGP4
ADDRLP4 4492
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4492
INDIRI4
CNSTI4 0
EQI4 $4089
ADDRLP4 260
ARGP4
ADDRGP4 $4093
ARGP4
ADDRLP4 4496
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4496
INDIRI4
CNSTI4 0
EQI4 $4089
line 4988
;4988:			{
line 4989
;4989:				if (Q_stricmp(skinname, "icon_default") == 0) {
ADDRLP4 260
ARGP4
ADDRGP4 $4096
ARGP4
ADDRLP4 4500
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4500
INDIRI4
CNSTI4 0
NEI4 $4094
line 4990
;4990:					Com_sprintf( scratch, sizeof(scratch), dirptr);
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 340
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4991
;4991:				} else {
ADDRGP4 $4095
JUMPV
LABELV $4094
line 4992
;4992:					Com_sprintf( scratch, sizeof(scratch), "%s/%s",dirptr, skinname + 5);
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $4097
ARGP4
ADDRLP4 340
INDIRP4
ARGP4
ADDRLP4 260+5
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4993
;4993:				}
LABELV $4095
line 4994
;4994:				dirty = 0;
ADDRLP4 324
CNSTI4 0
ASGNI4
line 4995
;4995:				for(k=0;k<uiInfo.q3HeadCount;k++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $4102
JUMPV
LABELV $4099
line 4996
;4996:					if (!Q_stricmp(scratch, uiInfo.q3HeadNames[uiInfo.q3HeadCount])) {
ADDRLP4 4
ARGP4
ADDRGP4 uiInfo+119500
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+119504
ADDP4
ARGP4
ADDRLP4 4504
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4504
INDIRI4
CNSTI4 0
NEI4 $4104
line 4997
;4997:						dirty = 1;
ADDRLP4 324
CNSTI4 1
ASGNI4
line 4998
;4998:						break;
ADDRGP4 $4101
JUMPV
LABELV $4104
line 5000
;4999:					}
;5000:				}
LABELV $4100
line 4995
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $4102
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+119500
INDIRI4
LTI4 $4099
LABELV $4101
line 5001
;5001:				if (!dirty) {
ADDRLP4 324
INDIRI4
CNSTI4 0
NEI4 $4108
line 5002
;5002:					Com_sprintf( uiInfo.q3HeadNames[uiInfo.q3HeadCount], sizeof(uiInfo.q3HeadNames[uiInfo.q3HeadCount]), scratch);
ADDRGP4 uiInfo+119500
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+119504
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5003
;5003:					uiInfo.q3HeadIcons[uiInfo.q3HeadCount++] = trap_R_RegisterShaderNoMip(va("models/players/%s/%s",dirptr,skinname));
ADDRLP4 4508
ADDRGP4 uiInfo+119500
ASGNP4
ADDRLP4 4504
ADDRLP4 4508
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 4508
INDIRP4
ADDRLP4 4504
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $4116
ARGP4
ADDRLP4 340
INDIRP4
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 4512
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4512
INDIRP4
ARGP4
ADDRLP4 4516
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 4504
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+135888
ADDP4
ADDRLP4 4516
INDIRI4
ASGNI4
line 5004
;5004:				}
LABELV $4108
line 5005
;5005:			}
LABELV $4089
line 5007
;5006:
;5007:		}
LABELV $4085
line 4980
ADDRLP4 332
ADDRLP4 332
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 328
ADDRLP4 336
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 328
INDIRP4
ADDP4
ASGNP4
LABELV $4087
ADDRLP4 332
INDIRI4
ADDRLP4 344
INDIRI4
GEI4 $4117
ADDRGP4 uiInfo+119500
INDIRI4
CNSTI4 256
LTI4 $4084
LABELV $4117
line 5008
;5008:	}	
LABELV $4071
line 4968
ADDRLP4 352
ADDRLP4 352
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 340
ADDRLP4 348
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 340
INDIRP4
ADDP4
ASGNP4
LABELV $4073
ADDRLP4 352
INDIRI4
ADDRLP4 2404
INDIRI4
GEI4 $4118
ADDRGP4 uiInfo+119500
INDIRI4
CNSTI4 256
LTI4 $4070
LABELV $4118
line 5010
;5009:
;5010:}
LABELV $4066
endproc UI_BuildQ3Model_List 4520 20
export _UI_Init
proc _UI_Init 52 16
line 5019
;5011:
;5012:
;5013:
;5014:/*
;5015:=================
;5016:UI_Init
;5017:=================
;5018:*/
;5019:void _UI_Init( qboolean inGameLoad ) {
line 5025
;5020:	const char *menuSet;
;5021:	int start;
;5022:
;5023:	//uiInfo.inGameLoad = inGameLoad;
;5024:
;5025:	UI_RegisterCvars();
ADDRGP4 UI_RegisterCvars
CALLV
pop
line 5026
;5026:	UI_InitMemory();
ADDRGP4 UI_InitMemory
CALLV
pop
line 5029
;5027:
;5028:	// cache redundant calulations
;5029:	UI_VideoCheck( -99999 );
CNSTI4 -99999
ARGI4
ADDRGP4 UI_VideoCheck
CALLV
pop
line 5033
;5030:
;5031:
;5032:  //UI_Load();
;5033:	uiInfo.uiDC.registerShaderNoMip = &trap_R_RegisterShaderNoMip;
ADDRGP4 uiInfo
ADDRGP4 trap_R_RegisterShaderNoMip
ASGNP4
line 5034
;5034:	uiInfo.uiDC.setColor = &UI_SetColor;
ADDRGP4 uiInfo+4
ADDRGP4 UI_SetColor
ASGNP4
line 5035
;5035:	uiInfo.uiDC.drawHandlePic = &UI_DrawHandlePic;
ADDRGP4 uiInfo+8
ADDRGP4 UI_DrawHandlePic
ASGNP4
line 5036
;5036:	uiInfo.uiDC.drawStretchPic = &trap_R_DrawStretchPic;
ADDRGP4 uiInfo+12
ADDRGP4 trap_R_DrawStretchPic
ASGNP4
line 5037
;5037:	uiInfo.uiDC.drawText = &Text_Paint;
ADDRGP4 uiInfo+16
ADDRGP4 Text_Paint
ASGNP4
line 5038
;5038:	uiInfo.uiDC.textWidth = &Text_Width;
ADDRGP4 uiInfo+20
ADDRGP4 Text_Width
ASGNP4
line 5039
;5039:	uiInfo.uiDC.textHeight = &Text_Height;
ADDRGP4 uiInfo+24
ADDRGP4 Text_Height
ASGNP4
line 5040
;5040:	uiInfo.uiDC.registerModel = &trap_R_RegisterModel;
ADDRGP4 uiInfo+28
ADDRGP4 trap_R_RegisterModel
ASGNP4
line 5041
;5041:	uiInfo.uiDC.modelBounds = &trap_R_ModelBounds;
ADDRGP4 uiInfo+32
ADDRGP4 trap_R_ModelBounds
ASGNP4
line 5042
;5042:	uiInfo.uiDC.fillRect = &UI_FillRect;
ADDRGP4 uiInfo+36
ADDRGP4 UI_FillRect
ASGNP4
line 5043
;5043:	uiInfo.uiDC.drawRect = &_UI_DrawRect;
ADDRGP4 uiInfo+40
ADDRGP4 _UI_DrawRect
ASGNP4
line 5044
;5044:	uiInfo.uiDC.drawSides = &_UI_DrawSides;
ADDRGP4 uiInfo+44
ADDRGP4 _UI_DrawSides
ASGNP4
line 5045
;5045:	uiInfo.uiDC.drawTopBottom = &_UI_DrawTopBottom;
ADDRGP4 uiInfo+48
ADDRGP4 _UI_DrawTopBottom
ASGNP4
line 5046
;5046:	uiInfo.uiDC.clearScene = &trap_R_ClearScene;
ADDRGP4 uiInfo+52
ADDRGP4 trap_R_ClearScene
ASGNP4
line 5047
;5047:	uiInfo.uiDC.drawSides = &_UI_DrawSides;
ADDRGP4 uiInfo+44
ADDRGP4 _UI_DrawSides
ASGNP4
line 5048
;5048:	uiInfo.uiDC.addRefEntityToScene = &trap_R_AddRefEntityToScene;
ADDRGP4 uiInfo+56
ADDRGP4 trap_R_AddRefEntityToScene
ASGNP4
line 5049
;5049:	uiInfo.uiDC.renderScene = &trap_R_RenderScene;
ADDRGP4 uiInfo+60
ADDRGP4 trap_R_RenderScene
ASGNP4
line 5050
;5050:	uiInfo.uiDC.registerFont = &trap_R_RegisterFont;
ADDRGP4 uiInfo+64
ADDRGP4 trap_R_RegisterFont
ASGNP4
line 5051
;5051:	uiInfo.uiDC.ownerDrawItem = &UI_OwnerDraw;
ADDRGP4 uiInfo+68
ADDRGP4 UI_OwnerDraw
ASGNP4
line 5052
;5052:	uiInfo.uiDC.getValue = &UI_GetValue;
ADDRGP4 uiInfo+72
ADDRGP4 UI_GetValue
ASGNP4
line 5053
;5053:	uiInfo.uiDC.ownerDrawVisible = &UI_OwnerDrawVisible;
ADDRGP4 uiInfo+76
ADDRGP4 UI_OwnerDrawVisible
ASGNP4
line 5054
;5054:	uiInfo.uiDC.runScript = &UI_RunMenuScript;
ADDRGP4 uiInfo+80
ADDRGP4 UI_RunMenuScript
ASGNP4
line 5055
;5055:	uiInfo.uiDC.getTeamColor = &UI_GetTeamColor;
ADDRGP4 uiInfo+84
ADDRGP4 UI_GetTeamColor
ASGNP4
line 5056
;5056:	uiInfo.uiDC.setCVar = trap_Cvar_Set;
ADDRGP4 uiInfo+96
ADDRGP4 trap_Cvar_Set
ASGNP4
line 5057
;5057:	uiInfo.uiDC.getCVarString = trap_Cvar_VariableStringBuffer;
ADDRGP4 uiInfo+88
ADDRGP4 trap_Cvar_VariableStringBuffer
ASGNP4
line 5058
;5058:	uiInfo.uiDC.getCVarValue = trap_Cvar_VariableValue;
ADDRGP4 uiInfo+92
ADDRGP4 trap_Cvar_VariableValue
ASGNP4
line 5059
;5059:	uiInfo.uiDC.drawTextWithCursor = &Text_PaintWithCursor;
ADDRGP4 uiInfo+100
ADDRGP4 Text_PaintWithCursor
ASGNP4
line 5060
;5060:	uiInfo.uiDC.setOverstrikeMode = &trap_Key_SetOverstrikeMode;
ADDRGP4 uiInfo+104
ADDRGP4 trap_Key_SetOverstrikeMode
ASGNP4
line 5061
;5061:	uiInfo.uiDC.getOverstrikeMode = &trap_Key_GetOverstrikeMode;
ADDRGP4 uiInfo+108
ADDRGP4 trap_Key_GetOverstrikeMode
ASGNP4
line 5062
;5062:	uiInfo.uiDC.startLocalSound = &trap_S_StartLocalSound;
ADDRGP4 uiInfo+112
ADDRGP4 trap_S_StartLocalSound
ASGNP4
line 5063
;5063:	uiInfo.uiDC.ownerDrawHandleKey = &UI_OwnerDrawHandleKey;
ADDRGP4 uiInfo+116
ADDRGP4 UI_OwnerDrawHandleKey
ASGNP4
line 5064
;5064:	uiInfo.uiDC.feederCount = &UI_FeederCount;
ADDRGP4 uiInfo+120
ADDRGP4 UI_FeederCount
ASGNP4
line 5065
;5065:	uiInfo.uiDC.feederItemImage = &UI_FeederItemImage;
ADDRGP4 uiInfo+128
ADDRGP4 UI_FeederItemImage
ASGNP4
line 5066
;5066:	uiInfo.uiDC.feederItemText = &UI_FeederItemText;
ADDRGP4 uiInfo+124
ADDRGP4 UI_FeederItemText
ASGNP4
line 5067
;5067:	uiInfo.uiDC.feederSelection = &UI_FeederSelection;
ADDRGP4 uiInfo+132
ADDRGP4 UI_FeederSelection
ASGNP4
line 5068
;5068:	uiInfo.uiDC.setBinding = &trap_Key_SetBinding;
ADDRGP4 uiInfo+144
ADDRGP4 trap_Key_SetBinding
ASGNP4
line 5069
;5069:	uiInfo.uiDC.getBindingBuf = &trap_Key_GetBindingBuf;
ADDRGP4 uiInfo+140
ADDRGP4 trap_Key_GetBindingBuf
ASGNP4
line 5070
;5070:	uiInfo.uiDC.keynumToStringBuf = &trap_Key_KeynumToStringBuf;
ADDRGP4 uiInfo+136
ADDRGP4 trap_Key_KeynumToStringBuf
ASGNP4
line 5071
;5071:	uiInfo.uiDC.executeText = &trap_Cmd_ExecuteText;
ADDRGP4 uiInfo+148
ADDRGP4 trap_Cmd_ExecuteText
ASGNP4
line 5072
;5072:	uiInfo.uiDC.Error = &Com_Error; 
ADDRGP4 uiInfo+152
ADDRGP4 Com_Error
ASGNP4
line 5073
;5073:	uiInfo.uiDC.Print = &Com_Printf; 
ADDRGP4 uiInfo+156
ADDRGP4 Com_Printf
ASGNP4
line 5074
;5074:	uiInfo.uiDC.Pause = &UI_Pause;
ADDRGP4 uiInfo+160
ADDRGP4 UI_Pause
ASGNP4
line 5075
;5075:	uiInfo.uiDC.ownerDrawWidth = &UI_OwnerDrawWidth;
ADDRGP4 uiInfo+164
ADDRGP4 UI_OwnerDrawWidth
ASGNP4
line 5076
;5076:	uiInfo.uiDC.registerSound = &trap_S_RegisterSound;
ADDRGP4 uiInfo+168
ADDRGP4 trap_S_RegisterSound
ASGNP4
line 5077
;5077:	uiInfo.uiDC.startBackgroundTrack = &trap_S_StartBackgroundTrack;
ADDRGP4 uiInfo+172
ADDRGP4 trap_S_StartBackgroundTrack
ASGNP4
line 5078
;5078:	uiInfo.uiDC.stopBackgroundTrack = &trap_S_StopBackgroundTrack;
ADDRGP4 uiInfo+176
ADDRGP4 trap_S_StopBackgroundTrack
ASGNP4
line 5079
;5079:	uiInfo.uiDC.playCinematic = &UI_PlayCinematic;
ADDRGP4 uiInfo+180
ADDRGP4 UI_PlayCinematic
ASGNP4
line 5080
;5080:	uiInfo.uiDC.stopCinematic = &UI_StopCinematic;
ADDRGP4 uiInfo+184
ADDRGP4 UI_StopCinematic
ASGNP4
line 5081
;5081:	uiInfo.uiDC.drawCinematic = &UI_DrawCinematic;
ADDRGP4 uiInfo+188
ADDRGP4 UI_DrawCinematic
ASGNP4
line 5082
;5082:	uiInfo.uiDC.runCinematicFrame = &UI_RunCinematicFrame;
ADDRGP4 uiInfo+192
ADDRGP4 UI_RunCinematicFrame
ASGNP4
line 5084
;5083:
;5084:	Init_Display(&uiInfo.uiDC);
ADDRGP4 uiInfo
ARGP4
ADDRGP4 Init_Display
CALLV
pop
line 5086
;5085:
;5086:	String_Init();
ADDRGP4 String_Init
CALLV
pop
line 5088
;5087:  
;5088:	uiInfo.uiDC.cursor	= trap_R_RegisterShaderNoMip( "menu/art/3_cursor2" );
ADDRGP4 $4170
ARGP4
ADDRLP4 8
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+73384
ADDRLP4 8
INDIRI4
ASGNI4
line 5089
;5089:	uiInfo.uiDC.whiteShader = trap_R_RegisterShaderNoMip( "white" );
ADDRGP4 $4172
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+73376
ADDRLP4 12
INDIRI4
ASGNI4
line 5091
;5090:
;5091:	AssetCache();
ADDRGP4 AssetCache
CALLV
pop
line 5093
;5092:
;5093:	start = trap_Milliseconds();
ADDRLP4 16
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 5095
;5094:
;5095:  uiInfo.teamCount = 0;
ADDRGP4 uiInfo+75768
CNSTI4 0
ASGNI4
line 5096
;5096:  uiInfo.characterCount = 0;
ADDRGP4 uiInfo+73452
CNSTI4 0
ASGNI4
line 5097
;5097:  uiInfo.aliasCount = 0;
ADDRGP4 uiInfo+74996
CNSTI4 0
ASGNI4
line 5103
;5098:
;5099:#ifdef PRE_RELEASE_TADEMO
;5100:	UI_ParseTeamInfo("demoteaminfo.txt");
;5101:	UI_ParseGameInfo("demogameinfo.txt");
;5102:#else
;5103:	UI_ParseTeamInfo("teaminfo.txt");
ADDRGP4 $4176
ARGP4
ADDRGP4 UI_ParseTeamInfo
CALLV
pop
line 5104
;5104:	UI_LoadTeams();
ADDRGP4 UI_LoadTeams
CALLV
pop
line 5105
;5105:	UI_ParseGameInfo("gameinfo.txt");
ADDRGP4 $656
ARGP4
ADDRGP4 UI_ParseGameInfo
CALLV
pop
line 5108
;5106:#endif
;5107:
;5108:	menuSet = UI_Cvar_VariableString("ui_menuFiles");
ADDRGP4 $650
ARGP4
ADDRLP4 20
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 5109
;5109:	if (menuSet == NULL || menuSet[0] == '\0') {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $4179
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $4177
LABELV $4179
line 5110
;5110:		menuSet = "ui/menus.txt";
ADDRLP4 0
ADDRGP4 $622
ASGNP4
line 5111
;5111:	}
LABELV $4177
line 5119
;5112:
;5113:#if 0
;5114:	if (uiInfo.inGameLoad) {
;5115:		UI_LoadMenus("ui/ingame.txt", qtrue);
;5116:	} else { // bk010222: left this: UI_LoadMenus(menuSet, qtrue);
;5117:	}
;5118:#else 
;5119:	UI_LoadMenus(menuSet, qtrue);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 UI_LoadMenus
CALLV
pop
line 5120
;5120:	UI_LoadMenus("ui/ingame.txt", qfalse);
ADDRGP4 $4180
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 UI_LoadMenus
CALLV
pop
line 5123
;5121:#endif
;5122:	
;5123:	Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 5125
;5124:
;5125:	trap_LAN_LoadCachedServers();
ADDRGP4 trap_LAN_LoadCachedServers
CALLV
pop
line 5126
;5126:	UI_LoadBestScores(uiInfo.mapList[ui_currentMap.integer].mapLoadName, uiInfo.gameTypes[ui_gameType.integer].gtEnum);
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83240+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78592+4
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_LoadBestScores
CALLV
pop
line 5128
;5127:
;5128:	UI_BuildQ3Model_List();
ADDRGP4 UI_BuildQ3Model_List
CALLV
pop
line 5129
;5129:	UI_LoadBots();
ADDRGP4 UI_LoadBots
CALLV
pop
line 5132
;5130:
;5131:	// sets defaults for ui temp cvars
;5132:	uiInfo.effectsColor = (int)trap_Cvar_VariableValue("color1")-1;
ADDRGP4 $1727
ARGP4
ADDRLP4 28
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRGP4 uiInfo+136916
ADDRLP4 28
INDIRF4
CVFI4 4
CNSTI4 1
SUBI4
ASGNI4
line 5133
;5133:	if ( uiInfo.effectsColor < 0 || uiInfo.effectsColor > 6) {
ADDRGP4 uiInfo+136916
INDIRI4
CNSTI4 0
LTI4 $4192
ADDRGP4 uiInfo+136916
INDIRI4
CNSTI4 6
LEI4 $4188
LABELV $4192
line 5134
;5134:		uiInfo.effectsColor = 6;
ADDRGP4 uiInfo+136916
CNSTI4 6
ASGNI4
line 5135
;5135:	}
LABELV $4188
line 5136
;5136:	uiInfo.currentCrosshair = (int)trap_Cvar_VariableValue("cg_drawCrosshair");
ADDRGP4 $2010
ARGP4
ADDRLP4 32
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRGP4 uiInfo+119488
ADDRLP4 32
INDIRF4
CVFI4 4
ASGNI4
line 5137
;5137:	trap_Cvar_Set("ui_mousePitch", (trap_Cvar_VariableValue("m_pitch") >= 0) ? "0" : "1");
ADDRGP4 $2309
ARGP4
ADDRLP4 40
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 40
INDIRF4
CNSTF4 0
LTF4 $4196
ADDRLP4 36
ADDRGP4 $369
ASGNP4
ADDRGP4 $4197
JUMPV
LABELV $4196
ADDRLP4 36
ADDRGP4 $372
ASGNP4
LABELV $4197
ADDRGP4 $2306
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5139
;5138:
;5139:	uiInfo.serverStatus.currentServerCinematic = -1;
ADDRGP4 uiInfo+99276+10432
CNSTI4 -1
ASGNI4
line 5140
;5140:	uiInfo.previewMovie = -1;
ADDRGP4 uiInfo+99272
CNSTI4 -1
ASGNI4
line 5142
;5141:
;5142:	if (trap_Cvar_VariableValue("ui_TeamArenaFirstRun") == 0) {
ADDRGP4 $4203
ARGP4
ADDRLP4 44
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 44
INDIRF4
CNSTF4 0
NEF4 $4201
line 5143
;5143:		trap_Cvar_Set("s_volume", "0.8");
ADDRGP4 $4204
ARGP4
ADDRGP4 $4205
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5144
;5144:		trap_Cvar_Set("s_musicvolume", "0.5");
ADDRGP4 $4206
ARGP4
ADDRGP4 $4207
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5145
;5145:		trap_Cvar_Set("ui_TeamArenaFirstRun", "1");
ADDRGP4 $4203
ARGP4
ADDRGP4 $372
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5146
;5146:	}
LABELV $4201
line 5148
;5147:
;5148:	trap_Cvar_Register(NULL, "debug_protocol", "", 0 );
CNSTP4 0
ARGP4
ADDRGP4 $4208
ARGP4
ADDRGP4 $110
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5150
;5149:
;5150:	trap_Cvar_Set("ui_actualNetGameType", va("%d", ui_netGameType.integer));
ADDRGP4 $695
ARGP4
ADDRGP4 ui_netGameType+12
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $710
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5151
;5151:}
LABELV $4119
endproc _UI_Init 52 16
export _UI_KeyEvent
proc _UI_KeyEvent 20 12
line 5159
;5152:
;5153:
;5154:/*
;5155:=================
;5156:UI_KeyEvent
;5157:=================
;5158:*/
;5159:void _UI_KeyEvent( int key, qboolean down ) {
line 5161
;5160:
;5161:	UI_VideoCheck( trap_Milliseconds() );
ADDRLP4 0
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 UI_VideoCheck
CALLV
pop
line 5163
;5162:
;5163:  if (Menu_Count() > 0) {
ADDRLP4 4
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LEI4 $4211
line 5164
;5164:    menuDef_t *menu = Menu_GetFocused();
ADDRLP4 12
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 5165
;5165:		if (menu) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $4213
line 5166
;5166:			if (key == K_ESCAPE && down && !Menus_AnyFullScreenVisible()) {
ADDRFP4 0
INDIRI4
CNSTI4 27
NEI4 $4215
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $4215
ADDRLP4 16
ADDRGP4 Menus_AnyFullScreenVisible
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $4215
line 5167
;5167:				Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 5168
;5168:			} else {
ADDRGP4 $4214
JUMPV
LABELV $4215
line 5169
;5169:				Menu_HandleKey(menu, key, down );
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 Menu_HandleKey
CALLV
pop
line 5170
;5170:			}
line 5171
;5171:		} else {
ADDRGP4 $4214
JUMPV
LABELV $4213
line 5172
;5172:			trap_Key_SetCatcher( trap_Key_GetCatcher() & ~KEYCATCH_UI );
ADDRLP4 16
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 -3
BANDI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 5173
;5173:			trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 5174
;5174:			trap_Cvar_Set( "cl_paused", "0" );
ADDRGP4 $2554
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5175
;5175:		}
LABELV $4214
line 5176
;5176:  }
LABELV $4211
line 5181
;5177:
;5178:  //if ((s > 0) && (s != menu_null_sound)) {
;5179:	//  trap_S_StartLocalSound( s, CHAN_LOCAL_SOUND );
;5180:  //}
;5181:}
LABELV $4210
endproc _UI_KeyEvent 20 12
export _UI_MouseEvent
proc _UI_MouseEvent 12 12
line 5189
;5182:
;5183:/*
;5184:=================
;5185:UI_MouseEvent
;5186:=================
;5187:*/
;5188:void _UI_MouseEvent( int dx, int dy )
;5189:{
line 5191
;5190:	// update virtual mouse cursor coordinates
;5191:	uiInfo.uiDC.cursorx += dx * uiInfo.uiDC.cursorScaleR;
ADDRLP4 0
ADDRGP4 uiInfo+216
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 0
INDIRI4
CVIF4 4
ADDRGP4 uiInfo+73404
INDIRF4
MULF4
ADDF4
ASGNF4
line 5192
;5192:	uiInfo.uiDC.cursory += dy * uiInfo.uiDC.cursorScaleR;
ADDRLP4 4
ADDRGP4 uiInfo+220
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRFP4 4
INDIRI4
CVIF4 4
ADDRGP4 uiInfo+73404
INDIRF4
MULF4
ADDF4
ASGNF4
line 5195
;5193:	
;5194:	// clamp virtual coordinates
;5195:	if ( uiInfo.uiDC.cursorx < uiInfo.uiDC.screenXmin )
ADDRGP4 uiInfo+216
INDIRF4
ADDRGP4 uiInfo+73408
INDIRF4
GEF4 $4222
line 5196
;5196:		uiInfo.uiDC.cursorx = uiInfo.uiDC.screenXmin;
ADDRGP4 uiInfo+216
ADDRGP4 uiInfo+73408
INDIRF4
ASGNF4
ADDRGP4 $4223
JUMPV
LABELV $4222
line 5197
;5197:	else if ( uiInfo.uiDC.cursorx > uiInfo.uiDC.screenXmax )
ADDRGP4 uiInfo+216
INDIRF4
ADDRGP4 uiInfo+73412
INDIRF4
LEF4 $4228
line 5198
;5198:		uiInfo.uiDC.cursorx = uiInfo.uiDC.screenXmax;
ADDRGP4 uiInfo+216
ADDRGP4 uiInfo+73412
INDIRF4
ASGNF4
LABELV $4228
LABELV $4223
line 5200
;5199:
;5200:	if ( uiInfo.uiDC.cursory < uiInfo.uiDC.screenYmin )
ADDRGP4 uiInfo+220
INDIRF4
ADDRGP4 uiInfo+73416
INDIRF4
GEF4 $4234
line 5201
;5201:		uiInfo.uiDC.cursory = uiInfo.uiDC.screenYmin;
ADDRGP4 uiInfo+220
ADDRGP4 uiInfo+73416
INDIRF4
ASGNF4
ADDRGP4 $4235
JUMPV
LABELV $4234
line 5202
;5202:	else if ( uiInfo.uiDC.cursory > uiInfo.uiDC.screenYmax )
ADDRGP4 uiInfo+220
INDIRF4
ADDRGP4 uiInfo+73420
INDIRF4
LEF4 $4240
line 5203
;5203:		uiInfo.uiDC.cursory = uiInfo.uiDC.screenYmax;
ADDRGP4 uiInfo+220
ADDRGP4 uiInfo+73420
INDIRF4
ASGNF4
LABELV $4240
LABELV $4235
line 5206
;5204:
;5205:
;5206:  if (Menu_Count() > 0) {
ADDRLP4 8
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LEI4 $4246
line 5209
;5207:    //menuDef_t *menu = Menu_GetFocused();
;5208:    //Menu_HandleMouseMove(menu, uiInfo.uiDC.cursorx, uiInfo.uiDC.cursory);
;5209:		Display_MouseMove(NULL, uiInfo.uiDC.cursorx, uiInfo.uiDC.cursory);
CNSTP4 0
ARGP4
ADDRGP4 uiInfo+216
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 uiInfo+220
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Display_MouseMove
CALLI4
pop
line 5210
;5210:  }
LABELV $4246
line 5212
;5211:
;5212:}
LABELV $4217
endproc _UI_MouseEvent 12 12
export UI_LoadNonIngame
proc UI_LoadNonIngame 12 8
line 5214
;5213:
;5214:void UI_LoadNonIngame() {
line 5215
;5215:	const char *menuSet = UI_Cvar_VariableString("ui_menuFiles");
ADDRGP4 $650
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 5216
;5216:	if (menuSet == NULL || menuSet[0] == '\0') {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $4253
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $4251
LABELV $4253
line 5217
;5217:		menuSet = "ui/menus.txt";
ADDRLP4 0
ADDRGP4 $622
ASGNP4
line 5218
;5218:	}
LABELV $4251
line 5219
;5219:	UI_LoadMenus(menuSet, qfalse);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 UI_LoadMenus
CALLV
pop
line 5220
;5220:	uiInfo.inGameLoad = qfalse;
ADDRGP4 uiInfo+136920
CNSTI4 0
ASGNI4
line 5221
;5221:}
LABELV $4250
endproc UI_LoadNonIngame 12 8
export _UI_SetActiveMenu
proc _UI_SetActiveMenu 292 12
line 5223
;5222:
;5223:void _UI_SetActiveMenu( uiMenuCommand_t menu ) {
line 5228
;5224:	char buf[256];
;5225:
;5226:	// this should be the ONLY way the menu system is brought up
;5227:	// enusure minumum menu data is cached
;5228:  if (Menu_Count() > 0) {
ADDRLP4 256
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 256
INDIRI4
CNSTI4 0
LEI4 $4256
line 5230
;5229:		vec3_t v;
;5230:		v[0] = v[1] = v[2] = 0;
ADDRLP4 272
CNSTF4 0
ASGNF4
ADDRLP4 260+8
ADDRLP4 272
INDIRF4
ASGNF4
ADDRLP4 260+4
ADDRLP4 272
INDIRF4
ASGNF4
ADDRLP4 260
ADDRLP4 272
INDIRF4
ASGNF4
line 5231
;5231:	  switch ( menu ) {
ADDRLP4 276
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 276
INDIRI4
CNSTI4 0
LTI4 $4260
ADDRLP4 276
INDIRI4
CNSTI4 6
GTI4 $4260
ADDRLP4 276
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $4284
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $4284
address $4263
address $4264
address $4282
address $4255
address $4255
address $4274
address $4277
code
LABELV $4263
line 5233
;5232:	  case UIMENU_NONE:
;5233:			trap_Key_SetCatcher( trap_Key_GetCatcher() & ~KEYCATCH_UI );
ADDRLP4 284
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 -3
BANDI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 5234
;5234:			trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 5235
;5235:			trap_Cvar_Set( "cl_paused", "0" );
ADDRGP4 $2554
ARGP4
ADDRGP4 $369
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5236
;5236:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 5238
;5237:
;5238:		  return;
ADDRGP4 $4255
JUMPV
LABELV $4264
line 5241
;5239:	  case UIMENU_MAIN:
;5240:			//trap_Cvar_Set( "sv_killserver", "1" );
;5241:			trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 5244
;5242:			//trap_S_StartLocalSound( trap_S_RegisterSound("sound/misc/menu_background.wav", qfalse) , CHAN_LOCAL_SOUND );
;5243:			//trap_S_StartBackgroundTrack("sound/misc/menu_background.wav", NULL);
;5244:			if (uiInfo.inGameLoad) {
ADDRGP4 uiInfo+136920
INDIRI4
CNSTI4 0
EQI4 $4265
line 5245
;5245:				UI_LoadNonIngame();
ADDRGP4 UI_LoadNonIngame
CALLV
pop
line 5246
;5246:			}
LABELV $4265
line 5247
;5247:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 5248
;5248:			Menus_ActivateByName("main");
ADDRGP4 $2484
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 5249
;5249:			trap_Cvar_VariableStringBuffer("com_errorMessage", buf, sizeof(buf));
ADDRGP4 $2405
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 5250
;5250:			if (strlen(buf)) {
ADDRLP4 0
ARGP4
ADDRLP4 288
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 288
INDIRU4
CNSTU4 0
EQU4 $4255
line 5251
;5251:				if (!ui_singlePlayerActive.integer) {
ADDRGP4 ui_singlePlayerActive+12
INDIRI4
CNSTI4 0
NEI4 $4270
line 5252
;5252:					Menus_ActivateByName("error_popmenu");
ADDRGP4 $4273
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 5253
;5253:				} else {
ADDRGP4 $4255
JUMPV
LABELV $4270
line 5254
;5254:					trap_Cvar_Set("com_errorMessage", "");
ADDRGP4 $2405
ARGP4
ADDRGP4 $110
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5255
;5255:				}
line 5256
;5256:			}
line 5257
;5257:		  return;
ADDRGP4 $4255
JUMPV
LABELV $4274
line 5259
;5258:	  case UIMENU_TEAM:
;5259:			trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 5260
;5260:      Menus_ActivateByName("team");
ADDRGP4 $2101
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 5261
;5261:		  return;
ADDRGP4 $4255
JUMPV
line 5267
;5262:	  case UIMENU_NEED_CD:
;5263:			// no cd check in TA
;5264:			//trap_Key_SetCatcher( KEYCATCH_UI );
;5265:      //Menus_ActivateByName("needcd");
;5266:		  //UI_ConfirmMenu( "Insert the CD", NULL, NeedCDAction );
;5267:		  return;
line 5273
;5268:	  case UIMENU_BAD_CD_KEY:
;5269:			// no cd check in TA
;5270:			//trap_Key_SetCatcher( KEYCATCH_UI );
;5271:      //Menus_ActivateByName("badcd");
;5272:		  //UI_ConfirmMenu( "Bad CD Key", NULL, NeedCDKeyAction );
;5273:		  return;
LABELV $4277
line 5276
;5274:	  case UIMENU_POSTGAME:
;5275:			//trap_Cvar_Set( "sv_killserver", "1" );
;5276:			trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 5277
;5277:			if (uiInfo.inGameLoad) {
ADDRGP4 uiInfo+136920
INDIRI4
CNSTI4 0
EQI4 $4278
line 5278
;5278:				UI_LoadNonIngame();
ADDRGP4 UI_LoadNonIngame
CALLV
pop
line 5279
;5279:			}
LABELV $4278
line 5280
;5280:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 5281
;5281:			Menus_ActivateByName("endofgame");
ADDRGP4 $4281
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 5283
;5282:		  //UI_ConfirmMenu( "Bad CD Key", NULL, NeedCDKeyAction );
;5283:		  return;
ADDRGP4 $4255
JUMPV
LABELV $4282
line 5285
;5284:	  case UIMENU_INGAME:
;5285:		  trap_Cvar_Set( "cl_paused", "1" );
ADDRGP4 $2554
ARGP4
ADDRGP4 $372
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5286
;5286:			trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 5287
;5287:			UI_BuildPlayerList();
ADDRGP4 UI_BuildPlayerList
CALLV
pop
line 5288
;5288:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 5289
;5289:			Menus_ActivateByName("ingame");
ADDRGP4 $4283
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 5290
;5290:		  return;
LABELV $4260
line 5292
;5291:	  }
;5292:  }
LABELV $4256
line 5293
;5293:}
LABELV $4255
endproc _UI_SetActiveMenu 292 12
export _UI_IsFullscreen
proc _UI_IsFullscreen 4 0
line 5295
;5294:
;5295:qboolean _UI_IsFullscreen( void ) {
line 5296
;5296:	return Menus_AnyFullScreenVisible();
ADDRLP4 0
ADDRGP4 Menus_AnyFullScreenVisible
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $4285
endproc _UI_IsFullscreen 4 0
proc UI_ReadableSize 12 16
line 5305
;5297:}
;5298:
;5299:
;5300:
;5301:static connstate_t	lastConnState;
;5302:static char			lastLoadingText[MAX_INFO_VALUE];
;5303:
;5304:static void UI_ReadableSize ( char *buf, int bufsize, int value )
;5305:{
line 5306
;5306:	if (value > 1024*1024*1024 ) { // gigs
ADDRFP4 8
INDIRI4
CNSTI4 1073741824
LEI4 $4287
line 5307
;5307:		Com_sprintf( buf, bufsize, "%d", value / (1024*1024*1024) );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $695
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1073741824
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5308
;5308:		Com_sprintf( buf+strlen(buf), bufsize-strlen(buf), ".%02d GB", 
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 0
INDIRU4
ADDRLP4 4
INDIRP4
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
CVIU4 4
ADDRLP4 8
INDIRU4
SUBU4
CVUI4 4
ARGI4
ADDRGP4 $4289
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1073741824
MODI4
CNSTI4 100
MULI4
CNSTI4 1073741824
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5310
;5309:			(value % (1024*1024*1024))*100 / (1024*1024*1024) );
;5310:	} else if (value > 1024*1024 ) { // megs
ADDRGP4 $4288
JUMPV
LABELV $4287
ADDRFP4 8
INDIRI4
CNSTI4 1048576
LEI4 $4290
line 5311
;5311:		Com_sprintf( buf, bufsize, "%d", value / (1024*1024) );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $695
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1048576
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5312
;5312:		Com_sprintf( buf+strlen(buf), bufsize-strlen(buf), ".%02d MB", 
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 0
INDIRU4
ADDRLP4 4
INDIRP4
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
CVIU4 4
ADDRLP4 8
INDIRU4
SUBU4
CVUI4 4
ARGI4
ADDRGP4 $4292
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1048576
MODI4
CNSTI4 100
MULI4
CNSTI4 1048576
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5314
;5313:			(value % (1024*1024))*100 / (1024*1024) );
;5314:	} else if (value > 1024 ) { // kilos
ADDRGP4 $4291
JUMPV
LABELV $4290
ADDRFP4 8
INDIRI4
CNSTI4 1024
LEI4 $4293
line 5315
;5315:		Com_sprintf( buf, bufsize, "%d KB", value / 1024 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $4295
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1024
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5316
;5316:	} else { // bytes
ADDRGP4 $4294
JUMPV
LABELV $4293
line 5317
;5317:		Com_sprintf( buf, bufsize, "%d bytes", value );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $4296
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5318
;5318:	}
LABELV $4294
LABELV $4291
LABELV $4288
line 5319
;5319:}
LABELV $4286
endproc UI_ReadableSize 12 16
proc UI_PrintTime 4 20
line 5322
;5320:
;5321:// Assumes time is in msec
;5322:static void UI_PrintTime ( char *buf, int bufsize, int time ) {
line 5323
;5323:	time /= 1000;  // change to seconds
ADDRFP4 8
ADDRFP4 8
INDIRI4
CNSTI4 1000
DIVI4
ASGNI4
line 5325
;5324:
;5325:	if (time > 3600) { // in the hours range
ADDRFP4 8
INDIRI4
CNSTI4 3600
LEI4 $4298
line 5326
;5326:		Com_sprintf( buf, bufsize, "%d hr %d min", time / 3600, (time % 3600) / 60 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $4300
ARGP4
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3600
DIVI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 3600
MODI4
CNSTI4 60
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5327
;5327:	} else if (time > 60) { // mins
ADDRGP4 $4299
JUMPV
LABELV $4298
ADDRFP4 8
INDIRI4
CNSTI4 60
LEI4 $4301
line 5328
;5328:		Com_sprintf( buf, bufsize, "%d min %d sec", time / 60, time % 60 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $4303
ARGP4
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 60
DIVI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 60
MODI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5329
;5329:	} else  { // secs
ADDRGP4 $4302
JUMPV
LABELV $4301
line 5330
;5330:		Com_sprintf( buf, bufsize, "%d sec", time );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $4304
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5331
;5331:	}
LABELV $4302
LABELV $4299
line 5332
;5332:}
LABELV $4297
endproc UI_PrintTime 4 20
export Text_PaintCenter
proc Text_PaintCenter 8 32
line 5334
;5333:
;5334:void Text_PaintCenter(float x, float y, float scale, vec4_t color, const char *text, float adjust) {
line 5335
;5335:	int len = Text_Width(text, scale, 0);
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 8
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 Text_Width
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 5336
;5336:	Text_Paint(x - len / 2, y, scale, color, text, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
ADDRFP4 0
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
DIVI4
CVIF4 4
SUBF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 5337
;5337:}
LABELV $4305
endproc Text_PaintCenter 8 32
export Text_PaintCenter_AutoWrapped
proc Text_PaintCenter_AutoWrapped 1056 24
line 5339
;5338:
;5339:void Text_PaintCenter_AutoWrapped(float x, float y, float xmax, float ystep, float scale, vec4_t color, const char *str, float adjust) {
line 5345
;5340:	int width;
;5341:	char *s1,*s2,*s3;
;5342:	char c_bcp;
;5343:	char buf[1024];
;5344:
;5345:	if (!str || str[0]=='\0')
ADDRLP4 1044
ADDRFP4 24
INDIRP4
ASGNP4
ADDRLP4 1044
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $4309
ADDRLP4 1044
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $4307
LABELV $4309
line 5346
;5346:		return;
ADDRGP4 $4306
JUMPV
LABELV $4307
line 5348
;5347:
;5348:	Q_strncpyz(buf, str, sizeof(buf));
ADDRLP4 20
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 5349
;5349:	s1 = s2 = s3 = buf;
ADDRLP4 0
ADDRLP4 20
ASGNP4
ADDRLP4 4
ADDRLP4 20
ASGNP4
ADDRLP4 12
ADDRLP4 20
ASGNP4
ADDRGP4 $4311
JUMPV
LABELV $4310
line 5351
;5350:
;5351:	while (1) {
LABELV $4313
line 5352
;5352:		do {
line 5353
;5353:			s3++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 5354
;5354:		} while (*s3!=' ' && *s3!='\0');
LABELV $4314
ADDRLP4 1048
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 32
EQI4 $4316
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $4313
LABELV $4316
line 5355
;5355:		c_bcp = *s3;
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRI1
ASGNI1
line 5356
;5356:		*s3 = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 5357
;5357:		width = Text_Width(s1, scale, 0);
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 1052
ADDRGP4 Text_Width
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 1052
INDIRI4
ASGNI4
line 5358
;5358:		*s3 = c_bcp;
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI1
ASGNI1
line 5359
;5359:		if (width > xmax) {
ADDRLP4 16
INDIRI4
CVIF4 4
ADDRFP4 8
INDIRF4
LEF4 $4317
line 5360
;5360:			if (s1==s2)
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
NEU4 $4319
line 5361
;5361:			{
line 5363
;5362:				// fuck, don't have a clean cut, we'll overflow
;5363:				s2 = s3;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 5364
;5364:			}
LABELV $4319
line 5365
;5365:			*s2 = '\0';
ADDRLP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 5366
;5366:			Text_PaintCenter(x, y, scale, color, s1, adjust);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 28
INDIRF4
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5367
;5367:			y += ystep;
ADDRFP4 4
ADDRFP4 4
INDIRF4
ADDRFP4 12
INDIRF4
ADDF4
ASGNF4
line 5368
;5368:			if (c_bcp == '\0')
ADDRLP4 8
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $4321
line 5369
;5369:      {
line 5374
;5370:				// that was the last word
;5371:        // we could start a new loop, but that wouldn't be much use
;5372:        // even if the word is too long, we would overflow it (see above)
;5373:        // so just print it now if needed
;5374:        s2++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 5375
;5375:        if (*s2 != '\0') // if we are printing an overflowing line we have s2 == s3
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $4312
line 5376
;5376:          Text_PaintCenter(x, y, scale, color, s2, adjust);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 28
INDIRF4
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5377
;5377:        break;
ADDRGP4 $4312
JUMPV
LABELV $4321
line 5379
;5378:      }
;5379:			s2++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 5380
;5380:			s1 = s2;
ADDRLP4 12
ADDRLP4 4
INDIRP4
ASGNP4
line 5381
;5381:			s3 = s2;
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 5382
;5382:		}
ADDRGP4 $4318
JUMPV
LABELV $4317
line 5384
;5383:		else
;5384:		{
line 5385
;5385:			s2 = s3;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 5386
;5386:			if (c_bcp == '\0') // we reached the end
ADDRLP4 8
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $4325
line 5387
;5387:			{
line 5388
;5388:				Text_PaintCenter(x, y, scale, color, s1, adjust);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 28
INDIRF4
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5389
;5389:				break;
ADDRGP4 $4312
JUMPV
LABELV $4325
line 5391
;5390:			}
;5391:		}
LABELV $4318
line 5392
;5392:	}
LABELV $4311
line 5351
ADDRGP4 $4310
JUMPV
LABELV $4312
line 5393
;5393:}
LABELV $4306
endproc Text_PaintCenter_AutoWrapped 1056 24
lit
align 1
LABELV $4328
byte 1 68
byte 1 111
byte 1 119
byte 1 110
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 0
align 1
LABELV $4329
byte 1 69
byte 1 115
byte 1 116
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 58
byte 1 0
align 1
LABELV $4330
byte 1 84
byte 1 114
byte 1 97
byte 1 110
byte 1 115
byte 1 102
byte 1 101
byte 1 114
byte 1 32
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 58
byte 1 0
code
proc UI_DisplayDownloadInfo 304 24
line 5395
;5394:
;5395:static void UI_DisplayDownloadInfo( const char *downloadName, float centerPoint, float yStart, float scale ) {
line 5406
;5396:	static char dlText[]	= "Downloading:";
;5397:	static char etaText[]	= "Estimated time left:";
;5398:	static char xferText[]	= "Transfer rate:";
;5399:
;5400:	int downloadSize, downloadCount, downloadTime;
;5401:	char dlSizeBuf[64], totalSizeBuf[64], xferRateBuf[64], dlTimeBuf[64];
;5402:	int xferRate;
;5403:	int leftWidth;
;5404:	const char *s;
;5405:
;5406:	downloadSize = trap_Cvar_VariableValue( "cl_downloadSize" );
ADDRGP4 $4331
ARGP4
ADDRLP4 280
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 280
INDIRF4
CVFI4 4
ASGNI4
line 5407
;5407:	downloadCount = trap_Cvar_VariableValue( "cl_downloadCount" );
ADDRGP4 $4332
ARGP4
ADDRLP4 284
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 284
INDIRF4
CVFI4 4
ASGNI4
line 5408
;5408:	downloadTime = trap_Cvar_VariableValue( "cl_downloadTime" );
ADDRGP4 $4333
ARGP4
ADDRLP4 288
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 140
ADDRLP4 288
INDIRF4
CVFI4 4
ASGNI4
line 5410
;5409:
;5410:	leftWidth = 320;
ADDRLP4 8
CNSTI4 320
ASGNI4
line 5412
;5411:
;5412:	UI_SetColor(colorWhite);
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_SetColor
CALLV
pop
line 5413
;5413:	Text_PaintCenter(centerPoint, yStart + 112, scale, colorWhite, dlText, 0);
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1121976320
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 $4328
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5414
;5414:	Text_PaintCenter(centerPoint, yStart + 192, scale, colorWhite, etaText, 0);
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1128267776
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 $4329
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5415
;5415:	Text_PaintCenter(centerPoint, yStart + 248, scale, colorWhite, xferText, 0);
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1131937792
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 $4330
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5417
;5416:
;5417:	if (downloadSize > 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $4334
line 5418
;5418:		s = va( "%s (%d%%)", downloadName, downloadCount * 100 / downloadSize );
ADDRGP4 $4336
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 100
MULI4
ADDRLP4 0
INDIRI4
DIVI4
ARGI4
ADDRLP4 292
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 148
ADDRLP4 292
INDIRP4
ASGNP4
line 5419
;5419:	} else {
ADDRGP4 $4335
JUMPV
LABELV $4334
line 5420
;5420:		s = downloadName;
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
line 5421
;5421:	}
LABELV $4335
line 5423
;5422:
;5423:	Text_PaintCenter(centerPoint, yStart+136, scale, colorWhite, s, 0);
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1124597760
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 148
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5425
;5424:
;5425:	UI_ReadableSize( dlSizeBuf,		sizeof dlSizeBuf,		downloadCount );
ADDRLP4 12
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 UI_ReadableSize
CALLV
pop
line 5426
;5426:	UI_ReadableSize( totalSizeBuf,	sizeof totalSizeBuf,	downloadSize );
ADDRLP4 76
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 UI_ReadableSize
CALLV
pop
line 5428
;5427:
;5428:	if (downloadCount < 4096 || !downloadTime) {
ADDRLP4 4
INDIRI4
CNSTI4 4096
LTI4 $4339
ADDRLP4 140
INDIRI4
CNSTI4 0
NEI4 $4337
LABELV $4339
line 5429
;5429:		Text_PaintCenter(leftWidth, yStart+216, scale, colorWhite, "estimating", 0);
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1129840640
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 $4340
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5430
;5430:		Text_PaintCenter(leftWidth, yStart+160, scale, colorWhite, va("(%s of %s copied)", dlSizeBuf, totalSizeBuf), 0);
ADDRGP4 $4341
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 292
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1126170624
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 292
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5431
;5431:	} else {
ADDRGP4 $4338
JUMPV
LABELV $4337
line 5432
;5432:		if ((uiInfo.uiDC.realTime - downloadTime) / 1000) {
ADDRGP4 uiInfo+208
INDIRI4
ADDRLP4 140
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
CNSTI4 0
EQI4 $4342
line 5433
;5433:			xferRate = downloadCount / ((uiInfo.uiDC.realTime - downloadTime) / 1000);
ADDRLP4 144
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+208
INDIRI4
ADDRLP4 140
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
DIVI4
ASGNI4
line 5434
;5434:		} else {
ADDRGP4 $4343
JUMPV
LABELV $4342
line 5435
;5435:			xferRate = 0;
ADDRLP4 144
CNSTI4 0
ASGNI4
line 5436
;5436:		}
LABELV $4343
line 5437
;5437:		UI_ReadableSize( xferRateBuf, sizeof xferRateBuf, xferRate );
ADDRLP4 152
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 144
INDIRI4
ARGI4
ADDRGP4 UI_ReadableSize
CALLV
pop
line 5440
;5438:
;5439:		// Extrapolate estimated completion time
;5440:		if (downloadSize && xferRate) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $4346
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $4346
line 5441
;5441:			int n = downloadSize / xferRate; // estimated time for entire d/l in secs
ADDRLP4 292
ADDRLP4 0
INDIRI4
ADDRLP4 144
INDIRI4
DIVI4
ASGNI4
line 5444
;5442:
;5443:			// We do it in K (/1024) because we'd overflow around 4MB
;5444:			UI_PrintTime ( dlTimeBuf, sizeof dlTimeBuf, 
ADDRLP4 216
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 296
ADDRLP4 292
INDIRI4
ASGNI4
ADDRLP4 296
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 1024
DIVI4
ADDRLP4 296
INDIRI4
MULI4
ADDRLP4 0
INDIRI4
CNSTI4 1024
DIVI4
DIVI4
SUBI4
CNSTI4 1000
MULI4
ARGI4
ADDRGP4 UI_PrintTime
CALLV
pop
line 5447
;5445:				(n - (((downloadCount/1024) * n) / (downloadSize/1024))) * 1000);
;5446:
;5447:			Text_PaintCenter(leftWidth, yStart+216, scale, colorWhite, dlTimeBuf, 0);
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1129840640
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 216
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5448
;5448:			Text_PaintCenter(leftWidth, yStart+160, scale, colorWhite, va("(%s of %s copied)", dlSizeBuf, totalSizeBuf), 0);
ADDRGP4 $4341
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 300
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1126170624
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 300
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5449
;5449:		} else {
ADDRGP4 $4347
JUMPV
LABELV $4346
line 5450
;5450:			Text_PaintCenter(leftWidth, yStart+216, scale, colorWhite, "estimating", 0);
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1129840640
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 $4340
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5451
;5451:			if (downloadSize) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $4348
line 5452
;5452:				Text_PaintCenter(leftWidth, yStart+160, scale, colorWhite, va("(%s of %s copied)", dlSizeBuf, totalSizeBuf), 0);
ADDRGP4 $4341
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 292
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1126170624
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 292
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5453
;5453:			} else {
ADDRGP4 $4349
JUMPV
LABELV $4348
line 5454
;5454:				Text_PaintCenter(leftWidth, yStart+160, scale, colorWhite, va("(%s copied)", dlSizeBuf), 0);
ADDRGP4 $4350
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 292
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1126170624
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 292
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5455
;5455:			}
LABELV $4349
line 5456
;5456:		}
LABELV $4347
line 5458
;5457:
;5458:		if (xferRate) {
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $4351
line 5459
;5459:			Text_PaintCenter(leftWidth, yStart+272, scale, colorWhite, va("%s/Sec", xferRateBuf), 0);
ADDRGP4 $4353
ARGP4
ADDRLP4 152
ARGP4
ADDRLP4 292
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1132986368
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 292
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5460
;5460:		}
LABELV $4351
line 5461
;5461:	}
LABELV $4338
line 5462
;5462:}
LABELV $4327
endproc UI_DisplayDownloadInfo 304 24
export UI_DrawConnectScreen
proc UI_DrawConnectScreen 5440 32
line 5472
;5463:
;5464:/*
;5465:========================
;5466:UI_DrawConnectScreen
;5467:
;5468:This will also be overlaid on the cgame info screen during loading
;5469:to prevent it from blinking away too rapidly on local or lan games.
;5470:========================
;5471:*/
;5472:void UI_DrawConnectScreen( qboolean overlay ) {
line 5479
;5473:	char			*s;
;5474:	uiClientState_t	cstate;
;5475:	char			info[MAX_INFO_VALUE];
;5476:	char text[256];
;5477:	float centerPoint, yStart, scale;
;5478:	
;5479:	menuDef_t *menu = Menus_FindByName("Connect");
ADDRGP4 $4355
ARGP4
ADDRLP4 4384
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRLP4 4120
ADDRLP4 4384
INDIRP4
ASGNP4
line 5482
;5480:
;5481:
;5482:	if ( !overlay && menu ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $4356
ADDRLP4 4120
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $4356
line 5483
;5483:		Menu_Paint(menu, qtrue);
ADDRLP4 4120
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_Paint
CALLV
pop
line 5484
;5484:	}
LABELV $4356
line 5486
;5485:
;5486:	if (!overlay) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $4358
line 5487
;5487:		centerPoint = 320;
ADDRLP4 3084
CNSTF4 1134559232
ASGNF4
line 5488
;5488:		yStart = 130;
ADDRLP4 3092
CNSTF4 1124204544
ASGNF4
line 5489
;5489:		scale = 0.5f;
ADDRLP4 3088
CNSTF4 1056964608
ASGNF4
line 5490
;5490:	} else {
ADDRGP4 $4359
JUMPV
LABELV $4358
line 5491
;5491:		centerPoint = 320;
ADDRLP4 3084
CNSTF4 1134559232
ASGNF4
line 5492
;5492:		yStart = 32;
ADDRLP4 3092
CNSTF4 1107296256
ASGNF4
line 5493
;5493:		scale = 0.6f;
ADDRLP4 3088
CNSTF4 1058642330
ASGNF4
line 5494
;5494:		return;
ADDRGP4 $4354
JUMPV
LABELV $4359
line 5498
;5495:	}
;5496:
;5497:	// see what information we should display
;5498:	trap_GetClientState( &cstate );
ADDRLP4 0
ARGP4
ADDRGP4 trap_GetClientState
CALLV
pop
line 5500
;5499:
;5500:	info[0] = '\0';
ADDRLP4 3096
CNSTI1 0
ASGNI1
line 5501
;5501:	if( trap_GetConfigString( CS_SERVERINFO, info, sizeof(info) ) ) {
CNSTI4 0
ARGI4
ADDRLP4 3096
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4388
ADDRGP4 trap_GetConfigString
CALLI4
ASGNI4
ADDRLP4 4388
INDIRI4
CNSTI4 0
EQI4 $4360
line 5502
;5502:		Text_PaintCenter(centerPoint, yStart, scale, colorWhite, va( "Loading %s", Info_ValueForKey( info, "mapname" )), 0);
ADDRLP4 3096
ARGP4
ADDRGP4 $3044
ARGP4
ADDRLP4 4392
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $4362
ARGP4
ADDRLP4 4392
INDIRP4
ARGP4
ADDRLP4 4396
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 3084
INDIRF4
ARGF4
ADDRLP4 3092
INDIRF4
ARGF4
ADDRLP4 3088
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 4396
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5503
;5503:	}
LABELV $4360
line 5505
;5504:
;5505:	if (!Q_stricmp(cstate.servername,"localhost")) {
ADDRLP4 0+12
ARGP4
ADDRGP4 $4366
ARGP4
ADDRLP4 4392
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4392
INDIRI4
CNSTI4 0
NEI4 $4363
line 5506
;5506:		Text_PaintCenter(centerPoint, yStart + 48, scale, colorWhite, va("Starting up..."), ITEM_TEXTSTYLE_SHADOWEDMORE);
ADDRGP4 $4367
ARGP4
ADDRLP4 4396
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 3084
INDIRF4
ARGF4
ADDRLP4 3092
INDIRF4
CNSTF4 1111490560
ADDF4
ARGF4
ADDRLP4 3088
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 4396
INDIRP4
ARGP4
CNSTF4 1086324736
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5507
;5507:	} else {
ADDRGP4 $4364
JUMPV
LABELV $4363
line 5508
;5508:		strcpy(text, va("Connecting to %s", cstate.servername));
ADDRGP4 $4368
ARGP4
ADDRLP4 0+12
ARGP4
ADDRLP4 4396
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4124
ARGP4
ADDRLP4 4396
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 5509
;5509:		Text_PaintCenter(centerPoint, yStart + 48, scale, colorWhite,text , ITEM_TEXTSTYLE_SHADOWEDMORE);
ADDRLP4 3084
INDIRF4
ARGF4
ADDRLP4 3092
INDIRF4
CNSTF4 1111490560
ADDF4
ARGF4
ADDRLP4 3088
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 4124
ARGP4
CNSTF4 1086324736
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5510
;5510:	}
LABELV $4364
line 5513
;5511:
;5512:	// display global MOTD at bottom
;5513:	Text_PaintCenter(centerPoint, 600, scale, colorWhite, Info_ValueForKey( cstate.updateInfoString, "motd" ), 0);
ADDRLP4 0+1036
ARGP4
ADDRGP4 $4371
ARGP4
ADDRLP4 4396
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 3084
INDIRF4
ARGF4
CNSTF4 1142292480
ARGF4
ADDRLP4 3088
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 4396
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5515
;5514:	// print any server info (server full, bad version, etc)
;5515:	if ( cstate.connState < CA_CONNECTED ) {
ADDRLP4 0
INDIRI4
CNSTI4 5
GEI4 $4372
line 5516
;5516:		Text_PaintCenter_AutoWrapped(centerPoint, yStart + 176, 630, 20, scale, colorWhite, cstate.messageString, 0);
ADDRLP4 3084
INDIRF4
ARGF4
ADDRLP4 3092
INDIRF4
CNSTF4 1127219200
ADDF4
ARGF4
CNSTF4 1142784000
ARGF4
CNSTF4 1101004800
ARGF4
ADDRLP4 3088
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 0+2060
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter_AutoWrapped
CALLV
pop
line 5517
;5517:	}
LABELV $4372
line 5519
;5518:
;5519:	if ( lastConnState > cstate.connState ) {
ADDRGP4 lastConnState
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $4375
line 5520
;5520:		lastLoadingText[0] = '\0';
ADDRGP4 lastLoadingText
CNSTI1 0
ASGNI1
line 5521
;5521:	}
LABELV $4375
line 5522
;5522:	lastConnState = cstate.connState;
ADDRGP4 lastConnState
ADDRLP4 0
INDIRI4
ASGNI4
line 5524
;5523:
;5524:	switch ( cstate.connState ) {
ADDRLP4 4400
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 4400
INDIRI4
CNSTI4 3
LTI4 $4354
ADDRLP4 4400
INDIRI4
CNSTI4 7
GTI4 $4354
ADDRLP4 4400
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $4393-12
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $4393
address $4380
address $4383
address $4386
address $4354
address $4354
code
LABELV $4380
line 5526
;5525:	case CA_CONNECTING:
;5526:		s = va("Awaiting connection...%i", cstate.connectPacketCount);
ADDRGP4 $4381
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 4408
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4380
ADDRLP4 4408
INDIRP4
ASGNP4
line 5527
;5527:		break;
ADDRGP4 $4378
JUMPV
LABELV $4383
line 5529
;5528:	case CA_CHALLENGING:
;5529:		s = va("Awaiting challenge...%i", cstate.connectPacketCount);
ADDRGP4 $4384
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 4412
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4380
ADDRLP4 4412
INDIRP4
ASGNP4
line 5530
;5530:		break;
ADDRGP4 $4378
JUMPV
LABELV $4386
line 5531
;5531:	case CA_CONNECTED: {
line 5534
;5532:		char downloadName[MAX_INFO_VALUE];
;5533:
;5534:			trap_Cvar_VariableStringBuffer( "cl_downloadName", downloadName, sizeof(downloadName) );
ADDRGP4 $4387
ARGP4
ADDRLP4 4416
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 5535
;5535:			if (*downloadName) {
ADDRLP4 4416
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $4388
line 5536
;5536:				UI_DisplayDownloadInfo( downloadName, centerPoint, yStart, scale );
ADDRLP4 4416
ARGP4
ADDRLP4 3084
INDIRF4
ARGF4
ADDRLP4 3092
INDIRF4
ARGF4
ADDRLP4 3088
INDIRF4
ARGF4
ADDRGP4 UI_DisplayDownloadInfo
CALLV
pop
line 5537
;5537:				return;
ADDRGP4 $4354
JUMPV
LABELV $4388
line 5539
;5538:			}
;5539:		}
line 5540
;5540:		s = "Awaiting gamestate...";
ADDRLP4 4380
ADDRGP4 $4390
ASGNP4
line 5541
;5541:		break;
line 5543
;5542:	case CA_LOADING:
;5543:		return;
line 5545
;5544:	case CA_PRIMED:
;5545:		return;
line 5547
;5546:	default:
;5547:		return;
LABELV $4378
line 5551
;5548:	}
;5549:
;5550:
;5551:	if (Q_stricmp(cstate.servername,"localhost")) {
ADDRLP4 0+12
ARGP4
ADDRGP4 $4366
ARGP4
ADDRLP4 4408
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4408
INDIRI4
CNSTI4 0
EQI4 $4395
line 5552
;5552:		Text_PaintCenter(centerPoint, yStart + 80, scale, colorWhite, s, 0);
ADDRLP4 3084
INDIRF4
ARGF4
ADDRLP4 3092
INDIRF4
CNSTF4 1117782016
ADDF4
ARGF4
ADDRLP4 3088
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 4380
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5553
;5553:	}
LABELV $4395
line 5556
;5554:
;5555:	// password required / connection rejected information goes here
;5556:}
LABELV $4354
endproc UI_DrawConnectScreen 5440 32
data
align 4
LABELV cvarTable
address ui_ffa_fraglimit
address $4399
address $673
byte 4 1
address ui_ffa_timelimit
address $4400
address $369
byte 4 1
address ui_tourney_fraglimit
address $4401
address $369
byte 4 1
address ui_tourney_timelimit
address $4402
address $674
byte 4 1
address ui_team_fraglimit
address $4403
address $369
byte 4 1
address ui_team_timelimit
address $4404
address $673
byte 4 1
address ui_team_friendly
address $4405
address $372
byte 4 1
address ui_ctf_capturelimit
address $4406
address $4407
byte 4 1
address ui_ctf_timelimit
address $4408
address $671
byte 4 1
address ui_ctf_friendly
address $4409
address $369
byte 4 1
address ui_arenasFile
address $4410
address $110
byte 4 80
address ui_botsFile
address $4411
address $110
byte 4 80
address ui_spScores1
address $4412
address $110
byte 4 65
address ui_spScores2
address $4413
address $110
byte 4 65
address ui_spScores3
address $4414
address $110
byte 4 65
address ui_spScores4
address $4415
address $110
byte 4 65
address ui_spScores5
address $4416
address $110
byte 4 65
address ui_spAwards
address $4417
address $110
byte 4 65
address ui_spVideos
address $4418
address $110
byte 4 65
address ui_spSkill
address $806
address $2203
byte 4 1
address ui_spSelection
address $4419
address $110
byte 4 64
address ui_browserMaster
address $4420
address $369
byte 4 1
address ui_browserGameType
address $4421
address $369
byte 4 1
address ui_browserSortKey
address $4422
address $2738
byte 4 1
address ui_browserShowFull
address $4423
address $372
byte 4 1
address ui_browserShowEmpty
address $4424
address $372
byte 4 1
address ui_brassTime
address $2296
address $4425
byte 4 1
address ui_drawCrosshair
address $2010
address $2738
byte 4 1
address ui_drawCrosshairNames
address $4426
address $372
byte 4 1
address ui_marks
address $4427
address $372
byte 4 1
address ui_server1
address $4428
address $110
byte 4 1
address ui_server2
address $4429
address $110
byte 4 1
address ui_server3
address $4430
address $110
byte 4 1
address ui_server4
address $4431
address $110
byte 4 1
address ui_server5
address $4432
address $110
byte 4 1
address ui_server6
address $4433
address $110
byte 4 1
address ui_server7
address $4434
address $110
byte 4 1
address ui_server8
address $4435
address $110
byte 4 1
address ui_server9
address $4436
address $110
byte 4 1
address ui_server10
address $4437
address $110
byte 4 1
address ui_server11
address $4438
address $110
byte 4 1
address ui_server12
address $4439
address $110
byte 4 1
address ui_server13
address $4440
address $110
byte 4 1
address ui_server14
address $4441
address $110
byte 4 1
address ui_server15
address $4442
address $110
byte 4 1
address ui_server16
address $4443
address $110
byte 4 1
address ui_cdkeychecked
address $4444
address $369
byte 4 64
address ui_new
address $4445
address $369
byte 4 256
address ui_debug
address $4446
address $369
byte 4 256
address ui_initialized
address $4447
address $369
byte 4 256
address ui_teamName
address $680
address $4448
byte 4 1
address ui_opponentName
address $1077
address $4449
byte 4 1
address ui_redteam
address $4450
address $4448
byte 4 1
address ui_blueteam
address $4451
address $4449
byte 4 1
address ui_dedicated
address $4452
address $369
byte 4 1
address ui_gameType
address $4453
address $4454
byte 4 1
address ui_joinGameType
address $4455
address $369
byte 4 1
address ui_netGameType
address $4456
address $4454
byte 4 1
address ui_actualNetGameType
address $4457
address $4454
byte 4 1
address ui_redteam1
address $4458
address $369
byte 4 1
address ui_redteam2
address $4459
address $369
byte 4 1
address ui_redteam3
address $4460
address $369
byte 4 1
address ui_redteam4
address $4461
address $369
byte 4 1
address ui_redteam5
address $4462
address $369
byte 4 1
address ui_blueteam1
address $4463
address $369
byte 4 1
address ui_blueteam2
address $4464
address $369
byte 4 1
address ui_blueteam3
address $4465
address $369
byte 4 1
address ui_blueteam4
address $4466
address $369
byte 4 1
address ui_blueteam5
address $4467
address $369
byte 4 1
address ui_netSource
address $1927
address $369
byte 4 1
address ui_menuFiles
address $650
address $622
byte 4 1
address ui_currentTier
address $999
address $369
byte 4 1
address ui_currentMap
address $873
address $369
byte 4 1
address ui_currentNetMap
address $871
address $369
byte 4 1
address ui_mapIndex
address $2163
address $369
byte 4 1
address ui_currentOpponent
address $4468
address $369
byte 4 1
address ui_selectedPlayer
address $1362
address $369
byte 4 1
address ui_selectedPlayerName
address $1370
address $110
byte 4 1
address ui_lastServerRefresh_0
address $4469
address $110
byte 4 1
address ui_lastServerRefresh_1
address $4470
address $110
byte 4 1
address ui_lastServerRefresh_2
address $4471
address $110
byte 4 1
address ui_lastServerRefresh_3
address $4472
address $110
byte 4 1
address ui_singlePlayerActive
address $2176
address $369
byte 4 0
address ui_scoreAccuracy
address $4473
address $369
byte 4 1
address ui_scoreImpressives
address $4474
address $369
byte 4 1
address ui_scoreExcellents
address $4475
address $369
byte 4 1
address ui_scoreCaptures
address $4476
address $369
byte 4 1
address ui_scoreDefends
address $4477
address $369
byte 4 1
address ui_scoreAssists
address $4478
address $369
byte 4 1
address ui_scoreGauntlets
address $4479
address $369
byte 4 1
address ui_scoreScore
address $4480
address $369
byte 4 1
address ui_scorePerfect
address $4481
address $369
byte 4 1
address ui_scoreTeam
address $4482
address $4483
byte 4 1
address ui_scoreBase
address $4484
address $369
byte 4 1
address ui_scoreTime
address $4485
address $4486
byte 4 1
address ui_scoreTimeBonus
address $4487
address $369
byte 4 1
address ui_scoreSkillBonus
address $4488
address $369
byte 4 1
address ui_scoreShutoutBonus
address $4489
address $369
byte 4 1
address ui_fragLimit
address $696
address $675
byte 4 0
address ui_captureLimit
address $694
address $676
byte 4 0
address ui_smallFont
address $4490
address $4491
byte 4 1
address ui_bigFont
address $4492
address $4493
byte 4 1
address ui_findPlayer
address $3132
address $4494
byte 4 1
address ui_Q3Model
address $4495
address $369
byte 4 1
address ui_hudFiles
address $4496
address $4497
byte 4 1
address ui_recordSPDemo
address $2195
address $369
byte 4 1
address ui_teamArenaFirstRun
address $4498
address $369
byte 4 1
address ui_realWarmUp
address $2187
address $673
byte 4 1
address ui_realCaptureLimit
address $697
address $4407
byte 4 1029
address ui_serverStatusTimeOut
address $4499
address $4500
byte 4 1
align 4
LABELV cvarTableSize
byte 4 110
export UI_RegisterCvars
code
proc UI_RegisterCvars 12 16
line 5594
;5557:
;5558:
;5559:/*
;5560:================
;5561:cvars
;5562:================
;5563:*/
;5564:
;5565:typedef struct {
;5566:	vmCvar_t	*vmCvar;
;5567:	char		*cvarName;
;5568:	char		*defaultString;
;5569:	int			cvarFlags;
;5570:} cvarTable_t;
;5571:
;5572:#define DECLARE_UI_CVAR
;5573:	#include "ui_cvar.h"
;5574:#undef DECLARE_UI_CVAR
;5575:
;5576:// bk001129 - made static to avoid aliasing
;5577:static cvarTable_t		cvarTable[] = {
;5578:
;5579:#define UI_CVAR_LIST
;5580:	#include "ui_cvar.h"
;5581:#undef UI_CVAR_LIST
;5582:
;5583:};
;5584:
;5585:// bk001129 - made static to avoid aliasing
;5586:static int		cvarTableSize = sizeof(cvarTable) / sizeof(cvarTable[0]);
;5587:
;5588:
;5589:/*
;5590:=================
;5591:UI_RegisterCvars
;5592:=================
;5593:*/
;5594:void UI_RegisterCvars( void ) {
line 5598
;5595:	int			i;
;5596:	cvarTable_t	*cv;
;5597:
;5598:	for ( i = 0, cv = cvarTable ; i < cvarTableSize ; i++, cv++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 cvarTable
ASGNP4
ADDRGP4 $4505
JUMPV
LABELV $4502
line 5599
;5599:		trap_Cvar_Register( cv->vmCvar, cv->cvarName, cv->defaultString, cv->cvarFlags );
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5600
;5600:	}
LABELV $4503
line 5598
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
LABELV $4505
ADDRLP4 4
INDIRI4
ADDRGP4 cvarTableSize
INDIRI4
LTI4 $4502
line 5601
;5601:}
LABELV $4501
endproc UI_RegisterCvars 12 16
export UI_UpdateCvars
proc UI_UpdateCvars 8 4
line 5608
;5602:
;5603:/*
;5604:=================
;5605:UI_UpdateCvars
;5606:=================
;5607:*/
;5608:void UI_UpdateCvars( void ) {
line 5612
;5609:	int			i;
;5610:	cvarTable_t	*cv;
;5611:
;5612:	for ( i = 0, cv = cvarTable ; i < cvarTableSize ; i++, cv++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRLP4 4
ADDRGP4 cvarTable
ASGNP4
ADDRGP4 $4510
JUMPV
LABELV $4507
line 5613
;5613:		trap_Cvar_Update( cv->vmCvar );
ADDRLP4 4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 5614
;5614:	}
LABELV $4508
line 5612
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
LABELV $4510
ADDRLP4 0
INDIRI4
ADDRGP4 cvarTableSize
INDIRI4
LTI4 $4507
line 5615
;5615:}
LABELV $4506
endproc UI_UpdateCvars 8 4
export UI_VideoCheck
proc UI_VideoCheck 12 4
line 5624
;5616:
;5617:
;5618:/*
;5619:=================
;5620:UI_VideoCheck
;5621:=================
;5622:*/
;5623:void UI_VideoCheck( int time ) 
;5624:{
line 5625
;5625:	if ( abs( time - uiInfo.uiDC.lastVideoCheck ) > 1000 ) {
ADDRFP4 0
INDIRI4
ADDRGP4 uiInfo+73424
INDIRI4
SUBI4
ARGI4
ADDRLP4 0
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1000
LEI4 $4512
line 5628
;5626:		
;5627:		int oldWidth, oldHeight;
;5628:		oldWidth = uiInfo.uiDC.glconfig.vidWidth;
ADDRLP4 4
ADDRGP4 uiInfo+62044+11304
INDIRI4
ASGNI4
line 5629
;5629:		oldHeight = uiInfo.uiDC.glconfig.vidHeight;
ADDRLP4 8
ADDRGP4 uiInfo+62044+11308
INDIRI4
ASGNI4
line 5631
;5630:
;5631:		trap_GetGlconfig( &uiInfo.uiDC.glconfig );
ADDRGP4 uiInfo+62044
ARGP4
ADDRGP4 trap_GetGlconfig
CALLV
pop
line 5633
;5632:
;5633:		if ( uiInfo.uiDC.glconfig.vidWidth != oldWidth || uiInfo.uiDC.glconfig.vidHeight != oldHeight ) {
ADDRGP4 uiInfo+62044+11304
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $4526
ADDRGP4 uiInfo+62044+11308
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $4520
LABELV $4526
line 5634
;5634:			uiInfo.uiDC.biasY = 0.0;
ADDRGP4 uiInfo+73400
CNSTF4 0
ASGNF4
line 5635
;5635:			uiInfo.uiDC.biasX = 0.0;
ADDRGP4 uiInfo+73396
CNSTF4 0
ASGNF4
line 5637
;5636:			// for 640x480 virtualized screen
;5637:			if ( uiInfo.uiDC.glconfig.vidWidth * 480 > uiInfo.uiDC.glconfig.vidHeight * 640 ) {
ADDRGP4 uiInfo+62044+11304
INDIRI4
CNSTI4 480
MULI4
ADDRGP4 uiInfo+62044+11308
INDIRI4
CNSTI4 640
MULI4
LEI4 $4529
line 5639
;5638:				// wide screen, scale by height
;5639:				uiInfo.uiDC.scale = uiInfo.uiDC.glconfig.vidHeight * (1.0/480.0);
ADDRGP4 uiInfo+73392
ADDRGP4 uiInfo+62044+11308
INDIRI4
CVIF4 4
CNSTF4 990414985
MULF4
ASGNF4
line 5640
;5640:				uiInfo.uiDC.biasX = 0.5 * ( uiInfo.uiDC.glconfig.vidWidth - ( uiInfo.uiDC.glconfig.vidHeight * (640.0/480.0) ) );
ADDRGP4 uiInfo+73396
ADDRGP4 uiInfo+62044+11304
INDIRI4
CVIF4 4
ADDRGP4 uiInfo+62044+11308
INDIRI4
CVIF4 4
CNSTF4 1068149419
MULF4
SUBF4
CNSTF4 1056964608
MULF4
ASGNF4
line 5641
;5641:			} else {
ADDRGP4 $4530
JUMPV
LABELV $4529
line 5643
;5642:				// no wide screen, scale by width
;5643:				uiInfo.uiDC.scale = uiInfo.uiDC.glconfig.vidWidth * (1.0/640.0);
ADDRGP4 uiInfo+73392
ADDRGP4 uiInfo+62044+11304
INDIRI4
CVIF4 4
CNSTF4 986500301
MULF4
ASGNF4
line 5644
;5644:				uiInfo.uiDC.biasY = 0.5 * ( uiInfo.uiDC.glconfig.vidHeight - ( uiInfo.uiDC.glconfig.vidWidth * (480.0/640) ) );
ADDRGP4 uiInfo+73400
ADDRGP4 uiInfo+62044+11308
INDIRI4
CVIF4 4
ADDRGP4 uiInfo+62044+11304
INDIRI4
CVIF4 4
CNSTF4 1061158912
MULF4
SUBF4
CNSTF4 1056964608
MULF4
ASGNF4
line 5645
;5645:			}
LABELV $4530
line 5647
;5646:
;5647:			uiInfo.uiDC.screenXmin = 0.0 - (uiInfo.uiDC.biasX / uiInfo.uiDC.scale);
ADDRGP4 uiInfo+73408
CNSTF4 0
ADDRGP4 uiInfo+73396
INDIRF4
ADDRGP4 uiInfo+73392
INDIRF4
DIVF4
SUBF4
ASGNF4
line 5648
;5648:			uiInfo.uiDC.screenXmax = 640.0 + (uiInfo.uiDC.biasX / uiInfo.uiDC.scale);
ADDRGP4 uiInfo+73412
ADDRGP4 uiInfo+73396
INDIRF4
ADDRGP4 uiInfo+73392
INDIRF4
DIVF4
CNSTF4 1142947840
ADDF4
ASGNF4
line 5650
;5649:
;5650:			uiInfo.uiDC.screenYmin = 0.0 - (uiInfo.uiDC.biasY / uiInfo.uiDC.scale);
ADDRGP4 uiInfo+73416
CNSTF4 0
ADDRGP4 uiInfo+73400
INDIRF4
ADDRGP4 uiInfo+73392
INDIRF4
DIVF4
SUBF4
ASGNF4
line 5651
;5651:			uiInfo.uiDC.screenYmax = 480.0 + (uiInfo.uiDC.biasY / uiInfo.uiDC.scale);
ADDRGP4 uiInfo+73420
ADDRGP4 uiInfo+73400
INDIRF4
ADDRGP4 uiInfo+73392
INDIRF4
DIVF4
CNSTF4 1139802112
ADDF4
ASGNF4
line 5653
;5652:
;5653:			uiInfo.uiDC.cursorScaleR = 1.0 / uiInfo.uiDC.scale;
ADDRGP4 uiInfo+73404
CNSTF4 1065353216
ADDRGP4 uiInfo+73392
INDIRF4
DIVF4
ASGNF4
line 5654
;5654:			if ( uiInfo.uiDC.cursorScaleR < 0.5 ) {
ADDRGP4 uiInfo+73404
INDIRF4
CNSTF4 1056964608
GEF4 $4565
line 5655
;5655:				uiInfo.uiDC.cursorScaleR = 0.5;
ADDRGP4 uiInfo+73404
CNSTF4 1056964608
ASGNF4
line 5656
;5656:			}
LABELV $4565
line 5657
;5657:		}
LABELV $4520
line 5659
;5658:
;5659:		uiInfo.uiDC.lastVideoCheck = time;
ADDRGP4 uiInfo+73424
ADDRFP4 0
INDIRI4
ASGNI4
line 5660
;5660:	}
LABELV $4512
line 5661
;5661:}
LABELV $4511
endproc UI_VideoCheck 12 4
proc UI_StopServerRefresh 12 12
line 5670
;5662:
;5663:
;5664:/*
;5665:=================
;5666:ArenaServers_StopRefresh
;5667:=================
;5668:*/
;5669:static void UI_StopServerRefresh( void )
;5670:{
line 5673
;5671:	int count;
;5672:
;5673:	if (!uiInfo.serverStatus.refreshActive) {
ADDRGP4 uiInfo+99276+2212
INDIRI4
CNSTI4 0
NEI4 $4571
line 5675
;5674:		// not currently refreshing
;5675:		return;
ADDRGP4 $4570
JUMPV
LABELV $4571
line 5677
;5676:	}
;5677:	uiInfo.serverStatus.refreshActive = qfalse;
ADDRGP4 uiInfo+99276+2212
CNSTI4 0
ASGNI4
line 5678
;5678:	Com_Printf("%d servers listed in browser with %d players.\n",
ADDRGP4 $4577
ARGP4
ADDRGP4 uiInfo+99276+10412
INDIRI4
ARGI4
ADDRGP4 uiInfo+99276+10416
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 5681
;5679:					uiInfo.serverStatus.numDisplayServers,
;5680:					uiInfo.serverStatus.numPlayersOnServers);
;5681:	count = trap_LAN_GetServerCount(ui_netSource.integer);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 5682
;5682:	if (count - uiInfo.serverStatus.numDisplayServers > 0) {
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+99276+10412
INDIRI4
SUBI4
CNSTI4 0
LEI4 $4583
line 5683
;5683:		Com_Printf("%d servers not listed due to packet loss or pings higher than %d\n",
ADDRGP4 $4590
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRGP4 $4587
ARGP4
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+99276+10412
INDIRI4
SUBI4
ARGI4
ADDRLP4 8
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 5686
;5684:						count - uiInfo.serverStatus.numDisplayServers,
;5685:						(int) trap_Cvar_VariableValue("cl_maxPing"));
;5686:	}
LABELV $4583
line 5688
;5687:
;5688:}
LABELV $4570
endproc UI_StopServerRefresh 12 12
proc UI_DoServerRefresh 8 4
line 5697
;5689:
;5690:
;5691:/*
;5692:=================
;5693:UI_DoServerRefresh
;5694:=================
;5695:*/
;5696:static void UI_DoServerRefresh( void )
;5697:{
line 5698
;5698:	qboolean wait = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 5700
;5699:
;5700:	if (!uiInfo.serverStatus.refreshActive) {
ADDRGP4 uiInfo+99276+2212
INDIRI4
CNSTI4 0
NEI4 $4592
line 5701
;5701:		return;
ADDRGP4 $4591
JUMPV
LABELV $4592
line 5703
;5702:	}
;5703:	if (ui_netSource.integer != AS_FAVORITES) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 3
EQI4 $4596
line 5704
;5704:		if (ui_netSource.integer == AS_LOCAL) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
NEI4 $4599
line 5705
;5705:			if (!trap_LAN_GetServerCount(ui_netSource.integer)) {
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $4600
line 5706
;5706:				wait = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 5707
;5707:			}
line 5708
;5708:		} else {
ADDRGP4 $4600
JUMPV
LABELV $4599
line 5709
;5709:			if (trap_LAN_GetServerCount(ui_netSource.integer) < 0) {
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $4605
line 5710
;5710:				wait = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 5711
;5711:			}
LABELV $4605
line 5712
;5712:		}
LABELV $4600
line 5713
;5713:	}
LABELV $4596
line 5715
;5714:
;5715:	if (uiInfo.uiDC.realTime < uiInfo.serverStatus.refreshtime) {
ADDRGP4 uiInfo+208
INDIRI4
ADDRGP4 uiInfo+99276+2192
INDIRI4
GEI4 $4608
line 5716
;5716:		if (wait) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $4613
line 5717
;5717:			return;
ADDRGP4 $4591
JUMPV
LABELV $4613
line 5719
;5718:		}
;5719:	}
LABELV $4608
line 5722
;5720:
;5721:	// if still trying to retrieve pings
;5722:	if (trap_LAN_UpdateVisiblePings(ui_netSource.integer)) {
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 trap_LAN_UpdateVisiblePings
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $4615
line 5723
;5723:		uiInfo.serverStatus.refreshtime = uiInfo.uiDC.realTime + 1000;
ADDRGP4 uiInfo+99276+2192
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 5724
;5724:	} else if (!wait) {
ADDRGP4 $4616
JUMPV
LABELV $4615
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $4621
line 5726
;5725:		// get the last servers in the list
;5726:		UI_BuildServerDisplayList(2);
CNSTI4 2
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 5728
;5727:		// stop the refresh
;5728:		UI_StopServerRefresh();
ADDRGP4 UI_StopServerRefresh
CALLV
pop
line 5729
;5729:	}
LABELV $4621
LABELV $4616
line 5731
;5730:	//
;5731:	UI_BuildServerDisplayList(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 5732
;5732:}
LABELV $4591
endproc UI_DoServerRefresh 8 4
proc UI_StartServerRefresh 68 24
line 5740
;5733:
;5734:/*
;5735:=================
;5736:UI_StartServerRefresh
;5737:=================
;5738:*/
;5739:static void UI_StartServerRefresh(qboolean full)
;5740:{
line 5745
;5741:	int		i;
;5742:	char	*ptr;
;5743:
;5744:	qtime_t q;
;5745:	trap_RealTime(&q);
ADDRLP4 0
ARGP4
ADDRGP4 trap_RealTime
CALLI4
pop
line 5746
;5746: 	trap_Cvar_Set( va("ui_lastServerRefresh_%i", ui_netSource.integer), va("%s-%i, %i at %i:%i", MonthAbbrev[q.tm_mon],q.tm_mday, 1900+q.tm_year,q.tm_hour,q.tm_min));
ADDRGP4 $1285
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $4625
ARGP4
ADDRLP4 0+16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 MonthAbbrev
ADDP4
INDIRP4
ARGP4
ADDRLP4 0+12
INDIRI4
ARGI4
ADDRLP4 0+20
INDIRI4
CNSTI4 1900
ADDI4
ARGI4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5748
;5747:
;5748:	if (!full) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $4631
line 5749
;5749:		UI_UpdatePendingPings();
ADDRGP4 UI_UpdatePendingPings
CALLV
pop
line 5750
;5750:		return;
ADDRGP4 $4623
JUMPV
LABELV $4631
line 5753
;5751:	}
;5752:
;5753:	uiInfo.serverStatus.refreshActive = qtrue;
ADDRGP4 uiInfo+99276+2212
CNSTI4 1
ASGNI4
line 5754
;5754:	uiInfo.serverStatus.nextDisplayRefresh = uiInfo.uiDC.realTime + 1000;
ADDRGP4 uiInfo+99276+10420
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 5756
;5755:	// clear number of displayed servers
;5756:	uiInfo.serverStatus.numDisplayServers = 0;
ADDRGP4 uiInfo+99276+10412
CNSTI4 0
ASGNI4
line 5757
;5757:	uiInfo.serverStatus.numPlayersOnServers = 0;
ADDRGP4 uiInfo+99276+10416
CNSTI4 0
ASGNI4
line 5759
;5758:	// mark all servers as visible so we store ping updates for them
;5759:	trap_LAN_MarkServerVisible(ui_netSource.integer, -1, qtrue);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_LAN_MarkServerVisible
CALLV
pop
line 5761
;5760:	// reset all the pings
;5761:	trap_LAN_ResetPings(ui_netSource.integer);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 trap_LAN_ResetPings
CALLV
pop
line 5763
;5762:	//
;5763:	if( ui_netSource.integer == AS_LOCAL ) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
NEI4 $4644
line 5764
;5764:		trap_Cmd_ExecuteText( EXEC_NOW, "localservers\n" );
CNSTI4 0
ARGI4
ADDRGP4 $4647
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 5765
;5765:		uiInfo.serverStatus.refreshtime = uiInfo.uiDC.realTime + 1000;
ADDRGP4 uiInfo+99276+2192
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 5766
;5766:		return;
ADDRGP4 $4623
JUMPV
LABELV $4644
line 5769
;5767:	}
;5768:
;5769:	uiInfo.serverStatus.refreshtime = uiInfo.uiDC.realTime + 5000;
ADDRGP4 uiInfo+99276+2192
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 5770
;5770:	if( ui_netSource.integer == AS_GLOBAL || ui_netSource.integer == AS_MPLAYER ) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 2
EQI4 $4658
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 1
NEI4 $4654
LABELV $4658
line 5771
;5771:		if( ui_netSource.integer == AS_GLOBAL ) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 2
NEI4 $4659
line 5772
;5772:			i = 0;
ADDRLP4 40
CNSTI4 0
ASGNI4
line 5773
;5773:		}
ADDRGP4 $4660
JUMPV
LABELV $4659
line 5774
;5774:		else {
line 5775
;5775:			i = 1;
ADDRLP4 40
CNSTI4 1
ASGNI4
line 5776
;5776:		}
LABELV $4660
line 5778
;5777:
;5778:		ptr = UI_Cvar_VariableString("debug_protocol");
ADDRGP4 $4208
ARGP4
ADDRLP4 52
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 36
ADDRLP4 52
INDIRP4
ASGNP4
line 5779
;5779:		if (strlen(ptr)) {
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 56
INDIRU4
CNSTU4 0
EQU4 $4662
line 5780
;5780:			trap_Cmd_ExecuteText( EXEC_NOW, va( "globalservers %d %s full empty\n", i, ptr));
ADDRGP4 $4664
ARGP4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 0
ARGI4
ADDRLP4 60
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 5781
;5781:		}
ADDRGP4 $4663
JUMPV
LABELV $4662
line 5782
;5782:		else {
line 5783
;5783:			trap_Cmd_ExecuteText( EXEC_NOW, va( "globalservers %d %d full empty\n", i, (int)trap_Cvar_VariableValue( "protocol" ) ) );
ADDRGP4 $2130
ARGP4
ADDRLP4 60
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRGP4 $4665
ARGP4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 60
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 64
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 0
ARGI4
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 5784
;5784:		}
LABELV $4663
line 5785
;5785:	}
LABELV $4654
line 5786
;5786:}
LABELV $4623
endproc UI_StartServerRefresh 68 24
bss
align 1
LABELV lastLoadingText
skip 1024
align 4
LABELV lastConnState
skip 4
export startTime
align 4
LABELV startTime
skip 4
import ProcessNewUI
import UI_RankStatusMenu
import RankStatus_Cache
import UI_SignupMenu
import Signup_Cache
import UI_LoginMenu
import Login_Cache
import UI_InitGameinfo
import UI_SPUnlockMedals_f
import UI_SPUnlock_f
import UI_GetAwardLevel
import UI_LogAwardData
import UI_NewGame
import UI_GetCurrentGame
import UI_CanShowTierVideo
import UI_ShowTierVideo
import UI_TierCompleted
import UI_SetBestScore
import UI_GetBestScore
import UI_GetBotNameByNumber
import UI_LoadBots
import UI_GetNumBots
import UI_GetBotInfoByName
import UI_GetBotInfoByNumber
import UI_GetNumSPTiers
import UI_GetNumSPArenas
import UI_GetNumArenas
import UI_GetSpecialArenaInfo
import UI_GetArenaInfoByMap
import UI_GetArenaInfoByNumber
import UI_NetworkOptionsMenu
import UI_NetworkOptionsMenu_Cache
import UI_SoundOptionsMenu
import UI_SoundOptionsMenu_Cache
import UI_DisplayOptionsMenu
import UI_DisplayOptionsMenu_Cache
import UI_SaveConfigMenu
import UI_SaveConfigMenu_Cache
import UI_LoadConfigMenu
import UI_LoadConfig_Cache
import UI_TeamOrdersMenu_Cache
import UI_TeamOrdersMenu_f
import UI_TeamOrdersMenu
import UI_RemoveBotsMenu
import UI_RemoveBots_Cache
import UI_AddBotsMenu
import UI_AddBots_Cache
import trap_SetPbClStatus
import trap_VerifyCDKey
import trap_R_RemapShader
import trap_RealTime
import trap_CIN_SetExtents
import trap_CIN_DrawCinematic
import trap_CIN_RunCinematic
import trap_CIN_StopCinematic
import trap_CIN_PlayCinematic
import trap_S_StartBackgroundTrack
import trap_S_StopBackgroundTrack
import trap_R_RegisterFont
import trap_SetCDKey
import trap_GetCDKey
import trap_MemoryRemaining
import trap_LAN_CompareServers
import trap_LAN_ServerStatus
import trap_LAN_ResetPings
import trap_LAN_RemoveServer
import trap_LAN_AddServer
import trap_LAN_UpdateVisiblePings
import trap_LAN_ServerIsVisible
import trap_LAN_MarkServerVisible
import trap_LAN_SaveCachedServers
import trap_LAN_LoadCachedServers
import trap_LAN_GetPingInfo
import trap_LAN_GetPing
import trap_LAN_ClearPing
import trap_LAN_GetPingQueueCount
import trap_LAN_GetServerPing
import trap_LAN_GetServerInfo
import trap_LAN_GetServerAddressString
import trap_LAN_GetServerCount
import trap_GetConfigString
import trap_GetGlconfig
import trap_GetClientState
import trap_GetClipboardData
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_ClearStates
import trap_Key_SetOverstrikeMode
import trap_Key_GetOverstrikeMode
import trap_Key_IsDown
import trap_Key_SetBinding
import trap_Key_GetBindingBuf
import trap_Key_KeynumToStringBuf
import trap_S_RegisterSound
import trap_S_StartLocalSound
import trap_CM_LerpTag
import trap_UpdateScreen
import trap_R_ModelBounds
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_AddLightToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Cmd_ExecuteText
import trap_Argv
import trap_Argc
import trap_Cvar_InfoStringBuffer
import trap_Cvar_Create
import trap_Cvar_Reset
import trap_Cvar_SetValue
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import UI_SPSkillMenu_Cache
import UI_SPSkillMenu
import UI_SPPostgameMenu_f
import UI_SPPostgameMenu_Cache
import UI_SPArena_Start
import UI_SPLevelMenu_ReInit
import UI_SPLevelMenu_f
import UI_SPLevelMenu
import UI_SPLevelMenu_Cache
import uis
import UI_LoadBestScores
import m_entersound
import UI_StartDemoLoop
import UI_Cvar_VariableString
import UI_Argv
import UI_ForceMenuOff
import UI_PopMenu
import UI_PushMenu
import UI_SetActiveMenu
import UI_IsFullscreen
import UI_DrawTextBox
import UI_AdjustFrom640
import UI_CursorInRect
import UI_DrawChar
import UI_DrawString
import UI_ProportionalStringWidth
import UI_DrawProportionalString
import UI_ProportionalSizeScale
import UI_DrawBannerString
import UI_LerpColor
import UI_SetColor
import UI_UpdateScreen
import UI_DrawSides
import UI_DrawTopBottom
import UI_DrawRect
import UI_FillRect
import UI_DrawHandlePic
import UI_DrawNamedPic
import UI_ClampCvar
import UI_ConsoleCommand
import UI_Refresh
import UI_MouseEvent
import UI_KeyEvent
import UI_Shutdown
import UI_Init
export uiInfo
align 4
LABELV uiInfo
skip 136924
import UI_RegisterClientModelname
import UI_PlayerInfo_SetInfo
import UI_PlayerInfo_SetModel
import UI_DrawPlayer
import DriverInfo_Cache
import GraphicsOptions_Cache
import UI_GraphicsOptionsMenu
import ServerInfo_Cache
import UI_ServerInfoMenu
import UI_BotSelectMenu_Cache
import UI_BotSelectMenu
import ServerOptions_Cache
import StartServer_Cache
import UI_StartServerMenu
import ArenaServers_Cache
import UI_ArenaServersMenu
import SpecifyServer_Cache
import UI_SpecifyServerMenu
import SpecifyLeague_Cache
import UI_SpecifyLeagueMenu
import Preferences_Cache
import UI_PreferencesMenu
import PlayerSettings_Cache
import UI_PlayerSettingsMenu
import PlayerModel_Cache
import UI_PlayerModelMenu
import UI_CDKeyMenu_f
import UI_CDKeyMenu_Cache
import UI_CDKeyMenu
import UI_ModsMenu_Cache
import UI_ModsMenu
import UI_CinematicsMenu_Cache
import UI_CinematicsMenu_f
import UI_CinematicsMenu
import Demos_Cache
import UI_DemosMenu
import Controls_Cache
import UI_ControlsMenu
import TeamMain_Cache
import UI_TeamMainMenu
import UI_SetupMenu
import UI_SetupMenu_Cache
import UI_ConfirmMenu
import ConfirmMenu_Cache
import UI_InGameMenu
import InGame_Cache
import UI_CreditMenu
import UI_MainMenu
import MainMenu_Cache
import UI_LoadArenas
import UI_ClearScores
import UI_AdjustTimeByGame
import MenuField_Key
import MenuField_Draw
import MenuField_Init
import MField_Draw
import MField_CharEvent
import MField_KeyDownEvent
import MField_Clear
import ui_medalSounds
import ui_medalPicNames
import ui_medalNames
import text_color_highlight
import text_color_normal
import text_color_disabled
import listbar_color
import list_color
import name_color
import color_dim
import color_red
import color_orange
import color_blue
import color_yellow
import color_white
import color_black
import menu_dim_color
import menu_black_color
import menu_red_color
import menu_highlight_color
import menu_dark_color
import menu_grayed_color
import menu_text_color
import weaponChangeSound
import menu_null_sound
import menu_buzz_sound
import menu_out_sound
import menu_move_sound
import menu_in_sound
import ScrollList_Key
import ScrollList_Draw
import Bitmap_Draw
import Bitmap_Init
import Menu_DefaultKey
import Menu_SetCursorToItem
import Menu_SetCursor
import Menu_ActivateItem
import Menu_ItemAtCursor
import Menu_Draw
import Menu_AdjustCursor
import Menu_AddItem
import Menu_Focus
import Menu_Cache
export ui_serverStatusTimeOut
align 4
LABELV ui_serverStatusTimeOut
skip 272
export ui_realCaptureLimit
align 4
LABELV ui_realCaptureLimit
skip 272
export ui_realWarmUp
align 4
LABELV ui_realWarmUp
skip 272
export ui_teamArenaFirstRun
align 4
LABELV ui_teamArenaFirstRun
skip 272
export ui_recordSPDemo
align 4
LABELV ui_recordSPDemo
skip 272
export ui_hudFiles
align 4
LABELV ui_hudFiles
skip 272
export ui_Q3Model
align 4
LABELV ui_Q3Model
skip 272
export ui_findPlayer
align 4
LABELV ui_findPlayer
skip 272
export ui_bigFont
align 4
LABELV ui_bigFont
skip 272
export ui_smallFont
align 4
LABELV ui_smallFont
skip 272
export ui_captureLimit
align 4
LABELV ui_captureLimit
skip 272
export ui_fragLimit
align 4
LABELV ui_fragLimit
skip 272
export ui_scoreShutoutBonus
align 4
LABELV ui_scoreShutoutBonus
skip 272
export ui_scoreSkillBonus
align 4
LABELV ui_scoreSkillBonus
skip 272
export ui_scoreTimeBonus
align 4
LABELV ui_scoreTimeBonus
skip 272
export ui_scoreTime
align 4
LABELV ui_scoreTime
skip 272
export ui_scoreBase
align 4
LABELV ui_scoreBase
skip 272
export ui_scoreTeam
align 4
LABELV ui_scoreTeam
skip 272
export ui_scorePerfect
align 4
LABELV ui_scorePerfect
skip 272
export ui_scoreScore
align 4
LABELV ui_scoreScore
skip 272
export ui_scoreGauntlets
align 4
LABELV ui_scoreGauntlets
skip 272
export ui_scoreAssists
align 4
LABELV ui_scoreAssists
skip 272
export ui_scoreDefends
align 4
LABELV ui_scoreDefends
skip 272
export ui_scoreCaptures
align 4
LABELV ui_scoreCaptures
skip 272
export ui_scoreExcellents
align 4
LABELV ui_scoreExcellents
skip 272
export ui_scoreImpressives
align 4
LABELV ui_scoreImpressives
skip 272
export ui_scoreAccuracy
align 4
LABELV ui_scoreAccuracy
skip 272
export ui_singlePlayerActive
align 4
LABELV ui_singlePlayerActive
skip 272
export ui_lastServerRefresh_3
align 4
LABELV ui_lastServerRefresh_3
skip 272
export ui_lastServerRefresh_2
align 4
LABELV ui_lastServerRefresh_2
skip 272
export ui_lastServerRefresh_1
align 4
LABELV ui_lastServerRefresh_1
skip 272
export ui_lastServerRefresh_0
align 4
LABELV ui_lastServerRefresh_0
skip 272
export ui_selectedPlayerName
align 4
LABELV ui_selectedPlayerName
skip 272
export ui_selectedPlayer
align 4
LABELV ui_selectedPlayer
skip 272
export ui_currentOpponent
align 4
LABELV ui_currentOpponent
skip 272
export ui_mapIndex
align 4
LABELV ui_mapIndex
skip 272
export ui_currentNetMap
align 4
LABELV ui_currentNetMap
skip 272
export ui_currentMap
align 4
LABELV ui_currentMap
skip 272
export ui_currentTier
align 4
LABELV ui_currentTier
skip 272
export ui_menuFiles
align 4
LABELV ui_menuFiles
skip 272
export ui_netSource
align 4
LABELV ui_netSource
skip 272
export ui_blueteam5
align 4
LABELV ui_blueteam5
skip 272
export ui_blueteam4
align 4
LABELV ui_blueteam4
skip 272
export ui_blueteam3
align 4
LABELV ui_blueteam3
skip 272
export ui_blueteam2
align 4
LABELV ui_blueteam2
skip 272
export ui_blueteam1
align 4
LABELV ui_blueteam1
skip 272
export ui_redteam5
align 4
LABELV ui_redteam5
skip 272
export ui_redteam4
align 4
LABELV ui_redteam4
skip 272
export ui_redteam3
align 4
LABELV ui_redteam3
skip 272
export ui_redteam2
align 4
LABELV ui_redteam2
skip 272
export ui_redteam1
align 4
LABELV ui_redteam1
skip 272
export ui_actualNetGameType
align 4
LABELV ui_actualNetGameType
skip 272
export ui_netGameType
align 4
LABELV ui_netGameType
skip 272
export ui_joinGameType
align 4
LABELV ui_joinGameType
skip 272
export ui_gameType
align 4
LABELV ui_gameType
skip 272
export ui_dedicated
align 4
LABELV ui_dedicated
skip 272
export ui_blueteam
align 4
LABELV ui_blueteam
skip 272
export ui_redteam
align 4
LABELV ui_redteam
skip 272
export ui_opponentName
align 4
LABELV ui_opponentName
skip 272
export ui_teamName
align 4
LABELV ui_teamName
skip 272
export ui_initialized
align 4
LABELV ui_initialized
skip 272
export ui_debug
align 4
LABELV ui_debug
skip 272
export ui_new
align 4
LABELV ui_new
skip 272
export ui_cdkeychecked
align 4
LABELV ui_cdkeychecked
skip 272
export ui_server16
align 4
LABELV ui_server16
skip 272
export ui_server15
align 4
LABELV ui_server15
skip 272
export ui_server14
align 4
LABELV ui_server14
skip 272
export ui_server13
align 4
LABELV ui_server13
skip 272
export ui_server12
align 4
LABELV ui_server12
skip 272
export ui_server11
align 4
LABELV ui_server11
skip 272
export ui_server10
align 4
LABELV ui_server10
skip 272
export ui_server9
align 4
LABELV ui_server9
skip 272
export ui_server8
align 4
LABELV ui_server8
skip 272
export ui_server7
align 4
LABELV ui_server7
skip 272
export ui_server6
align 4
LABELV ui_server6
skip 272
export ui_server5
align 4
LABELV ui_server5
skip 272
export ui_server4
align 4
LABELV ui_server4
skip 272
export ui_server3
align 4
LABELV ui_server3
skip 272
export ui_server2
align 4
LABELV ui_server2
skip 272
export ui_server1
align 4
LABELV ui_server1
skip 272
export ui_marks
align 4
LABELV ui_marks
skip 272
export ui_drawCrosshairNames
align 4
LABELV ui_drawCrosshairNames
skip 272
export ui_drawCrosshair
align 4
LABELV ui_drawCrosshair
skip 272
export ui_brassTime
align 4
LABELV ui_brassTime
skip 272
export ui_browserShowEmpty
align 4
LABELV ui_browserShowEmpty
skip 272
export ui_browserShowFull
align 4
LABELV ui_browserShowFull
skip 272
export ui_browserSortKey
align 4
LABELV ui_browserSortKey
skip 272
export ui_browserGameType
align 4
LABELV ui_browserGameType
skip 272
export ui_browserMaster
align 4
LABELV ui_browserMaster
skip 272
export ui_spSelection
align 4
LABELV ui_spSelection
skip 272
export ui_spSkill
align 4
LABELV ui_spSkill
skip 272
export ui_spVideos
align 4
LABELV ui_spVideos
skip 272
export ui_spAwards
align 4
LABELV ui_spAwards
skip 272
export ui_spScores5
align 4
LABELV ui_spScores5
skip 272
export ui_spScores4
align 4
LABELV ui_spScores4
skip 272
export ui_spScores3
align 4
LABELV ui_spScores3
skip 272
export ui_spScores2
align 4
LABELV ui_spScores2
skip 272
export ui_spScores1
align 4
LABELV ui_spScores1
skip 272
export ui_botsFile
align 4
LABELV ui_botsFile
skip 272
export ui_arenasFile
align 4
LABELV ui_arenasFile
skip 272
export ui_ctf_friendly
align 4
LABELV ui_ctf_friendly
skip 272
export ui_ctf_timelimit
align 4
LABELV ui_ctf_timelimit
skip 272
export ui_ctf_capturelimit
align 4
LABELV ui_ctf_capturelimit
skip 272
export ui_team_friendly
align 4
LABELV ui_team_friendly
skip 272
export ui_team_timelimit
align 4
LABELV ui_team_timelimit
skip 272
export ui_team_fraglimit
align 4
LABELV ui_team_fraglimit
skip 272
export ui_tourney_timelimit
align 4
LABELV ui_tourney_timelimit
skip 272
export ui_tourney_fraglimit
align 4
LABELV ui_tourney_fraglimit
skip 272
export ui_ffa_timelimit
align 4
LABELV ui_ffa_timelimit
skip 272
export ui_ffa_fraglimit
align 4
LABELV ui_ffa_fraglimit
skip 272
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
LABELV $4665
byte 1 103
byte 1 108
byte 1 111
byte 1 98
byte 1 97
byte 1 108
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 32
byte 1 101
byte 1 109
byte 1 112
byte 1 116
byte 1 121
byte 1 10
byte 1 0
align 1
LABELV $4664
byte 1 103
byte 1 108
byte 1 111
byte 1 98
byte 1 97
byte 1 108
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 32
byte 1 101
byte 1 109
byte 1 112
byte 1 116
byte 1 121
byte 1 10
byte 1 0
align 1
LABELV $4647
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $4625
byte 1 37
byte 1 115
byte 1 45
byte 1 37
byte 1 105
byte 1 44
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $4590
byte 1 99
byte 1 108
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 80
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $4587
byte 1 37
byte 1 100
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 100
byte 1 117
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 32
byte 1 108
byte 1 111
byte 1 115
byte 1 115
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 103
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $4577
byte 1 37
byte 1 100
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $4500
byte 1 55
byte 1 48
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $4499
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 79
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $4498
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 65
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 70
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 82
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $4497
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
LABELV $4496
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
LABELV $4495
byte 1 117
byte 1 105
byte 1 95
byte 1 113
byte 1 51
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $4494
byte 1 83
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $4493
byte 1 48
byte 1 46
byte 1 52
byte 1 0
align 1
LABELV $4492
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 105
byte 1 103
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $4491
byte 1 48
byte 1 46
byte 1 50
byte 1 53
byte 1 0
align 1
LABELV $4490
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $4489
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 83
byte 1 104
byte 1 117
byte 1 116
byte 1 111
byte 1 117
byte 1 116
byte 1 66
byte 1 111
byte 1 110
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $4488
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 83
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 66
byte 1 111
byte 1 110
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $4487
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 66
byte 1 111
byte 1 110
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $4486
byte 1 48
byte 1 48
byte 1 58
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $4485
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $4484
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 66
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $4483
byte 1 48
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 48
byte 1 0
align 1
LABELV $4482
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $4481
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 80
byte 1 101
byte 1 114
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $4480
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $4479
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 71
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $4478
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 65
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $4477
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 68
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $4476
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $4475
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 69
byte 1 120
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $4474
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 73
byte 1 109
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 118
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $4473
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 65
byte 1 99
byte 1 99
byte 1 117
byte 1 114
byte 1 97
byte 1 99
byte 1 121
byte 1 0
align 1
LABELV $4472
byte 1 117
byte 1 105
byte 1 95
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 82
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 95
byte 1 51
byte 1 0
align 1
LABELV $4471
byte 1 117
byte 1 105
byte 1 95
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 82
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 95
byte 1 50
byte 1 0
align 1
LABELV $4470
byte 1 117
byte 1 105
byte 1 95
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 82
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $4469
byte 1 117
byte 1 105
byte 1 95
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 82
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $4468
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 79
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $4467
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 53
byte 1 0
align 1
LABELV $4466
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 52
byte 1 0
align 1
LABELV $4465
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 51
byte 1 0
align 1
LABELV $4464
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 50
byte 1 0
align 1
LABELV $4463
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 49
byte 1 0
align 1
LABELV $4462
byte 1 117
byte 1 105
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 53
byte 1 0
align 1
LABELV $4461
byte 1 117
byte 1 105
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 52
byte 1 0
align 1
LABELV $4460
byte 1 117
byte 1 105
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 51
byte 1 0
align 1
LABELV $4459
byte 1 117
byte 1 105
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 50
byte 1 0
align 1
LABELV $4458
byte 1 117
byte 1 105
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 49
byte 1 0
align 1
LABELV $4457
byte 1 117
byte 1 105
byte 1 95
byte 1 97
byte 1 99
byte 1 116
byte 1 117
byte 1 97
byte 1 108
byte 1 78
byte 1 101
byte 1 116
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $4456
byte 1 117
byte 1 105
byte 1 95
byte 1 110
byte 1 101
byte 1 116
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $4455
byte 1 117
byte 1 105
byte 1 95
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $4454
byte 1 51
byte 1 0
align 1
LABELV $4453
byte 1 117
byte 1 105
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
LABELV $4452
byte 1 117
byte 1 105
byte 1 95
byte 1 100
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $4451
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $4450
byte 1 117
byte 1 105
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $4449
byte 1 83
byte 1 116
byte 1 114
byte 1 111
byte 1 103
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $4448
byte 1 80
byte 1 97
byte 1 103
byte 1 97
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $4447
byte 1 117
byte 1 105
byte 1 95
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
byte 1 0
align 1
LABELV $4446
byte 1 117
byte 1 105
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 0
align 1
LABELV $4445
byte 1 117
byte 1 105
byte 1 95
byte 1 110
byte 1 101
byte 1 119
byte 1 0
align 1
LABELV $4444
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 100
byte 1 107
byte 1 101
byte 1 121
byte 1 99
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $4443
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 54
byte 1 0
align 1
LABELV $4442
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 53
byte 1 0
align 1
LABELV $4441
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 52
byte 1 0
align 1
LABELV $4440
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 51
byte 1 0
align 1
LABELV $4439
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 50
byte 1 0
align 1
LABELV $4438
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 49
byte 1 0
align 1
LABELV $4437
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $4436
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 57
byte 1 0
align 1
LABELV $4435
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 56
byte 1 0
align 1
LABELV $4434
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 55
byte 1 0
align 1
LABELV $4433
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 54
byte 1 0
align 1
LABELV $4432
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 53
byte 1 0
align 1
LABELV $4431
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 52
byte 1 0
align 1
LABELV $4430
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 51
byte 1 0
align 1
LABELV $4429
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $4428
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 0
align 1
LABELV $4427
byte 1 99
byte 1 103
byte 1 95
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 115
byte 1 0
align 1
LABELV $4426
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 67
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $4425
byte 1 50
byte 1 53
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $4424
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 83
byte 1 104
byte 1 111
byte 1 119
byte 1 69
byte 1 109
byte 1 112
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $4423
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 83
byte 1 104
byte 1 111
byte 1 119
byte 1 70
byte 1 117
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $4422
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 83
byte 1 111
byte 1 114
byte 1 116
byte 1 75
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $4421
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $4420
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 77
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $4419
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $4418
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 86
byte 1 105
byte 1 100
byte 1 101
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $4417
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 65
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $4416
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 53
byte 1 0
align 1
LABELV $4415
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 52
byte 1 0
align 1
LABELV $4414
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 51
byte 1 0
align 1
LABELV $4413
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 50
byte 1 0
align 1
LABELV $4412
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 49
byte 1 0
align 1
LABELV $4411
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $4410
byte 1 103
byte 1 95
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 115
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $4409
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 0
align 1
LABELV $4408
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $4407
byte 1 56
byte 1 0
align 1
LABELV $4406
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $4405
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 0
align 1
LABELV $4404
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $4403
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $4402
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $4401
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $4400
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $4399
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $4390
byte 1 65
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 101
byte 1 46
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $4387
byte 1 99
byte 1 108
byte 1 95
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $4384
byte 1 65
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 101
byte 1 46
byte 1 46
byte 1 46
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $4381
byte 1 65
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 46
byte 1 46
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $4371
byte 1 109
byte 1 111
byte 1 116
byte 1 100
byte 1 0
align 1
LABELV $4368
byte 1 67
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $4367
byte 1 83
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 117
byte 1 112
byte 1 46
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $4366
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 104
byte 1 111
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $4362
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $4355
byte 1 67
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $4353
byte 1 37
byte 1 115
byte 1 47
byte 1 83
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $4350
byte 1 40
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 111
byte 1 112
byte 1 105
byte 1 101
byte 1 100
byte 1 41
byte 1 0
align 1
LABELV $4341
byte 1 40
byte 1 37
byte 1 115
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 111
byte 1 112
byte 1 105
byte 1 101
byte 1 100
byte 1 41
byte 1 0
align 1
LABELV $4340
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $4336
byte 1 37
byte 1 115
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 37
byte 1 37
byte 1 41
byte 1 0
align 1
LABELV $4333
byte 1 99
byte 1 108
byte 1 95
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $4332
byte 1 99
byte 1 108
byte 1 95
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 67
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $4331
byte 1 99
byte 1 108
byte 1 95
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 83
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $4304
byte 1 37
byte 1 100
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $4303
byte 1 37
byte 1 100
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $4300
byte 1 37
byte 1 100
byte 1 32
byte 1 104
byte 1 114
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $4296
byte 1 37
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 116
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $4295
byte 1 37
byte 1 100
byte 1 32
byte 1 75
byte 1 66
byte 1 0
align 1
LABELV $4292
byte 1 46
byte 1 37
byte 1 48
byte 1 50
byte 1 100
byte 1 32
byte 1 77
byte 1 66
byte 1 0
align 1
LABELV $4289
byte 1 46
byte 1 37
byte 1 48
byte 1 50
byte 1 100
byte 1 32
byte 1 71
byte 1 66
byte 1 0
align 1
LABELV $4283
byte 1 105
byte 1 110
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $4281
byte 1 101
byte 1 110
byte 1 100
byte 1 111
byte 1 102
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $4273
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 95
byte 1 112
byte 1 111
byte 1 112
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 0
align 1
LABELV $4208
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 116
byte 1 111
byte 1 99
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $4207
byte 1 48
byte 1 46
byte 1 53
byte 1 0
align 1
LABELV $4206
byte 1 115
byte 1 95
byte 1 109
byte 1 117
byte 1 115
byte 1 105
byte 1 99
byte 1 118
byte 1 111
byte 1 108
byte 1 117
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $4205
byte 1 48
byte 1 46
byte 1 56
byte 1 0
align 1
LABELV $4204
byte 1 115
byte 1 95
byte 1 118
byte 1 111
byte 1 108
byte 1 117
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $4203
byte 1 117
byte 1 105
byte 1 95
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 65
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 70
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 82
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $4180
byte 1 117
byte 1 105
byte 1 47
byte 1 105
byte 1 110
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 46
byte 1 116
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $4176
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 46
byte 1 116
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $4172
byte 1 119
byte 1 104
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $4170
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 51
byte 1 95
byte 1 99
byte 1 117
byte 1 114
byte 1 115
byte 1 111
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $4116
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $4097
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $4096
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $4093
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $4092
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $4091
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 0
align 1
LABELV $4083
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $4082
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $4080
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $4079
byte 1 46
byte 1 0
align 1
LABELV $4069
byte 1 47
byte 1 0
align 1
LABELV $4068
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $4020
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $4015
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $4010
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $3995
byte 1 84
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 44
byte 1 32
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 32
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $3987
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 95
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $3931
byte 1 84
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 115
byte 1 44
byte 1 32
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 32
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $3926
byte 1 84
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 110
byte 1 101
byte 1 116
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 115
byte 1 44
byte 1 32
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 32
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $3884
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 115
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $3881
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
LABELV $3876
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $3859
byte 1 84
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 115
byte 1 101
byte 1 115
byte 1 44
byte 1 32
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 32
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $3849
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 117
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 97
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $3821
byte 1 84
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
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
byte 1 44
byte 1 32
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $3811
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $3804
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $3801
byte 1 74
byte 1 97
byte 1 110
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $3797
byte 1 102
byte 1 101
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $3792
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $3765
byte 1 84
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 44
byte 1 32
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $3758
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $3600
byte 1 42
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $3497
byte 1 78
byte 1 111
byte 1 0
align 1
LABELV $3496
byte 1 89
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $3493
byte 1 112
byte 1 117
byte 1 110
byte 1 107
byte 1 98
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $3491
byte 1 46
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $3487
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $3483
byte 1 37
byte 1 115
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 0
align 1
LABELV $3480
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $3479
byte 1 110
byte 1 101
byte 1 116
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $3478
byte 1 37
byte 1 115
byte 1 32
byte 1 91
byte 1 37
byte 1 115
byte 1 93
byte 1 0
align 1
LABELV $3301
byte 1 115
byte 1 0
align 1
LABELV $3298
byte 1 37
byte 1 100
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 37
byte 1 115
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
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $3293
byte 1 110
byte 1 111
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $3209
byte 1 115
byte 1 101
byte 1 97
byte 1 114
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 100
byte 1 47
byte 1 37
byte 1 100
byte 1 46
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $3151
byte 1 115
byte 1 101
byte 1 97
byte 1 114
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 100
byte 1 46
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $3143
byte 1 99
byte 1 108
byte 1 95
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 82
byte 1 101
byte 1 115
byte 1 101
byte 1 110
byte 1 100
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $3132
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $3087
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $3086
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $3085
byte 1 110
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $3047
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $3046
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $3045
byte 1 77
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $3044
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $3043
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $3042
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $3041
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $3040
byte 1 65
byte 1 100
byte 1 100
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $3039
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $3038
byte 1 115
byte 1 118
byte 1 95
byte 1 104
byte 1 111
byte 1 115
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $3019
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
LABELV $2999
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $2956
byte 1 87
byte 1 101
byte 1 108
byte 1 99
byte 1 111
byte 1 109
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 65
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 33
byte 1 0
align 1
LABELV $2945
byte 1 99
byte 1 108
byte 1 95
byte 1 109
byte 1 111
byte 1 116
byte 1 100
byte 1 83
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $2788
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
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
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $2785
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $2749
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 85
byte 1 73
byte 1 32
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2746
byte 1 115
byte 1 101
byte 1 116
byte 1 80
byte 1 98
byte 1 67
byte 1 108
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $2741
byte 1 117
byte 1 112
byte 1 100
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $2738
byte 1 52
byte 1 0
align 1
LABELV $2737
byte 1 103
byte 1 108
byte 1 67
byte 1 117
byte 1 115
byte 1 116
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $2728
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $2720
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 115
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $2708
byte 1 10
byte 1 0
align 1
LABELV $2701
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $2692
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 97
byte 1 118
byte 1 111
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 65
byte 1 100
byte 1 100
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $2691
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 97
byte 1 118
byte 1 111
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2687
byte 1 99
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 70
byte 1 97
byte 1 118
byte 1 111
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $2674
byte 1 100
byte 1 101
byte 1 108
byte 1 101
byte 1 116
byte 1 101
byte 1 70
byte 1 97
byte 1 118
byte 1 111
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $2671
byte 1 65
byte 1 100
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 97
byte 1 118
byte 1 111
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2670
byte 1 70
byte 1 97
byte 1 118
byte 1 111
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 32
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 32
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $2667
byte 1 70
byte 1 97
byte 1 118
byte 1 111
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $2662
byte 1 97
byte 1 100
byte 1 100
byte 1 114
byte 1 0
align 1
LABELV $2661
byte 1 104
byte 1 111
byte 1 115
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2652
byte 1 97
byte 1 100
byte 1 100
byte 1 70
byte 1 97
byte 1 118
byte 1 111
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $2636
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
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2633
byte 1 97
byte 1 100
byte 1 100
byte 1 66
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $2628
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
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2622
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 76
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2616
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
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
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $2610
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2605
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2599
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 75
byte 1 105
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $2593
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2587
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 77
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $2584
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 105
byte 1 110
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2581
byte 1 83
byte 1 107
byte 1 105
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 104
byte 1 83
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $2578
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 83
byte 1 107
byte 1 105
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $2562
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 83
byte 1 111
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $2559
byte 1 100
byte 1 105
byte 1 115
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $2558
byte 1 76
byte 1 101
byte 1 97
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $2555
byte 1 115
byte 1 101
byte 1 116
byte 1 117
byte 1 112
byte 1 95
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 50
byte 1 0
align 1
LABELV $2554
byte 1 99
byte 1 108
byte 1 95
byte 1 112
byte 1 97
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $2553
byte 1 67
byte 1 111
byte 1 110
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $2550
byte 1 113
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $2549
byte 1 81
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $2539
byte 1 70
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 74
byte 1 111
byte 1 105
byte 1 110
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2536
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2522
byte 1 74
byte 1 111
byte 1 105
byte 1 110
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2517
byte 1 70
byte 1 105
byte 1 110
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2510
byte 1 70
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $2500
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $2494
byte 1 85
byte 1 112
byte 1 100
byte 1 97
byte 1 116
byte 1 101
byte 1 70
byte 1 105
byte 1 108
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2487
byte 1 83
byte 1 116
byte 1 111
byte 1 112
byte 1 82
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $2484
byte 1 109
byte 1 97
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $2483
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2474
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 74
byte 1 111
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $2471
byte 1 81
byte 1 117
byte 1 97
byte 1 107
byte 1 101
byte 1 51
byte 1 0
align 1
LABELV $2466
byte 1 100
byte 1 101
byte 1 109
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2465
byte 1 82
byte 1 117
byte 1 110
byte 1 68
byte 1 101
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $2462
byte 1 118
byte 1 105
byte 1 100
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 59
byte 1 0
align 1
LABELV $2459
byte 1 102
byte 1 115
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2458
byte 1 82
byte 1 117
byte 1 110
byte 1 77
byte 1 111
byte 1 100
byte 1 0
align 1
LABELV $2453
byte 1 99
byte 1 105
byte 1 110
byte 1 101
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 99
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 114
byte 1 111
byte 1 113
byte 1 32
byte 1 50
byte 1 10
byte 1 0
align 1
LABELV $2448
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 77
byte 1 111
byte 1 118
byte 1 105
byte 1 101
byte 1 0
align 1
LABELV $2445
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 77
byte 1 111
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $2442
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 77
byte 1 111
byte 1 118
byte 1 105
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $2439
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 68
byte 1 101
byte 1 109
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $2430
byte 1 100
byte 1 101
byte 1 109
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $2426
byte 1 82
byte 1 117
byte 1 110
byte 1 83
byte 1 80
byte 1 68
byte 1 101
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $2423
byte 1 82
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 70
byte 1 105
byte 1 108
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2420
byte 1 82
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $2417
byte 1 114
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $2408
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 0
align 1
LABELV $2405
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 77
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $2404
byte 1 99
byte 1 108
byte 1 101
byte 1 97
byte 1 114
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $2401
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 67
byte 1 111
byte 1 110
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $2398
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 67
byte 1 111
byte 1 110
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $2395
byte 1 99
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2394
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 65
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 115
byte 1 0
align 1
LABELV $2391
byte 1 67
byte 1 68
byte 1 32
byte 1 75
byte 1 101
byte 1 121
byte 1 32
byte 1 100
byte 1 111
byte 1 101
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 112
byte 1 112
byte 1 101
byte 1 97
byte 1 114
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 46
byte 1 0
align 1
LABELV $2390
byte 1 67
byte 1 68
byte 1 32
byte 1 75
byte 1 101
byte 1 121
byte 1 32
byte 1 65
byte 1 112
byte 1 112
byte 1 101
byte 1 97
byte 1 114
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 46
byte 1 0
align 1
LABELV $2389
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 100
byte 1 107
byte 1 101
byte 1 121
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 0
align 1
LABELV $2388
byte 1 99
byte 1 100
byte 1 107
byte 1 101
byte 1 121
byte 1 99
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 115
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $2385
byte 1 99
byte 1 100
byte 1 107
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $2384
byte 1 118
byte 1 101
byte 1 114
byte 1 105
byte 1 102
byte 1 121
byte 1 67
byte 1 68
byte 1 75
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $2376
byte 1 99
byte 1 100
byte 1 107
byte 1 101
byte 1 121
byte 1 52
byte 1 0
align 1
LABELV $2375
byte 1 99
byte 1 100
byte 1 107
byte 1 101
byte 1 121
byte 1 51
byte 1 0
align 1
LABELV $2374
byte 1 99
byte 1 100
byte 1 107
byte 1 101
byte 1 121
byte 1 50
byte 1 0
align 1
LABELV $2373
byte 1 99
byte 1 100
byte 1 107
byte 1 101
byte 1 121
byte 1 49
byte 1 0
align 1
LABELV $2372
byte 1 103
byte 1 101
byte 1 116
byte 1 67
byte 1 68
byte 1 75
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $2369
byte 1 118
byte 1 105
byte 1 100
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $2368
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 114
byte 1 111
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $2367
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $2366
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $2365
byte 1 114
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 68
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $2358
byte 1 117
byte 1 112
byte 1 100
byte 1 97
byte 1 116
byte 1 101
byte 1 83
byte 1 80
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 0
align 1
LABELV $2348
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
byte 1 37
byte 1 102
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $2345
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
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2316
byte 1 100
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $2315
byte 1 83
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2309
byte 1 109
byte 1 95
byte 1 112
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $2306
byte 1 117
byte 1 105
byte 1 95
byte 1 109
byte 1 111
byte 1 117
byte 1 115
byte 1 101
byte 1 80
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $2301
byte 1 71
byte 1 76
byte 1 95
byte 1 76
byte 1 73
byte 1 78
byte 1 69
byte 1 65
byte 1 82
byte 1 95
byte 1 77
byte 1 73
byte 1 80
byte 1 77
byte 1 65
byte 1 80
byte 1 95
byte 1 78
byte 1 69
byte 1 65
byte 1 82
byte 1 69
byte 1 83
byte 1 84
byte 1 0
align 1
LABELV $2298
byte 1 71
byte 1 76
byte 1 95
byte 1 76
byte 1 73
byte 1 78
byte 1 69
byte 1 65
byte 1 82
byte 1 95
byte 1 77
byte 1 73
byte 1 80
byte 1 77
byte 1 65
byte 1 80
byte 1 95
byte 1 76
byte 1 73
byte 1 78
byte 1 69
byte 1 65
byte 1 82
byte 1 0
align 1
LABELV $2297
byte 1 114
byte 1 95
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $2296
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 114
byte 1 97
byte 1 115
byte 1 115
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2295
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 115
byte 1 0
align 1
LABELV $2294
byte 1 114
byte 1 95
byte 1 105
byte 1 110
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 86
byte 1 105
byte 1 100
byte 1 101
byte 1 111
byte 1 0
align 1
LABELV $2293
byte 1 114
byte 1 95
byte 1 102
byte 1 97
byte 1 115
byte 1 116
byte 1 83
byte 1 107
byte 1 121
byte 1 0
align 1
LABELV $2292
byte 1 114
byte 1 95
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 98
byte 1 105
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $2291
byte 1 114
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $2290
byte 1 114
byte 1 95
byte 1 112
byte 1 105
byte 1 99
byte 1 109
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $2289
byte 1 114
byte 1 95
byte 1 118
byte 1 101
byte 1 114
byte 1 116
byte 1 101
byte 1 120
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $2288
byte 1 114
byte 1 95
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 83
byte 1 99
byte 1 114
byte 1 101
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $2284
byte 1 117
byte 1 105
byte 1 95
byte 1 103
byte 1 108
byte 1 67
byte 1 117
byte 1 115
byte 1 116
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $2279
byte 1 114
byte 1 95
byte 1 115
byte 1 117
byte 1 98
byte 1 100
byte 1 105
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $2275
byte 1 114
byte 1 95
byte 1 108
byte 1 111
byte 1 100
byte 1 98
byte 1 105
byte 1 97
byte 1 115
byte 1 0
align 1
LABELV $2268
byte 1 114
byte 1 95
byte 1 115
byte 1 116
byte 1 101
byte 1 110
byte 1 99
byte 1 105
byte 1 108
byte 1 98
byte 1 105
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $2267
byte 1 114
byte 1 95
byte 1 100
byte 1 101
byte 1 112
byte 1 116
byte 1 104
byte 1 98
byte 1 105
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $2263
byte 1 114
byte 1 95
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 98
byte 1 105
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $2260
byte 1 117
byte 1 105
byte 1 95
byte 1 71
byte 1 101
byte 1 116
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2255
byte 1 99
byte 1 108
byte 1 95
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 100
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $2254
byte 1 99
byte 1 108
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $2251
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $2250
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 101
byte 1 116
byte 1 82
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $2247
byte 1 117
byte 1 105
byte 1 95
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2246
byte 1 117
byte 1 105
byte 1 95
byte 1 83
byte 1 101
byte 1 116
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2242
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 32
byte 1 53
byte 1 59
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 82
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $2218
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
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2204
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 32
byte 1 59
byte 1 32
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
byte 1 37
byte 1 102
byte 1 32
byte 1 44
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $2203
byte 1 50
byte 1 0
align 1
LABELV $2200
byte 1 117
byte 1 105
byte 1 95
byte 1 114
byte 1 101
byte 1 99
byte 1 111
byte 1 114
byte 1 100
byte 1 83
byte 1 80
byte 1 68
byte 1 101
byte 1 109
byte 1 111
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2196
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $2195
byte 1 117
byte 1 105
byte 1 95
byte 1 114
byte 1 101
byte 1 99
byte 1 111
byte 1 114
byte 1 100
byte 1 83
byte 1 80
byte 1 68
byte 1 101
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $2192
byte 1 103
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $2191
byte 1 103
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $2190
byte 1 117
byte 1 105
byte 1 95
byte 1 112
byte 1 117
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $2189
byte 1 115
byte 1 118
byte 1 95
byte 1 112
byte 1 117
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $2188
byte 1 117
byte 1 105
byte 1 95
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $2187
byte 1 103
byte 1 95
byte 1 119
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $2186
byte 1 117
byte 1 105
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $2185
byte 1 115
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $2184
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $2183
byte 1 103
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $2182
byte 1 117
byte 1 105
byte 1 95
byte 1 100
byte 1 111
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $2181
byte 1 103
byte 1 95
byte 1 100
byte 1 111
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $2180
byte 1 117
byte 1 105
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2179
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2178
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 70
byte 1 114
byte 1 97
byte 1 103
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $2177
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $2176
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $2173
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 77
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $2169
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 32
byte 1 59
byte 1 32
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 32
byte 1 59
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2163
byte 1 117
byte 1 105
byte 1 95
byte 1 109
byte 1 97
byte 1 112
byte 1 73
byte 1 110
byte 1 100
byte 1 101
byte 1 120
byte 1 0
align 1
LABELV $2159
byte 1 115
byte 1 107
byte 1 105
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $2133
byte 1 46
byte 1 100
byte 1 109
byte 1 95
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $2132
byte 1 100
byte 1 101
byte 1 109
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $2130
byte 1 112
byte 1 114
byte 1 111
byte 1 116
byte 1 111
byte 1 99
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $2129
byte 1 100
byte 1 109
byte 1 95
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $2126
byte 1 46
byte 1 114
byte 1 111
byte 1 113
byte 1 0
align 1
LABELV $2111
byte 1 114
byte 1 111
byte 1 113
byte 1 0
align 1
LABELV $2110
byte 1 118
byte 1 105
byte 1 100
byte 1 101
byte 1 111
byte 1 0
align 1
LABELV $2101
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $2086
byte 1 36
byte 1 109
byte 1 111
byte 1 100
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $2082
byte 1 81
byte 1 117
byte 1 97
byte 1 107
byte 1 101
byte 1 32
byte 1 73
byte 1 73
byte 1 73
byte 1 32
byte 1 65
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 0
align 1
LABELV $2032
byte 1 69
byte 1 118
byte 1 101
byte 1 114
byte 1 121
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $2010
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 67
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $1927
byte 1 117
byte 1 105
byte 1 95
byte 1 110
byte 1 101
byte 1 116
byte 1 83
byte 1 111
byte 1 117
byte 1 114
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $1816
byte 1 117
byte 1 105
byte 1 95
byte 1 97
byte 1 99
byte 1 116
byte 1 117
byte 1 97
byte 1 108
byte 1 110
byte 1 101
byte 1 116
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $1785
byte 1 117
byte 1 105
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $1727
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 49
byte 1 0
align 1
LABELV $1708
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1511
byte 1 80
byte 1 73
byte 1 88
byte 1 69
byte 1 76
byte 1 70
byte 1 79
byte 1 82
byte 1 77
byte 1 65
byte 1 84
byte 1 58
byte 1 32
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 40
byte 1 37
byte 1 100
byte 1 45
byte 1 98
byte 1 105
byte 1 116
byte 1 115
byte 1 41
byte 1 32
byte 1 90
byte 1 40
byte 1 37
byte 1 100
byte 1 45
byte 1 98
byte 1 105
byte 1 116
byte 1 115
byte 1 41
byte 1 32
byte 1 115
byte 1 116
byte 1 101
byte 1 110
byte 1 99
byte 1 105
byte 1 108
byte 1 40
byte 1 37
byte 1 100
byte 1 45
byte 1 98
byte 1 105
byte 1 116
byte 1 115
byte 1 41
byte 1 0
align 1
LABELV $1507
byte 1 86
byte 1 69
byte 1 82
byte 1 83
byte 1 73
byte 1 79
byte 1 78
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1504
byte 1 86
byte 1 69
byte 1 78
byte 1 68
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1396
byte 1 82
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 32
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1393
byte 1 71
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 40
byte 1 69
byte 1 83
byte 1 67
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 108
byte 1 41
byte 1 0
align 1
LABELV $1380
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $1370
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $1362
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1342
byte 1 110
byte 1 0
align 1
LABELV $1331
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
LABELV $1330
byte 1 116
byte 1 0
align 1
LABELV $1329
byte 1 116
byte 1 108
byte 1 0
align 1
LABELV $1294
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
LABELV $1285
byte 1 117
byte 1 105
byte 1 95
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 82
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 95
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1283
byte 1 80
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 69
byte 1 78
byte 1 84
byte 1 69
byte 1 82
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 67
byte 1 76
byte 1 73
byte 1 67
byte 1 75
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 44
byte 1 32
byte 1 80
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 66
byte 1 65
byte 1 67
byte 1 75
byte 1 83
byte 1 80
byte 1 65
byte 1 67
byte 1 69
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 99
byte 1 108
byte 1 101
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $1282
byte 1 87
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 110
byte 1 101
byte 1 119
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 80
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 69
byte 1 83
byte 1 67
byte 1 65
byte 1 80
byte 1 69
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $1254
byte 1 37
byte 1 105
byte 1 46
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1077
byte 1 117
byte 1 105
byte 1 95
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $1070
byte 1 117
byte 1 105
byte 1 95
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $1065
byte 1 74
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $1017
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1004
byte 1 84
byte 1 105
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $999
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 84
byte 1 105
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $997
byte 1 70
byte 1 105
byte 1 108
byte 1 116
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $969
byte 1 83
byte 1 111
byte 1 117
byte 1 114
byte 1 99
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $952
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $951
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $948
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $947
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $946
byte 1 117
byte 1 105
byte 1 95
byte 1 81
byte 1 51
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $903
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 58
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 0
align 1
LABELV $888
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $873
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 77
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $871
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 78
byte 1 101
byte 1 116
byte 1 77
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $838
byte 1 72
byte 1 117
byte 1 109
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $835
byte 1 67
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $829
byte 1 117
byte 1 105
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $828
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $822
byte 1 82
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $821
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $820
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $813
byte 1 117
byte 1 105
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $812
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $806
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
LABELV $772
byte 1 37
byte 1 115
byte 1 46
byte 1 114
byte 1 111
byte 1 113
byte 1 0
align 1
LABELV $753
byte 1 37
byte 1 115
byte 1 95
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $748
byte 1 37
byte 1 115
byte 1 95
byte 1 109
byte 1 101
byte 1 116
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $720
byte 1 117
byte 1 105
byte 1 95
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $710
byte 1 117
byte 1 105
byte 1 95
byte 1 97
byte 1 99
byte 1 116
byte 1 117
byte 1 97
byte 1 108
byte 1 78
byte 1 101
byte 1 116
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $709
byte 1 117
byte 1 105
byte 1 95
byte 1 110
byte 1 101
byte 1 116
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $698
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $697
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $696
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $695
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $694
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $680
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $678
byte 1 104
byte 1 97
byte 1 110
byte 1 100
byte 1 105
byte 1 99
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $676
byte 1 53
byte 1 0
align 1
LABELV $675
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $674
byte 1 49
byte 1 53
byte 1 0
align 1
LABELV $673
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $672
byte 1 50
byte 1 53
byte 1 0
align 1
LABELV $671
byte 1 51
byte 1 48
byte 1 0
align 1
LABELV $670
byte 1 51
byte 1 53
byte 1 0
align 1
LABELV $669
byte 1 52
byte 1 48
byte 1 0
align 1
LABELV $668
byte 1 52
byte 1 53
byte 1 0
align 1
LABELV $667
byte 1 53
byte 1 48
byte 1 0
align 1
LABELV $666
byte 1 53
byte 1 53
byte 1 0
align 1
LABELV $665
byte 1 54
byte 1 48
byte 1 0
align 1
LABELV $664
byte 1 54
byte 1 53
byte 1 0
align 1
LABELV $663
byte 1 55
byte 1 48
byte 1 0
align 1
LABELV $662
byte 1 55
byte 1 53
byte 1 0
align 1
LABELV $661
byte 1 56
byte 1 48
byte 1 0
align 1
LABELV $660
byte 1 56
byte 1 53
byte 1 0
align 1
LABELV $659
byte 1 57
byte 1 48
byte 1 0
align 1
LABELV $658
byte 1 57
byte 1 53
byte 1 0
align 1
LABELV $657
byte 1 78
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $656
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 46
byte 1 116
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $650
byte 1 117
byte 1 105
byte 1 95
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $648
byte 1 85
byte 1 73
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 61
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 109
byte 1 105
byte 1 108
byte 1 108
byte 1 105
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $645
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 0
align 1
LABELV $625
byte 1 94
byte 1 49
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 117
byte 1 105
byte 1 47
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 115
byte 1 46
byte 1 116
byte 1 120
byte 1 116
byte 1 44
byte 1 32
byte 1 117
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 116
byte 1 105
byte 1 110
byte 1 117
byte 1 101
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $622
byte 1 117
byte 1 105
byte 1 47
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 115
byte 1 46
byte 1 116
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $621
byte 1 94
byte 1 51
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 117
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $599
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 100
byte 1 101
byte 1 102
byte 1 0
align 1
LABELV $593
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 71
byte 1 108
byte 1 111
byte 1 98
byte 1 97
byte 1 108
byte 1 68
byte 1 101
byte 1 102
byte 1 0
align 1
LABELV $579
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $573
byte 1 71
byte 1 108
byte 1 121
byte 1 112
byte 1 104
byte 1 32
byte 1 104
byte 1 97
byte 1 110
byte 1 100
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $568
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 10
byte 1 0
align 1
LABELV $567
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 32
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 10
byte 1 0
align 1
LABELV $556
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $548
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 89
byte 1 0
align 1
LABELV $540
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 88
byte 1 0
align 1
LABELV $532
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 65
byte 1 109
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $524
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 67
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $516
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 67
byte 1 108
byte 1 97
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $504
byte 1 99
byte 1 117
byte 1 114
byte 1 115
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $496
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 66
byte 1 117
byte 1 122
byte 1 122
byte 1 83
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $488
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 70
byte 1 111
byte 1 99
byte 1 117
byte 1 115
byte 1 83
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $480
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 69
byte 1 120
byte 1 105
byte 1 116
byte 1 83
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $472
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 69
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 83
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $464
byte 1 103
byte 1 114
byte 1 97
byte 1 100
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 98
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $455
byte 1 98
byte 1 105
byte 1 103
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $446
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $435
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $431
byte 1 125
byte 1 0
align 1
LABELV $422
byte 1 123
byte 1 0
align 1
LABELV $415
byte 1 94
byte 1 49
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 108
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 44
byte 1 32
byte 1 109
byte 1 97
byte 1 120
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $412
byte 1 94
byte 1 49
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 117
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $372
byte 1 49
byte 1 0
align 1
LABELV $371
byte 1 115
byte 1 118
byte 1 95
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $370
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
LABELV $369
byte 1 48
byte 1 0
align 1
LABELV $368
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
LABELV $205
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 110
byte 1 101
byte 1 119
byte 1 104
byte 1 105
byte 1 103
byte 1 104
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $203
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 37
byte 1 99
byte 1 0
align 1
LABELV $196
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 108
byte 1 105
byte 1 100
byte 1 101
byte 1 114
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 95
byte 1 49
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $193
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 108
byte 1 105
byte 1 100
byte 1 101
byte 1 114
byte 1 50
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $190
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 99
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 98
byte 1 97
byte 1 114
byte 1 95
byte 1 116
byte 1 104
byte 1 117
byte 1 109
byte 1 98
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $187
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 99
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 98
byte 1 97
byte 1 114
byte 1 95
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 95
byte 1 114
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $184
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 99
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 98
byte 1 97
byte 1 114
byte 1 95
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 95
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $181
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 99
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 98
byte 1 97
byte 1 114
byte 1 95
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 95
byte 1 117
byte 1 112
byte 1 95
byte 1 97
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $178
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 99
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 98
byte 1 97
byte 1 114
byte 1 95
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 95
byte 1 100
byte 1 119
byte 1 110
byte 1 95
byte 1 97
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $175
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 99
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 98
byte 1 97
byte 1 114
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $172
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 120
byte 1 95
byte 1 119
byte 1 104
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $169
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 120
byte 1 95
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $166
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 103
byte 1 114
byte 1 97
byte 1 100
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 98
byte 1 97
byte 1 114
byte 1 50
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $147
byte 1 73
byte 1 80
byte 1 88
byte 1 0
align 1
LABELV $146
byte 1 85
byte 1 68
byte 1 80
byte 1 0
align 1
LABELV $145
byte 1 63
byte 1 63
byte 1 63
byte 1 0
align 1
LABELV $144
byte 1 80
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $143
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $142
byte 1 79
byte 1 112
byte 1 101
byte 1 110
byte 1 32
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 83
byte 1 112
byte 1 111
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $141
byte 1 77
byte 1 97
byte 1 112
byte 1 32
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $140
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $139
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 84
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $138
byte 1 72
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $137
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $136
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
byte 1 0
align 1
LABELV $135
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $134
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
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
byte 1 0
align 1
LABELV $133
byte 1 83
byte 1 105
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 32
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $132
byte 1 84
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $131
byte 1 70
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 70
byte 1 111
byte 1 114
byte 1 32
byte 1 65
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $130
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 84
byte 1 79
byte 1 85
byte 1 82
byte 1 78
byte 1 65
byte 1 77
byte 1 69
byte 1 78
byte 1 84
byte 1 0
align 1
LABELV $129
byte 1 72
byte 1 65
byte 1 82
byte 1 86
byte 1 69
byte 1 83
byte 1 84
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $128
byte 1 79
byte 1 86
byte 1 69
byte 1 82
byte 1 76
byte 1 79
byte 1 65
byte 1 68
byte 1 0
align 1
LABELV $127
byte 1 49
byte 1 70
byte 1 67
byte 1 84
byte 1 70
byte 1 0
align 1
LABELV $126
byte 1 67
byte 1 84
byte 1 70
byte 1 0
align 1
LABELV $125
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 32
byte 1 68
byte 1 77
byte 1 0
align 1
LABELV $124
byte 1 83
byte 1 80
byte 1 0
align 1
LABELV $123
byte 1 84
byte 1 79
byte 1 85
byte 1 82
byte 1 78
byte 1 65
byte 1 77
byte 1 69
byte 1 78
byte 1 84
byte 1 0
align 1
LABELV $122
byte 1 70
byte 1 70
byte 1 65
byte 1 0
align 1
LABELV $121
byte 1 111
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $120
byte 1 79
byte 1 83
byte 1 80
byte 1 0
align 1
LABELV $119
byte 1 119
byte 1 102
byte 1 97
byte 1 0
align 1
LABELV $118
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 32
byte 1 70
byte 1 97
byte 1 99
byte 1 116
byte 1 111
byte 1 114
byte 1 121
byte 1 32
byte 1 65
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 0
align 1
LABELV $117
byte 1 97
byte 1 108
byte 1 108
byte 1 105
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $116
byte 1 65
byte 1 108
byte 1 108
byte 1 105
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $115
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 0
align 1
LABELV $114
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 32
byte 1 65
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 0
align 1
LABELV $113
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $112
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 65
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 0
align 1
LABELV $111
byte 1 81
byte 1 117
byte 1 97
byte 1 107
byte 1 101
byte 1 32
byte 1 51
byte 1 32
byte 1 65
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 0
align 1
LABELV $110
byte 1 0
align 1
LABELV $109
byte 1 65
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $108
byte 1 70
byte 1 97
byte 1 118
byte 1 111
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $107
byte 1 73
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 110
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $106
byte 1 77
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $105
byte 1 76
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $104
byte 1 78
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 109
byte 1 97
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $103
byte 1 72
byte 1 97
byte 1 114
byte 1 100
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $102
byte 1 72
byte 1 117
byte 1 114
byte 1 116
byte 1 32
byte 1 77
byte 1 101
byte 1 32
byte 1 80
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $101
byte 1 66
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 73
byte 1 116
byte 1 32
byte 1 79
byte 1 110
byte 1 0
align 1
LABELV $100
byte 1 73
byte 1 32
byte 1 67
byte 1 97
byte 1 110
byte 1 32
byte 1 87
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $99
byte 1 68
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $98
byte 1 78
byte 1 111
byte 1 118
byte 1 0
align 1
LABELV $97
byte 1 79
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $96
byte 1 83
byte 1 101
byte 1 112
byte 1 0
align 1
LABELV $95
byte 1 65
byte 1 117
byte 1 103
byte 1 0
align 1
LABELV $94
byte 1 74
byte 1 117
byte 1 108
byte 1 0
align 1
LABELV $93
byte 1 74
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $92
byte 1 77
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $91
byte 1 65
byte 1 112
byte 1 114
byte 1 0
align 1
LABELV $90
byte 1 77
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $89
byte 1 70
byte 1 101
byte 1 98
byte 1 0
align 1
LABELV $88
byte 1 74
byte 1 97
byte 1 110
byte 1 0
