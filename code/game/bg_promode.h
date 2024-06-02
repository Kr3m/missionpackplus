#include "bg_pmove.h"

// Physics variables
extern qboolean phy_initialized;
//  General
extern float phy_stopspeed;
// Acceleration
extern float phy_fly_accel;
// Friction
extern float phy_friction;
extern float phy_fly_friction;
extern float phy_spectator_friction;

// New variables
extern float phy_crouch_scale;  // Default renamed
// extern int   df_promode;             // pm->movetype; // Physics type selection
// Ground
extern float phy_ground_basespeed;  // Movement speed on the ground (aka maxspeed). Equivalent to the default g_speed
extern float phy_ground_accel;      // Acceleration when on the ground. sv_accelerate
// Air
extern float phy_air_basespeed;  // Maxspeed on air when in VQ3, or when strafing diagonally in CPM
extern float phy_air_accel;      // Acceleration when in VQ3, or when strafing diagonally in CPM
// Air deceleration. To have different accel values for stopping down than for accelerating normally.
extern float phy_air_decel;       // Factor to scale down air acceleration, when the current angle is over decelAngle
extern float phy_air_decelAngle;  // Angle at which air deceleration will change
// AirStrafe (aka AD turning)
extern float phy_airstrafe_accel;      // Acceleration when strafing "quakeworld style" in CPM
extern float phy_airstrafe_basespeed;  // Maxspeed on air when in VQ3, or when strafing diagonally in CPM
// AirControl (aka W turning)
extern qboolean phy_aircontrol;         // Turns aircontrol on or off
extern float    phy_aircontrol_amount;  // Amount you can control yourself with W/S
extern float    phy_aircontrol_power;   // Aircontrol formula exponent
extern float phy_airstopaccelerate;
extern float phy_wishspeed;
// Stepup
#define STEPSIZE 18
extern int phy_step_size;    // Distance that will be moved up/down for step behavior. (default = STEPSIZE = 18)
extern int phy_step_maxvel;  // When set, it limits the maximum vertical speed at which you can multi/double jump. Prevents stairs-climb crazyness
// Jump
extern int phy_jump_type;         // Jump type selection. Available VQ3, CPM
extern int phy_jump_velocity;     // Vertical velocity that will be set/added when jumping (default = JUMP_VELOCITY = 270)
extern int phy_jump_timebuffer;   // Amount of time(ms) since last jump, where CPM dj behavior can happen. (default CPM = 400)
extern int phy_jump_dj_velocity;  // Amount of velocity to add to CPM dj behavior. (default CPM = 100)
// Powerups
// extern float phy_haste_factor;           // Multiplier to apply during haste powerup (q3 default = 1.3)
// extern float phy_quad_factor;            // Multiplier to apply during quad powerup  (q3 default = 3)
// Water
extern float phy_water_accel;
extern float phy_water_scale;  // phy_swimScale;
extern float phy_water_friction;
// Slick
extern float phy_water_friction;
extern float phy_slick_accel;

// Physics indexes
#define VQ3 0  // VQ3
#define CPM 1  // CPM
#define CQ3 2  // CQ3

// Initialize
void phy_init(int movetype);  // Calls all other initializer functions
void cpm_init(void);
void vq3_init(void);
void cq3_init(void);

// Movement
void phy_PmoveSingle(pmove_t* pmove);  // Core movement entrypoint
void phy_move(pmove_t* pmove);         // Calls all other movement functions
void cpm_move(pmove_t* pmove);
void vq3_move(pmove_t* pmove);
void cq3_move(pmove_t* pmove);

// Core functions (common to all/most)
void     core_Accelerate(vec3_t wishdir, float wishspeed, float accel, float basespeed);
void     core_Friction(void);
void     core_Weapon(void);
void     core_GroundTrace(void);
float    core_CmdScale(usercmd_t* cmd, qboolean fix);
qboolean core_SlideMove(qboolean gravity);
void     core_StepSlideMove(qboolean gravity);

// Math
void VectorReflect(vec3_t in, vec3_t normal, vec3_t out, float overbounce);
void VectorReflect2D(vec3_t in, vec3_t normal, vec3_t out, float overbounce);
void VectorReflectOS(vec3_t in, vec3_t normal, vec3_t out, float overbounce);
void VectorReflectBC(vec3_t in, vec3_t normal, vec3_t out, float overbounce);
