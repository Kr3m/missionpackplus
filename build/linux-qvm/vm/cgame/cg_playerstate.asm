export CG_CheckAmmo
code
proc CG_CheckAmmo 20 8
file "../../../../code/cgame/cg_playerstate.c"
line 17
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_playerstate.c -- this file acts on changes in a new playerState_t
;4:// With normal play, this will be done after local prediction, but when
;5:// following another player or playing back a demo, it will be checked
;6:// when the snapshot transitions like all the other entities
;7:
;8:#include "cg_local.h"
;9:
;10:/*
;11:==============
;12:CG_CheckAmmo
;13:
;14:If the ammo has gone low enough to generate the warning, play a sound
;15:==============
;16:*/
;17:void CG_CheckAmmo( void ) {
line 24
;18:	int		i;
;19:	int		total;
;20:	int		previous;
;21:	int		weapons;
;22:
;23:	// see about how many seconds of ammo we have remaining
;24:	weapons = cg.snap->ps.stats[ STAT_WEAPONS ];
ADDRLP4 8
ADDRGP4 cg+36
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
ASGNI4
line 25
;25:	total = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 26
;26:	for ( i = WP_MACHINEGUN ; i < WP_NUM_WEAPONS ; i++ ) {
ADDRLP4 0
CNSTI4 2
ASGNI4
LABELV $74
line 27
;27:		if ( ! ( weapons & ( 1 << i ) ) ) {
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $78
line 28
;28:			continue;
ADDRGP4 $75
JUMPV
LABELV $78
line 30
;29:		}
;30:		switch ( i ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $80
ADDRLP4 0
INDIRI4
CNSTI4 12
GTI4 $80
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $85-12
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $85
address $82
address $82
address $82
address $80
address $82
address $80
address $80
address $80
address $80
address $82
code
LABELV $82
line 38
;31:		case WP_ROCKET_LAUNCHER:
;32:		case WP_GRENADE_LAUNCHER:
;33:		case WP_RAILGUN:
;34:		case WP_SHOTGUN:
;35:#ifdef MISSIONPACK
;36:		case WP_PROX_LAUNCHER:
;37:#endif
;38:			total += cg.snap->ps.ammo[i] * 1000;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 420
ADDP4
ADDP4
INDIRI4
CNSTI4 1000
MULI4
ADDI4
ASGNI4
line 39
;39:			break;
ADDRGP4 $81
JUMPV
LABELV $80
line 41
;40:		default:
;41:			total += cg.snap->ps.ammo[i] * 200;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 420
ADDP4
ADDP4
INDIRI4
CNSTI4 200
MULI4
ADDI4
ASGNI4
line 42
;42:			break;
LABELV $81
line 44
;43:		}
;44:		if ( total >= 5000 ) {
ADDRLP4 4
INDIRI4
CNSTI4 5000
LTI4 $87
line 45
;45:			cg.lowAmmoWarning = 0;
ADDRGP4 cg+125464
CNSTI4 0
ASGNI4
line 46
;46:			return;
ADDRGP4 $72
JUMPV
LABELV $87
line 48
;47:		}
;48:	}
LABELV $75
line 26
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 14
LTI4 $74
line 50
;49:
;50:	previous = cg.lowAmmoWarning;
ADDRLP4 12
ADDRGP4 cg+125464
INDIRI4
ASGNI4
line 52
;51:
;52:	if ( total == 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $91
line 53
;53:		cg.lowAmmoWarning = 2;
ADDRGP4 cg+125464
CNSTI4 2
ASGNI4
line 54
;54:	} else {
ADDRGP4 $92
JUMPV
LABELV $91
line 55
;55:		cg.lowAmmoWarning = 1;
ADDRGP4 cg+125464
CNSTI4 1
ASGNI4
line 56
;56:	}
LABELV $92
line 59
;57:
;58:	// play a sound on transitions
;59:	if ( cg.lowAmmoWarning != previous ) {
ADDRGP4 cg+125464
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $95
line 60
;60:		trap_S_StartLocalSound( cgs.media.noAmmoSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+148772+896
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 61
;61:	}
LABELV $95
line 62
;62:}
LABELV $72
endproc CG_CheckAmmo 20 8
export CG_DamageFeedback
proc CG_DamageFeedback 80 16
line 70
;63:
;64:
;65:/*
;66:==============
;67:CG_DamageFeedback
;68:==============
;69:*/
;70:void CG_DamageFeedback( int yawByte, int pitchByte, int damage ) {
line 86
;71:	float		left, front, up;
;72:	float		kick;
;73:	int			health;
;74:	int			attacker;
;75:	float		scale;
;76:	vec3_t		dir;
;77:	vec3_t		angles;
;78:	float		dist;
;79:	float		yaw, pitch;
;80:	const char	*info;
;81:
;82:	// show the attacking player's head and name in corner
;83:	// but only if client is valid
;84:
;85:	//attacker = cg.predictedPlayerState.persistant[PERS_ATTACKER]; ?
;86:	attacker = cg.snap->ps.persistant[PERS_ATTACKER]; 
ADDRLP4 16
ADDRGP4 cg+36
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
ASGNI4
line 88
;87:
;88:	if ( (unsigned)attacker < MAX_CLIENTS && attacker != cg.snap->ps.clientNum ) {
ADDRLP4 16
INDIRI4
CVIU4 4
CNSTU4 64
GEU4 $102
ADDRLP4 16
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $102
line 90
;89:		// dont do it when cg_draw2d = 0 ?
;90:		info = CG_ConfigString( CS_PLAYERS + attacker );
ADDRLP4 16
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 72
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 52
ADDRLP4 72
INDIRP4
ASGNP4
line 91
;91:		if ( *info ) {
ADDRLP4 52
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $105
line 92
;92:			BG_CleanName( Info_ValueForKey( info, "n" ), cg.attackerName, sizeof( cg.attackerName ), "???" );
ADDRLP4 52
INDIRP4
ARGP4
ADDRGP4 $107
ARGP4
ADDRLP4 76
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 cg+125488
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $110
ARGP4
ADDRGP4 BG_CleanName
CALLV
pop
line 93
;93:			cg.attackerClientNum = attacker;
ADDRGP4 cg+125520
ADDRLP4 16
INDIRI4
ASGNI4
line 94
;94:			cg.attackerTime = cg.time;
ADDRGP4 cg+125524
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 95
;95:		}
LABELV $105
line 96
;96:	}
LABELV $102
line 99
;97:
;98:	// the lower on health you are, the greater the view kick will be
;99:	health = cg.snap->ps.stats[STAT_HEALTH];
ADDRLP4 24
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ASGNI4
line 100
;100:	if ( health < 40 ) {
ADDRLP4 24
INDIRI4
CNSTI4 40
GEI4 $115
line 101
;101:		scale = 1;
ADDRLP4 32
CNSTF4 1065353216
ASGNF4
line 102
;102:	} else {
ADDRGP4 $116
JUMPV
LABELV $115
line 103
;103:		scale = 40.0 / health;
ADDRLP4 32
CNSTF4 1109393408
ADDRLP4 24
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 104
;104:	}
LABELV $116
line 105
;105:	kick = damage * scale;
ADDRLP4 12
ADDRFP4 8
INDIRI4
CVIF4 4
ADDRLP4 32
INDIRF4
MULF4
ASGNF4
line 107
;106:
;107:	if (kick < 5)
ADDRLP4 12
INDIRF4
CNSTF4 1084227584
GEF4 $117
line 108
;108:		kick = 5;
ADDRLP4 12
CNSTF4 1084227584
ASGNF4
LABELV $117
line 109
;109:	if (kick > 10)
ADDRLP4 12
INDIRF4
CNSTF4 1092616192
LEF4 $119
line 110
;110:		kick = 10;
ADDRLP4 12
CNSTF4 1092616192
ASGNF4
LABELV $119
line 113
;111:
;112:	// if yaw and pitch are both 255, make the damage always centered (falling, etc)
;113:	if ( yawByte == 255 && pitchByte == 255 ) {
ADDRFP4 0
INDIRI4
CNSTI4 255
NEI4 $121
ADDRFP4 4
INDIRI4
CNSTI4 255
NEI4 $121
line 114
;114:		cg.damageX = 0;
ADDRGP4 cg+125812
CNSTF4 0
ASGNF4
line 115
;115:		cg.damageY = 0;
ADDRGP4 cg+125816
CNSTF4 0
ASGNF4
line 116
;116:		cg.v_dmg_roll = 0;
ADDRGP4 cg+125860
CNSTF4 0
ASGNF4
line 117
;117:		cg.v_dmg_pitch = -kick;
ADDRGP4 cg+125856
ADDRLP4 12
INDIRF4
NEGF4
ASGNF4
line 118
;118:	} else {
ADDRGP4 $122
JUMPV
LABELV $121
line 120
;119:		// positional
;120:		pitch = pitchByte / 255.0 * 360;
ADDRLP4 64
ADDRFP4 4
INDIRI4
CVIF4 4
CNSTF4 1068807349
MULF4
ASGNF4
line 121
;121:		yaw = yawByte / 255.0 * 360;
ADDRLP4 60
ADDRFP4 0
INDIRI4
CVIF4 4
CNSTF4 1068807349
MULF4
ASGNF4
line 123
;122:
;123:		angles[PITCH] = pitch;
ADDRLP4 36
ADDRLP4 64
INDIRF4
ASGNF4
line 124
;124:		angles[YAW] = yaw;
ADDRLP4 36+4
ADDRLP4 60
INDIRF4
ASGNF4
line 125
;125:		angles[ROLL] = 0;
ADDRLP4 36+8
CNSTF4 0
ASGNF4
line 127
;126:
;127:		AngleVectors( angles, dir, NULL, NULL );
ADDRLP4 36
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
line 128
;128:		VectorSubtract( vec3_origin, dir, dir );
ADDRLP4 0
ADDRGP4 vec3_origin
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 vec3_origin+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 vec3_origin+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 130
;129:
;130:		front = DotProduct (dir, cg.refdef.viewaxis[0] );
ADDRLP4 20
ADDRLP4 0
INDIRF4
ADDRGP4 cg+109056+36
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRGP4 cg+109056+36+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+109056+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 131
;131:		left = DotProduct (dir, cg.refdef.viewaxis[1] );
ADDRLP4 28
ADDRLP4 0
INDIRF4
ADDRGP4 cg+109056+36+12
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRGP4 cg+109056+36+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+109056+36+12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 132
;132:		up = DotProduct (dir, cg.refdef.viewaxis[2] );
ADDRLP4 56
ADDRLP4 0
INDIRF4
ADDRGP4 cg+109056+36+24
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRGP4 cg+109056+36+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+109056+36+24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 134
;133:
;134:		dir[0] = front;
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 135
;135:		dir[1] = left;
ADDRLP4 0+4
ADDRLP4 28
INDIRF4
ASGNF4
line 136
;136:		dir[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 137
;137:		dist = VectorLength( dir );
ADDRLP4 0
ARGP4
ADDRLP4 72
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 48
ADDRLP4 72
INDIRF4
ASGNF4
line 138
;138:		if ( dist < 0.1 ) {
ADDRLP4 48
INDIRF4
CNSTF4 1036831949
GEF4 $173
line 139
;139:			dist = 0.1f;
ADDRLP4 48
CNSTF4 1036831949
ASGNF4
line 140
;140:		}
LABELV $173
line 142
;141:
;142:		cg.v_dmg_roll = kick * left;
ADDRGP4 cg+125860
ADDRLP4 12
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 144
;143:		
;144:		cg.v_dmg_pitch = -kick * front;
ADDRGP4 cg+125856
ADDRLP4 12
INDIRF4
NEGF4
ADDRLP4 20
INDIRF4
MULF4
ASGNF4
line 146
;145:
;146:		if ( front <= 0.1 ) {
ADDRLP4 20
INDIRF4
CNSTF4 1036831949
GTF4 $177
line 147
;147:			front = 0.1f;
ADDRLP4 20
CNSTF4 1036831949
ASGNF4
line 148
;148:		}
LABELV $177
line 149
;149:		cg.damageX = -left / front;
ADDRGP4 cg+125812
ADDRLP4 28
INDIRF4
NEGF4
ADDRLP4 20
INDIRF4
DIVF4
ASGNF4
line 150
;150:		cg.damageY = up / dist;
ADDRGP4 cg+125816
ADDRLP4 56
INDIRF4
ADDRLP4 48
INDIRF4
DIVF4
ASGNF4
line 151
;151:	}
LABELV $122
line 154
;152:
;153:	// clamp the position
;154:	if ( cg.damageX > 1.0 ) {
ADDRGP4 cg+125812
INDIRF4
CNSTF4 1065353216
LEF4 $181
line 155
;155:		cg.damageX = 1.0;
ADDRGP4 cg+125812
CNSTF4 1065353216
ASGNF4
line 156
;156:	}
LABELV $181
line 157
;157:	if ( cg.damageX < - 1.0 ) {
ADDRGP4 cg+125812
INDIRF4
CNSTF4 3212836864
GEF4 $185
line 158
;158:		cg.damageX = -1.0;
ADDRGP4 cg+125812
CNSTF4 3212836864
ASGNF4
line 159
;159:	}
LABELV $185
line 161
;160:
;161:	if ( cg.damageY > 1.0 ) {
ADDRGP4 cg+125816
INDIRF4
CNSTF4 1065353216
LEF4 $189
line 162
;162:		cg.damageY = 1.0;
ADDRGP4 cg+125816
CNSTF4 1065353216
ASGNF4
line 163
;163:	}
LABELV $189
line 164
;164:	if ( cg.damageY < - 1.0 ) {
ADDRGP4 cg+125816
INDIRF4
CNSTF4 3212836864
GEF4 $193
line 165
;165:		cg.damageY = -1.0;
ADDRGP4 cg+125816
CNSTF4 3212836864
ASGNF4
line 166
;166:	}
LABELV $193
line 169
;167:
;168:	// don't let the screen flashes vary as much
;169:	if ( kick > 10 ) {
ADDRLP4 12
INDIRF4
CNSTF4 1092616192
LEF4 $197
line 170
;170:		kick = 10;
ADDRLP4 12
CNSTF4 1092616192
ASGNF4
line 171
;171:	}
LABELV $197
line 172
;172:	cg.damageValue = kick;
ADDRGP4 cg+125820
ADDRLP4 12
INDIRF4
ASGNF4
line 173
;173:	cg.v_dmg_time = cg.time + DAMAGE_TIME;
ADDRGP4 cg+125852
ADDRGP4 cg+107604
INDIRI4
CNSTI4 500
ADDI4
CVIF4 4
ASGNF4
line 174
;174:	cg.damageTime = cg.snap->serverTime;
ADDRGP4 cg+125808
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 175
;175:}
LABELV $100
endproc CG_DamageFeedback 80 16
export CG_Respawn
proc CG_Respawn 0 0
line 185
;176:
;177:
;178:/*
;179:================
;180:CG_Respawn
;181:
;182:A respawn happened this snapshot
;183:================
;184:*/
;185:void CG_Respawn( void ) {
line 187
;186:	// no error decay on player movement
;187:	cg.thisFrameTeleport = qtrue;
ADDRGP4 cg+107592
CNSTI4 1
ASGNI4
line 190
;188:
;189:	// display weapons available
;190:	cg.weaponSelectTime = cg.time;
ADDRGP4 cg+125796
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 193
;191:
;192:	// select the weapon the server says we are using
;193:	cg.weaponSelect = cg.snap->ps.weapon;
ADDRGP4 cg+108956
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
line 195
;194:
;195:	cg.timeResidual = cg.snap->ps.commandTime + 1000;
ADDRGP4 cg+157020
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 196
;196:}
LABELV $204
endproc CG_Respawn 0 0
proc CG_CheckPlayerstateEvents 40 12
line 207
;197:
;198:
;199:/*
;200:==============
;201:CG_CheckPlayerstateEvents
;202:==============
;203:*/
;204:extern int		eventStack;
;205:extern int		eventParm2[ MAX_PREDICTED_EVENTS ];
;206:
;207:static void CG_CheckPlayerstateEvents( const playerState_t *ps, const playerState_t *ops ) {
line 212
;208:	int			i, n;
;209:	int			event;
;210:	centity_t	*cent;
;211:
;212:	if ( ps->externalEvent && ps->externalEvent != ops->externalEvent ) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
CNSTI4 0
EQI4 $213
ADDRLP4 16
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
EQI4 $213
line 213
;213:		cent = &cg_entities[ ps->clientNum ];
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 214
;214:		cent->currentState.event = ps->externalEvent;
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
ASGNI4
line 215
;215:		cent->currentState.eventParm = ps->externalEventParm;
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 132
ADDP4
INDIRI4
ASGNI4
line 216
;216:		CG_EntityEvent( cent, cent->lerpOrigin, -1 );
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
line 217
;217:	}
LABELV $213
line 219
;218:
;219:	cent = &cg.predictedPlayerEntity; // cg_entities[ ps->clientNum ];
ADDRLP4 4
ADDRGP4 cg+108104
ASGNP4
line 220
;220:	n = eventStack - MAX_PS_EVENTS;
ADDRLP4 12
ADDRGP4 eventStack
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 221
;221:	if ( n < 0 ) n  = 0;
ADDRLP4 12
INDIRI4
CNSTI4 0
GEI4 $216
ADDRLP4 12
CNSTI4 0
ASGNI4
LABELV $216
line 223
;222:	// go through the predictable events buffer
;223:	for ( i = ps->eventSequence - MAX_PS_EVENTS ; i < ps->eventSequence ; i++ ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
ADDRGP4 $221
JUMPV
LABELV $218
line 225
;224:		// if we have a new predictable event
;225:		if ( i >= ops->eventSequence
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
GEI4 $224
ADDRLP4 0
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 2
SUBI4
LEI4 $222
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
EQI4 $222
LABELV $224
line 228
;226:			// or the server told us to play another event instead of a predicted event we already issued
;227:			// or something the server told us changed our prediction causing a different event
;228:			|| (i > ops->eventSequence - MAX_PS_EVENTS && ps->events[i & (MAX_PS_EVENTS-1)] != ops->events[i & (MAX_PS_EVENTS-1)]) ) {
line 230
;229:
;230:			event = ps->events[ i & (MAX_PS_EVENTS-1) ];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ASGNI4
line 231
;231:			if ( event == EV_NONE ) // ignore empty events
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $225
line 232
;232:				continue;
ADDRGP4 $219
JUMPV
LABELV $225
line 233
;233:			cent->currentState.event = event;
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 234
;234:			cent->currentState.eventParm = ps->eventParms[ i & (MAX_PS_EVENTS-1) ];
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDP4
INDIRI4
ASGNI4
line 236
;235:
;236:			CG_EntityEvent( cent, cent->lerpOrigin, eventParm2[ n++ ] );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 28
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 12
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 eventParm2
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_EntityEvent
CALLV
pop
line 238
;237:
;238:			cg.predictableEvents[ i & (MAX_PREDICTED_EVENTS-1) ] = event;
ADDRLP4 0
INDIRI4
CNSTI4 15
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cg+108868
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 240
;239:
;240:			cg.eventSequence++;
ADDRLP4 36
ADDRGP4 cg+108864
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 241
;241:		}
LABELV $222
line 242
;242:	}
LABELV $219
line 223
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $221
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
LTI4 $218
line 243
;243:}
LABELV $212
endproc CG_CheckPlayerstateEvents 40 12
proc pushReward 4 0
line 251
;244:
;245:
;246:/*
;247:==================
;248:pushReward
;249:==================
;250:*/
;251:static void pushReward( sfxHandle_t sfx, qhandle_t shader, int rewardCount ) {
line 252
;252:	if ( cg.rewardStack < (MAX_REWARDSTACK-1 )) {
ADDRGP4 cg+125532
INDIRI4
CNSTI4 9
GEI4 $230
line 253
;253:		cg.rewardStack++;
ADDRLP4 0
ADDRGP4 cg+125532
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 254
;254:		cg.rewardSound[cg.rewardStack] = sfx;
ADDRGP4 cg+125532
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+125620
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 255
;255:		cg.rewardShader[cg.rewardStack] = shader;
ADDRGP4 cg+125532
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+125580
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 256
;256:		cg.rewardCount[cg.rewardStack] = rewardCount;
ADDRGP4 cg+125532
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+125540
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 257
;257:	}
LABELV $230
line 258
;258:}
LABELV $229
endproc pushReward 4 0
export CG_CheckLocalSounds
proc CG_CheckLocalSounds 32 12
line 266
;259:
;260:
;261:/*
;262:==================
;263:CG_CheckLocalSounds
;264:==================
;265:*/
;266:void CG_CheckLocalSounds( playerState_t *ps, playerState_t *ops ) {
line 274
;267:#ifdef MISSIONPACK
;268:	int health, armor;
;269:#endif
;270:	int	highScore, reward;
;271:	sfxHandle_t sfx;
;272:
;273:	// don't play the sounds if the player just changed teams
;274:	if ( ps->persistant[PERS_TEAM] != ops->persistant[PERS_TEAM] ) {
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
EQI4 $241
line 275
;275:		return;
ADDRGP4 $240
JUMPV
LABELV $241
line 279
;276:	}
;277:
;278:	// hit changes
;279:	if ( ps->persistant[PERS_HITS] > ops->persistant[PERS_HITS] ) {
ADDRFP4 0
INDIRP4
CNSTI4 252
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 252
ADDP4
INDIRI4
LEI4 $243
line 281
;280:#ifdef MISSIONPACK
;281:		armor  = ps->persistant[PERS_ATTACKEE_ARMOR] & 0xff;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 282
;282:		health = ps->persistant[PERS_ATTACKEE_ARMOR] >> 8;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 8
RSHI4
ASGNI4
line 283
;283:		if (armor > 50 ) {
ADDRLP4 12
INDIRI4
CNSTI4 50
LEI4 $245
line 284
;284:			trap_S_StartLocalSound( cgs.media.hitSoundHighArmor, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+148772+960
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 285
;285:		} else if (armor || health > 100) {
ADDRGP4 $244
JUMPV
LABELV $245
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $251
ADDRLP4 16
INDIRI4
CNSTI4 100
LEI4 $249
LABELV $251
line 286
;286:			trap_S_StartLocalSound( cgs.media.hitSoundLowArmor, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+148772+964
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 287
;287:		} else {
ADDRGP4 $244
JUMPV
LABELV $249
line 288
;288:			trap_S_StartLocalSound( cgs.media.hitSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+148772+940
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 289
;289:		}
line 314
;290:#else
;291:		if ( cg_hitSounds.integer > 0 && (ps->persistant[PERS_ATTACKEE_ARMOR] & 0xFF00) == 0 )
;292:		{
;293:			// high byte of PERS_ATTACKEE_ARMOR is target->health in vq3/ta i.e. it is always non-zero
;294:			// so we will use this value to filter legacy data from our new hitsounds where it is always 0
;295:			int damage, index;
;296:			damage = ps->persistant[PERS_ATTACKEE_ARMOR] & 0xFF;
;297:
;298:			// damage value is already scaled by STAT_MAX_HEALTH on server side
;299:			if ( damage > 75 ) index = 3;
;300:			else if ( damage > 50 ) index = 2;
;301:			else if ( damage > 25 ) index = 1;
;302:			else index = 0;
;303:
;304:			if ( cg_hitSounds.integer > 1 ) // reversed: higher damage - higher tone
;305:				index = 3 - index;
;306:
;307:			trap_S_StartLocalSound( cgs.media.hitSounds[ index ], CHAN_LOCAL_SOUND );
;308:		} 
;309:		else
;310:		{
;311:			trap_S_StartLocalSound( cgs.media.hitSound, CHAN_LOCAL_SOUND );
;312:		}
;313:#endif
;314:	} else if ( ps->persistant[PERS_HITS] < ops->persistant[PERS_HITS] ) {
ADDRGP4 $244
JUMPV
LABELV $243
ADDRFP4 0
INDIRP4
CNSTI4 252
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 252
ADDP4
INDIRI4
GEI4 $256
line 315
;315:		trap_S_StartLocalSound( cgs.media.hitTeamSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+148772+968
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 316
;316:	}
LABELV $256
LABELV $244
line 319
;317:
;318:	// health changes of more than -1 should make pain sounds
;319:	if ( ps->stats[STAT_HEALTH] < ops->stats[STAT_HEALTH] - 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 1
SUBI4
GEI4 $260
line 320
;320:		if ( ps->stats[STAT_HEALTH] > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $262
line 321
;321:			CG_PainEvent( &cg.predictedPlayerEntity, ps->stats[STAT_HEALTH] );
ADDRGP4 cg+108104
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_PainEvent
CALLV
pop
line 322
;322:		}
LABELV $262
line 323
;323:	}
LABELV $260
line 326
;324:
;325:	// if we are going into the intermission, don't start any voices
;326:	if ( cg.intermissionStarted ) {
ADDRGP4 cg+24
INDIRI4
CNSTI4 0
EQI4 $265
line 327
;327:		return;
ADDRGP4 $240
JUMPV
LABELV $265
line 331
;328:	}
;329:
;330:	// reward sounds
;331:	reward = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 332
;332:	if (ps->persistant[PERS_CAPTURES] != ops->persistant[PERS_CAPTURES]) {
ADDRFP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
EQI4 $268
line 333
;333:		pushReward(cgs.media.captureAwardSound, cgs.media.medalCapture, ps->persistant[PERS_CAPTURES]);
ADDRGP4 cgs+148772+1056
INDIRI4
ARGI4
ADDRGP4 cgs+148772+616
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ARGI4
ADDRGP4 pushReward
CALLV
pop
line 334
;334:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 336
;335:		//Com_Printf("capture\n");
;336:	}
LABELV $268
line 337
;337:	if (ps->persistant[PERS_IMPRESSIVE_COUNT] != ops->persistant[PERS_IMPRESSIVE_COUNT]) {
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
EQI4 $274
line 339
;338:#ifdef MISSIONPACK
;339:		if (ps->persistant[PERS_IMPRESSIVE_COUNT] == 1) {
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
CNSTI4 1
NEI4 $276
line 340
;340:			sfx = cgs.media.firstImpressiveSound;
ADDRLP4 4
ADDRGP4 cgs+148772+996
INDIRI4
ASGNI4
line 341
;341:		} else {
ADDRGP4 $277
JUMPV
LABELV $276
line 342
;342:			sfx = cgs.media.impressiveSound;
ADDRLP4 4
ADDRGP4 cgs+148772+972
INDIRI4
ASGNI4
line 343
;343:		}
LABELV $277
line 347
;344:#else
;345:		sfx = cgs.media.impressiveSound;
;346:#endif
;347:		pushReward(sfx, cgs.media.medalImpressive, ps->persistant[PERS_IMPRESSIVE_COUNT]);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 cgs+148772+596
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
ARGI4
ADDRGP4 pushReward
CALLV
pop
line 348
;348:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 350
;349:		//Com_Printf("impressive\n");
;350:	}
LABELV $274
line 351
;351:	if (ps->persistant[PERS_EXCELLENT_COUNT] != ops->persistant[PERS_EXCELLENT_COUNT]) {
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
EQI4 $284
line 353
;352:#ifdef MISSIONPACK
;353:		if (ps->persistant[PERS_EXCELLENT_COUNT] == 1) {
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
CNSTI4 1
NEI4 $286
line 354
;354:			sfx = cgs.media.firstExcellentSound;
ADDRLP4 4
ADDRGP4 cgs+148772+1000
INDIRI4
ASGNI4
line 355
;355:		} else {
ADDRGP4 $287
JUMPV
LABELV $286
line 356
;356:			sfx = cgs.media.excellentSound;
ADDRLP4 4
ADDRGP4 cgs+148772+976
INDIRI4
ASGNI4
line 357
;357:		}
LABELV $287
line 361
;358:#else
;359:		sfx = cgs.media.excellentSound;
;360:#endif
;361:		pushReward(sfx, cgs.media.medalExcellent, ps->persistant[PERS_EXCELLENT_COUNT]);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 cgs+148772+600
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
ARGI4
ADDRGP4 pushReward
CALLV
pop
line 362
;362:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 364
;363:		//Com_Printf("excellent\n");
;364:	}
LABELV $284
line 365
;365:	if (ps->persistant[PERS_GAUNTLET_FRAG_COUNT] != ops->persistant[PERS_GAUNTLET_FRAG_COUNT]) {
ADDRFP4 0
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
EQI4 $294
line 367
;366:#ifdef MISSIONPACK
;367:		if (ps->persistant[PERS_GAUNTLET_FRAG_COUNT] == 1) {
ADDRFP4 0
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
CNSTI4 1
NEI4 $296
line 368
;368:			sfx = cgs.media.firstHumiliationSound;
ADDRLP4 4
ADDRGP4 cgs+148772+1004
INDIRI4
ASGNI4
line 369
;369:		} else {
ADDRGP4 $297
JUMPV
LABELV $296
line 370
;370:			sfx = cgs.media.humiliationSound;
ADDRLP4 4
ADDRGP4 cgs+148772+984
INDIRI4
ASGNI4
line 371
;371:		}
LABELV $297
line 375
;372:#else
;373:		sfx = cgs.media.humiliationSound;
;374:#endif
;375:		pushReward(sfx, cgs.media.medalGauntlet, ps->persistant[PERS_GAUNTLET_FRAG_COUNT]);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 cgs+148772+604
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
ARGI4
ADDRGP4 pushReward
CALLV
pop
line 376
;376:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 378
;377:		//Com_Printf("guantlet frag\n");
;378:	}
LABELV $294
line 379
;379:	if (ps->persistant[PERS_DEFEND_COUNT] != ops->persistant[PERS_DEFEND_COUNT]) {
ADDRFP4 0
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
EQI4 $304
line 380
;380:		pushReward(cgs.media.defendSound, cgs.media.medalDefend, ps->persistant[PERS_DEFEND_COUNT]);
ADDRGP4 cgs+148772+992
INDIRI4
ARGI4
ADDRGP4 cgs+148772+608
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRGP4 pushReward
CALLV
pop
line 381
;381:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 383
;382:		//Com_Printf("defend\n");
;383:	}
LABELV $304
line 384
;384:	if (ps->persistant[PERS_ASSIST_COUNT] != ops->persistant[PERS_ASSIST_COUNT]) {
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
EQI4 $310
line 385
;385:		pushReward(cgs.media.assistSound, cgs.media.medalAssist, ps->persistant[PERS_ASSIST_COUNT]);
ADDRGP4 cgs+148772+988
INDIRI4
ARGI4
ADDRGP4 cgs+148772+612
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
ARGI4
ADDRGP4 pushReward
CALLV
pop
line 386
;386:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 388
;387:		//Com_Printf("assist\n");
;388:	}
LABELV $310
line 390
;389:	// if any of the player event bits changed
;390:	if (ps->persistant[PERS_PLAYEREVENTS] != ops->persistant[PERS_PLAYEREVENTS]) {
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
EQI4 $316
line 391
;391:		if ((ps->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_DENIEDREWARD) !=
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRFP4 4
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
CNSTI4 1
BANDI4
EQI4 $318
line 392
;392:				(ops->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_DENIEDREWARD)) {
line 393
;393:			trap_S_StartLocalSound( cgs.media.deniedSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+148772+980
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 394
;394:		}
ADDRGP4 $319
JUMPV
LABELV $318
line 395
;395:		else if ((ps->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_GAUNTLETREWARD) !=
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
CNSTI4 2
BANDI4
ADDRFP4 4
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
CNSTI4 2
BANDI4
EQI4 $322
line 396
;396:				(ops->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_GAUNTLETREWARD)) {
line 397
;397:			trap_S_StartLocalSound( cgs.media.humiliationSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+148772+984
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 398
;398:		}
ADDRGP4 $323
JUMPV
LABELV $322
line 399
;399:		else if ((ps->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_HOLYSHIT) !=
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
CNSTI4 4
BANDI4
ADDRFP4 4
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
CNSTI4 4
BANDI4
EQI4 $326
line 400
;400:				(ops->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_HOLYSHIT)) {
line 401
;401:			trap_S_StartLocalSound( cgs.media.holyShitSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+148772+1140
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 402
;402:		}
LABELV $326
LABELV $323
LABELV $319
line 403
;403:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 404
;404:	}
LABELV $316
line 407
;405:
;406:	// check for flag pickup
;407:	if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $330
line 408
;408:		if ((ps->powerups[PW_REDFLAG] != ops->powerups[PW_REDFLAG] && ps->powerups[PW_REDFLAG]) ||
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
EQI4 $336
ADDRLP4 20
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
NEI4 $337
LABELV $336
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
EQI4 $338
ADDRLP4 24
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
NEI4 $337
LABELV $338
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
EQI4 $333
ADDRLP4 28
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $333
LABELV $337
line 411
;409:			(ps->powerups[PW_BLUEFLAG] != ops->powerups[PW_BLUEFLAG] && ps->powerups[PW_BLUEFLAG]) ||
;410:			(ps->powerups[PW_NEUTRALFLAG] != ops->powerups[PW_NEUTRALFLAG] && ps->powerups[PW_NEUTRALFLAG]) )
;411:		{
line 412
;412:			trap_S_StartLocalSound( cgs.media.youHaveFlagSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+148772+1132
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 413
;413:		}
LABELV $333
line 414
;414:	}
LABELV $330
line 417
;415:
;416:	// lead changes
;417:	if (!reward) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $341
line 419
;418:		//
;419:		if ( !cg.warmup ) {
ADDRGP4 cg+125768
INDIRI4
CNSTI4 0
NEI4 $343
line 421
;420:			// never play lead changes during warmup
;421:			if ( ps->persistant[PERS_RANK] != ops->persistant[PERS_RANK] ) {
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
EQI4 $346
line 422
;422:				if ( cgs.gametype < GT_TEAM) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
GEI4 $348
line 423
;423:					if (  ps->persistant[PERS_RANK] == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 0
NEI4 $351
line 424
;424:						CG_AddBufferedSound(cgs.media.takenLeadSound);
ADDRGP4 cgs+148772+1008
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 425
;425:					} else if ( ps->persistant[PERS_RANK] == RANK_TIED_FLAG ) {
ADDRGP4 $352
JUMPV
LABELV $351
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 16384
NEI4 $355
line 426
;426:						CG_AddBufferedSound(cgs.media.tiedLeadSound);
ADDRGP4 cgs+148772+1012
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 427
;427:					} else if ( ( ops->persistant[PERS_RANK] & ~RANK_TIED_FLAG ) == 0 ) {
ADDRGP4 $356
JUMPV
LABELV $355
ADDRFP4 4
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 -16385
BANDI4
CNSTI4 0
NEI4 $359
line 428
;428:						CG_AddBufferedSound(cgs.media.lostLeadSound);
ADDRGP4 cgs+148772+1016
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 429
;429:					}
LABELV $359
LABELV $356
LABELV $352
line 430
;430:				}
LABELV $348
line 431
;431:			}
LABELV $346
line 432
;432:		}
LABELV $343
line 433
;433:	}
LABELV $341
line 436
;434:
;435:	// timelimit warnings
;436:	if ( cgs.timelimit > 0 && !cg.warmup && cg.warmupFightSound < cg.time ) {
ADDRGP4 cgs+31500
INDIRI4
CNSTI4 0
LEI4 $363
ADDRGP4 cg+125768
INDIRI4
CNSTI4 0
NEI4 $363
ADDRGP4 cg+125776
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $363
line 439
;437:		int		msec;
;438:
;439:		msec = cg.time - cgs.levelStartTime;
ADDRLP4 20
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+34820
INDIRI4
SUBI4
ASGNI4
line 440
;440:		if ( !( cg.timelimitWarnings & 4 ) && msec > ( cgs.timelimit * 60 + 2 ) * 1000 ) {
ADDRGP4 cg+107616
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $371
ADDRLP4 20
INDIRI4
ADDRGP4 cgs+31500
INDIRI4
CNSTI4 60
MULI4
CNSTI4 1000
MULI4
CNSTI4 2000
ADDI4
LEI4 $371
line 441
;441:			cg.timelimitWarnings |= 1 | 2 | 4;
ADDRLP4 24
ADDRGP4 cg+107616
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 7
BORI4
ASGNI4
line 442
;442:			trap_S_StartLocalSound( cgs.media.suddenDeathSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+148772+924
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 443
;443:		}
ADDRGP4 $372
JUMPV
LABELV $371
line 444
;444:		else if ( !( cg.timelimitWarnings & 2 ) && msec > (cgs.timelimit - 1) * 60 * 1000 ) {
ADDRGP4 cg+107616
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $378
ADDRLP4 20
INDIRI4
ADDRGP4 cgs+31500
INDIRI4
CNSTI4 60
MULI4
CNSTI4 1000
MULI4
CNSTI4 60000
SUBI4
LEI4 $378
line 445
;445:			cg.timelimitWarnings |= 1 | 2;
ADDRLP4 24
ADDRGP4 cg+107616
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 3
BORI4
ASGNI4
line 446
;446:			CG_AddBufferedSound( cgs.media.oneMinuteSound );
ADDRGP4 cgs+148772+916
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 447
;447:		}
ADDRGP4 $379
JUMPV
LABELV $378
line 448
;448:		else if ( cgs.timelimit > 5 && !( cg.timelimitWarnings & 1 ) && msec > (cgs.timelimit - 5) * 60 * 1000 ) {
ADDRGP4 cgs+31500
INDIRI4
CNSTI4 5
LEI4 $385
ADDRGP4 cg+107616
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $385
ADDRLP4 20
INDIRI4
ADDRGP4 cgs+31500
INDIRI4
CNSTI4 60
MULI4
CNSTI4 1000
MULI4
CNSTI4 300000
SUBI4
LEI4 $385
line 449
;449:			cg.timelimitWarnings |= 1;
ADDRLP4 24
ADDRGP4 cg+107616
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 450
;450:			CG_AddBufferedSound( cgs.media.fiveMinuteSound );
ADDRGP4 cgs+148772+920
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 451
;451:		}
LABELV $385
LABELV $379
LABELV $372
line 452
;452:	}
LABELV $363
line 455
;453:
;454:	// fraglimit warnings
;455:	if ( cgs.fraglimit > 0 && cgs.gametype < GT_CTF) {
ADDRGP4 cgs+31492
INDIRI4
CNSTI4 0
LEI4 $393
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 4
GEI4 $393
line 456
;456:		highScore = cgs.scores1;
ADDRLP4 8
ADDRGP4 cgs+34824
INDIRI4
ASGNI4
line 458
;457:
;458:		if (cgs.gametype == GT_TEAM && cgs.scores2 > highScore) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
NEI4 $398
ADDRGP4 cgs+34828
INDIRI4
ADDRLP4 8
INDIRI4
LEI4 $398
line 459
;459:			highScore = cgs.scores2;
ADDRLP4 8
ADDRGP4 cgs+34828
INDIRI4
ASGNI4
line 460
;460:		}
LABELV $398
line 462
;461:
;462:		if ( !( cg.fraglimitWarnings & 4 ) && highScore == (cgs.fraglimit - 1) ) {
ADDRGP4 cg+107620
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $403
ADDRLP4 8
INDIRI4
ADDRGP4 cgs+31492
INDIRI4
CNSTI4 1
SUBI4
NEI4 $403
line 463
;463:			cg.fraglimitWarnings |= 1 | 2 | 4;
ADDRLP4 20
ADDRGP4 cg+107620
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 7
BORI4
ASGNI4
line 464
;464:			CG_AddBufferedSound(cgs.media.oneFragSound);
ADDRGP4 cgs+148772+936
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 465
;465:		}
ADDRGP4 $404
JUMPV
LABELV $403
line 466
;466:		else if ( cgs.fraglimit > 2 && !( cg.fraglimitWarnings & 2 ) && highScore == (cgs.fraglimit - 2) ) {
ADDRGP4 cgs+31492
INDIRI4
CNSTI4 2
LEI4 $410
ADDRGP4 cg+107620
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $410
ADDRLP4 8
INDIRI4
ADDRGP4 cgs+31492
INDIRI4
CNSTI4 2
SUBI4
NEI4 $410
line 467
;467:			cg.fraglimitWarnings |= 1 | 2;
ADDRLP4 20
ADDRGP4 cg+107620
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 3
BORI4
ASGNI4
line 468
;468:			CG_AddBufferedSound(cgs.media.twoFragSound);
ADDRGP4 cgs+148772+932
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 469
;469:		}
ADDRGP4 $411
JUMPV
LABELV $410
line 470
;470:		else if ( cgs.fraglimit > 3 && !( cg.fraglimitWarnings & 1 ) && highScore == (cgs.fraglimit - 3) ) {
ADDRGP4 cgs+31492
INDIRI4
CNSTI4 3
LEI4 $418
ADDRGP4 cg+107620
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $418
ADDRLP4 8
INDIRI4
ADDRGP4 cgs+31492
INDIRI4
CNSTI4 3
SUBI4
NEI4 $418
line 471
;471:			cg.fraglimitWarnings |= 1;
ADDRLP4 20
ADDRGP4 cg+107620
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 472
;472:			CG_AddBufferedSound(cgs.media.threeFragSound);
ADDRGP4 cgs+148772+928
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 473
;473:		}
LABELV $418
LABELV $411
LABELV $404
line 474
;474:	}
LABELV $393
line 475
;475:}
LABELV $240
endproc CG_CheckLocalSounds 32 12
export CG_TransitionPlayerState
proc CG_TransitionPlayerState 12 12
line 483
;476:
;477:/*
;478:===============
;479:CG_TransitionPlayerState
;480:
;481:===============
;482:*/
;483:void CG_TransitionPlayerState( playerState_t *ps, playerState_t *ops ) {
line 487
;484:	qboolean respawn;
;485:
;486:	// check for changing follow mode
;487:	if ( ps->clientNum != ops->clientNum ) {
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
EQI4 $427
line 488
;488:		cg.thisFrameTeleport = qtrue;
ADDRGP4 cg+107592
CNSTI4 1
ASGNI4
line 490
;489:		// make sure we don't get any unwanted transition effects
;490:		*ops = *ps;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 468
line 491
;491:	}
LABELV $427
line 494
;492:
;493:	// damage events (player is getting wounded)
;494:	if ( ps->damageEvent != ops->damageEvent && ps->damageCount ) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
EQI4 $430
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 0
EQI4 $430
line 495
;495:		CG_DamageFeedback( ps->damageYaw, ps->damagePitch, ps->damageCount );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DamageFeedback
CALLV
pop
line 496
;496:	}
LABELV $430
line 499
;497:
;498:	// respawning / map restart
;499:	respawn = ps->persistant[PERS_SPAWN_COUNT] != ops->persistant[PERS_SPAWN_COUNT];
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
EQI4 $433
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $434
JUMPV
LABELV $433
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $434
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 500
;500:	if ( respawn || cg.mapRestart ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $438
ADDRGP4 cg+107624
INDIRI4
CNSTI4 0
EQI4 $435
LABELV $438
line 501
;501:		cg.mapRestart = qfalse;
ADDRGP4 cg+107624
CNSTI4 0
ASGNI4
line 502
;502:		CG_Respawn();
ADDRGP4 CG_Respawn
CALLV
pop
line 503
;503:	}
LABELV $435
line 505
;504:
;505:	if ( cg.snap->ps.pm_type != PM_INTERMISSION 
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
EQI4 $440
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 3
EQI4 $440
line 506
;506:		&& ps->persistant[PERS_TEAM] != TEAM_SPECTATOR ) {
line 507
;507:		CG_CheckLocalSounds( ps, ops );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_CheckLocalSounds
CALLV
pop
line 508
;508:	}
LABELV $440
line 511
;509:
;510:	// check for going low on ammo
;511:	CG_CheckAmmo();
ADDRGP4 CG_CheckAmmo
CALLV
pop
line 514
;512:
;513:	 // try to play potentially dropped events
;514:	CG_PlayDroppedEvents( ps, ops );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_PlayDroppedEvents
CALLV
pop
line 517
;515:
;516:	// run events
;517:	CG_CheckPlayerstateEvents( ps, ops );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_CheckPlayerstateEvents
CALLV
pop
line 520
;518:
;519:	// reset event stack
;520:	eventStack = 0;
ADDRGP4 eventStack
CNSTI4 0
ASGNI4
line 523
;521:
;522:	// smooth the ducking viewheight change
;523:	if ( ps->viewheight != ops->viewheight && !respawn ) {
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
EQI4 $443
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $443
line 524
;524:		cg.duckChange = ps->viewheight - ops->viewheight;
ADDRGP4 cg+108940
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 525
;525:		cg.duckTime = cg.time;
ADDRGP4 cg+108944
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 526
;526:	}
LABELV $443
line 527
;527:}
LABELV $426
endproc CG_TransitionPlayerState 12 12
import eventParm2
import eventStack
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
LABELV $110
byte 1 63
byte 1 63
byte 1 63
byte 1 0
align 1
LABELV $107
byte 1 110
byte 1 0
