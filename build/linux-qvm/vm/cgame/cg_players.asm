data
align 4
LABELV cg_customSoundNames
address $72
address $73
address $74
address $75
address $76
address $77
address $78
address $79
address $80
address $81
address $82
address $83
address $84
skip 76
export CG_CustomSound
code
proc CG_CustomSound 16 8
file "../../../../code/cgame/cg_players.c"
line 32
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_players.c -- handle the media and animation for player entities
;4:#include "cg_local.h"
;5:
;6:#define	PM_SKIN "pm"
;7:#define FB_SKIN "fb"
;8:
;9:static const char *cg_customSoundNames[ MAX_CUSTOM_SOUNDS ] = {
;10:	"*death1.wav",
;11:	"*death2.wav",
;12:	"*death3.wav",
;13:	"*jump1.wav",
;14:	"*pain25_1.wav",
;15:	"*pain50_1.wav",
;16:	"*pain75_1.wav",
;17:	"*pain100_1.wav",
;18:	"*falling1.wav",
;19:	"*gasp.wav",
;20:	"*drown.wav",
;21:	"*fall1.wav",
;22:	"*taunt.wav"
;23:};
;24:
;25:
;26:/*
;27:================
;28:CG_CustomSound
;29:
;30:================
;31:*/
;32:sfxHandle_t	CG_CustomSound( int clientNum, const char *soundName ) {
line 36
;33:	clientInfo_t *ci;
;34:	int			i;
;35:
;36:	if ( soundName[0] != '*' ) {
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
EQI4 $86
line 37
;37:		return trap_S_RegisterSound( soundName, qfalse );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $85
JUMPV
LABELV $86
line 40
;38:	}
;39:
;40:	if ( clientNum < 0 || clientNum >= MAX_CLIENTS ) {
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $90
ADDRLP4 8
INDIRI4
CNSTI4 64
LTI4 $88
LABELV $90
line 41
;41:		clientNum = 0;
ADDRFP4 0
CNSTI4 0
ASGNI4
line 42
;42:	}
LABELV $88
line 43
;43:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 4
ADDRFP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 45
;44:
;45:	for ( i = 0 ; i < MAX_CUSTOM_SOUNDS && cg_customSoundNames[i] ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $95
JUMPV
LABELV $92
line 46
;46:		if ( !strcmp( soundName, cg_customSoundNames[i] ) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_customSoundNames
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $96
line 47
;47:			return ci->sounds[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 1484
ADDP4
ADDP4
INDIRI4
RETI4
ADDRGP4 $85
JUMPV
LABELV $96
line 49
;48:		}
;49:	}
LABELV $93
line 45
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $95
ADDRLP4 0
INDIRI4
CNSTI4 32
GEI4 $98
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_customSoundNames
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $92
LABELV $98
line 51
;50:
;51:	CG_Error( "Unknown custom sound: %s", soundName );
ADDRGP4 $99
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 52
;52:	return 0;
CNSTI4 0
RETI4
LABELV $85
endproc CG_CustomSound 16 8
proc CG_ParseAnimationFile 20076 12
line 73
;53:}
;54:
;55:
;56:
;57:/*
;58:=============================================================================
;59:
;60:CLIENT INFO
;61:
;62:=============================================================================
;63:*/
;64:
;65:/*
;66:======================
;67:CG_ParseAnimationFile
;68:
;69:Read a configuration file containing animation counts and rates
;70:models/players/visor/animation.cfg, etc
;71:======================
;72:*/
;73:static qboolean	CG_ParseAnimationFile( const char *filename, clientInfo_t *ci ) {
line 84
;74:	char		*text_p, *prev;
;75:	int			len;
;76:	int			i;
;77:	char		*token;
;78:	float		fps;
;79:	int			skip;
;80:	char		text[20000];
;81:	fileHandle_t	f;
;82:	animation_t *animations;
;83:
;84:	animations = ci->animations;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 448
ADDP4
ASGNP4
line 87
;85:
;86:	// load the file
;87:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 20036
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 20036
INDIRI4
ASGNI4
line 88
;88:	if ( f == FS_INVALID_HANDLE ) {
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $101
line 89
;89:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $100
JUMPV
LABELV $101
line 91
;90:	}
;91:	if ( len <= 0 ) {
ADDRLP4 28
INDIRI4
CNSTI4 0
GTI4 $103
line 92
;92:		trap_FS_FCloseFile( f );
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 93
;93:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $100
JUMPV
LABELV $103
line 95
;94:	}
;95:	if ( len >= sizeof( text ) - 1 ) {
ADDRLP4 28
INDIRI4
CVIU4 4
CNSTU4 19999
LTU4 $105
line 96
;96:		CG_Printf( "File %s too long\n", filename );
ADDRGP4 $107
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 97
;97:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $100
JUMPV
LABELV $105
line 99
;98:	}
;99:	trap_FS_Read( text, len, f );
ADDRLP4 36
ARGP4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 100
;100:	text[len] = '\0';
ADDRLP4 28
INDIRI4
ADDRLP4 36
ADDP4
CNSTI1 0
ASGNI1
line 101
;101:	trap_FS_FCloseFile( f );
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 104
;102:
;103:	// parse the text
;104:	text_p = text;
ADDRLP4 12
ADDRLP4 36
ASGNP4
line 105
;105:	skip = 0;	// quite the compiler warning
ADDRLP4 24
CNSTI4 0
ASGNI4
line 107
;106:
;107:	ci->footsteps = FOOTSTEP_NORMAL;
ADDRFP4 4
INDIRP4
CNSTI4 412
ADDP4
CNSTI4 0
ASGNI4
line 108
;108:	VectorClear( ci->headOffset );
ADDRFP4 4
INDIRP4
CNSTI4 400
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 404
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 408
ADDP4
CNSTF4 0
ASGNF4
line 109
;109:	ci->gender = GENDER_MALE;
ADDRFP4 4
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 0
ASGNI4
line 110
;110:	ci->fixedlegs = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 392
ADDP4
CNSTI4 0
ASGNI4
line 111
;111:	ci->fixedtorso = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 396
ADDP4
CNSTI4 0
ASGNI4
ADDRGP4 $109
JUMPV
LABELV $108
line 114
;112:
;113:	// read optional parameters
;114:	while ( 1 ) {
line 115
;115:		prev = text_p;	// so we can unget
ADDRLP4 20
ADDRLP4 12
INDIRP4
ASGNP4
line 116
;116:		token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20040
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20040
INDIRP4
ASGNP4
line 117
;117:		if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $111
line 118
;118:			break;
ADDRGP4 $110
JUMPV
LABELV $111
line 120
;119:		}
;120:		if ( !Q_stricmp( token, "footsteps" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $115
ARGP4
ADDRLP4 20044
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20044
INDIRI4
CNSTI4 0
NEI4 $113
line 121
;121:			token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20048
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20048
INDIRP4
ASGNP4
line 122
;122:			if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $116
line 123
;123:				break;
ADDRGP4 $110
JUMPV
LABELV $116
line 125
;124:			}
;125:			if ( !Q_stricmp( token, "default" ) || !Q_stricmp( token, "normal" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $120
ARGP4
ADDRLP4 20052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20052
INDIRI4
CNSTI4 0
EQI4 $122
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $121
ARGP4
ADDRLP4 20056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20056
INDIRI4
CNSTI4 0
NEI4 $118
LABELV $122
line 126
;126:				ci->footsteps = FOOTSTEP_NORMAL;
ADDRFP4 4
INDIRP4
CNSTI4 412
ADDP4
CNSTI4 0
ASGNI4
line 127
;127:			} else if ( !Q_stricmp( token, "boot" ) ) {
ADDRGP4 $109
JUMPV
LABELV $118
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $125
ARGP4
ADDRLP4 20060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20060
INDIRI4
CNSTI4 0
NEI4 $123
line 128
;128:				ci->footsteps = FOOTSTEP_BOOT;
ADDRFP4 4
INDIRP4
CNSTI4 412
ADDP4
CNSTI4 1
ASGNI4
line 129
;129:			} else if ( !Q_stricmp( token, "flesh" ) ) {
ADDRGP4 $109
JUMPV
LABELV $123
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $128
ARGP4
ADDRLP4 20064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20064
INDIRI4
CNSTI4 0
NEI4 $126
line 130
;130:				ci->footsteps = FOOTSTEP_FLESH;
ADDRFP4 4
INDIRP4
CNSTI4 412
ADDP4
CNSTI4 2
ASGNI4
line 131
;131:			} else if ( !Q_stricmp( token, "mech" ) ) {
ADDRGP4 $109
JUMPV
LABELV $126
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $131
ARGP4
ADDRLP4 20068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20068
INDIRI4
CNSTI4 0
NEI4 $129
line 132
;132:				ci->footsteps = FOOTSTEP_MECH;
ADDRFP4 4
INDIRP4
CNSTI4 412
ADDP4
CNSTI4 3
ASGNI4
line 133
;133:			} else if ( !Q_stricmp( token, "energy" ) ) {
ADDRGP4 $109
JUMPV
LABELV $129
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $134
ARGP4
ADDRLP4 20072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20072
INDIRI4
CNSTI4 0
NEI4 $132
line 134
;134:				ci->footsteps = FOOTSTEP_ENERGY;
ADDRFP4 4
INDIRP4
CNSTI4 412
ADDP4
CNSTI4 4
ASGNI4
line 135
;135:			} else {
ADDRGP4 $109
JUMPV
LABELV $132
line 136
;136:				CG_Printf( "Bad footsteps parm in %s: %s\n", filename, token );
ADDRGP4 $135
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 137
;137:			}
line 138
;138:			continue;
ADDRGP4 $109
JUMPV
LABELV $113
line 139
;139:		} else if ( !Q_stricmp( token, "headoffset" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $138
ARGP4
ADDRLP4 20048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20048
INDIRI4
CNSTI4 0
NEI4 $136
line 140
;140:			for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $139
line 141
;141:				token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20052
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20052
INDIRP4
ASGNP4
line 142
;142:				if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $143
line 143
;143:					break;
ADDRGP4 $109
JUMPV
LABELV $143
line 145
;144:				}
;145:				ci->headOffset[i] = atof( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20056
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 400
ADDP4
ADDP4
ADDRLP4 20056
INDIRF4
ASGNF4
line 146
;146:			}
LABELV $140
line 140
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 3
LTI4 $139
line 147
;147:			continue;
ADDRGP4 $109
JUMPV
LABELV $136
line 148
;148:		} else if ( !Q_stricmp( token, "sex" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $147
ARGP4
ADDRLP4 20052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20052
INDIRI4
CNSTI4 0
NEI4 $145
line 149
;149:			token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20056
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20056
INDIRP4
ASGNP4
line 150
;150:			if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $148
line 151
;151:				break;
ADDRGP4 $110
JUMPV
LABELV $148
line 153
;152:			}
;153:			if ( token[0] == 'f' || token[0] == 'F' ) {
ADDRLP4 20060
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20060
INDIRI4
CNSTI4 102
EQI4 $152
ADDRLP4 20060
INDIRI4
CNSTI4 70
NEI4 $150
LABELV $152
line 154
;154:				ci->gender = GENDER_FEMALE;
ADDRFP4 4
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 1
ASGNI4
line 155
;155:			} else if ( token[0] == 'n' || token[0] == 'N' ) {
ADDRGP4 $109
JUMPV
LABELV $150
ADDRLP4 20064
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20064
INDIRI4
CNSTI4 110
EQI4 $155
ADDRLP4 20064
INDIRI4
CNSTI4 78
NEI4 $153
LABELV $155
line 156
;156:				ci->gender = GENDER_NEUTER;
ADDRFP4 4
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 2
ASGNI4
line 157
;157:			} else {
ADDRGP4 $109
JUMPV
LABELV $153
line 158
;158:				ci->gender = GENDER_MALE;
ADDRFP4 4
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 0
ASGNI4
line 159
;159:			}
line 160
;160:			continue;
ADDRGP4 $109
JUMPV
LABELV $145
line 161
;161:		} else if ( !Q_stricmp( token, "fixedlegs" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $158
ARGP4
ADDRLP4 20056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20056
INDIRI4
CNSTI4 0
NEI4 $156
line 162
;162:			ci->fixedlegs = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 392
ADDP4
CNSTI4 1
ASGNI4
line 163
;163:			continue;
ADDRGP4 $109
JUMPV
LABELV $156
line 164
;164:		} else if ( !Q_stricmp( token, "fixedtorso" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $161
ARGP4
ADDRLP4 20060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20060
INDIRI4
CNSTI4 0
NEI4 $159
line 165
;165:			ci->fixedtorso = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 396
ADDP4
CNSTI4 1
ASGNI4
line 166
;166:			continue;
ADDRGP4 $109
JUMPV
LABELV $159
line 170
;167:		}
;168:
;169:		// if it is a number, start parsing animations
;170:		if ( token[0] >= '0' && token[0] <= '9' ) {
ADDRLP4 20064
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20064
INDIRI4
CNSTI4 48
LTI4 $162
ADDRLP4 20064
INDIRI4
CNSTI4 57
GTI4 $162
line 171
;171:			text_p = prev;	// unget the token
ADDRLP4 12
ADDRLP4 20
INDIRP4
ASGNP4
line 172
;172:			break;
ADDRGP4 $110
JUMPV
LABELV $162
line 174
;173:		}
;174:		Com_Printf( "unknown token '%s' in %s\n", token, filename );
ADDRGP4 $164
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 175
;175:	}
LABELV $109
line 114
ADDRGP4 $108
JUMPV
LABELV $110
line 178
;176:
;177:	// read information for each frame
;178:	for ( i = 0 ; i < MAX_ANIMATIONS ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $165
line 180
;179:
;180:		token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20040
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20040
INDIRP4
ASGNP4
line 181
;181:		if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $169
line 182
;182:			if( i >= TORSO_GETFLAG && i <= TORSO_NEGATIVE ) {
ADDRLP4 4
INDIRI4
CNSTI4 25
LTI4 $167
ADDRLP4 4
INDIRI4
CNSTI4 30
GTI4 $167
line 183
;183:				animations[i].firstFrame = animations[TORSO_GESTURE].firstFrame;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 184
;184:				animations[i].frameLerp = animations[TORSO_GESTURE].frameLerp;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ASGNI4
line 185
;185:				animations[i].initialLerp = animations[TORSO_GESTURE].initialLerp;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 16
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 186
;186:				animations[i].loopFrames = animations[TORSO_GESTURE].loopFrames;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ASGNI4
line 187
;187:				animations[i].numFrames = animations[TORSO_GESTURE].numFrames;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ASGNI4
line 188
;188:				animations[i].reversed = qfalse;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 189
;189:				animations[i].flipflop = qfalse;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 190
;190:				continue;
ADDRGP4 $166
JUMPV
line 192
;191:			}
;192:			break;
LABELV $169
line 194
;193:		}
;194:		animations[i].firstFrame = atoi( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20044
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 20044
INDIRI4
ASGNI4
line 196
;195:		// leg only frames are adjusted to not count the upper body only frames
;196:		if ( i == LEGS_WALKCR ) {
ADDRLP4 4
INDIRI4
CNSTI4 13
NEI4 $173
line 197
;197:			skip = animations[LEGS_WALKCR].firstFrame - animations[TORSO_GESTURE].firstFrame;
ADDRLP4 24
ADDRLP4 8
INDIRP4
CNSTI4 364
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
SUBI4
ASGNI4
line 198
;198:		}
LABELV $173
line 199
;199:		if ( i >= LEGS_WALKCR && i<TORSO_GETFLAG) {
ADDRLP4 4
INDIRI4
CNSTI4 13
LTI4 $175
ADDRLP4 4
INDIRI4
CNSTI4 25
GEI4 $175
line 200
;200:			animations[i].firstFrame -= skip;
ADDRLP4 20052
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ASGNP4
ADDRLP4 20052
INDIRP4
ADDRLP4 20052
INDIRP4
INDIRI4
ADDRLP4 24
INDIRI4
SUBI4
ASGNI4
line 201
;201:		}
LABELV $175
line 203
;202:
;203:		token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20052
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20052
INDIRP4
ASGNP4
line 204
;204:		if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $177
line 205
;205:			break;
ADDRGP4 $167
JUMPV
LABELV $177
line 207
;206:		}
;207:		animations[i].numFrames = atoi( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20056
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 20056
INDIRI4
ASGNI4
line 209
;208:
;209:		animations[i].reversed = qfalse;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 210
;210:		animations[i].flipflop = qfalse;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 212
;211:		// if numFrames is negative the animation is reversed
;212:		if (animations[i].numFrames < 0) {
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 0
GEI4 $179
line 213
;213:			animations[i].numFrames = -animations[i].numFrames;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
NEGI4
ASGNI4
line 214
;214:			animations[i].reversed = qtrue;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 1
ASGNI4
line 215
;215:		}
LABELV $179
line 217
;216:
;217:		token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20060
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20060
INDIRP4
ASGNP4
line 218
;218:		if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $181
line 219
;219:			break;
ADDRGP4 $167
JUMPV
LABELV $181
line 221
;220:		}
;221:		animations[i].loopFrames = atoi( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20064
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 20064
INDIRI4
ASGNI4
line 223
;222:
;223:		token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20068
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20068
INDIRP4
ASGNP4
line 224
;224:		if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $183
line 225
;225:			break;
ADDRGP4 $167
JUMPV
LABELV $183
line 227
;226:		}
;227:		fps = atof( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20072
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 20072
INDIRF4
ASGNF4
line 228
;228:		if ( fps == 0 ) {
ADDRLP4 16
INDIRF4
CNSTF4 0
NEF4 $185
line 229
;229:			fps = 1;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
line 230
;230:		}
LABELV $185
line 231
;231:		animations[i].frameLerp = 1000 / fps;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 12
ADDP4
CNSTF4 1148846080
ADDRLP4 16
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 232
;232:		animations[i].initialLerp = 1000 / fps;
ADDRLP4 4
INDIRI4
CNSTI4 28
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 16
ADDP4
CNSTF4 1148846080
ADDRLP4 16
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 233
;233:	}
LABELV $166
line 178
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 31
LTI4 $165
LABELV $167
line 235
;234:
;235:	if ( i != MAX_ANIMATIONS ) {
ADDRLP4 4
INDIRI4
CNSTI4 31
EQI4 $187
line 236
;236:		CG_Printf( "Error parsing animation file: %s\n", filename );
ADDRGP4 $189
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 237
;237:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $100
JUMPV
LABELV $187
line 241
;238:	}
;239:
;240:	// crouch backward animation
;241:	memcpy(&animations[LEGS_BACKCR], &animations[LEGS_WALKCR], sizeof(animation_t));
ADDRLP4 8
INDIRP4
CNSTI4 896
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 364
ADDP4
ARGP4
CNSTU4 28
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 242
;242:	animations[LEGS_BACKCR].reversed = qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 916
ADDP4
CNSTI4 1
ASGNI4
line 244
;243:	// walk backward animation
;244:	memcpy(&animations[LEGS_BACKWALK], &animations[LEGS_WALK], sizeof(animation_t));
ADDRLP4 8
INDIRP4
CNSTI4 924
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 392
ADDP4
ARGP4
CNSTU4 28
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 245
;245:	animations[LEGS_BACKWALK].reversed = qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 944
ADDP4
CNSTI4 1
ASGNI4
line 247
;246:	// flag moving fast
;247:	animations[FLAG_RUN].firstFrame = 0;
ADDRLP4 8
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 0
ASGNI4
line 248
;248:	animations[FLAG_RUN].numFrames = 16;
ADDRLP4 8
INDIRP4
CNSTI4 956
ADDP4
CNSTI4 16
ASGNI4
line 249
;249:	animations[FLAG_RUN].loopFrames = 16;
ADDRLP4 8
INDIRP4
CNSTI4 960
ADDP4
CNSTI4 16
ASGNI4
line 250
;250:	animations[FLAG_RUN].frameLerp = 1000 / 15;
ADDRLP4 8
INDIRP4
CNSTI4 964
ADDP4
CNSTI4 66
ASGNI4
line 251
;251:	animations[FLAG_RUN].initialLerp = 1000 / 15;
ADDRLP4 8
INDIRP4
CNSTI4 968
ADDP4
CNSTI4 66
ASGNI4
line 252
;252:	animations[FLAG_RUN].reversed = qfalse;
ADDRLP4 8
INDIRP4
CNSTI4 972
ADDP4
CNSTI4 0
ASGNI4
line 254
;253:	// flag not moving or moving slowly
;254:	animations[FLAG_STAND].firstFrame = 16;
ADDRLP4 8
INDIRP4
CNSTI4 980
ADDP4
CNSTI4 16
ASGNI4
line 255
;255:	animations[FLAG_STAND].numFrames = 5;
ADDRLP4 8
INDIRP4
CNSTI4 984
ADDP4
CNSTI4 5
ASGNI4
line 256
;256:	animations[FLAG_STAND].loopFrames = 0;
ADDRLP4 8
INDIRP4
CNSTI4 988
ADDP4
CNSTI4 0
ASGNI4
line 257
;257:	animations[FLAG_STAND].frameLerp = 1000 / 20;
ADDRLP4 8
INDIRP4
CNSTI4 992
ADDP4
CNSTI4 50
ASGNI4
line 258
;258:	animations[FLAG_STAND].initialLerp = 1000 / 20;
ADDRLP4 8
INDIRP4
CNSTI4 996
ADDP4
CNSTI4 50
ASGNI4
line 259
;259:	animations[FLAG_STAND].reversed = qfalse;
ADDRLP4 8
INDIRP4
CNSTI4 1000
ADDP4
CNSTI4 0
ASGNI4
line 261
;260:	// flag speeding up
;261:	animations[FLAG_STAND2RUN].firstFrame = 16;
ADDRLP4 8
INDIRP4
CNSTI4 1008
ADDP4
CNSTI4 16
ASGNI4
line 262
;262:	animations[FLAG_STAND2RUN].numFrames = 5;
ADDRLP4 8
INDIRP4
CNSTI4 1012
ADDP4
CNSTI4 5
ASGNI4
line 263
;263:	animations[FLAG_STAND2RUN].loopFrames = 1;
ADDRLP4 8
INDIRP4
CNSTI4 1016
ADDP4
CNSTI4 1
ASGNI4
line 264
;264:	animations[FLAG_STAND2RUN].frameLerp = 1000 / 15;
ADDRLP4 8
INDIRP4
CNSTI4 1020
ADDP4
CNSTI4 66
ASGNI4
line 265
;265:	animations[FLAG_STAND2RUN].initialLerp = 1000 / 15;
ADDRLP4 8
INDIRP4
CNSTI4 1024
ADDP4
CNSTI4 66
ASGNI4
line 266
;266:	animations[FLAG_STAND2RUN].reversed = qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 1028
ADDP4
CNSTI4 1
ASGNI4
line 276
;267:	//
;268:	// new anims changes
;269:	//
;270://	animations[TORSO_GETFLAG].flipflop = qtrue;
;271://	animations[TORSO_GUARDBASE].flipflop = qtrue;
;272://	animations[TORSO_PATROL].flipflop = qtrue;
;273://	animations[TORSO_AFFIRMATIVE].flipflop = qtrue;
;274://	animations[TORSO_NEGATIVE].flipflop = qtrue;
;275:	//
;276:	return qtrue;
CNSTI4 1
RETI4
LABELV $100
endproc CG_ParseAnimationFile 20076 12
proc CG_FileExists 12 12
line 285
;277:}
;278:
;279:
;280:/*
;281:==========================
;282:CG_FileExists
;283:==========================
;284:*/
;285:static qboolean	CG_FileExists( const char *filename ) {
line 289
;286:	int len;
;287:	fileHandle_t	f;
;288:
;289:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 291
;290:
;291:	if ( f != FS_INVALID_HANDLE ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $191
line 292
;292:		trap_FS_FCloseFile( f );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 293
;293:	}
LABELV $191
line 295
;294:
;295:	if ( len > 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LEI4 $193
line 296
;296:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $190
JUMPV
LABELV $193
line 299
;297:	}
;298:
;299:	return qfalse;
CNSTI4 0
RETI4
LABELV $190
endproc CG_FileExists 12 12
proc CG_FindClientModelFile 44 40
line 308
;300:}
;301:
;302:
;303:/*
;304:==========================
;305:CG_FindClientModelFile
;306:==========================
;307:*/
;308:static qboolean	CG_FindClientModelFile( char *filename, int length, clientInfo_t *ci, const char *teamName, const char *modelName, const char *skinName, const char *base, const char *ext ) {
line 312
;309:	char *team, *charactersFolder;
;310:	int i;
;311:
;312:	if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $196
line 313
;313:		switch ( ci->team ) {
ADDRLP4 12
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $202
ADDRGP4 $199
JUMPV
LABELV $202
line 314
;314:			case TEAM_BLUE: {
line 315
;315:				team = "blue";
ADDRLP4 8
ADDRGP4 $203
ASGNP4
line 316
;316:				break;
ADDRGP4 $197
JUMPV
LABELV $199
line 318
;317:			}
;318:			default: {
line 319
;319:				team = "red";
ADDRLP4 8
ADDRGP4 $204
ASGNP4
line 320
;320:				break;
line 323
;321:			}
;322:		}
;323:	}
ADDRGP4 $197
JUMPV
LABELV $196
line 324
;324:	else {
line 325
;325:		team = "default";
ADDRLP4 8
ADDRGP4 $120
ASGNP4
line 326
;326:	}
LABELV $197
line 329
;327:
;328:	// colored skins
;329:	if ( ci->coloredSkin && !Q_stricmp( ci->skinName, PM_SKIN ) ) {
ADDRLP4 12
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 1612
ADDP4
INDIRI4
CNSTI4 0
EQI4 $205
ADDRLP4 12
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 $207
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $205
line 330
;330:		team = PM_SKIN;
ADDRLP4 8
ADDRGP4 $207
ASGNP4
line 331
;331:	}
LABELV $205
line 332
;332:	if ( ci->coloredSkin && !Q_stricmp( ci->skinName, FB_SKIN ) ) {
ADDRLP4 20
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 1612
ADDP4
INDIRI4
CNSTI4 0
EQI4 $208
ADDRLP4 20
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $208
line 333
;333:		team = FB_SKIN;
ADDRLP4 8
ADDRGP4 $210
ASGNP4
line 334
;334:	}
LABELV $208
line 336
;335:
;336:	charactersFolder = "";
ADDRLP4 4
ADDRGP4 $211
ASGNP4
ADDRGP4 $213
JUMPV
LABELV $212
line 337
;337:	while(1) {
line 338
;338:		for ( i = 0; i < 2; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $215
line 339
;339:			if ( i == 0 && teamName && *teamName ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $219
ADDRLP4 28
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $219
ADDRLP4 28
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $219
line 341
;340:				//								"models/players/characters/james/stroggs/lower_lily_red.skin"
;341:				Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s_%s.%s", charactersFolder, modelName, teamName, base, skinName, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $221
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 342
;342:			}
ADDRGP4 $220
JUMPV
LABELV $219
line 343
;343:			else {
line 345
;344:				//								"models/players/characters/james/lower_lily_red.skin"
;345:				Com_sprintf( filename, length, "models/players/%s%s/%s_%s_%s.%s", charactersFolder, modelName, base, skinName, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $222
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 346
;346:			}
LABELV $220
line 347
;347:			if ( CG_FileExists( filename ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $223
line 348
;348:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $195
JUMPV
LABELV $223
line 350
;349:			}
;350:			if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $225
line 351
;351:				if ( i == 0 && teamName && *teamName ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $228
ADDRLP4 36
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $228
ADDRLP4 36
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $228
line 353
;352:					//								"models/players/characters/james/stroggs/lower_red.skin"
;353:					Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s.%s", charactersFolder, modelName, teamName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $230
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 354
;354:				}
ADDRGP4 $226
JUMPV
LABELV $228
line 355
;355:				else {
line 357
;356:					//								"models/players/characters/james/lower_red.skin"
;357:					Com_sprintf( filename, length, "models/players/%s%s/%s_%s.%s", charactersFolder, modelName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $231
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 358
;358:				}
line 359
;359:			}
ADDRGP4 $226
JUMPV
LABELV $225
line 360
;360:			else {
line 361
;361:				if ( i == 0 && teamName && *teamName ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $232
ADDRLP4 36
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $232
ADDRLP4 36
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $232
line 363
;362:					//								"models/players/characters/james/stroggs/lower_lily.skin"
;363:					Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s.%s", charactersFolder, modelName, teamName, base, skinName, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $230
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 364
;364:				}
ADDRGP4 $233
JUMPV
LABELV $232
line 365
;365:				else {
line 367
;366:					//								"models/players/characters/james/lower_lily.skin"
;367:					Com_sprintf( filename, length, "models/players/%s%s/%s_%s.%s", charactersFolder, modelName, base, skinName, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $231
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 368
;368:				}
LABELV $233
line 369
;369:			}
LABELV $226
line 370
;370:			if ( CG_FileExists( filename ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $234
line 371
;371:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $195
JUMPV
LABELV $234
line 373
;372:			}
;373:			if ( !teamName || !*teamName ) {
ADDRLP4 40
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $238
ADDRLP4 40
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $236
LABELV $238
line 374
;374:				break;
ADDRGP4 $217
JUMPV
LABELV $236
line 376
;375:			}
;376:		}
LABELV $216
line 338
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $215
LABELV $217
line 378
;377:		// if tried the heads folder first
;378:		if ( charactersFolder[0] ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $239
line 379
;379:			break;
ADDRGP4 $214
JUMPV
LABELV $239
line 381
;380:		}
;381:		charactersFolder = "characters/";
ADDRLP4 4
ADDRGP4 $241
ASGNP4
line 382
;382:	}
LABELV $213
line 337
ADDRGP4 $212
JUMPV
LABELV $214
line 384
;383:
;384:	return qfalse;
CNSTI4 0
RETI4
LABELV $195
endproc CG_FindClientModelFile 44 40
proc CG_FindClientHeadFile 44 40
line 393
;385:}
;386:
;387:
;388:/*
;389:==========================
;390:CG_FindClientHeadFile
;391:==========================
;392:*/
;393:static qboolean	CG_FindClientHeadFile( char *filename, int length, clientInfo_t *ci, const char *teamName, const char *headModelName, const char *headSkinName, const char *base, const char *ext ) {
line 397
;394:	char *team, *headsFolder;
;395:	int i;
;396:
;397:	if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $243
line 398
;398:		switch ( ci->team ) {
ADDRLP4 12
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 1
EQI4 $249
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $250
ADDRGP4 $246
JUMPV
LABELV $249
line 399
;399:			case TEAM_RED: {
line 400
;400:				team = "red";
ADDRLP4 8
ADDRGP4 $204
ASGNP4
line 401
;401:				break;
ADDRGP4 $244
JUMPV
LABELV $250
line 403
;402:			}
;403:			case TEAM_BLUE: {
line 404
;404:				team = "blue";
ADDRLP4 8
ADDRGP4 $203
ASGNP4
line 405
;405:				break;
ADDRGP4 $244
JUMPV
LABELV $246
line 407
;406:			}
;407:			default: {
line 408
;408:				team = "default";
ADDRLP4 8
ADDRGP4 $120
ASGNP4
line 409
;409:				break;
line 412
;410:			}
;411:		}
;412:	}
ADDRGP4 $244
JUMPV
LABELV $243
line 413
;413:	else {
line 414
;414:		team = "default";
ADDRLP4 8
ADDRGP4 $120
ASGNP4
line 415
;415:	}
LABELV $244
line 418
;416:
;417:	// colored skins
;418:	if ( ci->coloredSkin && !Q_stricmp( ci->headSkinName, PM_SKIN ) ) {
ADDRLP4 12
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 1612
ADDP4
INDIRI4
CNSTI4 0
EQI4 $251
ADDRLP4 12
INDIRP4
CNSTI4 320
ADDP4
ARGP4
ADDRGP4 $207
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $251
line 419
;419:		team = PM_SKIN;
ADDRLP4 8
ADDRGP4 $207
ASGNP4
line 420
;420:	}
LABELV $251
line 421
;421:	if ( ci->coloredSkin && !Q_stricmp( ci->headSkinName, FB_SKIN ) ) {
ADDRLP4 20
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 1612
ADDP4
INDIRI4
CNSTI4 0
EQI4 $253
ADDRLP4 20
INDIRP4
CNSTI4 320
ADDP4
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $253
line 422
;422:		team = FB_SKIN;
ADDRLP4 8
ADDRGP4 $210
ASGNP4
line 423
;423:	}
LABELV $253
line 425
;424:
;425:	if ( headModelName[0] == '*' ) {
ADDRFP4 16
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $255
line 426
;426:		headsFolder = "heads/";
ADDRLP4 4
ADDRGP4 $257
ASGNP4
line 427
;427:		headModelName++;
ADDRFP4 16
ADDRFP4 16
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 428
;428:	}
ADDRGP4 $259
JUMPV
LABELV $255
line 429
;429:	else {
line 430
;430:		headsFolder = "";
ADDRLP4 4
ADDRGP4 $211
ASGNP4
line 431
;431:	}
ADDRGP4 $259
JUMPV
LABELV $258
line 432
;432:	while(1) {
line 433
;433:		for ( i = 0; i < 2; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $261
line 434
;434:			if ( i == 0 && teamName && *teamName ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $265
ADDRLP4 28
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $265
ADDRLP4 28
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $265
line 435
;435:				Com_sprintf( filename, length, "models/players/%s%s/%s/%s%s_%s.%s", headsFolder, headModelName, headSkinName, teamName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $267
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 436
;436:			}
ADDRGP4 $266
JUMPV
LABELV $265
line 437
;437:			else {
line 438
;438:				Com_sprintf( filename, length, "models/players/%s%s/%s/%s_%s.%s", headsFolder, headModelName, headSkinName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $268
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 439
;439:			}
LABELV $266
line 440
;440:			if ( CG_FileExists( filename ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $269
line 441
;441:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $242
JUMPV
LABELV $269
line 443
;442:			}
;443:			if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $271
line 444
;444:				if ( i == 0 &&  teamName && *teamName ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $274
ADDRLP4 36
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $274
ADDRLP4 36
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $274
line 445
;445:					Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s.%s", headsFolder, headModelName, teamName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $230
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 446
;446:				}
ADDRGP4 $272
JUMPV
LABELV $274
line 447
;447:				else {
line 448
;448:					Com_sprintf( filename, length, "models/players/%s%s/%s_%s.%s", headsFolder, headModelName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $231
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 449
;449:				}
line 450
;450:			}
ADDRGP4 $272
JUMPV
LABELV $271
line 451
;451:			else {
line 452
;452:				if ( i == 0 && teamName && *teamName ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $276
ADDRLP4 36
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $276
ADDRLP4 36
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $276
line 453
;453:					Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s.%s", headsFolder, headModelName, teamName, base, headSkinName, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $230
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 454
;454:				}
ADDRGP4 $277
JUMPV
LABELV $276
line 455
;455:				else {
line 456
;456:					Com_sprintf( filename, length, "models/players/%s%s/%s_%s.%s", headsFolder, headModelName, base, headSkinName, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $231
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 457
;457:				}
LABELV $277
line 458
;458:			}
LABELV $272
line 459
;459:			if ( CG_FileExists( filename ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $278
line 460
;460:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $242
JUMPV
LABELV $278
line 462
;461:			}
;462:			if ( !teamName || !*teamName ) {
ADDRLP4 40
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $282
ADDRLP4 40
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $280
LABELV $282
line 463
;463:				break;
ADDRGP4 $263
JUMPV
LABELV $280
line 465
;464:			}
;465:		}
LABELV $262
line 433
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $261
LABELV $263
line 467
;466:		// if tried the heads folder first
;467:		if ( headsFolder[0] ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $283
line 468
;468:			break;
ADDRGP4 $260
JUMPV
LABELV $283
line 470
;469:		}
;470:		headsFolder = "heads/";
ADDRLP4 4
ADDRGP4 $257
ASGNP4
line 471
;471:	}
LABELV $259
line 432
ADDRGP4 $258
JUMPV
LABELV $260
line 473
;472:
;473:	return qfalse;
CNSTI4 0
RETI4
LABELV $242
endproc CG_FindClientHeadFile 44 40
proc CG_RegisterClientSkin 80 32
line 482
;474:}
;475:
;476:
;477:/*
;478:==========================
;479:CG_RegisterClientSkin
;480:==========================
;481:*/
;482:static qboolean	CG_RegisterClientSkin( clientInfo_t *ci, const char *teamName, const char *modelName, const char *skinName, const char *headModelName, const char *headSkinName ) {
line 507
;483:	char filename[MAX_QPATH];
;484:
;485:	/*
;486:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/%slower_%s.skin", modelName, teamName, skinName );
;487:	ci->legsSkin = trap_R_RegisterSkin( filename );
;488:	if (!ci->legsSkin) {
;489:		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/%slower_%s.skin", modelName, teamName, skinName );
;490:		ci->legsSkin = trap_R_RegisterSkin( filename );
;491:		if (!ci->legsSkin) {
;492:			Com_Printf( "Leg skin load failure: %s\n", filename );
;493:		}
;494:	}
;495:
;496:
;497:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/%supper_%s.skin", modelName, teamName, skinName );
;498:	ci->torsoSkin = trap_R_RegisterSkin( filename );
;499:	if (!ci->torsoSkin) {
;500:		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/%supper_%s.skin", modelName, teamName, skinName );
;501:		ci->torsoSkin = trap_R_RegisterSkin( filename );
;502:		if (!ci->torsoSkin) {
;503:			Com_Printf( "Torso skin load failure: %s\n", filename );
;504:		}
;505:	}
;506:	*/
;507:	if ( CG_FindClientModelFile( filename, sizeof(filename), ci, teamName, modelName, skinName, "lower", "skin" ) ) {
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRP4
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
ADDRGP4 $288
ARGP4
ADDRGP4 $289
ARGP4
ADDRLP4 64
ADDRGP4 CG_FindClientModelFile
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $286
line 508
;508:		ci->legsSkin = trap_R_RegisterSkin( filename );
ADDRLP4 0
ARGP4
ADDRLP4 68
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ADDRLP4 68
INDIRI4
ASGNI4
line 509
;509:	}
LABELV $286
line 510
;510:	if (!ci->legsSkin) {
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 0
NEI4 $290
line 511
;511:		Com_Printf( "Leg skin load failure: %s\n", filename );
ADDRGP4 $292
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 512
;512:	}
LABELV $290
line 514
;513:
;514:	if ( CG_FindClientModelFile( filename, sizeof(filename), ci, teamName, modelName, skinName, "upper", "skin" ) ) {
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRP4
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
ADDRGP4 $295
ARGP4
ADDRGP4 $289
ARGP4
ADDRLP4 68
ADDRGP4 CG_FindClientModelFile
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $293
line 515
;515:		ci->torsoSkin = trap_R_RegisterSkin( filename );
ADDRLP4 0
ARGP4
ADDRLP4 72
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 432
ADDP4
ADDRLP4 72
INDIRI4
ASGNI4
line 516
;516:	}
LABELV $293
line 517
;517:	if (!ci->torsoSkin) {
ADDRFP4 0
INDIRP4
CNSTI4 432
ADDP4
INDIRI4
CNSTI4 0
NEI4 $296
line 518
;518:		Com_Printf( "Torso skin load failure: %s\n", filename );
ADDRGP4 $298
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 519
;519:	}
LABELV $296
line 521
;520:
;521:	if ( CG_FindClientHeadFile( filename, sizeof(filename), ci, teamName, headModelName, headSkinName, "head", "skin" ) ) {
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRGP4 $301
ARGP4
ADDRGP4 $289
ARGP4
ADDRLP4 72
ADDRGP4 CG_FindClientHeadFile
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
EQI4 $299
line 522
;522:		ci->headSkin = trap_R_RegisterSkin( filename );
ADDRLP4 0
ARGP4
ADDRLP4 76
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 440
ADDP4
ADDRLP4 76
INDIRI4
ASGNI4
line 523
;523:	}
LABELV $299
line 524
;524:	if (!ci->headSkin) {
ADDRFP4 0
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
CNSTI4 0
NEI4 $302
line 525
;525:		Com_Printf( "Head skin load failure: %s\n", filename );
ADDRGP4 $304
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 526
;526:	}
LABELV $302
line 529
;527:
;528:	// if any skins failed to load
;529:	if ( !ci->legsSkin || !ci->torsoSkin || !ci->headSkin ) {
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 0
EQI4 $308
ADDRLP4 76
INDIRP4
CNSTI4 432
ADDP4
INDIRI4
CNSTI4 0
EQI4 $308
ADDRLP4 76
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
CNSTI4 0
NEI4 $305
LABELV $308
line 530
;530:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $285
JUMPV
LABELV $305
line 532
;531:	}
;532:	return qtrue;
CNSTI4 1
RETI4
LABELV $285
endproc CG_RegisterClientSkin 80 32
proc CG_RegisterClientModelname 164 32
line 541
;533:}
;534:
;535:
;536:/*
;537:==========================
;538:CG_RegisterClientModelname
;539:==========================
;540:*/
;541:static qboolean CG_RegisterClientModelname( clientInfo_t *ci, const char *modelName, const char *skinName, const char *headModelName, const char *headSkinName, const char *teamName ) {
line 546
;542:	char	filename[MAX_QPATH];
;543:	const char		*headName;
;544:	char newTeamName[MAX_QPATH];
;545:
;546:	if ( headModelName[0] == '\0' ) {
ADDRFP4 12
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $310
line 547
;547:		headName = modelName;
ADDRLP4 64
ADDRFP4 4
INDIRP4
ASGNP4
line 548
;548:	}
ADDRGP4 $311
JUMPV
LABELV $310
line 549
;549:	else {
line 550
;550:		headName = headModelName;
ADDRLP4 64
ADDRFP4 12
INDIRP4
ASGNP4
line 551
;551:	}
LABELV $311
line 552
;552:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/lower.md3", modelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $312
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 553
;553:	ci->legsModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 132
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 420
ADDP4
ADDRLP4 132
INDIRI4
ASGNI4
line 554
;554:	if ( !ci->legsModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
CNSTI4 0
NEI4 $313
line 555
;555:		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/lower.md3", modelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $315
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 556
;556:		ci->legsModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 136
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 420
ADDP4
ADDRLP4 136
INDIRI4
ASGNI4
line 557
;557:		if ( !ci->legsModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
CNSTI4 0
NEI4 $316
line 558
;558:			Com_Printf( "Failed to load model file %s\n", filename );
ADDRGP4 $318
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 559
;559:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $309
JUMPV
LABELV $316
line 561
;560:		}
;561:	}
LABELV $313
line 563
;562:
;563:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/upper.md3", modelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $319
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 564
;564:	ci->torsoModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 136
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
ADDRLP4 136
INDIRI4
ASGNI4
line 565
;565:	if ( !ci->torsoModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
CNSTI4 0
NEI4 $320
line 566
;566:		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/upper.md3", modelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $322
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 567
;567:		ci->torsoModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 140
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
ADDRLP4 140
INDIRI4
ASGNI4
line 568
;568:		if ( !ci->torsoModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
CNSTI4 0
NEI4 $323
line 569
;569:			Com_Printf( "Failed to load model file %s\n", filename );
ADDRGP4 $318
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 570
;570:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $309
JUMPV
LABELV $323
line 572
;571:		}
;572:	}
LABELV $320
line 574
;573:
;574:	if( headName[0] == '*' ) {
ADDRLP4 64
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $325
line 575
;575:		Com_sprintf( filename, sizeof( filename ), "models/players/heads/%s/%s.md3", &headModelName[1], &headModelName[1] );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $327
ARGP4
ADDRLP4 140
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 140
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 576
;576:	}
ADDRGP4 $326
JUMPV
LABELV $325
line 577
;577:	else {
line 578
;578:		Com_sprintf( filename, sizeof( filename ), "models/players/%s/head.md3", headName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $328
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 579
;579:	}
LABELV $326
line 580
;580:	ci->headModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 140
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 140
INDIRI4
ASGNI4
line 582
;581:	// if the head model could not be found and we didn't load from the heads folder try to load from there
;582:	if ( !ci->headModel && headName[0] != '*' ) {
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
CNSTI4 0
NEI4 $329
ADDRLP4 64
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
EQI4 $329
line 583
;583:		Com_sprintf( filename, sizeof( filename ), "models/players/heads/%s/%s.md3", headModelName, headModelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $327
ARGP4
ADDRLP4 144
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
ARGP4
ADDRLP4 144
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 584
;584:		ci->headModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 148
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 148
INDIRI4
ASGNI4
line 585
;585:	}
LABELV $329
line 586
;586:	if ( !ci->headModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
CNSTI4 0
NEI4 $331
line 587
;587:		Com_Printf( "Failed to load model file %s\n", filename );
ADDRGP4 $318
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 588
;588:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $309
JUMPV
LABELV $331
line 592
;589:	}
;590:
;591:	// if any skins failed to load, return failure
;592:	if ( !CG_RegisterClientSkin( ci, teamName, modelName, skinName, headName, headSkinName ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 CG_RegisterClientSkin
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $333
line 593
;593:		if ( teamName && *teamName) {
ADDRLP4 148
ADDRFP4 20
INDIRP4
ASGNP4
ADDRLP4 148
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $335
ADDRLP4 148
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $335
line 594
;594:			Com_Printf( "Failed to load skin file: %s : %s : %s, %s : %s\n", teamName, modelName, skinName, headName, headSkinName );
ADDRGP4 $337
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 595
;595:			if( ci->team == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 2
NEI4 $338
line 596
;596:				Com_sprintf(newTeamName, sizeof(newTeamName), "%s/", DEFAULT_BLUETEAM_NAME);
ADDRLP4 68
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $340
ARGP4
ADDRGP4 $341
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 597
;597:			}
ADDRGP4 $339
JUMPV
LABELV $338
line 598
;598:			else {
line 599
;599:				Com_sprintf(newTeamName, sizeof(newTeamName), "%s/", DEFAULT_REDTEAM_NAME);
ADDRLP4 68
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $340
ARGP4
ADDRGP4 $342
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 600
;600:			}
LABELV $339
line 601
;601:			if ( !CG_RegisterClientSkin( ci, newTeamName, modelName, skinName, headName, headSkinName ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 152
ADDRGP4 CG_RegisterClientSkin
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $336
line 602
;602:				Com_Printf( "Failed to load skin file: %s : %s : %s, %s : %s\n", newTeamName, modelName, skinName, headName, headSkinName );
ADDRGP4 $337
ARGP4
ADDRLP4 68
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 603
;603:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $309
JUMPV
line 605
;604:			}
;605:		} else {
LABELV $335
line 606
;606:			Com_Printf( "Failed to load skin file: %s : %s, %s : %s\n", modelName, skinName, headName, headSkinName );
ADDRGP4 $345
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 607
;607:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $309
JUMPV
LABELV $336
line 609
;608:		}
;609:	}
LABELV $333
line 612
;610:
;611:	// load the animations
;612:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/animation.cfg", modelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $346
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 613
;613:	if ( !CG_ParseAnimationFile( filename, ci ) ) {
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 CG_ParseAnimationFile
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $347
line 614
;614:		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/animation.cfg", modelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $349
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 615
;615:		if ( !CG_ParseAnimationFile( filename, ci ) ) {
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 152
ADDRGP4 CG_ParseAnimationFile
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $350
line 616
;616:			Com_Printf( "Failed to load animation file %s\n", filename );
ADDRGP4 $352
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 617
;617:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $309
JUMPV
LABELV $350
line 619
;618:		}
;619:	}
LABELV $347
line 621
;620:
;621:	if ( CG_FindClientHeadFile( filename, sizeof(filename), ci, teamName, headName, headSkinName, "icon", "skin" ) ) {
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 $355
ARGP4
ADDRGP4 $289
ARGP4
ADDRLP4 152
ADDRGP4 CG_FindClientHeadFile
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $353
line 622
;622:		ci->modelIcon = trap_R_RegisterShaderNoMip( filename );
ADDRLP4 0
ARGP4
ADDRLP4 156
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
ADDRLP4 156
INDIRI4
ASGNI4
line 623
;623:	}
ADDRGP4 $354
JUMPV
LABELV $353
line 624
;624:	else if ( CG_FindClientHeadFile( filename, sizeof(filename), ci, teamName, headName, headSkinName, "icon", "tga" ) ) {
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 $355
ARGP4
ADDRGP4 $358
ARGP4
ADDRLP4 156
ADDRGP4 CG_FindClientHeadFile
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $356
line 625
;625:		ci->modelIcon = trap_R_RegisterShaderNoMip( filename );
ADDRLP4 0
ARGP4
ADDRLP4 160
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
ADDRLP4 160
INDIRI4
ASGNI4
line 626
;626:	}
LABELV $356
LABELV $354
line 628
;627:
;628:	if ( !ci->modelIcon ) {
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
CNSTI4 0
NEI4 $359
line 629
;629:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $309
JUMPV
LABELV $359
line 632
;630:	}
;631:
;632:	return qtrue;
CNSTI4 1
RETI4
LABELV $309
endproc CG_RegisterClientModelname 164 32
proc CG_IsKnownModel 92 8
line 637
;633:}
;634:
;635:
;636:/* advance this function on any new pm skin added */
;637:static qboolean CG_IsKnownModel( const char *modelName ) {
line 639
;638:
;639:	if ( Q_stricmp(modelName, "anarki") &&
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $364
ARGP4
ADDRLP4 0
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $365
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $366
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $367
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $368
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $369
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $370
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $371
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $372
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $373
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $374
ARGP4
ADDRLP4 40
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $375
ARGP4
ADDRLP4 44
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $376
ARGP4
ADDRLP4 48
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $377
ARGP4
ADDRLP4 52
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $378
ARGP4
ADDRLP4 56
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $379
ARGP4
ADDRLP4 60
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $380
ARGP4
ADDRLP4 64
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $381
ARGP4
ADDRLP4 68
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $382
ARGP4
ADDRLP4 72
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $383
ARGP4
ADDRLP4 76
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $384
ARGP4
ADDRLP4 80
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $385
ARGP4
ADDRLP4 84
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $362
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $386
ARGP4
ADDRLP4 88
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $362
line 662
;640:		 Q_stricmp(modelName, "biker") &&
;641:		 Q_stricmp(modelName, "bitterman") &&
;642:		 Q_stricmp(modelName, "bones") &&
;643:		 Q_stricmp(modelName, "crash") &&
;644:		 Q_stricmp(modelName, "doom") &&
;645:		 Q_stricmp(modelName, "grunt") &&
;646:		 Q_stricmp(modelName, "hunter") &&
;647:		 Q_stricmp(modelName, "keel") &&
;648:		 Q_stricmp(modelName, "klesk") &&
;649:		 Q_stricmp(modelName, "lucy") &&
;650:		 Q_stricmp(modelName, "major") &&
;651:		 Q_stricmp(modelName, "mynx") &&
;652:		 Q_stricmp(modelName, "orbb") &&
;653:		 Q_stricmp(modelName, "ranger") &&
;654:		 Q_stricmp(modelName, "razor") &&
;655:		 Q_stricmp(modelName, "sarge") &&
;656:		 Q_stricmp(modelName, "slash") &&
;657:		 Q_stricmp(modelName, "sorlag") &&
;658:		 Q_stricmp(modelName, "tankjr") &&
;659:		 Q_stricmp(modelName, "uriel") &&
;660:		 Q_stricmp(modelName, "visor") &&
;661:		 Q_stricmp(modelName, "xaero") )
;662:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $361
JUMPV
LABELV $362
line 664
;663:	else
;664:		return qtrue;
CNSTI4 1
RETI4
LABELV $361
endproc CG_IsKnownModel 92 8
proc CG_ColorFromChar 8 0
ADDRFP4 0
ADDRFP4 0
INDIRI4
CVII1 4
ASGNI1
line 673
;665:}
;666:
;667:
;668:/*
;669:====================
;670:CG_ColorFromString
;671:====================
;672:*/
;673:static void CG_ColorFromChar( char v, vec3_t color ) {
line 676
;674:	int val;
;675:
;676:	val = v - '0';
ADDRLP4 0
ADDRFP4 0
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
ASGNI4
line 678
;677:
;678:	if ( val < 1 || val > 7 ) {
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $390
ADDRLP4 0
INDIRI4
CNSTI4 7
LEI4 $388
LABELV $390
line 679
;679:		VectorSet( color, 1.0f, 1.0f, 1.0f );
ADDRFP4 4
INDIRP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1065353216
ASGNF4
line 680
;680:	} else {
ADDRGP4 $389
JUMPV
LABELV $388
line 681
;681:		VectorClear( color );
ADDRFP4 4
INDIRP4
CNSTF4 0
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
line 682
;682:		if ( val & 1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $391
line 683
;683:			color[0] = 1.0f;
ADDRFP4 4
INDIRP4
CNSTF4 1065353216
ASGNF4
line 684
;684:		}
LABELV $391
line 685
;685:		if ( val & 2 ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $393
line 686
;686:			color[1] = 1.0f;
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1065353216
ASGNF4
line 687
;687:		}
LABELV $393
line 688
;688:		if ( val & 4 ) {
ADDRLP4 0
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $395
line 689
;689:			color[2] = 1.0f;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1065353216
ASGNF4
line 690
;690:		}
LABELV $395
line 691
;691:	}
LABELV $389
line 692
;692:}
LABELV $387
endproc CG_ColorFromChar 8 0
proc CG_SetColorInfo 0 8
line 696
;693:
;694:
;695:static void CG_SetColorInfo( const char *color, clientInfo_t *info ) 
;696:{
line 697
;697:	VectorSet ( info->headColor, 1.0f, 1.0f, 1.0f );
ADDRFP4 4
INDIRP4
CNSTI4 1616
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 1620
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 1624
ADDP4
CNSTF4 1065353216
ASGNF4
line 698
;698:	VectorSet ( info->bodyColor, 1.0f, 1.0f, 1.0f );
ADDRFP4 4
INDIRP4
CNSTI4 1628
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 1632
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 1636
ADDP4
CNSTF4 1065353216
ASGNF4
line 699
;699:	VectorSet ( info->legsColor, 1.0f, 1.0f, 1.0f );
ADDRFP4 4
INDIRP4
CNSTI4 1640
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 1644
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 1648
ADDP4
CNSTF4 1065353216
ASGNF4
line 701
;700:	
;701:	if ( !color[0] )
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $398
line 702
;702:		return;
ADDRGP4 $397
JUMPV
LABELV $398
line 703
;703:	CG_ColorFromChar( color[0], info->headColor );
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 1616
ADDP4
ARGP4
ADDRGP4 CG_ColorFromChar
CALLV
pop
line 705
;704:	
;705:	if ( !color[1] )
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $400
line 706
;706:		return;
ADDRGP4 $397
JUMPV
LABELV $400
line 707
;707:	CG_ColorFromChar( color[1], info->bodyColor );
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 1628
ADDP4
ARGP4
ADDRGP4 CG_ColorFromChar
CALLV
pop
line 709
;708:
;709:	if ( !color[2] )
ADDRFP4 0
INDIRP4
CNSTI4 2
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $402
line 710
;710:		return;
ADDRGP4 $397
JUMPV
LABELV $402
line 711
;711:	CG_ColorFromChar( color[2], info->legsColor );
ADDRFP4 0
INDIRP4
CNSTI4 2
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 1640
ADDP4
ARGP4
ADDRGP4 CG_ColorFromChar
CALLV
pop
line 714
;712:
;713:	// override color1/color2 if specified
;714:	if ( !color[3] )
ADDRFP4 0
INDIRP4
CNSTI4 3
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $404
line 715
;715:		return;
ADDRGP4 $397
JUMPV
LABELV $404
line 716
;716:	CG_ColorFromChar( color[3], info->color1 );
ADDRFP4 0
INDIRP4
CNSTI4 3
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
ARGP4
ADDRGP4 CG_ColorFromChar
CALLV
pop
line 718
;717:
;718:	if ( !color[4] )
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $406
line 719
;719:		return;
ADDRGP4 $397
JUMPV
LABELV $406
line 720
;720:	CG_ColorFromChar( color[4], info->color2 );
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 56
ADDP4
ARGP4
ADDRGP4 CG_ColorFromChar
CALLV
pop
line 721
;721:}
LABELV $397
endproc CG_SetColorInfo 0 8
bss
align 1
LABELV $409
skip 6
code
proc CG_GetTeamColors 8 12
line 724
;722:
;723:
;724:static const char *CG_GetTeamColors( const char *color, team_t team ) {
line 727
;725:	static char str[6];
;726:
;727:	Q_strncpyz( str, color, sizeof( str ) );
ADDRGP4 $409
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 6
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 729
;728:
;729:	switch ( team ) {
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $415
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $413
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $414
ADDRGP4 $411
JUMPV
LABELV $413
line 730
;730:		case TEAM_RED:  replace1( '?', '1', str ); break;
CNSTI4 63
ARGI4
CNSTI4 49
ARGI4
ADDRGP4 $409
ARGP4
ADDRGP4 replace1
CALLI4
pop
ADDRGP4 $411
JUMPV
LABELV $414
line 731
;731:		case TEAM_BLUE: replace1( '?', '4', str ); break;
CNSTI4 63
ARGI4
CNSTI4 52
ARGI4
ADDRGP4 $409
ARGP4
ADDRGP4 replace1
CALLI4
pop
ADDRGP4 $411
JUMPV
LABELV $415
line 732
;732:		case TEAM_FREE: replace1( '?', '7', str ); break;
CNSTI4 63
ARGI4
CNSTI4 55
ARGI4
ADDRGP4 $409
ARGP4
ADDRGP4 replace1
CALLI4
pop
line 733
;733:		default: break;
LABELV $411
line 736
;734:    }
;735:
;736:	return str;
ADDRGP4 $409
RETP4
LABELV $408
endproc CG_GetTeamColors 8 12
proc CG_LoadClientInfo 404 24
line 748
;737:}
;738:
;739:
;740:/*
;741:===================
;742:CG_LoadClientInfo
;743:
;744:Load it now, taking the disk hits.
;745:This will usually be deferred to a safe time
;746:===================
;747:*/
;748:static void CG_LoadClientInfo( clientInfo_t *ci ) {
line 756
;749:	const char	*dir;
;750:	int			i, modelloaded;
;751:	const char	*s;
;752:	int			clientNum;
;753:	char		teamname[MAX_QPATH];
;754:	char		vertexlit[MAX_CVAR_VALUE_STRING];
;755:
;756:	teamname[0] = '\0';
ADDRLP4 276
CNSTI1 0
ASGNI1
line 759
;757:
;758:	// disable vertexlight for colored skins
;759:	trap_Cvar_VariableStringBuffer( "r_vertexlight", vertexlit, sizeof( vertexlit ) );
ADDRGP4 $417
ARGP4
ADDRLP4 16
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 760
;760:	if ( vertexlit[0] && vertexlit[0] != '0' ) {
ADDRLP4 340
ADDRLP4 16
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 340
INDIRI4
CNSTI4 0
EQI4 $418
ADDRLP4 340
INDIRI4
CNSTI4 48
EQI4 $418
line 761
;761:		trap_Cvar_Set( "r_vertexlight", "0" );
ADDRGP4 $417
ARGP4
ADDRGP4 $420
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 762
;762:	}
LABELV $418
line 765
;763:
;764:#ifdef MISSIONPACK
;765:	if( cgs.gametype >= GT_TEAM) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $421
line 766
;766:		if( ci->team == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 2
NEI4 $424
line 767
;767:			Q_strncpyz(teamname, cg_blueTeamName.string, sizeof(teamname) );
ADDRLP4 276
ARGP4
ADDRGP4 cg_blueTeamName+16
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 768
;768:		} else {
ADDRGP4 $425
JUMPV
LABELV $424
line 769
;769:			Q_strncpyz(teamname, cg_redTeamName.string, sizeof(teamname) );
ADDRLP4 276
ARGP4
ADDRGP4 cg_redTeamName+16
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 770
;770:		}
LABELV $425
line 771
;771:	}
LABELV $421
line 772
;772:	if( teamname[0] ) {
ADDRLP4 276
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $428
line 773
;773:		strcat( teamname, "/" );
ADDRLP4 276
ARGP4
ADDRGP4 $430
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 774
;774:	}
LABELV $428
line 776
;775:#endif
;776:	modelloaded = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 777
;777:	if ( !CG_RegisterClientModelname( ci, ci->modelName, ci->skinName, ci->headModelName, ci->headSkinName, teamname ) ) {
ADDRLP4 344
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 344
INDIRP4
ARGP4
ADDRLP4 344
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRLP4 344
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 344
INDIRP4
CNSTI4 256
ADDP4
ARGP4
ADDRLP4 344
INDIRP4
CNSTI4 320
ADDP4
ARGP4
ADDRLP4 276
ARGP4
ADDRLP4 348
ADDRGP4 CG_RegisterClientModelname
CALLI4
ASGNI4
ADDRLP4 348
INDIRI4
CNSTI4 0
NEI4 $431
line 778
;778:		if ( cg_buildScript.integer ) {
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $433
line 779
;779:			CG_Error( "CG_RegisterClientModelname( %s, %s, %s, %s %s ) failed", ci->modelName, ci->skinName, ci->headModelName, ci->headSkinName, teamname );
ADDRGP4 $436
ARGP4
ADDRLP4 352
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 352
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRLP4 352
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 352
INDIRP4
CNSTI4 256
ADDP4
ARGP4
ADDRLP4 352
INDIRP4
CNSTI4 320
ADDP4
ARGP4
ADDRLP4 276
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 780
;780:		}
LABELV $433
line 783
;781:
;782:		// fall back to default team name
;783:		if( cgs.gametype >= GT_TEAM) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $437
line 785
;784:			// keep skin name
;785:			if( ci->team == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 2
NEI4 $440
line 786
;786:				Q_strncpyz(teamname, DEFAULT_BLUETEAM_NAME, sizeof(teamname) );
ADDRLP4 276
ARGP4
ADDRGP4 $341
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 787
;787:			} else {
ADDRGP4 $441
JUMPV
LABELV $440
line 788
;788:				Q_strncpyz(teamname, DEFAULT_REDTEAM_NAME, sizeof(teamname) );
ADDRLP4 276
ARGP4
ADDRGP4 $342
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 789
;789:			}
LABELV $441
line 790
;790:			if ( !CG_RegisterClientModelname( ci, DEFAULT_MODEL, ci->skinName, DEFAULT_MODEL, ci->skinName, teamname ) ) {
ADDRLP4 352
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 352
INDIRP4
ARGP4
ADDRLP4 356
ADDRGP4 $380
ASGNP4
ADDRLP4 356
INDIRP4
ARGP4
ADDRLP4 352
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 356
INDIRP4
ARGP4
ADDRLP4 352
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 276
ARGP4
ADDRLP4 360
ADDRGP4 CG_RegisterClientModelname
CALLI4
ASGNI4
ADDRLP4 360
INDIRI4
CNSTI4 0
NEI4 $438
line 791
;791:				CG_Error( "DEFAULT_TEAM_MODEL / skin (%s/%s) failed to register", DEFAULT_MODEL, ci->skinName );
ADDRGP4 $444
ARGP4
ADDRGP4 $380
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 792
;792:			}
line 793
;793:		} else {
ADDRGP4 $438
JUMPV
LABELV $437
line 794
;794:			if ( !CG_RegisterClientModelname( ci, DEFAULT_MODEL, "default", DEFAULT_MODEL, "default", teamname ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 352
ADDRGP4 $380
ASGNP4
ADDRLP4 352
INDIRP4
ARGP4
ADDRLP4 356
ADDRGP4 $120
ASGNP4
ADDRLP4 356
INDIRP4
ARGP4
ADDRLP4 352
INDIRP4
ARGP4
ADDRLP4 356
INDIRP4
ARGP4
ADDRLP4 276
ARGP4
ADDRLP4 360
ADDRGP4 CG_RegisterClientModelname
CALLI4
ASGNI4
ADDRLP4 360
INDIRI4
CNSTI4 0
NEI4 $445
line 795
;795:				CG_Error( "DEFAULT_MODEL (%s) failed to register", DEFAULT_MODEL );
ADDRGP4 $447
ARGP4
ADDRGP4 $380
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 796
;796:			}
LABELV $445
line 797
;797:		}
LABELV $438
line 798
;798:		modelloaded = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 799
;799:	}
LABELV $431
line 801
;800:
;801:	ci->newAnims = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 388
ADDP4
CNSTI4 0
ASGNI4
line 802
;802:	if ( ci->torsoModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
CNSTI4 0
EQI4 $448
line 805
;803:		orientation_t tag;
;804:		// if the torso model has the "tag_flag"
;805:		if ( trap_R_LerpTag( &tag, ci->torsoModel, 0, 0, 1, "tag_flag" ) ) {
ADDRLP4 352
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 $452
ARGP4
ADDRLP4 400
ADDRGP4 trap_R_LerpTag
CALLI4
ASGNI4
ADDRLP4 400
INDIRI4
CNSTI4 0
EQI4 $450
line 806
;806:			ci->newAnims = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 388
ADDP4
CNSTI4 1
ASGNI4
line 807
;807:		}
LABELV $450
line 808
;808:	}
LABELV $448
line 811
;809:
;810:	// sounds
;811:	dir = ci->modelName;
ADDRLP4 272
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ASGNP4
line 813
;812:
;813:	for ( i = 0 ; i < MAX_CUSTOM_SOUNDS ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $453
line 814
;814:		s = cg_customSoundNames[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_customSoundNames
ADDP4
INDIRP4
ASGNP4
line 815
;815:		if ( !s ) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $457
line 816
;816:			break;
ADDRGP4 $455
JUMPV
LABELV $457
line 818
;817:		}
;818:		ci->sounds[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1484
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 820
;819:		// if the model didn't load use the sounds of the default model
;820:		if (modelloaded) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $459
line 821
;821:			ci->sounds[i] = trap_S_RegisterSound( va("sound/player/%s/%s", dir, s + 1), qfalse );
ADDRGP4 $461
ARGP4
ADDRLP4 272
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 352
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 352
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 356
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1484
ADDP4
ADDP4
ADDRLP4 356
INDIRI4
ASGNI4
line 822
;822:		}
LABELV $459
line 823
;823:		if ( !ci->sounds[i] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1484
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $462
line 824
;824:			ci->sounds[i] = trap_S_RegisterSound( va("sound/player/%s/%s", DEFAULT_MODEL, s + 1), qfalse );
ADDRGP4 $461
ARGP4
ADDRGP4 $380
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 352
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 352
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 356
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1484
ADDP4
ADDP4
ADDRLP4 356
INDIRI4
ASGNI4
line 825
;825:		}
LABELV $462
line 826
;826:	}
LABELV $454
line 813
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $453
LABELV $455
line 828
;827:
;828:	ci->deferred = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 0
ASGNI4
line 832
;829:
;830:	// reset any existing players and bodies, because they might be in bad
;831:	// frames for this new model
;832:	clientNum = ci - cgs.clientinfo;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 cgs+40996
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1652
DIVI4
ASGNI4
line 833
;833:	for ( i = 0 ; i < MAX_GENTITIES ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $465
line 834
;834:		if ( cg_entities[i].currentState.clientNum == clientNum
ADDRLP4 0
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities+168
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $469
ADDRLP4 0
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities+4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $469
line 835
;835:			&& cg_entities[i].currentState.eType == ET_PLAYER ) {
line 836
;836:			CG_ResetPlayerEntity( &cg_entities[i] );
ADDRLP4 0
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities
ADDP4
ARGP4
ADDRGP4 CG_ResetPlayerEntity
CALLV
pop
line 837
;837:		}
LABELV $469
line 838
;838:	}
LABELV $466
line 833
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1024
LTI4 $465
line 841
;839:
;840:	// restore vertexlight mode
;841:	if ( vertexlit[0] && vertexlit[0] != '0' ) {
ADDRLP4 352
ADDRLP4 16
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 352
INDIRI4
CNSTI4 0
EQI4 $473
ADDRLP4 352
INDIRI4
CNSTI4 48
EQI4 $473
line 842
;842:		trap_Cvar_Set( "r_vertexlight", vertexlit );
ADDRGP4 $417
ARGP4
ADDRLP4 16
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 843
;843:	}
LABELV $473
line 844
;844:}
LABELV $416
endproc CG_LoadClientInfo 404 24
proc CG_CopyClientInfoModel 0 12
line 852
;845:
;846:
;847:/*
;848:======================
;849:CG_CopyClientInfoModel
;850:======================
;851:*/
;852:static void CG_CopyClientInfoModel( const clientInfo_t *from, clientInfo_t *to ) {
line 853
;853:	VectorCopy( from->headOffset, to->headOffset );
ADDRFP4 4
INDIRP4
CNSTI4 400
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 400
ADDP4
INDIRB
ASGNB 12
line 854
;854:	to->footsteps = from->footsteps;
ADDRFP4 4
INDIRP4
CNSTI4 412
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
ASGNI4
line 855
;855:	to->gender = from->gender;
ADDRFP4 4
INDIRP4
CNSTI4 416
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
ASGNI4
line 857
;856:
;857:	to->legsModel = from->legsModel;
ADDRFP4 4
INDIRP4
CNSTI4 420
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
ASGNI4
line 858
;858:	to->legsSkin = from->legsSkin;
ADDRFP4 4
INDIRP4
CNSTI4 424
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
ASGNI4
line 859
;859:	to->torsoModel = from->torsoModel;
ADDRFP4 4
INDIRP4
CNSTI4 428
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
ASGNI4
line 860
;860:	to->torsoSkin = from->torsoSkin;
ADDRFP4 4
INDIRP4
CNSTI4 432
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 432
ADDP4
INDIRI4
ASGNI4
line 861
;861:	to->headModel = from->headModel;
ADDRFP4 4
INDIRP4
CNSTI4 436
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ASGNI4
line 862
;862:	to->headSkin = from->headSkin;
ADDRFP4 4
INDIRP4
CNSTI4 440
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
ASGNI4
line 863
;863:	to->modelIcon = from->modelIcon;
ADDRFP4 4
INDIRP4
CNSTI4 444
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
ASGNI4
line 865
;864:
;865:	to->newAnims = from->newAnims;
ADDRFP4 4
INDIRP4
CNSTI4 388
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
ASGNI4
line 866
;866:	to->coloredSkin = from->coloredSkin;
ADDRFP4 4
INDIRP4
CNSTI4 1612
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 1612
ADDP4
INDIRI4
ASGNI4
line 868
;867:
;868:	memcpy( to->animations, from->animations, sizeof( to->animations ) );
ADDRFP4 4
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
ARGP4
CNSTU4 1036
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 869
;869:	memcpy( to->sounds, from->sounds, sizeof( to->sounds ) );
ADDRFP4 4
INDIRP4
CNSTI4 1484
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1484
ADDP4
ARGP4
CNSTU4 128
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 870
;870:}
LABELV $475
endproc CG_CopyClientInfoModel 0 12
proc CG_ScanForExistingClientInfo 24 8
line 878
;871:
;872:
;873:/*
;874:======================
;875:CG_ScanForExistingClientInfo
;876:======================
;877:*/
;878:static qboolean CG_ScanForExistingClientInfo( clientInfo_t *ci ) {
line 882
;879:	int		i;
;880:	clientInfo_t	*match;
;881:
;882:	for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $480
JUMPV
LABELV $477
line 883
;883:		match = &cgs.clientinfo[ i ];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 884
;884:		if ( !match->infoValid ) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $483
line 885
;885:			continue;
ADDRGP4 $478
JUMPV
LABELV $483
line 887
;886:		}
;887:		if ( match->deferred ) {
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
EQI4 $485
line 888
;888:			continue;
ADDRGP4 $478
JUMPV
LABELV $485
line 890
;889:		}
;890:		if ( !Q_stricmp( ci->modelName, match->modelName )
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $487
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $487
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $487
ADDRFP4 0
INDIRP4
CNSTI4 320
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $487
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $490
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
NEI4 $487
LABELV $490
line 896
;891:			&& !Q_stricmp( ci->skinName, match->skinName )
;892:			&& !Q_stricmp( ci->headModelName, match->headModelName )
;893:			&& !Q_stricmp( ci->headSkinName, match->headSkinName ) 
;894:			//&& !Q_stricmp( ci->blueTeam, match->blueTeam ) 
;895:			//&& !Q_stricmp( ci->redTeam, match->redTeam )
;896:			&& (cgs.gametype < GT_TEAM || ci->team == match->team) ) {
line 899
;897:			// this clientinfo is identical, so use it's handles
;898:
;899:			ci->deferred = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 0
ASGNI4
line 901
;900:
;901:			CG_CopyClientInfoModel( match, ci );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CopyClientInfoModel
CALLV
pop
line 903
;902:
;903:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $476
JUMPV
LABELV $487
line 905
;904:		}
;905:	}
LABELV $478
line 882
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $480
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31504
INDIRI4
LTI4 $477
line 908
;906:
;907:	// nothing matches, so defer the load
;908:	return qfalse;
CNSTI4 0
RETI4
LABELV $476
endproc CG_ScanForExistingClientInfo 24 8
proc CG_SetDeferredClientInfo 20 8
line 920
;909:}
;910:
;911:
;912:/*
;913:======================
;914:CG_SetDeferredClientInfo
;915:
;916:We aren't going to load it now, so grab some other
;917:client's info to use until we have some spare time.
;918:======================
;919:*/
;920:static void CG_SetDeferredClientInfo( clientInfo_t *ci ) {
line 926
;921:	int		i;
;922:	clientInfo_t	*match;
;923:
;924:	// if someone else is already the same models and skins we
;925:	// can just load the client info
;926:	for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $495
JUMPV
LABELV $492
line 927
;927:		match = &cgs.clientinfo[ i ];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 928
;928:		if ( !match->infoValid || match->deferred ) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $500
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
EQI4 $498
LABELV $500
line 929
;929:			continue;
ADDRGP4 $493
JUMPV
LABELV $498
line 931
;930:		}
;931:		if ( Q_stricmp( ci->skinName, match->skinName ) ||
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $505
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $505
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $501
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
EQI4 $501
LABELV $505
line 935
;932:			 Q_stricmp( ci->modelName, match->modelName ) ||
;933://			 Q_stricmp( ci->headModelName, match->headModelName ) ||
;934://			 Q_stricmp( ci->headSkinName, match->headSkinName ) ||
;935:			 (cgs.gametype >= GT_TEAM && ci->team != match->team) ) {
line 936
;936:			continue;
ADDRGP4 $493
JUMPV
LABELV $501
line 939
;937:		}
;938:		// just load the real info cause it uses the same models and skins
;939:		CG_LoadClientInfo( ci );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 940
;940:		return;
ADDRGP4 $491
JUMPV
LABELV $493
line 926
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $495
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31504
INDIRI4
LTI4 $492
line 944
;941:	}
;942:
;943:	// if we are in teamplay, only grab a model if the skin is correct
;944:	if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $506
line 945
;945:		for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $512
JUMPV
LABELV $509
line 946
;946:			match = &cgs.clientinfo[ i ];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 947
;947:			if ( !match->infoValid || match->deferred ) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $517
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
EQI4 $515
LABELV $517
line 948
;948:				continue;
ADDRGP4 $510
JUMPV
LABELV $515
line 950
;949:			}
;950:			if ( Q_stricmp( ci->skinName, match->skinName ) ||
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $521
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $518
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
EQI4 $518
LABELV $521
line 951
;951:				(cgs.gametype >= GT_TEAM && ci->team != match->team) ) {
line 952
;952:				continue;
ADDRGP4 $510
JUMPV
LABELV $518
line 954
;953:			}
;954:			ci->deferred = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 1
ASGNI4
line 955
;955:			CG_CopyClientInfoModel( match, ci );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CopyClientInfoModel
CALLV
pop
line 956
;956:			return;
ADDRGP4 $491
JUMPV
LABELV $510
line 945
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $512
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31504
INDIRI4
LTI4 $509
line 962
;957:		}
;958:		// load the full model, because we don't ever want to show
;959:		// an improper team skin.  This will cause a hitch for the first
;960:		// player, when the second enters.  Combat shouldn't be going on
;961:		// yet, so it shouldn't matter
;962:		CG_LoadClientInfo( ci );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 963
;963:		return;
ADDRGP4 $491
JUMPV
LABELV $506
line 967
;964:	}
;965:
;966:	// find the first valid clientinfo and grab its stuff
;967:	for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $525
JUMPV
LABELV $522
line 968
;968:		match = &cgs.clientinfo[ i ];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 969
;969:		if ( !match->infoValid ) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $528
line 970
;970:			continue;
ADDRGP4 $523
JUMPV
LABELV $528
line 973
;971:		}
;972:
;973:		ci->deferred = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 1
ASGNI4
line 974
;974:		CG_CopyClientInfoModel( match, ci );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CopyClientInfoModel
CALLV
pop
line 975
;975:		return;
ADDRGP4 $491
JUMPV
LABELV $523
line 967
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $525
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31504
INDIRI4
LTI4 $522
line 979
;976:	}
;977:
;978:	// we should never get here...
;979:	CG_Printf( "CG_SetDeferredClientInfo: no valid clients!\n" );
ADDRGP4 $530
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 981
;980:
;981:	CG_LoadClientInfo( ci );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 982
;982:}
LABELV $491
endproc CG_SetDeferredClientInfo 20 8
proc CG_SetSkinAndModel 204 12
line 993
;983:
;984:
;985:static void CG_SetSkinAndModel( clientInfo_t *newInfo,
;986:		clientInfo_t *curInfo,
;987:		const char *infomodel,
;988:		qboolean allowNativeModel,
;989:		int clientNum, int myClientNum,
;990:		team_t myTeam, qboolean setColor,
;991:		char *modelName, int modelNameSize,
;992:		char *skinName, int skinNameSize ) 
;993:{
line 1002
;994:	char modelStr[ MAX_QPATH ];
;995:	char newSkin[ MAX_QPATH ];
;996:	char *skin, *slash;
;997:	qboolean	pm_model;
;998:	qboolean	fb_model;
;999:	team_t		team;
;1000:	const char	*colors;
;1001:	
;1002:	team = newInfo->team;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
line 1003
;1003:	pm_model = ( Q_stricmp( cg_enemyModel.string, PM_SKIN ) == 0 ) ? qtrue : qfalse;
ADDRGP4 cg_enemyModel+16
ARGP4
ADDRGP4 $207
ARGP4
ADDRLP4 156
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
NEI4 $534
ADDRLP4 152
CNSTI4 1
ASGNI4
ADDRGP4 $535
JUMPV
LABELV $534
ADDRLP4 152
CNSTI4 0
ASGNI4
LABELV $535
ADDRLP4 4
ADDRLP4 152
INDIRI4
ASGNI4
line 1004
;1004:	fb_model = ( Q_stricmp( cg_enemyModel.string, FB_SKIN ) == 0 ) ? qtrue : qfalse;
ADDRGP4 cg_enemyModel+16
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 164
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
NEI4 $538
ADDRLP4 160
CNSTI4 1
ASGNI4
ADDRGP4 $539
JUMPV
LABELV $538
ADDRLP4 160
CNSTI4 0
ASGNI4
LABELV $539
ADDRLP4 12
ADDRLP4 160
INDIRI4
ASGNI4
line 1006
;1005:
;1006:	if ( cg_forceModel.integer || cg_enemyModel.string[0] || cg_teamModel.string[0] )
ADDRGP4 cg_forceModel+12
INDIRI4
CNSTI4 0
NEI4 $546
ADDRGP4 cg_enemyModel+16
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $546
ADDRGP4 cg_teamModel+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $540
LABELV $546
line 1007
;1007:	{
line 1008
;1008:		if ( cgs.gametype >= GT_TEAM )
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $547
line 1009
;1009:		{
line 1011
;1010:			// enemy model
;1011:			if ( cg_enemyModel.string[0] && team != myTeam && team != TEAM_SPECTATOR ) {
ADDRGP4 cg_enemyModel+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $550
ADDRLP4 168
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 168
INDIRI4
ADDRFP4 24
INDIRI4
EQI4 $550
ADDRLP4 168
INDIRI4
CNSTI4 3
EQI4 $550
line 1012
;1012:				if ( pm_model || fb_model ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $555
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $553
LABELV $555
line 1013
;1013:					Q_strncpyz( modelName, infomodel, modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1014
;1014:					skin = strchr( modelName, '/' );
ADDRFP4 32
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 172
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 172
INDIRP4
ASGNP4
line 1016
;1015:					// force skin
;1016:					if ( pm_model )
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $556
line 1017
;1017:						strcpy( newSkin, PM_SKIN );
ADDRLP4 20
ARGP4
ADDRGP4 $207
ARGP4
ADDRGP4 strcpy
CALLP4
pop
ADDRGP4 $557
JUMPV
LABELV $556
line 1019
;1018:					else
;1019:						strcpy( newSkin, FB_SKIN );
ADDRLP4 20
ARGP4
ADDRGP4 $210
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $557
line 1020
;1020:					if ( skin )
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $554
line 1021
;1021:						*skin = '\0';
ADDRLP4 16
INDIRP4
CNSTI1 0
ASGNI1
line 1022
;1022:				}
ADDRGP4 $554
JUMPV
LABELV $553
line 1023
;1023:				else {
line 1024
;1024:					Q_strncpyz( modelName, cg_enemyModel.string, modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRGP4 cg_enemyModel+16
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1025
;1025:					skin = strchr( modelName, '/' );
ADDRFP4 32
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 172
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 172
INDIRP4
ASGNP4
line 1026
;1026:					if ( !skin ) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $561
line 1027
;1027:						Q_strncpyz( newSkin, PM_SKIN, skinNameSize );
ADDRLP4 20
ARGP4
ADDRGP4 $207
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1028
;1028:					} else {
ADDRGP4 $562
JUMPV
LABELV $561
line 1029
;1029:						Q_strncpyz( newSkin, skin + 1, skinNameSize );
ADDRLP4 20
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1030
;1030:						*skin = '\0';
ADDRLP4 16
INDIRP4
CNSTI1 0
ASGNI1
line 1031
;1031:					}
LABELV $562
line 1032
;1032:				}
LABELV $554
line 1034
;1033:
;1034:				if ( ( pm_model || fb_model ) && !CG_IsKnownModel( modelName ) ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $565
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $563
LABELV $565
ADDRFP4 32
INDIRP4
ARGP4
ADDRLP4 172
ADDRGP4 CG_IsKnownModel
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
NEI4 $563
line 1036
;1035:					// revert to default model if specified skin is not known
;1036:					Q_strncpyz( modelName, "sarge", modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRGP4 $380
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1037
;1037:				}
LABELV $563
line 1038
;1038:				Q_strncpyz( skinName, newSkin, skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1040
;1039:
;1040:				if ( setColor ) {
ADDRFP4 28
INDIRI4
CNSTI4 0
EQI4 $541
line 1041
;1041:					if ( cg_enemyColors.string[0] && myTeam != TEAM_SPECTATOR ) // free-fly?
ADDRGP4 cg_enemyColors+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $568
ADDRFP4 24
INDIRI4
CNSTI4 3
EQI4 $568
line 1042
;1042:						colors = CG_GetTeamColors( cg_enemyColors.string, newInfo->team );
ADDRGP4 cg_enemyColors+16
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRLP4 176
ADDRGP4 CG_GetTeamColors
CALLP4
ASGNP4
ADDRLP4 84
ADDRLP4 176
INDIRP4
ASGNP4
ADDRGP4 $569
JUMPV
LABELV $568
line 1044
;1043:					else
;1044:						colors = CG_GetTeamColors( "???", newInfo->team );
ADDRGP4 $572
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRLP4 180
ADDRGP4 CG_GetTeamColors
CALLP4
ASGNP4
ADDRLP4 84
ADDRLP4 180
INDIRP4
ASGNP4
LABELV $569
line 1046
;1045:
;1046:					CG_SetColorInfo( colors, newInfo );
ADDRLP4 84
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetColorInfo
CALLV
pop
line 1047
;1047:					newInfo->coloredSkin = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 1612
ADDP4
CNSTI4 1
ASGNI4
line 1048
;1048:				}
line 1050
;1049:
;1050:			} else if ( cg_teamModel.string[0] && team == myTeam && team != TEAM_SPECTATOR && clientNum != myClientNum ) {
ADDRGP4 $541
JUMPV
LABELV $550
ADDRGP4 cg_teamModel+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $573
ADDRLP4 172
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 172
INDIRI4
ADDRFP4 24
INDIRI4
NEI4 $573
ADDRLP4 172
INDIRI4
CNSTI4 3
EQI4 $573
ADDRFP4 16
INDIRI4
ADDRFP4 20
INDIRI4
EQI4 $573
line 1052
;1051:				// teammodel
;1052:				pm_model = ( Q_stricmp( cg_teamModel.string, PM_SKIN ) == 0 ) ? qtrue : qfalse;
ADDRGP4 cg_teamModel+16
ARGP4
ADDRGP4 $207
ARGP4
ADDRLP4 180
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
NEI4 $578
ADDRLP4 176
CNSTI4 1
ASGNI4
ADDRGP4 $579
JUMPV
LABELV $578
ADDRLP4 176
CNSTI4 0
ASGNI4
LABELV $579
ADDRLP4 4
ADDRLP4 176
INDIRI4
ASGNI4
line 1053
;1053:				fb_model = ( Q_stricmp( cg_enemyModel.string, FB_SKIN ) == 0 ) ? qtrue : qfalse;
ADDRGP4 cg_enemyModel+16
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 188
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 0
NEI4 $582
ADDRLP4 184
CNSTI4 1
ASGNI4
ADDRGP4 $583
JUMPV
LABELV $582
ADDRLP4 184
CNSTI4 0
ASGNI4
LABELV $583
ADDRLP4 12
ADDRLP4 184
INDIRI4
ASGNI4
line 1055
;1054:
;1055:				if ( pm_model || fb_model ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $586
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $584
LABELV $586
line 1056
;1056:					Q_strncpyz( modelName, infomodel, modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1057
;1057:					skin = strchr( modelName, '/' );
ADDRFP4 32
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 192
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 192
INDIRP4
ASGNP4
line 1059
;1058:					// force skin
;1059:					if ( pm_model )
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $587
line 1060
;1060:						strcpy( newSkin, PM_SKIN );
ADDRLP4 20
ARGP4
ADDRGP4 $207
ARGP4
ADDRGP4 strcpy
CALLP4
pop
ADDRGP4 $588
JUMPV
LABELV $587
line 1062
;1061:					else
;1062:						strcpy( newSkin, FB_SKIN );
ADDRLP4 20
ARGP4
ADDRGP4 $210
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $588
line 1063
;1063:					if ( skin )
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $585
line 1064
;1064:						*skin = '\0';
ADDRLP4 16
INDIRP4
CNSTI1 0
ASGNI1
line 1065
;1065:				} else {
ADDRGP4 $585
JUMPV
LABELV $584
line 1066
;1066:					Q_strncpyz( modelName, cg_teamModel.string, modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRGP4 cg_teamModel+16
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1067
;1067:					skin = strchr( modelName, '/' );
ADDRFP4 32
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 192
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 192
INDIRP4
ASGNP4
line 1068
;1068:					if ( !skin ) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $592
line 1069
;1069:						Q_strncpyz( newSkin, PM_SKIN, skinNameSize );
ADDRLP4 20
ARGP4
ADDRGP4 $207
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1070
;1070:					} else {
ADDRGP4 $593
JUMPV
LABELV $592
line 1071
;1071:						Q_strncpyz( newSkin, skin + 1, skinNameSize );
ADDRLP4 20
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1072
;1072:						*skin = '\0';
ADDRLP4 16
INDIRP4
CNSTI1 0
ASGNI1
line 1073
;1073:					}
LABELV $593
line 1074
;1074:				}
LABELV $585
line 1076
;1075:
;1076:				if ( ( pm_model || fb_model ) && !CG_IsKnownModel( modelName ) ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $596
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $594
LABELV $596
ADDRFP4 32
INDIRP4
ARGP4
ADDRLP4 192
ADDRGP4 CG_IsKnownModel
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
NEI4 $594
line 1078
;1077:					// revert to default model if specified skin is not known
;1078:					Q_strncpyz( modelName, "sarge", modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRGP4 $380
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1079
;1079:				}
LABELV $594
line 1080
;1080:				Q_strncpyz( skinName, newSkin, skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1082
;1081:
;1082:				if ( setColor ) {
ADDRFP4 28
INDIRI4
CNSTI4 0
EQI4 $541
line 1083
;1083:					if ( cg_teamColors.string[0] && myTeam != TEAM_SPECTATOR ) // free-fly?
ADDRGP4 cg_teamColors+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $599
ADDRFP4 24
INDIRI4
CNSTI4 3
EQI4 $599
line 1084
;1084:						colors = CG_GetTeamColors( cg_teamColors.string, newInfo->team );
ADDRGP4 cg_teamColors+16
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRLP4 196
ADDRGP4 CG_GetTeamColors
CALLP4
ASGNP4
ADDRLP4 84
ADDRLP4 196
INDIRP4
ASGNP4
ADDRGP4 $600
JUMPV
LABELV $599
line 1086
;1085:					else
;1086:						colors = CG_GetTeamColors( "???", newInfo->team );
ADDRGP4 $572
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRLP4 200
ADDRGP4 CG_GetTeamColors
CALLP4
ASGNP4
ADDRLP4 84
ADDRLP4 200
INDIRP4
ASGNP4
LABELV $600
line 1088
;1087:
;1088:					CG_SetColorInfo( colors, newInfo );
ADDRLP4 84
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetColorInfo
CALLV
pop
line 1089
;1089:					newInfo->coloredSkin = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 1612
ADDP4
CNSTI4 1
ASGNI4
line 1090
;1090:				}
line 1092
;1091:
;1092:			} else {
ADDRGP4 $541
JUMPV
LABELV $573
line 1094
;1093:				// forcemodel etc.
;1094:				if ( cg_forceModel.integer ) {
ADDRGP4 cg_forceModel+12
INDIRI4
CNSTI4 0
EQI4 $603
line 1096
;1095:
;1096:					trap_Cvar_VariableStringBuffer( "model", modelStr, sizeof( modelStr ) );
ADDRGP4 $606
ARGP4
ADDRLP4 88
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1097
;1097:					if ( ( skin = strchr( modelStr, '/' ) ) == NULL) {
ADDRLP4 88
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 176
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 176
INDIRP4
ASGNP4
ADDRLP4 176
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $607
line 1098
;1098:						skin = "default";
ADDRLP4 16
ADDRGP4 $120
ASGNP4
line 1099
;1099:					} else {
ADDRGP4 $608
JUMPV
LABELV $607
line 1100
;1100:						*skin++ = '\0';
ADDRLP4 180
ADDRLP4 16
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 180
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 180
INDIRP4
CNSTI1 0
ASGNI1
line 1101
;1101:					}
LABELV $608
line 1103
;1102:
;1103:					Q_strncpyz( skinName, skin, skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1104
;1104:					Q_strncpyz( modelName, modelStr, modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRLP4 88
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1106
;1105:
;1106:				} else {
ADDRGP4 $541
JUMPV
LABELV $603
line 1107
;1107:					Q_strncpyz( modelName, infomodel, modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1108
;1108:					slash = strchr( modelName, '/' );
ADDRFP4 32
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 176
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 176
INDIRP4
ASGNP4
line 1109
;1109:					if ( !slash ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $609
line 1110
;1110:						Q_strncpyz( skinName, "default", skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRGP4 $120
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1111
;1111:					} else {
ADDRGP4 $541
JUMPV
LABELV $609
line 1112
;1112:						Q_strncpyz( skinName, slash + 1, skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1113
;1113:						*slash = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1114
;1114:					}
line 1115
;1115:				}
line 1116
;1116:			}
line 1117
;1117:		} else { // not team game
ADDRGP4 $541
JUMPV
LABELV $547
line 1119
;1118:
;1119:			if ( pm_model && myClientNum != clientNum && cgs.gametype != GT_SINGLE_PLAYER ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $611
ADDRFP4 20
INDIRI4
ADDRFP4 16
INDIRI4
EQI4 $611
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 2
EQI4 $611
line 1120
;1120:				Q_strncpyz( modelName, infomodel, modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1123
;1121:
;1122:				// strip skin name from model name
;1123:				slash = strchr( modelName, '/' );
ADDRFP4 32
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 168
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 168
INDIRP4
ASGNP4
line 1124
;1124:				if ( !slash ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $614
line 1125
;1125:					Q_strncpyz( skinName, PM_SKIN, skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRGP4 $207
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1126
;1126:				} else {
ADDRGP4 $615
JUMPV
LABELV $614
line 1127
;1127:					Q_strncpyz( skinName, PM_SKIN, skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRGP4 $207
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1128
;1128:					*slash = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1129
;1129:				}
LABELV $615
line 1131
;1130:
;1131:				if ( !CG_IsKnownModel( modelName ) )
ADDRFP4 32
INDIRP4
ARGP4
ADDRLP4 172
ADDRGP4 CG_IsKnownModel
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
NEI4 $616
line 1132
;1132:					Q_strncpyz( modelName, "sarge", modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRGP4 $380
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
LABELV $616
line 1134
;1133:
;1134:				if ( setColor ) {
ADDRFP4 28
INDIRI4
CNSTI4 0
EQI4 $541
line 1135
;1135:					colors = CG_GetTeamColors( cg_enemyColors.string, newInfo->team );
ADDRGP4 cg_enemyColors+16
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRLP4 176
ADDRGP4 CG_GetTeamColors
CALLP4
ASGNP4
ADDRLP4 84
ADDRLP4 176
INDIRP4
ASGNP4
line 1136
;1136:					CG_SetColorInfo( colors, newInfo );
ADDRLP4 84
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetColorInfo
CALLV
pop
line 1137
;1137:					newInfo->coloredSkin = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 1612
ADDP4
CNSTI4 1
ASGNI4
line 1138
;1138:				}
line 1140
;1139:
;1140:			} else if ( cg_enemyModel.string[0] && myClientNum != clientNum && !allowNativeModel && cgs.gametype != GT_SINGLE_PLAYER ) {
ADDRGP4 $541
JUMPV
LABELV $611
ADDRGP4 cg_enemyModel+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $621
ADDRFP4 20
INDIRI4
ADDRFP4 16
INDIRI4
EQI4 $621
ADDRFP4 12
INDIRI4
CNSTI4 0
NEI4 $621
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 2
EQI4 $621
line 1142
;1141:
;1142:				Q_strncpyz( modelName, cg_enemyModel.string, modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRGP4 cg_enemyModel+16
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1144
;1143:
;1144:				slash = strchr( modelName, '/' );
ADDRFP4 32
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 168
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 168
INDIRP4
ASGNP4
line 1145
;1145:				if ( !slash ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $626
line 1146
;1146:					Q_strncpyz( skinName, PM_SKIN, skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRGP4 $207
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1147
;1147:				} else {
ADDRGP4 $627
JUMPV
LABELV $626
line 1148
;1148:					Q_strncpyz( skinName, slash + 1, skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1149
;1149:					*slash = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1150
;1150:				}
LABELV $627
line 1152
;1151:
;1152:				if ( setColor ) {
ADDRFP4 28
INDIRI4
CNSTI4 0
EQI4 $541
line 1153
;1153:					colors = CG_GetTeamColors( cg_enemyColors.string, newInfo->team );
ADDRGP4 cg_enemyColors+16
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRLP4 172
ADDRGP4 CG_GetTeamColors
CALLP4
ASGNP4
ADDRLP4 84
ADDRLP4 172
INDIRP4
ASGNP4
line 1154
;1154:					CG_SetColorInfo( colors, newInfo );
ADDRLP4 84
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetColorInfo
CALLV
pop
line 1155
;1155:					newInfo->coloredSkin = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 1612
ADDP4
CNSTI4 1
ASGNI4
line 1156
;1156:				}
line 1157
;1157:			} else { // forcemodel, etc.
ADDRGP4 $541
JUMPV
LABELV $621
line 1158
;1158:				if ( cg_forceModel.integer ) {
ADDRGP4 cg_forceModel+12
INDIRI4
CNSTI4 0
EQI4 $631
line 1160
;1159:
;1160:					trap_Cvar_VariableStringBuffer( "model", modelStr, sizeof( modelStr ) );
ADDRGP4 $606
ARGP4
ADDRLP4 88
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1161
;1161:					if ( ( skin = strchr( modelStr, '/' ) ) == NULL ) {
ADDRLP4 88
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 168
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 168
INDIRP4
ASGNP4
ADDRLP4 168
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $634
line 1162
;1162:						skin = "default";
ADDRLP4 16
ADDRGP4 $120
ASGNP4
line 1163
;1163:					} else {
ADDRGP4 $635
JUMPV
LABELV $634
line 1164
;1164:						*skin++ = '\0';
ADDRLP4 172
ADDRLP4 16
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 172
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 172
INDIRP4
CNSTI1 0
ASGNI1
line 1165
;1165:					}
LABELV $635
line 1167
;1166:
;1167:					Q_strncpyz( skinName, skin, skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1168
;1168:					Q_strncpyz( modelName, modelStr, modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRLP4 88
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1169
;1169:				} else {
ADDRGP4 $541
JUMPV
LABELV $631
line 1170
;1170:					Q_strncpyz( modelName, infomodel, modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1171
;1171:						slash = strchr( modelName, '/' );
ADDRFP4 32
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 168
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 168
INDIRP4
ASGNP4
line 1172
;1172:					if ( !slash ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $636
line 1174
;1173:						// modelName didn not include a skin name
;1174:						Q_strncpyz( skinName, "default", skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRGP4 $120
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1175
;1175:					} else {
ADDRGP4 $541
JUMPV
LABELV $636
line 1176
;1176:						Q_strncpyz( skinName, slash + 1, skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1178
;1177:						// truncate modelName
;1178:						*slash = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1179
;1179:					}
line 1180
;1180:				}
line 1181
;1181:			}
line 1182
;1182:		}
line 1183
;1183:	}
ADDRGP4 $541
JUMPV
LABELV $540
line 1185
;1184:	else // !cg_forcemodel && !cg_enemyModel && !cg_teamModel
;1185:	{
line 1186
;1186:		Q_strncpyz( modelName, infomodel, modelNameSize );
ADDRFP4 32
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1187
;1187:		slash = strchr( modelName, '/' );
ADDRFP4 32
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 168
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 168
INDIRP4
ASGNP4
line 1188
;1188:		if ( !slash ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $638
line 1190
;1189:			// modelName didn not include a skin name
;1190:			Q_strncpyz( skinName, "default", skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRGP4 $120
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1191
;1191:		} else {
ADDRGP4 $639
JUMPV
LABELV $638
line 1192
;1192:			Q_strncpyz( skinName, slash + 1, skinNameSize );
ADDRFP4 40
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRFP4 44
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1194
;1193:			// truncate modelName
;1194:			*slash = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1195
;1195:		}
LABELV $639
line 1196
;1196:	}
LABELV $541
line 1197
;1197:}
LABELV $531
endproc CG_SetSkinAndModel 204 12
export CG_NewClientInfo
proc CG_NewClientInfo 1788 48
line 1205
;1198:
;1199:
;1200:/*
;1201:======================
;1202:CG_NewClientInfo
;1203:======================
;1204:*/
;1205:void CG_NewClientInfo( int clientNum ) {
line 1219
;1206:	clientInfo_t *ci;
;1207:	clientInfo_t newInfo;
;1208:	const char	*configstring;
;1209:	const char	*v;
;1210:
;1211:	// for colored skins
;1212:	qboolean	allowNativeModel;
;1213:	int			can_defer;
;1214:	int			myClientNum;
;1215:	team_t		myTeam;
;1216:	team_t		team;
;1217:	int			len;
;1218:
;1219:	ci = &cgs.clientinfo[clientNum];
ADDRLP4 1668
ADDRFP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 1221
;1220:
;1221:	configstring = CG_ConfigString( clientNum + CS_PLAYERS );
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 1688
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 1656
ADDRLP4 1688
INDIRP4
ASGNP4
line 1222
;1222:	if ( !configstring[0] ) {
ADDRLP4 1656
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $642
line 1223
;1223:		memset( ci, 0, sizeof( *ci ) );
ADDRLP4 1668
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 1652
ARGU4
ADDRGP4 memset
CALLP4
pop
line 1224
;1224:		return;	// player just left
ADDRGP4 $640
JUMPV
LABELV $642
line 1227
;1225:	}
;1226:
;1227:	if ( cg.snap ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $644
line 1228
;1228:		myClientNum = cg.snap->ps.clientNum;
ADDRLP4 1672
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 1229
;1229:		myTeam = cgs.clientinfo[ myClientNum ].team;
ADDRLP4 1664
ADDRLP4 1672
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+36
ADDP4
INDIRI4
ASGNI4
line 1230
;1230:	} else {
ADDRGP4 $645
JUMPV
LABELV $644
line 1231
;1231:		myClientNum = cg.clientNum;
ADDRLP4 1672
ADDRGP4 cg+4
INDIRI4
ASGNI4
line 1232
;1232:		myTeam = TEAM_SPECTATOR;
ADDRLP4 1664
CNSTI4 3
ASGNI4
line 1233
;1233:	}
LABELV $645
line 1236
;1234:
;1235:	// "join" team if spectating
;1236:	if ( myTeam == TEAM_SPECTATOR && cg.snap ) {
ADDRLP4 1664
INDIRI4
CNSTI4 3
NEI4 $651
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $651
line 1237
;1237:		myTeam = cg.snap->ps.persistant[ PERS_TEAM ];
ADDRLP4 1664
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ASGNI4
line 1238
;1238:	}
LABELV $651
line 1240
;1239:
;1240:	allowNativeModel = qfalse;
ADDRLP4 1676
CNSTI4 0
ASGNI4
line 1241
;1241:	if ( cgs.gametype < GT_TEAM ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
GEI4 $655
line 1242
;1242:		if ( !cg.snap || ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_FREE && cg.snap->ps.clientNum == clientNum ) ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $663
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 0
NEI4 $658
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $658
LABELV $663
line 1243
;1243:			if ( cg.demoPlayback || ( cg.snap && cg.snap->ps.pm_flags & PMF_FOLLOW ) ) {
ADDRGP4 cg+8
INDIRI4
CNSTI4 0
NEI4 $669
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $664
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $664
LABELV $669
line 1244
;1244:				allowNativeModel = qtrue;
ADDRLP4 1676
CNSTI4 1
ASGNI4
line 1245
;1245:			}
LABELV $664
line 1246
;1246:		}
LABELV $658
line 1247
;1247:	}
LABELV $655
line 1251
;1248:
;1249:	// build into a temp buffer so the defer checks can use
;1250:	// the old value
;1251:	memset( &newInfo, 0, sizeof( newInfo ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTU4 1652
ARGU4
ADDRGP4 memset
CALLP4
pop
line 1254
;1252:
;1253:	// isolate the player's name
;1254:	v = Info_ValueForKey( configstring, "n" );
ADDRLP4 1656
INDIRP4
ARGP4
ADDRGP4 $670
ARGP4
ADDRLP4 1692
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1692
INDIRP4
ASGNP4
line 1255
;1255:	Q_strncpyz( newInfo.name, v, sizeof( newInfo.name ) );
ADDRLP4 0+4
ARGP4
ADDRLP4 1652
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1258
;1256:
;1257:	// team
;1258:	v = Info_ValueForKey( configstring, "t" );
ADDRLP4 1656
INDIRP4
ARGP4
ADDRGP4 $673
ARGP4
ADDRLP4 1696
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1696
INDIRP4
ASGNP4
line 1259
;1259:	team = atoi( v );
ADDRLP4 1652
INDIRP4
ARGP4
ADDRLP4 1700
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1660
ADDRLP4 1700
INDIRI4
ASGNI4
line 1260
;1260:	if ( (unsigned) team > TEAM_NUM_TEAMS ) {
ADDRLP4 1660
INDIRI4
CVIU4 4
CNSTU4 4
LEU4 $674
line 1261
;1261:		team = TEAM_SPECTATOR;
ADDRLP4 1660
CNSTI4 3
ASGNI4
line 1262
;1262:	}
LABELV $674
line 1263
;1263:	newInfo.team = team;
ADDRLP4 0+36
ADDRLP4 1660
INDIRI4
ASGNI4
line 1266
;1264:
;1265:	// colors
;1266:	v = Info_ValueForKey( configstring, "c1" );
ADDRLP4 1656
INDIRP4
ARGP4
ADDRGP4 $677
ARGP4
ADDRLP4 1704
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1704
INDIRP4
ASGNP4
line 1267
;1267:	CG_ColorFromChar( v[0], newInfo.color1 );
ADDRLP4 1652
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 0+44
ARGP4
ADDRGP4 CG_ColorFromChar
CALLV
pop
line 1269
;1268:
;1269:	v = Info_ValueForKey( configstring, "c2" );
ADDRLP4 1656
INDIRP4
ARGP4
ADDRGP4 $679
ARGP4
ADDRLP4 1708
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1708
INDIRP4
ASGNP4
line 1270
;1270:	CG_ColorFromChar( v[0], newInfo.color2 );
ADDRLP4 1652
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 0+56
ARGP4
ADDRGP4 CG_ColorFromChar
CALLV
pop
line 1272
;1271:
;1272:	VectorSet( newInfo.headColor, 1.0, 1.0, 1.0 );
ADDRLP4 0+1616
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+1616+4
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+1616+8
CNSTF4 1065353216
ASGNF4
line 1273
;1273:	VectorSet( newInfo.bodyColor, 1.0, 1.0, 1.0 );
ADDRLP4 0+1628
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+1628+4
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+1628+8
CNSTF4 1065353216
ASGNF4
line 1274
;1274:	VectorSet( newInfo.legsColor, 1.0, 1.0, 1.0 );
ADDRLP4 0+1640
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+1640+4
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+1640+8
CNSTF4 1065353216
ASGNF4
line 1277
;1275:
;1276:	// bot skill
;1277:	v = Info_ValueForKey( configstring, "skill" );
ADDRLP4 1656
INDIRP4
ARGP4
ADDRGP4 $696
ARGP4
ADDRLP4 1712
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1712
INDIRP4
ASGNP4
line 1278
;1278:	newInfo.botSkill = atoi( v );
ADDRLP4 1652
INDIRP4
ARGP4
ADDRLP4 1716
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+40
ADDRLP4 1716
INDIRI4
ASGNI4
line 1281
;1279:
;1280:	// handicap
;1281:	v = Info_ValueForKey( configstring, "hc" );
ADDRLP4 1656
INDIRP4
ARGP4
ADDRGP4 $698
ARGP4
ADDRLP4 1720
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1720
INDIRP4
ASGNP4
line 1282
;1282:	newInfo.handicap = atoi( v );
ADDRLP4 1652
INDIRP4
ARGP4
ADDRLP4 1724
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+88
ADDRLP4 1724
INDIRI4
ASGNI4
line 1285
;1283:
;1284:	// wins
;1285:	v = Info_ValueForKey( configstring, "w" );
ADDRLP4 1656
INDIRP4
ARGP4
ADDRGP4 $700
ARGP4
ADDRLP4 1728
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1728
INDIRP4
ASGNP4
line 1286
;1286:	newInfo.wins = atoi( v );
ADDRLP4 1652
INDIRP4
ARGP4
ADDRLP4 1732
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+92
ADDRLP4 1732
INDIRI4
ASGNI4
line 1289
;1287:
;1288:	// losses
;1289:	v = Info_ValueForKey( configstring, "l" );
ADDRLP4 1656
INDIRP4
ARGP4
ADDRGP4 $702
ARGP4
ADDRLP4 1736
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1736
INDIRP4
ASGNP4
line 1290
;1290:	newInfo.losses = atoi( v );
ADDRLP4 1652
INDIRP4
ARGP4
ADDRLP4 1740
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+96
ADDRLP4 1740
INDIRI4
ASGNI4
line 1293
;1291:
;1292:	// always apply team colors [4] and [5] if specified, this will work in non-team games too
;1293:	if ( cg_teamColors.string[0] && team != TEAM_SPECTATOR ) {
ADDRGP4 cg_teamColors+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $704
ADDRLP4 1660
INDIRI4
CNSTI4 3
EQI4 $704
line 1294
;1294:		if ( allowNativeModel || ( ( team == TEAM_RED || team == TEAM_BLUE ) && team == myTeam && ( clientNum != myClientNum || cg.demoPlayback ) ) ) {
ADDRLP4 1676
INDIRI4
CNSTI4 0
NEI4 $712
ADDRLP4 1660
INDIRI4
CNSTI4 1
EQI4 $711
ADDRLP4 1660
INDIRI4
CNSTI4 2
NEI4 $707
LABELV $711
ADDRLP4 1660
INDIRI4
ADDRLP4 1664
INDIRI4
NEI4 $707
ADDRFP4 0
INDIRI4
ADDRLP4 1672
INDIRI4
NEI4 $712
ADDRGP4 cg+8
INDIRI4
CNSTI4 0
EQI4 $707
LABELV $712
line 1295
;1295:			v = CG_GetTeamColors( cg_teamColors.string, team );
ADDRGP4 cg_teamColors+16
ARGP4
ADDRLP4 1660
INDIRI4
ARGI4
ADDRLP4 1748
ADDRGP4 CG_GetTeamColors
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1748
INDIRP4
ASGNP4
line 1296
;1296:			len = strlen( v );
ADDRLP4 1652
INDIRP4
ARGP4
ADDRLP4 1752
ADDRGP4 strlen
CALLU4
ASGNU4
ADDRLP4 1684
ADDRLP4 1752
INDIRU4
CVUI4 4
ASGNI4
line 1297
;1297:			if ( len >= 4 )
ADDRLP4 1684
INDIRI4
CNSTI4 4
LTI4 $714
line 1298
;1298:				CG_ColorFromChar( v[3], newInfo.color1 );
ADDRLP4 1652
INDIRP4
CNSTI4 3
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 0+44
ARGP4
ADDRGP4 CG_ColorFromChar
CALLV
pop
LABELV $714
line 1299
;1299:			if ( len >= 5 )
ADDRLP4 1684
INDIRI4
CNSTI4 5
LTI4 $717
line 1300
;1300:				CG_ColorFromChar( v[4], newInfo.color2 );
ADDRLP4 1652
INDIRP4
CNSTI4 4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 0+56
ARGP4
ADDRGP4 CG_ColorFromChar
CALLV
pop
LABELV $717
line 1301
;1301:		}
LABELV $707
line 1302
;1302:	}
LABELV $704
line 1305
;1303:
;1304:	// team task
;1305:	v = Info_ValueForKey( configstring, "tt" );
ADDRLP4 1656
INDIRP4
ARGP4
ADDRGP4 $720
ARGP4
ADDRLP4 1744
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1744
INDIRP4
ASGNP4
line 1306
;1306:	newInfo.teamTask = atoi(v);
ADDRLP4 1652
INDIRP4
ARGP4
ADDRLP4 1748
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+100
ADDRLP4 1748
INDIRI4
ASGNI4
line 1309
;1307:
;1308:	// team leader
;1309:	v = Info_ValueForKey( configstring, "tl" );
ADDRLP4 1656
INDIRP4
ARGP4
ADDRGP4 $722
ARGP4
ADDRLP4 1752
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1752
INDIRP4
ASGNP4
line 1310
;1310:	newInfo.teamLeader = atoi(v);
ADDRLP4 1652
INDIRP4
ARGP4
ADDRLP4 1756
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+104
ADDRLP4 1756
INDIRI4
ASGNI4
line 1313
;1311:
;1312:	// model
;1313:	v = Info_ValueForKey( configstring, "model" );
ADDRLP4 1656
INDIRP4
ARGP4
ADDRGP4 $606
ARGP4
ADDRLP4 1760
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1760
INDIRP4
ASGNP4
line 1314
;1314:	CG_SetSkinAndModel( &newInfo, ci, v, allowNativeModel, clientNum, myClientNum, myTeam, qtrue, 
ADDRLP4 0
ARGP4
ADDRLP4 1668
INDIRP4
ARGP4
ADDRLP4 1652
INDIRP4
ARGP4
ADDRLP4 1676
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1672
INDIRI4
ARGI4
ADDRLP4 1664
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 0+128
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 0+192
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 CG_SetSkinAndModel
CALLV
pop
line 1318
;1315:		newInfo.modelName, sizeof( newInfo.modelName ),	newInfo.skinName, sizeof( newInfo.skinName ) );
;1316:
;1317:	// head model
;1318:	v = Info_ValueForKey( configstring, "hmodel" );
ADDRLP4 1656
INDIRP4
ARGP4
ADDRGP4 $728
ARGP4
ADDRLP4 1764
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1652
ADDRLP4 1764
INDIRP4
ASGNP4
line 1319
;1319:	CG_SetSkinAndModel( &newInfo, ci, v, allowNativeModel, clientNum, myClientNum, myTeam, qfalse, 
ADDRLP4 0
ARGP4
ADDRLP4 1668
INDIRP4
ARGP4
ADDRLP4 1652
INDIRP4
ARGP4
ADDRLP4 1676
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1672
INDIRI4
ARGI4
ADDRLP4 1664
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0+256
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 0+320
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 CG_SetSkinAndModel
CALLV
pop
line 1323
;1320:		newInfo.headModelName, sizeof( newInfo.headModelName ),	newInfo.headSkinName, sizeof( newInfo.headSkinName ) );
;1321:
;1322:	// allow deferred load at some conditions
;1323:	can_defer = cg_deferPlayers.integer == 2 || ( cg_deferPlayers.integer == 1 && myTeam != TEAM_SPECTATOR && team == TEAM_SPECTATOR );
ADDRGP4 cg_deferPlayers+12
INDIRI4
CNSTI4 2
EQI4 $738
ADDRGP4 cg_deferPlayers+12
INDIRI4
CNSTI4 1
NEI4 $736
ADDRLP4 1664
INDIRI4
CNSTI4 3
EQI4 $736
ADDRLP4 1660
INDIRI4
CNSTI4 3
NEI4 $736
LABELV $738
ADDRLP4 1768
CNSTI4 1
ASGNI4
ADDRGP4 $737
JUMPV
LABELV $736
ADDRLP4 1768
CNSTI4 0
ASGNI4
LABELV $737
ADDRLP4 1680
ADDRLP4 1768
INDIRI4
ASGNI4
line 1327
;1324:
;1325:	// scan for an existing clientinfo that matches this modelname
;1326:	// so we can avoid loading checks if possible
;1327:	if ( !CG_ScanForExistingClientInfo( &newInfo ) ) {
ADDRLP4 0
ARGP4
ADDRLP4 1772
ADDRGP4 CG_ScanForExistingClientInfo
CALLI4
ASGNI4
ADDRLP4 1772
INDIRI4
CNSTI4 0
NEI4 $739
line 1330
;1328:		qboolean	forceDefer;
;1329:
;1330:		forceDefer = trap_MemoryRemaining() < 4000000;
ADDRLP4 1784
ADDRGP4 trap_MemoryRemaining
CALLI4
ASGNI4
ADDRLP4 1784
INDIRI4
CNSTI4 4000000
GEI4 $742
ADDRLP4 1780
CNSTI4 1
ASGNI4
ADDRGP4 $743
JUMPV
LABELV $742
ADDRLP4 1780
CNSTI4 0
ASGNI4
LABELV $743
ADDRLP4 1776
ADDRLP4 1780
INDIRI4
ASGNI4
line 1333
;1331:
;1332:		// if we are defering loads, just have it pick the first valid
;1333:		if ( forceDefer || (can_defer && !cg_buildScript.integer && !cg.loading) )  {
ADDRLP4 1776
INDIRI4
CNSTI4 0
NEI4 $748
ADDRLP4 1680
INDIRI4
CNSTI4 0
EQI4 $744
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
NEI4 $744
ADDRGP4 cg+20
INDIRI4
CNSTI4 0
NEI4 $744
LABELV $748
line 1335
;1334:			// keep whatever they had if it won't violate team skins
;1335:			CG_SetDeferredClientInfo( &newInfo );
ADDRLP4 0
ARGP4
ADDRGP4 CG_SetDeferredClientInfo
CALLV
pop
line 1337
;1336:			// if we are low on memory, leave them with this model
;1337:			if ( forceDefer ) {
ADDRLP4 1776
INDIRI4
CNSTI4 0
EQI4 $745
line 1338
;1338:				CG_Printf( "Memory is low. Using deferred model.\n" );
ADDRGP4 $751
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1339
;1339:				newInfo.deferred = qfalse;
ADDRLP4 0+384
CNSTI4 0
ASGNI4
line 1340
;1340:			}
line 1341
;1341:		} else {
ADDRGP4 $745
JUMPV
LABELV $744
line 1342
;1342:			CG_LoadClientInfo( &newInfo );
ADDRLP4 0
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 1343
;1343:		}
LABELV $745
line 1344
;1344:	}
LABELV $739
line 1347
;1345:
;1346:	// replace whatever was there with the new one
;1347:	newInfo.infoValid = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1348
;1348:	*ci = newInfo;
ADDRLP4 1668
INDIRP4
ADDRLP4 0
INDIRB
ASGNB 1652
line 1349
;1349:}
LABELV $640
endproc CG_NewClientInfo 1788 48
export CG_LoadDeferredPlayers
proc CG_LoadDeferredPlayers 16 4
line 1361
;1350:
;1351:
;1352:/*
;1353:======================
;1354:CG_LoadDeferredPlayers
;1355:
;1356:Called each frame when a player is dead
;1357:and the scoreboard is up
;1358:so deferred players can be loaded
;1359:======================
;1360:*/
;1361:void CG_LoadDeferredPlayers( void ) {
line 1366
;1362:	int		i;
;1363:	clientInfo_t	*ci;
;1364:
;1365:	// scan for a deferred player to load
;1366:	for ( i = 0, ci = cgs.clientinfo ; i < cgs.maxclients ; i++, ci++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 cgs+40996
ASGNP4
ADDRGP4 $757
JUMPV
LABELV $754
line 1367
;1367:		if ( ci->infoValid && ci->deferred ) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $760
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
EQI4 $760
line 1369
;1368:			// if we are low on memory, leave it deferred
;1369:			if ( trap_MemoryRemaining() < 4000000 ) {
ADDRLP4 12
ADDRGP4 trap_MemoryRemaining
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 4000000
GEI4 $762
line 1370
;1370:				CG_Printf( "Memory is low.  Using deferred model.\n" );
ADDRGP4 $764
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1371
;1371:				ci->deferred = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 0
ASGNI4
line 1372
;1372:				continue;
ADDRGP4 $755
JUMPV
LABELV $762
line 1374
;1373:			}
;1374:			CG_LoadClientInfo( ci );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 1376
;1375://			break;
;1376:		}
LABELV $760
line 1377
;1377:	}
LABELV $755
line 1366
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1652
ADDP4
ASGNP4
LABELV $757
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31504
INDIRI4
LTI4 $754
line 1378
;1378:}
LABELV $753
endproc CG_LoadDeferredPlayers 16 4
proc CG_SetLerpFrameAnimation 12 8
line 1396
;1379:
;1380:/*
;1381:=============================================================================
;1382:
;1383:PLAYER ANIMATION
;1384:
;1385:=============================================================================
;1386:*/
;1387:
;1388:
;1389:/*
;1390:===============
;1391:CG_SetLerpFrameAnimation
;1392:
;1393:may include ANIM_TOGGLEBIT
;1394:===============
;1395:*/
;1396:static void CG_SetLerpFrameAnimation( clientInfo_t *ci, lerpFrame_t *lf, int newAnimation ) {
line 1399
;1397:	animation_t	*anim;
;1398:
;1399:	lf->animationNumber = newAnimation;
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 1400
;1400:	newAnimation &= ~ANIM_TOGGLEBIT;
ADDRFP4 8
ADDRFP4 8
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1402
;1401:
;1402:	if ( newAnimation < 0 || newAnimation >= MAX_TOTALANIMATIONS ) {
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $768
ADDRLP4 4
INDIRI4
CNSTI4 37
LTI4 $766
LABELV $768
line 1403
;1403:		CG_Error( "Bad animation number: %i", newAnimation );
ADDRGP4 $769
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1404
;1404:	}
LABELV $766
line 1406
;1405:
;1406:	anim = &ci->animations[ newAnimation ];
ADDRLP4 0
ADDRFP4 8
INDIRI4
CNSTI4 28
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
ADDP4
ASGNP4
line 1408
;1407:
;1408:	lf->animation = anim;
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1409
;1409:	lf->animationTime = lf->frameTime + anim->initialLerp;
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1411
;1410:
;1411:	if ( cg_debugAnim.integer ) {
ADDRGP4 cg_debugAnim+12
INDIRI4
CNSTI4 0
EQI4 $770
line 1412
;1412:		CG_Printf( "Anim: %i\n", newAnimation );
ADDRGP4 $773
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 1413
;1413:	}
LABELV $770
line 1414
;1414:}
LABELV $765
endproc CG_SetLerpFrameAnimation 12 8
proc CG_RunLerpFrame 36 12
line 1425
;1415:
;1416:
;1417:/*
;1418:===============
;1419:CG_RunLerpFrame
;1420:
;1421:Sets cg.snap, cg.oldFrame, and cg.backlerp
;1422:cg.time should be between oldFrameTime and frameTime after exit
;1423:===============
;1424:*/
;1425:static void CG_RunLerpFrame( clientInfo_t *ci, lerpFrame_t *lf, int newAnimation, float speedScale ) {
line 1430
;1426:	int			f, numFrames;
;1427:	animation_t	*anim;
;1428:
;1429:	// debugging tool to get no animations
;1430:	if ( cg_animSpeed.integer == 0 ) {
ADDRGP4 cg_animSpeed+12
INDIRI4
CNSTI4 0
NEI4 $775
line 1431
;1431:		lf->oldFrame = lf->frame = lf->backlerp = 0;
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
CNSTF4 0
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 20
ADDRLP4 16
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 20
INDIRI4
ASGNI4
line 1432
;1432:		return;
ADDRGP4 $774
JUMPV
LABELV $775
line 1436
;1433:	}
;1434:
;1435:	// see if the animation sequence is switching
;1436:	if ( newAnimation != lf->animationNumber || !lf->animation ) {
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 8
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
NEI4 $780
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $778
LABELV $780
line 1437
;1437:		CG_SetLerpFrameAnimation( ci, lf, newAnimation );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_SetLerpFrameAnimation
CALLV
pop
line 1438
;1438:	}
LABELV $778
line 1442
;1439:
;1440:	// if we have passed the current frame, move it to
;1441:	// oldFrame and calculate a new frame
;1442:	if ( cg.time >= lf->frameTime ) {
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
LTI4 $781
line 1443
;1443:		lf->oldFrame = lf->frame;
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1444
;1444:		lf->oldFrameTime = lf->frameTime;
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1447
;1445:
;1446:		// get the next frame based on the animation
;1447:		anim = lf->animation;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
ASGNP4
line 1448
;1448:		if ( !anim->frameLerp ) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
NEI4 $784
line 1449
;1449:			return;		// shouldn't happen
ADDRGP4 $774
JUMPV
LABELV $784
line 1451
;1450:		}
;1451:		if ( cg.time < lf->animationTime ) {
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
GEI4 $786
line 1452
;1452:			lf->frameTime = lf->animationTime;		// initial lerp
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ASGNI4
line 1453
;1453:		} else {
ADDRGP4 $787
JUMPV
LABELV $786
line 1454
;1454:			lf->frameTime = lf->oldFrameTime + anim->frameLerp;
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1455
;1455:		}
LABELV $787
line 1456
;1456:		f = ( lf->frameTime - lf->animationTime ) / anim->frameLerp;
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
SUBI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
DIVI4
ASGNI4
line 1457
;1457:		f *= speedScale;		// adjust for haste, etc
ADDRLP4 4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRFP4 12
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1459
;1458:
;1459:		numFrames = anim->numFrames;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1460
;1460:		if (anim->flipflop) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $789
line 1461
;1461:			numFrames *= 2;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 1462
;1462:		}
LABELV $789
line 1463
;1463:		if ( f >= numFrames ) {
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $791
line 1464
;1464:			f -= numFrames;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1465
;1465:			if ( anim->loopFrames ) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
EQI4 $793
line 1466
;1466:				f %= anim->loopFrames;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MODI4
ASGNI4
line 1467
;1467:				f += anim->numFrames - anim->loopFrames;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
ADDI4
ASGNI4
line 1468
;1468:			} else {
ADDRGP4 $794
JUMPV
LABELV $793
line 1469
;1469:				f = numFrames - 1;
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1472
;1470:				// the animation is stuck at the end, so it
;1471:				// can immediately transition to another sequence
;1472:				lf->frameTime = cg.time;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1473
;1473:			}
LABELV $794
line 1474
;1474:		}
LABELV $791
line 1475
;1475:		if ( anim->reversed ) {
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
EQI4 $796
line 1476
;1476:			lf->frame = anim->firstFrame + anim->numFrames - 1 - f;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 1477
;1477:		}
ADDRGP4 $797
JUMPV
LABELV $796
line 1478
;1478:		else if (anim->flipflop && f>=anim->numFrames) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $798
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LTI4 $798
line 1479
;1479:			lf->frame = anim->firstFrame + anim->numFrames - 1 - (f%anim->numFrames);
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
MODI4
SUBI4
ASGNI4
line 1480
;1480:		}
ADDRGP4 $799
JUMPV
LABELV $798
line 1481
;1481:		else {
line 1482
;1482:			lf->frame = anim->firstFrame + f;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1483
;1483:		}
LABELV $799
LABELV $797
line 1484
;1484:		if ( cg.time > lf->frameTime ) {
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
LEI4 $800
line 1485
;1485:			lf->frameTime = cg.time;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1486
;1486:			if ( cg_debugAnim.integer ) {
ADDRGP4 cg_debugAnim+12
INDIRI4
CNSTI4 0
EQI4 $804
line 1487
;1487:				CG_Printf( "Clamp lf->frameTime\n");
ADDRGP4 $807
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1488
;1488:			}
LABELV $804
line 1489
;1489:		}
LABELV $800
line 1490
;1490:	}
LABELV $781
line 1492
;1491:
;1492:	if ( lf->frameTime > cg.time + 200 ) {
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 200
ADDI4
LEI4 $808
line 1493
;1493:		lf->frameTime = cg.time;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1494
;1494:	}
LABELV $808
line 1496
;1495:
;1496:	if ( lf->oldFrameTime > cg.time ) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $812
line 1497
;1497:		lf->oldFrameTime = cg.time;
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1498
;1498:	}
LABELV $812
line 1500
;1499:	// calculate current lerp value
;1500:	if ( lf->frameTime == lf->oldFrameTime ) {
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
NEI4 $816
line 1501
;1501:		lf->backlerp = 0;
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 0
ASGNF4
line 1502
;1502:	} else {
ADDRGP4 $817
JUMPV
LABELV $816
line 1503
;1503:		lf->backlerp = 1.0 - (float)( cg.time - lf->oldFrameTime ) / ( lf->frameTime - lf->oldFrameTime );
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 1065353216
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
SUBI4
CVIF4 4
DIVF4
SUBF4
ASGNF4
line 1504
;1504:	}
LABELV $817
line 1505
;1505:}
LABELV $774
endproc CG_RunLerpFrame 36 12
proc CG_ClearLerpFrame 16 12
line 1513
;1506:
;1507:
;1508:/*
;1509:===============
;1510:CG_ClearLerpFrame
;1511:===============
;1512:*/
;1513:static void CG_ClearLerpFrame( clientInfo_t *ci, lerpFrame_t *lf, int animationNumber ) {
line 1514
;1514:	lf->frameTime = lf->oldFrameTime = cg.time;
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1515
;1515:	CG_SetLerpFrameAnimation( ci, lf, animationNumber );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_SetLerpFrameAnimation
CALLV
pop
line 1516
;1516:	lf->oldFrame = lf->frame = lf->animation->firstFrame;
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1517
;1517:}
LABELV $819
endproc CG_ClearLerpFrame 16 12
proc CG_PlayerAnimation 20 16
line 1526
;1518:
;1519:
;1520:/*
;1521:===============
;1522:CG_PlayerAnimation
;1523:===============
;1524:*/
;1525:static void CG_PlayerAnimation( centity_t *cent, int *legsOld, int *legs, float *legsBackLerp,
;1526:						int *torsoOld, int *torso, float *torsoBackLerp ) {
line 1531
;1527:	clientInfo_t	*ci;
;1528:	int				clientNum;
;1529:	float			speedScale;
;1530:
;1531:	clientNum = cent->currentState.clientNum;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 1533
;1532:
;1533:	if ( cg_noPlayerAnims.integer ) {
ADDRGP4 cg_noPlayerAnims+12
INDIRI4
CNSTI4 0
EQI4 $822
line 1534
;1534:		*legsOld = *legs = *torsoOld = *torso = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRFP4 20
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1535
;1535:		return;
ADDRGP4 $821
JUMPV
LABELV $822
line 1538
;1536:	}
;1537:
;1538:	if ( cent->currentState.powerups & ( 1 << PW_HASTE ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $825
line 1539
;1539:		speedScale = 1.5;
ADDRLP4 4
CNSTF4 1069547520
ASGNF4
line 1540
;1540:	} else {
ADDRGP4 $826
JUMPV
LABELV $825
line 1541
;1541:		speedScale = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1542
;1542:	}
LABELV $826
line 1544
;1543:
;1544:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 1547
;1545:
;1546:	// do the shuffle turn frames locally
;1547:	if ( cent->pe.legs.yawing && ( cent->currentState.legsAnim & ~ANIM_TOGGLEBIT ) == LEGS_IDLE ) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
CNSTI4 0
EQI4 $828
ADDRLP4 12
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
CNSTI4 22
NEI4 $828
line 1548
;1548:		CG_RunLerpFrame( ci, &cent->pe.legs, LEGS_TURN, speedScale );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
ARGP4
CNSTI4 24
ARGI4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 CG_RunLerpFrame
CALLV
pop
line 1549
;1549:	} else {
ADDRGP4 $829
JUMPV
LABELV $828
line 1550
;1550:		CG_RunLerpFrame( ci, &cent->pe.legs, cent->currentState.legsAnim, speedScale );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 460
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 CG_RunLerpFrame
CALLV
pop
line 1551
;1551:	}
LABELV $829
line 1553
;1552:
;1553:	*legsOld = cent->pe.legs.oldFrame;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
ASGNI4
line 1554
;1554:	*legs = cent->pe.legs.frame;
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
ASGNI4
line 1555
;1555:	*legsBackLerp = cent->pe.legs.backlerp;
ADDRFP4 12
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRF4
ASGNF4
line 1557
;1556:
;1557:	CG_RunLerpFrame( ci, &cent->pe.torso, cent->currentState.torsoAnim, speedScale );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 CG_RunLerpFrame
CALLV
pop
line 1559
;1558:
;1559:	*torsoOld = cent->pe.torso.oldFrame;
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 508
ADDP4
INDIRI4
ASGNI4
line 1560
;1560:	*torso = cent->pe.torso.frame;
ADDRFP4 20
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRI4
ASGNI4
line 1561
;1561:	*torsoBackLerp = cent->pe.torso.backlerp;
ADDRFP4 24
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRF4
ASGNF4
line 1562
;1562:}
LABELV $821
endproc CG_PlayerAnimation 20 16
proc CG_SwingAngles 28 8
line 1578
;1563:
;1564:/*
;1565:=============================================================================
;1566:
;1567:PLAYER ANGLES
;1568:
;1569:=============================================================================
;1570:*/
;1571:
;1572:/*
;1573:==================
;1574:CG_SwingAngles
;1575:==================
;1576:*/
;1577:static void CG_SwingAngles( float destination, float swingTolerance, float clampTolerance,
;1578:					float speed, float *angle, qboolean *swinging ) {
line 1583
;1579:	float	swing;
;1580:	float	move;
;1581:	float	scale;
;1582:
;1583:	if ( !*swinging ) {
ADDRFP4 20
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $831
line 1585
;1584:		// see if a swing should be started
;1585:		swing = AngleSubtract( *angle, destination );
ADDRFP4 16
INDIRP4
INDIRF4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 1586
;1586:		if ( swing > swingTolerance || swing < -swingTolerance ) {
ADDRLP4 20
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRF4
GTF4 $835
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRF4
NEGF4
GEF4 $833
LABELV $835
line 1587
;1587:			*swinging = qtrue;
ADDRFP4 20
INDIRP4
CNSTI4 1
ASGNI4
line 1588
;1588:		}
LABELV $833
line 1589
;1589:	}
LABELV $831
line 1591
;1590:
;1591:	if ( !*swinging ) {
ADDRFP4 20
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $836
line 1592
;1592:		return;
ADDRGP4 $830
JUMPV
LABELV $836
line 1597
;1593:	}
;1594:	
;1595:	// modify the speed depending on the delta
;1596:	// so it doesn't seem so linear
;1597:	swing = AngleSubtract( destination, *angle );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 1598
;1598:	scale = fabs( swing );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 16
INDIRF4
ASGNF4
line 1599
;1599:	if ( scale < swingTolerance * 0.5 ) {
ADDRLP4 4
INDIRF4
ADDRFP4 4
INDIRF4
CNSTF4 1056964608
MULF4
GEF4 $838
line 1600
;1600:		scale = 0.5;
ADDRLP4 4
CNSTF4 1056964608
ASGNF4
line 1601
;1601:	} else if ( scale < swingTolerance ) {
ADDRGP4 $839
JUMPV
LABELV $838
ADDRLP4 4
INDIRF4
ADDRFP4 4
INDIRF4
GEF4 $840
line 1602
;1602:		scale = 1.0;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1603
;1603:	} else {
ADDRGP4 $841
JUMPV
LABELV $840
line 1604
;1604:		scale = 2.0;
ADDRLP4 4
CNSTF4 1073741824
ASGNF4
line 1605
;1605:	}
LABELV $841
LABELV $839
line 1608
;1606:
;1607:	// swing towards the destination angle
;1608:	if ( swing >= 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LTF4 $842
line 1609
;1609:		move = cg.frametime * scale * speed;
ADDRLP4 8
ADDRGP4 cg+107600
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
MULF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
line 1610
;1610:		if ( move >= swing ) {
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
LTF4 $845
line 1611
;1611:			move = swing;
ADDRLP4 8
ADDRLP4 0
INDIRF4
ASGNF4
line 1612
;1612:			*swinging = qfalse;
ADDRFP4 20
INDIRP4
CNSTI4 0
ASGNI4
line 1613
;1613:		}
LABELV $845
line 1614
;1614:		*angle = AngleMod( *angle + move );
ADDRLP4 20
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1615
;1615:	} else {
ADDRGP4 $843
JUMPV
LABELV $842
line 1616
;1616:		move = cg.frametime * scale * -speed;
ADDRLP4 8
ADDRGP4 cg+107600
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
MULF4
ADDRFP4 12
INDIRF4
NEGF4
MULF4
ASGNF4
line 1617
;1617:		if ( move <= swing ) {
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
GTF4 $848
line 1618
;1618:			move = swing;
ADDRLP4 8
ADDRLP4 0
INDIRF4
ASGNF4
line 1619
;1619:			*swinging = qfalse;
ADDRFP4 20
INDIRP4
CNSTI4 0
ASGNI4
line 1620
;1620:		}
LABELV $848
line 1621
;1621:		*angle = AngleMod( *angle + move );
ADDRLP4 20
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1622
;1622:	}
LABELV $843
line 1625
;1623:
;1624:	// clamp to no more than tolerance
;1625:	swing = AngleSubtract( destination, *angle );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 1626
;1626:	if ( swing > clampTolerance ) {
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
LEF4 $850
line 1627
;1627:		*angle = AngleMod( destination - (clampTolerance - 1) );
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
SUBF4
SUBF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 16
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1628
;1628:	} else if ( swing < -clampTolerance ) {
ADDRGP4 $851
JUMPV
LABELV $850
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
NEGF4
GEF4 $852
line 1629
;1629:		*angle = AngleMod( destination + (clampTolerance - 1) );
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
SUBF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 16
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1630
;1630:	}
LABELV $852
LABELV $851
line 1631
;1631:}
LABELV $830
endproc CG_SwingAngles 28 8
proc CG_AddPainTwitch 12 0
line 1639
;1632:
;1633:
;1634:/*
;1635:=================
;1636:CG_AddPainTwitch
;1637:=================
;1638:*/
;1639:static void CG_AddPainTwitch( centity_t *cent, vec3_t torsoAngles ) {
line 1643
;1640:	int		t;
;1641:	float	f;
;1642:
;1643:	t = cg.time - cent->pe.painTime;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1644
;1644:	if ( t >= PAIN_TWITCH_TIME ) {
ADDRLP4 0
INDIRI4
CNSTI4 200
LTI4 $856
line 1645
;1645:		return;
ADDRGP4 $854
JUMPV
LABELV $856
line 1648
;1646:	}
;1647:
;1648:	f = 1.0 - (float)t / PAIN_TWITCH_TIME;
ADDRLP4 4
CNSTF4 1065353216
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1000593162
MULF4
SUBF4
ASGNF4
line 1650
;1649:
;1650:	if ( cent->pe.painDirection ) {
ADDRFP4 0
INDIRP4
CNSTI4 608
ADDP4
INDIRI4
CNSTI4 0
EQI4 $858
line 1651
;1651:		torsoAngles[ROLL] += 20 * f;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
CNSTF4 1101004800
MULF4
ADDF4
ASGNF4
line 1652
;1652:	} else {
ADDRGP4 $859
JUMPV
LABELV $858
line 1653
;1653:		torsoAngles[ROLL] -= 20 * f;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
CNSTF4 1101004800
MULF4
SUBF4
ASGNF4
line 1654
;1654:	}
LABELV $859
line 1655
;1655:}
LABELV $854
endproc CG_AddPainTwitch 12 0
data
align 4
LABELV $861
byte 4 0
byte 4 22
byte 4 45
byte 4 -22
byte 4 0
byte 4 22
byte 4 -45
byte 4 -22
code
proc CG_PlayerAngles 136 24
line 1672
;1656:
;1657:
;1658:/*
;1659:===============
;1660:CG_PlayerAngles
;1661:
;1662:Handles seperate torso motion
;1663:
;1664:  legs pivot based on direction of movement
;1665:
;1666:  head always looks exactly at cent->lerpAngles
;1667:
;1668:  if motion < 20 degrees, show in head only
;1669:  if < 45 degrees, also show in torso
;1670:===============
;1671:*/
;1672:static void CG_PlayerAngles( centity_t *cent, vec3_t legs[3], vec3_t torso[3], vec3_t head[3] ) {
line 1681
;1673:	vec3_t		legsAngles, torsoAngles, headAngles;
;1674:	float		dest;
;1675:	static	int	movementOffsets[8] = { 0, 22, 45, -22, 0, 22, -45, -22 };
;1676:	vec3_t		velocity;
;1677:	float		speed;
;1678:	int			dir, clientNum;
;1679:	clientInfo_t	*ci;
;1680:
;1681:	VectorCopy( cent->lerpAngles, headAngles );
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 1682
;1682:	headAngles[YAW] = AngleMod( headAngles[YAW] );
ADDRLP4 24+4
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 68
INDIRF4
ASGNF4
line 1683
;1683:	VectorClear( legsAngles );
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 12+4
CNSTF4 0
ASGNF4
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 1684
;1684:	VectorClear( torsoAngles );
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRLP4 0+4
CNSTF4 0
ASGNF4
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 1689
;1685:
;1686:	// --------- yaw -------------
;1687:
;1688:	// allow yaw to drift a bit
;1689:	if ( ( cent->currentState.legsAnim & ~ANIM_TOGGLEBIT ) != LEGS_IDLE 
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
CNSTI4 22
NEI4 $870
ADDRLP4 72
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
CNSTI4 11
EQI4 $868
ADDRLP4 72
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
CNSTI4 12
EQI4 $868
LABELV $870
line 1691
;1690:		|| ((cent->currentState.torsoAnim & ~ANIM_TOGGLEBIT) != TORSO_STAND 
;1691:		&& (cent->currentState.torsoAnim & ~ANIM_TOGGLEBIT) != TORSO_STAND2)) {
line 1693
;1692:		// if not standing still, always point all in the same direction
;1693:		cent->pe.torso.yawing = qtrue;	// always center
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 1
ASGNI4
line 1694
;1694:		cent->pe.torso.pitching = qtrue;	// always center
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
CNSTI4 1
ASGNI4
line 1695
;1695:		cent->pe.legs.yawing = qtrue;	// always center
ADDRFP4 0
INDIRP4
CNSTI4 484
ADDP4
CNSTI4 1
ASGNI4
line 1696
;1696:	}
LABELV $868
line 1699
;1697:
;1698:	// adjust legs for movement dir
;1699:	if ( cent->currentState.eFlags & EF_DEAD ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $871
line 1701
;1700:		// don't let dead bodies twitch
;1701:		dir = 0;
ADDRLP4 52
CNSTI4 0
ASGNI4
line 1702
;1702:	} else {
ADDRGP4 $872
JUMPV
LABELV $871
line 1703
;1703:		dir = cent->currentState.angles2[YAW];
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 132
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 1704
;1704:		if ( dir < 0 || dir > 7 ) {
ADDRLP4 52
INDIRI4
CNSTI4 0
LTI4 $875
ADDRLP4 52
INDIRI4
CNSTI4 7
LEI4 $873
LABELV $875
line 1705
;1705:			CG_Error( "Bad player movement angle" );
ADDRGP4 $876
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 1706
;1706:		}
LABELV $873
line 1707
;1707:	}
LABELV $872
line 1708
;1708:	legsAngles[YAW] = headAngles[YAW] + movementOffsets[ dir ];
ADDRLP4 12+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $861
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1709
;1709:	torsoAngles[YAW] = headAngles[YAW] + 0.25 * movementOffsets[ dir ];
ADDRLP4 0+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $861
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1048576000
MULF4
ADDF4
ASGNF4
line 1712
;1710:
;1711:	// torso
;1712:	CG_SwingAngles( torsoAngles[YAW], 25, 90, cg_swingSpeed.value, &cent->pe.torso.yawAngle, &cent->pe.torso.yawing );
ADDRLP4 0+4
INDIRF4
ARGF4
CNSTF4 1103626240
ARGF4
CNSTF4 1119092736
ARGF4
ADDRGP4 cg_swingSpeed+8
INDIRF4
ARGF4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 528
ADDP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 532
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLV
pop
line 1713
;1713:	CG_SwingAngles( legsAngles[YAW], 40, 90, cg_swingSpeed.value, &cent->pe.legs.yawAngle, &cent->pe.legs.yawing );
ADDRLP4 12+4
INDIRF4
ARGF4
CNSTF4 1109393408
ARGF4
CNSTF4 1119092736
ARGF4
ADDRGP4 cg_swingSpeed+8
INDIRF4
ARGF4
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 480
ADDP4
ARGP4
ADDRLP4 80
INDIRP4
CNSTI4 484
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLV
pop
line 1715
;1714:
;1715:	torsoAngles[YAW] = cent->pe.torso.yawAngle;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ASGNF4
line 1716
;1716:	legsAngles[YAW] = cent->pe.legs.yawAngle;
ADDRLP4 12+4
ADDRFP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
ASGNF4
line 1722
;1717:
;1718:
;1719:	// --------- pitch -------------
;1720:
;1721:	// only show a fraction of the pitch angle in the torso
;1722:	if ( headAngles[PITCH] > 180 ) {
ADDRLP4 24
INDIRF4
CNSTF4 1127481344
LEF4 $887
line 1723
;1723:		dest = (-360 + headAngles[PITCH]) * 0.75f;
ADDRLP4 60
ADDRLP4 24
INDIRF4
CNSTF4 3283353600
ADDF4
CNSTF4 1061158912
MULF4
ASGNF4
line 1724
;1724:	} else {
ADDRGP4 $888
JUMPV
LABELV $887
line 1725
;1725:		dest = headAngles[PITCH] * 0.75f;
ADDRLP4 60
ADDRLP4 24
INDIRF4
CNSTF4 1061158912
MULF4
ASGNF4
line 1726
;1726:	}
LABELV $888
line 1727
;1727:	CG_SwingAngles( dest, 15, 30, 0.1f, &cent->pe.torso.pitchAngle, &cent->pe.torso.pitching );
ADDRLP4 60
INDIRF4
ARGF4
CNSTF4 1097859072
ARGF4
CNSTF4 1106247680
ARGF4
CNSTF4 1036831949
ARGF4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 536
ADDP4
ARGP4
ADDRLP4 84
INDIRP4
CNSTI4 540
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLV
pop
line 1728
;1728:	torsoAngles[PITCH] = cent->pe.torso.pitchAngle;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRF4
ASGNF4
line 1731
;1729:
;1730:	//
;1731:	clientNum = cent->currentState.clientNum;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 1732
;1732:	if ( clientNum >= 0 && clientNum < MAX_CLIENTS ) {
ADDRLP4 36
INDIRI4
CNSTI4 0
LTI4 $889
ADDRLP4 36
INDIRI4
CNSTI4 64
GEI4 $889
line 1733
;1733:		ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 64
ADDRLP4 36
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 1734
;1734:		if ( ci->fixedtorso ) {
ADDRLP4 64
INDIRP4
CNSTI4 396
ADDP4
INDIRI4
CNSTI4 0
EQI4 $892
line 1735
;1735:			torsoAngles[PITCH] = 0.0f;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1736
;1736:		}
LABELV $892
line 1737
;1737:	}
LABELV $889
line 1743
;1738:
;1739:	// --------- roll -------------
;1740:
;1741:
;1742:	// lean towards the direction of travel
;1743:	VectorCopy( cent->currentState.pos.trDelta, velocity );
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1744
;1744:	speed = VectorNormalize( velocity );
ADDRLP4 40
ARGP4
ADDRLP4 92
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 56
ADDRLP4 92
INDIRF4
ASGNF4
line 1745
;1745:	if ( speed ) {
ADDRLP4 56
INDIRF4
CNSTF4 0
EQF4 $894
line 1749
;1746:		vec3_t	axis[3];
;1747:		float	side;
;1748:
;1749:		speed *= 0.05f;
ADDRLP4 56
ADDRLP4 56
INDIRF4
CNSTF4 1028443341
MULF4
ASGNF4
line 1751
;1750:
;1751:		AnglesToAxis( legsAngles, axis );
ADDRLP4 12
ARGP4
ADDRLP4 96
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1752
;1752:		side = speed * DotProduct( velocity, axis[1] );
ADDRLP4 132
ADDRLP4 56
INDIRF4
ADDRLP4 40
INDIRF4
ADDRLP4 96+12
INDIRF4
MULF4
ADDRLP4 40+4
INDIRF4
ADDRLP4 96+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 96+12+8
INDIRF4
MULF4
ADDF4
MULF4
ASGNF4
line 1753
;1753:		legsAngles[ROLL] -= side;
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 132
INDIRF4
SUBF4
ASGNF4
line 1755
;1754:
;1755:		side = speed * DotProduct( velocity, axis[0] );
ADDRLP4 132
ADDRLP4 56
INDIRF4
ADDRLP4 40
INDIRF4
ADDRLP4 96
INDIRF4
MULF4
ADDRLP4 40+4
INDIRF4
ADDRLP4 96+4
INDIRF4
MULF4
ADDF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 96+8
INDIRF4
MULF4
ADDF4
MULF4
ASGNF4
line 1756
;1756:		legsAngles[PITCH] += side;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 132
INDIRF4
ADDF4
ASGNF4
line 1757
;1757:	}
LABELV $894
line 1760
;1758:
;1759:	//
;1760:	clientNum = cent->currentState.clientNum;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 1761
;1761:	if ( clientNum >= 0 && clientNum < MAX_CLIENTS ) {
ADDRLP4 36
INDIRI4
CNSTI4 0
LTI4 $908
ADDRLP4 36
INDIRI4
CNSTI4 64
GEI4 $908
line 1762
;1762:		ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 64
ADDRLP4 36
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 1763
;1763:		if ( ci->fixedlegs ) {
ADDRLP4 64
INDIRP4
CNSTI4 392
ADDP4
INDIRI4
CNSTI4 0
EQI4 $911
line 1764
;1764:			legsAngles[YAW] = torsoAngles[YAW];
ADDRLP4 12+4
ADDRLP4 0+4
INDIRF4
ASGNF4
line 1765
;1765:			legsAngles[PITCH] = 0.0f;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 1766
;1766:			legsAngles[ROLL] = 0.0f;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 1767
;1767:		}
LABELV $911
line 1768
;1768:	}
LABELV $908
line 1771
;1769:
;1770:	// pain twitch
;1771:	CG_AddPainTwitch( cent, torsoAngles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_AddPainTwitch
CALLV
pop
line 1774
;1772:
;1773:	// pull the angles back out of the hierarchial chain
;1774:	AnglesSubtract( headAngles, torsoAngles, headAngles );
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 AnglesSubtract
CALLV
pop
line 1775
;1775:	AnglesSubtract( torsoAngles, legsAngles, torsoAngles );
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 AnglesSubtract
CALLV
pop
line 1776
;1776:	AnglesToAxis( legsAngles, legs );
ADDRLP4 12
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1777
;1777:	AnglesToAxis( torsoAngles, torso );
ADDRLP4 0
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1778
;1778:	AnglesToAxis( headAngles, head );
ADDRLP4 24
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1779
;1779:}
LABELV $860
endproc CG_PlayerAngles 136 24
proc CG_HasteTrail 32 48
line 1789
;1780:
;1781:
;1782://==========================================================================
;1783:
;1784:/*
;1785:===============
;1786:CG_HasteTrail
;1787:===============
;1788:*/
;1789:static void CG_HasteTrail( centity_t *cent ) {
line 1794
;1790:	localEntity_t	*smoke;
;1791:	vec3_t			origin;
;1792:	int				anim;
;1793:
;1794:	if ( cent->trailTime > cg.time ) {
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $917
line 1795
;1795:		return;
ADDRGP4 $916
JUMPV
LABELV $917
line 1797
;1796:	}
;1797:	anim = cent->pe.legs.animationNumber & ~ANIM_TOGGLEBIT;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1798
;1798:	if ( anim != LEGS_RUN && anim != LEGS_BACK ) {
ADDRLP4 12
INDIRI4
CNSTI4 15
EQI4 $920
ADDRLP4 12
INDIRI4
CNSTI4 16
EQI4 $920
line 1799
;1799:		return;
ADDRGP4 $916
JUMPV
LABELV $920
line 1802
;1800:	}
;1801:
;1802:	cent->trailTime += 100;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 1803
;1803:	if ( cent->trailTime < cg.time ) {
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $922
line 1804
;1804:		cent->trailTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1805
;1805:	}
LABELV $922
line 1807
;1806:
;1807:	VectorCopy( cent->lerpOrigin, origin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 1808
;1808:	origin[2] -= 16;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1810
;1809:
;1810:	smoke = CG_SmokePuff( origin, vec3_origin, 
ADDRLP4 0
ARGP4
ADDRGP4 vec3_origin
ARGP4
CNSTF4 1090519040
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1140457472
ARGF4
ADDRGP4 cg+107604
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148772+460
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 CG_SmokePuff
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 28
INDIRP4
ASGNP4
line 1820
;1811:				  8, 
;1812:				  1, 1, 1, 1,
;1813:				  500, 
;1814:				  cg.time,
;1815:				  0,
;1816:				  0,
;1817:				  cgs.media.hastePuffShader );
;1818:
;1819:	// use the optimized local entity add
;1820:	smoke->leType = LE_SCALE_FADE;
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 7
ASGNI4
line 1821
;1821:}
LABELV $916
endproc CG_HasteTrail 32 48
proc CG_BreathPuffs 48 48
line 1830
;1822:
;1823:
;1824:#ifdef MISSIONPACK
;1825:/*
;1826:===============
;1827:CG_BreathPuffs
;1828:===============
;1829:*/
;1830:static void CG_BreathPuffs( centity_t *cent, refEntity_t *head) {
line 1835
;1831:	clientInfo_t *ci;
;1832:	vec3_t up, origin;
;1833:	int contents;
;1834:
;1835:	ci = &cgs.clientinfo[ cent->currentState.number ];
ADDRLP4 24
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 1837
;1836:
;1837:	if (!cg_enableBreath.integer) {
ADDRGP4 cg_enableBreath+12
INDIRI4
CNSTI4 0
NEI4 $932
line 1838
;1838:		return;
ADDRGP4 $930
JUMPV
LABELV $932
line 1840
;1839:	}
;1840:	if ( cent->currentState.number == cg.snap->ps.clientNum && !cg.renderingThirdPerson) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $935
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
NEI4 $935
line 1841
;1841:		return;
ADDRGP4 $930
JUMPV
LABELV $935
line 1843
;1842:	}
;1843:	if ( cent->currentState.eFlags & EF_DEAD ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $939
line 1844
;1844:		return;
ADDRGP4 $930
JUMPV
LABELV $939
line 1846
;1845:	}
;1846:	contents = CG_PointContents( head->origin, 0 );
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 32
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 32
INDIRI4
ASGNI4
line 1847
;1847:	if ( contents & ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ) {
ADDRLP4 28
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $941
line 1848
;1848:		return;
ADDRGP4 $930
JUMPV
LABELV $941
line 1850
;1849:	}
;1850:	if ( ci->breathPuffTime > cg.time ) {
ADDRLP4 24
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $943
line 1851
;1851:		return;
ADDRGP4 $930
JUMPV
LABELV $943
line 1854
;1852:	}
;1853:
;1854:	VectorSet( up, 0, 0, 8 );
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 12+4
CNSTF4 0
ASGNF4
ADDRLP4 12+8
CNSTF4 1090519040
ASGNF4
line 1855
;1855:	VectorMA(head->origin, 8, head->axis[0], origin);
ADDRLP4 36
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 36
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
ADDRLP4 40
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 40
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
line 1856
;1856:	VectorMA(origin, -4, head->axis[2], origin);
ADDRLP4 44
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 52
ADDP4
INDIRF4
CNSTF4 3229614080
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 56
ADDP4
INDIRF4
CNSTF4 3229614080
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
CNSTF4 3229614080
MULF4
ADDF4
ASGNF4
line 1857
;1857:	CG_SmokePuff( origin, up, 16, 1, 1, 1, 0.66f, 1500, cg.time, cg.time + 400, LEF_PUFF_DONT_SCALE, cgs.media.shotgunSmokePuffShader );
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
CNSTF4 1098907648
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1059648963
ARGF4
CNSTF4 1153138688
ARGF4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 400
ADDI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 cgs+148772+316
INDIRI4
ARGI4
ADDRGP4 CG_SmokePuff
CALLP4
pop
line 1858
;1858:	ci->breathPuffTime = cg.time + 2000;
ADDRLP4 24
INDIRP4
CNSTI4 124
ADDP4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 1859
;1859:}
LABELV $930
endproc CG_BreathPuffs 48 48
proc CG_DustTrail 96 48
line 1866
;1860:
;1861:/*
;1862:===============
;1863:CG_DustTrail
;1864:===============
;1865:*/
;1866:static void CG_DustTrail( centity_t *cent ) {
line 1871
;1867:	int				anim;
;1868:	vec3_t end, vel;
;1869:	trace_t tr;
;1870:
;1871:	if (!cg_enableDust.integer)
ADDRGP4 cg_enableDust+12
INDIRI4
CNSTI4 0
NEI4 $960
line 1872
;1872:		return;
ADDRGP4 $959
JUMPV
LABELV $960
line 1874
;1873:
;1874:	if ( cent->dustTrailTime > cg.time ) {
ADDRFP4 0
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $963
line 1875
;1875:		return;
ADDRGP4 $959
JUMPV
LABELV $963
line 1878
;1876:	}
;1877:
;1878:	anim = cent->pe.legs.animationNumber & ~ANIM_TOGGLEBIT;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1879
;1879:	if ( anim != LEGS_LANDB && anim != LEGS_LAND ) {
ADDRLP4 24
INDIRI4
CNSTI4 21
EQI4 $966
ADDRLP4 24
INDIRI4
CNSTI4 19
EQI4 $966
line 1880
;1880:		return;
ADDRGP4 $959
JUMPV
LABELV $966
line 1883
;1881:	}
;1882:
;1883:	cent->dustTrailTime += 40;
ADDRLP4 88
ADDRFP4 0
INDIRP4
CNSTI4 440
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 40
ADDI4
ASGNI4
line 1884
;1884:	if ( cent->dustTrailTime < cg.time ) {
ADDRFP4 0
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $968
line 1885
;1885:		cent->dustTrailTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 440
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1886
;1886:	}
LABELV $968
line 1888
;1887:
;1888:	VectorCopy(cent->currentState.pos.trBase, end);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 1889
;1889:	end[2] -= 64;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1115684864
SUBF4
ASGNF4
line 1890
;1890:	CG_Trace( &tr, cent->currentState.pos.trBase, NULL, NULL, end, cent->currentState.number, MASK_PLAYERSOLID );
ADDRLP4 28
ARGP4
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 92
INDIRP4
INDIRI4
ARGI4
CNSTI4 33619969
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 1892
;1891:
;1892:	if ( !(tr.surfaceFlags & SURF_DUST) )
ADDRLP4 28+44
INDIRI4
CNSTI4 262144
BANDI4
CNSTI4 0
NEI4 $973
line 1893
;1893:		return;
ADDRGP4 $959
JUMPV
LABELV $973
line 1895
;1894:
;1895:	VectorCopy( cent->currentState.pos.trBase, end );
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 1896
;1896:	end[2] -= 16;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1898
;1897:
;1898:	VectorSet(vel, 0, 0, -30);
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 12+4
CNSTF4 0
ASGNF4
ADDRLP4 12+8
CNSTF4 3253731328
ASGNF4
line 1899
;1899:	CG_SmokePuff( end, vel,
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
CNSTF4 1103101952
ARGF4
CNSTF4 1061997773
ARGF4
CNSTF4 1061997773
ARGF4
CNSTF4 1060320051
ARGF4
CNSTF4 1051260355
ARGF4
CNSTF4 1140457472
ARGF4
ADDRGP4 cg+107604
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148772+568
INDIRI4
ARGI4
ADDRGP4 CG_SmokePuff
CALLP4
pop
line 1907
;1900:				  24,
;1901:				  .8f, .8f, 0.7f, 0.33f,
;1902:				  500,
;1903:				  cg.time,
;1904:				  0,
;1905:				  0,
;1906:				  cgs.media.dustPuffShader );
;1907:}
LABELV $959
endproc CG_DustTrail 96 48
proc CG_TrailItem 188 12
line 1916
;1908:#endif
;1909:
;1910:
;1911:/*
;1912:===============
;1913:CG_TrailItem
;1914:===============
;1915:*/
;1916:static void CG_TrailItem( const centity_t *cent, qhandle_t hModel ) {
line 1921
;1917:	refEntity_t		ent;
;1918:	vec3_t			angles;
;1919:	vec3_t			axis[3];
;1920:
;1921:	VectorCopy( cent->lerpAngles, angles );
ADDRLP4 140
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 1922
;1922:	angles[PITCH] = 0;
ADDRLP4 140
CNSTF4 0
ASGNF4
line 1923
;1923:	angles[ROLL] = 0;
ADDRLP4 140+8
CNSTF4 0
ASGNF4
line 1924
;1924:	AnglesToAxis( angles, axis );
ADDRLP4 140
ARGP4
ADDRLP4 152
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1926
;1925:
;1926:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTU4 140
ARGU4
ADDRGP4 memset
CALLP4
pop
line 1927
;1927:	VectorMA( cent->lerpOrigin, -16, axis[0], ent.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRF4
ADDRLP4 152
INDIRF4
CNSTF4 3246391296
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+4
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
INDIRF4
ADDRLP4 152+4
INDIRF4
CNSTF4 3246391296
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+8
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
INDIRF4
ADDRLP4 152+8
INDIRF4
CNSTF4 3246391296
MULF4
ADDF4
ASGNF4
line 1928
;1928:	ent.origin[2] += 16;
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1929
;1929:	angles[YAW] += 90;
ADDRLP4 140+4
ADDRLP4 140+4
INDIRF4
CNSTF4 1119092736
ADDF4
ASGNF4
line 1930
;1930:	AnglesToAxis( angles, ent.axis );
ADDRLP4 140
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1932
;1931:
;1932:	ent.hModel = hModel;
ADDRLP4 0+8
ADDRFP4 4
INDIRI4
ASGNI4
line 1933
;1933:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1934
;1934:}
LABELV $982
endproc CG_TrailItem 188 12
proc CG_PlayerFlag 352 24
line 1942
;1935:
;1936:
;1937:/*
;1938:===============
;1939:CG_PlayerFlag
;1940:===============
;1941:*/
;1942:static void CG_PlayerFlag( centity_t *cent, qhandle_t hSkin, refEntity_t *torso ) {
line 1951
;1943:	clientInfo_t	*ci;
;1944:	refEntity_t	pole;
;1945:	refEntity_t	flag;
;1946:	vec3_t		angles, dir;
;1947:	int			legsAnim, flagAnim, updateangles;
;1948:	float		angle, d;
;1949:
;1950:	// show the flag pole model
;1951:	memset( &pole, 0, sizeof(pole) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTU4 140
ARGU4
ADDRGP4 memset
CALLP4
pop
line 1952
;1952:	pole.hModel = cgs.media.flagPoleModel;
ADDRLP4 0+8
ADDRGP4 cgs+148772+88
INDIRI4
ASGNI4
line 1953
;1953:	VectorCopy( torso->lightingOrigin, pole.lightingOrigin );
ADDRLP4 0+12
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 1954
;1954:	pole.shadowPlane = torso->shadowPlane;
ADDRLP4 0+24
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1955
;1955:	pole.renderfx = torso->renderfx;
ADDRLP4 0+4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1956
;1956:	CG_PositionEntityOnTag( &pole, torso, torso->hModel, "tag_flag" );
ADDRLP4 0
ARGP4
ADDRLP4 328
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 328
INDIRP4
ARGP4
ADDRLP4 328
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $452
ARGP4
ADDRGP4 CG_PositionEntityOnTag
CALLV
pop
line 1957
;1957:	trap_R_AddRefEntityToScene( &pole );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1960
;1958:
;1959:	// show the flag model
;1960:	memset( &flag, 0, sizeof(flag) );
ADDRLP4 140
ARGP4
CNSTI4 0
ARGI4
CNSTU4 140
ARGU4
ADDRGP4 memset
CALLP4
pop
line 1961
;1961:	flag.hModel = cgs.media.flagFlapModel;
ADDRLP4 140+8
ADDRGP4 cgs+148772+92
INDIRI4
ASGNI4
line 1962
;1962:	flag.customSkin = hSkin;
ADDRLP4 140+108
ADDRFP4 4
INDIRI4
ASGNI4
line 1963
;1963:	VectorCopy( torso->lightingOrigin, flag.lightingOrigin );
ADDRLP4 140+12
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 1964
;1964:	flag.shadowPlane = torso->shadowPlane;
ADDRLP4 140+24
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1965
;1965:	flag.renderfx = torso->renderfx;
ADDRLP4 140+4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1967
;1966:
;1967:	VectorClear(angles);
ADDRLP4 280
CNSTF4 0
ASGNF4
ADDRLP4 280+4
CNSTF4 0
ASGNF4
ADDRLP4 280+8
CNSTF4 0
ASGNF4
line 1969
;1968:
;1969:	updateangles = qfalse;
ADDRLP4 312
CNSTI4 0
ASGNI4
line 1970
;1970:	legsAnim = cent->currentState.legsAnim & ~ANIM_TOGGLEBIT;
ADDRLP4 304
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1971
;1971:	if( legsAnim == LEGS_IDLE || legsAnim == LEGS_IDLECR ) {
ADDRLP4 304
INDIRI4
CNSTI4 22
EQI4 $1014
ADDRLP4 304
INDIRI4
CNSTI4 23
NEI4 $1012
LABELV $1014
line 1972
;1972:		flagAnim = FLAG_STAND;
ADDRLP4 320
CNSTI4 35
ASGNI4
line 1973
;1973:	} else if ( legsAnim == LEGS_WALK || legsAnim == LEGS_WALKCR ) {
ADDRGP4 $1013
JUMPV
LABELV $1012
ADDRLP4 304
INDIRI4
CNSTI4 14
EQI4 $1017
ADDRLP4 304
INDIRI4
CNSTI4 13
NEI4 $1015
LABELV $1017
line 1974
;1974:		flagAnim = FLAG_STAND;
ADDRLP4 320
CNSTI4 35
ASGNI4
line 1975
;1975:		updateangles = qtrue;
ADDRLP4 312
CNSTI4 1
ASGNI4
line 1976
;1976:	} else {
ADDRGP4 $1016
JUMPV
LABELV $1015
line 1977
;1977:		flagAnim = FLAG_RUN;
ADDRLP4 320
CNSTI4 34
ASGNI4
line 1978
;1978:		updateangles = qtrue;
ADDRLP4 312
CNSTI4 1
ASGNI4
line 1979
;1979:	}
LABELV $1016
LABELV $1013
line 1981
;1980:
;1981:	if ( updateangles ) {
ADDRLP4 312
INDIRI4
CNSTI4 0
EQI4 $1018
line 1983
;1982:
;1983:		VectorCopy( cent->currentState.pos.trDelta, dir );
ADDRLP4 292
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1985
;1984:		// add gravity
;1985:		dir[2] += 100;
ADDRLP4 292+8
ADDRLP4 292+8
INDIRF4
CNSTF4 1120403456
ADDF4
ASGNF4
line 1986
;1986:		VectorNormalize( dir );
ADDRLP4 292
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1987
;1987:		d = DotProduct(pole.axis[2], dir);
ADDRLP4 308
ADDRLP4 0+28+24
INDIRF4
ADDRLP4 292
INDIRF4
MULF4
ADDRLP4 0+28+24+4
INDIRF4
ADDRLP4 292+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+28+24+8
INDIRF4
ADDRLP4 292+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1989
;1988:		// if there is enough movement orthogonal to the flag pole
;1989:		if (fabs(d) < 0.9) {
ADDRLP4 308
INDIRF4
ARGF4
ADDRLP4 340
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 340
INDIRF4
CNSTF4 1063675494
GEF4 $1031
line 1991
;1990:			//
;1991:			d = DotProduct(pole.axis[0], dir);
ADDRLP4 308
ADDRLP4 0+28
INDIRF4
ADDRLP4 292
INDIRF4
MULF4
ADDRLP4 0+28+4
INDIRF4
ADDRLP4 292+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+28+8
INDIRF4
ADDRLP4 292+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1992
;1992:			if (d > 1.0f) {
ADDRLP4 308
INDIRF4
CNSTF4 1065353216
LEF4 $1040
line 1993
;1993:				d = 1.0f;
ADDRLP4 308
CNSTF4 1065353216
ASGNF4
line 1994
;1994:			}
ADDRGP4 $1041
JUMPV
LABELV $1040
line 1995
;1995:			else if (d < -1.0f) {
ADDRLP4 308
INDIRF4
CNSTF4 3212836864
GEF4 $1042
line 1996
;1996:				d = -1.0f;
ADDRLP4 308
CNSTF4 3212836864
ASGNF4
line 1997
;1997:			}
LABELV $1042
LABELV $1041
line 1998
;1998:			angle = acos(d);
ADDRLP4 308
INDIRF4
ARGF4
ADDRLP4 344
ADDRGP4 acos
CALLF4
ASGNF4
ADDRLP4 324
ADDRLP4 344
INDIRF4
ASGNF4
line 2000
;1999:
;2000:			d = DotProduct(pole.axis[1], dir);
ADDRLP4 308
ADDRLP4 0+28+12
INDIRF4
ADDRLP4 292
INDIRF4
MULF4
ADDRLP4 0+28+12+4
INDIRF4
ADDRLP4 292+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+28+12+8
INDIRF4
ADDRLP4 292+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2001
;2001:			if (d < 0) {
ADDRLP4 308
INDIRF4
CNSTF4 0
GEF4 $1054
line 2002
;2002:				angles[YAW] = 360 - angle * 180 / M_PI;
ADDRLP4 280+4
CNSTF4 1135869952
ADDRLP4 324
INDIRF4
CNSTF4 1113927393
MULF4
SUBF4
ASGNF4
line 2003
;2003:			}
ADDRGP4 $1055
JUMPV
LABELV $1054
line 2004
;2004:			else {
line 2005
;2005:				angles[YAW] = angle * 180 / M_PI;
ADDRLP4 280+4
ADDRLP4 324
INDIRF4
CNSTF4 1113927393
MULF4
ASGNF4
line 2006
;2006:			}
LABELV $1055
line 2007
;2007:			if (angles[YAW] < 0)
ADDRLP4 280+4
INDIRF4
CNSTF4 0
GEF4 $1058
line 2008
;2008:				angles[YAW] += 360;
ADDRLP4 280+4
ADDRLP4 280+4
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $1058
line 2009
;2009:			if (angles[YAW] > 360)
ADDRLP4 280+4
INDIRF4
CNSTF4 1135869952
LEF4 $1062
line 2010
;2010:				angles[YAW] -= 360;
ADDRLP4 280+4
ADDRLP4 280+4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $1062
line 2015
;2011:
;2012:			//vectoangles( cent->currentState.pos.trDelta, tmpangles );
;2013:			//angles[YAW] = tmpangles[YAW] + 45 - cent->pe.torso.yawAngle;
;2014:			// change the yaw angle
;2015:			CG_SwingAngles( angles[YAW], 25, 90, 0.15f, &cent->pe.flag.yawAngle, &cent->pe.flag.yawing );
ADDRLP4 280+4
INDIRF4
ARGF4
CNSTF4 1103626240
ARGF4
CNSTF4 1119092736
ARGF4
CNSTF4 1041865114
ARGF4
ADDRLP4 348
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 348
INDIRP4
CNSTI4 576
ADDP4
ARGP4
ADDRLP4 348
INDIRP4
CNSTI4 580
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLV
pop
line 2016
;2016:		}
LABELV $1031
line 2036
;2017:
;2018:		/*
;2019:		d = DotProduct(pole.axis[2], dir);
;2020:		angle = Q_acos(d);
;2021:
;2022:		d = DotProduct(pole.axis[1], dir);
;2023:		if (d < 0) {
;2024:			angle = 360 - angle * 180 / M_PI;
;2025:		}
;2026:		else {
;2027:			angle = angle * 180 / M_PI;
;2028:		}
;2029:		if (angle > 340 && angle < 20) {
;2030:			flagAnim = FLAG_RUNUP;
;2031:		}
;2032:		if (angle > 160 && angle < 200) {
;2033:			flagAnim = FLAG_RUNDOWN;
;2034:		}
;2035:		*/
;2036:	}
LABELV $1018
line 2039
;2037:
;2038:	// set the yaw angle
;2039:	angles[YAW] = cent->pe.flag.yawAngle;
ADDRLP4 280+4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRF4
ASGNF4
line 2041
;2040:	// lerp the flag animation frames
;2041:	ci = &cgs.clientinfo[ cent->currentState.clientNum ];
ADDRLP4 316
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 2042
;2042:	CG_RunLerpFrame( ci, &cent->pe.flag, flagAnim, 1 );
ADDRLP4 316
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
ARGP4
ADDRLP4 320
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_RunLerpFrame
CALLV
pop
line 2043
;2043:	flag.oldframe = cent->pe.flag.oldFrame;
ADDRLP4 140+96
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
ASGNI4
line 2044
;2044:	flag.frame = cent->pe.flag.frame;
ADDRLP4 140+80
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ASGNI4
line 2045
;2045:	flag.backlerp = cent->pe.flag.backlerp;
ADDRLP4 140+100
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRF4
ASGNF4
line 2047
;2046:
;2047:	AnglesToAxis( angles, flag.axis );
ADDRLP4 280
ARGP4
ADDRLP4 140+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 2048
;2048:	CG_PositionRotatedEntityOnTag( &flag, &pole, pole.hModel, "tag_flag" );
ADDRLP4 140
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $452
ARGP4
ADDRGP4 CG_PositionRotatedEntityOnTag
CALLV
pop
line 2050
;2049:
;2050:	trap_R_AddRefEntityToScene( &flag );
ADDRLP4 140
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2051
;2051:}
LABELV $996
endproc CG_PlayerFlag 352 24
proc CG_PlayerTokens 196 12
line 2060
;2052:
;2053:
;2054:#ifdef MISSIONPACK // bk001204
;2055:/*
;2056:===============
;2057:CG_PlayerTokens
;2058:===============
;2059:*/
;2060:static void CG_PlayerTokens( centity_t *cent, int renderfx ) {
line 2066
;2061:	int			tokens, i, j;
;2062:	float		angle;
;2063:	refEntity_t	ent;
;2064:	vec3_t		dir, origin;
;2065:	skulltrail_t *trail;
;2066:	trail = &cg.skulltrails[cent->currentState.number];
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 124
MULI4
ADDRGP4 cg+116488
ADDP4
ASGNP4
line 2067
;2067:	tokens = cent->currentState.generic1;
ADDRLP4 180
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
line 2068
;2068:	if ( !tokens ) {
ADDRLP4 180
INDIRI4
CNSTI4 0
NEI4 $1076
line 2069
;2069:		trail->numpositions = 0;
ADDRLP4 4
INDIRP4
CNSTI4 120
ADDP4
CNSTI4 0
ASGNI4
line 2070
;2070:		return;
ADDRGP4 $1074
JUMPV
LABELV $1076
line 2073
;2071:	}
;2072:
;2073:	if ( tokens > MAX_SKULLTRAIL ) {
ADDRLP4 180
INDIRI4
CNSTI4 10
LEI4 $1078
line 2074
;2074:		tokens = MAX_SKULLTRAIL;
ADDRLP4 180
CNSTI4 10
ASGNI4
line 2075
;2075:	}
LABELV $1078
line 2078
;2076:
;2077:	// add skulls if there are more than last time
;2078:	for (i = 0; i < tokens - trail->numpositions; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $1083
JUMPV
LABELV $1080
line 2079
;2079:		for (j = trail->numpositions; j > 0; j--) {
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $1087
JUMPV
LABELV $1084
line 2080
;2080:			VectorCopy(trail->positions[j-1], trail->positions[j]);
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
CNSTI4 12
SUBI4
ADDRLP4 4
INDIRP4
ADDP4
INDIRB
ASGNB 12
line 2081
;2081:		}
LABELV $1085
line 2079
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $1087
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $1084
line 2082
;2082:		VectorCopy(cent->lerpOrigin, trail->positions[0]);
ADDRLP4 4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2083
;2083:	}
LABELV $1081
line 2078
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1083
ADDRLP4 8
INDIRI4
ADDRLP4 180
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
SUBI4
LTI4 $1080
line 2084
;2084:	trail->numpositions = tokens;
ADDRLP4 4
INDIRP4
CNSTI4 120
ADDP4
ADDRLP4 180
INDIRI4
ASGNI4
line 2087
;2085:
;2086:	// move all the skulls along the trail
;2087:	VectorCopy(cent->lerpOrigin, origin);
ADDRLP4 152
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2088
;2088:	for (i = 0; i < trail->numpositions; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $1091
JUMPV
LABELV $1088
line 2089
;2089:		VectorSubtract(trail->positions[i], origin, dir);
ADDRLP4 164
ADDRLP4 8
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 152
INDIRF4
SUBF4
ASGNF4
ADDRLP4 164+4
ADDRLP4 8
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 152+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 164+8
ADDRLP4 8
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 152+8
INDIRF4
SUBF4
ASGNF4
line 2090
;2090:		if (VectorNormalize(dir) > 30) {
ADDRLP4 164
ARGP4
ADDRLP4 192
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 192
INDIRF4
CNSTF4 1106247680
LEF4 $1096
line 2091
;2091:			VectorMA(origin, 30, dir, trail->positions[i]);
ADDRLP4 8
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 152
INDIRF4
ADDRLP4 164
INDIRF4
CNSTF4 1106247680
MULF4
ADDF4
ASGNF4
ADDRLP4 8
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 152+4
INDIRF4
ADDRLP4 164+4
INDIRF4
CNSTF4 1106247680
MULF4
ADDF4
ASGNF4
ADDRLP4 8
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 152+8
INDIRF4
ADDRLP4 164+8
INDIRF4
CNSTF4 1106247680
MULF4
ADDF4
ASGNF4
line 2092
;2092:		}
LABELV $1096
line 2093
;2093:		VectorCopy(trail->positions[i], origin);
ADDRLP4 152
ADDRLP4 8
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
ADDP4
INDIRB
ASGNB 12
line 2094
;2094:	}
LABELV $1089
line 2088
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1091
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
LTI4 $1088
line 2096
;2095:
;2096:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 12
ARGP4
CNSTI4 0
ARGI4
CNSTU4 140
ARGU4
ADDRGP4 memset
CALLP4
pop
line 2097
;2097:	if( cgs.clientinfo[ cent->currentState.clientNum ].team == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+36
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1102
line 2098
;2098:		ent.hModel = cgs.media.redCubeModel;
ADDRLP4 12+8
ADDRGP4 cgs+148772+20
INDIRI4
ASGNI4
line 2099
;2099:	} else {
ADDRGP4 $1103
JUMPV
LABELV $1102
line 2100
;2100:		ent.hModel = cgs.media.blueCubeModel;
ADDRLP4 12+8
ADDRGP4 cgs+148772+24
INDIRI4
ASGNI4
line 2101
;2101:	}
LABELV $1103
line 2102
;2102:	ent.renderfx = renderfx;
ADDRLP4 12+4
ADDRFP4 4
INDIRI4
ASGNI4
line 2104
;2103:
;2104:	VectorCopy(cent->lerpOrigin, origin);
ADDRLP4 152
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2105
;2105:	for (i = 0; i < trail->numpositions; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $1116
JUMPV
LABELV $1113
line 2106
;2106:		VectorSubtract(origin, trail->positions[i], ent.axis[0]);
ADDRLP4 12+28
ADDRLP4 152
INDIRF4
ADDRLP4 8
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+28+4
ADDRLP4 152+4
INDIRF4
ADDRLP4 8
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+28+8
ADDRLP4 152+8
INDIRF4
ADDRLP4 8
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2107
;2107:		ent.axis[0][2] = 0;
ADDRLP4 12+28+8
CNSTF4 0
ASGNF4
line 2108
;2108:		VectorNormalize(ent.axis[0]);
ADDRLP4 12+28
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 2109
;2109:		VectorSet(ent.axis[2], 0, 0, 1);
ADDRLP4 12+28+24
CNSTF4 0
ASGNF4
ADDRLP4 12+28+24+4
CNSTF4 0
ASGNF4
ADDRLP4 12+28+24+8
CNSTF4 1065353216
ASGNF4
line 2110
;2110:		CrossProduct(ent.axis[0], ent.axis[2], ent.axis[1]);
ADDRLP4 12+28
ARGP4
ADDRLP4 12+28+24
ARGP4
ADDRLP4 12+28+12
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 2112
;2111:
;2112:		VectorCopy(trail->positions[i], ent.origin);
ADDRLP4 12+68
ADDRLP4 8
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
ADDP4
INDIRB
ASGNB 12
line 2113
;2113:		angle = (((cg.time + 500 * MAX_SKULLTRAIL - 500 * i) / 16) & 255) * (M_PI * 2) / 255;
ADDRLP4 176
ADDRGP4 cg+107604
INDIRI4
CNSTI4 5000
ADDI4
ADDRLP4 8
INDIRI4
CNSTI4 500
MULI4
SUBI4
CNSTI4 16
DIVI4
CNSTI4 255
BANDI4
CVIF4 4
CNSTF4 1019861428
MULF4
ASGNF4
line 2114
;2114:		ent.origin[2] += sin(angle) * 10;
ADDRLP4 176
INDIRF4
ARGF4
ADDRLP4 184
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 12+68+8
ADDRLP4 12+68+8
INDIRF4
ADDRLP4 184
INDIRF4
CNSTF4 1092616192
MULF4
ADDF4
ASGNF4
line 2115
;2115:		trap_R_AddRefEntityToScene( &ent );
ADDRLP4 12
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2116
;2116:		VectorCopy(trail->positions[i], origin);
ADDRLP4 152
ADDRLP4 8
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
ADDP4
INDIRB
ASGNB 12
line 2117
;2117:	}
LABELV $1114
line 2105
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1116
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
LTI4 $1113
line 2118
;2118:}
LABELV $1074
endproc CG_PlayerTokens 196 12
proc CG_PlayerPowerups 12 20
line 2127
;2119:#endif
;2120:
;2121:
;2122:/*
;2123:===============
;2124:CG_PlayerPowerups
;2125:===============
;2126:*/
;2127:static void CG_PlayerPowerups( centity_t *cent, refEntity_t *torso ) {
line 2131
;2128:	int		powerups;
;2129:	clientInfo_t	*ci;
;2130:
;2131:	powerups = cent->currentState.powerups;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
line 2132
;2132:	if ( !powerups ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1145
line 2133
;2133:		return;
ADDRGP4 $1144
JUMPV
LABELV $1145
line 2137
;2134:	}
;2135:
;2136:	// quad gives a dlight
;2137:	if ( powerups & ( 1 << PW_QUAD ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1147
line 2138
;2138:		if ( cgs.clientinfo[ cent->currentState.clientNum ].team == TEAM_RED ) {
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1149
line 2139
;2139:			trap_R_AddLightToScene( cent->lerpOrigin, ( POWERUP_GLOW_RADIUS + (rand() & POWERUP_GLOW_RADIUS_MOD) ), 1.0f, 0.2f, 0.2f );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1045220557
ARGF4
CNSTF4 1045220557
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2140
;2140:		} else {
ADDRGP4 $1150
JUMPV
LABELV $1149
line 2141
;2141:			trap_R_AddLightToScene( cent->lerpOrigin, ( POWERUP_GLOW_RADIUS + (rand() & POWERUP_GLOW_RADIUS_MOD) ), 0.2f, 0.2f, 1.0f );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
CNSTF4 1045220557
ARGF4
CNSTF4 1045220557
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2142
;2142:		}
LABELV $1150
line 2143
;2143:	}
LABELV $1147
line 2146
;2144:
;2145:	// flight plays a looped sound
;2146:	if ( powerups & ( 1 << PW_FLIGHT ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $1153
line 2147
;2147:		trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, cgs.media.flightSound );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRGP4 cgs+148772+1044
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 2148
;2148:	}
LABELV $1153
line 2150
;2149:
;2150:	ci = &cgs.clientinfo[ cent->currentState.clientNum ];
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 2152
;2151:	// redflag
;2152:	if ( powerups & ( 1 << PW_REDFLAG ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $1158
line 2153
;2153:		if (ci->newAnims) {
ADDRLP4 4
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1160
line 2154
;2154:			CG_PlayerFlag( cent, cgs.media.redFlagFlapSkin, torso );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148772+96
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_PlayerFlag
CALLV
pop
line 2155
;2155:		}
ADDRGP4 $1161
JUMPV
LABELV $1160
line 2156
;2156:		else {
line 2157
;2157:			CG_TrailItem( cent, cgs.media.redFlagModel );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148772+36
INDIRI4
ARGI4
ADDRGP4 CG_TrailItem
CALLV
pop
line 2158
;2158:		}
LABELV $1161
line 2159
;2159:		trap_R_AddLightToScene( cent->lerpOrigin, ( POWERUP_GLOW_RADIUS + (rand() & POWERUP_GLOW_RADIUS_MOD) ), 1.0f, 0.2f, 0.2f );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1045220557
ARGF4
CNSTF4 1045220557
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2160
;2160:	}
LABELV $1158
line 2163
;2161:
;2162:	// blueflag
;2163:	if ( powerups & ( 1 << PW_BLUEFLAG ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $1166
line 2164
;2164:		if (ci->newAnims){
ADDRLP4 4
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1168
line 2165
;2165:			CG_PlayerFlag( cent, cgs.media.blueFlagFlapSkin, torso );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148772+100
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_PlayerFlag
CALLV
pop
line 2166
;2166:		}
ADDRGP4 $1169
JUMPV
LABELV $1168
line 2167
;2167:		else {
line 2168
;2168:			CG_TrailItem( cent, cgs.media.blueFlagModel );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148772+40
INDIRI4
ARGI4
ADDRGP4 CG_TrailItem
CALLV
pop
line 2169
;2169:		}
LABELV $1169
line 2170
;2170:		trap_R_AddLightToScene( cent->lerpOrigin, ( POWERUP_GLOW_RADIUS + (rand() & POWERUP_GLOW_RADIUS_MOD) ), 0.2f, 0.2f, 1.0f );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
CNSTF4 1045220557
ARGF4
CNSTF4 1045220557
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2171
;2171:	}
LABELV $1166
line 2174
;2172:
;2173:	// neutralflag
;2174:	if ( powerups & ( 1 << PW_NEUTRALFLAG ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $1174
line 2175
;2175:		if (ci->newAnims) {
ADDRLP4 4
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1176
line 2176
;2176:			CG_PlayerFlag( cent, cgs.media.neutralFlagFlapSkin, torso );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148772+104
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_PlayerFlag
CALLV
pop
line 2177
;2177:		}
ADDRGP4 $1177
JUMPV
LABELV $1176
line 2178
;2178:		else {
line 2179
;2179:			CG_TrailItem( cent, cgs.media.neutralFlagModel );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148772+44
INDIRI4
ARGI4
ADDRGP4 CG_TrailItem
CALLV
pop
line 2180
;2180:		}
LABELV $1177
line 2181
;2181:		trap_R_AddLightToScene( cent->lerpOrigin, ( POWERUP_GLOW_RADIUS + (rand() & POWERUP_GLOW_RADIUS_MOD) ), 1.0f, 1.0f, 1.0f );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2182
;2182:	}
LABELV $1174
line 2185
;2183:
;2184:	// haste leaves smoke trails
;2185:	if ( powerups & ( 1 << PW_HASTE ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1182
line 2186
;2186:		CG_HasteTrail( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_HasteTrail
CALLV
pop
line 2187
;2187:	}
LABELV $1182
line 2188
;2188:}
LABELV $1144
endproc CG_PlayerPowerups 12 20
proc CG_PlayerFloatSprite 144 12
line 2198
;2189:
;2190:
;2191:/*
;2192:===============
;2193:CG_PlayerFloatSprite
;2194:
;2195:Float a sprite over the player's head
;2196:===============
;2197:*/
;2198:static void CG_PlayerFloatSprite( const centity_t *cent, qhandle_t shader ) {
line 2202
;2199:	int				rf;
;2200:	refEntity_t		ent;
;2201:
;2202:	if ( cent->currentState.number == cg.snap->ps.clientNum && !cg.renderingThirdPerson ) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $1185
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
NEI4 $1185
line 2203
;2203:		rf = RF_THIRD_PERSON;		// only show in mirrors
ADDRLP4 140
CNSTI4 2
ASGNI4
line 2204
;2204:	} else {
ADDRGP4 $1186
JUMPV
LABELV $1185
line 2205
;2205:		rf = 0;
ADDRLP4 140
CNSTI4 0
ASGNI4
line 2206
;2206:	}
LABELV $1186
line 2208
;2207:
;2208:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTU4 140
ARGU4
ADDRGP4 memset
CALLP4
pop
line 2209
;2209:	VectorCopy( cent->lerpOrigin, ent.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2210
;2210:	ent.origin[2] += 48;
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
CNSTF4 1111490560
ADDF4
ASGNF4
line 2211
;2211:	ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 2212
;2212:	ent.customShader = shader;
ADDRLP4 0+112
ADDRFP4 4
INDIRI4
ASGNI4
line 2213
;2213:	ent.radius = 10;
ADDRLP4 0+132
CNSTF4 1092616192
ASGNF4
line 2214
;2214:	ent.renderfx = rf;
ADDRLP4 0+4
ADDRLP4 140
INDIRI4
ASGNI4
line 2215
;2215:	ent.shaderRGBA[0] = 255;
ADDRLP4 0+116
CNSTU1 255
ASGNU1
line 2216
;2216:	ent.shaderRGBA[1] = 255;
ADDRLP4 0+116+1
CNSTU1 255
ASGNU1
line 2217
;2217:	ent.shaderRGBA[2] = 255;
ADDRLP4 0+116+2
CNSTU1 255
ASGNU1
line 2218
;2218:	ent.shaderRGBA[3] = 255;
ADDRLP4 0+116+3
CNSTU1 255
ASGNU1
line 2219
;2219:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2220
;2220:}
LABELV $1184
endproc CG_PlayerFloatSprite 144 12
proc CG_PlayerSprites 4 8
line 2230
;2221:
;2222:
;2223:/*
;2224:===============
;2225:CG_PlayerSprites
;2226:
;2227:Float sprites over the player's head
;2228:===============
;2229:*/
;2230:static void CG_PlayerSprites( centity_t *cent ) {
line 2233
;2231:	int		team;
;2232:
;2233:	if ( cent->currentState.eFlags & EF_CONNECTION ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1203
line 2234
;2234:		CG_PlayerFloatSprite( cent, cgs.media.connectionShader );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148772+240
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2235
;2235:		return;
ADDRGP4 $1202
JUMPV
LABELV $1203
line 2238
;2236:	}
;2237:
;2238:	if ( cent->currentState.eFlags & EF_TALK ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $1207
line 2239
;2239:		CG_PlayerFloatSprite( cent, cgs.media.balloonShader );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148772+236
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2240
;2240:		return;
ADDRGP4 $1202
JUMPV
LABELV $1207
line 2243
;2241:	}
;2242:
;2243:	if ( cent->currentState.eFlags & EF_AWARD_IMPRESSIVE ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $1211
line 2244
;2244:		CG_PlayerFloatSprite( cent, cgs.media.medalImpressive );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148772+596
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2245
;2245:		return;
ADDRGP4 $1202
JUMPV
LABELV $1211
line 2248
;2246:	}
;2247:
;2248:	if ( cent->currentState.eFlags & EF_AWARD_EXCELLENT ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1215
line 2249
;2249:		CG_PlayerFloatSprite( cent, cgs.media.medalExcellent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148772+600
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2250
;2250:		return;
ADDRGP4 $1202
JUMPV
LABELV $1215
line 2253
;2251:	}
;2252:
;2253:	if ( cent->currentState.eFlags & EF_AWARD_GAUNTLET ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $1219
line 2254
;2254:		CG_PlayerFloatSprite( cent, cgs.media.medalGauntlet );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148772+604
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2255
;2255:		return;
ADDRGP4 $1202
JUMPV
LABELV $1219
line 2258
;2256:	}
;2257:
;2258:	if ( cent->currentState.eFlags & EF_AWARD_DEFEND ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 65536
BANDI4
CNSTI4 0
EQI4 $1223
line 2259
;2259:		CG_PlayerFloatSprite( cent, cgs.media.medalDefend );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148772+608
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2260
;2260:		return;
ADDRGP4 $1202
JUMPV
LABELV $1223
line 2263
;2261:	}
;2262:
;2263:	if ( cent->currentState.eFlags & EF_AWARD_ASSIST ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 131072
BANDI4
CNSTI4 0
EQI4 $1227
line 2264
;2264:		CG_PlayerFloatSprite( cent, cgs.media.medalAssist );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148772+612
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2265
;2265:		return;
ADDRGP4 $1202
JUMPV
LABELV $1227
line 2268
;2266:	}
;2267:
;2268:	if ( cent->currentState.eFlags & EF_AWARD_CAP ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1231
line 2269
;2269:		CG_PlayerFloatSprite( cent, cgs.media.medalCapture );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148772+616
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2270
;2270:		return;
ADDRGP4 $1202
JUMPV
LABELV $1231
line 2273
;2271:	}
;2272:
;2273:	team = cgs.clientinfo[ cent->currentState.clientNum ].team;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996+36
ADDP4
INDIRI4
ASGNI4
line 2274
;2274:	if ( !(cent->currentState.eFlags & EF_DEAD) && 
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $1237
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1237
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $1237
line 2276
;2275:		cg.snap->ps.persistant[PERS_TEAM] == team &&
;2276:		cgs.gametype >= GT_TEAM) {
line 2277
;2277:		if (cg_drawFriend.integer) {
ADDRGP4 cg_drawFriend+12
INDIRI4
CNSTI4 0
EQI4 $1202
line 2278
;2278:			CG_PlayerFloatSprite( cent, cgs.media.friendShader );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+148772+232
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2279
;2279:		}
line 2280
;2280:		return;
LABELV $1237
line 2282
;2281:	}
;2282:}
LABELV $1202
endproc CG_PlayerSprites 4 8
data
align 4
LABELV $1247
byte 4 3245342720
byte 4 3245342720
byte 4 0
align 4
LABELV $1248
byte 4 1097859072
byte 4 1097859072
byte 4 1073741824
code
proc CG_PlayerShadow 100 44
line 2295
;2283:
;2284:
;2285:/*
;2286:===============
;2287:CG_PlayerShadow
;2288:
;2289:Returns the Z component of the surface being shadowed
;2290:
;2291:  should it return a full plane instead of a Z?
;2292:===============
;2293:*/
;2294:#define	SHADOW_DISTANCE		128
;2295:static qboolean CG_PlayerShadow( centity_t *cent, float *shadowPlane ) {
line 2296
;2296:	vec3_t		end, mins = {-15, -15, 0}, maxs = {15, 15, 2};
ADDRLP4 72
ADDRGP4 $1247
INDIRB
ASGNB 12
ADDRLP4 84
ADDRGP4 $1248
INDIRB
ASGNB 12
line 2300
;2297:	trace_t		trace;
;2298:	float		alpha;
;2299:
;2300:	*shadowPlane = 0;
ADDRFP4 4
INDIRP4
CNSTF4 0
ASGNF4
line 2302
;2301:
;2302:	if ( cg_shadows.integer == 0 ) {
ADDRGP4 cg_shadows+12
INDIRI4
CNSTI4 0
NEI4 $1249
line 2303
;2303:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1246
JUMPV
LABELV $1249
line 2307
;2304:	}
;2305:
;2306:	// no shadows when invisible
;2307:	if ( cent->currentState.powerups & ( 1 << PW_INVIS ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1252
line 2308
;2308:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1246
JUMPV
LABELV $1252
line 2312
;2309:	}
;2310:
;2311:	// send a trace down from the player to the ground
;2312:	VectorCopy( cent->lerpOrigin, end );
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2313
;2313:	end[2] -= SHADOW_DISTANCE;
ADDRLP4 60+8
ADDRLP4 60+8
INDIRF4
CNSTF4 1124073472
SUBF4
ASGNF4
line 2315
;2314:
;2315:	trap_CM_BoxTrace( &trace, cent->lerpOrigin, end, mins, maxs, 0, MASK_PLAYERSOLID );
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 60
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 84
ARGP4
CNSTI4 0
ARGI4
CNSTI4 33619969
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 2318
;2316:
;2317:	// no shadow if too high
;2318:	if ( trace.fraction == 1.0 || trace.startsolid || trace.allsolid ) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
EQF4 $1260
ADDRLP4 0+4
INDIRI4
CNSTI4 0
NEI4 $1260
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1255
LABELV $1260
line 2319
;2319:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1246
JUMPV
LABELV $1255
line 2322
;2320:	}
;2321:
;2322:	*shadowPlane = trace.endpos[2] + 1;
ADDRFP4 4
INDIRP4
ADDRLP4 0+12+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2324
;2323:
;2324:	if ( cg_shadows.integer != 1 ) {	// no mark for stencil or projection shadows
ADDRGP4 cg_shadows+12
INDIRI4
CNSTI4 1
EQI4 $1263
line 2325
;2325:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1246
JUMPV
LABELV $1263
line 2329
;2326:	}
;2327:
;2328:	// fade the shadow out with height
;2329:	alpha = 1.0 - trace.fraction;
ADDRLP4 56
CNSTF4 1065353216
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 2336
;2330:
;2331:	// bk0101022 - hack / FPE - bogus planes?
;2332:	//assert( DotProduct( trace.plane.normal, trace.plane.normal ) != 0.0f ) 
;2333:
;2334:	// add the mark as a temporary, so it goes directly to the renderer
;2335:	// without taking a spot in the cg_marks array
;2336:	CG_ImpactMark( cgs.media.shadowMarkShader, trace.endpos, trace.plane.normal, 
ADDRGP4 cgs+148772+384
INDIRI4
ARGI4
ADDRLP4 0+12
ARGP4
ADDRLP4 0+24
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
CNSTI4 0
ARGI4
CNSTF4 1103101952
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 CG_ImpactMark
CALLV
pop
line 2339
;2337:		cent->pe.legs.yawAngle, alpha,alpha,alpha,1, qfalse, 24, qtrue );
;2338:
;2339:	return qtrue;
CNSTI4 1
RETI4
LABELV $1246
endproc CG_PlayerShadow 100 44
proc CG_PlayerSplash 188 28
line 2350
;2340:}
;2341:
;2342:
;2343:/*
;2344:===============
;2345:CG_PlayerSplash
;2346:
;2347:Draw a mark at the water surface
;2348:===============
;2349:*/
;2350:static void CG_PlayerSplash( const centity_t *cent ) {
line 2356
;2351:	vec3_t		start, end;
;2352:	trace_t		trace;
;2353:	int			contents;
;2354:	polyVert_t	verts[4];
;2355:
;2356:	if ( !cg_shadows.integer ) {
ADDRGP4 cg_shadows+12
INDIRI4
CNSTI4 0
NEI4 $1272
line 2357
;2357:		return;
ADDRGP4 $1271
JUMPV
LABELV $1272
line 2360
;2358:	}
;2359:
;2360:	VectorCopy( cent->lerpOrigin, end );
ADDRLP4 164
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2361
;2361:	end[2] -= 24;
ADDRLP4 164+8
ADDRLP4 164+8
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 2365
;2362:
;2363:	// if the feet aren't in liquid, don't make a mark
;2364:	// this won't handle moving water brushes, but they wouldn't draw right anyway...
;2365:	contents = CG_PointContents( end, 0 );
ADDRLP4 164
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 180
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 176
ADDRLP4 180
INDIRI4
ASGNI4
line 2366
;2366:	if ( !( contents & ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ) ) {
ADDRLP4 176
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
NEI4 $1276
line 2367
;2367:		return;
ADDRGP4 $1271
JUMPV
LABELV $1276
line 2370
;2368:	}
;2369:
;2370:	VectorCopy( cent->lerpOrigin, start );
ADDRLP4 152
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2371
;2371:	start[2] += 32;
ADDRLP4 152+8
ADDRLP4 152+8
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2374
;2372:
;2373:	// if the head isn't out of liquid, don't make a mark
;2374:	contents = CG_PointContents( start, 0 );
ADDRLP4 152
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 184
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 176
ADDRLP4 184
INDIRI4
ASGNI4
line 2375
;2375:	if ( contents & ( CONTENTS_SOLID | CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ) {
ADDRLP4 176
INDIRI4
CNSTI4 57
BANDI4
CNSTI4 0
EQI4 $1279
line 2376
;2376:		return;
ADDRGP4 $1271
JUMPV
LABELV $1279
line 2380
;2377:	}
;2378:
;2379:	// trace down to find the surface
;2380:	trap_CM_BoxTrace( &trace, start, end, NULL, NULL, 0, ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) );
ADDRLP4 96
ARGP4
ADDRLP4 152
ARGP4
ADDRLP4 164
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 2382
;2381:
;2382:	if ( trace.fraction == 1.0 ) {
ADDRLP4 96+8
INDIRF4
CNSTF4 1065353216
NEF4 $1281
line 2383
;2383:		return;
ADDRGP4 $1271
JUMPV
LABELV $1281
line 2387
;2384:	}
;2385:
;2386:	// create a mark polygon
;2387:	VectorCopy( trace.endpos, verts[0].xyz );
ADDRLP4 0
ADDRLP4 96+12
INDIRB
ASGNB 12
line 2388
;2388:	verts[0].xyz[0] -= 32;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 2389
;2389:	verts[0].xyz[1] -= 32;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 2390
;2390:	verts[0].st[0] = 0;
ADDRLP4 0+12
CNSTF4 0
ASGNF4
line 2391
;2391:	verts[0].st[1] = 0;
ADDRLP4 0+12+4
CNSTF4 0
ASGNF4
line 2392
;2392:	verts[0].modulate[0] = 255;
ADDRLP4 0+20
CNSTU1 255
ASGNU1
line 2393
;2393:	verts[0].modulate[1] = 255;
ADDRLP4 0+20+1
CNSTU1 255
ASGNU1
line 2394
;2394:	verts[0].modulate[2] = 255;
ADDRLP4 0+20+2
CNSTU1 255
ASGNU1
line 2395
;2395:	verts[0].modulate[3] = 255;
ADDRLP4 0+20+3
CNSTU1 255
ASGNU1
line 2397
;2396:
;2397:	VectorCopy( trace.endpos, verts[1].xyz );
ADDRLP4 0+24
ADDRLP4 96+12
INDIRB
ASGNB 12
line 2398
;2398:	verts[1].xyz[0] -= 32;
ADDRLP4 0+24
ADDRLP4 0+24
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 2399
;2399:	verts[1].xyz[1] += 32;
ADDRLP4 0+24+4
ADDRLP4 0+24+4
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2400
;2400:	verts[1].st[0] = 0;
ADDRLP4 0+24+12
CNSTF4 0
ASGNF4
line 2401
;2401:	verts[1].st[1] = 1;
ADDRLP4 0+24+12+4
CNSTF4 1065353216
ASGNF4
line 2402
;2402:	verts[1].modulate[0] = 255;
ADDRLP4 0+24+20
CNSTU1 255
ASGNU1
line 2403
;2403:	verts[1].modulate[1] = 255;
ADDRLP4 0+24+20+1
CNSTU1 255
ASGNU1
line 2404
;2404:	verts[1].modulate[2] = 255;
ADDRLP4 0+24+20+2
CNSTU1 255
ASGNU1
line 2405
;2405:	verts[1].modulate[3] = 255;
ADDRLP4 0+24+20+3
CNSTU1 255
ASGNU1
line 2407
;2406:
;2407:	VectorCopy( trace.endpos, verts[2].xyz );
ADDRLP4 0+48
ADDRLP4 96+12
INDIRB
ASGNB 12
line 2408
;2408:	verts[2].xyz[0] += 32;
ADDRLP4 0+48
ADDRLP4 0+48
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2409
;2409:	verts[2].xyz[1] += 32;
ADDRLP4 0+48+4
ADDRLP4 0+48+4
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2410
;2410:	verts[2].st[0] = 1;
ADDRLP4 0+48+12
CNSTF4 1065353216
ASGNF4
line 2411
;2411:	verts[2].st[1] = 1;
ADDRLP4 0+48+12+4
CNSTF4 1065353216
ASGNF4
line 2412
;2412:	verts[2].modulate[0] = 255;
ADDRLP4 0+48+20
CNSTU1 255
ASGNU1
line 2413
;2413:	verts[2].modulate[1] = 255;
ADDRLP4 0+48+20+1
CNSTU1 255
ASGNU1
line 2414
;2414:	verts[2].modulate[2] = 255;
ADDRLP4 0+48+20+2
CNSTU1 255
ASGNU1
line 2415
;2415:	verts[2].modulate[3] = 255;
ADDRLP4 0+48+20+3
CNSTU1 255
ASGNU1
line 2417
;2416:
;2417:	VectorCopy( trace.endpos, verts[3].xyz );
ADDRLP4 0+72
ADDRLP4 96+12
INDIRB
ASGNB 12
line 2418
;2418:	verts[3].xyz[0] += 32;
ADDRLP4 0+72
ADDRLP4 0+72
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2419
;2419:	verts[3].xyz[1] -= 32;
ADDRLP4 0+72+4
ADDRLP4 0+72+4
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 2420
;2420:	verts[3].st[0] = 1;
ADDRLP4 0+72+12
CNSTF4 1065353216
ASGNF4
line 2421
;2421:	verts[3].st[1] = 0;
ADDRLP4 0+72+12+4
CNSTF4 0
ASGNF4
line 2422
;2422:	verts[3].modulate[0] = 255;
ADDRLP4 0+72+20
CNSTU1 255
ASGNU1
line 2423
;2423:	verts[3].modulate[1] = 255;
ADDRLP4 0+72+20+1
CNSTU1 255
ASGNU1
line 2424
;2424:	verts[3].modulate[2] = 255;
ADDRLP4 0+72+20+2
CNSTU1 255
ASGNU1
line 2425
;2425:	verts[3].modulate[3] = 255;
ADDRLP4 0+72+20+3
CNSTU1 255
ASGNU1
line 2427
;2426:
;2427:	trap_R_AddPolyToScene( cgs.media.wakeMarkShader, 4, verts );
ADDRGP4 cgs+148772+408
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddPolyToScene
CALLV
pop
line 2428
;2428:}
LABELV $1271
endproc CG_PlayerSplash 188 28
export CG_AddRefEntityWithPowerups
proc CG_AddRefEntityWithPowerups 0 4
line 2439
;2429:
;2430:
;2431:/*
;2432:===============
;2433:CG_AddRefEntityWithPowerups
;2434:
;2435:Adds a piece with modifications or duplications for powerups
;2436:Also called by CG_Missile for quad rockets, but nobody can tell...
;2437:===============
;2438:*/
;2439:void CG_AddRefEntityWithPowerups( refEntity_t *ent, entityState_t *state, int team ) {
line 2441
;2440:
;2441:	if ( state->powerups & ( 1 << PW_INVIS ) ) {
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1362
line 2442
;2442:		ent->customShader = cgs.media.invisShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+148772+444
INDIRI4
ASGNI4
line 2443
;2443:		trap_R_AddRefEntityToScene( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2444
;2444:	} else {
ADDRGP4 $1363
JUMPV
LABELV $1362
line 2454
;2445:		/*
;2446:		if ( state->eFlags & EF_KAMIKAZE ) {
;2447:			if (team == TEAM_BLUE)
;2448:				ent->customShader = cgs.media.blueKamikazeShader;
;2449:			else
;2450:				ent->customShader = cgs.media.redKamikazeShader;
;2451:			trap_R_AddRefEntityToScene( ent );
;2452:		}
;2453:		else {*/
;2454:			trap_R_AddRefEntityToScene( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2457
;2455:		//}
;2456:
;2457:		if ( state->powerups & ( 1 << PW_QUAD ) )
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1366
line 2458
;2458:		{
line 2459
;2459:			if (team == TEAM_RED)
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $1368
line 2460
;2460:				ent->customShader = cgs.media.redQuadShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+148772+436
INDIRI4
ASGNI4
ADDRGP4 $1369
JUMPV
LABELV $1368
line 2462
;2461:			else
;2462:				ent->customShader = cgs.media.quadShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+148772+432
INDIRI4
ASGNI4
LABELV $1369
line 2463
;2463:			trap_R_AddRefEntityToScene( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2464
;2464:		}
LABELV $1366
line 2465
;2465:		if ( state->powerups & ( 1 << PW_REGEN ) ) {
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1374
line 2466
;2466:			if ( ( ( cg.time / 100 ) % 10 ) == 1 ) {
ADDRGP4 cg+107604
INDIRI4
CNSTI4 100
DIVI4
CNSTI4 10
MODI4
CNSTI4 1
NEI4 $1376
line 2467
;2467:				ent->customShader = cgs.media.regenShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+148772+448
INDIRI4
ASGNI4
line 2468
;2468:				trap_R_AddRefEntityToScene( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2469
;2469:			}
LABELV $1376
line 2470
;2470:		}
LABELV $1374
line 2471
;2471:		if ( state->powerups & ( 1 << PW_BATTLESUIT ) ) {
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1381
line 2472
;2472:			ent->customShader = cgs.media.battleSuitShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+148772+452
INDIRI4
ASGNI4
line 2473
;2473:			trap_R_AddRefEntityToScene( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2474
;2474:		}
LABELV $1381
line 2475
;2475:	}
LABELV $1363
line 2476
;2476:}
LABELV $1361
endproc CG_AddRefEntityWithPowerups 0 4
export CG_LightVerts
proc CG_LightVerts 88 16
line 2485
;2477:
;2478:
;2479:/*
;2480:=================
;2481:CG_LightVerts
;2482:=================
;2483:*/
;2484:int CG_LightVerts( vec3_t normal, int numVerts, polyVert_t *verts )
;2485:{
line 2492
;2486:	int				i, j;
;2487:	float			incoming;
;2488:	vec3_t			ambientLight;
;2489:	vec3_t			lightDir;
;2490:	vec3_t			directedLight;
;2491:
;2492:	trap_R_LightForPoint( verts[0].xyz, ambientLight, directedLight, lightDir );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 trap_R_LightForPoint
CALLI4
pop
line 2494
;2493:
;2494:	for (i = 0; i < numVerts; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1389
JUMPV
LABELV $1386
line 2495
;2495:		incoming = DotProduct (normal, lightDir);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 48
INDIRP4
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDRLP4 48
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 48
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2496
;2496:		if ( incoming <= 0 ) {
ADDRLP4 8
INDIRF4
CNSTF4 0
GTF4 $1392
line 2497
;2497:			verts[i].modulate[0] = ambientLight[0];
ADDRLP4 56
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 60
CNSTF4 1325400064
ASGNF4
ADDRLP4 56
INDIRF4
ADDRLP4 60
INDIRF4
LTF4 $1395
ADDRLP4 52
ADDRLP4 56
INDIRF4
ADDRLP4 60
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1396
JUMPV
LABELV $1395
ADDRLP4 52
ADDRLP4 56
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1396
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
ADDRLP4 52
INDIRU4
CVUU1 4
ASGNU1
line 2498
;2498:			verts[i].modulate[1] = ambientLight[1];
ADDRLP4 68
ADDRLP4 12+4
INDIRF4
ASGNF4
ADDRLP4 72
CNSTF4 1325400064
ASGNF4
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
LTF4 $1399
ADDRLP4 64
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1400
JUMPV
LABELV $1399
ADDRLP4 64
ADDRLP4 68
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1400
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 21
ADDP4
ADDRLP4 64
INDIRU4
CVUU1 4
ASGNU1
line 2499
;2499:			verts[i].modulate[2] = ambientLight[2];
ADDRLP4 80
ADDRLP4 12+8
INDIRF4
ASGNF4
ADDRLP4 84
CNSTF4 1325400064
ASGNF4
ADDRLP4 80
INDIRF4
ADDRLP4 84
INDIRF4
LTF4 $1403
ADDRLP4 76
ADDRLP4 80
INDIRF4
ADDRLP4 84
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1404
JUMPV
LABELV $1403
ADDRLP4 76
ADDRLP4 80
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1404
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 22
ADDP4
ADDRLP4 76
INDIRU4
CVUU1 4
ASGNU1
line 2500
;2500:			verts[i].modulate[3] = 255;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 23
ADDP4
CNSTU1 255
ASGNU1
line 2501
;2501:			continue;
ADDRGP4 $1387
JUMPV
LABELV $1392
line 2503
;2502:		} 
;2503:		j = ( ambientLight[0] + incoming * directedLight[0] );
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 2504
;2504:		if ( j > 255 ) {
ADDRLP4 0
INDIRI4
CNSTI4 255
LEI4 $1405
line 2505
;2505:			j = 255;
ADDRLP4 0
CNSTI4 255
ASGNI4
line 2506
;2506:		}
LABELV $1405
line 2507
;2507:		verts[i].modulate[0] = j;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
ADDRLP4 0
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 2509
;2508:
;2509:		j = ( ambientLight[1] + incoming * directedLight[1] );
ADDRLP4 0
ADDRLP4 12+4
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 36+4
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 2510
;2510:		if ( j > 255 ) {
ADDRLP4 0
INDIRI4
CNSTI4 255
LEI4 $1409
line 2511
;2511:			j = 255;
ADDRLP4 0
CNSTI4 255
ASGNI4
line 2512
;2512:		}
LABELV $1409
line 2513
;2513:		verts[i].modulate[1] = j;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 21
ADDP4
ADDRLP4 0
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 2515
;2514:
;2515:		j = ( ambientLight[2] + incoming * directedLight[2] );
ADDRLP4 0
ADDRLP4 12+8
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 36+8
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 2516
;2516:		if ( j > 255 ) {
ADDRLP4 0
INDIRI4
CNSTI4 255
LEI4 $1413
line 2517
;2517:			j = 255;
ADDRLP4 0
CNSTI4 255
ASGNI4
line 2518
;2518:		}
LABELV $1413
line 2519
;2519:		verts[i].modulate[2] = j;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 22
ADDP4
ADDRLP4 0
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 2521
;2520:
;2521:		verts[i].modulate[3] = 255;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 23
ADDP4
CNSTU1 255
ASGNU1
line 2522
;2522:	}
LABELV $1387
line 2494
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1389
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $1386
line 2523
;2523:	return qtrue;
CNSTI4 1
RETI4
LABELV $1385
endproc CG_LightVerts 88 16
export CG_Player
proc CG_Player 812 28
line 2532
;2524:}
;2525:
;2526:
;2527:/*
;2528:===============
;2529:CG_Player
;2530:===============
;2531:*/
;2532:void CG_Player( centity_t *cent ) {
line 2554
;2533:	clientInfo_t	*ci;
;2534:	refEntity_t		legs;
;2535:	refEntity_t		torso;
;2536:	refEntity_t		head;
;2537:	int				clientNum;
;2538:	int				renderfx;
;2539:	qboolean		shadow;
;2540:	float			shadowPlane;
;2541:#ifdef MISSIONPACK
;2542:	refEntity_t		skull;
;2543:	refEntity_t		powerup;
;2544:	int				t;
;2545:	float			c;
;2546:	float			angle;
;2547:	vec3_t			dir, angles;
;2548:#endif
;2549:	qboolean		darken;
;2550:
;2551:	// the client number is stored in clientNum.  It can't be derived
;2552:	// from the entity number, because a single client may have
;2553:	// multiple corpses on the level using the same clientinfo
;2554:	clientNum = cent->currentState.clientNum;
ADDRLP4 752
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 2555
;2555:	if ( (unsigned) clientNum >= MAX_CLIENTS ) {
ADDRLP4 752
INDIRI4
CVIU4 4
CNSTU4 64
LTU4 $1416
line 2556
;2556:		CG_Error( "Bad clientNum on player entity" );
ADDRGP4 $1418
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 2557
;2557:	}
LABELV $1416
line 2558
;2558:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 280
ADDRLP4 752
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 2562
;2559:
;2560:	// it is possible to see corpses from disconnected players that may
;2561:	// not have valid clientinfo
;2562:	if ( !ci->infoValid ) {
ADDRLP4 280
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $1420
line 2563
;2563:		return;
ADDRGP4 $1415
JUMPV
LABELV $1420
line 2567
;2564:	}
;2565:
;2566:	// get the player model information
;2567:	renderfx = 0;
ADDRLP4 704
CNSTI4 0
ASGNI4
line 2568
;2568:	if ( cent->currentState.number == cg.snap->ps.clientNum) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $1422
line 2569
;2569:		if (!cg.renderingThirdPerson) {
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
NEI4 $1425
line 2570
;2570:			renderfx = RF_THIRD_PERSON;			// only draw in mirrors
ADDRLP4 704
CNSTI4 2
ASGNI4
line 2571
;2571:		} else {
ADDRGP4 $1426
JUMPV
LABELV $1425
line 2572
;2572:			if (cg_cameraMode.integer) {
ADDRGP4 cg_cameraMode+12
INDIRI4
CNSTI4 0
EQI4 $1428
line 2573
;2573:				return;
ADDRGP4 $1415
JUMPV
LABELV $1428
line 2575
;2574:			}
;2575:		}
LABELV $1426
line 2576
;2576:	}
LABELV $1422
line 2578
;2577:
;2578:	if ( cg_deadBodyDarken.integer && cent->currentState.eFlags & EF_DEAD )
ADDRGP4 cg_deadBodyDarken+12
INDIRI4
CNSTI4 0
EQI4 $1431
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1431
line 2579
;2579:		darken = qtrue;
ADDRLP4 740
CNSTI4 1
ASGNI4
ADDRGP4 $1432
JUMPV
LABELV $1431
line 2581
;2580:	else
;2581:		darken = qfalse;
ADDRLP4 740
CNSTI4 0
ASGNI4
LABELV $1432
line 2583
;2582:
;2583:	memset( &legs, 0, sizeof(legs) );
ADDRLP4 284
ARGP4
CNSTI4 0
ARGI4
CNSTU4 140
ARGU4
ADDRGP4 memset
CALLP4
pop
line 2584
;2584:	memset( &torso, 0, sizeof(torso) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTU4 140
ARGU4
ADDRGP4 memset
CALLP4
pop
line 2585
;2585:	memset( &head, 0, sizeof(head) );
ADDRLP4 424
ARGP4
CNSTI4 0
ARGI4
CNSTU4 140
ARGU4
ADDRGP4 memset
CALLP4
pop
line 2588
;2586:
;2587:	// get the rotation information
;2588:	CG_PlayerAngles( cent, legs.axis, torso.axis, head.axis );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 284+28
ARGP4
ADDRLP4 0+28
ARGP4
ADDRLP4 424+28
ARGP4
ADDRGP4 CG_PlayerAngles
CALLV
pop
line 2591
;2589:	
;2590:	// get the animation state (after rotation, to allow feet shuffle)
;2591:	CG_PlayerAnimation( cent, &legs.oldframe, &legs.frame, &legs.backlerp,
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 284+96
ARGP4
ADDRLP4 284+80
ARGP4
ADDRLP4 284+100
ARGP4
ADDRLP4 0+96
ARGP4
ADDRLP4 0+80
ARGP4
ADDRLP4 0+100
ARGP4
ADDRGP4 CG_PlayerAnimation
CALLV
pop
line 2595
;2592:		 &torso.oldframe, &torso.frame, &torso.backlerp );
;2593:
;2594:	// add the talk baloon or disconnect icon
;2595:	CG_PlayerSprites( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_PlayerSprites
CALLV
pop
line 2598
;2596:
;2597:	// add the shadow
;2598:	shadow = CG_PlayerShadow( cent, &shadowPlane );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 736
ARGP4
ADDRLP4 760
ADDRGP4 CG_PlayerShadow
CALLI4
ASGNI4
ADDRLP4 756
ADDRLP4 760
INDIRI4
ASGNI4
line 2601
;2599:
;2600:	// add a water splash if partially in and out of water
;2601:	CG_PlayerSplash( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_PlayerSplash
CALLV
pop
line 2603
;2602:
;2603:	if ( cg_shadows.integer == 3 && shadow ) {
ADDRGP4 cg_shadows+12
INDIRI4
CNSTI4 3
NEI4 $1443
ADDRLP4 756
INDIRI4
CNSTI4 0
EQI4 $1443
line 2604
;2604:		renderfx |= RF_SHADOW_PLANE;
ADDRLP4 704
ADDRLP4 704
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 2605
;2605:	}
LABELV $1443
line 2606
;2606:	renderfx |= RF_LIGHTING_ORIGIN;			// use the same origin for all
ADDRLP4 704
ADDRLP4 704
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 2608
;2607:#ifdef MISSIONPACK
;2608:	if( cgs.gametype == GT_HARVESTER ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 7
NEI4 $1446
line 2609
;2609:		CG_PlayerTokens( cent, renderfx );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 704
INDIRI4
ARGI4
ADDRGP4 CG_PlayerTokens
CALLV
pop
line 2610
;2610:	}
LABELV $1446
line 2615
;2611:#endif
;2612:	//
;2613:	// add the legs
;2614:	//
;2615:	legs.hModel = ci->legsModel;
ADDRLP4 284+8
ADDRLP4 280
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
ASGNI4
line 2616
;2616:	legs.customSkin = ci->legsSkin;
ADDRLP4 284+108
ADDRLP4 280
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
ASGNI4
line 2618
;2617:
;2618:	VectorCopy( cent->lerpOrigin, legs.origin );
ADDRLP4 284+68
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2620
;2619:
;2620:	VectorCopy( cent->lerpOrigin, legs.lightingOrigin );
ADDRLP4 284+12
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2621
;2621:	legs.shadowPlane = shadowPlane;
ADDRLP4 284+24
ADDRLP4 736
INDIRF4
ASGNF4
line 2622
;2622:	legs.renderfx = renderfx;
ADDRLP4 284+4
ADDRLP4 704
INDIRI4
ASGNI4
line 2623
;2623:	VectorCopy (legs.origin, legs.oldorigin);	// don't positionally lerp at all
ADDRLP4 284+84
ADDRLP4 284+68
INDIRB
ASGNB 12
line 2626
;2624:
;2625:	// colored skin
;2626:	if ( darken ) {
ADDRLP4 740
INDIRI4
CNSTI4 0
EQI4 $1457
line 2627
;2627:		legs.shaderRGBA[0] = 85;
ADDRLP4 284+116
CNSTU1 85
ASGNU1
line 2628
;2628:		legs.shaderRGBA[1] = 85;
ADDRLP4 284+116+1
CNSTU1 85
ASGNU1
line 2629
;2629:		legs.shaderRGBA[2] = 85;
ADDRLP4 284+116+2
CNSTU1 85
ASGNU1
line 2630
;2630:	} else {
ADDRGP4 $1458
JUMPV
LABELV $1457
line 2631
;2631:		legs.shaderRGBA[0] = ci->legsColor[0] * 255;
ADDRLP4 768
ADDRLP4 280
INDIRP4
CNSTI4 1640
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 772
CNSTF4 1325400064
ASGNF4
ADDRLP4 768
INDIRF4
ADDRLP4 772
INDIRF4
LTF4 $1466
ADDRLP4 764
ADDRLP4 768
INDIRF4
ADDRLP4 772
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1467
JUMPV
LABELV $1466
ADDRLP4 764
ADDRLP4 768
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1467
ADDRLP4 284+116
ADDRLP4 764
INDIRU4
CVUU1 4
ASGNU1
line 2632
;2632:		legs.shaderRGBA[1] = ci->legsColor[1] * 255;
ADDRLP4 780
ADDRLP4 280
INDIRP4
CNSTI4 1644
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 784
CNSTF4 1325400064
ASGNF4
ADDRLP4 780
INDIRF4
ADDRLP4 784
INDIRF4
LTF4 $1471
ADDRLP4 776
ADDRLP4 780
INDIRF4
ADDRLP4 784
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1472
JUMPV
LABELV $1471
ADDRLP4 776
ADDRLP4 780
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1472
ADDRLP4 284+116+1
ADDRLP4 776
INDIRU4
CVUU1 4
ASGNU1
line 2633
;2633:		legs.shaderRGBA[2] = ci->legsColor[2] * 255;
ADDRLP4 792
ADDRLP4 280
INDIRP4
CNSTI4 1648
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 796
CNSTF4 1325400064
ASGNF4
ADDRLP4 792
INDIRF4
ADDRLP4 796
INDIRF4
LTF4 $1476
ADDRLP4 788
ADDRLP4 792
INDIRF4
ADDRLP4 796
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1477
JUMPV
LABELV $1476
ADDRLP4 788
ADDRLP4 792
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1477
ADDRLP4 284+116+2
ADDRLP4 788
INDIRU4
CVUU1 4
ASGNU1
line 2634
;2634:	}
LABELV $1458
line 2635
;2635:	legs.shaderRGBA[3] = 255;
ADDRLP4 284+116+3
CNSTU1 255
ASGNU1
line 2637
;2636:
;2637:	CG_AddRefEntityWithPowerups( &legs, &cent->currentState, ci->team );
ADDRLP4 284
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 280
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddRefEntityWithPowerups
CALLV
pop
line 2640
;2638:
;2639:	// if the model failed, allow the default nullmodel to be displayed
;2640:	if (!legs.hModel) {
ADDRLP4 284+8
INDIRI4
CNSTI4 0
NEI4 $1480
line 2641
;2641:		return;
ADDRGP4 $1415
JUMPV
LABELV $1480
line 2647
;2642:	}
;2643:
;2644:	//
;2645:	// add the torso
;2646:	//
;2647:	torso.hModel = ci->torsoModel;
ADDRLP4 0+8
ADDRLP4 280
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
ASGNI4
line 2648
;2648:	if (!torso.hModel) {
ADDRLP4 0+8
INDIRI4
CNSTI4 0
NEI4 $1484
line 2649
;2649:		return;
ADDRGP4 $1415
JUMPV
LABELV $1484
line 2652
;2650:	}
;2651:
;2652:	torso.customSkin = ci->torsoSkin;
ADDRLP4 0+108
ADDRLP4 280
INDIRP4
CNSTI4 432
ADDP4
INDIRI4
ASGNI4
line 2654
;2653:
;2654:	VectorCopy( cent->lerpOrigin, torso.lightingOrigin );
ADDRLP4 0+12
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2656
;2655:
;2656:	CG_PositionRotatedEntityOnTag( &torso, &legs, ci->legsModel, "tag_torso");
ADDRLP4 0
ARGP4
ADDRLP4 284
ARGP4
ADDRLP4 280
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
ARGI4
ADDRGP4 $1489
ARGP4
ADDRGP4 CG_PositionRotatedEntityOnTag
CALLV
pop
line 2658
;2657:
;2658:	torso.shadowPlane = shadowPlane;
ADDRLP4 0+24
ADDRLP4 736
INDIRF4
ASGNF4
line 2659
;2659:	torso.renderfx = renderfx;
ADDRLP4 0+4
ADDRLP4 704
INDIRI4
ASGNI4
line 2662
;2660:
;2661:	// colored skin
;2662:	if ( darken ) {
ADDRLP4 740
INDIRI4
CNSTI4 0
EQI4 $1492
line 2663
;2663:		torso.shaderRGBA[0] = 85;
ADDRLP4 0+116
CNSTU1 85
ASGNU1
line 2664
;2664:		torso.shaderRGBA[1] = 85;
ADDRLP4 0+116+1
CNSTU1 85
ASGNU1
line 2665
;2665:		torso.shaderRGBA[2] = 85;
ADDRLP4 0+116+2
CNSTU1 85
ASGNU1
line 2666
;2666:	} else {
ADDRGP4 $1493
JUMPV
LABELV $1492
line 2667
;2667:		torso.shaderRGBA[0] = ci->bodyColor[0] * 255;
ADDRLP4 768
ADDRLP4 280
INDIRP4
CNSTI4 1628
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 772
CNSTF4 1325400064
ASGNF4
ADDRLP4 768
INDIRF4
ADDRLP4 772
INDIRF4
LTF4 $1501
ADDRLP4 764
ADDRLP4 768
INDIRF4
ADDRLP4 772
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1502
JUMPV
LABELV $1501
ADDRLP4 764
ADDRLP4 768
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1502
ADDRLP4 0+116
ADDRLP4 764
INDIRU4
CVUU1 4
ASGNU1
line 2668
;2668:		torso.shaderRGBA[1] = ci->bodyColor[1] * 255;
ADDRLP4 780
ADDRLP4 280
INDIRP4
CNSTI4 1632
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 784
CNSTF4 1325400064
ASGNF4
ADDRLP4 780
INDIRF4
ADDRLP4 784
INDIRF4
LTF4 $1506
ADDRLP4 776
ADDRLP4 780
INDIRF4
ADDRLP4 784
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1507
JUMPV
LABELV $1506
ADDRLP4 776
ADDRLP4 780
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1507
ADDRLP4 0+116+1
ADDRLP4 776
INDIRU4
CVUU1 4
ASGNU1
line 2669
;2669:		torso.shaderRGBA[2] = ci->bodyColor[2] * 255;
ADDRLP4 792
ADDRLP4 280
INDIRP4
CNSTI4 1636
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 796
CNSTF4 1325400064
ASGNF4
ADDRLP4 792
INDIRF4
ADDRLP4 796
INDIRF4
LTF4 $1511
ADDRLP4 788
ADDRLP4 792
INDIRF4
ADDRLP4 796
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1512
JUMPV
LABELV $1511
ADDRLP4 788
ADDRLP4 792
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1512
ADDRLP4 0+116+2
ADDRLP4 788
INDIRU4
CVUU1 4
ASGNU1
line 2670
;2670:	}
LABELV $1493
line 2671
;2671:	torso.shaderRGBA[3] = 255;
ADDRLP4 0+116+3
CNSTU1 255
ASGNU1
line 2673
;2672:
;2673:	CG_AddRefEntityWithPowerups( &torso, &cent->currentState, ci->team );
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 280
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddRefEntityWithPowerups
CALLV
pop
line 2676
;2674:
;2675:#ifdef MISSIONPACK
;2676:	if ( cent->currentState.eFlags & EF_KAMIKAZE ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $1515
line 2678
;2677:
;2678:		memset( &skull, 0, sizeof(skull) );
ADDRLP4 564
ARGP4
CNSTI4 0
ARGI4
CNSTU4 140
ARGU4
ADDRGP4 memset
CALLP4
pop
line 2680
;2679:
;2680:		VectorCopy( cent->lerpOrigin, skull.lightingOrigin );
ADDRLP4 564+12
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2681
;2681:		skull.shadowPlane = shadowPlane;
ADDRLP4 564+24
ADDRLP4 736
INDIRF4
ASGNF4
line 2682
;2682:		skull.renderfx = renderfx;
ADDRLP4 564+4
ADDRLP4 704
INDIRI4
ASGNI4
line 2684
;2683:
;2684:		if ( cent->currentState.eFlags & EF_DEAD ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1520
line 2686
;2685:			// one skull bobbing above the dead body
;2686:			angle = ((cg.time / 7) & 255) * (M_PI * 2) / 255;
ADDRLP4 720
ADDRGP4 cg+107604
INDIRI4
CNSTI4 7
DIVI4
CNSTI4 255
BANDI4
CVIF4 4
CNSTF4 1019861428
MULF4
ASGNF4
line 2687
;2687:			if (angle > M_PI * 2)
ADDRLP4 720
INDIRF4
CNSTF4 1086918619
LEF4 $1523
line 2688
;2688:				angle -= (float)M_PI * 2;
ADDRLP4 720
ADDRLP4 720
INDIRF4
CNSTF4 1086918619
SUBF4
ASGNF4
LABELV $1523
line 2689
;2689:			dir[0] = sin(angle) * 20;
ADDRLP4 720
INDIRF4
ARGF4
ADDRLP4 764
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 708
ADDRLP4 764
INDIRF4
CNSTF4 1101004800
MULF4
ASGNF4
line 2690
;2690:			dir[1] = cos(angle) * 20;
ADDRLP4 720
INDIRF4
ARGF4
ADDRLP4 768
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 708+4
ADDRLP4 768
INDIRF4
CNSTF4 1101004800
MULF4
ASGNF4
line 2691
;2691:			angle = ((cg.time / 4) & 255) * (M_PI * 2) / 255;
ADDRLP4 720
ADDRGP4 cg+107604
INDIRI4
CNSTI4 4
DIVI4
CNSTI4 255
BANDI4
CVIF4 4
CNSTF4 1019861428
MULF4
ASGNF4
line 2692
;2692:			dir[2] = 15 + sin(angle) * 8;
ADDRLP4 720
INDIRF4
ARGF4
ADDRLP4 772
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 708+8
ADDRLP4 772
INDIRF4
CNSTF4 1090519040
MULF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 2693
;2693:			VectorAdd(torso.origin, dir, skull.origin);
ADDRLP4 564+68
ADDRLP4 0+68
INDIRF4
ADDRLP4 708
INDIRF4
ADDF4
ASGNF4
ADDRLP4 564+68+4
ADDRLP4 0+68+4
INDIRF4
ADDRLP4 708+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 564+68+8
ADDRLP4 0+68+8
INDIRF4
ADDRLP4 708+8
INDIRF4
ADDF4
ASGNF4
line 2695
;2694:			
;2695:			dir[2] = 0;
ADDRLP4 708+8
CNSTF4 0
ASGNF4
line 2696
;2696:			VectorCopy(dir, skull.axis[1]);
ADDRLP4 564+28+12
ADDRLP4 708
INDIRB
ASGNB 12
line 2697
;2697:			VectorNormalize(skull.axis[1]);
ADDRLP4 564+28+12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 2698
;2698:			VectorSet(skull.axis[2], 0, 0, 1);
ADDRLP4 564+28+24
CNSTF4 0
ASGNF4
ADDRLP4 564+28+24+4
CNSTF4 0
ASGNF4
ADDRLP4 564+28+24+8
CNSTF4 1065353216
ASGNF4
line 2699
;2699:			CrossProduct(skull.axis[1], skull.axis[2], skull.axis[0]);
ADDRLP4 564+28+12
ARGP4
ADDRLP4 564+28+24
ARGP4
ADDRLP4 564+28
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 2701
;2700:
;2701:			skull.hModel = cgs.media.kamikazeHeadModel;
ADDRLP4 564+8
ADDRGP4 cgs+148772+532
INDIRI4
ASGNI4
line 2702
;2702:			trap_R_AddRefEntityToScene( &skull );
ADDRLP4 564
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2703
;2703:			skull.hModel = cgs.media.kamikazeHeadTrail;
ADDRLP4 564+8
ADDRGP4 cgs+148772+536
INDIRI4
ASGNI4
line 2704
;2704:			trap_R_AddRefEntityToScene( &skull );
ADDRLP4 564
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2705
;2705:		}
ADDRGP4 $1521
JUMPV
LABELV $1520
line 2706
;2706:		else {
line 2708
;2707:			// three skulls spinning around the player
;2708:			angle = ((cg.time / 4) & 255) * (M_PI * 2) / 255;
ADDRLP4 720
ADDRGP4 cg+107604
INDIRI4
CNSTI4 4
DIVI4
CNSTI4 255
BANDI4
CVIF4 4
CNSTF4 1019861428
MULF4
ASGNF4
line 2709
;2709:			dir[0] = cos(angle) * 20;
ADDRLP4 720
INDIRF4
ARGF4
ADDRLP4 764
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 708
ADDRLP4 764
INDIRF4
CNSTF4 1101004800
MULF4
ASGNF4
line 2710
;2710:			dir[1] = sin(angle) * 20;
ADDRLP4 720
INDIRF4
ARGF4
ADDRLP4 768
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 708+4
ADDRLP4 768
INDIRF4
CNSTF4 1101004800
MULF4
ASGNF4
line 2711
;2711:			dir[2] = cos(angle) * 20;
ADDRLP4 720
INDIRF4
ARGF4
ADDRLP4 772
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 708+8
ADDRLP4 772
INDIRF4
CNSTF4 1101004800
MULF4
ASGNF4
line 2712
;2712:			VectorAdd(torso.origin, dir, skull.origin);
ADDRLP4 564+68
ADDRLP4 0+68
INDIRF4
ADDRLP4 708
INDIRF4
ADDF4
ASGNF4
ADDRLP4 564+68+4
ADDRLP4 0+68+4
INDIRF4
ADDRLP4 708+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 564+68+8
ADDRLP4 0+68+8
INDIRF4
ADDRLP4 708+8
INDIRF4
ADDF4
ASGNF4
line 2714
;2713:
;2714:			angles[0] = sin(angle) * 30;
ADDRLP4 720
INDIRF4
ARGF4
ADDRLP4 776
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 724
ADDRLP4 776
INDIRF4
CNSTF4 1106247680
MULF4
ASGNF4
line 2715
;2715:			angles[1] = (angle * 180 / M_PI) + 90;
ADDRLP4 724+4
ADDRLP4 720
INDIRF4
CNSTF4 1113927393
MULF4
CNSTF4 1119092736
ADDF4
ASGNF4
line 2716
;2716:			if (angles[1] > 360)
ADDRLP4 724+4
INDIRF4
CNSTF4 1135869952
LEF4 $1580
line 2717
;2717:				angles[1] -= 360;
ADDRLP4 724+4
ADDRLP4 724+4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $1580
line 2718
;2718:			angles[2] = 0;
ADDRLP4 724+8
CNSTF4 0
ASGNF4
line 2719
;2719:			AnglesToAxis( angles, skull.axis );
ADDRLP4 724
ARGP4
ADDRLP4 564+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 2730
;2720:
;2721:			/*
;2722:			dir[2] = 0;
;2723:			VectorInverse(dir);
;2724:			VectorCopy(dir, skull.axis[1]);
;2725:			VectorNormalize(skull.axis[1]);
;2726:			VectorSet(skull.axis[2], 0, 0, 1);
;2727:			CrossProduct(skull.axis[1], skull.axis[2], skull.axis[0]);
;2728:			*/
;2729:
;2730:			skull.hModel = cgs.media.kamikazeHeadModel;
ADDRLP4 564+8
ADDRGP4 cgs+148772+532
INDIRI4
ASGNI4
line 2731
;2731:			trap_R_AddRefEntityToScene( &skull );
ADDRLP4 564
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2733
;2732:			// flip the trail because this skull is spinning in the other direction
;2733:			VectorInverse(skull.axis[1]);
ADDRLP4 564+28+12
ARGP4
ADDRGP4 VectorInverse
CALLV
pop
line 2734
;2734:			skull.hModel = cgs.media.kamikazeHeadTrail;
ADDRLP4 564+8
ADDRGP4 cgs+148772+536
INDIRI4
ASGNI4
line 2735
;2735:			trap_R_AddRefEntityToScene( &skull );
ADDRLP4 564
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2737
;2736:
;2737:			angle = ((cg.time / 4) & 255) * (M_PI * 2) / 255 + M_PI;
ADDRLP4 720
ADDRGP4 cg+107604
INDIRI4
CNSTI4 4
DIVI4
CNSTI4 255
BANDI4
CVIF4 4
CNSTF4 1019861428
MULF4
CNSTF4 1078530011
ADDF4
ASGNF4
line 2738
;2738:			if (angle > M_PI * 2)
ADDRLP4 720
INDIRF4
CNSTF4 1086918619
LEF4 $1595
line 2739
;2739:				angle -= (float)M_PI * 2;
ADDRLP4 720
ADDRLP4 720
INDIRF4
CNSTF4 1086918619
SUBF4
ASGNF4
LABELV $1595
line 2740
;2740:			dir[0] = sin(angle) * 20;
ADDRLP4 720
INDIRF4
ARGF4
ADDRLP4 780
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 708
ADDRLP4 780
INDIRF4
CNSTF4 1101004800
MULF4
ASGNF4
line 2741
;2741:			dir[1] = cos(angle) * 20;
ADDRLP4 720
INDIRF4
ARGF4
ADDRLP4 784
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 708+4
ADDRLP4 784
INDIRF4
CNSTF4 1101004800
MULF4
ASGNF4
line 2742
;2742:			dir[2] = cos(angle) * 20;
ADDRLP4 720
INDIRF4
ARGF4
ADDRLP4 788
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 708+8
ADDRLP4 788
INDIRF4
CNSTF4 1101004800
MULF4
ASGNF4
line 2743
;2743:			VectorAdd(torso.origin, dir, skull.origin);
ADDRLP4 564+68
ADDRLP4 0+68
INDIRF4
ADDRLP4 708
INDIRF4
ADDF4
ASGNF4
ADDRLP4 564+68+4
ADDRLP4 0+68+4
INDIRF4
ADDRLP4 708+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 564+68+8
ADDRLP4 0+68+8
INDIRF4
ADDRLP4 708+8
INDIRF4
ADDF4
ASGNF4
line 2745
;2744:
;2745:			angles[0] = cos(angle - 0.5 * M_PI) * 30;
ADDRLP4 720
INDIRF4
CNSTF4 1070141403
SUBF4
ARGF4
ADDRLP4 792
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 724
ADDRLP4 792
INDIRF4
CNSTF4 1106247680
MULF4
ASGNF4
line 2746
;2746:			angles[1] = 360 - (angle * 180 / M_PI);
ADDRLP4 724+4
CNSTF4 1135869952
ADDRLP4 720
INDIRF4
CNSTF4 1113927393
MULF4
SUBF4
ASGNF4
line 2747
;2747:			if (angles[1] > 360)
ADDRLP4 724+4
INDIRF4
CNSTF4 1135869952
LEF4 $1612
line 2748
;2748:				angles[1] -= 360;
ADDRLP4 724+4
ADDRLP4 724+4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $1612
line 2749
;2749:			angles[2] = 0;
ADDRLP4 724+8
CNSTF4 0
ASGNF4
line 2750
;2750:			AnglesToAxis( angles, skull.axis );
ADDRLP4 724
ARGP4
ADDRLP4 564+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 2760
;2751:
;2752:			/*
;2753:			dir[2] = 0;
;2754:			VectorCopy(dir, skull.axis[1]);
;2755:			VectorNormalize(skull.axis[1]);
;2756:			VectorSet(skull.axis[2], 0, 0, 1);
;2757:			CrossProduct(skull.axis[1], skull.axis[2], skull.axis[0]);
;2758:			*/
;2759:
;2760:			skull.hModel = cgs.media.kamikazeHeadModel;
ADDRLP4 564+8
ADDRGP4 cgs+148772+532
INDIRI4
ASGNI4
line 2761
;2761:			trap_R_AddRefEntityToScene( &skull );
ADDRLP4 564
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2762
;2762:			skull.hModel = cgs.media.kamikazeHeadTrail;
ADDRLP4 564+8
ADDRGP4 cgs+148772+536
INDIRI4
ASGNI4
line 2763
;2763:			trap_R_AddRefEntityToScene( &skull );
ADDRLP4 564
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2765
;2764:
;2765:			angle = ((cg.time / 3) & 255) * (M_PI * 2) / 255 + 0.5 * M_PI;
ADDRLP4 720
ADDRGP4 cg+107604
INDIRI4
CNSTI4 3
DIVI4
CNSTI4 255
BANDI4
CVIF4 4
CNSTF4 1019861428
MULF4
CNSTF4 1070141403
ADDF4
ASGNF4
line 2766
;2766:			if (angle > M_PI * 2)
ADDRLP4 720
INDIRF4
CNSTF4 1086918619
LEF4 $1625
line 2767
;2767:				angle -= (float)M_PI * 2;
ADDRLP4 720
ADDRLP4 720
INDIRF4
CNSTF4 1086918619
SUBF4
ASGNF4
LABELV $1625
line 2768
;2768:			dir[0] = sin(angle) * 20;
ADDRLP4 720
INDIRF4
ARGF4
ADDRLP4 796
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 708
ADDRLP4 796
INDIRF4
CNSTF4 1101004800
MULF4
ASGNF4
line 2769
;2769:			dir[1] = cos(angle) * 20;
ADDRLP4 720
INDIRF4
ARGF4
ADDRLP4 800
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 708+4
ADDRLP4 800
INDIRF4
CNSTF4 1101004800
MULF4
ASGNF4
line 2770
;2770:			dir[2] = 0;
ADDRLP4 708+8
CNSTF4 0
ASGNF4
line 2771
;2771:			VectorAdd(torso.origin, dir, skull.origin);
ADDRLP4 564+68
ADDRLP4 0+68
INDIRF4
ADDRLP4 708
INDIRF4
ADDF4
ASGNF4
ADDRLP4 564+68+4
ADDRLP4 0+68+4
INDIRF4
ADDRLP4 708+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 564+68+8
ADDRLP4 0+68+8
INDIRF4
ADDRLP4 708+8
INDIRF4
ADDF4
ASGNF4
line 2773
;2772:			
;2773:			VectorCopy(dir, skull.axis[1]);
ADDRLP4 564+28+12
ADDRLP4 708
INDIRB
ASGNB 12
line 2774
;2774:			VectorNormalize(skull.axis[1]);
ADDRLP4 564+28+12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 2775
;2775:			VectorSet(skull.axis[2], 0, 0, 1);
ADDRLP4 564+28+24
CNSTF4 0
ASGNF4
ADDRLP4 564+28+24+4
CNSTF4 0
ASGNF4
ADDRLP4 564+28+24+8
CNSTF4 1065353216
ASGNF4
line 2776
;2776:			CrossProduct(skull.axis[1], skull.axis[2], skull.axis[0]);
ADDRLP4 564+28+12
ARGP4
ADDRLP4 564+28+24
ARGP4
ADDRLP4 564+28
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 2778
;2777:
;2778:			skull.hModel = cgs.media.kamikazeHeadModel;
ADDRLP4 564+8
ADDRGP4 cgs+148772+532
INDIRI4
ASGNI4
line 2779
;2779:			trap_R_AddRefEntityToScene( &skull );
ADDRLP4 564
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2780
;2780:			skull.hModel = cgs.media.kamikazeHeadTrail;
ADDRLP4 564+8
ADDRGP4 cgs+148772+536
INDIRI4
ASGNI4
line 2781
;2781:			trap_R_AddRefEntityToScene( &skull );
ADDRLP4 564
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2782
;2782:		}
LABELV $1521
line 2783
;2783:	}
LABELV $1515
line 2785
;2784:
;2785:	if ( cent->currentState.powerups & ( 1 << PW_GUARD ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1664
line 2786
;2786:		memcpy(&powerup, &torso, sizeof(torso));
ADDRLP4 140
ARGP4
ADDRLP4 0
ARGP4
CNSTU4 140
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 2787
;2787:		powerup.hModel = cgs.media.guardPowerupModel;
ADDRLP4 140+8
ADDRGP4 cgs+148772+540
INDIRI4
ASGNI4
line 2788
;2788:		powerup.frame = 0;
ADDRLP4 140+80
CNSTI4 0
ASGNI4
line 2789
;2789:		powerup.oldframe = 0;
ADDRLP4 140+96
CNSTI4 0
ASGNI4
line 2790
;2790:		powerup.customSkin = 0;
ADDRLP4 140+108
CNSTI4 0
ASGNI4
line 2791
;2791:		powerup.customShader = 0;
ADDRLP4 140+112
CNSTI4 0
ASGNI4
line 2792
;2792:		trap_R_AddRefEntityToScene( &powerup );
ADDRLP4 140
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2793
;2793:	}
LABELV $1664
line 2794
;2794:	if ( cent->currentState.powerups & ( 1 << PW_SCOUT ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1673
line 2795
;2795:		memcpy(&powerup, &torso, sizeof(torso));
ADDRLP4 140
ARGP4
ADDRLP4 0
ARGP4
CNSTU4 140
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 2796
;2796:		powerup.hModel = cgs.media.scoutPowerupModel;
ADDRLP4 140+8
ADDRGP4 cgs+148772+544
INDIRI4
ASGNI4
line 2797
;2797:		powerup.frame = 0;
ADDRLP4 140+80
CNSTI4 0
ASGNI4
line 2798
;2798:		powerup.oldframe = 0;
ADDRLP4 140+96
CNSTI4 0
ASGNI4
line 2799
;2799:		powerup.customSkin = 0;
ADDRLP4 140+108
CNSTI4 0
ASGNI4
line 2800
;2800:		powerup.customShader = 0;
ADDRLP4 140+112
CNSTI4 0
ASGNI4
line 2801
;2801:		trap_R_AddRefEntityToScene( &powerup );
ADDRLP4 140
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2802
;2802:	}
LABELV $1673
line 2803
;2803:	if ( cent->currentState.powerups & ( 1 << PW_DOUBLER ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $1682
line 2804
;2804:		memcpy(&powerup, &torso, sizeof(torso));
ADDRLP4 140
ARGP4
ADDRLP4 0
ARGP4
CNSTU4 140
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 2805
;2805:		powerup.hModel = cgs.media.doublerPowerupModel;
ADDRLP4 140+8
ADDRGP4 cgs+148772+548
INDIRI4
ASGNI4
line 2806
;2806:		powerup.frame = 0;
ADDRLP4 140+80
CNSTI4 0
ASGNI4
line 2807
;2807:		powerup.oldframe = 0;
ADDRLP4 140+96
CNSTI4 0
ASGNI4
line 2808
;2808:		powerup.customSkin = 0;
ADDRLP4 140+108
CNSTI4 0
ASGNI4
line 2809
;2809:		powerup.customShader = 0;
ADDRLP4 140+112
CNSTI4 0
ASGNI4
line 2810
;2810:		trap_R_AddRefEntityToScene( &powerup );
ADDRLP4 140
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2811
;2811:	}
LABELV $1682
line 2812
;2812:	if ( cent->currentState.powerups & ( 1 << PW_AMMOREGEN ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1691
line 2813
;2813:		memcpy(&powerup, &torso, sizeof(torso));
ADDRLP4 140
ARGP4
ADDRLP4 0
ARGP4
CNSTU4 140
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 2814
;2814:		powerup.hModel = cgs.media.ammoRegenPowerupModel;
ADDRLP4 140+8
ADDRGP4 cgs+148772+552
INDIRI4
ASGNI4
line 2815
;2815:		powerup.frame = 0;
ADDRLP4 140+80
CNSTI4 0
ASGNI4
line 2816
;2816:		powerup.oldframe = 0;
ADDRLP4 140+96
CNSTI4 0
ASGNI4
line 2817
;2817:		powerup.customSkin = 0;
ADDRLP4 140+108
CNSTI4 0
ASGNI4
line 2818
;2818:		powerup.customShader = 0;
ADDRLP4 140+112
CNSTI4 0
ASGNI4
line 2819
;2819:		trap_R_AddRefEntityToScene( &powerup );
ADDRLP4 140
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2820
;2820:	}
LABELV $1691
line 2821
;2821:	if ( cent->currentState.powerups & ( 1 << PW_INVULNERABILITY ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $1700
line 2822
;2822:		if ( !ci->invulnerabilityStartTime ) {
ADDRLP4 280
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1702
line 2823
;2823:			ci->invulnerabilityStartTime = cg.time;
ADDRLP4 280
INDIRP4
CNSTI4 116
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 2824
;2824:		}
LABELV $1702
line 2825
;2825:		ci->invulnerabilityStopTime = cg.time;
ADDRLP4 280
INDIRP4
CNSTI4 120
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 2826
;2826:	}
ADDRGP4 $1701
JUMPV
LABELV $1700
line 2827
;2827:	else {
line 2828
;2828:		ci->invulnerabilityStartTime = 0;
ADDRLP4 280
INDIRP4
CNSTI4 116
ADDP4
CNSTI4 0
ASGNI4
line 2829
;2829:	}
LABELV $1701
line 2830
;2830:	if ( (cent->currentState.powerups & ( 1 << PW_INVULNERABILITY ) ) ||
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
NEI4 $1709
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 280
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
SUBI4
CNSTI4 250
GEI4 $1706
LABELV $1709
line 2831
;2831:		cg.time - ci->invulnerabilityStopTime < 250 ) {
line 2833
;2832:
;2833:		memcpy(&powerup, &torso, sizeof(torso));
ADDRLP4 140
ARGP4
ADDRLP4 0
ARGP4
CNSTU4 140
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 2834
;2834:		powerup.hModel = cgs.media.invulnerabilityPowerupModel;
ADDRLP4 140+8
ADDRGP4 cgs+148772+576
INDIRI4
ASGNI4
line 2835
;2835:		powerup.customSkin = 0;
ADDRLP4 140+108
CNSTI4 0
ASGNI4
line 2836
;2836:		powerup.customShader = 0;
ADDRLP4 140+112
CNSTI4 0
ASGNI4
line 2838
;2837:		// always draw
;2838:		powerup.renderfx &= ~RF_THIRD_PERSON;
ADDRLP4 140+4
ADDRLP4 140+4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 2839
;2839:		VectorCopy(cent->lerpOrigin, powerup.origin);
ADDRLP4 140+68
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2841
;2840:
;2841:		if ( cg.time - ci->invulnerabilityStartTime < 250 ) {
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 280
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
SUBI4
CNSTI4 250
GEI4 $1717
line 2842
;2842:			c = (float) (cg.time - ci->invulnerabilityStartTime) / 250;
ADDRLP4 748
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 280
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
SUBI4
CVIF4 4
CNSTF4 998445679
MULF4
ASGNF4
line 2843
;2843:		}
ADDRGP4 $1718
JUMPV
LABELV $1717
line 2844
;2844:		else if (cg.time - ci->invulnerabilityStopTime < 250 ) {
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 280
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
SUBI4
CNSTI4 250
GEI4 $1721
line 2845
;2845:			c = (float) (250 - (cg.time - ci->invulnerabilityStopTime)) / 250;
ADDRLP4 748
CNSTI4 250
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 280
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
SUBI4
SUBI4
CVIF4 4
CNSTF4 998445679
MULF4
ASGNF4
line 2846
;2846:		}
ADDRGP4 $1722
JUMPV
LABELV $1721
line 2847
;2847:		else {
line 2848
;2848:			c = 1;
ADDRLP4 748
CNSTF4 1065353216
ASGNF4
line 2849
;2849:		}
LABELV $1722
LABELV $1718
line 2850
;2850:		VectorSet( powerup.axis[0], c, 0, 0 );
ADDRLP4 140+28
ADDRLP4 748
INDIRF4
ASGNF4
ADDRLP4 140+28+4
CNSTF4 0
ASGNF4
ADDRLP4 140+28+8
CNSTF4 0
ASGNF4
line 2851
;2851:		VectorSet( powerup.axis[1], 0, c, 0 );
ADDRLP4 140+28+12
CNSTF4 0
ASGNF4
ADDRLP4 140+28+12+4
ADDRLP4 748
INDIRF4
ASGNF4
ADDRLP4 140+28+12+8
CNSTF4 0
ASGNF4
line 2852
;2852:		VectorSet( powerup.axis[2], 0, 0, c );
ADDRLP4 140+28+24
CNSTF4 0
ASGNF4
ADDRLP4 140+28+24+4
CNSTF4 0
ASGNF4
ADDRLP4 140+28+24+8
ADDRLP4 748
INDIRF4
ASGNF4
line 2853
;2853:		trap_R_AddRefEntityToScene( &powerup );
ADDRLP4 140
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2854
;2854:	}
LABELV $1706
line 2856
;2855:
;2856:	t = cg.time - ci->medkitUsageTime;
ADDRLP4 744
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 280
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
SUBI4
ASGNI4
line 2857
;2857:	if ( ci->medkitUsageTime && t < 500 ) {
ADDRLP4 280
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1747
ADDRLP4 744
INDIRI4
CNSTI4 500
GEI4 $1747
line 2858
;2858:		memcpy(&powerup, &torso, sizeof(torso));
ADDRLP4 140
ARGP4
ADDRLP4 0
ARGP4
CNSTU4 140
ARGU4
ADDRGP4 memcpy
CALLP4
pop
line 2859
;2859:		powerup.hModel = cgs.media.medkitUsageModel;
ADDRLP4 140+8
ADDRGP4 cgs+148772+564
INDIRI4
ASGNI4
line 2860
;2860:		powerup.customSkin = 0;
ADDRLP4 140+108
CNSTI4 0
ASGNI4
line 2861
;2861:		powerup.customShader = 0;
ADDRLP4 140+112
CNSTI4 0
ASGNI4
line 2863
;2862:		// always draw
;2863:		powerup.renderfx &= ~RF_THIRD_PERSON;
ADDRLP4 140+4
ADDRLP4 140+4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 2864
;2864:		VectorClear(angles);
ADDRLP4 724
CNSTF4 0
ASGNF4
ADDRLP4 724+4
CNSTF4 0
ASGNF4
ADDRLP4 724+8
CNSTF4 0
ASGNF4
line 2865
;2865:		AnglesToAxis(angles, powerup.axis);
ADDRLP4 724
ARGP4
ADDRLP4 140+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 2866
;2866:		VectorCopy(cent->lerpOrigin, powerup.origin);
ADDRLP4 140+68
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2867
;2867:		powerup.origin[2] += -24 + (float) t * 80 / 500;
ADDRLP4 140+68+8
ADDRLP4 140+68+8
INDIRF4
ADDRLP4 744
INDIRI4
CVIF4 4
CNSTF4 1042536202
MULF4
CNSTF4 3250585600
ADDF4
ADDF4
ASGNF4
line 2868
;2868:		if ( t > 400 ) {
ADDRLP4 744
INDIRI4
CNSTI4 400
LEI4 $1761
line 2869
;2869:			c = (float) (t - 1000) * 0xff / 100;
ADDRLP4 748
ADDRLP4 744
INDIRI4
CNSTI4 1000
SUBI4
CVIF4 4
CNSTF4 1076048691
MULF4
ASGNF4
line 2870
;2870:			powerup.shaderRGBA[0] = 0xff - c;
ADDRLP4 768
CNSTF4 1132396544
ADDRLP4 748
INDIRF4
SUBF4
ASGNF4
ADDRLP4 772
CNSTF4 1325400064
ASGNF4
ADDRLP4 768
INDIRF4
ADDRLP4 772
INDIRF4
LTF4 $1765
ADDRLP4 764
ADDRLP4 768
INDIRF4
ADDRLP4 772
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1766
JUMPV
LABELV $1765
ADDRLP4 764
ADDRLP4 768
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1766
ADDRLP4 140+116
ADDRLP4 764
INDIRU4
CVUU1 4
ASGNU1
line 2871
;2871:			powerup.shaderRGBA[1] = 0xff - c;
ADDRLP4 780
CNSTF4 1132396544
ADDRLP4 748
INDIRF4
SUBF4
ASGNF4
ADDRLP4 784
CNSTF4 1325400064
ASGNF4
ADDRLP4 780
INDIRF4
ADDRLP4 784
INDIRF4
LTF4 $1770
ADDRLP4 776
ADDRLP4 780
INDIRF4
ADDRLP4 784
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1771
JUMPV
LABELV $1770
ADDRLP4 776
ADDRLP4 780
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1771
ADDRLP4 140+116+1
ADDRLP4 776
INDIRU4
CVUU1 4
ASGNU1
line 2872
;2872:			powerup.shaderRGBA[2] = 0xff - c;
ADDRLP4 792
CNSTF4 1132396544
ADDRLP4 748
INDIRF4
SUBF4
ASGNF4
ADDRLP4 796
CNSTF4 1325400064
ASGNF4
ADDRLP4 792
INDIRF4
ADDRLP4 796
INDIRF4
LTF4 $1775
ADDRLP4 788
ADDRLP4 792
INDIRF4
ADDRLP4 796
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1776
JUMPV
LABELV $1775
ADDRLP4 788
ADDRLP4 792
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1776
ADDRLP4 140+116+2
ADDRLP4 788
INDIRU4
CVUU1 4
ASGNU1
line 2873
;2873:			powerup.shaderRGBA[3] = 0xff - c;
ADDRLP4 804
CNSTF4 1132396544
ADDRLP4 748
INDIRF4
SUBF4
ASGNF4
ADDRLP4 808
CNSTF4 1325400064
ASGNF4
ADDRLP4 804
INDIRF4
ADDRLP4 808
INDIRF4
LTF4 $1780
ADDRLP4 800
ADDRLP4 804
INDIRF4
ADDRLP4 808
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1781
JUMPV
LABELV $1780
ADDRLP4 800
ADDRLP4 804
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1781
ADDRLP4 140+116+3
ADDRLP4 800
INDIRU4
CVUU1 4
ASGNU1
line 2874
;2874:		}
ADDRGP4 $1762
JUMPV
LABELV $1761
line 2875
;2875:		else {
line 2876
;2876:			powerup.shaderRGBA[0] = 0xff;
ADDRLP4 140+116
CNSTU1 255
ASGNU1
line 2877
;2877:			powerup.shaderRGBA[1] = 0xff;
ADDRLP4 140+116+1
CNSTU1 255
ASGNU1
line 2878
;2878:			powerup.shaderRGBA[2] = 0xff;
ADDRLP4 140+116+2
CNSTU1 255
ASGNU1
line 2879
;2879:			powerup.shaderRGBA[3] = 0xff;
ADDRLP4 140+116+3
CNSTU1 255
ASGNU1
line 2880
;2880:		}
LABELV $1762
line 2881
;2881:		trap_R_AddRefEntityToScene( &powerup );
ADDRLP4 140
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2882
;2882:	}
LABELV $1747
line 2888
;2883:#endif // MISSIONPACK
;2884:
;2885:	//
;2886:	// add the head
;2887:	//
;2888:	head.hModel = ci->headModel;
ADDRLP4 424+8
ADDRLP4 280
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ASGNI4
line 2889
;2889:	if (!head.hModel) {
ADDRLP4 424+8
INDIRI4
CNSTI4 0
NEI4 $1790
line 2890
;2890:		return;
ADDRGP4 $1415
JUMPV
LABELV $1790
line 2892
;2891:	}
;2892:	head.customSkin = ci->headSkin;
ADDRLP4 424+108
ADDRLP4 280
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
ASGNI4
line 2894
;2893:
;2894:	VectorCopy( cent->lerpOrigin, head.lightingOrigin );
ADDRLP4 424+12
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2896
;2895:
;2896:	CG_PositionRotatedEntityOnTag( &head, &torso, ci->torsoModel, "tag_head");
ADDRLP4 424
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 280
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
ARGI4
ADDRGP4 $1795
ARGP4
ADDRGP4 CG_PositionRotatedEntityOnTag
CALLV
pop
line 2898
;2897:
;2898:	head.shadowPlane = shadowPlane;
ADDRLP4 424+24
ADDRLP4 736
INDIRF4
ASGNF4
line 2899
;2899:	head.renderfx = renderfx;
ADDRLP4 424+4
ADDRLP4 704
INDIRI4
ASGNI4
line 2902
;2900:
;2901:	// colored skin
;2902:	if ( darken ) {
ADDRLP4 740
INDIRI4
CNSTI4 0
EQI4 $1798
line 2903
;2903:		head.shaderRGBA[0] = 85;
ADDRLP4 424+116
CNSTU1 85
ASGNU1
line 2904
;2904:		head.shaderRGBA[1] = 85;
ADDRLP4 424+116+1
CNSTU1 85
ASGNU1
line 2905
;2905:		head.shaderRGBA[2] = 85;
ADDRLP4 424+116+2
CNSTU1 85
ASGNU1
line 2906
;2906:	} else {
ADDRGP4 $1799
JUMPV
LABELV $1798
line 2907
;2907:		head.shaderRGBA[0] = ci->headColor[0] * 255;
ADDRLP4 768
ADDRLP4 280
INDIRP4
CNSTI4 1616
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 772
CNSTF4 1325400064
ASGNF4
ADDRLP4 768
INDIRF4
ADDRLP4 772
INDIRF4
LTF4 $1807
ADDRLP4 764
ADDRLP4 768
INDIRF4
ADDRLP4 772
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1808
JUMPV
LABELV $1807
ADDRLP4 764
ADDRLP4 768
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1808
ADDRLP4 424+116
ADDRLP4 764
INDIRU4
CVUU1 4
ASGNU1
line 2908
;2908:		head.shaderRGBA[1] = ci->headColor[1] * 255;
ADDRLP4 780
ADDRLP4 280
INDIRP4
CNSTI4 1620
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 784
CNSTF4 1325400064
ASGNF4
ADDRLP4 780
INDIRF4
ADDRLP4 784
INDIRF4
LTF4 $1812
ADDRLP4 776
ADDRLP4 780
INDIRF4
ADDRLP4 784
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1813
JUMPV
LABELV $1812
ADDRLP4 776
ADDRLP4 780
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1813
ADDRLP4 424+116+1
ADDRLP4 776
INDIRU4
CVUU1 4
ASGNU1
line 2909
;2909:		head.shaderRGBA[2] = ci->headColor[2] * 255;
ADDRLP4 792
ADDRLP4 280
INDIRP4
CNSTI4 1624
ADDP4
INDIRF4
CNSTF4 1132396544
MULF4
ASGNF4
ADDRLP4 796
CNSTF4 1325400064
ASGNF4
ADDRLP4 792
INDIRF4
ADDRLP4 796
INDIRF4
LTF4 $1817
ADDRLP4 788
ADDRLP4 792
INDIRF4
ADDRLP4 796
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1818
JUMPV
LABELV $1817
ADDRLP4 788
ADDRLP4 792
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1818
ADDRLP4 424+116+2
ADDRLP4 788
INDIRU4
CVUU1 4
ASGNU1
line 2910
;2910:	}
LABELV $1799
line 2911
;2911:	head.shaderRGBA[3] = 255;
ADDRLP4 424+116+3
CNSTU1 255
ASGNU1
line 2913
;2912:	
;2913:	CG_AddRefEntityWithPowerups( &head, &cent->currentState, ci->team );
ADDRLP4 424
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 280
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddRefEntityWithPowerups
CALLV
pop
line 2916
;2914:
;2915:#ifdef MISSIONPACK
;2916:	CG_BreathPuffs(cent, &head);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 424
ARGP4
ADDRGP4 CG_BreathPuffs
CALLV
pop
line 2918
;2917:
;2918:	CG_DustTrail(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_DustTrail
CALLV
pop
line 2924
;2919:#endif
;2920:
;2921:	//
;2922:	// add the gun / barrel / flash
;2923:	//
;2924:	CG_AddPlayerWeapon( &torso, NULL, cent, ci->team );
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 280
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddPlayerWeapon
CALLV
pop
line 2927
;2925:
;2926:	// add powerups floating behind the player
;2927:	CG_PlayerPowerups( cent, &torso );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_PlayerPowerups
CALLV
pop
line 2928
;2928:}
LABELV $1415
endproc CG_Player 812 28
export CG_ResetPlayerEntity
proc CG_ResetPlayerEntity 40 12
line 2940
;2929:
;2930:
;2931://=====================================================================
;2932:
;2933:/*
;2934:===============
;2935:CG_ResetPlayerEntity
;2936:
;2937:A player just came into view or teleported, so reset all animation info
;2938:===============
;2939:*/
;2940:void CG_ResetPlayerEntity( centity_t *cent ) {
line 2941
;2941:	cent->errorTime = -99999;		// guarantee no error decay added
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
CNSTI4 -99999
ASGNI4
line 2942
;2942:	cent->extrapolated = qfalse;	
ADDRFP4 0
INDIRP4
CNSTI4 676
ADDP4
CNSTI4 0
ASGNI4
line 2944
;2943:
;2944:	CG_ClearLerpFrame( &cgs.clientinfo[ cent->currentState.clientNum ], &cent->pe.legs, cent->currentState.legsAnim );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ClearLerpFrame
CALLV
pop
line 2945
;2945:	CG_ClearLerpFrame( &cgs.clientinfo[ cent->currentState.clientNum ], &cent->pe.torso, cent->currentState.torsoAnim );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ClearLerpFrame
CALLV
pop
line 2947
;2946:
;2947:	BG_EvaluateTrajectory( &cent->currentState.pos, cg.time, cent->lerpOrigin );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 2948
;2948:	BG_EvaluateTrajectory( &cent->currentState.apos, cg.time, cent->lerpAngles );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 2950
;2949:
;2950:	VectorCopy( cent->lerpOrigin, cent->rawOrigin );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 680
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2951
;2951:	VectorCopy( cent->lerpAngles, cent->rawAngles );
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 692
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 2953
;2952:
;2953:	memset( &cent->pe.legs, 0, sizeof( cent->pe.legs ) );
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 48
ARGU4
ADDRGP4 memset
CALLP4
pop
line 2954
;2954:	cent->pe.legs.yawAngle = cent->rawAngles[YAW];
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 480
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 696
ADDP4
INDIRF4
ASGNF4
line 2955
;2955:	cent->pe.legs.yawing = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 484
ADDP4
CNSTI4 0
ASGNI4
line 2956
;2956:	cent->pe.legs.pitchAngle = 0;
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
CNSTF4 0
ASGNF4
line 2957
;2957:	cent->pe.legs.pitching = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 492
ADDP4
CNSTI4 0
ASGNI4
line 2959
;2958:
;2959:	memset( &cent->pe.torso, 0, sizeof( cent->pe.torso ) );
ADDRFP4 0
INDIRP4
CNSTI4 508
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 48
ARGU4
ADDRGP4 memset
CALLP4
pop
line 2960
;2960:	cent->pe.torso.yawAngle = cent->rawAngles[YAW];
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 528
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 696
ADDP4
INDIRF4
ASGNF4
line 2961
;2961:	cent->pe.torso.yawing = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 0
ASGNI4
line 2962
;2962:	cent->pe.torso.pitchAngle = cent->rawAngles[PITCH];
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 536
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 692
ADDP4
INDIRF4
ASGNF4
line 2963
;2963:	cent->pe.torso.pitching = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
CNSTI4 0
ASGNI4
line 2965
;2964:
;2965:	if ( cg_debugPosition.integer ) {
ADDRGP4 cg_debugPosition+12
INDIRI4
CNSTI4 0
EQI4 $1826
line 2966
;2966:		CG_Printf("%i ResetPlayerEntity yaw=%f\n", cent->currentState.number, cent->pe.torso.yawAngle );
ADDRGP4 $1829
ARGP4
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
INDIRI4
ARGI4
ADDRLP4 36
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 2967
;2967:	}
LABELV $1826
line 2968
;2968:}
LABELV $1821
endproc CG_ResetPlayerEntity 40 12
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
import CG_PredictPlayerState
import CG_Trace
import CG_PointContents
import CG_BuildSolidList
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
LABELV $1829
byte 1 37
byte 1 105
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 69
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 121
byte 1 97
byte 1 119
byte 1 61
byte 1 37
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $1795
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1489
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 116
byte 1 111
byte 1 114
byte 1 115
byte 1 111
byte 1 0
align 1
LABELV $1418
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 78
byte 1 117
byte 1 109
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $876
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $807
byte 1 67
byte 1 108
byte 1 97
byte 1 109
byte 1 112
byte 1 32
byte 1 108
byte 1 102
byte 1 45
byte 1 62
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $773
byte 1 65
byte 1 110
byte 1 105
byte 1 109
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $769
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $764
byte 1 77
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 108
byte 1 111
byte 1 119
byte 1 46
byte 1 32
byte 1 32
byte 1 85
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $751
byte 1 77
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 108
byte 1 111
byte 1 119
byte 1 46
byte 1 32
byte 1 85
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $728
byte 1 104
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $722
byte 1 116
byte 1 108
byte 1 0
align 1
LABELV $720
byte 1 116
byte 1 116
byte 1 0
align 1
LABELV $702
byte 1 108
byte 1 0
align 1
LABELV $700
byte 1 119
byte 1 0
align 1
LABELV $698
byte 1 104
byte 1 99
byte 1 0
align 1
LABELV $696
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $679
byte 1 99
byte 1 50
byte 1 0
align 1
LABELV $677
byte 1 99
byte 1 49
byte 1 0
align 1
LABELV $673
byte 1 116
byte 1 0
align 1
LABELV $670
byte 1 110
byte 1 0
align 1
LABELV $606
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $572
byte 1 63
byte 1 63
byte 1 63
byte 1 0
align 1
LABELV $530
byte 1 67
byte 1 71
byte 1 95
byte 1 83
byte 1 101
byte 1 116
byte 1 68
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 114
byte 1 101
byte 1 100
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 58
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
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $461
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $452
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $447
byte 1 68
byte 1 69
byte 1 70
byte 1 65
byte 1 85
byte 1 76
byte 1 84
byte 1 95
byte 1 77
byte 1 79
byte 1 68
byte 1 69
byte 1 76
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 114
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $444
byte 1 68
byte 1 69
byte 1 70
byte 1 65
byte 1 85
byte 1 76
byte 1 84
byte 1 95
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 95
byte 1 77
byte 1 79
byte 1 68
byte 1 69
byte 1 76
byte 1 32
byte 1 47
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 41
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 114
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $436
byte 1 67
byte 1 71
byte 1 95
byte 1 82
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 40
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 41
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $430
byte 1 47
byte 1 0
align 1
LABELV $420
byte 1 48
byte 1 0
align 1
LABELV $417
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
LABELV $386
byte 1 120
byte 1 97
byte 1 101
byte 1 114
byte 1 111
byte 1 0
align 1
LABELV $385
byte 1 118
byte 1 105
byte 1 115
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $384
byte 1 117
byte 1 114
byte 1 105
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $383
byte 1 116
byte 1 97
byte 1 110
byte 1 107
byte 1 106
byte 1 114
byte 1 0
align 1
LABELV $382
byte 1 115
byte 1 111
byte 1 114
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $381
byte 1 115
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $380
byte 1 115
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $379
byte 1 114
byte 1 97
byte 1 122
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $378
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $377
byte 1 111
byte 1 114
byte 1 98
byte 1 98
byte 1 0
align 1
LABELV $376
byte 1 109
byte 1 121
byte 1 110
byte 1 120
byte 1 0
align 1
LABELV $375
byte 1 109
byte 1 97
byte 1 106
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $374
byte 1 108
byte 1 117
byte 1 99
byte 1 121
byte 1 0
align 1
LABELV $373
byte 1 107
byte 1 108
byte 1 101
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $372
byte 1 107
byte 1 101
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $371
byte 1 104
byte 1 117
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $370
byte 1 103
byte 1 114
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $369
byte 1 100
byte 1 111
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $368
byte 1 99
byte 1 114
byte 1 97
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $367
byte 1 98
byte 1 111
byte 1 110
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $366
byte 1 98
byte 1 105
byte 1 116
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $365
byte 1 98
byte 1 105
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $364
byte 1 97
byte 1 110
byte 1 97
byte 1 114
byte 1 107
byte 1 105
byte 1 0
align 1
LABELV $358
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $355
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $352
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $349
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
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $346
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
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $345
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $342
byte 1 83
byte 1 116
byte 1 114
byte 1 111
byte 1 103
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $341
byte 1 80
byte 1 97
byte 1 103
byte 1 97
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $340
byte 1 37
byte 1 115
byte 1 47
byte 1 0
align 1
LABELV $337
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $328
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
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $327
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
byte 1 37
byte 1 115
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $322
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
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $319
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
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $318
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $315
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
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $312
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
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $304
byte 1 72
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 117
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $301
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $298
byte 1 84
byte 1 111
byte 1 114
byte 1 115
byte 1 111
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 117
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $295
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $292
byte 1 76
byte 1 101
byte 1 103
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 117
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $289
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $288
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $268
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
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $267
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
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $257
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 47
byte 1 0
align 1
LABELV $241
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
byte 1 0
align 1
LABELV $231
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
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $230
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
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $222
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
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $221
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
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $211
byte 1 0
align 1
LABELV $210
byte 1 102
byte 1 98
byte 1 0
align 1
LABELV $207
byte 1 112
byte 1 109
byte 1 0
align 1
LABELV $204
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $203
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $189
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $164
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $161
byte 1 102
byte 1 105
byte 1 120
byte 1 101
byte 1 100
byte 1 116
byte 1 111
byte 1 114
byte 1 115
byte 1 111
byte 1 0
align 1
LABELV $158
byte 1 102
byte 1 105
byte 1 120
byte 1 101
byte 1 100
byte 1 108
byte 1 101
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $147
byte 1 115
byte 1 101
byte 1 120
byte 1 0
align 1
LABELV $138
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 111
byte 1 102
byte 1 102
byte 1 115
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $135
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $134
byte 1 101
byte 1 110
byte 1 101
byte 1 114
byte 1 103
byte 1 121
byte 1 0
align 1
LABELV $131
byte 1 109
byte 1 101
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $128
byte 1 102
byte 1 108
byte 1 101
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $125
byte 1 98
byte 1 111
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $121
byte 1 110
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $120
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $115
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $107
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $99
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 99
byte 1 117
byte 1 115
byte 1 116
byte 1 111
byte 1 109
byte 1 32
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $84
byte 1 42
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $83
byte 1 42
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $82
byte 1 42
byte 1 100
byte 1 114
byte 1 111
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $81
byte 1 42
byte 1 103
byte 1 97
byte 1 115
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $80
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
LABELV $79
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 49
byte 1 48
byte 1 48
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $78
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 55
byte 1 53
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $77
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 53
byte 1 48
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $76
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 50
byte 1 53
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $75
byte 1 42
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $74
byte 1 42
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $73
byte 1 42
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $72
byte 1 42
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
