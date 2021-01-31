/*
*   Author: Patch & Tirpitz
*   Sets up rappelling on the players machine.
*   params: postInit
*/

// Prevent advanced urban rappelling from installing twice
if(!isNil "TIRP_fnc_AUR_RAPPELLING_INIT") exitWith {};
TIRP_fnc_AUR_RAPPELLING_INIT = true;

diag_log "Advanced Urban Rappelling Loading...";






if(isServer) then {
	
	// Adds support for exile network calls (Only used when running exile) //
	
	TIRP_fnc_AUR_SUPPORTED_REMOTEEXECSERVER_FUNCTIONS = ["TIRP_fnc_AUR_Enable_Rappelling_Animation_Global","TIRP_fnc_AUR_Hide_Object_Global","TIRP_fnc_AUR_Play_Rappelling_Sounds_Global"];

	ExileServer_AdvancedUrbanRappelling_network_AdvancedUrbanRappellingRemoteExecServer = {
		params ["_sessionId", "_messageParameters",["_isCall",false]];
		_messageParameters params ["_params","_functionName"];
		if(_functionName in TIRP_fnc_AUR_SUPPORTED_REMOTEEXECSERVER_FUNCTIONS) then {
			if(_isCall) then {
				_params call (missionNamespace getVariable [_functionName,{}]);
			} else {
				_params spawn (missionNamespace getVariable [_functionName,{}]);
			};
		};
	};
	
	TIRP_fnc_AUR_SUPPORTED_REMOTEEXECCLIENT_FUNCTIONS = ["TIRP_fnc_AUR_Hint"];
	
	ExileServer_AdvancedUrbanRappelling_network_AdvancedUrbanRappellingRemoteExecClient = {
		params ["_sessionId", "_messageParameters"];
		_messageParameters params ["_params","_functionName","_target",["_isCall",false]];
		if(_functionName in TIRP_fnc_AUR_SUPPORTED_REMOTEEXECCLIENT_FUNCTIONS) then {
			if(_isCall) then {
				_params remoteExecCall [_functionName, _target];
			} else {
				_params remoteExec [_functionName, _target];
			};
		};
	};
	
};

diag_log "Advanced Urban Rappelling Loaded";
