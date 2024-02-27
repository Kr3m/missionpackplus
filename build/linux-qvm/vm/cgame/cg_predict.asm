export CG_BuildSolidList
code
proc CG_BuildSolidList 24 0
file "../../../../code/cgame/cg_predict.c"
line 26
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_predict.c -- this file generates cg.predictedPlayerState by either
;4:// interpolating between snapshots from the server or locally predicting
;5:// ahead the client's movement.
;6:// It also handles local physics interaction, like fragments bouncing off walls
;7:
;8:#include "cg_local.h"
;9:
;10:static	pmove_t		cg_pmove;
;11:
;12:static	int			cg_numSolidEntities;
;13:static	centity_t	*cg_solidEntities[MAX_ENTITIES_IN_SNAPSHOT];
;14:static	int			cg_numTriggerEntities;
;15:static	centity_t	*cg_triggerEntities[MAX_ENTITIES_IN_SNAPSHOT];
;16:
;17:/*
;18:====================
;19:CG_BuildSolidList
;20:
;21:When a new cg.snap has been set, this function builds a sublist
;22:of the entities that are actually solid, to make for more
;23:efficient collision detection
;24:====================
;25:*/
;26:void CG_BuildSolidList( void ) {
line 32
;27:	int			i;
;28:	centity_t	*cent;
;29:	snapshot_t	*snap;
;30:	entityState_t	*ent;
;31:
;32:	cg_numSolidEntities = 0;
ADDRGP4 cg_numSolidEntities
CNSTI4 0
ASGNI4
line 33
;33:	cg_numTriggerEntities = 0;
ADDRGP4 cg_numTriggerEntities
CNSTI4 0
ASGNI4
line 35
;34:
;35:	if ( cg.nextSnap && !cg.nextFrameTeleport && !cg.thisFrameTeleport ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $73
ADDRGP4 cg+107596
INDIRI4
CNSTI4 0
NEI4 $73
ADDRGP4 cg+107592
INDIRI4
CNSTI4 0
NEI4 $73
line 36
;36:		snap = cg.nextSnap;
ADDRLP4 12
ADDRGP4 cg+40
INDIRP4
ASGNP4
line 37
;37:	} else {
ADDRGP4 $74
JUMPV
LABELV $73
line 38
;38:		snap = cg.snap;
ADDRLP4 12
ADDRGP4 cg+36
INDIRP4
ASGNP4
line 39
;39:	}
LABELV $74
line 41
;40:
;41:	for ( i = 0 ; i < snap->numEntities ; i++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $83
JUMPV
LABELV $80
line 42
;42:		cent = &cg_entities[ snap->entities[ i ].number ];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 208
MULI4
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
ADDP4
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 43
;43:		ent = &cent->currentState;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 45
;44:
;45:		if ( ent->eType == ET_ITEM || ent->eType == ET_PUSH_TRIGGER || ent->eType == ET_TELEPORT_TRIGGER ) {
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $87
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 8
EQI4 $87
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 9
NEI4 $84
LABELV $87
line 46
;46:			cg_triggerEntities[cg_numTriggerEntities] = cent;
ADDRGP4 cg_numTriggerEntities
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_triggerEntities
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 47
;47:			cg_numTriggerEntities++;
ADDRLP4 20
ADDRGP4 cg_numTriggerEntities
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 48
;48:			continue;
ADDRGP4 $81
JUMPV
LABELV $84
line 51
;49:		}
;50:
;51:		if ( cent->nextState.solid ) {
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
EQI4 $88
line 52
;52:			cg_solidEntities[cg_numSolidEntities] = cent;
ADDRGP4 cg_numSolidEntities
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_solidEntities
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 53
;53:			cg_numSolidEntities++;
ADDRLP4 20
ADDRGP4 cg_numSolidEntities
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 54
;54:			continue;
LABELV $88
line 56
;55:		}
;56:	}
LABELV $81
line 41
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $83
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
LTI4 $80
line 57
;57:}
LABELV $72
endproc CG_BuildSolidList 24 0
proc CG_ClipMoveToEntities 144 36
line 67
;58:
;59:
;60:/*
;61:====================
;62:CG_ClipMoveToEntities
;63:
;64:====================
;65:*/
;66:static void CG_ClipMoveToEntities ( const vec3_t start, const vec3_t mins, const vec3_t maxs, const vec3_t end,
;67:							int skipNumber, int mask, trace_t *tr ) {
line 76
;68:	int			i, x, zd, zu;
;69:	trace_t		trace;
;70:	entityState_t	*ent;
;71:	clipHandle_t 	cmodel;
;72:	vec3_t		bmins, bmaxs;
;73:	vec3_t		origin, angles;
;74:	centity_t	*cent;
;75:
;76:	for ( i = 0 ; i < cg_numSolidEntities ; i++ ) {
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRGP4 $94
JUMPV
LABELV $91
line 77
;77:		cent = cg_solidEntities[ i ];
ADDRLP4 60
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_solidEntities
ADDP4
INDIRP4
ASGNP4
line 78
;78:		ent = &cent->currentState;
ADDRLP4 0
ADDRLP4 60
INDIRP4
ASGNP4
line 80
;79:
;80:		if ( ent->number == skipNumber ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 16
INDIRI4
NEI4 $95
line 81
;81:			continue;
ADDRGP4 $92
JUMPV
LABELV $95
line 84
;82:		}
;83:
;84:		if ( ent->solid == SOLID_BMODEL ) {
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
NEI4 $97
line 86
;85:			// special value for bmodel
;86:			cmodel = trap_CM_InlineModel( ent->modelindex );
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRLP4 132
ADDRGP4 trap_CM_InlineModel
CALLI4
ASGNI4
ADDRLP4 68
ADDRLP4 132
INDIRI4
ASGNI4
line 87
;87:			VectorCopy( cent->lerpAngles, angles );
ADDRLP4 108
ADDRLP4 60
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 88
;88:			BG_EvaluateTrajectory( &cent->currentState.pos, cg.physicsTime, origin );
ADDRLP4 60
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+107612
INDIRI4
ARGI4
ADDRLP4 96
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 89
;89:		} else {
ADDRGP4 $98
JUMPV
LABELV $97
line 91
;90:			// encoded bbox
;91:			x = (ent->solid & 255);
ADDRLP4 120
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 92
;92:			zd = ((ent->solid>>8) & 255);
ADDRLP4 124
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 255
BANDI4
ASGNI4
line 93
;93:			zu = ((ent->solid>>16) & 255) - 32;
ADDRLP4 128
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16
RSHI4
CNSTI4 255
BANDI4
CNSTI4 32
SUBI4
ASGNI4
line 95
;94:
;95:			bmins[0] = bmins[1] = -x;
ADDRLP4 132
ADDRLP4 120
INDIRI4
NEGI4
CVIF4 4
ASGNF4
ADDRLP4 72+4
ADDRLP4 132
INDIRF4
ASGNF4
ADDRLP4 72
ADDRLP4 132
INDIRF4
ASGNF4
line 96
;96:			bmaxs[0] = bmaxs[1] = x;
ADDRLP4 136
ADDRLP4 120
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 84+4
ADDRLP4 136
INDIRF4
ASGNF4
ADDRLP4 84
ADDRLP4 136
INDIRF4
ASGNF4
line 97
;97:			bmins[2] = -zd;
ADDRLP4 72+8
ADDRLP4 124
INDIRI4
NEGI4
CVIF4 4
ASGNF4
line 98
;98:			bmaxs[2] = zu;
ADDRLP4 84+8
ADDRLP4 128
INDIRI4
CVIF4 4
ASGNF4
line 100
;99:
;100:			cmodel = trap_CM_TempBoxModel( bmins, bmaxs );
ADDRLP4 72
ARGP4
ADDRLP4 84
ARGP4
ADDRLP4 140
ADDRGP4 trap_CM_TempBoxModel
CALLI4
ASGNI4
ADDRLP4 68
ADDRLP4 140
INDIRI4
ASGNI4
line 101
;101:			VectorCopy( vec3_origin, angles );
ADDRLP4 108
ADDRGP4 vec3_origin
INDIRB
ASGNB 12
line 102
;102:			VectorCopy( cent->lerpOrigin, origin );
ADDRLP4 96
ADDRLP4 60
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 103
;103:		}
LABELV $98
line 106
;104:
;105:
;106:		trap_CM_TransformedBoxTrace ( &trace, start, end,
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 68
INDIRI4
ARGI4
ADDRFP4 20
INDIRI4
ARGI4
ADDRLP4 96
ARGP4
ADDRLP4 108
ARGP4
ADDRGP4 trap_CM_TransformedBoxTrace
CALLV
pop
line 109
;107:			mins, maxs, cmodel,  mask, origin, angles);
;108:
;109:		if (trace.allsolid || trace.fraction < tr->fraction) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $107
ADDRLP4 4+8
INDIRF4
ADDRFP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
GEF4 $104
LABELV $107
line 110
;110:			trace.entityNum = ent->number;
ADDRLP4 4+52
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 111
;111:			*tr = trace;
ADDRFP4 24
INDIRP4
ADDRLP4 4
INDIRB
ASGNB 56
line 112
;112:		} else if (trace.startsolid) {
ADDRGP4 $105
JUMPV
LABELV $104
ADDRLP4 4+4
INDIRI4
CNSTI4 0
EQI4 $109
line 113
;113:			tr->startsolid = qtrue;
ADDRFP4 24
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 1
ASGNI4
line 114
;114:		}
LABELV $109
LABELV $105
line 115
;115:		if ( tr->allsolid ) {
ADDRFP4 24
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $112
line 116
;116:			return;
ADDRGP4 $90
JUMPV
LABELV $112
line 118
;117:		}
;118:	}
LABELV $92
line 76
ADDRLP4 64
ADDRLP4 64
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $94
ADDRLP4 64
INDIRI4
ADDRGP4 cg_numSolidEntities
INDIRI4
LTI4 $91
line 119
;119:}
LABELV $90
endproc CG_ClipMoveToEntities 144 36
export CG_Trace
proc CG_Trace 56 28
line 128
;120:
;121:
;122:/*
;123:================
;124:CG_Trace
;125:================
;126:*/
;127:void	CG_Trace( trace_t *result, const vec3_t start, const vec3_t mins, const vec3_t maxs, const vec3_t end, 
;128:					 int skipNumber, int mask ) {
line 131
;129:	trace_t	t;
;130:
;131:	trap_CM_BoxTrace ( &t, start, end, mins, maxs, 0, mask);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 132
;132:	if ( t.fraction == 1.0 )
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
NEF4 $115
line 133
;133:		t.entityNum = ENTITYNUM_NONE;
ADDRLP4 0+52
CNSTI4 1023
ASGNI4
ADDRGP4 $116
JUMPV
LABELV $115
line 135
;134:	else
;135:		t.entityNum = ENTITYNUM_WORLD;
ADDRLP4 0+52
CNSTI4 1022
ASGNI4
LABELV $116
line 138
;136:
;137:	// check all other solid models
;138:	CG_ClipMoveToEntities (start, mins, maxs, end, skipNumber, mask, &t);
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
ADDRLP4 0
ARGP4
ADDRGP4 CG_ClipMoveToEntities
CALLV
pop
line 140
;139:
;140:	*result = t;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRB
ASGNB 56
line 141
;141:}
LABELV $114
endproc CG_Trace 56 28
export CG_PointContents
proc CG_PointContents 36 16
line 149
;142:
;143:
;144:/*
;145:================
;146:CG_PointContents
;147:================
;148:*/
;149:int		CG_PointContents( const vec3_t point, int passEntityNum ) {
line 156
;150:	int			i;
;151:	entityState_t	*ent;
;152:	centity_t	*cent;
;153:	clipHandle_t cmodel;
;154:	int			contents;
;155:
;156:	contents = trap_CM_PointContents (point, 0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 20
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 20
INDIRI4
ASGNI4
line 158
;157:
;158:	for ( i = 0 ; i < cg_numSolidEntities ; i++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $124
JUMPV
LABELV $121
line 159
;159:		cent = cg_solidEntities[ i ];
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_solidEntities
ADDP4
INDIRP4
ASGNP4
line 161
;160:
;161:		ent = &cent->currentState;
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 163
;162:
;163:		if ( ent->number == passEntityNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $125
line 164
;164:			continue;
ADDRGP4 $122
JUMPV
LABELV $125
line 167
;165:		}
;166:
;167:		if (ent->solid != SOLID_BMODEL) { // special value for bmodel
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
EQI4 $127
line 168
;168:			continue;
ADDRGP4 $122
JUMPV
LABELV $127
line 171
;169:		}
;170:
;171:		cmodel = trap_CM_InlineModel( ent->modelindex );
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 trap_CM_InlineModel
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 24
INDIRI4
ASGNI4
line 172
;172:		if ( !cmodel ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $129
line 173
;173:			continue;
ADDRGP4 $122
JUMPV
LABELV $129
line 176
;174:		}
;175:
;176:		contents |= trap_CM_TransformedPointContents( point, cmodel, cent->lerpOrigin, cent->lerpAngles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRLP4 32
ADDRGP4 trap_CM_TransformedPointContents
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 32
INDIRI4
BORI4
ASGNI4
line 177
;177:	}
LABELV $122
line 158
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $124
ADDRLP4 8
INDIRI4
ADDRGP4 cg_numSolidEntities
INDIRI4
LTI4 $121
line 179
;178:
;179:	return contents;
ADDRLP4 16
INDIRI4
RETI4
LABELV $120
endproc CG_PointContents 36 16
proc CG_InterpolatePlayerState 52 12
line 191
;180:}
;181:
;182:
;183:/*
;184:========================
;185:CG_InterpolatePlayerState
;186:
;187:Generates cg.predictedPlayerState by interpolating between
;188:cg.snap->player_state and cg.nextFrame->player_state
;189:========================
;190:*/
;191:static void CG_InterpolatePlayerState( qboolean grabAngles ) {
line 197
;192:	float			f;
;193:	int				i;
;194:	playerState_t	*out;
;195:	snapshot_t		*prev, *next;
;196:
;197:	out = &cg.predictedPlayerState;
ADDRLP4 12
ADDRGP4 cg+107636
ASGNP4
line 198
;198:	prev = cg.snap;
ADDRLP4 4
ADDRGP4 cg+36
INDIRP4
ASGNP4
line 199
;199:	next = cg.nextSnap;
ADDRLP4 8
ADDRGP4 cg+40
INDIRP4
ASGNP4
line 201
;200:
;201:	*out = cg.snap->ps;
ADDRLP4 12
INDIRP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 468
line 204
;202:
;203:	// if we are still allowing local input, short circuit the view angles
;204:	if ( grabAngles ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $136
line 208
;205:		usercmd_t	cmd;
;206:		int			cmdNum;
;207:
;208:		cmdNum = trap_GetCurrentCmdNumber();
ADDRLP4 48
ADDRGP4 trap_GetCurrentCmdNumber
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 48
INDIRI4
ASGNI4
line 209
;209:		trap_GetUserCmd( cmdNum, &cmd );
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 20
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 211
;210:
;211:		PM_UpdateViewAngles( out, &cmd );
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 PM_UpdateViewAngles
CALLV
pop
line 212
;212:	}
LABELV $136
line 215
;213:
;214:	// if the next frame is a teleport, we can't lerp to it
;215:	if ( cg.nextFrameTeleport ) {
ADDRGP4 cg+107596
INDIRI4
CNSTI4 0
EQI4 $138
line 216
;216:		return;
ADDRGP4 $131
JUMPV
LABELV $138
line 219
;217:	}
;218:
;219:	if ( !next || next->serverTime <= prev->serverTime ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $143
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
GTI4 $141
LABELV $143
line 220
;220:		return;
ADDRGP4 $131
JUMPV
LABELV $141
line 223
;221:	}
;222:
;223:	f = (float)( cg.time - prev->serverTime ) / ( next->serverTime - prev->serverTime );
ADDRLP4 16
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 225
;224:
;225:	i = next->ps.bobCycle;
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ASGNI4
line 226
;226:	if ( i < prev->ps.bobCycle ) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
GEI4 $145
line 227
;227:		i += 256;		// handle wraparound
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 256
ADDI4
ASGNI4
line 228
;228:	}
LABELV $145
line 229
;229:	out->bobCycle = prev->ps.bobCycle + f * ( i - prev->ps.bobCycle );
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
SUBI4
CVIF4 4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 231
;230:
;231:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $147
line 232
;232:		out->origin[i] = prev->ps.origin[i] + f * (next->ps.origin[i] - prev->ps.origin[i] );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 20
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 64
ADDP4
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 64
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 64
ADDP4
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 233
;233:		if ( !grabAngles ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $151
line 234
;234:			out->viewangles[i] = LerpAngle( 
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 196
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 44
ADDRGP4 LerpAngle
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 152
ADDP4
ADDP4
ADDRLP4 44
INDIRF4
ASGNF4
line 236
;235:				prev->ps.viewangles[i], next->ps.viewangles[i], f );
;236:		}
LABELV $151
line 237
;237:		out->velocity[i] = prev->ps.velocity[i] + 
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 76
ADDP4
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 76
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 76
ADDP4
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 239
;238:			f * (next->ps.velocity[i] - prev->ps.velocity[i] );
;239:	}
LABELV $148
line 231
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $147
line 241
;240:
;241:}
LABELV $131
endproc CG_InterpolatePlayerState 52 12
export CG_StoreEvent
proc CG_StoreEvent 4 4
line 258
;242:
;243:int				eventStack;
;244:entity_event_t	events[ MAX_PREDICTED_EVENTS ];
;245:int				eventParms[ MAX_PREDICTED_EVENTS ];
;246:int				eventParm2[ MAX_PREDICTED_EVENTS ]; // client entity index
;247:
;248:void CG_AddFallDamage( int damage );
;249:
;250:/*
;251:===================
;252:CG_StoreEvents
;253:
;254:Save events that may be dropped during prediction
;255:===================
;256:*/
;257:void CG_StoreEvent( entity_event_t evt, int eventParm, int entityNum ) 
;258:{
line 259
;259:	if ( eventStack >= MAX_PREDICTED_EVENTS )
ADDRGP4 eventStack
INDIRI4
CNSTI4 16
LTI4 $154
line 260
;260:		return;
ADDRGP4 $153
JUMPV
LABELV $154
line 262
;261:
;262:	if ( evt == EV_FALL_FAR ) {
ADDRFP4 0
INDIRI4
CNSTI4 12
NEI4 $156
line 263
;263:		CG_AddFallDamage( 10 );
CNSTI4 10
ARGI4
ADDRGP4 CG_AddFallDamage
CALLV
pop
line 264
;264:	} else if ( evt == EV_FALL_MEDIUM ) {
ADDRGP4 $157
JUMPV
LABELV $156
ADDRFP4 0
INDIRI4
CNSTI4 11
NEI4 $158
line 265
;265:		CG_AddFallDamage( 5 );
CNSTI4 5
ARGI4
ADDRGP4 CG_AddFallDamage
CALLV
pop
line 266
;266:	}
LABELV $158
LABELV $157
line 268
;267:
;268:	events[ eventStack ] = evt;
ADDRGP4 eventStack
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 events
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 269
;269:	eventParms[ eventStack ] = eventParm;
ADDRGP4 eventStack
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 eventParms
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 270
;270:	eventParm2[ eventStack ] = entityNum;
ADDRGP4 eventStack
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 eventParm2
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 271
;271:	eventStack++;
ADDRLP4 0
ADDRGP4 eventStack
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 272
;272:}
LABELV $153
endproc CG_StoreEvent 4 4
export CG_PlayDroppedEvents
proc CG_PlayDroppedEvents 24 12
line 280
;273:
;274:
;275:/*
;276:===================
;277:CG_PlayDroppedEvents
;278:===================
;279:*/
;280:void CG_PlayDroppedEvents( playerState_t *ps, playerState_t *ops ) {
line 285
;281:	centity_t	*cent;
;282:	entity_event_t oldEvent;
;283:	int i, oldParam;
;284:
;285:	if ( ps == ops ) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $161
line 286
;286:		return;
ADDRGP4 $160
JUMPV
LABELV $161
line 289
;287:	}
;288:
;289:	if ( eventStack <= MAX_PS_EVENTS ) {
ADDRGP4 eventStack
INDIRI4
CNSTI4 2
GTI4 $163
line 290
;290:		return;
ADDRGP4 $160
JUMPV
LABELV $163
line 293
;291:	}
;292:
;293:	cent = &cg.predictedPlayerEntity;
ADDRLP4 4
ADDRGP4 cg+108104
ASGNP4
line 295
;294:
;295:	oldEvent = cent->currentState.event;
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ASGNI4
line 296
;296:	oldParam = cent->currentState.eventParm;
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 298
;297:
;298:	for ( i = 0; i < eventStack - MAX_PS_EVENTS ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $169
JUMPV
LABELV $166
line 299
;299:		cent->currentState.event = events[ i ];
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 events
ADDP4
INDIRI4
ASGNI4
line 300
;300:		cent->currentState.eventParm = eventParms[ i ];
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 eventParms
ADDP4
INDIRI4
ASGNI4
line 301
;301:		if ( cg_showmiss.integer ) 
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $170
line 302
;302:		{
line 303
;303:			CG_Printf( "Playing dropped event: %s %i", eventnames[ events[ i ] ], eventParms[ i ] );
ADDRGP4 $173
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 events
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 eventnames
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 eventParms
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 304
;304:		}
LABELV $170
line 305
;305:		CG_EntityEvent( cent, cent->lerpOrigin, eventParm2[ i ] );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 0
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
line 306
;306:		cg.eventSequence++;
ADDRLP4 20
ADDRGP4 cg+108864
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 307
;307:	}
LABELV $167
line 298
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $169
ADDRLP4 0
INDIRI4
ADDRGP4 eventStack
INDIRI4
CNSTI4 2
SUBI4
LTI4 $166
line 309
;308:
;309:	cent->currentState.event = oldEvent;
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 310
;310:	cent->currentState.eventParm = oldParam;
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 311
;311:}
LABELV $160
endproc CG_PlayDroppedEvents 24 12
proc CG_AddArmor 4 0
line 314
;312:
;313:
;314:static void CG_AddArmor( const gitem_t *item, int quantity ) {
line 316
;315:
;316:	cg.predictedPlayerState.stats[STAT_ARMOR] += quantity;
ADDRLP4 0
ADDRGP4 cg+107636+184+16
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
line 318
;317:
;318:		if ( cg.predictedPlayerState.stats[STAT_ARMOR] > cg.predictedPlayerState.stats[STAT_MAX_HEALTH]*2 )
ADDRGP4 cg+107636+184+16
INDIRI4
ADDRGP4 cg+107636+184+28
INDIRI4
CNSTI4 1
LSHI4
LEI4 $179
line 319
;319:			cg.predictedPlayerState.stats[STAT_ARMOR] = cg.predictedPlayerState.stats[STAT_MAX_HEALTH]*2;
ADDRGP4 cg+107636+184+16
ADDRGP4 cg+107636+184+28
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
LABELV $179
line 320
;320:}
LABELV $175
endproc CG_AddArmor 4 0
proc CG_AddAmmo 12 0
line 324
;321:
;322:
;323:static void CG_AddAmmo( int weapon, int count )
;324:{
line 325
;325:	if ( weapon == WP_GAUNTLET || weapon == WP_GRAPPLING_HOOK ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $196
ADDRLP4 0
INDIRI4
CNSTI4 10
NEI4 $194
LABELV $196
line 326
;326:		cg.predictedPlayerState.ammo[weapon] = -1;
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+376
ADDP4
CNSTI4 -1
ASGNI4
line 327
;327:	} else {
ADDRGP4 $195
JUMPV
LABELV $194
line 328
;328:		cg.predictedPlayerState.ammo[weapon] += count;
ADDRLP4 4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+376
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
line 329
;329:		if ( weapon >= WP_MACHINEGUN && weapon <= WP_BFG ) {
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 2
LTI4 $201
ADDRLP4 8
INDIRI4
CNSTI4 9
GTI4 $201
line 330
;330:			if ( cg.predictedPlayerState.ammo[weapon] > AMMO_HARD_LIMIT ) {
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+376
ADDP4
INDIRI4
CNSTI4 200
LEI4 $203
line 331
;331:				cg.predictedPlayerState.ammo[weapon] = AMMO_HARD_LIMIT;
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+376
ADDP4
CNSTI4 200
ASGNI4
line 332
;332:			}
LABELV $203
line 333
;333:		}
LABELV $201
line 334
;334:	}
LABELV $195
line 335
;335:}
LABELV $193
endproc CG_AddAmmo 12 0
proc CG_AddWeapon 4 8
line 339
;336:
;337:
;338:static void CG_AddWeapon( int weapon, int quantity, qboolean dropped ) 
;339:{
line 345
;340:	//int	ammo;
;341:	
;342:	//ammo = quantity;
;343:
;344:	// dropped items and teamplay weapons always have full ammo
;345:	if ( !dropped && cgs.gametype != GT_TEAM ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $210
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
EQI4 $210
line 346
;346:		if ( cg.predictedPlayerState.ammo[ weapon ] < quantity ) {
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+376
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
GEI4 $213
line 347
;347:			quantity = quantity - cg.predictedPlayerState.ammo[ weapon ];
ADDRFP4 4
ADDRFP4 4
INDIRI4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+376
ADDP4
INDIRI4
SUBI4
ASGNI4
line 348
;348:		} else {
ADDRGP4 $214
JUMPV
LABELV $213
line 349
;349:			quantity = 1;
ADDRFP4 4
CNSTI4 1
ASGNI4
line 350
;350:		}
LABELV $214
line 351
;351:	}
LABELV $210
line 354
;352:
;353:	// add the weapon
;354:	cg.predictedPlayerState.stats[STAT_WEAPONS] |= ( 1 << weapon );
ADDRLP4 0
ADDRGP4 cg+107636+184+12
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDRFP4 0
INDIRI4
LSHI4
BORI4
ASGNI4
line 356
;355:
;356:	CG_AddAmmo( weapon, quantity );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 CG_AddAmmo
CALLV
pop
line 357
;357:}
LABELV $209
endproc CG_AddWeapon 4 8
proc CG_CheckArmor 16 4
line 360
;358:
;359:
;360:static int CG_CheckArmor( int damage ) {
line 364
;361:	int				save;
;362:	int				count;
;363:
;364:	count = cg.predictedPlayerState.stats[STAT_ARMOR];
ADDRLP4 4
ADDRGP4 cg+107636+184+16
INDIRI4
ASGNI4
line 366
;365:
;366:	save = ceil( damage * ARMOR_PROTECTION );
ADDRFP4 0
INDIRI4
CVIF4 4
CNSTF4 1059648963
MULF4
ARGF4
ADDRLP4 8
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
CVFI4 4
ASGNI4
line 368
;367:
;368:	if (save >= count)
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $226
line 369
;369:		save = count;
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
LABELV $226
line 371
;370:
;371:	if ( !save )
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $228
line 372
;372:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $222
JUMPV
LABELV $228
line 374
;373:	
;374:	cg.predictedPlayerState.stats[STAT_ARMOR] -= save;
ADDRLP4 12
ADDRGP4 cg+107636+184+16
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ASGNI4
line 376
;375:
;376:	return save;
ADDRLP4 0
INDIRI4
RETI4
LABELV $222
endproc CG_CheckArmor 16 4
export CG_AddFallDamage
proc CG_AddFallDamage 16 4
line 381
;377:}
;378:
;379:
;380: void CG_AddFallDamage( int damage ) 
;381:{
line 384
;382:	int take, asave;
;383:
;384:	if ( cg.predictedPlayerState.powerups[ PW_BATTLESUIT ] )
ADDRGP4 cg+107636+312+8
INDIRI4
CNSTI4 0
EQI4 $234
line 385
;385:		return;
ADDRGP4 $233
JUMPV
LABELV $234
line 387
;386:
;387:	if ( cg.predictedPlayerState.clientNum != cg.snap->ps.clientNum || cg.snap->ps.pm_flags & PMF_FOLLOW ) {
ADDRGP4 cg+107636+140
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $245
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $239
LABELV $245
line 388
;388:		return;
ADDRGP4 $233
JUMPV
LABELV $239
line 391
;389:	}
;390:
;391:	take = damage;
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
line 393
;392:
;393:	asave = CG_CheckArmor( take );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_CheckArmor
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 395
;394:
;395:	take -= asave;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 397
;396:
;397:	cg.predictedPlayerState.stats[STAT_HEALTH] -= take;
ADDRLP4 12
ADDRGP4 cg+107636+184
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ASGNI4
line 404
;398:
;399:#if 0
;400:	CG_Printf( "take: %i asave:%i health:%i armor:%i\n", take, asave, 
;401:		cg.predictedPlayerState.stats[STAT_HEALTH], cg.predictedPlayerState.stats[STAT_ARMOR] );
;402:#endif
;403:
;404:	cg.predictedPlayerState.damagePitch = 255;
ADDRGP4 cg+107636+176
CNSTI4 255
ASGNI4
line 405
;405:	cg.predictedPlayerState.damageYaw = 255;
ADDRGP4 cg+107636+172
CNSTI4 255
ASGNI4
line 407
;406:	//cg.predictedPlayerState.damageEvent++;
;407:	cg.predictedPlayerState.damageCount = take + asave;
ADDRGP4 cg+107636+180
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 408
;408:}
LABELV $233
endproc CG_AddFallDamage 16 4
proc CG_PickupPrediction 16 12
line 411
;409: 
;410:
;411:static void CG_PickupPrediction( centity_t *cent, const gitem_t *item ) {
line 414
;412:
;413:	// health prediction
;414:	if ( item->giType == IT_HEALTH && cent->currentState.time2 > 0 ) {
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 4
NEI4 $255
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 0
LEI4 $255
line 417
;415:		int limit;
;416:
;417:		limit = cg.predictedPlayerState.stats[ STAT_MAX_HEALTH ]; // soft limit
ADDRLP4 0
ADDRGP4 cg+107636+184+28
INDIRI4
ASGNI4
line 418
;418:		if ( !Q_stricmp( item->classname, "item_health_small" ) || !Q_stricmp( item->classname, "item_health_mega" ) ) {
ADDRFP4 4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 $262
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $264
ADDRFP4 4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 $263
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $260
LABELV $264
line 419
;419:			limit *= 2; // hard limit
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 420
;420:		}
LABELV $260
line 422
;421:
;422:		cg.predictedPlayerState.stats[STAT_HEALTH] += cent->currentState.time2;
ADDRLP4 12
ADDRGP4 cg+107636+184
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
ADDI4
ASGNI4
line 423
;423:		if ( cg.predictedPlayerState.stats[ STAT_HEALTH ] > limit ) {
ADDRGP4 cg+107636+184
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $267
line 424
;424:			cg.predictedPlayerState.stats[ STAT_HEALTH ] = limit;
ADDRGP4 cg+107636+184
ADDRLP4 0
INDIRI4
ASGNI4
line 425
;425:		}
LABELV $267
line 426
;426:	}
LABELV $255
line 429
;427:
;428:	// armor prediction
;429:	if ( item->giType == IT_ARMOR && cent->currentState.time2 > 0 ) {
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 3
NEI4 $273
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 0
LEI4 $273
line 430
;430:		CG_AddArmor( item, cent->currentState.time2 );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddArmor
CALLV
pop
line 431
;431:		return;
ADDRGP4 $254
JUMPV
LABELV $273
line 435
;432:	}
;433:
;434:	// ammo prediction
;435:	if ( item->giType == IT_AMMO && cent->currentState.time2 > 0 ) {
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 2
NEI4 $275
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 0
LEI4 $275
line 436
;436:		CG_AddAmmo( item->giTag, cent->currentState.time2 );
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddAmmo
CALLV
pop
line 437
;437:		return;
ADDRGP4 $254
JUMPV
LABELV $275
line 441
;438:	}
;439:
;440:	// weapon prediction
;441:	if ( item->giType == IT_WEAPON && cent->currentState.time2 > 0 ) {
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $277
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 0
LEI4 $277
line 442
;442:		CG_AddWeapon( item->giTag, cent->currentState.time2, (cent->currentState.modelindex2 == 1) );
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 1
NEI4 $280
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $281
JUMPV
LABELV $280
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $281
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_AddWeapon
CALLV
pop
line 443
;443:		return;
ADDRGP4 $254
JUMPV
LABELV $277
line 447
;444:	}
;445:
;446:	// powerups prediction
;447:	if ( item->giType == IT_POWERUP && item->giTag >= PW_QUAD && item->giTag <= PW_FLIGHT ) {
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $282
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 1
LTI4 $282
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 6
GTI4 $282
line 449
;448:		// round timing to seconds to make multiple powerup timers count in sync
;449:		if ( !cg.predictedPlayerState.powerups[ item->giTag ] ) {
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+312
ADDP4
INDIRI4
CNSTI4 0
NEI4 $284
line 450
;450:			cg.predictedPlayerState.powerups[ item->giTag ] = cg.predictedPlayerState.commandTime - ( cg.predictedPlayerState.commandTime % 1000 );
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+312
ADDP4
ADDRGP4 cg+107636
INDIRI4
ADDRGP4 cg+107636
INDIRI4
CNSTI4 1000
MODI4
SUBI4
ASGNI4
line 452
;451:			// this assumption is correct only on transition and implies hardcoded 1.3 coefficient:
;452:			if ( item->giTag == PW_HASTE ) {
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 3
NEI4 $292
line 453
;453:				cg.predictedPlayerState.speed *= 1.3f;
ADDRLP4 4
ADDRGP4 cg+107636+52
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CVIF4 4
CNSTF4 1067869798
MULF4
CVFI4 4
ASGNI4
line 454
;454:			}
LABELV $292
line 455
;455:		}
LABELV $284
line 456
;456:		cg.predictedPlayerState.powerups[ item->giTag ] += cent->currentState.time2 * 1000;
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+312
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 1000
MULI4
ADDI4
ASGNI4
line 457
;457:	}	
LABELV $282
line 460
;458:
;459:	// holdable prediction
;460:	if ( item->giType == IT_HOLDABLE && ( item->giTag == HI_TELEPORTER || item->giTag == HI_MEDKIT ) ) {
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 6
NEI4 $298
ADDRLP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 1
EQI4 $300
ADDRLP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
NEI4 $298
LABELV $300
line 461
;461:		cg.predictedPlayerState.stats[ STAT_HOLDABLE_ITEM ] = item - bg_itemlist;
ADDRGP4 cg+107636+184+4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
ASGNI4
line 462
;462:	}
LABELV $298
line 463
;463:}
LABELV $254
endproc CG_PickupPrediction 16 12
proc CG_TouchItem 28 16
line 471
;464:
;465:
;466:/*
;467:===================
;468:CG_TouchItem
;469:===================
;470:*/
;471:static void CG_TouchItem( centity_t *cent ) {
line 474
;472:	const gitem_t *item;
;473:
;474:	if ( cg.allowPickupPrediction && cg.allowPickupPrediction > cg.time ) {
ADDRGP4 cg+157024
INDIRI4
CNSTI4 0
EQI4 $305
ADDRGP4 cg+157024
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $305
line 475
;475:		return;
ADDRGP4 $304
JUMPV
LABELV $305
line 478
;476:	}
;477:
;478:	if ( !cg_predictItems.integer ) {
ADDRGP4 cg_predictItems+12
INDIRI4
CNSTI4 0
NEI4 $310
line 479
;479:		return;
ADDRGP4 $304
JUMPV
LABELV $310
line 482
;480:	}
;481:
;482:	if ( !BG_PlayerTouchesItem( &cg.predictedPlayerState, &cent->currentState, cg.time ) ) {
ADDRGP4 cg+107636
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 BG_PlayerTouchesItem
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $313
line 483
;483:		return;
ADDRGP4 $304
JUMPV
LABELV $313
line 487
;484:	}
;485:
;486:	// never pick an item up twice in a prediction
;487:	if ( cent->delaySpawn > cg.time ) { 
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $317
line 488
;488:		return;
ADDRGP4 $304
JUMPV
LABELV $317
line 491
;489:	}
;490:
;491:	if ( !BG_CanItemBeGrabbed( cgs.gametype, &cent->currentState, &cg.predictedPlayerState ) ) {
ADDRGP4 cgs+31480
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cg+107636
ARGP4
ADDRLP4 8
ADDRGP4 BG_CanItemBeGrabbed
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $320
line 492
;492:		return;	// can't hold it
ADDRGP4 $304
JUMPV
LABELV $320
line 495
;493:	}
;494:
;495:	item = &bg_itemlist[ cent->currentState.modelindex ];
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 500
;496:
;497:	// Special case for flags.  
;498:	// We don't predict touching our own flag
;499:#ifdef MISSIONPACK
;500:	if( cgs.gametype == GT_1FCTF ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 5
NEI4 $324
line 501
;501:		if( item->giTag != PW_NEUTRALFLAG ) {
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 9
EQI4 $327
line 502
;502:			return;
ADDRGP4 $304
JUMPV
LABELV $327
line 504
;503:		}
;504:	}
LABELV $324
line 505
;505:	if( cgs.gametype == GT_CTF || cgs.gametype == GT_HARVESTER ) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 4
EQI4 $333
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 7
NEI4 $329
LABELV $333
line 509
;506:#else
;507:	if( cgs.gametype == GT_CTF ) {
;508:#endif
;509:		if (cg.predictedPlayerState.persistant[PERS_TEAM] == TEAM_RED &&
ADDRGP4 cg+107636+248+12
INDIRI4
CNSTI4 1
NEI4 $334
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $334
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $334
line 511
;510:			item->giType == IT_TEAM && item->giTag == PW_REDFLAG)
;511:			return;
ADDRGP4 $304
JUMPV
LABELV $334
line 512
;512:		if (cg.predictedPlayerState.persistant[PERS_TEAM] == TEAM_BLUE &&
ADDRGP4 cg+107636+248+12
INDIRI4
CNSTI4 2
NEI4 $339
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $339
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $339
line 514
;513:			item->giType == IT_TEAM && item->giTag == PW_BLUEFLAG)
;514:			return;
ADDRGP4 $304
JUMPV
LABELV $339
line 515
;515:	}
LABELV $329
line 518
;516:
;517:	// grab it
;518:	BG_AddPredictableEventToPlayerstate( EV_ITEM_PICKUP, cent->currentState.modelindex , &cg.predictedPlayerState, cent - cg_entities );
CNSTI4 19
ARGI4
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+107636
ARGP4
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRGP4 cg_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 740
DIVI4
ARGI4
ADDRGP4 BG_AddPredictableEventToPlayerstate
CALLV
pop
line 521
;519:
;520:	// perform prediction
;521:	CG_PickupPrediction( cent, item );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_PickupPrediction
CALLV
pop
line 524
;522:
;523:	// remove it from the frame so it won't be drawn
;524:	cent->currentState.eFlags |= EF_NODRAW;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 527
;525:
;526:	// don't touch it again this prediction
;527:	cent->miscTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 530
;528:
;529:	// delay next potential pickup for some time
;530:	cent->delaySpawn = cg.time + ( cg.meanPing > 0 ? cg.meanPing * 2 + 100 : 333 );
ADDRGP4 cg+157016
INDIRI4
CNSTI4 0
LEI4 $350
ADDRLP4 20
ADDRGP4 cg+157016
INDIRI4
CNSTI4 1
LSHI4
CNSTI4 100
ADDI4
ASGNI4
ADDRGP4 $351
JUMPV
LABELV $350
ADDRLP4 20
CNSTI4 333
ASGNI4
LABELV $351
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 20
INDIRI4
ADDI4
ASGNI4
line 531
;531:	cent->delaySpawnPlayed = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 452
ADDP4
CNSTI4 0
ASGNI4
line 534
;532:
;533:	// if it's a weapon, give them some predicted ammo so the autoswitch will work
;534:	if ( item->giType == IT_WEAPON ) {
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $352
line 535
;535:		cg.predictedPlayerState.stats[ STAT_WEAPONS ] |= 1 << item->giTag;
ADDRLP4 24
ADDRGP4 cg+107636+184+12
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
LSHI4
BORI4
ASGNI4
line 536
;536:		if ( !cg.predictedPlayerState.ammo[ item->giTag ] ) {
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+376
ADDP4
INDIRI4
CNSTI4 0
NEI4 $357
line 537
;537:			cg.predictedPlayerState.ammo[ item->giTag ] = 1;
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+376
ADDP4
CNSTI4 1
ASGNI4
line 538
;538:		}
LABELV $357
line 539
;539:	}
LABELV $352
line 540
;540:}
LABELV $304
endproc CG_TouchItem 28 16
proc CG_TouchTriggerPrediction 84 28
line 550
;541:
;542:
;543:/*
;544:=========================
;545:CG_TouchTriggerPrediction
;546:
;547:Predict push triggers and items
;548:=========================
;549:*/
;550:static void CG_TouchTriggerPrediction( void ) {
line 559
;551:	int			i;
;552:	trace_t		trace;
;553:	entityState_t	*ent;
;554:	clipHandle_t cmodel;
;555:	centity_t	*cent;
;556:	qboolean	spectator;
;557:
;558:	// dead clients don't activate triggers
;559:	if ( cg.predictedPlayerState.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 cg+107636+184
INDIRI4
CNSTI4 0
GTI4 $364
line 560
;560:		return;
ADDRGP4 $363
JUMPV
LABELV $364
line 563
;561:	}
;562:
;563:	spectator = ( cg.predictedPlayerState.pm_type == PM_SPECTATOR );
ADDRGP4 cg+107636+4
INDIRI4
CNSTI4 2
NEI4 $371
ADDRLP4 76
CNSTI4 1
ASGNI4
ADDRGP4 $372
JUMPV
LABELV $371
ADDRLP4 76
CNSTI4 0
ASGNI4
LABELV $372
ADDRLP4 72
ADDRLP4 76
INDIRI4
ASGNI4
line 565
;564:
;565:	if ( cg.predictedPlayerState.pm_type != PM_NORMAL && !spectator ) {
ADDRGP4 cg+107636+4
INDIRI4
CNSTI4 0
EQI4 $373
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $373
line 566
;566:		return;
ADDRGP4 $363
JUMPV
LABELV $373
line 569
;567:	}
;568:
;569:	for ( i = 0 ; i < cg_numTriggerEntities ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $380
JUMPV
LABELV $377
line 570
;570:		cent = cg_triggerEntities[ i ];
ADDRLP4 12
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_triggerEntities
ADDP4
INDIRP4
ASGNP4
line 571
;571:		ent = &cent->currentState;
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 573
;572:
;573:		if ( ent->eType == ET_ITEM && !spectator ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $381
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $381
line 574
;574:			CG_TouchItem( cent );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 CG_TouchItem
CALLV
pop
line 575
;575:			continue;
ADDRGP4 $378
JUMPV
LABELV $381
line 578
;576:		}
;577:
;578:		if ( ent->solid != SOLID_BMODEL ) {
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
EQI4 $383
line 579
;579:			continue;
ADDRGP4 $378
JUMPV
LABELV $383
line 582
;580:		}
;581:
;582:		cmodel = trap_CM_InlineModel( ent->modelindex );
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRLP4 80
ADDRGP4 trap_CM_InlineModel
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 80
INDIRI4
ASGNI4
line 583
;583:		if ( !cmodel ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $385
line 584
;584:			continue;
ADDRGP4 $378
JUMPV
LABELV $385
line 587
;585:		}
;586:
;587:		trap_CM_BoxTrace( &trace, cg.predictedPlayerState.origin, cg.predictedPlayerState.origin, 
ADDRLP4 16
ARGP4
ADDRGP4 cg+107636+20
ARGP4
ADDRGP4 cg+107636+20
ARGP4
ADDRGP4 cg_pmove+176
ARGP4
ADDRGP4 cg_pmove+188
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 590
;588:			cg_pmove.mins, cg_pmove.maxs, cmodel, -1 );
;589:
;590:		if ( !trace.startsolid ) {
ADDRLP4 16+4
INDIRI4
CNSTI4 0
NEI4 $393
line 591
;591:			continue;
ADDRGP4 $378
JUMPV
LABELV $393
line 594
;592:		}
;593:
;594:		if ( ent->eType == ET_TELEPORT_TRIGGER ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 9
NEI4 $396
line 595
;595:			cg.hyperspace = qtrue;
ADDRGP4 cg+107632
CNSTI4 1
ASGNI4
line 596
;596:		} else if ( ent->eType == ET_PUSH_TRIGGER ) {
ADDRGP4 $397
JUMPV
LABELV $396
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 8
NEI4 $399
line 597
;597:			BG_TouchJumpPad( &cg.predictedPlayerState, ent );
ADDRGP4 cg+107636
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BG_TouchJumpPad
CALLV
pop
line 598
;598:		}
LABELV $399
LABELV $397
line 599
;599:	}
LABELV $378
line 569
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $380
ADDRLP4 4
INDIRI4
ADDRGP4 cg_numTriggerEntities
INDIRI4
LTI4 $377
line 602
;600:
;601:	// if we didn't touch a jump pad this pmove frame
;602:	if ( cg.predictedPlayerState.jumppad_frame != cg.predictedPlayerState.pmove_framecount ) {
ADDRGP4 cg+107636+460
INDIRI4
ADDRGP4 cg+107636+456
INDIRI4
EQI4 $402
line 603
;603:		cg.predictedPlayerState.jumppad_frame = 0;
ADDRGP4 cg+107636+460
CNSTI4 0
ASGNI4
line 604
;604:		cg.predictedPlayerState.jumppad_ent = 0;
ADDRGP4 cg+107636+448
CNSTI4 0
ASGNI4
line 605
;605:	}
LABELV $402
line 606
;606:}
LABELV $363
endproc CG_TouchTriggerPrediction 84 28
proc CG_CheckTimers 16 0
line 609
;607:
;608:
;609:static void CG_CheckTimers( void ) {
line 613
;610:	int i;
;611:
;612:	// no prediction for spectators
;613:	if ( cg.predictedPlayerState.pm_type == PM_SPECTATOR ) {
ADDRGP4 cg+107636+4
INDIRI4
CNSTI4 2
NEI4 $413
line 614
;614:		return;
ADDRGP4 $412
JUMPV
LABELV $413
line 618
;615:	}
;616:
;617:	// no armor/health/powerups prediction for dead bodies
;618:	if ( cg.predictedPlayerState.stats[STAT_HEALTH] <= 0 )
ADDRGP4 cg+107636+184
INDIRI4
CNSTI4 0
GTI4 $417
line 619
;619:		return;
ADDRGP4 $412
JUMPV
LABELV $417
line 622
;620:
;621:	// periodic tasks
;622:	if ( cg.timeResidual && cg.predictedPlayerState.commandTime >= cg.timeResidual && !cg.thisFrameTeleport ) {
ADDRGP4 cg+157020
INDIRI4
CNSTI4 0
EQI4 $421
ADDRGP4 cg+107636
INDIRI4
ADDRGP4 cg+157020
INDIRI4
LTI4 $421
ADDRGP4 cg+107592
INDIRI4
CNSTI4 0
NEI4 $421
line 623
;623:		cg.timeResidual += 1000;
ADDRLP4 4
ADDRGP4 cg+157020
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 624
;624:		if ( cg.predictedPlayerState.powerups[ PW_REGEN ] ) {
ADDRGP4 cg+107636+312+20
INDIRI4
CNSTI4 0
EQI4 $428
line 625
;625:			int maxhealth = cg.predictedPlayerState.stats[ STAT_MAX_HEALTH ];
ADDRLP4 8
ADDRGP4 cg+107636+184+28
INDIRI4
ASGNI4
line 626
;626:			if ( cg.predictedPlayerState.stats[ STAT_HEALTH ] < maxhealth ) {
ADDRGP4 cg+107636+184
INDIRI4
ADDRLP4 8
INDIRI4
GEI4 $436
line 627
;627:				cg.predictedPlayerState.stats[ STAT_HEALTH ] += 15;
ADDRLP4 12
ADDRGP4 cg+107636+184
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 15
ADDI4
ASGNI4
line 628
;628:				if ( cg.predictedPlayerState.stats[ STAT_HEALTH ] > maxhealth * 1.1 ) {
ADDRGP4 cg+107636+184
INDIRI4
CVIF4 4
ADDRLP4 8
INDIRI4
CVIF4 4
CNSTF4 1066192077
MULF4
LEF4 $429
line 629
;629:					cg.predictedPlayerState.stats[ STAT_HEALTH ] = maxhealth * 1.1;
ADDRGP4 cg+107636+184
ADDRLP4 8
INDIRI4
CVIF4 4
CNSTF4 1066192077
MULF4
CVFI4 4
ASGNI4
line 630
;630:				}
line 632
;631:				// TODO: add external EV_POWERUP_REGEN
;632:			} else if ( cg.predictedPlayerState.stats[ STAT_HEALTH ] < maxhealth * 2) {
ADDRGP4 $429
JUMPV
LABELV $436
ADDRGP4 cg+107636+184
INDIRI4
ADDRLP4 8
INDIRI4
CNSTI4 1
LSHI4
GEI4 $429
line 633
;633:				cg.predictedPlayerState.stats[ STAT_HEALTH ] += 5;
ADDRLP4 12
ADDRGP4 cg+107636+184
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 5
ADDI4
ASGNI4
line 634
;634:				if ( cg.predictedPlayerState.stats[ STAT_HEALTH ] > maxhealth * 2 ) {
ADDRGP4 cg+107636+184
INDIRI4
ADDRLP4 8
INDIRI4
CNSTI4 1
LSHI4
LEI4 $429
line 635
;635:					cg.predictedPlayerState.stats[ STAT_HEALTH ] = maxhealth * 2;
ADDRGP4 cg+107636+184
ADDRLP4 8
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 636
;636:				}
line 638
;637:				// TODO: add external EV_POWERUP_REGEN
;638:			}
line 639
;639:		} else {
ADDRGP4 $429
JUMPV
LABELV $428
line 640
;640:			if ( cg.predictedPlayerState.stats[ STAT_HEALTH ] > cg.predictedPlayerState.stats[ STAT_MAX_HEALTH ] ) {
ADDRGP4 cg+107636+184
INDIRI4
ADDRGP4 cg+107636+184+28
INDIRI4
LEI4 $460
line 641
;641:				cg.predictedPlayerState.stats[ STAT_HEALTH ]--;
ADDRLP4 8
ADDRGP4 cg+107636+184
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 642
;642:			}
LABELV $460
line 643
;643:		}
LABELV $429
line 644
;644:		if ( cg.predictedPlayerState.stats[ STAT_ARMOR ] > cg.predictedPlayerState.stats[ STAT_MAX_HEALTH ] ) {
ADDRGP4 cg+107636+184+16
INDIRI4
ADDRGP4 cg+107636+184+28
INDIRI4
LEI4 $469
line 645
;645:			cg.predictedPlayerState.stats[ STAT_ARMOR ]--;
ADDRLP4 8
ADDRGP4 cg+107636+184+16
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 646
;646:		}
LABELV $469
line 647
;647:	}
LABELV $421
line 650
;648:
;649:	// turn off any expired powerups
;650:	for ( i = 0 ; i < MAX_POWERUPS ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $480
line 651
;651:		if ( !cg.predictedPlayerState.powerups[ i ] )
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+312
ADDP4
INDIRI4
CNSTI4 0
NEI4 $484
line 652
;652:			continue;
ADDRGP4 $481
JUMPV
LABELV $484
line 653
;653:		if ( cg.predictedPlayerState.powerups[ i ] < cg.predictedPlayerState.commandTime ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+312
ADDP4
INDIRI4
ADDRGP4 cg+107636
INDIRI4
GEI4 $488
line 654
;654:			cg.predictedPlayerState.powerups[ i ] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+312
ADDP4
CNSTI4 0
ASGNI4
line 655
;655:		}
LABELV $488
line 656
;656:	}
LABELV $481
line 650
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $480
line 657
;657:}
LABELV $412
endproc CG_CheckTimers 16 0
proc CG_IsUnacceptableError 164 36
line 660
;658:
;659:
;660:static int CG_IsUnacceptableError( playerState_t *ps, playerState_t *pps, qboolean *forceMove ) {
line 664
;661:	vec3_t delta;
;662:	int i, n, v0, v1;
;663: 
;664:	if ( pps->pm_time != ps->pm_time ||
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
NEI4 $499
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
NEI4 $499
ADDRLP4 28
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
EQI4 $496
LABELV $499
line 666
;665:		 pps->pm_type != ps->pm_type ||
;666:		 pps->pm_flags != ps->pm_flags ) {
line 667
;667:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $495
JUMPV
LABELV $496
line 670
;668:	}
;669: 
;670:	VectorSubtract( pps->origin, ps->origin, delta );
ADDRLP4 36
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 36
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 36
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
line 671
;671:	if ( VectorLengthSquared( delta ) > 0.01f * 0.01f ) {
ADDRLP4 12
ARGP4
ADDRLP4 44
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 44
INDIRF4
CNSTF4 953267991
LEF4 $502
line 672
;672:		if( cg_showmiss.integer > 2 ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 2
LEI4 $504
line 673
;673:			CG_Printf( "origin delta: %.2f  ", VectorLength( delta ) );
ADDRLP4 12
ARGP4
ADDRLP4 48
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRGP4 $507
ARGP4
ADDRLP4 48
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 674
;674:		}
LABELV $504
line 675
;675:		return 2;
CNSTI4 2
RETI4
ADDRGP4 $495
JUMPV
LABELV $502
line 678
;676:	}
;677:
;678:	VectorSubtract( pps->velocity, ps->velocity, delta );
ADDRLP4 48
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 48
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 48
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
SUBF4
ASGNF4
line 679
;679:	if( VectorLengthSquared( delta ) > 0.01f * 0.01f ) {
ADDRLP4 12
ARGP4
ADDRLP4 56
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 56
INDIRF4
CNSTF4 953267991
LEF4 $510
line 680
;680:		if( cg_showmiss.integer > 2 ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 2
LEI4 $512
line 681
;681:			CG_Printf( "velocity delta: %.2f  ", VectorLength( delta ) );
ADDRLP4 12
ARGP4
ADDRLP4 60
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRGP4 $515
ARGP4
ADDRLP4 60
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 682
;682:		}
LABELV $512
line 683
;683:		return 3;
CNSTI4 3
RETI4
ADDRGP4 $495
JUMPV
LABELV $510
line 686
;684:	}
;685:
;686:	if( pps->weaponTime != ps->weaponTime ||
ADDRLP4 60
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
NEI4 $523
ADDRLP4 60
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
NEI4 $523
ADDRLP4 60
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
NEI4 $523
ADDRLP4 60
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
NEI4 $523
ADDRLP4 60
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
NEI4 $523
ADDRLP4 60
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
NEI4 $523
ADDRLP4 60
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
EQI4 $516
LABELV $523
line 692
;687:		pps->gravity != ps->gravity ||
;688:		pps->speed != ps->speed ||
;689:		pps->delta_angles[ 0 ] != ps->delta_angles[ 0 ] ||
;690:		pps->delta_angles[ 1 ] != ps->delta_angles[ 1 ] ||
;691:		pps->delta_angles[ 2 ] != ps->delta_angles[ 2 ] || 
;692:		pps->groundEntityNum != ps->groundEntityNum ) {
line 693
;693:		if ( cg_showmiss.integer > 1 )
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 1
LEI4 $524
line 694
;694:			CG_Printf( "%i %i %i %i => %i %i %i %i", 
ADDRGP4 $527
ARGP4
ADDRLP4 68
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $524
line 698
;695:				pps->weaponTime, pps->gravity, pps->speed, pps->groundEntityNum,
;696:				ps->weaponTime, ps->gravity, ps->speed, ps->groundEntityNum ); 
;697:
;698:		return 4;
CNSTI4 4
RETI4
ADDRGP4 $495
JUMPV
LABELV $516
line 702
;699:	}
;700:
;701:	// forward gesture animation
;702:	if ( pps->torsoAnim != ps->torsoAnim && (ps->torsoAnim & ~ANIM_TOGGLEBIT ) == TORSO_GESTURE ) {
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 4
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDRLP4 68
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
EQI4 $528
ADDRLP4 68
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
CNSTI4 6
NEI4 $528
line 703
;703:		for ( n = 0 ; n < NUM_SAVED_STATES; n++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $530
line 704
;704:			cg.savedPmoveStates[ n ].torsoAnim = ps->torsoAnim;
ADDRLP4 4
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126120+84
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ASGNI4
line 705
;705:			cg.savedPmoveStates[ n ].torsoTimer = ps->torsoTimer;
ADDRLP4 4
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126120+80
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ASGNI4
line 706
;706:		}
LABELV $531
line 703
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 66
LTI4 $530
line 707
;707:	}
LABELV $528
line 709
;708:
;709:	if ( pps->legsTimer != ps->legsTimer ||	pps->legsAnim != ps->legsAnim ||
ADDRLP4 72
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
ADDRLP4 76
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
NEI4 $543
ADDRLP4 72
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
ADDRLP4 76
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
NEI4 $543
ADDRLP4 72
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ADDRLP4 76
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
NEI4 $543
ADDRLP4 72
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDRLP4 76
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
NEI4 $543
ADDRLP4 72
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
ADDRLP4 76
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
EQI4 $538
LABELV $543
line 711
;710:		pps->torsoTimer != ps->torsoTimer || pps->torsoAnim != ps->torsoAnim ||
;711:		pps->movementDir != ps->movementDir ) {
line 712
;712:		return 5;
CNSTI4 5
RETI4
ADDRGP4 $495
JUMPV
LABELV $538
line 715
;713:	}
;714:
;715:	VectorSubtract( pps->grapplePoint, ps->grapplePoint, delta );
ADDRLP4 80
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 80
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 80
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 4
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 716
;716:	if( VectorLengthSquared( delta ) > 0.01f * 0.01f )
ADDRLP4 12
ARGP4
ADDRLP4 88
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 88
INDIRF4
CNSTF4 953267991
LEF4 $546
line 717
;717:		return 6;
CNSTI4 6
RETI4
ADDRGP4 $495
JUMPV
LABELV $546
line 720
;718:
;719:	// check/update eFlags if needed
;720:	v0 = pps->eFlags & EF_NOPREDICT;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 784456
BANDI4
ASGNI4
line 721
;721:	v1 = ps->eFlags & EF_NOPREDICT;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 784456
BANDI4
ASGNI4
line 722
;722:	if ( v0 != v1 ) {
ADDRLP4 8
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $548
line 723
;723:		for ( i = 0 ; i < NUM_SAVED_STATES; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $550
line 724
;724:			cg.savedPmoveStates[ i ].eFlags = (cg.savedPmoveStates[ i ].eFlags & ~EF_NOPREDICT) | v1 ;
ADDRLP4 0
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126120+104
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126120+104
ADDP4
INDIRI4
CNSTI4 -784457
BANDI4
ADDRLP4 24
INDIRI4
BORI4
ASGNI4
line 725
;725:		}
LABELV $551
line 723
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 66
LTI4 $550
line 726
;726:		pps->eFlags = (pps->eFlags & ~EF_NOPREDICT) | v1;
ADDRLP4 92
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 92
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 -784457
BANDI4
ADDRLP4 24
INDIRI4
BORI4
ASGNI4
line 727
;727:	}
LABELV $548
line 729
;728:
;729:	if ( pps->eFlags !=  ps->eFlags ) {
ADDRFP4 4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
EQI4 $558
line 730
;730:		if ( cg_showmiss.integer > 1 )
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 1
LEI4 $560
line 731
;731:			CG_Printf( "eFlags %i => %i", pps->eFlags, ps->eFlags );
ADDRGP4 $563
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $560
line 732
;732:		return 7;
CNSTI4 7
RETI4
ADDRGP4 $495
JUMPV
LABELV $558
line 735
;733:	}
;734:
;735:	if( pps->eventSequence != ps->eventSequence )
ADDRFP4 4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
EQI4 $564
line 736
;736:		return 8;
CNSTI4 8
RETI4
ADDRGP4 $495
JUMPV
LABELV $564
line 738
;737:
;738:	for( i = 0; i < MAX_PS_EVENTS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $566
line 739
;739:		if ( pps->events[ i ] != ps->events[ i ] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
EQI4 $570
line 740
;740:			if ( cg_showmiss.integer > 1 ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 1
LEI4 $572
line 741
;741:				CG_Printf( "event[%i] %i => %i\n", i, pps->events[ i ], ps->events[ i ] );
ADDRGP4 $575
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 742
;742:			}
LABELV $572
line 743
;743:			return 9;
CNSTI4 9
RETI4
ADDRGP4 $495
JUMPV
LABELV $570
line 745
;744:		}
;745:		if ( pps->eventParms[ i ] != ps->eventParms[ i ] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 120
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDP4
INDIRI4
EQI4 $576
line 746
;746:			if ( cg_showmiss.integer > 1 ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 1
LEI4 $578
line 747
;747:				CG_Printf( "eventParms[%i] %i => %i\n", i, pps->eventParms[ i ], ps->eventParms[ i ] );
ADDRGP4 $581
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 120
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 748
;748:			}
LABELV $578
line 749
;749:			return 9;
CNSTI4 9
RETI4
ADDRGP4 $495
JUMPV
LABELV $576
line 751
;750:		}
;751:	}
LABELV $567
line 738
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $566
line 753
;752:
;753:	if ( pps->externalEvent != ps->externalEvent ||
ADDRLP4 92
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
ADDRLP4 96
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
NEI4 $585
ADDRLP4 92
INDIRP4
CNSTI4 132
ADDP4
INDIRI4
ADDRLP4 96
INDIRP4
CNSTI4 132
ADDP4
INDIRI4
NEI4 $585
ADDRLP4 92
INDIRP4
CNSTI4 136
ADDP4
INDIRI4
ADDRLP4 96
INDIRP4
CNSTI4 136
ADDP4
INDIRI4
EQI4 $582
LABELV $585
line 755
;754:		pps->externalEventParm != ps->externalEventParm ||
;755:		pps->externalEventTime != ps->externalEventTime ) {
line 756
;756:		return 10;
CNSTI4 10
RETI4
ADDRGP4 $495
JUMPV
LABELV $582
line 759
;757:	}
;758:
;759:	if ( pps->clientNum != ps->clientNum ||
ADDRLP4 100
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ADDRLP4 104
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
NEI4 $589
ADDRLP4 100
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ADDRLP4 104
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
NEI4 $589
ADDRLP4 100
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ADDRLP4 104
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
EQI4 $586
LABELV $589
line 761
;760:		pps->weapon != ps->weapon ||
;761:		pps->weaponstate != ps->weaponstate ) {
line 762
;762:		return 11;
CNSTI4 11
RETI4
ADDRGP4 $495
JUMPV
LABELV $586
line 765
;763:	}
;764:
;765:	if ( fabs( AngleDelta( ps->viewangles[ 0 ], pps->viewangles[ 0 ] ) ) > 1.0f ||
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRP4
CNSTI4 152
ADDP4
INDIRF4
ARGF4
ADDRLP4 108
ADDRGP4 AngleDelta
CALLF4
ASGNF4
ADDRLP4 108
INDIRF4
ARGF4
ADDRLP4 112
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 112
INDIRF4
CNSTF4 1065353216
GTF4 $593
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 116
ADDRGP4 AngleDelta
CALLF4
ASGNF4
ADDRLP4 116
INDIRF4
ARGF4
ADDRLP4 120
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 120
INDIRF4
CNSTF4 1065353216
GTF4 $593
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 124
ADDRGP4 AngleDelta
CALLF4
ASGNF4
ADDRLP4 124
INDIRF4
ARGF4
ADDRLP4 128
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 128
INDIRF4
CNSTF4 1065353216
LEF4 $590
LABELV $593
line 767
;766:		fabs( AngleDelta( ps->viewangles[ 1 ], pps->viewangles[ 1 ] ) ) > 1.0f ||
;767:		fabs( AngleDelta( ps->viewangles[ 2 ], pps->viewangles[ 2 ] ) ) > 1.0f ) {
line 768
;768:		return 12;
CNSTI4 12
RETI4
ADDRGP4 $495
JUMPV
LABELV $590
line 771
;769:	}
;770:
;771:	if ( pps->viewheight != ps->viewheight )
ADDRFP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
EQI4 $594
line 772
;772:  		return 13;
CNSTI4 13
RETI4
ADDRGP4 $495
JUMPV
LABELV $594
line 774
;773:
;774:	if( pps->damageEvent != ps->damageEvent ||
ADDRLP4 132
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 136
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 132
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ADDRLP4 136
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
NEI4 $600
ADDRLP4 132
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ADDRLP4 136
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
NEI4 $600
ADDRLP4 132
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ADDRLP4 136
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
NEI4 $600
ADDRLP4 132
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ADDRLP4 136
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
EQI4 $596
LABELV $600
line 777
;775:		pps->damageYaw != ps->damageYaw ||
;776:		pps->damagePitch != ps->damagePitch ||
;777:		pps->damageCount != ps->damageCount ) {
line 778
;778:		if ( cg_showmiss.integer > 1 )
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 1
LEI4 $601
line 779
;779:			CG_Printf( "dmg %i %i %i %i >= %i %i %i %i\n", 
ADDRGP4 $604
ARGP4
ADDRLP4 140
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 140
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ARGI4
ADDRLP4 140
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ARGI4
ADDRLP4 140
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 140
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ARGI4
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ARGI4
ADDRLP4 144
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ARGI4
ADDRLP4 144
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 144
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $601
line 782
;780:				pps->damageEvent, pps->damageYaw, pps->damagePitch, pps->damageCount,
;781:				ps->damageEvent, ps->damageYaw, ps->damagePitch, ps->damageCount );
;782:		return 14;
CNSTI4 14
RETI4
ADDRGP4 $495
JUMPV
LABELV $596
line 786
;783:	}
;784:
;785:	// health countdown?
;786:	if ( pps->stats[ STAT_HEALTH ] == ps->stats[ STAT_HEALTH ] + 1 && ps->stats[ STAT_HEALTH ] >= ps->stats[ STAT_MAX_HEALTH ] ) {
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 140
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 1
ADDI4
NEI4 $605
ADDRLP4 140
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 140
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
LTI4 $605
line 787
;787:		cg.timeResidual = ps->commandTime + 1000;
ADDRGP4 cg+157020
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 788
;788:		for ( n = 0 ; n < NUM_SAVED_STATES; n++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $608
line 789
;789:			cg.savedPmoveStates[ n ].stats[ STAT_HEALTH ] = ps->stats[ STAT_HEALTH ];
ADDRLP4 4
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126120+184
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 790
;790:		}
LABELV $609
line 788
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 66
LTI4 $608
line 792
;791:
;792:	}
LABELV $605
line 794
;793:	// armor countdown?
;794:	if ( pps->stats[ STAT_ARMOR ] == ps->stats[ STAT_ARMOR ] - 1 && ps->stats[ STAT_ARMOR ] >= ps->stats[ STAT_MAX_HEALTH ] ) {
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 4
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ADDRLP4 144
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CNSTI4 1
SUBI4
NEI4 $614
ADDRLP4 144
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ADDRLP4 144
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
LTI4 $614
line 796
;795:		// we may need few frames to sync with client->timeResidual on server side
;796:		cg.timeResidual = ps->commandTime + 1000;
ADDRGP4 cg+157020
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 797
;797:		for ( n = 0 ; n < NUM_SAVED_STATES; n++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $617
line 798
;798:			cg.savedPmoveStates[ n ].stats[ STAT_ARMOR ] = ps->stats[ STAT_ARMOR ];
ADDRLP4 4
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126120+184+16
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ASGNI4
line 799
;799:		}
LABELV $618
line 797
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 66
LTI4 $617
line 800
;800:	}
LABELV $614
line 802
;801:
;802:	for( i = 0; i < MAX_STATS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $624
line 804
;803:		// we can't predict some flags
;804:		if ( i == STAT_CLIENTS_READY /*|| i == STAT_MAX_HEALTH */ ) {
ADDRLP4 0
INDIRI4
CNSTI4 6
NEI4 $628
line 805
;805:			for ( n = 0 ; n < NUM_SAVED_STATES; n++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $630
line 806
;806:				cg.savedPmoveStates[ n ].stats[ i ] = ps->stats[ i ];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126120+184
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDP4
INDIRI4
ASGNI4
line 807
;807:			}
LABELV $631
line 805
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 66
LTI4 $630
line 808
;808:			continue;
ADDRGP4 $625
JUMPV
LABELV $628
line 810
;809:		}
;810:		if ( pps->stats[ i ] != ps->stats[ i ] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDP4
INDIRI4
EQI4 $636
line 811
;811:			if ( cg_showmiss.integer > 1 ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 1
LEI4 $638
line 812
;812:				CG_Printf( "stats[%i] %i => %i ", i, pps->stats[ i ], ps->stats[ i ] );
ADDRGP4 $641
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 813
;813:			}
LABELV $638
line 814
;814:			return 15;
CNSTI4 15
RETI4
ADDRGP4 $495
JUMPV
LABELV $636
line 816
;815:		}
;816:	}
LABELV $625
line 802
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $624
line 819
;817:
;818:
;819:	for( i = 0; i < MAX_PERSISTANT ; i++ )
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $642
line 820
;820:	{
line 821
;821:		if ( pps->persistant[ i ] != ps->persistant[ i ] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 248
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 248
ADDP4
ADDP4
INDIRI4
EQI4 $646
line 822
;822:			if ( i >= PERS_TEAM && i <= PERS_PLAYEREVENTS ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $648
ADDRLP4 0
INDIRI4
CNSTI4 5
GTI4 $648
line 823
;823:				if ( cg_showmiss.integer > 1 ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 1
LEI4 $650
line 824
;824:					CG_Printf( "persistant[%i] %i => %i ", i, pps->persistant[ i ], ps->persistant[ i ] );
ADDRGP4 $653
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 248
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 248
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 825
;825:				}
LABELV $650
line 826
;826:				return 16;
CNSTI4 16
RETI4
ADDRGP4 $495
JUMPV
LABELV $648
line 828
;827:			}
;828:			v0 = ps->persistant[ i ];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 248
ADDP4
ADDP4
INDIRI4
ASGNI4
line 829
;829:			for ( n = 0 ; n < NUM_SAVED_STATES; n++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $654
line 830
;830:				cg.savedPmoveStates[ n ].persistant[ i ] = v0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126120+248
ADDP4
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 831
;831:			}
LABELV $655
line 829
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 66
LTI4 $654
line 832
;832:			*forceMove = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 1
ASGNI4
line 833
;833:		}
LABELV $646
line 834
;834:	}
LABELV $643
line 819
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $642
line 836
;835:
;836:	for( i = 0; i < MAX_WEAPONS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $660
line 837
;837:		if( pps->ammo[ i ] != ps->ammo[ i ] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
EQI4 $664
line 838
;838:			if ( cg_showmiss.integer > 1 ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 1
LEI4 $666
line 839
;839:				CG_Printf( "ammo[%i] %i => %i ", i, pps->ammo[ i ], ps->ammo[ i ] );
ADDRGP4 $669
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 840
;840:			}
LABELV $666
line 841
;841:			return 18;
CNSTI4 18
RETI4
ADDRGP4 $495
JUMPV
LABELV $664
line 843
;842:		}
;843:	}
LABELV $661
line 836
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $660
line 845
;844:
;845:	if ( pps->generic1 != ps->generic1 || pps->loopSound != ps->loopSound ) {
ADDRLP4 148
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 148
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
ADDRLP4 152
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
NEI4 $672
ADDRLP4 148
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
ADDRLP4 152
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
EQI4 $670
LABELV $672
line 846
;846:		return 19;
CNSTI4 19
RETI4
ADDRGP4 $495
JUMPV
LABELV $670
line 849
;847:	}
;848:
;849:	for ( i = 0; i < MAX_POWERUPS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $673
line 850
;850:		if( pps->powerups[ i ] != ps->powerups[ i ] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
EQI4 $677
line 851
;851:			if ( cg_showmiss.integer > 1 )
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 1
LEI4 $679
line 852
;852:				CG_Printf( "powerups[%i] %i => %i ", i, pps->powerups[i], ps->powerups[i] );
ADDRGP4 $682
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $679
line 853
;853:			return 20;
CNSTI4 20
RETI4
ADDRGP4 $495
JUMPV
LABELV $677
line 855
;854:		}
;855:	}
LABELV $674
line 849
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $673
line 857
;856:
;857:	return 0;
CNSTI4 0
RETI4
LABELV $495
endproc CG_IsUnacceptableError 164 36
export CG_PredictPlayerState
proc CG_PredictPlayerState 596 28
line 887
;858:}
;859:
;860:
;861:/*
;862:=================
;863:CG_PredictPlayerState
;864:
;865:Generates cg.predictedPlayerState for the current cg.time
;866:cg.predictedPlayerState is guaranteed to be valid after exiting.
;867:
;868:For demo playback, this will be an interpolation between two valid
;869:playerState_t.
;870:
;871:For normal gameplay, it will be the result of predicted usercmd_t on
;872:top of the most recent playerState_t received from the server.
;873:
;874:Each new snapshot will usually have one or more new usercmd over the last,
;875:but we simulate all unacknowledged commands each time, not just the new ones.
;876:This means that on an internet connection, quite a few pmoves may be issued
;877:each frame.
;878:
;879:OPTIMIZE: don't re-simulate unless the newly arrived snapshot playerState_t
;880:differs from the predicted one.  Would require saving all intermediate
;881:playerState_t during prediction.
;882:
;883:We detect prediction errors and allow them to be decayed off over several frames
;884:to ease the jerk.
;885:=================
;886:*/
;887:void CG_PredictPlayerState( void ) {
line 893
;888:	int			cmdNum, current;
;889:	playerState_t	oldPlayerState;
;890:	qboolean	moved;
;891:	usercmd_t	oldestCmd;
;892:	usercmd_t	latestCmd;
;893:	int stateIndex = 0, predictCmd = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 484
CNSTI4 0
ASGNI4
line 895
;894:
;895:	cg.hyperspace = qfalse;	// will be set if touching a trigger_teleport
ADDRGP4 cg+107632
CNSTI4 0
ASGNI4
line 900
;896:
;897:	// if this is the first frame we must guarantee
;898:	// predictedPlayerState is valid even if there is some
;899:	// other error condition
;900:	if ( !cg.validPPS ) {
ADDRGP4 cg+108844
INDIRI4
CNSTI4 0
NEI4 $685
line 901
;901:		cg.validPPS = qtrue;
ADDRGP4 cg+108844
CNSTI4 1
ASGNI4
line 902
;902:		cg.predictedPlayerState = cg.snap->ps;
ADDRGP4 cg+107636
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 468
line 903
;903:	}
LABELV $685
line 907
;904:
;905:
;906:	// demo playback just copies the moves
;907:	if ( cg.demoPlayback || (cg.snap->ps.pm_flags & PMF_FOLLOW) ) {
ADDRGP4 cg+8
INDIRI4
CNSTI4 0
NEI4 $695
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $691
LABELV $695
line 908
;908:		CG_InterpolatePlayerState( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 CG_InterpolatePlayerState
CALLV
pop
line 909
;909:		return;
ADDRGP4 $683
JUMPV
LABELV $691
line 913
;910:	}
;911:
;912:	// non-predicting local movement will grab the latest angles
;913:	if ( cg_nopredict.integer || cgs.synchronousClients ) {
ADDRGP4 cg_nopredict+12
INDIRI4
CNSTI4 0
NEI4 $700
ADDRGP4 cgs+150080
INDIRI4
CNSTI4 0
EQI4 $696
LABELV $700
line 914
;914:		CG_InterpolatePlayerState( qtrue );
CNSTI4 1
ARGI4
ADDRGP4 CG_InterpolatePlayerState
CALLV
pop
line 915
;915:		return;
ADDRGP4 $683
JUMPV
LABELV $696
line 919
;916:	}
;917:
;918:	// prepare for pmove
;919:	cg_pmove.ps = &cg.predictedPlayerState;
ADDRGP4 cg_pmove
ADDRGP4 cg+107636
ASGNP4
line 920
;920:	cg_pmove.trace = CG_Trace;
ADDRGP4 cg_pmove+216
ADDRGP4 CG_Trace
ASGNP4
line 921
;921:	cg_pmove.pointcontents = CG_PointContents;
ADDRGP4 cg_pmove+220
ADDRGP4 CG_PointContents
ASGNP4
line 922
;922:	if ( cg_pmove.ps->pm_type == PM_DEAD ) {
ADDRGP4 cg_pmove
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $704
line 923
;923:		cg_pmove.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;
ADDRGP4 cg_pmove+28
CNSTI4 65537
ASGNI4
line 924
;924:	}
ADDRGP4 $705
JUMPV
LABELV $704
line 925
;925:	else {
line 926
;926:		cg_pmove.tracemask = MASK_PLAYERSOLID;
ADDRGP4 cg_pmove+28
CNSTI4 33619969
ASGNI4
line 927
;927:	}
LABELV $705
line 928
;928:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $708
line 929
;929:		cg_pmove.tracemask &= ~CONTENTS_BODY;	// spectators can fly through bodies
ADDRLP4 536
ADDRGP4 cg_pmove+28
ASGNP4
ADDRLP4 536
INDIRP4
ADDRLP4 536
INDIRP4
INDIRI4
CNSTI4 -33554433
BANDI4
ASGNI4
line 930
;930:	}
LABELV $708
line 933
;931:
;932:	// save the state before the pmove so we can detect transitions
;933:	oldPlayerState = cg.predictedPlayerState;
ADDRLP4 8
ADDRGP4 cg+107636
INDIRB
ASGNB 468
line 935
;934:
;935:	current = trap_GetCurrentCmdNumber();
ADDRLP4 536
ADDRGP4 trap_GetCurrentCmdNumber
CALLI4
ASGNI4
ADDRLP4 476
ADDRLP4 536
INDIRI4
ASGNI4
line 940
;936:
;937:	// if we don't have the commands right after the snapshot, we
;938:	// can't accurately predict a current position, so just freeze at
;939:	// the last good position we had
;940:	cmdNum = current - CMD_BACKUP + 1;
ADDRLP4 0
ADDRLP4 476
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 941
;941:	trap_GetUserCmd( cmdNum, &oldestCmd );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 512
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 942
;942:	if ( oldestCmd.serverTime > cg.snap->ps.commandTime
ADDRLP4 540
ADDRLP4 512
INDIRI4
ASGNI4
ADDRLP4 540
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
LEI4 $713
ADDRLP4 540
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $713
line 943
;943:		&& oldestCmd.serverTime < cg.time ) {	// special check for map_restart
line 944
;944:		if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $683
line 945
;945:			CG_Printf ("exceeded PACKET_BACKUP on commands\n");
ADDRGP4 $720
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 946
;946:		}
line 947
;947:		return;
ADDRGP4 $683
JUMPV
LABELV $713
line 951
;948:	}
;949:
;950:	// get the latest command so we can know which commands are from previous map_restarts
;951:	trap_GetUserCmd( current, &latestCmd );
ADDRLP4 476
INDIRI4
ARGI4
ADDRLP4 488
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 957
;952:
;953:	// get the most recent information we have, even if
;954:	// the server time is beyond our current cg.time,
;955:	// because predicted player positions are going to 
;956:	// be ahead of everything else anyway
;957:	if ( cg.nextSnap && !cg.nextFrameTeleport && !cg.thisFrameTeleport ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $721
ADDRGP4 cg+107596
INDIRI4
CNSTI4 0
NEI4 $721
ADDRGP4 cg+107592
INDIRI4
CNSTI4 0
NEI4 $721
line 958
;958:		cg.predictedPlayerState = cg.nextSnap->ps;
ADDRGP4 cg+107636
ADDRGP4 cg+40
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 468
line 959
;959:		cg.physicsTime = cg.nextSnap->serverTime;
ADDRGP4 cg+107612
ADDRGP4 cg+40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 960
;960:	} else {
ADDRGP4 $722
JUMPV
LABELV $721
line 961
;961:		cg.predictedPlayerState = cg.snap->ps;
ADDRGP4 cg+107636
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 468
line 962
;962:		cg.physicsTime = cg.snap->serverTime;
ADDRGP4 cg+107612
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 963
;963:	}
LABELV $722
line 965
;964:
;965:	cg_pmove.pmove_fixed = cgs.pmove_fixed;
ADDRGP4 cg_pmove+208
ADDRGP4 cgs+150072
INDIRI4
ASGNI4
line 966
;966:	cg_pmove.pmove_msec = cgs.pmove_msec;
ADDRGP4 cg_pmove+212
ADDRGP4 cgs+150076
INDIRI4
ASGNI4
line 969
;967:
;968:	// clean event stack
;969:	eventStack = 0;
ADDRGP4 eventStack
CNSTI4 0
ASGNI4
line 972
;970:	
;971:	// run cmds
;972:	moved = qfalse;
ADDRLP4 480
CNSTI4 0
ASGNI4
line 974
;973:
;974:	cg_pmove.pmove_fixed = cgs.pmove_fixed;
ADDRGP4 cg_pmove+208
ADDRGP4 cgs+150072
INDIRI4
ASGNI4
line 975
;975:	cg_pmove.pmove_msec = cgs.pmove_msec;
ADDRGP4 cg_pmove+212
ADDRGP4 cgs+150076
INDIRI4
ASGNI4
line 995
;976:
;977:	// Like the comments described above, a player's state is entirely
;978:	// re-predicted from the last valid snapshot every client frame, which
;979:	// can be really, really, really slow.  Every old command has to be
;980:	// run again.  For every client frame that is *not* directly after a
;981:	// snapshot, this is unnecessary, since we have no new information.
;982:	// For those, we'll play back the predictions from the last frame and
;983:	// predict only the newest commands.  Essentially, we'll be doing
;984:	// an incremental predict instead of a full predict.
;985:	//
;986:	// If we have a new snapshot, we can compare its player state's command
;987:	// time to the command times in the queue to find a match.  If we find
;988:	// a matching state, and the predicted version has not deviated, we can
;989:	// use the predicted state as a base - and also do an incremental predict.
;990:	//
;991:	// With this method, we get incremental predicts on every client frame
;992:	// except a frame following a new snapshot in which there was a prediction
;993:	// error.  This yeilds anywhere from a 15% to 40% performance increase,
;994:	// depending on how much of a bottleneck the CPU is.
;995:	if( 1 /* cg_optimizePrediction.integer */ ) {
line 996
;996:		if( cg.nextFrameTeleport || cg.thisFrameTeleport ) {
ADDRGP4 cg+107596
INDIRI4
CNSTI4 0
NEI4 $748
ADDRGP4 cg+107592
INDIRI4
CNSTI4 0
EQI4 $744
LABELV $748
line 998
;997:			// do a full predict
;998:			cg.lastPredictedCommand = 0;
ADDRGP4 cg+126112
CNSTI4 0
ASGNI4
line 999
;999:			cg.stateTail = cg.stateHead;
ADDRGP4 cg+157012
ADDRGP4 cg+157008
INDIRI4
ASGNI4
line 1000
;1000:			predictCmd = current - CMD_BACKUP + 1;
ADDRLP4 484
ADDRLP4 476
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1001
;1001:		}
ADDRGP4 $745
JUMPV
LABELV $744
line 1004
;1002:		// cg.physicsTime is the current snapshot's serverTime if it's the same
;1003:		// as the last one
;1004:		else if( cg.physicsTime == cg.lastServerTime ) {
ADDRGP4 cg+107612
INDIRI4
ADDRGP4 cg+126116
INDIRI4
NEI4 $752
line 1006
;1005:			// we have no new information, so do an incremental predict
;1006:			predictCmd = cg.lastPredictedCommand + 1;
ADDRLP4 484
ADDRGP4 cg+126112
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1007
;1007:		} else {
ADDRGP4 $753
JUMPV
LABELV $752
line 1011
;1008:			// we have a new snapshot
;1009:			int i;
;1010:			int errorcode;
;1011:			qboolean error = qtrue;
ADDRLP4 552
CNSTI4 1
ASGNI4
line 1014
;1012:
;1013:			// loop through the saved states queue
;1014:			for( i = cg.stateHead; i != cg.stateTail; i = ( i + 1 ) % NUM_SAVED_STATES ) {
ADDRLP4 544
ADDRGP4 cg+157008
INDIRI4
ASGNI4
ADDRGP4 $760
JUMPV
LABELV $757
line 1017
;1015:				// if we find a predicted state whose commandTime matches the snapshot
;1016:				// player state's commandTime
;1017:				if( cg.savedPmoveStates[ i ].commandTime != cg.predictedPlayerState.commandTime ) {
ADDRLP4 544
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126120
ADDP4
INDIRI4
ADDRGP4 cg+107636
INDIRI4
EQI4 $763
line 1018
;1018:					continue;
ADDRGP4 $758
JUMPV
LABELV $763
line 1021
;1019:				}
;1020:				// make sure the state differences are acceptable
;1021:				errorcode = CG_IsUnacceptableError( &cg.predictedPlayerState, &cg.savedPmoveStates[ i ], &moved );
ADDRGP4 cg+107636
ARGP4
ADDRLP4 544
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126120
ADDP4
ARGP4
ADDRLP4 480
ARGP4
ADDRLP4 556
ADDRGP4 CG_IsUnacceptableError
CALLI4
ASGNI4
ADDRLP4 548
ADDRLP4 556
INDIRI4
ASGNI4
line 1022
;1022:				if ( errorcode ) {
ADDRLP4 548
INDIRI4
CNSTI4 0
EQI4 $769
line 1023
;1023:					if( cg_showmiss.integer > 1 )
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 1
LEI4 $759
line 1024
;1024:						CG_Printf( "errorcode %d at %d\n", errorcode, cg.time );
ADDRGP4 $774
ARGP4
ADDRLP4 548
INDIRI4
ARGI4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 1025
;1025:					break;
ADDRGP4 $759
JUMPV
LABELV $769
line 1029
;1026:				}
;1027:  
;1028:				// this one is almost exact, so we'll copy it in as the starting point
;1029:				*cg_pmove.ps = cg.savedPmoveStates[ i ];
ADDRGP4 cg_pmove
INDIRP4
ADDRLP4 544
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126120
ADDP4
INDIRB
ASGNB 468
line 1031
;1030:				// advance the head
;1031:				cg.stateHead = ( i + 1 ) % NUM_SAVED_STATES;
ADDRGP4 cg+157008
ADDRLP4 544
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 66
MODI4
ASGNI4
line 1034
;1032:  
;1033:				// set the next command to predict
;1034:				predictCmd = cg.lastPredictedCommand + 1;
ADDRLP4 484
ADDRGP4 cg+126112
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1037
;1035:  
;1036:				// a saved state matched, so flag it
;1037:				error = qfalse;
ADDRLP4 552
CNSTI4 0
ASGNI4
line 1038
;1038:				break;
ADDRGP4 $759
JUMPV
LABELV $758
line 1014
ADDRLP4 544
ADDRLP4 544
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 66
MODI4
ASGNI4
LABELV $760
ADDRLP4 544
INDIRI4
ADDRGP4 cg+157012
INDIRI4
NEI4 $757
LABELV $759
line 1042
;1039:			}
;1040:
;1041:			// if no saved states matched
;1042:			if ( error ) {
ADDRLP4 552
INDIRI4
CNSTI4 0
EQI4 $779
line 1044
;1043:				// do a full predict
;1044:				cg.lastPredictedCommand = 0;
ADDRGP4 cg+126112
CNSTI4 0
ASGNI4
line 1045
;1045:				cg.stateTail = cg.stateHead;
ADDRGP4 cg+157012
ADDRGP4 cg+157008
INDIRI4
ASGNI4
line 1046
;1046:				predictCmd = current - CMD_BACKUP + 1;
ADDRLP4 484
ADDRLP4 476
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1047
;1047:			}
LABELV $779
line 1048
;1048:		}
LABELV $753
LABELV $745
line 1051
;1049:		// keep track of the server time of the last snapshot so we
;1050:		// know when we're starting from a new one in future calls
;1051:		cg.lastServerTime = cg.physicsTime;
ADDRGP4 cg+126116
ADDRGP4 cg+107612
INDIRI4
ASGNI4
line 1052
;1052:		stateIndex = cg.stateHead;
ADDRLP4 4
ADDRGP4 cg+157008
INDIRI4
ASGNI4
line 1053
;1053:	}
LABELV $742
line 1055
;1054:
;1055:	cmdNum = current - CMD_BACKUP + 1;
ADDRLP4 0
ADDRLP4 476
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1056
;1056:	if ( cmdNum < 0 ) // can happen on first spawn
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $792
line 1057
;1057:		cmdNum = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1062
;1058:
;1059:	// run cmds
;1060:	// moved = qfalse;
;1061:
;1062:	for ( /* cmdNum = current - CMD_BACKUP + 1 */; cmdNum <= current ; cmdNum++ ) {
ADDRGP4 $792
JUMPV
LABELV $789
line 1064
;1063:		// get the command
;1064:		trap_GetUserCmd( cmdNum, &cg_pmove.cmd );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 cg_pmove+4
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 1066
;1065:
;1066:		if ( cgs.pmove_fixed ) {
ADDRGP4 cgs+150072
INDIRI4
CNSTI4 0
EQI4 $794
line 1067
;1067:			PM_UpdateViewAngles( cg_pmove.ps, &cg_pmove.cmd );
ADDRGP4 cg_pmove
INDIRP4
ARGP4
ADDRGP4 cg_pmove+4
ARGP4
ADDRGP4 PM_UpdateViewAngles
CALLV
pop
line 1068
;1068:		}
LABELV $794
line 1071
;1069:
;1070:		// don't do anything if the time is before the snapshot player time
;1071:		if ( cg_pmove.cmd.serverTime <= cg.predictedPlayerState.commandTime ) {
ADDRGP4 cg_pmove+4
INDIRI4
ADDRGP4 cg+107636
INDIRI4
GTI4 $798
line 1072
;1072:			continue;
ADDRGP4 $790
JUMPV
LABELV $798
line 1076
;1073:		}
;1074:
;1075:		// don't do anything if the command was from a previous map_restart
;1076:		if ( cg_pmove.cmd.serverTime > latestCmd.serverTime ) {
ADDRGP4 cg_pmove+4
INDIRI4
ADDRLP4 488
INDIRI4
LEI4 $802
line 1077
;1077:			continue;
ADDRGP4 $790
JUMPV
LABELV $802
line 1085
;1078:		}
;1079:
;1080:		// check for a prediction error from last frame
;1081:		// on a lan, this will often be the exact value
;1082:		// from the snapshot, but on a wan we will have
;1083:		// to predict several commands to get to the point
;1084:		// we want to compare
;1085:		if ( cg.predictedPlayerState.commandTime == oldPlayerState.commandTime ) {
ADDRGP4 cg+107636
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $805
line 1089
;1086:			vec3_t	delta;
;1087:			float	len;
;1088:
;1089:			if ( cg.thisFrameTeleport ) {
ADDRGP4 cg+107592
INDIRI4
CNSTI4 0
EQI4 $808
line 1091
;1090:				// a teleport will not cause an error decay
;1091:				VectorClear( cg.predictedError );
ADDRGP4 cg+108852
CNSTF4 0
ASGNF4
ADDRGP4 cg+108852+4
CNSTF4 0
ASGNF4
ADDRGP4 cg+108852+8
CNSTF4 0
ASGNF4
line 1092
;1092:				if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $816
line 1093
;1093:					CG_Printf( "PredictionTeleport\n" );
ADDRGP4 $819
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1094
;1094:				}
LABELV $816
line 1095
;1095:				cg.thisFrameTeleport = qfalse;
ADDRGP4 cg+107592
CNSTI4 0
ASGNI4
line 1098
;1096:
;1097:				// delay prediction for some time or until first server event
;1098:				cg.allowPickupPrediction = cg.time + PICKUP_PREDICTION_DELAY;
ADDRGP4 cg+157024
ADDRGP4 cg+107604
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 1099
;1099:			} else {
ADDRGP4 $809
JUMPV
LABELV $808
line 1101
;1100:				vec3_t adjusted, new_angles;
;1101:				CG_AdjustPositionForMover( cg.predictedPlayerState.origin, 
ADDRGP4 cg+107636+20
ARGP4
ADDRGP4 cg+107636+68
INDIRI4
ARGI4
ADDRGP4 cg+107612
INDIRI4
ARGI4
ADDRGP4 cg+107608
INDIRI4
ARGI4
ADDRLP4 560
ARGP4
ADDRGP4 cg+107636+152
ARGP4
ADDRLP4 572
ARGP4
ADDRGP4 CG_AdjustPositionForMover
CALLV
pop
line 1104
;1102:					cg.predictedPlayerState.groundEntityNum, cg.physicsTime, cg.oldTime, adjusted, cg.predictedPlayerState.viewangles, new_angles);
;1103:
;1104:				if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $831
line 1105
;1105:					if ( !VectorCompare( oldPlayerState.origin, adjusted ) ) {
ADDRLP4 8+20
ARGP4
ADDRLP4 560
ARGP4
ADDRLP4 584
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 584
INDIRI4
CNSTI4 0
NEI4 $834
line 1106
;1106:						CG_Printf( "prediction error\n" );
ADDRGP4 $837
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1107
;1107:					}
LABELV $834
line 1108
;1108:				}
LABELV $831
line 1109
;1109:				VectorSubtract( oldPlayerState.origin, adjusted, delta );
ADDRLP4 544
ADDRLP4 8+20
INDIRF4
ADDRLP4 560
INDIRF4
SUBF4
ASGNF4
ADDRLP4 544+4
ADDRLP4 8+20+4
INDIRF4
ADDRLP4 560+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 544+8
ADDRLP4 8+20+8
INDIRF4
ADDRLP4 560+8
INDIRF4
SUBF4
ASGNF4
line 1110
;1110:				len = VectorLengthSquared( delta );
ADDRLP4 544
ARGP4
ADDRLP4 584
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 556
ADDRLP4 584
INDIRF4
ASGNF4
line 1111
;1111:				if ( len > (0.01f * 0.01f) ) {
ADDRLP4 556
INDIRF4
CNSTF4 953267991
LEF4 $847
line 1112
;1112:					if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $849
line 1113
;1113:						CG_Printf( "Prediction miss: %f\n", sqrt( len ) );
ADDRLP4 556
INDIRF4
ARGF4
ADDRLP4 588
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRGP4 $852
ARGP4
ADDRLP4 588
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 1114
;1114:					}
LABELV $849
line 1115
;1115:					if ( cg_errorDecay.integer ) {
ADDRGP4 cg_errorDecay+12
INDIRI4
CNSTI4 0
EQI4 $853
line 1119
;1116:						int		t;
;1117:						float	f;
;1118:
;1119:						t = cg.time - cg.predictedErrorTime;
ADDRLP4 592
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+108848
INDIRI4
SUBI4
ASGNI4
line 1120
;1120:						f = ( cg_errorDecay.value - t ) / cg_errorDecay.value;
ADDRLP4 588
ADDRGP4 cg_errorDecay+8
INDIRF4
ADDRLP4 592
INDIRI4
CVIF4 4
SUBF4
ADDRGP4 cg_errorDecay+8
INDIRF4
DIVF4
ASGNF4
line 1121
;1121:						if ( f < 0 ) {
ADDRLP4 588
INDIRF4
CNSTF4 0
GEF4 $860
line 1122
;1122:							f = 0;
ADDRLP4 588
CNSTF4 0
ASGNF4
line 1123
;1123:						} else
ADDRGP4 $861
JUMPV
LABELV $860
line 1124
;1124:						if ( f > 0 && cg_showmiss.integer ) {
ADDRLP4 588
INDIRF4
CNSTF4 0
LEF4 $862
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $862
line 1125
;1125:							CG_Printf("Double prediction decay: %f\n", f);
ADDRGP4 $865
ARGP4
ADDRLP4 588
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 1126
;1126:						}
LABELV $862
LABELV $861
line 1127
;1127:						VectorScale( cg.predictedError, f, cg.predictedError );
ADDRGP4 cg+108852
ADDRGP4 cg+108852
INDIRF4
ADDRLP4 588
INDIRF4
MULF4
ASGNF4
ADDRGP4 cg+108852+4
ADDRGP4 cg+108852+4
INDIRF4
ADDRLP4 588
INDIRF4
MULF4
ASGNF4
ADDRGP4 cg+108852+8
ADDRGP4 cg+108852+8
INDIRF4
ADDRLP4 588
INDIRF4
MULF4
ASGNF4
line 1128
;1128:					} else {
ADDRGP4 $854
JUMPV
LABELV $853
line 1129
;1129:						VectorClear( cg.predictedError );
ADDRGP4 cg+108852
CNSTF4 0
ASGNF4
ADDRGP4 cg+108852+4
CNSTF4 0
ASGNF4
ADDRGP4 cg+108852+8
CNSTF4 0
ASGNF4
line 1130
;1130:					}
LABELV $854
line 1131
;1131:					VectorAdd( delta, cg.predictedError, cg.predictedError );
ADDRGP4 cg+108852
ADDRLP4 544
INDIRF4
ADDRGP4 cg+108852
INDIRF4
ADDF4
ASGNF4
ADDRGP4 cg+108852+4
ADDRLP4 544+4
INDIRF4
ADDRGP4 cg+108852+4
INDIRF4
ADDF4
ASGNF4
ADDRGP4 cg+108852+8
ADDRLP4 544+8
INDIRF4
ADDRGP4 cg+108852+8
INDIRF4
ADDF4
ASGNF4
line 1132
;1132:					cg.predictedErrorTime = cg.oldTime;
ADDRGP4 cg+108848
ADDRGP4 cg+107608
INDIRI4
ASGNI4
line 1133
;1133:				}
LABELV $847
line 1134
;1134:			}
LABELV $809
line 1135
;1135:		}
LABELV $805
line 1139
;1136:
;1137:		// don't predict gauntlet firing, which is only supposed to happen
;1138:		// when it actually inflicts damage
;1139:		cg_pmove.gauntletHit = qfalse;
ADDRGP4 cg_pmove+36
CNSTI4 0
ASGNI4
line 1141
;1140:
;1141:		if ( cg_pmove.pmove_fixed ) {
ADDRGP4 cg_pmove+208
INDIRI4
CNSTI4 0
EQI4 $896
line 1142
;1142:			cg_pmove.cmd.serverTime = ((cg_pmove.cmd.serverTime + cg_pmove.pmove_msec-1) / cg_pmove.pmove_msec) * cg_pmove.pmove_msec;
ADDRGP4 cg_pmove+4
ADDRGP4 cg_pmove+4
INDIRI4
ADDRGP4 cg_pmove+212
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ADDRGP4 cg_pmove+212
INDIRI4
DIVI4
ADDRGP4 cg_pmove+212
INDIRI4
MULI4
ASGNI4
line 1143
;1143:		}
LABELV $896
line 1149
;1144:#if 0
;1145:		if ( !cg_optimizePrediction.integer ) {
;1146:			Pmove (&cg_pmove);
;1147:		} else 
;1148:#endif
;1149:		if ( /*cg_optimizePrediction.integer && */ ( cmdNum >= predictCmd || ( stateIndex + 1 ) % NUM_SAVED_STATES == cg.stateHead ) ) {
ADDRLP4 0
INDIRI4
ADDRLP4 484
INDIRI4
GEI4 $907
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 66
MODI4
ADDRGP4 cg+157008
INDIRI4
NEI4 $904
LABELV $907
line 1151
;1150:
;1151:			Pmove( &cg_pmove );
ADDRGP4 cg_pmove
ARGP4
ADDRGP4 Pmove
CALLV
pop
line 1154
;1152:
;1153:			// add push trigger movement effects
;1154:			CG_TouchTriggerPrediction();
ADDRGP4 CG_TouchTriggerPrediction
CALLV
pop
line 1157
;1155:
;1156:			// check for expired powerups etc.
;1157:			CG_CheckTimers();
ADDRGP4 CG_CheckTimers
CALLV
pop
line 1160
;1158:
;1159:			// record the last predicted command
;1160:			cg.lastPredictedCommand = cmdNum;
ADDRGP4 cg+126112
ADDRLP4 0
INDIRI4
ASGNI4
line 1163
;1161: 
;1162:			// if we haven't run out of space in the saved states queue
;1163:			if( ( stateIndex + 1 ) % NUM_SAVED_STATES != cg.stateHead ) {
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 66
MODI4
ADDRGP4 cg+157008
INDIRI4
EQI4 $905
line 1166
;1164:				// save the state for the false case ( of cmdNum >= predictCmd )
;1165:				// in later calls to this function
;1166:				cg.savedPmoveStates[ stateIndex ] = *cg_pmove.ps;
ADDRLP4 4
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126120
ADDP4
ADDRGP4 cg_pmove
INDIRP4
INDIRB
ASGNB 468
line 1167
;1167:				stateIndex = ( stateIndex + 1 ) % NUM_SAVED_STATES;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 66
MODI4
ASGNI4
line 1168
;1168:				cg.stateTail = stateIndex;
ADDRGP4 cg+157012
ADDRLP4 4
INDIRI4
ASGNI4
line 1169
;1169:			}
line 1170
;1170:		} else {
ADDRGP4 $905
JUMPV
LABELV $904
line 1171
;1171:			*cg_pmove.ps = cg.savedPmoveStates[ stateIndex ];
ADDRGP4 cg_pmove
INDIRP4
ADDRLP4 4
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126120
ADDP4
INDIRB
ASGNB 468
line 1172
;1172:			stateIndex = ( stateIndex + 1 ) % NUM_SAVED_STATES;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 66
MODI4
ASGNI4
line 1173
;1173:		}
LABELV $905
line 1175
;1174:
;1175:		moved = qtrue;
ADDRLP4 480
CNSTI4 1
ASGNI4
line 1176
;1176:	}
LABELV $790
line 1062
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $792
ADDRLP4 0
INDIRI4
ADDRLP4 476
INDIRI4
LEI4 $789
line 1178
;1177:
;1178:	if ( cg_showmiss.integer > 3 ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 3
LEI4 $915
line 1179
;1179:		CG_Printf( "[%i : %i] ", cg_pmove.cmd.serverTime, cg.time );
ADDRGP4 $918
ARGP4
ADDRGP4 cg_pmove+4
INDIRI4
ARGI4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 1180
;1180:	}
LABELV $915
line 1182
;1181:
;1182:	if ( !moved ) {
ADDRLP4 480
INDIRI4
CNSTI4 0
NEI4 $921
line 1183
;1183:		if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $923
line 1184
;1184:			CG_Printf( "not moved\n" );
ADDRGP4 $926
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1185
;1185:		}
LABELV $923
line 1187
;1186:		// clean event stack
;1187:		eventStack = 0;
ADDRGP4 eventStack
CNSTI4 0
ASGNI4
line 1188
;1188:		return;
ADDRGP4 $683
JUMPV
LABELV $921
line 1192
;1189:	}
;1190:
;1191:	// adjust for the movement of the groundentity
;1192:	CG_AdjustPositionForMover( cg.predictedPlayerState.origin, cg.predictedPlayerState.groundEntityNum, 
ADDRGP4 cg+107636+20
ARGP4
ADDRGP4 cg+107636+68
INDIRI4
ARGI4
ADDRGP4 cg+107612
INDIRI4
ARGI4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRGP4 cg+107636+20
ARGP4
ADDRGP4 cg+107636+152
ARGP4
ADDRGP4 cg+107636+152
ARGP4
ADDRGP4 CG_AdjustPositionForMover
CALLV
pop
line 1196
;1193:		cg.physicsTime, cg.time, cg.predictedPlayerState.origin, 
;1194:		cg.predictedPlayerState.viewangles, cg.predictedPlayerState.viewangles );
;1195:
;1196:	if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $939
line 1197
;1197:		if ( cg.predictedPlayerState.eventSequence > oldPlayerState.eventSequence + MAX_PS_EVENTS ) {
ADDRGP4 cg+107636+108
INDIRI4
ADDRLP4 8+108
INDIRI4
CNSTI4 2
ADDI4
LEI4 $942
line 1198
;1198:			CG_Printf( "WARNING: dropped event\n" );
ADDRGP4 $947
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1199
;1199:		}
LABELV $942
line 1200
;1200:	}
LABELV $939
line 1203
;1201:
;1202:	// fire events and other transition triggered things
;1203:	CG_TransitionPlayerState( &cg.predictedPlayerState, &oldPlayerState );
ADDRGP4 cg+107636
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_TransitionPlayerState
CALLV
pop
line 1205
;1204:
;1205:	if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $949
line 1206
;1206:		if ( cg.eventSequence > cg.predictedPlayerState.eventSequence ) {
ADDRGP4 cg+108864
INDIRI4
ADDRGP4 cg+107636+108
INDIRI4
LEI4 $952
line 1207
;1207:			CG_Printf( "WARNING: double event\n" );
ADDRGP4 $957
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1208
;1208:			cg.eventSequence = cg.predictedPlayerState.eventSequence;
ADDRGP4 cg+108864
ADDRGP4 cg+107636+108
INDIRI4
ASGNI4
line 1209
;1209:		}
LABELV $952
line 1210
;1210:	}
LABELV $949
line 1211
;1211:}
LABELV $683
endproc CG_PredictPlayerState 596 28
bss
export eventParm2
align 4
LABELV eventParm2
skip 64
export eventParms
align 4
LABELV eventParms
skip 64
export events
align 4
LABELV events
skip 64
export eventStack
align 4
LABELV eventStack
skip 4
align 4
LABELV cg_triggerEntities
skip 1024
align 4
LABELV cg_numTriggerEntities
skip 4
align 4
LABELV cg_solidEntities
skip 1024
align 4
LABELV cg_numSolidEntities
skip 4
align 4
LABELV cg_pmove
skip 224
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
import CG_LoadDeferredPlayers
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
LABELV $957
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 100
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $947
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $926
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $918
byte 1 91
byte 1 37
byte 1 105
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 93
byte 1 32
byte 1 0
align 1
LABELV $865
byte 1 68
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 100
byte 1 101
byte 1 99
byte 1 97
byte 1 121
byte 1 58
byte 1 32
byte 1 37
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $852
byte 1 80
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $837
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $819
byte 1 80
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 84
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $774
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 99
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $720
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 101
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 80
byte 1 65
byte 1 67
byte 1 75
byte 1 69
byte 1 84
byte 1 95
byte 1 66
byte 1 65
byte 1 67
byte 1 75
byte 1 85
byte 1 80
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $682
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 91
byte 1 37
byte 1 105
byte 1 93
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 61
byte 1 62
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 0
align 1
LABELV $669
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 91
byte 1 37
byte 1 105
byte 1 93
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 61
byte 1 62
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 0
align 1
LABELV $653
byte 1 112
byte 1 101
byte 1 114
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 116
byte 1 91
byte 1 37
byte 1 105
byte 1 93
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 61
byte 1 62
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 0
align 1
LABELV $641
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 115
byte 1 91
byte 1 37
byte 1 105
byte 1 93
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 61
byte 1 62
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 0
align 1
LABELV $604
byte 1 100
byte 1 109
byte 1 103
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
byte 1 62
byte 1 61
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
byte 1 10
byte 1 0
align 1
LABELV $581
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 80
byte 1 97
byte 1 114
byte 1 109
byte 1 115
byte 1 91
byte 1 37
byte 1 105
byte 1 93
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 61
byte 1 62
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $575
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 91
byte 1 37
byte 1 105
byte 1 93
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 61
byte 1 62
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $563
byte 1 101
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 61
byte 1 62
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $527
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
byte 1 61
byte 1 62
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
byte 1 0
align 1
LABELV $515
byte 1 118
byte 1 101
byte 1 108
byte 1 111
byte 1 99
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 100
byte 1 101
byte 1 108
byte 1 116
byte 1 97
byte 1 58
byte 1 32
byte 1 37
byte 1 46
byte 1 50
byte 1 102
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $507
byte 1 111
byte 1 114
byte 1 105
byte 1 103
byte 1 105
byte 1 110
byte 1 32
byte 1 100
byte 1 101
byte 1 108
byte 1 116
byte 1 97
byte 1 58
byte 1 32
byte 1 37
byte 1 46
byte 1 50
byte 1 102
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $263
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 95
byte 1 109
byte 1 101
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $262
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 95
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $173
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 0
