//legacy

params ["_player"];
if(_player getVariable ["AUR_Is_Rappelling",false]) exitWith {false};
_rappelPoint = [_player] call TIRP_fnc_AUR_Get_Anchor_Point_Player_Looking_At;
if(count _rappelPoint == 0) exitWith {false;};
_angle = [_player, _rappelPoint select 0, 20] call TIRP_fnc_AUR_Get_Trajectory_Angle;
if(_angle < 0) exitWith {false};
true;