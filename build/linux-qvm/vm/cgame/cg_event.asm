bss
align 1
LABELV $73
skip 64
export CG_PlaceString
code
proc CG_PlaceString 12 20
file "../../../../code/cgame/cg_event.c"
line 20
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_event.c -- handle entity events at snapshot or playerstate transitions
;4:
;5:#include "cg_local.h"
;6:
;7:// for the voice chats
;8:#ifdef MISSIONPACK // bk001205
;9:#include "../../ui/menudef.h"
;10:#endif
;11://==========================================================================
;12:
;13:/*
;14:===================
;15:CG_PlaceString
;16:
;17:Also called by scoreboard drawing
;18:===================
;19:*/
;20:const char	*CG_PlaceString( int rank ) {
line 24
;21:	static char	str[64];
;22:	char	*s, *t;
;23:
;24:	if ( rank & RANK_TIED_FLAG ) {
ADDRFP4 0
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $74
line 25
;25:		rank &= ~RANK_TIED_FLAG;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -16385
BANDI4
ASGNI4
line 26
;26:		t = "Tied for ";
ADDRLP4 4
ADDRGP4 $76
ASGNP4
line 27
;27:	} else {
ADDRGP4 $75
JUMPV
LABELV $74
line 28
;28:		t = "";
ADDRLP4 4
ADDRGP4 $77
ASGNP4
line 29
;29:	}
LABELV $75
line 31
;30:
;31:	if ( rank == 1 ) {
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $78
line 32
;32:		s = S_COLOR_BLUE "1st" S_COLOR_WHITE;		// draw in blue
ADDRLP4 0
ADDRGP4 $80
ASGNP4
line 33
;33:	} else if ( rank == 2 ) {
ADDRGP4 $79
JUMPV
LABELV $78
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $81
line 34
;34:		s = S_COLOR_RED "2nd" S_COLOR_WHITE;		// draw in red
ADDRLP4 0
ADDRGP4 $83
ASGNP4
line 35
;35:	} else if ( rank == 3 ) {
ADDRGP4 $82
JUMPV
LABELV $81
ADDRFP4 0
INDIRI4
CNSTI4 3
NEI4 $84
line 36
;36:		s = S_COLOR_YELLOW "3rd" S_COLOR_WHITE;		// draw in yellow
ADDRLP4 0
ADDRGP4 $86
ASGNP4
line 37
;37:	} else if ( rank == 11 ) {
ADDRGP4 $85
JUMPV
LABELV $84
ADDRFP4 0
INDIRI4
CNSTI4 11
NEI4 $87
line 38
;38:		s = "11th";
ADDRLP4 0
ADDRGP4 $89
ASGNP4
line 39
;39:	} else if ( rank == 12 ) {
ADDRGP4 $88
JUMPV
LABELV $87
ADDRFP4 0
INDIRI4
CNSTI4 12
NEI4 $90
line 40
;40:		s = "12th";
ADDRLP4 0
ADDRGP4 $92
ASGNP4
line 41
;41:	} else if ( rank == 13 ) {
ADDRGP4 $91
JUMPV
LABELV $90
ADDRFP4 0
INDIRI4
CNSTI4 13
NEI4 $93
line 42
;42:		s = "13th";
ADDRLP4 0
ADDRGP4 $95
ASGNP4
line 43
;43:	} else if ( rank % 10 == 1 ) {
ADDRGP4 $94
JUMPV
LABELV $93
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 1
NEI4 $96
line 44
;44:		s = va("%ist", rank);
ADDRGP4 $98
ARGP4
ADDRFP4 0
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
line 45
;45:	} else if ( rank % 10 == 2 ) {
ADDRGP4 $97
JUMPV
LABELV $96
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 2
NEI4 $99
line 46
;46:		s = va("%ind", rank);
ADDRGP4 $101
ARGP4
ADDRFP4 0
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
line 47
;47:	} else if ( rank % 10 == 3 ) {
ADDRGP4 $100
JUMPV
LABELV $99
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 3
NEI4 $102
line 48
;48:		s = va("%ird", rank);
ADDRGP4 $104
ARGP4
ADDRFP4 0
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
line 49
;49:	} else {
ADDRGP4 $103
JUMPV
LABELV $102
line 50
;50:		s = va("%ith", rank);
ADDRGP4 $105
ARGP4
ADDRFP4 0
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
line 51
;51:	}
LABELV $103
LABELV $100
LABELV $97
LABELV $94
LABELV $91
LABELV $88
LABELV $85
LABELV $82
LABELV $79
line 53
;52:
;53:	Com_sprintf( str, sizeof( str ), "%s%s", t, s );
ADDRGP4 $73
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $106
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 54
;54:	return str;
ADDRGP4 $73
RETP4
LABELV $72
endproc CG_PlaceString 12 20
proc CG_Obituary 136 20
line 63
;55:}
;56:
;57:
;58:/*
;59:=============
;60:CG_Obituary
;61:=============
;62:*/
;63:static void CG_Obituary( entityState_t *ent ) {
line 76
;64:	int			mod;
;65:	int			target, attacker;
;66:	char		*message;
;67:	char		*message2;
;68:	const char	*targetInfo;
;69:	const char	*attackerInfo;
;70:	char		targetName[32];
;71:	char		attackerName[32];
;72:	gender_t	gender;
;73:	clientInfo_t	*ci;
;74:	qboolean	following;
;75:
;76:	target = ent->otherEntityNum;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 77
;77:	attacker = ent->otherEntityNum2;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 78
;78:	mod = ent->eventParm;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 80
;79:
;80:	if ( target < 0 || target >= MAX_CLIENTS ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $110
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $108
LABELV $110
line 81
;81:		CG_Error( "CG_Obituary: target out of range" );
ADDRGP4 $111
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 82
;82:	}
LABELV $108
line 83
;83:	ci = &cgs.clientinfo[target];
ADDRLP4 92
ADDRLP4 4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 85
;84:
;85:	if ( attacker < 0 || attacker >= MAX_CLIENTS ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $115
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $113
LABELV $115
line 86
;86:		attacker = ENTITYNUM_WORLD;
ADDRLP4 0
CNSTI4 1022
ASGNI4
line 87
;87:		attackerInfo = NULL;
ADDRLP4 84
CNSTP4 0
ASGNP4
line 88
;88:	} else {
ADDRGP4 $114
JUMPV
LABELV $113
line 89
;89:		attackerInfo = CG_ConfigString( CS_PLAYERS + attacker );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 112
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 84
ADDRLP4 112
INDIRP4
ASGNP4
line 90
;90:	}
LABELV $114
line 92
;91:
;92:	targetInfo = CG_ConfigString( CS_PLAYERS + target );
ADDRLP4 4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 112
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 48
ADDRLP4 112
INDIRP4
ASGNP4
line 93
;93:	if ( !targetInfo[0] )
ADDRLP4 48
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $116
line 94
;94:	{
line 95
;95:		return;
ADDRGP4 $107
JUMPV
LABELV $116
line 97
;96:	}
;97:	Q_strncpyz( targetName, Info_ValueForKey( targetInfo, "n" ), sizeof(targetName) - 2);
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 $118
ARGP4
ADDRLP4 116
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ARGP4
ADDRLP4 116
INDIRP4
ARGP4
CNSTI4 30
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 98
;98:	strcat( targetName, S_COLOR_WHITE );
ADDRLP4 8
ARGP4
ADDRGP4 $119
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 100
;99:
;100:	following = cg.snap->ps.pm_flags & PMF_FOLLOW;
ADDRLP4 96
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
ASGNI4
line 102
;101:
;102:	message2 = "";
ADDRLP4 88
ADDRGP4 $77
ASGNP4
line 106
;103:
;104:	// check for single client messages
;105:
;106:	switch( mod ) {
ADDRLP4 44
INDIRI4
CNSTI4 14
LTI4 $121
ADDRLP4 44
INDIRI4
CNSTI4 22
GTI4 $121
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $139-56
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $139
address $129
address $131
address $133
address $127
address $121
address $125
address $123
address $135
address $137
code
LABELV $123
line 108
;107:	case MOD_SUICIDE:
;108:		message = "suicides";
ADDRLP4 40
ADDRGP4 $124
ASGNP4
line 109
;109:		break;
ADDRGP4 $122
JUMPV
LABELV $125
line 111
;110:	case MOD_FALLING:
;111:		message = "cratered";
ADDRLP4 40
ADDRGP4 $126
ASGNP4
line 112
;112:		break;
ADDRGP4 $122
JUMPV
LABELV $127
line 114
;113:	case MOD_CRUSH:
;114:		message = "was squished";
ADDRLP4 40
ADDRGP4 $128
ASGNP4
line 115
;115:		break;
ADDRGP4 $122
JUMPV
LABELV $129
line 117
;116:	case MOD_WATER:
;117:		message = "sank like a rock";
ADDRLP4 40
ADDRGP4 $130
ASGNP4
line 118
;118:		break;
ADDRGP4 $122
JUMPV
LABELV $131
line 120
;119:	case MOD_SLIME:
;120:		message = "melted";
ADDRLP4 40
ADDRGP4 $132
ASGNP4
line 121
;121:		break;
ADDRGP4 $122
JUMPV
LABELV $133
line 123
;122:	case MOD_LAVA:
;123:		message = "does a back flip into the lava";
ADDRLP4 40
ADDRGP4 $134
ASGNP4
line 124
;124:		break;
ADDRGP4 $122
JUMPV
LABELV $135
line 126
;125:	case MOD_TARGET_LASER:
;126:		message = "saw the light";
ADDRLP4 40
ADDRGP4 $136
ASGNP4
line 127
;127:		break;
ADDRGP4 $122
JUMPV
LABELV $137
line 129
;128:	case MOD_TRIGGER_HURT:
;129:		message = "was in the wrong place";
ADDRLP4 40
ADDRGP4 $138
ASGNP4
line 130
;130:		break;
ADDRGP4 $122
JUMPV
LABELV $121
line 132
;131:	default:
;132:		message = NULL;
ADDRLP4 40
CNSTP4 0
ASGNP4
line 133
;133:		break;
LABELV $122
line 136
;134:	}
;135:
;136:	if (attacker == target) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $141
line 137
;137:		gender = ci->gender;
ADDRLP4 100
ADDRLP4 92
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
ASGNI4
line 138
;138:		switch (mod) {
ADDRLP4 44
INDIRI4
CNSTI4 13
EQI4 $171
ADDRLP4 44
INDIRI4
CNSTI4 13
GTI4 $189
LABELV $188
ADDRLP4 44
INDIRI4
CNSTI4 5
EQI4 $147
ADDRLP4 44
INDIRI4
CNSTI4 7
EQI4 $155
ADDRLP4 44
INDIRI4
CNSTI4 9
EQI4 $163
ADDRGP4 $143
JUMPV
LABELV $189
ADDRLP4 44
INDIRI4
CNSTI4 25
EQI4 $173
ADDRLP4 44
INDIRI4
CNSTI4 26
EQI4 $145
ADDRGP4 $143
JUMPV
LABELV $145
line 141
;139:#ifdef MISSIONPACK
;140:		case MOD_KAMIKAZE:
;141:			message = "goes out with a bang";
ADDRLP4 40
ADDRGP4 $146
ASGNP4
line 142
;142:			break;
ADDRGP4 $144
JUMPV
LABELV $147
line 145
;143:#endif
;144:		case MOD_GRENADE_SPLASH:
;145:			if ( gender == GENDER_FEMALE )
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $148
line 146
;146:				message = "tripped on her own grenade";
ADDRLP4 40
ADDRGP4 $150
ASGNP4
ADDRGP4 $144
JUMPV
LABELV $148
line 147
;147:			else if ( gender == GENDER_NEUTER )
ADDRLP4 100
INDIRI4
CNSTI4 2
NEI4 $151
line 148
;148:				message = "tripped on its own grenade";
ADDRLP4 40
ADDRGP4 $153
ASGNP4
ADDRGP4 $144
JUMPV
LABELV $151
line 150
;149:			else
;150:				message = "tripped on his own grenade";
ADDRLP4 40
ADDRGP4 $154
ASGNP4
line 151
;151:			break;
ADDRGP4 $144
JUMPV
LABELV $155
line 153
;152:		case MOD_ROCKET_SPLASH:
;153:			if ( gender == GENDER_FEMALE )
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $156
line 154
;154:				message = "blew herself up";
ADDRLP4 40
ADDRGP4 $158
ASGNP4
ADDRGP4 $144
JUMPV
LABELV $156
line 155
;155:			else if ( gender == GENDER_NEUTER )
ADDRLP4 100
INDIRI4
CNSTI4 2
NEI4 $159
line 156
;156:				message = "blew itself up";
ADDRLP4 40
ADDRGP4 $161
ASGNP4
ADDRGP4 $144
JUMPV
LABELV $159
line 158
;157:			else
;158:				message = "blew himself up";
ADDRLP4 40
ADDRGP4 $162
ASGNP4
line 159
;159:			break;
ADDRGP4 $144
JUMPV
LABELV $163
line 161
;160:		case MOD_PLASMA_SPLASH:
;161:			if ( gender == GENDER_FEMALE )
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $164
line 162
;162:				message = "melted herself";
ADDRLP4 40
ADDRGP4 $166
ASGNP4
ADDRGP4 $144
JUMPV
LABELV $164
line 163
;163:			else if ( gender == GENDER_NEUTER )
ADDRLP4 100
INDIRI4
CNSTI4 2
NEI4 $167
line 164
;164:				message = "melted itself";
ADDRLP4 40
ADDRGP4 $169
ASGNP4
ADDRGP4 $144
JUMPV
LABELV $167
line 166
;165:			else
;166:				message = "melted himself";
ADDRLP4 40
ADDRGP4 $170
ASGNP4
line 167
;167:			break;
ADDRGP4 $144
JUMPV
LABELV $171
line 169
;168:		case MOD_BFG_SPLASH:
;169:			message = "should have used a smaller gun";
ADDRLP4 40
ADDRGP4 $172
ASGNP4
line 170
;170:			break;
ADDRGP4 $144
JUMPV
LABELV $173
line 173
;171:#ifdef MISSIONPACK
;172:		case MOD_PROXIMITY_MINE:
;173:			if( gender == GENDER_FEMALE ) {
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $174
line 174
;174:				message = "found her prox mine";
ADDRLP4 40
ADDRGP4 $176
ASGNP4
line 175
;175:			} else if ( gender == GENDER_NEUTER ) {
ADDRGP4 $144
JUMPV
LABELV $174
ADDRLP4 100
INDIRI4
CNSTI4 2
NEI4 $177
line 176
;176:				message = "found its prox mine";
ADDRLP4 40
ADDRGP4 $179
ASGNP4
line 177
;177:			} else {
ADDRGP4 $144
JUMPV
LABELV $177
line 178
;178:				message = "found his prox mine";
ADDRLP4 40
ADDRGP4 $180
ASGNP4
line 179
;179:			}
line 180
;180:			break;
ADDRGP4 $144
JUMPV
LABELV $143
line 183
;181:#endif
;182:		default:
;183:			if ( gender == GENDER_FEMALE )
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $181
line 184
;184:				message = "killed herself";
ADDRLP4 40
ADDRGP4 $183
ASGNP4
ADDRGP4 $144
JUMPV
LABELV $181
line 185
;185:			else if ( gender == GENDER_NEUTER )
ADDRLP4 100
INDIRI4
CNSTI4 2
NEI4 $184
line 186
;186:				message = "killed itself";
ADDRLP4 40
ADDRGP4 $186
ASGNP4
ADDRGP4 $144
JUMPV
LABELV $184
line 188
;187:			else
;188:				message = "killed himself";
ADDRLP4 40
ADDRGP4 $187
ASGNP4
line 189
;189:			break;
LABELV $144
line 191
;190:		}
;191:	}
LABELV $141
line 193
;192:
;193:	if ( message ) {
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $190
line 194
;194:		CG_Printf( "%s %s.\n", targetName, message);
ADDRGP4 $192
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 196
;195:		// switch to first killer if not following anyone
;196:		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR && cg_followKiller.integer ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $107
ADDRGP4 cg_followKiller+12
INDIRI4
CNSTI4 0
EQI4 $107
line 197
;197:			if ( !cg.followTime && attacker != cg.snap->ps.clientNum && attacker < MAX_CLIENTS ) {
ADDRGP4 cg+157028
INDIRI4
CNSTI4 0
NEI4 $107
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $107
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $107
line 198
;198:				cg.followClient = attacker;
ADDRGP4 cg+157032
ADDRLP4 0
INDIRI4
ASGNI4
line 199
;199:				cg.followTime = cg.time;
ADDRGP4 cg+157028
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 200
;200:			}
line 201
;201:		}
line 202
;202:		return;
ADDRGP4 $107
JUMPV
LABELV $190
line 206
;203:	}
;204:
;205:	// check for kill messages from the current clientNum
;206:	if ( attacker == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $204
line 209
;207:		char	*s;
;208:
;209:		if ( cgs.gametype < GT_TEAM ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
GEI4 $207
line 210
;210:			s = va("You fragged %s\n%s place with %i", targetName, 
ADDRGP4 cg+36
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 128
ADDRGP4 CG_PlaceString
CALLP4
ASGNP4
ADDRGP4 $210
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRLP4 132
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 124
ADDRLP4 132
INDIRP4
ASGNP4
line 213
;211:				CG_PlaceString( cg.snap->ps.persistant[PERS_RANK] + 1 ),
;212:				cg.snap->ps.persistant[PERS_SCORE] );
;213:		} else {
ADDRGP4 $208
JUMPV
LABELV $207
line 214
;214:			s = va("You fragged %s", targetName );
ADDRGP4 $213
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 128
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 124
ADDRLP4 128
INDIRP4
ASGNP4
line 215
;215:		}
LABELV $208
line 217
;216:#ifdef MISSIONPACK
;217:		if (!(cg_singlePlayerActive.integer && cg_cameraOrbit.integer)) {
ADDRGP4 cg_singlePlayerActive+12
INDIRI4
CNSTI4 0
EQI4 $218
ADDRGP4 cg_cameraOrbit+12
INDIRI4
CNSTI4 0
NEI4 $214
LABELV $218
line 218
;218:			CG_CenterPrint( s, SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
ADDRLP4 124
INDIRP4
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 219
;219:		} 
LABELV $214
line 225
;220:#else
;221:		CG_CenterPrint( s, SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
;222:#endif
;223:
;224:		// print the text message as well
;225:	}
LABELV $204
line 228
;226:
;227:	// check for double client messages
;228:	if ( !attackerInfo ) {
ADDRLP4 84
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $219
line 229
;229:		attacker = ENTITYNUM_WORLD;
ADDRLP4 0
CNSTI4 1022
ASGNI4
line 230
;230:		strcpy( attackerName, "noname" );
ADDRLP4 52
ARGP4
ADDRGP4 $221
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 231
;231:	} else {
ADDRGP4 $220
JUMPV
LABELV $219
line 232
;232:		Q_strncpyz( attackerName, Info_ValueForKey( attackerInfo, "n" ), sizeof(attackerName) - 2);
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 $118
ARGP4
ADDRLP4 124
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 52
ARGP4
ADDRLP4 124
INDIRP4
ARGP4
CNSTI4 30
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 233
;233:		Q_CleanStr( attackerName );
ADDRLP4 52
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 234
;234:		strcat( attackerName, S_COLOR_WHITE );
ADDRLP4 52
ARGP4
ADDRGP4 $119
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 236
;235:		// check for kill messages about the current clientNum
;236:		if ( target == cg.snap->ps.clientNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $222
line 237
;237:			Q_strncpyz( cg.killerName, attackerName, sizeof( cg.killerName ) );
ADDRGP4 cg+115368
ARGP4
ADDRLP4 52
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 239
;238:			// follow killer
;239:			if ( following && cg_followKiller.integer ) {
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $227
ADDRGP4 cg_followKiller+12
INDIRI4
CNSTI4 0
EQI4 $227
line 240
;240:				if ( !cg.followTime && attacker != cg.snap->ps.clientNum && attacker < MAX_CLIENTS ) {
ADDRGP4 cg+157028
INDIRI4
CNSTI4 0
NEI4 $230
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $230
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $230
line 241
;241:					cg.followClient = attacker;
ADDRGP4 cg+157032
ADDRLP4 0
INDIRI4
ASGNI4
line 242
;242:					cg.followTime = cg.time + 1100;
ADDRGP4 cg+157028
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1100
ADDI4
ASGNI4
line 243
;243:				}
LABELV $230
line 244
;244:			}
LABELV $227
line 245
;245:		}
LABELV $222
line 246
;246:	}
LABELV $220
line 248
;247:
;248:	if ( attacker != ENTITYNUM_WORLD ) {
ADDRLP4 0
INDIRI4
CNSTI4 1022
EQI4 $237
line 249
;249:		switch (mod) {
ADDRLP4 44
INDIRI4
CNSTI4 1
LTI4 $239
ADDRLP4 44
INDIRI4
CNSTI4 28
GTI4 $239
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $287-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $287
address $247
address $243
address $245
address $249
address $252
address $255
address $257
address $259
address $262
address $263
address $265
address $267
address $267
address $239
address $239
address $239
address $239
address $283
address $239
address $239
address $239
address $239
address $270
address $272
address $275
address $278
address $281
address $241
code
LABELV $241
line 251
;250:		case MOD_GRAPPLE:
;251:			message = "was caught by";
ADDRLP4 40
ADDRGP4 $242
ASGNP4
line 252
;252:			break;
ADDRGP4 $240
JUMPV
LABELV $243
line 254
;253:		case MOD_GAUNTLET:
;254:			message = "was pummeled by";
ADDRLP4 40
ADDRGP4 $244
ASGNP4
line 255
;255:			break;
ADDRGP4 $240
JUMPV
LABELV $245
line 257
;256:		case MOD_MACHINEGUN:
;257:			message = "was machinegunned by";
ADDRLP4 40
ADDRGP4 $246
ASGNP4
line 258
;258:			break;
ADDRGP4 $240
JUMPV
LABELV $247
line 260
;259:		case MOD_SHOTGUN:
;260:			message = "was gunned down by";
ADDRLP4 40
ADDRGP4 $248
ASGNP4
line 261
;261:			break;
ADDRGP4 $240
JUMPV
LABELV $249
line 263
;262:		case MOD_GRENADE:
;263:			message = "ate";
ADDRLP4 40
ADDRGP4 $250
ASGNP4
line 264
;264:			message2 = "'s grenade";
ADDRLP4 88
ADDRGP4 $251
ASGNP4
line 265
;265:			break;
ADDRGP4 $240
JUMPV
LABELV $252
line 267
;266:		case MOD_GRENADE_SPLASH:
;267:			message = "was shredded by";
ADDRLP4 40
ADDRGP4 $253
ASGNP4
line 268
;268:			message2 = "'s shrapnel";
ADDRLP4 88
ADDRGP4 $254
ASGNP4
line 269
;269:			break;
ADDRGP4 $240
JUMPV
LABELV $255
line 271
;270:		case MOD_ROCKET:
;271:			message = "ate";
ADDRLP4 40
ADDRGP4 $250
ASGNP4
line 272
;272:			message2 = "'s rocket";
ADDRLP4 88
ADDRGP4 $256
ASGNP4
line 273
;273:			break;
ADDRGP4 $240
JUMPV
LABELV $257
line 275
;274:		case MOD_ROCKET_SPLASH:
;275:			message = "almost dodged";
ADDRLP4 40
ADDRGP4 $258
ASGNP4
line 276
;276:			message2 = "'s rocket";
ADDRLP4 88
ADDRGP4 $256
ASGNP4
line 277
;277:			break;
ADDRGP4 $240
JUMPV
LABELV $259
line 279
;278:		case MOD_PLASMA:
;279:			message = "was melted by";
ADDRLP4 40
ADDRGP4 $260
ASGNP4
line 280
;280:			message2 = "'s plasmagun";
ADDRLP4 88
ADDRGP4 $261
ASGNP4
line 281
;281:			break;
ADDRGP4 $240
JUMPV
LABELV $262
line 283
;282:		case MOD_PLASMA_SPLASH:
;283:			message = "was melted by";
ADDRLP4 40
ADDRGP4 $260
ASGNP4
line 284
;284:			message2 = "'s plasmagun";
ADDRLP4 88
ADDRGP4 $261
ASGNP4
line 285
;285:			break;
ADDRGP4 $240
JUMPV
LABELV $263
line 287
;286:		case MOD_RAILGUN:
;287:			message = "was railed by";
ADDRLP4 40
ADDRGP4 $264
ASGNP4
line 288
;288:			break;
ADDRGP4 $240
JUMPV
LABELV $265
line 290
;289:		case MOD_LIGHTNING:
;290:			message = "was electrocuted by";
ADDRLP4 40
ADDRGP4 $266
ASGNP4
line 291
;291:			break;
ADDRGP4 $240
JUMPV
LABELV $267
line 294
;292:		case MOD_BFG:
;293:		case MOD_BFG_SPLASH:
;294:			message = "was blasted by";
ADDRLP4 40
ADDRGP4 $268
ASGNP4
line 295
;295:			message2 = "'s BFG";
ADDRLP4 88
ADDRGP4 $269
ASGNP4
line 296
;296:			break;
ADDRGP4 $240
JUMPV
LABELV $270
line 299
;297:#ifdef MISSIONPACK
;298:		case MOD_NAIL:
;299:			message = "was nailed by";
ADDRLP4 40
ADDRGP4 $271
ASGNP4
line 300
;300:			break;
ADDRGP4 $240
JUMPV
LABELV $272
line 302
;301:		case MOD_CHAINGUN:
;302:			message = "got lead poisoning from";
ADDRLP4 40
ADDRGP4 $273
ASGNP4
line 303
;303:			message2 = "'s Chaingun";
ADDRLP4 88
ADDRGP4 $274
ASGNP4
line 304
;304:			break;
ADDRGP4 $240
JUMPV
LABELV $275
line 306
;305:		case MOD_PROXIMITY_MINE:
;306:			message = "was too close to";
ADDRLP4 40
ADDRGP4 $276
ASGNP4
line 307
;307:			message2 = "'s Prox Mine";
ADDRLP4 88
ADDRGP4 $277
ASGNP4
line 308
;308:			break;
ADDRGP4 $240
JUMPV
LABELV $278
line 310
;309:		case MOD_KAMIKAZE:
;310:			message = "falls to";
ADDRLP4 40
ADDRGP4 $279
ASGNP4
line 311
;311:			message2 = "'s Kamikaze blast";
ADDRLP4 88
ADDRGP4 $280
ASGNP4
line 312
;312:			break;
ADDRGP4 $240
JUMPV
LABELV $281
line 314
;313:		case MOD_JUICED:
;314:			message = "was juiced by";
ADDRLP4 40
ADDRGP4 $282
ASGNP4
line 315
;315:			break;
ADDRGP4 $240
JUMPV
LABELV $283
line 318
;316:#endif
;317:		case MOD_TELEFRAG:
;318:			message = "tried to invade";
ADDRLP4 40
ADDRGP4 $284
ASGNP4
line 319
;319:			message2 = "'s personal space";
ADDRLP4 88
ADDRGP4 $285
ASGNP4
line 320
;320:			break;
ADDRGP4 $240
JUMPV
LABELV $239
line 322
;321:		default:
;322:			message = "was killed by";
ADDRLP4 40
ADDRGP4 $286
ASGNP4
line 323
;323:			break;
LABELV $240
line 326
;324:		}
;325:
;326:		if ( message ) {
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $289
line 327
;327:			CG_Printf( "%s %s %s%s\n", targetName, message, attackerName, message2 );
ADDRGP4 $291
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 329
;328:			// switch to first killer if not following anyone
;329:			if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR && cg_followKiller.integer ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $107
ADDRGP4 cg_followKiller+12
INDIRI4
CNSTI4 0
EQI4 $107
line 330
;330:				if ( !cg.followTime && attacker != cg.snap->ps.clientNum && attacker < MAX_CLIENTS ) {
ADDRGP4 cg+157028
INDIRI4
CNSTI4 0
NEI4 $107
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $107
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $107
line 331
;331:					cg.followClient = attacker;
ADDRGP4 cg+157032
ADDRLP4 0
INDIRI4
ASGNI4
line 332
;332:					cg.followTime = cg.time;
ADDRGP4 cg+157028
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 333
;333:				}
line 334
;334:			}
line 335
;335:			return;
ADDRGP4 $107
JUMPV
LABELV $289
line 337
;336:		}
;337:	}
LABELV $237
line 340
;338:
;339:	// we don't know what it was
;340:	CG_Printf( "%s "S_COLOR_STRIP"died.\n", targetName );
ADDRGP4 $303
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 341
;341:}
LABELV $107
endproc CG_Obituary 136 20
proc CG_UseItem 32 16
line 350
;342://==========================================================================
;343:
;344:
;345:/*
;346:===============
;347:CG_UseItem
;348:===============
;349:*/
;350:static void CG_UseItem( centity_t *cent ) {
line 356
;351:	clientInfo_t *ci;
;352:	int			itemNum, clientNum;
;353:	gitem_t		*item;
;354:	entityState_t *es;
;355:
;356:	es = &cent->currentState;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 358
;357:	
;358:	itemNum = (es->event & ~EV_EVENT_BITS) - EV_USE_ITEM0;
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
CNSTI4 24
SUBI4
ASGNI4
line 359
;359:	if ( itemNum < 0 || itemNum > HI_NUM_HOLDABLE ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $307
ADDRLP4 0
INDIRI4
CNSTI4 6
LEI4 $305
LABELV $307
line 360
;360:		itemNum = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 361
;361:	}
LABELV $305
line 364
;362:
;363:	// print a message if the local player
;364:	if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 4
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $308
line 365
;365:		if ( !itemNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $311
line 366
;366:			CG_CenterPrint( "No item to use", SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
ADDRGP4 $313
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 367
;367:		} else {
ADDRGP4 $312
JUMPV
LABELV $311
line 368
;368:			item = BG_FindItemForHoldable( itemNum );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 BG_FindItemForHoldable
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 24
INDIRP4
ASGNP4
line 369
;369:			CG_CenterPrint( va("Use %s", item->pickup_name), SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
ADDRGP4 $314
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 28
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
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 370
;370:		}
LABELV $312
line 371
;371:	}
LABELV $308
line 373
;372:
;373:	switch ( itemNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $315
ADDRLP4 0
INDIRI4
CNSTI4 5
GTI4 $315
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $333
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $333
address $317
address $316
address $321
address $316
address $316
address $330
code
LABELV $315
LABELV $317
line 376
;374:	default:
;375:	case HI_NONE:
;376:		trap_S_StartSound (NULL, es->number, CHAN_BODY, cgs.media.useNothingSound );
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+148772+632
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 377
;377:		break;
ADDRGP4 $316
JUMPV
line 380
;378:
;379:	case HI_TELEPORTER:
;380:		break;
LABELV $321
line 383
;381:
;382:	case HI_MEDKIT:
;383:		clientNum = cent->currentState.clientNum;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 384
;384:		if ( clientNum >= 0 && clientNum < MAX_CLIENTS ) {
ADDRLP4 28
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
LTI4 $322
ADDRLP4 28
INDIRI4
CNSTI4 64
GEI4 $322
line 385
;385:			ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 16
ADDRLP4 12
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 386
;386:			ci->medkitUsageTime = cg.time;
ADDRLP4 16
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 387
;387:		}
LABELV $322
line 388
;388:		trap_S_StartSound (NULL, es->number, CHAN_BODY, cgs.media.medkitSound );
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+148772+1048
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 389
;389:		break;
ADDRGP4 $316
JUMPV
line 393
;390:
;391:#ifdef MISSIONPACK
;392:	case HI_KAMIKAZE:
;393:		break;
line 396
;394:
;395:	case HI_PORTAL:
;396:		break;
LABELV $330
line 398
;397:	case HI_INVULNERABILITY:
;398:		trap_S_StartSound (NULL, es->number, CHAN_BODY, cgs.media.useInvulnerabilitySound );
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+148772+828
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 399
;399:		break;
LABELV $316
line 402
;400:#endif
;401:	}
;402:}
LABELV $304
endproc CG_UseItem 32 16
data
align 4
LABELV $335
byte 4 -1
code
proc CG_ItemPickup 4 0
line 412
;403:
;404:
;405:/*
;406:================
;407:CG_ItemPickup
;408:
;409:A new item was picked up this frame
;410:================
;411:*/
;412:static void CG_ItemPickup( int itemNum ) {
line 415
;413:	static int oldItem = -1;
;414:	
;415:	cg.itemPickup = itemNum;
ADDRGP4 cg+125780
ADDRFP4 0
INDIRI4
ASGNI4
line 416
;416:	cg.itemPickupTime = cg.time;
ADDRGP4 cg+125788
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 417
;417:	cg.itemPickupBlendTime = cg.time;
ADDRGP4 cg+125792
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 419
;418:
;419:	if ( oldItem != itemNum )
ADDRGP4 $335
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $341
line 420
;420:		cg.itemPickupCount = 1;
ADDRGP4 cg+125784
CNSTI4 1
ASGNI4
ADDRGP4 $342
JUMPV
LABELV $341
line 422
;421:	else
;422:		cg.itemPickupCount++;
ADDRLP4 0
ADDRGP4 cg+125784
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $342
line 424
;423:
;424:	oldItem = itemNum;
ADDRGP4 $335
ADDRFP4 0
INDIRI4
ASGNI4
line 427
;425:	
;426:	// see if it should be the grabbed weapon
;427:	if ( bg_itemlist[itemNum].giType == IT_WEAPON ) {
ADDRFP4 0
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $345
line 429
;428:		// select it immediately
;429:		if ( cg_autoswitch.integer && bg_itemlist[itemNum].giTag != WP_MACHINEGUN ) {
ADDRGP4 cg_autoswitch+12
INDIRI4
CNSTI4 0
EQI4 $348
ADDRFP4 0
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 2
EQI4 $348
line 430
;430:			cg.weaponSelectTime = cg.time;
ADDRGP4 cg+125796
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 431
;431:			cg.weaponSelect = bg_itemlist[itemNum].giTag;
ADDRGP4 cg+108956
ADDRFP4 0
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
ASGNI4
line 432
;432:		}
LABELV $348
line 433
;433:	}
LABELV $345
line 435
;434:
;435:}
LABELV $334
endproc CG_ItemPickup 4 0
export CG_WaterLevel
proc CG_WaterLevel 52 8
line 445
;436:
;437:
;438:/*
;439:================
;440:CG_WaterLevel
;441:
;442:Returns waterlevel for entity origin
;443:================
;444:*/
;445:int CG_WaterLevel(centity_t *cent) {
line 450
;446:	vec3_t point;
;447:	int contents, sample1, sample2, anim, waterlevel;
;448:	int viewheight;
;449:
;450:	anim = cent->currentState.legsAnim & ~ANIM_TOGGLEBIT;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 452
;451:
;452:	if ( anim == LEGS_WALKCR || anim == LEGS_IDLECR ) {
ADDRLP4 16
INDIRI4
CNSTI4 13
EQI4 $359
ADDRLP4 16
INDIRI4
CNSTI4 23
NEI4 $357
LABELV $359
line 453
;453:		viewheight = CROUCH_VIEWHEIGHT;
ADDRLP4 24
CNSTI4 12
ASGNI4
line 454
;454:	} else {
ADDRGP4 $358
JUMPV
LABELV $357
line 455
;455:		viewheight = DEFAULT_VIEWHEIGHT;
ADDRLP4 24
CNSTI4 26
ASGNI4
line 456
;456:	}
LABELV $358
line 461
;457:
;458:	//
;459:	// get waterlevel, accounting for ducking
;460:	//
;461:	waterlevel = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 463
;462:
;463:	point[0] = cent->lerpOrigin[0];
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRF4
ASGNF4
line 464
;464:	point[1] = cent->lerpOrigin[1];
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
INDIRF4
ASGNF4
line 465
;465:	point[2] = cent->lerpOrigin[2] + MINS_Z + 1;
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 466
;466:	contents = CG_PointContents(point, -1);
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 40
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 40
INDIRI4
ASGNI4
line 468
;467:
;468:	if ( contents & MASK_WATER ) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $362
line 469
;469:		sample2 = viewheight - MINS_Z;
ADDRLP4 28
ADDRLP4 24
INDIRI4
CNSTI4 -24
SUBI4
ASGNI4
line 470
;470:		sample1 = sample2 / 2;
ADDRLP4 32
ADDRLP4 28
INDIRI4
CNSTI4 2
DIVI4
ASGNI4
line 471
;471:		waterlevel = 1;
ADDRLP4 20
CNSTI4 1
ASGNI4
line 472
;472:		point[2] = cent->lerpOrigin[2] + MINS_Z + sample1;
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
ADDRLP4 32
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 473
;473:		contents = CG_PointContents(point, -1);
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 44
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 44
INDIRI4
ASGNI4
line 475
;474:
;475:		if (contents & MASK_WATER) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $365
line 476
;476:			waterlevel = 2;
ADDRLP4 20
CNSTI4 2
ASGNI4
line 477
;477:			point[2] = cent->lerpOrigin[2] + MINS_Z + sample2;
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
ADDRLP4 28
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 478
;478:			contents = CG_PointContents(point, -1);
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 48
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 48
INDIRI4
ASGNI4
line 480
;479:
;480:			if (contents & MASK_WATER) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $368
line 481
;481:				waterlevel = 3;
ADDRLP4 20
CNSTI4 3
ASGNI4
line 482
;482:			}
LABELV $368
line 483
;483:		}
LABELV $365
line 484
;484:	}
LABELV $362
line 486
;485:
;486:	return waterlevel;
ADDRLP4 20
INDIRI4
RETI4
LABELV $356
endproc CG_WaterLevel 52 8
export CG_PainEvent
proc CG_PainEvent 16 16
line 496
;487:}
;488:
;489:/*
;490:================
;491:CG_PainEvent
;492:
;493:Also called by playerstate transition
;494:================
;495:*/
;496:void CG_PainEvent( centity_t *cent, int health ) {
line 500
;497:	const char *snd;
;498:
;499:	// don't do more than two pain sounds a second
;500:	if ( cg.time - cent->pe.painTime < 500 ) {
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRI4
SUBI4
CNSTI4 500
GEI4 $371
line 501
;501:		cent->pe.painIgnore = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 0
ASGNI4
line 502
;502:		return;
ADDRGP4 $370
JUMPV
LABELV $371
line 505
;503:	}
;504:
;505:	if ( cent->pe.painIgnore ) {
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
INDIRI4
CNSTI4 0
EQI4 $374
line 506
;506:		cent->pe.painIgnore = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 0
ASGNI4
line 507
;507:		return;
ADDRGP4 $370
JUMPV
LABELV $374
line 510
;508:	}
;509:
;510:	if ( health < 25 ) {
ADDRFP4 4
INDIRI4
CNSTI4 25
GEI4 $376
line 511
;511:		snd = "*pain25_1.wav";
ADDRLP4 0
ADDRGP4 $378
ASGNP4
line 512
;512:	} else if ( health < 50 ) {
ADDRGP4 $377
JUMPV
LABELV $376
ADDRFP4 4
INDIRI4
CNSTI4 50
GEI4 $379
line 513
;513:		snd = "*pain50_1.wav";
ADDRLP4 0
ADDRGP4 $381
ASGNP4
line 514
;514:	} else if ( health < 75 ) {
ADDRGP4 $380
JUMPV
LABELV $379
ADDRFP4 4
INDIRI4
CNSTI4 75
GEI4 $382
line 515
;515:		snd = "*pain75_1.wav";
ADDRLP4 0
ADDRGP4 $384
ASGNP4
line 516
;516:	} else {
ADDRGP4 $383
JUMPV
LABELV $382
line 517
;517:		snd = "*pain100_1.wav";
ADDRLP4 0
ADDRGP4 $385
ASGNP4
line 518
;518:	}
LABELV $383
LABELV $380
LABELV $377
line 521
;519:
;520:	// play a gurp sound instead of a normal pain sound
;521:	if (CG_WaterLevel(cent) == 3) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 CG_WaterLevel
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 3
NEI4 $386
line 522
;522:		if (rand()&1) {
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $388
line 523
;523:			trap_S_StartSound(NULL, cent->currentState.number, CHAN_VOICE, CG_CustomSound(cent->currentState.number, "sound/player/gurp1.wav"));
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $390
ARGP4
ADDRLP4 12
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 524
;524:		} else {
ADDRGP4 $387
JUMPV
LABELV $388
line 525
;525:			trap_S_StartSound(NULL, cent->currentState.number, CHAN_VOICE, CG_CustomSound(cent->currentState.number, "sound/player/gurp2.wav"));
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $391
ARGP4
ADDRLP4 12
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 526
;526:		}
line 527
;527:	} else {
ADDRGP4 $387
JUMPV
LABELV $386
line 528
;528:		trap_S_StartSound(NULL, cent->currentState.number, CHAN_VOICE, CG_CustomSound(cent->currentState.number, snd));
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 529
;529:	}
LABELV $387
line 532
;530:
;531:	// save pain time for programitic twitch animation
;532:	cent->pe.painTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 533
;533:	cent->pe.painDirection ^= 1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 608
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 534
;534:}
LABELV $370
endproc CG_PainEvent 16 16
data
align 4
LABELV $499
byte 4 0
byte 4 0
byte 4 1065353216
export CG_EntityEvent
code
proc CG_EntityEvent 124 48
line 546
;535:
;536:
;537:
;538:/*
;539:==============
;540:CG_EntityEvent
;541:
;542:An entity has an event value
;543:also called by CG_CheckPlayerstateEvents
;544:==============
;545:*/
;546:void CG_EntityEvent( centity_t *cent, vec3_t position, int entityNum ) {
line 557
;547:	entityState_t	*es;
;548:	entity_event_t	event;
;549:	vec3_t			dir;
;550:	const char		*s;
;551:	int				clientNum;
;552:	clientInfo_t	*ci;
;553:	vec3_t			vec;
;554:	float			fovOffset;
;555:	centity_t		*ce;
;556:
;557:	es = &cent->currentState;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 558
;558:	event = es->event & ~EV_EVENT_BITS;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
ASGNI4
line 560
;559:
;560:	if ( (unsigned) event >= EV_MAX ) {
ADDRLP4 4
INDIRI4
CVIU4 4
CNSTU4 83
LTU4 $394
line 561
;561:		CG_Error( "Unknown event: %i", event );
ADDRGP4 $396
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 562
;562:		return;
ADDRGP4 $393
JUMPV
LABELV $394
line 565
;563:	}
;564:
;565:	if ( cg_debugEvents.integer ) {
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $397
line 566
;566:		CG_Printf( "ent:%3i  event:%3i %s", es->number, event, eventnames[ event ] );
ADDRGP4 $400
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 eventnames
ADDP4
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 567
;567:	}
LABELV $397
line 569
;568:
;569:	if ( !event ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $401
line 570
;570:		return;
ADDRGP4 $393
JUMPV
LABELV $401
line 573
;571:	}
;572:
;573:	clientNum = es->clientNum;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 574
;574:	if ( (unsigned) clientNum >= MAX_CLIENTS ) {
ADDRLP4 8
INDIRI4
CVIU4 4
CNSTU4 64
LTU4 $403
line 575
;575:		clientNum = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 576
;576:	}
LABELV $403
line 577
;577:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 12
ADDRLP4 8
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+40996
ADDP4
ASGNP4
line 579
;578:
;579:	switch ( event ) {
ADDRLP4 52
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 1
LTI4 $406
ADDRLP4 52
INDIRI4
CNSTI4 82
GTI4 $406
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $886-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $886
address $409
address $415
address $422
address $429
address $436
address $472
address $472
address $472
address $472
address $443
address $453
address $462
address $498
address $506
address $524
address $527
address $530
address $533
address $535
address $573
address $590
address $594
address $597
address $598
address $598
address $598
address $598
address $598
address $598
address $598
address $598
address $598
address $598
address $598
address $598
address $598
address $598
address $598
address $598
address $608
address $605
address $599
address $602
address $612
address $707
address $712
address $719
address $705
address $704
address $640
address $641
address $642
address $643
address $706
address $406
address $842
address $846
address $846
address $846
address $851
address $852
address $861
address $870
address $879
address $639
address $619
address $630
address $633
address $634
address $635
address $636
address $637
address $638
address $885
address $884
address $510
address $512
address $514
address $516
address $518
address $520
address $522
code
LABELV $409
line 584
;580:	//
;581:	// movement generated events
;582:	//
;583:	case EV_FOOTSTEP:
;584:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $407
line 585
;585:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 60
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 cgs+148772+640
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 587
;586:				cgs.media.footsteps[ ci->footsteps ][rand()&3] );
;587:		}
line 588
;588:		break;
ADDRGP4 $407
JUMPV
LABELV $415
line 591
;589:
;590:	case EV_FOOTSTEP_METAL:
;591:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $407
line 592
;592:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 60
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+148772+640+80
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 594
;593:				cgs.media.footsteps[ FOOTSTEP_METAL ][rand()&3] );
;594:		}
line 595
;595:		break;
ADDRGP4 $407
JUMPV
LABELV $422
line 598
;596:
;597:	case EV_FOOTSPLASH:
;598:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $407
line 599
;599:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 60
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+148772+640+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 601
;600:				cgs.media.footsteps[ FOOTSTEP_SPLASH ][rand()&3] );
;601:		}
line 602
;602:		break;
ADDRGP4 $407
JUMPV
LABELV $429
line 605
;603:
;604:	case EV_FOOTWADE:
;605:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $407
line 606
;606:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 60
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+148772+640+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 608
;607:				cgs.media.footsteps[ FOOTSTEP_SPLASH ][rand()&3] );
;608:		}
line 609
;609:		break;
ADDRGP4 $407
JUMPV
LABELV $436
line 612
;610:
;611:	case EV_SWIM:
;612:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $407
line 613
;613:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 60
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+148772+640+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 615
;614:				cgs.media.footsteps[ FOOTSTEP_SPLASH ][rand()&3] );
;615:		}
line 616
;616:		break;
ADDRGP4 $407
JUMPV
LABELV $443
line 619
;617:
;618:	case EV_FALL_SHORT:
;619:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.landSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148772+908
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 620
;620:		if ( clientNum == cg.predictedPlayerState.clientNum ) {
ADDRLP4 8
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $407
line 622
;621:			// smooth landing z changes
;622:			cg.landChange = -8;
ADDRGP4 cg+108948
CNSTF4 3238002688
ASGNF4
line 623
;623:			cg.landTime = cg.time;
ADDRGP4 cg+108952
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 624
;624:		}
line 625
;625:		break;
ADDRGP4 $407
JUMPV
LABELV $453
line 629
;626:
;627:	case EV_FALL_MEDIUM:
;628:		// use normal pain sound
;629:		trap_S_StartSound( NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*pain100_1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $385
ARGP4
ADDRLP4 60
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 630
;630:		cent->pe.painIgnore = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 1
ASGNI4
line 631
;631:		cent->pe.painTime = cg.time;	// don't play a pain sound right after this
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 632
;632:		if ( clientNum == cg.predictedPlayerState.clientNum ) {
ADDRLP4 8
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $407
line 634
;633:			// smooth landing z changes
;634:			cg.landChange = -16;
ADDRGP4 cg+108948
CNSTF4 3246391296
ASGNF4
line 635
;635:			cg.landTime = cg.time;
ADDRGP4 cg+108952
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 636
;636:		}
line 637
;637:		break;
ADDRGP4 $407
JUMPV
LABELV $462
line 640
;638:
;639:	case EV_FALL_FAR:
;640:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, CG_CustomSound( es->number, "*fall1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $463
ARGP4
ADDRLP4 64
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 641
;641:		cent->pe.painIgnore = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 1
ASGNI4
line 642
;642:		cent->pe.painTime = cg.time;	// don't play a pain sound right after this
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 643
;643:		if ( clientNum == cg.predictedPlayerState.clientNum ) {
ADDRLP4 8
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $407
line 645
;644:			// smooth landing z changes
;645:			cg.landChange = -24;
ADDRGP4 cg+108948
CNSTF4 3250585600
ASGNF4
line 646
;646:			cg.landTime = cg.time;
ADDRGP4 cg+108952
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 647
;647:		}
line 648
;648:		break;
ADDRGP4 $407
JUMPV
LABELV $472
line 654
;649:
;650:	case EV_STEP_4:
;651:	case EV_STEP_8:
;652:	case EV_STEP_12:
;653:	case EV_STEP_16:		// smooth out step up transitions
;654:	{
line 659
;655:		float	oldStep;
;656:		int		delta;
;657:		int		step;
;658:
;659:		if ( clientNum != cg.predictedPlayerState.clientNum ) {
ADDRLP4 8
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
EQI4 $473
line 660
;660:			break;
ADDRGP4 $407
JUMPV
LABELV $473
line 663
;661:		}
;662:		// if we are interpolating, we don't need to smooth steps
;663:		if ( cg.demoPlayback || (cg.snap->ps.pm_flags & PMF_FOLLOW) ||
ADDRGP4 cg+8
INDIRI4
CNSTI4 0
NEI4 $485
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $485
ADDRGP4 cg_nopredict+12
INDIRI4
CNSTI4 0
NEI4 $485
ADDRGP4 cgs+150080
INDIRI4
CNSTI4 0
EQI4 $477
LABELV $485
line 664
;664:			cg_nopredict.integer || cgs.synchronousClients ) {
line 665
;665:			break;
ADDRGP4 $407
JUMPV
LABELV $477
line 668
;666:		}
;667:		// check for stepping up before a previous step is completed
;668:		delta = cg.time - cg.stepTime;
ADDRLP4 68
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+108936
INDIRI4
SUBI4
ASGNI4
line 669
;669:		if (delta < STEP_TIME) {
ADDRLP4 68
INDIRI4
CNSTI4 200
GEI4 $488
line 670
;670:			oldStep = cg.stepChange * (STEP_TIME - delta) / STEP_TIME;
ADDRLP4 72
ADDRGP4 cg+108932
INDIRF4
CNSTI4 200
ADDRLP4 68
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1000593162
MULF4
ASGNF4
line 671
;671:		} else {
ADDRGP4 $489
JUMPV
LABELV $488
line 672
;672:			oldStep = 0;
ADDRLP4 72
CNSTF4 0
ASGNF4
line 673
;673:		}
LABELV $489
line 676
;674:
;675:		// add this amount
;676:		step = 4 * (event - EV_STEP_4 + 1 );
ADDRLP4 76
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 24
SUBI4
CNSTI4 4
ADDI4
ASGNI4
line 677
;677:		cg.stepChange = oldStep + step;
ADDRGP4 cg+108932
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 678
;678:		if ( cg.stepChange > MAX_STEP_CHANGE ) {
ADDRGP4 cg+108932
INDIRF4
CNSTF4 1107296256
LEF4 $492
line 679
;679:			cg.stepChange = MAX_STEP_CHANGE;
ADDRGP4 cg+108932
CNSTF4 1107296256
ASGNF4
line 680
;680:		}
LABELV $492
line 681
;681:		cg.stepTime = cg.time;
ADDRGP4 cg+108936
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 682
;682:		break;
ADDRGP4 $407
JUMPV
LABELV $498
line 687
;683:	}
;684:
;685:	case EV_JUMP_PAD:
;686://		CG_Printf( "EV_JUMP_PAD w/effect #%i\n", es->eventParm );
;687:		{
line 688
;688:			vec3_t			up = {0, 0, 1};
ADDRLP4 68
ADDRGP4 $499
INDIRB
ASGNB 12
line 691
;689:
;690:
;691:			CG_SmokePuff( cent->lerpOrigin, up, 
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 68
ARGP4
CNSTF4 1107296256
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1051260355
ARGF4
CNSTF4 1148846080
ARGF4
ADDRGP4 cg+107604
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 cgs+148772+308
INDIRI4
ARGI4
ADDRGP4 CG_SmokePuff
CALLP4
pop
line 698
;692:						  32, 
;693:						  1, 1, 1, 0.33f,
;694:						  1000, 
;695:						  cg.time, 0,
;696:						  LEF_PUFF_DONT_SCALE, 
;697:						  cgs.media.smokePuffShader );
;698:		}
line 701
;699:
;700:		// boing sound at origin, jump sound on player
;701:		trap_S_StartSound ( cent->lerpOrigin, -1, CHAN_VOICE, cgs.media.jumpPadSound );
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 cgs+148772+912
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 702
;702:		trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*jump1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $505
ARGP4
ADDRLP4 68
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 68
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 703
;703:		break;
ADDRGP4 $407
JUMPV
LABELV $506
line 707
;704:
;705:	case EV_JUMP:
;706:		// pain event with fast sequential jump just creates sound distortion
;707:		if ( cg.time - cent->pe.painTime > 50 )
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRI4
SUBI4
CNSTI4 50
LEI4 $407
line 708
;708:			trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*jump1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $505
ARGP4
ADDRLP4 72
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 709
;709:		break;
ADDRGP4 $407
JUMPV
LABELV $510
line 712
;710:
;711:	case EV_TAUNT:
;712:		trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*taunt.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $511
ARGP4
ADDRLP4 76
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 713
;713:		break;
ADDRGP4 $407
JUMPV
LABELV $512
line 717
;714:
;715:#ifdef MISSIONPACK
;716:	case EV_TAUNT_YES:
;717:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_YES);
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 53
ARGI4
ADDRGP4 $513
ARGP4
ADDRGP4 CG_VoiceChatLocal
CALLV
pop
line 718
;718:		break;
ADDRGP4 $407
JUMPV
LABELV $514
line 721
;719:
;720:	case EV_TAUNT_NO:
;721:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_NO);
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 53
ARGI4
ADDRGP4 $515
ARGP4
ADDRGP4 CG_VoiceChatLocal
CALLV
pop
line 722
;722:		break;
ADDRGP4 $407
JUMPV
LABELV $516
line 725
;723:
;724:	case EV_TAUNT_FOLLOWME:
;725:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_FOLLOWME);
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 53
ARGI4
ADDRGP4 $517
ARGP4
ADDRGP4 CG_VoiceChatLocal
CALLV
pop
line 726
;726:		break;
ADDRGP4 $407
JUMPV
LABELV $518
line 729
;727:
;728:	case EV_TAUNT_GETFLAG:
;729:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_ONGETFLAG);
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 53
ARGI4
ADDRGP4 $519
ARGP4
ADDRGP4 CG_VoiceChatLocal
CALLV
pop
line 730
;730:		break;
ADDRGP4 $407
JUMPV
LABELV $520
line 733
;731:
;732:	case EV_TAUNT_GUARDBASE:
;733:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_ONDEFENSE);
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 53
ARGI4
ADDRGP4 $521
ARGP4
ADDRGP4 CG_VoiceChatLocal
CALLV
pop
line 734
;734:		break;
ADDRGP4 $407
JUMPV
LABELV $522
line 737
;735:
;736:	case EV_TAUNT_PATROL:
;737:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_ONPATROL);
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 53
ARGI4
ADDRGP4 $523
ARGP4
ADDRGP4 CG_VoiceChatLocal
CALLV
pop
line 738
;738:		break;
ADDRGP4 $407
JUMPV
LABELV $524
line 741
;739:#endif
;740:	case EV_WATER_TOUCH:
;741:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.watrInSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148772+1032
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 742
;742:		break;
ADDRGP4 $407
JUMPV
LABELV $527
line 745
;743:
;744:	case EV_WATER_LEAVE:
;745:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.watrOutSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148772+1036
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 746
;746:		break;
ADDRGP4 $407
JUMPV
LABELV $530
line 749
;747:
;748:	case EV_WATER_UNDER:
;749:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.watrUnSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148772+1040
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 750
;750:		break;
ADDRGP4 $407
JUMPV
LABELV $533
line 753
;751:
;752:	case EV_WATER_CLEAR:
;753:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, CG_CustomSound( es->number, "*gasp.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $534
ARGP4
ADDRLP4 80
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 80
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 754
;754:		break;
ADDRGP4 $407
JUMPV
LABELV $535
line 757
;755:
;756:	case EV_ITEM_PICKUP:
;757:		{
line 761
;758:			gitem_t	*item;
;759:			int		index;
;760:
;761:			index = es->eventParm;		// player predicted
ADDRLP4 84
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 763
;762:
;763:			if ( index < 1 || index >= bg_numItems ) {
ADDRLP4 92
ADDRLP4 84
INDIRI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 1
LTI4 $538
ADDRLP4 92
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $536
LABELV $538
line 764
;764:				break;
ADDRGP4 $407
JUMPV
LABELV $536
line 767
;765:			}
;766:
;767:			if ( entityNum >= 0 ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
LTI4 $539
line 769
;768:				// our predicted entity
;769:				ce = cg_entities + entityNum;
ADDRLP4 40
ADDRFP4 8
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 770
;770:				if ( ce->delaySpawn > cg.time && ce->delaySpawnPlayed ) {
ADDRLP4 96
ADDRLP4 40
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 448
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $540
ADDRLP4 96
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
CNSTI4 0
EQI4 $540
line 771
;771:					break; // delay item pickup
ADDRGP4 $407
JUMPV
line 773
;772:				}
;773:			} else {
LABELV $539
line 774
;774:				ce = NULL;
ADDRLP4 40
CNSTP4 0
ASGNP4
line 775
;775:			}
LABELV $540
line 777
;776:
;777:			item = &bg_itemlist[ index ];
ADDRLP4 88
ADDRLP4 84
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 781
;778:
;779:			// powerups and team items will have a separate global sound, this one
;780:			// will be played at prediction time
;781:			if ( item->giType == IT_POWERUP || item->giType == IT_TEAM) {
ADDRLP4 96
ADDRLP4 88
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
EQI4 $546
ADDRLP4 96
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $544
LABELV $546
line 782
;782:				trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.n_healthSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148772+1248
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 783
;783:			} else if (item->giType == IT_PERSISTANT_POWERUP) {
ADDRGP4 $545
JUMPV
LABELV $544
ADDRLP4 88
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 7
NEI4 $549
line 785
;784:#ifdef MISSIONPACK
;785:				switch (item->giTag ) {
ADDRLP4 100
ADDRLP4 88
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 10
LTI4 $550
ADDRLP4 100
INDIRI4
CNSTI4 13
GTI4 $550
ADDRLP4 100
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $566-40
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $566
address $554
address $557
address $560
address $563
code
LABELV $554
line 787
;786:					case PW_SCOUT:
;787:						trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.scoutSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148772+1232
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 788
;788:					break;
ADDRGP4 $550
JUMPV
LABELV $557
line 790
;789:					case PW_GUARD:
;790:						trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.guardSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148772+1228
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 791
;791:					break;
ADDRGP4 $550
JUMPV
LABELV $560
line 793
;792:					case PW_DOUBLER:
;793:						trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.doublerSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148772+1224
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 794
;794:					break;
ADDRGP4 $550
JUMPV
LABELV $563
line 796
;795:					case PW_AMMOREGEN:
;796:						trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.ammoregenSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148772+1220
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 797
;797:					break;
line 800
;798:				}
;799:#endif
;800:			} else {
ADDRGP4 $550
JUMPV
LABELV $549
line 801
;801:				trap_S_StartSound (NULL, es->number, CHAN_AUTO,	trap_S_RegisterSound( item->pickup_sound, qfalse ) );
ADDRLP4 88
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 100
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 100
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 802
;802:			}
LABELV $550
LABELV $545
line 805
;803:
;804:			// show icon and name on status bar
;805:			if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $568
line 806
;806:				CG_ItemPickup( index );
ADDRLP4 84
INDIRI4
ARGI4
ADDRGP4 CG_ItemPickup
CALLV
pop
line 807
;807:			}
LABELV $568
line 809
;808:
;809:			if ( ce ) {
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $407
line 810
;810:				ce->delaySpawnPlayed = qtrue;
ADDRLP4 40
INDIRP4
CNSTI4 452
ADDP4
CNSTI4 1
ASGNI4
line 811
;811:			}
line 812
;812:		}
line 813
;813:		break;
ADDRGP4 $407
JUMPV
LABELV $573
line 816
;814:
;815:	case EV_GLOBAL_ITEM_PICKUP:
;816:		{
line 820
;817:			gitem_t	*item;
;818:			int		index;
;819:
;820:			index = es->eventParm;		// player predicted
ADDRLP4 84
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 822
;821:
;822:			if ( index < 1 || index >= bg_numItems ) {
ADDRLP4 92
ADDRLP4 84
INDIRI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 1
LTI4 $576
ADDRLP4 92
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $574
LABELV $576
line 823
;823:				break;
ADDRGP4 $407
JUMPV
LABELV $574
line 826
;824:			}
;825:
;826:			if ( entityNum >= 0 ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
LTI4 $577
line 828
;827:				// our predicted entity
;828:				ce = cg_entities + entityNum;
ADDRLP4 40
ADDRFP4 8
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 829
;829:				if ( ce->delaySpawn > cg.time && ce->delaySpawnPlayed ) {
ADDRLP4 96
ADDRLP4 40
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 448
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $578
ADDRLP4 96
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
CNSTI4 0
EQI4 $578
line 830
;830:					break;
ADDRGP4 $407
JUMPV
line 832
;831:				}
;832:			} else {
LABELV $577
line 833
;833:				ce = NULL;
ADDRLP4 40
CNSTP4 0
ASGNP4
line 834
;834:			}
LABELV $578
line 836
;835:
;836:			item = &bg_itemlist[ index ];
ADDRLP4 88
ADDRLP4 84
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 838
;837:			// powerup pickups are global
;838:			if( item->pickup_sound ) {
ADDRLP4 88
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $582
line 839
;839:				trap_S_StartSound (NULL, cg.snap->ps.clientNum, CHAN_AUTO, trap_S_RegisterSound( item->pickup_sound, qfalse ) );
ADDRLP4 88
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 96
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 96
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 840
;840:			}
LABELV $582
line 843
;841:
;842:			// show icon and name on status bar
;843:			if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $585
line 844
;844:				CG_ItemPickup( index );
ADDRLP4 84
INDIRI4
ARGI4
ADDRGP4 CG_ItemPickup
CALLV
pop
line 845
;845:			}
LABELV $585
line 847
;846:
;847:			if ( ce ) {
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $407
line 848
;848:				ce->delaySpawnPlayed = qtrue;
ADDRLP4 40
INDIRP4
CNSTI4 452
ADDP4
CNSTI4 1
ASGNI4
line 849
;849:			}
line 850
;850:		}
line 851
;851:		break;
ADDRGP4 $407
JUMPV
LABELV $590
line 858
;852:
;853:	//
;854:	// weapon events
;855:	//
;856:	case EV_NOAMMO:
;857://		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.noAmmoSound );
;858:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $407
line 859
;859:			CG_OutOfAmmoChange();
ADDRGP4 CG_OutOfAmmoChange
CALLV
pop
line 860
;860:		}
line 861
;861:		break;
ADDRGP4 $407
JUMPV
LABELV $594
line 864
;862:
;863:	case EV_CHANGE_WEAPON:
;864:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.selectSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148772+628
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 865
;865:		break;
ADDRGP4 $407
JUMPV
LABELV $597
line 868
;866:
;867:	case EV_FIRE_WEAPON:
;868:		CG_FireWeapon( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FireWeapon
CALLV
pop
line 869
;869:		break;
ADDRGP4 $407
JUMPV
LABELV $598
line 887
;870:
;871:	case EV_USE_ITEM0:
;872:	case EV_USE_ITEM1:
;873:	case EV_USE_ITEM2:
;874:	case EV_USE_ITEM3:
;875:	case EV_USE_ITEM4:
;876:	case EV_USE_ITEM5:
;877:	case EV_USE_ITEM6:
;878:	case EV_USE_ITEM7:
;879:	case EV_USE_ITEM8:
;880:	case EV_USE_ITEM9:
;881:	case EV_USE_ITEM10:
;882:	case EV_USE_ITEM11:
;883:	case EV_USE_ITEM12:
;884:	case EV_USE_ITEM13:
;885:	case EV_USE_ITEM14:
;886:	case EV_USE_ITEM15:
;887:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 888
;888:		break;
ADDRGP4 $407
JUMPV
LABELV $599
line 896
;889:
;890:	//=================================================================
;891:
;892:	//
;893:	// other events
;894:	//
;895:	case EV_PLAYER_TELEPORT_IN:
;896:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.teleInSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148772+888
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 897
;897:		CG_SpawnEffect( position);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_SpawnEffect
CALLV
pop
line 898
;898:		break;
ADDRGP4 $407
JUMPV
LABELV $602
line 901
;899:
;900:	case EV_PLAYER_TELEPORT_OUT:
;901:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.teleOutSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148772+892
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 902
;902:		CG_SpawnEffect(  position);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_SpawnEffect
CALLV
pop
line 903
;903:		break;
ADDRGP4 $407
JUMPV
LABELV $605
line 906
;904:
;905:	case EV_ITEM_POP:
;906:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.respawnSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148772+900
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 907
;907:		break;
ADDRGP4 $407
JUMPV
LABELV $608
line 910
;908:
;909:	case EV_ITEM_RESPAWN:
;910:		cent->miscTime = cg.time;	// scale up from this
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 911
;911:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.respawnSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148772+900
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 912
;912:		break;
ADDRGP4 $407
JUMPV
LABELV $612
line 915
;913:
;914:	case EV_GRENADE_BOUNCE:
;915:		if ( rand() & 1 ) {
ADDRLP4 84
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $613
line 916
;916:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.hgrenb1aSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148772+1252
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 917
;917:		} else {
ADDRGP4 $407
JUMPV
LABELV $613
line 918
;918:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.hgrenb2aSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148772+1256
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 919
;919:		}
line 920
;920:		break;
ADDRGP4 $407
JUMPV
LABELV $619
line 924
;921:
;922:#ifdef MISSIONPACK
;923:	case EV_PROXIMITY_MINE_STICK:
;924:		if( es->eventParm & SURF_FLESH ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $620
line 925
;925:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.wstbimplSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148772+1260
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 926
;926:		} else 	if( es->eventParm & SURF_METALSTEPS ) {
ADDRGP4 $407
JUMPV
LABELV $620
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $624
line 927
;927:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.wstbimpmSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148772+1264
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 928
;928:		} else {
ADDRGP4 $407
JUMPV
LABELV $624
line 929
;929:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.wstbimpdSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148772+1268
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 930
;930:		}
line 931
;931:		break;
ADDRGP4 $407
JUMPV
LABELV $630
line 934
;932:
;933:	case EV_PROXIMITY_MINE_TRIGGER:
;934:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.wstbactvSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+148772+1272
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 935
;935:		break;
ADDRGP4 $407
JUMPV
LABELV $633
line 938
;936:
;937:	case EV_KAMIKAZE:
;938:		CG_KamikazeEffect( cent->lerpOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 CG_KamikazeEffect
CALLV
pop
line 939
;939:		break;
ADDRGP4 $407
JUMPV
LABELV $634
line 942
;940:
;941:	case EV_OBELISKEXPLODE:
;942:		CG_ObeliskExplode( cent->lerpOrigin, es->eventParm );
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ObeliskExplode
CALLV
pop
line 943
;943:		break;
ADDRGP4 $407
JUMPV
LABELV $635
line 946
;944:
;945:	case EV_OBELISKPAIN:
;946:		CG_ObeliskPain( cent->lerpOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 CG_ObeliskPain
CALLV
pop
line 947
;947:		break;
ADDRGP4 $407
JUMPV
LABELV $636
line 950
;948:
;949:	case EV_INVUL_IMPACT:
;950:		CG_InvulnerabilityImpact( cent->lerpOrigin, cent->currentState.angles );
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 88
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRGP4 CG_InvulnerabilityImpact
CALLV
pop
line 951
;951:		break;
ADDRGP4 $407
JUMPV
LABELV $637
line 954
;952:
;953:	case EV_JUICED:
;954:		CG_InvulnerabilityJuiced( cent->lerpOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 CG_InvulnerabilityJuiced
CALLV
pop
line 955
;955:		break;
ADDRGP4 $407
JUMPV
LABELV $638
line 958
;956:
;957:	case EV_LIGHTNINGBOLT:
;958:		CG_LightningBoltBeam(es->origin2, es->pos.trBase);
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 CG_LightningBoltBeam
CALLV
pop
line 959
;959:		break;
ADDRGP4 $407
JUMPV
LABELV $639
line 963
;960:#endif
;961:
;962:	case EV_SCOREPLUM:
;963:		CG_ScorePlum( cent->currentState.otherEntityNum, cent->lerpOrigin, cent->currentState.time );
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 96
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ScorePlum
CALLV
pop
line 964
;964:		break;
ADDRGP4 $407
JUMPV
LABELV $640
line 970
;965:
;966:	//
;967:	// missile impacts
;968:	//
;969:	case EV_MISSILE_HIT:
;970:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 971
;971:		CG_MissileHitPlayer( es->weapon, position, dir, es->otherEntityNum );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_MissileHitPlayer
CALLV
pop
line 972
;972:		break;
ADDRGP4 $407
JUMPV
LABELV $641
line 975
;973:
;974:	case EV_MISSILE_MISS:
;975:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 976
;976:		CG_MissileHitWall( es->weapon, 0, position, dir, IMPACTSOUND_DEFAULT );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 977
;977:		break;
ADDRGP4 $407
JUMPV
LABELV $642
line 980
;978:
;979:	case EV_MISSILE_MISS_METAL:
;980:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 981
;981:		CG_MissileHitWall( es->weapon, 0, position, dir, IMPACTSOUND_METAL );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 982
;982:		break;
ADDRGP4 $407
JUMPV
LABELV $643
line 985
;983:
;984:	case EV_RAILTRAIL:
;985:		cent->currentState.weapon = WP_RAILGUN;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 7
ASGNI4
line 987
;986:
;987:		if ( cent->currentState.clientNum == cg.snap->ps.clientNum && !cg_thirdPerson.integer ) 
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $644
ADDRGP4 cg_thirdPerson+12
INDIRI4
CNSTI4 0
NEI4 $644
line 988
;988:		{
line 989
;989:			VectorCopy( cg.refdef.vieworg, vec );
ADDRLP4 16
ADDRGP4 cg+109056+24
INDIRB
ASGNB 12
line 990
;990:			fovOffset = -0.2f * ( cgs.fov - 90.0f );
ADDRLP4 48
ADDRGP4 cgs+150064
INDIRF4
CNSTF4 1119092736
SUBF4
CNSTF4 3192704205
MULF4
ASGNF4
line 993
;991:
;992:			// 13.5, -5.5, -6.0
;993:			VectorMA( vec, cg_gun_x.value + 13.5f, cg.refdef.viewaxis[0], vec );
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRGP4 cg+109056+36
INDIRF4
ADDRGP4 cg_gun_x+8
INDIRF4
CNSTF4 1096286208
ADDF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 16+4
INDIRF4
ADDRGP4 cg+109056+36+4
INDIRF4
ADDRGP4 cg_gun_x+8
INDIRF4
CNSTF4 1096286208
ADDF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 16+8
INDIRF4
ADDRGP4 cg+109056+36+8
INDIRF4
ADDRGP4 cg_gun_x+8
INDIRF4
CNSTF4 1096286208
ADDF4
MULF4
ADDF4
ASGNF4
line 994
;994:			VectorMA( vec, cg_gun_y.value - 5.5f, cg.refdef.viewaxis[1], vec );
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRGP4 cg+109056+36+12
INDIRF4
ADDRGP4 cg_gun_y+8
INDIRF4
CNSTF4 1085276160
SUBF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 16+4
INDIRF4
ADDRGP4 cg+109056+36+12+4
INDIRF4
ADDRGP4 cg_gun_y+8
INDIRF4
CNSTF4 1085276160
SUBF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 16+8
INDIRF4
ADDRGP4 cg+109056+36+12+8
INDIRF4
ADDRGP4 cg_gun_y+8
INDIRF4
CNSTF4 1085276160
SUBF4
MULF4
ADDF4
ASGNF4
line 995
;995:			VectorMA( vec, cg_gun_z.value + fovOffset - 6.0f, cg.refdef.viewaxis[2], vec );
ADDRLP4 104
ADDRLP4 48
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRGP4 cg+109056+36+24
INDIRF4
ADDRGP4 cg_gun_z+8
INDIRF4
ADDRLP4 104
INDIRF4
ADDF4
CNSTF4 1086324736
SUBF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 16+4
INDIRF4
ADDRGP4 cg+109056+36+24+4
INDIRF4
ADDRGP4 cg_gun_z+8
INDIRF4
ADDRLP4 104
INDIRF4
ADDF4
CNSTF4 1086324736
SUBF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 16+8
INDIRF4
ADDRGP4 cg+109056+36+24+8
INDIRF4
ADDRGP4 cg_gun_z+8
INDIRF4
ADDRLP4 48
INDIRF4
ADDF4
CNSTF4 1086324736
SUBF4
MULF4
ADDF4
ASGNF4
line 996
;996:		}
ADDRGP4 $645
JUMPV
LABELV $644
line 998
;997:		else
;998:			VectorCopy( es->origin2, vec );
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
LABELV $645
line 1001
;999:
;1000:		// if the end was on a nomark surface, don't make an explosion
;1001:		CG_RailTrail( ci, vec, es->pos.trBase );
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 CG_RailTrail
CALLV
pop
line 1003
;1002:
;1003:		if ( es->eventParm != 255 ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 255
EQI4 $407
line 1004
;1004:			ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 1005
;1005:			CG_MissileHitWall( es->weapon, es->clientNum, position, dir, IMPACTSOUND_DEFAULT );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 1006
;1006:		}
line 1007
;1007:		break;
ADDRGP4 $407
JUMPV
LABELV $704
line 1010
;1008:
;1009:	case EV_BULLET_HIT_WALL:
;1010:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 1011
;1011:		CG_Bullet( es->pos.trBase, es->otherEntityNum, dir, qfalse, ENTITYNUM_WORLD );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1022
ARGI4
ADDRGP4 CG_Bullet
CALLV
pop
line 1012
;1012:		break;
ADDRGP4 $407
JUMPV
LABELV $705
line 1015
;1013:
;1014:	case EV_BULLET_HIT_FLESH:
;1015:		CG_Bullet( es->pos.trBase, es->otherEntityNum, dir, qtrue, es->eventParm );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Bullet
CALLV
pop
line 1016
;1016:		break;
ADDRGP4 $407
JUMPV
LABELV $706
line 1019
;1017:
;1018:	case EV_SHOTGUN:
;1019:		CG_ShotgunFire( es );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_ShotgunFire
CALLV
pop
line 1020
;1020:		break;
ADDRGP4 $407
JUMPV
LABELV $707
line 1023
;1021:
;1022:	case EV_GENERAL_SOUND:
;1023:		if ( cgs.gameSounds[ es->eventParm ] ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35872
ADDP4
INDIRI4
CNSTI4 0
EQI4 $708
line 1024
;1024:			trap_S_StartSound (NULL, es->number, CHAN_VOICE, cgs.gameSounds[ es->eventParm ] );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35872
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1025
;1025:		} else {
ADDRGP4 $407
JUMPV
LABELV $708
line 1026
;1026:			s = CG_ConfigString( CS_SOUNDS + es->eventParm );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 112
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 44
ADDRLP4 112
INDIRP4
ASGNP4
line 1027
;1027:			trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, s ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 116
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 116
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1028
;1028:		}
line 1029
;1029:		break;
ADDRGP4 $407
JUMPV
LABELV $712
line 1032
;1030:
;1031:	case EV_GLOBAL_SOUND:	// play from the player's head so it never diminishes
;1032:		if ( cgs.gameSounds[ es->eventParm ] ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35872
ADDP4
INDIRI4
CNSTI4 0
EQI4 $713
line 1033
;1033:			trap_S_StartSound (NULL, cg.snap->ps.clientNum, CHAN_AUTO, cgs.gameSounds[ es->eventParm ] );
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35872
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1034
;1034:		} else {
ADDRGP4 $407
JUMPV
LABELV $713
line 1035
;1035:			s = CG_ConfigString( CS_SOUNDS + es->eventParm );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 112
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 44
ADDRLP4 112
INDIRP4
ASGNP4
line 1036
;1036:			trap_S_StartSound (NULL, cg.snap->ps.clientNum, CHAN_AUTO, CG_CustomSound( es->number, s ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 116
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 116
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1037
;1037:		}
line 1038
;1038:		break;
ADDRGP4 $407
JUMPV
LABELV $719
line 1041
;1039:
;1040:	case EV_GLOBAL_TEAM_SOUND:	// play from the player's head so it never diminishes
;1041:		{
line 1042
;1042:			switch( es->eventParm ) {
ADDRLP4 112
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
LTI4 $407
ADDRLP4 112
INDIRI4
CNSTI4 13
GTI4 $407
ADDRLP4 112
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $841
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $841
address $723
address $731
address $739
address $749
address $759
address $785
address $811
address $817
address $823
address $826
address $829
address $832
address $835
address $838
code
LABELV $723
line 1044
;1043:				case GTS_RED_CAPTURE: // CTF: red team captured the blue flag, 1FCTF: red team captured the neutral flag
;1044:					if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED )
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $724
line 1045
;1045:						CG_AddBufferedSound( cgs.media.captureYourTeamSound );
ADDRGP4 cgs+148772+1080
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $407
JUMPV
LABELV $724
line 1047
;1046:					else
;1047:						CG_AddBufferedSound( cgs.media.captureOpponentSound );
ADDRGP4 cgs+148772+1084
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1048
;1048:					break;
ADDRGP4 $407
JUMPV
LABELV $731
line 1050
;1049:				case GTS_BLUE_CAPTURE: // CTF: blue team captured the red flag, 1FCTF: blue team captured the neutral flag
;1050:					if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE )
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $732
line 1051
;1051:						CG_AddBufferedSound( cgs.media.captureYourTeamSound );
ADDRGP4 cgs+148772+1080
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $407
JUMPV
LABELV $732
line 1053
;1052:					else
;1053:						CG_AddBufferedSound( cgs.media.captureOpponentSound );
ADDRGP4 cgs+148772+1084
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1054
;1054:					break;
ADDRGP4 $407
JUMPV
LABELV $739
line 1056
;1055:				case GTS_RED_RETURN: // CTF: blue flag returned, 1FCTF: never used
;1056:					if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED )
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $740
line 1057
;1057:						CG_AddBufferedSound( cgs.media.returnYourTeamSound );
ADDRGP4 cgs+148772+1088
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $741
JUMPV
LABELV $740
line 1059
;1058:					else
;1059:						CG_AddBufferedSound( cgs.media.returnOpponentSound );
ADDRGP4 cgs+148772+1092
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
LABELV $741
line 1061
;1060:					//
;1061:					CG_AddBufferedSound( cgs.media.blueFlagReturnedSound );
ADDRGP4 cgs+148772+1108
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1062
;1062:					break;
ADDRGP4 $407
JUMPV
LABELV $749
line 1064
;1063:				case GTS_BLUE_RETURN: // CTF red flag returned, 1FCTF: neutral flag returned
;1064:					if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE )
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $750
line 1065
;1065:						CG_AddBufferedSound( cgs.media.returnYourTeamSound );
ADDRGP4 cgs+148772+1088
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $751
JUMPV
LABELV $750
line 1067
;1066:					else
;1067:						CG_AddBufferedSound( cgs.media.returnOpponentSound );
ADDRGP4 cgs+148772+1092
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
LABELV $751
line 1069
;1068:					//
;1069:					CG_AddBufferedSound( cgs.media.redFlagReturnedSound );
ADDRGP4 cgs+148772+1104
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1070
;1070:					break;
ADDRGP4 $407
JUMPV
LABELV $759
line 1074
;1071:
;1072:				case GTS_RED_TAKEN: // CTF: red team took blue flag, 1FCTF: blue team took the neutral flag
;1073:					// if this player picked up the flag then a sound is played in CG_CheckLocalSounds
;1074:					if (cg.snap->ps.powerups[PW_BLUEFLAG] || cg.snap->ps.powerups[PW_NEUTRALFLAG]) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
NEI4 $764
ADDRGP4 cg+36
INDIRP4
CNSTI4 392
ADDP4
INDIRI4
CNSTI4 0
EQI4 $760
LABELV $764
line 1075
;1075:					}
ADDRGP4 $407
JUMPV
LABELV $760
line 1076
;1076:					else {
line 1077
;1077:						if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $765
line 1079
;1078:#ifdef MISSIONPACK
;1079:							if (cgs.gametype == GT_1FCTF) 
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 5
NEI4 $768
line 1080
;1080:								CG_AddBufferedSound( cgs.media.yourTeamTookTheFlagSound );
ADDRGP4 cgs+148772+1128
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $407
JUMPV
LABELV $768
line 1083
;1081:							else
;1082:#endif
;1083:						 	CG_AddBufferedSound( cgs.media.enemyTookYourFlagSound );
ADDRGP4 cgs+148772+1116
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1084
;1084:						}
ADDRGP4 $407
JUMPV
LABELV $765
line 1085
;1085:						else if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $407
line 1087
;1086:#ifdef MISSIONPACK
;1087:							if (cgs.gametype == GT_1FCTF)
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 5
NEI4 $778
line 1088
;1088:								CG_AddBufferedSound( cgs.media.enemyTookTheFlagSound );
ADDRGP4 cgs+148772+1120
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $407
JUMPV
LABELV $778
line 1091
;1089:							else
;1090:#endif
;1091: 							CG_AddBufferedSound( cgs.media.yourTeamTookEnemyFlagSound );
ADDRGP4 cgs+148772+1124
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1092
;1092:						}
line 1093
;1093:					}
line 1094
;1094:					break;
ADDRGP4 $407
JUMPV
LABELV $785
line 1097
;1095:				case GTS_BLUE_TAKEN: // CTF: blue team took the red flag, 1FCTF red team took the neutral flag
;1096:					// if this player picked up the flag then a sound is played in CG_CheckLocalSounds
;1097:					if (cg.snap->ps.powerups[PW_REDFLAG] || cg.snap->ps.powerups[PW_NEUTRALFLAG]) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
NEI4 $790
ADDRGP4 cg+36
INDIRP4
CNSTI4 392
ADDP4
INDIRI4
CNSTI4 0
EQI4 $786
LABELV $790
line 1098
;1098:					}
ADDRGP4 $407
JUMPV
LABELV $786
line 1099
;1099:					else {
line 1100
;1100:						if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $791
line 1102
;1101:#ifdef MISSIONPACK
;1102:							if (cgs.gametype == GT_1FCTF)
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 5
NEI4 $794
line 1103
;1103:								CG_AddBufferedSound( cgs.media.yourTeamTookTheFlagSound );
ADDRGP4 cgs+148772+1128
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $407
JUMPV
LABELV $794
line 1106
;1104:							else
;1105:#endif
;1106:							CG_AddBufferedSound( cgs.media.enemyTookYourFlagSound );
ADDRGP4 cgs+148772+1116
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1107
;1107:						}
ADDRGP4 $407
JUMPV
LABELV $791
line 1108
;1108:						else if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $407
line 1110
;1109:#ifdef MISSIONPACK
;1110:							if (cgs.gametype == GT_1FCTF)
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 5
NEI4 $804
line 1111
;1111:								CG_AddBufferedSound( cgs.media.enemyTookTheFlagSound );
ADDRGP4 cgs+148772+1120
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $407
JUMPV
LABELV $804
line 1114
;1112:							else
;1113:#endif
;1114:							CG_AddBufferedSound( cgs.media.yourTeamTookEnemyFlagSound );
ADDRGP4 cgs+148772+1124
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1115
;1115:						}
line 1116
;1116:					}
line 1117
;1117:					break;
ADDRGP4 $407
JUMPV
LABELV $811
line 1120
;1118:#ifdef MISSIONPACK
;1119:				case GTS_REDOBELISK_ATTACKED: // Overload: red obelisk is being attacked
;1120:					if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $407
line 1121
;1121:						CG_AddBufferedSound( cgs.media.yourBaseIsUnderAttackSound );
ADDRGP4 cgs+148772+1136
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1122
;1122:					}
line 1123
;1123:					break;
ADDRGP4 $407
JUMPV
LABELV $817
line 1125
;1124:				case GTS_BLUEOBELISK_ATTACKED: // Overload: blue obelisk is being attacked
;1125:					if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $407
line 1126
;1126:						CG_AddBufferedSound( cgs.media.yourBaseIsUnderAttackSound );
ADDRGP4 cgs+148772+1136
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1127
;1127:					}
line 1128
;1128:					break;
ADDRGP4 $407
JUMPV
LABELV $823
line 1132
;1129:#endif
;1130:
;1131:				case GTS_REDTEAM_SCORED:
;1132:					CG_AddBufferedSound(cgs.media.redScoredSound);
ADDRGP4 cgs+148772+1060
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1133
;1133:					break;
ADDRGP4 $407
JUMPV
LABELV $826
line 1135
;1134:				case GTS_BLUETEAM_SCORED:
;1135:					CG_AddBufferedSound(cgs.media.blueScoredSound);
ADDRGP4 cgs+148772+1064
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1136
;1136:					break;
ADDRGP4 $407
JUMPV
LABELV $829
line 1138
;1137:				case GTS_REDTEAM_TOOK_LEAD:
;1138:					CG_AddBufferedSound(cgs.media.redLeadsSound);
ADDRGP4 cgs+148772+1068
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1139
;1139:					break;
ADDRGP4 $407
JUMPV
LABELV $832
line 1141
;1140:				case GTS_BLUETEAM_TOOK_LEAD:
;1141:					CG_AddBufferedSound(cgs.media.blueLeadsSound);
ADDRGP4 cgs+148772+1072
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1142
;1142:					break;
ADDRGP4 $407
JUMPV
LABELV $835
line 1144
;1143:				case GTS_TEAMS_ARE_TIED:
;1144:					CG_AddBufferedSound( cgs.media.teamsTiedSound );
ADDRGP4 cgs+148772+1076
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1145
;1145:					break;
ADDRGP4 $407
JUMPV
LABELV $838
line 1148
;1146:#ifdef MISSIONPACK
;1147:				case GTS_KAMIKAZE:
;1148:					trap_S_StartLocalSound(cgs.media.kamikazeFarSound, CHAN_ANNOUNCER);
ADDRGP4 cgs+148772+824
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1149
;1149:					break;
line 1152
;1150:#endif
;1151:				default:
;1152:					break;
line 1154
;1153:			}
;1154:			break;
ADDRGP4 $407
JUMPV
LABELV $842
line 1160
;1155:		}
;1156:
;1157:	case EV_PAIN:
;1158:		// local player sounds are triggered in CG_CheckLocalSounds,
;1159:		// so ignore events on the player
;1160:		if ( cent->currentState.number != cg.snap->ps.clientNum ) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $407
line 1161
;1161:			CG_PainEvent( cent, es->eventParm );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_PainEvent
CALLV
pop
line 1162
;1162:		}
line 1163
;1163:		break;
ADDRGP4 $407
JUMPV
LABELV $846
line 1168
;1164:
;1165:	case EV_DEATH1:
;1166:	case EV_DEATH2:
;1167:	case EV_DEATH3:
;1168:		if ( CG_WaterLevel(cent) == 3 ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 112
ADDRGP4 CG_WaterLevel
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 3
NEI4 $847
line 1169
;1169:			trap_S_StartSound( NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, "*drown.wav") );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $849
ARGP4
ADDRLP4 116
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 116
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1170
;1170:		} else {
ADDRGP4 $407
JUMPV
LABELV $847
line 1171
;1171:			trap_S_StartSound( NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, va("*death%i.wav", event - EV_DEATH1 + 1)) );
ADDRGP4 $850
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 57
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 116
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 120
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 120
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1172
;1172:		}
line 1174
;1173:
;1174:		break;
ADDRGP4 $407
JUMPV
LABELV $851
line 1177
;1175:
;1176:	case EV_OBITUARY:
;1177:		CG_Obituary( es );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Obituary
CALLV
pop
line 1178
;1178:		break;
ADDRGP4 $407
JUMPV
LABELV $852
line 1184
;1179:
;1180:	//
;1181:	// powerup events
;1182:	//
;1183:	case EV_POWERUP_QUAD:
;1184:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $853
line 1185
;1185:			cg.powerupActive = PW_QUAD;
ADDRGP4 cg+125480
CNSTI4 1
ASGNI4
line 1186
;1186:			cg.powerupTime = cg.time;
ADDRGP4 cg+125484
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1187
;1187:		}
LABELV $853
line 1188
;1188:		trap_S_StartSound (NULL, es->number, CHAN_ITEM, cgs.media.quadSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+148772+620
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1189
;1189:		break;
ADDRGP4 $407
JUMPV
LABELV $861
line 1192
;1190:
;1191:	case EV_POWERUP_BATTLESUIT:
;1192:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $862
line 1193
;1193:			cg.powerupActive = PW_BATTLESUIT;
ADDRGP4 cg+125480
CNSTI4 2
ASGNI4
line 1194
;1194:			cg.powerupTime = cg.time;
ADDRGP4 cg+125484
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1195
;1195:		}
LABELV $862
line 1196
;1196:		trap_S_StartSound (NULL, es->number, CHAN_ITEM, cgs.media.protectSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+148772+1244
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1197
;1197:		break;
ADDRGP4 $407
JUMPV
LABELV $870
line 1200
;1198:
;1199:	case EV_POWERUP_REGEN:
;1200:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $871
line 1201
;1201:			cg.powerupActive = PW_REGEN;
ADDRGP4 cg+125480
CNSTI4 5
ASGNI4
line 1202
;1202:			cg.powerupTime = cg.time;
ADDRGP4 cg+125484
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1203
;1203:		}
LABELV $871
line 1204
;1204:		trap_S_StartSound (NULL, es->number, CHAN_ITEM, cgs.media.regenSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+148772+1240
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1205
;1205:		break;
ADDRGP4 $407
JUMPV
LABELV $879
line 1212
;1206:
;1207:	case EV_GIB_PLAYER:
;1208:		// don't play gib sound when using the kamikaze because it interferes
;1209:		// with the kamikaze sound, downside is that the gib sound will also
;1210:		// not be played when someone is gibbed while just carrying the kamikaze
;1211:#ifdef MISSIONPACK
;1212:		if ( !(es->eFlags & EF_KAMIKAZE) ) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
NEI4 $880
line 1213
;1213:			trap_S_StartSound( NULL, es->number, CHAN_BODY, cgs.media.gibSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+148772+872
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1214
;1214:		}
LABELV $880
line 1218
;1215:#else
;1216:		trap_S_StartSound( NULL, es->number, CHAN_BODY, cgs.media.gibSound );
;1217:#endif
;1218:		CG_GibPlayer( cent->lerpOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 CG_GibPlayer
CALLV
pop
line 1219
;1219:		break;
ADDRGP4 $407
JUMPV
LABELV $884
line 1222
;1220:
;1221:	case EV_STOPLOOPINGSOUND:
;1222:		trap_S_StopLoopingSound( es->number );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StopLoopingSound
CALLV
pop
line 1223
;1223:		es->loopSound = 0;
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 1224
;1224:		break;
ADDRGP4 $407
JUMPV
LABELV $885
line 1227
;1225:
;1226:	case EV_DEBUG_LINE:
;1227:		CG_Beam( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Beam
CALLV
pop
line 1228
;1228:		break;
ADDRGP4 $407
JUMPV
LABELV $406
line 1232
;1229:
;1230:
;1231:	default:
;1232:		CG_Error( "Unknown event: %i", event );
ADDRGP4 $396
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1233
;1233:		break;
LABELV $407
line 1235
;1234:	}
;1235:}
LABELV $393
endproc CG_EntityEvent 124 48
export CG_CheckEvents
proc CG_CheckEvents 8 12
line 1244
;1236:
;1237:
;1238:/*
;1239:==============
;1240:CG_CheckEvents
;1241:
;1242:==============
;1243:*/
;1244:void CG_CheckEvents( centity_t *cent ) {
line 1246
;1245:	// check for event-only entities
;1246:	if ( cent->currentState.eType > ET_EVENTS ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
LEI4 $889
line 1247
;1247:		if ( cent->previousEvent ) {
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
CNSTI4 0
EQI4 $891
line 1248
;1248:			return;	// already fired
ADDRGP4 $888
JUMPV
LABELV $891
line 1251
;1249:		}
;1250:		// if this is a player event set the entity number of the client entity number
;1251:		if ( cent->currentState.eFlags & EF_PLAYER_EVENT ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $893
line 1252
;1252:			cent->currentState.number = cent->currentState.otherEntityNum;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 1253
;1253:		}
LABELV $893
line 1255
;1254:
;1255:		cent->previousEvent = 1;
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
CNSTI4 1
ASGNI4
line 1257
;1256:
;1257:		cent->currentState.event = cent->currentState.eType - ET_EVENTS;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
SUBI4
ASGNI4
line 1258
;1258:	} else {
ADDRGP4 $890
JUMPV
LABELV $889
line 1260
;1259:		// check for events riding with another entity
;1260:		if ( cent->currentState.event == cent->previousEvent ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
NEI4 $895
line 1261
;1261:			return;
ADDRGP4 $888
JUMPV
LABELV $895
line 1263
;1262:		}
;1263:		cent->previousEvent = cent->currentState.event;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 428
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ASGNI4
line 1264
;1264:		if ( ( cent->currentState.event & ~EV_EVENT_BITS ) == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
CNSTI4 0
NEI4 $897
line 1265
;1265:			return;
ADDRGP4 $888
JUMPV
LABELV $897
line 1267
;1266:		}
;1267:	}
LABELV $890
line 1270
;1268:
;1269:	// calculate the position at exactly the frame time
;1270:	BG_EvaluateTrajectory( &cent->currentState.pos, cg.snap->serverTime, cent->lerpOrigin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 1271
;1271:	CG_SetEntitySoundPosition( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetEntitySoundPosition
CALLV
pop
line 1273
;1272:
;1273:	CG_EntityEvent( cent, cent->lerpOrigin, -1 );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 716
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 CG_EntityEvent
CALLV
pop
line 1274
;1274:}
LABELV $888
endproc CG_CheckEvents 8 12
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
LABELV $850
byte 1 42
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $849
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
LABELV $534
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
LABELV $523
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
LABELV $521
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
LABELV $519
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
LABELV $517
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $515
byte 1 110
byte 1 111
byte 1 0
align 1
LABELV $513
byte 1 121
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $511
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
LABELV $505
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
LABELV $463
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
LABELV $400
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $396
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $391
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
byte 1 103
byte 1 117
byte 1 114
byte 1 112
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $390
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
byte 1 103
byte 1 117
byte 1 114
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $385
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
LABELV $384
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
LABELV $381
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
LABELV $378
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
LABELV $314
byte 1 85
byte 1 115
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $313
byte 1 78
byte 1 111
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $303
byte 1 37
byte 1 115
byte 1 32
byte 1 94
byte 1 55
byte 1 100
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $291
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $286
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $285
byte 1 39
byte 1 115
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 97
byte 1 108
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $284
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $282
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 106
byte 1 117
byte 1 105
byte 1 99
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $280
byte 1 39
byte 1 115
byte 1 32
byte 1 75
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 101
byte 1 32
byte 1 98
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $279
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 0
align 1
LABELV $277
byte 1 39
byte 1 115
byte 1 32
byte 1 80
byte 1 114
byte 1 111
byte 1 120
byte 1 32
byte 1 77
byte 1 105
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $276
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 0
align 1
LABELV $274
byte 1 39
byte 1 115
byte 1 32
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
LABELV $273
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 115
byte 1 111
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $271
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $269
byte 1 39
byte 1 115
byte 1 32
byte 1 66
byte 1 70
byte 1 71
byte 1 0
align 1
LABELV $268
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $266
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 114
byte 1 111
byte 1 99
byte 1 117
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $264
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $261
byte 1 39
byte 1 115
byte 1 32
byte 1 112
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
LABELV $260
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $258
byte 1 97
byte 1 108
byte 1 109
byte 1 111
byte 1 115
byte 1 116
byte 1 32
byte 1 100
byte 1 111
byte 1 100
byte 1 103
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $256
byte 1 39
byte 1 115
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $254
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 114
byte 1 97
byte 1 112
byte 1 110
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $253
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 114
byte 1 101
byte 1 100
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $251
byte 1 39
byte 1 115
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $250
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $248
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 103
byte 1 117
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $246
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $244
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 112
byte 1 117
byte 1 109
byte 1 109
byte 1 101
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $242
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 117
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $221
byte 1 110
byte 1 111
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $213
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $210
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 37
byte 1 115
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $192
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $187
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $186
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $183
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $180
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $179
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $176
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $172
byte 1 115
byte 1 104
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $170
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $169
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $166
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $162
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $161
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $158
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $154
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $153
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $150
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $146
byte 1 103
byte 1 111
byte 1 101
byte 1 115
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $138
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 119
byte 1 114
byte 1 111
byte 1 110
byte 1 103
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $136
byte 1 115
byte 1 97
byte 1 119
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $134
byte 1 100
byte 1 111
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 102
byte 1 108
byte 1 105
byte 1 112
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 108
byte 1 97
byte 1 118
byte 1 97
byte 1 0
align 1
LABELV $132
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $130
byte 1 115
byte 1 97
byte 1 110
byte 1 107
byte 1 32
byte 1 108
byte 1 105
byte 1 107
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $128
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 113
byte 1 117
byte 1 105
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $126
byte 1 99
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $124
byte 1 115
byte 1 117
byte 1 105
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $119
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $118
byte 1 110
byte 1 0
align 1
LABELV $111
byte 1 67
byte 1 71
byte 1 95
byte 1 79
byte 1 98
byte 1 105
byte 1 116
byte 1 117
byte 1 97
byte 1 114
byte 1 121
byte 1 58
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
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
byte 1 0
align 1
LABELV $106
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $105
byte 1 37
byte 1 105
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $104
byte 1 37
byte 1 105
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $101
byte 1 37
byte 1 105
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $98
byte 1 37
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $95
byte 1 49
byte 1 51
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $92
byte 1 49
byte 1 50
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $89
byte 1 49
byte 1 49
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $86
byte 1 94
byte 1 51
byte 1 51
byte 1 114
byte 1 100
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $83
byte 1 94
byte 1 49
byte 1 50
byte 1 110
byte 1 100
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $80
byte 1 94
byte 1 52
byte 1 49
byte 1 115
byte 1 116
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $77
byte 1 0
align 1
LABELV $76
byte 1 84
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 0
