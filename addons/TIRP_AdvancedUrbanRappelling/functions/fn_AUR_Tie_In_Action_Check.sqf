#include "TIRP_AUR_MACROS.h"

if (AUR_GET_RAPPELLING_STATUS(player)) exitWith {False;};
_ropes = (GetPosATL player) nearObjects ["Land_Can_V2_F", 2];
// systemChat str count _ropes;
_ret = False;
scopeName "TIRP_TieInCheck";

{
_ret2 = AUR_GET_TIE_IN_POINT_STATUS(_x);
	if (_ret2 > 0) then {_ret= True; breakTo "TIRP_TieInCheck";}
	} forEach _ropes;
if (_ret  and {"AUR_BelayDevice" in items player }) then {
_ret = true;
}else {_ret = false;};
_ret;
