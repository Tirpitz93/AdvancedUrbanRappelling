/*
*   Author: Tirpitz
*
* Parameters: 
*               player (object), 
*               player position, (position, array), 
*               rappelpoint (anchor to use as rappelling point) (object), 
*               rappel Direction (direction player is facing todo: detect correct direction using edge detection???) (vector, array), 
*               rope or rope Length, (available for rappel, not including the top rope length) (object or number),
*               starting on ground (bool)
* Variable description:
*                       _anchor: object that live rappelling rope is attached to. (can)          
*                       _anchor2: object free end (bottom) of rappelling rope is attached to.   (static_aa)                  
*                       _dummyAnchor: object rope from rappelling anchor to the useable anchor is attached (static_aa)   
*TODO: track all ropes ensure ropes are destroyed correctly.
*TODO: Check endpoint and anchor offsets and locations.
*
*/
#include "TIRP_AUR_MACROS.h"
params ["_player",["_playerStartingOnGround",false]];
//params ["_player","_playerPreRappelPosition","_rappelPoint","_rappelDirection","_rope",["_playerStartingOnGround",false]];
_playerPreRappelPosition = getPosASL _player;
_rappelDirection = eyeDirection _player;
// _anchor = AUR_GET_ENDPOINT_LEADER(_player);
// systemChat format ["Function: Rappel, Params: %1", _this];
//hint format ["Player: %1 \nPre_rappel_position: %2, \nRappelPoint: %3 \n RappelDirection: %4,\n RopeLength: %5.", str _player,str  _playerPreRappelPosition,str _rappelPoint, str _rappelDirection,str  _rope];
 AUR_SET_RAPPELLING_STATUS(_player, true) ;
_playerStartPosition = getPosASL _player;
_dummyAnchor = "";
_rappelPoint = (getPosWorld AUR_GET_ENDPOINT_LEADER(_player));
AUR_GET_ENDPOINT_LEADER(_player) hideObject true;
_ropeLength  = AUR_GET_LENGTH_AVAILABLE(_player);

// Create anchor for rope (at rappel point)
_anchor = createVehicle ["Land_Can_V2_F", _rappelPoint, [], 0, "CAN_COLLIDE"];
// hideObject _anchor;
_anchor enableSimulation false;
_anchor allowDamage false;
[[_anchor],"TIRP_fnc_AUR_Hide_Object_Global"] call TIRP_fnc_AUR_RemoteExecServer;
_anchor setVariable ["TIRP_AUR_isAnchor", True, true];
// _anchor setPosASL (getPosASL AUR_GET_ENDPOINT_LEADER(_player));
_anchor setPosWorld (getPosWorld AUR_GET_ENDPOINT_LEADER(_player));
_anchor attachTo [AUR_GET_ENDPOINT_LEADER(_player), [0,0,0]];
AUR_SET_MASTER(_anchor, AUR_GET_MASTER(_player));
AUR_SET_ENDPOINT_TOP(_player, _anchor);
// Create anchor for rope (at rappel point)
// _anchor2 = createVehicle ["Land_Can_V2_F", _player, [], 0, "CAN_COLLIDE"];
// // hideObject _anchor;
// _anchor2 enableSimulation false;
// _anchor2 allowDamage false;
// [[_anchor2],"TIRP_fnc_AUR_Hide_Object_Global"] call TIRP_fnc_AUR_RemoteExecServer;
// hint typeName _rappelPoint;


if(!_playerStartingOnGround) then {
	// Start player rappelling 2m out from the rappel point
	_playerStartPosition = (_playerStartPosition vectorAdd (_rappelDirection vectorMultiply 2)) vectorAdd [0,0,2] ;
	_player setPosWorld _playerStartPosition;
};


// Create rappel device (attached to player)
_rappelDevice = createVehicle ["B_static_AA_F", _player, [], 0, "CAN_COLLIDE"];
// hideObject _rappelDevice;
_rappelDevice setPosWorld _playerStartPosition;
_rappelDevice allowDamage false;
[[_rappelDevice],"TIRP_fnc_AUR_Hide_Object_Global"] call TIRP_fnc_AUR_RemoteExecServer;
AUR_SET_MASTER(_rappelDevice, AUR_GET_MASTER(_player));
AUR_SET_RAPPEL_DEVICE(_player, _rappelDevice);
[[_player,_rappelDevice, AUR_GET_ENDPOINT_LEADER(_player)],"TIRP_fnc_AUR_Play_Rappelling_Sounds_Global"] call TIRP_fnc_AUR_RemoteExecServer;

_bottomRopeStartLength = _ropeLength- 2;

_topRopeStartLength = 2;

if(_playerStartingOnGround) then {
	_topRopeStartLength = abs ((_rappelPoint select 2) - (getPosASL _player select 2) - 1);
	_bottomRopeStartLength = (_ropeLength- _topRopeStartLength);
};


_ropeBottom = ropeCreate [_rappelDevice, [-0.15,0,0], _bottomRopeStartLength];
_ropeBottom allowDamage false;
AUR_SET_ROPE_BOTTOM(_player, _ropeBottom);

_ropeTop = ropeCreate [_rappelDevice, [0,0.15,0],_anchor, [0, 0, 0], _topRopeStartLength];
AUR_SET_ROPE_TOP(_player, _ropeTop);
_ropeTop allowDamage false;
// systemChat str ( ropeAttachedObjects  _anchor); 
 AUR_GET_ENDPOINT_LEADER(_player) setPosWorld _rappelPoint;



_ropeTop setVariable ["TIRP_AUR_isRappelRope",True, True];





_animationsHandle = [_player] spawn TIRP_fnc_AUR_Enable_Rappelling_Animation;

// Make player face the wall they're rappelling on
_player setVectorDir (_rappelDirection vectorMultiply -1);

_gravityAccelerationVec = [0,0,-9.8];
_velocityVec = [0,0,0];
_lastTime = diag_tickTime;
_lastPosition = AGLtoASL (_rappelDevice modelToWorldVisual [0,0,0]);

_decendRopeKeyDownHandler = -1;
_ropeKeyUpHandler = -1;
if(_player == player) then {	
	_decendRopeKeyDownHandler = (findDisplay 46) displayAddEventHandler ["KeyDown", {
		private ["_topRope","_bottomRope"];
		if(_this select 1 in (actionKeys "MoveBack")) then {
			_ropeLength = AUR_GET_LENGTH_AVAILABLE(player);
			_topRope = AUR_GET_ROPE_TOP(player);
            _bottomRope = AUR_GET_ROPE_BOTTOM(player);
            // systemChat ("unwinding");
			if(!isNil "_topRope") then {
            // systemChat ("winding down " + (str _topRope));
				ropeUnwind [ _topRope, 1.5, ((ropeLength _topRope) + 0.1) min _ropeLength]; //1.5
			};
			
			if(!isNil "_bottomRope") then {
            // systemChat ("winding down " + (str _bottomRope));
				ropeUnwind [ _bottomRope, 1.5, ((ropeLength _bottomRope) - 0.1) max 0]; //1.5
			};
		};
		if(_this select 1 in (actionKeys "MoveForward")) then {
			_ropeLength= AUR_GET_LENGTH_AVAILABLE(player);
            // hint str _ropeLength;
			_topRope =  AUR_GET_ROPE_TOP(player);
            _bottomRope = AUR_GET_ROPE_BOTTOM(player);
            _speed = 0.3;
            if (AUR_HAS_ASCENDER(player))  then { _speed = 1;};
            // systemChat ("Winding up");
			if(!isNil "_topRope") then {
                // systemChat ("winding up " + (str _topRope));
                
				ropeUnwind [ _topRope, _speed, ((ropeLength _topRope) - 0.1) min _ropeLength]; //0.3
			};
			
			if(!isNil "_bottomRope") then {
            // systemChat ("winding up " + (str _bottomRope));
				ropeUnwind [ _bottomRope, _speed, ((ropeLength _bottomRope) + 0.1) max 0]; //0.3
			};
		};
		if(_this select 1 in (actionKeys "Turbo") && player getVariable ["AUR_JUMP_PRESSED_START",0] == 0) then {
			player setVariable ["AUR_JUMP_PRESSED_START",diag_tickTime];
		};
		
		if(_this select 1 in (actionKeys "TurnRight")) then {
			player setVariable ["AUR_RIGHT_DOWN",true];
		};
		if(_this select 1 in (actionKeys "TurnLeft")) then {
			player setVariable ["AUR_LEFT_DOWN",true];
		};
	}];
	_ropeKeyUpHandler = (findDisplay 46) displayAddEventHandler ["KeyUp", {
		if(_this select 1 in (actionKeys "Turbo")) then {
			player setVariable ["AUR_JUMP_PRESSED",true];
			player setVariable ["AUR_JUMP_PRESSED_TIME",diag_tickTime - (player getVariable ["AUR_JUMP_PRESSED_START",diag_tickTime])];
			player setVariable ["AUR_JUMP_PRESSED_START",0];	
		};
		if(_this select 1 in (actionKeys "TurnRight")) then {
			player setVariable ["AUR_RIGHT_DOWN",false];
		};
		if(_this select 1 in (actionKeys "TurnLeft")) then {
			player setVariable ["AUR_LEFT_DOWN",false];
		};
	}];
} else {
	[_ropeTop,_ropeBottom] spawn {
		params ["_ropeTop","_ropeBottom"];
		sleep 1;
		_randomSpeedFactor = ((random 10) - 5) / 10;
		ropeUnwind [ _ropeTop, 2 + _randomSpeedFactor, (ropeLength _ropeTop) + (ropeLength _ropeBottom)];
		ropeUnwind [ _ropeBottom, 2 + _randomSpeedFactor, 0];
	};
};

_walkingOnWallForce = [0,0,0];

_lastAiJumpTime = diag_tickTime;

while {true} do {
    // hint "rappelling...";

	_currentTime = diag_tickTime;
	_timeSinceLastUpdate = _currentTime - _lastTime;
	_lastTime = _currentTime;
	if(_timeSinceLastUpdate > 1) then {
		_timeSinceLastUpdate = 0;
	};

	_environmentWindVelocity = wind;
	_playerWindVelocity = _velocityVec vectorMultiply -1;
	_totalWindVelocity = _environmentWindVelocity vectorAdd _playerWindVelocity;
	_totalWindForce = _totalWindVelocity vectorMultiply (9.8/53);

	_accelerationVec = _gravityAccelerationVec vectorAdd _totalWindForce vectorAdd _walkingOnWallForce;
	_velocityVec = _velocityVec vectorAdd ( _accelerationVec vectorMultiply _timeSinceLastUpdate );
	_newPosition = _lastPosition vectorAdd ( _velocityVec vectorMultiply _timeSinceLastUpdate );

	if(_newPosition distance _rappelPoint > ((ropeLength _ropeTop) + 1)) then {
		_newPosition = (_rappelPoint) vectorAdd (( vectorNormalized ( (_rappelPoint) vectorFromTo _newPosition )) vectorMultiply ((ropeLength _ropeTop) + 1));
		_surfaceVector = ( vectorNormalized ( _newPosition vectorFromTo (_rappelPoint) ));
		_velocityVec = _velocityVec vectorAdd (( _surfaceVector vectorMultiply (_velocityVec vectorDotProduct _surfaceVector)) vectorMultiply -1);
	};

	_radius = 0.85;
	_intersectionTests = 10;
	for "_i" from 0 to _intersectionTests do
	{
		_axis1 = cos ((360/_intersectionTests)*_i);
		_axis2 = sin ((360/_intersectionTests)*_i);
		{
			_directionUnitVector = vectorNormalized _x;
			_intersectStartASL = _newPosition;
			_intersectEndASL = _newPosition vectorAdd ( _directionUnitVector vectorMultiply _radius );
			_surfaces = lineIntersectsSurfaces [_intersectStartASL, _intersectEndASL, _player, objNull, true, 10,"FIRE","NONE"];
			{
				_x params ["_intersectionPositionASL", "_surfaceNormal", "_intersectionObject"];
				_objectFileName = str _intersectionObject;
				if((_objectFileName find "rope") == -1 && not (_intersectionObject isKindOf "RopeSegment") && (_objectFileName find " t_") == -1 && (_objectFileName find " b_") == -1 ) then {
					if(_newPosition distance _intersectionPositionASL < 1) then {
						_newPosition = _intersectionPositionASL vectorAdd ( ( vectorNormalized ( _intersectEndASL vectorFromTo _intersectStartASL )) vectorMultiply  (_radius) );
					};
					_velocityVec = _velocityVec vectorAdd (( _surfaceNormal vectorMultiply (_velocityVec vectorDotProduct _surfaceNormal)) vectorMultiply -1);
				};
			} forEach _surfaces;
		} forEach [[_axis1, _axis2, 0], [_axis1, 0, _axis2], [0, _axis1, _axis2]];
	};
	
	
	_jumpPressed = _player getVariable ["AUR_JUMP_PRESSED",false];
	_jumpPressedTime = _player getVariable ["AUR_JUMP_PRESSED_TIME",0];
	_leftDown = _player getVariable ["AUR_LEFT_DOWN",false];
	_rightDown = _player getVariable ["AUR_RIGHT_DOWN",false];
	
	// Simulate AI jumping off wall randomly
	if(_player != player) then {
		if(diag_tickTime - _lastAiJumpTime > (random 30) max 5) then {
			_jumpPressed = true;
			_jumpPressedTime = 0;
			_lastAiJumpTime = diag_tickTime;
		};
	};
	
	if(_jumpPressed || _leftDown || _rightDown) then {
		
		// Get the surface normal of the surface the player is hanging against
		_intersectStartASL = _newPosition;
		_intersectEndASL = _intersectStartASL vectorAdd (vectorDir _player vectorMultiply (_radius + 0.3));
		_surfaces = lineIntersectsSurfaces [_intersectStartASL, _intersectEndASL, _player, objNull, true, 10, "GEOM", "NONE"];
		_isAgainstSurface = false;
		{
			_x params ["_intersectionPositionASL", "_surfaceNormal", "_intersectionObject"];
			_objectFileName = str _intersectionObject;
			if((_objectFileName find "rope") == -1 && not (_intersectionObject isKindOf "RopeSegment") && (_objectFileName find " t_") == -1 && (_objectFileName find " b_") == -1 ) exitWith {
				_isAgainstSurface = true;
			};
		} forEach _surfaces;

		if(_isAgainstSurface) then {
			if(_jumpPressed) then {
				_jumpForce = ((( 1.5 min _jumpPressedTime )/1.5) * 4.5) max 2.5;
				_velocityVec = _velocityVec vectorAdd (vectorDir _player vectorMultiply (_jumpForce * -1));
				_player setVariable ["AUR_JUMP_PRESSED", false];
			};
			if(_rightDown) then {
				_walkingOnWallForce = (vectorNormalized ((vectorDir _player) vectorCrossProduct [0,0,1])) vectorMultiply 1;
			};
			if(_leftDown) then {
				_walkingOnWallForce = (vectorNormalized ((vectorDir _player) vectorCrossProduct [0,0,-1])) vectorMultiply 1;
			};
			if(_rightDown && _leftDown) then {
				_walkingOnWallForce = [0,0,0];
			}
		} else {
			_player setVariable ["AUR_JUMP_PRESSED", false];
		};
	
	} else {
		_walkingOnWallForce = [0,0,0];
	};
	
	_rappelDevice setPosWorld (_newPosition vectorAdd (_velocityVec vectorMultiply 0.1) );
	_rappelDevice setVectorDir (vectorDir _player); 
	    diag_log "setting player Pos";
	_player setPosWorld (_newPosition vectorAdd [0,0,-0.6]);

	_player setVelocity [0,0,0];

	_lastPosition = _newPosition;
	
	if( !alive _player || vehicle _player != _player || ropeLength _ropeBottom <= 1 || _player getVariable ["AUR_Climb_To_Top",false] || _player getVariable ["AUR_Detach_Rope",false] ) exitWith {
        if(_player getVariable ["AUR_Detach_Rope",false]) then {
                // Player detached from rope. Don't prevent damage 
                // if we didn't find a position on the ground
                // [_player] call tirp_fnc_AUR_cleanup_after;
                _player allowDamage true;
                };
                
            // };

            if(_player getVariable ["AUR_Climb_To_Top",false]) then {
                _player allowDamage false;
                diag_log "Setting climb out pos";
                _player setPosWorld ((getPosASL (AUR_GET_ENDPOINT_LEADER(_player))));
                // [_player] call tirp_fnc_AUR_cleanup_after;
                _player allowDamage true;
            };
        diag_log "exiting rappel";
    
            if(_decendRopeKeyDownHandler != -1) then {			
            (findDisplay 46) displayRemoveEventHandler ["KeyDown", _decendRopeKeyDownHandler];
        };
        if(_ropeKeyUpHandler != -1) then {			
            (findDisplay 46) displayRemoveEventHandler ["KeyDown", _ropeKeyUpHandler];
        };
        [_player] call tirp_fnc_AUR_cleanup_after;
        };
	
	sleep 0.01;
};

// if(ropeLength _ropeBottom > 1 && alive _player && vehicle _player == _player && not (_player getVariable ["AUR_Climb_To_Top",false])) then {

	// _playerStartASLIntersect = getPosASL _player;
	// _playerEndASLIntersect = [_playerStartASLIntersect select 0, _playerStartASLIntersect select 1, (_playerStartASLIntersect select 2) - 5];
	// _surfaces = lineIntersectsSurfaces [_playerStartASLIntersect, _playerEndASLIntersect, _player, objNull, true, 10];
	// _intersectionASL = [];
	// {
		// hint str _x;
		// scopeName "surfaceLoop";
		// _intersectionObject = _x select 2;
		// _objectFileName = str _intersectionObject;
		// if((_objectFileName find " t_") == -1 && (_objectFileName find " b_") == -1) then {
			// _intersectionASL = _x select 0;
			// breakOut "surfaceLoop";
		// };
	// } forEach _surfaces;
	
	// if(count _intersectionASL != 0) then {
		// _player allowDamage false;
		// _player setPosASL _intersectionASL;
	// };		



// ropeDestroy _ropeTop;
// ropeDestroy _ropeBottom;		
// deleteVehicle _anchor;
// deleteVehicle _rappelDevice;

AUR_SET_RAPPELLING_STATUS(_player, nil);
_player setVariable ["AUR_Rappel_Rope_Top",nil];
_player setVariable ["AUR_Rappel_Rope_Bottom",nil];
_player setVariable ["AUR_Rappel_Rope_Length",nil];
_player setVariable ["AUR_Climb_To_Top",nil];
_player setVariable ["AUR_Detach_Rope",nil];
_player setVariable ["AUR_Animation_Move",nil,true];
_player setVariable ["AUR_Anchor_objects",nil];

if(_decendRopeKeyDownHandler != -1) then {			
	(findDisplay 46) displayRemoveEventHandler ["KeyDown", _decendRopeKeyDownHandler];
};
if(_ropeKeyUpHandler != -1) then {			
	(findDisplay 46) displayRemoveEventHandler ["KeyDown", _ropeKeyUpHandler];
};

sleep 2;
terminate _animationsHandle;
_player allowDamage true;
