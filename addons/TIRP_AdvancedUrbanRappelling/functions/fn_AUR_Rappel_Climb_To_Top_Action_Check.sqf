#include "TIRP_AUR_MACROS.h"
params ["_player"];
private ["_topRope"];
if!(AUR_GET_RAPPELLING_STATUS(_player)) exitWith {false;};
_topRope = AUR_GET_ROPE_TOP(_player);
if(isNil "_topRope") exitWith {false;};
if(ropeLength _topRope > 1) exitWith {false;};
true;