#include "script_components.hpp"
class CfgPatches
{
	class TIRP_AdvancedUrbanRappelling
	{
		units[] = {"TIRP_AdvancedUrbanRappelling"};
		requiredVersion = 1.0;
		requiredAddons[] = {"A3_Modules_F","cba_main"};
	};
};

class CfgNetworkMessages
{
	
	class AdvancedUrbanRappellingRemoteExecClient
	{
		module = "AdvancedUrbanRappelling";
		parameters[] = {"ARRAY","STRING","OBJECT","BOOL"};
	};
	
	class AdvancedUrbanRappellingRemoteExecServer
	{
		module = "AdvancedUrbanRappelling";
		parameters[] = {"ARRAY","STRING","BOOL"};
	};
	
};

class CfgFunctions
{

#include "\TIRP_AdvancedUrbanRappelling\functions\functions.h"

};
#include "cfgWeapons.hpp"

class CfgSounds
{
	class AUR_Rappel_Loop
	{
		name = "AUR_Rappel_Loop";
		sound[] = {"\TIRP_AdvancedUrbanRappelling\sounds\AUR_Rappel_Loop.ogg", db+5, 1};
		titles[] = {0,""};
	};
	class AUR_Rappel_Start
	{
		name = "AUR_Rappel_Start";
		sound[] = {"\TIRP_AdvancedUrbanRappelling\sounds\AUR_Rappel_Start.ogg", db+10, 1};
		titles[] = {0,""};
	};
	class AUR_Rappel_End
	{
		name = "AUR_Rappel_End";
		sound[] = {"\TIRP_AdvancedUrbanRappelling\sounds\AUR_Rappel_End.ogg", db+10, 1};
		titles[] = {0,""};
	};
};
#include "cfgAnimations.hpp"