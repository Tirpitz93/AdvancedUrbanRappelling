	
    #include "TIRP_AUR_MACROS.h"
    params ["_player"];
	if!(AUR_GET_RAPPELLING_STATUS(_player )) exitWith {false;};
	true;