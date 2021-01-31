//LEGACY

params ["_player"];
_rappelPoint = [_player] call TIRP_fnc_AUR_Get_Anchor_Point_Player_Looking_At;
if(count _rappelPoint > 0) then {
	_player setVariable ["AUR_Rappelling_Last_Started_Time",diag_tickTime];
	_player setVariable ["AUR_Rappelling_Last_Rappel_Point",_rappelPoint];
	_ropeLength = ((ASLtoAGL (_rappelPoint select 0)) select 2) * 1.3;
	_angle = [_player, _rappelPoint select 0, 20] call TIRP_fnc_AUR_Get_Trajectory_Angle;
	
	_grap = createVehicle ["Land_Can_V2_F", _player, [], 0, "CAN_COLLIDE"];
	_velocity = (getPosASL _player) vectorFromTo (_rappelPoint select 0);
	_velocity set [2,0];
	_velocity = vectorNormalized _velocity;
	_velocity set [2,tan _angle];
	_velocity = _velocity vectorMultiply 20;
	_grap setVelocity _velocity;
	_grap allowDamage false;
	//hideObject _grap;
	_playerHoldingAnchor = createVehicle ["B_static_AA_F", _player, [], 0, "CAN_COLLIDE"];
	hideObject _playerHoldingAnchor;
	_playerHoldingAnchor allowDamage false;
	_rope = ropeCreate [_playerHoldingAnchor, [0,0.15,0], _grap, [0, 0, 0], 30];
	
	sleep 1;
	
	_grap enableSimulation false;
	_grap setPosASL (_rappelPoint select 0);
	
	sleep 1;
	
	ropeDestroy _rope;
	deleteVehicle _playerHoldingAnchor;
	deleteVehicle _grap;		
	
	[_player, _rappelPoint select 3, _rappelPoint select 0, _rappelPoint select 1,_ropeLength, true] spawn TIRP_fnc_AUR_Rappel;
} else {
	[["Couldn't attach rope. Move closer to edge!", false],"TIRP_fnc_AUR_Hint",_player] call TIRP_fnc_AUR_RemoteExec;
};