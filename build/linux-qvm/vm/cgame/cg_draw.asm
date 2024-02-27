data
export menuScoreboard
align 4
LABELV menuScoreboard
byte 4 0
export CG_Text_Width
code
proc CG_Text_Width 40 4
file "../../../../code/cgame/cg_draw.c"
line 27
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_draw.c -- draw all of the graphical elements during
;4:// active (after loading) gameplay
;5:
;6:#include "cg_local.h"
;7:
;8:#ifdef MISSIONPACK
;9:#include "../ui/ui_shared.h"
;10:
;11:// used for scoreboard
;12:extern displayContextDef_t cgDC;
;13:menuDef_t *menuScoreboard = NULL;
;14:#else
;15:int drawTeamOverlayModificationCount = -1;
;16:#endif
;17:
;18:int sortedTeamPlayers[TEAM_MAXOVERLAY];
;19:int	numSortedTeamPlayers;
;20:
;21:char systemChat[256];
;22:char teamChat1[256];
;23:char teamChat2[256];
;24:
;25:#ifdef MISSIONPACK
;26:
;27:int CG_Text_Width(const char *text, float scale, int limit) {
line 34
;28:  int count,len;
;29:	float out;
;30:	glyphInfo_t *glyph;
;31:	float useScale;
;32:// FIXME: see ui_main.c, same problem
;33://	const unsigned char *s = text;
;34:	const char *s = text;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 35
;35:	fontInfo_t *font = &cgDC.Assets.textFont;
ADDRLP4 12
ADDRGP4 cgDC+228+12
ASGNP4
line 36
;36:	if (scale <= cg_smallFont.value) {
ADDRFP4 4
INDIRF4
ADDRGP4 cg_smallFont+8
INDIRF4
GTF4 $84
line 37
;37:		font = &cgDC.Assets.smallFont;
ADDRLP4 12
ADDRGP4 cgDC+228+20560
ASGNP4
line 38
;38:	} else if (scale > cg_bigFont.value) {
ADDRGP4 $85
JUMPV
LABELV $84
ADDRFP4 4
INDIRF4
ADDRGP4 cg_bigFont+8
INDIRF4
LEF4 $89
line 39
;39:		font = &cgDC.Assets.bigFont;
ADDRLP4 12
ADDRGP4 cgDC+228+41108
ASGNP4
line 40
;40:	}
LABELV $89
LABELV $85
line 41
;41:	useScale = scale * font->glyphScale;
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
line 42
;42:  out = 0;
ADDRLP4 20
CNSTF4 0
ASGNF4
line 43
;43:  if (text) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $94
line 44
;44:    len = strlen(text);
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
line 45
;45:		if (limit > 0 && len > limit) {
ADDRLP4 32
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
LEI4 $96
ADDRLP4 8
INDIRI4
ADDRLP4 32
INDIRI4
LEI4 $96
line 46
;46:			len = limit;
ADDRLP4 8
ADDRFP4 8
INDIRI4
ASGNI4
line 47
;47:		}
LABELV $96
line 48
;48:		count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $99
JUMPV
LABELV $98
line 49
;49:		while (s && *s && count < len) {
line 50
;50:			if ( Q_IsColorString(s) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $101
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $101
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $101
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $101
line 51
;51:				s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 52
;52:				continue;
ADDRGP4 $99
JUMPV
LABELV $101
line 53
;53:			} else {
line 54
;54:				glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
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
line 55
;55:				out += glyph->xSkip;
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
line 56
;56:				s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 57
;57:				count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 58
;58:			}
line 59
;59:    }
LABELV $99
line 49
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $104
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $104
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $98
LABELV $104
line 60
;60:  }
LABELV $94
line 61
;61:  return out * useScale;
ADDRLP4 20
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
CVFI4 4
RETI4
LABELV $81
endproc CG_Text_Width 40 4
export CG_Text_Height
proc CG_Text_Height 40 4
line 64
;62:}
;63:
;64:int CG_Text_Height(const char *text, float scale, int limit) {
line 71
;65:  int len, count;
;66:	float max;
;67:	glyphInfo_t *glyph;
;68:	float useScale;
;69:// TTimo: FIXME
;70://	const unsigned char *s = text;
;71:	const char *s = text;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 72
;72:	fontInfo_t *font = &cgDC.Assets.textFont;
ADDRLP4 20
ADDRGP4 cgDC+228+12
ASGNP4
line 73
;73:	if (scale <= cg_smallFont.value) {
ADDRFP4 4
INDIRF4
ADDRGP4 cg_smallFont+8
INDIRF4
GTF4 $108
line 74
;74:		font = &cgDC.Assets.smallFont;
ADDRLP4 20
ADDRGP4 cgDC+228+20560
ASGNP4
line 75
;75:	} else if (scale > cg_bigFont.value) {
ADDRGP4 $109
JUMPV
LABELV $108
ADDRFP4 4
INDIRF4
ADDRGP4 cg_bigFont+8
INDIRF4
LEF4 $113
line 76
;76:		font = &cgDC.Assets.bigFont;
ADDRLP4 20
ADDRGP4 cgDC+228+41108
ASGNP4
line 77
;77:	}
LABELV $113
LABELV $109
line 78
;78:	useScale = scale * font->glyphScale;
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
line 79
;79:  max = 0;
ADDRLP4 16
CNSTF4 0
ASGNF4
line 80
;80:  if (text) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $118
line 81
;81:    len = strlen(text);
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
line 82
;82:		if (limit > 0 && len > limit) {
ADDRLP4 32
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
LEI4 $120
ADDRLP4 8
INDIRI4
ADDRLP4 32
INDIRI4
LEI4 $120
line 83
;83:			len = limit;
ADDRLP4 8
ADDRFP4 8
INDIRI4
ASGNI4
line 84
;84:		}
LABELV $120
line 85
;85:		count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $123
JUMPV
LABELV $122
line 86
;86:		while (s && *s && count < len) {
line 87
;87:			if ( Q_IsColorString(s) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $125
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $125
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $125
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $125
line 88
;88:				s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 89
;89:				continue;
ADDRGP4 $123
JUMPV
LABELV $125
line 90
;90:			} else {
line 91
;91:				glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
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
line 92
;92:	      if (max < glyph->height) {
ADDRLP4 16
INDIRF4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
GEF4 $127
line 93
;93:		      max = glyph->height;
ADDRLP4 16
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
line 94
;94:			  }
LABELV $127
line 95
;95:				s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 96
;96:				count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 97
;97:			}
line 98
;98:    }
LABELV $123
line 86
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $130
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $130
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $122
LABELV $130
line 99
;99:  }
LABELV $118
line 100
;100:  return max * useScale;
ADDRLP4 16
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
CVFI4 4
RETI4
LABELV $105
endproc CG_Text_Height 40 4
export CG_Text_PaintChar
proc CG_Text_PaintChar 8 36
line 103
;101:}
;102:
;103:void CG_Text_PaintChar(float x, float y, float width, float height, float scale, float s, float t, float s2, float t2, qhandle_t hShader) {
line 105
;104:  float w, h;
;105:  w = width * scale;
ADDRLP4 0
ADDRFP4 8
INDIRF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 106
;106:  h = height * scale;
ADDRLP4 4
ADDRFP4 12
INDIRF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 107
;107:  CG_AdjustFrom640( &x, &y, &w, &h );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 108
;108:  trap_R_DrawStretchPic( x, y, w, h, s, t, s2, t2, hShader );
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
line 109
;109:}
LABELV $131
endproc CG_Text_PaintChar 8 36
export CG_Text_Paint
proc CG_Text_Paint 76 40
line 111
;110:
;111:void CG_Text_Paint(float x, float y, float scale, vec4_t color, const char *text, float adjust, int limit, int style) {
line 116
;112:  int len, count;
;113:	vec4_t newColor;
;114:	glyphInfo_t *glyph;
;115:	float useScale;
;116:	fontInfo_t *font = &cgDC.Assets.textFont;
ADDRLP4 28
ADDRGP4 cgDC+228+12
ASGNP4
line 117
;117:	if (scale <= cg_smallFont.value) {
ADDRFP4 8
INDIRF4
ADDRGP4 cg_smallFont+8
INDIRF4
GTF4 $135
line 118
;118:		font = &cgDC.Assets.smallFont;
ADDRLP4 28
ADDRGP4 cgDC+228+20560
ASGNP4
line 119
;119:	} else if (scale > cg_bigFont.value) {
ADDRGP4 $136
JUMPV
LABELV $135
ADDRFP4 8
INDIRF4
ADDRGP4 cg_bigFont+8
INDIRF4
LEF4 $140
line 120
;120:		font = &cgDC.Assets.bigFont;
ADDRLP4 28
ADDRGP4 cgDC+228+41108
ASGNP4
line 121
;121:	}
LABELV $140
LABELV $136
line 122
;122:	useScale = scale * font->glyphScale;
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
line 123
;123:  if (text) {
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $145
line 126
;124:// TTimo: FIXME
;125://		const unsigned char *s = text;
;126:		const char *s = text;
ADDRLP4 36
ADDRFP4 16
INDIRP4
ASGNP4
line 127
;127:		trap_R_SetColor( color );
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 128
;128:		memcpy(&newColor[0], &color[0], sizeof(vec4_t));
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
line 129
;129:    len = strlen(text);
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
line 130
;130:		if (limit > 0 && len > limit) {
ADDRLP4 44
ADDRFP4 24
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
LEI4 $147
ADDRLP4 32
INDIRI4
ADDRLP4 44
INDIRI4
LEI4 $147
line 131
;131:			len = limit;
ADDRLP4 32
ADDRFP4 24
INDIRI4
ASGNI4
line 132
;132:		}
LABELV $147
line 133
;133:		count = 0;
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 $150
JUMPV
LABELV $149
line 134
;134:		while (s && *s && count < len) {
line 135
;135:			glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
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
line 138
;136:      //int yadj = Assets.textFont.glyphs[text[i]].bottom + Assets.textFont.glyphs[text[i]].top;
;137:      //float yadj = scale * (Assets.textFont.glyphs[text[i]].imageHeight - Assets.textFont.glyphs[text[i]].height);
;138:			if ( Q_IsColorString( s ) ) {
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $152
ADDRLP4 36
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $152
ADDRLP4 36
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $152
ADDRLP4 36
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $152
line 139
;139:				memcpy( newColor, g_color_table[ColorIndex(*(s+1))], sizeof( newColor ) );
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
line 140
;140:				newColor[3] = color[3];
ADDRLP4 4+12
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 141
;141:				trap_R_SetColor( newColor );
ADDRLP4 4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 142
;142:				s += 2;
ADDRLP4 36
ADDRLP4 36
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 143
;143:				continue;
ADDRGP4 $150
JUMPV
LABELV $152
line 144
;144:			} else {
line 145
;145:				float yadj = useScale * glyph->top;
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
line 146
;146:				if (style == ITEM_TEXTSTYLE_SHADOWED || style == ITEM_TEXTSTYLE_SHADOWEDMORE) {
ADDRLP4 56
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 3
EQI4 $157
ADDRLP4 56
INDIRI4
CNSTI4 6
NEI4 $155
LABELV $157
line 147
;147:					int ofs = style == ITEM_TEXTSTYLE_SHADOWED ? 1 : 2;
ADDRFP4 28
INDIRI4
CNSTI4 3
NEI4 $159
ADDRLP4 64
CNSTI4 1
ASGNI4
ADDRGP4 $160
JUMPV
LABELV $159
ADDRLP4 64
CNSTI4 2
ASGNI4
LABELV $160
ADDRLP4 60
ADDRLP4 64
INDIRI4
ASGNI4
line 148
;148:					colorBlack[3] = newColor[3];
ADDRGP4 colorBlack+12
ADDRLP4 4+12
INDIRF4
ASGNF4
line 149
;149:					trap_R_SetColor( colorBlack );
ADDRGP4 colorBlack
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 150
;150:					CG_Text_PaintChar(x + ofs, y - yadj + ofs, 
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
ADDRGP4 CG_Text_PaintChar
CALLV
pop
line 159
;151:														glyph->imageWidth,
;152:														glyph->imageHeight,
;153:														useScale, 
;154:														glyph->s,
;155:														glyph->t,
;156:														glyph->s2,
;157:														glyph->t2,
;158:														glyph->glyph);
;159:					colorBlack[3] = 1.0;
ADDRGP4 colorBlack+12
CNSTF4 1065353216
ASGNF4
line 160
;160:					trap_R_SetColor( newColor );
ADDRLP4 4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 161
;161:				}
LABELV $155
line 162
;162:				CG_Text_PaintChar(x, y - yadj, 
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
ADDRGP4 CG_Text_PaintChar
CALLV
pop
line 172
;163:													glyph->imageWidth,
;164:													glyph->imageHeight,
;165:													useScale, 
;166:													glyph->s,
;167:													glyph->t,
;168:													glyph->s2,
;169:													glyph->t2,
;170:													glyph->glyph);
;171:				// CG_DrawPic(x, y - yadj, scale * cgDC.Assets.textFont.glyphs[text[i]].imageWidth, scale * cgDC.Assets.textFont.glyphs[text[i]].imageHeight, cgDC.Assets.textFont.glyphs[text[i]].glyph);
;172:				x += (glyph->xSkip * useScale) + adjust;
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
line 173
;173:				s++;
ADDRLP4 36
ADDRLP4 36
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 174
;174:				count++;
ADDRLP4 24
ADDRLP4 24
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 175
;175:			}
line 176
;176:    }
LABELV $150
line 134
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $165
ADDRLP4 36
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $165
ADDRLP4 24
INDIRI4
ADDRLP4 32
INDIRI4
LTI4 $149
LABELV $165
line 177
;177:	  trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 178
;178:  }
LABELV $145
line 179
;179:}
LABELV $132
endproc CG_Text_Paint 76 40
export CG_Draw3DModel
proc CG_Draw3DModel 508 16
line 253
;180:
;181:
;182:#endif
;183:
;184:/*
;185:==============
;186:CG_DrawField
;187:
;188:Draws large numbers for status bar and powerups
;189:==============
;190:*/
;191:#ifndef MISSIONPACK
;192:static void CG_DrawField (int x, int y, int width, int value) {
;193:	char	num[16], *ptr;
;194:	int		l;
;195:	int		frame;
;196:
;197:	if ( width < 1 ) {
;198:		return;
;199:	}
;200:
;201:	// draw number string
;202:	if ( width > 5 ) {
;203:		width = 5;
;204:	}
;205:
;206:	switch ( width ) {
;207:	case 1:
;208:		value = value > 9 ? 9 : value;
;209:		value = value < 0 ? 0 : value;
;210:		break;
;211:	case 2:
;212:		value = value > 99 ? 99 : value;
;213:		value = value < -9 ? -9 : value;
;214:		break;
;215:	case 3:
;216:		value = value > 999 ? 999 : value;
;217:		value = value < -99 ? -99 : value;
;218:		break;
;219:	case 4:
;220:		value = value > 9999 ? 9999 : value;
;221:		value = value < -999 ? -999 : value;
;222:		break;
;223:	}
;224:
;225:	Com_sprintf (num, sizeof(num), "%i", value);
;226:	l = strlen(num);
;227:	if (l > width)
;228:		l = width;
;229:	x += 2 + CHAR_WIDTH*(width - l);
;230:
;231:	ptr = num;
;232:	while (*ptr && l)
;233:	{
;234:		if (*ptr == '-')
;235:			frame = STAT_MINUS;
;236:		else
;237:			frame = *ptr -'0';
;238:
;239:		CG_DrawPic( x,y, CHAR_WIDTH, CHAR_HEIGHT, cgs.media.numberShaders[frame] );
;240:		x += CHAR_WIDTH;
;241:		ptr++;
;242:		l--;
;243:	}
;244:}
;245:#endif // MISSIONPACK
;246:
;247:
;248:/*
;249:================
;250:CG_Draw3DModel
;251:================
;252:*/
;253:void CG_Draw3DModel( float x, float y, float w, float h, qhandle_t model, qhandle_t skin, vec3_t origin, vec3_t angles ) {
line 257
;254:	refdef_t		refdef;
;255:	refEntity_t		ent;
;256:
;257:	if ( !cg_draw3dIcons.integer || !cg_drawIcons.integer ) {
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
EQI4 $171
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
NEI4 $167
LABELV $171
line 258
;258:		return;
ADDRGP4 $166
JUMPV
LABELV $167
line 261
;259:	}
;260:
;261:	CG_AdjustFrom640( &x, &y, &w, &h );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 263
;262:
;263:	memset( &refdef, 0, sizeof( refdef ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTU4 368
ARGU4
ADDRGP4 memset
CALLP4
pop
line 265
;264:
;265:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 368
ARGP4
CNSTI4 0
ARGI4
CNSTU4 140
ARGU4
ADDRGP4 memset
CALLP4
pop
line 266
;266:	AnglesToAxis( angles, ent.axis );
ADDRFP4 28
INDIRP4
ARGP4
ADDRLP4 368+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 267
;267:	VectorCopy( origin, ent.origin );
ADDRLP4 368+68
ADDRFP4 24
INDIRP4
INDIRB
ASGNB 12
line 268
;268:	ent.hModel = model;
ADDRLP4 368+8
ADDRFP4 16
INDIRI4
ASGNI4
line 269
;269:	ent.customSkin = skin;
ADDRLP4 368+108
ADDRFP4 20
INDIRI4
ASGNI4
line 270
;270:	ent.renderfx = RF_NOSHADOW;		// no stencil shadows
ADDRLP4 368+4
CNSTI4 64
ASGNI4
line 272
;271:
;272:	refdef.rdflags = RDF_NOWORLDMODEL;
ADDRLP4 0+76
CNSTI4 1
ASGNI4
line 274
;273:
;274:	AxisClear( refdef.viewaxis );
ADDRLP4 0+36
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 276
;275:
;276:	refdef.fov_x = 30;
ADDRLP4 0+16
CNSTF4 1106247680
ASGNF4
line 277
;277:	refdef.fov_y = 30;
ADDRLP4 0+20
CNSTF4 1106247680
ASGNF4
line 279
;278:
;279:	refdef.x = x;
ADDRLP4 0
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 280
;280:	refdef.y = y;
ADDRLP4 0+4
ADDRFP4 4
INDIRF4
CVFI4 4
ASGNI4
line 281
;281:	refdef.width = w;
ADDRLP4 0+8
ADDRFP4 8
INDIRF4
CVFI4 4
ASGNI4
line 282
;282:	refdef.height = h;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
CVFI4 4
ASGNI4
line 284
;283:
;284:	refdef.time = cg.time;
ADDRLP4 0+72
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 286
;285:
;286:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 287
;287:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 368
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 288
;288:	trap_R_RenderScene( &refdef );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 289
;289:}
LABELV $166
endproc CG_Draw3DModel 508 16
export CG_Draw3DModelColor
proc CG_Draw3DModelColor 544 16
line 298
;290:
;291:
;292:
;293:/*
;294:================
;295:CG_Draw3DModel
;296:================
;297:*/
;298:void CG_Draw3DModelColor( float x, float y, float w, float h, qhandle_t model, qhandle_t skin, vec3_t origin, vec3_t angles, vec3_t color ) {
line 302
;299:	refdef_t		refdef;
;300:	refEntity_t		ent;
;301:
;302:	if ( !cg_draw3dIcons.integer || !cg_drawIcons.integer ) {
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
EQI4 $191
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
NEI4 $187
LABELV $191
line 303
;303:		return;
ADDRGP4 $186
JUMPV
LABELV $187
line 306
;304:	}
;305:
;306:	CG_AdjustFrom640( &x, &y, &w, &h );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 308
;307:
;308:	memset( &refdef, 0, sizeof( refdef ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTU4 368
ARGU4
ADDRGP4 memset
CALLP4
pop
line 310
;309:
;310:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 368
ARGP4
CNSTI4 0
ARGI4
CNSTU4 140
ARGU4
ADDRGP4 memset
CALLP4
pop
line 311
;311:	AnglesToAxis( angles, ent.axis );
ADDRFP4 28
INDIRP4
ARGP4
ADDRLP4 368+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 312
;312:	VectorCopy( origin, ent.origin );
ADDRLP4 368+68
ADDRFP4 24
INDIRP4
INDIRB
ASGNB 12
line 313
;313:	ent.hModel = model;
ADDRLP4 368+8
ADDRFP4 16
INDIRI4
ASGNI4
line 314
;314:	ent.customSkin = skin;
ADDRLP4 368+108
ADDRFP4 20
INDIRI4
ASGNI4
line 315
;315:	ent.renderfx = RF_NOSHADOW;		// no stencil shadows
ADDRLP4 368+4
CNSTI4 64
ASGNI4
line 317
;316:
;317:	refdef.rdflags = RDF_NOWORLDMODEL;
ADDRLP4 0+76
CNSTI4 1
ASGNI4
line 319
;318:
;319:	AxisClear( refdef.viewaxis );
ADDRLP4 0+36
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 321
;320:
;321:	refdef.fov_x = 30;
ADDRLP4 0+16
CNSTF4 1106247680
ASGNF4
line 322
;322:	refdef.fov_y = 30;
ADDRLP4 0+20
CNSTF4 1106247680
ASGNF4
line 324
;323:
;324:	refdef.x = x;
ADDRLP4 0
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 325
;325:	refdef.y = y;
ADDRLP4 0+4
ADDRFP4 4
INDIRF4
CVFI4 4
ASGNI4
line 326
;326:	refdef.width = w;
ADDRLP4 0+8
ADDRFP4 8
INDIRF4
CVFI4 4
ASGNI4
line 327
;327:	refdef.height = h;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
CVFI4 4
ASGNI4
line 329
;328:
;329:	refdef.time = cg.time;
ADDRLP4 0+72
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 331
;330:
;331:	ent.shaderRGBA[0] = color[0] * 255;
ADDRLP4 512
ADDRFP4 32
INDIRP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 516
CNSTF4 1325400064
ASGNF4
ADDRLP4 512
INDIRF4
ADDRLP4 516
INDIRF4
LTF4 $208
ADDRLP4 508
ADDRLP4 512
INDIRF4
ADDRLP4 516
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $209
JUMPV
LABELV $208
ADDRLP4 508
ADDRLP4 512
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $209
ADDRLP4 368+116
ADDRLP4 508
INDIRU4
CVUU1 4
ASGNU1
line 332
;332:	ent.shaderRGBA[1] = color[1] * 255;
ADDRLP4 524
ADDRFP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 528
CNSTF4 1325400064
ASGNF4
ADDRLP4 524
INDIRF4
ADDRLP4 528
INDIRF4
LTF4 $213
ADDRLP4 520
ADDRLP4 524
INDIRF4
ADDRLP4 528
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $214
JUMPV
LABELV $213
ADDRLP4 520
ADDRLP4 524
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $214
ADDRLP4 368+116+1
ADDRLP4 520
INDIRU4
CVUU1 4
ASGNU1
line 333
;333:	ent.shaderRGBA[2] = color[2] * 255;
ADDRLP4 536
ADDRFP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 540
CNSTF4 1325400064
ASGNF4
ADDRLP4 536
INDIRF4
ADDRLP4 540
INDIRF4
LTF4 $218
ADDRLP4 532
ADDRLP4 536
INDIRF4
ADDRLP4 540
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $219
JUMPV
LABELV $218
ADDRLP4 532
ADDRLP4 536
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $219
ADDRLP4 368+116+2
ADDRLP4 532
INDIRU4
CVUU1 4
ASGNU1
line 334
;334:	ent.shaderRGBA[3] = 255;
ADDRLP4 368+116+3
CNSTU1 255
ASGNU1
line 336
;335:
;336:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 337
;337:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 368
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 338
;338:	trap_R_RenderScene( &refdef );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 339
;339:}
LABELV $186
endproc CG_Draw3DModelColor 544 16
export CG_DrawHead
proc CG_DrawHead 56 36
line 349
;340:
;341:
;342:/*
;343:================
;344:CG_DrawHead
;345:
;346:Used for both the status bar and the scoreboard
;347:================
;348:*/
;349:void CG_DrawHead( float x, float y, float w, float h, int clientNum, vec3_t headAngles ) {
line 356
;350:	clipHandle_t	cm;
;351:	clientInfo_t	*ci;
;352:	float			len;
;353:	vec3_t			origin;
;354:	vec3_t			mins, maxs;
;355:
;356:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 0
ADDRFP4 16
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 358
;357:
;358:	if ( cg_draw3dIcons.integer ) {
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
EQI4 $224
line 359
;359:		cm = ci->headModel;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ASGNI4
line 360
;360:		if ( !cm ) {
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $227
line 361
;361:			return;
ADDRGP4 $222
JUMPV
LABELV $227
line 365
;362:		}
;363:
;364:		// offset the origin y and z to center the head
;365:		trap_R_ModelBounds( cm, mins, maxs );
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 367
;366:
;367:		origin[2] = -0.5 * ( mins[2] + maxs[2] );
ADDRLP4 4+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 28+8
INDIRF4
ADDF4
CNSTF4 3204448256
MULF4
ASGNF4
line 368
;368:		origin[1] = 0.5 * ( mins[1] + maxs[1] );
ADDRLP4 4+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 28+4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ASGNF4
line 372
;369:
;370:		// calculate distance so the head nearly fills the box
;371:		// assume heads are taller than wide
;372:		len = 0.7 * ( maxs[2] - mins[2] );		
ADDRLP4 44
ADDRLP4 28+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
CNSTF4 1060320051
MULF4
ASGNF4
line 373
;373:		origin[0] = len / 0.268;	// len / tan( fov/2 )
ADDRLP4 4
ADDRLP4 44
INDIRF4
CNSTF4 1081003604
MULF4
ASGNF4
line 376
;374:
;375:		// allow per-model tweaking
;376:		VectorAdd( origin, ci->headOffset, origin );
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 400
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 404
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRF4
ADDF4
ASGNF4
line 378
;377:
;378:		CG_Draw3DModelColor( x, y, w, h, ci->headModel, ci->headSkin, origin, headAngles, ci->headColor );
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
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1616
ADDP4
ARGP4
ADDRGP4 CG_Draw3DModelColor
CALLV
pop
line 379
;379:	} else if ( cg_drawIcons.integer ) {
ADDRGP4 $225
JUMPV
LABELV $224
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $241
line 380
;380:		trap_R_SetColor ( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 381
;381:		CG_DrawPic( x, y, w, h, ci->modelIcon );
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
ADDRLP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 382
;382:	}
LABELV $241
LABELV $225
line 385
;383:
;384:	// if they are deferred, draw a cross out
;385:	if ( ci->deferred ) {
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
EQI4 $244
line 386
;386:		trap_R_SetColor ( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 387
;387:		CG_DrawPic( x, y, w, h, cgs.media.deferShader );
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
ADDRGP4 cgs+148772+164
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 388
;388:	}
LABELV $244
line 389
;389:}
LABELV $222
endproc CG_DrawHead 56 36
export CG_DrawFlagModel
proc CG_DrawFlagModel 68 32
line 398
;390:
;391:/*
;392:================
;393:CG_DrawFlagModel
;394:
;395:Used for both the status bar and the scoreboard
;396:================
;397:*/
;398:void CG_DrawFlagModel( float x, float y, float w, float h, int team, qboolean force2D ) {
line 405
;399:	qhandle_t		cm;
;400:	float			len;
;401:	vec3_t			origin, angles;
;402:	vec3_t			mins, maxs;
;403:	qhandle_t		handle;
;404:
;405:	if ( !force2D && cg_draw3dIcons.integer ) {
ADDRFP4 20
INDIRI4
CNSTI4 0
NEI4 $249
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
EQI4 $249
line 407
;406:
;407:		VectorClear( angles );
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRLP4 0+4
CNSTF4 0
ASGNF4
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 409
;408:
;409:		cm = cgs.media.redFlagModel;
ADDRLP4 48
ADDRGP4 cgs+148772+36
INDIRI4
ASGNI4
line 412
;410:
;411:		// offset the origin y and z to center the flag
;412:		trap_R_ModelBounds( cm, mins, maxs );
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 414
;413:
;414:		origin[2] = -0.5 * ( mins[2] + maxs[2] );
ADDRLP4 12+8
ADDRLP4 24+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
CNSTF4 3204448256
MULF4
ASGNF4
line 415
;415:		origin[1] = 0.5 * ( mins[1] + maxs[1] );
ADDRLP4 12+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ASGNF4
line 419
;416:
;417:		// calculate distance so the flag nearly fills the box
;418:		// assume heads are taller than wide
;419:		len = 0.5 * ( maxs[2] - mins[2] );		
ADDRLP4 52
ADDRLP4 36+8
INDIRF4
ADDRLP4 24+8
INDIRF4
SUBF4
CNSTF4 1056964608
MULF4
ASGNF4
line 420
;420:		origin[0] = len / 0.268;	// len / tan( fov/2 )
ADDRLP4 12
ADDRLP4 52
INDIRF4
CNSTF4 1081003604
MULF4
ASGNF4
line 422
;421:
;422:		angles[YAW] = 60 * sin( ( cg.time % TMOD_2000 ) / 2000.0 );;
ADDRGP4 cg+107604
INDIRI4
CNSTI4 5730265
MODI4
CVIF4 4
CNSTF4 973279855
MULF4
ARGF4
ADDRLP4 60
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 60
INDIRF4
CNSTF4 1114636288
MULF4
ASGNF4
line 424
;423:
;424:		if( team == TEAM_RED ) {
ADDRFP4 16
INDIRI4
CNSTI4 1
NEI4 $266
line 425
;425:			handle = cgs.media.redFlagModel;
ADDRLP4 56
ADDRGP4 cgs+148772+36
INDIRI4
ASGNI4
line 426
;426:		} else if( team == TEAM_BLUE ) {
ADDRGP4 $267
JUMPV
LABELV $266
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $270
line 427
;427:			handle = cgs.media.blueFlagModel;
ADDRLP4 56
ADDRGP4 cgs+148772+40
INDIRI4
ASGNI4
line 428
;428:		} else if( team == TEAM_FREE ) {
ADDRGP4 $271
JUMPV
LABELV $270
ADDRFP4 16
INDIRI4
CNSTI4 0
NEI4 $248
line 429
;429:			handle = cgs.media.neutralFlagModel;
ADDRLP4 56
ADDRGP4 cgs+148772+44
INDIRI4
ASGNI4
line 430
;430:		} else {
line 431
;431:			return;
LABELV $275
LABELV $271
LABELV $267
line 433
;432:		}
;433:		CG_Draw3DModel( x, y, w, h, handle, 0, origin, angles );
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
ADDRLP4 56
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 434
;434:	} else if ( cg_drawIcons.integer ) {
ADDRGP4 $250
JUMPV
LABELV $249
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $278
line 437
;435:		gitem_t *item;
;436:
;437:		if( team == TEAM_RED ) {
ADDRFP4 16
INDIRI4
CNSTI4 1
NEI4 $281
line 438
;438:			item = BG_FindItemForPowerup( PW_REDFLAG );
CNSTI4 7
ARGI4
ADDRLP4 64
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 64
INDIRP4
ASGNP4
line 439
;439:		} else if( team == TEAM_BLUE ) {
ADDRGP4 $282
JUMPV
LABELV $281
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $283
line 440
;440:			item = BG_FindItemForPowerup( PW_BLUEFLAG );
CNSTI4 8
ARGI4
ADDRLP4 64
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 64
INDIRP4
ASGNP4
line 441
;441:		} else if( team == TEAM_FREE ) {
ADDRGP4 $284
JUMPV
LABELV $283
ADDRFP4 16
INDIRI4
CNSTI4 0
NEI4 $248
line 442
;442:			item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
CNSTI4 9
ARGI4
ADDRLP4 64
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 64
INDIRP4
ASGNP4
line 443
;443:		} else {
line 444
;444:			return;
LABELV $286
LABELV $284
LABELV $282
line 446
;445:		}
;446:		if (item) {
ADDRLP4 60
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $287
line 447
;447:		  CG_DrawPic( x, y, w, h, cg_items[ ITEM_INDEX(item) ].icon );
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
ADDRLP4 60
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 28
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 448
;448:		}
LABELV $287
line 449
;449:	}
LABELV $278
LABELV $250
line 450
;450:}
LABELV $248
endproc CG_DrawFlagModel 68 32
export CG_DrawTeamBackground
proc CG_DrawTeamBackground 16 20
line 532
;451:
;452:/*
;453:================
;454:CG_DrawStatusBarHead
;455:
;456:================
;457:*/
;458:#ifndef MISSIONPACK
;459:
;460:static void CG_DrawStatusBarHead( float x ) {
;461:	vec3_t		angles;
;462:	float		size, stretch;
;463:	float		frac;
;464:
;465:	VectorClear( angles );
;466:
;467:	if ( cg.damageTime && cg.time - cg.damageTime < DAMAGE_TIME ) {
;468:		frac = (float)(cg.time - cg.damageTime ) / DAMAGE_TIME;
;469:		size = ICON_SIZE * 1.25 * ( 1.5 - frac * 0.5 );
;470:
;471:		stretch = size - ICON_SIZE * 1.25;
;472:		// kick in the direction of damage
;473:		x -= stretch * 0.5 + cg.damageX * stretch * 0.5;
;474:
;475:		cg.headStartYaw = 180 + cg.damageX * 45;
;476:
;477:		cg.headEndYaw = 180 + 20 * cos( crandom()*M_PI );
;478:		cg.headEndPitch = 5 * cos( crandom()*M_PI );
;479:
;480:		cg.headStartTime = cg.time;
;481:		cg.headEndTime = cg.time + 100 + random() * 2000;
;482:	} else {
;483:		if ( cg.time >= cg.headEndTime ) {
;484:			// select a new head angle
;485:			cg.headStartYaw = cg.headEndYaw;
;486:			cg.headStartPitch = cg.headEndPitch;
;487:			cg.headStartTime = cg.headEndTime;
;488:			cg.headEndTime = cg.time + 100 + random() * 2000;
;489:
;490:			cg.headEndYaw = 180 + 20 * cos( crandom()*M_PI );
;491:			cg.headEndPitch = 5 * cos( crandom()*M_PI );
;492:		}
;493:
;494:		size = ICON_SIZE * 1.25;
;495:	}
;496:
;497:	// if the server was frozen for a while we may have a bad head start time
;498:	if ( cg.headStartTime > cg.time ) {
;499:		cg.headStartTime = cg.time;
;500:	}
;501:
;502:	frac = ( cg.time - cg.headStartTime ) / (float)( cg.headEndTime - cg.headStartTime );
;503:	frac = frac * frac * ( 3 - 2 * frac );
;504:	angles[YAW] = cg.headStartYaw + ( cg.headEndYaw - cg.headStartYaw ) * frac;
;505:	angles[PITCH] = cg.headStartPitch + ( cg.headEndPitch - cg.headStartPitch ) * frac;
;506:
;507:	CG_DrawHead( x, cgs.screenYmax + 1 - size, size, size, cg.snap->ps.clientNum, angles );
;508:}
;509:#endif // MISSIONPACK
;510:
;511:
;512:/*
;513:================
;514:CG_DrawStatusBarFlag
;515:
;516:================
;517:*/
;518:#ifndef MISSIONPACK
;519:static void CG_DrawStatusBarFlag( float x, int team ) {
;520:	CG_DrawFlagModel( x, cgs.screenYmax + 1 - ICON_SIZE, ICON_SIZE, ICON_SIZE, team, qfalse );
;521:}
;522:#endif // MISSIONPACK
;523:
;524:
;525:/*
;526:================
;527:CG_DrawTeamBackground
;528:
;529:================
;530:*/
;531:void CG_DrawTeamBackground( int x, int y, int w, int h, float alpha, int team )
;532:{
line 535
;533:	vec4_t		hcolor;
;534:
;535:	hcolor[3] = alpha;
ADDRLP4 0+12
ADDRFP4 16
INDIRF4
ASGNF4
line 536
;536:	if ( team == TEAM_RED ) {
ADDRFP4 20
INDIRI4
CNSTI4 1
NEI4 $292
line 537
;537:		hcolor[0] = 1.0f;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 538
;538:		hcolor[1] = 0.0f;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 539
;539:		hcolor[2] = 0.0f;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 540
;540:	} else if ( team == TEAM_BLUE ) {
ADDRGP4 $293
JUMPV
LABELV $292
ADDRFP4 20
INDIRI4
CNSTI4 2
NEI4 $290
line 541
;541:		hcolor[0] = 0.0f;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 542
;542:		hcolor[1] = 0.1f;
ADDRLP4 0+4
CNSTF4 1036831949
ASGNF4
line 543
;543:		hcolor[2] = 1.0f;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 544
;544:	} else {
line 545
;545:		return;
LABELV $297
LABELV $293
line 547
;546:	}
;547:	trap_R_SetColor( hcolor );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 548
;548:	CG_DrawPic( x, y, w, h, cgs.media.teamStatusBar );
ADDRFP4 0
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
ADDRFP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+148772+160
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 549
;549:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 550
;550:}
LABELV $290
endproc CG_DrawTeamBackground 16 20
proc CG_DrawAttacker 64 32
line 763
;551:
;552:
;553:/*
;554:================
;555:CG_DrawStatusBar
;556:================
;557:*/
;558:#ifndef MISSIONPACK
;559:#define STATUSBAR_HEIGHT 60
;560:static void CG_DrawStatusBar( void ) {
;561:	int			color;
;562:	centity_t	*cent;
;563:	playerState_t	*ps;
;564:	int			value;
;565:	vec4_t		hcolor;
;566:	vec3_t		angles;
;567:	vec3_t		origin;
;568:	float		y;
;569:#ifdef MISSIONPACK
;570:	qhandle_t	handle;
;571:#endif
;572:	static float colors[4][4] = { 
;573://		{ 0.2, 1.0, 0.2, 1.0 } , { 1.0, 0.2, 0.2, 1.0 }, {0.5, 0.5, 0.5, 1} };
;574:		{ 1.0f, 0.69f, 0.0f, 1.0f },    // normal
;575:		{ 1.0f, 0.2f, 0.2f, 1.0f },     // low health
;576:		{ 0.5f, 0.5f, 0.5f, 1.0f },     // weapon firing
;577:		{ 1.0f, 1.0f, 1.0f, 1.0f } };   // health > 100
;578:
;579:	if ( cg_drawStatus.integer == 0 ) {
;580:		return;
;581:	}
;582:
;583:	// draw the team background
;584:	CG_DrawTeamBackground( cgs.screenXmin, cgs.screenYmax - STATUSBAR_HEIGHT + 1,
;585:		cgs.screenXmax - cgs.screenXmin + 1, STATUSBAR_HEIGHT, 
;586:		0.33f, cg.snap->ps.persistant[ PERS_TEAM ] );
;587:
;588:	y = cgs.screenYmax + 1 - ICON_SIZE;
;589:
;590:	cent = &cg_entities[cg.snap->ps.clientNum];
;591:	ps = &cg.snap->ps;
;592:
;593:	VectorClear( angles );
;594:
;595:	// draw any 3D icons first, so the changes back to 2D are minimized
;596:	if ( cent->currentState.weapon && cg_weapons[ cent->currentState.weapon ].ammoModel ) {
;597:		origin[0] = 70;
;598:		origin[1] = 0;
;599:		origin[2] = 0;
;600:		angles[YAW] = 90 + 20 * sin( ( cg.time % TMOD_1000 ) / 1000.0 );
;601:		CG_Draw3DModel( CHAR_WIDTH*3 + TEXT_ICON_SPACE, y, ICON_SIZE, ICON_SIZE,
;602:					   cg_weapons[ cent->currentState.weapon ].ammoModel, 0, origin, angles );
;603:	}
;604:
;605:	CG_DrawStatusBarHead( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE );
;606:
;607:	if( cg.predictedPlayerState.powerups[PW_REDFLAG] ) {
;608:		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_RED );
;609:	} else if( cg.predictedPlayerState.powerups[PW_BLUEFLAG] ) {
;610:		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_BLUE );
;611:	} else if( cg.predictedPlayerState.powerups[PW_NEUTRALFLAG] ) {
;612:		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_FREE );
;613:	}
;614:
;615:	if ( ps->stats[ STAT_ARMOR ] ) {
;616:		origin[0] = 90;
;617:		origin[1] = 0;
;618:		origin[2] = -10;
;619:		angles[YAW] = ( cg.time & 2047 ) * 360 / 2048.0;
;620:		CG_Draw3DModel( 370 + CHAR_WIDTH*3 + TEXT_ICON_SPACE, y, ICON_SIZE, ICON_SIZE,
;621:					   cgs.media.armorModel, 0, origin, angles );
;622:	}
;623:#ifdef MISSIONPACK
;624:	if( cgs.gametype == GT_HARVESTER ) {
;625:		origin[0] = 90;
;626:		origin[1] = 0;
;627:		origin[2] = -10;
;628:		angles[YAW] = ( cg.time & 2047 ) * 360 / 2048.0;
;629:		if( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
;630:			handle = cgs.media.redCubeModel;
;631:		} else {
;632:			handle = cgs.media.blueCubeModel;
;633:		}
;634:		CG_Draw3DModel( 640 - (TEXT_ICON_SPACE + ICON_SIZE), 416, ICON_SIZE, ICON_SIZE, handle, 0, origin, angles );
;635:	}
;636:#endif
;637:	//
;638:	// ammo
;639:	//
;640:	if ( cent->currentState.weapon ) {
;641:		value = ps->ammo[cent->currentState.weapon];
;642:		if ( value > -1 ) {
;643:			if ( cg.predictedPlayerState.weaponstate == WEAPON_FIRING
;644:				&& cg.predictedPlayerState.weaponTime > 100 ) {
;645:				// draw as dark grey when reloading
;646:				color = 2;	// dark grey
;647:			} else {
;648:				if ( value >= 0 ) {
;649:					color = 0;	// yellow
;650:				} else {
;651:					color = 1;	// red
;652:				}
;653:			}
;654:#ifdef USE_NEW_FONT_RENDERER
;655:			CG_SelectFont( 1 );
;656:			CG_DrawString( CHAR_WIDTH*3, y, va( "%i", value ), colors[ color ], CHAR_WIDTH, CHAR_HEIGHT, 0, DS_RIGHT | DS_PROPORTIONAL );
;657:			CG_SelectFont( 0 );
;658:#else
;659:			trap_R_SetColor( colors[color] );
;660:			CG_DrawField( 0, y, 3, value );
;661:#endif
;662:			trap_R_SetColor( NULL );
;663:
;664:			// if we didn't draw a 3D icon, draw a 2D icon for ammo
;665:			if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
;666:				qhandle_t	icon;
;667:
;668:				icon = cg_weapons[ cg.predictedPlayerState.weapon ].ammoIcon;
;669:				if ( icon ) {
;670:					CG_DrawPic( CHAR_WIDTH*3 + TEXT_ICON_SPACE, y, ICON_SIZE, ICON_SIZE, icon );
;671:				}
;672:			}
;673:		}
;674:	}
;675:
;676:	//
;677:	// health
;678:	//
;679:	value = ps->stats[STAT_HEALTH];
;680:	if ( value > 100 ) {
;681:		color = 3; // white
;682:	} else if ( value > 25 ) {
;683:		color = 0; 	// yellow
;684:	} else if (value > 0) {
;685:		color = (cg.time >> 8) & 1;	// red/yellow flashing
;686:	} else {
;687:		color = 1; // red
;688:	}
;689:
;690:#ifdef USE_NEW_FONT_RENDERER
;691:	CG_SelectFont( 1 );
;692:	CG_DrawString( 185 + CHAR_WIDTH*3, y, va( "%i", value ), colors[ color ], CHAR_WIDTH, CHAR_HEIGHT, 0, DS_RIGHT | DS_PROPORTIONAL );
;693:	CG_SelectFont( 0 );
;694:#else
;695:	trap_R_SetColor( colors[ color ] );
;696:	// stretch the health up when taking damage
;697:	CG_DrawField( 185, y, 3, value );
;698:#endif
;699:	
;700:	CG_ColorForHealth( hcolor );
;701:	trap_R_SetColor( hcolor );
;702:
;703:	//
;704:	// armor
;705:	//
;706:	value = ps->stats[STAT_ARMOR];
;707:	if ( value > 0 ) {
;708:#ifdef USE_NEW_FONT_RENDERER
;709:		CG_SelectFont( 1 );
;710:		CG_DrawString( 370 + CHAR_WIDTH*3, y, va( "%i", value ), colors[ color ], CHAR_WIDTH, CHAR_HEIGHT, 0, DS_RIGHT | DS_PROPORTIONAL );
;711:		CG_SelectFont( 0 );
;712:#else
;713:		trap_R_SetColor( colors[0] );
;714:		CG_DrawField( 370, y, 3, value );
;715:#endif
;716:		trap_R_SetColor( NULL );
;717:		// if we didn't draw a 3D icon, draw a 2D icon for armor
;718:		if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
;719:			CG_DrawPic( 370 + CHAR_WIDTH*3 + TEXT_ICON_SPACE, y, ICON_SIZE, ICON_SIZE, cgs.media.armorIcon );
;720:		}
;721:	}
;722:
;723:#ifdef MISSIONPACK
;724:	//
;725:	// cubes
;726:	//
;727:	if( cgs.gametype == GT_HARVESTER ) {
;728:		value = ps->generic1;
;729:		if( value > 99 ) {
;730:			value = 99;
;731:		}
;732:		trap_R_SetColor( colors[0] );
;733:		CG_DrawField (640 - (CHAR_WIDTH*2 + TEXT_ICON_SPACE + ICON_SIZE), y, 2, value);
;734:		trap_R_SetColor( NULL );
;735:		// if we didn't draw a 3D icon, draw a 2D icon for armor
;736:		if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
;737:			if( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
;738:				handle = cgs.media.redCubeIcon;
;739:			} else {
;740:				handle = cgs.media.blueCubeIcon;
;741:			}
;742:			CG_DrawPic( 640 - (TEXT_ICON_SPACE + ICON_SIZE), y, ICON_SIZE, ICON_SIZE, handle );
;743:		}
;744:	}
;745:#endif
;746:}
;747:#endif
;748:
;749:/*
;750:===========================================================================================
;751:
;752:  UPPER RIGHT CORNER
;753:
;754:===========================================================================================
;755:*/
;756:
;757:/*
;758:================
;759:CG_DrawAttacker
;760:
;761:================
;762:*/
;763:static float CG_DrawAttacker( float y ) {
line 772
;764:	int			t;
;765:	float		size;
;766:	vec3_t		angles;
;767:	const char	*info;
;768:	const char	*name;
;769:	int			clientNum;
;770:	vec4_t		color;
;771:
;772:	if ( cg.predictedPlayerState.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 cg+107636+184
INDIRI4
CNSTI4 0
GTI4 $303
line 773
;773:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $302
JUMPV
LABELV $303
line 776
;774:	}
;775:
;776:	if ( !cg.attackerTime ) {
ADDRGP4 cg+125524
INDIRI4
CNSTI4 0
NEI4 $307
line 777
;777:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $302
JUMPV
LABELV $307
line 780
;778:	}
;779:
;780:	clientNum = cg.predictedPlayerState.persistant[PERS_ATTACKER];
ADDRLP4 0
ADDRGP4 cg+107636+248+24
INDIRI4
ASGNI4
line 781
;781:	if ( clientNum < 0 || clientNum >= MAX_CLIENTS || clientNum == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $317
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $317
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $313
LABELV $317
line 782
;782:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $302
JUMPV
LABELV $313
line 785
;783:	}
;784:
;785:	t = cg.time - cg.attackerTime;
ADDRLP4 36
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+125524
INDIRI4
SUBI4
ASGNI4
line 786
;786:	if ( t > ATTACKER_HEAD_TIME ) {
ADDRLP4 36
INDIRI4
CNSTI4 10000
LEI4 $320
line 787
;787:		cg.attackerTime = 0;
ADDRGP4 cg+125524
CNSTI4 0
ASGNI4
line 788
;788:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $302
JUMPV
LABELV $320
line 791
;789:	}
;790:
;791:	size = ICON_SIZE * 1.25;
ADDRLP4 4
CNSTF4 1114636288
ASGNF4
line 793
;792:
;793:	angles[PITCH] = 0;
ADDRLP4 24
CNSTF4 0
ASGNF4
line 794
;794:	angles[YAW] = 180;
ADDRLP4 24+4
CNSTF4 1127481344
ASGNF4
line 795
;795:	angles[ROLL] = 0;
ADDRLP4 24+8
CNSTF4 0
ASGNF4
line 796
;796:	CG_DrawHead( cgs.screenXmax + 1 - size, y, size, size, clientNum, angles );
ADDRGP4 cgs+31456
INDIRF4
CNSTF4 1065353216
ADDF4
ADDRLP4 4
INDIRF4
SUBF4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRGP4 CG_DrawHead
CALLV
pop
line 798
;797:
;798:	info = CG_ConfigString( CS_PLAYERS + clientNum );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 56
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 40
ADDRLP4 56
INDIRP4
ASGNP4
line 799
;799:	name = Info_ValueForKey(  info, "n" );
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 $326
ARGP4
ADDRLP4 60
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 44
ADDRLP4 60
INDIRP4
ASGNP4
line 800
;800:	y += size;
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 802
;801:
;802:	VectorSet( color, 1, 1, 1 );
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
ADDRLP4 8+4
CNSTF4 1065353216
ASGNF4
ADDRLP4 8+8
CNSTF4 1065353216
ASGNF4
line 803
;803:	color[3] = 0.5f;
ADDRLP4 8+12
CNSTF4 1056964608
ASGNF4
line 805
;804:
;805:	CG_DrawString( cgs.screenXmax - 4, y, name, color, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_PROPORTIONAL | DS_RIGHT );
ADDRGP4 cgs+31456
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
CNSTI4 0
ARGI4
CNSTI4 20
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 807
;806:
;807:	return y + BIGCHAR_HEIGHT + 2;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1073741824
ADDF4
RETF4
LABELV $302
endproc CG_DrawAttacker 64 32
proc CG_DrawSpeedMeter 8 32
line 816
;808:}
;809:
;810:
;811:/*
;812:================
;813:CG_DrawSpeedMeter
;814:================
;815:*/
;816:static float CG_DrawSpeedMeter( float y ) {
line 820
;817:	const char *s;
;818:
;819:	/* speed meter can get in the way of the scoreboard */
;820:	if ( cg.scoreBoardShowing ) {
ADDRGP4 cg+115360
INDIRI4
CNSTI4 0
EQI4 $332
line 821
;821:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $331
JUMPV
LABELV $332
line 824
;822:	}
;823:
;824:	s = va( "%1.0fups", cg.xyspeed );
ADDRGP4 $335
ARGP4
ADDRGP4 cg+125896
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 826
;825:
;826:	if ( cg_drawSpeed.integer == 1 ) {
ADDRGP4 cg_drawSpeed+12
INDIRI4
CNSTI4 1
NEI4 $337
line 828
;827:		/* top left-hand corner of screen */
;828:		CG_DrawString( cgs.screenXmax - 4, y + 2, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT | DS_PROPORTIONAL );
ADDRGP4 cgs+31456
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
ARGF4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
CNSTI4 0
ARGI4
CNSTI4 21
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 829
;829:		return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
ADDRGP4 $331
JUMPV
LABELV $337
line 830
;830:	} else {
line 832
;831:		/* center of screen */
;832:		CG_DrawString( 320, 300, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_CENTER | DS_PROPORTIONAL );
CNSTF4 1134559232
ARGF4
CNSTF4 1133903872
ARGF4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
CNSTI4 0
ARGI4
CNSTI4 13
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 833
;833:		return y;
ADDRFP4 0
INDIRF4
RETF4
LABELV $331
endproc CG_DrawSpeedMeter 8 32
proc CG_DrawSnapshot 8 32
line 843
;834:	}
;835:}
;836:
;837:
;838:/*
;839:==================
;840:CG_DrawSnapshot
;841:==================
;842:*/
;843:static float CG_DrawSnapshot( float y ) {
line 846
;844:	const char *s;
;845:
;846:	s = va( "time:%i snap:%i cmd:%i", cg.snap->serverTime, 
ADDRGP4 $342
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+28
INDIRI4
ARGI4
ADDRGP4 cgs+31468
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 849
;847:		cg.latestSnapshotNum, cgs.serverCommandSequence );
;848:
;849:	CG_DrawString( cgs.screenXmax - 4, y + 2, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT );
ADDRGP4 cgs+31456
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
ARGF4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
CNSTI4 0
ARGI4
CNSTI4 17
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 851
;850:
;851:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $341
endproc CG_DrawSnapshot 8 32
bss
align 4
LABELV $348
skip 16
align 4
LABELV $349
skip 4
align 4
LABELV $350
skip 4
code
proc CG_DrawFPS 36 32
line 861
;852:}
;853:
;854:
;855:/*
;856:==================
;857:CG_DrawFPS
;858:==================
;859:*/
;860:#define	FPS_FRAMES	4
;861:static float CG_DrawFPS( float y ) {
line 872
;862:	const char	*s;
;863:	static int	previousTimes[FPS_FRAMES];
;864:	static int	index;
;865:	int		i, total;
;866:	int		fps;
;867:	static	int	previous;
;868:	int		t, frameTime;
;869:
;870:	// don't use serverTime, because that will be drifting to
;871:	// correct for internet lag changes, timescales, timedemos, etc
;872:	t = trap_Milliseconds();
ADDRLP4 24
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 24
INDIRI4
ASGNI4
line 873
;873:	frameTime = t - previous;
ADDRLP4 12
ADDRLP4 8
INDIRI4
ADDRGP4 $350
INDIRI4
SUBI4
ASGNI4
line 874
;874:	previous = t;
ADDRGP4 $350
ADDRLP4 8
INDIRI4
ASGNI4
line 876
;875:
;876:	previousTimes[index % FPS_FRAMES] = frameTime;
ADDRGP4 $349
INDIRI4
CNSTI4 4
MODI4
CNSTI4 2
LSHI4
ADDRGP4 $348
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 877
;877:	index++;
ADDRLP4 28
ADDRGP4 $349
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 878
;878:	if ( index > FPS_FRAMES ) {
ADDRGP4 $349
INDIRI4
CNSTI4 4
LEI4 $351
line 880
;879:		// average multiple frames together to smooth changes out a bit
;880:		total = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 881
;881:		for ( i = 0 ; i < FPS_FRAMES ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $353
line 882
;882:			total += previousTimes[i];
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $348
ADDP4
INDIRI4
ADDI4
ASGNI4
line 883
;883:		}
LABELV $354
line 881
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $353
line 884
;884:		if ( !total ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $357
line 885
;885:			total = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 886
;886:		}
LABELV $357
line 887
;887:		fps = 1000 * FPS_FRAMES / total;
ADDRLP4 20
CNSTI4 4000
ADDRLP4 4
INDIRI4
DIVI4
ASGNI4
line 889
;888:
;889:		s = va( "%ifps", fps );
ADDRGP4 $359
ARGP4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 32
INDIRP4
ASGNP4
line 890
;890:		CG_DrawString( cgs.screenXmax - 4, y + 2, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT | DS_PROPORTIONAL );
ADDRGP4 cgs+31456
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
ARGF4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
CNSTI4 0
ARGI4
CNSTI4 21
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 891
;891:	}
LABELV $351
line 893
;892:
;893:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $347
endproc CG_DrawFPS 36 32
proc CG_DrawTimer 20 32
line 902
;894:}
;895:
;896:
;897:/*
;898:=================
;899:CG_DrawTimer
;900:=================
;901:*/
;902:static float CG_DrawTimer( float y ) {
line 907
;903:	const char	*s;
;904:	int			mins, seconds;
;905:	int			msec;
;906:
;907:	msec = cg.time - cgs.levelStartTime;
ADDRLP4 12
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+34820
INDIRI4
SUBI4
ASGNI4
line 909
;908:
;909:	seconds = msec / 1000;
ADDRLP4 0
ADDRLP4 12
INDIRI4
CNSTI4 1000
DIVI4
ASGNI4
line 910
;910:	mins = seconds / 60;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 60
DIVI4
ASGNI4
line 911
;911:	seconds -= mins * 60;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 60
MULI4
SUBI4
ASGNI4
line 913
;912:
;913:	s = va( "%i:%02i", mins, seconds );
ADDRGP4 $364
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
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
line 914
;914:	CG_DrawString( cgs.screenXmax - 4, y + 2, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT | DS_PROPORTIONAL );
ADDRGP4 cgs+31456
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
ARGF4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
CNSTI4 0
ARGI4
CNSTI4 21
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 916
;915:
;916:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $361
endproc CG_DrawTimer 20 32
proc CG_DrawTeamOverlay 120 32
line 925
;917:}
;918:
;919:
;920:/*
;921:=================
;922:CG_DrawTeamOverlay
;923:=================
;924:*/
;925:static float CG_DrawTeamOverlay( float y, qboolean right, qboolean upper ) {
line 937
;926:	int x, w, h, xx;
;927:	int i, j, len;
;928:	const char *p;
;929:	vec4_t		hcolor;
;930:	int pwidth, lwidth;
;931:	int plyrs;
;932:	char st[16];
;933:	clientInfo_t *ci;
;934:	gitem_t	*item;
;935:	int ret_y, count;
;936:
;937:	if ( !cg_drawTeamOverlay.integer ) {
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 0
NEI4 $367
line 938
;938:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $366
JUMPV
LABELV $367
line 941
;939:	}
;940:
;941:	if ( cg.snap->ps.persistant[PERS_TEAM] != TEAM_RED && cg.snap->ps.persistant[PERS_TEAM] != TEAM_BLUE ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
EQI4 $370
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
EQI4 $370
line 942
;942:		return y; // Not on any team
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $366
JUMPV
LABELV $370
line 945
;943:	}
;944:
;945:	plyrs = 0;
ADDRLP4 76
CNSTI4 0
ASGNI4
line 948
;946:
;947:	// max player name width
;948:	pwidth = 0;
ADDRLP4 56
CNSTI4 0
ASGNI4
line 949
;949:	count = (numSortedTeamPlayers > 8) ? 8 : numSortedTeamPlayers;
ADDRGP4 numSortedTeamPlayers
INDIRI4
CNSTI4 8
LEI4 $375
ADDRLP4 92
CNSTI4 8
ASGNI4
ADDRGP4 $376
JUMPV
LABELV $375
ADDRLP4 92
ADDRGP4 numSortedTeamPlayers
INDIRI4
ASGNI4
LABELV $376
ADDRLP4 48
ADDRLP4 92
INDIRI4
ASGNI4
line 950
;950:	for (i = 0; i < count; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $380
JUMPV
LABELV $377
line 951
;951:		ci = cgs.clientinfo + sortedTeamPlayers[i];
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 952
;952:		if ( ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $382
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
NEI4 $382
line 953
;953:			plyrs++;
ADDRLP4 76
ADDRLP4 76
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 954
;954:			len = CG_DrawStrlen(ci->name);
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 100
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 100
INDIRI4
ASGNI4
line 955
;955:			if (len > pwidth)
ADDRLP4 40
INDIRI4
ADDRLP4 56
INDIRI4
LEI4 $385
line 956
;956:				pwidth = len;
ADDRLP4 56
ADDRLP4 40
INDIRI4
ASGNI4
LABELV $385
line 957
;957:		}
LABELV $382
line 958
;958:	}
LABELV $378
line 950
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $380
ADDRLP4 8
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $377
line 960
;959:
;960:	if (!plyrs)
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $387
line 961
;961:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $366
JUMPV
LABELV $387
line 963
;962:
;963:	if (pwidth > TEAM_OVERLAY_MAXNAME_WIDTH)
ADDRLP4 56
INDIRI4
CNSTI4 12
LEI4 $389
line 964
;964:		pwidth = TEAM_OVERLAY_MAXNAME_WIDTH;
ADDRLP4 56
CNSTI4 12
ASGNI4
LABELV $389
line 967
;965:
;966:	// max location name width
;967:	lwidth = 0;
ADDRLP4 44
CNSTI4 0
ASGNI4
line 968
;968:	for (i = 1; i < MAX_LOCATIONS; i++) {
ADDRLP4 8
CNSTI4 1
ASGNI4
LABELV $391
line 969
;969:		p = CG_ConfigString(CS_LOCATIONS + i);
ADDRLP4 8
INDIRI4
CNSTI4 608
ADDI4
ARGI4
ADDRLP4 96
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 96
INDIRP4
ASGNP4
line 970
;970:		if (p && *p) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $395
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $395
line 971
;971:			len = CG_DrawStrlen(p);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 104
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 104
INDIRI4
ASGNI4
line 972
;972:			if (len > lwidth)
ADDRLP4 40
INDIRI4
ADDRLP4 44
INDIRI4
LEI4 $397
line 973
;973:				lwidth = len;
ADDRLP4 44
ADDRLP4 40
INDIRI4
ASGNI4
LABELV $397
line 974
;974:		}
LABELV $395
line 975
;975:	}
LABELV $392
line 968
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 64
LTI4 $391
line 977
;976:
;977:	if (lwidth > TEAM_OVERLAY_MAXLOCATION_WIDTH)
ADDRLP4 44
INDIRI4
CNSTI4 16
LEI4 $399
line 978
;978:		lwidth = TEAM_OVERLAY_MAXLOCATION_WIDTH;
ADDRLP4 44
CNSTI4 16
ASGNI4
LABELV $399
line 980
;979:
;980:	w = (pwidth + lwidth + 4 + 7) * TINYCHAR_WIDTH;
ADDRLP4 80
ADDRLP4 56
INDIRI4
ADDRLP4 44
INDIRI4
ADDI4
CNSTI4 3
LSHI4
CNSTI4 32
ADDI4
CNSTI4 56
ADDI4
ASGNI4
line 982
;981:
;982:	if ( right )
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $401
line 983
;983:		x = cgs.screenXmax + 1 - w;
ADDRLP4 52
ADDRGP4 cgs+31456
INDIRF4
CNSTF4 1065353216
ADDF4
ADDRLP4 80
INDIRI4
CVIF4 4
SUBF4
CVFI4 4
ASGNI4
ADDRGP4 $402
JUMPV
LABELV $401
line 985
;984:	else
;985:		x = cgs.screenXmin;
ADDRLP4 52
ADDRGP4 cgs+31452
INDIRF4
CVFI4 4
ASGNI4
LABELV $402
line 987
;986:
;987:	h = plyrs * TINYCHAR_HEIGHT;
ADDRLP4 84
ADDRLP4 76
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 989
;988:
;989:	if ( upper ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $405
line 990
;990:		ret_y = y + h;
ADDRLP4 88
ADDRFP4 0
INDIRF4
ADDRLP4 84
INDIRI4
CVIF4 4
ADDF4
CVFI4 4
ASGNI4
line 991
;991:	} else {
ADDRGP4 $406
JUMPV
LABELV $405
line 992
;992:		y -= h;
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 84
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 993
;993:		ret_y = y;
ADDRLP4 88
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 994
;994:	}
LABELV $406
line 996
;995:
;996:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $407
line 997
;997:		hcolor[0] = 1.0f;
ADDRLP4 24
CNSTF4 1065353216
ASGNF4
line 998
;998:		hcolor[1] = 0.0f;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 999
;999:		hcolor[2] = 0.0f;
ADDRLP4 24+8
CNSTF4 0
ASGNF4
line 1000
;1000:		hcolor[3] = 0.33f;
ADDRLP4 24+12
CNSTF4 1051260355
ASGNF4
line 1001
;1001:	} else { // if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE )
ADDRGP4 $408
JUMPV
LABELV $407
line 1002
;1002:		hcolor[0] = 0.0f;
ADDRLP4 24
CNSTF4 0
ASGNF4
line 1003
;1003:		hcolor[1] = 0.0f;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 1004
;1004:		hcolor[2] = 1.0f;
ADDRLP4 24+8
CNSTF4 1065353216
ASGNF4
line 1005
;1005:		hcolor[3] = 0.33f;
ADDRLP4 24+12
CNSTF4 1051260355
ASGNF4
line 1006
;1006:	}
LABELV $408
line 1007
;1007:	trap_R_SetColor( hcolor );
ADDRLP4 24
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1008
;1008:	CG_DrawPic( x, y, w, h, cgs.media.teamStatusBar );
ADDRLP4 52
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 80
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 84
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+148772+160
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1009
;1009:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1011
;1010:
;1011:	for (i = 0; i < count; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $421
JUMPV
LABELV $418
line 1012
;1012:		ci = cgs.clientinfo + sortedTeamPlayers[i];
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 1013
;1013:		if ( ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $423
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
NEI4 $423
line 1015
;1014:
;1015:			hcolor[0] = hcolor[1] = hcolor[2] = hcolor[3] = 1.0;
ADDRLP4 100
CNSTF4 1065353216
ASGNF4
ADDRLP4 24+12
ADDRLP4 100
INDIRF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 100
INDIRF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 100
INDIRF4
ASGNF4
ADDRLP4 24
ADDRLP4 100
INDIRF4
ASGNF4
line 1017
;1016:
;1017:			xx = x + TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 52
INDIRI4
CNSTI4 8
ADDI4
ASGNI4
line 1019
;1018:
;1019:			CG_DrawString( xx, y, ci->name, hcolor, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, TEAM_OVERLAY_MAXNAME_WIDTH, DS_PROPORTIONAL );
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 24
ARGP4
CNSTF4 1090519040
ARGF4
CNSTF4 1090519040
ARGF4
CNSTI4 12
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 1021
;1020:
;1021:			if (lwidth) {
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $429
line 1022
;1022:				p = CG_ConfigString(CS_LOCATIONS + ci->location);
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 608
ADDI4
ARGI4
ADDRLP4 104
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 104
INDIRP4
ASGNP4
line 1023
;1023:				if (!p || !*p)
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $433
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $431
LABELV $433
line 1024
;1024:					p = "unknown";
ADDRLP4 20
ADDRGP4 $434
ASGNP4
LABELV $431
line 1025
;1025:				len = CG_DrawStrlen(p);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 112
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 112
INDIRI4
ASGNI4
line 1026
;1026:				if (len > lwidth)
ADDRLP4 40
INDIRI4
ADDRLP4 44
INDIRI4
LEI4 $435
line 1027
;1027:					len = lwidth;
ADDRLP4 40
ADDRLP4 44
INDIRI4
ASGNI4
LABELV $435
line 1031
;1028:
;1029://				xx = x + TINYCHAR_WIDTH * 2 + TINYCHAR_WIDTH * pwidth + 
;1030://					((lwidth/2 - len/2) * TINYCHAR_WIDTH);
;1031:				xx = x + TINYCHAR_WIDTH * 2 + TINYCHAR_WIDTH * pwidth;
ADDRLP4 12
ADDRLP4 52
INDIRI4
CNSTI4 16
ADDI4
ADDRLP4 56
INDIRI4
CNSTI4 3
LSHI4
ADDI4
ASGNI4
line 1032
;1032:				CG_DrawString( xx, y, p, hcolor, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, TEAM_OVERLAY_MAXLOCATION_WIDTH, DS_PROPORTIONAL );
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
CNSTF4 1090519040
ARGF4
CNSTF4 1090519040
ARGF4
CNSTI4 16
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 1033
;1033:			}
LABELV $429
line 1035
;1034:
;1035:			CG_GetColorForHealth( ci->health, ci->armor, hcolor );
ADDRLP4 4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRGP4 CG_GetColorForHealth
CALLV
pop
line 1037
;1036:
;1037:			Com_sprintf (st, sizeof(st), "%3i %3i", ci->health,	ci->armor);
ADDRLP4 60
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $437
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1039
;1038:
;1039:			xx = x + TINYCHAR_WIDTH * 3 + 
ADDRLP4 12
ADDRLP4 52
INDIRI4
CNSTI4 24
ADDI4
ADDRLP4 56
INDIRI4
CNSTI4 3
LSHI4
ADDI4
ADDRLP4 44
INDIRI4
CNSTI4 3
LSHI4
ADDI4
ASGNI4
line 1042
;1040:				TINYCHAR_WIDTH * pwidth + TINYCHAR_WIDTH * lwidth;
;1041:
;1042:			CG_DrawString( xx, y, st, hcolor, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0, 0 );
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 60
ARGP4
ADDRLP4 24
ARGP4
CNSTF4 1090519040
ARGF4
CNSTF4 1090519040
ARGF4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 1045
;1043:
;1044:			// draw weapon icon
;1045:			xx += TINYCHAR_WIDTH * 3;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 24
ADDI4
ASGNI4
line 1047
;1046:
;1047:			if ( cg_weapons[ci->curWeapon].weaponIcon ) {
ADDRLP4 4
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 136
MULI4
ADDRGP4 cg_weapons+68
ADDP4
INDIRI4
CNSTI4 0
EQI4 $438
line 1048
;1048:				CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
CNSTF4 1090519040
ARGF4
CNSTF4 1090519040
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 136
MULI4
ADDRGP4 cg_weapons+68
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1050
;1049:					cg_weapons[ci->curWeapon].weaponIcon );
;1050:			} else {
ADDRGP4 $439
JUMPV
LABELV $438
line 1051
;1051:				CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
CNSTF4 1090519040
ARGF4
CNSTF4 1090519040
ARGF4
ADDRGP4 cgs+148772+164
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1053
;1052:					cgs.media.deferShader );
;1053:			}
LABELV $439
line 1056
;1054:
;1055:			// Draw powerup icons
;1056:			if (right) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $444
line 1057
;1057:				xx = x;
ADDRLP4 12
ADDRLP4 52
INDIRI4
ASGNI4
line 1058
;1058:			} else {
ADDRGP4 $445
JUMPV
LABELV $444
line 1059
;1059:				xx = x + w - TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 52
INDIRI4
ADDRLP4 80
INDIRI4
ADDI4
CNSTI4 8
SUBI4
ASGNI4
line 1060
;1060:			}
LABELV $445
line 1061
;1061:			for (j = 0; j <= PW_NUM_POWERUPS; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $446
line 1062
;1062:				if (ci->powerups & (1 << j)) {
ADDRLP4 4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $450
line 1064
;1063:
;1064:					item = BG_FindItemForPowerup( j );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 112
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 112
INDIRP4
ASGNP4
line 1066
;1065:
;1066:					if (item) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $452
line 1067
;1067:						CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 
ADDRLP4 16
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 116
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
CNSTF4 1090519040
ARGF4
CNSTF4 1090519040
ARGF4
ADDRLP4 116
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1069
;1068:						trap_R_RegisterShader( item->icon ) );
;1069:						if (right) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $454
line 1070
;1070:							xx -= TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 1071
;1071:						} else {
ADDRGP4 $455
JUMPV
LABELV $454
line 1072
;1072:							xx += TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 8
ADDI4
ASGNI4
line 1073
;1073:						}
LABELV $455
line 1074
;1074:					}
LABELV $452
line 1075
;1075:				}
LABELV $450
line 1076
;1076:			}
LABELV $447
line 1061
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 15
LEI4 $446
line 1078
;1077:
;1078:			y += TINYCHAR_HEIGHT;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 1079
;1079:		}
LABELV $423
line 1080
;1080:	}
LABELV $419
line 1011
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $421
ADDRLP4 8
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $418
line 1082
;1081:
;1082:	return ret_y;
ADDRLP4 88
INDIRI4
CVIF4 4
RETF4
LABELV $366
endproc CG_DrawTeamOverlay 120 32
proc CG_DrawUpperRight 12 12
line 1093
;1083:}
;1084:
;1085:
;1086:/*
;1087:=====================
;1088:CG_DrawUpperRight
;1089:
;1090:=====================
;1091:*/
;1092:static void CG_DrawUpperRight(stereoFrame_t stereoFrame)
;1093:{
line 1096
;1094:	float	y;
;1095:
;1096:	y = cgs.screenYmin;
ADDRLP4 0
ADDRGP4 cgs+31460
INDIRF4
ASGNF4
line 1098
;1097:
;1098:	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 1 ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $458
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 1
NEI4 $458
line 1099
;1099:		y = CG_DrawTeamOverlay( y, qtrue, qtrue );
ADDRLP4 0
INDIRF4
ARGF4
CNSTI4 1
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 CG_DrawTeamOverlay
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1100
;1100:	} 
LABELV $458
line 1101
;1101:	if ( cg_drawSnapshot.integer ) {
ADDRGP4 cg_drawSnapshot+12
INDIRI4
CNSTI4 0
EQI4 $462
line 1102
;1102:		y = CG_DrawSnapshot( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawSnapshot
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1103
;1103:	}
LABELV $462
line 1104
;1104:	if (cg_drawFPS.integer && (stereoFrame == STEREO_CENTER || stereoFrame == STEREO_RIGHT)) {
ADDRGP4 cg_drawFPS+12
INDIRI4
CNSTI4 0
EQI4 $465
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $468
ADDRLP4 4
INDIRI4
CNSTI4 2
NEI4 $465
LABELV $468
line 1105
;1105:		y = CG_DrawFPS( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 CG_DrawFPS
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 1106
;1106:	}
LABELV $465
line 1107
;1107:	if ( cg_drawSpeed.integer ) {
ADDRGP4 cg_drawSpeed+12
INDIRI4
CNSTI4 0
EQI4 $469
line 1108
;1108:		y = CG_DrawSpeedMeter( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 CG_DrawSpeedMeter
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 1109
;1109:	}	
LABELV $469
line 1110
;1110:	if ( cg_drawTimer.integer ) {
ADDRGP4 cg_drawTimer+12
INDIRI4
CNSTI4 0
EQI4 $472
line 1111
;1111:		y = CG_DrawTimer( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 CG_DrawTimer
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 1112
;1112:	}
LABELV $472
line 1113
;1113:	if ( cg_drawAttacker.integer ) {
ADDRGP4 cg_drawAttacker+12
INDIRI4
CNSTI4 0
EQI4 $475
line 1114
;1114:		y = CG_DrawAttacker( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 CG_DrawAttacker
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 1115
;1115:	}
LABELV $475
line 1116
;1116:}
LABELV $456
endproc CG_DrawUpperRight 12 12
proc CG_DrawReward 68 32
line 1602
;1117:
;1118:
;1119:/*
;1120:===========================================================================================
;1121:
;1122:  LOWER RIGHT CORNER
;1123:
;1124:===========================================================================================
;1125:*/
;1126:
;1127:/*
;1128:=================
;1129:CG_DrawScores
;1130:
;1131:Draw the small two score display
;1132:=================
;1133:*/
;1134:#ifndef MISSIONPACK
;1135:static float CG_DrawScores( float y ) {
;1136:	const char	*s;
;1137:	int			s1, s2, score;
;1138:	int			x, x0, w;
;1139:	int			v;
;1140:	vec4_t		color;
;1141:	float		y1;
;1142:	gitem_t		*item;
;1143:
;1144:	s1 = cgs.scores1;
;1145:	s2 = cgs.scores2;
;1146:
;1147:	y -=  BIGCHAR_HEIGHT + 8 - 4;
;1148:
;1149:	y1 = y;
;1150:
;1151:	// draw from the right side to left
;1152:	if ( cgs.gametype >= GT_TEAM ) {
;1153:		x0 = cgs.screenXmax + 1;
;1154:		color[0] = 0.0f;
;1155:		color[1] = 0.1f;
;1156:		color[2] = 1.0f;
;1157:		color[3] = 0.33f;
;1158:		// second score
;1159:		s = va( "%2i", s2 );
;1160:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
;1161:		x = x0 - w;
;1162:		CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
;1163:		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
;1164:			CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
;1165:		}
;1166:		CG_DrawString( x0-4, y, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT );
;1167:
;1168:		if ( cgs.gametype == GT_CTF ) {
;1169:			// Display flag status
;1170:			item = BG_FindItemForPowerup( PW_BLUEFLAG );
;1171:
;1172:			if (item) {
;1173:				y1 = y - BIGCHAR_HEIGHT - 8;
;1174:				if( cgs.blueflag >= 0 && cgs.blueflag <= 2 ) {
;1175:					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.blueFlagShader[cgs.blueflag] );
;1176:				}
;1177:			}
;1178:		}
;1179:		color[0] = 1.0f;
;1180:		color[1] = 0.0f;
;1181:		color[2] = 0.0f;
;1182:		color[3] = 0.33f;
;1183:		// first score
;1184:		x0 = x;
;1185:		s = va( "%2i", s1 );
;1186:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
;1187:		x -= w;
;1188:		CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
;1189:		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
;1190:			CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
;1191:		}
;1192:
;1193:		CG_DrawString( x0-4, y, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT );
;1194:
;1195:		if ( cgs.gametype == GT_CTF ) {
;1196:			// Display flag status
;1197:			item = BG_FindItemForPowerup( PW_REDFLAG );
;1198:
;1199:			if (item) {
;1200:				y1 = y - BIGCHAR_HEIGHT - 8;
;1201:				if( cgs.redflag >= 0 && cgs.redflag <= 2 ) {
;1202:					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.redFlagShader[cgs.redflag] );
;1203:				}
;1204:			}
;1205:		}
;1206:
;1207:#ifdef MISSIONPACK
;1208:		if ( cgs.gametype == GT_1FCTF ) {
;1209:			// Display flag status
;1210:			item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
;1211:
;1212:			if (item) {
;1213:				y1 = y - BIGCHAR_HEIGHT - 8;
;1214:				if( cgs.flagStatus >= 0 && cgs.flagStatus <= 3 ) {
;1215:					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.flagShader[cgs.flagStatus] );
;1216:				}
;1217:			}
;1218:		}
;1219:#endif
;1220:		if ( cgs.gametype >= GT_CTF ) {
;1221:			v = cgs.capturelimit;
;1222:		} else {
;1223:			v = cgs.fraglimit;
;1224:		}
;1225:		if ( v ) {
;1226:			s = va( "%2i", v );
;1227:			CG_DrawString( x-4, y, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT );
;1228:		}
;1229:
;1230:	} else {
;1231:		qboolean	spectator;
;1232:
;1233:		x = cgs.screenXmax + 1;
;1234:
;1235:		score = cg.snap->ps.persistant[PERS_SCORE];
;1236:		spectator = ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR );
;1237:
;1238:		// always show your score in the second box if not in first place
;1239:		if ( s1 != score ) {
;1240:			s2 = score;
;1241:		}
;1242:		if ( s2 != SCORE_NOT_PRESENT ) {
;1243:			x0 = x;
;1244:			s = va( "%2i", s2 );
;1245:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
;1246:			x -= w;
;1247:			if ( !spectator && score == s2 && score != s1 ) {
;1248:				color[0] = 1.0f;
;1249:				color[1] = 0.0f;
;1250:				color[2] = 0.0f;
;1251:				color[3] = 0.33f;
;1252:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
;1253:				CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
;1254:			} else {
;1255:				color[0] = 0.5f;
;1256:				color[1] = 0.5f;
;1257:				color[2] = 0.5f;
;1258:				color[3] = 0.33f;
;1259:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
;1260:			}	
;1261:			CG_DrawString( x0-4, y, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT );
;1262:		}
;1263:
;1264:		// first place
;1265:		if ( s1 != SCORE_NOT_PRESENT ) {
;1266:			x0 = x;
;1267:			s = va( "%2i", s1 );
;1268:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
;1269:			x -= w;
;1270:			if ( !spectator && score == s1 ) {
;1271:				color[0] = 0.0f;
;1272:				color[1] = 0.1f;
;1273:				color[2] = 1.0f;
;1274:				color[3] = 0.33f;
;1275:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
;1276:				CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
;1277:			} else {
;1278:				color[0] = 0.5f;
;1279:				color[1] = 0.5f;
;1280:				color[2] = 0.5f;
;1281:				color[3] = 0.33f;
;1282:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
;1283:			}
;1284:			CG_DrawString( x0-4, y, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT );
;1285:		}
;1286:
;1287:		if ( cgs.fraglimit ) {
;1288:			s = va( "%2i", cgs.fraglimit );
;1289:			CG_DrawString( x-4, y, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_RIGHT );
;1290:		}
;1291:	}
;1292:
;1293:	return y1 - 8;
;1294:}
;1295:#endif // MISSIONPACK
;1296:
;1297:
;1298:/*
;1299:================
;1300:CG_DrawPowerups
;1301:================
;1302:*/
;1303:#ifndef MISSIONPACK
;1304:static float CG_DrawPowerups( float y ) {
;1305:	int		sorted[MAX_POWERUPS];
;1306:	int		sortedTime[MAX_POWERUPS];
;1307:	int		i, j, k;
;1308:	int		active;
;1309:	playerState_t	*ps;
;1310:	int		t;
;1311:	gitem_t	*item;
;1312:	int		x;
;1313:	int		color;
;1314:	float	size;
;1315:	float	f;
;1316:	static const float colors[2][4] = { 
;1317:		{ 0.2f, 1.0f, 0.2f, 1.0f },
;1318:		{ 1.0f, 0.2f, 0.2f, 1.0f } 
;1319:	};
;1320:
;1321:	ps = &cg.snap->ps;
;1322:
;1323:	if ( ps->stats[STAT_HEALTH] <= 0 ) {
;1324:		return y;
;1325:	}
;1326:
;1327:	// sort the list by time remaining
;1328:	active = 0;
;1329:	for ( i = 0 ; i < MAX_POWERUPS ; i++ ) {
;1330:		if ( !ps->powerups[ i ] ) {
;1331:			continue;
;1332:		}
;1333:		t = ps->powerups[ i ] - cg.time;
;1334:		// ZOID--don't draw if the power up has unlimited time (999 seconds)
;1335:		// This is true of the CTF flags
;1336:		if ( t < 0 || t > 999000) {
;1337:			continue;
;1338:		}
;1339:
;1340:		// insert into the list
;1341:		for ( j = 0 ; j < active ; j++ ) {
;1342:			if ( sortedTime[j] >= t ) {
;1343:				for ( k = active - 1 ; k >= j ; k-- ) {
;1344:					sorted[k+1] = sorted[k];
;1345:					sortedTime[k+1] = sortedTime[k];
;1346:				}
;1347:				break;
;1348:			}
;1349:		}
;1350:		sorted[j] = i;
;1351:		sortedTime[j] = t;
;1352:		active++;
;1353:	}
;1354:
;1355:	// draw the icons and timers
;1356:	x = cgs.screenXmax + 1 - ICON_SIZE - CHAR_WIDTH * 2;
;1357:	for ( i = 0 ; i < active ; i++ ) {
;1358:		item = BG_FindItemForPowerup( sorted[i] );
;1359:
;1360:		if ( item ) {
;1361:
;1362:			color = 1;
;1363:
;1364:			y -= ICON_SIZE;
;1365:
;1366:			trap_R_SetColor( colors[color] );
;1367:			CG_DrawField( x, y, 2, sortedTime[ i ] / 1000 );
;1368:
;1369:			t = ps->powerups[ sorted[i] ];
;1370:			if ( t - cg.time >= POWERUP_BLINKS * POWERUP_BLINK_TIME ) {
;1371:				trap_R_SetColor( NULL );
;1372:			} else {
;1373:				vec4_t	modulate;
;1374:
;1375:				f = (float)( t - cg.time ) / POWERUP_BLINK_TIME;
;1376:				f -= (int)f;
;1377:				modulate[0] = modulate[1] = modulate[2] = modulate[3] = f;
;1378:				trap_R_SetColor( modulate );
;1379:			}
;1380:
;1381:			if ( cg.powerupActive == sorted[i] && 
;1382:				cg.time - cg.powerupTime < PULSE_TIME ) {
;1383:				f = 1.0 - ( (float)( cg.time - cg.powerupTime ) / PULSE_TIME );
;1384:				size = ICON_SIZE * ( 1.0 + ( PULSE_SCALE - 1.0 ) * f );
;1385:			} else {
;1386:				size = ICON_SIZE;
;1387:			}
;1388:
;1389:			CG_DrawPic( cgs.screenXmax + 1 - size, y + ICON_SIZE / 2 - size / 2, 
;1390:				size, size, trap_R_RegisterShader( item->icon ) );
;1391:		} // if ( item )
;1392:	}
;1393:	trap_R_SetColor( NULL );
;1394:
;1395:	return y;
;1396:}
;1397:#endif // MISSIONPACK
;1398:
;1399:
;1400:/*
;1401:=====================
;1402:CG_DrawLowerRight
;1403:
;1404:=====================
;1405:*/
;1406:#ifndef MISSIONPACK
;1407:static void CG_DrawLowerRight( void ) {
;1408:	float	y;
;1409:
;1410:	y = cgs.screenYmax + 1 - STATUSBAR_HEIGHT;
;1411:
;1412:	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 2 ) {
;1413:		y = CG_DrawTeamOverlay( y, qtrue, qfalse );
;1414:	} 
;1415:
;1416:	y = CG_DrawScores( y );
;1417:	y = CG_DrawPowerups( y );
;1418:}
;1419:#endif // MISSIONPACK
;1420:
;1421:
;1422:/*
;1423:===================
;1424:CG_DrawPickupItem
;1425:===================
;1426:*/
;1427:#ifndef MISSIONPACK
;1428:static int CG_DrawPickupItem( int y ) {
;1429:	int		value;
;1430:	float	*fadeColor;
;1431:	const char *text;
;1432:
;1433:	if ( cg.snap->ps.stats[STAT_HEALTH] <= 0 ) {
;1434:		return y;
;1435:	}
;1436:
;1437:	y -= PICKUP_ICON_SIZE;
;1438:
;1439:	value = cg.itemPickup;
;1440:	if ( value ) {
;1441:		fadeColor = CG_FadeColorTime( cg.itemPickupTime, 3000, 250 );
;1442:		if ( fadeColor ) {
;1443:			CG_RegisterItemVisuals( value );
;1444:			trap_R_SetColor( fadeColor );
;1445:			CG_DrawPic( cgs.screenXmin + 8, y, PICKUP_ICON_SIZE, PICKUP_ICON_SIZE, cg_items[ value ].icon );
;1446:			if ( cg.itemPickupCount > 1 ) {
;1447:				text = va( "%s x%i", bg_itemlist[ value ].pickup_name, cg.itemPickupCount );
;1448:			} else {
;1449:				text = bg_itemlist[ value ].pickup_name;
;1450:			}
;1451:
;1452:			CG_DrawString( cgs.screenXmin + PICKUP_ICON_SIZE + 16, y + (PICKUP_ICON_SIZE/2 - PICKUP_TEXT_SIZE/2), 
;1453:				text, fadeColor, PICKUP_TEXT_SIZE, PICKUP_TEXT_SIZE, 0, DS_SHADOW | DS_PROPORTIONAL );
;1454:			
;1455:			trap_R_SetColor( NULL );
;1456:		} else {
;1457:			cg.itemPickupCount = 0;
;1458:		}
;1459:	}
;1460:	
;1461:	return y;
;1462:}
;1463:#endif // MISSIONPACK
;1464:
;1465:
;1466:/*
;1467:=====================
;1468:CG_DrawLowerLeft
;1469:=====================
;1470:*/
;1471:#ifndef MISSIONPACK
;1472:static void CG_DrawLowerLeft( void ) {
;1473:	float	y;
;1474:
;1475:	y = cgs.screenYmax + 1 - STATUSBAR_HEIGHT;
;1476:
;1477:	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 3 ) {
;1478:		y = CG_DrawTeamOverlay( y, qfalse, qfalse );
;1479:	} 
;1480:
;1481:	y = CG_DrawPickupItem( y );
;1482:}
;1483:#endif // MISSIONPACK
;1484:
;1485:
;1486://===========================================================================================
;1487:
;1488:/*
;1489:=================
;1490:CG_DrawTeamInfo
;1491:=================
;1492:*/
;1493:#ifndef MISSIONPACK
;1494:static void CG_DrawTeamInfo( void ) {
;1495:	int w, h;
;1496:	int i, len;
;1497:	vec4_t		hcolor;
;1498:	int		chatHeight;
;1499:
;1500:	#define CHATLOC_Y (cgs.screenYmax + 1 - STATUSBAR_HEIGHT ) // bottom end
;1501:	#define CHATLOC_X (cgs.screenXmin)
;1502:
;1503:	if (cg_teamChatHeight.integer < TEAMCHAT_HEIGHT)
;1504:		chatHeight = cg_teamChatHeight.integer;
;1505:	else
;1506:		chatHeight = TEAMCHAT_HEIGHT;
;1507:	if (chatHeight <= 0)
;1508:		return; // disabled
;1509:
;1510:	if (cgs.teamLastChatPos != cgs.teamChatPos) {
;1511:		if (cg.time - cgs.teamChatMsgTimes[cgs.teamLastChatPos % chatHeight] > cg_teamChatTime.integer) {
;1512:			cgs.teamLastChatPos++;
;1513:		}
;1514:
;1515:		h = (cgs.teamChatPos - cgs.teamLastChatPos) * TINYCHAR_HEIGHT;
;1516:
;1517:		w = 0;
;1518:
;1519:		for (i = cgs.teamLastChatPos; i < cgs.teamChatPos; i++) {
;1520:			len = CG_DrawStrlen(cgs.teamChatMsgs[i % chatHeight]);
;1521:			if (len > w)
;1522:				w = len;
;1523:		}
;1524:		w *= TINYCHAR_WIDTH;
;1525:		w += TINYCHAR_WIDTH * 2;
;1526:
;1527:		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
;1528:			hcolor[0] = 1.0f;
;1529:			hcolor[1] = 0.0f;
;1530:			hcolor[2] = 0.0f;
;1531:			hcolor[3] = 0.33f;
;1532:		} else if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
;1533:			hcolor[0] = 0.0f;
;1534:			hcolor[1] = 0.0f;
;1535:			hcolor[2] = 1.0f;
;1536:			hcolor[3] = 0.33f;
;1537:		} else {
;1538:			hcolor[0] = 0.0f;
;1539:			hcolor[1] = 1.0f;
;1540:			hcolor[2] = 0.0f;
;1541:			hcolor[3] = 0.33f;
;1542:		}
;1543:
;1544:		trap_R_SetColor( hcolor );
;1545:		CG_DrawPic( CHATLOC_X, CHATLOC_Y - h, w, h, cgs.media.teamStatusBar );
;1546:		trap_R_SetColor( NULL );
;1547:
;1548:		hcolor[0] = hcolor[1] = hcolor[2] = 1.0f;
;1549:		hcolor[3] = 1.0f;
;1550:
;1551:		for ( i = cgs.teamChatPos - 1; i >= cgs.teamLastChatPos; i-- ) {
;1552:			CG_DrawString( CHATLOC_X + TINYCHAR_WIDTH, CHATLOC_Y - (cgs.teamChatPos - i)*TINYCHAR_HEIGHT, 
;1553:				cgs.teamChatMsgs[i % chatHeight], hcolor, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0, DS_PROPORTIONAL );
;1554:		}
;1555:	}
;1556:}
;1557:#endif // MISSIONPACK
;1558:
;1559:
;1560:/*
;1561:===================
;1562:CG_DrawHoldableItem
;1563:===================
;1564:*/
;1565:#ifndef MISSIONPACK
;1566:static void CG_DrawHoldableItem( void ) { 
;1567:	int		value;
;1568:
;1569:	value = cg.snap->ps.stats[STAT_HOLDABLE_ITEM];
;1570:	if ( value ) {
;1571:		CG_RegisterItemVisuals( value );
;1572:		CG_DrawPic( cgs.screenXmax + 1 - ICON_SIZE, (SCREEN_HEIGHT-ICON_SIZE)/2, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon );
;1573:	}
;1574:}
;1575:#endif // MISSIONPACK
;1576:
;1577:#ifdef MISSIONPACK
;1578:/*
;1579:===================
;1580:CG_DrawPersistantPowerup
;1581:===================
;1582:*/
;1583:#if 0 // sos001208 - DEAD
;1584:static void CG_DrawPersistantPowerup( void ) { 
;1585:	int		value;
;1586:
;1587:	value = cg.snap->ps.stats[STAT_PERSISTANT_POWERUP];
;1588:	if ( value ) {
;1589:		CG_RegisterItemVisuals( value );
;1590:		CG_DrawPic( 640-ICON_SIZE, (SCREEN_HEIGHT-ICON_SIZE)/2 - ICON_SIZE, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon );
;1591:	}
;1592:}
;1593:#endif
;1594:#endif // MISSIONPACK
;1595:
;1596:
;1597:/*
;1598:===================
;1599:CG_DrawReward
;1600:===================
;1601:*/
;1602:static void CG_DrawReward( void ) { 
line 1608
;1603:	float	*color;
;1604:	int		i, count;
;1605:	float	x, y;
;1606:	char	buf[32];
;1607:
;1608:	if ( !cg_drawRewards.integer ) {
ADDRGP4 cg_drawRewards+12
INDIRI4
CNSTI4 0
NEI4 $479
line 1609
;1609:		return;
ADDRGP4 $478
JUMPV
LABELV $479
line 1612
;1610:	}
;1611:
;1612:	color = CG_FadeColor( cg.rewardTime, REWARD_TIME );
ADDRGP4 cg+125536
INDIRI4
ARGI4
CNSTI4 3000
ARGI4
ADDRLP4 52
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 52
INDIRP4
ASGNP4
line 1613
;1613:	if ( !color ) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $483
line 1614
;1614:		if (cg.rewardStack > 0) {
ADDRGP4 cg+125532
INDIRI4
CNSTI4 0
LEI4 $478
line 1615
;1615:			for(i = 0; i < cg.rewardStack; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $491
JUMPV
LABELV $488
line 1616
;1616:				cg.rewardSound[i] = cg.rewardSound[i+1];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+125620
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+125620+4
ADDP4
INDIRI4
ASGNI4
line 1617
;1617:				cg.rewardShader[i] = cg.rewardShader[i+1];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+125580
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+125580+4
ADDP4
INDIRI4
ASGNI4
line 1618
;1618:				cg.rewardCount[i] = cg.rewardCount[i+1];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+125540
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+125540+4
ADDP4
INDIRI4
ASGNI4
line 1619
;1619:			}
LABELV $489
line 1615
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $491
ADDRLP4 0
INDIRI4
ADDRGP4 cg+125532
INDIRI4
LTI4 $488
line 1620
;1620:			cg.rewardTime = cg.time;
ADDRGP4 cg+125536
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1621
;1621:			cg.rewardStack--;
ADDRLP4 56
ADDRGP4 cg+125532
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1622
;1622:			color = CG_FadeColor( cg.rewardTime, REWARD_TIME );
ADDRGP4 cg+125536
INDIRI4
ARGI4
CNSTI4 3000
ARGI4
ADDRLP4 60
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 60
INDIRP4
ASGNP4
line 1623
;1623:			trap_S_StartLocalSound(cg.rewardSound[0], CHAN_ANNOUNCER);
ADDRGP4 cg+125620
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1624
;1624:		} else {
line 1625
;1625:			return;
LABELV $486
line 1627
;1626:		}
;1627:	}
LABELV $483
line 1629
;1628:
;1629:	trap_R_SetColor( color );
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1646
;1630:
;1631:	/*
;1632:	count = cg.rewardCount[0]/10;				// number of big rewards to draw
;1633:
;1634:	if (count) {
;1635:		y = 4;
;1636:		x = 320 - count * ICON_SIZE;
;1637:		for ( i = 0 ; i < count ; i++ ) {
;1638:			CG_DrawPic( x, y, (ICON_SIZE*2)-4, (ICON_SIZE*2)-4, cg.rewardShader[0] );
;1639:			x += (ICON_SIZE*2);
;1640:		}
;1641:	}
;1642:
;1643:	count = cg.rewardCount[0] - count*10;		// number of small rewards to draw
;1644:	*/
;1645:
;1646:	if ( cg.rewardCount[0] >= 10 ) {
ADDRGP4 cg+125540
INDIRI4
CNSTI4 10
LTI4 $507
line 1647
;1647:		y = 56; // FIXME: cgs.screenYmin + 56?
ADDRLP4 8
CNSTF4 1113587712
ASGNF4
line 1648
;1648:		x = 320 - ICON_SIZE/2;
ADDRLP4 4
CNSTF4 1133772800
ASGNF4
line 1649
;1649:		CG_DrawPic( x, y, ICON_SIZE-4, ICON_SIZE-4, cg.rewardShader[0] );
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1110441984
ARGF4
CNSTF4 1110441984
ARGF4
ADDRGP4 cg+125580
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1650
;1650:		Com_sprintf( buf, sizeof( buf ), "%d", cg.rewardCount[0] );
ADDRLP4 20
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $511
ARGP4
ADDRGP4 cg+125540
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1651
;1651:		CG_DrawString( 320, y + ICON_SIZE, buf, color, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, DS_SHADOW | DS_CENTER );
CNSTF4 1134559232
ARGF4
ADDRLP4 8
INDIRF4
CNSTF4 1111490560
ADDF4
ARGF4
ADDRLP4 20
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTF4 1090519040
ARGF4
CNSTF4 1098907648
ARGF4
CNSTI4 0
ARGI4
CNSTI4 9
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 1652
;1652:	}
ADDRGP4 $508
JUMPV
LABELV $507
line 1653
;1653:	else {
line 1655
;1654:
;1655:		count = cg.rewardCount[0];
ADDRLP4 12
ADDRGP4 cg+125540
INDIRI4
ASGNI4
line 1657
;1656:
;1657:		y = 56; // FIXME: cgs.screenYmin + 56?
ADDRLP4 8
CNSTF4 1113587712
ASGNF4
line 1658
;1658:		x = 320 - count * ICON_SIZE/2;
ADDRLP4 4
CNSTI4 320
ADDRLP4 12
INDIRI4
CNSTI4 48
MULI4
CNSTI4 2
DIVI4
SUBI4
CVIF4 4
ASGNF4
line 1659
;1659:		for ( i = 0 ; i < count ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $517
JUMPV
LABELV $514
line 1660
;1660:			CG_DrawPic( x, y, ICON_SIZE-4, ICON_SIZE-4, cg.rewardShader[0] );
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1110441984
ARGF4
CNSTF4 1110441984
ARGF4
ADDRGP4 cg+125580
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1661
;1661:			x += ICON_SIZE;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1111490560
ADDF4
ASGNF4
line 1662
;1662:		}
LABELV $515
line 1659
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $517
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
LTI4 $514
line 1663
;1663:	}
LABELV $508
line 1664
;1664:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1665
;1665:}
LABELV $478
endproc CG_DrawReward 68 32
export CG_AddLagometerFrameInfo
proc CG_AddLagometerFrameInfo 8 0
line 1696
;1666:
;1667:
;1668:/*
;1669:===============================================================================
;1670:
;1671:LAGOMETER
;1672:
;1673:===============================================================================
;1674:*/
;1675:
;1676:#define	LAG_SAMPLES		128
;1677:
;1678:
;1679:typedef struct {
;1680:	int		frameSamples[LAG_SAMPLES];
;1681:	int		frameCount;
;1682:	int		snapshotFlags[LAG_SAMPLES];
;1683:	int		snapshotSamples[LAG_SAMPLES];
;1684:	int		snapshotCount;
;1685:} lagometer_t;
;1686:
;1687:lagometer_t		lagometer;
;1688:
;1689:/*
;1690:==============
;1691:CG_AddLagometerFrameInfo
;1692:
;1693:Adds the current interpolate / extrapolate bar for this frame
;1694:==============
;1695:*/
;1696:void CG_AddLagometerFrameInfo( void ) {
line 1699
;1697:	int			offset;
;1698:
;1699:	offset = cg.time - cg.latestSnapshotTime;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+32
INDIRI4
SUBI4
ASGNI4
line 1700
;1700:	lagometer.frameSamples[ lagometer.frameCount & ( LAG_SAMPLES - 1) ] = offset;
ADDRGP4 lagometer+512
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1701
;1701:	lagometer.frameCount++;
ADDRLP4 4
ADDRGP4 lagometer+512
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1702
;1702:}
LABELV $520
endproc CG_AddLagometerFrameInfo 8 0
export CG_AddLagometerSnapshotInfo
proc CG_AddLagometerSnapshotInfo 4 0
line 1715
;1703:
;1704:
;1705:/*
;1706:==============
;1707:CG_AddLagometerSnapshotInfo
;1708:
;1709:Each time a snapshot is received, log its ping time and
;1710:the number of snapshots that were dropped before it.
;1711:
;1712:Pass NULL for a dropped packet.
;1713:==============
;1714:*/
;1715:void CG_AddLagometerSnapshotInfo( snapshot_t *snap ) {
line 1717
;1716:	// dropped packet
;1717:	if ( !snap ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $526
line 1718
;1718:		lagometer.snapshotSamples[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = -1;
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
CNSTI4 -1
ASGNI4
line 1719
;1719:		lagometer.snapshotCount++;
ADDRLP4 0
ADDRGP4 lagometer+1540
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1720
;1720:		return;
ADDRGP4 $525
JUMPV
LABELV $526
line 1724
;1721:	}
;1722:
;1723:	// add this snapshot's info
;1724:	lagometer.snapshotSamples[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = snap->ping;
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1725
;1725:	lagometer.snapshotFlags[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = snap->snapFlags;
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+516
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 1726
;1726:	lagometer.snapshotCount++;
ADDRLP4 0
ADDRGP4 lagometer+1540
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1727
;1727:}
LABELV $525
endproc CG_AddLagometerSnapshotInfo 4 0
proc CG_DrawDisconnect 52 32
line 1737
;1728:
;1729:
;1730:/*
;1731:==============
;1732:CG_DrawDisconnect
;1733:
;1734:Should we draw something differnet for long lag vs no packets?
;1735:==============
;1736:*/
;1737:static void CG_DrawDisconnect( void ) {
line 1744
;1738:	float		x, y;
;1739:	int			cmdNum;
;1740:	usercmd_t	cmd;
;1741:	const char	*s;
;1742:
;1743:	// draw the phone jack if we are completely past our buffers
;1744:	cmdNum = trap_GetCurrentCmdNumber() - CMD_BACKUP + 1;
ADDRLP4 40
ADDRGP4 trap_GetCurrentCmdNumber
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 40
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1745
;1745:	trap_GetUserCmd( cmdNum, &cmd );
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 1746
;1746:	if ( cmd.serverTime <= cg.snap->ps.commandTime
ADDRLP4 44
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
LEI4 $541
ADDRLP4 44
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $537
LABELV $541
line 1747
;1747:		|| cmd.serverTime > cg.time ) {	// special check for map_restart // bk 0102165 - FIXME
line 1748
;1748:		return;
ADDRGP4 $536
JUMPV
LABELV $537
line 1752
;1749:	}
;1750:
;1751:	// also add text in center of screen
;1752:	s = "Connection Interrupted";
ADDRLP4 36
ADDRGP4 $542
ASGNP4
line 1753
;1753:	CG_DrawString( 320, cgs.screenYmin + 100, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_PROPORTIONAL | DS_CENTER );
CNSTF4 1134559232
ARGF4
ADDRGP4 cgs+31460
INDIRF4
CNSTF4 1120403456
ADDF4
ARGF4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
CNSTI4 0
ARGI4
CNSTI4 13
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 1756
;1754:
;1755:	// blink the icon
;1756:	if ( ( cg.time >> 9 ) & 1 ) {
ADDRGP4 cg+107604
INDIRI4
CNSTI4 9
RSHI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $544
line 1757
;1757:		return;
ADDRGP4 $536
JUMPV
LABELV $544
line 1760
;1758:	}
;1759:
;1760:	x = cgs.screenXmax + 1 - 48;
ADDRLP4 24
ADDRGP4 cgs+31456
INDIRF4
CNSTF4 1065353216
ADDF4
CNSTF4 1111490560
SUBF4
ASGNF4
line 1761
;1761:	y = cgs.screenYmax + 1 - 48;
ADDRLP4 28
ADDRGP4 cgs+31464
INDIRF4
CNSTF4 1065353216
ADDF4
CNSTF4 1111490560
SUBF4
ASGNF4
line 1763
;1762:
;1763:	CG_DrawPic( x, y, 48, 48, trap_R_RegisterShader( "gfx/2d/net.tga" ) );
ADDRGP4 $549
ARGP4
ADDRLP4 48
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
CNSTF4 1111490560
ARGF4
CNSTF4 1111490560
ARGF4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1764
;1764:}
LABELV $536
endproc CG_DrawDisconnect 52 32
proc CG_DrawLagometer 56 36
line 1775
;1765:
;1766:
;1767:#define	MAX_LAGOMETER_PING	900
;1768:#define	MAX_LAGOMETER_RANGE	300
;1769:
;1770:/*
;1771:==============
;1772:CG_DrawLagometer
;1773:==============
;1774:*/
;1775:static void CG_DrawLagometer( void ) {
line 1782
;1776:	int		a, x, y, i;
;1777:	float	v;
;1778:	float	ax, ay, aw, ah, mid, range;
;1779:	int		color;
;1780:	float	vscale;
;1781:
;1782:	if ( !cg_lagometer.integer || cgs.localServer ) {
ADDRGP4 cg_lagometer+12
INDIRI4
CNSTI4 0
EQI4 $555
ADDRGP4 cgs+31476
INDIRI4
CNSTI4 0
EQI4 $551
LABELV $555
line 1783
;1783:		CG_DrawDisconnect();
ADDRGP4 CG_DrawDisconnect
CALLV
pop
line 1784
;1784:		return;
ADDRGP4 $550
JUMPV
LABELV $551
line 1791
;1785:	}
;1786:
;1787:	//
;1788:	// draw the graph
;1789:	//
;1790:#ifdef MISSIONPACK
;1791:	x = cgs.screenXmax + 1 - 48;
ADDRLP4 48
ADDRGP4 cgs+31456
INDIRF4
CNSTF4 1065353216
ADDF4
CNSTF4 1111490560
SUBF4
CVFI4 4
ASGNI4
line 1792
;1792:	y = cgs.screenYmax + 1 - 144;
ADDRLP4 44
ADDRGP4 cgs+31464
INDIRF4
CNSTF4 1065353216
ADDF4
CNSTF4 1125122048
SUBF4
CVFI4 4
ASGNI4
line 1798
;1793:#else
;1794:	x = cgs.screenXmax + 1 - 48;
;1795:	y = cgs.screenYmax + 1 - 48;
;1796:#endif
;1797:
;1798:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1799
;1799:	CG_DrawPic( x, y, 48, 48, cgs.media.lagometerShader );
ADDRLP4 48
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 44
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1111490560
ARGF4
CNSTF4 1111490560
ARGF4
ADDRGP4 cgs+148772+296
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1801
;1800:
;1801:	ax = x;
ADDRLP4 24
ADDRLP4 48
INDIRI4
CVIF4 4
ASGNF4
line 1802
;1802:	ay = y;
ADDRLP4 36
ADDRLP4 44
INDIRI4
CVIF4 4
ASGNF4
line 1803
;1803:	aw = 48;
ADDRLP4 12
CNSTF4 1111490560
ASGNF4
line 1804
;1804:	ah = 48;
ADDRLP4 32
CNSTF4 1111490560
ASGNF4
line 1805
;1805:	CG_AdjustFrom640( &ax, &ay, &aw, &ah );
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 32
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 1807
;1806:
;1807:	color = -1;
ADDRLP4 20
CNSTI4 -1
ASGNI4
line 1808
;1808:	range = ah / 3;
ADDRLP4 16
ADDRLP4 32
INDIRF4
CNSTF4 1051372203
MULF4
ASGNF4
line 1809
;1809:	mid = ay + range;
ADDRLP4 40
ADDRLP4 36
INDIRF4
ADDRLP4 16
INDIRF4
ADDF4
ASGNF4
line 1811
;1810:
;1811:	vscale = range / MAX_LAGOMETER_RANGE;
ADDRLP4 28
ADDRLP4 16
INDIRF4
CNSTF4 995783694
MULF4
ASGNF4
line 1814
;1812:
;1813:	// draw the frame interpoalte / extrapolate graph
;1814:	for ( a = 0 ; a < aw ; a++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $563
JUMPV
LABELV $560
line 1815
;1815:		i = ( lagometer.frameCount - 1 - a ) & (LAG_SAMPLES - 1);
ADDRLP4 8
ADDRGP4 lagometer+512
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 127
BANDI4
ASGNI4
line 1816
;1816:		v = lagometer.frameSamples[i];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1817
;1817:		v *= vscale;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 1818
;1818:		if ( v > 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $565
line 1819
;1819:			if ( color != 1 ) {
ADDRLP4 20
INDIRI4
CNSTI4 1
EQI4 $567
line 1820
;1820:				color = 1;
ADDRLP4 20
CNSTI4 1
ASGNI4
line 1821
;1821:				trap_R_SetColor( g_color_table[ColorIndex(COLOR_YELLOW)] );
ADDRGP4 g_color_table+48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1822
;1822:			}
LABELV $567
line 1823
;1823:			if ( v > range ) {
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $570
line 1824
;1824:				v = range;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 1825
;1825:			}
LABELV $570
line 1826
;1826:			trap_R_DrawStretchPic ( ax + aw - a, mid - v, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 40
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ARGF4
CNSTF4 1065353216
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
ADDRGP4 cgs+148772+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1827
;1827:		} else if ( v < 0 ) {
ADDRGP4 $566
JUMPV
LABELV $565
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $574
line 1828
;1828:			if ( color != 2 ) {
ADDRLP4 20
INDIRI4
CNSTI4 2
EQI4 $576
line 1829
;1829:				color = 2;
ADDRLP4 20
CNSTI4 2
ASGNI4
line 1830
;1830:				trap_R_SetColor( g_color_table[ColorIndex(COLOR_BLUE)] );
ADDRGP4 g_color_table+64
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1831
;1831:			}
LABELV $576
line 1832
;1832:			v = -v;
ADDRLP4 0
ADDRLP4 0
INDIRF4
NEGF4
ASGNF4
line 1833
;1833:			if ( v > range ) {
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $579
line 1834
;1834:				v = range;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 1835
;1835:			}
LABELV $579
line 1836
;1836:			trap_R_DrawStretchPic( ax + aw - a, mid, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
CNSTF4 1065353216
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
ADDRGP4 cgs+148772+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1837
;1837:		}
LABELV $574
LABELV $566
line 1838
;1838:	}
LABELV $561
line 1814
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $563
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRF4
LTF4 $560
line 1841
;1839:
;1840:	// draw the snapshot latency / drop graph
;1841:	range = ah / 2;
ADDRLP4 16
ADDRLP4 32
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 1842
;1842:	vscale = range / MAX_LAGOMETER_PING;
ADDRLP4 28
ADDRLP4 16
INDIRF4
CNSTF4 982622900
MULF4
ASGNF4
line 1844
;1843:
;1844:	for ( a = 0 ; a < aw ; a++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $586
JUMPV
LABELV $583
line 1845
;1845:		i = ( lagometer.snapshotCount - 1 - a ) & (LAG_SAMPLES - 1);
ADDRLP4 8
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 127
BANDI4
ASGNI4
line 1846
;1846:		v = lagometer.snapshotSamples[i];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1847
;1847:		if ( v > 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $589
line 1848
;1848:			if ( lagometer.snapshotFlags[i] & SNAPFLAG_RATE_DELAYED ) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+516
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $591
line 1849
;1849:				if ( color != 5 ) {
ADDRLP4 20
INDIRI4
CNSTI4 5
EQI4 $592
line 1850
;1850:					color = 5;	// YELLOW for rate delay
ADDRLP4 20
CNSTI4 5
ASGNI4
line 1851
;1851:					trap_R_SetColor( g_color_table[ColorIndex(COLOR_YELLOW)] );
ADDRGP4 g_color_table+48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1852
;1852:				}
line 1853
;1853:			} else {
ADDRGP4 $592
JUMPV
LABELV $591
line 1854
;1854:				if ( color != 3 ) {
ADDRLP4 20
INDIRI4
CNSTI4 3
EQI4 $597
line 1855
;1855:					color = 3;
ADDRLP4 20
CNSTI4 3
ASGNI4
line 1856
;1856:					trap_R_SetColor( g_color_table[ColorIndex(COLOR_GREEN)] );
ADDRGP4 g_color_table+32
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1857
;1857:				}
LABELV $597
line 1858
;1858:			}
LABELV $592
line 1859
;1859:			v = v * vscale;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 1860
;1860:			if ( v > range ) {
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $600
line 1861
;1861:				v = range;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 1862
;1862:			}
LABELV $600
line 1863
;1863:			trap_R_DrawStretchPic( ax + aw - a, ay + ah - v, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 36
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ADDRLP4 0
INDIRF4
SUBF4
ARGF4
CNSTF4 1065353216
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
ADDRGP4 cgs+148772+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1864
;1864:		} else if ( v < 0 ) {
ADDRGP4 $590
JUMPV
LABELV $589
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $604
line 1865
;1865:			if ( color != 4 ) {
ADDRLP4 20
INDIRI4
CNSTI4 4
EQI4 $606
line 1866
;1866:				color = 4;		// RED for dropped snapshots
ADDRLP4 20
CNSTI4 4
ASGNI4
line 1867
;1867:				trap_R_SetColor( g_color_table[ColorIndex(COLOR_RED)] );
ADDRGP4 g_color_table+16
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1868
;1868:			}
LABELV $606
line 1869
;1869:			trap_R_DrawStretchPic( ax + aw - a, ay + ah - range, 1, range, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 36
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ADDRLP4 16
INDIRF4
SUBF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 16
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
ADDRGP4 cgs+148772+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1870
;1870:		}
LABELV $604
LABELV $590
line 1871
;1871:	}
LABELV $584
line 1844
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $586
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRF4
LTF4 $583
line 1873
;1872:
;1873:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1875
;1874:
;1875:	if ( cg_nopredict.integer || cgs.synchronousClients ) {
ADDRGP4 cg_nopredict+12
INDIRI4
CNSTI4 0
NEI4 $615
ADDRGP4 cgs+150080
INDIRI4
CNSTI4 0
EQI4 $611
LABELV $615
line 1876
;1876:		CG_DrawString( cgs.screenXmax-1, y, "snc", colorWhite, 5, 10, 0, DS_PROPORTIONAL | DS_RIGHT );
ADDRGP4 cgs+31456
INDIRF4
CNSTF4 1065353216
SUBF4
ARGF4
ADDRLP4 44
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 $617
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTF4 1084227584
ARGF4
CNSTF4 1092616192
ARGF4
CNSTI4 0
ARGI4
CNSTI4 20
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 1877
;1877:	}
LABELV $611
line 1879
;1878:
;1879:	if ( !cg.demoPlayback ) {
ADDRGP4 cg+8
INDIRI4
CNSTI4 0
NEI4 $618
line 1880
;1880:		CG_DrawString( x+1, y, va( "%ims", cg.meanPing ), colorWhite, 5, 10, 0, DS_PROPORTIONAL );
ADDRGP4 $621
ARGP4
ADDRGP4 cg+157016
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 48
INDIRI4
CNSTI4 1
ADDI4
CVIF4 4
ARGF4
ADDRLP4 44
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 52
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTF4 1084227584
ARGF4
CNSTF4 1092616192
ARGF4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 1881
;1881:	}
LABELV $618
line 1883
;1882:
;1883:	CG_DrawDisconnect();
ADDRGP4 CG_DrawDisconnect
CALLV
pop
line 1884
;1884:}
LABELV $550
endproc CG_DrawLagometer 56 36
export CG_CenterPrint
proc CG_CenterPrint 8 12
line 1905
;1885:
;1886:
;1887:
;1888:/*
;1889:===============================================================================
;1890:
;1891:CENTER PRINTING
;1892:
;1893:===============================================================================
;1894:*/
;1895:
;1896:
;1897:/*
;1898:==============
;1899:CG_CenterPrint
;1900:
;1901:Called for important messages that should stay in the center of the screen
;1902:for a few moments
;1903:==============
;1904:*/
;1905:void CG_CenterPrint( const char *str, int y, int charWidth ) {
line 1908
;1906:	char	*s;
;1907:
;1908:	Q_strncpyz( cg.centerPrint, str, sizeof(cg.centerPrint) );
ADDRGP4 cg+124436
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1910
;1909:
;1910:	cg.centerPrintTime = cg.time;
ADDRGP4 cg+124424
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1911
;1911:	cg.centerPrintY = y;
ADDRGP4 cg+124432
ADDRFP4 4
INDIRI4
ASGNI4
line 1912
;1912:	cg.centerPrintCharWidth = charWidth;
ADDRGP4 cg+124428
ADDRFP4 8
INDIRI4
ASGNI4
line 1915
;1913:
;1914:	// count the number of lines for centering
;1915:	cg.centerPrintLines = 1;
ADDRGP4 cg+125460
CNSTI4 1
ASGNI4
line 1916
;1916:	s = cg.centerPrint;
ADDRLP4 0
ADDRGP4 cg+124436
ASGNP4
ADDRGP4 $633
JUMPV
LABELV $632
line 1917
;1917:	while( *s ) {
line 1918
;1918:		if (*s == '\n')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 10
NEI4 $635
line 1919
;1919:			cg.centerPrintLines++;
ADDRLP4 4
ADDRGP4 cg+125460
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $635
line 1920
;1920:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1921
;1921:	}
LABELV $633
line 1917
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $632
line 1922
;1922:}
LABELV $623
endproc CG_CenterPrint 8 12
proc CG_DrawCenterString 1068 32
line 1930
;1923:
;1924:
;1925:/*
;1926:===================
;1927:CG_DrawCenterString
;1928:===================
;1929:*/
;1930:static void CG_DrawCenterString( void ) {
line 1939
;1931:	char	*start;
;1932:	int		l;
;1933:	int		y;
;1934:#ifdef MISSIONPACK // bk010221 - unused else
;1935:  int x, w, h;
;1936:#endif
;1937:	float	*color;
;1938:
;1939:	if ( !cg.centerPrintTime ) {
ADDRGP4 cg+124424
INDIRI4
CNSTI4 0
NEI4 $639
line 1940
;1940:		return;
ADDRGP4 $638
JUMPV
LABELV $639
line 1943
;1941:	}
;1942:
;1943:	color = CG_FadeColor( cg.centerPrintTime, 1000 * cg_centertime.value );
ADDRGP4 cg+124424
INDIRI4
ARGI4
ADDRGP4 cg_centertime+8
INDIRF4
CNSTF4 1148846080
MULF4
CVFI4 4
ARGI4
ADDRLP4 28
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 28
INDIRP4
ASGNP4
line 1944
;1944:	if ( !color ) {
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $644
line 1945
;1945:		return;
ADDRGP4 $638
JUMPV
LABELV $644
line 1948
;1946:	}
;1947:
;1948:	trap_R_SetColor( color );
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1950
;1949:
;1950:	start = cg.centerPrint;
ADDRLP4 0
ADDRGP4 cg+124436
ASGNP4
line 1952
;1951:
;1952:	y = cg.centerPrintY - cg.centerPrintLines * BIGCHAR_HEIGHT / 2;
ADDRLP4 12
ADDRGP4 cg+124432
INDIRI4
ADDRGP4 cg+125460
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
ADDRGP4 $650
JUMPV
LABELV $649
line 1954
;1953:
;1954:	while ( 1 ) {
line 1957
;1955:		char linebuffer[1024];
;1956:
;1957:		for ( l = 0; l < 50; l++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $652
line 1958
;1958:			if ( !start[l] || start[l] == '\n' ) {
ADDRLP4 1056
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
EQI4 $658
ADDRLP4 1056
INDIRI4
CNSTI4 10
NEI4 $656
LABELV $658
line 1959
;1959:				break;
ADDRGP4 $654
JUMPV
LABELV $656
line 1961
;1960:			}
;1961:			linebuffer[l] = start[l];
ADDRLP4 4
INDIRI4
ADDRLP4 32
ADDP4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 1962
;1962:		}
LABELV $653
line 1957
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 50
LTI4 $652
LABELV $654
line 1963
;1963:		linebuffer[l] = 0;
ADDRLP4 4
INDIRI4
ADDRLP4 32
ADDP4
CNSTI1 0
ASGNI1
line 1966
;1964:
;1965:#ifdef MISSIONPACK
;1966:		w = CG_Text_Width(linebuffer, 0.5, 0);
ADDRLP4 32
ARGP4
CNSTF4 1056964608
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 1056
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 1056
INDIRI4
ASGNI4
line 1967
;1967:		h = CG_Text_Height(linebuffer, 0.5, 0);
ADDRLP4 32
ARGP4
CNSTF4 1056964608
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 1060
ADDRGP4 CG_Text_Height
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 1060
INDIRI4
ASGNI4
line 1968
;1968:		x = (SCREEN_WIDTH - w) / 2;
ADDRLP4 16
CNSTI4 640
ADDRLP4 20
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 1969
;1969:		CG_Text_Paint(x, y + h, 0.5, color, linebuffer, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
CVIF4 4
ARGF4
CNSTF4 1056964608
ARGF4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 32
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 1970
;1970:		y += h + 6;
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 8
INDIRI4
CNSTI4 6
ADDI4
ADDI4
ASGNI4
ADDRGP4 $660
JUMPV
LABELV $659
line 1976
;1971:#else
;1972:		CG_DrawString( 320, y, linebuffer, color, cg.centerPrintCharWidth, cg.centerPrintCharWidth * 1.5, 0, DS_SHADOW | DS_CENTER | DS_PROPORTIONAL );
;1973:
;1974:		y += cg.centerPrintCharWidth * 1.5;
;1975:#endif
;1976:		while ( *start && ( *start != '\n' ) ) {
line 1977
;1977:			start++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1978
;1978:		}
LABELV $660
line 1976
ADDRLP4 1064
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
EQI4 $662
ADDRLP4 1064
INDIRI4
CNSTI4 10
NEI4 $659
LABELV $662
line 1979
;1979:		if ( !*start ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $663
line 1980
;1980:			break;
ADDRGP4 $651
JUMPV
LABELV $663
line 1982
;1981:		}
;1982:		start++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1983
;1983:	}
LABELV $650
line 1954
ADDRGP4 $649
JUMPV
LABELV $651
line 1985
;1984:
;1985:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1986
;1986:}
LABELV $638
endproc CG_DrawCenterString 1068 32
proc CG_DrawCrosshair 44 36
line 2004
;1987:
;1988:
;1989:
;1990:/*
;1991:================================================================================
;1992:
;1993:CROSSHAIR
;1994:
;1995:================================================================================
;1996:*/
;1997:
;1998:
;1999:/*
;2000:=================
;2001:CG_DrawCrosshair
;2002:=================
;2003:*/
;2004:static void CG_DrawCrosshair( void ) {
line 2011
;2005:	float		w, h;
;2006:	qhandle_t	hShader;
;2007:	float		f;
;2008:	float		x, y;
;2009:	int			ca;
;2010:
;2011:	if ( !cg_drawCrosshair.integer ) {
ADDRGP4 cg_drawCrosshair+12
INDIRI4
CNSTI4 0
NEI4 $666
line 2012
;2012:		return;
ADDRGP4 $665
JUMPV
LABELV $666
line 2015
;2013:	}
;2014:
;2015:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $669
line 2016
;2016:		return;
ADDRGP4 $665
JUMPV
LABELV $669
line 2019
;2017:	}
;2018:
;2019:	if ( cg.renderingThirdPerson ) {
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
EQI4 $672
line 2020
;2020:		return;
ADDRGP4 $665
JUMPV
LABELV $672
line 2024
;2021:	}
;2022:
;2023:	// set color based on health
;2024:	if ( cg_crosshairHealth.integer ) {
ADDRGP4 cg_crosshairHealth+12
INDIRI4
CNSTI4 0
EQI4 $675
line 2027
;2025:		vec4_t		hcolor;
;2026:
;2027:		CG_ColorForHealth( hcolor );
ADDRLP4 28
ARGP4
ADDRGP4 CG_ColorForHealth
CALLV
pop
line 2028
;2028:		trap_R_SetColor( hcolor );
ADDRLP4 28
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2029
;2029:	}
ADDRGP4 $676
JUMPV
LABELV $675
line 2030
;2030:	else if ( cgs.crosshairColor[3] > 0.0f )
ADDRGP4 cgs+150048+12
INDIRF4
CNSTF4 0
LEF4 $678
line 2031
;2031:	{
line 2032
;2032:		trap_R_SetColor( cgs.crosshairColor );
ADDRGP4 cgs+150048
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2033
;2033:	}	 
ADDRGP4 $679
JUMPV
LABELV $678
line 2034
;2034:	else {
line 2035
;2035:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2036
;2036:	}
LABELV $679
LABELV $676
line 2038
;2037:
;2038:	w = h = cg_crosshairSize.value;
ADDRLP4 28
ADDRGP4 cg_crosshairSize+8
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 28
INDIRF4
ASGNF4
line 2041
;2039:
;2040:	// pulse the size of the crosshair when picking up items
;2041:	f = cg.time - cg.itemPickupBlendTime;
ADDRLP4 8
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+125792
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 2042
;2042:	if ( f > 0 && f < ITEM_BLOB_TIME ) {
ADDRLP4 8
INDIRF4
CNSTF4 0
LEF4 $686
ADDRLP4 8
INDIRF4
CNSTF4 1128792064
GEF4 $686
line 2043
;2043:		f /= ITEM_BLOB_TIME;
ADDRLP4 8
ADDRLP4 8
INDIRF4
CNSTF4 1000593162
MULF4
ASGNF4
line 2044
;2044:		w *= ( 1 + f );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 2045
;2045:		h *= ( 1 + f );
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 2046
;2046:	}
LABELV $686
line 2048
;2047:
;2048:	x = cg_crosshairX.integer;
ADDRLP4 16
ADDRGP4 cg_crosshairX+12
INDIRI4
CVIF4 4
ASGNF4
line 2049
;2049:	y = cg_crosshairY.integer;
ADDRLP4 20
ADDRGP4 cg_crosshairY+12
INDIRI4
CVIF4 4
ASGNF4
line 2051
;2050:
;2051:	CG_AdjustFrom640( &x, &y, &w, &h );
ADDRLP4 16
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 2053
;2052:
;2053:	ca = cg_drawCrosshair.integer;
ADDRLP4 12
ADDRGP4 cg_drawCrosshair+12
INDIRI4
ASGNI4
line 2054
;2054:	if ( ca < 0 ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
GEI4 $691
line 2055
;2055:		ca = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 2056
;2056:	}
LABELV $691
line 2058
;2057:
;2058:	hShader = cgs.media.crosshairShader[ ca % NUM_CROSSHAIRS ];
ADDRLP4 24
ADDRLP4 12
INDIRI4
CNSTI4 10
MODI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+148772+256
ADDP4
INDIRI4
ASGNI4
line 2060
;2059:
;2060:	trap_R_DrawStretchPic( x + cg.refdef.x + 0.5 * (cg.refdef.width - w) - cgs.screenXBias,
ADDRLP4 36
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 16
INDIRF4
ADDRGP4 cg+109056
INDIRI4
CVIF4 4
ADDF4
ADDRGP4 cg+109056+8
INDIRI4
CVIF4 4
ADDRLP4 36
INDIRF4
SUBF4
CNSTF4 1056964608
MULF4
ADDF4
ADDRGP4 cgs+31444
INDIRF4
SUBF4
ARGF4
ADDRLP4 40
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 20
INDIRF4
ADDRGP4 cg+109056+4
INDIRI4
CVIF4 4
ADDF4
ADDRGP4 cg+109056+12
INDIRI4
CVIF4 4
ADDRLP4 40
INDIRF4
SUBF4
CNSTF4 1056964608
MULF4
ADDF4
ADDRGP4 cgs+31448
INDIRF4
SUBF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 2063
;2061:		y + cg.refdef.y + 0.5 * (cg.refdef.height - h) - cgs.screenYBias,
;2062:		w, h, 0, 0, 1, 1, hShader );
;2063:}
LABELV $665
endproc CG_DrawCrosshair 44 36
proc CG_ScanForCrosshairEntity 92 28
line 2072
;2064:
;2065:
;2066:
;2067:/*
;2068:=================
;2069:CG_ScanForCrosshairEntity
;2070:=================
;2071:*/
;2072:static void CG_ScanForCrosshairEntity( void ) {
line 2077
;2073:	trace_t		trace;
;2074:	vec3_t		start, end;
;2075:	int			content;
;2076:
;2077:	VectorCopy( cg.refdef.vieworg, start );
ADDRLP4 56
ADDRGP4 cg+109056+24
INDIRB
ASGNB 12
line 2078
;2078:	VectorMA( start, 131072, cg.refdef.viewaxis[0], end );
ADDRLP4 68
ADDRLP4 56
INDIRF4
ADDRGP4 cg+109056+36
INDIRF4
CNSTF4 1207959552
MULF4
ADDF4
ASGNF4
ADDRLP4 68+4
ADDRLP4 56+4
INDIRF4
ADDRGP4 cg+109056+36+4
INDIRF4
CNSTF4 1207959552
MULF4
ADDF4
ASGNF4
ADDRLP4 68+8
ADDRLP4 56+8
INDIRF4
ADDRGP4 cg+109056+36+8
INDIRF4
CNSTF4 1207959552
MULF4
ADDF4
ASGNF4
line 2080
;2079:
;2080:	CG_Trace( &trace, start, vec3_origin, vec3_origin, end, 
ADDRLP4 0
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 84
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 33554433
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 2082
;2081:		cg.snap->ps.clientNum, CONTENTS_SOLID|CONTENTS_BODY );
;2082:	if ( trace.entityNum >= MAX_CLIENTS ) {
ADDRLP4 0+52
INDIRI4
CNSTI4 64
LTI4 $720
line 2083
;2083:		return;
ADDRGP4 $704
JUMPV
LABELV $720
line 2087
;2084:	}
;2085:
;2086:	// if the player is in fog, don't show it
;2087:	content = CG_PointContents( trace.endpos, 0 );
ADDRLP4 0+12
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 88
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 80
ADDRLP4 88
INDIRI4
ASGNI4
line 2088
;2088:	if ( content & CONTENTS_FOG ) {
ADDRLP4 80
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $724
line 2089
;2089:		return;
ADDRGP4 $704
JUMPV
LABELV $724
line 2093
;2090:	}
;2091:
;2092:	// if the player is invisible, don't show it
;2093:	if ( cg_entities[ trace.entityNum ].currentState.powerups & ( 1 << PW_INVIS ) ) {
ADDRLP4 0+52
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities+188
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $726
line 2094
;2094:		return;
ADDRGP4 $704
JUMPV
LABELV $726
line 2098
;2095:	}
;2096:
;2097:	// update the fade timer
;2098:	cg.crosshairClientNum = trace.entityNum;
ADDRGP4 cg+125472
ADDRLP4 0+52
INDIRI4
ASGNI4
line 2099
;2099:	cg.crosshairClientTime = cg.time;
ADDRGP4 cg+125476
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 2100
;2100:}
LABELV $704
endproc CG_ScanForCrosshairEntity 92 28
proc CG_DrawCrosshairNames 24 32
line 2108
;2101:
;2102:
;2103:/*
;2104:=====================
;2105:CG_DrawCrosshairNames
;2106:=====================
;2107:*/
;2108:static void CG_DrawCrosshairNames( void ) {
line 2115
;2109:	float		*color;
;2110:	const char	*name;
;2111:#ifdef MISSIONPACK
;2112:	int w;
;2113:#endif
;2114:
;2115:	if ( !cg_drawCrosshair.integer ) {
ADDRGP4 cg_drawCrosshair+12
INDIRI4
CNSTI4 0
NEI4 $735
line 2116
;2116:		return;
ADDRGP4 $734
JUMPV
LABELV $735
line 2118
;2117:	}
;2118:	if ( !cg_drawCrosshairNames.integer ) {
ADDRGP4 cg_drawCrosshairNames+12
INDIRI4
CNSTI4 0
NEI4 $738
line 2119
;2119:		return;
ADDRGP4 $734
JUMPV
LABELV $738
line 2121
;2120:	}
;2121:	if ( cg.renderingThirdPerson ) {
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
EQI4 $741
line 2122
;2122:		return;
ADDRGP4 $734
JUMPV
LABELV $741
line 2126
;2123:	}
;2124:
;2125:	// scan the known entities to see if the crosshair is sighted on one
;2126:	CG_ScanForCrosshairEntity();
ADDRGP4 CG_ScanForCrosshairEntity
CALLV
pop
line 2129
;2127:
;2128:	// draw the name of the player being looked at
;2129:	color = CG_FadeColor( cg.crosshairClientTime, 1000 );
ADDRGP4 cg+125476
INDIRI4
ARGI4
CNSTI4 1000
ARGI4
ADDRLP4 12
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 2130
;2130:	if ( !color ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $745
line 2131
;2131:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2132
;2132:		return;
ADDRGP4 $734
JUMPV
LABELV $745
line 2135
;2133:	}
;2134:
;2135:	name = cgs.clientinfo[ cg.crosshairClientNum ].name;
ADDRLP4 4
ADDRGP4 cg+125472
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+4
ADDP4
ASGNP4
line 2137
;2136:#ifdef MISSIONPACK
;2137:	color[3] *= 0.5f;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 2138
;2138:	w = CG_Text_Width(name, 0.3f, 0);
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1050253722
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 20
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 20
INDIRI4
ASGNI4
line 2139
;2139:	CG_Text_Paint( 320 - w / 2, 190, 0.3f, color, name, 0, 0, ITEM_TEXTSTYLE_SHADOWED);
CNSTI4 320
ADDRLP4 8
INDIRI4
CNSTI4 2
DIVI4
SUBI4
CVIF4 4
ARGF4
CNSTF4 1128136704
ARGF4
CNSTF4 1050253722
ARGF4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 2144
;2140:#else
;2141:	color[3] *= 0.5f;
;2142:	CG_DrawString( 320, 174, name, color, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_CENTER | DS_PROPORTIONAL );
;2143:#endif
;2144:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2145
;2145:}
LABELV $734
endproc CG_DrawCrosshairNames 24 32
proc CG_DrawSpectator 0 32
line 2155
;2146:
;2147:
;2148://==============================================================================
;2149:
;2150:/*
;2151:=================
;2152:CG_DrawSpectator
;2153:=================
;2154:*/
;2155:static void CG_DrawSpectator( void ) {
line 2156
;2156:	CG_DrawString( 320, cgs.screenYmax - 40 + 1, "SPECTATOR", colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_CENTER | DS_PROPORTIONAL );
CNSTF4 1134559232
ARGF4
ADDRGP4 cgs+31464
INDIRF4
CNSTF4 1109393408
SUBF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRGP4 $752
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
CNSTI4 0
ARGI4
CNSTI4 13
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 2157
;2157:	if ( cgs.gametype == GT_TOURNAMENT ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 1
NEI4 $753
line 2158
;2158:		CG_DrawString( 320, cgs.screenYmax - 20 + 1, "waiting to play", colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_CENTER | DS_PROPORTIONAL );
CNSTF4 1134559232
ARGF4
ADDRGP4 cgs+31464
INDIRF4
CNSTF4 1101004800
SUBF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRGP4 $757
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
CNSTI4 0
ARGI4
CNSTI4 13
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 2159
;2159:	} else if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 $754
JUMPV
LABELV $753
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $758
line 2160
;2160:		CG_DrawString( 320, cgs.screenYmax - 20 + 1, "press ESC and use the JOIN menu to play", colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_CENTER | DS_PROPORTIONAL );
CNSTF4 1134559232
ARGF4
ADDRGP4 cgs+31464
INDIRF4
CNSTF4 1101004800
SUBF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRGP4 $762
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
CNSTI4 0
ARGI4
CNSTI4 13
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 2161
;2161:	}
LABELV $758
LABELV $754
line 2162
;2162:}
LABELV $750
endproc CG_DrawSpectator 0 32
proc CG_DrawVote 12 32
line 2170
;2163:
;2164:
;2165:/*
;2166:=================
;2167:CG_DrawVote
;2168:=================
;2169:*/
;2170:static void CG_DrawVote( void ) {
line 2174
;2171:	char	*s;
;2172:	int		sec;
;2173:
;2174:	if ( !cgs.voteTime ) {
ADDRGP4 cgs+31700
INDIRI4
CNSTI4 0
NEI4 $764
line 2175
;2175:		return;
ADDRGP4 $763
JUMPV
LABELV $764
line 2179
;2176:	}
;2177:
;2178:	// play a talk beep whenever it is modified
;2179:	if ( cgs.voteModified ) {
ADDRGP4 cgs+31712
INDIRI4
CNSTI4 0
EQI4 $767
line 2180
;2180:		cgs.voteModified = qfalse;
ADDRGP4 cgs+31712
CNSTI4 0
ASGNI4
line 2181
;2181:		trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+148772+904
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2182
;2182:	}
LABELV $767
line 2184
;2183:
;2184:	sec = ( VOTE_TIME - ( cg.time - cgs.voteTime ) ) / 1000;
ADDRLP4 4
CNSTI4 30000
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+31700
INDIRI4
SUBI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 2185
;2185:	if ( sec < 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $775
line 2186
;2186:		sec = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2187
;2187:	}
LABELV $775
line 2189
;2188:#ifdef MISSIONPACK
;2189:	s = va("VOTE(%i):%s yes:%i no:%i", sec, cgs.voteString, cgs.voteYes, cgs.voteNo);
ADDRGP4 $777
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 cgs+31716
ARGP4
ADDRGP4 cgs+31704
INDIRI4
ARGI4
ADDRGP4 cgs+31708
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 2190
;2190:	CG_DrawString( cgs.screenXmin - 0, 58, s, colorWhite, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, DS_PROPORTIONAL );
ADDRGP4 cgs+31452
INDIRF4
CNSTF4 0
SUBF4
ARGF4
CNSTF4 1114112000
ARGF4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTF4 1090519040
ARGF4
CNSTF4 1098907648
ARGF4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 2191
;2191:	s = "or press ESC then click Vote";
ADDRLP4 0
ADDRGP4 $782
ASGNP4
line 2192
;2192:	CG_DrawString( cgs.screenXmin - 0, 58 + SMALLCHAR_HEIGHT + 2, s, colorWhite, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, DS_PROPORTIONAL );
ADDRGP4 cgs+31452
INDIRF4
CNSTF4 0
SUBF4
ARGF4
CNSTF4 1117257728
ARGF4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTF4 1090519040
ARGF4
CNSTF4 1098907648
ARGF4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 2197
;2193:#else
;2194:	s = va( "VOTE(%i):%s yes:%i no:%i", sec, cgs.voteString, cgs.voteYes, cgs.voteNo );
;2195:	CG_DrawString( cgs.screenXmin - 0, 58, s, colorWhite, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, DS_PROPORTIONAL ); // DS_SHADOW?
;2196:#endif
;2197:}
LABELV $763
endproc CG_DrawVote 12 32
proc CG_DrawTeamVote 20 32
line 2205
;2198:
;2199:
;2200:/*
;2201:=================
;2202:CG_DrawTeamVote
;2203:=================
;2204:*/
;2205:static void CG_DrawTeamVote(void) {
line 2209
;2206:	char	*s;
;2207:	int		sec, cs_offset;
;2208:
;2209:	if ( cgs.clientinfo[ cg.clientNum ].team == TEAM_RED )
ADDRGP4 cg+4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $785
line 2210
;2210:		cs_offset = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $786
JUMPV
LABELV $785
line 2211
;2211:	else if ( cgs.clientinfo[ cg.clientNum ].team == TEAM_BLUE )
ADDRGP4 cg+4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+36
ADDP4
INDIRI4
CNSTI4 2
NEI4 $784
line 2212
;2212:		cs_offset = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 2214
;2213:	else
;2214:		return;
LABELV $791
LABELV $786
line 2216
;2215:
;2216:	if ( !cgs.teamVoteTime[cs_offset] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32740
ADDP4
INDIRI4
CNSTI4 0
NEI4 $795
line 2217
;2217:		return;
ADDRGP4 $784
JUMPV
LABELV $795
line 2221
;2218:	}
;2219:
;2220:	// play a talk beep whenever it is modified
;2221:	if ( cgs.teamVoteModified[cs_offset] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32764
ADDP4
INDIRI4
CNSTI4 0
EQI4 $798
line 2222
;2222:		cgs.teamVoteModified[cs_offset] = qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32764
ADDP4
CNSTI4 0
ASGNI4
line 2223
;2223:		trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+148772+904
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2224
;2224:	}
LABELV $798
line 2226
;2225:
;2226:	sec = ( VOTE_TIME - ( cg.time - cgs.teamVoteTime[cs_offset] ) ) / 1000;
ADDRLP4 4
CNSTI4 30000
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32740
ADDP4
INDIRI4
SUBI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 2227
;2227:	if ( sec < 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $806
line 2228
;2228:		sec = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2229
;2229:	}
LABELV $806
line 2230
;2230:	s = va("TEAMVOTE(%i):%s yes:%i no:%i", sec, cgs.teamVoteString[cs_offset],
ADDRGP4 $808
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 cgs+32772
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32748
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32756
ADDP4
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
line 2233
;2231:							cgs.teamVoteYes[cs_offset], cgs.teamVoteNo[cs_offset] );
;2232:
;2233:	CG_DrawString( cgs.screenXmin - 0, 90, s, colorWhite, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, DS_PROPORTIONAL ); // DS_SHADOW?
ADDRGP4 cgs+31452
INDIRF4
CNSTF4 0
SUBF4
ARGF4
CNSTF4 1119092736
ARGF4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTF4 1090519040
ARGF4
CNSTF4 1098907648
ARGF4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 2234
;2234:}
LABELV $784
endproc CG_DrawTeamVote 20 32
data
align 4
LABELV $814
byte 4 1
code
proc CG_DrawScoreboard 16 8
line 2237
;2235:
;2236:
;2237:static qboolean CG_DrawScoreboard( void ) {
line 2242
;2238:#ifdef MISSIONPACK
;2239:	static qboolean firstTime = qtrue;
;2240:	float fade, *fadeColor;
;2241:
;2242:	if (menuScoreboard) {
ADDRGP4 menuScoreboard
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $815
line 2243
;2243:		menuScoreboard->window.flags &= ~WINDOW_FORCED;
ADDRLP4 8
ADDRGP4 menuScoreboard
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -1048577
BANDI4
ASGNI4
line 2244
;2244:	}
LABELV $815
line 2245
;2245:	if (cg_paused.integer) {
ADDRGP4 cg_paused+12
INDIRI4
CNSTI4 0
EQI4 $817
line 2246
;2246:		cg.deferredPlayerLoading = 0;
ADDRGP4 cg+16
CNSTI4 0
ASGNI4
line 2247
;2247:		firstTime = qtrue;
ADDRGP4 $814
CNSTI4 1
ASGNI4
line 2248
;2248:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $813
JUMPV
LABELV $817
line 2252
;2249:	}
;2250:
;2251:	// should never happen in Team Arena
;2252:	if (cgs.gametype == GT_SINGLE_PLAYER && cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 2
NEI4 $821
ADDRGP4 cg+107636+4
INDIRI4
CNSTI4 5
NEI4 $821
line 2253
;2253:		cg.deferredPlayerLoading = 0;
ADDRGP4 cg+16
CNSTI4 0
ASGNI4
line 2254
;2254:		firstTime = qtrue;
ADDRGP4 $814
CNSTI4 1
ASGNI4
line 2255
;2255:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $813
JUMPV
LABELV $821
line 2259
;2256:	}
;2257:
;2258:	// don't draw scoreboard during death while warmup up
;2259:	if ( cg.warmup && !cg.showScores ) {
ADDRGP4 cg+125768
INDIRI4
CNSTI4 0
EQI4 $827
ADDRGP4 cg+115356
INDIRI4
CNSTI4 0
NEI4 $827
line 2260
;2260:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $813
JUMPV
LABELV $827
line 2263
;2261:	}
;2262:
;2263:	if ( cg.showScores || cg.predictedPlayerState.pm_type == PM_DEAD || cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
ADDRGP4 cg+115356
INDIRI4
CNSTI4 0
NEI4 $839
ADDRGP4 cg+107636+4
INDIRI4
CNSTI4 3
EQI4 $839
ADDRGP4 cg+107636+4
INDIRI4
CNSTI4 5
NEI4 $831
LABELV $839
line 2264
;2264:		fade = 1.0;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 2265
;2265:		fadeColor = colorWhite;
ADDRLP4 0
ADDRGP4 colorWhite
ASGNP4
line 2266
;2266:	} else {
ADDRGP4 $832
JUMPV
LABELV $831
line 2267
;2267:		fadeColor = CG_FadeColor( cg.scoreFadeTime, FADE_TIME );
ADDRGP4 cg+115364
INDIRI4
ARGI4
CNSTI4 200
ARGI4
ADDRLP4 8
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 2268
;2268:		if ( !fadeColor ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $841
line 2270
;2269:			// next time scoreboard comes up, don't print killer
;2270:			cg.deferredPlayerLoading = 0;
ADDRGP4 cg+16
CNSTI4 0
ASGNI4
line 2271
;2271:			cg.killerName[0] = 0;
ADDRGP4 cg+115368
CNSTI1 0
ASGNI1
line 2272
;2272:			firstTime = qtrue;
ADDRGP4 $814
CNSTI4 1
ASGNI4
line 2273
;2273:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $813
JUMPV
LABELV $841
line 2275
;2274:		}
;2275:		fade = *fadeColor;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRF4
ASGNF4
line 2276
;2276:	}																					  
LABELV $832
line 2279
;2277:
;2278:
;2279:	if (menuScoreboard == NULL) {
ADDRGP4 menuScoreboard
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $845
line 2280
;2280:		if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $847
line 2281
;2281:			menuScoreboard = Menus_FindByName("teamscore_menu");
ADDRGP4 $850
ARGP4
ADDRLP4 8
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRGP4 menuScoreboard
ADDRLP4 8
INDIRP4
ASGNP4
line 2282
;2282:		} else {
ADDRGP4 $848
JUMPV
LABELV $847
line 2283
;2283:			menuScoreboard = Menus_FindByName("score_menu");
ADDRGP4 $851
ARGP4
ADDRLP4 8
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRGP4 menuScoreboard
ADDRLP4 8
INDIRP4
ASGNP4
line 2284
;2284:		}
LABELV $848
line 2285
;2285:	}
LABELV $845
line 2287
;2286:
;2287:	if (menuScoreboard) {
ADDRGP4 menuScoreboard
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $852
line 2288
;2288:		if (firstTime) {
ADDRGP4 $814
INDIRI4
CNSTI4 0
EQI4 $854
line 2289
;2289:			CG_SetScoreSelection(menuScoreboard);
ADDRGP4 menuScoreboard
INDIRP4
ARGP4
ADDRGP4 CG_SetScoreSelection
CALLV
pop
line 2290
;2290:			firstTime = qfalse;
ADDRGP4 $814
CNSTI4 0
ASGNI4
line 2291
;2291:		}
LABELV $854
line 2292
;2292:		Menu_Paint(menuScoreboard, qtrue);
ADDRGP4 menuScoreboard
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_Paint
CALLV
pop
line 2293
;2293:	}
LABELV $852
line 2296
;2294:
;2295:	// load any models that have been deferred
;2296:	if ( ++cg.deferredPlayerLoading > 10 ) {
ADDRLP4 8
ADDRGP4 cg+16
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 10
LEI4 $856
line 2297
;2297:		CG_LoadDeferredPlayers();
ADDRGP4 CG_LoadDeferredPlayers
CALLV
pop
line 2298
;2298:	}
LABELV $856
line 2300
;2299:
;2300:	return qtrue;
CNSTI4 1
RETI4
LABELV $813
endproc CG_DrawScoreboard 16 8
proc CG_DrawIntermission 4 0
line 2312
;2301:#else
;2302:	return CG_DrawOldScoreboard();
;2303:#endif
;2304:}
;2305:
;2306:
;2307:/*
;2308:=================
;2309:CG_DrawIntermission
;2310:=================
;2311:*/
;2312:static void CG_DrawIntermission( void ) {
line 2325
;2313://	int key;
;2314:#ifdef MISSIONPACK
;2315:	//if (cg_singlePlayer.integer) {
;2316:	//	CG_DrawCenterString();
;2317:	//	return;
;2318:	//}
;2319:#else
;2320:	if ( cgs.gametype == GT_SINGLE_PLAYER ) {
;2321:		CG_DrawCenterString();
;2322:		return;
;2323:	}
;2324:#endif
;2325:	cg.scoreFadeTime = cg.time;
ADDRGP4 cg+115364
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 2326
;2326:	cg.scoreBoardShowing = CG_DrawScoreboard();
ADDRLP4 0
ADDRGP4 CG_DrawScoreboard
CALLI4
ASGNI4
ADDRGP4 cg+115360
ADDRLP4 0
INDIRI4
ASGNI4
line 2327
;2327:}
LABELV $859
endproc CG_DrawIntermission 4 0
proc CG_DrawFollow 4 32
line 2335
;2328:
;2329:
;2330:/*
;2331:=================
;2332:CG_DrawFollow
;2333:=================
;2334:*/
;2335:static qboolean CG_DrawFollow( void ) {
line 2339
;2336:
;2337:	const char	*name;
;2338:
;2339:	if ( !(cg.snap->ps.pm_flags & PMF_FOLLOW) ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $864
line 2340
;2340:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $863
JUMPV
LABELV $864
line 2343
;2341:	}
;2342:
;2343:	CG_DrawString( 320, cgs.screenYmin + 24, "following", colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_CENTER | DS_SHADOW );
CNSTF4 1134559232
ARGF4
ADDRGP4 cgs+31460
INDIRF4
CNSTF4 1103101952
ADDF4
ARGF4
ADDRGP4 $868
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
CNSTI4 0
ARGI4
CNSTI4 9
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 2345
;2344:
;2345:	name = cgs.clientinfo[ cg.snap->ps.clientNum ].name;
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+4
ADDP4
ASGNP4
line 2347
;2346:
;2347:	CG_DrawString( 320, cgs.screenYmin + 40, name, colorWhite, GIANT_WIDTH, GIANT_HEIGHT, 0, DS_FORCE_COLOR | DS_SHADOW | DS_CENTER );
CNSTF4 1134559232
ARGF4
ADDRGP4 cgs+31460
INDIRF4
CNSTF4 1109393408
ADDF4
ARGF4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTF4 1107296256
ARGF4
CNSTF4 1111490560
ARGF4
CNSTI4 0
ARGI4
CNSTI4 11
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 2349
;2348:
;2349:	return qtrue;
CNSTI4 1
RETI4
LABELV $863
endproc CG_DrawFollow 4 32
proc CG_DrawAmmoWarning 4 32
line 2359
;2350:}
;2351:
;2352:
;2353:
;2354:/*
;2355:=================
;2356:CG_DrawAmmoWarning
;2357:=================
;2358:*/
;2359:static void CG_DrawAmmoWarning( void ) {
line 2362
;2360:	const char	*s;
;2361:
;2362:	if ( cg_drawAmmoWarning.integer == 0 ) {
ADDRGP4 cg_drawAmmoWarning+12
INDIRI4
CNSTI4 0
NEI4 $874
line 2363
;2363:		return;
ADDRGP4 $873
JUMPV
LABELV $874
line 2366
;2364:	}
;2365:
;2366:	if ( !cg.lowAmmoWarning ) {
ADDRGP4 cg+125464
INDIRI4
CNSTI4 0
NEI4 $877
line 2367
;2367:		return;
ADDRGP4 $873
JUMPV
LABELV $877
line 2370
;2368:	}
;2369:
;2370:	if ( cg.lowAmmoWarning == 2 ) {
ADDRGP4 cg+125464
INDIRI4
CNSTI4 2
NEI4 $880
line 2371
;2371:		s = "OUT OF AMMO";
ADDRLP4 0
ADDRGP4 $883
ASGNP4
line 2372
;2372:	} else {
ADDRGP4 $881
JUMPV
LABELV $880
line 2373
;2373:		s = "LOW AMMO WARNING";
ADDRLP4 0
ADDRGP4 $884
ASGNP4
line 2374
;2374:	}
LABELV $881
line 2376
;2375:
;2376:	CG_DrawString( 320, 64, s, colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_PROPORTIONAL | DS_CENTER | DS_SHADOW );
CNSTF4 1134559232
ARGF4
CNSTF4 1115684864
ARGF4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
CNSTI4 0
ARGI4
CNSTI4 13
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 2377
;2377:}
LABELV $873
endproc CG_DrawAmmoWarning 4 32
bss
align 4
LABELV $886
skip 4
align 4
LABELV $887
skip 4
align 4
LABELV $888
skip 4
code
proc CG_DrawProxWarning 40 32
line 2386
;2378:
;2379:
;2380:#ifdef MISSIONPACK
;2381:/*
;2382:=================
;2383:CG_DrawProxWarning
;2384:=================
;2385:*/
;2386:static void CG_DrawProxWarning( void ) {
line 2392
;2387:	char s [32];
;2388:	static int proxTime;
;2389:	static int proxCounter;
;2390:	static int proxTick;
;2391:
;2392:	if( !(cg.snap->ps.eFlags & EF_TICKING ) ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $889
line 2393
;2393:		proxTime = 0;
ADDRGP4 $886
CNSTI4 0
ASGNI4
line 2394
;2394:		return;
ADDRGP4 $885
JUMPV
LABELV $889
line 2397
;2395:	}
;2396:
;2397:	if ( proxTime == 0 ) {
ADDRGP4 $886
INDIRI4
CNSTI4 0
NEI4 $892
line 2398
;2398:		proxTime = cg.time + 5000;
ADDRGP4 $886
ADDRGP4 cg+107604
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 2399
;2399:		proxCounter = 5;
ADDRGP4 $887
CNSTI4 5
ASGNI4
line 2400
;2400:		proxTick = 0;
ADDRGP4 $888
CNSTI4 0
ASGNI4
line 2401
;2401:	}
LABELV $892
line 2403
;2402:
;2403:	if (cg.time > proxTime) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 $886
INDIRI4
LEI4 $895
line 2404
;2404:		proxTick = proxCounter--;
ADDRLP4 36
ADDRGP4 $887
ASGNP4
ADDRLP4 32
ADDRLP4 36
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRP4
ADDRLP4 32
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $888
ADDRLP4 32
INDIRI4
ASGNI4
line 2405
;2405:		proxTime = cg.time + 1000;
ADDRGP4 $886
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 2406
;2406:	}
LABELV $895
line 2408
;2407:
;2408:	if (proxTick != 0) {
ADDRGP4 $888
INDIRI4
CNSTI4 0
EQI4 $899
line 2409
;2409:		Com_sprintf( s, sizeof(s), "INTERNAL COMBUSTION IN: %i", proxTick );
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $901
ARGP4
ADDRGP4 $888
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 2410
;2410:	} else {
ADDRGP4 $900
JUMPV
LABELV $899
line 2411
;2411:		Com_sprintf( s, sizeof(s), "YOU HAVE BEEN MINED" );
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $902
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 2412
;2412:	}
LABELV $900
line 2414
;2413:
;2414:	CG_DrawString( 320, 64 + 64 + BIGCHAR_HEIGHT, s, g_color_table[ColorIndex(COLOR_RED)], BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, DS_SHADOW | DS_FORCE_COLOR | DS_CENTER );
CNSTF4 1134559232
ARGF4
CNSTF4 1125122048
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 g_color_table+16
ARGP4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
CNSTI4 0
ARGI4
CNSTI4 11
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 2415
;2415:}
LABELV $885
endproc CG_DrawProxWarning 40 32
proc CG_DrawWarmup 40 32
line 2424
;2416:#endif
;2417:
;2418:
;2419:/*
;2420:=================
;2421:CG_DrawWarmup
;2422:=================
;2423:*/
;2424:static void CG_DrawWarmup( void ) {
line 2434
;2425:	int			w;
;2426:	int			i;
;2427:#ifdef MISSIONPACK
;2428:	float scale;
;2429:#endif
;2430:	clientInfo_t *ci1, *ci2;
;2431:	int			cw;
;2432:	const char	*s;
;2433:
;2434:	if ( !cg.warmup ) {
ADDRGP4 cg+125768
INDIRI4
CNSTI4 0
NEI4 $905
line 2435
;2435:		return;
ADDRGP4 $904
JUMPV
LABELV $905
line 2438
;2436:	}
;2437:
;2438:	if ( cg.warmup < 0 ) {
ADDRGP4 cg+125768
INDIRI4
CNSTI4 0
GEI4 $908
line 2439
;2439:		CG_DrawString( 320,24, "Waiting for players", colorWhite, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0,
CNSTF4 1134559232
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 $911
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
CNSTI4 0
ARGI4
CNSTI4 13
ARGI4
ADDRGP4 CG_DrawString
CALLV
pop
line 2441
;2440:			DS_PROPORTIONAL | DS_CENTER | DS_SHADOW );
;2441:		return;
ADDRGP4 $904
JUMPV
LABELV $908
line 2444
;2442:	}
;2443:
;2444:	if ( cgs.gametype == GT_TOURNAMENT ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 1
NEI4 $912
line 2446
;2445:		// find the two active players
;2446:		ci1 = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 2447
;2447:		ci2 = NULL;
ADDRLP4 16
CNSTP4 0
ASGNP4
line 2448
;2448:		for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $918
JUMPV
LABELV $915
line 2449
;2449:			if ( cgs.clientinfo[i].infoValid && cgs.clientinfo[i].team == TEAM_FREE ) {
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
INDIRI4
CNSTI4 0
EQI4 $920
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+36
ADDP4
INDIRI4
CNSTI4 0
NEI4 $920
line 2450
;2450:				if ( !ci1 ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $925
line 2451
;2451:					ci1 = &cgs.clientinfo[i];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 2452
;2452:				} else {
ADDRGP4 $926
JUMPV
LABELV $925
line 2453
;2453:					ci2 = &cgs.clientinfo[i];
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 2454
;2454:				}
LABELV $926
line 2455
;2455:			}
LABELV $920
line 2456
;2456:		}
LABELV $916
line 2448
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $918
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+31504
INDIRI4
LTI4 $915
line 2458
;2457:
;2458:		if ( ci1 && ci2 ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $913
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $913
line 2459
;2459:			s = va( "%s vs %s", ci1->name, ci2->name );
ADDRGP4 $931
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 28
INDIRP4
ASGNP4
line 2461
;2460:#ifdef MISSIONPACK
;2461:			w = CG_Text_Width(s, 0.6f, 0);
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1058642330
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 32
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 32
INDIRI4
ASGNI4
line 2462
;2462:			CG_Text_Paint(320 - w / 2, 60, 0.6f, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
CNSTI4 320
ADDRLP4 12
INDIRI4
CNSTI4 2
DIVI4
SUBI4
CVIF4 4
ARGF4
CNSTF4 1114636288
ARGF4
CNSTF4 1058642330
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 2472
;2463:#else
;2464:			w = CG_DrawStrlen( s );
;2465:			if ( w > 640 / GIANT_WIDTH ) {
;2466:				cw = 640 / w;
;2467:			} else {
;2468:				cw = GIANT_WIDTH;
;2469:			}
;2470:			CG_DrawString( 320, 20, s, colorWhite, cw, cw*1.5, 0, DS_SHADOW | DS_CENTER | DS_PROPORTIONAL );
;2471:#endif
;2472:		}
line 2473
;2473:	} else {
ADDRGP4 $913
JUMPV
LABELV $912
line 2474
;2474:		if ( cgs.gametype == GT_FFA ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 0
NEI4 $932
line 2475
;2475:			s = "Free For All";
ADDRLP4 4
ADDRGP4 $935
ASGNP4
line 2476
;2476:		} else if ( cgs.gametype == GT_TEAM ) {
ADDRGP4 $933
JUMPV
LABELV $932
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
NEI4 $936
line 2477
;2477:			s = "Team Deathmatch";
ADDRLP4 4
ADDRGP4 $939
ASGNP4
line 2478
;2478:		} else if ( cgs.gametype == GT_CTF ) {
ADDRGP4 $937
JUMPV
LABELV $936
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 4
NEI4 $940
line 2479
;2479:			s = "Capture the Flag";
ADDRLP4 4
ADDRGP4 $943
ASGNP4
line 2481
;2480:#ifdef MISSIONPACK
;2481:		} else if ( cgs.gametype == GT_1FCTF ) {
ADDRGP4 $941
JUMPV
LABELV $940
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 5
NEI4 $944
line 2482
;2482:			s = "One Flag CTF";
ADDRLP4 4
ADDRGP4 $947
ASGNP4
line 2483
;2483:		} else if ( cgs.gametype == GT_OBELISK ) {
ADDRGP4 $945
JUMPV
LABELV $944
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 6
NEI4 $948
line 2484
;2484:			s = "Overload";
ADDRLP4 4
ADDRGP4 $951
ASGNP4
line 2485
;2485:		} else if ( cgs.gametype == GT_HARVESTER ) {
ADDRGP4 $949
JUMPV
LABELV $948
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 7
NEI4 $952
line 2486
;2486:			s = "Harvester";
ADDRLP4 4
ADDRGP4 $955
ASGNP4
line 2488
;2487:#endif
;2488:		} else {
ADDRGP4 $953
JUMPV
LABELV $952
line 2489
;2489:			s = "";
ADDRLP4 4
ADDRGP4 $956
ASGNP4
line 2490
;2490:		}
LABELV $953
LABELV $949
LABELV $945
LABELV $941
LABELV $937
LABELV $933
line 2492
;2491:#ifdef MISSIONPACK
;2492:		w = CG_Text_Width(s, 0.6f, 0);
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1058642330
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 28
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 28
INDIRI4
ASGNI4
line 2493
;2493:		CG_Text_Paint(320 - w / 2, 90, 0.6f, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
CNSTI4 320
ADDRLP4 12
INDIRI4
CNSTI4 2
DIVI4
SUBI4
CVIF4 4
ARGF4
CNSTF4 1119092736
ARGF4
CNSTF4 1058642330
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 2503
;2494:#else
;2495:		w = CG_DrawStrlen( s );
;2496:		if ( w > 640 / GIANT_WIDTH ) {
;2497:			cw = 640 / w;
;2498:		} else {
;2499:			cw = GIANT_WIDTH;
;2500:		}
;2501:		CG_DrawString( 320, 25, s, colorWhite, cw, cw*1.1f, 0, DS_PROPORTIONAL | DS_SHADOW | DS_CENTER );
;2502:#endif
;2503:	}
LABELV $913
line 2505
;2504:
;2505:	if ( cg.warmupCount <= 0 )
ADDRGP4 cg+125772
INDIRI4
CNSTI4 0
GTI4 $957
line 2506
;2506:		return;
ADDRGP4 $904
JUMPV
LABELV $957
line 2508
;2507:
;2508:	s = va( "Starts in: %i", cg.warmupCount );
ADDRGP4 $960
ARGP4
ADDRGP4 cg+125772
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 28
INDIRP4
ASGNP4
line 2510
;2509:
;2510:	switch ( cg.warmupCount ) {
ADDRLP4 32
ADDRGP4 cg+125772
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 1
EQI4 $965
ADDRLP4 32
INDIRI4
CNSTI4 2
EQI4 $966
ADDRLP4 32
INDIRI4
CNSTI4 3
EQI4 $967
ADDRGP4 $962
JUMPV
LABELV $965
line 2512
;2511:	case 1:
;2512:		cw = 28;
ADDRLP4 24
CNSTI4 28
ASGNI4
line 2514
;2513:#ifdef MISSIONPACK
;2514:		scale = 0.54f;
ADDRLP4 20
CNSTF4 1057635697
ASGNF4
line 2516
;2515:#endif
;2516:		break;
ADDRGP4 $963
JUMPV
LABELV $966
line 2518
;2517:	case 2:
;2518:		cw = 24;
ADDRLP4 24
CNSTI4 24
ASGNI4
line 2520
;2519:#ifdef MISSIONPACK
;2520:		scale = 0.51f;
ADDRLP4 20
CNSTF4 1057132380
ASGNF4
line 2522
;2521:#endif
;2522:		break;
ADDRGP4 $963
JUMPV
LABELV $967
line 2524
;2523:	case 3:
;2524:		cw = 20;
ADDRLP4 24
CNSTI4 20
ASGNI4
line 2526
;2525:#ifdef MISSIONPACK
;2526:		scale = 0.48f;
ADDRLP4 20
CNSTF4 1056293519
ASGNF4
line 2528
;2527:#endif
;2528:		break;
ADDRGP4 $963
JUMPV
LABELV $962
line 2530
;2529:	default:
;2530:		cw = 16;
ADDRLP4 24
CNSTI4 16
ASGNI4
line 2532
;2531:#ifdef MISSIONPACK
;2532:		scale = 0.45f;
ADDRLP4 20
CNSTF4 1055286886
ASGNF4
line 2534
;2533:#endif
;2534:		break;
LABELV $963
line 2538
;2535:	}
;2536:
;2537:#ifdef MISSIONPACK
;2538:	w = CG_Text_Width(s, scale, 0);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 36
ADDRGP4 CG_Text_Width
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 36
INDIRI4
ASGNI4
line 2539
;2539:	CG_Text_Paint(320 - w / 2, 125, scale, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
CNSTI4 320
ADDRLP4 12
INDIRI4
CNSTI4 2
DIVI4
SUBI4
CVIF4 4
ARGF4
CNSTF4 1123680256
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 2543
;2540:#else
;2541:	CG_DrawString( 320, 70, s, colorWhite, cw, cw * 1.5, 0, DS_CENTER | DS_SHADOW | DS_PROPORTIONAL );
;2542:#endif
;2543:}
LABELV $904
endproc CG_DrawWarmup 40 32
export CG_DrawTimedMenus
proc CG_DrawTimedMenus 4 8
line 2553
;2544:
;2545:
;2546://==================================================================================
;2547:#ifdef MISSIONPACK
;2548:/* 
;2549:=================
;2550:CG_DrawTimedMenus
;2551:=================
;2552:*/
;2553:void CG_DrawTimedMenus( void ) {
line 2554
;2554:	if (cg.voiceTime) {
ADDRGP4 cg+125528
INDIRI4
CNSTI4 0
EQI4 $969
line 2555
;2555:		int t = cg.time - cg.voiceTime;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+125528
INDIRI4
SUBI4
ASGNI4
line 2556
;2556:		if ( t > 2500 ) {
ADDRLP4 0
INDIRI4
CNSTI4 2500
LEI4 $974
line 2557
;2557:			Menus_CloseByName("voiceMenu");
ADDRGP4 $976
ARGP4
ADDRGP4 Menus_CloseByName
CALLV
pop
line 2558
;2558:			trap_Cvar_Set("cl_conXOffset", "0");
ADDRGP4 $977
ARGP4
ADDRGP4 $978
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2559
;2559:			cg.voiceTime = 0;
ADDRGP4 cg+125528
CNSTI4 0
ASGNI4
line 2560
;2560:		}
LABELV $974
line 2561
;2561:	}
LABELV $969
line 2562
;2562:}
LABELV $968
endproc CG_DrawTimedMenus 4 8
proc CG_Draw2D 24 36
line 2572
;2563:#endif
;2564:
;2565:
;2566:/*
;2567:=================
;2568:CG_Draw2D
;2569:=================
;2570:*/
;2571:static void CG_Draw2D( stereoFrame_t stereoFrame )
;2572:{
line 2574
;2573:#ifdef MISSIONPACK
;2574:	if (cgs.orderPending && cg.time > cgs.orderTime) {
ADDRGP4 cgs+148716
INDIRI4
CNSTI4 0
EQI4 $981
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+148720
INDIRI4
LEI4 $981
line 2575
;2575:		CG_CheckOrderPending();
ADDRGP4 CG_CheckOrderPending
CALLV
pop
line 2576
;2576:	}
LABELV $981
line 2579
;2577:#endif
;2578:	// if we are taking a levelshot for the menu, don't draw anything
;2579:	if ( cg.levelShot ) {
ADDRGP4 cg+12
INDIRI4
CNSTI4 0
EQI4 $986
line 2580
;2580:		return;
ADDRGP4 $980
JUMPV
LABELV $986
line 2583
;2581:	}
;2582:
;2583:	if ( cg_draw2D.integer == 0 ) {
ADDRGP4 cg_draw2D+12
INDIRI4
CNSTI4 0
NEI4 $989
line 2584
;2584:		return;
ADDRGP4 $980
JUMPV
LABELV $989
line 2587
;2585:	}
;2586:
;2587:	if ( cg.snap->ps.pm_type == PM_INTERMISSION ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
NEI4 $992
line 2588
;2588:		CG_DrawIntermission();
ADDRGP4 CG_DrawIntermission
CALLV
pop
line 2589
;2589:		return;
ADDRGP4 $980
JUMPV
LABELV $992
line 2597
;2590:	}
;2591:
;2592:/*
;2593:	if (cg.cameraMode) {
;2594:		return;
;2595:	}
;2596:*/
;2597:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $995
line 2598
;2598:		CG_DrawSpectator();
ADDRGP4 CG_DrawSpectator
CALLV
pop
line 2599
;2599:		CG_DrawCrosshair();
ADDRGP4 CG_DrawCrosshair
CALLV
pop
line 2600
;2600:		CG_DrawCrosshairNames();
ADDRGP4 CG_DrawCrosshairNames
CALLV
pop
line 2601
;2601:	} else {
ADDRGP4 $996
JUMPV
LABELV $995
line 2603
;2602:		// don't draw any status if dead or the scoreboard is being explicitly shown
;2603:		if ( !cg.showScores && cg.snap->ps.stats[STAT_HEALTH] > 0 ) {
ADDRGP4 cg+115356
INDIRI4
CNSTI4 0
NEI4 $998
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
LEI4 $998
line 2606
;2604:
;2605:#ifdef MISSIONPACK
;2606:			if ( cg_drawStatus.integer ) {
ADDRGP4 cg_drawStatus+12
INDIRI4
CNSTI4 0
EQI4 $1002
line 2607
;2607:				Menu_PaintAll();
ADDRGP4 Menu_PaintAll
CALLV
pop
line 2608
;2608:				CG_DrawTimedMenus();
ADDRGP4 CG_DrawTimedMenus
CALLV
pop
line 2609
;2609:			}
LABELV $1002
line 2614
;2610:#else
;2611:			CG_DrawStatusBar();
;2612:#endif
;2613:      
;2614:			CG_DrawAmmoWarning();
ADDRGP4 CG_DrawAmmoWarning
CALLV
pop
line 2617
;2615:
;2616:#ifdef MISSIONPACK
;2617:			CG_DrawProxWarning();
ADDRGP4 CG_DrawProxWarning
CALLV
pop
line 2619
;2618:#endif      
;2619:			CG_DrawCrosshair();
ADDRGP4 CG_DrawCrosshair
CALLV
pop
line 2620
;2620:			CG_DrawCrosshairNames();
ADDRGP4 CG_DrawCrosshairNames
CALLV
pop
line 2621
;2621:			CG_DrawWeaponSelect();
ADDRGP4 CG_DrawWeaponSelect
CALLV
pop
line 2628
;2622:
;2623:#ifndef MISSIONPACK
;2624:			CG_DrawHoldableItem();
;2625:#else
;2626:			//CG_DrawPersistantPowerup();
;2627:#endif
;2628:			CG_DrawReward();
ADDRGP4 CG_DrawReward
CALLV
pop
line 2629
;2629:		}
LABELV $998
line 2631
;2630:    
;2631:		if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $1005
line 2635
;2632:#ifndef MISSIONPACK
;2633:			CG_DrawTeamInfo();
;2634:#endif
;2635:		}
LABELV $1005
line 2636
;2636:	}
LABELV $996
line 2638
;2637:
;2638:	CG_DrawVote();
ADDRGP4 CG_DrawVote
CALLV
pop
line 2639
;2639:	CG_DrawTeamVote();
ADDRGP4 CG_DrawTeamVote
CALLV
pop
line 2641
;2640:
;2641:	CG_DrawLagometer();
ADDRGP4 CG_DrawLagometer
CALLV
pop
line 2644
;2642:
;2643:#ifdef MISSIONPACK
;2644:	if (!cg_paused.integer) {
ADDRGP4 cg_paused+12
INDIRI4
CNSTI4 0
NEI4 $1008
line 2645
;2645:		CG_DrawUpperRight(stereoFrame);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 CG_DrawUpperRight
CALLV
pop
line 2646
;2646:	}
LABELV $1008
line 2656
;2647:#else
;2648:	CG_DrawUpperRight(stereoFrame);
;2649:#endif
;2650:
;2651:#ifndef MISSIONPACK
;2652:	CG_DrawLowerRight();
;2653:	CG_DrawLowerLeft();
;2654:#endif
;2655:
;2656:	if ( !CG_DrawFollow() ) {
ADDRLP4 0
ADDRGP4 CG_DrawFollow
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1011
line 2657
;2657:		CG_DrawWarmup();
ADDRGP4 CG_DrawWarmup
CALLV
pop
line 2658
;2658:	}
LABELV $1011
line 2661
;2659:
;2660:	// don't draw center string if scoreboard is up
;2661:	cg.scoreBoardShowing = CG_DrawScoreboard();
ADDRLP4 4
ADDRGP4 CG_DrawScoreboard
CALLI4
ASGNI4
ADDRGP4 cg+115360
ADDRLP4 4
INDIRI4
ASGNI4
line 2662
;2662:	if ( !cg.scoreBoardShowing ) {
ADDRGP4 cg+115360
INDIRI4
CNSTI4 0
NEI4 $1014
line 2663
;2663:		CG_DrawCenterString();
ADDRGP4 CG_DrawCenterString
CALLV
pop
line 2664
;2664:	}
LABELV $1014
line 2666
;2665:
;2666:	if ( cgs.score_catched ) {
ADDRGP4 cgs+150096
INDIRI4
CNSTI4 0
EQI4 $1017
line 2668
;2667:		float x, y, w, h;
;2668:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2669
;2669:		x = cgs.cursorX - 12;
ADDRLP4 8
ADDRGP4 cgs+150104
INDIRF4
CNSTF4 1094713344
SUBF4
ASGNF4
line 2670
;2670:		y = cgs.cursorY - 12;
ADDRLP4 12
ADDRGP4 cgs+150108
INDIRF4
CNSTF4 1094713344
SUBF4
ASGNF4
line 2671
;2671:		w = 24;
ADDRLP4 16
CNSTF4 1103101952
ASGNF4
line 2672
;2672:		h = 24;
ADDRLP4 20
CNSTF4 1103101952
ASGNF4
line 2673
;2673:		CG_AdjustFrom640( &x, &y, &w, &h );
ADDRLP4 8
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 2674
;2674:		trap_R_DrawStretchPic( x, y, w, h, 0, 0, 1, 1, cgs.media.cursor );
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 cgs+148772+1236
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 2675
;2675:	}
LABELV $1017
line 2676
;2676:}
LABELV $980
endproc CG_Draw2D 24 36
proc CG_DrawTourneyScoreboard 0 0
line 2679
;2677:
;2678:
;2679:static void CG_DrawTourneyScoreboard( void ) {
line 2684
;2680:#ifdef MISSIONPACK
;2681:#else
;2682:	CG_DrawOldTourneyScoreboard();
;2683:#endif
;2684:}
LABELV $1024
endproc CG_DrawTourneyScoreboard 0 0
proc CG_CalculatePing 16 0
line 2687
;2685:
;2686:
;2687:static void CG_CalculatePing( void ) {
line 2690
;2688:	int count, i, v;
;2689:
;2690:	cg.meanPing = 0;
ADDRGP4 cg+157016
CNSTI4 0
ASGNI4
line 2692
;2691:
;2692:	for ( i = 0, count = 0; i < LAG_SAMPLES; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $1030
JUMPV
LABELV $1027
line 2694
;2693:
;2694:		v = lagometer.snapshotSamples[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
INDIRI4
ASGNI4
line 2695
;2695:		if ( v >= 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $1032
line 2696
;2696:			cg.meanPing += v;
ADDRLP4 12
ADDRGP4 cg+157016
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 2697
;2697:			count++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2698
;2698:		}
LABELV $1032
line 2700
;2699:
;2700:	}
LABELV $1028
line 2692
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1030
ADDRLP4 0
INDIRI4
CNSTI4 128
LTI4 $1027
line 2702
;2701:
;2702:	if ( count ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1035
line 2703
;2703:		cg.meanPing /= count;
ADDRLP4 12
ADDRGP4 cg+157016
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
DIVI4
ASGNI4
line 2704
;2704:	}
LABELV $1035
line 2705
;2705:}
LABELV $1025
endproc CG_CalculatePing 16 0
proc CG_WarmupEvents 8 12
line 2708
;2706:
;2707:
;2708:static void CG_WarmupEvents( void ) {
line 2712
;2709:
;2710:	int	count;
;2711:
;2712:	if ( !cg.warmup )
ADDRGP4 cg+125768
INDIRI4
CNSTI4 0
NEI4 $1039
line 2713
;2713:		return;
ADDRGP4 $1038
JUMPV
LABELV $1039
line 2715
;2714:
;2715:	if ( cg.warmup < 0 ) {
ADDRGP4 cg+125768
INDIRI4
CNSTI4 0
GEI4 $1042
line 2716
;2716:		cg.warmupCount = -1;
ADDRGP4 cg+125772
CNSTI4 -1
ASGNI4
line 2717
;2717:		return;
ADDRGP4 $1038
JUMPV
LABELV $1042
line 2720
;2718:	}
;2719:
;2720:	if ( cg.warmup < cg.time ) {
ADDRGP4 cg+125768
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $1046
line 2721
;2721:		cg.warmup = 0;
ADDRGP4 cg+125768
CNSTI4 0
ASGNI4
line 2722
;2722:		count = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2723
;2723:	} else {
ADDRGP4 $1047
JUMPV
LABELV $1046
line 2724
;2724:		count = ( cg.warmup - cg.time + 999 ) / 1000;
ADDRLP4 0
ADDRGP4 cg+125768
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CNSTI4 999
ADDI4
CNSTI4 1000
DIVI4
ASGNI4
line 2725
;2725:	}
LABELV $1047
line 2727
;2726:
;2727:	if ( cg.warmupCount == -2 && cg.demoPlayback ) {
ADDRGP4 cg+125772
INDIRI4
CNSTI4 -2
NEI4 $1053
ADDRGP4 cg+8
INDIRI4
CNSTI4 0
EQI4 $1053
line 2728
;2728:		cg.warmupCount = 0;
ADDRGP4 cg+125772
CNSTI4 0
ASGNI4
line 2729
;2729:	}
LABELV $1053
line 2731
;2730:
;2731:	if ( cg.warmupCount == count ) {
ADDRGP4 cg+125772
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1058
line 2732
;2732:		return;
ADDRGP4 $1038
JUMPV
LABELV $1058
line 2735
;2733:	}
;2734:
;2735:	cg.warmupCount = count;
ADDRGP4 cg+125772
ADDRLP4 0
INDIRI4
ASGNI4
line 2736
;2736:	cg.timelimitWarnings = 0;
ADDRGP4 cg+107616
CNSTI4 0
ASGNI4
line 2738
;2737:
;2738:	switch ( count ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1064
ADDRLP4 0
INDIRI4
CNSTI4 3
GTI4 $1064
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1084
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1084
address $1065
address $1075
address $1078
address $1081
code
LABELV $1065
line 2740
;2739:		case 0:
;2740:			if ( cg.warmupFightSound <= cg.time ) {
ADDRGP4 cg+125776
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GTI4 $1066
line 2741
;2741:				trap_S_StartLocalSound( cgs.media.countFightSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+148772+1156
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2742
;2742:				cg.warmupFightSound = cg.time + 750;
ADDRGP4 cg+125776
ADDRGP4 cg+107604
INDIRI4
CNSTI4 750
ADDI4
ASGNI4
line 2743
;2743:			}
LABELV $1066
line 2744
;2744:			CG_CenterPrint( "FIGHT!", 120, GIANTCHAR_WIDTH*2 );
ADDRGP4 $1074
ARGP4
CNSTI4 120
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 2745
;2745:			break;
ADDRGP4 $1064
JUMPV
LABELV $1075
line 2748
;2746:
;2747:		case 1:
;2748:			trap_S_StartLocalSound( cgs.media.count1Sound, CHAN_ANNOUNCER );
ADDRGP4 cgs+148772+1152
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2749
;2749:			break;
ADDRGP4 $1064
JUMPV
LABELV $1078
line 2752
;2750:
;2751:		case 2:
;2752:			trap_S_StartLocalSound( cgs.media.count2Sound, CHAN_ANNOUNCER );
ADDRGP4 cgs+148772+1148
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2753
;2753:			break;
ADDRGP4 $1064
JUMPV
LABELV $1081
line 2756
;2754:
;2755:		case 3:
;2756:			trap_S_StartLocalSound( cgs.media.count3Sound, CHAN_ANNOUNCER );
ADDRGP4 cgs+148772+1144
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2757
;2757:			break;
line 2760
;2758:
;2759:		default:
;2760:			break;
LABELV $1064
line 2762
;2761:	}
;2762:}
LABELV $1038
endproc CG_WarmupEvents 8 12
export CG_WarmupEvent
proc CG_WarmupEvent 0 0
line 2767
;2763:
;2764:
;2765:
;2766:// will be called on warmup end and when client changed
;2767:void CG_WarmupEvent( void ) {
line 2769
;2768:
;2769:	cg.attackerTime = 0;
ADDRGP4 cg+125524
CNSTI4 0
ASGNI4
line 2770
;2770:	cg.attackerName[0] = '\0';
ADDRGP4 cg+125488
CNSTI1 0
ASGNI1
line 2772
;2771:
;2772:	cg.itemPickupTime = 0;
ADDRGP4 cg+125788
CNSTI4 0
ASGNI4
line 2773
;2773:	cg.itemPickupBlendTime = 0;
ADDRGP4 cg+125792
CNSTI4 0
ASGNI4
line 2774
;2774:	cg.itemPickupCount = 0;
ADDRGP4 cg+125784
CNSTI4 0
ASGNI4
line 2776
;2775:
;2776:	cg.killerTime = 0;
ADDRGP4 cg+115432
CNSTI4 0
ASGNI4
line 2777
;2777:	cg.killerName[0] = '\0';
ADDRGP4 cg+115368
CNSTI1 0
ASGNI1
line 2779
;2778:	
;2779:	cg.damageTime = 0;
ADDRGP4 cg+125808
CNSTI4 0
ASGNI4
line 2781
;2780:
;2781:	cg.rewardStack = 0;
ADDRGP4 cg+125532
CNSTI4 0
ASGNI4
line 2782
;2782:	cg.rewardTime = 0;
ADDRGP4 cg+125536
CNSTI4 0
ASGNI4
line 2784
;2783:	
;2784:	cg.weaponSelectTime = cg.time;
ADDRGP4 cg+125796
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 2786
;2785:
;2786:	cg.lowAmmoWarning = 0;
ADDRGP4 cg+125464
CNSTI4 0
ASGNI4
line 2788
;2787:
;2788:	cg.followTime = 0;
ADDRGP4 cg+157028
CNSTI4 0
ASGNI4
line 2789
;2789:}
LABELV $1085
endproc CG_WarmupEvent 0 0
proc CG_ApplyClientChange 0 0
line 2794
;2790:
;2791:
;2792:// called each time client team changed
;2793:static void CG_ApplyClientChange( void )
;2794:{
line 2795
;2795:	CG_WarmupEvent();
ADDRGP4 CG_WarmupEvent
CALLV
pop
line 2796
;2796:	CG_ForceModelChange();
ADDRGP4 CG_ForceModelChange
CALLV
pop
line 2797
;2797:}
LABELV $1100
endproc CG_ApplyClientChange 0 0
data
align 4
LABELV $1102
byte 4 -1
align 4
LABELV $1103
byte 4 -1
align 4
LABELV $1104
byte 4 -1
export CG_TrackClientTeamChange
code
proc CG_TrackClientTeamChange 8 4
line 2806
;2798:
;2799:
;2800:/*
;2801:=====================
;2802:CG_TrackClientTeamChange
;2803:=====================
;2804:*/
;2805:void CG_TrackClientTeamChange( void ) 
;2806:{
line 2814
;2807:	static int spec_client = -1;
;2808:	static int spec_team = -1;
;2809:	static int curr_team = -1;
;2810:
;2811:	int		ti; // team from clientinfo 
;2812:	int		tp; // persistant team from snapshot
;2813:
;2814:	if ( !cg.snap )
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1105
line 2815
;2815:		return;
ADDRGP4 $1101
JUMPV
LABELV $1105
line 2817
;2816:
;2817:	tp = cg.snap->ps.persistant[ PERS_TEAM ];
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ASGNI4
line 2818
;2818:	ti = cgs.clientinfo[ cg.snap->ps.clientNum ].team;
ADDRLP4 4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+36
ADDP4
INDIRI4
ASGNI4
line 2820
;2819:
;2820:	if ( !(cg.snap->ps.pm_flags & PMF_FOLLOW) && tp != TEAM_SPECTATOR ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $1112
ADDRLP4 0
INDIRI4
CNSTI4 3
EQI4 $1112
line 2821
;2821:		ti = tp; // use team from persistant info
ADDRLP4 4
ADDRLP4 0
INDIRI4
ASGNI4
line 2822
;2822:	}
LABELV $1112
line 2825
;2823:
;2824:	// team changed
;2825:	if ( curr_team != ti )
ADDRGP4 $1104
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $1115
line 2826
;2826:	{
line 2827
;2827:		curr_team = ti;
ADDRGP4 $1104
ADDRLP4 4
INDIRI4
ASGNI4
line 2828
;2828:		spec_client = cg.snap->ps.clientNum;
ADDRGP4 $1102
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 2829
;2829:		spec_team = tp;
ADDRGP4 $1103
ADDRLP4 0
INDIRI4
ASGNI4
line 2831
;2830:
;2831:		if ( spec_team == TEAM_SPECTATOR )
ADDRGP4 $1103
INDIRI4
CNSTI4 3
NEI4 $1118
line 2832
;2832:			spec_team = curr_team;
ADDRGP4 $1103
ADDRGP4 $1104
INDIRI4
ASGNI4
LABELV $1118
line 2834
;2833:
;2834:		CG_ApplyClientChange();
ADDRGP4 CG_ApplyClientChange
CALLV
pop
line 2835
;2835:		CG_ResetPlayerEntity( &cg.predictedPlayerEntity );
ADDRGP4 cg+108104
ARGP4
ADDRGP4 CG_ResetPlayerEntity
CALLV
pop
line 2836
;2836:		return;
ADDRGP4 $1101
JUMPV
LABELV $1115
line 2839
;2837:	}
;2838:
;2839:	if ( curr_team == TEAM_SPECTATOR )
ADDRGP4 $1104
INDIRI4
CNSTI4 3
NEI4 $1121
line 2840
;2840:	{
line 2841
;2841:		if ( spec_team != tp )
ADDRGP4 $1103
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $1123
line 2842
;2842:		{
line 2843
;2843:			spec_team  = tp;
ADDRGP4 $1103
ADDRLP4 0
INDIRI4
ASGNI4
line 2844
;2844:			spec_client = cg.snap->ps.clientNum;
ADDRGP4 $1102
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 2846
;2845:
;2846:			CG_ApplyClientChange();
ADDRGP4 CG_ApplyClientChange
CALLV
pop
line 2847
;2847:			CG_ResetPlayerEntity( &cg.predictedPlayerEntity );
ADDRGP4 cg+108104
ARGP4
ADDRGP4 CG_ResetPlayerEntity
CALLV
pop
line 2848
;2848:			return;
ADDRGP4 $1101
JUMPV
LABELV $1123
line 2851
;2849:		}
;2850:
;2851:		if ( cgs.gametype >= GT_TEAM ) 
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $1127
line 2852
;2852:		{
line 2853
;2853:			spec_client = cg.snap->ps.clientNum;
ADDRGP4 $1102
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 2854
;2854:			return;
ADDRGP4 $1101
JUMPV
LABELV $1127
line 2857
;2855:		}
;2856:		// pass through to spec client checks
;2857:	}
LABELV $1121
line 2859
;2858:	
;2859:	if ( spec_client != cg.snap->ps.clientNum ) 
ADDRGP4 $1102
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $1131
line 2860
;2860:	{
line 2861
;2861:		spec_client = cg.snap->ps.clientNum;
ADDRGP4 $1102
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 2862
;2862:		spec_team = tp;
ADDRGP4 $1103
ADDRLP4 0
INDIRI4
ASGNI4
line 2864
;2863:
;2864:		if ( spec_team == TEAM_SPECTATOR )
ADDRGP4 $1103
INDIRI4
CNSTI4 3
NEI4 $1135
line 2865
;2865:			spec_team = cgs.clientinfo[ cg.snap->ps.clientNum ].team;
ADDRGP4 $1103
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+36
ADDP4
INDIRI4
ASGNI4
LABELV $1135
line 2867
;2866:
;2867:		CG_ApplyClientChange();
ADDRGP4 CG_ApplyClientChange
CALLV
pop
line 2868
;2868:		CG_ResetPlayerEntity( &cg.predictedPlayerEntity );
ADDRGP4 cg+108104
ARGP4
ADDRGP4 CG_ResetPlayerEntity
CALLV
pop
line 2869
;2869:	}
LABELV $1131
line 2870
;2870:}
LABELV $1101
endproc CG_TrackClientTeamChange 8 4
export CG_DrawActive
proc CG_DrawActive 0 4
line 2880
;2871:
;2872:
;2873:/*
;2874:=====================
;2875:CG_DrawActive
;2876:
;2877:Perform all drawing needed to completely fill the screen
;2878:=====================
;2879:*/
;2880:void CG_DrawActive( stereoFrame_t stereoView ) {
line 2882
;2881:	// optionally draw the info screen instead
;2882:	if ( !cg.snap ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1142
line 2883
;2883:		CG_DrawInformation();
ADDRGP4 CG_DrawInformation
CALLV
pop
line 2884
;2884:		return;
ADDRGP4 $1141
JUMPV
LABELV $1142
line 2887
;2885:	}
;2886:
;2887:	if ( !cg.demoPlayback ) {
ADDRGP4 cg+8
INDIRI4
CNSTI4 0
NEI4 $1145
line 2888
;2888:		CG_CalculatePing();
ADDRGP4 CG_CalculatePing
CALLV
pop
line 2889
;2889:	}
LABELV $1145
line 2892
;2890:
;2891:	// optionally draw the tournement scoreboard instead
;2892:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR &&
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1148
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1148
line 2893
;2893:		( cg.snap->ps.pm_flags & PMF_SCOREBOARD ) ) {
line 2894
;2894:		CG_DrawTourneyScoreboard();
ADDRGP4 CG_DrawTourneyScoreboard
CALLV
pop
line 2895
;2895:		return;
ADDRGP4 $1141
JUMPV
LABELV $1148
line 2899
;2896:	}
;2897:
;2898:	// clear around the rendered view if sized down
;2899:	CG_TileClear();
ADDRGP4 CG_TileClear
CALLV
pop
line 2902
;2900:
;2901:	// draw 3D view
;2902:	trap_R_RenderScene( &cg.refdef );
ADDRGP4 cg+109056
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 2905
;2903:
;2904:	// play warmup sounds and display text
;2905:	CG_WarmupEvents();
ADDRGP4 CG_WarmupEvents
CALLV
pop
line 2908
;2906:
;2907:	// draw status bar and other floating elements
;2908: 	CG_Draw2D( stereoView );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 CG_Draw2D
CALLV
pop
line 2909
;2909:}
LABELV $1141
endproc CG_DrawActive 0 4
bss
export lagometer
align 4
LABELV lagometer
skip 1544
import cgDC
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
import CG_InitConsoleCommands
import CG_ConsoleCommand
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
import CG_ForceModelChange
import CG_StatusHandle
import CG_OtherTeamHasFlag
import CG_YourTeamHasFlag
import CG_GameTypeString
import CG_CheckOrderPending
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
import CG_OwnerDraw
export teamChat2
align 1
LABELV teamChat2
skip 256
export teamChat1
align 1
LABELV teamChat1
skip 256
export systemChat
align 1
LABELV systemChat
skip 256
import drawTeamOverlayModificationCount
export numSortedTeamPlayers
align 4
LABELV numSortedTeamPlayers
skip 4
export sortedTeamPlayers
align 4
LABELV sortedTeamPlayers
skip 128
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
LABELV $1074
byte 1 70
byte 1 73
byte 1 71
byte 1 72
byte 1 84
byte 1 33
byte 1 0
align 1
LABELV $978
byte 1 48
byte 1 0
align 1
LABELV $977
byte 1 99
byte 1 108
byte 1 95
byte 1 99
byte 1 111
byte 1 110
byte 1 88
byte 1 79
byte 1 102
byte 1 102
byte 1 115
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $976
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 0
align 1
LABELV $960
byte 1 83
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $956
byte 1 0
align 1
LABELV $955
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
LABELV $951
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
LABELV $947
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
LABELV $943
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
LABELV $939
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
LABELV $935
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
LABELV $931
byte 1 37
byte 1 115
byte 1 32
byte 1 118
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $911
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
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $902
byte 1 89
byte 1 79
byte 1 85
byte 1 32
byte 1 72
byte 1 65
byte 1 86
byte 1 69
byte 1 32
byte 1 66
byte 1 69
byte 1 69
byte 1 78
byte 1 32
byte 1 77
byte 1 73
byte 1 78
byte 1 69
byte 1 68
byte 1 0
align 1
LABELV $901
byte 1 73
byte 1 78
byte 1 84
byte 1 69
byte 1 82
byte 1 78
byte 1 65
byte 1 76
byte 1 32
byte 1 67
byte 1 79
byte 1 77
byte 1 66
byte 1 85
byte 1 83
byte 1 84
byte 1 73
byte 1 79
byte 1 78
byte 1 32
byte 1 73
byte 1 78
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $884
byte 1 76
byte 1 79
byte 1 87
byte 1 32
byte 1 65
byte 1 77
byte 1 77
byte 1 79
byte 1 32
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 0
align 1
LABELV $883
byte 1 79
byte 1 85
byte 1 84
byte 1 32
byte 1 79
byte 1 70
byte 1 32
byte 1 65
byte 1 77
byte 1 77
byte 1 79
byte 1 0
align 1
LABELV $868
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $851
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 95
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 0
align 1
LABELV $850
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 95
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 0
align 1
LABELV $808
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 86
byte 1 79
byte 1 84
byte 1 69
byte 1 40
byte 1 37
byte 1 105
byte 1 41
byte 1 58
byte 1 37
byte 1 115
byte 1 32
byte 1 121
byte 1 101
byte 1 115
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 110
byte 1 111
byte 1 58
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $782
byte 1 111
byte 1 114
byte 1 32
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 69
byte 1 83
byte 1 67
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 110
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $777
byte 1 86
byte 1 79
byte 1 84
byte 1 69
byte 1 40
byte 1 37
byte 1 105
byte 1 41
byte 1 58
byte 1 37
byte 1 115
byte 1 32
byte 1 121
byte 1 101
byte 1 115
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 110
byte 1 111
byte 1 58
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $762
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 69
byte 1 83
byte 1 67
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 74
byte 1 79
byte 1 73
byte 1 78
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $757
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $752
byte 1 83
byte 1 80
byte 1 69
byte 1 67
byte 1 84
byte 1 65
byte 1 84
byte 1 79
byte 1 82
byte 1 0
align 1
LABELV $621
byte 1 37
byte 1 105
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $617
byte 1 115
byte 1 110
byte 1 99
byte 1 0
align 1
LABELV $549
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 101
byte 1 116
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $542
byte 1 67
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 73
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 114
byte 1 117
byte 1 112
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $511
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $437
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 37
byte 1 51
byte 1 105
byte 1 0
align 1
LABELV $434
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $364
byte 1 37
byte 1 105
byte 1 58
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 0
align 1
LABELV $359
byte 1 37
byte 1 105
byte 1 102
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $342
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 115
byte 1 110
byte 1 97
byte 1 112
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 99
byte 1 109
byte 1 100
byte 1 58
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $335
byte 1 37
byte 1 49
byte 1 46
byte 1 48
byte 1 102
byte 1 117
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $326
byte 1 110
byte 1 0
