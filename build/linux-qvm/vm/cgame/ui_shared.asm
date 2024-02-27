data
align 4
LABELV captureFunc
byte 4 0
align 4
LABELV captureData
byte 4 0
align 4
LABELV itemCapture
byte 4 0
export DC
align 4
LABELV DC
byte 4 0
align 4
LABELV g_waitingForKey
byte 4 0
align 4
LABELV g_editingField
byte 4 0
align 4
LABELV g_bindItem
byte 4 0
align 4
LABELV g_editItem
byte 4 0
export menuCount
align 4
LABELV menuCount
byte 4 0
export openMenuCount
align 4
LABELV openMenuCount
byte 4 0
align 4
LABELV debugMode
byte 4 0
align 4
LABELV lastListBoxClickTime
byte 4 0
export UI_Alloc
code
proc UI_Alloc 8 4
file "../../../../code/ui/ui_shared.c"
line 73
;1:// 
;2:// string allocation/managment
;3:
;4:#include "ui_shared.h"
;5:
;6:int ED_vsprintf( char *buffer, const char *fmt, va_list ap );
;7:
;8:#define SCROLL_TIME_START					500
;9:#define SCROLL_TIME_ADJUST				150
;10:#define SCROLL_TIME_ADJUSTOFFSET	40
;11:#define SCROLL_TIME_FLOOR					20
;12:
;13:typedef struct scrollInfo_s {
;14:	int nextScrollTime;
;15:	int nextAdjustTime;
;16:	int adjustValue;
;17:	int scrollKey;
;18:	float xStart;
;19:	float yStart;
;20:	itemDef_t *item;
;21:	qboolean scrollDir;
;22:} scrollInfo_t;
;23:
;24:static scrollInfo_t scrollInfo;
;25:
;26:static void (*captureFunc) (void *p) = NULL;
;27:static void *captureData = NULL;
;28:static itemDef_t *itemCapture = NULL;   // item that has the mouse captured ( if any )
;29:
;30:displayContextDef_t *DC = NULL;
;31:
;32:static qboolean g_waitingForKey = qfalse;
;33:static qboolean g_editingField = qfalse;
;34:
;35:static itemDef_t *g_bindItem = NULL;
;36:static itemDef_t *g_editItem = NULL;
;37:
;38:menuDef_t Menus[MAX_MENUS];      // defined menus
;39:int menuCount = 0;               // how many
;40:
;41:menuDef_t *menuStack[MAX_OPEN_MENUS];
;42:int openMenuCount = 0;
;43:
;44:static qboolean debugMode = qfalse;
;45:
;46:#define DOUBLE_CLICK_DELAY 300
;47:static int lastListBoxClickTime = 0;
;48:
;49:void Item_RunScript(itemDef_t *item, const char *s);
;50:void Item_SetupKeywordHash(void);
;51:void Menu_SetupKeywordHash(void);
;52:int BindingIDFromName(const char *name);
;53:qboolean Item_Bind_HandleKey(itemDef_t *item, int key, qboolean down);
;54:itemDef_t *Menu_SetPrevCursorItem(menuDef_t *menu);
;55:itemDef_t *Menu_SetNextCursorItem(menuDef_t *menu);
;56:static qboolean Menu_OverActiveItem(menuDef_t *menu, float x, float y);
;57:
;58:#ifdef CGAME
;59:#define MEM_POOL_SIZE  128 * 1024
;60:#else
;61:#define MEM_POOL_SIZE  1024 * 1024
;62:#endif
;63:
;64:static char		memoryPool[MEM_POOL_SIZE];
;65:static int		allocPoint, outOfMemory;
;66:
;67:
;68:/*
;69:===============
;70:UI_Alloc
;71:===============
;72:*/				  
;73:void *UI_Alloc( int size ) {
line 76
;74:	char	*p; 
;75:
;76:	if ( allocPoint + size > MEM_POOL_SIZE ) {
ADDRGP4 allocPoint
INDIRI4
ADDRFP4 0
INDIRI4
ADDI4
CNSTI4 131072
LEI4 $41
line 77
;77:		outOfMemory = qtrue;
ADDRGP4 outOfMemory
CNSTI4 1
ASGNI4
line 78
;78:		if (DC->Print) {
ADDRGP4 DC
INDIRP4
CNSTI4 156
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $43
line 79
;79:			DC->Print("UI_Alloc: Failure. Out of memory!\n");
ADDRGP4 $45
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 156
ADDP4
INDIRP4
CALLV
pop
line 80
;80:		}
LABELV $43
line 82
;81:    //DC->trap_Print(S_COLOR_YELLOW"WARNING: UI Out of Memory!\n");
;82:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $40
JUMPV
LABELV $41
line 85
;83:	}
;84:
;85:	p = &memoryPool[allocPoint];
ADDRLP4 0
ADDRGP4 allocPoint
INDIRI4
ADDRGP4 memoryPool
ADDP4
ASGNP4
line 87
;86:
;87:	allocPoint += ( size + 15 ) & ~15;
ADDRLP4 4
ADDRGP4 allocPoint
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRFP4 0
INDIRI4
CNSTI4 15
ADDI4
CNSTI4 -16
BANDI4
ADDI4
ASGNI4
line 89
;88:
;89:	return p;
ADDRLP4 0
INDIRP4
RETP4
LABELV $40
endproc UI_Alloc 8 4
export UI_InitMemory
proc UI_InitMemory 0 0
line 97
;90:}
;91:
;92:/*
;93:===============
;94:UI_InitMemory
;95:===============
;96:*/
;97:void UI_InitMemory( void ) {
line 98
;98:	allocPoint = 0;
ADDRGP4 allocPoint
CNSTI4 0
ASGNI4
line 99
;99:	outOfMemory = qfalse;
ADDRGP4 outOfMemory
CNSTI4 0
ASGNI4
line 100
;100:}
LABELV $46
endproc UI_InitMemory 0 0
export UI_OutOfMemory
proc UI_OutOfMemory 0 0
line 102
;101:
;102:qboolean UI_OutOfMemory( void ) {
line 103
;103:	return outOfMemory;
ADDRGP4 outOfMemory
INDIRI4
RETI4
LABELV $47
endproc UI_OutOfMemory 0 0
proc hashForString 16 4
line 116
;104:}
;105:
;106:
;107:
;108:
;109:
;110:#define HASH_TABLE_SIZE 2048
;111:/*
;112:================
;113:return a hash value for the string
;114:================
;115:*/
;116:static long hashForString(const char *str) {
line 121
;117:	int		i;
;118:	long	hash;
;119:	char	letter;
;120:
;121:	hash = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 122
;122:	i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $50
JUMPV
LABELV $49
line 123
;123:	while (str[i] != '\0') {
line 124
;124:		letter = tolower(str[i]);
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 12
ADDRGP4 tolower
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CVII1 4
ASGNI1
line 125
;125:		hash+=(long)(letter)*(i+119);
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI1
CVII4 1
ADDRLP4 0
INDIRI4
CNSTI4 119
ADDI4
MULI4
ADDI4
ASGNI4
line 126
;126:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 127
;127:	}
LABELV $50
line 123
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $49
line 128
;128:	hash &= (HASH_TABLE_SIZE-1);
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 2047
BANDI4
ASGNI4
line 129
;129:	return hash;
ADDRLP4 8
INDIRI4
RETI4
LABELV $48
endproc hashForString 16 4
data
align 4
LABELV strPoolIndex
byte 4 0
align 4
LABELV strHandleCount
byte 4 0
align 4
LABELV $53
address $54
export String_Alloc
code
proc String_Alloc 40 8
line 144
;130:}
;131:
;132:typedef struct stringDef_s {
;133:	struct stringDef_s *next;
;134:	const char *str;
;135:} stringDef_t;
;136:
;137:static int strPoolIndex = 0;
;138:static char strPool[STRING_POOL_SIZE];
;139:
;140:static int strHandleCount = 0;
;141:static stringDef_t *strHandle[HASH_TABLE_SIZE];
;142:
;143:
;144:const char *String_Alloc(const char *p) {
line 150
;145:	int len;
;146:	long hash;
;147:	stringDef_t *str, *last;
;148:	static const char *staticNULL = "";
;149:
;150:	if (p == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $55
line 151
;151:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $52
JUMPV
LABELV $55
line 154
;152:	}
;153:
;154:	if (*p == 0) {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $57
line 155
;155:		return staticNULL;
ADDRGP4 $53
INDIRP4
RETP4
ADDRGP4 $52
JUMPV
LABELV $57
line 158
;156:	}
;157:
;158:	hash = hashForString(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 hashForString
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
ASGNI4
line 160
;159:
;160:	str = strHandle[hash];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 strHandle
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $60
JUMPV
LABELV $59
line 161
;161:	while (str) {
line 162
;162:		if (strcmp(p, str->str) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $62
line 163
;163:			return str->str;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
RETP4
ADDRGP4 $52
JUMPV
LABELV $62
line 165
;164:		}
;165:		str = str->next;
ADDRLP4 0
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 166
;166:	}
LABELV $60
line 161
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $59
line 168
;167:
;168:	len = strlen(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 12
ADDRLP4 20
INDIRU4
CVUI4 4
ASGNI4
line 169
;169:	if (len + strPoolIndex + 1 < STRING_POOL_SIZE) {
ADDRLP4 12
INDIRI4
ADDRGP4 strPoolIndex
INDIRI4
ADDI4
CNSTI4 1
ADDI4
CNSTI4 131072
GEI4 $64
line 170
;170:		int ph = strPoolIndex;
ADDRLP4 24
ADDRGP4 strPoolIndex
INDIRI4
ASGNI4
line 171
;171:		strcpy(&strPool[strPoolIndex], p);
ADDRGP4 strPoolIndex
INDIRI4
ADDRGP4 strPool
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 172
;172:		strPoolIndex += len + 1;
ADDRLP4 28
ADDRGP4 strPoolIndex
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ADDI4
ASGNI4
line 174
;173:
;174:		str = strHandle[hash];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 strHandle
ADDP4
INDIRP4
ASGNP4
line 175
;175:		last = str;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $67
JUMPV
LABELV $66
line 176
;176:		while (str && str->next) {
line 177
;177:			last = str;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 178
;178:			str = str->next;
ADDRLP4 0
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 179
;179:		}
LABELV $67
line 176
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $69
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $66
LABELV $69
line 181
;180:
;181:		str  = UI_Alloc(sizeof(stringDef_t));
CNSTI4 8
ARGI4
ADDRLP4 36
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
ASGNP4
line 182
;182:		str->next = NULL;
ADDRLP4 0
INDIRP4
CNSTP4 0
ASGNP4
line 183
;183:		str->str = &strPool[ph];
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 24
INDIRI4
ADDRGP4 strPool
ADDP4
ASGNP4
line 184
;184:		if (last) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $70
line 185
;185:			last->next = str;
ADDRLP4 4
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 186
;186:		} else {
ADDRGP4 $71
JUMPV
LABELV $70
line 187
;187:			strHandle[hash] = str;
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 strHandle
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 188
;188:		}
LABELV $71
line 189
;189:		return &strPool[ph];
ADDRLP4 24
INDIRI4
ADDRGP4 strPool
ADDP4
RETP4
ADDRGP4 $52
JUMPV
LABELV $64
line 191
;190:	}
;191:	return NULL;
CNSTP4 0
RETP4
LABELV $52
endproc String_Alloc 40 8
export String_Report
proc String_Report 4 16
line 194
;192:}
;193:
;194:void String_Report(void) {
line 196
;195:	float f;
;196:	Com_Printf("Memory/String Pool Info\n");
ADDRGP4 $73
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 197
;197:	Com_Printf("----------------\n");
ADDRGP4 $74
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 198
;198:	f = strPoolIndex;
ADDRLP4 0
ADDRGP4 strPoolIndex
INDIRI4
CVIF4 4
ASGNF4
line 199
;199:	f /= STRING_POOL_SIZE;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 922746880
MULF4
ASGNF4
line 200
;200:	f *= 100;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1120403456
MULF4
ASGNF4
line 201
;201:	Com_Printf("String Pool is %.1f%% full, %i bytes out of %i used.\n", f, strPoolIndex, STRING_POOL_SIZE);
ADDRGP4 $75
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 strPoolIndex
INDIRI4
ARGI4
CNSTI4 131072
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 202
;202:	f = allocPoint;
ADDRLP4 0
ADDRGP4 allocPoint
INDIRI4
CVIF4 4
ASGNF4
line 203
;203:	f /= MEM_POOL_SIZE;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 922746880
MULF4
ASGNF4
line 204
;204:	f *= 100;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1120403456
MULF4
ASGNF4
line 205
;205:	Com_Printf("Memory Pool is %.1f%% full, %i bytes out of %i used.\n", f, allocPoint, MEM_POOL_SIZE);
ADDRGP4 $76
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 allocPoint
INDIRI4
ARGI4
CNSTI4 131072
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 206
;206:}
LABELV $72
endproc String_Report 4 16
export String_Init
proc String_Init 8 0
line 213
;207:
;208:/*
;209:=================
;210:String_Init
;211:=================
;212:*/
;213:void String_Init(void) {
line 215
;214:	int i;
;215:	for (i = 0; i < HASH_TABLE_SIZE; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $78
line 216
;216:		strHandle[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 strHandle
ADDP4
CNSTP4 0
ASGNP4
line 217
;217:	}
LABELV $79
line 215
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2048
LTI4 $78
line 218
;218:	strHandleCount = 0;
ADDRGP4 strHandleCount
CNSTI4 0
ASGNI4
line 219
;219:	strPoolIndex = 0;
ADDRGP4 strPoolIndex
CNSTI4 0
ASGNI4
line 220
;220:	menuCount = 0;
ADDRGP4 menuCount
CNSTI4 0
ASGNI4
line 221
;221:	openMenuCount = 0;
ADDRGP4 openMenuCount
CNSTI4 0
ASGNI4
line 222
;222:	UI_InitMemory();
ADDRGP4 UI_InitMemory
CALLV
pop
line 223
;223:	Item_SetupKeywordHash();
ADDRGP4 Item_SetupKeywordHash
CALLV
pop
line 224
;224:	Menu_SetupKeywordHash();
ADDRGP4 Menu_SetupKeywordHash
CALLV
pop
line 225
;225:	if (DC && DC->getBindingBuf) {
ADDRLP4 4
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $82
ADDRLP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $82
line 226
;226:		Controls_GetConfig();
ADDRGP4 Controls_GetConfig
CALLV
pop
line 227
;227:	}
LABELV $82
line 228
;228:}
LABELV $77
endproc String_Init 8 0
bss
align 1
LABELV $85
skip 4096
export PC_SourceWarning
code
proc PC_SourceWarning 136 16
line 235
;229:
;230:/*
;231:=================
;232:PC_SourceWarning
;233:=================
;234:*/
;235:void PC_SourceWarning(int handle, char *format, ...) {
line 241
;236:	int line;
;237:	char filename[128];
;238:	va_list argptr;
;239:	static char string[4096];
;240:
;241:	va_start (argptr, format);
ADDRLP4 132
ADDRFP4 4+4
ASGNP4
line 242
;242:	ED_vsprintf (string, format, argptr);
ADDRGP4 $85
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRGP4 ED_vsprintf
CALLI4
pop
line 243
;243:	va_end (argptr);
ADDRLP4 132
CNSTP4 0
ASGNP4
line 245
;244:
;245:	filename[0] = '\0';
ADDRLP4 4
CNSTI1 0
ASGNI1
line 246
;246:	line = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 247
;247:	trap_PC_SourceFileAndLine(handle, filename, &line);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_PC_SourceFileAndLine
CALLI4
pop
line 249
;248:
;249:	Com_Printf(S_COLOR_YELLOW "WARNING: %s, line %d: %s\n", filename, line, string);
ADDRGP4 $87
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $85
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 250
;250:}
LABELV $84
endproc PC_SourceWarning 136 16
bss
align 1
LABELV $89
skip 4096
export PC_SourceError
code
proc PC_SourceError 136 16
line 257
;251:
;252:/*
;253:=================
;254:PC_SourceError
;255:=================
;256:*/
;257:void PC_SourceError(int handle, char *format, ...) {
line 263
;258:	int line;
;259:	char filename[128];
;260:	va_list argptr;
;261:	static char string[4096];
;262:
;263:	va_start (argptr, format);
ADDRLP4 132
ADDRFP4 4+4
ASGNP4
line 264
;264:	ED_vsprintf (string, format, argptr);
ADDRGP4 $89
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRGP4 ED_vsprintf
CALLI4
pop
line 265
;265:	va_end (argptr);
ADDRLP4 132
CNSTP4 0
ASGNP4
line 267
;266:
;267:	filename[0] = '\0';
ADDRLP4 4
CNSTI1 0
ASGNI1
line 268
;268:	line = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 269
;269:	trap_PC_SourceFileAndLine(handle, filename, &line);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_PC_SourceFileAndLine
CALLI4
pop
line 271
;270:
;271:	Com_Printf(S_COLOR_RED "ERROR: %s, line %d: %s\n", filename, line, string);
ADDRGP4 $91
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $89
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 272
;272:}
LABELV $88
endproc PC_SourceError 136 16
export LerpColor
proc LerpColor 12 0
line 280
;273:
;274:/*
;275:=================
;276:LerpColor
;277:=================
;278:*/
;279:void LerpColor(vec4_t a, vec4_t b, vec4_t c, float t)
;280:{
line 284
;281:	int i;
;282:
;283:	// lerp and clamp each component
;284:	for (i=0; i<4; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $93
line 285
;285:	{
line 286
;286:		c[i] = a[i] + t*(b[i]-a[i]);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 287
;287:		if (c[i] < 0)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $97
line 288
;288:			c[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $98
JUMPV
LABELV $97
line 289
;289:		else if (c[i] > 1.0)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
CNSTF4 1065353216
LEF4 $99
line 290
;290:			c[i] = 1.0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTF4 1065353216
ASGNF4
LABELV $99
LABELV $98
line 291
;291:	}
LABELV $94
line 284
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $93
line 292
;292:}
LABELV $92
endproc LerpColor 12 0
export Float_Parse
proc Float_Parse 16 8
line 299
;293:
;294:/*
;295:=================
;296:Float_Parse
;297:=================
;298:*/
;299:qboolean Float_Parse(char **p, float *f) {
line 301
;300:	char	*token;
;301:	token = COM_ParseExt(p, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 302
;302:	if (token && token[0] != 0) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $102
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $102
line 303
;303:		*f = atof(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRF4
ASGNF4
line 304
;304:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $101
JUMPV
LABELV $102
line 305
;305:	} else {
line 306
;306:		return qfalse;
CNSTI4 0
RETI4
LABELV $101
endproc Float_Parse 16 8
export PC_Float_Parse
proc PC_Float_Parse 1052 12
line 315
;307:	}
;308:}
;309:
;310:/*
;311:=================
;312:PC_Float_Parse
;313:=================
;314:*/
;315:qboolean PC_Float_Parse(int handle, float *f) {
line 317
;316:	pc_token_t token;
;317:	int negative = qfalse;
ADDRLP4 1040
CNSTI4 0
ASGNI4
line 319
;318:
;319:	if (!trap_PC_ReadToken(handle, &token))
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
NEI4 $105
line 320
;320:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $104
JUMPV
LABELV $105
line 321
;321:	if (token.string[0] == '-') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $107
line 322
;322:		if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
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
NEI4 $110
line 323
;323:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $104
JUMPV
LABELV $110
line 324
;324:		negative = qtrue;
ADDRLP4 1040
CNSTI4 1
ASGNI4
line 325
;325:	}
LABELV $107
line 326
;326:	if (token.type != TT_NUMBER) {
ADDRLP4 0
INDIRI4
CNSTI4 3
EQI4 $112
line 327
;327:		PC_SourceError(handle, "expected float but found %s\n", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $114
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 328
;328:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $104
JUMPV
LABELV $112
line 330
;329:	}
;330:	if (negative)
ADDRLP4 1040
INDIRI4
CNSTI4 0
EQI4 $116
line 331
;331:		*f = -token.floatvalue;
ADDRFP4 4
INDIRP4
ADDRLP4 0+12
INDIRF4
NEGF4
ASGNF4
ADDRGP4 $117
JUMPV
LABELV $116
line 333
;332:	else
;333:		*f = token.floatvalue;
ADDRFP4 4
INDIRP4
ADDRLP4 0+12
INDIRF4
ASGNF4
LABELV $117
line 334
;334:	return qtrue;
CNSTI4 1
RETI4
LABELV $104
endproc PC_Float_Parse 1052 12
export Color_Parse
proc Color_Parse 12 8
line 342
;335:}
;336:
;337:/*
;338:=================
;339:Color_Parse
;340:=================
;341:*/
;342:qboolean Color_Parse(char **p, vec4_t *c) {
line 346
;343:	int i;
;344:	float f;
;345:
;346:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $121
line 347
;347:		if (!Float_Parse(p, &f)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $125
line 348
;348:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $120
JUMPV
LABELV $125
line 350
;349:		}
;350:		(*c)[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 351
;351:	}
LABELV $122
line 346
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $121
line 352
;352:	return qtrue;
CNSTI4 1
RETI4
LABELV $120
endproc Color_Parse 12 8
export PC_Color_Parse
proc PC_Color_Parse 12 8
line 360
;353:}
;354:
;355:/*
;356:=================
;357:PC_Color_Parse
;358:=================
;359:*/
;360:qboolean PC_Color_Parse(int handle, vec4_t *c) {
line 364
;361:	int i;
;362:	float f;
;363:
;364:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $128
line 365
;365:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $132
line 366
;366:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $127
JUMPV
LABELV $132
line 368
;367:		}
;368:		(*c)[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 369
;369:	}
LABELV $129
line 364
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $128
line 370
;370:	return qtrue;
CNSTI4 1
RETI4
LABELV $127
endproc PC_Color_Parse 12 8
export Int_Parse
proc Int_Parse 16 8
line 378
;371:}
;372:
;373:/*
;374:=================
;375:Int_Parse
;376:=================
;377:*/
;378:qboolean Int_Parse(char **p, int *i) {
line 380
;379:	char	*token;
;380:	token = COM_ParseExt(p, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 382
;381:
;382:	if (token && token[0] != 0) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $135
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $135
line 383
;383:		*i = atoi(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 384
;384:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $134
JUMPV
LABELV $135
line 385
;385:	} else {
line 386
;386:		return qfalse;
CNSTI4 0
RETI4
LABELV $134
endproc Int_Parse 16 8
export PC_Int_Parse
proc PC_Int_Parse 1052 12
line 395
;387:	}
;388:}
;389:
;390:/*
;391:=================
;392:PC_Int_Parse
;393:=================
;394:*/
;395:qboolean PC_Int_Parse(int handle, int *i) {
line 397
;396:	pc_token_t token;
;397:	int negative = qfalse;
ADDRLP4 1040
CNSTI4 0
ASGNI4
line 399
;398:
;399:	if (!trap_PC_ReadToken(handle, &token))
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
NEI4 $138
line 400
;400:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $137
JUMPV
LABELV $138
line 401
;401:	if (token.string[0] == '-') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $140
line 402
;402:		if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
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
NEI4 $143
line 403
;403:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $137
JUMPV
LABELV $143
line 404
;404:		negative = qtrue;
ADDRLP4 1040
CNSTI4 1
ASGNI4
line 405
;405:	}
LABELV $140
line 406
;406:	if (token.type != TT_NUMBER) {
ADDRLP4 0
INDIRI4
CNSTI4 3
EQI4 $145
line 407
;407:		PC_SourceError(handle, "expected integer but found %s\n", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $147
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 408
;408:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $137
JUMPV
LABELV $145
line 410
;409:	}
;410:	*i = token.intvalue;
ADDRFP4 4
INDIRP4
ADDRLP4 0+8
INDIRI4
ASGNI4
line 411
;411:	if (negative)
ADDRLP4 1040
INDIRI4
CNSTI4 0
EQI4 $150
line 412
;412:		*i = - *i;
ADDRLP4 1048
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 1048
INDIRP4
ADDRLP4 1048
INDIRP4
INDIRI4
NEGI4
ASGNI4
LABELV $150
line 413
;413:	return qtrue;
CNSTI4 1
RETI4
LABELV $137
endproc PC_Int_Parse 1052 12
export Rect_Parse
proc Rect_Parse 16 8
line 421
;414:}
;415:
;416:/*
;417:=================
;418:Rect_Parse
;419:=================
;420:*/
;421:qboolean Rect_Parse(char **p, rectDef_t *r) {
line 422
;422:	if (Float_Parse(p, &r->x)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $153
line 423
;423:		if (Float_Parse(p, &r->y)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $155
line 424
;424:			if (Float_Parse(p, &r->w)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $157
line 425
;425:				if (Float_Parse(p, &r->h)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $159
line 426
;426:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $152
JUMPV
LABELV $159
line 428
;427:				}
;428:			}
LABELV $157
line 429
;429:		}
LABELV $155
line 430
;430:	}
LABELV $153
line 431
;431:	return qfalse;
CNSTI4 0
RETI4
LABELV $152
endproc Rect_Parse 16 8
export PC_Rect_Parse
proc PC_Rect_Parse 16 8
line 439
;432:}
;433:
;434:/*
;435:=================
;436:PC_Rect_Parse
;437:=================
;438:*/
;439:qboolean PC_Rect_Parse(int handle, rectDef_t *r) {
line 440
;440:	if (PC_Float_Parse(handle, &r->x)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $162
line 441
;441:		if (PC_Float_Parse(handle, &r->y)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $164
line 442
;442:			if (PC_Float_Parse(handle, &r->w)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $166
line 443
;443:				if (PC_Float_Parse(handle, &r->h)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $168
line 444
;444:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $161
JUMPV
LABELV $168
line 446
;445:				}
;446:			}
LABELV $166
line 447
;447:		}
LABELV $164
line 448
;448:	}
LABELV $162
line 449
;449:	return qfalse;
CNSTI4 0
RETI4
LABELV $161
endproc PC_Rect_Parse 16 8
export String_Parse
proc String_Parse 16 8
line 457
;450:}
;451:
;452:/*
;453:=================
;454:String_Parse
;455:=================
;456:*/
;457:qboolean String_Parse(char **p, const char **out) {
line 460
;458:	char *token;
;459:
;460:	token = COM_ParseExt(p, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 461
;461:	if (token && token[0] != 0) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $171
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $171
line 462
;462:		*(out) = String_Alloc(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRP4
ASGNP4
line 463
;463:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $170
JUMPV
LABELV $171
line 465
;464:	}
;465:	return qfalse;
CNSTI4 0
RETI4
LABELV $170
endproc String_Parse 16 8
export PC_String_Parse
proc PC_String_Parse 1048 8
line 473
;466:}
;467:
;468:/*
;469:=================
;470:PC_String_Parse
;471:=================
;472:*/
;473:qboolean PC_String_Parse(int handle, const char **out) {
line 476
;474:	pc_token_t token;
;475:
;476:	if (!trap_PC_ReadToken(handle, &token))
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
NEI4 $174
line 477
;477:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $173
JUMPV
LABELV $174
line 479
;478:	
;479:	*(out) = String_Alloc(token.string);
ADDRLP4 0+16
ARGP4
ADDRLP4 1044
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ADDRLP4 1044
INDIRP4
ASGNP4
line 480
;480:    return qtrue;
CNSTI4 1
RETI4
LABELV $173
endproc PC_String_Parse 1048 8
export PC_Script_Parse
proc PC_Script_Parse 2084 12
line 488
;481:}
;482:
;483:/*
;484:=================
;485:PC_Script_Parse
;486:=================
;487:*/
;488:qboolean PC_Script_Parse(int handle, const char **out) {
line 492
;489:	char script[1024];
;490:	pc_token_t token;
;491:
;492:	memset(script, 0, sizeof(script));
ADDRLP4 1040
ARGP4
CNSTI4 0
ARGI4
CNSTU4 1024
ARGU4
ADDRGP4 memset
CALLP4
pop
line 496
;493:	// scripts start with { and have ; separated command lists.. commands are command, arg.. 
;494:	// basically we want everything between the { } as it will be interpreted at run time
;495:  
;496:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 2064
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 2064
INDIRI4
CNSTI4 0
NEI4 $178
line 497
;497:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $177
JUMPV
LABELV $178
line 498
;498:	if (Q_stricmp(token.string, "{") != 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $183
ARGP4
ADDRLP4 2068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 0
EQI4 $185
line 499
;499:	    return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $177
JUMPV
LABELV $184
line 502
;500:	}
;501:
;502:	while ( 1 ) {
line 503
;503:		if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 2072
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 2072
INDIRI4
CNSTI4 0
NEI4 $187
line 504
;504:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $177
JUMPV
LABELV $187
line 506
;505:
;506:		if (Q_stricmp(token.string, "}") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $192
ARGP4
ADDRLP4 2076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2076
INDIRI4
CNSTI4 0
NEI4 $189
line 507
;507:			*out = String_Alloc(script);
ADDRLP4 1040
ARGP4
ADDRLP4 2080
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ADDRLP4 2080
INDIRP4
ASGNP4
line 508
;508:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $177
JUMPV
LABELV $189
line 511
;509:		}
;510:
;511:		if (token.string[1] != '\0') {
ADDRLP4 0+16+1
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $193
line 512
;512:			Q_strcat(script, 1024, va("\"%s\"", token.string));
ADDRGP4 $197
ARGP4
ADDRLP4 0+16
ARGP4
ADDRLP4 2080
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1040
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2080
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 513
;513:		} else {
ADDRGP4 $194
JUMPV
LABELV $193
line 514
;514:			Q_strcat(script, 1024, token.string);
ADDRLP4 1040
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 0+16
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 515
;515:		}
LABELV $194
line 516
;516:		Q_strcat(script, 1024, " ");
ADDRLP4 1040
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $200
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 517
;517:	}
LABELV $185
line 502
ADDRGP4 $184
JUMPV
line 518
;518:	return qfalse; 	// bk001105 - LCC   missing return value
CNSTI4 0
RETI4
LABELV $177
endproc PC_Script_Parse 2084 12
export Init_Display
proc Init_Display 0 0
line 531
;519:}
;520:
;521:// display, window, menu, item code
;522:// 
;523:
;524:/*
;525:==================
;526:Init_Display
;527:
;528:Initializes the display with a structure to all the drawing routines
;529: ==================
;530:*/
;531:void Init_Display(displayContextDef_t *dc) {
line 532
;532:	DC = dc;
ADDRGP4 DC
ADDRFP4 0
INDIRP4
ASGNP4
line 533
;533:}
LABELV $201
endproc Init_Display 0 0
export GradientBar_Paint
proc GradientBar_Paint 8 20
line 539
;534:
;535:
;536:
;537:// type and style painting 
;538:
;539:void GradientBar_Paint(rectDef_t *rect, vec4_t color) {
line 541
;540:	// gradient bar takes two paints
;541:	DC->setColor( color );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 542
;542:	DC->drawHandlePic(rect->x, rect->y, rect->w, rect->h, DC->Assets.gradientBar);
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
ADDRLP4 4
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 61888
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 543
;543:	DC->setColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 544
;544:}
LABELV $202
endproc GradientBar_Paint 8 20
export Window_Init
proc Window_Init 8 12
line 555
;545:
;546:
;547:/*
;548:==================
;549:Window_Init
;550:
;551:Initializes a window structure ( windowDef_t ) with defaults
;552: 
;553:==================
;554:*/
;555:void Window_Init(Window *w) {
line 556
;556:	memset(w, 0, sizeof(windowDef_t));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 180
ARGU4
ADDRGP4 memset
CALLP4
pop
line 557
;557:	w->borderSize = 1;
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTF4 1065353216
ASGNF4
line 558
;558:	w->foreColor[0] = w->foreColor[1] = w->foreColor[2] = w->foreColor[3] = 1.0;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 559
;559:	w->cinematic = -1;
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 -1
ASGNI4
line 560
;560:}
LABELV $203
endproc Window_Init 8 12
export Fade
proc Fade 8 0
line 562
;561:
;562:void Fade(int *flags, float *f, float clamp, int *nextTime, int offsetTime, qboolean bFlags, float fadeAmount) {
line 563
;563:  if (*flags & (WINDOW_FADINGOUT | WINDOW_FADINGIN)) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 96
BANDI4
CNSTI4 0
EQI4 $205
line 564
;564:    if (DC->realTime > *nextTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRFP4 12
INDIRP4
INDIRI4
LEI4 $207
line 565
;565:      *nextTime = DC->realTime + offsetTime;
ADDRFP4 12
INDIRP4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRFP4 16
INDIRI4
ADDI4
ASGNI4
line 566
;566:      if (*flags & WINDOW_FADINGOUT) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $209
line 567
;567:        *f -= fadeAmount;
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 24
INDIRF4
SUBF4
ASGNF4
line 568
;568:        if (bFlags && *f <= 0.0) {
ADDRFP4 20
INDIRI4
CNSTI4 0
EQI4 $210
ADDRFP4 4
INDIRP4
INDIRF4
CNSTF4 0
GTF4 $210
line 569
;569:          *flags &= ~(WINDOW_FADINGOUT | WINDOW_VISIBLE);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -37
BANDI4
ASGNI4
line 570
;570:        }
line 571
;571:      } else {
ADDRGP4 $210
JUMPV
LABELV $209
line 572
;572:        *f += fadeAmount;
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 24
INDIRF4
ADDF4
ASGNF4
line 573
;573:        if (*f >= clamp) {
ADDRFP4 4
INDIRP4
INDIRF4
ADDRFP4 8
INDIRF4
LTF4 $213
line 574
;574:          *f = clamp;
ADDRFP4 4
INDIRP4
ADDRFP4 8
INDIRF4
ASGNF4
line 575
;575:          if (bFlags) {
ADDRFP4 20
INDIRI4
CNSTI4 0
EQI4 $215
line 576
;576:            *flags &= ~WINDOW_FADINGIN;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -65
BANDI4
ASGNI4
line 577
;577:          }
LABELV $215
line 578
;578:        }
LABELV $213
line 579
;579:      }
LABELV $210
line 580
;580:    }
LABELV $207
line 581
;581:  }
LABELV $205
line 582
;582:}
LABELV $204
endproc Fade 8 0
export Window_Paint
proc Window_Paint 64 36
line 586
;583:
;584:
;585:
;586:void Window_Paint(Window *w, float fadeAmount, float fadeClamp, float fadeCycle) {
line 589
;587:	//float bordersize = 0;
;588:	vec4_t color;
;589:	rectDef_t fillRect = w->rect;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 16
line 590
;590:	qboolean isfullscreen = qfalse;
ADDRLP4 32
CNSTI4 0
ASGNI4
line 593
;591:
;592:
;593:	if (debugMode) {
ADDRGP4 debugMode
INDIRI4
CNSTI4 0
EQI4 $218
line 594
;594:		color[0] = color[1] = color[2] = color[3] = 1;
ADDRLP4 36
CNSTF4 1065353216
ASGNF4
ADDRLP4 16+12
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 36
INDIRF4
ASGNF4
line 595
;595:		DC->drawRect(w->rect.x, w->rect.y, w->rect.w, w->rect.h, 1, color);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 16
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 596
;596:	}
LABELV $218
line 598
;597:
;598:	if (w == NULL || (w->style == 0 && w->border == 0)) {
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $225
ADDRLP4 36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 0
NEI4 $223
ADDRLP4 36
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
NEI4 $223
LABELV $225
line 599
;599:		return;
ADDRGP4 $217
JUMPV
LABELV $223
line 602
;600:	}
;601:
;602:	if (w->border != 0) {
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $226
line 603
;603:		fillRect.x += w->borderSize;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 604
;604:		fillRect.y += w->borderSize;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 605
;605:		fillRect.w -= w->borderSize + 1;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
SUBF4
ASGNF4
line 606
;606:		fillRect.h -= w->borderSize + 1;
ADDRLP4 0+12
ADDRLP4 0+12
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
SUBF4
ASGNF4
line 607
;607:	}
LABELV $226
line 609
;608:
;609:	if ( w->background && w->rect.x == 0 && w->rect.y == 0 && w->rect.w == 640 && w->rect.h == 480 ) {
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 0
EQI4 $231
ADDRLP4 40
INDIRP4
INDIRF4
CNSTF4 0
NEF4 $231
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 0
NEF4 $231
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1142947840
NEF4 $231
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1139802112
NEF4 $231
line 610
;610:		isfullscreen = qtrue;
ADDRLP4 32
CNSTI4 1
ASGNI4
line 611
;611:	}
LABELV $231
line 613
;612:
;613:	if (w->style == WINDOW_STYLE_FILLED) {
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 1
NEI4 $233
line 615
;614:		// box, but possible a shader that needs filled
;615:		if (w->background) {
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 0
EQI4 $235
line 616
;616:			Fade(&w->flags, &w->backColor[3], fadeClamp, &w->nextTime, fadeCycle, qtrue, fadeAmount);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 68
ADDP4
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 140
ADDP4
ARGP4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 108
ADDP4
ARGP4
ADDRFP4 12
INDIRF4
CVFI4 4
ARGI4
CNSTI4 1
ARGI4
ADDRFP4 4
INDIRF4
ARGF4
ADDRGP4 Fade
CALLV
pop
line 617
;617:			DC->setColor(w->backColor);
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 618
;618:			if( isfullscreen ) {
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $237
line 619
;619:				DC->drawStretchPic(0, 0, DC->glconfig.vidWidth, DC->glconfig.vidHeight, 0, 0, 1, 1, w->background);
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 48
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 73348
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 48
INDIRP4
CNSTI4 73352
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
CALLV
pop
line 620
;620:			} else {
ADDRGP4 $238
JUMPV
LABELV $237
line 621
;621:				DC->drawHandlePic(fillRect.x, fillRect.y, fillRect.w, fillRect.h, w->background);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 0+12
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 622
;622:			}
LABELV $238
line 623
;623:			DC->setColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 624
;624:		} else {
ADDRGP4 $234
JUMPV
LABELV $235
line 625
;625:			DC->fillRect(fillRect.x, fillRect.y, fillRect.w, fillRect.h, w->backColor);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 0+12
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
CALLV
pop
line 626
;626:		}
line 627
;627:	} else if (w->style == WINDOW_STYLE_GRADIENT) {
ADDRGP4 $234
JUMPV
LABELV $233
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 2
NEI4 $245
line 628
;628:		GradientBar_Paint(&fillRect, w->backColor);
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRGP4 GradientBar_Paint
CALLV
pop
line 630
;629:		// gradient bar
;630:	} else if (w->style == WINDOW_STYLE_SHADER) {
ADDRGP4 $246
JUMPV
LABELV $245
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 3
NEI4 $247
line 631
;631:		if (w->flags & WINDOW_FORECOLORSET) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $249
line 632
;632:			DC->setColor(w->foreColor);
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 633
;633:		}
LABELV $249
line 634
;634:		if( isfullscreen ) {
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $251
line 635
;635:			DC->drawStretchPic(0, 0, DC->glconfig.vidWidth, DC->glconfig.vidHeight, 0, 0, 1, 1, w->background);
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 44
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 73348
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 73352
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
CALLV
pop
line 636
;636:		} else {
ADDRGP4 $252
JUMPV
LABELV $251
line 637
;637:			DC->drawHandlePic(fillRect.x, fillRect.y, fillRect.w, fillRect.h, w->background);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 0+12
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 638
;638:		}
LABELV $252
line 639
;639:		DC->setColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 640
;640:	} else if (w->style == WINDOW_STYLE_TEAMCOLOR) {
ADDRGP4 $248
JUMPV
LABELV $247
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 4
NEI4 $256
line 641
;641:		if (DC->getTeamColor) {
ADDRGP4 DC
INDIRP4
CNSTI4 84
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $257
line 642
;642:			DC->getTeamColor(&color);
ADDRLP4 16
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 84
ADDP4
INDIRP4
CALLV
pop
line 643
;643:			DC->fillRect(fillRect.x, fillRect.y, fillRect.w, fillRect.h, color);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 0+12
INDIRF4
ARGF4
ADDRLP4 16
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
CALLV
pop
line 644
;644:		}
line 645
;645:	} else if (w->style == WINDOW_STYLE_CINEMATIC) {
ADDRGP4 $257
JUMPV
LABELV $256
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
NEI4 $263
line 646
;646:			if (w->cinematic == -1) {
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $265
line 647
;647:				w->cinematic = DC->playCinematic(w->cinematicName, fillRect.x, fillRect.y, fillRect.w, fillRect.h);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 0+12
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 DC
INDIRP4
CNSTI4 180
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 44
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 48
INDIRI4
ASGNI4
line 648
;648:				if (w->cinematic == -1) {
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $270
line 649
;649:					w->cinematic = -2;
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 -2
ASGNI4
line 650
;650:				}
LABELV $270
line 651
;651:			} 
LABELV $265
line 652
;652:			if (w->cinematic >= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LTI4 $272
line 653
;653:				DC->runCinematicFrame(w->cinematic);
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 192
ADDP4
INDIRP4
CALLV
pop
line 654
;654:				DC->drawCinematic(w->cinematic, fillRect.x, fillRect.y, fillRect.w, fillRect.h);
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 0+12
INDIRF4
ARGF4
ADDRGP4 DC
INDIRP4
CNSTI4 188
ADDP4
INDIRP4
CALLV
pop
line 655
;655:			}
LABELV $272
line 656
;656:	}
LABELV $263
LABELV $257
LABELV $248
LABELV $246
LABELV $234
line 658
;657:
;658:	if (w->border == WINDOW_BORDER_FULL) {
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 1
NEI4 $277
line 661
;659:		// full
;660:		// HACK HACK HACK
;661:		if (w->style == WINDOW_STYLE_TEAMCOLOR) {
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 4
NEI4 $279
line 662
;662:			if (color[0] > 0) { 
ADDRLP4 16
INDIRF4
CNSTF4 0
LEF4 $281
line 664
;663:				// red
;664:				color[0] = 1;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
line 665
;665:				color[1] = color[2] = .5;
ADDRLP4 44
CNSTF4 1056964608
ASGNF4
ADDRLP4 16+8
ADDRLP4 44
INDIRF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 44
INDIRF4
ASGNF4
line 667
;666:
;667:			} else {
ADDRGP4 $282
JUMPV
LABELV $281
line 668
;668:				color[2] = 1;
ADDRLP4 16+8
CNSTF4 1065353216
ASGNF4
line 669
;669:				color[0] = color[1] = .5;
ADDRLP4 44
CNSTF4 1056964608
ASGNF4
ADDRLP4 16+4
ADDRLP4 44
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 44
INDIRF4
ASGNF4
line 670
;670:			}
LABELV $282
line 671
;671:			color[3] = 1;
ADDRLP4 16+12
CNSTF4 1065353216
ASGNF4
line 672
;672:			DC->drawRect(w->rect.x, w->rect.y, w->rect.w, w->rect.h, w->borderSize, color);
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
ADDRLP4 44
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 673
;673:		} else {
ADDRGP4 $278
JUMPV
LABELV $279
line 674
;674:			DC->drawRect(w->rect.x, w->rect.y, w->rect.w, w->rect.h, w->borderSize, w->borderColor);
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
ADDRLP4 44
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 675
;675:		}
line 676
;676:	} else if (w->border == WINDOW_BORDER_HORZ) {
ADDRGP4 $278
JUMPV
LABELV $277
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 2
NEI4 $288
line 678
;677:		// top/bottom
;678:		DC->setColor(w->borderColor);
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 679
;679:		DC->drawTopBottom(w->rect.x, w->rect.y, w->rect.w, w->rect.h, w->borderSize);
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
ADDRLP4 44
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ARGF4
ADDRGP4 DC
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CALLV
pop
line 680
;680:		DC->setColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 681
;681:	} else if (w->border == WINDOW_BORDER_VERT) {
ADDRGP4 $289
JUMPV
LABELV $288
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 3
NEI4 $290
line 683
;682:		// left right
;683:		DC->setColor(w->borderColor);
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 684
;684:		DC->drawSides(w->rect.x, w->rect.y, w->rect.w, w->rect.h, w->borderSize);
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
ADDRLP4 44
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ARGF4
ADDRGP4 DC
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
CALLV
pop
line 685
;685:		DC->setColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 686
;686:	} else if (w->border == WINDOW_BORDER_KCGRADIENT) {
ADDRGP4 $291
JUMPV
LABELV $290
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 4
NEI4 $292
line 688
;687:		// this is just two gradient bars along each horz edge
;688:		rectDef_t r = w->rect;
ADDRLP4 44
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 16
line 689
;689:		r.h = w->borderSize;
ADDRLP4 44+12
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ASGNF4
line 690
;690:		GradientBar_Paint(&r, w->borderColor);
ADDRLP4 44
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 GradientBar_Paint
CALLV
pop
line 691
;691:		r.y = w->rect.y + w->rect.h - 1;
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44+4
ADDRLP4 60
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 692
;692:		GradientBar_Paint(&r, w->borderColor);
ADDRLP4 44
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 GradientBar_Paint
CALLV
pop
line 693
;693:	}
LABELV $292
LABELV $291
LABELV $289
LABELV $278
line 694
;694:}
LABELV $217
endproc Window_Paint 64 36
export Item_SetScreenCoords
proc Item_SetScreenCoords 16 0
line 697
;695:
;696:
;697:void Item_SetScreenCoords(itemDef_t *item, float x, float y) {
line 699
;698:  
;699:  if (item == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $297
line 700
;700:    return;
ADDRGP4 $296
JUMPV
LABELV $297
line 703
;701:  }
;702:
;703:  if (item->window.border != 0) {
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $299
line 704
;704:    x += item->window.borderSize;
ADDRFP4 4
ADDRFP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 705
;705:    y += item->window.borderSize;
ADDRFP4 8
ADDRFP4 8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 706
;706:  }
LABELV $299
line 708
;707:
;708:  item->window.rect.x = x + item->window.rectClient.x;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRFP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDF4
ASGNF4
line 709
;709:  item->window.rect.y = y + item->window.rectClient.y;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 8
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDF4
ASGNF4
line 710
;710:  item->window.rect.w = item->window.rectClient.w;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 711
;711:  item->window.rect.h = item->window.rectClient.h;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ASGNF4
line 714
;712:
;713:  // force the text rects to recompute
;714:  item->textRect.w = 0;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 0
ASGNF4
line 715
;715:  item->textRect.h = 0;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 0
ASGNF4
line 716
;716:}
LABELV $296
endproc Item_SetScreenCoords 16 0
export Item_UpdatePosition
proc Item_UpdatePosition 16 12
line 719
;717:
;718:// FIXME: consolidate this with nearby stuff
;719:void Item_UpdatePosition(itemDef_t *item) {
line 723
;720:  float x, y;
;721:  menuDef_t *menu;
;722:  
;723:  if (item == NULL || item->parent == NULL) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $304
ADDRLP4 12
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $302
LABELV $304
line 724
;724:    return;
ADDRGP4 $301
JUMPV
LABELV $302
line 727
;725:  }
;726:
;727:  menu = item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 729
;728:
;729:  x = menu->window.rect.x;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRF4
ASGNF4
line 730
;730:  y = menu->window.rect.y;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 732
;731:  
;732:  if (menu->window.border != 0) {
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $305
line 733
;733:    x += menu->window.borderSize;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 734
;734:    y += menu->window.borderSize;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 735
;735:  }
LABELV $305
line 737
;736:
;737:  Item_SetScreenCoords(item, x, y);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 Item_SetScreenCoords
CALLV
pop
line 739
;738:
;739:}
LABELV $301
endproc Item_UpdatePosition 16 12
export Menu_UpdatePosition
proc Menu_UpdatePosition 12 12
line 742
;740:
;741:// menus
;742:void Menu_UpdatePosition(menuDef_t *menu) {
line 746
;743:  int i;
;744:  float x, y;
;745:
;746:  if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $308
line 747
;747:    return;
ADDRGP4 $307
JUMPV
LABELV $308
line 750
;748:  }
;749:  
;750:  x = menu->window.rect.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 751
;751:  y = menu->window.rect.y;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 752
;752:  if (menu->window.border != 0) {
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $310
line 753
;753:    x += menu->window.borderSize;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 754
;754:    y += menu->window.borderSize;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 755
;755:  }
LABELV $310
line 757
;756:
;757:  for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $315
JUMPV
LABELV $312
line 758
;758:    Item_SetScreenCoords(menu->items[i], x, y);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 Item_SetScreenCoords
CALLV
pop
line 759
;759:  }
LABELV $313
line 757
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $315
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $312
line 760
;760:}
LABELV $307
endproc Menu_UpdatePosition 12 12
export Menu_PostParse
proc Menu_PostParse 0 4
line 762
;761:
;762:void Menu_PostParse(menuDef_t *menu) {
line 763
;763:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $317
line 764
;764:		return;
ADDRGP4 $316
JUMPV
LABELV $317
line 766
;765:	}
;766:	if (menu->fullScreen) {
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
EQI4 $319
line 767
;767:		menu->window.rect.x = 0;
ADDRFP4 0
INDIRP4
CNSTF4 0
ASGNF4
line 768
;768:		menu->window.rect.y = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
line 769
;769:		menu->window.rect.w = 640;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1142947840
ASGNF4
line 770
;770:		menu->window.rect.h = 480;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1139802112
ASGNF4
line 771
;771:	}
LABELV $319
line 772
;772:	Menu_UpdatePosition(menu);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_UpdatePosition
CALLV
pop
line 773
;773:}
LABELV $316
endproc Menu_PostParse 0 4
export Menu_ClearFocus
proc Menu_ClearFocus 20 8
line 775
;774:
;775:itemDef_t *Menu_ClearFocus(menuDef_t *menu) {
line 777
;776:  int i;
;777:  itemDef_t *ret = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 779
;778:
;779:  if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $322
line 780
;780:    return NULL;
CNSTP4 0
RETP4
ADDRGP4 $321
JUMPV
LABELV $322
line 783
;781:  }
;782:
;783:  for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $327
JUMPV
LABELV $324
line 784
;784:    if (menu->items[i]->window.flags & WINDOW_HASFOCUS) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $328
line 785
;785:      ret = menu->items[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
line 786
;786:    } 
LABELV $328
line 787
;787:    menu->items[i]->window.flags &= ~WINDOW_HASFOCUS;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 788
;788:    if (menu->items[i]->leaveFocus) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 260
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $330
line 789
;789:      Item_RunScript(menu->items[i], menu->items[i]->leaveFocus);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 260
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 790
;790:    }
LABELV $330
line 791
;791:  }
LABELV $325
line 783
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $327
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $324
line 793
;792: 
;793:  return ret;
ADDRLP4 4
INDIRP4
RETP4
LABELV $321
endproc Menu_ClearFocus 20 8
export IsVisible
proc IsVisible 8 0
line 796
;794:}
;795:
;796:qboolean IsVisible(int flags) {
line 797
;797:  return (flags & WINDOW_VISIBLE && !(flags & WINDOW_FADINGOUT));
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $334
ADDRLP4 4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $334
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $335
JUMPV
LABELV $334
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $335
ADDRLP4 0
INDIRI4
RETI4
LABELV $332
endproc IsVisible 8 0
export Rect_ContainsPoint
proc Rect_ContainsPoint 16 0
line 800
;798:}
;799:
;800:qboolean Rect_ContainsPoint(rectDef_t *rect, float x, float y) {
line 801
;801:  if (rect) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $337
line 802
;802:    if (x > rect->x && x < rect->x + rect->w && y > rect->y && y < rect->y + rect->h) {
ADDRLP4 0
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 4
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $339
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
GEF4 $339
ADDRLP4 12
ADDRFP4 8
INDIRF4
ASGNF4
ADDRLP4 12
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
LEF4 $339
ADDRLP4 12
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
GEF4 $339
line 803
;803:      return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $336
JUMPV
LABELV $339
line 805
;804:    }
;805:  }
LABELV $337
line 806
;806:  return qfalse;
CNSTI4 0
RETI4
LABELV $336
endproc Rect_ContainsPoint 16 0
export Menu_ItemsMatchingGroup
proc Menu_ItemsMatchingGroup 24 8
line 809
;807:}
;808:
;809:int Menu_ItemsMatchingGroup(menuDef_t *menu, const char *name) {
line 811
;810:  int i;
;811:  int count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 812
;812:  for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $345
JUMPV
LABELV $342
line 813
;813:    if (Q_stricmp(menu->items[i]->window.name, name) == 0 || (menu->items[i]->window.group && Q_stricmp(menu->items[i]->window.group, name) == 0)) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $348
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $346
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 36
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
NEI4 $346
LABELV $348
line 814
;814:      count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 815
;815:    } 
LABELV $346
line 816
;816:  }
LABELV $343
line 812
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $345
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $342
line 817
;817:  return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $341
endproc Menu_ItemsMatchingGroup 24 8
export Menu_GetMatchingItemByNumber
proc Menu_GetMatchingItemByNumber 24 8
line 820
;818:}
;819:
;820:itemDef_t *Menu_GetMatchingItemByNumber(menuDef_t *menu, int index, const char *name) {
line 822
;821:  int i;
;822:  int count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 823
;823:  for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $353
JUMPV
LABELV $350
line 824
;824:    if (Q_stricmp(menu->items[i]->window.name, name) == 0 || (menu->items[i]->window.group && Q_stricmp(menu->items[i]->window.group, name) == 0)) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $356
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $354
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $354
LABELV $356
line 825
;825:      if (count == index) {
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $357
line 826
;826:        return menu->items[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $349
JUMPV
LABELV $357
line 828
;827:      }
;828:      count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 829
;829:    } 
LABELV $354
line 830
;830:  }
LABELV $351
line 823
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $353
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $350
line 831
;831:  return NULL;
CNSTP4 0
RETP4
LABELV $349
endproc Menu_GetMatchingItemByNumber 24 8
export Script_SetColor
proc Script_SetColor 36 8
line 836
;832:}
;833:
;834:
;835:
;836:void Script_SetColor(itemDef_t *item, char **args) {
line 842
;837:  const char *name;
;838:  int i;
;839:  float f;
;840:  vec4_t *out;
;841:  // expecting type of color to set and 4 args for the color
;842:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 16
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $360
line 843
;843:      out = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 844
;844:      if (Q_stricmp(name, "backcolor") == 0) {
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $364
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $362
line 845
;845:        out = &item->window.backColor;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ASGNP4
line 846
;846:        item->window.flags |= WINDOW_BACKCOLORSET;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 4194304
BORI4
ASGNI4
line 847
;847:      } else if (Q_stricmp(name, "forecolor") == 0) {
ADDRGP4 $363
JUMPV
LABELV $362
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $367
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $365
line 848
;848:        out = &item->window.foreColor;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ASGNP4
line 849
;849:        item->window.flags |= WINDOW_FORECOLORSET;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 850
;850:      } else if (Q_stricmp(name, "bordercolor") == 0) {
ADDRGP4 $366
JUMPV
LABELV $365
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $370
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $368
line 851
;851:        out = &item->window.borderColor;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
ASGNP4
line 852
;852:      }
LABELV $368
LABELV $366
LABELV $363
line 854
;853:
;854:      if (out) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $371
line 855
;855:        for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $373
line 856
;856:          if (!Float_Parse(args, &f)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 32
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $377
line 857
;857:            return;
ADDRGP4 $359
JUMPV
LABELV $377
line 859
;858:          }
;859:          (*out)[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 860
;860:        }
LABELV $374
line 855
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $373
line 861
;861:      }
LABELV $371
line 862
;862:  }
LABELV $360
line 863
;863:}
LABELV $359
endproc Script_SetColor 36 8
export Script_SetAsset
proc Script_SetAsset 8 8
line 865
;864:
;865:void Script_SetAsset(itemDef_t *item, char **args) {
line 868
;866:  const char *name;
;867:  // expecting name to set asset to
;868:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $380
line 870
;869:    // check for a model 
;870:    if (item->type == ITEM_TYPE_MODEL) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 7
NEI4 $382
line 871
;871:    }
LABELV $382
line 872
;872:  }
LABELV $380
line 873
;873:}
LABELV $379
endproc Script_SetAsset 8 8
export Script_SetBackground
proc Script_SetBackground 12 8
line 875
;874:
;875:void Script_SetBackground(itemDef_t *item, char **args) {
line 878
;876:  const char *name;
;877:  // expecting name to set asset to
;878:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $385
line 879
;879:    item->window.background = DC->registerShaderNoMip(name);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 880
;880:  }
LABELV $385
line 881
;881:}
LABELV $384
endproc Script_SetBackground 12 8
export Menu_FindItemByName
proc Menu_FindItemByName 8 8
line 886
;882:
;883:
;884:
;885:
;886:itemDef_t *Menu_FindItemByName(menuDef_t *menu, const char *p) {
line 888
;887:  int i;
;888:  if (menu == NULL || p == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $390
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $388
LABELV $390
line 889
;889:    return NULL;
CNSTP4 0
RETP4
ADDRGP4 $387
JUMPV
LABELV $388
line 892
;890:  }
;891:
;892:  for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $394
JUMPV
LABELV $391
line 893
;893:    if (Q_stricmp(p, menu->items[i]->window.name) == 0) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 32
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
NEI4 $395
line 894
;894:      return menu->items[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $387
JUMPV
LABELV $395
line 896
;895:    }
;896:  }
LABELV $392
line 892
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $394
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $391
line 898
;897:
;898:  return NULL;
CNSTP4 0
RETP4
LABELV $387
endproc Menu_FindItemByName 8 8
export Script_SetTeamColor
proc Script_SetTeamColor 24 4
line 901
;899:}
;900:
;901:void Script_SetTeamColor(itemDef_t *item, char **args) {
line 902
;902:  if (DC->getTeamColor) {
ADDRGP4 DC
INDIRP4
CNSTI4 84
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $398
line 905
;903:    int i;
;904:    vec4_t color;
;905:    DC->getTeamColor(&color);
ADDRLP4 4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 84
ADDP4
INDIRP4
CALLV
pop
line 906
;906:    for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $400
line 907
;907:      item->window.backColor[i] = color[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ASGNF4
line 908
;908:    }
LABELV $401
line 906
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $400
line 909
;909:  }
LABELV $398
line 910
;910:}
LABELV $397
endproc Script_SetTeamColor 24 4
export Script_SetItemColor
proc Script_SetItemColor 80 12
line 912
;911:
;912:void Script_SetItemColor(itemDef_t *item, char **args) {
line 919
;913:  const char *itemname;
;914:  const char *name;
;915:  vec4_t color;
;916:  int i;
;917:  vec4_t *out;
;918:  // expecting type of color to set and 4 args for the color
;919:  if (String_Parse(args, &itemname) && String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 32
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $405
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 36
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $405
line 922
;920:    itemDef_t *item2;
;921:    int j;
;922:    int count = Menu_ItemsMatchingGroup(item->parent, itemname);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 Menu_ItemsMatchingGroup
CALLI4
ASGNI4
ADDRLP4 48
ADDRLP4 52
INDIRI4
ASGNI4
line 924
;923:
;924:    if (!Color_Parse(args, &color)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 56
ADDRGP4 Color_Parse
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $407
line 925
;925:      return;
ADDRGP4 $404
JUMPV
LABELV $407
line 928
;926:    }
;927:
;928:    for (j = 0; j < count; j++) {
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRGP4 $412
JUMPV
LABELV $409
line 929
;929:      item2 = Menu_GetMatchingItemByNumber(item->parent, j, itemname);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 Menu_GetMatchingItemByNumber
CALLP4
ASGNP4
ADDRLP4 44
ADDRLP4 60
INDIRP4
ASGNP4
line 930
;930:      if (item2 != NULL) {
ADDRLP4 44
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $413
line 931
;931:        out = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 932
;932:        if (Q_stricmp(name, "backcolor") == 0) {
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 $364
ARGP4
ADDRLP4 64
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $415
line 933
;933:          out = &item2->window.backColor;
ADDRLP4 4
ADDRLP4 44
INDIRP4
CNSTI4 128
ADDP4
ASGNP4
line 934
;934:        } else if (Q_stricmp(name, "forecolor") == 0) {
ADDRGP4 $416
JUMPV
LABELV $415
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 $367
ARGP4
ADDRLP4 68
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $417
line 935
;935:          out = &item2->window.foreColor;
ADDRLP4 4
ADDRLP4 44
INDIRP4
CNSTI4 112
ADDP4
ASGNP4
line 936
;936:          item2->window.flags |= WINDOW_FORECOLORSET;
ADDRLP4 72
ADDRLP4 44
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 937
;937:        } else if (Q_stricmp(name, "bordercolor") == 0) {
ADDRGP4 $418
JUMPV
LABELV $417
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 $370
ARGP4
ADDRLP4 72
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $419
line 938
;938:          out = &item2->window.borderColor;
ADDRLP4 4
ADDRLP4 44
INDIRP4
CNSTI4 144
ADDP4
ASGNP4
line 939
;939:        }
LABELV $419
LABELV $418
LABELV $416
line 941
;940:
;941:        if (out) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $421
line 942
;942:          for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $423
line 943
;943:            (*out)[i] = color[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRF4
ASGNF4
line 944
;944:          }
LABELV $424
line 942
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $423
line 945
;945:        }
LABELV $421
line 946
;946:      }
LABELV $413
line 947
;947:    }
LABELV $410
line 928
ADDRLP4 40
ADDRLP4 40
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $412
ADDRLP4 40
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $409
line 948
;948:  }
LABELV $405
line 949
;949:}
LABELV $404
endproc Script_SetItemColor 80 12
export Menu_ShowItemByName
proc Menu_ShowItemByName 24 12
line 952
;950:
;951:
;952:void Menu_ShowItemByName(menuDef_t *menu, const char *p, qboolean bShow) {
line 955
;953:	itemDef_t *item;
;954:	int i;
;955:	int count = Menu_ItemsMatchingGroup(menu, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Menu_ItemsMatchingGroup
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 956
;956:	for (i = 0; i < count; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $431
JUMPV
LABELV $428
line 957
;957:		item = Menu_GetMatchingItemByNumber(menu, i, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Menu_GetMatchingItemByNumber
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 958
;958:		if (item != NULL) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $432
line 959
;959:			if (bShow) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $434
line 960
;960:				item->window.flags |= WINDOW_VISIBLE;
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 961
;961:			} else {
ADDRGP4 $435
JUMPV
LABELV $434
line 962
;962:				item->window.flags &= ~WINDOW_VISIBLE;
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 -5
BANDI4
ASGNI4
line 964
;963:				// stop cinematics playing in the window
;964:				if (item->window.cinematic >= 0) {
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LTI4 $436
line 965
;965:					DC->stopCinematic(item->window.cinematic);
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 184
ADDP4
INDIRP4
CALLV
pop
line 966
;966:					item->window.cinematic = -1;
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 -1
ASGNI4
line 967
;967:				}
LABELV $436
line 968
;968:			}
LABELV $435
line 969
;969:		}
LABELV $432
line 970
;970:	}
LABELV $429
line 956
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $431
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $428
line 971
;971:}
LABELV $427
endproc Menu_ShowItemByName 24 12
export Menu_FadeItemByName
proc Menu_FadeItemByName 28 12
line 973
;972:
;973:void Menu_FadeItemByName(menuDef_t *menu, const char *p, qboolean fadeOut) {
line 976
;974:  itemDef_t *item;
;975:  int i;
;976:  int count = Menu_ItemsMatchingGroup(menu, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Menu_ItemsMatchingGroup
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 977
;977:  for (i = 0; i < count; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $442
JUMPV
LABELV $439
line 978
;978:    item = Menu_GetMatchingItemByNumber(menu, i, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Menu_GetMatchingItemByNumber
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 979
;979:    if (item != NULL) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $443
line 980
;980:      if (fadeOut) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $445
line 981
;981:        item->window.flags |= (WINDOW_FADINGOUT | WINDOW_VISIBLE);
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 36
BORI4
ASGNI4
line 982
;982:        item->window.flags &= ~WINDOW_FADINGIN;
ADDRLP4 24
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 -65
BANDI4
ASGNI4
line 983
;983:      } else {
ADDRGP4 $446
JUMPV
LABELV $445
line 984
;984:        item->window.flags |= (WINDOW_VISIBLE | WINDOW_FADINGIN);
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 68
BORI4
ASGNI4
line 985
;985:        item->window.flags &= ~WINDOW_FADINGOUT;
ADDRLP4 24
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 -33
BANDI4
ASGNI4
line 986
;986:      }
LABELV $446
line 987
;987:    }
LABELV $443
line 988
;988:  }
LABELV $440
line 977
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $442
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $439
line 989
;989:}
LABELV $438
endproc Menu_FadeItemByName 28 12
export Menus_FindByName
proc Menus_FindByName 8 8
line 991
;990:
;991:menuDef_t *Menus_FindByName(const char *p) {
line 993
;992:  int i;
;993:  for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $451
JUMPV
LABELV $448
line 994
;994:    if (Q_stricmp(Menus[i].window.name, p) == 0) {
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus+32
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
NEI4 $452
line 995
;995:      return &Menus[i];
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
RETP4
ADDRGP4 $447
JUMPV
LABELV $452
line 997
;996:    } 
;997:  }
LABELV $449
line 993
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $451
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $448
line 998
;998:  return NULL;
CNSTP4 0
RETP4
LABELV $447
endproc Menus_FindByName 8 8
export Menus_ShowByName
proc Menus_ShowByName 8 4
line 1001
;999:}
;1000:
;1001:void Menus_ShowByName(const char *p) {
line 1002
;1002:	menuDef_t *menu = Menus_FindByName(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1003
;1003:	if (menu) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $456
line 1004
;1004:		Menus_Activate(menu);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menus_Activate
CALLV
pop
line 1005
;1005:	}
LABELV $456
line 1006
;1006:}
LABELV $455
endproc Menus_ShowByName 8 4
export Menus_OpenByName
proc Menus_OpenByName 0 4
line 1008
;1007:
;1008:void Menus_OpenByName(const char *p) {
line 1009
;1009:  Menus_ActivateByName(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 1010
;1010:}
LABELV $458
endproc Menus_OpenByName 0 4
proc Menu_RunCloseScript 544 8
line 1012
;1011:
;1012:static void Menu_RunCloseScript(menuDef_t *menu) {
line 1013
;1013:	if (menu && menu->window.flags & WINDOW_VISIBLE && menu->onClose) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $460
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $460
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $460
line 1015
;1014:		itemDef_t item;
;1015:    item.parent = menu;
ADDRLP4 4+228
ADDRFP4 0
INDIRP4
ASGNP4
line 1016
;1016:    Item_RunScript(&item, menu->onClose);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1017
;1017:	}
LABELV $460
line 1018
;1018:}
LABELV $459
endproc Menu_RunCloseScript 544 8
export Menus_CloseByName
proc Menus_CloseByName 12 4
line 1020
;1019:
;1020:void Menus_CloseByName(const char *p) {
line 1021
;1021:  menuDef_t *menu = Menus_FindByName(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1022
;1022:  if (menu != NULL) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $464
line 1023
;1023:		Menu_RunCloseScript(menu);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_RunCloseScript
CALLV
pop
line 1024
;1024:		menu->window.flags &= ~(WINDOW_VISIBLE | WINDOW_HASFOCUS);
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -7
BANDI4
ASGNI4
line 1025
;1025:  }
LABELV $464
line 1026
;1026:}
LABELV $463
endproc Menus_CloseByName 12 4
export Menus_CloseAll
proc Menus_CloseAll 8 4
line 1028
;1027:
;1028:void Menus_CloseAll( void ) {
line 1030
;1029:  int i;
;1030:  for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $470
JUMPV
LABELV $467
line 1031
;1031:		Menu_RunCloseScript(&Menus[i]);
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRGP4 Menu_RunCloseScript
CALLV
pop
line 1032
;1032:		Menus[i].window.flags &= ~(WINDOW_HASFOCUS | WINDOW_VISIBLE);
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus+68
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -7
BANDI4
ASGNI4
line 1033
;1033:  }
LABELV $468
line 1030
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $470
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $467
line 1034
;1034:}
LABELV $466
endproc Menus_CloseAll 8 4
export Script_Show
proc Script_Show 8 12
line 1037
;1035:
;1036:
;1037:void Script_Show(itemDef_t *item, char **args) {
line 1039
;1038:  const char *name;
;1039:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $473
line 1040
;1040:    Menu_ShowItemByName(item->parent, name, qtrue);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1041
;1041:  }
LABELV $473
line 1042
;1042:}
LABELV $472
endproc Script_Show 8 12
export Script_Hide
proc Script_Hide 8 12
line 1044
;1043:
;1044:void Script_Hide(itemDef_t *item, char **args) {
line 1046
;1045:  const char *name;
;1046:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $476
line 1047
;1047:    Menu_ShowItemByName(item->parent, name, qfalse);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1048
;1048:  }
LABELV $476
line 1049
;1049:}
LABELV $475
endproc Script_Hide 8 12
export Script_FadeIn
proc Script_FadeIn 8 12
line 1051
;1050:
;1051:void Script_FadeIn(itemDef_t *item, char **args) {
line 1053
;1052:  const char *name;
;1053:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $479
line 1054
;1054:    Menu_FadeItemByName(item->parent, name, qfalse);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_FadeItemByName
CALLV
pop
line 1055
;1055:  }
LABELV $479
line 1056
;1056:}
LABELV $478
endproc Script_FadeIn 8 12
export Script_FadeOut
proc Script_FadeOut 8 12
line 1058
;1057:
;1058:void Script_FadeOut(itemDef_t *item, char **args) {
line 1060
;1059:  const char *name;
;1060:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $482
line 1061
;1061:    Menu_FadeItemByName(item->parent, name, qtrue);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_FadeItemByName
CALLV
pop
line 1062
;1062:  }
LABELV $482
line 1063
;1063:}
LABELV $481
endproc Script_FadeOut 8 12
export Script_Open
proc Script_Open 8 8
line 1067
;1064:
;1065:
;1066:
;1067:void Script_Open(itemDef_t *item, char **args) {
line 1069
;1068:  const char *name;
;1069:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $485
line 1070
;1070:    Menus_OpenByName(name);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menus_OpenByName
CALLV
pop
line 1071
;1071:  }
LABELV $485
line 1072
;1072:}
LABELV $484
endproc Script_Open 8 8
export Script_ConditionalOpen
proc Script_ConditionalOpen 32 8
line 1074
;1073:
;1074:void Script_ConditionalOpen(itemDef_t *item, char **args) {
line 1080
;1075:	const char *cvar;
;1076:	const char *name1;
;1077:	const char *name2;
;1078:	float           val;
;1079:
;1080:	if ( String_Parse(args, &cvar) && String_Parse(args, &name1) && String_Parse(args, &name2) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $488
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 20
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $488
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 24
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $488
line 1081
;1081:		val = DC->getCVarValue( cvar );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 28
INDIRF4
ASGNF4
line 1082
;1082:		if ( val == 0.f ) {
ADDRLP4 12
INDIRF4
CNSTF4 0
NEF4 $490
line 1083
;1083:			Menus_OpenByName(name2);
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 Menus_OpenByName
CALLV
pop
line 1084
;1084:		} else {
ADDRGP4 $491
JUMPV
LABELV $490
line 1085
;1085:			Menus_OpenByName(name1);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Menus_OpenByName
CALLV
pop
line 1086
;1086:		}
LABELV $491
line 1087
;1087:	}
LABELV $488
line 1088
;1088:}
LABELV $487
endproc Script_ConditionalOpen 32 8
export Script_Close
proc Script_Close 8 8
line 1090
;1089:
;1090:void Script_Close(itemDef_t *item, char **args) {
line 1092
;1091:  const char *name;
;1092:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $493
line 1093
;1093:    Menus_CloseByName(name);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menus_CloseByName
CALLV
pop
line 1094
;1094:  }
LABELV $493
line 1095
;1095:}
LABELV $492
endproc Script_Close 8 8
export Menu_TransitionItemByName
proc Menu_TransitionItemByName 40 12
line 1097
;1096:
;1097:void Menu_TransitionItemByName(menuDef_t *menu, const char *p, rectDef_t rectFrom, rectDef_t rectTo, int time, float amt) {
line 1100
;1098:  itemDef_t *item;
;1099:  int i;
;1100:  int count = Menu_ItemsMatchingGroup(menu, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Menu_ItemsMatchingGroup
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 1101
;1101:  for (i = 0; i < count; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $499
JUMPV
LABELV $496
line 1102
;1102:    item = Menu_GetMatchingItemByNumber(menu, i, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Menu_GetMatchingItemByNumber
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 1103
;1103:    if (item != NULL) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $500
line 1104
;1104:      item->window.flags |= (WINDOW_INTRANSITION | WINDOW_VISIBLE);
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 260
BORI4
ASGNI4
line 1105
;1105:      item->window.offsetTime = time;
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRFP4 16
INDIRI4
ASGNI4
line 1106
;1106:			memcpy(&item->window.rectClient, &rectFrom, sizeof(rectDef_t));
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
CNSTU4 16
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 1107
;1107:			memcpy(&item->window.rectEffects, &rectTo, sizeof(rectDef_t));
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTU4 16
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 1108
;1108:			item->window.rectEffects2.x = abs(rectTo.x - rectFrom.x) / amt;
ADDRFP4 12
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
INDIRF4
SUBF4
CVFI4 4
ARGI4
ADDRLP4 24
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 24
INDIRI4
CVIF4 4
ADDRFP4 20
INDIRF4
DIVF4
ASGNF4
line 1109
;1109:			item->window.rectEffects2.y = abs(rectTo.y - rectFrom.y) / amt;
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
CVFI4 4
ARGI4
ADDRLP4 28
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 28
INDIRI4
CVIF4 4
ADDRFP4 20
INDIRF4
DIVF4
ASGNF4
line 1110
;1110:			item->window.rectEffects2.w = abs(rectTo.w - rectFrom.w) / amt;
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
CVFI4 4
ARGI4
ADDRLP4 32
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
ADDRLP4 32
INDIRI4
CVIF4 4
ADDRFP4 20
INDIRF4
DIVF4
ASGNF4
line 1111
;1111:			item->window.rectEffects2.h = abs(rectTo.h - rectFrom.h) / amt;
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
SUBF4
CVFI4 4
ARGI4
ADDRLP4 36
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
ADDRLP4 36
INDIRI4
CVIF4 4
ADDRFP4 20
INDIRF4
DIVF4
ASGNF4
line 1112
;1112:      Item_UpdatePosition(item);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Item_UpdatePosition
CALLV
pop
line 1113
;1113:    }
LABELV $500
line 1114
;1114:  }
LABELV $497
line 1101
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $499
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $496
line 1115
;1115:}
LABELV $495
endproc Menu_TransitionItemByName 40 12
export Script_Transition
proc Script_Transition 96 24
line 1118
;1116:
;1117:
;1118:void Script_Transition(itemDef_t *item, char **args) {
line 1124
;1119:  const char *name;
;1120:	rectDef_t rectFrom, rectTo;
;1121:  int time;
;1122:	float amt;
;1123:
;1124:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 44
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $503
line 1125
;1125:    if ( Rect_Parse(args, &rectFrom) && Rect_Parse(args, &rectTo) && Int_Parse(args, &time) && Float_Parse(args, &amt)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 48
ADDRGP4 Rect_Parse
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $505
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 52
ADDRGP4 Rect_Parse
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $505
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 56
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $505
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 60
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $505
line 1126
;1126:      Menu_TransitionItemByName(item->parent, name, rectFrom, rectTo, time, amt);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 64
ADDRLP4 4
INDIRB
ASGNB 16
ADDRLP4 64
ARGP4
ADDRLP4 80
ADDRLP4 20
INDIRB
ASGNB 16
ADDRLP4 80
ARGP4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 40
INDIRF4
ARGF4
ADDRGP4 Menu_TransitionItemByName
CALLV
pop
line 1127
;1127:    }
LABELV $505
line 1128
;1128:  }
LABELV $503
line 1129
;1129:}
LABELV $502
endproc Script_Transition 96 24
export Menu_OrbitItemByName
proc Menu_OrbitItemByName 24 12
line 1132
;1130:
;1131:
;1132:void Menu_OrbitItemByName(menuDef_t *menu, const char *p, float x, float y, float cx, float cy, int time) {
line 1135
;1133:  itemDef_t *item;
;1134:  int i;
;1135:  int count = Menu_ItemsMatchingGroup(menu, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Menu_ItemsMatchingGroup
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 1136
;1136:  for (i = 0; i < count; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $511
JUMPV
LABELV $508
line 1137
;1137:    item = Menu_GetMatchingItemByNumber(menu, i, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Menu_GetMatchingItemByNumber
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 1138
;1138:    if (item != NULL) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $512
line 1139
;1139:      item->window.flags |= (WINDOW_ORBITING | WINDOW_VISIBLE);
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 65540
BORI4
ASGNI4
line 1140
;1140:      item->window.offsetTime = time;
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRFP4 24
INDIRI4
ASGNI4
line 1141
;1141:      item->window.rectEffects.x = cx;
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDRFP4 16
INDIRF4
ASGNF4
line 1142
;1142:      item->window.rectEffects.y = cy;
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRFP4 20
INDIRF4
ASGNF4
line 1143
;1143:      item->window.rectClient.x = x;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 8
INDIRF4
ASGNF4
line 1144
;1144:      item->window.rectClient.y = y;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 12
INDIRF4
ASGNF4
line 1145
;1145:      Item_UpdatePosition(item);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Item_UpdatePosition
CALLV
pop
line 1146
;1146:    }
LABELV $512
line 1147
;1147:  }
LABELV $509
line 1136
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $511
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $508
line 1148
;1148:}
LABELV $507
endproc Menu_OrbitItemByName 24 12
export Script_Orbit
proc Script_Orbit 48 28
line 1151
;1149:
;1150:
;1151:void Script_Orbit(itemDef_t *item, char **args) {
line 1156
;1152:  const char *name;
;1153:  float cx, cy, x, y;
;1154:  int time;
;1155:
;1156:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $515
line 1157
;1157:    if ( Float_Parse(args, &x) && Float_Parse(args, &y) && Float_Parse(args, &cx) && Float_Parse(args, &cy) && Int_Parse(args, &time) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 28
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $517
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 32
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $517
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 36
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $517
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 40
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $517
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 44
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $517
line 1158
;1158:      Menu_OrbitItemByName(item->parent, name, x, y, cx, cy, time);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 Menu_OrbitItemByName
CALLV
pop
line 1159
;1159:    }
LABELV $517
line 1160
;1160:  }
LABELV $515
line 1161
;1161:}
LABELV $514
endproc Script_Orbit 48 28
export Script_SetFocus
proc Script_SetFocus 28 8
line 1165
;1162:
;1163:
;1164:
;1165:void Script_SetFocus(itemDef_t *item, char **args) {
line 1169
;1166:  const char *name;
;1167:  itemDef_t *focusItem;
;1168:
;1169:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $520
line 1170
;1170:    focusItem = Menu_FindItemByName(item->parent, name);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Menu_FindItemByName
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 1171
;1171:    if (focusItem && !(focusItem->window.flags & WINDOW_DECORATION) && !(focusItem->window.flags & WINDOW_HASFOCUS)) {
ADDRLP4 16
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $522
ADDRLP4 16
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $522
ADDRLP4 16
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $522
line 1172
;1172:      Menu_ClearFocus(item->parent);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRGP4 Menu_ClearFocus
CALLP4
pop
line 1173
;1173:      focusItem->window.flags |= WINDOW_HASFOCUS;
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 68
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
line 1174
;1174:      if (focusItem->onFocus) {
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $524
line 1175
;1175:        Item_RunScript(focusItem, focusItem->onFocus);
ADDRLP4 24
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1176
;1176:      }
LABELV $524
line 1177
;1177:      if (DC->Assets.itemFocusSound) {
ADDRGP4 DC
INDIRP4
CNSTI4 61948
ADDP4
INDIRI4
CNSTI4 0
EQI4 $526
line 1178
;1178:        DC->startLocalSound( DC->Assets.itemFocusSound, CHAN_LOCAL_SOUND );
ADDRLP4 24
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 61948
ADDP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CALLV
pop
line 1179
;1179:      }
LABELV $526
line 1180
;1180:    }
LABELV $522
line 1181
;1181:  }
LABELV $520
line 1182
;1182:}
LABELV $519
endproc Script_SetFocus 28 8
export Script_SetPlayerModel
proc Script_SetPlayerModel 8 8
line 1184
;1183:
;1184:void Script_SetPlayerModel(itemDef_t *item, char **args) {
line 1186
;1185:  const char *name;
;1186:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $529
line 1187
;1187:    DC->setCVar("team_model", name);
ADDRGP4 $531
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 1188
;1188:  }
LABELV $529
line 1189
;1189:}
LABELV $528
endproc Script_SetPlayerModel 8 8
export Script_SetPlayerHead
proc Script_SetPlayerHead 8 8
line 1191
;1190:
;1191:void Script_SetPlayerHead(itemDef_t *item, char **args) {
line 1193
;1192:  const char *name;
;1193:  if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $533
line 1194
;1194:    DC->setCVar("team_headmodel", name);
ADDRGP4 $535
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 1195
;1195:  }
LABELV $533
line 1196
;1196:}
LABELV $532
endproc Script_SetPlayerHead 8 8
export Script_SetCvar
proc Script_SetCvar 16 8
line 1198
;1197:
;1198:void Script_SetCvar(itemDef_t *item, char **args) {
line 1200
;1199:	const char *cvar, *val;
;1200:	if (String_Parse(args, &cvar) && String_Parse(args, &val)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $537
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $537
line 1201
;1201:		DC->setCVar(cvar, val);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 1202
;1202:	}
LABELV $537
line 1204
;1203:	
;1204:}
LABELV $536
endproc Script_SetCvar 16 8
export Script_Exec
proc Script_Exec 12 8
line 1206
;1205:
;1206:void Script_Exec(itemDef_t *item, char **args) {
line 1208
;1207:	const char *val;
;1208:	if (String_Parse(args, &val)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $540
line 1209
;1209:		DC->executeText(EXEC_APPEND, va("%s ; ", val));
ADDRGP4 $542
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 148
ADDP4
INDIRP4
CALLV
pop
line 1210
;1210:	}
LABELV $540
line 1211
;1211:}
LABELV $539
endproc Script_Exec 12 8
export Script_Play
proc Script_Play 12 8
line 1213
;1212:
;1213:void Script_Play(itemDef_t *item, char **args) {
line 1215
;1214:	const char *val;
;1215:	if (String_Parse(args, &val)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $544
line 1216
;1216:		DC->startLocalSound(DC->registerSound(val, qfalse), CHAN_LOCAL_SOUND);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
CNSTI4 168
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CALLV
pop
line 1217
;1217:	}
LABELV $544
line 1218
;1218:}
LABELV $543
endproc Script_Play 12 8
export Script_playLooped
proc Script_playLooped 12 8
line 1220
;1219:
;1220:void Script_playLooped(itemDef_t *item, char **args) {
line 1222
;1221:	const char *val;
;1222:	if (String_Parse(args, &val)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $547
line 1223
;1223:		DC->stopBackgroundTrack();
ADDRGP4 DC
INDIRP4
CNSTI4 176
ADDP4
INDIRP4
CALLV
pop
line 1224
;1224:		DC->startBackgroundTrack(val, val);
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 172
ADDP4
INDIRP4
CALLV
pop
line 1225
;1225:	}
LABELV $547
line 1226
;1226:}
LABELV $546
endproc Script_playLooped 12 8
data
export commandList
align 4
LABELV commandList
address $549
address Script_FadeIn
address $550
address Script_FadeOut
address $551
address Script_Show
address $552
address Script_Hide
address $553
address Script_SetColor
address $554
address Script_Open
address $555
address Script_ConditionalOpen
address $556
address Script_Close
address $557
address Script_SetAsset
address $558
address Script_SetBackground
address $559
address Script_SetItemColor
address $560
address Script_SetTeamColor
address $561
address Script_SetFocus
address $562
address Script_SetPlayerModel
address $563
address Script_SetPlayerHead
address $564
address Script_Transition
address $565
address Script_SetCvar
address $566
address Script_Exec
address $567
address Script_Play
address $568
address Script_playLooped
address $569
address Script_Orbit
export scriptCommandCount
align 4
LABELV scriptCommandCount
byte 4 21
export Item_RunScript
code
proc Item_RunScript 1056 12
line 1257
;1227:
;1228:
;1229:commandDef_t commandList[] =
;1230:{
;1231:  {"fadein", &Script_FadeIn},                   // group/name
;1232:  {"fadeout", &Script_FadeOut},                 // group/name
;1233:  {"show", &Script_Show},                       // group/name
;1234:  {"hide", &Script_Hide},                       // group/name
;1235:  {"setcolor", &Script_SetColor},               // works on this
;1236:  {"open", &Script_Open},                       // menu
;1237:	{"conditionalopen", &Script_ConditionalOpen},	// menu
;1238:  {"close", &Script_Close},                     // menu
;1239:  {"setasset", &Script_SetAsset},               // works on this
;1240:  {"setbackground", &Script_SetBackground},     // works on this
;1241:  {"setitemcolor", &Script_SetItemColor},       // group/name
;1242:  {"setteamcolor", &Script_SetTeamColor},       // sets this background color to team color
;1243:  {"setfocus", &Script_SetFocus},               // sets this background color to team color
;1244:  {"setplayermodel", &Script_SetPlayerModel},   // sets this background color to team color
;1245:  {"setplayerhead", &Script_SetPlayerHead},     // sets this background color to team color
;1246:  {"transition", &Script_Transition},           // group/name
;1247:  {"setcvar", &Script_SetCvar},           // group/name
;1248:  {"exec", &Script_Exec},           // group/name
;1249:  {"play", &Script_Play},           // group/name
;1250:  {"playlooped", &Script_playLooped},           // group/name
;1251:  {"orbit", &Script_Orbit}                      // group/name
;1252:};
;1253:
;1254:int scriptCommandCount = sizeof(commandList) / sizeof(commandDef_t);
;1255:
;1256:
;1257:void Item_RunScript(itemDef_t *item, const char *s) {
line 1261
;1258:  char script[1024], *p;
;1259:  int i;
;1260:  qboolean bRan;
;1261:  memset(script, 0, sizeof(script));
ADDRLP4 12
ARGP4
CNSTI4 0
ARGI4
CNSTU4 1024
ARGU4
ADDRGP4 memset
CALLP4
pop
line 1262
;1262:  if (item && s && s[0]) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $571
ADDRLP4 1036
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 1036
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $571
ADDRLP4 1036
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $571
line 1263
;1263:    Q_strcat(script, 1024, s);
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 1264
;1264:    p = script;
ADDRLP4 8
ADDRLP4 12
ASGNP4
ADDRGP4 $574
JUMPV
LABELV $573
line 1265
;1265:    while (1) {
line 1268
;1266:      const char *command;
;1267:      // expect command then arguments, ; ends command, NULL ends script
;1268:      if (!String_Parse(&p, &command)) {
ADDRLP4 8
ARGP4
ADDRLP4 1040
ARGP4
ADDRLP4 1044
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $576
line 1269
;1269:        return;
ADDRGP4 $570
JUMPV
LABELV $576
line 1272
;1270:      }
;1271:
;1272:      if (command[0] == ';' && command[1] == '\0') {
ADDRLP4 1048
ADDRLP4 1040
INDIRP4
ASGNP4
ADDRLP4 1048
INDIRP4
INDIRI1
CVII4 1
CNSTI4 59
NEI4 $578
ADDRLP4 1048
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $578
line 1273
;1273:        continue;
ADDRGP4 $574
JUMPV
LABELV $578
line 1276
;1274:      }
;1275:
;1276:      bRan = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1277
;1277:      for (i = 0; i < scriptCommandCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $583
JUMPV
LABELV $580
line 1278
;1278:        if (Q_stricmp(command, commandList[i].name) == 0) {
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commandList
ADDP4
INDIRP4
ARGP4
ADDRLP4 1052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $584
line 1279
;1279:          (commandList[i].handler(item, &p));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commandList+4
ADDP4
INDIRP4
CALLV
pop
line 1280
;1280:          bRan = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1281
;1281:          break;
ADDRGP4 $582
JUMPV
LABELV $584
line 1283
;1282:        }
;1283:      }
LABELV $581
line 1277
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $583
ADDRLP4 0
INDIRI4
ADDRGP4 scriptCommandCount
INDIRI4
LTI4 $580
LABELV $582
line 1285
;1284:      // not in our auto list, pass to handler
;1285:      if (!bRan) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $587
line 1286
;1286:        DC->runScript(&p);
ADDRLP4 8
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 80
ADDP4
INDIRP4
CALLV
pop
line 1287
;1287:      }
LABELV $587
line 1288
;1288:    }
LABELV $574
line 1265
ADDRGP4 $573
JUMPV
line 1289
;1289:  }
LABELV $571
line 1290
;1290:}
LABELV $570
endproc Item_RunScript 1056 12
export Item_EnableShowViaCvar
proc Item_EnableShowViaCvar 2072 12
line 1293
;1291:
;1292:
;1293:qboolean Item_EnableShowViaCvar(itemDef_t *item, int flag) {
line 1295
;1294:  char script[1024], *p;
;1295:  memset(script, 0, sizeof(script));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 1024
ARGU4
ADDRGP4 memset
CALLP4
pop
line 1296
;1296:  if (item && item->enableCvar && *item->enableCvar && item->cvarTest && *item->cvarTest) {
ADDRLP4 1028
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1028
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $590
ADDRLP4 1028
INDIRP4
CNSTI4 272
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $590
ADDRLP4 1028
INDIRP4
CNSTI4 272
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $590
ADDRLP4 1028
INDIRP4
CNSTI4 268
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $590
ADDRLP4 1028
INDIRP4
CNSTI4 268
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $590
line 1298
;1297:		char buff[1024];
;1298:	  DC->getCVarString(item->cvarTest, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
INDIRP4
ARGP4
ADDRLP4 1032
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 1300
;1299:
;1300:    Q_strcat(script, 1024, item->enableCvar);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 1301
;1301:    p = script;
ADDRLP4 0
ADDRLP4 4
ASGNP4
ADDRGP4 $593
JUMPV
LABELV $592
line 1302
;1302:    while (1) {
line 1305
;1303:      const char *val;
;1304:      // expect value then ; or NULL, NULL ends list
;1305:      if (!String_Parse(&p, &val)) {
ADDRLP4 0
ARGP4
ADDRLP4 2056
ARGP4
ADDRLP4 2060
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 2060
INDIRI4
CNSTI4 0
NEI4 $595
line 1306
;1306:				return (item->cvarFlags & flag) ? qfalse : qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
BANDI4
CNSTI4 0
EQI4 $598
ADDRLP4 2064
CNSTI4 0
ASGNI4
ADDRGP4 $599
JUMPV
LABELV $598
ADDRLP4 2064
CNSTI4 1
ASGNI4
LABELV $599
ADDRLP4 2064
INDIRI4
RETI4
ADDRGP4 $589
JUMPV
LABELV $595
line 1309
;1307:      }
;1308:
;1309:      if (val[0] == ';' && val[1] == '\0') {
ADDRLP4 2064
ADDRLP4 2056
INDIRP4
ASGNP4
ADDRLP4 2064
INDIRP4
INDIRI1
CVII4 1
CNSTI4 59
NEI4 $600
ADDRLP4 2064
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $600
line 1310
;1310:        continue;
ADDRGP4 $593
JUMPV
LABELV $600
line 1314
;1311:      }
;1312:
;1313:			// enable it if any of the values are true
;1314:			if (item->cvarFlags & flag) {
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
BANDI4
CNSTI4 0
EQI4 $602
line 1315
;1315:        if (Q_stricmp(buff, val) == 0) {
ADDRLP4 1032
ARGP4
ADDRLP4 2056
INDIRP4
ARGP4
ADDRLP4 2068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 0
NEI4 $603
line 1316
;1316:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $589
JUMPV
line 1318
;1317:				}
;1318:			} else {
LABELV $602
line 1320
;1319:				// disable it if any of the values are true
;1320:        if (Q_stricmp(buff, val) == 0) {
ADDRLP4 1032
ARGP4
ADDRLP4 2056
INDIRP4
ARGP4
ADDRLP4 2068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 0
NEI4 $606
line 1321
;1321:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $589
JUMPV
LABELV $606
line 1323
;1322:				}
;1323:			}
LABELV $603
line 1325
;1324:
;1325:    }
LABELV $593
line 1302
ADDRGP4 $592
JUMPV
line 1326
;1326:		return (item->cvarFlags & flag) ? qfalse : qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
BANDI4
CNSTI4 0
EQI4 $609
ADDRLP4 2056
CNSTI4 0
ASGNI4
ADDRGP4 $610
JUMPV
LABELV $609
ADDRLP4 2056
CNSTI4 1
ASGNI4
LABELV $610
ADDRLP4 2056
INDIRI4
RETI4
ADDRGP4 $589
JUMPV
LABELV $590
line 1328
;1327:  }
;1328:	return qtrue;
CNSTI4 1
RETI4
LABELV $589
endproc Item_EnableShowViaCvar 2072 12
export Item_SetFocus
proc Item_SetFocus 72 12
line 1333
;1329:}
;1330:
;1331:
;1332:// will optionaly set focus to this item 
;1333:qboolean Item_SetFocus(itemDef_t *item, float x, float y) {
line 1336
;1334:	int i;
;1335:	itemDef_t *oldFocus;
;1336:	sfxHandle_t *sfx = &DC->Assets.itemFocusSound;
ADDRLP4 8
ADDRGP4 DC
INDIRP4
CNSTI4 61948
ADDP4
ASGNP4
line 1337
;1337:	qboolean playSound = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 1340
;1338:	menuDef_t *parent; // bk001206: = (menuDef_t*)item->parent;
;1339:	// sanity check, non-null, not a decoration and does not already have the focus
;1340:	if (item == NULL || item->window.flags & WINDOW_DECORATION || item->window.flags & WINDOW_HASFOCUS || !(item->window.flags & WINDOW_VISIBLE)) {
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $616
ADDRLP4 20
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $616
ADDRLP4 20
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $616
ADDRLP4 20
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $612
LABELV $616
line 1341
;1341:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $611
JUMPV
LABELV $612
line 1345
;1342:	}
;1343:
;1344:	// bk001206 - this can be NULL.
;1345:	parent = (menuDef_t*)item->parent; 
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 1348
;1346:      
;1347:	// items can be enabled and disabled based on cvars
;1348:	if (item->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(item, CVAR_ENABLE)) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $617
ADDRLP4 24
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 28
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $617
line 1349
;1349:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $611
JUMPV
LABELV $617
line 1352
;1350:	}
;1351:
;1352:	if (item->cvarFlags & (CVAR_SHOW | CVAR_HIDE) && !Item_EnableShowViaCvar(item, CVAR_SHOW)) {
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 12
BANDI4
CNSTI4 0
EQI4 $619
ADDRLP4 32
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 36
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $619
line 1353
;1353:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $611
JUMPV
LABELV $619
line 1356
;1354:	}
;1355:
;1356:	oldFocus = Menu_ClearFocus(item->parent);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 Menu_ClearFocus
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 40
INDIRP4
ASGNP4
line 1358
;1357:
;1358:	if (item->type == ITEM_TYPE_TEXT) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
NEI4 $621
line 1360
;1359:		rectDef_t r;
;1360:		r = item->textRect;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRB
ASGNB 16
line 1361
;1361:		r.y -= r.h;
ADDRLP4 44+4
ADDRLP4 44+4
INDIRF4
ADDRLP4 44+12
INDIRF4
SUBF4
ASGNF4
line 1362
;1362:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 44
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 60
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $625
line 1363
;1363:			item->window.flags |= WINDOW_HASFOCUS;
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 68
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
line 1364
;1364:			if (item->focusSound) {
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
CNSTI4 0
EQI4 $627
line 1365
;1365:				sfx = &item->focusSound;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
ASGNP4
line 1366
;1366:			}
LABELV $627
line 1367
;1367:			playSound = qtrue;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 1368
;1368:		} else {
ADDRGP4 $622
JUMPV
LABELV $625
line 1369
;1369:			if (oldFocus) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $622
line 1370
;1370:				oldFocus->window.flags |= WINDOW_HASFOCUS;
ADDRLP4 64
ADDRLP4 16
INDIRP4
CNSTI4 68
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
line 1371
;1371:				if (oldFocus->onFocus) {
ADDRLP4 16
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $622
line 1372
;1372:					Item_RunScript(oldFocus, oldFocus->onFocus);
ADDRLP4 68
ADDRLP4 16
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1373
;1373:				}
line 1374
;1374:			}
line 1375
;1375:		}
line 1376
;1376:	} else {
ADDRGP4 $622
JUMPV
LABELV $621
line 1377
;1377:	    item->window.flags |= WINDOW_HASFOCUS;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 1378
;1378:		if (item->onFocus) {
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $633
line 1379
;1379:			Item_RunScript(item, item->onFocus);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 48
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1380
;1380:		}
LABELV $633
line 1381
;1381:		if (item->focusSound) {
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
CNSTI4 0
EQI4 $635
line 1382
;1382:			sfx = &item->focusSound;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
ASGNP4
line 1383
;1383:		}
LABELV $635
line 1384
;1384:		playSound = qtrue;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 1385
;1385:	}
LABELV $622
line 1387
;1386:
;1387:	if (playSound && sfx) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $637
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $637
line 1388
;1388:		DC->startLocalSound( *sfx, CHAN_LOCAL_SOUND );
ADDRLP4 8
INDIRP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CALLV
pop
line 1389
;1389:	}
LABELV $637
line 1391
;1390:
;1391:	for (i = 0; i < parent->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $642
JUMPV
LABELV $639
line 1392
;1392:		if (parent->items[i] == item) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $643
line 1393
;1393:			parent->cursorItem = i;
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1394
;1394:			break;
ADDRGP4 $641
JUMPV
LABELV $643
line 1396
;1395:		}
;1396:	}
LABELV $640
line 1391
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $642
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $639
LABELV $641
line 1398
;1397:
;1398:	return qtrue;
CNSTI4 1
RETI4
LABELV $611
endproc Item_SetFocus 72 12
export Item_ListBox_MaxScroll
proc Item_ListBox_MaxScroll 16 4
line 1401
;1399:}
;1400:
;1401:int Item_ListBox_MaxScroll(itemDef_t *item) {
line 1402
;1402:	listBoxDef_t *listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1403
;1403:	int count = DC->feederCount(item->special);
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 1406
;1404:	int max;
;1405:
;1406:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $646
line 1407
;1407:		max = count - (item->window.rect.w / listPtr->elementWidth) + 1;
ADDRLP4 0
ADDRLP4 8
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
DIVF4
SUBF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 1408
;1408:	}
ADDRGP4 $647
JUMPV
LABELV $646
line 1409
;1409:	else {
line 1410
;1410:		max = count - (item->window.rect.h / listPtr->elementHeight) + 1;
ADDRLP4 0
ADDRLP4 8
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
DIVF4
SUBF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 1411
;1411:	}
LABELV $647
line 1412
;1412:	if (max < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $648
line 1413
;1413:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $645
JUMPV
LABELV $648
line 1415
;1414:	}
;1415:	return max;
ADDRLP4 0
INDIRI4
RETI4
LABELV $645
endproc Item_ListBox_MaxScroll 16 4
export Item_ListBox_ThumbPosition
proc Item_ListBox_ThumbPosition 20 4
line 1418
;1416:}
;1417:
;1418:int Item_ListBox_ThumbPosition(itemDef_t *item) {
line 1420
;1419:	float max, pos, size;
;1420:	listBoxDef_t *listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1422
;1421:
;1422:	max = Item_ListBox_MaxScroll(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Item_ListBox_MaxScroll
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
CVIF4 4
ASGNF4
line 1423
;1423:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $651
line 1424
;1424:		size = item->window.rect.w - (SCROLLBAR_SIZE * 2) - 2;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 1425
;1425:		if (max > 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $653
line 1426
;1426:			pos = (size-SCROLLBAR_SIZE) / (float) max;
ADDRLP4 0
ADDRLP4 12
INDIRF4
CNSTF4 1098907648
SUBF4
ADDRLP4 4
INDIRF4
DIVF4
ASGNF4
line 1427
;1427:		} else {
ADDRGP4 $654
JUMPV
LABELV $653
line 1428
;1428:			pos = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1429
;1429:		}
LABELV $654
line 1430
;1430:		pos *= listPtr->startPos;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRP4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 1431
;1431:		return item->window.rect.x + 1 + SCROLLBAR_SIZE + pos;
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
CNSTF4 1098907648
ADDF4
ADDRLP4 0
INDIRF4
ADDF4
CVFI4 4
RETI4
ADDRGP4 $650
JUMPV
LABELV $651
line 1433
;1432:	}
;1433:	else {
line 1434
;1434:		size = item->window.rect.h - (SCROLLBAR_SIZE * 2) - 2;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 1435
;1435:		if (max > 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $655
line 1436
;1436:			pos = (size-SCROLLBAR_SIZE) / (float) max;
ADDRLP4 0
ADDRLP4 12
INDIRF4
CNSTF4 1098907648
SUBF4
ADDRLP4 4
INDIRF4
DIVF4
ASGNF4
line 1437
;1437:		} else {
ADDRGP4 $656
JUMPV
LABELV $655
line 1438
;1438:			pos = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1439
;1439:		}
LABELV $656
line 1440
;1440:		pos *= listPtr->startPos;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRP4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 1441
;1441:		return item->window.rect.y + 1 + SCROLLBAR_SIZE + pos;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
CNSTF4 1098907648
ADDF4
ADDRLP4 0
INDIRF4
ADDF4
CVFI4 4
RETI4
LABELV $650
endproc Item_ListBox_ThumbPosition 20 4
export Item_ListBox_ThumbDrawPosition
proc Item_ListBox_ThumbDrawPosition 20 4
line 1445
;1442:	}
;1443:}
;1444:
;1445:int Item_ListBox_ThumbDrawPosition(itemDef_t *item) {
line 1448
;1446:	int min, max;
;1447:
;1448:	if (itemCapture == item) {
ADDRGP4 itemCapture
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $658
line 1449
;1449:		if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $660
line 1450
;1450:			min = item->window.rect.x + SCROLLBAR_SIZE + 1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 1451
;1451:			max = item->window.rect.x + item->window.rect.w - 2*SCROLLBAR_SIZE - 1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1107296256
SUBF4
CNSTF4 1065353216
SUBF4
CVFI4 4
ASGNI4
line 1452
;1452:			if (DC->cursorx >= min + SCROLLBAR_SIZE/2 && DC->cursorx <= max + SCROLLBAR_SIZE/2) {
ADDRLP4 12
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1090519040
ADDF4
LTF4 $662
ADDRLP4 12
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
CNSTF4 1090519040
ADDF4
GTF4 $662
line 1453
;1453:				return DC->cursorx - SCROLLBAR_SIZE/2;
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
CNSTF4 1090519040
SUBF4
CVFI4 4
RETI4
ADDRGP4 $657
JUMPV
LABELV $662
line 1455
;1454:			}
;1455:			else {
line 1456
;1456:				return Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Item_ListBox_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
RETI4
ADDRGP4 $657
JUMPV
LABELV $660
line 1459
;1457:			}
;1458:		}
;1459:		else {
line 1460
;1460:			min = item->window.rect.y + SCROLLBAR_SIZE + 1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 1461
;1461:			max = item->window.rect.y + item->window.rect.h - 2*SCROLLBAR_SIZE - 1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
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
CNSTF4 1107296256
SUBF4
CNSTF4 1065353216
SUBF4
CVFI4 4
ASGNI4
line 1462
;1462:			if (DC->cursory >= min + SCROLLBAR_SIZE/2 && DC->cursory <= max + SCROLLBAR_SIZE/2) {
ADDRLP4 12
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1090519040
ADDF4
LTF4 $664
ADDRLP4 12
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
CNSTF4 1090519040
ADDF4
GTF4 $664
line 1463
;1463:				return DC->cursory - SCROLLBAR_SIZE/2;
ADDRGP4 DC
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
CNSTF4 1090519040
SUBF4
CVFI4 4
RETI4
ADDRGP4 $657
JUMPV
LABELV $664
line 1465
;1464:			}
;1465:			else {
line 1466
;1466:				return Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Item_ListBox_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
RETI4
ADDRGP4 $657
JUMPV
LABELV $658
line 1470
;1467:			}
;1468:		}
;1469:	}
;1470:	else {
line 1471
;1471:		return Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Item_ListBox_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
LABELV $657
endproc Item_ListBox_ThumbDrawPosition 20 4
export Item_Slider_ThumbPosition
proc Item_Slider_ThumbPosition 24 4
line 1475
;1472:	}
;1473:}
;1474:
;1475:float Item_Slider_ThumbPosition(itemDef_t *item) {
line 1477
;1476:	float value, range, x;
;1477:	editFieldDef_t *editDef = item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1479
;1478:
;1479:	if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $667
line 1480
;1480:		x = item->textRect.x + item->textRect.w + 8;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 1481
;1481:	} else {
ADDRGP4 $668
JUMPV
LABELV $667
line 1482
;1482:		x = item->window.rect.x;
ADDRLP4 8
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 1483
;1483:	}
LABELV $668
line 1485
;1484:
;1485:	if (editDef == NULL && item->cvar) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $669
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $669
line 1486
;1486:		return x;
ADDRLP4 8
INDIRF4
RETF4
ADDRGP4 $666
JUMPV
LABELV $669
line 1489
;1487:	}
;1488:
;1489:	value = DC->getCVarValue(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 1491
;1490:
;1491:	if (value < editDef->minVal) {
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRP4
INDIRF4
GEF4 $671
line 1492
;1492:		value = editDef->minVal;
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRF4
ASGNF4
line 1493
;1493:	} else if (value > editDef->maxVal) {
ADDRGP4 $672
JUMPV
LABELV $671
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
LEF4 $673
line 1494
;1494:		value = editDef->maxVal;
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 1495
;1495:	}
LABELV $673
LABELV $672
line 1497
;1496:
;1497:	range = editDef->maxVal - editDef->minVal;
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
INDIRF4
SUBF4
ASGNF4
line 1498
;1498:	value -= editDef->minVal;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRP4
INDIRF4
SUBF4
ASGNF4
line 1499
;1499:	value /= range;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
DIVF4
ASGNF4
line 1501
;1500:	//value /= (editDef->maxVal - editDef->minVal);
;1501:	value *= SLIDER_WIDTH;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1119879168
MULF4
ASGNF4
line 1502
;1502:	x += value;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
line 1505
;1503:	// vm fuckage
;1504:	//x = x + (((float)value / editDef->maxVal) * SLIDER_WIDTH);
;1505:	return x;
ADDRLP4 8
INDIRF4
RETF4
LABELV $666
endproc Item_Slider_ThumbPosition 24 4
export Item_Slider_OverSlider
proc Item_Slider_OverSlider 24 12
line 1508
;1506:}
;1507:
;1508:int Item_Slider_OverSlider(itemDef_t *item, float x, float y) {
line 1511
;1509:	rectDef_t r;
;1510:
;1511:	r.x = Item_Slider_ThumbPosition(item) - (SLIDER_THUMB_WIDTH / 2);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Item_Slider_ThumbPosition
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
CNSTF4 1086324736
SUBF4
ASGNF4
line 1512
;1512:	r.y = item->window.rect.y - 2;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 1513
;1513:	r.w = SLIDER_THUMB_WIDTH;
ADDRLP4 0+8
CNSTF4 1094713344
ASGNF4
line 1514
;1514:	r.h = SLIDER_THUMB_HEIGHT;
ADDRLP4 0+12
CNSTF4 1101004800
ASGNF4
line 1516
;1515:
;1516:	if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $679
line 1517
;1517:		return WINDOW_LB_THUMB;
CNSTI4 8192
RETI4
ADDRGP4 $675
JUMPV
LABELV $679
line 1519
;1518:	}
;1519:	return 0;
CNSTI4 0
RETI4
LABELV $675
endproc Item_Slider_OverSlider 24 12
export Item_ListBox_OverLB
proc Item_ListBox_OverLB 72 12
line 1522
;1520:}
;1521:
;1522:int Item_ListBox_OverLB(itemDef_t *item, float x, float y) {
line 1528
;1523:	rectDef_t r;
;1524:	listBoxDef_t *listPtr;
;1525:	int thumbstart;
;1526:	int count;
;1527:
;1528:	count = DC->feederCount(item->special);
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 28
INDIRI4
ASGNI4
line 1529
;1529:	listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1530
;1530:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $682
line 1532
;1531:		// check if on left arrow
;1532:		r.x = item->window.rect.x;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 1533
;1533:		r.y = item->window.rect.y + item->window.rect.h - SCROLLBAR_SIZE;
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1534
;1534:		r.h = r.w = SCROLLBAR_SIZE;
ADDRLP4 36
CNSTF4 1098907648
ASGNF4
ADDRLP4 0+8
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0+12
ADDRLP4 36
INDIRF4
ASGNF4
line 1535
;1535:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $687
line 1536
;1536:			return WINDOW_LB_LEFTARROW;
CNSTI4 2048
RETI4
ADDRGP4 $681
JUMPV
LABELV $687
line 1539
;1537:		}
;1538:		// check if on right arrow
;1539:		r.x = item->window.rect.x + item->window.rect.w - SCROLLBAR_SIZE;
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 44
INDIRP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1540
;1540:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $689
line 1541
;1541:			return WINDOW_LB_RIGHTARROW;
CNSTI4 4096
RETI4
ADDRGP4 $681
JUMPV
LABELV $689
line 1544
;1542:		}
;1543:		// check if on thumb
;1544:		thumbstart = Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 Item_ListBox_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 52
INDIRI4
ASGNI4
line 1545
;1545:		r.x = thumbstart;
ADDRLP4 0
ADDRLP4 16
INDIRI4
CVIF4 4
ASGNF4
line 1546
;1546:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 56
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $691
line 1547
;1547:			return WINDOW_LB_THUMB;
CNSTI4 8192
RETI4
ADDRGP4 $681
JUMPV
LABELV $691
line 1549
;1548:		}
;1549:		r.x = item->window.rect.x + SCROLLBAR_SIZE;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1550
;1550:		r.w = thumbstart - r.x;
ADDRLP4 0+8
ADDRLP4 16
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
line 1551
;1551:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 60
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $694
line 1552
;1552:			return WINDOW_LB_PGUP;
CNSTI4 16384
RETI4
ADDRGP4 $681
JUMPV
LABELV $694
line 1554
;1553:		}
;1554:		r.x = thumbstart + SCROLLBAR_SIZE;
ADDRLP4 0
ADDRLP4 16
INDIRI4
CVIF4 4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1555
;1555:		r.w = item->window.rect.x + item->window.rect.w - SCROLLBAR_SIZE;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 64
INDIRP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1556
;1556:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $683
line 1557
;1557:			return WINDOW_LB_PGDN;
CNSTI4 32768
RETI4
ADDRGP4 $681
JUMPV
line 1559
;1558:		}
;1559:	} else {
LABELV $682
line 1560
;1560:		r.x = item->window.rect.x + item->window.rect.w - SCROLLBAR_SIZE;
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1561
;1561:		r.y = item->window.rect.y;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 1562
;1562:		r.h = r.w = SCROLLBAR_SIZE;
ADDRLP4 36
CNSTF4 1098907648
ASGNF4
ADDRLP4 0+8
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0+12
ADDRLP4 36
INDIRF4
ASGNF4
line 1563
;1563:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $702
line 1564
;1564:			return WINDOW_LB_LEFTARROW;
CNSTI4 2048
RETI4
ADDRGP4 $681
JUMPV
LABELV $702
line 1566
;1565:		}
;1566:		r.y = item->window.rect.y + item->window.rect.h - SCROLLBAR_SIZE;
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 44
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1567
;1567:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $705
line 1568
;1568:			return WINDOW_LB_RIGHTARROW;
CNSTI4 4096
RETI4
ADDRGP4 $681
JUMPV
LABELV $705
line 1570
;1569:		}
;1570:		thumbstart = Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 Item_ListBox_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 52
INDIRI4
ASGNI4
line 1571
;1571:		r.y = thumbstart;
ADDRLP4 0+4
ADDRLP4 16
INDIRI4
CVIF4 4
ASGNF4
line 1572
;1572:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 56
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $708
line 1573
;1573:			return WINDOW_LB_THUMB;
CNSTI4 8192
RETI4
ADDRGP4 $681
JUMPV
LABELV $708
line 1575
;1574:		}
;1575:		r.y = item->window.rect.y + SCROLLBAR_SIZE;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1576
;1576:		r.h = thumbstart - r.y;
ADDRLP4 0+12
ADDRLP4 16
INDIRI4
CVIF4 4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
line 1577
;1577:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 60
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $713
line 1578
;1578:			return WINDOW_LB_PGUP;
CNSTI4 16384
RETI4
ADDRGP4 $681
JUMPV
LABELV $713
line 1580
;1579:		}
;1580:		r.y = thumbstart + SCROLLBAR_SIZE;
ADDRLP4 0+4
ADDRLP4 16
INDIRI4
CVIF4 4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1581
;1581:		r.h = item->window.rect.y + item->window.rect.h - SCROLLBAR_SIZE;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+12
ADDRLP4 64
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1582
;1582:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $717
line 1583
;1583:			return WINDOW_LB_PGDN;
CNSTI4 32768
RETI4
ADDRGP4 $681
JUMPV
LABELV $717
line 1585
;1584:		}
;1585:	}
LABELV $683
line 1586
;1586:	return 0;
CNSTI4 0
RETI4
LABELV $681
endproc Item_ListBox_OverLB 72 12
export Item_ListBox_MouseEnter
proc Item_ListBox_MouseEnter 52 12
line 1591
;1587:}
;1588:
;1589:
;1590:void Item_ListBox_MouseEnter(itemDef_t *item, float x, float y) 
;1591:{
line 1593
;1592:	rectDef_t r;
;1593:	listBoxDef_t *listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1595
;1594:        
;1595:	item->window.flags &= ~(WINDOW_LB_LEFTARROW | WINDOW_LB_RIGHTARROW | WINDOW_LB_THUMB | WINDOW_LB_PGUP | WINDOW_LB_PGDN);
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 -63489
BANDI4
ASGNI4
line 1596
;1596:	item->window.flags |= Item_ListBox_OverLB(item, x, y);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 Item_ListBox_OverLB
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 24
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
ADDRLP4 28
INDIRI4
BORI4
ASGNI4
line 1598
;1597:
;1598:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $720
line 1599
;1599:		if (!(item->window.flags & (WINDOW_LB_LEFTARROW | WINDOW_LB_RIGHTARROW | WINDOW_LB_THUMB | WINDOW_LB_PGUP | WINDOW_LB_PGDN))) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 63488
BANDI4
CNSTI4 0
NEI4 $721
line 1601
;1600:			// check for selection hit as we have exausted buttons and thumb
;1601:			if (listPtr->elementStyle == LISTBOX_IMAGE) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 1
NEI4 $721
line 1602
;1602:				r.x = item->window.rect.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 1603
;1603:				r.y = item->window.rect.y;
ADDRLP4 4+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 1604
;1604:				r.h = item->window.rect.h - SCROLLBAR_SIZE;
ADDRLP4 4+12
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1605
;1605:				r.w = item->window.rect.w - listPtr->drawPadding;
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 1606
;1606:				if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $721
line 1607
;1607:					listPtr->cursorPos =  (int)((x - r.x) / listPtr->elementWidth)  + listPtr->startPos;
ADDRLP4 40
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ADDRLP4 40
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
DIVF4
CVFI4 4
ADDRLP4 40
INDIRP4
INDIRI4
ADDI4
ASGNI4
line 1608
;1608:					if (listPtr->cursorPos >= listPtr->endPos) {
ADDRLP4 44
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 44
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LTI4 $721
line 1609
;1609:						listPtr->cursorPos = listPtr->endPos;
ADDRLP4 48
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1610
;1610:					}
line 1611
;1611:				}
line 1612
;1612:			} else {
line 1614
;1613:				// text hit.. 
;1614:			}
line 1615
;1615:		}
line 1616
;1616:	} else if (!(item->window.flags & (WINDOW_LB_LEFTARROW | WINDOW_LB_RIGHTARROW | WINDOW_LB_THUMB | WINDOW_LB_PGUP | WINDOW_LB_PGDN))) {
ADDRGP4 $721
JUMPV
LABELV $720
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 63488
BANDI4
CNSTI4 0
NEI4 $733
line 1617
;1617:		r.x = item->window.rect.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 1618
;1618:		r.y = item->window.rect.y;
ADDRLP4 4+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 1619
;1619:		r.w = item->window.rect.w - SCROLLBAR_SIZE;
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1620
;1620:		r.h = item->window.rect.h - listPtr->drawPadding;
ADDRLP4 4+12
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 1621
;1621:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $738
line 1622
;1622:			listPtr->cursorPos =  (int)((y - 2 - r.y) / listPtr->elementHeight)  + listPtr->startPos;
ADDRLP4 40
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 8
INDIRF4
CNSTF4 1073741824
SUBF4
ADDRLP4 4+4
INDIRF4
SUBF4
ADDRLP4 40
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
DIVF4
CVFI4 4
ADDRLP4 40
INDIRP4
INDIRI4
ADDI4
ASGNI4
line 1623
;1623:			if (listPtr->cursorPos > listPtr->endPos) {
ADDRLP4 44
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 44
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LEI4 $741
line 1624
;1624:				listPtr->cursorPos = listPtr->endPos;
ADDRLP4 48
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1625
;1625:			}
LABELV $741
line 1626
;1626:		}
LABELV $738
line 1627
;1627:	}
LABELV $733
LABELV $721
line 1628
;1628:}
LABELV $719
endproc Item_ListBox_MouseEnter 52 12
export Item_MouseEnter
proc Item_MouseEnter 44 12
line 1630
;1629:
;1630:void Item_MouseEnter(itemDef_t *item, float x, float y) {
line 1632
;1631:	rectDef_t r;
;1632:	if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $744
line 1633
;1633:		r = item->textRect;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRB
ASGNB 16
line 1634
;1634:		r.y -= r.h;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 0+12
INDIRF4
SUBF4
ASGNF4
line 1638
;1635:		// in the text rect?
;1636:
;1637:		// items can be enabled and disabled based on cvars
;1638:		if (item->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(item, CVAR_ENABLE)) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $748
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 20
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $748
line 1639
;1639:			return;
ADDRGP4 $743
JUMPV
LABELV $748
line 1642
;1640:		}
;1641:
;1642:		if (item->cvarFlags & (CVAR_SHOW | CVAR_HIDE) && !Item_EnableShowViaCvar(item, CVAR_SHOW)) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 12
BANDI4
CNSTI4 0
EQI4 $750
ADDRLP4 24
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 28
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $750
line 1643
;1643:			return;
ADDRGP4 $743
JUMPV
LABELV $750
line 1646
;1644:		}
;1645:
;1646:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $752
line 1647
;1647:			if (!(item->window.flags & WINDOW_MOUSEOVERTEXT)) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
NEI4 $754
line 1648
;1648:				Item_RunScript(item, item->mouseEnterText);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1649
;1649:				item->window.flags |= WINDOW_MOUSEOVERTEXT;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 1650
;1650:			}
LABELV $754
line 1651
;1651:			if (!(item->window.flags & WINDOW_MOUSEOVER)) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $753
line 1652
;1652:				Item_RunScript(item, item->mouseEnter);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 244
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1653
;1653:				item->window.flags |= WINDOW_MOUSEOVER;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1654
;1654:			}
line 1656
;1655:
;1656:		} else {
ADDRGP4 $753
JUMPV
LABELV $752
line 1658
;1657:			// not in the text rect
;1658:			if (item->window.flags & WINDOW_MOUSEOVERTEXT) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $758
line 1660
;1659:				// if we were
;1660:				Item_RunScript(item, item->mouseExitText);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1661
;1661:				item->window.flags &= ~WINDOW_MOUSEOVERTEXT;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1662
;1662:			}
LABELV $758
line 1663
;1663:			if (!(item->window.flags & WINDOW_MOUSEOVER)) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $760
line 1664
;1664:				Item_RunScript(item, item->mouseEnter);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 244
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1665
;1665:				item->window.flags |= WINDOW_MOUSEOVER;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1666
;1666:			}
LABELV $760
line 1668
;1667:
;1668:			if (item->type == ITEM_TYPE_LISTBOX) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 6
NEI4 $762
line 1669
;1669:				Item_ListBox_MouseEnter(item, x, y);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRGP4 Item_ListBox_MouseEnter
CALLV
pop
line 1670
;1670:			}
LABELV $762
line 1671
;1671:		}
LABELV $753
line 1672
;1672:	}
LABELV $744
line 1673
;1673:}
LABELV $743
endproc Item_MouseEnter 44 12
export Item_MouseLeave
proc Item_MouseLeave 8 8
line 1675
;1674:
;1675:void Item_MouseLeave(itemDef_t *item) {
line 1676
;1676:  if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $765
line 1677
;1677:    if (item->window.flags & WINDOW_MOUSEOVERTEXT) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $767
line 1678
;1678:      Item_RunScript(item, item->mouseExitText);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1679
;1679:      item->window.flags &= ~WINDOW_MOUSEOVERTEXT;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1680
;1680:    }
LABELV $767
line 1681
;1681:    Item_RunScript(item, item->mouseExit);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1682
;1682:    item->window.flags &= ~(WINDOW_LB_RIGHTARROW | WINDOW_LB_LEFTARROW);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -6145
BANDI4
ASGNI4
line 1683
;1683:  }
LABELV $765
line 1684
;1684:}
LABELV $764
endproc Item_MouseLeave 8 8
export Menu_HitTest
proc Menu_HitTest 8 12
line 1686
;1685:
;1686:itemDef_t *Menu_HitTest(menuDef_t *menu, float x, float y) {
line 1688
;1687:  int i;
;1688:  for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $773
JUMPV
LABELV $770
line 1689
;1689:    if (Rect_ContainsPoint(&menu->items[i]->window.rect, x, y)) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $774
line 1690
;1690:      return menu->items[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $769
JUMPV
LABELV $774
line 1692
;1691:    }
;1692:  }
LABELV $771
line 1688
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $773
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $770
line 1693
;1693:  return NULL;
CNSTP4 0
RETP4
LABELV $769
endproc Menu_HitTest 8 12
export Item_SetMouseOver
proc Item_SetMouseOver 4 0
line 1696
;1694:}
;1695:
;1696:void Item_SetMouseOver(itemDef_t *item, qboolean focus) {
line 1697
;1697:  if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $777
line 1698
;1698:    if (focus) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $779
line 1699
;1699:      item->window.flags |= WINDOW_MOUSEOVER;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1700
;1700:    } else {
ADDRGP4 $780
JUMPV
LABELV $779
line 1701
;1701:      item->window.flags &= ~WINDOW_MOUSEOVER;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 1702
;1702:    }
LABELV $780
line 1703
;1703:  }
LABELV $777
line 1704
;1704:}
LABELV $776
endproc Item_SetMouseOver 4 0
export Item_OwnerDraw_HandleKey
proc Item_OwnerDraw_HandleKey 8 16
line 1707
;1705:
;1706:
;1707:qboolean Item_OwnerDraw_HandleKey(itemDef_t *item, int key) {
line 1708
;1708:  if (item && DC->ownerDrawHandleKey) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $782
ADDRGP4 DC
INDIRP4
CNSTI4 116
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $782
line 1709
;1709:    return DC->ownerDrawHandleKey(item->window.ownerDraw, item->window.ownerDrawFlags, &item->special, key);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 DC
INDIRP4
CNSTI4 116
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $781
JUMPV
LABELV $782
line 1711
;1710:  }
;1711:  return qfalse;
CNSTI4 0
RETI4
LABELV $781
endproc Item_OwnerDraw_HandleKey 8 16
export Item_ListBox_HandleKey
proc Item_ListBox_HandleKey 68 12
line 1714
;1712:}
;1713:
;1714:qboolean Item_ListBox_HandleKey(itemDef_t *item, int key, qboolean down, qboolean force) {
line 1715
;1715:	listBoxDef_t *listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1716
;1716:	int count = DC->feederCount(item->special);
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
ASGNI4
line 1719
;1717:	int max, viewmax;
;1718:
;1719:	if (force || (Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory) && item->window.flags & WINDOW_HASFOCUS)) {
ADDRFP4 12
INDIRI4
CNSTI4 0
NEI4 $787
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $785
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $785
LABELV $787
line 1720
;1720:		max = Item_ListBox_MaxScroll(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 Item_ListBox_MaxScroll
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 28
INDIRI4
ASGNI4
line 1721
;1721:		if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $788
line 1722
;1722:			viewmax = (item->window.rect.w / listPtr->elementWidth);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 1723
;1723:			if ( key == K_LEFTARROW || key == K_KP_LEFTARROW ) 
ADDRLP4 32
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 134
EQI4 $792
ADDRLP4 32
INDIRI4
CNSTI4 163
NEI4 $790
LABELV $792
line 1724
;1724:			{
line 1725
;1725:				if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $793
line 1726
;1726:					listPtr->cursorPos--;
ADDRLP4 36
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1727
;1727:					if (listPtr->cursorPos < 0) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
GEI4 $795
line 1728
;1728:						listPtr->cursorPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 1729
;1729:					}
LABELV $795
line 1730
;1730:					if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $797
line 1731
;1731:						listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1732
;1732:					}
LABELV $797
line 1733
;1733:					if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
LTI4 $799
line 1734
;1734:						listPtr->startPos = listPtr->cursorPos - viewmax + 1;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1735
;1735:					}
LABELV $799
line 1736
;1736:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1737
;1737:					DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 48
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLV
pop
line 1738
;1738:				}
ADDRGP4 $794
JUMPV
LABELV $793
line 1739
;1739:				else {
line 1740
;1740:					listPtr->startPos--;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1741
;1741:					if (listPtr->startPos < 0)
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $801
line 1742
;1742:						listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
LABELV $801
line 1743
;1743:				}
LABELV $794
line 1744
;1744:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $784
JUMPV
LABELV $790
line 1746
;1745:			}
;1746:			if ( key == K_RIGHTARROW || key == K_KP_RIGHTARROW ) 
ADDRLP4 36
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 135
EQI4 $805
ADDRLP4 36
INDIRI4
CNSTI4 165
NEI4 $789
LABELV $805
line 1747
;1747:			{
line 1748
;1748:				if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $806
line 1749
;1749:					listPtr->cursorPos++;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1750
;1750:					if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $808
line 1751
;1751:						listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1752
;1752:					}
LABELV $808
line 1753
;1753:					if (listPtr->cursorPos >= count) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $810
line 1754
;1754:						listPtr->cursorPos = count-1;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1755
;1755:					}
LABELV $810
line 1756
;1756:					if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
LTI4 $812
line 1757
;1757:						listPtr->startPos = listPtr->cursorPos - viewmax + 1;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1758
;1758:					}
LABELV $812
line 1759
;1759:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1760
;1760:					DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLV
pop
line 1761
;1761:				}
ADDRGP4 $807
JUMPV
LABELV $806
line 1762
;1762:				else {
line 1763
;1763:					listPtr->startPos++;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1764
;1764:					if (listPtr->startPos >= count)
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $814
line 1765
;1765:						listPtr->startPos = count-1;
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $814
line 1766
;1766:				}
LABELV $807
line 1767
;1767:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $784
JUMPV
line 1769
;1768:			}
;1769:		}
LABELV $788
line 1770
;1770:		else {
line 1771
;1771:			viewmax = (item->window.rect.h / listPtr->elementHeight);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 1772
;1772:			if ( key == K_UPARROW || key == K_KP_UPARROW ) 
ADDRLP4 32
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 132
EQI4 $818
ADDRLP4 32
INDIRI4
CNSTI4 161
NEI4 $816
LABELV $818
line 1773
;1773:			{
line 1774
;1774:				if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $819
line 1775
;1775:					listPtr->cursorPos--;
ADDRLP4 36
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1776
;1776:					if (listPtr->cursorPos < 0) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
GEI4 $821
line 1777
;1777:						listPtr->cursorPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 1778
;1778:					}
LABELV $821
line 1779
;1779:					if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $823
line 1780
;1780:						listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1781
;1781:					}
LABELV $823
line 1782
;1782:					if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
LTI4 $825
line 1783
;1783:						listPtr->startPos = listPtr->cursorPos - viewmax + 1;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1784
;1784:					}
LABELV $825
line 1785
;1785:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1786
;1786:					DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 48
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLV
pop
line 1787
;1787:				}
ADDRGP4 $820
JUMPV
LABELV $819
line 1788
;1788:				else {
line 1789
;1789:					listPtr->startPos--;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1790
;1790:					if (listPtr->startPos < 0)
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $827
line 1791
;1791:						listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
LABELV $827
line 1792
;1792:				}
LABELV $820
line 1793
;1793:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $784
JUMPV
LABELV $816
line 1795
;1794:			}
;1795:			if ( key == K_DOWNARROW || key == K_KP_DOWNARROW ) 
ADDRLP4 36
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 133
EQI4 $831
ADDRLP4 36
INDIRI4
CNSTI4 167
NEI4 $829
LABELV $831
line 1796
;1796:			{
line 1797
;1797:				if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $832
line 1798
;1798:					listPtr->cursorPos++;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1799
;1799:					if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $834
line 1800
;1800:						listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1801
;1801:					}
LABELV $834
line 1802
;1802:					if (listPtr->cursorPos >= count) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $836
line 1803
;1803:						listPtr->cursorPos = count-1;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1804
;1804:					}
LABELV $836
line 1805
;1805:					if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
LTI4 $838
line 1806
;1806:						listPtr->startPos = listPtr->cursorPos - viewmax + 1;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1807
;1807:					}
LABELV $838
line 1808
;1808:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1809
;1809:					DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLV
pop
line 1810
;1810:				}
ADDRGP4 $833
JUMPV
LABELV $832
line 1811
;1811:				else {
line 1812
;1812:					listPtr->startPos++;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1813
;1813:					if (listPtr->startPos > max)
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $840
line 1814
;1814:						listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
LABELV $840
line 1815
;1815:				}
LABELV $833
line 1816
;1816:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $784
JUMPV
LABELV $829
line 1818
;1817:			}
;1818:		}
LABELV $789
line 1820
;1819:		// mouse hit
;1820:		if (key == K_MOUSE1 || key == K_MOUSE2) {
ADDRLP4 32
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 178
EQI4 $844
ADDRLP4 32
INDIRI4
CNSTI4 179
NEI4 $842
LABELV $844
line 1821
;1821:			if (item->window.flags & WINDOW_LB_LEFTARROW) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $845
line 1822
;1822:				listPtr->startPos--;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1823
;1823:				if (listPtr->startPos < 0) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $846
line 1824
;1824:					listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1825
;1825:				}
line 1826
;1826:			} else if (item->window.flags & WINDOW_LB_RIGHTARROW) {
ADDRGP4 $846
JUMPV
LABELV $845
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $849
line 1828
;1827:				// one down
;1828:				listPtr->startPos++;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1829
;1829:				if (listPtr->startPos > max) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $850
line 1830
;1830:					listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1831
;1831:				}
line 1832
;1832:			} else if (item->window.flags & WINDOW_LB_PGUP) {
ADDRGP4 $850
JUMPV
LABELV $849
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $853
line 1834
;1833:				// page up
;1834:				listPtr->startPos -= viewmax;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 1835
;1835:				if (listPtr->startPos < 0) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $854
line 1836
;1836:					listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1837
;1837:				}
line 1838
;1838:			} else if (item->window.flags & WINDOW_LB_PGDN) {
ADDRGP4 $854
JUMPV
LABELV $853
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $857
line 1840
;1839:				// page down
;1840:				listPtr->startPos += viewmax;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1841
;1841:				if (listPtr->startPos > max) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $858
line 1842
;1842:					listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1843
;1843:				}
line 1844
;1844:			} else if (item->window.flags & WINDOW_LB_THUMB) {
ADDRGP4 $858
JUMPV
LABELV $857
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $861
line 1846
;1845:				// Display_SetCaptureItem(item);
;1846:			} else {
ADDRGP4 $862
JUMPV
LABELV $861
line 1848
;1847:				// select an item
;1848:				if (DC->realTime < lastListBoxClickTime && listPtr->doubleClick) {
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRGP4 lastListBoxClickTime
INDIRI4
GEI4 $863
ADDRLP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $863
line 1849
;1849:					Item_RunScript(item, listPtr->doubleClick);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1850
;1850:				}
LABELV $863
line 1851
;1851:				lastListBoxClickTime = DC->realTime + DOUBLE_CLICK_DELAY;
ADDRGP4 lastListBoxClickTime
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 300
ADDI4
ASGNI4
line 1852
;1852:				if (item->cursorPos != listPtr->cursorPos) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
EQI4 $865
line 1853
;1853:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1854
;1854:					DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLV
pop
line 1855
;1855:				}
LABELV $865
line 1856
;1856:			}
LABELV $862
LABELV $858
LABELV $854
LABELV $850
LABELV $846
line 1857
;1857:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $784
JUMPV
LABELV $842
line 1859
;1858:		}
;1859:		if ( key == K_HOME || key == K_KP_HOME) {
ADDRLP4 36
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 143
EQI4 $869
ADDRLP4 36
INDIRI4
CNSTI4 160
NEI4 $867
LABELV $869
line 1861
;1860:			// home
;1861:			listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1862
;1862:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $784
JUMPV
LABELV $867
line 1864
;1863:		}
;1864:		if ( key == K_END || key == K_KP_END) {
ADDRLP4 40
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 144
EQI4 $872
ADDRLP4 40
INDIRI4
CNSTI4 166
NEI4 $870
LABELV $872
line 1866
;1865:			// end
;1866:			listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1867
;1867:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $784
JUMPV
LABELV $870
line 1869
;1868:		}
;1869:		if (key == K_PGUP || key == K_KP_PGUP ) {
ADDRLP4 44
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 142
EQI4 $875
ADDRLP4 44
INDIRI4
CNSTI4 162
NEI4 $873
LABELV $875
line 1871
;1870:			// page up
;1871:			if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $876
line 1872
;1872:				listPtr->cursorPos -= viewmax;
ADDRLP4 48
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 1873
;1873:				if (listPtr->cursorPos < 0) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
GEI4 $878
line 1874
;1874:					listPtr->cursorPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 1875
;1875:				}
LABELV $878
line 1876
;1876:				if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $880
line 1877
;1877:					listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1878
;1878:				}
LABELV $880
line 1879
;1879:				if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
LTI4 $882
line 1880
;1880:					listPtr->startPos = listPtr->cursorPos - viewmax + 1;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1881
;1881:				}
LABELV $882
line 1882
;1882:				item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1883
;1883:				DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLV
pop
line 1884
;1884:			}
ADDRGP4 $877
JUMPV
LABELV $876
line 1885
;1885:			else {
line 1886
;1886:				listPtr->startPos -= viewmax;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 1887
;1887:				if (listPtr->startPos < 0) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $884
line 1888
;1888:					listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1889
;1889:				}
LABELV $884
line 1890
;1890:			}
LABELV $877
line 1891
;1891:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $784
JUMPV
LABELV $873
line 1893
;1892:		}
;1893:		if ( key == K_PGDN || key == K_KP_PGDN ) {
ADDRLP4 48
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 141
EQI4 $888
ADDRLP4 48
INDIRI4
CNSTI4 168
NEI4 $886
LABELV $888
line 1895
;1894:			// page down
;1895:			if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $889
line 1896
;1896:				listPtr->cursorPos += viewmax;
ADDRLP4 52
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1897
;1897:				if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $891
line 1898
;1898:					listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1899
;1899:				}
LABELV $891
line 1900
;1900:				if (listPtr->cursorPos >= count) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $893
line 1901
;1901:					listPtr->cursorPos = count-1;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1902
;1902:				}
LABELV $893
line 1903
;1903:				if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
LTI4 $895
line 1904
;1904:					listPtr->startPos = listPtr->cursorPos - viewmax + 1;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1905
;1905:				}
LABELV $895
line 1906
;1906:				item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1907
;1907:				DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 64
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLV
pop
line 1908
;1908:			}
ADDRGP4 $890
JUMPV
LABELV $889
line 1909
;1909:			else {
line 1910
;1910:				listPtr->startPos += viewmax;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1911
;1911:				if (listPtr->startPos > max) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $897
line 1912
;1912:					listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1913
;1913:				}
LABELV $897
line 1914
;1914:			}
LABELV $890
line 1915
;1915:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $784
JUMPV
LABELV $886
line 1917
;1916:		}
;1917:	}
LABELV $785
line 1918
;1918:	return qfalse;
CNSTI4 0
RETI4
LABELV $784
endproc Item_ListBox_HandleKey 68 12
export Item_YesNo_HandleKey
proc Item_YesNo_HandleKey 28 12
line 1921
;1919:}
;1920:
;1921:qboolean Item_YesNo_HandleKey(itemDef_t *item, int key) {
line 1923
;1922:
;1923:  if (Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory) && item->window.flags & WINDOW_HASFOCUS && item->cvar) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $900
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $900
ADDRLP4 8
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $900
line 1924
;1924:		if (key == K_MOUSE1 || key == K_ENTER || key == K_MOUSE2 || key == K_MOUSE3) {
ADDRLP4 12
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 178
EQI4 $906
ADDRLP4 12
INDIRI4
CNSTI4 13
EQI4 $906
ADDRLP4 12
INDIRI4
CNSTI4 179
EQI4 $906
ADDRLP4 12
INDIRI4
CNSTI4 180
NEI4 $902
LABELV $906
line 1925
;1925:	    DC->setCVar(item->cvar, va("%i", !DC->getCVarValue(item->cvar)));
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 20
INDIRF4
CNSTF4 0
NEF4 $909
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $910
JUMPV
LABELV $909
ADDRLP4 16
CNSTI4 0
ASGNI4
LABELV $910
ADDRGP4 $907
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 1926
;1926:		  return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $899
JUMPV
LABELV $902
line 1928
;1927:		}
;1928:  }
LABELV $900
line 1930
;1929:
;1930:  return qfalse;
CNSTI4 0
RETI4
LABELV $899
endproc Item_YesNo_HandleKey 28 12
export Item_Multi_CountSettings
proc Item_Multi_CountSettings 4 0
line 1934
;1931:
;1932:}
;1933:
;1934:int Item_Multi_CountSettings(itemDef_t *item) {
line 1935
;1935:	multiDef_t *multiPtr = (multiDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1936
;1936:	if (multiPtr == NULL) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $912
line 1937
;1937:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $911
JUMPV
LABELV $912
line 1939
;1938:	}
;1939:	return multiPtr->count;
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
RETI4
LABELV $911
endproc Item_Multi_CountSettings 4 0
export Item_Multi_FindCvarByValue
proc Item_Multi_FindCvarByValue 1040 12
line 1942
;1940:}
;1941:
;1942:int Item_Multi_FindCvarByValue(itemDef_t *item) {
line 1944
;1943:	char buff[1024];
;1944:	float value = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 1946
;1945:	int i;
;1946:	multiDef_t *multiPtr = (multiDef_t*)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1947
;1947:	if (multiPtr) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $915
line 1948
;1948:		if (multiPtr->strDef) {
ADDRLP4 4
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $917
line 1949
;1949:	    DC->getCVarString(item->cvar, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 1950
;1950:		} else {
ADDRGP4 $918
JUMPV
LABELV $917
line 1951
;1951:			value = DC->getCVarValue(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 1036
INDIRF4
ASGNF4
line 1952
;1952:		}
LABELV $918
line 1953
;1953:		for (i = 0; i < multiPtr->count; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $922
JUMPV
LABELV $919
line 1954
;1954:			if (multiPtr->strDef) {
ADDRLP4 4
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $923
line 1955
;1955:				if (Q_stricmp(buff, multiPtr->cvarStr[i]) == 0) {
ADDRLP4 12
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 128
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $924
line 1956
;1956:					return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $914
JUMPV
line 1958
;1957:				}
;1958:			} else {
LABELV $923
line 1959
;1959: 				if (multiPtr->cvarValue[i] == value) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 256
ADDP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
NEF4 $927
line 1960
;1960: 					return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $914
JUMPV
LABELV $927
line 1962
;1961: 				}
;1962: 			}
LABELV $924
line 1963
;1963: 		}
LABELV $920
line 1953
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $922
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
LTI4 $919
line 1964
;1964:	}
LABELV $915
line 1965
;1965:	return 0;
CNSTI4 0
RETI4
LABELV $914
endproc Item_Multi_FindCvarByValue 1040 12
export Item_Multi_Setting
proc Item_Multi_Setting 1040 12
line 1968
;1966:}
;1967:
;1968:const char *Item_Multi_Setting(itemDef_t *item) {
line 1970
;1969:	char buff[1024];
;1970:	float value = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 1972
;1971:	int i;
;1972:	multiDef_t *multiPtr = (multiDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1973
;1973:	if (multiPtr) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $930
line 1974
;1974:		if (multiPtr->strDef) {
ADDRLP4 0
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $932
line 1975
;1975:	    DC->getCVarString(item->cvar, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 1976
;1976:		} else {
ADDRGP4 $933
JUMPV
LABELV $932
line 1977
;1977:			value = DC->getCVarValue(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 1036
INDIRF4
ASGNF4
line 1978
;1978:		}
LABELV $933
line 1979
;1979:		for (i = 0; i < multiPtr->count; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $937
JUMPV
LABELV $934
line 1980
;1980:			if (multiPtr->strDef) {
ADDRLP4 0
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $938
line 1981
;1981:				if (Q_stricmp(buff, multiPtr->cvarStr[i]) == 0) {
ADDRLP4 12
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $939
line 1982
;1982:					return multiPtr->cvarList[i];
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $929
JUMPV
line 1984
;1983:				}
;1984:			} else {
LABELV $938
line 1985
;1985: 				if (multiPtr->cvarValue[i] == value) {
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
NEF4 $942
line 1986
;1986:					return multiPtr->cvarList[i];
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $929
JUMPV
LABELV $942
line 1988
;1987: 				}
;1988: 			}
LABELV $939
line 1989
;1989: 		}
LABELV $935
line 1979
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $937
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
LTI4 $934
line 1990
;1990:	}
LABELV $930
line 1991
;1991:	return "";
ADDRGP4 $54
RETP4
LABELV $929
endproc Item_Multi_Setting 1040 12
export Item_Multi_HandleKey
proc Item_Multi_HandleKey 52 12
line 1994
;1992:}
;1993:
;1994:qboolean Item_Multi_HandleKey(itemDef_t *item, int key) {
line 1995
;1995:	multiDef_t *multiPtr = (multiDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1996
;1996:	if (multiPtr) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $945
line 1997
;1997:	  if (Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory) && item->window.flags & WINDOW_HASFOCUS && item->cvar) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $947
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $947
ADDRLP4 12
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $947
line 1998
;1998:			if (key == K_MOUSE1 || key == K_ENTER || key == K_MOUSE2 || key == K_MOUSE3) {
ADDRLP4 16
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 178
EQI4 $953
ADDRLP4 16
INDIRI4
CNSTI4 13
EQI4 $953
ADDRLP4 16
INDIRI4
CNSTI4 179
EQI4 $953
ADDRLP4 16
INDIRI4
CNSTI4 180
NEI4 $949
LABELV $953
line 1999
;1999:				int current = Item_Multi_FindCvarByValue(item) + 1;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 Item_Multi_FindCvarByValue
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2000
;2000:				int max = Item_Multi_CountSettings(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 Item_Multi_CountSettings
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 32
INDIRI4
ASGNI4
line 2001
;2001:				if ( current < 0 || current >= max ) {
ADDRLP4 36
ADDRLP4 20
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
LTI4 $956
ADDRLP4 36
INDIRI4
ADDRLP4 24
INDIRI4
LTI4 $954
LABELV $956
line 2002
;2002:					current = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 2003
;2003:				}
LABELV $954
line 2004
;2004:				if (multiPtr->strDef) {
ADDRLP4 0
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $957
line 2005
;2005:					DC->setCVar(item->cvar, multiPtr->cvarStr[current]);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2006
;2006:				} else {
ADDRGP4 $958
JUMPV
LABELV $957
line 2007
;2007:					float value = multiPtr->cvarValue[current];
ADDRLP4 40
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
ADDP4
INDIRF4
ASGNF4
line 2008
;2008:					if (((float)((int) value)) == value) {
ADDRLP4 44
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 44
INDIRF4
CVFI4 4
CVIF4 4
ADDRLP4 44
INDIRF4
NEF4 $959
line 2009
;2009:						DC->setCVar(item->cvar, va("%i", (int) value ));
ADDRGP4 $907
ARGP4
ADDRLP4 40
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 48
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2010
;2010:					}
ADDRGP4 $960
JUMPV
LABELV $959
line 2011
;2011:					else {
line 2012
;2012:						DC->setCVar(item->cvar, va("%f", value ));
ADDRGP4 $961
ARGP4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2013
;2013:					}
LABELV $960
line 2014
;2014:				}
LABELV $958
line 2015
;2015:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $944
JUMPV
LABELV $949
line 2017
;2016:			}
;2017:		}
LABELV $947
line 2018
;2018:	}
LABELV $945
line 2019
;2019:  return qfalse;
CNSTI4 0
RETI4
LABELV $944
endproc Item_Multi_HandleKey 52 12
export Item_TextField_HandleKey
proc Item_TextField_HandleKey 1076 12
line 2022
;2020:}
;2021:
;2022:qboolean Item_TextField_HandleKey(itemDef_t *item, int key) {
line 2025
;2023:	char buff[1024];
;2024:	int len;
;2025:	itemDef_t *newItem = NULL;
ADDRLP4 1028
CNSTP4 0
ASGNP4
line 2026
;2026:	editFieldDef_t *editPtr = (editFieldDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 2028
;2027:
;2028:	if (item->cvar) {
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $963
line 2030
;2029:
;2030:		memset(buff, 0, sizeof(buff));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 1024
ARGU4
ADDRGP4 memset
CALLP4
pop
line 2031
;2031:		DC->getCVarString(item->cvar, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 2032
;2032:		len = strlen(buff);
ADDRLP4 4
ARGP4
ADDRLP4 1036
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 1032
ADDRLP4 1036
INDIRU4
CVUI4 4
ASGNI4
line 2033
;2033:		if (editPtr->maxChars && len > editPtr->maxChars) {
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $965
ADDRLP4 1032
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
LEI4 $965
line 2034
;2034:			len = editPtr->maxChars;
ADDRLP4 1032
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 2035
;2035:		}
LABELV $965
line 2036
;2036:		if ( key & K_CHAR_FLAG ) {
ADDRFP4 4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $967
line 2037
;2037:			key &= ~K_CHAR_FLAG;
ADDRFP4 4
ADDRFP4 4
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 2040
;2038:
;2039:
;2040:			if (key == 'h' - 'a' + 1 )	{	// ctrl-h is backspace
ADDRFP4 4
INDIRI4
CNSTI4 8
NEI4 $969
line 2041
;2041:				if ( item->cursorPos > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 0
LEI4 $971
line 2042
;2042:					memmove( &buff[item->cursorPos - 1], &buff[item->cursorPos], len + 1 - item->cursorPos);
ADDRLP4 1044
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1044
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 4-1
ADDP4
ARGP4
ADDRLP4 1044
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 1032
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 1044
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
SUBI4
CVIU4 4
ARGU4
ADDRGP4 memmove
CALLP4
pop
line 2043
;2043:					item->cursorPos--;
ADDRLP4 1048
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ASGNP4
ADDRLP4 1048
INDIRP4
ADDRLP4 1048
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2044
;2044:					if (item->cursorPos < editPtr->paintOffset) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
GEI4 $974
line 2045
;2045:						editPtr->paintOffset--;
ADDRLP4 1052
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 1052
INDIRP4
ADDRLP4 1052
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2046
;2046:					}
LABELV $974
line 2047
;2047:				}
LABELV $971
line 2048
;2048:				DC->setCVar(item->cvar, buff);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2049
;2049:	    		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $962
JUMPV
LABELV $969
line 2056
;2050:			}
;2051:
;2052:
;2053:			//
;2054:			// ignore any non printable chars
;2055:			//
;2056:			if ( key < 32 || !item->cvar) {
ADDRFP4 4
INDIRI4
CNSTI4 32
LTI4 $978
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $976
LABELV $978
line 2057
;2057:			    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $962
JUMPV
LABELV $976
line 2060
;2058:		    }
;2059:
;2060:			if (item->type == ITEM_TYPE_NUMERICFIELD) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 9
NEI4 $979
line 2061
;2061:				if (key < '0' || key > '9') {
ADDRLP4 1044
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 48
LTI4 $983
ADDRLP4 1044
INDIRI4
CNSTI4 57
LEI4 $981
LABELV $983
line 2062
;2062:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $962
JUMPV
LABELV $981
line 2064
;2063:				}
;2064:			}
LABELV $979
line 2066
;2065:
;2066:			if (!DC->getOverstrikeMode()) {
ADDRLP4 1044
ADDRGP4 DC
INDIRP4
CNSTI4 108
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $984
line 2067
;2067:				if (( len == MAX_EDITFIELD - 1 ) || (editPtr->maxChars && len >= editPtr->maxChars)) {
ADDRLP4 1048
ADDRLP4 1032
INDIRI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 255
EQI4 $988
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $986
ADDRLP4 1048
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
LTI4 $986
LABELV $988
line 2068
;2068:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $962
JUMPV
LABELV $986
line 2070
;2069:				}
;2070:				memmove( &buff[item->cursorPos + 1], &buff[item->cursorPos], len + 1 - item->cursorPos );
ADDRLP4 1056
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1056
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 4+1
ADDP4
ARGP4
ADDRLP4 1056
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 1032
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 1056
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
SUBI4
CVIU4 4
ARGU4
ADDRGP4 memmove
CALLP4
pop
line 2071
;2071:			} else {
ADDRGP4 $985
JUMPV
LABELV $984
line 2072
;2072:				if (editPtr->maxChars && item->cursorPos >= editPtr->maxChars) {
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $990
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
LTI4 $990
line 2073
;2073:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $962
JUMPV
LABELV $990
line 2075
;2074:				}
;2075:			}
LABELV $985
line 2077
;2076:
;2077:			buff[item->cursorPos] = key;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 4
ADDP4
ADDRFP4 4
INDIRI4
CVII1 4
ASGNI1
line 2079
;2078:
;2079:			DC->setCVar(item->cvar, buff);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2081
;2080:
;2081:			if (item->cursorPos < len + 1) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 1032
INDIRI4
CNSTI4 1
ADDI4
GEI4 $968
line 2082
;2082:				item->cursorPos++;
ADDRLP4 1048
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ASGNP4
ADDRLP4 1048
INDIRP4
ADDRLP4 1048
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2083
;2083:				if (editPtr->maxPaintChars && item->cursorPos > editPtr->maxPaintChars) {
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
EQI4 $968
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
LEI4 $968
line 2084
;2084:					editPtr->paintOffset++;
ADDRLP4 1056
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 1056
INDIRP4
ADDRLP4 1056
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2085
;2085:				}
line 2086
;2086:			}
line 2088
;2087:
;2088:		} else {
ADDRGP4 $968
JUMPV
LABELV $967
line 2090
;2089:
;2090:			if ( key == K_DEL || key == K_KP_DEL ) {
ADDRLP4 1044
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 140
EQI4 $998
ADDRLP4 1044
INDIRI4
CNSTI4 171
NEI4 $996
LABELV $998
line 2091
;2091:				if ( item->cursorPos < len ) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 1032
INDIRI4
GEI4 $999
line 2092
;2092:					memmove( buff + item->cursorPos, buff + item->cursorPos + 1, len - item->cursorPos);
ADDRLP4 1048
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1048
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 1048
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 4+1
ADDP4
ARGP4
ADDRLP4 1032
INDIRI4
ADDRLP4 1048
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
SUBI4
CVIU4 4
ARGU4
ADDRGP4 memmove
CALLP4
pop
line 2093
;2093:					DC->setCVar(item->cvar, buff);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2094
;2094:				}
LABELV $999
line 2095
;2095:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $962
JUMPV
LABELV $996
line 2098
;2096:			}
;2097:
;2098:			if ( key == K_RIGHTARROW || key == K_KP_RIGHTARROW ) 
ADDRLP4 1048
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 135
EQI4 $1004
ADDRLP4 1048
INDIRI4
CNSTI4 165
NEI4 $1002
LABELV $1004
line 2099
;2099:			{
line 2100
;2100:				if (editPtr->maxPaintChars && item->cursorPos >= editPtr->maxPaintChars && item->cursorPos < len) {
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1005
ADDRLP4 1056
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1056
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
LTI4 $1005
ADDRLP4 1056
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 1032
INDIRI4
GEI4 $1005
line 2101
;2101:					item->cursorPos++;
ADDRLP4 1060
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ASGNP4
ADDRLP4 1060
INDIRP4
ADDRLP4 1060
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2102
;2102:					editPtr->paintOffset++;
ADDRLP4 1064
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 1064
INDIRP4
ADDRLP4 1064
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2103
;2103:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $962
JUMPV
LABELV $1005
line 2105
;2104:				}
;2105:				if (item->cursorPos < len) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 1032
INDIRI4
GEI4 $1007
line 2106
;2106:					item->cursorPos++;
ADDRLP4 1060
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ASGNP4
ADDRLP4 1060
INDIRP4
ADDRLP4 1060
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2107
;2107:				} 
LABELV $1007
line 2108
;2108:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $962
JUMPV
LABELV $1002
line 2111
;2109:			}
;2110:
;2111:			if ( key == K_LEFTARROW || key == K_KP_LEFTARROW ) 
ADDRLP4 1052
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 134
EQI4 $1011
ADDRLP4 1052
INDIRI4
CNSTI4 163
NEI4 $1009
LABELV $1011
line 2112
;2112:			{
line 2113
;2113:				if ( item->cursorPos > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1012
line 2114
;2114:					item->cursorPos--;
ADDRLP4 1056
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ASGNP4
ADDRLP4 1056
INDIRP4
ADDRLP4 1056
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2115
;2115:				}
LABELV $1012
line 2116
;2116:				if (item->cursorPos < editPtr->paintOffset) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
GEI4 $1014
line 2117
;2117:					editPtr->paintOffset--;
ADDRLP4 1056
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 1056
INDIRP4
ADDRLP4 1056
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2118
;2118:				}
LABELV $1014
line 2119
;2119:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $962
JUMPV
LABELV $1009
line 2122
;2120:			}
;2121:
;2122:			if ( key == K_HOME || key == K_KP_HOME) {// || ( tolower(key) == 'a' && trap_Key_IsDown( K_CTRL ) ) ) {
ADDRLP4 1056
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 143
EQI4 $1018
ADDRLP4 1056
INDIRI4
CNSTI4 160
NEI4 $1016
LABELV $1018
line 2123
;2123:				item->cursorPos = 0;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 0
ASGNI4
line 2124
;2124:				editPtr->paintOffset = 0;
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 2125
;2125:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $962
JUMPV
LABELV $1016
line 2128
;2126:			}
;2127:
;2128:			if ( key == K_END || key == K_KP_END)  {// ( tolower(key) == 'e' && trap_Key_IsDown( K_CTRL ) ) ) {
ADDRLP4 1060
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 144
EQI4 $1021
ADDRLP4 1060
INDIRI4
CNSTI4 166
NEI4 $1019
LABELV $1021
line 2129
;2129:				item->cursorPos = len;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 1032
INDIRI4
ASGNI4
line 2130
;2130:				if(item->cursorPos > editPtr->maxPaintChars) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
LEI4 $1022
line 2131
;2131:					editPtr->paintOffset = len - editPtr->maxPaintChars;
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 1032
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
SUBI4
ASGNI4
line 2132
;2132:				}
LABELV $1022
line 2133
;2133:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $962
JUMPV
LABELV $1019
line 2136
;2134:			}
;2135:
;2136:			if ( key == K_INS || key == K_KP_INS ) {
ADDRLP4 1064
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 139
EQI4 $1026
ADDRLP4 1064
INDIRI4
CNSTI4 170
NEI4 $1024
LABELV $1026
line 2137
;2137:				DC->setOverstrikeMode(!DC->getOverstrikeMode());
ADDRLP4 1072
ADDRGP4 DC
INDIRP4
CNSTI4 108
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $1028
ADDRLP4 1068
CNSTI4 1
ASGNI4
ADDRGP4 $1029
JUMPV
LABELV $1028
ADDRLP4 1068
CNSTI4 0
ASGNI4
LABELV $1029
ADDRLP4 1068
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 104
ADDP4
INDIRP4
CALLV
pop
line 2138
;2138:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $962
JUMPV
LABELV $1024
line 2140
;2139:			}
;2140:		}
LABELV $968
line 2142
;2141:
;2142:		if (key == K_TAB || key == K_DOWNARROW || key == K_KP_DOWNARROW) {
ADDRLP4 1044
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 9
EQI4 $1033
ADDRLP4 1044
INDIRI4
CNSTI4 133
EQI4 $1033
ADDRLP4 1044
INDIRI4
CNSTI4 167
NEI4 $1030
LABELV $1033
line 2143
;2143:			newItem = Menu_SetNextCursorItem(item->parent);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRLP4 1048
ADDRGP4 Menu_SetNextCursorItem
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1048
INDIRP4
ASGNP4
line 2144
;2144:			if (newItem && (newItem->type == ITEM_TYPE_EDITFIELD || newItem->type == ITEM_TYPE_NUMERICFIELD)) {
ADDRLP4 1028
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1034
ADDRLP4 1028
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 4
EQI4 $1036
ADDRLP4 1028
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 9
NEI4 $1034
LABELV $1036
line 2145
;2145:				g_editItem = newItem;
ADDRGP4 g_editItem
ADDRLP4 1028
INDIRP4
ASGNP4
line 2146
;2146:			}
LABELV $1034
line 2147
;2147:		}
LABELV $1030
line 2149
;2148:
;2149:		if (key == K_UPARROW || key == K_KP_UPARROW) {
ADDRLP4 1048
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 132
EQI4 $1039
ADDRLP4 1048
INDIRI4
CNSTI4 161
NEI4 $1037
LABELV $1039
line 2150
;2150:			newItem = Menu_SetPrevCursorItem(item->parent);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRLP4 1052
ADDRGP4 Menu_SetPrevCursorItem
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1052
INDIRP4
ASGNP4
line 2151
;2151:			if (newItem && (newItem->type == ITEM_TYPE_EDITFIELD || newItem->type == ITEM_TYPE_NUMERICFIELD)) {
ADDRLP4 1028
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1040
ADDRLP4 1028
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 4
EQI4 $1042
ADDRLP4 1028
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 9
NEI4 $1040
LABELV $1042
line 2152
;2152:				g_editItem = newItem;
ADDRGP4 g_editItem
ADDRLP4 1028
INDIRP4
ASGNP4
line 2153
;2153:			}
LABELV $1040
line 2154
;2154:		}
LABELV $1037
line 2156
;2155:
;2156:		if ( key == K_ENTER || key == K_KP_ENTER || key == K_ESCAPE)  {
ADDRLP4 1052
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 13
EQI4 $1046
ADDRLP4 1052
INDIRI4
CNSTI4 169
EQI4 $1046
ADDRLP4 1052
INDIRI4
CNSTI4 27
NEI4 $1043
LABELV $1046
line 2157
;2157:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $962
JUMPV
LABELV $1043
line 2160
;2158:		}
;2159:
;2160:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $962
JUMPV
LABELV $963
line 2162
;2161:	}
;2162:	return qfalse;
CNSTI4 0
RETI4
LABELV $962
endproc Item_TextField_HandleKey 1076 12
proc Scroll_ListBox_AutoFunc 12 16
line 2166
;2163:
;2164:}
;2165:
;2166:static void Scroll_ListBox_AutoFunc(void *p) {
line 2167
;2167:	scrollInfo_t *si = (scrollInfo_t*)p;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 2168
;2168:	if (DC->realTime > si->nextScrollTime) { 
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
LEI4 $1048
line 2172
;2169:		// need to scroll which is done by simulating a click to the item
;2170:		// this is done a bit sideways as the autoscroll "knows" that the item is a listbox
;2171:		// so it calls it directly
;2172:		Item_ListBox_HandleKey(si->item, si->scrollKey, qtrue, qfalse);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Item_ListBox_HandleKey
CALLI4
pop
line 2173
;2173:		si->nextScrollTime = DC->realTime + si->adjustValue; 
ADDRLP4 0
INDIRP4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDI4
ASGNI4
line 2174
;2174:	}
LABELV $1048
line 2176
;2175:
;2176:	if (DC->realTime > si->nextAdjustTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LEI4 $1050
line 2177
;2177:		si->nextAdjustTime = DC->realTime + SCROLL_TIME_ADJUST;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 150
ADDI4
ASGNI4
line 2178
;2178:		if (si->adjustValue > SCROLL_TIME_FLOOR) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 20
LEI4 $1052
line 2179
;2179:			si->adjustValue -= SCROLL_TIME_ADJUSTOFFSET;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 40
SUBI4
ASGNI4
line 2180
;2180:		}
LABELV $1052
line 2181
;2181:	}
LABELV $1050
line 2182
;2182:}
LABELV $1047
endproc Scroll_ListBox_AutoFunc 12 16
proc Scroll_ListBox_ThumbFunc 40 16
line 2184
;2183:
;2184:static void Scroll_ListBox_ThumbFunc(void *p) {
line 2185
;2185:	scrollInfo_t *si = (scrollInfo_t*)p;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 2189
;2186:	rectDef_t r;
;2187:	int pos, max;
;2188:
;2189:	listBoxDef_t *listPtr = (listBoxDef_t*)si->item->typeData;
ADDRLP4 28
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 2190
;2190:	if (si->item->window.flags & WINDOW_HORIZONTAL) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1055
line 2191
;2191:		if (DC->cursorx == si->xStart) {
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
NEF4 $1057
line 2192
;2192:			return;
ADDRGP4 $1054
JUMPV
LABELV $1057
line 2194
;2193:		}
;2194:		r.x = si->item->window.rect.x + SCROLLBAR_SIZE + 1;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2195
;2195:		r.y = si->item->window.rect.y + si->item->window.rect.h - SCROLLBAR_SIZE - 1;
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 2196
;2196:		r.h = SCROLLBAR_SIZE;
ADDRLP4 4+12
CNSTF4 1098907648
ASGNF4
line 2197
;2197:		r.w = si->item->window.rect.w - (SCROLLBAR_SIZE*2) - 2;
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 2198
;2198:		max = Item_ListBox_MaxScroll(si->item);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 Item_ListBox_MaxScroll
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 36
INDIRI4
ASGNI4
line 2200
;2199:		//
;2200:		pos = (DC->cursorx - r.x - SCROLLBAR_SIZE/2) * max / (r.w - SCROLLBAR_SIZE);
ADDRLP4 20
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
CNSTF4 1090519040
SUBF4
ADDRLP4 24
INDIRI4
CVIF4 4
MULF4
ADDRLP4 4+8
INDIRF4
CNSTF4 1098907648
SUBF4
DIVF4
CVFI4 4
ASGNI4
line 2201
;2201:		if (pos < 0) {
ADDRLP4 20
INDIRI4
CNSTI4 0
GEI4 $1063
line 2202
;2202:			pos = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 2203
;2203:		}
ADDRGP4 $1064
JUMPV
LABELV $1063
line 2204
;2204:		else if (pos > max) {
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $1065
line 2205
;2205:			pos = max;
ADDRLP4 20
ADDRLP4 24
INDIRI4
ASGNI4
line 2206
;2206:		}
LABELV $1065
LABELV $1064
line 2207
;2207:		listPtr->startPos = pos;
ADDRLP4 28
INDIRP4
ADDRLP4 20
INDIRI4
ASGNI4
line 2208
;2208:		si->xStart = DC->cursorx;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ASGNF4
line 2209
;2209:	}
ADDRGP4 $1056
JUMPV
LABELV $1055
line 2210
;2210:	else if (DC->cursory != si->yStart) {
ADDRGP4 DC
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
EQF4 $1067
line 2212
;2211:
;2212:		r.x = si->item->window.rect.x + si->item->window.rect.w - SCROLLBAR_SIZE - 1;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 2213
;2213:		r.y = si->item->window.rect.y + SCROLLBAR_SIZE + 1;
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2214
;2214:		r.h = si->item->window.rect.h - (SCROLLBAR_SIZE*2) - 2;
ADDRLP4 4+12
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 2215
;2215:		r.w = SCROLLBAR_SIZE;
ADDRLP4 4+8
CNSTF4 1098907648
ASGNF4
line 2216
;2216:		max = Item_ListBox_MaxScroll(si->item);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 Item_ListBox_MaxScroll
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 36
INDIRI4
ASGNI4
line 2218
;2217:		//
;2218:		pos = (DC->cursory - r.y - SCROLLBAR_SIZE/2) * max / (r.h - SCROLLBAR_SIZE);
ADDRLP4 20
ADDRGP4 DC
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ADDRLP4 4+4
INDIRF4
SUBF4
CNSTF4 1090519040
SUBF4
ADDRLP4 24
INDIRI4
CVIF4 4
MULF4
ADDRLP4 4+12
INDIRF4
CNSTF4 1098907648
SUBF4
DIVF4
CVFI4 4
ASGNI4
line 2219
;2219:		if (pos < 0) {
ADDRLP4 20
INDIRI4
CNSTI4 0
GEI4 $1074
line 2220
;2220:			pos = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 2221
;2221:		}
ADDRGP4 $1075
JUMPV
LABELV $1074
line 2222
;2222:		else if (pos > max) {
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $1076
line 2223
;2223:			pos = max;
ADDRLP4 20
ADDRLP4 24
INDIRI4
ASGNI4
line 2224
;2224:		}
LABELV $1076
LABELV $1075
line 2225
;2225:		listPtr->startPos = pos;
ADDRLP4 28
INDIRP4
ADDRLP4 20
INDIRI4
ASGNI4
line 2226
;2226:		si->yStart = DC->cursory;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ASGNF4
line 2227
;2227:	}
LABELV $1067
LABELV $1056
line 2229
;2228:
;2229:	if (DC->realTime > si->nextScrollTime) { 
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
LEI4 $1078
line 2233
;2230:		// need to scroll which is done by simulating a click to the item
;2231:		// this is done a bit sideways as the autoscroll "knows" that the item is a listbox
;2232:		// so it calls it directly
;2233:		Item_ListBox_HandleKey(si->item, si->scrollKey, qtrue, qfalse);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Item_ListBox_HandleKey
CALLI4
pop
line 2234
;2234:		si->nextScrollTime = DC->realTime + si->adjustValue; 
ADDRLP4 0
INDIRP4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDI4
ASGNI4
line 2235
;2235:	}
LABELV $1078
line 2237
;2236:
;2237:	if (DC->realTime > si->nextAdjustTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LEI4 $1080
line 2238
;2238:		si->nextAdjustTime = DC->realTime + SCROLL_TIME_ADJUST;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 150
ADDI4
ASGNI4
line 2239
;2239:		if (si->adjustValue > SCROLL_TIME_FLOOR) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 20
LEI4 $1082
line 2240
;2240:			si->adjustValue -= SCROLL_TIME_ADJUSTOFFSET;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 40
SUBI4
ASGNI4
line 2241
;2241:		}
LABELV $1082
line 2242
;2242:	}
LABELV $1080
line 2243
;2243:}
LABELV $1054
endproc Scroll_ListBox_ThumbFunc 40 16
proc Scroll_Slider_ThumbFunc 28 8
line 2245
;2244:
;2245:static void Scroll_Slider_ThumbFunc(void *p) {
line 2247
;2246:	float x, value, cursorx;
;2247:	scrollInfo_t *si = (scrollInfo_t*)p;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 2248
;2248:	editFieldDef_t *editDef = si->item->typeData;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 2250
;2249:
;2250:	if (si->item->text) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1085
line 2251
;2251:		x = si->item->textRect.x + si->item->textRect.w + 8;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 2252
;2252:	} else {
ADDRGP4 $1086
JUMPV
LABELV $1085
line 2253
;2253:		x = si->item->window.rect.x;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
INDIRF4
ASGNF4
line 2254
;2254:	}
LABELV $1086
line 2256
;2255:
;2256:	cursorx = DC->cursorx;
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ASGNF4
line 2258
;2257:
;2258:	if (cursorx < x) {
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
GEF4 $1087
line 2259
;2259:		cursorx = x;
ADDRLP4 12
ADDRLP4 8
INDIRF4
ASGNF4
line 2260
;2260:	} else if (cursorx > x + SLIDER_WIDTH) {
ADDRGP4 $1088
JUMPV
LABELV $1087
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
CNSTF4 1119879168
ADDF4
LEF4 $1089
line 2261
;2261:		cursorx = x + SLIDER_WIDTH;
ADDRLP4 12
ADDRLP4 8
INDIRF4
CNSTF4 1119879168
ADDF4
ASGNF4
line 2262
;2262:	}
LABELV $1089
LABELV $1088
line 2263
;2263:	value = cursorx - x;
ADDRLP4 4
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
ASGNF4
line 2264
;2264:	value /= SLIDER_WIDTH;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1009429163
MULF4
ASGNF4
line 2265
;2265:	value *= (editDef->maxVal - editDef->minVal);
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
INDIRF4
SUBF4
MULF4
ASGNF4
line 2266
;2266:	value += editDef->minVal;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 16
INDIRP4
INDIRF4
ADDF4
ASGNF4
line 2267
;2267:	DC->setCVar(si->item->cvar, va("%f", value));
ADDRGP4 $961
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2268
;2268:}
LABELV $1084
endproc Scroll_Slider_ThumbFunc 28 8
export Item_StartCapture
proc Item_StartCapture 24 12
line 2270
;2269:
;2270:void Item_StartCapture(itemDef_t *item, int key) {
line 2272
;2271:	int flags;
;2272:	switch (item->type) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
LTI4 $1092
ADDRLP4 4
INDIRI4
CNSTI4 10
GTI4 $1092
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1119-16
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1119
address $1095
address $1092
address $1095
address $1092
address $1092
address $1095
address $1112
code
LABELV $1095
line 2277
;2273:    case ITEM_TYPE_EDITFIELD:
;2274:    case ITEM_TYPE_NUMERICFIELD:
;2275:
;2276:		case ITEM_TYPE_LISTBOX:
;2277:		{
line 2278
;2278:			flags = Item_ListBox_OverLB(item, DC->cursorx, DC->cursory);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 Item_ListBox_OverLB
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 16
INDIRI4
ASGNI4
line 2279
;2279:			if (flags & (WINDOW_LB_LEFTARROW | WINDOW_LB_RIGHTARROW)) {
ADDRLP4 0
INDIRI4
CNSTI4 6144
BANDI4
CNSTI4 0
EQI4 $1096
line 2280
;2280:				scrollInfo.nextScrollTime = DC->realTime + SCROLL_TIME_START;
ADDRGP4 scrollInfo
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 2281
;2281:				scrollInfo.nextAdjustTime = DC->realTime + SCROLL_TIME_ADJUST;
ADDRGP4 scrollInfo+4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 150
ADDI4
ASGNI4
line 2282
;2282:				scrollInfo.adjustValue = SCROLL_TIME_START;
ADDRGP4 scrollInfo+8
CNSTI4 500
ASGNI4
line 2283
;2283:				scrollInfo.scrollKey = key;
ADDRGP4 scrollInfo+12
ADDRFP4 4
INDIRI4
ASGNI4
line 2284
;2284:				scrollInfo.scrollDir = (flags & WINDOW_LB_LEFTARROW) ? qtrue : qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1103
ADDRLP4 20
CNSTI4 1
ASGNI4
ADDRGP4 $1104
JUMPV
LABELV $1103
ADDRLP4 20
CNSTI4 0
ASGNI4
LABELV $1104
ADDRGP4 scrollInfo+28
ADDRLP4 20
INDIRI4
ASGNI4
line 2285
;2285:				scrollInfo.item = item;
ADDRGP4 scrollInfo+24
ADDRFP4 0
INDIRP4
ASGNP4
line 2286
;2286:				captureData = &scrollInfo;
ADDRGP4 captureData
ADDRGP4 scrollInfo
ASGNP4
line 2287
;2287:				captureFunc = &Scroll_ListBox_AutoFunc;
ADDRGP4 captureFunc
ADDRGP4 Scroll_ListBox_AutoFunc
ASGNP4
line 2288
;2288:				itemCapture = item;
ADDRGP4 itemCapture
ADDRFP4 0
INDIRP4
ASGNP4
line 2289
;2289:			} else if (flags & WINDOW_LB_THUMB) {
ADDRGP4 $1093
JUMPV
LABELV $1096
ADDRLP4 0
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1093
line 2290
;2290:				scrollInfo.scrollKey = key;
ADDRGP4 scrollInfo+12
ADDRFP4 4
INDIRI4
ASGNI4
line 2291
;2291:				scrollInfo.item = item;
ADDRGP4 scrollInfo+24
ADDRFP4 0
INDIRP4
ASGNP4
line 2292
;2292:				scrollInfo.xStart = DC->cursorx;
ADDRGP4 scrollInfo+16
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ASGNF4
line 2293
;2293:				scrollInfo.yStart = DC->cursory;
ADDRGP4 scrollInfo+20
ADDRGP4 DC
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ASGNF4
line 2294
;2294:				captureData = &scrollInfo;
ADDRGP4 captureData
ADDRGP4 scrollInfo
ASGNP4
line 2295
;2295:				captureFunc = &Scroll_ListBox_ThumbFunc;
ADDRGP4 captureFunc
ADDRGP4 Scroll_ListBox_ThumbFunc
ASGNP4
line 2296
;2296:				itemCapture = item;
ADDRGP4 itemCapture
ADDRFP4 0
INDIRP4
ASGNP4
line 2297
;2297:			}
line 2298
;2298:			break;
ADDRGP4 $1093
JUMPV
LABELV $1112
line 2301
;2299:		}
;2300:		case ITEM_TYPE_SLIDER:
;2301:		{
line 2302
;2302:			flags = Item_Slider_OverSlider(item, DC->cursorx, DC->cursory);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 Item_Slider_OverSlider
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 16
INDIRI4
ASGNI4
line 2303
;2303:			if (flags & WINDOW_LB_THUMB) {
ADDRLP4 0
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1093
line 2304
;2304:				scrollInfo.scrollKey = key;
ADDRGP4 scrollInfo+12
ADDRFP4 4
INDIRI4
ASGNI4
line 2305
;2305:				scrollInfo.item = item;
ADDRGP4 scrollInfo+24
ADDRFP4 0
INDIRP4
ASGNP4
line 2306
;2306:				scrollInfo.xStart = DC->cursorx;
ADDRGP4 scrollInfo+16
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ASGNF4
line 2307
;2307:				scrollInfo.yStart = DC->cursory;
ADDRGP4 scrollInfo+20
ADDRGP4 DC
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ASGNF4
line 2308
;2308:				captureData = &scrollInfo;
ADDRGP4 captureData
ADDRGP4 scrollInfo
ASGNP4
line 2309
;2309:				captureFunc = &Scroll_Slider_ThumbFunc;
ADDRGP4 captureFunc
ADDRGP4 Scroll_Slider_ThumbFunc
ASGNP4
line 2310
;2310:				itemCapture = item;
ADDRGP4 itemCapture
ADDRFP4 0
INDIRP4
ASGNP4
line 2311
;2311:			}
line 2312
;2312:			break;
LABELV $1092
LABELV $1093
line 2315
;2313:		}
;2314:	}
;2315:}
LABELV $1091
endproc Item_StartCapture 24 12
export Item_StopCapture
proc Item_StopCapture 0 0
line 2317
;2316:
;2317:void Item_StopCapture(itemDef_t *item) {
line 2319
;2318:
;2319:}
LABELV $1121
endproc Item_StopCapture 0 0
export Item_Slider_HandleKey
proc Item_Slider_HandleKey 68 12
line 2321
;2320:
;2321:qboolean Item_Slider_HandleKey(itemDef_t *item, int key, qboolean down) {
line 2325
;2322:	float x, value, width, work;
;2323:
;2324:	//DC->Print("slider handle key\n");
;2325:	if (item->window.flags & WINDOW_HASFOCUS && item->cvar && Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory)) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1123
ADDRLP4 16
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1123
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $1123
line 2326
;2326:		if (key == K_MOUSE1 || key == K_ENTER || key == K_MOUSE2 || key == K_MOUSE3) {
ADDRLP4 28
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 178
EQI4 $1129
ADDRLP4 28
INDIRI4
CNSTI4 13
EQI4 $1129
ADDRLP4 28
INDIRI4
CNSTI4 179
EQI4 $1129
ADDRLP4 28
INDIRI4
CNSTI4 180
NEI4 $1125
LABELV $1129
line 2327
;2327:			editFieldDef_t *editDef = item->typeData;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 2328
;2328:			if (editDef) {
ADDRLP4 32
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1130
line 2330
;2329:				rectDef_t testRect;
;2330:				width = SLIDER_WIDTH;
ADDRLP4 8
CNSTF4 1119879168
ASGNF4
line 2331
;2331:				if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1132
line 2332
;2332:					x = item->textRect.x + item->textRect.w + 8;
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 52
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 2333
;2333:				} else {
ADDRGP4 $1133
JUMPV
LABELV $1132
line 2334
;2334:					x = item->window.rect.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 2335
;2335:				}
LABELV $1133
line 2337
;2336:
;2337:				testRect = item->window.rect;
ADDRLP4 36
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 16
line 2338
;2338:				testRect.x = x;
ADDRLP4 36
ADDRLP4 4
INDIRF4
ASGNF4
line 2339
;2339:				value = (float)SLIDER_THUMB_WIDTH / 2;
ADDRLP4 0
CNSTF4 1086324736
ASGNF4
line 2340
;2340:				testRect.x -= value;
ADDRLP4 36
ADDRLP4 36
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
line 2342
;2341:				//DC->Print("slider x: %f\n", testRect.x);
;2342:				testRect.w = (SLIDER_WIDTH + (float)SLIDER_THUMB_WIDTH / 2);
ADDRLP4 36+8
CNSTF4 1120665600
ASGNF4
line 2344
;2343:				//DC->Print("slider w: %f\n", testRect.w);
;2344:				if (Rect_ContainsPoint(&testRect, DC->cursorx, DC->cursory)) {
ADDRLP4 36
ARGP4
ADDRLP4 52
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $1135
line 2345
;2345:					work = DC->cursorx - x;
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 2346
;2346:					value = work / width;
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
DIVF4
ASGNF4
line 2347
;2347:					value *= (editDef->maxVal - editDef->minVal);
ADDRLP4 60
ADDRLP4 32
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
INDIRF4
SUBF4
MULF4
ASGNF4
line 2350
;2348:					// vm fuckage
;2349:					// value = (((float)(DC->cursorx - x)/ SLIDER_WIDTH) * (editDef->maxVal - editDef->minVal));
;2350:					value += editDef->minVal;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 32
INDIRP4
INDIRF4
ADDF4
ASGNF4
line 2351
;2351:					DC->setCVar(item->cvar, va("%f", value));
ADDRGP4 $961
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 64
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2352
;2352:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1122
JUMPV
LABELV $1135
line 2354
;2353:				}
;2354:			}
LABELV $1130
line 2355
;2355:		}
LABELV $1125
line 2356
;2356:	}
LABELV $1123
line 2357
;2357:	DC->Print("slider handle key exit\n");
ADDRGP4 $1137
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 156
ADDP4
INDIRP4
CALLV
pop
line 2358
;2358:	return qfalse;
CNSTI4 0
RETI4
LABELV $1122
endproc Item_Slider_HandleKey 68 12
export Item_HandleKey
proc Item_HandleKey 32 16
line 2362
;2359:}
;2360:
;2361:
;2362:qboolean Item_HandleKey(itemDef_t *item, int key, qboolean down) {
line 2364
;2363:
;2364:	if (itemCapture) {
ADDRGP4 itemCapture
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1139
line 2365
;2365:		Item_StopCapture(itemCapture);
ADDRGP4 itemCapture
INDIRP4
ARGP4
ADDRGP4 Item_StopCapture
CALLV
pop
line 2366
;2366:		itemCapture = NULL;
ADDRGP4 itemCapture
CNSTP4 0
ASGNP4
line 2367
;2367:		captureFunc = NULL;
ADDRGP4 captureFunc
CNSTP4 0
ASGNP4
line 2368
;2368:		captureData = NULL;
ADDRGP4 captureData
CNSTP4 0
ASGNP4
line 2369
;2369:	} else {
ADDRGP4 $1140
JUMPV
LABELV $1139
line 2371
;2370:	  // bk001206 - parentheses
;2371:		if ( down && ( key == K_MOUSE1 || key == K_MOUSE2 || key == K_MOUSE3 ) ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1141
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1144
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1144
ADDRLP4 0
INDIRI4
CNSTI4 180
NEI4 $1141
LABELV $1144
line 2372
;2372:			Item_StartCapture(item, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 Item_StartCapture
CALLV
pop
line 2373
;2373:		}
LABELV $1141
line 2374
;2374:	}
LABELV $1140
line 2376
;2375:
;2376:	if (!down) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $1145
line 2377
;2377:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1138
JUMPV
LABELV $1145
line 2380
;2378:	}
;2379:
;2380:  switch (item->type) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $1147
ADDRLP4 0
INDIRI4
CNSTI4 13
GTI4 $1147
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1161-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1161
address $1150
address $1151
address $1152
address $1153
address $1154
address $1155
address $1147
address $1158
address $1153
address $1160
address $1156
address $1157
address $1159
code
LABELV $1150
line 2382
;2381:    case ITEM_TYPE_BUTTON:
;2382:      return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1138
JUMPV
line 2383
;2383:      break;
LABELV $1151
line 2385
;2384:    case ITEM_TYPE_RADIOBUTTON:
;2385:      return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1138
JUMPV
line 2386
;2386:      break;
LABELV $1152
line 2388
;2387:    case ITEM_TYPE_CHECKBOX:
;2388:      return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1138
JUMPV
line 2389
;2389:      break;
LABELV $1153
line 2393
;2390:    case ITEM_TYPE_EDITFIELD:
;2391:    case ITEM_TYPE_NUMERICFIELD:
;2392:      //return Item_TextField_HandleKey(item, key);
;2393:      return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1138
JUMPV
line 2394
;2394:      break;
LABELV $1154
line 2396
;2395:    case ITEM_TYPE_COMBO:
;2396:      return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1138
JUMPV
line 2397
;2397:      break;
LABELV $1155
line 2399
;2398:    case ITEM_TYPE_LISTBOX:
;2399:      return Item_ListBox_HandleKey(item, key, down, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 Item_ListBox_HandleKey
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $1138
JUMPV
line 2400
;2400:      break;
LABELV $1156
line 2402
;2401:    case ITEM_TYPE_YESNO:
;2402:      return Item_YesNo_HandleKey(item, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 Item_YesNo_HandleKey
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $1138
JUMPV
line 2403
;2403:      break;
LABELV $1157
line 2405
;2404:    case ITEM_TYPE_MULTI:
;2405:      return Item_Multi_HandleKey(item, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 Item_Multi_HandleKey
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
RETI4
ADDRGP4 $1138
JUMPV
line 2406
;2406:      break;
LABELV $1158
line 2408
;2407:    case ITEM_TYPE_OWNERDRAW:
;2408:      return Item_OwnerDraw_HandleKey(item, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 Item_OwnerDraw_HandleKey
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $1138
JUMPV
line 2409
;2409:      break;
LABELV $1159
line 2411
;2410:    case ITEM_TYPE_BIND:
;2411:			return Item_Bind_HandleKey(item, key, down);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 Item_Bind_HandleKey
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
RETI4
ADDRGP4 $1138
JUMPV
line 2412
;2412:      break;
LABELV $1160
line 2414
;2413:    case ITEM_TYPE_SLIDER:
;2414:      return Item_Slider_HandleKey(item, key, down);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 Item_Slider_HandleKey
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
RETI4
ADDRGP4 $1138
JUMPV
line 2415
;2415:      break;
LABELV $1147
line 2420
;2416:    //case ITEM_TYPE_IMAGE:
;2417:    //  Item_Image_Paint(item);
;2418:    //  break;
;2419:    default:
;2420:      return qfalse;
CNSTI4 0
RETI4
line 2421
;2421:      break;
LABELV $1138
endproc Item_HandleKey 32 16
export Item_Action
proc Item_Action 4 8
line 2427
;2422:  }
;2423:
;2424:  //return qfalse;
;2425:}
;2426:
;2427:void Item_Action(itemDef_t *item) {
line 2428
;2428:  if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1164
line 2429
;2429:    Item_RunScript(item, item->action);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 252
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 2430
;2430:  }
LABELV $1164
line 2431
;2431:}
LABELV $1163
endproc Item_Action 4 8
export Menu_SetPrevCursorItem
proc Menu_SetPrevCursorItem 32 12
line 2433
;2432:
;2433:itemDef_t *Menu_SetPrevCursorItem(menuDef_t *menu) {
line 2434
;2434:  qboolean wrapped = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2435
;2435:	int oldCursor = menu->cursorItem;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 2437
;2436:  
;2437:  if (menu->cursorItem < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1170
line 2438
;2438:    menu->cursorItem = menu->itemCount-1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2439
;2439:    wrapped = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 2440
;2440:  } 
ADDRGP4 $1170
JUMPV
LABELV $1169
line 2442
;2441:
;2442:  while (menu->cursorItem > -1) {
line 2444
;2443:    
;2444:    menu->cursorItem--;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2445
;2445:    if (menu->cursorItem < 0 && !wrapped) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1172
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1172
line 2446
;2446:      wrapped = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 2447
;2447:      menu->cursorItem = menu->itemCount -1;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2448
;2448:    }
LABELV $1172
line 2450
;2449:
;2450:		if (Item_SetFocus(menu->items[menu->cursorItem], DC->cursorx, DC->cursory)) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 Item_SetFocus
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $1174
line 2451
;2451:			Menu_HandleMouseMove(menu, menu->items[menu->cursorItem]->window.rect.x + 1, menu->items[menu->cursorItem]->window.rect.y + 1);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRGP4 Menu_HandleMouseMove
CALLV
pop
line 2452
;2452:      return menu->items[menu->cursorItem];
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 28
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $1166
JUMPV
LABELV $1174
line 2454
;2453:    }
;2454:  }
LABELV $1170
line 2442
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -1
GTI4 $1169
line 2455
;2455:	menu->cursorItem = oldCursor;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 2456
;2456:	return NULL;
CNSTP4 0
RETP4
LABELV $1166
endproc Menu_SetPrevCursorItem 32 12
export Menu_SetNextCursorItem
proc Menu_SetNextCursorItem 36 12
line 2460
;2457:
;2458:}
;2459:
;2460:itemDef_t *Menu_SetNextCursorItem(menuDef_t *menu) {
line 2462
;2461:
;2462:  qboolean wrapped = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2463
;2463:	int oldCursor = menu->cursorItem;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 2466
;2464:
;2465:
;2466:  if (menu->cursorItem == -1) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1180
line 2467
;2467:    menu->cursorItem = 0;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 0
ASGNI4
line 2468
;2468:    wrapped = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 2469
;2469:  }
ADDRGP4 $1180
JUMPV
LABELV $1179
line 2471
;2470:
;2471:  while (menu->cursorItem < menu->itemCount) {
line 2473
;2472:
;2473:    menu->cursorItem++;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2474
;2474:    if (menu->cursorItem >= menu->itemCount && !wrapped) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1182
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1182
line 2475
;2475:      wrapped = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 2476
;2476:      menu->cursorItem = 0;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 0
ASGNI4
line 2477
;2477:    }
LABELV $1182
line 2478
;2478:		if (Item_SetFocus(menu->items[menu->cursorItem], DC->cursorx, DC->cursory)) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 Item_SetFocus
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $1184
line 2479
;2479:			Menu_HandleMouseMove(menu, menu->items[menu->cursorItem]->window.rect.x + 1, menu->items[menu->cursorItem]->window.rect.y + 1);
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 28
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 28
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRGP4 Menu_HandleMouseMove
CALLV
pop
line 2480
;2480:      return menu->items[menu->cursorItem];
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $1176
JUMPV
LABELV $1184
line 2483
;2481:    }
;2482:    
;2483:  }
LABELV $1180
line 2471
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1179
line 2485
;2484:
;2485:	menu->cursorItem = oldCursor;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 2486
;2486:	return NULL;
CNSTP4 0
RETP4
LABELV $1176
endproc Menu_SetNextCursorItem 36 12
proc Window_CloseCinematic 4 4
line 2489
;2487:}
;2488:
;2489:static void Window_CloseCinematic(windowDef_t *window) {
line 2490
;2490:	if (window->style == WINDOW_STYLE_CINEMATIC && window->cinematic >= 0) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1187
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LTI4 $1187
line 2491
;2491:		DC->stopCinematic(window->cinematic);
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 184
ADDP4
INDIRP4
CALLV
pop
line 2492
;2492:		window->cinematic = -1;
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 -1
ASGNI4
line 2493
;2493:	}
LABELV $1187
line 2494
;2494:}
LABELV $1186
endproc Window_CloseCinematic 4 4
proc Menu_CloseCinematics 4 4
line 2496
;2495:
;2496:static void Menu_CloseCinematics(menuDef_t *menu) {
line 2497
;2497:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1190
line 2499
;2498:		int i;
;2499:		Window_CloseCinematic(&menu->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_CloseCinematic
CALLV
pop
line 2500
;2500:	  for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1195
JUMPV
LABELV $1192
line 2501
;2501:		  Window_CloseCinematic(&menu->items[i]->window);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Window_CloseCinematic
CALLV
pop
line 2502
;2502:			if (menu->items[i]->type == ITEM_TYPE_OWNERDRAW) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1196
line 2503
;2503:				DC->stopCinematic(0-menu->items[i]->window.ownerDraw);
CNSTI4 0
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
SUBI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 184
ADDP4
INDIRP4
CALLV
pop
line 2504
;2504:			}
LABELV $1196
line 2505
;2505:	  }
LABELV $1193
line 2500
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1195
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1192
line 2506
;2506:	}
LABELV $1190
line 2507
;2507:}
LABELV $1189
endproc Menu_CloseCinematics 4 4
proc Display_CloseCinematics 4 4
line 2509
;2508:
;2509:static void Display_CloseCinematics( void ) {
line 2511
;2510:	int i;
;2511:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1202
JUMPV
LABELV $1199
line 2512
;2512:		Menu_CloseCinematics(&Menus[i]);
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRGP4 Menu_CloseCinematics
CALLV
pop
line 2513
;2513:	}
LABELV $1200
line 2511
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1202
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $1199
line 2514
;2514:}
LABELV $1198
endproc Display_CloseCinematics 4 4
export Menus_Activate
proc Menus_Activate 544 8
line 2516
;2515:
;2516:void  Menus_Activate(menuDef_t *menu) {
line 2517
;2517:	menu->window.flags |= (WINDOW_HASFOCUS | WINDOW_VISIBLE);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 6
BORI4
ASGNI4
line 2518
;2518:	if (menu->onOpen) {
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1204
line 2520
;2519:		itemDef_t item;
;2520:		item.parent = menu;
ADDRLP4 4+228
ADDRFP4 0
INDIRP4
ASGNP4
line 2521
;2521:		Item_RunScript(&item, menu->onOpen);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 2522
;2522:	}
LABELV $1204
line 2524
;2523:
;2524:	if (menu->soundName && *menu->soundName) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1207
ADDRLP4 4
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1207
line 2526
;2525://		DC->stopBackgroundTrack();					// you don't want to do this since it will reset s_rawend
;2526:		DC->startBackgroundTrack(menu->soundName, menu->soundName);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 172
ADDP4
INDIRP4
CALLV
pop
line 2527
;2527:	}
LABELV $1207
line 2529
;2528:
;2529:	Display_CloseCinematics();
ADDRGP4 Display_CloseCinematics
CALLV
pop
line 2531
;2530:
;2531:}
LABELV $1203
endproc Menus_Activate 544 8
export Display_VisibleMenuCount
proc Display_VisibleMenuCount 8 0
line 2533
;2532:
;2533:int Display_VisibleMenuCount(void) {
line 2535
;2534:	int i, count;
;2535:	count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2536
;2536:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1213
JUMPV
LABELV $1210
line 2537
;2537:		if (Menus[i].window.flags & (WINDOW_FORCED | WINDOW_VISIBLE)) {
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus+68
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
EQI4 $1214
line 2538
;2538:			count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2539
;2539:		}
LABELV $1214
line 2540
;2540:	}
LABELV $1211
line 2536
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1213
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $1210
line 2541
;2541:	return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $1209
endproc Display_VisibleMenuCount 8 0
export Menus_HandleOOBClick
proc Menus_HandleOOBClick 20 12
line 2544
;2542:}
;2543:
;2544:void Menus_HandleOOBClick(menuDef_t *menu, int key, qboolean down) {
line 2545
;2545:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1218
line 2550
;2546:		int i;
;2547:		// basically the behaviour we are looking for is if there are windows in the stack.. see if 
;2548:		// the cursor is within any of them.. if not close them otherwise activate them and pass the 
;2549:		// key on.. force a mouse move to activate focus and script stuff 
;2550:		if (down && menu->window.flags & WINDOW_OOB_CLICK) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1220
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 131072
BANDI4
CNSTI4 0
EQI4 $1220
line 2551
;2551:			Menu_RunCloseScript(menu);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_RunCloseScript
CALLV
pop
line 2552
;2552:			menu->window.flags &= ~(WINDOW_HASFOCUS | WINDOW_VISIBLE);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -7
BANDI4
ASGNI4
line 2553
;2553:		}
LABELV $1220
line 2555
;2554:
;2555:		for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1225
JUMPV
LABELV $1222
line 2556
;2556:			if (Menu_OverActiveItem(&Menus[i], DC->cursorx, DC->cursory)) {
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 Menu_OverActiveItem
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1226
line 2557
;2557:				Menu_RunCloseScript(menu);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_RunCloseScript
CALLV
pop
line 2558
;2558:				menu->window.flags &= ~(WINDOW_HASFOCUS | WINDOW_VISIBLE);
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 -7
BANDI4
ASGNI4
line 2559
;2559:				Menus_Activate(&Menus[i]);
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRGP4 Menus_Activate
CALLV
pop
line 2560
;2560:				Menu_HandleMouseMove(&Menus[i], DC->cursorx, DC->cursory);
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ARGF4
ADDRGP4 Menu_HandleMouseMove
CALLV
pop
line 2561
;2561:				Menu_HandleKey(&Menus[i], key, down);
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Menu_HandleKey
CALLV
pop
line 2562
;2562:			}
LABELV $1226
line 2563
;2563:		}
LABELV $1223
line 2555
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1225
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $1222
line 2565
;2564:
;2565:		if (Display_VisibleMenuCount() == 0) {
ADDRLP4 4
ADDRGP4 Display_VisibleMenuCount
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1228
line 2566
;2566:			if (DC->Pause) {
ADDRGP4 DC
INDIRP4
CNSTI4 160
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1230
line 2567
;2567:				DC->Pause(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 160
ADDP4
INDIRP4
CALLV
pop
line 2568
;2568:			}
LABELV $1230
line 2569
;2569:		}
LABELV $1228
line 2570
;2570:		Display_CloseCinematics();
ADDRGP4 Display_CloseCinematics
CALLV
pop
line 2571
;2571:	}
LABELV $1218
line 2572
;2572:}
LABELV $1217
endproc Menus_HandleOOBClick 20 12
bss
align 4
LABELV $1233
skip 16
code
proc Item_CorrectedTextRect 4 12
line 2574
;2573:
;2574:static rectDef_t *Item_CorrectedTextRect(itemDef_t *item) {
line 2576
;2575:	static rectDef_t rect;
;2576:	memset(&rect, 0, sizeof(rectDef_t));
ADDRGP4 $1233
ARGP4
CNSTI4 0
ARGI4
CNSTU4 16
ARGU4
ADDRGP4 memset
CALLP4
pop
line 2577
;2577:	if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1234
line 2578
;2578:		rect = item->textRect;
ADDRGP4 $1233
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRB
ASGNB 16
line 2579
;2579:		if (rect.w) {
ADDRGP4 $1233+8
INDIRF4
CNSTF4 0
EQF4 $1236
line 2580
;2580:			rect.y -= rect.h;
ADDRLP4 0
ADDRGP4 $1233+4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRGP4 $1233+12
INDIRF4
SUBF4
ASGNF4
line 2581
;2581:		}
LABELV $1236
line 2582
;2582:	}
LABELV $1234
line 2583
;2583:	return &rect;
ADDRGP4 $1233
RETP4
LABELV $1232
endproc Item_CorrectedTextRect 4 12
data
align 4
LABELV $1262
byte 4 0
export Menu_HandleKey
code
proc Menu_HandleKey 600 12
line 2586
;2584:}
;2585:
;2586:void Menu_HandleKey(menuDef_t *menu, int key, qboolean down) {
line 2588
;2587:	int i;
;2588:	itemDef_t *item = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 2589
;2589:	qboolean inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2591
;2590:
;2591:	if (inHandler) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1242
line 2592
;2592:		return;
ADDRGP4 $1241
JUMPV
LABELV $1242
line 2595
;2593:	}
;2594:
;2595:	inHandler = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 2596
;2596:	if (g_waitingForKey && down) {
ADDRGP4 g_waitingForKey
INDIRI4
CNSTI4 0
EQI4 $1244
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1244
line 2597
;2597:		Item_Bind_HandleKey(g_bindItem, key, down);
ADDRGP4 g_bindItem
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Item_Bind_HandleKey
CALLI4
pop
line 2598
;2598:		inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2599
;2599:		return;
ADDRGP4 $1241
JUMPV
LABELV $1244
line 2602
;2600:	}
;2601:
;2602:	if (g_editingField && down) {
ADDRGP4 g_editingField
INDIRI4
CNSTI4 0
EQI4 $1246
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1246
line 2603
;2603:		if (!Item_TextField_HandleKey(g_editItem, key)) {
ADDRGP4 g_editItem
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 Item_TextField_HandleKey
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $1248
line 2604
;2604:			g_editingField = qfalse;
ADDRGP4 g_editingField
CNSTI4 0
ASGNI4
line 2605
;2605:			g_editItem = NULL;
ADDRGP4 g_editItem
CNSTP4 0
ASGNP4
line 2606
;2606:			inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2607
;2607:			return;
ADDRGP4 $1241
JUMPV
LABELV $1248
line 2608
;2608:		} else if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_MOUSE3) {
ADDRLP4 16
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 178
EQI4 $1253
ADDRLP4 16
INDIRI4
CNSTI4 179
EQI4 $1253
ADDRLP4 16
INDIRI4
CNSTI4 180
NEI4 $1250
LABELV $1253
line 2609
;2609:			g_editingField = qfalse;
ADDRGP4 g_editingField
CNSTI4 0
ASGNI4
line 2610
;2610:			g_editItem = NULL;
ADDRGP4 g_editItem
CNSTP4 0
ASGNP4
line 2611
;2611:			Display_MouseMove(NULL, DC->cursorx, DC->cursory);
CNSTP4 0
ARGP4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 20
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Display_MouseMove
CALLI4
pop
line 2612
;2612:		} else if (key == K_TAB || key == K_UPARROW || key == K_DOWNARROW) {
ADDRGP4 $1251
JUMPV
LABELV $1250
ADDRLP4 20
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 9
EQI4 $1257
ADDRLP4 20
INDIRI4
CNSTI4 132
EQI4 $1257
ADDRLP4 20
INDIRI4
CNSTI4 133
NEI4 $1254
LABELV $1257
line 2613
;2613:			return;
ADDRGP4 $1241
JUMPV
LABELV $1254
LABELV $1251
line 2615
;2614:		}
;2615:	}
LABELV $1246
line 2617
;2616:
;2617:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1258
line 2618
;2618:		inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2619
;2619:		return;
ADDRGP4 $1241
JUMPV
LABELV $1258
line 2623
;2620:	}
;2621:
;2622:		// see if the mouse is within the window bounds and if so is this a mouse click
;2623:	if (down && !(menu->window.flags & WINDOW_POPUP) && !Rect_ContainsPoint(&menu->window.rect, DC->cursorx, DC->cursory)) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1260
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2097152
BANDI4
CNSTI4 0
NEI4 $1260
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $1260
line 2626
;2624:		static qboolean inHandleKey = qfalse;
;2625:		// bk001206 - parentheses
;2626:		if (!inHandleKey && ( key == K_MOUSE1 || key == K_MOUSE2 || key == K_MOUSE3 ) ) {
ADDRGP4 $1262
INDIRI4
CNSTI4 0
NEI4 $1263
ADDRLP4 24
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 178
EQI4 $1266
ADDRLP4 24
INDIRI4
CNSTI4 179
EQI4 $1266
ADDRLP4 24
INDIRI4
CNSTI4 180
NEI4 $1263
LABELV $1266
line 2627
;2627:			inHandleKey = qtrue;
ADDRGP4 $1262
CNSTI4 1
ASGNI4
line 2628
;2628:			Menus_HandleOOBClick(menu, key, down);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Menus_HandleOOBClick
CALLV
pop
line 2629
;2629:			inHandleKey = qfalse;
ADDRGP4 $1262
CNSTI4 0
ASGNI4
line 2630
;2630:			inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2631
;2631:			return;
ADDRGP4 $1241
JUMPV
LABELV $1263
line 2633
;2632:		}
;2633:	}
LABELV $1260
line 2636
;2634:
;2635:	// get the item with focus
;2636:	for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1270
JUMPV
LABELV $1267
line 2637
;2637:		if (menu->items[i]->window.flags & WINDOW_HASFOCUS) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1271
line 2638
;2638:			item = menu->items[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
line 2639
;2639:		}
LABELV $1271
line 2640
;2640:	}
LABELV $1268
line 2636
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1270
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1267
line 2642
;2641:
;2642:	if (item != NULL) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1273
line 2643
;2643:		if (Item_HandleKey(item, key, down)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 Item_HandleKey
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $1275
line 2644
;2644:			Item_Action(item);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Item_Action
CALLV
pop
line 2645
;2645:			inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2646
;2646:			return;
ADDRGP4 $1241
JUMPV
LABELV $1275
line 2648
;2647:		}
;2648:	}
LABELV $1273
line 2650
;2649:
;2650:	if (!down) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $1277
line 2651
;2651:		inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2652
;2652:		return;
ADDRGP4 $1241
JUMPV
LABELV $1277
line 2656
;2653:	}
;2654:
;2655:	// default handling
;2656:	switch ( key ) {
ADDRLP4 24
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 155
EQI4 $1281
ADDRLP4 24
INDIRI4
CNSTI4 156
EQI4 $1285
ADDRLP4 24
INDIRI4
CNSTI4 156
GTI4 $1317
LABELV $1316
ADDRLP4 28
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 13
EQI4 $1310
ADDRLP4 28
INDIRI4
CNSTI4 13
GTI4 $1319
LABELV $1318
ADDRFP4 4
INDIRI4
CNSTI4 9
EQI4 $1294
ADDRGP4 $1279
JUMPV
LABELV $1319
ADDRLP4 32
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 27
EQI4 $1290
ADDRLP4 32
INDIRI4
CNSTI4 27
LTI4 $1279
LABELV $1320
ADDRLP4 36
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 132
EQI4 $1289
ADDRLP4 36
INDIRI4
CNSTI4 133
EQI4 $1294
ADDRGP4 $1279
JUMPV
LABELV $1317
ADDRLP4 40
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 167
EQI4 $1294
ADDRLP4 40
INDIRI4
CNSTI4 169
EQI4 $1310
ADDRLP4 40
INDIRI4
CNSTI4 169
GTI4 $1322
LABELV $1321
ADDRFP4 4
INDIRI4
CNSTI4 161
EQI4 $1289
ADDRGP4 $1279
JUMPV
LABELV $1322
ADDRLP4 44
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 178
LTI4 $1279
ADDRLP4 44
INDIRI4
CNSTI4 188
GTI4 $1323
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1324-712
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1324
address $1295
address $1295
address $1279
address $1279
address $1279
address $1279
address $1279
address $1280
address $1280
address $1280
address $1280
code
LABELV $1323
ADDRLP4 48
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 217
LTI4 $1279
ADDRLP4 48
INDIRI4
CNSTI4 232
GTI4 $1279
ADDRLP4 48
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1326-868
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1326
address $1280
address $1280
address $1280
address $1280
address $1280
address $1280
address $1280
address $1280
address $1280
address $1280
address $1280
address $1280
address $1280
address $1280
address $1280
address $1280
code
LABELV $1281
line 2659
;2657:
;2658:		case K_F11:
;2659:			if (DC->getCVarValue("developer")) {
ADDRGP4 $1284
ARGP4
ADDRLP4 52
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 52
INDIRF4
CNSTF4 0
EQF4 $1280
line 2660
;2660:				debugMode ^= 1;
ADDRLP4 56
ADDRGP4 debugMode
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 2661
;2661:			}
line 2662
;2662:			break;
ADDRGP4 $1280
JUMPV
LABELV $1285
line 2665
;2663:
;2664:		case K_F12:
;2665:			if (DC->getCVarValue("developer")) {
ADDRGP4 $1284
ARGP4
ADDRLP4 56
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 56
INDIRF4
CNSTF4 0
EQF4 $1280
line 2666
;2666:				DC->executeText(EXEC_APPEND, "screenshot\n");
CNSTI4 2
ARGI4
ADDRGP4 $1288
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 148
ADDP4
INDIRP4
CALLV
pop
line 2667
;2667:			}
line 2668
;2668:			break;
ADDRGP4 $1280
JUMPV
LABELV $1289
line 2671
;2669:		case K_KP_UPARROW:
;2670:		case K_UPARROW:
;2671:			Menu_SetPrevCursorItem(menu);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_SetPrevCursorItem
CALLP4
pop
line 2672
;2672:			break;
ADDRGP4 $1280
JUMPV
LABELV $1290
line 2675
;2673:
;2674:		case K_ESCAPE:
;2675:			if (!g_waitingForKey && menu->onESC) {
ADDRGP4 g_waitingForKey
INDIRI4
CNSTI4 0
NEI4 $1280
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1280
line 2677
;2676:				itemDef_t it;
;2677:		    it.parent = menu;
ADDRLP4 60+228
ADDRFP4 0
INDIRP4
ASGNP4
line 2678
;2678:		    Item_RunScript(&it, menu->onESC);
ADDRLP4 60
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 2679
;2679:			}
line 2680
;2680:			break;
ADDRGP4 $1280
JUMPV
LABELV $1294
line 2684
;2681:		case K_TAB:
;2682:		case K_KP_DOWNARROW:
;2683:		case K_DOWNARROW:
;2684:			Menu_SetNextCursorItem(menu);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_SetNextCursorItem
CALLP4
pop
line 2685
;2685:			break;
ADDRGP4 $1280
JUMPV
LABELV $1295
line 2689
;2686:
;2687:		case K_MOUSE1:
;2688:		case K_MOUSE2:
;2689:			if (item) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1280
line 2690
;2690:				if (item->type == ITEM_TYPE_TEXT) {
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1298
line 2691
;2691:					if (Rect_ContainsPoint(Item_CorrectedTextRect(item), DC->cursorx, DC->cursory)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 Item_CorrectedTextRect
CALLP4
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 64
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $1280
line 2692
;2692:						Item_Action(item);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Item_Action
CALLV
pop
line 2693
;2693:					}
line 2694
;2694:				} else if (item->type == ITEM_TYPE_EDITFIELD || item->type == ITEM_TYPE_NUMERICFIELD) {
ADDRGP4 $1280
JUMPV
LABELV $1298
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 4
EQI4 $1304
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 9
NEI4 $1302
LABELV $1304
line 2695
;2695:					if (Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 64
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $1280
line 2696
;2696:						item->cursorPos = 0;
ADDRLP4 4
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 0
ASGNI4
line 2697
;2697:						g_editingField = qtrue;
ADDRGP4 g_editingField
CNSTI4 1
ASGNI4
line 2698
;2698:						g_editItem = item;
ADDRGP4 g_editItem
ADDRLP4 4
INDIRP4
ASGNP4
line 2699
;2699:						DC->setOverstrikeMode(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 104
ADDP4
INDIRP4
CALLV
pop
line 2700
;2700:					}
line 2701
;2701:				} else {
ADDRGP4 $1280
JUMPV
LABELV $1302
line 2702
;2702:					if (Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 64
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $1280
line 2703
;2703:						Item_Action(item);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Item_Action
CALLV
pop
line 2704
;2704:					}
line 2705
;2705:				}
line 2706
;2706:			}
line 2707
;2707:			break;
ADDRGP4 $1280
JUMPV
line 2729
;2708:
;2709:		case K_JOY1:
;2710:		case K_JOY2:
;2711:		case K_JOY3:
;2712:		case K_JOY4:
;2713:		case K_AUX1:
;2714:		case K_AUX2:
;2715:		case K_AUX3:
;2716:		case K_AUX4:
;2717:		case K_AUX5:
;2718:		case K_AUX6:
;2719:		case K_AUX7:
;2720:		case K_AUX8:
;2721:		case K_AUX9:
;2722:		case K_AUX10:
;2723:		case K_AUX11:
;2724:		case K_AUX12:
;2725:		case K_AUX13:
;2726:		case K_AUX14:
;2727:		case K_AUX15:
;2728:		case K_AUX16:
;2729:			break;
LABELV $1310
line 2732
;2730:		case K_KP_ENTER:
;2731:		case K_ENTER:
;2732:			if (item) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1280
line 2733
;2733:				if (item->type == ITEM_TYPE_EDITFIELD || item->type == ITEM_TYPE_NUMERICFIELD) {
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 4
EQI4 $1315
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 9
NEI4 $1313
LABELV $1315
line 2734
;2734:					item->cursorPos = 0;
ADDRLP4 4
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 0
ASGNI4
line 2735
;2735:					g_editingField = qtrue;
ADDRGP4 g_editingField
CNSTI4 1
ASGNI4
line 2736
;2736:					g_editItem = item;
ADDRGP4 g_editItem
ADDRLP4 4
INDIRP4
ASGNP4
line 2737
;2737:					DC->setOverstrikeMode(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 104
ADDP4
INDIRP4
CALLV
pop
line 2738
;2738:				} else {
ADDRGP4 $1280
JUMPV
LABELV $1313
line 2739
;2739:						Item_Action(item);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Item_Action
CALLV
pop
line 2740
;2740:				}
line 2741
;2741:			}
line 2742
;2742:			break;
LABELV $1279
LABELV $1280
line 2744
;2743:	}
;2744:	inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2745
;2745:}
LABELV $1241
endproc Menu_HandleKey 600 12
export ToWindowCoords
proc ToWindowCoords 8 0
line 2747
;2746:
;2747:void ToWindowCoords(float *x, float *y, windowDef_t *window) {
line 2748
;2748:	if (window->border != 0) {
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1329
line 2749
;2749:		*x += window->borderSize;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 2750
;2750:		*y += window->borderSize;
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 2751
;2751:	} 
LABELV $1329
line 2752
;2752:	*x += window->rect.x;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
INDIRF4
ADDF4
ASGNF4
line 2753
;2753:	*y += window->rect.y;
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 2754
;2754:}
LABELV $1328
endproc ToWindowCoords 8 0
export Rect_ToWindowCoords
proc Rect_ToWindowCoords 4 12
line 2756
;2755:
;2756:void Rect_ToWindowCoords(rectDef_t *rect, windowDef_t *window) {
line 2757
;2757:	ToWindowCoords(&rect->x, &rect->y, window);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 ToWindowCoords
CALLV
pop
line 2758
;2758:}
LABELV $1331
endproc Rect_ToWindowCoords 4 12
export Item_SetTextExtents
proc Item_SetTextExtents 292 12
line 2760
;2759:
;2760:void Item_SetTextExtents(itemDef_t *item, int *width, int *height, const char *text) {
line 2761
;2761:	const char *textPtr = (text) ? text : item->text;
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1334
ADDRLP4 4
ADDRFP4 12
INDIRP4
ASGNP4
ADDRGP4 $1335
JUMPV
LABELV $1334
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
LABELV $1335
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 2763
;2762:
;2763:	if (textPtr == NULL ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1336
line 2764
;2764:		return;
ADDRGP4 $1332
JUMPV
LABELV $1336
line 2767
;2765:	}
;2766:
;2767:	*width = item->textRect.w;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 2768
;2768:	*height = item->textRect.h;
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 2771
;2769:
;2770:	// keeps us from computing the widths and heights more than once
;2771:	if (*width == 0 || (item->type == ITEM_TYPE_OWNERDRAW && item->textalignment == ITEM_ALIGN_CENTER)) {
ADDRFP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $1340
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1338
ADDRLP4 8
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1338
LABELV $1340
line 2772
;2772:		int originalWidth = DC->textWidth(item->text, item->textscale, 0);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 20
INDIRI4
ASGNI4
line 2774
;2773:
;2774:		if (item->type == ITEM_TYPE_OWNERDRAW && (item->textalignment == ITEM_ALIGN_CENTER || item->textalignment == ITEM_ALIGN_RIGHT)) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1341
ADDRLP4 24
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
EQI4 $1343
ADDRLP4 24
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1341
LABELV $1343
line 2775
;2775:			originalWidth += DC->ownerDrawWidth(item->window.ownerDraw, item->textscale);
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 DC
INDIRP4
CNSTI4 164
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 32
INDIRI4
ADDI4
ASGNI4
line 2776
;2776:		} else if (item->type == ITEM_TYPE_EDITFIELD && item->textalignment == ITEM_ALIGN_CENTER && item->cvar) {
ADDRGP4 $1342
JUMPV
LABELV $1341
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 4
NEI4 $1344
ADDRLP4 28
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1344
ADDRLP4 28
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1344
line 2778
;2777:			char buff[256];
;2778:			DC->getCVarString(item->cvar, buff, 256);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 2779
;2779:			originalWidth += DC->textWidth(buff, item->textscale, 0);
ADDRLP4 32
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 288
ADDRGP4 DC
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 288
INDIRI4
ADDI4
ASGNI4
line 2780
;2780:		}
LABELV $1344
LABELV $1342
line 2782
;2781:
;2782:		*width = DC->textWidth(textPtr, item->textscale, 0);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 32
ADDRGP4 DC
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 32
INDIRI4
ASGNI4
line 2783
;2783:		*height = DC->textHeight(textPtr, item->textscale, 0);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 36
ADDRGP4 DC
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 36
INDIRI4
ASGNI4
line 2784
;2784:		item->textRect.w = *width;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
ADDRFP4 4
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
line 2785
;2785:		item->textRect.h = *height;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
ADDRFP4 8
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
line 2786
;2786:		item->textRect.x = item->textalignx;
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ASGNF4
line 2787
;2787:		item->textRect.y = item->textaligny;
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 44
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ASGNF4
line 2788
;2788:		if (item->textalignment == ITEM_ALIGN_RIGHT) {
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1346
line 2789
;2789:			item->textRect.x = item->textalignx - originalWidth;
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ADDRLP4 12
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 2790
;2790:		} else if (item->textalignment == ITEM_ALIGN_CENTER) {
ADDRGP4 $1347
JUMPV
LABELV $1346
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1348
line 2791
;2791:			item->textRect.x = item->textalignx - originalWidth / 2;
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ADDRLP4 12
INDIRI4
CNSTI4 2
DIVI4
CVIF4 4
SUBF4
ASGNF4
line 2792
;2792:		}
LABELV $1348
LABELV $1347
line 2794
;2793:
;2794:		ToWindowCoords(&item->textRect.x, &item->textRect.y, &item->window);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 48
INDIRP4
CNSTI4 184
ADDP4
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 ToWindowCoords
CALLV
pop
line 2795
;2795:	}
LABELV $1338
line 2796
;2796:}
LABELV $1332
endproc Item_SetTextExtents 292 12
export Item_TextColor
proc Item_TextColor 40 28
line 2798
;2797:
;2798:void Item_TextColor(itemDef_t *item, vec4_t *newColor) {
line 2800
;2799:	vec4_t lowLight;
;2800:	menuDef_t *parent = (menuDef_t*)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 2802
;2801:
;2802:	Fade(&item->window.flags, &item->window.foreColor[3], parent->fadeClamp, &item->window.nextTime, parent->fadeCycle, qtrue, parent->fadeAmount);
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 68
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 124
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 108
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ARGF4
ADDRGP4 Fade
CALLV
pop
line 2804
;2803:
;2804:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1351
line 2805
;2805:		lowLight[0] = 0.8 * parent->focusColor[0]; 
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2806
;2806:		lowLight[1] = 0.8 * parent->focusColor[1]; 
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2807
;2807:		lowLight[2] = 0.8 * parent->focusColor[2]; 
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2808
;2808:		lowLight[3] = 0.8 * parent->focusColor[3]; 
ADDRLP4 4+12
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2809
;2809:		LerpColor(parent->focusColor,lowLight,*newColor,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 28
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 2810
;2810:	} else if (item->textStyle == ITEM_TEXTSTYLE_BLINK && !((DC->realTime/BLINK_DIVISOR) & 1)) {
ADDRGP4 $1352
JUMPV
LABELV $1351
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1356
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 200
DIVI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $1356
line 2811
;2811:		lowLight[0] = 0.8 * item->window.foreColor[0]; 
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2812
;2812:		lowLight[1] = 0.8 * item->window.foreColor[1]; 
ADDRLP4 4+4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2813
;2813:		lowLight[2] = 0.8 * item->window.foreColor[2]; 
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2814
;2814:		lowLight[3] = 0.8 * item->window.foreColor[3]; 
ADDRLP4 4+12
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2815
;2815:		LerpColor(item->window.foreColor,lowLight,*newColor,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 28
ADDRGP4 sin
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 2816
;2816:	} else {
ADDRGP4 $1357
JUMPV
LABELV $1356
line 2817
;2817:		memcpy(newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTU4 16
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 2819
;2818:		// items can be enabled and disabled based on cvars
;2819:	}
LABELV $1357
LABELV $1352
line 2821
;2820:
;2821:	if (item->enableCvar && *item->enableCvar && item->cvarTest && *item->cvarTest) {
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 272
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1361
ADDRLP4 28
INDIRP4
CNSTI4 272
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1361
ADDRLP4 28
INDIRP4
CNSTI4 268
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1361
ADDRLP4 28
INDIRP4
CNSTI4 268
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1361
line 2822
;2822:		if (item->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(item, CVAR_ENABLE)) {
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $1363
ADDRLP4 32
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 36
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $1363
line 2823
;2823:			memcpy(newColor, &parent->disableColor, sizeof(vec4_t));
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 244
ADDP4
ARGP4
CNSTU4 16
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 2824
;2824:		}
LABELV $1363
line 2825
;2825:	}
LABELV $1361
line 2826
;2826:}
LABELV $1350
endproc Item_TextColor 40 28
export Item_Text_AutoWrapped_Paint
proc Item_Text_AutoWrapped_Paint 2124 32
line 2828
;2827:
;2828:void Item_Text_AutoWrapped_Paint(itemDef_t *item) {
line 2836
;2829:	char text[1024];
;2830:	const char *p, *textPtr, *newLinePtr;
;2831:	char buff[1024];
;2832:	int width, height, len, textWidth, newLine, newLineWidth;
;2833:	float y;
;2834:	vec4_t color;
;2835:
;2836:	textWidth = 0;
ADDRLP4 1032
CNSTI4 0
ASGNI4
line 2837
;2837:	newLinePtr = NULL;
ADDRLP4 1044
CNSTP4 0
ASGNP4
line 2839
;2838:
;2839:	if (item->text == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1366
line 2840
;2840:		if (item->cvar == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1368
line 2841
;2841:			return;
ADDRGP4 $1365
JUMPV
LABELV $1368
line 2843
;2842:		}
;2843:		else {
line 2844
;2844:			DC->getCVarString(item->cvar, text, sizeof(text));
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 1080
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 2845
;2845:			textPtr = text;
ADDRLP4 1056
ADDRLP4 1080
ASGNP4
line 2846
;2846:		}
line 2847
;2847:	}
ADDRGP4 $1367
JUMPV
LABELV $1366
line 2848
;2848:	else {
line 2849
;2849:		textPtr = item->text;
ADDRLP4 1056
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
line 2850
;2850:	}
LABELV $1367
line 2851
;2851:	if (*textPtr == '\0') {
ADDRLP4 1056
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1370
line 2852
;2852:		return;
ADDRGP4 $1365
JUMPV
LABELV $1370
line 2854
;2853:	}
;2854:	Item_TextColor(item, &color);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1060
ARGP4
ADDRGP4 Item_TextColor
CALLV
pop
line 2855
;2855:	Item_SetTextExtents(item, &width, &height, textPtr);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1076
ARGP4
ADDRLP4 1052
ARGP4
ADDRLP4 1056
INDIRP4
ARGP4
ADDRGP4 Item_SetTextExtents
CALLV
pop
line 2857
;2856:
;2857:	y = item->textaligny;
ADDRLP4 1048
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ASGNF4
line 2858
;2858:	len = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 2859
;2859:	buff[0] = '\0';
ADDRLP4 4
CNSTI1 0
ASGNI1
line 2860
;2860:	newLine = 0;
ADDRLP4 1036
CNSTI4 0
ASGNI4
line 2861
;2861:	newLineWidth = 0;
ADDRLP4 1040
CNSTI4 0
ASGNI4
line 2862
;2862:	p = textPtr;
ADDRLP4 0
ADDRLP4 1056
INDIRP4
ASGNP4
ADDRGP4 $1373
JUMPV
LABELV $1372
line 2863
;2863:	while (p) {
line 2864
;2864:		if (*p == ' ' || *p == '\t' || *p == '\n' || *p == '\0') {
ADDRLP4 2104
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 2104
INDIRI4
CNSTI4 32
EQI4 $1379
ADDRLP4 2104
INDIRI4
CNSTI4 9
EQI4 $1379
ADDRLP4 2104
INDIRI4
CNSTI4 10
EQI4 $1379
ADDRLP4 2104
INDIRI4
CNSTI4 0
NEI4 $1375
LABELV $1379
line 2865
;2865:			newLine = len;
ADDRLP4 1036
ADDRLP4 1028
INDIRI4
ASGNI4
line 2866
;2866:			newLinePtr = p+1;
ADDRLP4 1044
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 2867
;2867:			newLineWidth = textWidth;
ADDRLP4 1040
ADDRLP4 1032
INDIRI4
ASGNI4
line 2868
;2868:		}
LABELV $1375
line 2869
;2869:		textWidth = DC->textWidth(buff, item->textscale, 0);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 2108
ADDRGP4 DC
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 2108
INDIRI4
ASGNI4
line 2870
;2870:		if ( (newLine && textWidth > item->window.rect.w) || *p == '\n' || *p == '\0') {
ADDRLP4 1036
INDIRI4
CNSTI4 0
EQI4 $1383
ADDRLP4 1032
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
GTF4 $1384
LABELV $1383
ADDRLP4 2112
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 2112
INDIRI4
CNSTI4 10
EQI4 $1384
ADDRLP4 2112
INDIRI4
CNSTI4 0
NEI4 $1380
LABELV $1384
line 2871
;2871:			if (len) {
ADDRLP4 1028
INDIRI4
CNSTI4 0
EQI4 $1385
line 2872
;2872:				if (item->textalignment == ITEM_ALIGN_LEFT) {
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1387
line 2873
;2873:					item->textRect.x = item->textalignx;
ADDRLP4 2116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2116
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 2116
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ASGNF4
line 2874
;2874:				} else if (item->textalignment == ITEM_ALIGN_RIGHT) {
ADDRGP4 $1388
JUMPV
LABELV $1387
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1389
line 2875
;2875:					item->textRect.x = item->textalignx - newLineWidth;
ADDRLP4 2116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2116
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 2116
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ADDRLP4 1040
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 2876
;2876:				} else if (item->textalignment == ITEM_ALIGN_CENTER) {
ADDRGP4 $1390
JUMPV
LABELV $1389
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1391
line 2877
;2877:					item->textRect.x = item->textalignx - newLineWidth / 2;
ADDRLP4 2116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2116
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 2116
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ADDRLP4 1040
INDIRI4
CNSTI4 2
DIVI4
CVIF4 4
SUBF4
ASGNF4
line 2878
;2878:				}
LABELV $1391
LABELV $1390
LABELV $1388
line 2879
;2879:				item->textRect.y = y;
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 1048
INDIRF4
ASGNF4
line 2880
;2880:				ToWindowCoords(&item->textRect.x, &item->textRect.y, &item->window);
ADDRLP4 2116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2116
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 2116
INDIRP4
CNSTI4 184
ADDP4
ARGP4
ADDRLP4 2116
INDIRP4
ARGP4
ADDRGP4 ToWindowCoords
CALLV
pop
line 2882
;2881:				//
;2882:				buff[newLine] = '\0';
ADDRLP4 1036
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 0
ASGNI1
line 2883
;2883:				DC->drawText(item->textRect.x, item->textRect.y, item->textscale, color, buff, 0, 0, item->textStyle);
ADDRLP4 2120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2120
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ARGF4
ADDRLP4 2120
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 2120
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 1060
ARGP4
ADDRLP4 4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 2120
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 2884
;2884:			}
LABELV $1385
line 2885
;2885:			if (*p == '\0') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1393
line 2886
;2886:				break;
ADDRGP4 $1374
JUMPV
LABELV $1393
line 2889
;2887:			}
;2888:			//
;2889:			y += height + 5;
ADDRLP4 1048
ADDRLP4 1048
INDIRF4
ADDRLP4 1052
INDIRI4
CNSTI4 5
ADDI4
CVIF4 4
ADDF4
ASGNF4
line 2890
;2890:			p = newLinePtr;
ADDRLP4 0
ADDRLP4 1044
INDIRP4
ASGNP4
line 2891
;2891:			len = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 2892
;2892:			newLine = 0;
ADDRLP4 1036
CNSTI4 0
ASGNI4
line 2893
;2893:			newLineWidth = 0;
ADDRLP4 1040
CNSTI4 0
ASGNI4
line 2894
;2894:			continue;
ADDRGP4 $1373
JUMPV
LABELV $1380
line 2896
;2895:		}
;2896:		buff[len++] = *p++;
ADDRLP4 2116
ADDRLP4 1028
INDIRI4
ASGNI4
ADDRLP4 1028
ADDRLP4 2116
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 2120
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 2120
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 2116
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 2120
INDIRP4
INDIRI1
ASGNI1
line 2897
;2897:		buff[len] = '\0';
ADDRLP4 1028
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 0
ASGNI1
line 2898
;2898:	}
LABELV $1373
line 2863
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1372
LABELV $1374
line 2899
;2899:}
LABELV $1365
endproc Item_Text_AutoWrapped_Paint 2124 32
export Item_Text_Wrapped_Paint
proc Item_Text_Wrapped_Paint 2112 32
line 2901
;2900:
;2901:void Item_Text_Wrapped_Paint(itemDef_t *item) {
line 2912
;2902:	char text[1024];
;2903:	const char *p, *start, *textPtr;
;2904:	char buff[1024];
;2905:	int width, height;
;2906:	float x, y;
;2907:	vec4_t color;
;2908:
;2909:	// now paint the text and/or any optional images
;2910:	// default to left
;2911:
;2912:	if (item->text == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1396
line 2913
;2913:		if (item->cvar == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1398
line 2914
;2914:			return;
ADDRGP4 $1395
JUMPV
LABELV $1398
line 2916
;2915:		}
;2916:		else {
line 2917
;2917:			DC->getCVarString(item->cvar, text, sizeof(text));
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 1068
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 2918
;2918:			textPtr = text;
ADDRLP4 1060
ADDRLP4 1068
ASGNP4
line 2919
;2919:		}
line 2920
;2920:	}
ADDRGP4 $1397
JUMPV
LABELV $1396
line 2921
;2921:	else {
line 2922
;2922:		textPtr = item->text;
ADDRLP4 1060
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
line 2923
;2923:	}
LABELV $1397
line 2924
;2924:	if (*textPtr == '\0') {
ADDRLP4 1060
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1400
line 2925
;2925:		return;
ADDRGP4 $1395
JUMPV
LABELV $1400
line 2928
;2926:	}
;2927:
;2928:	Item_TextColor(item, &color);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1040
ARGP4
ADDRGP4 Item_TextColor
CALLV
pop
line 2929
;2929:	Item_SetTextExtents(item, &width, &height, textPtr);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1064
ARGP4
ADDRLP4 1056
ARGP4
ADDRLP4 1060
INDIRP4
ARGP4
ADDRGP4 Item_SetTextExtents
CALLV
pop
line 2931
;2930:
;2931:	x = item->textRect.x;
ADDRLP4 1036
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ASGNF4
line 2932
;2932:	y = item->textRect.y;
ADDRLP4 1032
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ASGNF4
line 2933
;2933:	start = textPtr;
ADDRLP4 4
ADDRLP4 1060
INDIRP4
ASGNP4
line 2934
;2934:	p = strchr(textPtr, '\r');
ADDRLP4 1060
INDIRP4
ARGP4
CNSTI4 13
ARGI4
ADDRLP4 2092
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2092
INDIRP4
ASGNP4
ADDRGP4 $1403
JUMPV
LABELV $1402
line 2935
;2935:	while (p && *p) {
line 2936
;2936:		strncpy(buff, start, p-start+1);
ADDRLP4 8
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1
ADDI4
CVIU4 4
ARGU4
ADDRGP4 strncpy
CALLP4
pop
line 2937
;2937:		buff[p-start] = '\0';
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 2938
;2938:		DC->drawText(x, y, item->textscale, color, buff, 0, 0, item->textStyle);
ADDRLP4 1036
INDIRF4
ARGF4
ADDRLP4 1032
INDIRF4
ARGF4
ADDRLP4 2100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2100
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 1040
ARGP4
ADDRLP4 8
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 2100
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 2939
;2939:		y += height + 5;
ADDRLP4 1032
ADDRLP4 1032
INDIRF4
ADDRLP4 1056
INDIRI4
CNSTI4 5
ADDI4
CVIF4 4
ADDF4
ASGNF4
line 2940
;2940:		start += p - start + 1;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1
ADDI4
ADDRLP4 4
INDIRP4
ADDP4
ASGNP4
line 2941
;2941:		p = strchr(p+1, '\r');
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
CNSTI4 13
ARGI4
ADDRLP4 2108
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2108
INDIRP4
ASGNP4
line 2942
;2942:	}
LABELV $1403
line 2935
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1405
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1402
LABELV $1405
line 2943
;2943:	DC->drawText(x, y, item->textscale, color, start, 0, 0, item->textStyle);
ADDRLP4 1036
INDIRF4
ARGF4
ADDRLP4 1032
INDIRF4
ARGF4
ADDRLP4 2100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2100
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 1040
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 2100
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 2944
;2944:}
LABELV $1395
endproc Item_Text_Wrapped_Paint 2112 32
export Item_Text_Paint
proc Item_Text_Paint 1056 32
line 2946
;2945:
;2946:void Item_Text_Paint(itemDef_t *item) {
line 2952
;2947:	char text[1024];
;2948:	const char *textPtr;
;2949:	int height, width;
;2950:	vec4_t color;
;2951:
;2952:	if (item->window.flags & WINDOW_WRAPPED) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 262144
BANDI4
CNSTI4 0
EQI4 $1407
line 2953
;2953:		Item_Text_Wrapped_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Wrapped_Paint
CALLV
pop
line 2954
;2954:		return;
ADDRGP4 $1406
JUMPV
LABELV $1407
line 2956
;2955:	}
;2956:	if (item->window.flags & WINDOW_AUTOWRAPPED) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 524288
BANDI4
CNSTI4 0
EQI4 $1409
line 2957
;2957:		Item_Text_AutoWrapped_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_AutoWrapped_Paint
CALLV
pop
line 2958
;2958:		return;
ADDRGP4 $1406
JUMPV
LABELV $1409
line 2961
;2959:	}
;2960:
;2961:	if (item->text == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1411
line 2962
;2962:		if (item->cvar == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1413
line 2963
;2963:			return;
ADDRGP4 $1406
JUMPV
LABELV $1413
line 2965
;2964:		}
;2965:		else {
line 2966
;2966:			DC->getCVarString(item->cvar, text, sizeof(text));
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 2967
;2967:			textPtr = text;
ADDRLP4 0
ADDRLP4 28
ASGNP4
line 2968
;2968:		}
line 2969
;2969:	}
ADDRGP4 $1412
JUMPV
LABELV $1411
line 2970
;2970:	else {
line 2971
;2971:		textPtr = item->text;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
line 2972
;2972:	}
LABELV $1412
line 2975
;2973:
;2974:	// this needs to go here as it sets extents for cvar types as well
;2975:	Item_SetTextExtents(item, &width, &height, textPtr);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Item_SetTextExtents
CALLV
pop
line 2977
;2976:
;2977:	if (*textPtr == '\0') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1415
line 2978
;2978:		return;
ADDRGP4 $1406
JUMPV
LABELV $1415
line 2982
;2979:	}
;2980:
;2981:
;2982:	Item_TextColor(item, &color);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Item_TextColor
CALLV
pop
line 3013
;2983:
;2984:	//FIXME: this is a fucking mess
;2985:/*
;2986:	adjust = 0;
;2987:	if (item->textStyle == ITEM_TEXTSTYLE_OUTLINED || item->textStyle == ITEM_TEXTSTYLE_OUTLINESHADOWED) {
;2988:		adjust = 0.5;
;2989:	}
;2990:
;2991:	if (item->textStyle == ITEM_TEXTSTYLE_SHADOWED || item->textStyle == ITEM_TEXTSTYLE_OUTLINESHADOWED) {
;2992:		Fade(&item->window.flags, &DC->Assets.shadowColor[3], DC->Assets.fadeClamp, &item->window.nextTime, DC->Assets.fadeCycle, qfalse);
;2993:		DC->drawText(item->textRect.x + DC->Assets.shadowX, item->textRect.y + DC->Assets.shadowY, item->textscale, DC->Assets.shadowColor, textPtr, adjust);
;2994:	}
;2995:*/
;2996:
;2997:
;2998://	if (item->textStyle == ITEM_TEXTSTYLE_OUTLINED || item->textStyle == ITEM_TEXTSTYLE_OUTLINESHADOWED) {
;2999://		Fade(&item->window.flags, &item->window.outlineColor[3], DC->Assets.fadeClamp, &item->window.nextTime, DC->Assets.fadeCycle, qfalse);
;3000://		/*
;3001://		Text_Paint(item->textRect.x-1, item->textRect.y-1, item->textscale, item->window.foreColor, textPtr, adjust);
;3002://		Text_Paint(item->textRect.x, item->textRect.y-1, item->textscale, item->window.foreColor, textPtr, adjust);
;3003://		Text_Paint(item->textRect.x+1, item->textRect.y-1, item->textscale, item->window.foreColor, textPtr, adjust);
;3004://		Text_Paint(item->textRect.x-1, item->textRect.y, item->textscale, item->window.foreColor, textPtr, adjust);
;3005://		Text_Paint(item->textRect.x+1, item->textRect.y, item->textscale, item->window.foreColor, textPtr, adjust);
;3006://		Text_Paint(item->textRect.x-1, item->textRect.y+1, item->textscale, item->window.foreColor, textPtr, adjust);
;3007://		Text_Paint(item->textRect.x, item->textRect.y+1, item->textscale, item->window.foreColor, textPtr, adjust);
;3008://		Text_Paint(item->textRect.x+1, item->textRect.y+1, item->textscale, item->window.foreColor, textPtr, adjust);
;3009://		*/
;3010://		DC->drawText(item->textRect.x - 1, item->textRect.y + 1, item->textscale * 1.02, item->window.outlineColor, textPtr, adjust);
;3011://	}
;3012:
;3013:	DC->drawText(item->textRect.x, item->textRect.y, item->textscale, color, textPtr, 0, 0, item->textStyle);
ADDRLP4 1052
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1052
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ARGF4
ADDRLP4 1052
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 1052
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 1052
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3014
;3014:}
LABELV $1406
endproc Item_Text_Paint 1056 32
export Item_TextField_Paint
proc Item_TextField_Paint 1096 36
line 3021
;3015:
;3016:
;3017:
;3018://float			trap_Cvar_VariableValue( const char *var_name );
;3019://void			trap_Cvar_VariableStringBuffer( const char *var_name, char *buffer, int bufsize );
;3020:
;3021:void Item_TextField_Paint(itemDef_t *item) {
line 3025
;3022:	char buff[1024];
;3023:	vec4_t newColor, lowLight;
;3024:	int offset;
;3025:	menuDef_t *parent = (menuDef_t*)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3026
;3026:	editFieldDef_t *editPtr = (editFieldDef_t*)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 3028
;3027:
;3028:	Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3030
;3029:
;3030:	buff[0] = '\0';
ADDRLP4 8
CNSTI1 0
ASGNI1
line 3032
;3031:
;3032:	if (item->cvar) {
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1418
line 3033
;3033:		DC->getCVarString(item->cvar, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 3034
;3034:	} 
LABELV $1418
line 3036
;3035:
;3036:	parent = (menuDef_t*)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3038
;3037:
;3038:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1420
line 3039
;3039:		lowLight[0] = 0.8 * parent->focusColor[0]; 
ADDRLP4 1032
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3040
;3040:		lowLight[1] = 0.8 * parent->focusColor[1]; 
ADDRLP4 1032+4
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3041
;3041:		lowLight[2] = 0.8 * parent->focusColor[2]; 
ADDRLP4 1032+8
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3042
;3042:		lowLight[3] = 0.8 * parent->focusColor[3]; 
ADDRLP4 1032+12
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3043
;3043:		LerpColor(parent->focusColor,lowLight,newColor,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 1068
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 1032
ARGP4
ADDRLP4 1048
ARGP4
ADDRLP4 1068
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3044
;3044:	} else {
ADDRGP4 $1421
JUMPV
LABELV $1420
line 3045
;3045:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 1048
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTU4 16
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 3046
;3046:	}
LABELV $1421
line 3048
;3047:
;3048:	offset = (item->text && *item->text) ? 8 : 0;
ADDRLP4 1072
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1072
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1426
ADDRLP4 1072
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1426
ADDRLP4 1068
CNSTI4 8
ASGNI4
ADDRGP4 $1427
JUMPV
LABELV $1426
ADDRLP4 1068
CNSTI4 0
ASGNI4
LABELV $1427
ADDRLP4 1064
ADDRLP4 1068
INDIRI4
ASGNI4
line 3049
;3049:	if (item->window.flags & WINDOW_HASFOCUS && g_editingField) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1428
ADDRGP4 g_editingField
INDIRI4
CNSTI4 0
EQI4 $1428
line 3050
;3050:		char cursor = DC->getOverstrikeMode() ? '_' : '|';
ADDRLP4 1084
ADDRGP4 DC
INDIRP4
CNSTI4 108
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1084
INDIRI4
CNSTI4 0
EQI4 $1431
ADDRLP4 1080
CNSTI4 95
ASGNI4
ADDRGP4 $1432
JUMPV
LABELV $1431
ADDRLP4 1080
CNSTI4 124
ASGNI4
LABELV $1432
ADDRLP4 1076
ADDRLP4 1080
INDIRI4
CVII1 4
ASGNI1
line 3051
;3051:		DC->drawTextWithCursor(item->textRect.x + item->textRect.w + offset, item->textRect.y, item->textscale, newColor, buff + editPtr->paintOffset, item->cursorPos - editPtr->paintOffset , cursor, editPtr->maxPaintChars, item->textStyle);
ADDRLP4 1088
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1088
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 1088
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
ADDRLP4 1064
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRLP4 1088
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 1088
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 1048
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ADDRLP4 8
ADDP4
ARGP4
ADDRLP4 1088
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
SUBI4
ARGI4
ADDRLP4 1076
INDIRI1
CVII4 1
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 1088
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 100
ADDP4
INDIRP4
CALLV
pop
line 3052
;3052:	} else {
ADDRGP4 $1429
JUMPV
LABELV $1428
line 3053
;3053:		DC->drawText(item->textRect.x + item->textRect.w + offset, item->textRect.y, item->textscale, newColor, buff + editPtr->paintOffset, 0, editPtr->maxPaintChars, item->textStyle);
ADDRLP4 1076
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1076
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 1076
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
ADDRLP4 1064
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRLP4 1076
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 1076
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 1048
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ADDRLP4 8
ADDP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 1076
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3054
;3054:	}
LABELV $1429
line 3056
;3055:
;3056:}
LABELV $1417
endproc Item_TextField_Paint 1096 36
export Item_YesNo_Paint
proc Item_YesNo_Paint 56 32
line 3058
;3057:
;3058:void Item_YesNo_Paint(itemDef_t *item) {
line 3061
;3059:	vec4_t newColor, lowLight;
;3060:	float value;
;3061:	menuDef_t *parent = (menuDef_t*)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3063
;3062:
;3063:	value = (item->cvar) ? DC->getCVarValue(item->cvar) : 0;
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1435
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 44
INDIRF4
ASGNF4
ADDRGP4 $1436
JUMPV
LABELV $1435
ADDRLP4 40
CNSTF4 0
ASGNF4
LABELV $1436
ADDRLP4 36
ADDRLP4 40
INDIRF4
ASGNF4
line 3065
;3064:
;3065:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1437
line 3066
;3066:		lowLight[0] = 0.8 * parent->focusColor[0]; 
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3067
;3067:		lowLight[1] = 0.8 * parent->focusColor[1]; 
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3068
;3068:		lowLight[2] = 0.8 * parent->focusColor[2]; 
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3069
;3069:		lowLight[3] = 0.8 * parent->focusColor[3]; 
ADDRLP4 4+12
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3070
;3070:		LerpColor(parent->focusColor,lowLight,newColor,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 48
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 48
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3071
;3071:	} else {
ADDRGP4 $1438
JUMPV
LABELV $1437
line 3072
;3072:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 20
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTU4 16
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 3073
;3073:	}
LABELV $1438
line 3075
;3074:
;3075:	if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1442
line 3076
;3076:		Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3077
;3077:		DC->drawText(item->textRect.x + item->textRect.w + 8, item->textRect.y, item->textscale, newColor, (value != 0) ? "Yes" : "No", 0, 0, item->textStyle);
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
ARGP4
ADDRLP4 36
INDIRF4
CNSTF4 0
EQF4 $1447
ADDRLP4 48
ADDRGP4 $1444
ASGNP4
ADDRGP4 $1448
JUMPV
LABELV $1447
ADDRLP4 48
ADDRGP4 $1445
ASGNP4
LABELV $1448
ADDRLP4 48
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3078
;3078:	} else {
ADDRGP4 $1443
JUMPV
LABELV $1442
line 3079
;3079:		DC->drawText(item->textRect.x, item->textRect.y, item->textscale, newColor, (value != 0) ? "Yes" : "No", 0, 0, item->textStyle);
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
ARGP4
ADDRLP4 36
INDIRF4
CNSTF4 0
EQF4 $1450
ADDRLP4 48
ADDRGP4 $1444
ASGNP4
ADDRGP4 $1451
JUMPV
LABELV $1450
ADDRLP4 48
ADDRGP4 $1445
ASGNP4
LABELV $1451
ADDRLP4 48
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3080
;3080:	}
LABELV $1443
line 3081
;3081:}
LABELV $1433
endproc Item_YesNo_Paint 56 32
export Item_Multi_Paint
proc Item_Multi_Paint 48 32
line 3083
;3082:
;3083:void Item_Multi_Paint(itemDef_t *item) {
line 3085
;3084:	vec4_t newColor, lowLight;
;3085:	const char *text = "";
ADDRLP4 4
ADDRGP4 $54
ASGNP4
line 3086
;3086:	menuDef_t *parent = (menuDef_t*)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3088
;3087:
;3088:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1453
line 3089
;3089:		lowLight[0] = 0.8 * parent->focusColor[0]; 
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3090
;3090:		lowLight[1] = 0.8 * parent->focusColor[1]; 
ADDRLP4 8+4
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3091
;3091:		lowLight[2] = 0.8 * parent->focusColor[2]; 
ADDRLP4 8+8
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3092
;3092:		lowLight[3] = 0.8 * parent->focusColor[3]; 
ADDRLP4 8+12
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3093
;3093:		LerpColor(parent->focusColor,lowLight,newColor,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 40
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 40
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3094
;3094:	} else {
ADDRGP4 $1454
JUMPV
LABELV $1453
line 3095
;3095:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 24
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTU4 16
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 3096
;3096:	}
LABELV $1454
line 3098
;3097:
;3098:	text = Item_Multi_Setting(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 Item_Multi_Setting
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 40
INDIRP4
ASGNP4
line 3100
;3099:
;3100:	if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1458
line 3101
;3101:		Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3102
;3102:		DC->drawText(item->textRect.x + item->textRect.w + 8, item->textRect.y, item->textscale, newColor, text, 0, 0, item->textStyle);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 44
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3103
;3103:	} else {
ADDRGP4 $1459
JUMPV
LABELV $1458
line 3104
;3104:		DC->drawText(item->textRect.x, item->textRect.y, item->textscale, newColor, text, 0, 0, item->textStyle);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 44
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3105
;3105:	}
LABELV $1459
line 3106
;3106:}
LABELV $1452
endproc Item_Multi_Paint 48 32
data
align 4
LABELV g_bindings
address $1462
byte 4 9
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1463
byte 4 13
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1464
byte 4 138
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1465
byte 4 132
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1466
byte 4 133
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1467
byte 4 44
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1468
byte 4 46
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1469
byte 4 32
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1470
byte 4 99
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1471
byte 4 134
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1472
byte 4 135
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1473
byte 4 136
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1474
byte 4 141
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1475
byte 4 140
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1476
byte 4 47
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1477
byte 4 144
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1478
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1479
byte 4 49
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1480
byte 4 50
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1481
byte 4 51
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1482
byte 4 52
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1483
byte 4 53
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1484
byte 4 54
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1485
byte 4 55
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1486
byte 4 56
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1487
byte 4 57
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1488
byte 4 48
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1489
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1490
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1491
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1492
byte 4 137
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1493
byte 4 91
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1494
byte 4 93
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1495
byte 4 180
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1496
byte 4 181
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1497
byte 4 119
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1498
byte 4 114
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1499
byte 4 116
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1500
byte 4 121
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1501
byte 4 110
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1502
byte 4 111
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1503
byte 4 100
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1504
byte 4 112
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1505
byte 4 99
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1506
byte 4 102
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1507
byte 4 118
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1508
byte 4 101
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1509
byte 4 105
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1510
byte 4 107
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1511
byte 4 145
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1512
byte 4 146
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1513
byte 4 147
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1514
byte 4 148
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1515
byte 4 149
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1516
byte 4 162
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1517
byte 4 168
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1518
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1519
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1520
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1521
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
align 4
LABELV g_bindCount
byte 4 60
code
proc Controls_GetKeyAssignment 276 12
line 3215
;3107:
;3108:
;3109:typedef struct {
;3110:	char	*command;
;3111:	int		id;
;3112:	int		defaultbind1;
;3113:	int		defaultbind2;
;3114:	int		bind1;
;3115:	int		bind2;
;3116:} bind_t;
;3117:
;3118:typedef struct
;3119:{
;3120:	char*	name;
;3121:	float	defaultvalue;
;3122:	float	value;	
;3123:} configcvar_t;
;3124:
;3125:
;3126:static bind_t g_bindings[] = 
;3127:{
;3128:	{"+scores",			 K_TAB,				-1,		-1, -1},
;3129:	{"+button2",		 K_ENTER,			-1,		-1, -1},
;3130:	{"+speed", 			 K_SHIFT,			-1,		-1,	-1},
;3131:	{"+forward", 		 K_UPARROW,		-1,		-1, -1},
;3132:	{"+back", 			 K_DOWNARROW,	-1,		-1, -1},
;3133:	{"+moveleft", 	 ',',					-1,		-1, -1},
;3134:	{"+moveright", 	 '.',					-1,		-1, -1},
;3135:	{"+moveup",			 K_SPACE,			-1,		-1, -1},
;3136:	{"+movedown",		 'c',					-1,		-1, -1},
;3137:	{"+left", 			 K_LEFTARROW,	-1,		-1, -1},
;3138:	{"+right", 			 K_RIGHTARROW,	-1,		-1, -1},
;3139:	{"+strafe", 		 K_ALT,				-1,		-1, -1},
;3140:	{"+lookup", 		 K_PGDN,				-1,		-1, -1},
;3141:	{"+lookdown", 	 K_DEL,				-1,		-1, -1},
;3142:	{"+mlook", 			 '/',					-1,		-1, -1},
;3143:	{"centerview", 	 K_END,				-1,		-1, -1},
;3144:	{"+zoom", 			 -1,						-1,		-1, -1},
;3145:	{"weapon 1",		 '1',					-1,		-1, -1},
;3146:	{"weapon 2",		 '2',					-1,		-1, -1},
;3147:	{"weapon 3",		 '3',					-1,		-1, -1},
;3148:	{"weapon 4",		 '4',					-1,		-1, -1},
;3149:	{"weapon 5",		 '5',					-1,		-1, -1},
;3150:	{"weapon 6",		 '6',					-1,		-1, -1},
;3151:	{"weapon 7",		 '7',					-1,		-1, -1},
;3152:	{"weapon 8",		 '8',					-1,		-1, -1},
;3153:	{"weapon 9",		 '9',					-1,		-1, -1},
;3154:	{"weapon 10",		 '0',					-1,		-1, -1},
;3155:	{"weapon 11",		 -1,					-1,		-1, -1},
;3156:	{"weapon 12",		 -1,					-1,		-1, -1},
;3157:	{"weapon 13",		 -1,					-1,		-1, -1},
;3158:	{"+attack", 		 K_CTRL,				-1,		-1, -1},
;3159:	{"weapprev",		 '[',					-1,		-1, -1},
;3160:	{"weapnext", 		 ']',					-1,		-1, -1},
;3161:	{"+button3", 		 K_MOUSE3,			-1,		-1, -1},
;3162:	{"+button4", 		 K_MOUSE4,			-1,		-1, -1},
;3163:	{"prevTeamMember", 'w',					-1,		-1, -1},
;3164:	{"nextTeamMember", 'r',					-1,		-1, -1},
;3165:	{"nextOrder", 't',					-1,		-1, -1},
;3166:	{"confirmOrder", 'y',					-1,		-1, -1},
;3167:	{"denyOrder", 'n',					-1,		-1, -1},
;3168:	{"taskOffense", 'o',					-1,		-1, -1},
;3169:	{"taskDefense", 'd',					-1,		-1, -1},
;3170:	{"taskPatrol", 'p',					-1,		-1, -1},
;3171:	{"taskCamp", 'c',					-1,		-1, -1},
;3172:	{"taskFollow", 'f',					-1,		-1, -1},
;3173:	{"taskRetrieve", 'v',					-1,		-1, -1},
;3174:	{"taskEscort", 'e',					-1,		-1, -1},
;3175:	{"taskOwnFlag", 'i',					-1,		-1, -1},
;3176:	{"taskSuicide", 'k',					-1,		-1, -1},
;3177:	{"tauntKillInsult", K_F1,			-1,		-1, -1},
;3178:	{"tauntPraise", K_F2,			-1,		-1, -1},
;3179:	{"tauntTaunt", K_F3,			-1,		-1, -1},
;3180:	{"tauntDeathInsult", K_F4,			-1,		-1, -1},
;3181:	{"tauntGauntlet", K_F5,			-1,		-1, -1},
;3182:	{"scoresUp", K_KP_PGUP,			-1,		-1, -1},
;3183:	{"scoresDown", K_KP_PGDN,			-1,		-1, -1},
;3184:	// bk001205 - this one below was:  '-1' 
;3185:	{"messagemode",  -1,					-1,		-1, -1},
;3186:	{"messagemode2", -1,						-1,		-1, -1},
;3187:	{"messagemode3", -1,						-1,		-1, -1},
;3188:	{"messagemode4", -1,						-1,		-1, -1}
;3189:};
;3190:
;3191:
;3192:static const int g_bindCount = sizeof(g_bindings) / sizeof(bind_t);
;3193:
;3194:#ifndef MISSIONPACK // bk001206
;3195:static configcvar_t g_configcvars[] =
;3196:{
;3197:	{"cl_run",			0,					0},
;3198:	{"m_pitch",			0,					0},
;3199:	{"cg_autoswitch",	0,					0},
;3200:	{"sensitivity",		0,					0},
;3201:	{"in_joystick",		0,					0},
;3202:	{"joy_threshold",	0,					0},
;3203:	{"m_filter",		0,					0},
;3204:	{"cl_freelook",		0,					0},
;3205:	{NULL,				0,					0}
;3206:};
;3207:#endif
;3208:
;3209:/*
;3210:=================
;3211:Controls_GetKeyAssignment
;3212:=================
;3213:*/
;3214:static void Controls_GetKeyAssignment (char *command, int *twokeys)
;3215:{
line 3220
;3216:	int		count;
;3217:	int		j;
;3218:	char	b[256];
;3219:
;3220:	twokeys[0] = twokeys[1] = -1;
ADDRLP4 264
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 268
CNSTI4 -1
ASGNI4
ADDRLP4 264
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 268
INDIRI4
ASGNI4
ADDRLP4 264
INDIRP4
ADDRLP4 268
INDIRI4
ASGNI4
line 3221
;3221:	count = 0;
ADDRLP4 260
CNSTI4 0
ASGNI4
line 3223
;3222:
;3223:	for ( j = 0; j < 256; j++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1523
line 3224
;3224:	{
line 3225
;3225:		DC->getBindingBuf( j, b, 256 );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 140
ADDP4
INDIRP4
CALLV
pop
line 3226
;3226:		if ( *b == 0 ) {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1527
line 3227
;3227:			continue;
ADDRGP4 $1524
JUMPV
LABELV $1527
line 3229
;3228:		}
;3229:		if ( !Q_stricmp( b, command ) ) {
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
NEI4 $1529
line 3230
;3230:			twokeys[count] = j;
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 3231
;3231:			count++;
ADDRLP4 260
ADDRLP4 260
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3232
;3232:			if (count == 2) {
ADDRLP4 260
INDIRI4
CNSTI4 2
NEI4 $1531
line 3233
;3233:				break;
ADDRGP4 $1525
JUMPV
LABELV $1531
line 3235
;3234:			}
;3235:		}
LABELV $1529
line 3236
;3236:	}
LABELV $1524
line 3223
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 256
LTI4 $1523
LABELV $1525
line 3237
;3237:}
LABELV $1522
endproc Controls_GetKeyAssignment 276 12
export Controls_GetConfig
proc Controls_GetConfig 12 8
line 3245
;3238:
;3239:/*
;3240:=================
;3241:Controls_GetConfig
;3242:=================
;3243:*/
;3244:void Controls_GetConfig( void )
;3245:{
line 3250
;3246:	int		i;
;3247:	int		twokeys[2];
;3248:
;3249:	// iterate each command, get its numeric binding
;3250:	for (i=0; i < g_bindCount; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1537
JUMPV
LABELV $1534
line 3251
;3251:	{
line 3253
;3252:
;3253:		Controls_GetKeyAssignment(g_bindings[i].command, twokeys);
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Controls_GetKeyAssignment
CALLV
pop
line 3255
;3254:
;3255:		g_bindings[i].bind1 = twokeys[0];
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 3256
;3256:		g_bindings[i].bind2 = twokeys[1];
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
ADDRLP4 4+4
INDIRI4
ASGNI4
line 3257
;3257:	}
LABELV $1535
line 3250
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1537
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1534
line 3267
;3258:
;3259:	//s_controls.invertmouse.curvalue  = DC->getCVarValue( "m_pitch" ) < 0;
;3260:	//s_controls.smoothmouse.curvalue  = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "m_filter" ) );
;3261:	//s_controls.alwaysrun.curvalue    = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "cl_run" ) );
;3262:	//s_controls.autoswitch.curvalue   = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "cg_autoswitch" ) );
;3263:	//s_controls.sensitivity.curvalue  = UI_ClampCvar( 2, 30, Controls_GetCvarValue( "sensitivity" ) );
;3264:	//s_controls.joyenable.curvalue    = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "in_joystick" ) );
;3265:	//s_controls.joythreshold.curvalue = UI_ClampCvar( 0.05, 0.75, Controls_GetCvarValue( "joy_threshold" ) );
;3266:	//s_controls.freelook.curvalue     = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "cl_freelook" ) );
;3267:}
LABELV $1533
endproc Controls_GetConfig 12 8
export Controls_SetConfig
proc Controls_SetConfig 12 8
line 3275
;3268:
;3269:/*
;3270:=================
;3271:Controls_SetConfig
;3272:=================
;3273:*/
;3274:void Controls_SetConfig(qboolean restart)
;3275:{
line 3279
;3276:	int		i;
;3277:
;3278:	// iterate each command, get its numeric binding
;3279:	for (i=0; i < g_bindCount; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1545
JUMPV
LABELV $1542
line 3280
;3280:	{
line 3282
;3281:
;3282:		if (g_bindings[i].bind1 != -1)
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1546
line 3283
;3283:		{	
line 3284
;3284:			DC->setBinding( g_bindings[i].bind1, g_bindings[i].command );
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings
ADDP4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 144
ADDP4
INDIRP4
CALLV
pop
line 3286
;3285:
;3286:			if (g_bindings[i].bind2 != -1)
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1550
line 3287
;3287:				DC->setBinding( g_bindings[i].bind2, g_bindings[i].command );
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings
ADDP4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 144
ADDP4
INDIRP4
CALLV
pop
LABELV $1550
line 3288
;3288:		}
LABELV $1546
line 3289
;3289:	}
LABELV $1543
line 3279
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1545
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1542
line 3303
;3290:
;3291:	//if ( s_controls.invertmouse.curvalue )
;3292:	//	DC->setCVar("m_pitch", va("%f),-fabs( DC->getCVarValue( "m_pitch" ) ) );
;3293:	//else
;3294:	//	trap_Cvar_SetValue( "m_pitch", fabs( trap_Cvar_VariableValue( "m_pitch" ) ) );
;3295:
;3296:	//trap_Cvar_SetValue( "m_filter", s_controls.smoothmouse.curvalue );
;3297:	//trap_Cvar_SetValue( "cl_run", s_controls.alwaysrun.curvalue );
;3298:	//trap_Cvar_SetValue( "cg_autoswitch", s_controls.autoswitch.curvalue );
;3299:	//trap_Cvar_SetValue( "sensitivity", s_controls.sensitivity.curvalue );
;3300:	//trap_Cvar_SetValue( "in_joystick", s_controls.joyenable.curvalue );
;3301:	//trap_Cvar_SetValue( "joy_threshold", s_controls.joythreshold.curvalue );
;3302:	//trap_Cvar_SetValue( "cl_freelook", s_controls.freelook.curvalue );
;3303:	DC->executeText(EXEC_APPEND, "in_restart\n");
CNSTI4 2
ARGI4
ADDRGP4 $1554
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 148
ADDP4
INDIRP4
CALLV
pop
line 3305
;3304:	//trap_Cmd_ExecuteText( EXEC_APPEND, "in_restart\n" );
;3305:}
LABELV $1541
endproc Controls_SetConfig 12 8
export Controls_SetDefaults
proc Controls_SetDefaults 12 0
line 3313
;3306:
;3307:/*
;3308:=================
;3309:Controls_SetDefaults
;3310:=================
;3311:*/
;3312:void Controls_SetDefaults( void )
;3313:{
line 3317
;3314:	int	i;
;3315:
;3316:	// iterate each command, set its default binding
;3317:  for (i=0; i < g_bindCount; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1559
JUMPV
LABELV $1556
line 3318
;3318:	{
line 3319
;3319:		g_bindings[i].bind1 = g_bindings[i].defaultbind1;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+8
ADDP4
INDIRI4
ASGNI4
line 3320
;3320:		g_bindings[i].bind2 = g_bindings[i].defaultbind2;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+12
ADDP4
INDIRI4
ASGNI4
line 3321
;3321:	}
LABELV $1557
line 3317
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1559
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1556
line 3331
;3322:
;3323:	//s_controls.invertmouse.curvalue  = Controls_GetCvarDefault( "m_pitch" ) < 0;
;3324:	//s_controls.smoothmouse.curvalue  = Controls_GetCvarDefault( "m_filter" );
;3325:	//s_controls.alwaysrun.curvalue    = Controls_GetCvarDefault( "cl_run" );
;3326:	//s_controls.autoswitch.curvalue   = Controls_GetCvarDefault( "cg_autoswitch" );
;3327:	//s_controls.sensitivity.curvalue  = Controls_GetCvarDefault( "sensitivity" );
;3328:	//s_controls.joyenable.curvalue    = Controls_GetCvarDefault( "in_joystick" );
;3329:	//s_controls.joythreshold.curvalue = Controls_GetCvarDefault( "joy_threshold" );
;3330:	//s_controls.freelook.curvalue     = Controls_GetCvarDefault( "cl_freelook" );
;3331:}
LABELV $1555
endproc Controls_SetDefaults 12 0
export BindingIDFromName
proc BindingIDFromName 8 8
line 3333
;3332:
;3333:int BindingIDFromName(const char *name) {
line 3335
;3334:	int i;
;3335:  for (i=0; i < g_bindCount; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1568
JUMPV
LABELV $1565
line 3336
;3336:	{
line 3337
;3337:		if (Q_stricmp(name, g_bindings[i].command) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings
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
NEI4 $1569
line 3338
;3338:			return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1564
JUMPV
LABELV $1569
line 3340
;3339:		}
;3340:	}
LABELV $1566
line 3335
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1568
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1565
line 3341
;3341:	return -1;
CNSTI4 -1
RETI4
LABELV $1564
endproc BindingIDFromName 8 8
export BindingFromName
proc BindingFromName 16 12
line 3347
;3342:}
;3343:
;3344:char g_nameBind1[32];
;3345:char g_nameBind2[32];
;3346:
;3347:void BindingFromName(const char *cvar) {
line 3351
;3348:	int	i, b1, b2;
;3349:
;3350:	// iterate each command, set its default binding
;3351:	for (i=0; i < g_bindCount; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1575
JUMPV
LABELV $1572
line 3352
;3352:	{
line 3353
;3353:		if (Q_stricmp(cvar, g_bindings[i].command) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings
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
NEI4 $1576
line 3354
;3354:			b1 = g_bindings[i].bind1;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ASGNI4
line 3355
;3355:			if (b1 == -1) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
NEI4 $1579
line 3356
;3356:				break;
ADDRGP4 $1574
JUMPV
LABELV $1579
line 3358
;3357:			}
;3358:				DC->keynumToStringBuf( b1, g_nameBind1, 32 );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 g_nameBind1
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 136
ADDP4
INDIRP4
CALLV
pop
line 3359
;3359:				Q_strupr(g_nameBind1);
ADDRGP4 g_nameBind1
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 3361
;3360:
;3361:				b2 = g_bindings[i].bind2;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ASGNI4
line 3362
;3362:				if (b2 != -1)
ADDRLP4 8
INDIRI4
CNSTI4 -1
EQI4 $1571
line 3363
;3363:				{
line 3364
;3364:					DC->keynumToStringBuf( b2, g_nameBind2, 32 );
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 g_nameBind2
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 136
ADDP4
INDIRP4
CALLV
pop
line 3365
;3365:					Q_strupr(g_nameBind2);
ADDRGP4 g_nameBind2
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 3366
;3366:					strcat( g_nameBind1, " or " );
ADDRGP4 g_nameBind1
ARGP4
ADDRGP4 $1584
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 3367
;3367:					strcat( g_nameBind1, g_nameBind2 );
ADDRGP4 g_nameBind1
ARGP4
ADDRGP4 g_nameBind2
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 3368
;3368:				}
line 3369
;3369:			return;
ADDRGP4 $1571
JUMPV
LABELV $1576
line 3371
;3370:		}
;3371:	}
LABELV $1573
line 3351
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1575
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1572
LABELV $1574
line 3372
;3372:	strcpy(g_nameBind1, "???");
ADDRGP4 g_nameBind1
ARGP4
ADDRGP4 $1585
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 3373
;3373:}
LABELV $1571
endproc BindingFromName 16 12
export Item_Slider_Paint
proc Item_Slider_Paint 68 20
line 3375
;3374:
;3375:void Item_Slider_Paint(itemDef_t *item) {
line 3378
;3376:	vec4_t newColor, lowLight;
;3377:	float x, y, value;
;3378:	menuDef_t *parent = (menuDef_t*)item->parent;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3380
;3379:
;3380:	value = (item->cvar) ? DC->getCVarValue(item->cvar) : 0;
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1588
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 48
ADDRLP4 52
INDIRF4
ASGNF4
ADDRGP4 $1589
JUMPV
LABELV $1588
ADDRLP4 48
CNSTF4 0
ASGNF4
LABELV $1589
ADDRLP4 44
ADDRLP4 48
INDIRF4
ASGNF4
line 3382
;3381:
;3382:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1590
line 3383
;3383:		lowLight[0] = 0.8 * parent->focusColor[0]; 
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3384
;3384:		lowLight[1] = 0.8 * parent->focusColor[1]; 
ADDRLP4 12+4
ADDRLP4 4
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3385
;3385:		lowLight[2] = 0.8 * parent->focusColor[2]; 
ADDRLP4 12+8
ADDRLP4 4
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3386
;3386:		lowLight[3] = 0.8 * parent->focusColor[3]; 
ADDRLP4 12+12
ADDRLP4 4
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3387
;3387:		LerpColor(parent->focusColor,lowLight,newColor,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 56
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 56
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3388
;3388:	} else {
ADDRGP4 $1591
JUMPV
LABELV $1590
line 3389
;3389:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTU4 16
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 3390
;3390:	}
LABELV $1591
line 3392
;3391:
;3392:	y = item->window.rect.y;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 3393
;3393:	if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1595
line 3394
;3394:		Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3395
;3395:		x = item->textRect.x + item->textRect.w + 8;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 56
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 3396
;3396:	} else {
ADDRGP4 $1596
JUMPV
LABELV $1595
line 3397
;3397:		x = item->window.rect.x;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 3398
;3398:	}
LABELV $1596
line 3399
;3399:	DC->setColor(newColor);
ADDRLP4 28
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 3400
;3400:	DC->drawHandlePic( x, y, SLIDER_WIDTH, SLIDER_HEIGHT, DC->Assets.sliderBar );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1119879168
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 56
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 61928
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3402
;3401:
;3402:	x = Item_Slider_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 Item_Slider_ThumbPosition
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 60
INDIRF4
ASGNF4
line 3403
;3403:	DC->drawHandlePic( x - (SLIDER_THUMB_WIDTH / 2), y - 2, SLIDER_THUMB_WIDTH, SLIDER_THUMB_HEIGHT, DC->Assets.sliderThumb );
ADDRLP4 0
INDIRF4
CNSTF4 1086324736
SUBF4
ARGF4
ADDRLP4 8
INDIRF4
CNSTF4 1073741824
SUBF4
ARGF4
CNSTF4 1094713344
ARGF4
CNSTF4 1101004800
ARGF4
ADDRLP4 64
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 61932
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3405
;3404:
;3405:}
LABELV $1586
endproc Item_Slider_Paint 68 20
export Item_Bind_Paint
proc Item_Bind_Paint 64 32
line 3407
;3406:
;3407:void Item_Bind_Paint(itemDef_t *item) {
line 3410
;3408:	vec4_t newColor, lowLight;
;3409:	float value;
;3410:	int maxChars = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 3411
;3411:	menuDef_t *parent = (menuDef_t*)item->parent;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3412
;3412:	editFieldDef_t *editPtr = (editFieldDef_t*)item->typeData;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 3413
;3413:	if (editPtr) {
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1598
line 3414
;3414:		maxChars = editPtr->maxPaintChars;
ADDRLP4 16
ADDRLP4 24
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
line 3415
;3415:	}
LABELV $1598
line 3417
;3416:
;3417:	value = (item->cvar) ? DC->getCVarValue(item->cvar) : 0;
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1601
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 48
ADDRLP4 52
INDIRF4
ASGNF4
ADDRGP4 $1602
JUMPV
LABELV $1601
ADDRLP4 48
CNSTF4 0
ASGNF4
LABELV $1602
ADDRLP4 44
ADDRLP4 48
INDIRF4
ASGNF4
line 3419
;3418:
;3419:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1603
line 3420
;3420:		if (g_bindItem == item) {
ADDRGP4 g_bindItem
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $1605
line 3421
;3421:			lowLight[0] = 0.8f * 1.0f;
ADDRLP4 0
CNSTF4 1061997773
ASGNF4
line 3422
;3422:			lowLight[1] = 0.8f * 0.0f;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 3423
;3423:			lowLight[2] = 0.8f * 0.0f;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 3424
;3424:			lowLight[3] = 0.8f * 1.0f;
ADDRLP4 0+12
CNSTF4 1061997773
ASGNF4
line 3425
;3425:		} else {
ADDRGP4 $1606
JUMPV
LABELV $1605
line 3426
;3426:			lowLight[0] = 0.8f * parent->focusColor[0]; 
ADDRLP4 0
ADDRLP4 20
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3427
;3427:			lowLight[1] = 0.8f * parent->focusColor[1]; 
ADDRLP4 0+4
ADDRLP4 20
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3428
;3428:			lowLight[2] = 0.8f * parent->focusColor[2]; 
ADDRLP4 0+8
ADDRLP4 20
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3429
;3429:			lowLight[3] = 0.8f * parent->focusColor[3]; 
ADDRLP4 0+12
ADDRLP4 20
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3430
;3430:		}
LABELV $1606
line 3431
;3431:		LerpColor(parent->focusColor,lowLight,newColor,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 56
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 20
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 56
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3432
;3432:	} else {
ADDRGP4 $1604
JUMPV
LABELV $1603
line 3433
;3433:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTU4 16
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 3434
;3434:	}
LABELV $1604
line 3436
;3435:
;3436:	if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1613
line 3437
;3437:		Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3438
;3438:		BindingFromName(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRGP4 BindingFromName
CALLV
pop
line 3439
;3439:		DC->drawText(item->textRect.x + item->textRect.w + 8, item->textRect.y, item->textscale, newColor, g_nameBind1, 0, maxChars, item->textStyle);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
ARGP4
ADDRGP4 g_nameBind1
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3440
;3440:	} else {
ADDRGP4 $1614
JUMPV
LABELV $1613
line 3441
;3441:		DC->drawText(item->textRect.x, item->textRect.y, item->textscale, newColor, (value != 0) ? "FIXME" : "FIXME", 0, maxChars, item->textStyle);
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
ARGP4
ADDRLP4 44
INDIRF4
CNSTF4 0
EQF4 $1617
ADDRLP4 56
ADDRGP4 $1615
ASGNP4
ADDRGP4 $1618
JUMPV
LABELV $1617
ADDRLP4 56
ADDRGP4 $1615
ASGNP4
LABELV $1618
ADDRLP4 56
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 16
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3442
;3442:	}
LABELV $1614
line 3443
;3443:}
LABELV $1597
endproc Item_Bind_Paint 64 32
export Display_KeyBindPending
proc Display_KeyBindPending 0 0
line 3445
;3444:
;3445:qboolean Display_KeyBindPending(void) {
line 3446
;3446:	return g_waitingForKey;
ADDRGP4 g_waitingForKey
INDIRI4
RETI4
LABELV $1619
endproc Display_KeyBindPending 0 0
export Item_Bind_HandleKey
proc Item_Bind_HandleKey 24 12
line 3449
;3447:}
;3448:
;3449:qboolean Item_Bind_HandleKey(itemDef_t *item, int key, qboolean down) {
line 3453
;3450:	int			id;
;3451:	int			i;
;3452:
;3453:	if (Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory) && !g_waitingForKey)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $1621
ADDRGP4 g_waitingForKey
INDIRI4
CNSTI4 0
NEI4 $1621
line 3454
;3454:	{
line 3455
;3455:		if (down && (key == K_MOUSE1 || key == K_ENTER)) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1623
ADDRLP4 16
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 178
EQI4 $1625
ADDRLP4 16
INDIRI4
CNSTI4 13
NEI4 $1623
LABELV $1625
line 3456
;3456:			g_waitingForKey = qtrue;
ADDRGP4 g_waitingForKey
CNSTI4 1
ASGNI4
line 3457
;3457:			g_bindItem = item;
ADDRGP4 g_bindItem
ADDRFP4 0
INDIRP4
ASGNP4
line 3458
;3458:		}
LABELV $1623
line 3459
;3459:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1620
JUMPV
LABELV $1621
line 3462
;3460:	}
;3461:	else
;3462:	{
line 3463
;3463:		if (!g_waitingForKey || g_bindItem == NULL) {
ADDRGP4 g_waitingForKey
INDIRI4
CNSTI4 0
EQI4 $1628
ADDRGP4 g_bindItem
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1626
LABELV $1628
line 3464
;3464:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1620
JUMPV
LABELV $1626
line 3467
;3465:		}
;3466:
;3467:		if (key & K_CHAR_FLAG) {
ADDRFP4 4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1629
line 3468
;3468:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1620
JUMPV
LABELV $1629
line 3471
;3469:		}
;3470:
;3471:		switch (key)
ADDRLP4 16
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 96
EQI4 $1639
ADDRLP4 16
INDIRI4
CNSTI4 96
GTI4 $1641
LABELV $1640
ADDRFP4 4
INDIRI4
CNSTI4 27
EQI4 $1633
ADDRGP4 $1631
JUMPV
LABELV $1641
ADDRFP4 4
INDIRI4
CNSTI4 127
EQI4 $1634
ADDRGP4 $1631
JUMPV
line 3472
;3472:		{
LABELV $1633
line 3474
;3473:			case K_ESCAPE:
;3474:				g_waitingForKey = qfalse;
ADDRGP4 g_waitingForKey
CNSTI4 0
ASGNI4
line 3475
;3475:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1620
JUMPV
LABELV $1634
line 3478
;3476:	
;3477:			case K_BACKSPACE:
;3478:				id = BindingIDFromName(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 BindingIDFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
ASGNI4
line 3479
;3479:				if (id != -1) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
EQI4 $1635
line 3480
;3480:					g_bindings[id].bind1 = -1;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
CNSTI4 -1
ASGNI4
line 3481
;3481:					g_bindings[id].bind2 = -1;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
CNSTI4 -1
ASGNI4
line 3482
;3482:				}
LABELV $1635
line 3483
;3483:				Controls_SetConfig(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 Controls_SetConfig
CALLV
pop
line 3484
;3484:				g_waitingForKey = qfalse;
ADDRGP4 g_waitingForKey
CNSTI4 0
ASGNI4
line 3485
;3485:				g_bindItem = NULL;
ADDRGP4 g_bindItem
CNSTP4 0
ASGNP4
line 3486
;3486:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1620
JUMPV
LABELV $1639
line 3489
;3487:
;3488:			case '`':
;3489:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1620
JUMPV
LABELV $1631
line 3491
;3490:		}
;3491:	}
line 3493
;3492:
;3493:	if (key != -1)
ADDRFP4 4
INDIRI4
CNSTI4 -1
EQI4 $1642
line 3494
;3494:	{
line 3496
;3495:
;3496:		for (i=0; i < g_bindCount; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1647
JUMPV
LABELV $1644
line 3497
;3497:		{
line 3499
;3498:
;3499:			if (g_bindings[i].bind2 == key) {
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $1648
line 3500
;3500:				g_bindings[i].bind2 = -1;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
CNSTI4 -1
ASGNI4
line 3501
;3501:			}
LABELV $1648
line 3503
;3502:
;3503:			if (g_bindings[i].bind1 == key)
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $1652
line 3504
;3504:			{
line 3505
;3505:				g_bindings[i].bind1 = g_bindings[i].bind2;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ASGNI4
line 3506
;3506:				g_bindings[i].bind2 = -1;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
CNSTI4 -1
ASGNI4
line 3507
;3507:			}
LABELV $1652
line 3508
;3508:		}
LABELV $1645
line 3496
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1647
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1644
line 3509
;3509:	}
LABELV $1642
line 3512
;3510:
;3511:
;3512:	id = BindingIDFromName(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 BindingIDFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 3514
;3513:
;3514:	if (id != -1) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
EQI4 $1658
line 3515
;3515:		if (key == -1) {
ADDRFP4 4
INDIRI4
CNSTI4 -1
NEI4 $1660
line 3516
;3516:			if( g_bindings[id].bind1 != -1 ) {
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1662
line 3517
;3517:				DC->setBinding( g_bindings[id].bind1, "" );
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ARGI4
ADDRGP4 $54
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 144
ADDP4
INDIRP4
CALLV
pop
line 3518
;3518:				g_bindings[id].bind1 = -1;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
CNSTI4 -1
ASGNI4
line 3519
;3519:			}
LABELV $1662
line 3520
;3520:			if( g_bindings[id].bind2 != -1 ) {
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1661
line 3521
;3521:				DC->setBinding( g_bindings[id].bind2, "" );
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 $54
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 144
ADDP4
INDIRP4
CALLV
pop
line 3522
;3522:				g_bindings[id].bind2 = -1;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
CNSTI4 -1
ASGNI4
line 3523
;3523:			}
line 3524
;3524:		}
ADDRGP4 $1661
JUMPV
LABELV $1660
line 3525
;3525:		else if (g_bindings[id].bind1 == -1) {
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1672
line 3526
;3526:			g_bindings[id].bind1 = key;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 3527
;3527:		}
ADDRGP4 $1673
JUMPV
LABELV $1672
line 3528
;3528:		else if (g_bindings[id].bind1 != key && g_bindings[id].bind2 == -1) {
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
EQI4 $1676
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1676
line 3529
;3529:			g_bindings[id].bind2 = key;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 3530
;3530:		}
ADDRGP4 $1677
JUMPV
LABELV $1676
line 3531
;3531:		else {
line 3532
;3532:			DC->setBinding( g_bindings[id].bind1, "" );
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ARGI4
ADDRGP4 $54
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 144
ADDP4
INDIRP4
CALLV
pop
line 3533
;3533:			DC->setBinding( g_bindings[id].bind2, "" );
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 $54
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 144
ADDP4
INDIRP4
CALLV
pop
line 3534
;3534:			g_bindings[id].bind1 = key;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 3535
;3535:			g_bindings[id].bind2 = -1;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
CNSTI4 -1
ASGNI4
line 3536
;3536:		}						
LABELV $1677
LABELV $1673
LABELV $1661
line 3537
;3537:	}
LABELV $1658
line 3539
;3538:
;3539:	Controls_SetConfig(qtrue);	
CNSTI4 1
ARGI4
ADDRGP4 Controls_SetConfig
CALLV
pop
line 3540
;3540:	g_waitingForKey = qfalse;
ADDRGP4 g_waitingForKey
CNSTI4 0
ASGNI4
line 3542
;3541:
;3542:	return qtrue;
CNSTI4 1
RETI4
LABELV $1620
endproc Item_Bind_HandleKey 24 12
export AdjustFrom640
proc AdjustFrom640 24 0
line 3547
;3543:}
;3544:
;3545:
;3546:
;3547:void AdjustFrom640(float *x, float *y, float *w, float *h) {
line 3548
;3548:	*x = *x * DC->scale + DC->biasX;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 73392
ADDP4
INDIRF4
MULF4
ADDRLP4 4
INDIRP4
CNSTI4 73396
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3549
;3549:	*y = *y * DC->scale + DC->biasY;
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 73392
ADDP4
INDIRF4
MULF4
ADDRLP4 12
INDIRP4
CNSTI4 73400
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3550
;3550:	*w *= DC->scale;
ADDRLP4 16
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
ADDRGP4 DC
INDIRP4
CNSTI4 73392
ADDP4
INDIRF4
MULF4
ASGNF4
line 3551
;3551:	*h *= DC->scale;
ADDRLP4 20
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRGP4 DC
INDIRP4
CNSTI4 73392
ADDP4
INDIRF4
MULF4
ASGNF4
line 3552
;3552:}
LABELV $1685
endproc AdjustFrom640 24 0
export Item_Model_Paint
proc Item_Model_Paint 588 16
line 3554
;3553:
;3554:void Item_Model_Paint(itemDef_t *item) {
line 3560
;3555:	float x, y, w, h;
;3556:	refdef_t refdef;
;3557:	refEntity_t		ent;
;3558:	vec3_t			mins, maxs, origin;
;3559:	vec3_t			angles;
;3560:	modelDef_t *modelPtr = (modelDef_t*)item->typeData;
ADDRLP4 508
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 3562
;3561:
;3562:	if (modelPtr == NULL) {
ADDRLP4 508
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1687
line 3563
;3563:		return;
ADDRGP4 $1686
JUMPV
LABELV $1687
line 3567
;3564:	}
;3565:
;3566:	// setup the refdef
;3567:	memset( &refdef, 0, sizeof( refdef ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTU4 368
ARGU4
ADDRGP4 memset
CALLP4
pop
line 3568
;3568:	refdef.rdflags = RDF_NOWORLDMODEL;
ADDRLP4 0+76
CNSTI4 1
ASGNI4
line 3569
;3569:	AxisClear( refdef.viewaxis );
ADDRLP4 0+36
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 3570
;3570:	x = item->window.rect.x+1;
ADDRLP4 568
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3571
;3571:	y = item->window.rect.y+1;
ADDRLP4 572
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3572
;3572:	w = item->window.rect.w-2;
ADDRLP4 524
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 3573
;3573:	h = item->window.rect.h-2;
ADDRLP4 528
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 3575
;3574:
;3575:	AdjustFrom640( &x, &y, &w, &h );
ADDRLP4 568
ARGP4
ADDRLP4 572
ARGP4
ADDRLP4 524
ARGP4
ADDRLP4 528
ARGP4
ADDRGP4 AdjustFrom640
CALLV
pop
line 3577
;3576:
;3577:	refdef.x = x;
ADDRLP4 0
ADDRLP4 568
INDIRF4
CVFI4 4
ASGNI4
line 3578
;3578:	refdef.y = y;
ADDRLP4 0+4
ADDRLP4 572
INDIRF4
CVFI4 4
ASGNI4
line 3579
;3579:	refdef.width = w;
ADDRLP4 0+8
ADDRLP4 524
INDIRF4
CVFI4 4
ASGNI4
line 3580
;3580:	refdef.height = h;
ADDRLP4 0+12
ADDRLP4 528
INDIRF4
CVFI4 4
ASGNI4
line 3582
;3581:
;3582:	DC->modelBounds( item->asset, mins, maxs );
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 544
ARGP4
ADDRLP4 556
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
CALLV
pop
line 3584
;3583:
;3584:	origin[2] = -0.5 * ( mins[2] + maxs[2] );
ADDRLP4 512+8
ADDRLP4 544+8
INDIRF4
ADDRLP4 556+8
INDIRF4
ADDF4
CNSTF4 3204448256
MULF4
ASGNF4
line 3585
;3585:	origin[1] = 0.5 * ( mins[1] + maxs[1] );
ADDRLP4 512+4
ADDRLP4 544+4
INDIRF4
ADDRLP4 556+4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3588
;3586:
;3587:	// calculate distance so the model nearly fills the box
;3588:	if (qtrue) {
line 3589
;3589:		float len = 0.5 * ( maxs[2] - mins[2] );		
ADDRLP4 576
ADDRLP4 556+8
INDIRF4
ADDRLP4 544+8
INDIRF4
SUBF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3590
;3590:		origin[0] = len / 0.268;	// len / tan( fov/2 )
ADDRLP4 512
ADDRLP4 576
INDIRF4
CNSTF4 1081003604
MULF4
ASGNF4
line 3592
;3591:		//origin[0] = len / tan(w/2);
;3592:	} else {
ADDRGP4 $1701
JUMPV
LABELV $1700
line 3593
;3593:		origin[0] = item->textscale;
ADDRLP4 512
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ASGNF4
line 3594
;3594:	}
LABELV $1701
line 3595
;3595:	refdef.fov_x = (modelPtr->fov_x) ? modelPtr->fov_x : w;
ADDRLP4 508
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1706
ADDRLP4 576
ADDRLP4 508
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ASGNF4
ADDRGP4 $1707
JUMPV
LABELV $1706
ADDRLP4 576
ADDRLP4 524
INDIRF4
ASGNF4
LABELV $1707
ADDRLP4 0+16
ADDRLP4 576
INDIRF4
ASGNF4
line 3596
;3596:	refdef.fov_y = (modelPtr->fov_y) ? modelPtr->fov_y : h;
ADDRLP4 508
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1710
ADDRLP4 580
ADDRLP4 508
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
ADDRGP4 $1711
JUMPV
LABELV $1710
ADDRLP4 580
ADDRLP4 528
INDIRF4
ASGNF4
LABELV $1711
ADDRLP4 0+20
ADDRLP4 580
INDIRF4
ASGNF4
line 3603
;3597:
;3598:	//refdef.fov_x = (int)((float)refdef.width / 640.0f * 90.0f);
;3599:	//xx = refdef.width / tan( refdef.fov_x / 360 * M_PI );
;3600:	//refdef.fov_y = atan2( refdef.height, xx );
;3601:	//refdef.fov_y *= ( 360 / M_PI );
;3602:
;3603:	DC->clearScene();
ADDRGP4 DC
INDIRP4
CNSTI4 52
ADDP4
INDIRP4
CALLV
pop
line 3605
;3604:
;3605:	refdef.time = DC->realTime;
ADDRLP4 0+72
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ASGNI4
line 3609
;3606:
;3607:	// add the model
;3608:
;3609:	memset( &ent, 0, sizeof(ent) );
ADDRLP4 368
ARGP4
CNSTI4 0
ARGI4
CNSTU4 140
ARGU4
ADDRGP4 memset
CALLP4
pop
line 3616
;3610:
;3611:	//adjust = 5.0 * sin( (float)uis.realtime / 500 );
;3612:	//adjust = 360 % (int)((float)uis.realtime / 1000);
;3613:	//VectorSet( angles, 0, 0, 1 );
;3614:
;3615:	// use item storage to track
;3616:	if (modelPtr->rotationSpeed) {
ADDRLP4 508
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1713
line 3617
;3617:		if (DC->realTime > item->window.nextTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
LEI4 $1715
line 3618
;3618:			item->window.nextTime = DC->realTime + modelPtr->rotationSpeed;
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 508
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ADDI4
ASGNI4
line 3619
;3619:			modelPtr->angle = (int)(modelPtr->angle + 1) % 360;
ADDRLP4 508
INDIRP4
ADDRLP4 508
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 360
MODI4
ASGNI4
line 3620
;3620:		}
LABELV $1715
line 3621
;3621:	}
LABELV $1713
line 3622
;3622:	VectorSet( angles, 0, modelPtr->angle, 0 );
ADDRLP4 532
CNSTF4 0
ASGNF4
ADDRLP4 532+4
ADDRLP4 508
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 532+8
CNSTF4 0
ASGNF4
line 3623
;3623:	AnglesToAxis( angles, ent.axis );
ADDRLP4 532
ARGP4
ADDRLP4 368+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 3625
;3624:
;3625:	ent.hModel = item->asset;
ADDRLP4 368+8
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ASGNI4
line 3626
;3626:	VectorCopy( origin, ent.origin );
ADDRLP4 368+68
ADDRLP4 512
INDIRB
ASGNB 12
line 3627
;3627:	VectorCopy( origin, ent.lightingOrigin );
ADDRLP4 368+12
ADDRLP4 512
INDIRB
ASGNB 12
line 3628
;3628:	ent.renderfx = RF_LIGHTING_ORIGIN | RF_NOSHADOW;
ADDRLP4 368+4
CNSTI4 192
ASGNI4
line 3629
;3629:	VectorCopy( ent.origin, ent.oldorigin );
ADDRLP4 368+84
ADDRLP4 368+68
INDIRB
ASGNB 12
line 3631
;3630:
;3631:	DC->addRefEntityToScene( &ent );
ADDRLP4 368
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 56
ADDP4
INDIRP4
CALLV
pop
line 3632
;3632:	DC->renderScene( &refdef );
ADDRLP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 60
ADDP4
INDIRP4
CALLV
pop
line 3634
;3633:
;3634:}
LABELV $1686
endproc Item_Model_Paint 588 16
export Item_Image_Paint
proc Item_Image_Paint 4 20
line 3637
;3635:
;3636:
;3637:void Item_Image_Paint(itemDef_t *item) {
line 3638
;3638:	if (item == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1727
line 3639
;3639:		return;
ADDRGP4 $1726
JUMPV
LABELV $1727
line 3641
;3640:	}
;3641:	DC->drawHandlePic(item->window.rect.x+1, item->window.rect.y+1, item->window.rect.w-2, item->window.rect.h-2, item->asset);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3642
;3642:}
LABELV $1726
endproc Item_Image_Paint 4 20
export Item_ListBox_Paint
proc Item_ListBox_Paint 92 32
line 3644
;3643:
;3644:void Item_ListBox_Paint(itemDef_t *item) {
line 3648
;3645:	float x, y, size, count, i, thumb;
;3646:	qhandle_t image;
;3647:	qhandle_t optionalImage;
;3648:	listBoxDef_t *listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 3654
;3649:
;3650:	// the listbox is horizontal or vertical and has a fixed size scroll bar going either direction
;3651:	// elements are enumerated from the DC and either text or image handles are acquired from the DC as well
;3652:	// textscale is used to size the text, textalignx and textaligny are used to size image elements
;3653:	// there is no clipping available so only the last completely visible item is painted
;3654:	count = DC->feederCount(item->special);
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 36
INDIRI4
CVIF4 4
ASGNF4
line 3656
;3655:	// default is vertical if horizontal flag is not here
;3656:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1730
line 3659
;3657:		// draw scrollbar in bottom of the window
;3658:		// bar
;3659:		x = item->window.rect.x + 1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3660
;3660:		y = item->window.rect.y + item->window.rect.h - SCROLLBAR_SIZE - 1;
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 3661
;3661:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarArrowLeft);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 44
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 61900
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3662
;3662:		x += SCROLLBAR_SIZE - 1;
ADDRLP4 16
ADDRLP4 16
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 3663
;3663:		size = item->window.rect.w - (SCROLLBAR_SIZE * 2);
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 3664
;3664:		DC->drawHandlePic(x, y, size+1, SCROLLBAR_SIZE, DC->Assets.scrollBar);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 48
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 61908
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3665
;3665:		x += size - 1;
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
CNSTF4 1065353216
SUBF4
ADDF4
ASGNF4
line 3666
;3666:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarArrowRight);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 52
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 61904
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3668
;3667:		// thumb
;3668:		thumb = Item_ListBox_ThumbDrawPosition(item);//Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 Item_ListBox_ThumbDrawPosition
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 56
INDIRI4
CVIF4 4
ASGNF4
line 3669
;3669:		if (thumb > x - SCROLLBAR_SIZE - 1) {
ADDRLP4 32
INDIRF4
ADDRLP4 16
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
LEF4 $1732
line 3670
;3670:			thumb = x - SCROLLBAR_SIZE - 1;
ADDRLP4 32
ADDRLP4 16
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 3671
;3671:		}
LABELV $1732
line 3672
;3672:		DC->drawHandlePic(thumb, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarThumb);
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 60
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 61912
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3674
;3673:		//
;3674:		listPtr->endPos = listPtr->startPos;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 3675
;3675:		size = item->window.rect.w - 2;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 3678
;3676:		// items
;3677:		// size contains max available space
;3678:		if (listPtr->elementStyle == LISTBOX_IMAGE) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1731
line 3680
;3679:			// fit = 0;
;3680:			x = item->window.rect.x + 1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3681
;3681:			y = item->window.rect.y + 1;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3682
;3682:			for (i = listPtr->startPos; i < count; i++) {
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
ADDRGP4 $1739
JUMPV
LABELV $1736
line 3685
;3683:				// always draw at least one
;3684:				// which may overdraw the box if it is too small for the element
;3685:				image = DC->feederItemImage(item->special, i);
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 68
ADDRGP4 DC
INDIRP4
CNSTI4 128
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 68
INDIRI4
ASGNI4
line 3686
;3686:				if (image) {
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $1740
line 3687
;3687:					DC->drawHandlePic(x+1, y+1, listPtr->elementWidth - 2, listPtr->elementHeight - 2, image);
ADDRLP4 16
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ARGF4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3688
;3688:				}
LABELV $1740
line 3690
;3689:
;3690:				if (i == item->cursorPos) {
ADDRLP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CVIF4 4
NEF4 $1742
line 3691
;3691:					DC->drawRect(x, y, listPtr->elementWidth-1, listPtr->elementHeight-1, item->window.borderSize, item->window.borderColor);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CNSTF4 1065353216
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1065353216
SUBF4
ARGF4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ARGF4
ADDRLP4 76
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 3692
;3692:				}
LABELV $1742
line 3694
;3693:
;3694:				size -= listPtr->elementWidth;
ADDRLP4 20
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3695
;3695:				if (size < listPtr->elementWidth) {
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
GEF4 $1744
line 3696
;3696:					listPtr->drawPadding = size; //listPtr->elementWidth - size;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 20
INDIRF4
CVFI4 4
ASGNI4
line 3697
;3697:					break;
ADDRGP4 $1731
JUMPV
LABELV $1744
line 3699
;3698:				}
;3699:				x += listPtr->elementWidth;
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3700
;3700:				listPtr->endPos++;
ADDRLP4 72
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3702
;3701:				// fit++;
;3702:			}
LABELV $1737
line 3682
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $1739
ADDRLP4 4
INDIRF4
ADDRLP4 28
INDIRF4
LTF4 $1736
line 3703
;3703:		} else {
line 3705
;3704:			//
;3705:		}
line 3706
;3706:	} else {
ADDRGP4 $1731
JUMPV
LABELV $1730
line 3708
;3707:		// draw scrollbar to right side of the window
;3708:		x = item->window.rect.x + item->window.rect.w - SCROLLBAR_SIZE - 1;
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 40
INDIRP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 3709
;3709:		y = item->window.rect.y + 1;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3710
;3710:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarArrowUp);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 44
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 61892
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3711
;3711:		y += SCROLLBAR_SIZE - 1;
ADDRLP4 12
ADDRLP4 12
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 3713
;3712:
;3713:		listPtr->endPos = listPtr->startPos;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 3714
;3714:		size = item->window.rect.h - (SCROLLBAR_SIZE * 2);
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 3715
;3715:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, size+1, DC->Assets.scrollBar);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 20
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 52
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 61908
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3716
;3716:		y += size - 1;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 20
INDIRF4
CNSTF4 1065353216
SUBF4
ADDF4
ASGNF4
line 3717
;3717:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarArrowDown);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 56
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 61896
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3719
;3718:		// thumb
;3719:		thumb = Item_ListBox_ThumbDrawPosition(item);//Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 Item_ListBox_ThumbDrawPosition
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 60
INDIRI4
CVIF4 4
ASGNF4
line 3720
;3720:		if (thumb > y - SCROLLBAR_SIZE - 1) {
ADDRLP4 32
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
LEF4 $1746
line 3721
;3721:			thumb = y - SCROLLBAR_SIZE - 1;
ADDRLP4 32
ADDRLP4 12
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 3722
;3722:		}
LABELV $1746
line 3723
;3723:		DC->drawHandlePic(x, thumb, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarThumb);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 64
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 61912
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3726
;3724:
;3725:		// adjust size for item painting
;3726:		size = item->window.rect.h - 2;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 3727
;3727:		if (listPtr->elementStyle == LISTBOX_IMAGE) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1748
line 3729
;3728:			// fit = 0;
;3729:			x = item->window.rect.x + 1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3730
;3730:			y = item->window.rect.y + 1;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3731
;3731:			for (i = listPtr->startPos; i < count; i++) {
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
ADDRGP4 $1753
JUMPV
LABELV $1750
line 3734
;3732:				// always draw at least one
;3733:				// which may overdraw the box if it is too small for the element
;3734:				image = DC->feederItemImage(item->special, i);
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 68
ADDRGP4 DC
INDIRP4
CNSTI4 128
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 68
INDIRI4
ASGNI4
line 3735
;3735:				if (image) {
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $1754
line 3736
;3736:					DC->drawHandlePic(x+1, y+1, listPtr->elementWidth - 2, listPtr->elementHeight - 2, image);
ADDRLP4 16
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ARGF4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3737
;3737:				}
LABELV $1754
line 3739
;3738:
;3739:				if (i == item->cursorPos) {
ADDRLP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CVIF4 4
NEF4 $1756
line 3740
;3740:					DC->drawRect(x, y, listPtr->elementWidth - 1, listPtr->elementHeight - 1, item->window.borderSize, item->window.borderColor);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CNSTF4 1065353216
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1065353216
SUBF4
ARGF4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ARGF4
ADDRLP4 76
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 3741
;3741:				}
LABELV $1756
line 3743
;3742:
;3743:				listPtr->endPos++;
ADDRLP4 72
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3744
;3744:				size -= listPtr->elementWidth;
ADDRLP4 20
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3745
;3745:				if (size < listPtr->elementHeight) {
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
GEF4 $1758
line 3746
;3746:					listPtr->drawPadding = listPtr->elementHeight - size;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
CVFI4 4
ASGNI4
line 3747
;3747:					break;
ADDRGP4 $1749
JUMPV
LABELV $1758
line 3749
;3748:				}
;3749:				y += listPtr->elementHeight;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3751
;3750:				// fit++;
;3751:			}
LABELV $1751
line 3731
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $1753
ADDRLP4 4
INDIRF4
ADDRLP4 28
INDIRF4
LTF4 $1750
line 3752
;3752:		} else {
ADDRGP4 $1749
JUMPV
LABELV $1748
line 3753
;3753:			x = item->window.rect.x + 1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3754
;3754:			y = item->window.rect.y + 1;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3755
;3755:			for (i = listPtr->startPos; i < count; i++) {
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
ADDRGP4 $1763
JUMPV
LABELV $1760
line 3760
;3756:				const char *text;
;3757:				// always draw at least one
;3758:				// which may overdraw the box if it is too small for the element
;3759:
;3760:				if (listPtr->numColumns > 0) {
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1764
line 3762
;3761:					int j;
;3762:					for (j = 0; j < listPtr->numColumns; j++) {
ADDRLP4 72
CNSTI4 0
ASGNI4
ADDRGP4 $1769
JUMPV
LABELV $1766
line 3763
;3763:						text = DC->feederItemText(item->special, i, j, &optionalImage);
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 76
ADDRGP4 DC
INDIRP4
CNSTI4 124
ADDP4
INDIRP4
CALLP4
ASGNP4
ADDRLP4 68
ADDRLP4 76
INDIRP4
ASGNP4
line 3764
;3764:						if (optionalImage >= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $1770
line 3765
;3765:							DC->drawHandlePic(x + 4 + listPtr->columnInfo[j].pos, y - 1 + listPtr->elementHeight / 2, listPtr->columnInfo[j].width, listPtr->columnInfo[j].width, optionalImage);
ADDRLP4 16
INDIRF4
CNSTF4 1082130432
ADDF4
ADDRLP4 72
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ADDP4
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
CNSTF4 1065353216
SUBF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1056964608
MULF4
ADDF4
ARGF4
ADDRLP4 72
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 72
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3766
;3766:						} else if (text) {
ADDRGP4 $1771
JUMPV
LABELV $1770
ADDRLP4 68
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1772
line 3767
;3767:							DC->drawText(x + 4 + listPtr->columnInfo[j].pos, y + listPtr->elementHeight, item->textscale, item->window.foreColor, text, 0, listPtr->columnInfo[j].maxChars, item->textStyle);
ADDRLP4 16
INDIRF4
CNSTF4 1082130432
ADDF4
ADDRLP4 72
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ADDP4
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 88
INDIRP4
CNSTI4 112
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 72
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ADDP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3768
;3768:						}
LABELV $1772
LABELV $1771
line 3769
;3769:					}
LABELV $1767
line 3762
ADDRLP4 72
ADDRLP4 72
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1769
ADDRLP4 72
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
LTI4 $1766
line 3770
;3770:				} else {
ADDRGP4 $1765
JUMPV
LABELV $1764
line 3771
;3771:					text = DC->feederItemText(item->special, i, 0, &optionalImage);
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
CVFI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 72
ADDRGP4 DC
INDIRP4
CNSTI4 124
ADDP4
INDIRP4
CALLP4
ASGNP4
ADDRLP4 68
ADDRLP4 72
INDIRP4
ASGNP4
line 3772
;3772:					if (optionalImage >= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $1774
line 3774
;3773:						//DC->drawHandlePic(x + 4 + listPtr->elementHeight, y, listPtr->columnInfo[j].width, listPtr->columnInfo[j].width, optionalImage);
;3774:					} else if (text) {
ADDRGP4 $1775
JUMPV
LABELV $1774
ADDRLP4 68
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1776
line 3775
;3775:						DC->drawText(x + 4, y + listPtr->elementHeight, item->textscale, item->window.foreColor, text, 0, 0, item->textStyle);
ADDRLP4 16
INDIRF4
CNSTF4 1082130432
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 76
INDIRP4
CNSTI4 112
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 76
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3776
;3776:					}
LABELV $1776
LABELV $1775
line 3777
;3777:				}
LABELV $1765
line 3779
;3778:
;3779:				if (i == item->cursorPos) {
ADDRLP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CVIF4 4
NEF4 $1778
line 3780
;3780:					DC->fillRect(x + 2, y + 2, item->window.rect.w - SCROLLBAR_SIZE - 4, listPtr->elementHeight, item->window.outlineColor);
ADDRLP4 16
INDIRF4
CNSTF4 1073741824
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
CNSTF4 1073741824
ADDF4
ARGF4
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
CALLV
pop
line 3781
;3781:				}
LABELV $1778
line 3783
;3782:
;3783:				size -= listPtr->elementHeight;
ADDRLP4 20
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3784
;3784:				if (size < listPtr->elementHeight) {
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
GEF4 $1780
line 3785
;3785:					listPtr->drawPadding = listPtr->elementHeight - size;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
CVFI4 4
ASGNI4
line 3786
;3786:					break;
ADDRGP4 $1762
JUMPV
LABELV $1780
line 3788
;3787:				}
;3788:				listPtr->endPos++;
ADDRLP4 72
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3789
;3789:				y += listPtr->elementHeight;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3791
;3790:				// fit++;
;3791:			}
LABELV $1761
line 3755
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $1763
ADDRLP4 4
INDIRF4
ADDRLP4 28
INDIRF4
LTF4 $1760
LABELV $1762
line 3792
;3792:		}
LABELV $1749
line 3793
;3793:	}
LABELV $1731
line 3794
;3794:}
LABELV $1729
endproc Item_ListBox_Paint 92 32
export Item_OwnerDraw_Paint
proc Item_OwnerDraw_Paint 72 56
line 3797
;3795:
;3796:
;3797:void Item_OwnerDraw_Paint(itemDef_t *item) {
line 3800
;3798:  menuDef_t *parent;
;3799:
;3800:	if (item == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1783
line 3801
;3801:		return;
ADDRGP4 $1782
JUMPV
LABELV $1783
line 3803
;3802:	}
;3803:  parent = (menuDef_t*)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3805
;3804:
;3805:	if (DC->ownerDrawItem) {
ADDRGP4 DC
INDIRP4
CNSTI4 68
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1785
line 3807
;3806:		vec4_t color, lowLight;
;3807:		menuDef_t *parent = (menuDef_t*)item->parent;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3808
;3808:		Fade(&item->window.flags, &item->window.foreColor[3], parent->fadeClamp, &item->window.nextTime, parent->fadeCycle, qtrue, parent->fadeAmount);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 68
ADDP4
ARGP4
ADDRLP4 40
INDIRP4
CNSTI4 124
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 204
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 108
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 20
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ARGF4
ADDRGP4 Fade
CALLV
pop
line 3809
;3809:		memcpy(&color, &item->window.foreColor, sizeof(color));
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTU4 16
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 3810
;3810:		if (item->numColors > 0 && DC->getValue) {
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1787
ADDRGP4 DC
INDIRP4
CNSTI4 72
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1787
line 3813
;3811:			// if the value is within one of the ranges then set color to that, otherwise leave at default
;3812:			int i;
;3813:			float f = DC->getValue(item->window.ownerDraw);
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 DC
INDIRP4
CNSTI4 72
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 52
ADDRLP4 56
INDIRF4
ASGNF4
line 3814
;3814:			for (i = 0; i < item->numColors; i++) {
ADDRLP4 48
CNSTI4 0
ASGNI4
ADDRGP4 $1792
JUMPV
LABELV $1789
line 3815
;3815:				if (f >= item->colorRanges[i].low && f <= item->colorRanges[i].high) {
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRF4
ADDRLP4 48
INDIRI4
CNSTI4 24
MULI4
ADDRLP4 68
INDIRP4
CNSTI4 288
ADDP4
ADDP4
CNSTI4 16
ADDP4
INDIRF4
LTF4 $1793
ADDRLP4 52
INDIRF4
ADDRLP4 48
INDIRI4
CNSTI4 24
MULI4
ADDRLP4 68
INDIRP4
CNSTI4 288
ADDP4
ADDP4
CNSTI4 20
ADDP4
INDIRF4
GTF4 $1793
line 3816
;3816:					memcpy(&color, &item->colorRanges[i].color, sizeof(color));
ADDRLP4 4
ARGP4
ADDRLP4 48
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDP4
ARGP4
CNSTU4 16
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 3817
;3817:					break;
ADDRGP4 $1791
JUMPV
LABELV $1793
line 3819
;3818:				}
;3819:			}
LABELV $1790
line 3814
ADDRLP4 48
ADDRLP4 48
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1792
ADDRLP4 48
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
LTI4 $1789
LABELV $1791
line 3820
;3820:		}
LABELV $1787
line 3822
;3821:
;3822:		if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1795
line 3823
;3823:			lowLight[0] = 0.8 * parent->focusColor[0]; 
ADDRLP4 24
ADDRLP4 20
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3824
;3824:			lowLight[1] = 0.8 * parent->focusColor[1]; 
ADDRLP4 24+4
ADDRLP4 20
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3825
;3825:			lowLight[2] = 0.8 * parent->focusColor[2]; 
ADDRLP4 24+8
ADDRLP4 20
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3826
;3826:			lowLight[3] = 0.8 * parent->focusColor[3]; 
ADDRLP4 24+12
ADDRLP4 20
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3827
;3827:			LerpColor(parent->focusColor,lowLight,color,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 48
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 20
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 48
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3828
;3828:		} else if (item->textStyle == ITEM_TEXTSTYLE_BLINK && !((DC->realTime/BLINK_DIVISOR) & 1)) {
ADDRGP4 $1796
JUMPV
LABELV $1795
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1800
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 200
DIVI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $1800
line 3829
;3829:			lowLight[0] = 0.8 * item->window.foreColor[0]; 
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3830
;3830:			lowLight[1] = 0.8 * item->window.foreColor[1]; 
ADDRLP4 24+4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3831
;3831:			lowLight[2] = 0.8 * item->window.foreColor[2]; 
ADDRLP4 24+8
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3832
;3832:			lowLight[3] = 0.8 * item->window.foreColor[3]; 
ADDRLP4 24+12
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3833
;3833:			LerpColor(item->window.foreColor,lowLight,color,0.5+0.5*sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 48
ADDRGP4 sin
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 48
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3834
;3834:		}
LABELV $1800
LABELV $1796
line 3836
;3835:
;3836:		if (item->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(item, CVAR_ENABLE)) {
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $1805
ADDRLP4 48
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 52
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $1805
line 3837
;3837:		  memcpy(color, parent->disableColor, sizeof(vec4_t)); // bk001207 - FIXME: Com_Memcpy
ADDRLP4 4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 244
ADDP4
ARGP4
CNSTU4 16
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 3838
;3838:		}
LABELV $1805
line 3840
;3839:	
;3840:		if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1807
line 3841
;3841:			Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3842
;3842:				if (item->text[0]) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1809
line 3844
;3843:					// +8 is an offset kludge to properly align owner draw items that have text combined with them
;3844:					DC->ownerDrawItem(item->textRect.x + item->textRect.w + 8, item->window.rect.y, item->window.rect.w, item->window.rect.h, 0, item->textaligny, item->window.ownerDraw, item->window.ownerDrawFlags, item->alignment, item->special, item->textscale, color, item->window.background, item->textStyle );
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
ARGP4
ADDRLP4 56
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 68
ADDP4
INDIRP4
CALLV
pop
line 3845
;3845:				} else {
ADDRGP4 $1808
JUMPV
LABELV $1809
line 3846
;3846:					DC->ownerDrawItem(item->textRect.x + item->textRect.w, item->window.rect.y, item->window.rect.w, item->window.rect.h, 0, item->textaligny, item->window.ownerDraw, item->window.ownerDrawFlags, item->alignment, item->special, item->textscale, color, item->window.background, item->textStyle );
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
ARGP4
ADDRLP4 56
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 68
ADDP4
INDIRP4
CALLV
pop
line 3847
;3847:				}
line 3848
;3848:			} else {
ADDRGP4 $1808
JUMPV
LABELV $1807
line 3849
;3849:			DC->ownerDrawItem(item->window.rect.x, item->window.rect.y, item->window.rect.w, item->window.rect.h, item->textalignx, item->textaligny, item->window.ownerDraw, item->window.ownerDrawFlags, item->alignment, item->special, item->textscale, color, item->window.background, item->textStyle );
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
ARGP4
ADDRLP4 56
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 68
ADDP4
INDIRP4
CALLV
pop
line 3850
;3850:		}
LABELV $1808
line 3851
;3851:	}
LABELV $1785
line 3852
;3852:}
LABELV $1782
endproc Item_OwnerDraw_Paint 72 56
export Item_Paint
proc Item_Paint 84 24
line 3855
;3853:
;3854:
;3855:void Item_Paint(itemDef_t *item) {
line 3857
;3856:  vec4_t red;
;3857:  menuDef_t *parent = (menuDef_t*)item->parent;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3858
;3858:  red[0] = red[3] = 1;
ADDRLP4 20
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+12
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 3859
;3859:  red[1] = red[2] = 0;
ADDRLP4 24
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 24
INDIRF4
ASGNF4
line 3861
;3860:
;3861:  if (item == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1815
line 3862
;3862:    return;
ADDRGP4 $1811
JUMPV
LABELV $1815
line 3865
;3863:  }
;3864:
;3865:  if (item->window.flags & WINDOW_ORBITING) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 65536
BANDI4
CNSTI4 0
EQI4 $1817
line 3866
;3866:    if (DC->realTime > item->window.nextTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
LEI4 $1819
line 3869
;3867:      float rx, ry, a, c, s, w, h;
;3868:      
;3869:      item->window.nextTime = DC->realTime + item->window.offsetTime;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 108
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 56
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ADDI4
ASGNI4
line 3871
;3870:      // translate
;3871:      w = item->window.rectClient.w / 2;
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3872
;3872:      h = item->window.rectClient.h / 2;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3873
;3873:      rx = item->window.rectClient.x + w - item->window.rectEffects.x;
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 60
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 48
INDIRF4
ADDF4
ADDRLP4 60
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3874
;3874:      ry = item->window.rectClient.y + h - item->window.rectEffects.y;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 64
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 52
INDIRF4
ADDF4
ADDRLP4 64
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3875
;3875:      a = 3 * M_PI / 180;
ADDRLP4 36
CNSTF4 1029076816
ASGNF4
line 3876
;3876:  	  c = cos(a);
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 68
INDIRF4
ASGNF4
line 3877
;3877:      s = sin(a);
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 72
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 72
INDIRF4
ASGNF4
line 3878
;3878:      item->window.rectClient.x = (rx * c - ry * s) + item->window.rectEffects.x - w;
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 28
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ADDRLP4 32
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
SUBF4
ADDRLP4 76
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ADDF4
ADDRLP4 48
INDIRF4
SUBF4
ASGNF4
line 3879
;3879:      item->window.rectClient.y = (rx * s + ry * c) + item->window.rectEffects.y - h;
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 28
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ADDRLP4 32
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ADDF4
ADDRLP4 80
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ADDF4
ADDRLP4 52
INDIRF4
SUBF4
ASGNF4
line 3880
;3880:      Item_UpdatePosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_UpdatePosition
CALLV
pop
line 3882
;3881:
;3882:    }
LABELV $1819
line 3883
;3883:  }
LABELV $1817
line 3886
;3884:
;3885:
;3886:  if (item->window.flags & WINDOW_INTRANSITION) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $1821
line 3887
;3887:    if (DC->realTime > item->window.nextTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
LEI4 $1823
line 3888
;3888:      int done = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 3889
;3889:      item->window.nextTime = DC->realTime + item->window.offsetTime;
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 108
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ADDI4
ASGNI4
line 3891
;3890:			// transition the x,y
;3891:			if (item->window.rectClient.x == item->window.rectEffects.x) {
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
NEF4 $1825
line 3892
;3892:				done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3893
;3893:			} else {
ADDRGP4 $1826
JUMPV
LABELV $1825
line 3894
;3894:				if (item->window.rectClient.x < item->window.rectEffects.x) {
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
GEF4 $1827
line 3895
;3895:					item->window.rectClient.x += item->window.rectEffects2.x;
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
ADDRLP4 44
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 88
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3896
;3896:					if (item->window.rectClient.x > item->window.rectEffects.x) {
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
LEF4 $1828
line 3897
;3897:						item->window.rectClient.x = item->window.rectEffects.x;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ASGNF4
line 3898
;3898:						done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3899
;3899:					}
line 3900
;3900:				} else {
ADDRGP4 $1828
JUMPV
LABELV $1827
line 3901
;3901:					item->window.rectClient.x -= item->window.rectEffects2.x;
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
ADDRLP4 44
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 88
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3902
;3902:					if (item->window.rectClient.x < item->window.rectEffects.x) {
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
GEF4 $1831
line 3903
;3903:						item->window.rectClient.x = item->window.rectEffects.x;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ASGNF4
line 3904
;3904:						done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3905
;3905:					}
LABELV $1831
line 3906
;3906:				}
LABELV $1828
line 3907
;3907:			}
LABELV $1826
line 3908
;3908:			if (item->window.rectClient.y == item->window.rectEffects.y) {
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
NEF4 $1833
line 3909
;3909:				done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3910
;3910:			} else {
ADDRGP4 $1834
JUMPV
LABELV $1833
line 3911
;3911:				if (item->window.rectClient.y < item->window.rectEffects.y) {
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
GEF4 $1835
line 3912
;3912:					item->window.rectClient.y += item->window.rectEffects2.y;
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
ADDRLP4 48
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3913
;3913:					if (item->window.rectClient.y > item->window.rectEffects.y) {
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
LEF4 $1836
line 3914
;3914:						item->window.rectClient.y = item->window.rectEffects.y;
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ASGNF4
line 3915
;3915:						done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3916
;3916:					}
line 3917
;3917:				} else {
ADDRGP4 $1836
JUMPV
LABELV $1835
line 3918
;3918:					item->window.rectClient.y -= item->window.rectEffects2.y;
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
ADDRLP4 48
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3919
;3919:					if (item->window.rectClient.y < item->window.rectEffects.y) {
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
GEF4 $1839
line 3920
;3920:						item->window.rectClient.y = item->window.rectEffects.y;
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ASGNF4
line 3921
;3921:						done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3922
;3922:					}
LABELV $1839
line 3923
;3923:				}
LABELV $1836
line 3924
;3924:			}
LABELV $1834
line 3925
;3925:			if (item->window.rectClient.w == item->window.rectEffects.w) {
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
NEF4 $1841
line 3926
;3926:				done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3927
;3927:			} else {
ADDRGP4 $1842
JUMPV
LABELV $1841
line 3928
;3928:				if (item->window.rectClient.w < item->window.rectEffects.w) {
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
GEF4 $1843
line 3929
;3929:					item->window.rectClient.w += item->window.rectEffects2.w;
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 52
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3930
;3930:					if (item->window.rectClient.w > item->window.rectEffects.w) {
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
LEF4 $1844
line 3931
;3931:						item->window.rectClient.w = item->window.rectEffects.w;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ASGNF4
line 3932
;3932:						done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3933
;3933:					}
line 3934
;3934:				} else {
ADDRGP4 $1844
JUMPV
LABELV $1843
line 3935
;3935:					item->window.rectClient.w -= item->window.rectEffects2.w;
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 52
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3936
;3936:					if (item->window.rectClient.w < item->window.rectEffects.w) {
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
GEF4 $1847
line 3937
;3937:						item->window.rectClient.w = item->window.rectEffects.w;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ASGNF4
line 3938
;3938:						done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3939
;3939:					}
LABELV $1847
line 3940
;3940:				}
LABELV $1844
line 3941
;3941:			}
LABELV $1842
line 3942
;3942:			if (item->window.rectClient.h == item->window.rectEffects.h) {
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
NEF4 $1849
line 3943
;3943:				done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3944
;3944:			} else {
ADDRGP4 $1850
JUMPV
LABELV $1849
line 3945
;3945:				if (item->window.rectClient.h < item->window.rectEffects.h) {
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
GEF4 $1851
line 3946
;3946:					item->window.rectClient.h += item->window.rectEffects2.h;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
ADDRLP4 56
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3947
;3947:					if (item->window.rectClient.h > item->window.rectEffects.h) {
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
LEF4 $1852
line 3948
;3948:						item->window.rectClient.h = item->window.rectEffects.h;
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
ASGNF4
line 3949
;3949:						done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3950
;3950:					}
line 3951
;3951:				} else {
ADDRGP4 $1852
JUMPV
LABELV $1851
line 3952
;3952:					item->window.rectClient.h -= item->window.rectEffects2.h;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
ADDRLP4 56
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3953
;3953:					if (item->window.rectClient.h < item->window.rectEffects.h) {
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
GEF4 $1855
line 3954
;3954:						item->window.rectClient.h = item->window.rectEffects.h;
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
ASGNF4
line 3955
;3955:						done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3956
;3956:					}
LABELV $1855
line 3957
;3957:				}
LABELV $1852
line 3958
;3958:			}
LABELV $1850
line 3960
;3959:
;3960:      Item_UpdatePosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_UpdatePosition
CALLV
pop
line 3962
;3961:
;3962:      if (done == 4) {
ADDRLP4 28
INDIRI4
CNSTI4 4
NEI4 $1857
line 3963
;3963:        item->window.flags &= ~WINDOW_INTRANSITION;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 3964
;3964:      }
LABELV $1857
line 3966
;3965:
;3966:    }
LABELV $1823
line 3967
;3967:  }
LABELV $1821
line 3969
;3968:
;3969:	if (item->window.ownerDrawFlags && DC->ownerDrawVisible) {
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1859
ADDRGP4 DC
INDIRP4
CNSTI4 76
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1859
line 3970
;3970:		if (!DC->ownerDrawVisible(item->window.ownerDrawFlags)) {
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 DC
INDIRP4
CNSTI4 76
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $1861
line 3971
;3971:			item->window.flags &= ~WINDOW_VISIBLE;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 -5
BANDI4
ASGNI4
line 3972
;3972:		} else {
ADDRGP4 $1862
JUMPV
LABELV $1861
line 3973
;3973:			item->window.flags |= WINDOW_VISIBLE;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 3974
;3974:		}
LABELV $1862
line 3975
;3975:	}
LABELV $1859
line 3977
;3976:
;3977:	if (item->cvarFlags & (CVAR_SHOW | CVAR_HIDE)) {
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 12
BANDI4
CNSTI4 0
EQI4 $1863
line 3978
;3978:		if (!Item_EnableShowViaCvar(item, CVAR_SHOW)) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 28
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $1865
line 3979
;3979:			return;
ADDRGP4 $1811
JUMPV
LABELV $1865
line 3981
;3980:		}
;3981:	}
LABELV $1863
line 3983
;3982:
;3983:  if (item->window.flags & WINDOW_TIMEDVISIBLE) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 8388608
BANDI4
CNSTI4 0
EQI4 $1867
line 3985
;3984:
;3985:	}
LABELV $1867
line 3987
;3986:
;3987:  if (!(item->window.flags & WINDOW_VISIBLE)) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $1869
line 3988
;3988:    return;
ADDRGP4 $1811
JUMPV
LABELV $1869
line 3992
;3989:  }
;3990:
;3991:  // paint the rect first.. 
;3992:  Window_Paint(&item->window, parent->fadeAmount , parent->fadeClamp, parent->fadeCycle);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 204
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 Window_Paint
CALLV
pop
line 3994
;3993:
;3994:  if (debugMode) {
ADDRGP4 debugMode
INDIRI4
CNSTI4 0
EQI4 $1871
line 3996
;3995:		vec4_t color;
;3996:		rectDef_t *r = Item_CorrectedTextRect(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 Item_CorrectedTextRect
CALLP4
ASGNP4
ADDRLP4 32
ADDRLP4 52
INDIRP4
ASGNP4
line 3997
;3997:    color[1] = color[3] = 1;
ADDRLP4 56
CNSTF4 1065353216
ASGNF4
ADDRLP4 36+12
ADDRLP4 56
INDIRF4
ASGNF4
ADDRLP4 36+4
ADDRLP4 56
INDIRF4
ASGNF4
line 3998
;3998:    color[0] = color[2] = 0;
ADDRLP4 60
CNSTF4 0
ASGNF4
ADDRLP4 36+8
ADDRLP4 60
INDIRF4
ASGNF4
ADDRLP4 36
ADDRLP4 60
INDIRF4
ASGNF4
line 3999
;3999:    DC->drawRect(r->x, r->y, r->w, r->h, 1, color);
ADDRLP4 32
INDIRP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 36
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 4000
;4000:  }
LABELV $1871
line 4004
;4001:
;4002:  //DC->drawRect(item->window.rect.x, item->window.rect.y, item->window.rect.w, item->window.rect.h, 1, red);
;4003:
;4004:  switch (item->type) {
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
LTI4 $1877
ADDRLP4 32
INDIRI4
CNSTI4 13
GTI4 $1877
ADDRLP4 32
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1891
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1891
address $1880
address $1880
address $1877
address $1877
address $1883
address $1877
address $1885
address $1886
address $1879
address $1883
address $1890
address $1887
address $1888
address $1889
code
LABELV $1879
line 4006
;4005:    case ITEM_TYPE_OWNERDRAW:
;4006:      Item_OwnerDraw_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_OwnerDraw_Paint
CALLV
pop
line 4007
;4007:      break;
ADDRGP4 $1877
JUMPV
LABELV $1880
line 4010
;4008:    case ITEM_TYPE_TEXT:
;4009:    case ITEM_TYPE_BUTTON:
;4010:      Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 4011
;4011:      break;
ADDRGP4 $1877
JUMPV
line 4013
;4012:    case ITEM_TYPE_RADIOBUTTON:
;4013:      break;
line 4015
;4014:    case ITEM_TYPE_CHECKBOX:
;4015:      break;
LABELV $1883
line 4018
;4016:    case ITEM_TYPE_EDITFIELD:
;4017:    case ITEM_TYPE_NUMERICFIELD:
;4018:      Item_TextField_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_TextField_Paint
CALLV
pop
line 4019
;4019:      break;
ADDRGP4 $1877
JUMPV
line 4021
;4020:    case ITEM_TYPE_COMBO:
;4021:      break;
LABELV $1885
line 4023
;4022:    case ITEM_TYPE_LISTBOX:
;4023:      Item_ListBox_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ListBox_Paint
CALLV
pop
line 4024
;4024:      break;
ADDRGP4 $1877
JUMPV
LABELV $1886
line 4029
;4025:    //case ITEM_TYPE_IMAGE:
;4026:    //  Item_Image_Paint(item);
;4027:    //  break;
;4028:    case ITEM_TYPE_MODEL:
;4029:      Item_Model_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Model_Paint
CALLV
pop
line 4030
;4030:      break;
ADDRGP4 $1877
JUMPV
LABELV $1887
line 4032
;4031:    case ITEM_TYPE_YESNO:
;4032:      Item_YesNo_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_YesNo_Paint
CALLV
pop
line 4033
;4033:      break;
ADDRGP4 $1877
JUMPV
LABELV $1888
line 4035
;4034:    case ITEM_TYPE_MULTI:
;4035:      Item_Multi_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Multi_Paint
CALLV
pop
line 4036
;4036:      break;
ADDRGP4 $1877
JUMPV
LABELV $1889
line 4038
;4037:    case ITEM_TYPE_BIND:
;4038:      Item_Bind_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Bind_Paint
CALLV
pop
line 4039
;4039:      break;
ADDRGP4 $1877
JUMPV
LABELV $1890
line 4041
;4040:    case ITEM_TYPE_SLIDER:
;4041:      Item_Slider_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Slider_Paint
CALLV
pop
line 4042
;4042:      break;
line 4044
;4043:    default:
;4044:      break;
LABELV $1877
line 4047
;4045:  }
;4046:
;4047:}
LABELV $1811
endproc Item_Paint 84 24
export Menu_Init
proc Menu_Init 0 12
line 4049
;4048:
;4049:void Menu_Init(menuDef_t *menu) {
line 4050
;4050:	memset(menu, 0, sizeof(menuDef_t));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 644
ARGU4
ADDRGP4 memset
CALLP4
pop
line 4051
;4051:	menu->cursorItem = -1;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 -1
ASGNI4
line 4052
;4052:	menu->fadeAmount = DC->Assets.fadeAmount;
ADDRFP4 0
INDIRP4
CNSTI4 208
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 61960
ADDP4
INDIRF4
ASGNF4
line 4053
;4053:	menu->fadeClamp = DC->Assets.fadeClamp;
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 61952
ADDP4
INDIRF4
ASGNF4
line 4054
;4054:	menu->fadeCycle = DC->Assets.fadeCycle;
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 61956
ADDP4
INDIRI4
ASGNI4
line 4055
;4055:	Window_Init(&menu->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_Init
CALLV
pop
line 4056
;4056:}
LABELV $1892
endproc Menu_Init 0 12
export Menu_GetFocusedItem
proc Menu_GetFocusedItem 4 0
line 4058
;4057:
;4058:itemDef_t *Menu_GetFocusedItem(menuDef_t *menu) {
line 4060
;4059:  int i;
;4060:  if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1894
line 4061
;4061:    for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1899
JUMPV
LABELV $1896
line 4062
;4062:      if (menu->items[i]->window.flags & WINDOW_HASFOCUS) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1900
line 4063
;4063:        return menu->items[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $1893
JUMPV
LABELV $1900
line 4065
;4064:      }
;4065:    }
LABELV $1897
line 4061
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1899
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1896
line 4066
;4066:  }
LABELV $1894
line 4067
;4067:  return NULL;
CNSTP4 0
RETP4
LABELV $1893
endproc Menu_GetFocusedItem 4 0
export Menu_GetFocused
proc Menu_GetFocused 8 0
line 4070
;4068:}
;4069:
;4070:menuDef_t *Menu_GetFocused(void) {
line 4072
;4071:  int i;
;4072:  for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1906
JUMPV
LABELV $1903
line 4073
;4073:    if (Menus[i].window.flags & WINDOW_HASFOCUS && Menus[i].window.flags & WINDOW_VISIBLE) {
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus+68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1907
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus+68
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1907
line 4074
;4074:      return &Menus[i];
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
RETP4
ADDRGP4 $1902
JUMPV
LABELV $1907
line 4076
;4075:    }
;4076:  }
LABELV $1904
line 4072
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1906
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $1903
line 4077
;4077:  return NULL;
CNSTP4 0
RETP4
LABELV $1902
endproc Menu_GetFocused 8 0
export Menu_ScrollFeeder
proc Menu_ScrollFeeder 8 16
line 4080
;4078:}
;4079:
;4080:void Menu_ScrollFeeder(menuDef_t *menu, int feeder, qboolean down) {
line 4081
;4081:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1912
line 4083
;4082:		int i;
;4083:    for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1917
JUMPV
LABELV $1914
line 4084
;4084:			if (menu->items[i]->special == feeder) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ADDRFP4 4
INDIRI4
CVIF4 4
NEF4 $1918
line 4085
;4085:				Item_ListBox_HandleKey(menu->items[i], (down) ? K_DOWNARROW : K_UPARROW, qtrue, qtrue);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1921
ADDRLP4 4
CNSTI4 133
ASGNI4
ADDRGP4 $1922
JUMPV
LABELV $1921
ADDRLP4 4
CNSTI4 132
ASGNI4
LABELV $1922
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 Item_ListBox_HandleKey
CALLI4
pop
line 4086
;4086:				return;
ADDRGP4 $1911
JUMPV
LABELV $1918
line 4088
;4087:			}
;4088:		}
LABELV $1915
line 4083
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1917
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1914
line 4089
;4089:	}
LABELV $1912
line 4090
;4090:}
LABELV $1911
endproc Menu_ScrollFeeder 8 16
export Menu_SetFeederSelection
proc Menu_SetFeederSelection 12 8
line 4094
;4091:
;4092:
;4093:
;4094:void Menu_SetFeederSelection(menuDef_t *menu, int feeder, int index, const char *name) {
line 4095
;4095:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1924
line 4096
;4096:		if (name == NULL) {
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1926
line 4097
;4097:			menu = Menu_GetFocused();
ADDRLP4 0
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRFP4 0
ADDRLP4 0
INDIRP4
ASGNP4
line 4098
;4098:		} else {
ADDRGP4 $1927
JUMPV
LABELV $1926
line 4099
;4099:			menu = Menus_FindByName(name);
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRFP4 0
ADDRLP4 0
INDIRP4
ASGNP4
line 4100
;4100:		}
LABELV $1927
line 4101
;4101:	}
LABELV $1924
line 4103
;4102:
;4103:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1928
line 4105
;4104:		int i;
;4105:    for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1933
JUMPV
LABELV $1930
line 4106
;4106:			if (menu->items[i]->special == feeder) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ADDRFP4 4
INDIRI4
CVIF4 4
NEF4 $1934
line 4107
;4107:				if (index == 0) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $1936
line 4108
;4108:					listBoxDef_t *listPtr = (listBoxDef_t*)menu->items[i]->typeData;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4109
;4109:					listPtr->cursorPos = 0;
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 4110
;4110:					listPtr->startPos = 0;
ADDRLP4 4
INDIRP4
CNSTI4 0
ASGNI4
line 4111
;4111:				}
LABELV $1936
line 4112
;4112:				menu->items[i]->cursorPos = index;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 532
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 4113
;4113:				DC->feederSelection(menu->items[i]->special, menu->items[i]->cursorPos);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLV
pop
line 4114
;4114:				return;
ADDRGP4 $1923
JUMPV
LABELV $1934
line 4116
;4115:			}
;4116:		}
LABELV $1931
line 4105
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1933
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1930
line 4117
;4117:	}
LABELV $1928
line 4118
;4118:}
LABELV $1923
endproc Menu_SetFeederSelection 12 8
export Menus_AnyFullScreenVisible
proc Menus_AnyFullScreenVisible 8 0
line 4120
;4119:
;4120:qboolean Menus_AnyFullScreenVisible(void) {
line 4122
;4121:  int i;
;4122:  for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1942
JUMPV
LABELV $1939
line 4123
;4123:    if (Menus[i].window.flags & WINDOW_VISIBLE && Menus[i].fullScreen) {
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus+68
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1943
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus+184
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1943
line 4124
;4124:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1938
JUMPV
LABELV $1943
line 4126
;4125:    }
;4126:  }
LABELV $1940
line 4122
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1942
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $1939
line 4127
;4127:  return qfalse;
CNSTI4 0
RETI4
LABELV $1938
endproc Menus_AnyFullScreenVisible 8 0
export Menus_ActivateByName
proc Menus_ActivateByName 28 8
line 4130
;4128:}
;4129:
;4130:menuDef_t *Menus_ActivateByName(const char *p) {
line 4132
;4131:  int i;
;4132:  menuDef_t *m = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 4133
;4133:	menuDef_t *focus = Menu_GetFocused();
ADDRLP4 12
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 4134
;4134:  for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1951
JUMPV
LABELV $1948
line 4135
;4135:    if (Q_stricmp(Menus[i].window.name, p) == 0) {
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus+32
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $1952
line 4136
;4136:	    m = &Menus[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
ASGNP4
line 4137
;4137:			Menus_Activate(m);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Menus_Activate
CALLV
pop
line 4138
;4138:			if (openMenuCount < MAX_OPEN_MENUS && focus != NULL) {
ADDRGP4 openMenuCount
INDIRI4
CNSTI4 16
GEI4 $1953
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1953
line 4139
;4139:				menuStack[openMenuCount++] = focus;
ADDRLP4 24
ADDRGP4 openMenuCount
ASGNP4
ADDRLP4 20
ADDRLP4 24
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRP4
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 menuStack
ADDP4
ADDRLP4 8
INDIRP4
ASGNP4
line 4140
;4140:			}
line 4141
;4141:    } else {
ADDRGP4 $1953
JUMPV
LABELV $1952
line 4142
;4142:      Menus[i].window.flags &= ~WINDOW_HASFOCUS;
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus+68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 4143
;4143:    }
LABELV $1953
line 4144
;4144:  }
LABELV $1949
line 4134
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1951
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $1948
line 4145
;4145:	Display_CloseCinematics();
ADDRGP4 Display_CloseCinematics
CALLV
pop
line 4146
;4146:  return m;
ADDRLP4 4
INDIRP4
RETP4
LABELV $1947
endproc Menus_ActivateByName 28 8
export Item_Init
proc Item_Init 0 12
line 4150
;4147:}
;4148:
;4149:
;4150:void Item_Init(itemDef_t *item) {
line 4151
;4151:	memset(item, 0, sizeof(itemDef_t));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 540
ARGU4
ADDRGP4 memset
CALLP4
pop
line 4152
;4152:	item->textscale = 0.55f;
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
CNSTF4 1057803469
ASGNF4
line 4153
;4153:	Window_Init(&item->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_Init
CALLV
pop
line 4154
;4154:}
LABELV $1958
endproc Item_Init 0 12
export Menu_HandleMouseMove
proc Menu_HandleMouseMove 56 12
line 4156
;4155:
;4156:void Menu_HandleMouseMove(menuDef_t *menu, float x, float y) {
line 4158
;4157:  int i, pass;
;4158:  qboolean focusSet = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 4161
;4159:
;4160:  itemDef_t *overItem;
;4161:  if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1960
line 4162
;4162:    return;
ADDRGP4 $1959
JUMPV
LABELV $1960
line 4165
;4163:  }
;4164:
;4165:  if (!(menu->window.flags & (WINDOW_VISIBLE | WINDOW_FORCED))) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
NEI4 $1962
line 4166
;4166:    return;
ADDRGP4 $1959
JUMPV
LABELV $1962
line 4169
;4167:  }
;4168:
;4169:	if (itemCapture) {
ADDRGP4 itemCapture
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1964
line 4171
;4170:		//Item_MouseMove(itemCapture, x, y);
;4171:		return;
ADDRGP4 $1959
JUMPV
LABELV $1964
line 4174
;4172:	}
;4173:
;4174:	if (g_waitingForKey || g_editingField) {
ADDRGP4 g_waitingForKey
INDIRI4
CNSTI4 0
NEI4 $1968
ADDRGP4 g_editingField
INDIRI4
CNSTI4 0
EQI4 $1966
LABELV $1968
line 4175
;4175:		return;
ADDRGP4 $1959
JUMPV
LABELV $1966
line 4180
;4176:	}
;4177:
;4178:  // FIXME: this is the whole issue of focus vs. mouse over.. 
;4179:  // need a better overall solution as i don't like going through everything twice
;4180:  for (pass = 0; pass < 2; pass++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $1969
line 4181
;4181:    for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1976
JUMPV
LABELV $1973
line 4185
;4182:      // turn off focus each item
;4183:      // menu->items[i].window.flags &= ~WINDOW_HASFOCUS;
;4184:
;4185:      if (!(menu->items[i]->window.flags & (WINDOW_VISIBLE | WINDOW_FORCED))) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
NEI4 $1977
line 4186
;4186:        continue;
ADDRGP4 $1974
JUMPV
LABELV $1977
line 4190
;4187:      }
;4188:
;4189:			// items can be enabled and disabled based on cvars
;4190:			if (menu->items[i]->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(menu->items[i], CVAR_ENABLE)) {
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $1979
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 24
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $1979
line 4191
;4191:				continue;
ADDRGP4 $1974
JUMPV
LABELV $1979
line 4194
;4192:			}
;4193:
;4194:			if (menu->items[i]->cvarFlags & (CVAR_SHOW | CVAR_HIDE) && !Item_EnableShowViaCvar(menu->items[i], CVAR_SHOW)) {
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
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 12
BANDI4
CNSTI4 0
EQI4 $1981
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 36
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $1981
line 4195
;4195:				continue;
ADDRGP4 $1974
JUMPV
LABELV $1981
line 4200
;4196:			}
;4197:
;4198:
;4199:
;4200:      if (Rect_ContainsPoint(&menu->items[i]->window.rect, x, y)) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $1983
line 4201
;4201:				if (pass == 1) {
ADDRLP4 8
INDIRI4
CNSTI4 1
NEI4 $1984
line 4202
;4202:					overItem = menu->items[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
line 4203
;4203:					if (overItem->type == ITEM_TYPE_TEXT && overItem->text) {
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1987
ADDRLP4 4
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1987
line 4204
;4204:						if (!Rect_ContainsPoint(Item_CorrectedTextRect(overItem), x, y)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 Item_CorrectedTextRect
CALLP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 52
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $1989
line 4205
;4205:							continue;
ADDRGP4 $1974
JUMPV
LABELV $1989
line 4207
;4206:						}
;4207:					}
LABELV $1987
line 4209
;4208:					// if we are over an item
;4209:					if (IsVisible(overItem->window.flags)) {
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 IsVisible
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $1984
line 4211
;4210:						// different one
;4211:						Item_MouseEnter(overItem, x, y);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRGP4 Item_MouseEnter
CALLV
pop
line 4215
;4212:						// Item_SetMouseOver(overItem, qtrue);
;4213:
;4214:						// if item is not a decoration see if it can take focus
;4215:						if (!focusSet) {
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $1984
line 4216
;4216:							focusSet = Item_SetFocus(overItem, x, y);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 52
ADDRGP4 Item_SetFocus
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 52
INDIRI4
ASGNI4
line 4217
;4217:						}
line 4218
;4218:					}
line 4219
;4219:				}
line 4220
;4220:      } else if (menu->items[i]->window.flags & WINDOW_MOUSEOVER) {
ADDRGP4 $1984
JUMPV
LABELV $1983
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1995
line 4221
;4221:          Item_MouseLeave(menu->items[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_MouseLeave
CALLV
pop
line 4222
;4222:          Item_SetMouseOver(menu->items[i], qfalse);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Item_SetMouseOver
CALLV
pop
line 4223
;4223:      }
LABELV $1995
LABELV $1984
line 4224
;4224:    }
LABELV $1974
line 4181
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1976
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1973
line 4225
;4225:  }
LABELV $1970
line 4180
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 2
LTI4 $1969
line 4227
;4226:
;4227:}
LABELV $1959
endproc Menu_HandleMouseMove 56 12
export Menu_Paint
proc Menu_Paint 44 36
line 4229
;4228:
;4229:void Menu_Paint(menuDef_t *menu, qboolean forcePaint) {
line 4232
;4230:	int i;
;4231:
;4232:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1998
line 4233
;4233:		return;
ADDRGP4 $1997
JUMPV
LABELV $1998
line 4236
;4234:	}
;4235:
;4236:	if (!(menu->window.flags & WINDOW_VISIBLE) &&  !forcePaint) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $2000
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $2000
line 4237
;4237:		return;
ADDRGP4 $1997
JUMPV
LABELV $2000
line 4240
;4238:	}
;4239:
;4240:	if (menu->window.ownerDrawFlags && DC->ownerDrawVisible && !DC->ownerDrawVisible(menu->window.ownerDrawFlags)) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2002
ADDRLP4 8
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 76
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2002
ADDRLP4 4
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 76
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2002
line 4241
;4241:		return;
ADDRGP4 $1997
JUMPV
LABELV $2002
line 4244
;4242:	}
;4243:	
;4244:	if (forcePaint) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $2004
line 4245
;4245:		menu->window.flags |= WINDOW_FORCED;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1048576
BORI4
ASGNI4
line 4246
;4246:	}
LABELV $2004
line 4249
;4247:
;4248:	// draw the background if necessary
;4249:	if (menu->fullScreen) {
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2006
line 4252
;4250:		// implies a background shader
;4251:		// FIXME: make sure we have a default shader if fullscreen is set with no background
;4252:		DC->drawStretchPic( 0, 0, DC->glconfig.vidWidth, DC->glconfig.vidHeight, 0, 0, 1, 1, menu->window.background );
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 16
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 73348
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 73352
ADDP4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
CALLV
pop
line 4253
;4253:	} else if (menu->window.background) {
ADDRGP4 $2007
JUMPV
LABELV $2006
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2008
line 4256
;4254:		// this allows a background shader without being full screen
;4255:		//UI_DrawHandlePic(menu->window.rect.x, menu->window.rect.y, menu->window.rect.w, menu->window.rect.h, menu->backgroundShader);
;4256:	}
LABELV $2008
LABELV $2007
line 4259
;4257:
;4258:	// paint the background and or border
;4259:	Window_Paint(&menu->window, menu->fadeAmount, menu->fadeClamp, menu->fadeCycle );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 204
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 Window_Paint
CALLV
pop
line 4261
;4260:
;4261:	for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2013
JUMPV
LABELV $2010
line 4262
;4262:		Item_Paint(menu->items[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_Paint
CALLV
pop
line 4263
;4263:	}
LABELV $2011
line 4261
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2013
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $2010
line 4265
;4264:
;4265:	if (debugMode) {
ADDRGP4 debugMode
INDIRI4
CNSTI4 0
EQI4 $2014
line 4267
;4266:		vec4_t color;
;4267:		color[0] = color[2] = color[3] = 1;
ADDRLP4 36
CNSTF4 1065353216
ASGNF4
ADDRLP4 20+12
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 20+8
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 20
ADDRLP4 36
INDIRF4
ASGNF4
line 4268
;4268:		color[1] = 0;
ADDRLP4 20+4
CNSTF4 0
ASGNF4
line 4269
;4269:		DC->drawRect(menu->window.rect.x, menu->window.rect.y, menu->window.rect.w, menu->window.rect.h, 1, color);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 20
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 4270
;4270:	}
LABELV $2014
line 4271
;4271:}
LABELV $1997
endproc Menu_Paint 44 36
export Item_ValidateTypeData
proc Item_ValidateTypeData 8 12
line 4278
;4272:
;4273:/*
;4274:===============
;4275:Item_ValidateTypeData
;4276:===============
;4277:*/
;4278:void Item_ValidateTypeData(itemDef_t *item) {
line 4279
;4279:	if (item->typeData) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2020
line 4280
;4280:		return;
ADDRGP4 $2019
JUMPV
LABELV $2020
line 4283
;4281:	}
;4282:
;4283:	if (item->type == ITEM_TYPE_LISTBOX) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 6
NEI4 $2022
line 4284
;4284:		item->typeData = UI_Alloc(sizeof(listBoxDef_t));
CNSTI4 232
ARGI4
ADDRLP4 0
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 4285
;4285:		memset(item->typeData, 0, sizeof(listBoxDef_t));
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 232
ARGU4
ADDRGP4 memset
CALLP4
pop
line 4286
;4286:	} else if (item->type == ITEM_TYPE_EDITFIELD || item->type == ITEM_TYPE_NUMERICFIELD || item->type == ITEM_TYPE_YESNO || item->type == ITEM_TYPE_BIND || item->type == ITEM_TYPE_SLIDER || item->type == ITEM_TYPE_TEXT) {
ADDRGP4 $2023
JUMPV
LABELV $2022
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 4
EQI4 $2030
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 9
EQI4 $2030
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 11
EQI4 $2030
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 13
EQI4 $2030
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 10
EQI4 $2030
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2024
LABELV $2030
line 4287
;4287:		item->typeData = UI_Alloc(sizeof(editFieldDef_t));
CNSTI4 28
ARGI4
ADDRLP4 4
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 4288
;4288:		memset(item->typeData, 0, sizeof(editFieldDef_t));
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 28
ARGU4
ADDRGP4 memset
CALLP4
pop
line 4289
;4289:		if (item->type == ITEM_TYPE_EDITFIELD) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 4
NEI4 $2025
line 4290
;4290:			if (!((editFieldDef_t *) item->typeData)->maxPaintChars) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2025
line 4291
;4291:				((editFieldDef_t *) item->typeData)->maxPaintChars = MAX_EDITFIELD;
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 256
ASGNI4
line 4292
;4292:			}
line 4293
;4293:		}
line 4294
;4294:	} else if (item->type == ITEM_TYPE_MULTI) {
ADDRGP4 $2025
JUMPV
LABELV $2024
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 12
NEI4 $2035
line 4295
;4295:		item->typeData = UI_Alloc(sizeof(multiDef_t));
CNSTI4 392
ARGI4
ADDRLP4 4
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 4296
;4296:	} else if (item->type == ITEM_TYPE_MODEL) {
ADDRGP4 $2036
JUMPV
LABELV $2035
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 7
NEI4 $2037
line 4297
;4297:		item->typeData = UI_Alloc(sizeof(modelDef_t));
CNSTI4 28
ARGI4
ADDRLP4 4
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 4298
;4298:	}
LABELV $2037
LABELV $2036
LABELV $2025
LABELV $2023
line 4299
;4299:}
LABELV $2019
endproc Item_ValidateTypeData 8 12
export KeywordHash_Key
proc KeywordHash_Key 20 0
line 4316
;4300:
;4301:/*
;4302:===============
;4303:Keyword Hash
;4304:===============
;4305:*/
;4306:
;4307:#define KEYWORDHASH_SIZE	512
;4308:
;4309:typedef struct keywordHash_s
;4310:{
;4311:	char *keyword;
;4312:	qboolean (*func)(itemDef_t *item, int handle);
;4313:	struct keywordHash_s *next;
;4314:} keywordHash_t;
;4315:
;4316:int KeywordHash_Key(char *keyword) {
line 4319
;4317:	int register hash, i;
;4318:
;4319:	hash = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 4320
;4320:	for (i = 0; keyword[i] != '\0'; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2043
JUMPV
LABELV $2040
line 4321
;4321:		if (keyword[i] >= 'A' && keyword[i] <= 'Z')
ADDRLP4 8
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 65
LTI4 $2044
ADDRLP4 8
INDIRI4
CNSTI4 90
GTI4 $2044
line 4322
;4322:			hash += (keyword[i] + ('a' - 'A')) * (119 + i);
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 32
ADDI4
ADDRLP4 4
INDIRI4
CNSTI4 119
ADDI4
MULI4
ADDI4
ASGNI4
ADDRGP4 $2045
JUMPV
LABELV $2044
line 4324
;4323:		else
;4324:			hash += keyword[i] * (119 + i);
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI4
CNSTI4 119
ADDI4
MULI4
ADDI4
ASGNI4
LABELV $2045
line 4325
;4325:	}
LABELV $2041
line 4320
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2043
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2040
line 4326
;4326:	hash = (hash ^ (hash >> 10) ^ (hash >> 20)) & (KEYWORDHASH_SIZE-1);
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 10
RSHI4
BXORI4
ADDRLP4 0
INDIRI4
CNSTI4 20
RSHI4
BXORI4
CNSTI4 511
BANDI4
ASGNI4
line 4327
;4327:	return hash;
ADDRLP4 0
INDIRI4
RETI4
LABELV $2039
endproc KeywordHash_Key 20 0
export KeywordHash_Add
proc KeywordHash_Add 8 4
line 4330
;4328:}
;4329:
;4330:void KeywordHash_Add(keywordHash_t *table[], keywordHash_t *key) {
line 4333
;4331:	int hash;
;4332:
;4333:	hash = KeywordHash_Key(key->keyword);
ADDRFP4 4
INDIRP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 KeywordHash_Key
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 4339
;4334:/*
;4335:	if (table[hash]) {
;4336:		int collision = qtrue;
;4337:	}
;4338:*/
;4339:	key->next = table[hash];
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRP4
ASGNP4
line 4340
;4340:	table[hash] = key;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
ADDRFP4 4
INDIRP4
ASGNP4
line 4341
;4341:}
LABELV $2046
endproc KeywordHash_Add 8 4
export KeywordHash_Find
proc KeywordHash_Find 16 8
line 4344
;4342:
;4343:keywordHash_t *KeywordHash_Find(keywordHash_t *table[], char *keyword)
;4344:{
line 4348
;4345:	keywordHash_t *key;
;4346:	int hash;
;4347:
;4348:	hash = KeywordHash_Key(keyword);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 KeywordHash_Key
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 4349
;4349:	for (key = table[hash]; key; key = key->next) {
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $2051
JUMPV
LABELV $2048
line 4350
;4350:		if (!Q_stricmp(key->keyword, keyword))
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2052
line 4351
;4351:			return key;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $2047
JUMPV
LABELV $2052
line 4352
;4352:	}
LABELV $2049
line 4349
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ASGNP4
LABELV $2051
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2048
line 4353
;4353:	return NULL;
CNSTP4 0
RETP4
LABELV $2047
endproc KeywordHash_Find 16 8
export ItemParse_name
proc ItemParse_name 4 8
line 4363
;4354:}
;4355:
;4356:/*
;4357:===============
;4358:Item Keyword Parse functions
;4359:===============
;4360:*/
;4361:
;4362:// name <string>
;4363:qboolean ItemParse_name( itemDef_t *item, int handle ) {
line 4364
;4364:	if (!PC_String_Parse(handle, &item->window.name)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2055
line 4365
;4365:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2054
JUMPV
LABELV $2055
line 4367
;4366:	}
;4367:	return qtrue;
CNSTI4 1
RETI4
LABELV $2054
endproc ItemParse_name 4 8
export ItemParse_focusSound
proc ItemParse_focusSound 12 8
line 4371
;4368:}
;4369:
;4370:// name <string>
;4371:qboolean ItemParse_focusSound( itemDef_t *item, int handle ) {
line 4373
;4372:	const char *temp;
;4373:	if (!PC_String_Parse(handle, &temp)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2058
line 4374
;4374:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2057
JUMPV
LABELV $2058
line 4376
;4375:	}
;4376:	item->focusSound = DC->registerSound(temp, qfalse);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
CNSTI4 168
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 4377
;4377:	return qtrue;
CNSTI4 1
RETI4
LABELV $2057
endproc ItemParse_focusSound 12 8
export ItemParse_text
proc ItemParse_text 4 8
line 4382
;4378:}
;4379:
;4380:
;4381:// text <string>
;4382:qboolean ItemParse_text( itemDef_t *item, int handle ) {
line 4383
;4383:	if (!PC_String_Parse(handle, &item->text)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2061
line 4384
;4384:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2060
JUMPV
LABELV $2061
line 4386
;4385:	}
;4386:	return qtrue;
CNSTI4 1
RETI4
LABELV $2060
endproc ItemParse_text 4 8
export ItemParse_group
proc ItemParse_group 4 8
line 4390
;4387:}
;4388:
;4389:// group <string>
;4390:qboolean ItemParse_group( itemDef_t *item, int handle ) {
line 4391
;4391:	if (!PC_String_Parse(handle, &item->window.group)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2064
line 4392
;4392:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2063
JUMPV
LABELV $2064
line 4394
;4393:	}
;4394:	return qtrue;
CNSTI4 1
RETI4
LABELV $2063
endproc ItemParse_group 4 8
export ItemParse_asset_model
proc ItemParse_asset_model 20 8
line 4398
;4395:}
;4396:
;4397:// asset_model <string>
;4398:qboolean ItemParse_asset_model( itemDef_t *item, int handle ) {
line 4401
;4399:	const char *temp;
;4400:	modelDef_t *modelPtr;
;4401:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4402
;4402:	modelPtr = (modelDef_t*)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4404
;4403:
;4404:	if (!PC_String_Parse(handle, &temp)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2067
line 4405
;4405:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2066
JUMPV
LABELV $2067
line 4407
;4406:	}
;4407:	item->asset = DC->registerModel(temp);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 4408
;4408:	modelPtr->angle = rand() % 360;
ADDRLP4 16
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 16
INDIRI4
CNSTI4 360
MODI4
ASGNI4
line 4409
;4409:	return qtrue;
CNSTI4 1
RETI4
LABELV $2066
endproc ItemParse_asset_model 20 8
export ItemParse_asset_shader
proc ItemParse_asset_shader 12 8
line 4413
;4410:}
;4411:
;4412:// asset_shader <string>
;4413:qboolean ItemParse_asset_shader( itemDef_t *item, int handle ) {
line 4416
;4414:	const char *temp;
;4415:
;4416:	if (!PC_String_Parse(handle, &temp)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2070
line 4417
;4417:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2069
JUMPV
LABELV $2070
line 4419
;4418:	}
;4419:	item->asset = DC->registerShaderNoMip(temp);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 4420
;4420:	return qtrue;
CNSTI4 1
RETI4
LABELV $2069
endproc ItemParse_asset_shader 12 8
export ItemParse_model_origin
proc ItemParse_model_origin 16 8
line 4424
;4421:}
;4422:
;4423:// model_origin <number> <number> <number>
;4424:qboolean ItemParse_model_origin( itemDef_t *item, int handle ) {
line 4426
;4425:	modelDef_t *modelPtr;
;4426:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4427
;4427:	modelPtr = (modelDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4429
;4428:
;4429:	if (PC_Float_Parse(handle, &modelPtr->origin[0])) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2073
line 4430
;4430:		if (PC_Float_Parse(handle, &modelPtr->origin[1])) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $2075
line 4431
;4431:			if (PC_Float_Parse(handle, &modelPtr->origin[2])) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2077
line 4432
;4432:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2072
JUMPV
LABELV $2077
line 4434
;4433:			}
;4434:		}
LABELV $2075
line 4435
;4435:	}
LABELV $2073
line 4436
;4436:	return qfalse;
CNSTI4 0
RETI4
LABELV $2072
endproc ItemParse_model_origin 16 8
export ItemParse_model_fovx
proc ItemParse_model_fovx 8 8
line 4440
;4437:}
;4438:
;4439:// model_fovx <number>
;4440:qboolean ItemParse_model_fovx( itemDef_t *item, int handle ) {
line 4442
;4441:	modelDef_t *modelPtr;
;4442:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4443
;4443:	modelPtr = (modelDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4445
;4444:
;4445:	if (!PC_Float_Parse(handle, &modelPtr->fov_x)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2080
line 4446
;4446:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2079
JUMPV
LABELV $2080
line 4448
;4447:	}
;4448:	return qtrue;
CNSTI4 1
RETI4
LABELV $2079
endproc ItemParse_model_fovx 8 8
export ItemParse_model_fovy
proc ItemParse_model_fovy 8 8
line 4452
;4449:}
;4450:
;4451:// model_fovy <number>
;4452:qboolean ItemParse_model_fovy( itemDef_t *item, int handle ) {
line 4454
;4453:	modelDef_t *modelPtr;
;4454:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4455
;4455:	modelPtr = (modelDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4457
;4456:
;4457:	if (!PC_Float_Parse(handle, &modelPtr->fov_y)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2083
line 4458
;4458:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2082
JUMPV
LABELV $2083
line 4460
;4459:	}
;4460:	return qtrue;
CNSTI4 1
RETI4
LABELV $2082
endproc ItemParse_model_fovy 8 8
export ItemParse_model_rotation
proc ItemParse_model_rotation 8 8
line 4464
;4461:}
;4462:
;4463:// model_rotation <integer>
;4464:qboolean ItemParse_model_rotation( itemDef_t *item, int handle ) {
line 4466
;4465:	modelDef_t *modelPtr;
;4466:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4467
;4467:	modelPtr = (modelDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4469
;4468:
;4469:	if (!PC_Int_Parse(handle, &modelPtr->rotationSpeed)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2086
line 4470
;4470:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2085
JUMPV
LABELV $2086
line 4472
;4471:	}
;4472:	return qtrue;
CNSTI4 1
RETI4
LABELV $2085
endproc ItemParse_model_rotation 8 8
export ItemParse_model_angle
proc ItemParse_model_angle 8 8
line 4476
;4473:}
;4474:
;4475:// model_angle <integer>
;4476:qboolean ItemParse_model_angle( itemDef_t *item, int handle ) {
line 4478
;4477:	modelDef_t *modelPtr;
;4478:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4479
;4479:	modelPtr = (modelDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4481
;4480:
;4481:	if (!PC_Int_Parse(handle, &modelPtr->angle)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2089
line 4482
;4482:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2088
JUMPV
LABELV $2089
line 4484
;4483:	}
;4484:	return qtrue;
CNSTI4 1
RETI4
LABELV $2088
endproc ItemParse_model_angle 8 8
export ItemParse_rect
proc ItemParse_rect 4 8
line 4488
;4485:}
;4486:
;4487:// rect <rectangle>
;4488:qboolean ItemParse_rect( itemDef_t *item, int handle ) {
line 4489
;4489:	if (!PC_Rect_Parse(handle, &item->window.rectClient)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Rect_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2092
line 4490
;4490:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2091
JUMPV
LABELV $2092
line 4492
;4491:	}
;4492:	return qtrue;
CNSTI4 1
RETI4
LABELV $2091
endproc ItemParse_rect 4 8
export ItemParse_style
proc ItemParse_style 4 8
line 4496
;4493:}
;4494:
;4495:// style <integer>
;4496:qboolean ItemParse_style( itemDef_t *item, int handle ) {
line 4497
;4497:	if (!PC_Int_Parse(handle, &item->window.style)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2095
line 4498
;4498:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2094
JUMPV
LABELV $2095
line 4500
;4499:	}
;4500:	return qtrue;
CNSTI4 1
RETI4
LABELV $2094
endproc ItemParse_style 4 8
export ItemParse_decoration
proc ItemParse_decoration 4 0
line 4504
;4501:}
;4502:
;4503:// decoration
;4504:qboolean ItemParse_decoration( itemDef_t *item, int handle ) {
line 4505
;4505:	item->window.flags |= WINDOW_DECORATION;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 4506
;4506:	return qtrue;
CNSTI4 1
RETI4
LABELV $2097
endproc ItemParse_decoration 4 0
export ItemParse_notselectable
proc ItemParse_notselectable 4 4
line 4510
;4507:}
;4508:
;4509:// notselectable
;4510:qboolean ItemParse_notselectable( itemDef_t *item, int handle ) {
line 4512
;4511:	listBoxDef_t *listPtr;
;4512:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4513
;4513:	listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4514
;4514:	if (item->type == ITEM_TYPE_LISTBOX && listPtr) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 6
NEI4 $2099
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2099
line 4515
;4515:		listPtr->notselectable = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
CNSTI4 1
ASGNI4
line 4516
;4516:	}
LABELV $2099
line 4517
;4517:	return qtrue;
CNSTI4 1
RETI4
LABELV $2098
endproc ItemParse_notselectable 4 4
export ItemParse_wrapped
proc ItemParse_wrapped 4 0
line 4521
;4518:}
;4519:
;4520:// manually wrapped
;4521:qboolean ItemParse_wrapped( itemDef_t *item, int handle ) {
line 4522
;4522:	item->window.flags |= WINDOW_WRAPPED;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 262144
BORI4
ASGNI4
line 4523
;4523:	return qtrue;
CNSTI4 1
RETI4
LABELV $2101
endproc ItemParse_wrapped 4 0
export ItemParse_autowrapped
proc ItemParse_autowrapped 4 0
line 4527
;4524:}
;4525:
;4526:// auto wrapped
;4527:qboolean ItemParse_autowrapped( itemDef_t *item, int handle ) {
line 4528
;4528:	item->window.flags |= WINDOW_AUTOWRAPPED;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 524288
BORI4
ASGNI4
line 4529
;4529:	return qtrue;
CNSTI4 1
RETI4
LABELV $2102
endproc ItemParse_autowrapped 4 0
export ItemParse_horizontalscroll
proc ItemParse_horizontalscroll 4 0
line 4534
;4530:}
;4531:
;4532:
;4533:// horizontalscroll
;4534:qboolean ItemParse_horizontalscroll( itemDef_t *item, int handle ) {
line 4535
;4535:	item->window.flags |= WINDOW_HORIZONTAL;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 4536
;4536:	return qtrue;
CNSTI4 1
RETI4
LABELV $2103
endproc ItemParse_horizontalscroll 4 0
export ItemParse_type
proc ItemParse_type 4 8
line 4540
;4537:}
;4538:
;4539:// type <integer>
;4540:qboolean ItemParse_type( itemDef_t *item, int handle ) {
line 4541
;4541:	if (!PC_Int_Parse(handle, &item->type)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2105
line 4542
;4542:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2104
JUMPV
LABELV $2105
line 4544
;4543:	}
;4544:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4545
;4545:	return qtrue;
CNSTI4 1
RETI4
LABELV $2104
endproc ItemParse_type 4 8
export ItemParse_elementwidth
proc ItemParse_elementwidth 8 8
line 4550
;4546:}
;4547:
;4548:// elementwidth, used for listbox image elements
;4549:// uses textalignx for storage
;4550:qboolean ItemParse_elementwidth( itemDef_t *item, int handle ) {
line 4553
;4551:	listBoxDef_t *listPtr;
;4552:
;4553:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4554
;4554:	listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4555
;4555:	if (!PC_Float_Parse(handle, &listPtr->elementWidth)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2108
line 4556
;4556:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2107
JUMPV
LABELV $2108
line 4558
;4557:	}
;4558:	return qtrue;
CNSTI4 1
RETI4
LABELV $2107
endproc ItemParse_elementwidth 8 8
export ItemParse_elementheight
proc ItemParse_elementheight 8 8
line 4563
;4559:}
;4560:
;4561:// elementheight, used for listbox image elements
;4562:// uses textaligny for storage
;4563:qboolean ItemParse_elementheight( itemDef_t *item, int handle ) {
line 4566
;4564:	listBoxDef_t *listPtr;
;4565:
;4566:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4567
;4567:	listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4568
;4568:	if (!PC_Float_Parse(handle, &listPtr->elementHeight)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2111
line 4569
;4569:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2110
JUMPV
LABELV $2111
line 4571
;4570:	}
;4571:	return qtrue;
CNSTI4 1
RETI4
LABELV $2110
endproc ItemParse_elementheight 8 8
export ItemParse_feeder
proc ItemParse_feeder 4 8
line 4575
;4572:}
;4573:
;4574:// feeder <float>
;4575:qboolean ItemParse_feeder( itemDef_t *item, int handle ) {
line 4576
;4576:	if (!PC_Float_Parse(handle, &item->special)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2114
line 4577
;4577:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2113
JUMPV
LABELV $2114
line 4579
;4578:	}
;4579:	return qtrue;
CNSTI4 1
RETI4
LABELV $2113
endproc ItemParse_feeder 4 8
export ItemParse_elementtype
proc ItemParse_elementtype 8 8
line 4584
;4580:}
;4581:
;4582:// elementtype, used to specify what type of elements a listbox contains
;4583:// uses textstyle for storage
;4584:qboolean ItemParse_elementtype( itemDef_t *item, int handle ) {
line 4587
;4585:	listBoxDef_t *listPtr;
;4586:
;4587:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4588
;4588:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2117
line 4589
;4589:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2116
JUMPV
LABELV $2117
line 4590
;4590:	listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4591
;4591:	if (!PC_Int_Parse(handle, &listPtr->elementStyle)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2119
line 4592
;4592:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2116
JUMPV
LABELV $2119
line 4594
;4593:	}
;4594:	return qtrue;
CNSTI4 1
RETI4
LABELV $2116
endproc ItemParse_elementtype 8 8
export ItemParse_columns
proc ItemParse_columns 40 8
line 4598
;4595:}
;4596:
;4597:// columns sets a number of columns and an x pos and width per.. 
;4598:qboolean ItemParse_columns( itemDef_t *item, int handle ) {
line 4602
;4599:	int num, i;
;4600:	listBoxDef_t *listPtr;
;4601:
;4602:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4603
;4603:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2122
line 4604
;4604:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2121
JUMPV
LABELV $2122
line 4605
;4605:	listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4606
;4606:	if (PC_Int_Parse(handle, &num)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 12
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2124
line 4607
;4607:		if (num > MAX_LB_COLUMNS) {
ADDRLP4 8
INDIRI4
CNSTI4 16
LEI4 $2126
line 4608
;4608:			num = MAX_LB_COLUMNS;
ADDRLP4 8
CNSTI4 16
ASGNI4
line 4609
;4609:		}
LABELV $2126
line 4610
;4610:		listPtr->numColumns = num;
ADDRLP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 4611
;4611:		for (i = 0; i < num; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2131
JUMPV
LABELV $2128
line 4614
;4612:			int pos, width, maxChars;
;4613:
;4614:			if (PC_Int_Parse(handle, &pos) && PC_Int_Parse(handle, &width) && PC_Int_Parse(handle, &maxChars)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRLP4 28
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2132
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 20
ARGP4
ADDRLP4 32
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $2132
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 36
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $2132
line 4615
;4615:				listPtr->columnInfo[i].pos = pos;
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 4616
;4616:				listPtr->columnInfo[i].width = width;
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 4617
;4617:				listPtr->columnInfo[i].maxChars = maxChars;
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 4618
;4618:			} else {
ADDRGP4 $2133
JUMPV
LABELV $2132
line 4619
;4619:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2121
JUMPV
LABELV $2133
line 4621
;4620:			}
;4621:		}
LABELV $2129
line 4611
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2131
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $2128
line 4622
;4622:	} else {
ADDRGP4 $2125
JUMPV
LABELV $2124
line 4623
;4623:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2121
JUMPV
LABELV $2125
line 4625
;4624:	}
;4625:	return qtrue;
CNSTI4 1
RETI4
LABELV $2121
endproc ItemParse_columns 40 8
export ItemParse_border
proc ItemParse_border 4 8
line 4628
;4626:}
;4627:
;4628:qboolean ItemParse_border( itemDef_t *item, int handle ) {
line 4629
;4629:	if (!PC_Int_Parse(handle, &item->window.border)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2135
line 4630
;4630:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2134
JUMPV
LABELV $2135
line 4632
;4631:	}
;4632:	return qtrue;
CNSTI4 1
RETI4
LABELV $2134
endproc ItemParse_border 4 8
export ItemParse_bordersize
proc ItemParse_bordersize 4 8
line 4635
;4633:}
;4634:
;4635:qboolean ItemParse_bordersize( itemDef_t *item, int handle ) {
line 4636
;4636:	if (!PC_Float_Parse(handle, &item->window.borderSize)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2138
line 4637
;4637:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2137
JUMPV
LABELV $2138
line 4639
;4638:	}
;4639:	return qtrue;
CNSTI4 1
RETI4
LABELV $2137
endproc ItemParse_bordersize 4 8
export ItemParse_visible
proc ItemParse_visible 12 8
line 4642
;4640:}
;4641:
;4642:qboolean ItemParse_visible( itemDef_t *item, int handle ) {
line 4645
;4643:	int i;
;4644:
;4645:	if (!PC_Int_Parse(handle, &i)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2141
line 4646
;4646:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2140
JUMPV
LABELV $2141
line 4648
;4647:	}
;4648:	if (i) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2143
line 4649
;4649:		item->window.flags |= WINDOW_VISIBLE;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 4650
;4650:	}
LABELV $2143
line 4651
;4651:	return qtrue;
CNSTI4 1
RETI4
LABELV $2140
endproc ItemParse_visible 12 8
export ItemParse_ownerdraw
proc ItemParse_ownerdraw 4 8
line 4654
;4652:}
;4653:
;4654:qboolean ItemParse_ownerdraw( itemDef_t *item, int handle ) {
line 4655
;4655:	if (!PC_Int_Parse(handle, &item->window.ownerDraw)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2146
line 4656
;4656:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2145
JUMPV
LABELV $2146
line 4658
;4657:	}
;4658:	item->type = ITEM_TYPE_OWNERDRAW;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 8
ASGNI4
line 4659
;4659:	return qtrue;
CNSTI4 1
RETI4
LABELV $2145
endproc ItemParse_ownerdraw 4 8
export ItemParse_align
proc ItemParse_align 4 8
line 4662
;4660:}
;4661:
;4662:qboolean ItemParse_align( itemDef_t *item, int handle ) {
line 4663
;4663:	if (!PC_Int_Parse(handle, &item->alignment)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2149
line 4664
;4664:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2148
JUMPV
LABELV $2149
line 4666
;4665:	}
;4666:	return qtrue;
CNSTI4 1
RETI4
LABELV $2148
endproc ItemParse_align 4 8
export ItemParse_textalign
proc ItemParse_textalign 4 8
line 4669
;4667:}
;4668:
;4669:qboolean ItemParse_textalign( itemDef_t *item, int handle ) {
line 4670
;4670:	if (!PC_Int_Parse(handle, &item->textalignment)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2152
line 4671
;4671:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2151
JUMPV
LABELV $2152
line 4673
;4672:	}
;4673:	return qtrue;
CNSTI4 1
RETI4
LABELV $2151
endproc ItemParse_textalign 4 8
export ItemParse_textalignx
proc ItemParse_textalignx 4 8
line 4676
;4674:}
;4675:
;4676:qboolean ItemParse_textalignx( itemDef_t *item, int handle ) {
line 4677
;4677:	if (!PC_Float_Parse(handle, &item->textalignx)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 208
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2155
line 4678
;4678:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2154
JUMPV
LABELV $2155
line 4680
;4679:	}
;4680:	return qtrue;
CNSTI4 1
RETI4
LABELV $2154
endproc ItemParse_textalignx 4 8
export ItemParse_textaligny
proc ItemParse_textaligny 4 8
line 4683
;4681:}
;4682:
;4683:qboolean ItemParse_textaligny( itemDef_t *item, int handle ) {
line 4684
;4684:	if (!PC_Float_Parse(handle, &item->textaligny)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2158
line 4685
;4685:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2157
JUMPV
LABELV $2158
line 4687
;4686:	}
;4687:	return qtrue;
CNSTI4 1
RETI4
LABELV $2157
endproc ItemParse_textaligny 4 8
export ItemParse_textscale
proc ItemParse_textscale 4 8
line 4690
;4688:}
;4689:
;4690:qboolean ItemParse_textscale( itemDef_t *item, int handle ) {
line 4691
;4691:	if (!PC_Float_Parse(handle, &item->textscale)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2161
line 4692
;4692:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2160
JUMPV
LABELV $2161
line 4694
;4693:	}
;4694:	return qtrue;
CNSTI4 1
RETI4
LABELV $2160
endproc ItemParse_textscale 4 8
export ItemParse_textstyle
proc ItemParse_textstyle 4 8
line 4697
;4695:}
;4696:
;4697:qboolean ItemParse_textstyle( itemDef_t *item, int handle ) {
line 4698
;4698:	if (!PC_Int_Parse(handle, &item->textStyle)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2164
line 4699
;4699:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2163
JUMPV
LABELV $2164
line 4701
;4700:	}
;4701:	return qtrue;
CNSTI4 1
RETI4
LABELV $2163
endproc ItemParse_textstyle 4 8
export ItemParse_backcolor
proc ItemParse_backcolor 12 8
line 4704
;4702:}
;4703:
;4704:qboolean ItemParse_backcolor( itemDef_t *item, int handle ) {
line 4708
;4705:	int i;
;4706:	float f;
;4707:
;4708:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2167
line 4709
;4709:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2171
line 4710
;4710:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2166
JUMPV
LABELV $2171
line 4712
;4711:		}
;4712:		item->window.backColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 4713
;4713:	}
LABELV $2168
line 4708
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2167
line 4714
;4714:	return qtrue;
CNSTI4 1
RETI4
LABELV $2166
endproc ItemParse_backcolor 12 8
export ItemParse_forecolor
proc ItemParse_forecolor 16 8
line 4717
;4715:}
;4716:
;4717:qboolean ItemParse_forecolor( itemDef_t *item, int handle ) {
line 4721
;4718:	int i;
;4719:	float f;
;4720:
;4721:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2174
line 4722
;4722:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2178
line 4723
;4723:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2173
JUMPV
LABELV $2178
line 4725
;4724:		}
;4725:		item->window.foreColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 4726
;4726:		item->window.flags |= WINDOW_FORECOLORSET;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 4727
;4727:	}
LABELV $2175
line 4721
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2174
line 4728
;4728:	return qtrue;
CNSTI4 1
RETI4
LABELV $2173
endproc ItemParse_forecolor 16 8
export ItemParse_bordercolor
proc ItemParse_bordercolor 12 8
line 4731
;4729:}
;4730:
;4731:qboolean ItemParse_bordercolor( itemDef_t *item, int handle ) {
line 4735
;4732:	int i;
;4733:	float f;
;4734:
;4735:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2181
line 4736
;4736:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2185
line 4737
;4737:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2180
JUMPV
LABELV $2185
line 4739
;4738:		}
;4739:		item->window.borderColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 4740
;4740:	}
LABELV $2182
line 4735
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2181
line 4741
;4741:	return qtrue;
CNSTI4 1
RETI4
LABELV $2180
endproc ItemParse_bordercolor 12 8
export ItemParse_outlinecolor
proc ItemParse_outlinecolor 4 8
line 4744
;4742:}
;4743:
;4744:qboolean ItemParse_outlinecolor( itemDef_t *item, int handle ) {
line 4745
;4745:	if (!PC_Color_Parse(handle, &item->window.outlineColor)){
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Color_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2188
line 4746
;4746:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2187
JUMPV
LABELV $2188
line 4748
;4747:	}
;4748:	return qtrue;
CNSTI4 1
RETI4
LABELV $2187
endproc ItemParse_outlinecolor 4 8
export ItemParse_background
proc ItemParse_background 12 8
line 4751
;4749:}
;4750:
;4751:qboolean ItemParse_background( itemDef_t *item, int handle ) {
line 4754
;4752:	const char *temp;
;4753:
;4754:	if (!PC_String_Parse(handle, &temp)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2191
line 4755
;4755:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2190
JUMPV
LABELV $2191
line 4757
;4756:	}
;4757:	item->window.background = DC->registerShaderNoMip(temp);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 4758
;4758:	return qtrue;
CNSTI4 1
RETI4
LABELV $2190
endproc ItemParse_background 12 8
export ItemParse_cinematic
proc ItemParse_cinematic 4 8
line 4761
;4759:}
;4760:
;4761:qboolean ItemParse_cinematic( itemDef_t *item, int handle ) {
line 4762
;4762:	if (!PC_String_Parse(handle, &item->window.cinematicName)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2194
line 4763
;4763:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2193
JUMPV
LABELV $2194
line 4765
;4764:	}
;4765:	return qtrue;
CNSTI4 1
RETI4
LABELV $2193
endproc ItemParse_cinematic 4 8
export ItemParse_doubleClick
proc ItemParse_doubleClick 8 8
line 4768
;4766:}
;4767:
;4768:qboolean ItemParse_doubleClick( itemDef_t *item, int handle ) {
line 4771
;4769:	listBoxDef_t *listPtr;
;4770:
;4771:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4772
;4772:	if (!item->typeData) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2197
line 4773
;4773:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2196
JUMPV
LABELV $2197
line 4776
;4774:	}
;4775:
;4776:	listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4778
;4777:
;4778:	if (!PC_Script_Parse(handle, &listPtr->doubleClick)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 224
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2199
line 4779
;4779:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2196
JUMPV
LABELV $2199
line 4781
;4780:	}
;4781:	return qtrue;
CNSTI4 1
RETI4
LABELV $2196
endproc ItemParse_doubleClick 8 8
export ItemParse_onFocus
proc ItemParse_onFocus 4 8
line 4784
;4782:}
;4783:
;4784:qboolean ItemParse_onFocus( itemDef_t *item, int handle ) {
line 4785
;4785:	if (!PC_Script_Parse(handle, &item->onFocus)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2202
line 4786
;4786:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2201
JUMPV
LABELV $2202
line 4788
;4787:	}
;4788:	return qtrue;
CNSTI4 1
RETI4
LABELV $2201
endproc ItemParse_onFocus 4 8
export ItemParse_leaveFocus
proc ItemParse_leaveFocus 4 8
line 4791
;4789:}
;4790:
;4791:qboolean ItemParse_leaveFocus( itemDef_t *item, int handle ) {
line 4792
;4792:	if (!PC_Script_Parse(handle, &item->leaveFocus)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2205
line 4793
;4793:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2204
JUMPV
LABELV $2205
line 4795
;4794:	}
;4795:	return qtrue;
CNSTI4 1
RETI4
LABELV $2204
endproc ItemParse_leaveFocus 4 8
export ItemParse_mouseEnter
proc ItemParse_mouseEnter 4 8
line 4798
;4796:}
;4797:
;4798:qboolean ItemParse_mouseEnter( itemDef_t *item, int handle ) {
line 4799
;4799:	if (!PC_Script_Parse(handle, &item->mouseEnter)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 244
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2208
line 4800
;4800:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2207
JUMPV
LABELV $2208
line 4802
;4801:	}
;4802:	return qtrue;
CNSTI4 1
RETI4
LABELV $2207
endproc ItemParse_mouseEnter 4 8
export ItemParse_mouseExit
proc ItemParse_mouseExit 4 8
line 4805
;4803:}
;4804:
;4805:qboolean ItemParse_mouseExit( itemDef_t *item, int handle ) {
line 4806
;4806:	if (!PC_Script_Parse(handle, &item->mouseExit)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 248
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2211
line 4807
;4807:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2210
JUMPV
LABELV $2211
line 4809
;4808:	}
;4809:	return qtrue;
CNSTI4 1
RETI4
LABELV $2210
endproc ItemParse_mouseExit 4 8
export ItemParse_mouseEnterText
proc ItemParse_mouseEnterText 4 8
line 4812
;4810:}
;4811:
;4812:qboolean ItemParse_mouseEnterText( itemDef_t *item, int handle ) {
line 4813
;4813:	if (!PC_Script_Parse(handle, &item->mouseEnterText)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2214
line 4814
;4814:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2213
JUMPV
LABELV $2214
line 4816
;4815:	}
;4816:	return qtrue;
CNSTI4 1
RETI4
LABELV $2213
endproc ItemParse_mouseEnterText 4 8
export ItemParse_mouseExitText
proc ItemParse_mouseExitText 4 8
line 4819
;4817:}
;4818:
;4819:qboolean ItemParse_mouseExitText( itemDef_t *item, int handle ) {
line 4820
;4820:	if (!PC_Script_Parse(handle, &item->mouseExitText)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2217
line 4821
;4821:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2216
JUMPV
LABELV $2217
line 4823
;4822:	}
;4823:	return qtrue;
CNSTI4 1
RETI4
LABELV $2216
endproc ItemParse_mouseExitText 4 8
export ItemParse_action
proc ItemParse_action 4 8
line 4826
;4824:}
;4825:
;4826:qboolean ItemParse_action( itemDef_t *item, int handle ) {
line 4827
;4827:	if (!PC_Script_Parse(handle, &item->action)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 252
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2220
line 4828
;4828:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2219
JUMPV
LABELV $2220
line 4830
;4829:	}
;4830:	return qtrue;
CNSTI4 1
RETI4
LABELV $2219
endproc ItemParse_action 4 8
export ItemParse_special
proc ItemParse_special 4 8
line 4833
;4831:}
;4832:
;4833:qboolean ItemParse_special( itemDef_t *item, int handle ) {
line 4834
;4834:	if (!PC_Float_Parse(handle, &item->special)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2223
line 4835
;4835:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2222
JUMPV
LABELV $2223
line 4837
;4836:	}
;4837:	return qtrue;
CNSTI4 1
RETI4
LABELV $2222
endproc ItemParse_special 4 8
export ItemParse_cvarTest
proc ItemParse_cvarTest 4 8
line 4840
;4838:}
;4839:
;4840:qboolean ItemParse_cvarTest( itemDef_t *item, int handle ) {
line 4841
;4841:	if (!PC_String_Parse(handle, &item->cvarTest)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2226
line 4842
;4842:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2225
JUMPV
LABELV $2226
line 4844
;4843:	}
;4844:	return qtrue;
CNSTI4 1
RETI4
LABELV $2225
endproc ItemParse_cvarTest 4 8
export ItemParse_cvar
proc ItemParse_cvar 8 8
line 4847
;4845:}
;4846:
;4847:qboolean ItemParse_cvar( itemDef_t *item, int handle ) {
line 4850
;4848:	editFieldDef_t *editPtr;
;4849:
;4850:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4851
;4851:	if (!PC_String_Parse(handle, &item->cvar)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2229
line 4852
;4852:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2228
JUMPV
LABELV $2229
line 4854
;4853:	}
;4854:	if (item->typeData) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2231
line 4855
;4855:		editPtr = (editFieldDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4856
;4856:		editPtr->minVal = -1;
ADDRLP4 0
INDIRP4
CNSTF4 3212836864
ASGNF4
line 4857
;4857:		editPtr->maxVal = -1;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 3212836864
ASGNF4
line 4858
;4858:		editPtr->defVal = -1;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 3212836864
ASGNF4
line 4859
;4859:	}
LABELV $2231
line 4860
;4860:	return qtrue;
CNSTI4 1
RETI4
LABELV $2228
endproc ItemParse_cvar 8 8
export ItemParse_maxChars
proc ItemParse_maxChars 12 8
line 4863
;4861:}
;4862:
;4863:qboolean ItemParse_maxChars( itemDef_t *item, int handle ) {
line 4867
;4864:	editFieldDef_t *editPtr;
;4865:	int maxChars;
;4866:
;4867:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4868
;4868:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2234
line 4869
;4869:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2233
JUMPV
LABELV $2234
line 4871
;4870:
;4871:	if (!PC_Int_Parse(handle, &maxChars)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2236
line 4872
;4872:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2233
JUMPV
LABELV $2236
line 4874
;4873:	}
;4874:	editPtr = (editFieldDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4875
;4875:	editPtr->maxChars = maxChars;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 4876
;4876:	return qtrue;
CNSTI4 1
RETI4
LABELV $2233
endproc ItemParse_maxChars 12 8
export ItemParse_maxPaintChars
proc ItemParse_maxPaintChars 12 8
line 4879
;4877:}
;4878:
;4879:qboolean ItemParse_maxPaintChars( itemDef_t *item, int handle ) {
line 4883
;4880:	editFieldDef_t *editPtr;
;4881:	int maxChars;
;4882:
;4883:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4884
;4884:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2239
line 4885
;4885:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2238
JUMPV
LABELV $2239
line 4887
;4886:
;4887:	if (!PC_Int_Parse(handle, &maxChars)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2241
line 4888
;4888:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2238
JUMPV
LABELV $2241
line 4890
;4889:	}
;4890:	editPtr = (editFieldDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4891
;4891:	editPtr->maxPaintChars = maxChars;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 4892
;4892:	return qtrue;
CNSTI4 1
RETI4
LABELV $2238
endproc ItemParse_maxPaintChars 12 8
export ItemParse_cvarFloat
proc ItemParse_cvarFloat 20 8
line 4897
;4893:}
;4894:
;4895:
;4896:
;4897:qboolean ItemParse_cvarFloat( itemDef_t *item, int handle ) {
line 4900
;4898:	editFieldDef_t *editPtr;
;4899:
;4900:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4901
;4901:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2244
line 4902
;4902:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2243
JUMPV
LABELV $2244
line 4903
;4903:	editPtr = (editFieldDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4904
;4904:	if (PC_String_Parse(handle, &item->cvar) &&
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2246
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $2246
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2246
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $2246
line 4907
;4905:		PC_Float_Parse(handle, &editPtr->defVal) &&
;4906:		PC_Float_Parse(handle, &editPtr->minVal) &&
;4907:		PC_Float_Parse(handle, &editPtr->maxVal)) {
line 4908
;4908:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2243
JUMPV
LABELV $2246
line 4910
;4909:	}
;4910:	return qfalse;
CNSTI4 0
RETI4
LABELV $2243
endproc ItemParse_cvarFloat 20 8
export ItemParse_cvarStrList
proc ItemParse_cvarStrList 1068 8
line 4913
;4911:}
;4912:
;4913:qboolean ItemParse_cvarStrList( itemDef_t *item, int handle ) {
line 4918
;4914:	pc_token_t token;
;4915:	multiDef_t *multiPtr;
;4916:	int pass;
;4917:	
;4918:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4919
;4919:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2249
line 4920
;4920:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2248
JUMPV
LABELV $2249
line 4921
;4921:	multiPtr = (multiDef_t*)item->typeData;
ADDRLP4 1040
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4922
;4922:	multiPtr->count = 0;
ADDRLP4 1040
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 0
ASGNI4
line 4923
;4923:	multiPtr->strDef = qtrue;
ADDRLP4 1040
INDIRP4
CNSTI4 388
ADDP4
CNSTI4 1
ASGNI4
line 4925
;4924:
;4925:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 4
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
NEI4 $2251
line 4926
;4926:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2248
JUMPV
LABELV $2251
line 4927
;4927:	if (*token.string != '{') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $2253
line 4928
;4928:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2248
JUMPV
LABELV $2253
line 4931
;4929:	}
;4930:
;4931:	pass = 0;
ADDRLP4 1044
CNSTI4 0
ASGNI4
ADDRGP4 $2257
JUMPV
LABELV $2256
line 4932
;4932:	while ( 1 ) {
line 4933
;4933:		if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 4
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
NEI4 $2259
line 4934
;4934:			PC_SourceError(handle, "end of file inside menu item\n");
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $2261
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 4935
;4935:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2248
JUMPV
LABELV $2259
line 4938
;4936:		}
;4937:
;4938:		if (*token.string == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $2262
line 4939
;4939:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2248
JUMPV
LABELV $2262
line 4942
;4940:		}
;4941:
;4942:		if (*token.string == ',' || *token.string == ';') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 44
EQI4 $2269
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 59
NEI4 $2265
LABELV $2269
line 4943
;4943:			continue;
ADDRGP4 $2257
JUMPV
LABELV $2265
line 4946
;4944:		}
;4945:
;4946:		if (pass == 0) {
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $2270
line 4947
;4947:			multiPtr->cvarList[multiPtr->count] = String_Alloc(token.string);
ADDRLP4 0+16
ARGP4
ADDRLP4 1056
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRLP4 1040
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1040
INDIRP4
ADDP4
ADDRLP4 1056
INDIRP4
ASGNP4
line 4948
;4948:			pass = 1;
ADDRLP4 1044
CNSTI4 1
ASGNI4
line 4949
;4949:		} else {
ADDRGP4 $2271
JUMPV
LABELV $2270
line 4950
;4950:			multiPtr->cvarStr[multiPtr->count] = String_Alloc(token.string);
ADDRLP4 0+16
ARGP4
ADDRLP4 1056
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRLP4 1040
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1040
INDIRP4
CNSTI4 128
ADDP4
ADDP4
ADDRLP4 1056
INDIRP4
ASGNP4
line 4951
;4951:			pass = 0;
ADDRLP4 1044
CNSTI4 0
ASGNI4
line 4952
;4952:			multiPtr->count++;
ADDRLP4 1064
ADDRLP4 1040
INDIRP4
CNSTI4 384
ADDP4
ASGNP4
ADDRLP4 1064
INDIRP4
ADDRLP4 1064
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4953
;4953:			if (multiPtr->count >= MAX_MULTI_CVARS) {
ADDRLP4 1040
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 32
LTI4 $2274
line 4954
;4954:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2248
JUMPV
LABELV $2274
line 4956
;4955:			}
;4956:		}
LABELV $2271
line 4958
;4957:
;4958:	}
LABELV $2257
line 4932
ADDRGP4 $2256
JUMPV
line 4959
;4959:	return qfalse; 	// bk001205 - LCC missing return value
CNSTI4 0
RETI4
LABELV $2248
endproc ItemParse_cvarStrList 1068 8
export ItemParse_cvarFloatList
proc ItemParse_cvarFloatList 1072 8
line 4962
;4960:}
;4961:
;4962:qboolean ItemParse_cvarFloatList( itemDef_t *item, int handle ) {
line 4966
;4963:	pc_token_t token;
;4964:	multiDef_t *multiPtr;
;4965:	
;4966:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4967
;4967:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2277
line 4968
;4968:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2276
JUMPV
LABELV $2277
line 4969
;4969:	multiPtr = (multiDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4970
;4970:	multiPtr->count = 0;
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 0
ASGNI4
line 4971
;4971:	multiPtr->strDef = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 388
ADDP4
CNSTI4 0
ASGNI4
line 4973
;4972:
;4973:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 1044
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $2279
line 4974
;4974:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2276
JUMPV
LABELV $2279
line 4975
;4975:	if (*token.string != '{') {
ADDRLP4 4+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $2285
line 4976
;4976:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2276
JUMPV
LABELV $2284
line 4979
;4977:	}
;4978:
;4979:	while ( 1 ) {
line 4980
;4980:		if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 1048
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $2287
line 4981
;4981:			PC_SourceError(handle, "end of file inside menu item\n");
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $2261
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 4982
;4982:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2276
JUMPV
LABELV $2287
line 4985
;4983:		}
;4984:
;4985:		if (*token.string == '}') {
ADDRLP4 4+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $2289
line 4986
;4986:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2276
JUMPV
LABELV $2289
line 4989
;4987:		}
;4988:
;4989:		if (*token.string == ',' || *token.string == ';') {
ADDRLP4 4+16
INDIRI1
CVII4 1
CNSTI4 44
EQI4 $2296
ADDRLP4 4+16
INDIRI1
CVII4 1
CNSTI4 59
NEI4 $2292
LABELV $2296
line 4990
;4990:			continue;
ADDRGP4 $2285
JUMPV
LABELV $2292
line 4993
;4991:		}
;4992:
;4993:		multiPtr->cvarList[multiPtr->count] = String_Alloc(token.string);
ADDRLP4 4+16
ARGP4
ADDRLP4 1052
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
ADDP4
ADDRLP4 1052
INDIRP4
ASGNP4
line 4994
;4994:		if (!PC_Float_Parse(handle, &multiPtr->cvarValue[multiPtr->count])) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
ADDP4
ARGP4
ADDRLP4 1064
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $2298
line 4995
;4995:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2276
JUMPV
LABELV $2298
line 4998
;4996:		}
;4997:
;4998:		multiPtr->count++;
ADDRLP4 1068
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
ASGNP4
ADDRLP4 1068
INDIRP4
ADDRLP4 1068
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4999
;4999:		if (multiPtr->count >= MAX_MULTI_CVARS) {
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 32
LTI4 $2300
line 5000
;5000:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2276
JUMPV
LABELV $2300
line 5003
;5001:		}
;5002:
;5003:	}
LABELV $2285
line 4979
ADDRGP4 $2284
JUMPV
line 5004
;5004:	return qfalse; 	// bk001205 - LCC missing return value
CNSTI4 0
RETI4
LABELV $2276
endproc ItemParse_cvarFloatList 1072 8
export ItemParse_addColorRange
proc ItemParse_addColorRange 44 12
line 5009
;5005:}
;5006:
;5007:
;5008:
;5009:qboolean ItemParse_addColorRange( itemDef_t *item, int handle ) {
line 5012
;5010:	colorRangeDef_t color;
;5011:
;5012:	if (PC_Float_Parse(handle, &color.low) &&
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0+16
ARGP4
ADDRLP4 24
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $2303
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0+20
ARGP4
ADDRLP4 28
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2303
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 32
ADDRGP4 PC_Color_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $2303
line 5014
;5013:		PC_Float_Parse(handle, &color.high) &&
;5014:		PC_Color_Parse(handle, &color.color) ) {
line 5015
;5015:		if (item->numColors < MAX_COLOR_RANGES) {
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
CNSTI4 10
GEI4 $2307
line 5016
;5016:			memcpy(&item->colorRanges[item->numColors], &color, sizeof(color));
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
CNSTI4 24
MULI4
ADDRLP4 36
INDIRP4
CNSTI4 288
ADDP4
ADDP4
ARGP4
ADDRLP4 0
ARGP4
CNSTU4 24
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 5017
;5017:			item->numColors++;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5018
;5018:		}
LABELV $2307
line 5019
;5019:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2302
JUMPV
LABELV $2303
line 5021
;5020:	}
;5021:	return qfalse;
CNSTI4 0
RETI4
LABELV $2302
endproc ItemParse_addColorRange 44 12
export ItemParse_ownerdrawFlag
proc ItemParse_ownerdrawFlag 12 8
line 5024
;5022:}
;5023:
;5024:qboolean ItemParse_ownerdrawFlag( itemDef_t *item, int handle ) {
line 5026
;5025:	int i;
;5026:	if (!PC_Int_Parse(handle, &i)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2310
line 5027
;5027:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2309
JUMPV
LABELV $2310
line 5029
;5028:	}
;5029:	item->window.ownerDrawFlags |= i;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
BORI4
ASGNI4
line 5030
;5030:	return qtrue;
CNSTI4 1
RETI4
LABELV $2309
endproc ItemParse_ownerdrawFlag 12 8
export ItemParse_enableCvar
proc ItemParse_enableCvar 4 8
line 5033
;5031:}
;5032:
;5033:qboolean ItemParse_enableCvar( itemDef_t *item, int handle ) {
line 5034
;5034:	if (PC_Script_Parse(handle, &item->enableCvar)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2313
line 5035
;5035:		item->cvarFlags = CVAR_ENABLE;
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
CNSTI4 1
ASGNI4
line 5036
;5036:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2312
JUMPV
LABELV $2313
line 5038
;5037:	}
;5038:	return qfalse;
CNSTI4 0
RETI4
LABELV $2312
endproc ItemParse_enableCvar 4 8
export ItemParse_disableCvar
proc ItemParse_disableCvar 4 8
line 5041
;5039:}
;5040:
;5041:qboolean ItemParse_disableCvar( itemDef_t *item, int handle ) {
line 5042
;5042:	if (PC_Script_Parse(handle, &item->enableCvar)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2316
line 5043
;5043:		item->cvarFlags = CVAR_DISABLE;
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
CNSTI4 2
ASGNI4
line 5044
;5044:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2315
JUMPV
LABELV $2316
line 5046
;5045:	}
;5046:	return qfalse;
CNSTI4 0
RETI4
LABELV $2315
endproc ItemParse_disableCvar 4 8
export ItemParse_showCvar
proc ItemParse_showCvar 4 8
line 5049
;5047:}
;5048:
;5049:qboolean ItemParse_showCvar( itemDef_t *item, int handle ) {
line 5050
;5050:	if (PC_Script_Parse(handle, &item->enableCvar)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2319
line 5051
;5051:		item->cvarFlags = CVAR_SHOW;
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
CNSTI4 4
ASGNI4
line 5052
;5052:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2318
JUMPV
LABELV $2319
line 5054
;5053:	}
;5054:	return qfalse;
CNSTI4 0
RETI4
LABELV $2318
endproc ItemParse_showCvar 4 8
export ItemParse_hideCvar
proc ItemParse_hideCvar 4 8
line 5057
;5055:}
;5056:
;5057:qboolean ItemParse_hideCvar( itemDef_t *item, int handle ) {
line 5058
;5058:	if (PC_Script_Parse(handle, &item->enableCvar)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2322
line 5059
;5059:		item->cvarFlags = CVAR_HIDE;
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
CNSTI4 8
ASGNI4
line 5060
;5060:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2321
JUMPV
LABELV $2322
line 5062
;5061:	}
;5062:	return qfalse;
CNSTI4 0
RETI4
LABELV $2321
endproc ItemParse_hideCvar 4 8
data
export itemParseKeywords
align 4
LABELV itemParseKeywords
address $2324
address ItemParse_name
byte 4 0
address $2325
address ItemParse_text
byte 4 0
address $2326
address ItemParse_group
byte 4 0
address $2327
address ItemParse_asset_model
byte 4 0
address $2328
address ItemParse_asset_shader
byte 4 0
address $2329
address ItemParse_model_origin
byte 4 0
address $2330
address ItemParse_model_fovx
byte 4 0
address $2331
address ItemParse_model_fovy
byte 4 0
address $2332
address ItemParse_model_rotation
byte 4 0
address $2333
address ItemParse_model_angle
byte 4 0
address $2334
address ItemParse_rect
byte 4 0
address $2335
address ItemParse_style
byte 4 0
address $2336
address ItemParse_decoration
byte 4 0
address $2337
address ItemParse_notselectable
byte 4 0
address $2338
address ItemParse_wrapped
byte 4 0
address $2339
address ItemParse_autowrapped
byte 4 0
address $2340
address ItemParse_horizontalscroll
byte 4 0
address $2341
address ItemParse_type
byte 4 0
address $2342
address ItemParse_elementwidth
byte 4 0
address $2343
address ItemParse_elementheight
byte 4 0
address $2344
address ItemParse_feeder
byte 4 0
address $2345
address ItemParse_elementtype
byte 4 0
address $2346
address ItemParse_columns
byte 4 0
address $2347
address ItemParse_border
byte 4 0
address $2348
address ItemParse_bordersize
byte 4 0
address $2349
address ItemParse_visible
byte 4 0
address $2350
address ItemParse_ownerdraw
byte 4 0
address $2351
address ItemParse_align
byte 4 0
address $2352
address ItemParse_textalign
byte 4 0
address $2353
address ItemParse_textalignx
byte 4 0
address $2354
address ItemParse_textaligny
byte 4 0
address $2355
address ItemParse_textscale
byte 4 0
address $2356
address ItemParse_textstyle
byte 4 0
address $364
address ItemParse_backcolor
byte 4 0
address $367
address ItemParse_forecolor
byte 4 0
address $370
address ItemParse_bordercolor
byte 4 0
address $2357
address ItemParse_outlinecolor
byte 4 0
address $2358
address ItemParse_background
byte 4 0
address $2359
address ItemParse_onFocus
byte 4 0
address $2360
address ItemParse_leaveFocus
byte 4 0
address $2361
address ItemParse_mouseEnter
byte 4 0
address $2362
address ItemParse_mouseExit
byte 4 0
address $2363
address ItemParse_mouseEnterText
byte 4 0
address $2364
address ItemParse_mouseExitText
byte 4 0
address $2365
address ItemParse_action
byte 4 0
address $2366
address ItemParse_special
byte 4 0
address $2367
address ItemParse_cvar
byte 4 0
address $2368
address ItemParse_maxChars
byte 4 0
address $2369
address ItemParse_maxPaintChars
byte 4 0
address $2370
address ItemParse_focusSound
byte 4 0
address $2371
address ItemParse_cvarFloat
byte 4 0
address $2372
address ItemParse_cvarStrList
byte 4 0
address $2373
address ItemParse_cvarFloatList
byte 4 0
address $2374
address ItemParse_addColorRange
byte 4 0
address $2375
address ItemParse_ownerdrawFlag
byte 4 0
address $2376
address ItemParse_enableCvar
byte 4 0
address $2377
address ItemParse_cvarTest
byte 4 0
address $2378
address ItemParse_disableCvar
byte 4 0
address $2379
address ItemParse_showCvar
byte 4 0
address $2380
address ItemParse_hideCvar
byte 4 0
address $2381
address ItemParse_cinematic
byte 4 0
address $2382
address ItemParse_doubleClick
byte 4 0
byte 4 0
byte 4 0
byte 4 0
export Item_SetupKeywordHash
code
proc Item_SetupKeywordHash 4 12
line 5139
;5063:}
;5064:
;5065:
;5066:keywordHash_t itemParseKeywords[] = {
;5067:	{"name", ItemParse_name, NULL},
;5068:	{"text", ItemParse_text, NULL},
;5069:	{"group", ItemParse_group, NULL},
;5070:	{"asset_model", ItemParse_asset_model, NULL},
;5071:	{"asset_shader", ItemParse_asset_shader, NULL},
;5072:	{"model_origin", ItemParse_model_origin, NULL},
;5073:	{"model_fovx", ItemParse_model_fovx, NULL},
;5074:	{"model_fovy", ItemParse_model_fovy, NULL},
;5075:	{"model_rotation", ItemParse_model_rotation, NULL},
;5076:	{"model_angle", ItemParse_model_angle, NULL},
;5077:	{"rect", ItemParse_rect, NULL},
;5078:	{"style", ItemParse_style, NULL},
;5079:	{"decoration", ItemParse_decoration, NULL},
;5080:	{"notselectable", ItemParse_notselectable, NULL},
;5081:	{"wrapped", ItemParse_wrapped, NULL},
;5082:	{"autowrapped", ItemParse_autowrapped, NULL},
;5083:	{"horizontalscroll", ItemParse_horizontalscroll, NULL},
;5084:	{"type", ItemParse_type, NULL},
;5085:	{"elementwidth", ItemParse_elementwidth, NULL},
;5086:	{"elementheight", ItemParse_elementheight, NULL},
;5087:	{"feeder", ItemParse_feeder, NULL},
;5088:	{"elementtype", ItemParse_elementtype, NULL},
;5089:	{"columns", ItemParse_columns, NULL},
;5090:	{"border", ItemParse_border, NULL},
;5091:	{"bordersize", ItemParse_bordersize, NULL},
;5092:	{"visible", ItemParse_visible, NULL},
;5093:	{"ownerdraw", ItemParse_ownerdraw, NULL},
;5094:	{"align", ItemParse_align, NULL},
;5095:	{"textalign", ItemParse_textalign, NULL},
;5096:	{"textalignx", ItemParse_textalignx, NULL},
;5097:	{"textaligny", ItemParse_textaligny, NULL},
;5098:	{"textscale", ItemParse_textscale, NULL},
;5099:	{"textstyle", ItemParse_textstyle, NULL},
;5100:	{"backcolor", ItemParse_backcolor, NULL},
;5101:	{"forecolor", ItemParse_forecolor, NULL},
;5102:	{"bordercolor", ItemParse_bordercolor, NULL},
;5103:	{"outlinecolor", ItemParse_outlinecolor, NULL},
;5104:	{"background", ItemParse_background, NULL},
;5105:	{"onFocus", ItemParse_onFocus, NULL},
;5106:	{"leaveFocus", ItemParse_leaveFocus, NULL},
;5107:	{"mouseEnter", ItemParse_mouseEnter, NULL},
;5108:	{"mouseExit", ItemParse_mouseExit, NULL},
;5109:	{"mouseEnterText", ItemParse_mouseEnterText, NULL},
;5110:	{"mouseExitText", ItemParse_mouseExitText, NULL},
;5111:	{"action", ItemParse_action, NULL},
;5112:	{"special", ItemParse_special, NULL},
;5113:	{"cvar", ItemParse_cvar, NULL},
;5114:	{"maxChars", ItemParse_maxChars, NULL},
;5115:	{"maxPaintChars", ItemParse_maxPaintChars, NULL},
;5116:	{"focusSound", ItemParse_focusSound, NULL},
;5117:	{"cvarFloat", ItemParse_cvarFloat, NULL},
;5118:	{"cvarStrList", ItemParse_cvarStrList, NULL},
;5119:	{"cvarFloatList", ItemParse_cvarFloatList, NULL},
;5120:	{"addColorRange", ItemParse_addColorRange, NULL},
;5121:	{"ownerdrawFlag", ItemParse_ownerdrawFlag, NULL},
;5122:	{"enableCvar", ItemParse_enableCvar, NULL},
;5123:	{"cvarTest", ItemParse_cvarTest, NULL},
;5124:	{"disableCvar", ItemParse_disableCvar, NULL},
;5125:	{"showCvar", ItemParse_showCvar, NULL},
;5126:	{"hideCvar", ItemParse_hideCvar, NULL},
;5127:	{"cinematic", ItemParse_cinematic, NULL},
;5128:	{"doubleclick", ItemParse_doubleClick, NULL},
;5129:	{NULL, NULL, NULL}
;5130:};
;5131:
;5132:keywordHash_t *itemParseKeywordHash[KEYWORDHASH_SIZE];
;5133:
;5134:/*
;5135:===============
;5136:Item_SetupKeywordHash
;5137:===============
;5138:*/
;5139:void Item_SetupKeywordHash(void) {
line 5142
;5140:	int i;
;5141:
;5142:	memset(itemParseKeywordHash, 0, sizeof(itemParseKeywordHash));
ADDRGP4 itemParseKeywordHash
ARGP4
CNSTI4 0
ARGI4
CNSTU4 2048
ARGU4
ADDRGP4 memset
CALLP4
pop
line 5143
;5143:	for (i = 0; itemParseKeywords[i].keyword; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2387
JUMPV
LABELV $2384
line 5144
;5144:		KeywordHash_Add(itemParseKeywordHash, &itemParseKeywords[i]);
ADDRGP4 itemParseKeywordHash
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 itemParseKeywords
ADDP4
ARGP4
ADDRGP4 KeywordHash_Add
CALLV
pop
line 5145
;5145:	}
LABELV $2385
line 5143
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2387
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 itemParseKeywords
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2384
line 5146
;5146:}
LABELV $2383
endproc Item_SetupKeywordHash 4 12
export Item_Parse
proc Item_Parse 1060 12
line 5153
;5147:
;5148:/*
;5149:===============
;5150:Item_Parse
;5151:===============
;5152:*/
;5153:qboolean Item_Parse(int handle, itemDef_t *item) {
line 5158
;5154:	pc_token_t token;
;5155:	keywordHash_t *key;
;5156:
;5157:
;5158:	if (!trap_PC_ReadToken(handle, &token))
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
NEI4 $2389
line 5159
;5159:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2388
JUMPV
LABELV $2389
line 5160
;5160:	if (*token.string != '{') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $2395
line 5161
;5161:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2388
JUMPV
LABELV $2394
line 5163
;5162:	}
;5163:	while ( 1 ) {
line 5164
;5164:		if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 0
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
NEI4 $2397
line 5165
;5165:			PC_SourceError(handle, "end of file inside menu item\n");
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $2261
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 5166
;5166:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2388
JUMPV
LABELV $2397
line 5169
;5167:		}
;5168:
;5169:		if (*token.string == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $2399
line 5170
;5170:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2388
JUMPV
LABELV $2399
line 5173
;5171:		}
;5172:
;5173:		key = KeywordHash_Find(itemParseKeywordHash, token.string);
ADDRGP4 itemParseKeywordHash
ARGP4
ADDRLP4 0+16
ARGP4
ADDRLP4 1052
ADDRGP4 KeywordHash_Find
CALLP4
ASGNP4
ADDRLP4 1040
ADDRLP4 1052
INDIRP4
ASGNP4
line 5174
;5174:		if (!key) {
ADDRLP4 1040
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2403
line 5175
;5175:			PC_SourceError(handle, "unknown menu item keyword %s", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $2405
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 5176
;5176:			continue;
ADDRGP4 $2395
JUMPV
LABELV $2403
line 5178
;5177:		}
;5178:		if ( !key->func(item, handle) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1056
ADDRLP4 1040
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $2407
line 5179
;5179:			PC_SourceError(handle, "couldn't parse menu item keyword %s", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $2409
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 5180
;5180:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2388
JUMPV
LABELV $2407
line 5182
;5181:		}
;5182:	}
LABELV $2395
line 5163
ADDRGP4 $2394
JUMPV
line 5183
;5183:	return qfalse; 	// bk001205 - LCC missing return value
CNSTI4 0
RETI4
LABELV $2388
endproc Item_Parse 1060 12
export Item_InitControls
proc Item_InitControls 4 0
line 5189
;5184:}
;5185:
;5186:
;5187:// Item_InitControls
;5188:// init's special control types
;5189:void Item_InitControls(itemDef_t *item) {
line 5190
;5190:	if (item == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2412
line 5191
;5191:		return;
ADDRGP4 $2411
JUMPV
LABELV $2412
line 5193
;5192:	}
;5193:	if (item->type == ITEM_TYPE_LISTBOX) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 6
NEI4 $2414
line 5194
;5194:		listBoxDef_t *listPtr = (listBoxDef_t*)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 5195
;5195:		item->cursorPos = 0;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 0
ASGNI4
line 5196
;5196:		if (listPtr) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2416
line 5197
;5197:			listPtr->cursorPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 5198
;5198:			listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 5199
;5199:			listPtr->endPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 5200
;5200:			listPtr->cursorPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 5201
;5201:		}
LABELV $2416
line 5202
;5202:	}
LABELV $2414
line 5203
;5203:}
LABELV $2411
endproc Item_InitControls 4 0
export MenuParse_font
proc MenuParse_font 12 12
line 5211
;5204:
;5205:/*
;5206:===============
;5207:Menu Keyword Parse functions
;5208:===============
;5209:*/
;5210:
;5211:qboolean MenuParse_font( itemDef_t *item, int handle ) {
line 5212
;5212:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5213
;5213:	if (!PC_String_Parse(handle, &menu->font)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2419
line 5214
;5214:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2418
JUMPV
LABELV $2419
line 5216
;5215:	}
;5216:	if (!DC->Assets.fontRegistered) {
ADDRGP4 DC
INDIRP4
CNSTI4 61992
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2421
line 5217
;5217:		DC->registerFont(menu->font, 48, &DC->Assets.textFont);
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRP4
ARGP4
CNSTI4 48
ARGI4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 240
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 64
ADDP4
INDIRP4
CALLV
pop
line 5218
;5218:		DC->Assets.fontRegistered = qtrue;
ADDRGP4 DC
INDIRP4
CNSTI4 61992
ADDP4
CNSTI4 1
ASGNI4
line 5219
;5219:	}
LABELV $2421
line 5220
;5220:	return qtrue;
CNSTI4 1
RETI4
LABELV $2418
endproc MenuParse_font 12 12
export MenuParse_name
proc MenuParse_name 12 8
line 5223
;5221:}
;5222:
;5223:qboolean MenuParse_name( itemDef_t *item, int handle ) {
line 5224
;5224:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5225
;5225:	if (!PC_String_Parse(handle, &menu->window.name)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2424
line 5226
;5226:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2423
JUMPV
LABELV $2424
line 5228
;5227:	}
;5228:	if (Q_stricmp(menu->window.name, "main") == 0) {
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
ARGP4
ADDRGP4 $2428
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2426
line 5231
;5229:		// default main as having focus
;5230:		//menu->window.flags |= WINDOW_HASFOCUS;
;5231:	}
LABELV $2426
line 5232
;5232:	return qtrue;
CNSTI4 1
RETI4
LABELV $2423
endproc MenuParse_name 12 8
export MenuParse_fullscreen
proc MenuParse_fullscreen 8 8
line 5235
;5233:}
;5234:
;5235:qboolean MenuParse_fullscreen( itemDef_t *item, int handle ) {
line 5236
;5236:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5237
;5237:	if (!PC_Int_Parse(handle, (int*) &menu->fullScreen)) { // bk001206 - cast qboolean
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2430
line 5238
;5238:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2429
JUMPV
LABELV $2430
line 5240
;5239:	}
;5240:	return qtrue;
CNSTI4 1
RETI4
LABELV $2429
endproc MenuParse_fullscreen 8 8
export MenuParse_rect
proc MenuParse_rect 8 8
line 5243
;5241:}
;5242:
;5243:qboolean MenuParse_rect( itemDef_t *item, int handle ) {
line 5244
;5244:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5245
;5245:	if (!PC_Rect_Parse(handle, &menu->window.rect)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Rect_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2433
line 5246
;5246:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2432
JUMPV
LABELV $2433
line 5248
;5247:	}
;5248:	return qtrue;
CNSTI4 1
RETI4
LABELV $2432
endproc MenuParse_rect 8 8
export MenuParse_style
proc MenuParse_style 8 8
line 5251
;5249:}
;5250:
;5251:qboolean MenuParse_style( itemDef_t *item, int handle ) {
line 5252
;5252:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5253
;5253:	if (!PC_Int_Parse(handle, &menu->window.style)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2436
line 5254
;5254:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2435
JUMPV
LABELV $2436
line 5256
;5255:	}
;5256:	return qtrue;
CNSTI4 1
RETI4
LABELV $2435
endproc MenuParse_style 8 8
export MenuParse_visible
proc MenuParse_visible 16 8
line 5259
;5257:}
;5258:
;5259:qboolean MenuParse_visible( itemDef_t *item, int handle ) {
line 5261
;5260:	int i;
;5261:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 5263
;5262:
;5263:	if (!PC_Int_Parse(handle, &i)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2439
line 5264
;5264:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2438
JUMPV
LABELV $2439
line 5266
;5265:	}
;5266:	if (i) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2441
line 5267
;5267:		menu->window.flags |= WINDOW_VISIBLE;
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 5268
;5268:	}
LABELV $2441
line 5269
;5269:	return qtrue;
CNSTI4 1
RETI4
LABELV $2438
endproc MenuParse_visible 16 8
export MenuParse_onOpen
proc MenuParse_onOpen 8 8
line 5272
;5270:}
;5271:
;5272:qboolean MenuParse_onOpen( itemDef_t *item, int handle ) {
line 5273
;5273:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5274
;5274:	if (!PC_Script_Parse(handle, &menu->onOpen)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2444
line 5275
;5275:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2443
JUMPV
LABELV $2444
line 5277
;5276:	}
;5277:	return qtrue;
CNSTI4 1
RETI4
LABELV $2443
endproc MenuParse_onOpen 8 8
export MenuParse_onClose
proc MenuParse_onClose 8 8
line 5280
;5278:}
;5279:
;5280:qboolean MenuParse_onClose( itemDef_t *item, int handle ) {
line 5281
;5281:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5282
;5282:	if (!PC_Script_Parse(handle, &menu->onClose)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2447
line 5283
;5283:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2446
JUMPV
LABELV $2447
line 5285
;5284:	}
;5285:	return qtrue;
CNSTI4 1
RETI4
LABELV $2446
endproc MenuParse_onClose 8 8
export MenuParse_onESC
proc MenuParse_onESC 8 8
line 5288
;5286:}
;5287:
;5288:qboolean MenuParse_onESC( itemDef_t *item, int handle ) {
line 5289
;5289:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5290
;5290:	if (!PC_Script_Parse(handle, &menu->onESC)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 220
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2450
line 5291
;5291:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2449
JUMPV
LABELV $2450
line 5293
;5292:	}
;5293:	return qtrue;
CNSTI4 1
RETI4
LABELV $2449
endproc MenuParse_onESC 8 8
export MenuParse_border
proc MenuParse_border 8 8
line 5298
;5294:}
;5295:
;5296:
;5297:
;5298:qboolean MenuParse_border( itemDef_t *item, int handle ) {
line 5299
;5299:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5300
;5300:	if (!PC_Int_Parse(handle, &menu->window.border)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2453
line 5301
;5301:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2452
JUMPV
LABELV $2453
line 5303
;5302:	}
;5303:	return qtrue;
CNSTI4 1
RETI4
LABELV $2452
endproc MenuParse_border 8 8
export MenuParse_borderSize
proc MenuParse_borderSize 8 8
line 5306
;5304:}
;5305:
;5306:qboolean MenuParse_borderSize( itemDef_t *item, int handle ) {
line 5307
;5307:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5308
;5308:	if (!PC_Float_Parse(handle, &menu->window.borderSize)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2456
line 5309
;5309:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2455
JUMPV
LABELV $2456
line 5311
;5310:	}
;5311:	return qtrue;
CNSTI4 1
RETI4
LABELV $2455
endproc MenuParse_borderSize 8 8
export MenuParse_backcolor
proc MenuParse_backcolor 16 8
line 5314
;5312:}
;5313:
;5314:qboolean MenuParse_backcolor( itemDef_t *item, int handle ) {
line 5317
;5315:	int i;
;5316:	float f;
;5317:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
line 5319
;5318:
;5319:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2459
line 5320
;5320:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2463
line 5321
;5321:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2458
JUMPV
LABELV $2463
line 5323
;5322:		}
;5323:		menu->window.backColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 128
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 5324
;5324:	}
LABELV $2460
line 5319
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2459
line 5325
;5325:	return qtrue;
CNSTI4 1
RETI4
LABELV $2458
endproc MenuParse_backcolor 16 8
export MenuParse_forecolor
proc MenuParse_forecolor 20 8
line 5328
;5326:}
;5327:
;5328:qboolean MenuParse_forecolor( itemDef_t *item, int handle ) {
line 5331
;5329:	int i;
;5330:	float f;
;5331:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 5333
;5332:
;5333:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2466
line 5334
;5334:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2470
line 5335
;5335:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2465
JUMPV
LABELV $2470
line 5337
;5336:		}
;5337:		menu->window.foreColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 112
ADDP4
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
line 5338
;5338:		menu->window.flags |= WINDOW_FORECOLORSET;
ADDRLP4 16
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 5339
;5339:	}
LABELV $2467
line 5333
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2466
line 5340
;5340:	return qtrue;
CNSTI4 1
RETI4
LABELV $2465
endproc MenuParse_forecolor 20 8
export MenuParse_bordercolor
proc MenuParse_bordercolor 16 8
line 5343
;5341:}
;5342:
;5343:qboolean MenuParse_bordercolor( itemDef_t *item, int handle ) {
line 5346
;5344:	int i;
;5345:	float f;
;5346:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
line 5348
;5347:
;5348:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2473
line 5349
;5349:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2477
line 5350
;5350:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2472
JUMPV
LABELV $2477
line 5352
;5351:		}
;5352:		menu->window.borderColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 144
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 5353
;5353:	}
LABELV $2474
line 5348
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2473
line 5354
;5354:	return qtrue;
CNSTI4 1
RETI4
LABELV $2472
endproc MenuParse_bordercolor 16 8
export MenuParse_focuscolor
proc MenuParse_focuscolor 16 8
line 5357
;5355:}
;5356:
;5357:qboolean MenuParse_focuscolor( itemDef_t *item, int handle ) {
line 5360
;5358:	int i;
;5359:	float f;
;5360:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
line 5362
;5361:
;5362:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2480
line 5363
;5363:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2484
line 5364
;5364:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2479
JUMPV
LABELV $2484
line 5366
;5365:		}
;5366:		menu->focusColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 228
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 5367
;5367:	}
LABELV $2481
line 5362
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2480
line 5368
;5368:	return qtrue;
CNSTI4 1
RETI4
LABELV $2479
endproc MenuParse_focuscolor 16 8
export MenuParse_disablecolor
proc MenuParse_disablecolor 16 8
line 5371
;5369:}
;5370:
;5371:qboolean MenuParse_disablecolor( itemDef_t *item, int handle ) {
line 5374
;5372:	int i;
;5373:	float f;
;5374:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
line 5375
;5375:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2487
line 5376
;5376:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2491
line 5377
;5377:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2486
JUMPV
LABELV $2491
line 5379
;5378:		}
;5379:		menu->disableColor[i]  = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 244
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 5380
;5380:	}
LABELV $2488
line 5375
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2487
line 5381
;5381:	return qtrue;
CNSTI4 1
RETI4
LABELV $2486
endproc MenuParse_disablecolor 16 8
export MenuParse_outlinecolor
proc MenuParse_outlinecolor 8 8
line 5385
;5382:}
;5383:
;5384:
;5385:qboolean MenuParse_outlinecolor( itemDef_t *item, int handle ) {
line 5386
;5386:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5387
;5387:	if (!PC_Color_Parse(handle, &menu->window.outlineColor)){
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Color_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2494
line 5388
;5388:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2493
JUMPV
LABELV $2494
line 5390
;5389:	}
;5390:	return qtrue;
CNSTI4 1
RETI4
LABELV $2493
endproc MenuParse_outlinecolor 8 8
export MenuParse_background
proc MenuParse_background 16 8
line 5393
;5391:}
;5392:
;5393:qboolean MenuParse_background( itemDef_t *item, int handle ) {
line 5395
;5394:	const char *buff;
;5395:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 5397
;5396:
;5397:	if (!PC_String_Parse(handle, &buff)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2497
line 5398
;5398:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2496
JUMPV
LABELV $2497
line 5400
;5399:	}
;5400:	menu->window.background = DC->registerShaderNoMip(buff);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 176
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 5401
;5401:	return qtrue;
CNSTI4 1
RETI4
LABELV $2496
endproc MenuParse_background 16 8
export MenuParse_cinematic
proc MenuParse_cinematic 8 8
line 5404
;5402:}
;5403:
;5404:qboolean MenuParse_cinematic( itemDef_t *item, int handle ) {
line 5405
;5405:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5407
;5406:
;5407:	if (!PC_String_Parse(handle, &menu->window.cinematicName)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2500
line 5408
;5408:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2499
JUMPV
LABELV $2500
line 5410
;5409:	}
;5410:	return qtrue;
CNSTI4 1
RETI4
LABELV $2499
endproc MenuParse_cinematic 8 8
export MenuParse_ownerdrawFlag
proc MenuParse_ownerdrawFlag 16 8
line 5413
;5411:}
;5412:
;5413:qboolean MenuParse_ownerdrawFlag( itemDef_t *item, int handle ) {
line 5415
;5414:	int i;
;5415:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 5417
;5416:
;5417:	if (!PC_Int_Parse(handle, &i)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2503
line 5418
;5418:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2502
JUMPV
LABELV $2503
line 5420
;5419:	}
;5420:	menu->window.ownerDrawFlags |= i;
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 60
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
BORI4
ASGNI4
line 5421
;5421:	return qtrue;
CNSTI4 1
RETI4
LABELV $2502
endproc MenuParse_ownerdrawFlag 16 8
export MenuParse_ownerdraw
proc MenuParse_ownerdraw 8 8
line 5424
;5422:}
;5423:
;5424:qboolean MenuParse_ownerdraw( itemDef_t *item, int handle ) {
line 5425
;5425:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5427
;5426:
;5427:	if (!PC_Int_Parse(handle, &menu->window.ownerDraw)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2506
line 5428
;5428:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2505
JUMPV
LABELV $2506
line 5430
;5429:	}
;5430:	return qtrue;
CNSTI4 1
RETI4
LABELV $2505
endproc MenuParse_ownerdraw 8 8
export MenuParse_popup
proc MenuParse_popup 8 0
line 5435
;5431:}
;5432:
;5433:
;5434:// decoration
;5435:qboolean MenuParse_popup( itemDef_t *item, int handle ) {
line 5436
;5436:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5437
;5437:	menu->window.flags |= WINDOW_POPUP;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 2097152
BORI4
ASGNI4
line 5438
;5438:	return qtrue;
CNSTI4 1
RETI4
LABELV $2508
endproc MenuParse_popup 8 0
export MenuParse_outOfBounds
proc MenuParse_outOfBounds 8 0
line 5442
;5439:}
;5440:
;5441:
;5442:qboolean MenuParse_outOfBounds( itemDef_t *item, int handle ) {
line 5443
;5443:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5445
;5444:
;5445:	menu->window.flags |= WINDOW_OOB_CLICK;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 131072
BORI4
ASGNI4
line 5446
;5446:	return qtrue;
CNSTI4 1
RETI4
LABELV $2509
endproc MenuParse_outOfBounds 8 0
export MenuParse_soundLoop
proc MenuParse_soundLoop 8 8
line 5449
;5447:}
;5448:
;5449:qboolean MenuParse_soundLoop( itemDef_t *item, int handle ) {
line 5450
;5450:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5452
;5451:
;5452:	if (!PC_String_Parse(handle, &menu->soundName)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 224
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2511
line 5453
;5453:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2510
JUMPV
LABELV $2511
line 5455
;5454:	}
;5455:	return qtrue;
CNSTI4 1
RETI4
LABELV $2510
endproc MenuParse_soundLoop 8 8
export MenuParse_fadeClamp
proc MenuParse_fadeClamp 8 8
line 5458
;5456:}
;5457:
;5458:qboolean MenuParse_fadeClamp( itemDef_t *item, int handle ) {
line 5459
;5459:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5461
;5460:
;5461:	if (!PC_Float_Parse(handle, &menu->fadeClamp)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2514
line 5462
;5462:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2513
JUMPV
LABELV $2514
line 5464
;5463:	}
;5464:	return qtrue;
CNSTI4 1
RETI4
LABELV $2513
endproc MenuParse_fadeClamp 8 8
export MenuParse_fadeAmount
proc MenuParse_fadeAmount 8 8
line 5467
;5465:}
;5466:
;5467:qboolean MenuParse_fadeAmount( itemDef_t *item, int handle ) {
line 5468
;5468:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5470
;5469:
;5470:	if (!PC_Float_Parse(handle, &menu->fadeAmount)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2517
line 5471
;5471:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2516
JUMPV
LABELV $2517
line 5473
;5472:	}
;5473:	return qtrue;
CNSTI4 1
RETI4
LABELV $2516
endproc MenuParse_fadeAmount 8 8
export MenuParse_fadeCycle
proc MenuParse_fadeCycle 8 8
line 5477
;5474:}
;5475:
;5476:
;5477:qboolean MenuParse_fadeCycle( itemDef_t *item, int handle ) {
line 5478
;5478:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5480
;5479:
;5480:	if (!PC_Int_Parse(handle, &menu->fadeCycle)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2520
line 5481
;5481:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2519
JUMPV
LABELV $2520
line 5483
;5482:	}
;5483:	return qtrue;
CNSTI4 1
RETI4
LABELV $2519
endproc MenuParse_fadeCycle 8 8
export MenuParse_itemDef
proc MenuParse_itemDef 40 8
line 5487
;5484:}
;5485:
;5486:
;5487:qboolean MenuParse_itemDef( itemDef_t *item, int handle ) {
line 5488
;5488:	menuDef_t *menu = (menuDef_t*)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5489
;5489:	if (menu->itemCount < MAX_MENUITEMS) {
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 96
GEI4 $2523
line 5490
;5490:		menu->items[menu->itemCount] = UI_Alloc(sizeof(itemDef_t));
CNSTI4 540
ARGI4
ADDRLP4 4
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 5491
;5491:		Item_Init(menu->items[menu->itemCount]);
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_Init
CALLV
pop
line 5492
;5492:		if (!Item_Parse(handle, menu->items[menu->itemCount])) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Item_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $2525
line 5493
;5493:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2522
JUMPV
LABELV $2525
line 5495
;5494:		}
;5495:		Item_InitControls(menu->items[menu->itemCount]);
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_InitControls
CALLV
pop
line 5496
;5496:		menu->items[menu->itemCount++]->parent = menu;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
ASGNP4
ADDRLP4 28
ADDRLP4 32
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRP4
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 228
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 5497
;5497:	}
LABELV $2523
line 5498
;5498:	return qtrue;
CNSTI4 1
RETI4
LABELV $2522
endproc MenuParse_itemDef 40 8
data
export menuParseKeywords
align 4
LABELV menuParseKeywords
address $2527
address MenuParse_font
byte 4 0
address $2324
address MenuParse_name
byte 4 0
address $2528
address MenuParse_fullscreen
byte 4 0
address $2334
address MenuParse_rect
byte 4 0
address $2335
address MenuParse_style
byte 4 0
address $2349
address MenuParse_visible
byte 4 0
address $2529
address MenuParse_onOpen
byte 4 0
address $2530
address MenuParse_onClose
byte 4 0
address $2531
address MenuParse_onESC
byte 4 0
address $2347
address MenuParse_border
byte 4 0
address $2532
address MenuParse_borderSize
byte 4 0
address $364
address MenuParse_backcolor
byte 4 0
address $367
address MenuParse_forecolor
byte 4 0
address $370
address MenuParse_bordercolor
byte 4 0
address $2533
address MenuParse_focuscolor
byte 4 0
address $2534
address MenuParse_disablecolor
byte 4 0
address $2357
address MenuParse_outlinecolor
byte 4 0
address $2358
address MenuParse_background
byte 4 0
address $2350
address MenuParse_ownerdraw
byte 4 0
address $2375
address MenuParse_ownerdrawFlag
byte 4 0
address $2535
address MenuParse_outOfBounds
byte 4 0
address $2536
address MenuParse_soundLoop
byte 4 0
address $2537
address MenuParse_itemDef
byte 4 0
address $2381
address MenuParse_cinematic
byte 4 0
address $2538
address MenuParse_popup
byte 4 0
address $2539
address MenuParse_fadeClamp
byte 4 0
address $2540
address MenuParse_fadeCycle
byte 4 0
address $2541
address MenuParse_fadeAmount
byte 4 0
byte 4 0
byte 4 0
byte 4 0
export Menu_SetupKeywordHash
code
proc Menu_SetupKeywordHash 4 12
line 5540
;5499:}
;5500:
;5501:keywordHash_t menuParseKeywords[] = {
;5502:	{"font", MenuParse_font, NULL},
;5503:	{"name", MenuParse_name, NULL},
;5504:	{"fullscreen", MenuParse_fullscreen, NULL},
;5505:	{"rect", MenuParse_rect, NULL},
;5506:	{"style", MenuParse_style, NULL},
;5507:	{"visible", MenuParse_visible, NULL},
;5508:	{"onOpen", MenuParse_onOpen, NULL},
;5509:	{"onClose", MenuParse_onClose, NULL},
;5510:	{"onESC", MenuParse_onESC, NULL},
;5511:	{"border", MenuParse_border, NULL},
;5512:	{"borderSize", MenuParse_borderSize, NULL},
;5513:	{"backcolor", MenuParse_backcolor, NULL},
;5514:	{"forecolor", MenuParse_forecolor, NULL},
;5515:	{"bordercolor", MenuParse_bordercolor, NULL},
;5516:	{"focuscolor", MenuParse_focuscolor, NULL},
;5517:	{"disablecolor", MenuParse_disablecolor, NULL},
;5518:	{"outlinecolor", MenuParse_outlinecolor, NULL},
;5519:	{"background", MenuParse_background, NULL},
;5520:	{"ownerdraw", MenuParse_ownerdraw, NULL},
;5521:	{"ownerdrawFlag", MenuParse_ownerdrawFlag, NULL},
;5522:	{"outOfBoundsClick", MenuParse_outOfBounds, NULL},
;5523:	{"soundLoop", MenuParse_soundLoop, NULL},
;5524:	{"itemDef", MenuParse_itemDef, NULL},
;5525:	{"cinematic", MenuParse_cinematic, NULL},
;5526:	{"popup", MenuParse_popup, NULL},
;5527:	{"fadeClamp", MenuParse_fadeClamp, NULL},
;5528:	{"fadeCycle", MenuParse_fadeCycle, NULL},
;5529:	{"fadeAmount", MenuParse_fadeAmount, NULL},
;5530:	{NULL, NULL, NULL}
;5531:};
;5532:
;5533:keywordHash_t *menuParseKeywordHash[KEYWORDHASH_SIZE];
;5534:
;5535:/*
;5536:===============
;5537:Menu_SetupKeywordHash
;5538:===============
;5539:*/
;5540:void Menu_SetupKeywordHash(void) {
line 5543
;5541:	int i;
;5542:
;5543:	memset(menuParseKeywordHash, 0, sizeof(menuParseKeywordHash));
ADDRGP4 menuParseKeywordHash
ARGP4
CNSTI4 0
ARGI4
CNSTU4 2048
ARGU4
ADDRGP4 memset
CALLP4
pop
line 5544
;5544:	for (i = 0; menuParseKeywords[i].keyword; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2546
JUMPV
LABELV $2543
line 5545
;5545:		KeywordHash_Add(menuParseKeywordHash, &menuParseKeywords[i]);
ADDRGP4 menuParseKeywordHash
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 menuParseKeywords
ADDP4
ARGP4
ADDRGP4 KeywordHash_Add
CALLV
pop
line 5546
;5546:	}
LABELV $2544
line 5544
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2546
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 menuParseKeywords
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2543
line 5547
;5547:}
LABELV $2542
endproc Menu_SetupKeywordHash 4 12
export Menu_Parse
proc Menu_Parse 1060 12
line 5554
;5548:
;5549:/*
;5550:===============
;5551:Menu_Parse
;5552:===============
;5553:*/
;5554:qboolean Menu_Parse(int handle, menuDef_t *menu) {
line 5558
;5555:	pc_token_t token;
;5556:	keywordHash_t *key;
;5557:
;5558:	if (!trap_PC_ReadToken(handle, &token))
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
NEI4 $2548
line 5559
;5559:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2547
JUMPV
LABELV $2548
line 5560
;5560:	if (*token.string != '{') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $2554
line 5561
;5561:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2547
JUMPV
LABELV $2553
line 5564
;5562:	}
;5563:    
;5564:	while ( 1 ) {
line 5566
;5565:
;5566:		memset(&token, 0, sizeof(pc_token_t));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTU4 1040
ARGU4
ADDRGP4 memset
CALLP4
pop
line 5567
;5567:		if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 0
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
NEI4 $2556
line 5568
;5568:			PC_SourceError(handle, "end of file inside menu\n");
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $2558
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 5569
;5569:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2547
JUMPV
LABELV $2556
line 5572
;5570:		}
;5571:
;5572:		if (*token.string == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $2559
line 5573
;5573:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2547
JUMPV
LABELV $2559
line 5576
;5574:		}
;5575:
;5576:		key = KeywordHash_Find(menuParseKeywordHash, token.string);
ADDRGP4 menuParseKeywordHash
ARGP4
ADDRLP4 0+16
ARGP4
ADDRLP4 1052
ADDRGP4 KeywordHash_Find
CALLP4
ASGNP4
ADDRLP4 1040
ADDRLP4 1052
INDIRP4
ASGNP4
line 5577
;5577:		if (!key) {
ADDRLP4 1040
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2563
line 5578
;5578:			PC_SourceError(handle, "unknown menu keyword %s", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $2565
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 5579
;5579:			continue;
ADDRGP4 $2554
JUMPV
LABELV $2563
line 5581
;5580:		}
;5581:		if ( !key->func((itemDef_t*)menu, handle) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1056
ADDRLP4 1040
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $2567
line 5582
;5582:			PC_SourceError(handle, "couldn't parse menu keyword %s", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $2569
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 5583
;5583:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2547
JUMPV
LABELV $2567
line 5585
;5584:		}
;5585:	}
LABELV $2554
line 5564
ADDRGP4 $2553
JUMPV
line 5586
;5586:	return qfalse; 	// bk001205 - LCC missing return value
CNSTI4 0
RETI4
LABELV $2547
endproc Menu_Parse 1060 12
export Menu_New
proc Menu_New 12 8
line 5594
;5587:}
;5588:
;5589:/*
;5590:===============
;5591:Menu_New
;5592:===============
;5593:*/
;5594:void Menu_New(int handle) {
line 5595
;5595:	menuDef_t *menu = &Menus[menuCount];
ADDRLP4 0
ADDRGP4 menuCount
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
ASGNP4
line 5597
;5596:
;5597:	if (menuCount < MAX_MENUS) {
ADDRGP4 menuCount
INDIRI4
CNSTI4 64
GEI4 $2572
line 5598
;5598:		Menu_Init(menu);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_Init
CALLV
pop
line 5599
;5599:		if (Menu_Parse(handle, menu)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Menu_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2574
line 5600
;5600:			Menu_PostParse(menu);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_PostParse
CALLV
pop
line 5601
;5601:			menuCount++;
ADDRLP4 8
ADDRGP4 menuCount
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5602
;5602:		}
LABELV $2574
line 5603
;5603:	}
LABELV $2572
line 5604
;5604:}
LABELV $2571
endproc Menu_New 12 8
export Menu_Count
proc Menu_Count 0 0
line 5606
;5605:
;5606:int Menu_Count(void) {
line 5607
;5607:	return menuCount;
ADDRGP4 menuCount
INDIRI4
RETI4
LABELV $2576
endproc Menu_Count 0 0
data
align 4
LABELV $2586
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
export Menu_PaintAll
code
proc Menu_PaintAll 28 32
line 5610
;5608:}
;5609:
;5610:void Menu_PaintAll(void) {
line 5612
;5611:	int i;
;5612:	if (captureFunc) {
ADDRGP4 captureFunc
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2578
line 5613
;5613:		captureFunc(captureData);
ADDRGP4 captureData
INDIRP4
ARGP4
ADDRGP4 captureFunc
INDIRP4
CALLV
pop
line 5614
;5614:	}
LABELV $2578
line 5616
;5615:
;5616:	for (i = 0; i < Menu_Count(); i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2583
JUMPV
LABELV $2580
line 5617
;5617:		Menu_Paint(&Menus[i], qfalse);
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_Paint
CALLV
pop
line 5618
;5618:	}
LABELV $2581
line 5616
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2583
ADDRLP4 4
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $2580
line 5620
;5619:
;5620:	if (debugMode) {
ADDRGP4 debugMode
INDIRI4
CNSTI4 0
EQI4 $2584
line 5621
;5621:		vec4_t v = {1, 1, 1, 1};
ADDRLP4 8
ADDRGP4 $2586
INDIRB
ASGNB 16
line 5622
;5622:		DC->drawText(5, 25, .5, v, va("fps: %f", DC->FPS), 0, 0, 0);
ADDRGP4 $2587
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 73388
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTF4 1084227584
ARGF4
CNSTF4 1103626240
ARGF4
CNSTF4 1056964608
ARGF4
ADDRLP4 8
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 5623
;5623:	}
LABELV $2584
line 5624
;5624:}
LABELV $2577
endproc Menu_PaintAll 28 32
export Menu_Reset
proc Menu_Reset 0 0
line 5626
;5625:
;5626:void Menu_Reset(void) {
line 5627
;5627:	menuCount = 0;
ADDRGP4 menuCount
CNSTI4 0
ASGNI4
line 5628
;5628:}
LABELV $2588
endproc Menu_Reset 0 0
export Display_GetContext
proc Display_GetContext 0 0
line 5630
;5629:
;5630:displayContextDef_t *Display_GetContext(void) {
line 5631
;5631:	return DC;
ADDRGP4 DC
INDIRP4
RETP4
LABELV $2589
endproc Display_GetContext 0 0
export Display_CaptureItem
proc Display_CaptureItem 8 12
line 5639
;5632:}
;5633: 
;5634:#ifndef MISSIONPACK // bk001206
;5635:static float captureX;
;5636:static float captureY;
;5637:#endif
;5638:
;5639:void *Display_CaptureItem(int x, int y) {
line 5642
;5640:	int i;
;5641:
;5642:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2594
JUMPV
LABELV $2591
line 5645
;5643:		// turn off focus each item
;5644:		// menu->items[i].window.flags &= ~WINDOW_HASFOCUS;
;5645:		if (Rect_ContainsPoint(&Menus[i].window.rect, x, y)) {
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2595
line 5646
;5646:			return &Menus[i];
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
RETP4
ADDRGP4 $2590
JUMPV
LABELV $2595
line 5648
;5647:		}
;5648:	}
LABELV $2592
line 5642
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2594
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $2591
line 5649
;5649:	return NULL;
CNSTP4 0
RETP4
LABELV $2590
endproc Display_CaptureItem 8 12
export Display_MouseMove
proc Display_MouseMove 16 12
line 5654
;5650:}
;5651:
;5652:
;5653:// FIXME: 
;5654:qboolean Display_MouseMove(void *p, int x, int y) {
line 5656
;5655:	int i;
;5656:	menuDef_t *menu = p;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 5658
;5657:
;5658:	if (menu == NULL) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2598
line 5659
;5659:    menu = Menu_GetFocused();
ADDRLP4 8
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 5660
;5660:		if (menu) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2600
line 5661
;5661:			if (menu->window.flags & WINDOW_POPUP) {
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2097152
BANDI4
CNSTI4 0
EQI4 $2602
line 5662
;5662:				Menu_HandleMouseMove(menu, x, y);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 Menu_HandleMouseMove
CALLV
pop
line 5663
;5663:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2597
JUMPV
LABELV $2602
line 5665
;5664:			}
;5665:		}
LABELV $2600
line 5666
;5666:		for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2607
JUMPV
LABELV $2604
line 5667
;5667:			Menu_HandleMouseMove(&Menus[i], x, y);
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 Menu_HandleMouseMove
CALLV
pop
line 5668
;5668:		}
LABELV $2605
line 5666
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2607
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $2604
line 5669
;5669:	} else {
ADDRGP4 $2599
JUMPV
LABELV $2598
line 5670
;5670:		menu->window.rect.x += x;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRFP4 4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 5671
;5671:		menu->window.rect.y += y;
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRFP4 8
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 5672
;5672:		Menu_UpdatePosition(menu);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Menu_UpdatePosition
CALLV
pop
line 5673
;5673:	}
LABELV $2599
line 5674
;5674: 	return qtrue;
CNSTI4 1
RETI4
LABELV $2597
endproc Display_MouseMove 16 12
export Display_CursorType
proc Display_CursorType 28 12
line 5678
;5675:
;5676:}
;5677:
;5678:int Display_CursorType(int x, int y) {
line 5680
;5679:	int i;
;5680:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2612
JUMPV
LABELV $2609
line 5682
;5681:		rectDef_t r2;
;5682:		r2.x = Menus[i].window.rect.x - 3;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
INDIRF4
CNSTF4 1077936128
SUBF4
ASGNF4
line 5683
;5683:		r2.y = Menus[i].window.rect.y - 3;
ADDRLP4 4+4
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus+4
ADDP4
INDIRF4
CNSTF4 1077936128
SUBF4
ASGNF4
line 5684
;5684:		r2.w = r2.h = 7;
ADDRLP4 20
CNSTF4 1088421888
ASGNF4
ADDRLP4 4+12
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 20
INDIRF4
ASGNF4
line 5685
;5685:		if (Rect_ContainsPoint(&r2, x, y)) {
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $2617
line 5686
;5686:			return CURSOR_SIZER;
CNSTI4 4
RETI4
ADDRGP4 $2608
JUMPV
LABELV $2617
line 5688
;5687:		}
;5688:	}
LABELV $2610
line 5680
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2612
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $2609
line 5689
;5689:	return CURSOR_ARROW;
CNSTI4 2
RETI4
LABELV $2608
endproc Display_CursorType 28 12
export Display_HandleKey
proc Display_HandleKey 12 12
line 5693
;5690:}
;5691:
;5692:
;5693:void Display_HandleKey(int key, qboolean down, int x, int y) {
line 5694
;5694:	menuDef_t *menu = Display_CaptureItem(x, y);
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 Display_CaptureItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 5695
;5695:	if (menu == NULL) {  
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2620
line 5696
;5696:		menu = Menu_GetFocused();
ADDRLP4 8
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 5697
;5697:	}
LABELV $2620
line 5698
;5698:	if (menu) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2622
line 5699
;5699:		Menu_HandleKey(menu, key, down );
ADDRLP4 0
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
line 5700
;5700:	}
LABELV $2622
line 5701
;5701:}
LABELV $2619
endproc Display_HandleKey 12 12
proc Window_CacheContents 8 20
line 5703
;5702:
;5703:static void Window_CacheContents(windowDef_t *window) {
line 5704
;5704:	if (window) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2625
line 5705
;5705:		if (window->cinematicName) {
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2627
line 5706
;5706:			int cin = DC->playCinematic(window->cinematicName, 0, 0, 0, 0);
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 4
ADDRGP4 DC
INDIRP4
CNSTI4 180
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 5707
;5707:			DC->stopCinematic(cin);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 184
ADDP4
INDIRP4
CALLV
pop
line 5708
;5708:		}
LABELV $2627
line 5709
;5709:	}
LABELV $2625
line 5710
;5710:}
LABELV $2624
endproc Window_CacheContents 8 20
proc Item_CacheContents 0 4
line 5713
;5711:
;5712:
;5713:static void Item_CacheContents(itemDef_t *item) {
line 5714
;5714:	if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2630
line 5715
;5715:		Window_CacheContents(&item->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_CacheContents
CALLV
pop
line 5716
;5716:	}
LABELV $2630
line 5718
;5717:
;5718:}
LABELV $2629
endproc Item_CacheContents 0 4
proc Menu_CacheContents 8 8
line 5720
;5719:
;5720:static void Menu_CacheContents(menuDef_t *menu) {
line 5721
;5721:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2633
line 5723
;5722:		int i;
;5723:		Window_CacheContents(&menu->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_CacheContents
CALLV
pop
line 5724
;5724:		for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2638
JUMPV
LABELV $2635
line 5725
;5725:			Item_CacheContents(menu->items[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_CacheContents
CALLV
pop
line 5726
;5726:		}
LABELV $2636
line 5724
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2638
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $2635
line 5728
;5727:
;5728:		if (menu->soundName && *menu->soundName) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2639
ADDRLP4 4
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $2639
line 5729
;5729:			DC->registerSound(menu->soundName, qfalse);
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 168
ADDP4
INDIRP4
CALLI4
pop
line 5730
;5730:		}
LABELV $2639
line 5731
;5731:	}
LABELV $2633
line 5733
;5732:
;5733:}
LABELV $2632
endproc Menu_CacheContents 8 8
export Display_CacheAll
proc Display_CacheAll 4 4
line 5735
;5734:
;5735:void Display_CacheAll(void) {
line 5737
;5736:	int i;
;5737:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2645
JUMPV
LABELV $2642
line 5738
;5738:		Menu_CacheContents(&Menus[i]);
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRGP4 Menu_CacheContents
CALLV
pop
line 5739
;5739:	}
LABELV $2643
line 5737
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2645
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $2642
line 5740
;5740:}
LABELV $2641
endproc Display_CacheAll 4 4
proc Menu_OverActiveItem 32 12
line 5743
;5741:
;5742:
;5743:static qboolean Menu_OverActiveItem(menuDef_t *menu, float x, float y) {
line 5744
;5744: 	if (menu && menu->window.flags & (WINDOW_VISIBLE | WINDOW_FORCED)) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2647
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
EQI4 $2647
line 5745
;5745:		if (Rect_ContainsPoint(&menu->window.rect, x, y)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2649
line 5747
;5746:			int i;
;5747:			for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $2654
JUMPV
LABELV $2651
line 5751
;5748:				// turn off focus each item
;5749:				// menu->items[i].window.flags &= ~WINDOW_HASFOCUS;
;5750:
;5751:				if (!(menu->items[i]->window.flags & (WINDOW_VISIBLE | WINDOW_FORCED))) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
NEI4 $2655
line 5752
;5752:					continue;
ADDRGP4 $2652
JUMPV
LABELV $2655
line 5755
;5753:				}
;5754:
;5755:				if (menu->items[i]->window.flags & WINDOW_DECORATION) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $2657
line 5756
;5756:					continue;
ADDRGP4 $2652
JUMPV
LABELV $2657
line 5759
;5757:				}
;5758:
;5759:				if (Rect_ContainsPoint(&menu->items[i]->window.rect, x, y)) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2659
line 5760
;5760:					itemDef_t *overItem = menu->items[i];
ADDRLP4 16
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
line 5761
;5761:					if (overItem->type == ITEM_TYPE_TEXT && overItem->text) {
ADDRLP4 16
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2661
ADDRLP4 16
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2661
line 5762
;5762:						if (Rect_ContainsPoint(Item_CorrectedTextRect(overItem), x, y)) {
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 Item_CorrectedTextRect
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2652
line 5763
;5763:							return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2646
JUMPV
line 5764
;5764:						} else {
line 5765
;5765:							continue;
LABELV $2661
line 5767
;5766:						}
;5767:					} else {
line 5768
;5768:						return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2646
JUMPV
LABELV $2659
line 5771
;5769:					}
;5770:				}
;5771:			}
LABELV $2652
line 5747
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2654
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $2651
line 5773
;5772:
;5773:		}
LABELV $2649
line 5774
;5774:	}
LABELV $2647
line 5775
;5775:	return qfalse;
CNSTI4 0
RETI4
LABELV $2646
endproc Menu_OverActiveItem 32 12
bss
export menuParseKeywordHash
align 4
LABELV menuParseKeywordHash
skip 2048
export itemParseKeywordHash
align 4
LABELV itemParseKeywordHash
skip 2048
export g_nameBind2
align 1
LABELV g_nameBind2
skip 32
export g_nameBind1
align 1
LABELV g_nameBind1
skip 32
align 4
LABELV strHandle
skip 8192
align 1
LABELV strPool
skip 131072
align 4
LABELV outOfMemory
skip 4
align 4
LABELV allocPoint
skip 4
align 1
LABELV memoryPool
skip 131072
export menuStack
align 4
LABELV menuStack
skip 64
export Menus
align 4
LABELV Menus
skip 41216
align 4
LABELV scrollInfo
skip 32
import trap_PC_SourceFileAndLine
import trap_PC_ReadToken
import trap_PC_FreeSource
import trap_PC_LoadSource
import trap_PC_AddGlobalDefine
import Script_Parse
import Display_ExpandMacros
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
LABELV $2587
byte 1 102
byte 1 112
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 102
byte 1 0
align 1
LABELV $2569
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $2565
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $2558
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 115
byte 1 105
byte 1 100
byte 1 101
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 10
byte 1 0
align 1
LABELV $2541
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
LABELV $2540
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
LABELV $2539
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
LABELV $2538
byte 1 112
byte 1 111
byte 1 112
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $2537
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 68
byte 1 101
byte 1 102
byte 1 0
align 1
LABELV $2536
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 76
byte 1 111
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $2535
byte 1 111
byte 1 117
byte 1 116
byte 1 79
byte 1 102
byte 1 66
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 115
byte 1 67
byte 1 108
byte 1 105
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $2534
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $2533
byte 1 102
byte 1 111
byte 1 99
byte 1 117
byte 1 115
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $2532
byte 1 98
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 83
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $2531
byte 1 111
byte 1 110
byte 1 69
byte 1 83
byte 1 67
byte 1 0
align 1
LABELV $2530
byte 1 111
byte 1 110
byte 1 67
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $2529
byte 1 111
byte 1 110
byte 1 79
byte 1 112
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $2528
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 115
byte 1 99
byte 1 114
byte 1 101
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $2527
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $2428
byte 1 109
byte 1 97
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $2409
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $2405
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $2382
byte 1 100
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 99
byte 1 108
byte 1 105
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $2381
byte 1 99
byte 1 105
byte 1 110
byte 1 101
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 99
byte 1 0
align 1
LABELV $2380
byte 1 104
byte 1 105
byte 1 100
byte 1 101
byte 1 67
byte 1 118
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $2379
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 67
byte 1 118
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $2378
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 67
byte 1 118
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $2377
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 84
byte 1 101
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $2376
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 67
byte 1 118
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $2375
byte 1 111
byte 1 119
byte 1 110
byte 1 101
byte 1 114
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $2374
byte 1 97
byte 1 100
byte 1 100
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 82
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $2373
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 70
byte 1 108
byte 1 111
byte 1 97
byte 1 116
byte 1 76
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $2372
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 83
byte 1 116
byte 1 114
byte 1 76
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $2371
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 70
byte 1 108
byte 1 111
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $2370
byte 1 102
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
LABELV $2369
byte 1 109
byte 1 97
byte 1 120
byte 1 80
byte 1 97
byte 1 105
byte 1 110
byte 1 116
byte 1 67
byte 1 104
byte 1 97
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $2368
byte 1 109
byte 1 97
byte 1 120
byte 1 67
byte 1 104
byte 1 97
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $2367
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $2366
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $2365
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $2364
byte 1 109
byte 1 111
byte 1 117
byte 1 115
byte 1 101
byte 1 69
byte 1 120
byte 1 105
byte 1 116
byte 1 84
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $2363
byte 1 109
byte 1 111
byte 1 117
byte 1 115
byte 1 101
byte 1 69
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 84
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $2362
byte 1 109
byte 1 111
byte 1 117
byte 1 115
byte 1 101
byte 1 69
byte 1 120
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $2361
byte 1 109
byte 1 111
byte 1 117
byte 1 115
byte 1 101
byte 1 69
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2360
byte 1 108
byte 1 101
byte 1 97
byte 1 118
byte 1 101
byte 1 70
byte 1 111
byte 1 99
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $2359
byte 1 111
byte 1 110
byte 1 70
byte 1 111
byte 1 99
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $2358
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $2357
byte 1 111
byte 1 117
byte 1 116
byte 1 108
byte 1 105
byte 1 110
byte 1 101
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $2356
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2355
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2354
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 97
byte 1 108
byte 1 105
byte 1 103
byte 1 110
byte 1 121
byte 1 0
align 1
LABELV $2353
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 97
byte 1 108
byte 1 105
byte 1 103
byte 1 110
byte 1 120
byte 1 0
align 1
LABELV $2352
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 97
byte 1 108
byte 1 105
byte 1 103
byte 1 110
byte 1 0
align 1
LABELV $2351
byte 1 97
byte 1 108
byte 1 105
byte 1 103
byte 1 110
byte 1 0
align 1
LABELV $2350
byte 1 111
byte 1 119
byte 1 110
byte 1 101
byte 1 114
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 0
align 1
LABELV $2349
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2348
byte 1 98
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $2347
byte 1 98
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2346
byte 1 99
byte 1 111
byte 1 108
byte 1 117
byte 1 109
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $2345
byte 1 101
byte 1 108
byte 1 101
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $2344
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2343
byte 1 101
byte 1 108
byte 1 101
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 104
byte 1 101
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $2342
byte 1 101
byte 1 108
byte 1 101
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 119
byte 1 105
byte 1 100
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $2341
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $2340
byte 1 104
byte 1 111
byte 1 114
byte 1 105
byte 1 122
byte 1 111
byte 1 110
byte 1 116
byte 1 97
byte 1 108
byte 1 115
byte 1 99
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $2339
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 119
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $2338
byte 1 119
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $2337
byte 1 110
byte 1 111
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2336
byte 1 100
byte 1 101
byte 1 99
byte 1 111
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $2335
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2334
byte 1 114
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $2333
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 95
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2332
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 95
byte 1 114
byte 1 111
byte 1 116
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $2331
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 95
byte 1 102
byte 1 111
byte 1 118
byte 1 121
byte 1 0
align 1
LABELV $2330
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 95
byte 1 102
byte 1 111
byte 1 118
byte 1 120
byte 1 0
align 1
LABELV $2329
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 95
byte 1 111
byte 1 114
byte 1 105
byte 1 103
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $2328
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 95
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2327
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $2326
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $2325
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $2324
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2261
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 115
byte 1 105
byte 1 100
byte 1 101
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 10
byte 1 0
align 1
LABELV $1615
byte 1 70
byte 1 73
byte 1 88
byte 1 77
byte 1 69
byte 1 0
align 1
LABELV $1585
byte 1 63
byte 1 63
byte 1 63
byte 1 0
align 1
LABELV $1584
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 0
align 1
LABELV $1554
byte 1 105
byte 1 110
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
LABELV $1521
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 52
byte 1 0
align 1
LABELV $1520
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 51
byte 1 0
align 1
LABELV $1519
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 50
byte 1 0
align 1
LABELV $1518
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $1517
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
LABELV $1516
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
LABELV $1515
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
LABELV $1514
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
LABELV $1513
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
LABELV $1512
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
LABELV $1511
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
LABELV $1510
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
LABELV $1509
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
LABELV $1508
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
LABELV $1507
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
LABELV $1506
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
LABELV $1505
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
LABELV $1504
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
LABELV $1503
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
LABELV $1502
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
LABELV $1501
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
LABELV $1500
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
LABELV $1499
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
LABELV $1498
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
LABELV $1497
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
LABELV $1496
byte 1 43
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 52
byte 1 0
align 1
LABELV $1495
byte 1 43
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 51
byte 1 0
align 1
LABELV $1494
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
LABELV $1493
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
LABELV $1492
byte 1 43
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $1491
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 49
byte 1 51
byte 1 0
align 1
LABELV $1490
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 49
byte 1 50
byte 1 0
align 1
LABELV $1489
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 49
byte 1 49
byte 1 0
align 1
LABELV $1488
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $1487
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 57
byte 1 0
align 1
LABELV $1486
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 56
byte 1 0
align 1
LABELV $1485
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 55
byte 1 0
align 1
LABELV $1484
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 54
byte 1 0
align 1
LABELV $1483
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 53
byte 1 0
align 1
LABELV $1482
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 52
byte 1 0
align 1
LABELV $1481
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 51
byte 1 0
align 1
LABELV $1480
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 50
byte 1 0
align 1
LABELV $1479
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 49
byte 1 0
align 1
LABELV $1478
byte 1 43
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $1477
byte 1 99
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 0
align 1
LABELV $1476
byte 1 43
byte 1 109
byte 1 108
byte 1 111
byte 1 111
byte 1 107
byte 1 0
align 1
LABELV $1475
byte 1 43
byte 1 108
byte 1 111
byte 1 111
byte 1 107
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $1474
byte 1 43
byte 1 108
byte 1 111
byte 1 111
byte 1 107
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $1473
byte 1 43
byte 1 115
byte 1 116
byte 1 114
byte 1 97
byte 1 102
byte 1 101
byte 1 0
align 1
LABELV $1472
byte 1 43
byte 1 114
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $1471
byte 1 43
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 0
align 1
LABELV $1470
byte 1 43
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $1469
byte 1 43
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $1468
byte 1 43
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $1467
byte 1 43
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 0
align 1
LABELV $1466
byte 1 43
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $1465
byte 1 43
byte 1 102
byte 1 111
byte 1 114
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $1464
byte 1 43
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1463
byte 1 43
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 50
byte 1 0
align 1
LABELV $1462
byte 1 43
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $1445
byte 1 78
byte 1 111
byte 1 0
align 1
LABELV $1444
byte 1 89
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $1288
byte 1 115
byte 1 99
byte 1 114
byte 1 101
byte 1 101
byte 1 110
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $1284
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
LABELV $1137
byte 1 115
byte 1 108
byte 1 105
byte 1 100
byte 1 101
byte 1 114
byte 1 32
byte 1 104
byte 1 97
byte 1 110
byte 1 100
byte 1 108
byte 1 101
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 32
byte 1 101
byte 1 120
byte 1 105
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $961
byte 1 37
byte 1 102
byte 1 0
align 1
LABELV $907
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $569
byte 1 111
byte 1 114
byte 1 98
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $568
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 108
byte 1 111
byte 1 111
byte 1 112
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $567
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $566
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $565
byte 1 115
byte 1 101
byte 1 116
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $564
byte 1 116
byte 1 114
byte 1 97
byte 1 110
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $563
byte 1 115
byte 1 101
byte 1 116
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $562
byte 1 115
byte 1 101
byte 1 116
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $561
byte 1 115
byte 1 101
byte 1 116
byte 1 102
byte 1 111
byte 1 99
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $560
byte 1 115
byte 1 101
byte 1 116
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $559
byte 1 115
byte 1 101
byte 1 116
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $558
byte 1 115
byte 1 101
byte 1 116
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $557
byte 1 115
byte 1 101
byte 1 116
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $556
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $555
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 97
byte 1 108
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $554
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $553
byte 1 115
byte 1 101
byte 1 116
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $552
byte 1 104
byte 1 105
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $551
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $550
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $549
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $542
byte 1 37
byte 1 115
byte 1 32
byte 1 59
byte 1 32
byte 1 0
align 1
LABELV $535
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
LABELV $531
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
LABELV $370
byte 1 98
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $367
byte 1 102
byte 1 111
byte 1 114
byte 1 101
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $364
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $200
byte 1 32
byte 1 0
align 1
LABELV $197
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $192
byte 1 125
byte 1 0
align 1
LABELV $183
byte 1 123
byte 1 0
align 1
LABELV $147
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 103
byte 1 101
byte 1 114
byte 1 32
byte 1 98
byte 1 117
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $114
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 108
byte 1 111
byte 1 97
byte 1 116
byte 1 32
byte 1 98
byte 1 117
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $91
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 108
byte 1 105
byte 1 110
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $87
byte 1 94
byte 1 51
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 108
byte 1 105
byte 1 110
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $76
byte 1 77
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 32
byte 1 80
byte 1 111
byte 1 111
byte 1 108
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 46
byte 1 49
byte 1 102
byte 1 37
byte 1 37
byte 1 32
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 44
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 98
byte 1 121
byte 1 116
byte 1 101
byte 1 115
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $75
byte 1 83
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 80
byte 1 111
byte 1 111
byte 1 108
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 46
byte 1 49
byte 1 102
byte 1 37
byte 1 37
byte 1 32
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 44
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 98
byte 1 121
byte 1 116
byte 1 101
byte 1 115
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $74
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
LABELV $73
byte 1 77
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 47
byte 1 83
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 80
byte 1 111
byte 1 111
byte 1 108
byte 1 32
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 10
byte 1 0
align 1
LABELV $54
byte 1 0
align 1
LABELV $45
byte 1 85
byte 1 73
byte 1 95
byte 1 65
byte 1 108
byte 1 108
byte 1 111
byte 1 99
byte 1 58
byte 1 32
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 117
byte 1 114
byte 1 101
byte 1 46
byte 1 32
byte 1 79
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 33
byte 1 10
byte 1 0
