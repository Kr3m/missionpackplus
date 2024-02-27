data
export pm_stopspeed
align 4
LABELV pm_stopspeed
byte 4 1120403456
export pm_duckScale
align 4
LABELV pm_duckScale
byte 4 1048576000
export pm_swimScale
align 4
LABELV pm_swimScale
byte 4 1056964608
export pm_wadeScale
align 4
LABELV pm_wadeScale
byte 4 1060320051
export pm_accelerate
align 4
LABELV pm_accelerate
byte 4 1092616192
export pm_airaccelerate
align 4
LABELV pm_airaccelerate
byte 4 1065353216
export pm_wateraccelerate
align 4
LABELV pm_wateraccelerate
byte 4 1082130432
export pm_flyaccelerate
align 4
LABELV pm_flyaccelerate
byte 4 1090519040
export pm_friction
align 4
LABELV pm_friction
byte 4 1086324736
export pm_waterfriction
align 4
LABELV pm_waterfriction
byte 4 1065353216
export pm_flightfriction
align 4
LABELV pm_flightfriction
byte 4 1077936128
export pm_spectatorfriction
align 4
LABELV pm_spectatorfriction
byte 4 1084227584
export c_pmove
align 4
LABELV c_pmove
byte 4 0
align 4
LABELV pm_respawntimer
byte 4 0
export PM_AddEvent
code
proc PM_AddEvent 0 16
file "../../../../code/game/bg_pmove.c"
line 41
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// bg_pmove.c -- both games player movement code
;4:// takes a playerstate and a usercmd as input and returns a modifed playerstate
;5:
;6:#include "q_shared.h"
;7:#include "bg_public.h"
;8:#include "bg_local.h"
;9:
;10:pmove_t		*pm;
;11:pml_t		pml;
;12:
;13:// movement parameters
;14:float	pm_stopspeed = 100.0f;
;15:float	pm_duckScale = 0.25f;
;16:float	pm_swimScale = 0.50f;
;17:float	pm_wadeScale = 0.70f;
;18:
;19:float	pm_accelerate = 10.0f;
;20:float	pm_airaccelerate = 1.0f;
;21:float	pm_wateraccelerate = 4.0f;
;22:float	pm_flyaccelerate = 8.0f;
;23:
;24:float	pm_friction = 6.0f;
;25:float	pm_waterfriction = 1.0f;
;26:float	pm_flightfriction = 3.0f;
;27:float	pm_spectatorfriction = 5.0f;
;28:
;29:int		c_pmove = 0;
;30:
;31:#define NO_RESPAWN_OVERBOUNCE 250
;32:
;33:static int pm_respawntimer = 0;
;34:
;35:/*
;36:===============
;37:PM_AddEvent
;38:
;39:===============
;40:*/
;41:void PM_AddEvent( int newEvent ) {
line 42
;42:	BG_AddPredictableEventToPlayerstate( newEvent, 0, pm->ps, -1 );
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 pm
INDIRP4
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 BG_AddPredictableEventToPlayerstate
CALLV
pop
line 43
;43:}
LABELV $41
endproc PM_AddEvent 0 16
export PM_AddTouchEnt
proc PM_AddTouchEnt 12 0
line 50
;44:
;45:/*
;46:===============
;47:PM_AddTouchEnt
;48:===============
;49:*/
;50:void PM_AddTouchEnt( int entityNum ) {
line 53
;51:	int		i;
;52:
;53:	if ( entityNum == ENTITYNUM_WORLD ) {
ADDRFP4 0
INDIRI4
CNSTI4 1022
NEI4 $43
line 54
;54:		return;
ADDRGP4 $42
JUMPV
LABELV $43
line 57
;55:	}
;56:
;57:	if ( pm->numtouch >= MAXTOUCH ) {
ADDRGP4 pm
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 32
LTI4 $45
line 58
;58:		return;
ADDRGP4 $42
JUMPV
LABELV $45
line 62
;59:	}
;60:
;61:	// see if it is already added
;62:	for ( i = 0 ; i < pm->numtouch ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $50
JUMPV
LABELV $47
line 63
;63:		if ( pm->touchents[ i ] == entityNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pm
INDIRP4
CNSTI4 48
ADDP4
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $51
line 64
;64:			return;
ADDRGP4 $42
JUMPV
LABELV $51
line 66
;65:		}
;66:	}
LABELV $48
line 62
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $50
ADDRLP4 0
INDIRI4
ADDRGP4 pm
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
LTI4 $47
line 69
;67:
;68:	// add it
;69:	pm->touchents[pm->numtouch] = entityNum;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 48
ADDP4
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 70
;70:	pm->numtouch++;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
CNSTI4 44
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
line 71
;71:}
LABELV $42
endproc PM_AddTouchEnt 12 0
proc PM_StartTorsoAnim 4 0
line 78
;72:
;73:/*
;74:===================
;75:PM_StartTorsoAnim
;76:===================
;77:*/
;78:static void PM_StartTorsoAnim( int anim ) {
line 79
;79:	if ( pm->ps->pm_type >= PM_DEAD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
LTI4 $54
line 80
;80:		return;
ADDRGP4 $53
JUMPV
LABELV $54
line 82
;81:	}
;82:	pm->ps->torsoAnim = ( ( pm->ps->torsoAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT )
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 128
BXORI4
ADDRFP4 0
INDIRI4
BORI4
ASGNI4
line 84
;83:		| anim;
;84:}
LABELV $53
endproc PM_StartTorsoAnim 4 0
proc PM_StartLegsAnim 4 0
line 85
;85:static void PM_StartLegsAnim( int anim ) {
line 86
;86:	if ( pm->ps->pm_type >= PM_DEAD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
LTI4 $57
line 87
;87:		return;
ADDRGP4 $56
JUMPV
LABELV $57
line 89
;88:	}
;89:	if ( pm->ps->legsTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
LEI4 $59
line 90
;90:		return;		// a high priority animation is running
ADDRGP4 $56
JUMPV
LABELV $59
line 92
;91:	}
;92:	pm->ps->legsAnim = ( ( pm->ps->legsAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT )
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 128
BXORI4
ADDRFP4 0
INDIRI4
BORI4
ASGNI4
line 94
;93:		| anim;
;94:}
LABELV $56
endproc PM_StartLegsAnim 4 0
proc PM_ContinueLegsAnim 0 4
line 96
;95:
;96:static void PM_ContinueLegsAnim( int anim ) {
line 97
;97:	if ( ( pm->ps->legsAnim & ~ANIM_TOGGLEBIT ) == anim ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ADDRFP4 0
INDIRI4
NEI4 $62
line 98
;98:		return;
ADDRGP4 $61
JUMPV
LABELV $62
line 100
;99:	}
;100:	if ( pm->ps->legsTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
LEI4 $64
line 101
;101:		return;		// a high priority animation is running
ADDRGP4 $61
JUMPV
LABELV $64
line 103
;102:	}
;103:	PM_StartLegsAnim( anim );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 PM_StartLegsAnim
CALLV
pop
line 104
;104:}
LABELV $61
endproc PM_ContinueLegsAnim 0 4
proc PM_ContinueTorsoAnim 0 4
line 106
;105:
;106:static void PM_ContinueTorsoAnim( int anim ) {
line 107
;107:	if ( ( pm->ps->torsoAnim & ~ANIM_TOGGLEBIT ) == anim ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ADDRFP4 0
INDIRI4
NEI4 $67
line 108
;108:		return;
ADDRGP4 $66
JUMPV
LABELV $67
line 110
;109:	}
;110:	if ( pm->ps->torsoTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
LEI4 $69
line 111
;111:		return;		// a high priority animation is running
ADDRGP4 $66
JUMPV
LABELV $69
line 113
;112:	}
;113:	PM_StartTorsoAnim( anim );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 114
;114:}
LABELV $66
endproc PM_ContinueTorsoAnim 0 4
proc PM_ForceLegsAnim 0 4
line 116
;115:
;116:static void PM_ForceLegsAnim( int anim ) {
line 117
;117:	pm->ps->legsTimer = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 118
;118:	PM_StartLegsAnim( anim );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 PM_StartLegsAnim
CALLV
pop
line 119
;119:}
LABELV $71
endproc PM_ForceLegsAnim 0 4
export PM_ClipVelocity
proc PM_ClipVelocity 24 0
line 129
;120:
;121:
;122:/*
;123:==================
;124:PM_ClipVelocity
;125:
;126:Slide off of the impacting surface
;127:==================
;128:*/
;129:void PM_ClipVelocity( vec3_t in, vec3_t normal, vec3_t out, float overbounce ) {
line 134
;130:	float	backoff;
;131:	float	change;
;132:	int		i;
;133:	
;134:	backoff = DotProduct (in, normal);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 16
INDIRP4
INDIRF4
MULF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 136
;135:	
;136:	if ( backoff < 0 ) {
ADDRLP4 8
INDIRF4
CNSTF4 0
GEF4 $73
line 137
;137:		backoff *= overbounce;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
line 138
;138:	} else {
ADDRGP4 $74
JUMPV
LABELV $73
line 139
;139:		backoff /= overbounce;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRFP4 12
INDIRF4
DIVF4
ASGNF4
line 140
;140:	}
LABELV $74
line 142
;141:
;142:	for ( i=0 ; i<3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $75
line 143
;143:		change = normal[i]*backoff;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
MULF4
ASGNF4
line 144
;144:		out[i] = in[i] - change;
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
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 145
;145:	}
LABELV $76
line 142
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $75
line 146
;146:}
LABELV $72
endproc PM_ClipVelocity 24 0
proc PM_Friction 48 4
line 156
;147:
;148:
;149:/*
;150:==================
;151:PM_Friction
;152:
;153:Handles both ground friction and water friction
;154:==================
;155:*/
;156:static void PM_Friction( void ) {
line 162
;157:	vec3_t	vec;
;158:	float	*vel;
;159:	float	speed, newspeed, control;
;160:	float	drop;
;161:	
;162:	vel = pm->ps->velocity;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
line 164
;163:	
;164:	VectorCopy( vel, vec );
ADDRLP4 16
ADDRLP4 0
INDIRP4
INDIRB
ASGNB 12
line 165
;165:	if ( pml.walking ) {
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
EQI4 $80
line 166
;166:		vec[2] = 0;	// ignore slope movement
ADDRLP4 16+8
CNSTF4 0
ASGNF4
line 167
;167:	}
LABELV $80
line 169
;168:
;169:	speed = VectorLength(vec);
ADDRLP4 16
ARGP4
ADDRLP4 32
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 32
INDIRF4
ASGNF4
line 170
;170:	if (speed < 1) {
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
GEF4 $84
line 171
;171:		vel[0] = 0;
ADDRLP4 0
INDIRP4
CNSTF4 0
ASGNF4
line 172
;172:		vel[1] = 0;		// allow sinking underwater
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
line 174
;173:		// FIXME: still have z friction underwater?
;174:		if ( pm->ps->pm_type == PM_SPECTATOR || pm->ps->powerups[ PW_FLIGHT ] )
ADDRLP4 36
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $88
ADDRLP4 36
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $79
LABELV $88
line 175
;175:			vel[2] = 0.0f; // no slow-sinking/raising movements
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
line 176
;176:		return;
ADDRGP4 $79
JUMPV
LABELV $84
line 179
;177:	}
;178:
;179:	drop = 0;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 182
;180:
;181:	// apply ground friction
;182:	if ( pm->waterlevel <= 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
GTI4 $89
line 183
;183:		if ( pml.walking && !(pml.groundTrace.surfaceFlags & SURF_SLICK) ) {
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
EQI4 $91
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $91
line 185
;184:			// if getting knocked back, no friction
;185:			if ( ! (pm->ps->pm_flags & PMF_TIME_KNOCKBACK) ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
NEI4 $96
line 186
;186:				control = speed < pm_stopspeed ? pm_stopspeed : speed;
ADDRLP4 8
INDIRF4
ADDRGP4 pm_stopspeed
INDIRF4
GEF4 $99
ADDRLP4 36
ADDRGP4 pm_stopspeed
INDIRF4
ASGNF4
ADDRGP4 $100
JUMPV
LABELV $99
ADDRLP4 36
ADDRLP4 8
INDIRF4
ASGNF4
LABELV $100
ADDRLP4 28
ADDRLP4 36
INDIRF4
ASGNF4
line 187
;187:				drop += control*pm_friction*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 28
INDIRF4
ADDRGP4 pm_friction
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 188
;188:			}
LABELV $96
line 189
;189:		}
LABELV $91
line 190
;190:	}
LABELV $89
line 193
;191:
;192:	// apply water friction even if just wading
;193:	if ( pm->waterlevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
EQI4 $102
line 194
;194:		drop += speed*pm_waterfriction*pm->waterlevel*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 pm_waterfriction
INDIRF4
MULF4
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CVIF4 4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 195
;195:	}
LABELV $102
line 198
;196:
;197:	// apply flying friction
;198:	if ( pm->ps->powerups[PW_FLIGHT]) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $105
line 199
;199:		drop += speed*pm_flightfriction*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 pm_flightfriction
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 200
;200:	}
LABELV $105
line 202
;201:
;202:	if ( pm->ps->pm_type == PM_SPECTATOR) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $108
line 203
;203:		drop += speed*pm_spectatorfriction*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 pm_spectatorfriction
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 204
;204:	}
LABELV $108
line 207
;205:
;206:	// scale the velocity
;207:	newspeed = speed - drop;
ADDRLP4 4
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ASGNF4
line 208
;208:	if (newspeed < 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
GEF4 $111
line 209
;209:		newspeed = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 210
;210:	}
LABELV $111
line 211
;211:	newspeed /= speed;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
DIVF4
ASGNF4
line 213
;212:
;213:	vel[0] = vel[0] * newspeed;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 214
;214:	vel[1] = vel[1] * newspeed;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 215
;215:	vel[2] = vel[2] * newspeed;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 216
;216:}
LABELV $79
endproc PM_Friction 48 4
proc PM_Accelerate 32 0
line 226
;217:
;218:
;219:/*
;220:==============
;221:PM_Accelerate
;222:
;223:Handles user intended acceleration
;224:==============
;225:*/
;226:static void PM_Accelerate( vec3_t wishdir, float wishspeed, float accel ) {
line 232
;227:#if 1
;228:	// q2 style
;229:	int			i;
;230:	float		addspeed, accelspeed, currentspeed;
;231:
;232:	currentspeed = DotProduct (pm->ps->velocity, wishdir);
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
INDIRF4
MULF4
ADDRLP4 16
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 16
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 233
;233:	addspeed = wishspeed - currentspeed;
ADDRLP4 8
ADDRFP4 4
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ASGNF4
line 234
;234:	if (addspeed <= 0) {
ADDRLP4 8
INDIRF4
CNSTF4 0
GTF4 $114
line 235
;235:		return;
ADDRGP4 $113
JUMPV
LABELV $114
line 237
;236:	}
;237:	accelspeed = accel*pml.frametime*wishspeed;
ADDRLP4 4
ADDRFP4 8
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
line 238
;238:	if (accelspeed > addspeed) {
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $117
line 239
;239:		accelspeed = addspeed;
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
line 240
;240:	}
LABELV $117
line 242
;241:	
;242:	for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $119
line 243
;243:		pm->ps->velocity[i] += accelspeed*wishdir[i];	
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 244
;244:	}
LABELV $120
line 242
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $119
line 263
;245:#else
;246:	// proper way (avoids strafe jump maxspeed bug), but feels bad
;247:	vec3_t		wishVelocity;
;248:	vec3_t		pushDir;
;249:	float		pushLen;
;250:	float		canPush;
;251:
;252:	VectorScale( wishdir, wishspeed, wishVelocity );
;253:	VectorSubtract( wishVelocity, pm->ps->velocity, pushDir );
;254:	pushLen = VectorNormalize( pushDir );
;255:
;256:	canPush = accel*pml.frametime*wishspeed;
;257:	if (canPush > pushLen) {
;258:		canPush = pushLen;
;259:	}
;260:
;261:	VectorMA( pm->ps->velocity, canPush, pushDir, pm->ps->velocity );
;262:#endif
;263:}
LABELV $113
endproc PM_Accelerate 32 0
proc PM_CmdScale 32 4
line 276
;264:
;265:
;266:
;267:/*
;268:============
;269:PM_CmdScale
;270:
;271:Returns the scale factor to apply to cmd movements
;272:This allows the clients to use axial -127 to 127 values for all directions
;273:without getting a sqrt(2) distortion in speed.
;274:============
;275:*/
;276:static float PM_CmdScale( usercmd_t *cmd ) {
line 281
;277:	int		max;
;278:	float	total;
;279:	float	scale;
;280:
;281:	max = abs( cmd->forwardmove );
ADDRFP4 0
INDIRP4
CNSTI4 21
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 12
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 282
;282:	if ( abs( cmd->rightmove ) > max ) {
ADDRFP4 0
INDIRP4
CNSTI4 22
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 16
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $124
line 283
;283:		max = abs( cmd->rightmove );
ADDRFP4 0
INDIRP4
CNSTI4 22
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 20
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
ASGNI4
line 284
;284:	}
LABELV $124
line 285
;285:	if ( abs( cmd->upmove ) > max ) {
ADDRFP4 0
INDIRP4
CNSTI4 23
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 20
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $126
line 286
;286:		max = abs( cmd->upmove );
ADDRFP4 0
INDIRP4
CNSTI4 23
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 24
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 24
INDIRI4
ASGNI4
line 287
;287:	}
LABELV $126
line 288
;288:	if ( !max ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $128
line 289
;289:		return 0;
CNSTF4 0
RETF4
ADDRGP4 $123
JUMPV
LABELV $128
line 292
;290:	}
;291:
;292:	total = sqrt( cmd->forwardmove * cmd->forwardmove
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 21
ADDP4
INDIRI1
CVII4 1
ADDRLP4 24
INDIRP4
CNSTI4 21
ADDP4
INDIRI1
CVII4 1
MULI4
ADDRLP4 24
INDIRP4
CNSTI4 22
ADDP4
INDIRI1
CVII4 1
ADDRLP4 24
INDIRP4
CNSTI4 22
ADDP4
INDIRI1
CVII4 1
MULI4
ADDI4
ADDRLP4 24
INDIRP4
CNSTI4 23
ADDP4
INDIRI1
CVII4 1
ADDRLP4 24
INDIRP4
CNSTI4 23
ADDP4
INDIRI1
CVII4 1
MULI4
ADDI4
CVIF4 4
ARGF4
ADDRLP4 28
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 28
INDIRF4
ASGNF4
line 294
;293:		+ cmd->rightmove * cmd->rightmove + cmd->upmove * cmd->upmove );
;294:	scale = (float)pm->ps->speed * max / ( 127.0 * total );
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRI4
CVIF4 4
MULF4
ADDRLP4 4
INDIRF4
CNSTF4 1123942400
MULF4
DIVF4
ASGNF4
line 296
;295:
;296:	return scale;
ADDRLP4 8
INDIRF4
RETF4
LABELV $123
endproc PM_CmdScale 32 4
proc PM_SetMovementDir 36 0
line 308
;297:}
;298:
;299:
;300:/*
;301:================
;302:PM_SetMovementDir
;303:
;304:Determine the rotation of the legs relative
;305:to the facing dir
;306:================
;307:*/
;308:static void PM_SetMovementDir( void ) {
line 309
;309:	if ( pm->cmd.forwardmove || pm->cmd.rightmove ) {
ADDRLP4 0
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $133
ADDRLP4 0
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $131
LABELV $133
line 310
;310:		if ( pm->cmd.rightmove == 0 && pm->cmd.forwardmove > 0 ) {
ADDRLP4 4
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $134
ADDRLP4 4
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $134
line 311
;311:			pm->ps->movementDir = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 0
ASGNI4
line 312
;312:		} else if ( pm->cmd.rightmove < 0 && pm->cmd.forwardmove > 0 ) {
ADDRGP4 $132
JUMPV
LABELV $134
ADDRLP4 8
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $136
ADDRLP4 8
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $136
line 313
;313:			pm->ps->movementDir = 1;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 1
ASGNI4
line 314
;314:		} else if ( pm->cmd.rightmove < 0 && pm->cmd.forwardmove == 0 ) {
ADDRGP4 $132
JUMPV
LABELV $136
ADDRLP4 12
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $138
ADDRLP4 12
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $138
line 315
;315:			pm->ps->movementDir = 2;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 2
ASGNI4
line 316
;316:		} else if ( pm->cmd.rightmove < 0 && pm->cmd.forwardmove < 0 ) {
ADDRGP4 $132
JUMPV
LABELV $138
ADDRLP4 16
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $140
ADDRLP4 16
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $140
line 317
;317:			pm->ps->movementDir = 3;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 3
ASGNI4
line 318
;318:		} else if ( pm->cmd.rightmove == 0 && pm->cmd.forwardmove < 0 ) {
ADDRGP4 $132
JUMPV
LABELV $140
ADDRLP4 20
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $142
ADDRLP4 20
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $142
line 319
;319:			pm->ps->movementDir = 4;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 4
ASGNI4
line 320
;320:		} else if ( pm->cmd.rightmove > 0 && pm->cmd.forwardmove < 0 ) {
ADDRGP4 $132
JUMPV
LABELV $142
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $144
ADDRLP4 24
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $144
line 321
;321:			pm->ps->movementDir = 5;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 5
ASGNI4
line 322
;322:		} else if ( pm->cmd.rightmove > 0 && pm->cmd.forwardmove == 0 ) {
ADDRGP4 $132
JUMPV
LABELV $144
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $146
ADDRLP4 28
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $146
line 323
;323:			pm->ps->movementDir = 6;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 6
ASGNI4
line 324
;324:		} else if ( pm->cmd.rightmove > 0 && pm->cmd.forwardmove > 0 ) {
ADDRGP4 $132
JUMPV
LABELV $146
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $132
ADDRLP4 32
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $132
line 325
;325:			pm->ps->movementDir = 7;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 7
ASGNI4
line 326
;326:		}
line 327
;327:	} else {
ADDRGP4 $132
JUMPV
LABELV $131
line 331
;328:		// if they aren't actively going directly sideways,
;329:		// change the animation to the diagonal so they
;330:		// don't stop too crooked
;331:		if ( pm->ps->movementDir == 2 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 2
NEI4 $150
line 332
;332:			pm->ps->movementDir = 1;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 1
ASGNI4
line 333
;333:		} else if ( pm->ps->movementDir == 6 ) {
ADDRGP4 $151
JUMPV
LABELV $150
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 6
NEI4 $152
line 334
;334:			pm->ps->movementDir = 7;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 7
ASGNI4
line 335
;335:		} 
LABELV $152
LABELV $151
line 336
;336:	}
LABELV $132
line 337
;337:}
LABELV $130
endproc PM_SetMovementDir 36 0
proc PM_CheckJump 8 4
line 345
;338:
;339:
;340:/*
;341:=============
;342:PM_CheckJump
;343:=============
;344:*/
;345:static qboolean PM_CheckJump( void ) {
line 346
;346:	if ( pm->ps->pm_flags & PMF_RESPAWNED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $155
line 347
;347:		return qfalse;		// don't allow jump until all buttons are up
CNSTI4 0
RETI4
ADDRGP4 $154
JUMPV
LABELV $155
line 350
;348:	}
;349:
;350:	if ( pm->cmd.upmove < 10 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 10
GEI4 $157
line 352
;351:		// not holding jump
;352:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $154
JUMPV
LABELV $157
line 356
;353:	}
;354:
;355:	// must wait for jump to be released
;356:	if ( pm->ps->pm_flags & PMF_JUMP_HELD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $159
line 358
;357:		// clear upmove so cmdscale doesn't lower running speed
;358:		pm->cmd.upmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 359
;359:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $154
JUMPV
LABELV $159
line 362
;360:	}
;361:
;362:	pml.groundPlane = qfalse;		// jumping away
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 363
;363:	pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 364
;364:	pm->ps->pm_flags |= PMF_JUMP_HELD;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 366
;365:
;366:	pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 367
;367:	pm->ps->velocity[2] = JUMP_VELOCITY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1132920832
ASGNF4
line 368
;368:	PM_AddEvent( EV_JUMP );
CNSTI4 14
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 370
;369:
;370:	if ( pm->cmd.forwardmove >= 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LTI4 $163
line 371
;371:		PM_ForceLegsAnim( LEGS_JUMP );
CNSTI4 18
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 372
;372:		pm->ps->pm_flags &= ~PMF_BACKWARDS_JUMP;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 373
;373:	} else {
ADDRGP4 $164
JUMPV
LABELV $163
line 374
;374:		PM_ForceLegsAnim( LEGS_JUMPB );
CNSTI4 20
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 375
;375:		pm->ps->pm_flags |= PMF_BACKWARDS_JUMP;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 376
;376:	}
LABELV $164
line 378
;377:
;378:	return qtrue;
CNSTI4 1
RETI4
LABELV $154
endproc PM_CheckJump 8 4
proc PM_CheckWaterJump 52 8
line 386
;379:}
;380:
;381:/*
;382:=============
;383:PM_CheckWaterJump
;384:=============
;385:*/
;386:static qboolean	PM_CheckWaterJump( void ) {
line 391
;387:	vec3_t	spot;
;388:	int		cont;
;389:	vec3_t	flatforward;
;390:
;391:	if (pm->ps->pm_time) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $166
line 392
;392:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $165
JUMPV
LABELV $166
line 396
;393:	}
;394:
;395:	// check for water jump
;396:	if ( pm->waterlevel != 2 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
EQI4 $168
line 397
;397:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $165
JUMPV
LABELV $168
line 400
;398:	}
;399:
;400:	flatforward[0] = pml.forward[0];
ADDRLP4 12
ADDRGP4 pml
INDIRF4
ASGNF4
line 401
;401:	flatforward[1] = pml.forward[1];
ADDRLP4 12+4
ADDRGP4 pml+4
INDIRF4
ASGNF4
line 402
;402:	flatforward[2] = 0;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 403
;403:	VectorNormalize (flatforward);
ADDRLP4 12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 405
;404:
;405:	VectorMA (pm->ps->origin, 30, flatforward, spot);
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 1106247680
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 12+4
INDIRF4
CNSTF4 1106247680
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 12+8
INDIRF4
CNSTF4 1106247680
MULF4
ADDF4
ASGNF4
line 406
;406:	spot[2] += 4;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1082130432
ADDF4
ASGNF4
line 407
;407:	cont = pm->pointcontents (spot, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 36
INDIRI4
ASGNI4
line 408
;408:	if ( !(cont & CONTENTS_SOLID) ) {
ADDRLP4 24
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $178
line 409
;409:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $165
JUMPV
LABELV $178
line 412
;410:	}
;411:
;412:	spot[2] += 16;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 413
;413:	cont = pm->pointcontents (spot, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 40
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
ADDRLP4 40
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 44
INDIRI4
ASGNI4
line 414
;414:	if ( cont & (CONTENTS_SOLID|CONTENTS_PLAYERCLIP|CONTENTS_BODY) ) {
ADDRLP4 24
INDIRI4
CNSTI4 33619969
BANDI4
CNSTI4 0
EQI4 $181
line 415
;415:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $165
JUMPV
LABELV $181
line 419
;416:	}
;417:
;418:	// jump out of water
;419:	VectorScale (pml.forward, 200, pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDRGP4 pml
INDIRF4
CNSTF4 1128792064
MULF4
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
ADDRGP4 pml+4
INDIRF4
CNSTF4 1128792064
MULF4
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ADDRGP4 pml+8
INDIRF4
CNSTF4 1128792064
MULF4
ASGNF4
line 420
;420:	pm->ps->velocity[2] = 350;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1135542272
ASGNF4
line 422
;421:
;422:	pm->ps->pm_flags |= PMF_TIME_WATERJUMP;
ADDRLP4 48
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 423
;423:	pm->ps->pm_time = 2000;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 2000
ASGNI4
line 425
;424:
;425:	return qtrue;
CNSTI4 1
RETI4
LABELV $165
endproc PM_CheckWaterJump 52 8
proc PM_WaterJumpMove 12 4
line 438
;426:}
;427:
;428://============================================================================
;429:
;430:
;431:/*
;432:===================
;433:PM_WaterJumpMove
;434:
;435:Flying out of the water
;436:===================
;437:*/
;438:static void PM_WaterJumpMove( void ) {
line 441
;439:	// waterjump has no control, but falls
;440:
;441:	PM_StepSlideMove( qtrue );
CNSTI4 1
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 443
;442:
;443:	pm->ps->velocity[2] -= pm->ps->gravity * pml.frametime;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pml+36
INDIRF4
MULF4
SUBF4
ASGNF4
line 444
;444:	if (pm->ps->velocity[2] < 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 0
GEF4 $187
line 446
;445:		// cancel as soon as we are falling down again
;446:		pm->ps->pm_flags &= ~PMF_ALL_TIMES;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -353
BANDI4
ASGNI4
line 447
;447:		pm->ps->pm_time = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 448
;448:	}
LABELV $187
line 449
;449:}
LABELV $185
endproc PM_WaterJumpMove 12 4
proc PM_WaterMove 76 16
line 457
;450:
;451:/*
;452:===================
;453:PM_WaterMove
;454:
;455:===================
;456:*/
;457:static void PM_WaterMove( void ) {
line 465
;458:	int		i;
;459:	vec3_t	wishvel;
;460:	float	wishspeed;
;461:	vec3_t	wishdir;
;462:	float	scale;
;463:	float	vel;
;464:
;465:	if ( PM_CheckWaterJump() ) {
ADDRLP4 40
ADDRGP4 PM_CheckWaterJump
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $190
line 466
;466:		PM_WaterJumpMove();
ADDRGP4 PM_WaterJumpMove
CALLV
pop
line 467
;467:		return;
ADDRGP4 $189
JUMPV
LABELV $190
line 483
;468:	}
;469:#if 0
;470:	// jump = head for surface
;471:	if ( pm->cmd.upmove >= 10 ) {
;472:		if (pm->ps->velocity[2] > -300) {
;473:			if ( pm->watertype & CONTENTS_WATER ) {
;474:				pm->ps->velocity[2] = 100;
;475:			} else if ( pm->watertype & CONTENTS_SLIME ) {
;476:				pm->ps->velocity[2] = 80;
;477:			} else {
;478:				pm->ps->velocity[2] = 50;
;479:			}
;480:		}
;481:	}
;482:#endif
;483:	PM_Friction ();
ADDRGP4 PM_Friction
CALLV
pop
line 485
;484:
;485:	scale = PM_CmdScale( &pm->cmd );
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 44
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 44
INDIRF4
ASGNF4
line 489
;486:	//
;487:	// user intentions
;488:	//
;489:	if ( !scale ) {
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $192
line 490
;490:		wishvel[0] = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 491
;491:		wishvel[1] = 0;
ADDRLP4 8+4
CNSTF4 0
ASGNF4
line 492
;492:		wishvel[2] = -60;		// sink towards bottom
ADDRLP4 8+8
CNSTF4 3262119936
ASGNF4
line 493
;493:	} else {
ADDRGP4 $193
JUMPV
LABELV $192
line 494
;494:		for (i=0 ; i<3 ; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $196
line 495
;495:			wishvel[i] = scale * pml.forward[i]*pm->cmd.forwardmove + scale * pml.right[i]*pm->cmd.rightmove;
ADDRLP4 56
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml
ADDP4
INDIRF4
MULF4
ADDRLP4 56
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml+12
ADDP4
INDIRF4
MULF4
ADDRLP4 56
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
LABELV $197
line 494
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $196
line 497
;496:
;497:		wishvel[2] += scale * pm->cmd.upmove;
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
ADDRLP4 4
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
line 498
;498:	}
LABELV $193
line 500
;499:
;500:	VectorCopy (wishvel, wishdir);
ADDRLP4 24
ADDRLP4 8
INDIRB
ASGNB 12
line 501
;501:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 24
ARGP4
ADDRLP4 48
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 48
INDIRF4
ASGNF4
line 503
;502:
;503:	if ( wishspeed > pm->ps->speed * pm_swimScale ) {
ADDRLP4 20
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_swimScale
INDIRF4
MULF4
LEF4 $202
line 504
;504:		wishspeed = pm->ps->speed * pm_swimScale;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_swimScale
INDIRF4
MULF4
ASGNF4
line 505
;505:	}
LABELV $202
line 507
;506:
;507:	PM_Accelerate (wishdir, wishspeed, pm_wateraccelerate);
ADDRLP4 24
ARGP4
ADDRLP4 20
INDIRF4
ARGF4
ADDRGP4 pm_wateraccelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 510
;508:
;509:	// make sure we can go up slopes easily under water
;510:	if ( pml.groundPlane && DotProduct( pm->ps->velocity, pml.groundTrace.plane.normal ) < 0 ) {
ADDRGP4 pml+48
INDIRI4
CNSTI4 0
EQI4 $204
ADDRLP4 52
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRGP4 pml+52+24
INDIRF4
MULF4
ADDRLP4 52
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRGP4 pml+52+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 52
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRGP4 pml+52+24+8
INDIRF4
MULF4
ADDF4
CNSTF4 0
GEF4 $204
line 511
;511:		vel = VectorLength(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 56
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 36
ADDRLP4 56
INDIRF4
ASGNF4
line 513
;512:		// slide along the ground plane
;513:		PM_ClipVelocity (pm->ps->velocity, pml.groundTrace.plane.normal,
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 32
ADDP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 516
;514:			pm->ps->velocity, OVERCLIP );
;515:
;516:		VectorNormalize(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 517
;517:		VectorScale(pm->ps->velocity, vel, pm->ps->velocity);
ADDRLP4 64
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
ADDRLP4 68
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
ADDRLP4 72
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
line 518
;518:	}
LABELV $204
line 520
;519:
;520:	PM_SlideMove( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 PM_SlideMove
CALLI4
pop
line 521
;521:}
LABELV $189
endproc PM_WaterMove 76 16
proc PM_InvulnerabilityMove 0 0
line 531
;522:
;523:#ifdef MISSIONPACK
;524:/*
;525:===================
;526:PM_InvulnerabilityMove
;527:
;528:Only with the invulnerability powerup
;529:===================
;530:*/
;531:static void PM_InvulnerabilityMove( void ) {
line 532
;532:	pm->cmd.forwardmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
CNSTI1 0
ASGNI1
line 533
;533:	pm->cmd.rightmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
CNSTI1 0
ASGNI1
line 534
;534:	pm->cmd.upmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 535
;535:	VectorClear(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 0
ASGNF4
line 536
;536:}
LABELV $217
endproc PM_InvulnerabilityMove 0 0
proc PM_FlyMove 52 12
line 546
;537:#endif
;538:
;539:/*
;540:===================
;541:PM_FlyMove
;542:
;543:Only with the flight powerup
;544:===================
;545:*/
;546:static void PM_FlyMove( void ) {
line 554
;547:	int		i;
;548:	vec3_t	wishvel;
;549:	float	wishspeed;
;550:	vec3_t	wishdir;
;551:	float	scale;
;552:
;553:	// normal slowdown
;554:	PM_Friction ();
ADDRGP4 PM_Friction
CALLV
pop
line 556
;555:
;556:	scale = PM_CmdScale( &pm->cmd );
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 36
INDIRF4
ASGNF4
line 560
;557:	//
;558:	// user intentions
;559:	//
;560:	if ( !scale ) {
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $219
line 561
;561:		wishvel[0] = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 562
;562:		wishvel[1] = 0;
ADDRLP4 8+4
CNSTF4 0
ASGNF4
line 563
;563:		wishvel[2] = 0;
ADDRLP4 8+8
CNSTF4 0
ASGNF4
line 564
;564:	} else {
ADDRGP4 $220
JUMPV
LABELV $219
line 565
;565:		for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $223
line 566
;566:			wishvel[i] = scale * pml.forward[i]*pm->cmd.forwardmove + scale * pml.right[i]*pm->cmd.rightmove;
ADDRLP4 48
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml
ADDP4
INDIRF4
MULF4
ADDRLP4 48
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml+12
ADDP4
INDIRF4
MULF4
ADDRLP4 48
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
line 567
;567:		}
LABELV $224
line 565
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $223
line 569
;568:
;569:		wishvel[2] += scale * pm->cmd.upmove;
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
ADDRLP4 4
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
line 570
;570:	}
LABELV $220
line 572
;571:
;572:	VectorCopy (wishvel, wishdir);
ADDRLP4 20
ADDRLP4 8
INDIRB
ASGNB 12
line 573
;573:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 20
ARGP4
ADDRLP4 40
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 40
INDIRF4
ASGNF4
line 575
;574:
;575:	PM_Accelerate (wishdir, wishspeed, pm_flyaccelerate);
ADDRLP4 20
ARGP4
ADDRLP4 32
INDIRF4
ARGF4
ADDRGP4 pm_flyaccelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 577
;576:
;577:	PM_StepSlideMove( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 578
;578:}
LABELV $218
endproc PM_FlyMove 52 12
proc PM_AirMove 80 16
line 587
;579:
;580:
;581:/*
;582:===================
;583:PM_AirMove
;584:
;585:===================
;586:*/
;587:static void PM_AirMove( void ) {
line 596
;588:	int			i;
;589:	vec3_t		wishvel;
;590:	float		fmove, smove;
;591:	vec3_t		wishdir;
;592:	float		wishspeed;
;593:	float		scale;
;594:	usercmd_t	cmd;
;595:
;596:	PM_Friction();
ADDRGP4 PM_Friction
CALLV
pop
line 598
;597:
;598:	fmove = pm->cmd.forwardmove;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 599
;599:	smove = pm->cmd.rightmove;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 601
;600:
;601:	cmd = pm->cmd;
ADDRLP4 44
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
INDIRB
ASGNB 24
line 602
;602:	scale = PM_CmdScale( &cmd );
ADDRLP4 44
ARGP4
ADDRLP4 68
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 68
INDIRF4
ASGNF4
line 605
;603:
;604:	// set the movementDir so clients can rotate the legs for strafing
;605:	PM_SetMovementDir();
ADDRGP4 PM_SetMovementDir
CALLV
pop
line 608
;606:
;607:	// project moves down to flat plane
;608:	pml.forward[2] = 0;
ADDRGP4 pml+8
CNSTF4 0
ASGNF4
line 609
;609:	pml.right[2] = 0;
ADDRGP4 pml+12+8
CNSTF4 0
ASGNF4
line 610
;610:	VectorNormalize (pml.forward);
ADDRGP4 pml
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 611
;611:	VectorNormalize (pml.right);
ADDRGP4 pml+12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 613
;612:
;613:	for ( i = 0 ; i < 2 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $234
line 614
;614:		wishvel[i] = pml.forward[i]*fmove + pml.right[i]*smove;
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
ADDRGP4 pml
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml+12
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 615
;615:	}
LABELV $235
line 613
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $234
line 616
;616:	wishvel[2] = 0;
ADDRLP4 4+8
CNSTF4 0
ASGNF4
line 618
;617:
;618:	VectorCopy (wishvel, wishdir);
ADDRLP4 24
ADDRLP4 4
INDIRB
ASGNB 12
line 619
;619:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 24
ARGP4
ADDRLP4 72
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 36
ADDRLP4 72
INDIRF4
ASGNF4
line 620
;620:	wishspeed *= scale;
ADDRLP4 36
ADDRLP4 36
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ASGNF4
line 623
;621:
;622:	// not on ground, so little effect on velocity
;623:	PM_Accelerate (wishdir, wishspeed, pm_airaccelerate);
ADDRLP4 24
ARGP4
ADDRLP4 36
INDIRF4
ARGF4
ADDRGP4 pm_airaccelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 628
;624:
;625:	// we may have a ground plane that is very steep, even
;626:	// though we don't have a groundentity
;627:	// slide along the steep plane
;628:	if ( pml.groundPlane ) {
ADDRGP4 pml+48
INDIRI4
CNSTI4 0
EQI4 $240
line 629
;629:		PM_ClipVelocity (pm->ps->velocity, pml.groundTrace.plane.normal, 
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 32
ADDP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 631
;630:			pm->ps->velocity, OVERCLIP );
;631:	}
LABELV $240
line 643
;632:
;633:#if 0
;634:	//ZOID:  If we are on the grapple, try stair-stepping
;635:	//this allows a player to use the grapple to pull himself
;636:	//over a ledge
;637:	if (pm->ps->pm_flags & PMF_GRAPPLE_PULL)
;638:		PM_StepSlideMove ( qtrue );
;639:	else
;640:		PM_SlideMove ( qtrue );
;641:#endif
;642:
;643:	PM_StepSlideMove ( qtrue );
CNSTI4 1
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 644
;644:}
LABELV $229
endproc PM_AirMove 80 16
proc PM_GrappleMove 44 4
line 652
;645:
;646:/*
;647:===================
;648:PM_GrappleMove
;649:
;650:===================
;651:*/
;652:static void PM_GrappleMove( void ) {
line 656
;653:	vec3_t vel, v;
;654:	float vlen;
;655:
;656:	VectorScale(pml.forward, -16, v);
ADDRLP4 12
ADDRGP4 pml
INDIRF4
CNSTF4 3246391296
MULF4
ASGNF4
ADDRLP4 12+4
ADDRGP4 pml+4
INDIRF4
CNSTF4 3246391296
MULF4
ASGNF4
ADDRLP4 12+8
ADDRGP4 pml+8
INDIRF4
CNSTF4 3246391296
MULF4
ASGNF4
line 657
;657:	VectorAdd(pm->ps->grapplePoint, v, v);
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDF4
ASGNF4
line 658
;658:	VectorSubtract(v, pm->ps->origin, vel);
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 32
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 32
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 12+8
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
line 659
;659:	vlen = VectorLength(vel);
ADDRLP4 0
ARGP4
ADDRLP4 36
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 36
INDIRF4
ASGNF4
line 660
;660:	VectorNormalize( vel );
ADDRLP4 0
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 662
;661:
;662:	if (vlen <= 100)
ADDRLP4 24
INDIRF4
CNSTF4 1120403456
GTF4 $258
line 663
;663:		VectorScale(vel, 10 * vlen, vel);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 1092616192
MULF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 1092616192
MULF4
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 1092616192
MULF4
MULF4
ASGNF4
ADDRGP4 $259
JUMPV
LABELV $258
line 665
;664:	else
;665:		VectorScale(vel, 800, vel);
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1145569280
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1145569280
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1145569280
MULF4
ASGNF4
LABELV $259
line 667
;666:
;667:	VectorCopy(vel, pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 669
;668:
;669:	pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 670
;670:}
LABELV $245
endproc PM_GrappleMove 44 4
proc PM_WalkMove 112 16
line 678
;671:
;672:/*
;673:===================
;674:PM_WalkMove
;675:
;676:===================
;677:*/
;678:static void PM_WalkMove( void ) {
line 689
;679:	int			i;
;680:	vec3_t		wishvel;
;681:	float		fmove, smove;
;682:	vec3_t		wishdir;
;683:	float		wishspeed;
;684:	float		scale;
;685:	usercmd_t	cmd;
;686:	float		accelerate;
;687:	float		vel;
;688:
;689:	if ( pm->waterlevel > 2 && DotProduct( pml.forward, pml.groundTrace.plane.normal ) > 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
LEI4 $270
ADDRGP4 pml
INDIRF4
ADDRGP4 pml+52+24
INDIRF4
MULF4
ADDRGP4 pml+4
INDIRF4
ADDRGP4 pml+52+24+4
INDIRF4
MULF4
ADDF4
ADDRGP4 pml+8
INDIRF4
ADDRGP4 pml+52+24+8
INDIRF4
MULF4
ADDF4
CNSTF4 0
LEF4 $270
line 691
;690:		// begin swimming
;691:		PM_WaterMove();
ADDRGP4 PM_WaterMove
CALLV
pop
line 692
;692:		return;
ADDRGP4 $269
JUMPV
LABELV $270
line 696
;693:	}
;694:
;695:
;696:	if ( PM_CheckJump () ) {
ADDRLP4 76
ADDRGP4 PM_CheckJump
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $282
line 698
;697:		// jumped away
;698:		if ( pm->waterlevel > 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
LEI4 $284
line 699
;699:			PM_WaterMove();
ADDRGP4 PM_WaterMove
CALLV
pop
line 700
;700:		} else {
ADDRGP4 $269
JUMPV
LABELV $284
line 701
;701:			PM_AirMove();
ADDRGP4 PM_AirMove
CALLV
pop
line 702
;702:		}
line 703
;703:		return;
ADDRGP4 $269
JUMPV
LABELV $282
line 706
;704:	}
;705:
;706:	PM_Friction ();
ADDRGP4 PM_Friction
CALLV
pop
line 708
;707:
;708:	fmove = pm->cmd.forwardmove;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 709
;709:	smove = pm->cmd.rightmove;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 711
;710:
;711:	cmd = pm->cmd;
ADDRLP4 44
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
INDIRB
ASGNB 24
line 712
;712:	scale = PM_CmdScale( &cmd );
ADDRLP4 44
ARGP4
ADDRLP4 80
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 80
INDIRF4
ASGNF4
line 715
;713:
;714:	// set the movementDir so clients can rotate the legs for strafing
;715:	PM_SetMovementDir();
ADDRGP4 PM_SetMovementDir
CALLV
pop
line 718
;716:
;717:	// project moves down to flat plane
;718:	pml.forward[2] = 0;
ADDRGP4 pml+8
CNSTF4 0
ASGNF4
line 719
;719:	pml.right[2] = 0;
ADDRGP4 pml+12+8
CNSTF4 0
ASGNF4
line 722
;720:
;721:	// project the forward and right directions onto the ground plane
;722:	PM_ClipVelocity (pml.forward, pml.groundTrace.plane.normal, pml.forward, OVERCLIP );
ADDRLP4 84
ADDRGP4 pml
ASGNP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 723
;723:	PM_ClipVelocity (pml.right, pml.groundTrace.plane.normal, pml.right, OVERCLIP );
ADDRGP4 pml+12
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRGP4 pml+12
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 725
;724:	//
;725:	VectorNormalize (pml.forward);
ADDRGP4 pml
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 726
;726:	VectorNormalize (pml.right);
ADDRGP4 pml+12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 728
;727:
;728:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $296
line 729
;729:		wishvel[i] = pml.forward[i]*fmove + pml.right[i]*smove;
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
ADDRGP4 pml
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml+12
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 730
;730:	}
LABELV $297
line 728
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $296
line 734
;731:	// when going up or down slopes the wish velocity should Not be zero
;732://	wishvel[2] = 0;
;733:
;734:	VectorCopy (wishvel, wishdir);
ADDRLP4 28
ADDRLP4 4
INDIRB
ASGNB 12
line 735
;735:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 28
ARGP4
ADDRLP4 88
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 88
INDIRF4
ASGNF4
line 736
;736:	wishspeed *= scale;
ADDRLP4 24
ADDRLP4 24
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ASGNF4
line 739
;737:
;738:	// clamp the speed lower if ducking
;739:	if ( pm->ps->pm_flags & PMF_DUCKED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $301
line 740
;740:		if ( wishspeed > pm->ps->speed * pm_duckScale ) {
ADDRLP4 24
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_duckScale
INDIRF4
MULF4
LEF4 $303
line 741
;741:			wishspeed = pm->ps->speed * pm_duckScale;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_duckScale
INDIRF4
MULF4
ASGNF4
line 742
;742:		}
LABELV $303
line 743
;743:	}
LABELV $301
line 746
;744:
;745:	// clamp the speed lower if wading or walking on the bottom
;746:	if ( pm->waterlevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
EQI4 $305
line 749
;747:		float	waterScale;
;748:
;749:		waterScale = pm->waterlevel / 3.0;
ADDRLP4 92
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1051372203
MULF4
ASGNF4
line 750
;750:		waterScale = 1.0 - ( 1.0 - pm_swimScale ) * waterScale;
ADDRLP4 92
CNSTF4 1065353216
CNSTF4 1065353216
ADDRGP4 pm_swimScale
INDIRF4
SUBF4
ADDRLP4 92
INDIRF4
MULF4
SUBF4
ASGNF4
line 751
;751:		if ( wishspeed > pm->ps->speed * waterScale ) {
ADDRLP4 24
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 92
INDIRF4
MULF4
LEF4 $307
line 752
;752:			wishspeed = pm->ps->speed * waterScale;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 92
INDIRF4
MULF4
ASGNF4
line 753
;753:		}
LABELV $307
line 754
;754:	}
LABELV $305
line 758
;755:
;756:	// when a player gets hit, they temporarily lose
;757:	// full control, which allows them to be moved a bit
;758:	if ( ( pml.groundTrace.surfaceFlags & SURF_SLICK ) || pm->ps->pm_flags & PMF_TIME_KNOCKBACK ) {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $313
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $309
LABELV $313
line 759
;759:		accelerate = pm_airaccelerate;
ADDRLP4 68
ADDRGP4 pm_airaccelerate
INDIRF4
ASGNF4
line 760
;760:	} else {
ADDRGP4 $310
JUMPV
LABELV $309
line 761
;761:		accelerate = pm_accelerate;
ADDRLP4 68
ADDRGP4 pm_accelerate
INDIRF4
ASGNF4
line 762
;762:	}
LABELV $310
line 764
;763:
;764:	PM_Accelerate (wishdir, wishspeed, accelerate);
ADDRLP4 28
ARGP4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 769
;765:
;766:	//Com_Printf("velocity = %1.1f %1.1f %1.1f\n", pm->ps->velocity[0], pm->ps->velocity[1], pm->ps->velocity[2]);
;767:	//Com_Printf("velocity1 = %1.1f\n", VectorLength(pm->ps->velocity));
;768:
;769:	if ( ( pml.groundTrace.surfaceFlags & SURF_SLICK ) || pm->ps->pm_flags & PMF_TIME_KNOCKBACK ) {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $318
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $314
LABELV $318
line 770
;770:		pm->ps->velocity[2] -= pm->ps->gravity * pml.frametime;
ADDRLP4 92
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 96
ADDRLP4 92
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pml+36
INDIRF4
MULF4
SUBF4
ASGNF4
line 771
;771:	} else {
LABELV $314
line 774
;772:		// don't reset the z velocity for slopes
;773://		pm->ps->velocity[2] = 0;
;774:	}
LABELV $315
line 776
;775: 
;776:	if ( pm_respawntimer ) { // no more overbounce at respawn
ADDRGP4 pm_respawntimer
INDIRI4
CNSTI4 0
EQI4 $320
line 778
;777:		// slide along the ground plane
;778:		PM_ClipVelocity (pm->ps->velocity, pml.groundTrace.plane.normal,
ADDRLP4 92
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 92
INDIRP4
CNSTI4 32
ADDP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 780
;779:			pm->ps->velocity, OVERCLIP );
;780:	} else {
ADDRGP4 $321
JUMPV
LABELV $320
line 781
;781:		vel = VectorLength(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 92
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 72
ADDRLP4 92
INDIRF4
ASGNF4
line 784
;782:
;783:		// slide along the ground plane
;784:		PM_ClipVelocity (pm->ps->velocity, pml.groundTrace.plane.normal,
ADDRLP4 96
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 32
ADDP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 788
;785:			pm->ps->velocity, OVERCLIP );
;786:
;787:		// don't decrease velocity when going up or down a slope
;788:		VectorNormalize(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 789
;789:		VectorScale(pm->ps->velocity, vel, pm->ps->velocity);
ADDRLP4 100
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 100
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 72
INDIRF4
MULF4
ASGNF4
ADDRLP4 104
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 104
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 104
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 72
INDIRF4
MULF4
ASGNF4
ADDRLP4 108
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 108
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 108
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 72
INDIRF4
MULF4
ASGNF4
line 790
;790:	}
LABELV $321
line 793
;791:
;792:	// don't do anything if standing still
;793:	if (!pm->ps->velocity[0] && !pm->ps->velocity[1]) {
ADDRLP4 92
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 0
NEF4 $326
ADDRLP4 92
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
CNSTF4 0
NEF4 $326
line 794
;794:		return;
ADDRGP4 $269
JUMPV
LABELV $326
line 797
;795:	}
;796:
;797:	PM_StepSlideMove( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 801
;798:
;799:	//Com_Printf("velocity2 = %1.1f\n", VectorLength(pm->ps->velocity));
;800:
;801:}
LABELV $269
endproc PM_WalkMove 112 16
proc PM_DeadMove 20 4
line 809
;802:
;803:
;804:/*
;805:==============
;806:PM_DeadMove
;807:==============
;808:*/
;809:static void PM_DeadMove( void ) {
line 812
;810:	float	forward;
;811:
;812:	if ( !pml.walking ) {
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
NEI4 $329
line 813
;813:		return;
ADDRGP4 $328
JUMPV
LABELV $329
line 818
;814:	}
;815:
;816:	// extra friction
;817:
;818:	forward = VectorLength (pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 819
;819:	forward -= 20;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1101004800
SUBF4
ASGNF4
line 820
;820:	if ( forward <= 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
GTF4 $332
line 821
;821:		VectorClear (pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 0
ASGNF4
line 822
;822:	} else {
ADDRGP4 $333
JUMPV
LABELV $332
line 823
;823:		VectorNormalize (pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 824
;824:		VectorScale (pm->ps->velocity, forward, pm->ps->velocity);
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 825
;825:	}
LABELV $333
line 826
;826:}
LABELV $328
endproc PM_DeadMove 20 4
proc PM_NoclipMove 92 12
line 834
;827:
;828:
;829:/*
;830:===============
;831:PM_NoclipMove
;832:===============
;833:*/
;834:static void PM_NoclipMove( void ) {
line 843
;835:	float	speed, drop, friction, control, newspeed;
;836:	int			i;
;837:	vec3_t		wishvel;
;838:	float		fmove, smove;
;839:	vec3_t		wishdir;
;840:	float		wishspeed;
;841:	float		scale;
;842:
;843:	pm->ps->viewheight = DEFAULT_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 26
ASGNI4
line 847
;844:
;845:	// friction
;846:
;847:	speed = VectorLength (pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 64
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 64
INDIRF4
ASGNF4
line 848
;848:	if (speed < 1)
ADDRLP4 24
INDIRF4
CNSTF4 1065353216
GEF4 $335
line 849
;849:	{
line 850
;850:		VectorCopy (vec3_origin, pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDRGP4 vec3_origin
INDIRB
ASGNB 12
line 851
;851:	}
ADDRGP4 $336
JUMPV
LABELV $335
line 853
;852:	else
;853:	{
line 854
;854:		drop = 0;
ADDRLP4 52
CNSTF4 0
ASGNF4
line 856
;855:
;856:		friction = pm_friction*1.5;	// extra friction
ADDRLP4 56
ADDRGP4 pm_friction
INDIRF4
CNSTF4 1069547520
MULF4
ASGNF4
line 857
;857:		control = speed < pm_stopspeed ? pm_stopspeed : speed;
ADDRLP4 24
INDIRF4
ADDRGP4 pm_stopspeed
INDIRF4
GEF4 $338
ADDRLP4 68
ADDRGP4 pm_stopspeed
INDIRF4
ASGNF4
ADDRGP4 $339
JUMPV
LABELV $338
ADDRLP4 68
ADDRLP4 24
INDIRF4
ASGNF4
LABELV $339
ADDRLP4 60
ADDRLP4 68
INDIRF4
ASGNF4
line 858
;858:		drop += control*friction*pml.frametime;
ADDRLP4 52
ADDRLP4 52
INDIRF4
ADDRLP4 60
INDIRF4
ADDRLP4 56
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 861
;859:
;860:		// scale the velocity
;861:		newspeed = speed - drop;
ADDRLP4 28
ADDRLP4 24
INDIRF4
ADDRLP4 52
INDIRF4
SUBF4
ASGNF4
line 862
;862:		if (newspeed < 0)
ADDRLP4 28
INDIRF4
CNSTF4 0
GEF4 $341
line 863
;863:			newspeed = 0;
ADDRLP4 28
CNSTF4 0
ASGNF4
LABELV $341
line 864
;864:		newspeed /= speed;
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 24
INDIRF4
DIVF4
ASGNF4
line 866
;865:
;866:		VectorScale (pm->ps->velocity, newspeed, pm->ps->velocity);
ADDRLP4 72
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 76
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 80
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 867
;867:	}
LABELV $336
line 870
;868:
;869:	// accelerate
;870:	scale = PM_CmdScale( &pm->cmd );
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 68
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 48
ADDRLP4 68
INDIRF4
ASGNF4
line 872
;871:
;872:	fmove = pm->cmd.forwardmove;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 873
;873:	smove = pm->cmd.rightmove;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 875
;874:	
;875:	for (i=0 ; i<3 ; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $343
line 876
;876:		wishvel[i] = pml.forward[i]*fmove + pml.right[i]*smove;
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
ADDRGP4 pml
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml+12
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $344
line 875
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $343
line 877
;877:	wishvel[2] += pm->cmd.upmove;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ADDF4
ASGNF4
line 879
;878:
;879:	VectorCopy (wishvel, wishdir);
ADDRLP4 32
ADDRLP4 4
INDIRB
ASGNB 12
line 880
;880:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 32
ARGP4
ADDRLP4 76
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 76
INDIRF4
ASGNF4
line 881
;881:	wishspeed *= scale;
ADDRLP4 44
ADDRLP4 44
INDIRF4
ADDRLP4 48
INDIRF4
MULF4
ASGNF4
line 883
;882:
;883:	PM_Accelerate( wishdir, wishspeed, pm_accelerate );
ADDRLP4 32
ARGP4
ADDRLP4 44
INDIRF4
ARGF4
ADDRGP4 pm_accelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 886
;884:
;885:	// move
;886:	VectorMA (pm->ps->origin, pml.frametime, pm->ps->velocity, pm->ps->origin);
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 80
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 84
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 84
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 88
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 88
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 88
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 887
;887:}
LABELV $334
endproc PM_NoclipMove 92 12
proc PM_FootstepForSurface 0 0
line 898
;888:
;889://============================================================================
;890:
;891:/*
;892:================
;893:PM_FootstepForSurface
;894:
;895:Returns an event number apropriate for the groundsurface
;896:================
;897:*/
;898:static int PM_FootstepForSurface( void ) {
line 899
;899:	if ( pml.groundTrace.surfaceFlags & SURF_NOSTEPS ) {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $353
line 900
;900:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $352
JUMPV
LABELV $353
line 902
;901:	}
;902:	if ( pml.groundTrace.surfaceFlags & SURF_METALSTEPS ) {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $357
line 903
;903:		return EV_FOOTSTEP_METAL;
CNSTI4 2
RETI4
ADDRGP4 $352
JUMPV
LABELV $357
line 905
;904:	}
;905:	return EV_FOOTSTEP;
CNSTI4 1
RETI4
LABELV $352
endproc PM_FootstepForSurface 0 0
proc PM_CrashLand 52 4
line 916
;906:}
;907:
;908:
;909:/*
;910:=================
;911:PM_CrashLand
;912:
;913:Check for hard landings that generate sound events
;914:=================
;915:*/
;916:static void PM_CrashLand( void ) {
line 924
;917:	float		delta;
;918:	float		dist;
;919:	float		vel, acc;
;920:	float		t;
;921:	float		a, b, c, den;
;922:
;923:	// decide which landing animation to use
;924:	if ( pm->ps->pm_flags & PMF_BACKWARDS_JUMP ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $362
line 925
;925:		PM_ForceLegsAnim( LEGS_LANDB );
CNSTI4 21
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 926
;926:	} else {
ADDRGP4 $363
JUMPV
LABELV $362
line 927
;927:		PM_ForceLegsAnim( LEGS_LAND );
CNSTI4 19
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 928
;928:	}
LABELV $363
line 930
;929:
;930:	pm->ps->legsTimer = TIMER_LAND;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 130
ASGNI4
line 933
;931:
;932:	// calculate the exact velocity on landing
;933:	dist = pm->ps->origin[2] - pml.previous_origin[2];
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRGP4 pml+112+8
INDIRF4
SUBF4
ASGNF4
line 934
;934:	vel = pml.previous_velocity[2];
ADDRLP4 8
ADDRGP4 pml+124+8
INDIRF4
ASGNF4
line 935
;935:	acc = -pm->ps->gravity;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
NEGI4
CVIF4 4
ASGNF4
line 937
;936:
;937:	a = acc / 2;
ADDRLP4 16
ADDRLP4 12
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 938
;938:	b = vel;
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
line 939
;939:	c = -dist;
ADDRLP4 32
ADDRLP4 24
INDIRF4
NEGF4
ASGNF4
line 941
;940:
;941:	den =  b * b - 4 * a * c;
ADDRLP4 20
ADDRLP4 4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ADDRLP4 16
INDIRF4
CNSTF4 1082130432
MULF4
ADDRLP4 32
INDIRF4
MULF4
SUBF4
ASGNF4
line 942
;942:	if ( den < 0 ) {
ADDRLP4 20
INDIRF4
CNSTF4 0
GEF4 $368
line 943
;943:		return;
ADDRGP4 $361
JUMPV
LABELV $368
line 945
;944:	}
;945:	t = (-b - sqrt( den ) ) / ( 2 * a );
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 4
INDIRF4
NEGF4
ADDRLP4 40
INDIRF4
SUBF4
ADDRLP4 16
INDIRF4
CNSTF4 1073741824
MULF4
DIVF4
ASGNF4
line 947
;946:
;947:	delta = vel + t * acc;
ADDRLP4 0
ADDRLP4 8
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 948
;948:	delta = delta*delta * 0.0001;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 953267991
MULF4
ASGNF4
line 951
;949:
;950:	// ducking while falling doubles damage
;951:	if ( pm->ps->pm_flags & PMF_DUCKED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $370
line 952
;952:		delta *= 2;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1073741824
MULF4
ASGNF4
line 953
;953:	}
LABELV $370
line 956
;954:
;955:	// never take falling damage if completely underwater
;956:	if ( pm->waterlevel == 3 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 3
NEI4 $372
line 957
;957:		return;
ADDRGP4 $361
JUMPV
LABELV $372
line 961
;958:	}
;959:
;960:	// reduce falling damage if there is standing water
;961:	if ( pm->waterlevel == 2 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
NEI4 $374
line 962
;962:		delta *= 0.25;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1048576000
MULF4
ASGNF4
line 963
;963:	}
LABELV $374
line 964
;964:	if ( pm->waterlevel == 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
NEI4 $376
line 965
;965:		delta *= 0.5;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 966
;966:	}
LABELV $376
line 968
;967:
;968:	if ( delta < 1 ) {
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
GEF4 $378
line 969
;969:		return;
ADDRGP4 $361
JUMPV
LABELV $378
line 976
;970:	}
;971:
;972:	// create a local entity event to play the sound
;973:
;974:	// SURF_NODAMAGE is used for bounce pads where you don't ever
;975:	// want to take damage or play a crunch sound
;976:	if ( !(pml.groundTrace.surfaceFlags & SURF_NODAMAGE) )  {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $380
line 977
;977:		if ( delta > 60 ) {
ADDRLP4 0
INDIRF4
CNSTF4 1114636288
LEF4 $384
line 978
;978:			PM_AddEvent( EV_FALL_FAR );
CNSTI4 12
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 979
;979:		} else if ( delta > 40 ) {
ADDRGP4 $385
JUMPV
LABELV $384
ADDRLP4 0
INDIRF4
CNSTF4 1109393408
LEF4 $386
line 981
;980:			// this is a pain grunt, so don't play it if dead
;981:			if ( pm->ps->stats[STAT_HEALTH] > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $387
line 982
;982:				PM_AddEvent( EV_FALL_MEDIUM );
CNSTI4 11
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 983
;983:			}
line 984
;984:		} else if ( delta > 7 ) {
ADDRGP4 $387
JUMPV
LABELV $386
ADDRLP4 0
INDIRF4
CNSTF4 1088421888
LEF4 $390
line 985
;985:			PM_AddEvent( EV_FALL_SHORT );
CNSTI4 10
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 986
;986:		} else {
ADDRGP4 $391
JUMPV
LABELV $390
line 987
;987:			PM_AddEvent( PM_FootstepForSurface() );
ADDRLP4 48
ADDRGP4 PM_FootstepForSurface
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 988
;988:		}
LABELV $391
LABELV $387
LABELV $385
line 989
;989:	}
LABELV $380
line 992
;990:
;991:	// start footstep cycle over
;992:	pm->ps->bobCycle = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 0
ASGNI4
line 993
;993:}
LABELV $361
endproc PM_CrashLand 52 4
proc PM_CorrectAllSolid 36 28
line 1016
;994:
;995:/*
;996:=============
;997:PM_CheckStuck
;998:=============
;999:*/
;1000:/*
;1001:void PM_CheckStuck(void) {
;1002:	trace_t trace;
;1003:
;1004:	pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, pm->ps->origin, pm->ps->clientNum, pm->tracemask);
;1005:	if (trace.allsolid) {
;1006:		//int shit = qtrue;
;1007:	}
;1008:}
;1009:*/
;1010:
;1011:/*
;1012:=============
;1013:PM_CorrectAllSolid
;1014:=============
;1015:*/
;1016:static int PM_CorrectAllSolid( trace_t *trace ) {
line 1020
;1017:	int			i, j, k;
;1018:	vec3_t		point;
;1019:
;1020:	if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $393
line 1021
;1021:		Com_Printf("%i:allsolid\n", c_pmove);
ADDRGP4 $395
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1022
;1022:	}
LABELV $393
line 1025
;1023:
;1024:	// jitter around
;1025:	for (i = -1; i <= 1; i++) {
ADDRLP4 20
CNSTI4 -1
ASGNI4
LABELV $396
line 1026
;1026:		for (j = -1; j <= 1; j++) {
ADDRLP4 16
CNSTI4 -1
ASGNI4
LABELV $400
line 1027
;1027:			for (k = -1; k <= 1; k++) {
ADDRLP4 12
CNSTI4 -1
ASGNI4
LABELV $404
line 1028
;1028:				VectorCopy(pm->ps->origin, point);
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1029
;1029:				point[0] += (float) i;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1030
;1030:				point[1] += (float) j;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 16
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1031
;1031:				point[2] += (float) k;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1032
;1032:				pm->trace (trace, point, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 176
ADDP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 188
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
CALLV
pop
line 1033
;1033:				if ( !trace->allsolid ) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $410
line 1034
;1034:					point[0] = pm->ps->origin[0];
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 1035
;1035:					point[1] = pm->ps->origin[1];
ADDRLP4 0+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1036
;1036:					point[2] = pm->ps->origin[2] - 0.25;
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1048576000
SUBF4
ASGNF4
line 1038
;1037:
;1038:					pm->trace (trace, pm->ps->origin, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 176
ADDP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 188
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
CALLV
pop
line 1039
;1039:					pml.groundTrace = *trace;
ADDRGP4 pml+52
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 56
line 1040
;1040:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $392
JUMPV
LABELV $410
line 1042
;1041:				}
;1042:			}
LABELV $405
line 1027
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 1
LEI4 $404
line 1043
;1043:		}
LABELV $401
line 1026
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 1
LEI4 $400
line 1044
;1044:	}
LABELV $397
line 1025
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 1
LEI4 $396
line 1046
;1045:
;1046:	pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1047
;1047:	pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1048
;1048:	pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1050
;1049:
;1050:	return qfalse;
CNSTI4 0
RETI4
LABELV $392
endproc PM_CorrectAllSolid 36 28
proc PM_GroundTraceMissed 80 28
line 1061
;1051:}
;1052:
;1053:
;1054:/*
;1055:=============
;1056:PM_GroundTraceMissed
;1057:
;1058:The ground trace didn't hit a surface, so we are in freefall
;1059:=============
;1060:*/
;1061:static void PM_GroundTraceMissed( void ) {
line 1065
;1062:	trace_t		trace;
;1063:	vec3_t		point;
;1064:
;1065:	if ( pm->ps->groundEntityNum != ENTITYNUM_NONE ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $418
line 1067
;1066:		// we just transitioned into freefall
;1067:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $420
line 1068
;1068:			Com_Printf("%i:lift\n", c_pmove);
ADDRGP4 $422
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1069
;1069:		}
LABELV $420
line 1073
;1070:
;1071:		// if they aren't in a jumping animation and the ground is a ways away, force into it
;1072:		// if we didn't do the trace, the player would be backflipping down staircases
;1073:		VectorCopy( pm->ps->origin, point );
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1074
;1074:		point[2] -= 64;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1115684864
SUBF4
ASGNF4
line 1076
;1075:
;1076:		pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRLP4 12
ARGP4
ADDRLP4 68
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 68
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 176
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 188
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
CALLV
pop
line 1077
;1077:		if ( trace.fraction == 1.0 ) {
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $424
line 1078
;1078:			if ( pm->cmd.forwardmove >= 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LTI4 $427
line 1079
;1079:				PM_ForceLegsAnim( LEGS_JUMP );
CNSTI4 18
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1080
;1080:				pm->ps->pm_flags &= ~PMF_BACKWARDS_JUMP;
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 1081
;1081:			} else {
ADDRGP4 $428
JUMPV
LABELV $427
line 1082
;1082:				PM_ForceLegsAnim( LEGS_JUMPB );
CNSTI4 20
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1083
;1083:				pm->ps->pm_flags |= PMF_BACKWARDS_JUMP;
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 1084
;1084:			}
LABELV $428
line 1085
;1085:		}
LABELV $424
line 1086
;1086:	}
LABELV $418
line 1088
;1087:
;1088:	pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1089
;1089:	pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1090
;1090:	pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1091
;1091:}
LABELV $417
endproc PM_GroundTraceMissed 80 28
proc PM_GroundTrace 84 28
line 1099
;1092:
;1093:
;1094:/*
;1095:=============
;1096:PM_GroundTrace
;1097:=============
;1098:*/
;1099:static void PM_GroundTrace( void ) {
line 1103
;1100:	vec3_t		point;
;1101:	trace_t		trace;
;1102:
;1103:	point[0] = pm->ps->origin[0];
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 1104
;1104:	point[1] = pm->ps->origin[1];
ADDRLP4 56+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1105
;1105:	point[2] = pm->ps->origin[2] - 0.25;
ADDRLP4 56+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1048576000
SUBF4
ASGNF4
line 1107
;1106:
;1107:	pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRLP4 0
ARGP4
ADDRLP4 68
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 68
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 176
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 188
ADDP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
CALLV
pop
line 1108
;1108:	pml.groundTrace = trace;
ADDRGP4 pml+52
ADDRLP4 0
INDIRB
ASGNB 56
line 1111
;1109:
;1110:	// do something corrective if the trace starts in a solid...
;1111:	if ( trace.allsolid ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $435
line 1112
;1112:		if ( !PM_CorrectAllSolid(&trace) )
ADDRLP4 0
ARGP4
ADDRLP4 76
ADDRGP4 PM_CorrectAllSolid
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $437
line 1113
;1113:			return;
ADDRGP4 $431
JUMPV
LABELV $437
line 1114
;1114:	}
LABELV $435
line 1117
;1115:
;1116:	// if the trace didn't hit anything, we are in free fall
;1117:	if ( trace.fraction == 1.0 ) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
NEF4 $439
line 1118
;1118:		PM_GroundTraceMissed();
ADDRGP4 PM_GroundTraceMissed
CALLV
pop
line 1119
;1119:		pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1120
;1120:		pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1121
;1121:		return;
ADDRGP4 $431
JUMPV
LABELV $439
line 1125
;1122:	}
;1123:
;1124:	// check if getting thrown off the ground
;1125:	if ( pm->ps->velocity[2] > 0 && DotProduct( pm->ps->velocity, trace.plane.normal ) > 10 ) {
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 0
LEF4 $444
ADDRLP4 76
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+24
INDIRF4
MULF4
ADDRLP4 76
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 0+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 76
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 0+24+8
INDIRF4
MULF4
ADDF4
CNSTF4 1092616192
LEF4 $444
line 1126
;1126:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $451
line 1127
;1127:			Com_Printf("%i:kickoff\n", c_pmove);
ADDRGP4 $453
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1128
;1128:		}
LABELV $451
line 1130
;1129:		// go into jump animation
;1130:		if ( pm->cmd.forwardmove >= 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LTI4 $454
line 1131
;1131:			PM_ForceLegsAnim( LEGS_JUMP );
CNSTI4 18
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1132
;1132:			pm->ps->pm_flags &= ~PMF_BACKWARDS_JUMP;
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 1133
;1133:		} else {
ADDRGP4 $455
JUMPV
LABELV $454
line 1134
;1134:			PM_ForceLegsAnim( LEGS_JUMPB );
CNSTI4 20
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1135
;1135:			pm->ps->pm_flags |= PMF_BACKWARDS_JUMP;
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 1136
;1136:		}
LABELV $455
line 1138
;1137:
;1138:		pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1139
;1139:		pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1140
;1140:		pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1141
;1141:		return;
ADDRGP4 $431
JUMPV
LABELV $444
line 1145
;1142:	}
;1143:	
;1144:	// slopes that are too steep will not be considered onground
;1145:	if ( trace.plane.normal[2] < MIN_WALK_NORMAL ) {
ADDRLP4 0+24+8
INDIRF4
CNSTF4 1060320051
GEF4 $458
line 1146
;1146:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $462
line 1147
;1147:			Com_Printf("%i:steep\n", c_pmove);
ADDRGP4 $464
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1148
;1148:		}
LABELV $462
line 1151
;1149:		// FIXME: if they can't slide down the slope, let them
;1150:		// walk (sharp crevices)
;1151:		pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1152
;1152:		pml.groundPlane = qtrue;
ADDRGP4 pml+48
CNSTI4 1
ASGNI4
line 1153
;1153:		pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1154
;1154:		return;
ADDRGP4 $431
JUMPV
LABELV $458
line 1157
;1155:	}
;1156:
;1157:	pml.groundPlane = qtrue;
ADDRGP4 pml+48
CNSTI4 1
ASGNI4
line 1158
;1158:	pml.walking = qtrue;
ADDRGP4 pml+44
CNSTI4 1
ASGNI4
line 1161
;1159:
;1160:	// hitting solid ground will end a waterjump
;1161:	if (pm->ps->pm_flags & PMF_TIME_WATERJUMP)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $469
line 1162
;1162:	{
line 1163
;1163:		pm->ps->pm_flags &= ~(PMF_TIME_WATERJUMP | PMF_TIME_LAND);
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 -289
BANDI4
ASGNI4
line 1164
;1164:		pm->ps->pm_time = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 1165
;1165:	}
LABELV $469
line 1167
;1166:
;1167:	if ( pm->ps->groundEntityNum == ENTITYNUM_NONE ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $471
line 1169
;1168:		// just hit the ground
;1169:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $473
line 1170
;1170:			Com_Printf("%i:Land\n", c_pmove);
ADDRGP4 $475
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1171
;1171:		}
LABELV $473
line 1173
;1172:		
;1173:		PM_CrashLand();
ADDRGP4 PM_CrashLand
CALLV
pop
line 1176
;1174:
;1175:		// don't do landing time if we were just going down a slope
;1176:		if ( pml.previous_velocity[2] < -200 ) {
ADDRGP4 pml+124+8
INDIRF4
CNSTF4 3276275712
GEF4 $476
line 1178
;1177:			// don't allow another jump for a little while
;1178:			pm->ps->pm_flags |= PMF_TIME_LAND;
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
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
line 1179
;1179:			pm->ps->pm_time = 250;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 250
ASGNI4
line 1180
;1180:		}
LABELV $476
line 1181
;1181:	}
LABELV $471
line 1183
;1182:
;1183:	pm->ps->groundEntityNum = trace.entityNum;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 0+52
INDIRI4
ASGNI4
line 1188
;1184:
;1185:	// don't reset the z velocity for slopes
;1186://	pm->ps->velocity[2] = 0;
;1187:
;1188:	PM_AddTouchEnt( trace.entityNum );
ADDRLP4 0+52
INDIRI4
ARGI4
ADDRGP4 PM_AddTouchEnt
CALLV
pop
line 1189
;1189:}
LABELV $431
endproc PM_GroundTrace 84 28
proc PM_SetWaterLevel 48 8
line 1197
;1190:
;1191:
;1192:/*
;1193:=============
;1194:PM_SetWaterLevel	FIXME: avoid this twice?  certainly if not moving
;1195:=============
;1196:*/
;1197:static void PM_SetWaterLevel( void ) {
line 1206
;1198:	vec3_t		point;
;1199:	int			cont;
;1200:	int			sample1;
;1201:	int			sample2;
;1202:
;1203:	//
;1204:	// get waterlevel, accounting for ducking
;1205:	//
;1206:	pm->waterlevel = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 0
ASGNI4
line 1207
;1207:	pm->watertype = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTI4 0
ASGNI4
line 1209
;1208:
;1209:	point[0] = pm->ps->origin[0];
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 1210
;1210:	point[1] = pm->ps->origin[1];
ADDRLP4 0+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1211
;1211:	point[2] = pm->ps->origin[2] + MINS_Z + 1;	
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1212
;1212:	cont = pm->pointcontents( point, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 28
INDIRI4
ASGNI4
line 1214
;1213:
;1214:	if ( cont & MASK_WATER ) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $485
line 1215
;1215:		sample2 = pm->ps->viewheight - MINS_Z;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 -24
SUBI4
ASGNI4
line 1216
;1216:		sample1 = sample2 / 2;
ADDRLP4 20
ADDRLP4 16
INDIRI4
CNSTI4 2
DIVI4
ASGNI4
line 1218
;1217:
;1218:		pm->watertype = cont;
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1219
;1219:		pm->waterlevel = 1;
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 1
ASGNI4
line 1220
;1220:		point[2] = pm->ps->origin[2] + MINS_Z + sample1;
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
ADDRLP4 20
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1221
;1221:		cont = pm->pointcontents (point, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 36
INDIRI4
ASGNI4
line 1222
;1222:		if ( cont & MASK_WATER ) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $488
line 1223
;1223:			pm->waterlevel = 2;
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 2
ASGNI4
line 1224
;1224:			point[2] = pm->ps->origin[2] + MINS_Z + sample2;
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
ADDRLP4 16
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1225
;1225:			cont = pm->pointcontents (point, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 40
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
ADDRLP4 40
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 44
INDIRI4
ASGNI4
line 1226
;1226:			if ( cont & MASK_WATER ){
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $491
line 1227
;1227:				pm->waterlevel = 3;
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 3
ASGNI4
line 1228
;1228:			}
LABELV $491
line 1229
;1229:		}
LABELV $488
line 1230
;1230:	}
LABELV $485
line 1232
;1231:
;1232:}
LABELV $482
endproc PM_SetWaterLevel 48 8
proc PM_CheckDuck 72 28
line 1242
;1233:
;1234:/*
;1235:==============
;1236:PM_CheckDuck
;1237:
;1238:Sets mins, maxs, and pm->ps->viewheight
;1239:==============
;1240:*/
;1241:static void PM_CheckDuck (void)
;1242:{
line 1245
;1243:	trace_t	trace;
;1244:
;1245:	if ( pm->ps->powerups[PW_INVULNERABILITY] ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 368
ADDP4
INDIRI4
CNSTI4 0
EQI4 $494
line 1246
;1246:		if ( pm->ps->pm_flags & PMF_INVULEXPAND ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $496
line 1248
;1247:			// invulnerability sphere has a 42 units radius
;1248:			VectorSet( pm->mins, -42, -42, -42 );
ADDRGP4 pm
INDIRP4
CNSTI4 176
ADDP4
CNSTF4 3257401344
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 3257401344
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 3257401344
ASGNF4
line 1249
;1249:			VectorSet( pm->maxs, 42, 42, 42 );
ADDRGP4 pm
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1109917696
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 1109917696
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1109917696
ASGNF4
line 1250
;1250:		}
ADDRGP4 $497
JUMPV
LABELV $496
line 1251
;1251:		else {
line 1252
;1252:			VectorSet( pm->mins, -15, -15, MINS_Z );
ADDRGP4 pm
INDIRP4
CNSTI4 176
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 3250585600
ASGNF4
line 1253
;1253:			VectorSet( pm->maxs, 15, 15, 16 );
ADDRGP4 pm
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1098907648
ASGNF4
line 1254
;1254:		}
LABELV $497
line 1255
;1255:		pm->ps->pm_flags |= PMF_DUCKED;
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1256
;1256:		pm->ps->viewheight = CROUCH_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 12
ASGNI4
line 1257
;1257:		return;
ADDRGP4 $493
JUMPV
LABELV $494
line 1259
;1258:	}
;1259:	pm->ps->pm_flags &= ~PMF_INVULEXPAND;
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 -16385
BANDI4
ASGNI4
line 1261
;1260:
;1261:	pm->mins[0] = -15;
ADDRGP4 pm
INDIRP4
CNSTI4 176
ADDP4
CNSTF4 3245342720
ASGNF4
line 1262
;1262:	pm->mins[1] = -15;
ADDRGP4 pm
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 3245342720
ASGNF4
line 1264
;1263:
;1264:	pm->maxs[0] = 15;
ADDRGP4 pm
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1097859072
ASGNF4
line 1265
;1265:	pm->maxs[1] = 15;
ADDRGP4 pm
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 1097859072
ASGNF4
line 1267
;1266:
;1267:	pm->mins[2] = MINS_Z;
ADDRGP4 pm
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 3250585600
ASGNF4
line 1269
;1268:
;1269:	if (pm->ps->pm_type == PM_DEAD)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $498
line 1270
;1270:	{
line 1271
;1271:		pm->maxs[2] = -8;
ADDRGP4 pm
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 3238002688
ASGNF4
line 1272
;1272:		pm->ps->viewheight = DEAD_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 -16
ASGNI4
line 1273
;1273:		return;
ADDRGP4 $493
JUMPV
LABELV $498
line 1276
;1274:	}
;1275:
;1276:	if (pm->cmd.upmove < 0)
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $500
line 1277
;1277:	{	// duck
line 1278
;1278:		pm->ps->pm_flags |= PMF_DUCKED;
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
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
line 1279
;1279:	}
ADDRGP4 $501
JUMPV
LABELV $500
line 1281
;1280:	else
;1281:	{	// stand up if possible
line 1282
;1282:		if (pm->ps->pm_flags & PMF_DUCKED)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $502
line 1283
;1283:		{
line 1285
;1284:			// try to stand up
;1285:			pm->maxs[2] = 32;
ADDRGP4 pm
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1107296256
ASGNF4
line 1286
;1286:			pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, pm->ps->origin, pm->ps->clientNum, pm->tracemask );
ADDRLP4 0
ARGP4
ADDRLP4 60
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 64
ADDRLP4 60
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 176
ADDP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 188
ADDP4
ARGP4
ADDRLP4 64
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 64
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
CALLV
pop
line 1287
;1287:			if (!trace.allsolid)
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $504
line 1288
;1288:				pm->ps->pm_flags &= ~PMF_DUCKED;
ADDRLP4 68
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
LABELV $504
line 1289
;1289:		}
LABELV $502
line 1290
;1290:	}
LABELV $501
line 1292
;1291:
;1292:	if (pm->ps->pm_flags & PMF_DUCKED)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $506
line 1293
;1293:	{
line 1294
;1294:		pm->maxs[2] = 16;
ADDRGP4 pm
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1098907648
ASGNF4
line 1295
;1295:		pm->ps->viewheight = CROUCH_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 12
ASGNI4
line 1296
;1296:	}
ADDRGP4 $507
JUMPV
LABELV $506
line 1298
;1297:	else
;1298:	{
line 1299
;1299:		pm->maxs[2] = 32;
ADDRGP4 pm
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1107296256
ASGNF4
line 1300
;1300:		pm->ps->viewheight = DEFAULT_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 26
ASGNI4
line 1301
;1301:	}
LABELV $507
line 1302
;1302:}
LABELV $493
endproc PM_CheckDuck 72 28
proc PM_Footsteps 24 4
line 1314
;1303:
;1304:
;1305:
;1306://===================================================================
;1307:
;1308:
;1309:/*
;1310:===============
;1311:PM_Footsteps
;1312:===============
;1313:*/
;1314:static void PM_Footsteps( void ) {
line 1327
;1315:	float		bobmove;
;1316:	float		xyspeedQ;
;1317:	int			old;
;1318:	qboolean	footstep;
;1319:
;1320:	//
;1321:	// calculate speed and cycle to be used for
;1322:	// all cyclic walking effects
;1323:	//
;1324:	//xyspeedQ = pm->ps->velocity[0] * pm->ps->velocity[0] 
;1325:	//	+ pm->ps->velocity[1] * pm->ps->velocity[1];
;1326:
;1327:	if ( pm->ps->groundEntityNum == ENTITYNUM_NONE ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $509
line 1329
;1328:
;1329:		if ( pm->ps->powerups[PW_INVULNERABILITY] ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 368
ADDP4
INDIRI4
CNSTI4 0
EQI4 $511
line 1330
;1330:			PM_ContinueLegsAnim( LEGS_IDLECR );
CNSTI4 23
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1331
;1331:		}
LABELV $511
line 1333
;1332:		// airborne leaves position in cycle intact, but doesn't advance
;1333:		if ( pm->waterlevel > 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
LEI4 $508
line 1334
;1334:			PM_ContinueLegsAnim( LEGS_SWIM );
CNSTI4 17
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1335
;1335:		}
line 1336
;1336:		return;
ADDRGP4 $508
JUMPV
LABELV $509
line 1340
;1337:	}
;1338:
;1339:	// if not trying to move
;1340:	if ( !pm->cmd.forwardmove && !pm->cmd.rightmove ) {
ADDRLP4 16
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $515
ADDRLP4 16
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $515
line 1341
;1341:		xyspeedQ = pm->ps->velocity[0] * pm->ps->velocity[0] 
ADDRLP4 20
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 20
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
MULF4
ADDRLP4 20
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1343
;1342:			+ pm->ps->velocity[1] * pm->ps->velocity[1];
;1343:		if ( xyspeedQ < 5.0*5.0 ) { // not using sqrt() there
ADDRLP4 12
INDIRF4
CNSTF4 1103626240
GEF4 $508
line 1344
;1344:			pm->ps->bobCycle = 0;	// start at beginning of cycle again
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 0
ASGNI4
line 1345
;1345:			if ( pm->ps->pm_flags & PMF_DUCKED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $519
line 1346
;1346:				PM_ContinueLegsAnim( LEGS_IDLECR );
CNSTI4 23
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1347
;1347:			} else {
ADDRGP4 $508
JUMPV
LABELV $519
line 1348
;1348:				PM_ContinueLegsAnim( LEGS_IDLE );
CNSTI4 22
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1349
;1349:			}
line 1350
;1350:		}
line 1351
;1351:		return;
ADDRGP4 $508
JUMPV
LABELV $515
line 1355
;1352:	}
;1353:	
;1354:
;1355:	footstep = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1357
;1356:
;1357:	if ( pm->ps->pm_flags & PMF_DUCKED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $521
line 1358
;1358:		bobmove = 0.5;	// ducked characters bob much faster
ADDRLP4 4
CNSTF4 1056964608
ASGNF4
line 1359
;1359:		if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $523
line 1360
;1360:			PM_ContinueLegsAnim( LEGS_BACKCR );
CNSTI4 32
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1361
;1361:		}
ADDRGP4 $522
JUMPV
LABELV $523
line 1362
;1362:		else {
line 1363
;1363:			PM_ContinueLegsAnim( LEGS_WALKCR );
CNSTI4 13
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1364
;1364:		}
line 1376
;1365:		// ducked characters never play footsteps
;1366:	/*
;1367:	} else 	if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
;1368:		if ( !( pm->cmd.buttons & BUTTON_WALKING ) ) {
;1369:			bobmove = 0.4;	// faster speeds bob faster
;1370:			footstep = qtrue;
;1371:		} else {
;1372:			bobmove = 0.3;
;1373:		}
;1374:		PM_ContinueLegsAnim( LEGS_BACK );
;1375:	*/
;1376:	} else {
ADDRGP4 $522
JUMPV
LABELV $521
line 1377
;1377:		if ( !( pm->cmd.buttons & BUTTON_WALKING ) ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $525
line 1378
;1378:			bobmove = 0.4f;	// faster speeds bob faster
ADDRLP4 4
CNSTF4 1053609165
ASGNF4
line 1379
;1379:			if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $527
line 1380
;1380:				PM_ContinueLegsAnim( LEGS_BACK );
CNSTI4 16
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1381
;1381:			}
ADDRGP4 $528
JUMPV
LABELV $527
line 1382
;1382:			else {
line 1383
;1383:				PM_ContinueLegsAnim( LEGS_RUN );
CNSTI4 15
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1384
;1384:			}
LABELV $528
line 1385
;1385:			footstep = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 1386
;1386:		} else {
ADDRGP4 $526
JUMPV
LABELV $525
line 1387
;1387:			bobmove = 0.3f;	// walking bobs slow
ADDRLP4 4
CNSTF4 1050253722
ASGNF4
line 1388
;1388:			if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $529
line 1389
;1389:				PM_ContinueLegsAnim( LEGS_BACKWALK );
CNSTI4 33
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1390
;1390:			}
ADDRGP4 $530
JUMPV
LABELV $529
line 1391
;1391:			else {
line 1392
;1392:				PM_ContinueLegsAnim( LEGS_WALK );
CNSTI4 14
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1393
;1393:			}
LABELV $530
line 1394
;1394:		}
LABELV $526
line 1395
;1395:	}
LABELV $522
line 1398
;1396:
;1397:	// check for footstep / splash sounds
;1398:	old = pm->ps->bobCycle;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1399
;1399:	pm->ps->bobCycle = (int)( old + bobmove * pml.msec ) & 255;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
ADDRGP4 pml+40
INDIRI4
CVIF4 4
MULF4
ADDF4
CVFI4 4
CNSTI4 255
BANDI4
ASGNI4
line 1402
;1400:
;1401:	// if we just crossed a cycle boundary, play an apropriate footstep event
;1402:	if ( ( ( old + 64 ) ^ ( pm->ps->bobCycle + 64 ) ) & 128 ) {
ADDRLP4 0
INDIRI4
CNSTI4 64
ADDI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 64
ADDI4
BXORI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $532
line 1403
;1403:		if ( pm->waterlevel == 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
NEI4 $534
line 1405
;1404:			// on ground will only play sounds if running
;1405:			if ( footstep ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $535
line 1406
;1406:				PM_AddEvent( PM_FootstepForSurface() );
ADDRLP4 20
ADDRGP4 PM_FootstepForSurface
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1407
;1407:			}
line 1408
;1408:		} else if ( pm->waterlevel == 1 ) {
ADDRGP4 $535
JUMPV
LABELV $534
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
NEI4 $538
line 1410
;1409:			// splashing
;1410:			PM_AddEvent( EV_FOOTSPLASH );
CNSTI4 3
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1411
;1411:		} else if ( pm->waterlevel == 2 ) {
ADDRGP4 $539
JUMPV
LABELV $538
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
NEI4 $540
line 1413
;1412:			// wading / swimming at surface
;1413:			PM_AddEvent( EV_SWIM );
CNSTI4 5
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1414
;1414:		} else if ( pm->waterlevel == 3 ) {
ADDRGP4 $541
JUMPV
LABELV $540
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 3
NEI4 $542
line 1417
;1415:			// no sound when completely underwater
;1416:
;1417:		}
LABELV $542
LABELV $541
LABELV $539
LABELV $535
line 1418
;1418:	}
LABELV $532
line 1419
;1419:}
LABELV $508
endproc PM_Footsteps 24 4
proc PM_WaterEvents 0 4
line 1428
;1420:
;1421:/*
;1422:==============
;1423:PM_WaterEvents
;1424:
;1425:Generate sound events for entering and leaving water
;1426:==============
;1427:*/
;1428:static void PM_WaterEvents( void ) {		// FIXME?
line 1432
;1429:	//
;1430:	// if just entered a water volume, play a sound
;1431:	//
;1432:	if (!pml.previous_waterlevel && pm->waterlevel) {
ADDRGP4 pml+136
INDIRI4
CNSTI4 0
NEI4 $545
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
EQI4 $545
line 1433
;1433:		PM_AddEvent( EV_WATER_TOUCH );
CNSTI4 15
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1434
;1434:	}
LABELV $545
line 1439
;1435:
;1436:	//
;1437:	// if just completely exited a water volume, play a sound
;1438:	//
;1439:	if (pml.previous_waterlevel && !pm->waterlevel) {
ADDRGP4 pml+136
INDIRI4
CNSTI4 0
EQI4 $548
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
NEI4 $548
line 1440
;1440:		PM_AddEvent( EV_WATER_LEAVE );
CNSTI4 16
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1441
;1441:	}
LABELV $548
line 1446
;1442:
;1443:	//
;1444:	// check for head just going under water
;1445:	//
;1446:	if (pml.previous_waterlevel != 3 && pm->waterlevel == 3) {
ADDRGP4 pml+136
INDIRI4
CNSTI4 3
EQI4 $551
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 3
NEI4 $551
line 1447
;1447:		PM_AddEvent( EV_WATER_UNDER );
CNSTI4 17
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1448
;1448:	}
LABELV $551
line 1453
;1449:
;1450:	//
;1451:	// check for head just coming out of water
;1452:	//
;1453:	if (pml.previous_waterlevel == 3 && pm->waterlevel != 3) {
ADDRGP4 pml+136
INDIRI4
CNSTI4 3
NEI4 $554
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 3
EQI4 $554
line 1454
;1454:		PM_AddEvent( EV_WATER_CLEAR );
CNSTI4 18
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1455
;1455:	}
LABELV $554
line 1456
;1456:}
LABELV $544
endproc PM_WaterEvents 0 4
proc PM_BeginWeaponChange 8 4
line 1464
;1457:
;1458:
;1459:/*
;1460:===============
;1461:PM_BeginWeaponChange
;1462:===============
;1463:*/
;1464:static void PM_BeginWeaponChange( int weapon ) {
line 1465
;1465:	if ( weapon <= WP_NONE || weapon >= WP_NUM_WEAPONS ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $560
ADDRLP4 0
INDIRI4
CNSTI4 14
LTI4 $558
LABELV $560
line 1466
;1466:		return;
ADDRGP4 $557
JUMPV
LABELV $558
line 1469
;1467:	}
;1468:
;1469:	if ( !( pm->ps->stats[STAT_WEAPONS] & ( 1 << weapon ) ) ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 1
ADDRFP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $561
line 1470
;1470:		return;
ADDRGP4 $557
JUMPV
LABELV $561
line 1473
;1471:	}
;1472:	
;1473:	if ( pm->ps->weaponstate == WEAPON_DROPPING ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
NEI4 $563
line 1474
;1474:		pm->ps->eFlags &= ~EF_FIRING;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 1475
;1475:		return;
ADDRGP4 $557
JUMPV
LABELV $563
line 1478
;1476:	}
;1477:
;1478:	PM_AddEvent( EV_CHANGE_WEAPON );
CNSTI4 22
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1479
;1479:	pm->ps->weaponstate = WEAPON_DROPPING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 2
ASGNI4
line 1480
;1480:	pm->ps->weaponTime += 200;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 1481
;1481:	PM_StartTorsoAnim( TORSO_DROP );
CNSTI4 9
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1482
;1482:}
LABELV $557
endproc PM_BeginWeaponChange 8 4
proc PM_FinishWeaponChange 16 4
line 1490
;1483:
;1484:
;1485:/*
;1486:===============
;1487:PM_FinishWeaponChange
;1488:===============
;1489:*/
;1490:static void PM_FinishWeaponChange( void ) {
line 1493
;1491:	int		weapon;
;1492:
;1493:	weapon = pm->cmd.weapon;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
ASGNI4
line 1494
;1494:	if ( weapon < WP_NONE || weapon >= WP_NUM_WEAPONS ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $568
ADDRLP4 0
INDIRI4
CNSTI4 14
LTI4 $566
LABELV $568
line 1495
;1495:		weapon = WP_NONE;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1496
;1496:	}
LABELV $566
line 1498
;1497:
;1498:	if ( !( pm->ps->stats[STAT_WEAPONS] & ( 1 << weapon ) ) ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $569
line 1499
;1499:		weapon = WP_NONE;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1500
;1500:	}
LABELV $569
line 1502
;1501:
;1502:	pm->ps->weapon = weapon;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1503
;1503:	pm->ps->weaponstate = WEAPON_RAISING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 1
ASGNI4
line 1504
;1504:	pm->ps->eFlags &= ~EF_FIRING;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 1505
;1505:	pm->ps->weaponTime += 250;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 250
ADDI4
ASGNI4
line 1506
;1506:	PM_StartTorsoAnim( TORSO_RAISE );
CNSTI4 10
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1507
;1507:}
LABELV $565
endproc PM_FinishWeaponChange 16 4
proc PM_TorsoAnimation 0 4
line 1516
;1508:
;1509:
;1510:/*
;1511:==============
;1512:PM_TorsoAnimation
;1513:
;1514:==============
;1515:*/
;1516:static void PM_TorsoAnimation( void ) {
line 1517
;1517:	if ( pm->ps->weaponstate == WEAPON_READY ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 0
NEI4 $572
line 1518
;1518:		if ( pm->ps->weapon == WP_GAUNTLET ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $574
line 1519
;1519:			PM_ContinueTorsoAnim( TORSO_STAND2 );
CNSTI4 12
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1520
;1520:		} else {
ADDRGP4 $571
JUMPV
LABELV $574
line 1521
;1521:			PM_ContinueTorsoAnim( TORSO_STAND );
CNSTI4 11
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1522
;1522:		}
line 1523
;1523:		return;
LABELV $572
line 1525
;1524:	}
;1525:}
LABELV $571
endproc PM_TorsoAnimation 0 4
proc PM_Weapon 28 4
line 1535
;1526:
;1527:
;1528:/*
;1529:==============
;1530:PM_Weapon
;1531:
;1532:Generates weapon events and modifes the weapon counter
;1533:==============
;1534:*/
;1535:static void PM_Weapon( void ) {
line 1539
;1536:	int		addTime;
;1537:
;1538:	// don't allow attack until all buttons are up
;1539:	if ( pm->ps->pm_flags & PMF_RESPAWNED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $577
line 1540
;1540:		return;
ADDRGP4 $576
JUMPV
LABELV $577
line 1544
;1541:	}
;1542:
;1543:	// ignore if spectator
;1544:	if ( pm->ps->persistant[PERS_TEAM] == TEAM_SPECTATOR ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 3
NEI4 $579
line 1545
;1545:		return;
ADDRGP4 $576
JUMPV
LABELV $579
line 1549
;1546:	}
;1547:
;1548:	// check for dead player
;1549:	if ( pm->ps->stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $581
line 1550
;1550:		pm->ps->weapon = WP_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 0
ASGNI4
line 1551
;1551:		return;
ADDRGP4 $576
JUMPV
LABELV $581
line 1555
;1552:	}
;1553:
;1554:	// check for item using
;1555:	if ( pm->cmd.buttons & BUTTON_USE_HOLDABLE ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $583
line 1556
;1556:		if ( ! ( pm->ps->pm_flags & PMF_USE_ITEM_HELD ) ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
NEI4 $584
line 1557
;1557:			if ( bg_itemlist[pm->ps->stats[STAT_HOLDABLE_ITEM]].giTag == HI_MEDKIT
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 2
NEI4 $587
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 25
ADDI4
LTI4 $587
line 1558
;1558:				&& pm->ps->stats[STAT_HEALTH] >= (pm->ps->stats[STAT_MAX_HEALTH] + 25) ) {
line 1560
;1559:				// don't use medkit if at max health
;1560:			} else {
ADDRGP4 $576
JUMPV
LABELV $587
line 1561
;1561:				pm->ps->pm_flags |= PMF_USE_ITEM_HELD;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 1562
;1562:				PM_AddEvent( EV_USE_ITEM0 + bg_itemlist[pm->ps->stats[STAT_HOLDABLE_ITEM]].giTag );
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 24
ADDI4
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1563
;1563:				pm->ps->stats[STAT_HOLDABLE_ITEM] = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 1564
;1564:			}
line 1565
;1565:			return;
ADDRGP4 $576
JUMPV
line 1567
;1566:		}
;1567:	} else {
LABELV $583
line 1568
;1568:		pm->ps->pm_flags &= ~PMF_USE_ITEM_HELD;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 1569
;1569:	}
LABELV $584
line 1573
;1570:
;1571:
;1572:	// make weapon function
;1573:	if ( pm->ps->weaponTime > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $591
line 1574
;1574:		pm->ps->weaponTime -= pml.msec;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1575
;1575:	}
LABELV $591
line 1580
;1576:
;1577:	// check for weapon change
;1578:	// can't change if weapon is firing, but can change
;1579:	// again if lowering or raising
;1580:	if ( pm->ps->weaponTime <= 0 || pm->ps->weaponstate != WEAPON_FIRING ) {
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $596
ADDRLP4 4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 3
EQI4 $594
LABELV $596
line 1581
;1581:		if ( pm->ps->weapon != pm->cmd.weapon ) {
ADDRLP4 8
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
EQI4 $597
line 1582
;1582:			PM_BeginWeaponChange( pm->cmd.weapon );
ADDRGP4 pm
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
ARGI4
ADDRGP4 PM_BeginWeaponChange
CALLV
pop
line 1583
;1583:		}
LABELV $597
line 1584
;1584:	}
LABELV $594
line 1586
;1585:
;1586:	if ( pm->ps->weaponTime > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $599
line 1587
;1587:		return;
ADDRGP4 $576
JUMPV
LABELV $599
line 1591
;1588:	}
;1589:
;1590:	// change weapon if time
;1591:	if ( pm->ps->weaponstate == WEAPON_DROPPING ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
NEI4 $601
line 1592
;1592:		PM_FinishWeaponChange();
ADDRGP4 PM_FinishWeaponChange
CALLV
pop
line 1593
;1593:		return;
ADDRGP4 $576
JUMPV
LABELV $601
line 1596
;1594:	}
;1595:
;1596:	if ( pm->ps->weaponstate == WEAPON_RAISING ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 1
NEI4 $603
line 1597
;1597:		pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 1598
;1598:		if ( pm->ps->weapon == WP_GAUNTLET ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $605
line 1599
;1599:			PM_StartTorsoAnim( TORSO_STAND2 );
CNSTI4 12
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1600
;1600:		} else {
ADDRGP4 $576
JUMPV
LABELV $605
line 1601
;1601:			PM_StartTorsoAnim( TORSO_STAND );
CNSTI4 11
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1602
;1602:		}
line 1603
;1603:		return;
ADDRGP4 $576
JUMPV
LABELV $603
line 1607
;1604:	}
;1605:
;1606:	// check for fire
;1607:	if ( ! (pm->cmd.buttons & BUTTON_ATTACK) ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $607
line 1608
;1608:		pm->ps->weaponTime = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 1609
;1609:		pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 1610
;1610:		return;
ADDRGP4 $576
JUMPV
LABELV $607
line 1614
;1611:	}
;1612:
;1613:	// start the animation even if out of ammo
;1614:	if ( pm->ps->weapon == WP_GAUNTLET ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $609
line 1616
;1615:		// the guantlet only "fires" when it actually hits something
;1616:		if ( !pm->gauntletHit ) {
ADDRGP4 pm
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 0
NEI4 $611
line 1617
;1617:			pm->ps->weaponTime = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 1618
;1618:			pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 1619
;1619:			return;
ADDRGP4 $576
JUMPV
LABELV $611
line 1621
;1620:		}
;1621:		PM_StartTorsoAnim( TORSO_ATTACK2 );
CNSTI4 8
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1622
;1622:	} else {
ADDRGP4 $610
JUMPV
LABELV $609
line 1623
;1623:		PM_StartTorsoAnim( TORSO_ATTACK );
CNSTI4 7
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1624
;1624:	}
LABELV $610
line 1626
;1625:
;1626:	pm->ps->weaponstate = WEAPON_FIRING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 3
ASGNI4
line 1629
;1627:
;1628:	// check for out of ammo
;1629:	if ( ! pm->ps->ammo[ pm->ps->weapon ] ) {
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $613
line 1630
;1630:		PM_AddEvent( EV_NOAMMO );
CNSTI4 21
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1631
;1631:		pm->ps->weaponTime += 500;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 1632
;1632:		return;
ADDRGP4 $576
JUMPV
LABELV $613
line 1636
;1633:	}
;1634:
;1635:	// take an ammo away if not infinite
;1636:	if ( pm->ps->ammo[ pm->ps->weapon ] != -1 ) {
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $615
line 1637
;1637:		pm->ps->ammo[ pm->ps->weapon ]--;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 376
ADDP4
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1638
;1638:	}
LABELV $615
line 1641
;1639:
;1640:	// fire weapon
;1641:	PM_AddEvent( EV_FIRE_WEAPON );
CNSTI4 23
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1643
;1642:
;1643:	switch( pm->ps->weapon ) {
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 1
LTI4 $617
ADDRLP4 16
INDIRI4
CNSTI4 13
GTI4 $617
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $633-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $633
address $620
address $623
address $622
address $624
address $625
address $621
address $627
address $626
address $628
address $629
address $630
address $631
address $632
code
LABELV $617
LABELV $620
line 1646
;1644:	default:
;1645:	case WP_GAUNTLET:
;1646:		addTime = 400;
ADDRLP4 0
CNSTI4 400
ASGNI4
line 1647
;1647:		break;
ADDRGP4 $618
JUMPV
LABELV $621
line 1649
;1648:	case WP_LIGHTNING:
;1649:		addTime = 50;
ADDRLP4 0
CNSTI4 50
ASGNI4
line 1650
;1650:		break;
ADDRGP4 $618
JUMPV
LABELV $622
line 1652
;1651:	case WP_SHOTGUN:
;1652:		addTime = 1000;
ADDRLP4 0
CNSTI4 1000
ASGNI4
line 1653
;1653:		break;
ADDRGP4 $618
JUMPV
LABELV $623
line 1655
;1654:	case WP_MACHINEGUN:
;1655:		addTime = 100;
ADDRLP4 0
CNSTI4 100
ASGNI4
line 1656
;1656:		break;
ADDRGP4 $618
JUMPV
LABELV $624
line 1658
;1657:	case WP_GRENADE_LAUNCHER:
;1658:		addTime = 800;
ADDRLP4 0
CNSTI4 800
ASGNI4
line 1659
;1659:		break;
ADDRGP4 $618
JUMPV
LABELV $625
line 1661
;1660:	case WP_ROCKET_LAUNCHER:
;1661:		addTime = 800;
ADDRLP4 0
CNSTI4 800
ASGNI4
line 1662
;1662:		break;
ADDRGP4 $618
JUMPV
LABELV $626
line 1664
;1663:	case WP_PLASMAGUN:
;1664:		addTime = 100;
ADDRLP4 0
CNSTI4 100
ASGNI4
line 1665
;1665:		break;
ADDRGP4 $618
JUMPV
LABELV $627
line 1667
;1666:	case WP_RAILGUN:
;1667:		addTime = 1500;
ADDRLP4 0
CNSTI4 1500
ASGNI4
line 1668
;1668:		break;
ADDRGP4 $618
JUMPV
LABELV $628
line 1670
;1669:	case WP_BFG:
;1670:		addTime = 200;
ADDRLP4 0
CNSTI4 200
ASGNI4
line 1671
;1671:		break;
ADDRGP4 $618
JUMPV
LABELV $629
line 1673
;1672:	case WP_GRAPPLING_HOOK:
;1673:		addTime = 400;
ADDRLP4 0
CNSTI4 400
ASGNI4
line 1674
;1674:		break;
ADDRGP4 $618
JUMPV
LABELV $630
line 1677
;1675:#ifdef MISSIONPACK
;1676:	case WP_NAILGUN:
;1677:		addTime = 1000;
ADDRLP4 0
CNSTI4 1000
ASGNI4
line 1678
;1678:		break;
ADDRGP4 $618
JUMPV
LABELV $631
line 1680
;1679:	case WP_PROX_LAUNCHER:
;1680:		addTime = 800;
ADDRLP4 0
CNSTI4 800
ASGNI4
line 1681
;1681:		break;
ADDRGP4 $618
JUMPV
LABELV $632
line 1683
;1682:	case WP_CHAINGUN:
;1683:		addTime = 30;
ADDRLP4 0
CNSTI4 30
ASGNI4
line 1684
;1684:		break;
LABELV $618
line 1689
;1685:#endif
;1686:	}
;1687:
;1688:#ifdef MISSIONPACK
;1689:	if( bg_itemlist[pm->ps->stats[STAT_PERSISTANT_POWERUP]].giTag == PW_SCOUT ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 10
NEI4 $635
line 1690
;1690:		addTime /= 1.5;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1059760811
MULF4
CVFI4 4
ASGNI4
line 1691
;1691:	}
ADDRGP4 $636
JUMPV
LABELV $635
line 1693
;1692:	else
;1693:	if( bg_itemlist[pm->ps->stats[STAT_PERSISTANT_POWERUP]].giTag == PW_AMMOREGEN ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 13
NEI4 $638
line 1694
;1694:		addTime /= 1.3;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1061481551
MULF4
CVFI4 4
ASGNI4
line 1695
;1695:	}
ADDRGP4 $639
JUMPV
LABELV $638
line 1698
;1696:	else
;1697:#endif
;1698:	if ( pm->ps->powerups[PW_HASTE] ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 324
ADDP4
INDIRI4
CNSTI4 0
EQI4 $641
line 1699
;1699:		addTime /= 1.3;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1061481551
MULF4
CVFI4 4
ASGNI4
line 1700
;1700:	}
LABELV $641
LABELV $639
LABELV $636
line 1702
;1701:
;1702:	pm->ps->weaponTime += addTime;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 1703
;1703:}
LABELV $576
endproc PM_Weapon 28 4
proc PM_Animate 0 4
line 1711
;1704:
;1705:/*
;1706:================
;1707:PM_Animate
;1708:================
;1709:*/
;1710:
;1711:static void PM_Animate( void ) {
line 1712
;1712:	if ( pm->cmd.buttons & BUTTON_GESTURE ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $644
line 1713
;1713:		if ( pm->ps->torsoTimer == 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $645
line 1714
;1714:			PM_StartTorsoAnim( TORSO_GESTURE );
CNSTI4 6
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1715
;1715:			pm->ps->torsoTimer = TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 2294
ASGNI4
line 1716
;1716:			PM_AddEvent( EV_TAUNT );
CNSTI4 76
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1717
;1717:		}
line 1719
;1718:#ifdef MISSIONPACK
;1719:	} else if ( pm->cmd.buttons & BUTTON_GETFLAG ) {
ADDRGP4 $645
JUMPV
LABELV $644
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $648
line 1720
;1720:		if ( pm->ps->torsoTimer == 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $649
line 1721
;1721:			PM_StartTorsoAnim( TORSO_GETFLAG );
CNSTI4 25
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1722
;1722:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 600
ASGNI4
line 1723
;1723:		}
line 1724
;1724:	} else if ( pm->cmd.buttons & BUTTON_GUARDBASE ) {
ADDRGP4 $649
JUMPV
LABELV $648
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $652
line 1725
;1725:		if ( pm->ps->torsoTimer == 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $653
line 1726
;1726:			PM_StartTorsoAnim( TORSO_GUARDBASE );
CNSTI4 26
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1727
;1727:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 600
ASGNI4
line 1728
;1728:		}
line 1729
;1729:	} else if ( pm->cmd.buttons & BUTTON_PATROL ) {
ADDRGP4 $653
JUMPV
LABELV $652
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $656
line 1730
;1730:		if ( pm->ps->torsoTimer == 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $657
line 1731
;1731:			PM_StartTorsoAnim( TORSO_PATROL );
CNSTI4 27
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1732
;1732:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 600
ASGNI4
line 1733
;1733:		}
line 1734
;1734:	} else if ( pm->cmd.buttons & BUTTON_FOLLOWME ) {
ADDRGP4 $657
JUMPV
LABELV $656
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $660
line 1735
;1735:		if ( pm->ps->torsoTimer == 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $661
line 1736
;1736:			PM_StartTorsoAnim( TORSO_FOLLOWME );
CNSTI4 28
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1737
;1737:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 600
ASGNI4
line 1738
;1738:		}
line 1739
;1739:	} else if ( pm->cmd.buttons & BUTTON_AFFIRMATIVE ) {
ADDRGP4 $661
JUMPV
LABELV $660
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $664
line 1740
;1740:		if ( pm->ps->torsoTimer == 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $665
line 1741
;1741:			PM_StartTorsoAnim( TORSO_AFFIRMATIVE);
CNSTI4 29
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1742
;1742:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 600
ASGNI4
line 1743
;1743:		}
line 1744
;1744:	} else if ( pm->cmd.buttons & BUTTON_NEGATIVE ) {
ADDRGP4 $665
JUMPV
LABELV $664
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $668
line 1745
;1745:		if ( pm->ps->torsoTimer == 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $670
line 1746
;1746:			PM_StartTorsoAnim( TORSO_NEGATIVE );
CNSTI4 30
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1747
;1747:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 600
ASGNI4
line 1748
;1748:		}
LABELV $670
line 1750
;1749:#endif
;1750:	}
LABELV $668
LABELV $665
LABELV $661
LABELV $657
LABELV $653
LABELV $649
LABELV $645
line 1751
;1751:}
LABELV $643
endproc PM_Animate 0 4
proc PM_DropTimers 4 0
line 1759
;1752:
;1753:
;1754:/*
;1755:================
;1756:PM_DropTimers
;1757:================
;1758:*/
;1759:static void PM_DropTimers( void ) {
line 1761
;1760:	// drop misc timing counter
;1761:	if ( pm->ps->pm_time ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $673
line 1762
;1762:		if ( pml.msec >= pm->ps->pm_time ) {
ADDRGP4 pml+40
INDIRI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
LTI4 $675
line 1763
;1763:			pm->ps->pm_flags &= ~PMF_ALL_TIMES;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -353
BANDI4
ASGNI4
line 1764
;1764:			pm->ps->pm_time = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 1765
;1765:		} else {
ADDRGP4 $676
JUMPV
LABELV $675
line 1766
;1766:			pm->ps->pm_time -= pml.msec;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1767
;1767:		}
LABELV $676
line 1768
;1768:	}
LABELV $673
line 1771
;1769:
;1770:	// drop animation counter
;1771:	if ( pm->ps->legsTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
LEI4 $679
line 1772
;1772:		pm->ps->legsTimer -= pml.msec;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1773
;1773:		if ( pm->ps->legsTimer < 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
GEI4 $682
line 1774
;1774:			pm->ps->legsTimer = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 1775
;1775:		}
LABELV $682
line 1776
;1776:	}
LABELV $679
line 1778
;1777:
;1778:	if ( pm->ps->torsoTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
LEI4 $684
line 1779
;1779:		pm->ps->torsoTimer -= pml.msec;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1780
;1780:		if ( pm->ps->torsoTimer < 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
GEI4 $687
line 1781
;1781:			pm->ps->torsoTimer = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 0
ASGNI4
line 1782
;1782:		}
LABELV $687
line 1783
;1783:	}
LABELV $684
line 1784
;1784:}
LABELV $672
endproc PM_DropTimers 4 0
export PM_UpdateViewAngles
proc PM_UpdateViewAngles 24 0
line 1794
;1785:
;1786:/*
;1787:================
;1788:PM_UpdateViewAngles
;1789:
;1790:This can be used as another entry point when only the viewangles
;1791:are being updated instead of a full move
;1792:================
;1793:*/
;1794:void PM_UpdateViewAngles( playerState_t *ps, const usercmd_t *cmd ) {
line 1798
;1795:	short		temp;
;1796:	int		i;
;1797:
;1798:	if ( ps->pm_type == PM_INTERMISSION || ps->pm_type == PM_SPINTERMISSION) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 5
EQI4 $692
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 6
NEI4 $690
LABELV $692
line 1799
;1799:		return;		// no view changes at all
ADDRGP4 $689
JUMPV
LABELV $690
line 1802
;1800:	}
;1801:
;1802:	if ( ps->pm_type != PM_SPECTATOR && ps->stats[STAT_HEALTH] <= 0 ) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $693
ADDRLP4 12
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $693
line 1803
;1803:		return;		// no view changes at all
ADDRGP4 $689
JUMPV
LABELV $693
line 1807
;1804:	}
;1805:
;1806:	// circularly clamp the angles with deltas
;1807:	for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $695
line 1808
;1808:		temp = cmd->angles[i] + ps->delta_angles[i];
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
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDP4
INDIRI4
ADDI4
CVII2 4
ASGNI2
line 1809
;1809:		if ( i == PITCH ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $699
line 1811
;1810:			// don't let the player look up or down more than 90 degrees
;1811:			if ( temp > 16000 ) {
ADDRLP4 4
INDIRI2
CVII4 2
CNSTI4 16000
LEI4 $701
line 1812
;1812:				ps->delta_angles[i] = (16000 - cmd->angles[i]) & 0xFFFF;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDP4
CNSTI4 16000
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
SUBI4
CNSTI4 65535
BANDI4
ASGNI4
line 1813
;1813:				temp = 16000;
ADDRLP4 4
CNSTI2 16000
ASGNI2
line 1814
;1814:			} else if ( temp < -16000 ) {
ADDRGP4 $702
JUMPV
LABELV $701
ADDRLP4 4
INDIRI2
CVII4 2
CNSTI4 -16000
GEI4 $703
line 1815
;1815:				ps->delta_angles[i] = (-16000 - cmd->angles[i]) & 0xFFFF;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDP4
CNSTI4 -16000
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
SUBI4
CNSTI4 65535
BANDI4
ASGNI4
line 1816
;1816:				temp = -16000;
ADDRLP4 4
CNSTI2 -16000
ASGNI2
line 1817
;1817:			}
LABELV $703
LABELV $702
line 1818
;1818:		}
LABELV $699
line 1819
;1819:		ps->viewangles[i] = SHORT2ANGLE(temp);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ADDP4
ADDRLP4 4
INDIRI2
CVII4 2
CVIF4 4
CNSTF4 1001652224
MULF4
ASGNF4
line 1820
;1820:	}
LABELV $696
line 1807
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $695
line 1822
;1821:
;1822:}
LABELV $689
endproc PM_UpdateViewAngles 24 0
export PmoveSingle
proc PmoveSingle 36 16
line 1833
;1823:
;1824:
;1825:/*
;1826:================
;1827:PmoveSingle
;1828:
;1829:================
;1830:*/
;1831:void trap_SnapVector( float *v );
;1832:
;1833:void PmoveSingle (pmove_t *pmove) {
line 1834
;1834:	pm = pmove;
ADDRGP4 pm
ADDRFP4 0
INDIRP4
ASGNP4
line 1838
;1835:
;1836:	// this counter lets us debug movement problems with a journal
;1837:	// by setting a conditional breakpoint fot the previous frame
;1838:	c_pmove++;
ADDRLP4 0
ADDRGP4 c_pmove
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1841
;1839:
;1840:	// clear results
;1841:	pm->numtouch = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 1842
;1842:	pm->watertype = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTI4 0
ASGNI4
line 1843
;1843:	pm->waterlevel = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 0
ASGNI4
line 1845
;1844:
;1845:	if ( pm->ps->stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $706
line 1846
;1846:		pm->tracemask &= ~CONTENTS_BODY;	// corpses can fly through bodies
ADDRLP4 4
ADDRGP4 pm
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -33554433
BANDI4
ASGNI4
line 1847
;1847:	}
LABELV $706
line 1851
;1848:
;1849:	// make sure walking button is clear if they are running, to avoid
;1850:	// proxy no-footsteps cheats
;1851:	if ( abs( pm->cmd.forwardmove ) > 64 || abs( pm->cmd.rightmove ) > 64 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 4
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 64
GTI4 $710
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 64
LEI4 $708
LABELV $710
line 1852
;1852:		pm->cmd.buttons &= ~BUTTON_WALKING;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 1853
;1853:	}
LABELV $708
line 1856
;1854:
;1855:	// set the talk balloon flag
;1856:	if ( pm->cmd.buttons & BUTTON_TALK ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $711
line 1857
;1857:		pm->ps->eFlags |= EF_TALK;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 1858
;1858:	} else {
ADDRGP4 $712
JUMPV
LABELV $711
line 1859
;1859:		pm->ps->eFlags &= ~EF_TALK;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 -4097
BANDI4
ASGNI4
line 1860
;1860:	}
LABELV $712
line 1863
;1861:
;1862:	// set the firing flag for continuous beam weapons
;1863:	if ( !(pm->ps->pm_flags & PMF_RESPAWNED) && pm->ps->pm_type != PM_INTERMISSION && pm->ps->pm_type != PM_NOCLIP
ADDRLP4 12
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
NEI4 $713
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 5
EQI4 $713
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
EQI4 $713
ADDRLP4 12
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $713
ADDRLP4 16
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $713
line 1864
;1864:		&& ( pm->cmd.buttons & BUTTON_ATTACK ) && pm->ps->ammo[ pm->ps->weapon ] ) {
line 1865
;1865:		pm->ps->eFlags |= EF_FIRING;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 1866
;1866:	} else {
ADDRGP4 $714
JUMPV
LABELV $713
line 1867
;1867:		pm->ps->eFlags &= ~EF_FIRING;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 1868
;1868:	}
LABELV $714
line 1871
;1869:
;1870:	// clear the respawned flag if attack and use are cleared
;1871:	if ( pm->ps->stats[STAT_HEALTH] > 0 && 
ADDRLP4 20
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $715
ADDRLP4 20
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 5
BANDI4
CNSTI4 0
NEI4 $715
line 1872
;1872:		!( pm->cmd.buttons & (BUTTON_ATTACK | BUTTON_USE_HOLDABLE) ) ) {
line 1873
;1873:		pm->ps->pm_flags &= ~PMF_RESPAWNED;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 -513
BANDI4
ASGNI4
line 1874
;1874:	}
LABELV $715
line 1879
;1875:
;1876:	// if talk button is down, dissallow all other input
;1877:	// this is to prevent any possible intercept proxy from
;1878:	// adding fake talk balloons
;1879:	if ( pmove->cmd.buttons & BUTTON_TALK ) {
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $717
line 1882
;1880:		// keep the talk button set tho for when the cmd.serverTime > 66 msec
;1881:		// and the same cmd is used multiple times in Pmove
;1882:		pmove->cmd.buttons = BUTTON_TALK;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 2
ASGNI4
line 1883
;1883:		pmove->cmd.forwardmove = 0;
ADDRFP4 0
INDIRP4
CNSTI4 25
ADDP4
CNSTI1 0
ASGNI1
line 1884
;1884:		pmove->cmd.rightmove = 0;
ADDRFP4 0
INDIRP4
CNSTI4 26
ADDP4
CNSTI1 0
ASGNI1
line 1885
;1885:		pmove->cmd.upmove = 0;
ADDRFP4 0
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 1886
;1886:	}
LABELV $717
line 1889
;1887:
;1888:	// clear all pmove local vars
;1889:	memset (&pml, 0, sizeof(pml));
ADDRGP4 pml
ARGP4
CNSTI4 0
ARGI4
CNSTU4 140
ARGU4
ADDRGP4 memset
CALLP4
pop
line 1892
;1890:
;1891:	// determine the time
;1892:	pml.msec = pmove->cmd.serverTime - pm->ps->commandTime;
ADDRGP4 pml+40
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRGP4 pm
INDIRP4
INDIRP4
INDIRI4
SUBI4
ASGNI4
line 1893
;1893:	if ( pml.msec < 1 ) {
ADDRGP4 pml+40
INDIRI4
CNSTI4 1
GEI4 $720
line 1894
;1894:		pml.msec = 1;
ADDRGP4 pml+40
CNSTI4 1
ASGNI4
line 1895
;1895:	} else if ( pml.msec > 200 ) {
ADDRGP4 $721
JUMPV
LABELV $720
ADDRGP4 pml+40
INDIRI4
CNSTI4 200
LEI4 $724
line 1896
;1896:		pml.msec = 200;
ADDRGP4 pml+40
CNSTI4 200
ASGNI4
line 1897
;1897:	}
LABELV $724
LABELV $721
line 1898
;1898:	pm->ps->commandTime = pmove->cmd.serverTime;
ADDRGP4 pm
INDIRP4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1901
;1899:
;1900:	// save old org in case we get stuck
;1901:	VectorCopy (pm->ps->origin, pml.previous_origin);
ADDRGP4 pml+112
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1904
;1902:
;1903:	// save old velocity for crashlanding
;1904:	VectorCopy (pm->ps->velocity, pml.previous_velocity);
ADDRGP4 pml+124
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
INDIRB
ASGNB 12
line 1906
;1905:
;1906:	pml.frametime = pml.msec * 0.001;
ADDRGP4 pml+36
ADDRGP4 pml+40
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ASGNF4
line 1909
;1907:
;1908:	// update the viewangles
;1909:	PM_UpdateViewAngles( pm->ps, &pm->cmd );
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRGP4 PM_UpdateViewAngles
CALLV
pop
line 1911
;1910:
;1911:	AngleVectors (pm->ps->viewangles, pml.forward, pml.right, pml.up);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 pml
ARGP4
ADDRGP4 pml+12
ARGP4
ADDRGP4 pml+24
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1913
;1912:
;1913:	if ( pm->cmd.upmove < 10 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 10
GEI4 $734
line 1915
;1914:		// not holding jump
;1915:		pm->ps->pm_flags &= ~PMF_JUMP_HELD;
ADDRLP4 28
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 1916
;1916:	}
LABELV $734
line 1919
;1917:
;1918:	// decide if backpedaling animations should be used
;1919:	if ( pm->cmd.forwardmove < 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $736
line 1920
;1920:		pm->ps->pm_flags |= PMF_BACKWARDS_RUN;
ADDRLP4 28
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 1921
;1921:	} else if ( pm->cmd.forwardmove > 0 || ( pm->cmd.forwardmove == 0 && pm->cmd.rightmove ) ) {
ADDRGP4 $737
JUMPV
LABELV $736
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GTI4 $740
ADDRLP4 28
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $738
ADDRLP4 28
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $738
LABELV $740
line 1922
;1922:		pm->ps->pm_flags &= ~PMF_BACKWARDS_RUN;
ADDRLP4 32
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 1923
;1923:	}
LABELV $738
LABELV $737
line 1925
;1924:
;1925:	if ( pm->ps->pm_type >= PM_DEAD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
LTI4 $741
line 1926
;1926:		pm->cmd.forwardmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
CNSTI1 0
ASGNI1
line 1927
;1927:		pm->cmd.rightmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
CNSTI1 0
ASGNI1
line 1928
;1928:		pm->cmd.upmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 1929
;1929:	}
LABELV $741
line 1931
;1930:
;1931:	if ( pm_respawntimer ) {
ADDRGP4 pm_respawntimer
INDIRI4
CNSTI4 0
EQI4 $743
line 1932
;1932:		pm_respawntimer -= pml.msec;
ADDRLP4 32
ADDRGP4 pm_respawntimer
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1933
;1933:		if ( pm_respawntimer < 0 ) {
ADDRGP4 pm_respawntimer
INDIRI4
CNSTI4 0
GEI4 $746
line 1934
;1934:			pm_respawntimer = 0;
ADDRGP4 pm_respawntimer
CNSTI4 0
ASGNI4
line 1935
;1935:		}
LABELV $746
line 1936
;1936:	}
LABELV $743
line 1938
;1937:
;1938:	if ( pm->ps->pm_type == PM_SPECTATOR ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $748
line 1939
;1939:		PM_CheckDuck ();
ADDRGP4 PM_CheckDuck
CALLV
pop
line 1940
;1940:		PM_FlyMove ();
ADDRGP4 PM_FlyMove
CALLV
pop
line 1941
;1941:		PM_DropTimers ();
ADDRGP4 PM_DropTimers
CALLV
pop
line 1942
;1942:		return;
ADDRGP4 $705
JUMPV
LABELV $748
line 1945
;1943:	}
;1944:
;1945:	if ( pm->ps->pm_type == PM_NOCLIP ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $750
line 1946
;1946:		PM_NoclipMove ();
ADDRGP4 PM_NoclipMove
CALLV
pop
line 1947
;1947:		PM_DropTimers ();
ADDRGP4 PM_DropTimers
CALLV
pop
line 1948
;1948:		return;
ADDRGP4 $705
JUMPV
LABELV $750
line 1951
;1949:	}
;1950:
;1951:	if (pm->ps->pm_type == PM_FREEZE) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 4
NEI4 $752
line 1952
;1952:		return;		// no movement at all
ADDRGP4 $705
JUMPV
LABELV $752
line 1955
;1953:	}
;1954:
;1955:	if ( pm->ps->pm_type == PM_INTERMISSION || pm->ps->pm_type == PM_SPINTERMISSION) {
ADDRLP4 32
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 5
EQI4 $756
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 6
NEI4 $754
LABELV $756
line 1956
;1956:		return;		// no movement at all
ADDRGP4 $705
JUMPV
LABELV $754
line 1960
;1957:	}
;1958:
;1959:	// set watertype, and waterlevel
;1960:	PM_SetWaterLevel();
ADDRGP4 PM_SetWaterLevel
CALLV
pop
line 1961
;1961:	pml.previous_waterlevel = pmove->waterlevel;
ADDRGP4 pml+136
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
line 1964
;1962:
;1963:	// set mins, maxs, and viewheight
;1964:	PM_CheckDuck ();
ADDRGP4 PM_CheckDuck
CALLV
pop
line 1967
;1965:
;1966:	// set groundentity
;1967:	PM_GroundTrace();
ADDRGP4 PM_GroundTrace
CALLV
pop
line 1969
;1968:
;1969:	if ( pm->ps->pm_type == PM_DEAD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $758
line 1970
;1970:		PM_DeadMove ();
ADDRGP4 PM_DeadMove
CALLV
pop
line 1971
;1971:	}
LABELV $758
line 1973
;1972:
;1973:	PM_DropTimers();
ADDRGP4 PM_DropTimers
CALLV
pop
line 1976
;1974:
;1975:#ifdef MISSIONPACK
;1976:	if ( pm->ps->powerups[PW_INVULNERABILITY] ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 368
ADDP4
INDIRI4
CNSTI4 0
EQI4 $760
line 1977
;1977:		PM_InvulnerabilityMove();
ADDRGP4 PM_InvulnerabilityMove
CALLV
pop
line 1978
;1978:	} else
ADDRGP4 $761
JUMPV
LABELV $760
line 1980
;1979:#endif
;1980:	if ( pm->ps->powerups[PW_FLIGHT] ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $762
line 1982
;1981:		// flight powerup doesn't allow jump and has different friction
;1982:		PM_FlyMove();
ADDRGP4 PM_FlyMove
CALLV
pop
line 1983
;1983:	} else if (pm->ps->pm_flags & PMF_GRAPPLE_PULL) {
ADDRGP4 $763
JUMPV
LABELV $762
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $764
line 1984
;1984:		PM_GrappleMove();
ADDRGP4 PM_GrappleMove
CALLV
pop
line 1986
;1985:		// We can wiggle a bit
;1986:		PM_AirMove();
ADDRGP4 PM_AirMove
CALLV
pop
line 1987
;1987:	} else if (pm->ps->pm_flags & PMF_TIME_WATERJUMP) {
ADDRGP4 $765
JUMPV
LABELV $764
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $766
line 1988
;1988:		PM_WaterJumpMove();
ADDRGP4 PM_WaterJumpMove
CALLV
pop
line 1989
;1989:	} else if ( pm->waterlevel > 1 ) {
ADDRGP4 $767
JUMPV
LABELV $766
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
LEI4 $768
line 1991
;1990:		// swimming
;1991:		PM_WaterMove();
ADDRGP4 PM_WaterMove
CALLV
pop
line 1992
;1992:	} else if ( pml.walking ) {
ADDRGP4 $769
JUMPV
LABELV $768
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
EQI4 $770
line 1994
;1993:		// walking on ground
;1994:		PM_WalkMove();
ADDRGP4 PM_WalkMove
CALLV
pop
line 1995
;1995:	} else {
ADDRGP4 $771
JUMPV
LABELV $770
line 1997
;1996:		// airborne
;1997:		PM_AirMove();
ADDRGP4 PM_AirMove
CALLV
pop
line 1998
;1998:	}
LABELV $771
LABELV $769
LABELV $767
LABELV $765
LABELV $763
LABELV $761
line 2000
;1999:
;2000:	PM_Animate();
ADDRGP4 PM_Animate
CALLV
pop
line 2003
;2001:
;2002:	// set groundentity, watertype, and waterlevel
;2003:	PM_GroundTrace();
ADDRGP4 PM_GroundTrace
CALLV
pop
line 2004
;2004:	PM_SetWaterLevel();
ADDRGP4 PM_SetWaterLevel
CALLV
pop
line 2007
;2005:
;2006:	// weapons
;2007:	PM_Weapon();
ADDRGP4 PM_Weapon
CALLV
pop
line 2010
;2008:
;2009:	// torso animation
;2010:	PM_TorsoAnimation();
ADDRGP4 PM_TorsoAnimation
CALLV
pop
line 2013
;2011:
;2012:	// footstep events / legs animations
;2013:	PM_Footsteps();
ADDRGP4 PM_Footsteps
CALLV
pop
line 2016
;2014:
;2015:	// entering / leaving water splashes
;2016:	PM_WaterEvents();
ADDRGP4 PM_WaterEvents
CALLV
pop
line 2018
;2017:
;2018:	if ( pm->ps->powerups[PW_FLIGHT] && !pml.groundPlane ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $773
ADDRGP4 pml+48
INDIRI4
CNSTI4 0
NEI4 $773
line 2020
;2019:		// don't snap velocity in free-fly or we will be not able to stop via flight friction
;2020:		return;
ADDRGP4 $705
JUMPV
LABELV $773
line 2024
;2021:	}
;2022:
;2023:	// snap some parts of playerstate to save network bandwidth
;2024:	trap_SnapVector( pm->ps->velocity );
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 trap_SnapVector
CALLV
pop
line 2025
;2025:}
LABELV $705
endproc PmoveSingle 36 16
export Pmove
proc Pmove 16 4
line 2035
;2026:
;2027:
;2028:/*
;2029:================
;2030:Pmove
;2031:
;2032:Can be called by either the server or the client
;2033:================
;2034:*/
;2035:void Pmove (pmove_t *pmove) {
line 2038
;2036:	int			finalTime;
;2037:
;2038:	finalTime = pmove->cmd.serverTime;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 2040
;2039:
;2040:	if ( finalTime < pmove->ps->commandTime ) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
GEI4 $777
line 2041
;2041:		return;	// should not happen
ADDRGP4 $776
JUMPV
LABELV $777
line 2044
;2042:	}
;2043:
;2044:	if ( finalTime > pmove->ps->commandTime + 1000 ) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
CNSTI4 1000
ADDI4
LEI4 $779
line 2045
;2045:		pmove->ps->commandTime = finalTime - 1000;
ADDRFP4 0
INDIRP4
INDIRP4
ADDRLP4 0
INDIRI4
CNSTI4 1000
SUBI4
ASGNI4
line 2046
;2046:	}
LABELV $779
line 2048
;2047:
;2048:	pmove->ps->pmove_framecount = (pmove->ps->pmove_framecount+1) & ((1<<PS_PMOVEFRAMECOUNTBITS)-1);
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 456
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 456
ADDP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 63
BANDI4
ASGNI4
line 2050
;2049:
;2050:	if ( pmove->ps->pm_flags & PMF_RESPAWNED && pm_respawntimer == 0 ) {
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $784
ADDRGP4 pm_respawntimer
INDIRI4
CNSTI4 0
NEI4 $784
line 2051
;2051:		pm_respawntimer = NO_RESPAWN_OVERBOUNCE;
ADDRGP4 pm_respawntimer
CNSTI4 250
ASGNI4
line 2052
;2052:	}
ADDRGP4 $784
JUMPV
LABELV $783
line 2056
;2053:
;2054:	// chop the move up if it is too long, to prevent framerate
;2055:	// dependent behavior
;2056:	while ( pmove->ps->commandTime != finalTime ) {
line 2059
;2057:		int		msec;
;2058:
;2059:		msec = finalTime - pmove->ps->commandTime;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
SUBI4
ASGNI4
line 2061
;2060:
;2061:		if ( pmove->pmove_fixed ) {
ADDRFP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 0
EQI4 $786
line 2062
;2062:			if ( msec > pmove->pmove_msec ) {
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
LEI4 $787
line 2063
;2063:				msec = pmove->pmove_msec;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ASGNI4
line 2064
;2064:			}
line 2065
;2065:		}
ADDRGP4 $787
JUMPV
LABELV $786
line 2066
;2066:		else {
line 2067
;2067:			if ( msec > 66 ) {
ADDRLP4 8
INDIRI4
CNSTI4 66
LEI4 $790
line 2068
;2068:				msec = 66;
ADDRLP4 8
CNSTI4 66
ASGNI4
line 2069
;2069:			}
LABELV $790
line 2070
;2070:		}
LABELV $787
line 2071
;2071:		pmove->cmd.serverTime = pmove->ps->commandTime + msec;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 12
INDIRP4
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 2072
;2072:		PmoveSingle( pmove );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 PmoveSingle
CALLV
pop
line 2074
;2073:
;2074:		if ( pmove->ps->pm_flags & PMF_JUMP_HELD ) {
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $792
line 2075
;2075:			pmove->cmd.upmove = 20;
ADDRFP4 0
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 20
ASGNI1
line 2076
;2076:		}
LABELV $792
line 2077
;2077:	}
LABELV $784
line 2056
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $783
line 2079
;2078:	//PM_CheckStuck();
;2079:}
LABELV $776
endproc Pmove 16 4
import trap_SnapVector
import PM_StepSlideMove
import PM_SlideMove
bss
export pml
align 4
LABELV pml
skip 140
export pm
align 4
LABELV pm
skip 4
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
LABELV $475
byte 1 37
byte 1 105
byte 1 58
byte 1 76
byte 1 97
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $464
byte 1 37
byte 1 105
byte 1 58
byte 1 115
byte 1 116
byte 1 101
byte 1 101
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $453
byte 1 37
byte 1 105
byte 1 58
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 111
byte 1 102
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $422
byte 1 37
byte 1 105
byte 1 58
byte 1 108
byte 1 105
byte 1 102
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $395
byte 1 37
byte 1 105
byte 1 58
byte 1 97
byte 1 108
byte 1 108
byte 1 115
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 10
byte 1 0
