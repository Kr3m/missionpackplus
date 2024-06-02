#ifndef BG_PMOVE_H
#define BG_PMOVE_H

#include "q_shared.h"
#include "bg_public.h"
#include "bg_local.h"

extern pmove_t* pm;
extern pml_t    pml;

// default movement parameters
extern float pm_stopspeed;
extern float pm_duckScale;
extern float pm_swimScale;

extern float pm_accelerate;
extern float pm_airaccelerate;
extern float pm_wateraccelerate;
extern float pm_flyaccelerate;

extern float pm_friction;
extern float pm_waterfriction;
extern float pm_flightfriction;
extern float pm_spectatorfriction;

extern int   c_pmove;

void         trap_SnapVector(float* v);

void         PM_AddEvent(int newEvent);
void         PM_AddTouchEnt(int entityNum);
// TODO: Move back to Static
void     PM_StartTorsoAnim(int anim);
void     PM_StartLegsAnim(int anim);
void     PM_ContinueLegsAnim(int anim);
void     PM_ContinueTorsoAnim(int anim);
void     PM_ForceLegsAnim(int anim);
void     PM_ClipVelocity(vec3_t in, vec3_t normal, vec3_t out, float overbounce);
void     PM_Friction(void);
void     PM_Accelerate(vec3_t wishdir, float wishspeed, float accel);
float    PM_CmdScale(usercmd_t* cmd);
void     PM_SetMovementDir(void);
qboolean PM_CheckJump(void);
qboolean PM_CheckWaterJump(void);
void     PM_WaterJumpMove(void);
void     PM_WaterMove(void);

#ifdef TEAMARENA
void PM_InvulnerabilityMove(void);
#endif
void PM_AirMove(void);
void PM_GrappleMove(void);
void PM_WalkMove(void);
int  PM_FootstepForSurface(void);
void PM_CrashLand(void);
/*
void PM_CheckStuck(void);
*/
int  PM_CorrectAllSolid(trace_t* trace);
void PM_GroundTraceMissed(void);
void PM_Footsteps(void);
void PM_WaterEvents(void);

void PM_TorsoAnimation(void);
void PM_Weapon(void);
void PM_Animate(void);

void PM_UpdateViewAngles(playerState_t* ps, const usercmd_t* cmd);
void PM_CheckDuck(void);
void PM_FlyMove(void);
void PM_DropTimers(void);
void PM_NoclipMove(void);
void PM_SetWaterLevel(void);
void PM_GroundTrace(void);
void PM_DeadMove(void);

#endif  // BG_PMOVE_H
