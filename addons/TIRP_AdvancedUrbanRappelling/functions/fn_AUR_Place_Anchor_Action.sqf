
params ["_player"];


_anchor = createVehicle ["WeaponHolderSimulated", player,[],0,"CAN_COLLIDE"];
_player removeItem "AUR_AnchorKit";

_anchor addWeaponCargoGlobal ["AUR_AnchorKit", 1];
//_anchor setPos (getPos player);
_anchor allowDamage false;

// _anchor addAction ["Attach Rope", {[player, (_this select 0),80] spawn TIRP_fnc_AUR_Prepare_Rope;}, nil, 6, true, false, "", "true", 2, false,"","[player] call TIRP_fnc_AUR_Prepare_Rope_Check"];


_anchor addAction   ["Attach 30m Rope", {[player, (_this select 0),30] spawn TIRP_fnc_AUR_Prepare_Rope;}, nil, 6, true, false, "","[player, 30] call TIRP_fnc_AUR_Prepare_Rope_Check", 2, false,"",""];
_anchor addAction   ["Attach 40m Rope", {[player, (_this select 0),40] spawn TIRP_fnc_AUR_Prepare_Rope;}, nil, 6, true, false, "","[player, 40] call TIRP_fnc_AUR_Prepare_Rope_Check", 2, false,"",""];
_anchor addAction   ["Attach 50m Rope", {[player, (_this select 0),50] spawn TIRP_fnc_AUR_Prepare_Rope;}, nil, 6, true, false, "","[player, 50] call TIRP_fnc_AUR_Prepare_Rope_Check", 2, false,"",""];
_anchor addAction   ["Attach 60m Rope", {[player, (_this select 0),60] spawn TIRP_fnc_AUR_Prepare_Rope;}, nil, 6, true, false, "","[player, 60] call TIRP_fnc_AUR_Prepare_Rope_Check", 2, false,"",""];
_anchor addAction   ["Attach 80m Rope", {[player, (_this select 0),80] spawn TIRP_fnc_AUR_Prepare_Rope;}, nil, 6, true, false, "","[player, 80] call TIRP_fnc_AUR_Prepare_Rope_Check", 2, false,"",""];
_anchor addAction   ["Attach 100m Rope", {[player, (_this select 0),100] spawn TIRP_fnc_AUR_Prepare_Rope;}, nil, 6, true, false, "","[player, 100] call TIRP_fnc_AUR_Prepare_Rope_Check", 2, false,"",""];