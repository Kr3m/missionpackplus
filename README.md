# missionpackplus

missionpackplus is a Quake III Team Arena mod based on [foundation](https://github.com/RemyTek/foundation) a mod to build mods on.

Special thanks to Ensiform for his amazing help as usual. =D

Special thanks to wiz @q3retro for his help.

Added support for 231 maps found here:  [MAPS.md](MAPS.md)

## New cvars

* g_startingWeapon <0|13> : defaults to 0.  Choose which weapon you spawn with.
* g_noSelfDamage <0|1> : default to 0. Toggle the player self damages
* g_startAmmo*X* <0|200> : allow to define the amount of ammunitions for a weapon. *X* can be MG, SG, GL, RL, LG, RG, PG, BFG, NG, PL, CG
* g_damage*X* <0|999> : allow to define the amount of damage for a weapon. *X* can be MG, SG, GL, RL, LG, RG, PG, BFG, NG, PL, CG
* g_sgPellets <1|?> : number of shotgun pellets per shot
* g_sgPelletSpread <1|?> : amount of shotgun spread defaults to 700
* g_splashDamage*X* <1|?> : allow to define the amount of splash damage for a weapon. *X* can be GL, RL, PG, BFG
* g_splashRadius*X* <1|?> : allow to define the amount of splash damage for a weapon. *X* can be GL, RL, PG, BFG
* g_velocityRL <1|?> : how fast the rockets move
* g_startArmor <0|200> : allow to define the amount of armor at spawn
* g_startHealth <0|200> : allow to define the amount of health at spawn
* g_ammoRespawn <seconds> : ammo respawn times for FFA and Duel
* g_ammoTeamRespawn <seconds> : ammo respawn times for team gametypes
* g_armorRespawn <seconds> : armor respawn times for FFA and Duel
* g_armorTeamRespawn <seconds> : armor respawn times for team gametypes
* g_healthRespawn <seconds> : health respawn times for FFA and Duel
* g_healthTeamRespawn <seconds> : health respawn times for team gametypes
* g_megahealthRespawn <seconds> : megahealth respawn times for FFA and Duel
* g_megahealthTeamRespawn <seconds> : megahealth respawn times for team gametypes
* g_powerupRespawn <seconds> : powerup respawn times for FFA and Duel
* g_powerupTeamRespawn <seconds> : powerup respawn times for team gametypes
* g_holdableRespawn <seconds> : holdable respawn times for FFA and Duel
* g_holdableTeamRespawn <seconds> : holdable respawn times for team gametypes
* g_grapple <0|1> : enable grapple hook
* g_grappleDelayTime <0|?> : delay time in milliseconds
* g_grappleHoldTime <0|?> : how long the grapple will hold on in seconds 0 for infinite camping
* g_grappleSpeed <0|?> : deploy speed in UPS
* g_grapplePull <0|?> : pull speed in UPS
* g_grappleDamage <0|?> : grapple hook damage 0 to disable

### Flagged cvars

The following cvars use a "flag" value which acts as a combination of integers to specify a group of items:

* wpflags "VAL" : what weapons a player should have at spawn.
  
The corresponding values are:

* Machinegun	1
* Shotgun	2
* Grenade Launcher	4
* Rocket Launcher	8
* Lightning Gun	16
* Railgun	32
* Plasma Gun	64
* BFG10K	128
* Nailgun 256
* Prox Launcher 512
* Chaingun 1024

So, in order to let a player starts with a shotgun, a grenade launcher and a rocket launcher you can use "wpflags 14" (for 14 is 2+4+8). Note that players always start with the machinegun and the gauntlet.

The **removeX** cvars allow to choose to remove items from a map, **X** is either **ammo**, **item**, **powerup** or **weapon**:

* removeammo "VAL" use the same numbers as wpflags but for the corresponding ammunition
* removeeapon "VAL" use the same numbers as wpflags
* removeitem "VAL", where VAL can used the following values:
  * item_armor_shard 1
  * item_armor_combat 2
  * item_armor_body 4
  * item_health_small 8
  * item_health 16
  * item_health_large 32
  * item_health_mega 64
  * holdable_teleporter 128
  * holdable_medkit 256
 * removepowerup "VAL", where VAL can used the following values:
  * item_quad 1
  * item_enviro 2
  * item_haste 4
  * item_invis 8
  * item_regen 16
  * item_flight 32

# Instructions

Download the release file to your Quake3/missionpack folder.  Enjoy!

Server up at /connect chi.kr3m.one:27946

# Screenshots

![alt taplus screenshot1](https://taplus.kr3m.one/images/screenshot0001.jpg)

![alt taplus screenshot2](https://taplus.kr3m.one/images/screenshot0002.jpg)

# Current state:

## Fixed crosshairHealth:

https://user-images.githubusercontent.com/290740/231115437-49be24c4-6999-4ba0-89e3-48eeddcb71e3.mp4

## Got FB skins working with team-based gametypes:

https://user-images.githubusercontent.com/290740/230755343-e4a1347e-c6bc-4b59-83f9-8d8c2620ce44.mp4

## Added instagib support:

https://user-images.githubusercontent.com/290740/230708646-ef9bd016-2284-4ca0-9efb-65e1457297a7.mp4

## Disabled screen shake when taking damage:

https://user-images.githubusercontent.com/290740/230672040-74bcfa4d-9400-4be6-a102-5333569f0030.mp4


# What is done:

 * new toolchain used (optimized q3lcc and q3asm)
 * upstream security fixes
 * floatfix
 * fixed vote system
 * fixed spawn system
 * fixed in-game crosshair proportions
 * fixed UI mouse sensitivity for high-resolution
 * fixed server browser + faster scanning
 * new demo UI (subfolders,filtering,sorting)
 * updated serverinfo UI
 * map rotation system
 * unlagged weapons
 * improved prediction
 * damage-based hitsounds
 * colored skins
 * high-quality proportional font renderer
 * Kr3m's custom ctf_unified.shader for popping decals at any picmip setting.
 * CPMA-style fullbright skins
 * linux qvm build support
 * cg_crosshairColor support for Quake 3 colors (seta cg_crosshairColor "2" //for green)
 * cg_kickScale support with a default value of 0 to disable screen shake when taking damage.
 * added fullbright skin support for team games.
 * fixed crosshairColor overriding crosshairHealth settings.
 * fixed spawn times for items
 * added railJump and noSelfDamage functionality.
 * added g_startHealth and g_startArmor
 * added custom entity support for maps

# TODO:

 * ~~Kr3m's custom ctf_unified.shader for popping decals at any picmip setting.~~
 * ~~CPMA-style fullbright skins~~
 * ~~linux qvm build support~~
 * ~~cg_crosshairColor support (seta cg_crosshairColor "0x00ff00ff" //for green)~~
 * ~~cg_kickScale support with a default value of 0 to disable screen shake when taking damage.~~
 * ~~add fullbright skin support for team games.~~
 * ~~fix crosshairColor overriding crosshairHealth settings.~~
 * ~~fix spawn times for items~~
 * bugfixes
 * add projectile delag code
 * ~~rework crosshair colors to support color string names and q3 color codes (e.g. "Green" or "2").~~
 * add ruleset and crontab support similar to excessiveplus, edawn, etc.
 * add more gametypes
 * fix spawn times for items in single player and when g_warmup 0
 * add random map rotation functionality
 * add g_doReady and /ready as a toggle
 * better HUD
 * improve AI
 * some features from Quake Live.


# Documentation

See /docs/

# Compilation and installation

Look in /build/
