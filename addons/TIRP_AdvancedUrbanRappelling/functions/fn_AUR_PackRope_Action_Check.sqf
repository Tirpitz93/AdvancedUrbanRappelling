/*
*   Author: Tirpitz
*   Checks whether player is holding rope and near to the anchor point (master object)
*   
*/
#include "TIRP_AUR_MACROS.h"

if !(AUR_GET_STATUS_HOLDING_ROPE(player)) exitWith {False;};
_master = AUR_GET_MASTER(player);
if ((_master distance player) < 2) exitWith {True;};

False;