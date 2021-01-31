class CfgWeapons
{
	class CBA_MiscItem;
	class CBA_MiscItem_ItemInfo;
    class ToolKit;
    class ace_csw_kordCarryTripod;
	class AUR_rope30: CBA_MiscItem {
		scope = 2;
		GVAR(ropeLength) = 30;
		picture = "\TIRP_AdvancedUrbanRappelling\assets\rope_Icon";
		model = "\A3\Structures_F_Heli\Items\Tools\Rope_01_F.p3d";
		displayName = "30m Climbing Rope";
		descriptionShort = "9.8mm Rope suitable for climbing or rappelling";
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 42;
		};

	};
	class AUR_rope40: CBA_MiscItem {
		scope = 2;
		GVAR(ropeLength) = 40;
		picture = "\TIRP_AdvancedUrbanRappelling\assets\rope_Icon";
		model = "\A3\Structures_F_Heli\Items\Tools\Rope_01_F.p3d";
		displayName = "40m Climbing Rope";
		descriptionShort = "9.8mm Rope suitable for climbing or rappelling";
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 56;
		};
	};
	class AUR_rope50: CBA_MiscItem {
		scope = 2;
		GVAR(ropeLength) = 50;
		picture = "\TIRP_AdvancedUrbanRappelling\assets\rope_Icon";
		model = "\A3\Structures_F_Heli\Items\Tools\Rope_01_F.p3d";
		displayName = "50m Climbing Rope";
		descriptionShort = "9.8mm Rope suitable for climbing or rappelling";
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 70;
		};
	};
	class AUR_rope60: CBA_MiscItem {
		scope = 2;
		GVAR(ropeLength) = 60;
		picture = "\TIRP_AdvancedUrbanRappelling\assets\rope_Icon";
		model = "\A3\Structures_F_Heli\Items\Tools\Rope_01_F.p3d";
		displayName = "60m Climbing Rope";
		descriptionShort = "9.8mm Rope suitable for climbing or rappelling";
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 84;
		};
	};
	class AUR_rope80: CBA_MiscItem {
		scope = 2;
		GVAR(ropeLength) = 80;
		picture = "\TIRP_AdvancedUrbanRappelling\assets\rope_Icon";
		model = "\A3\Structures_F_Heli\Items\Tools\Rope_01_F.p3d";
		displayName = "80m Climbing Rope";
		descriptionShort = "9.8mm Rope suitable for climbing or rappelling";
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 112;
		};
	};
	class AUR_rope100: CBA_MiscItem {
		scope = 2;
		GVAR(ropeLength) = 100;
		picture = "\TIRP_AdvancedUrbanRappelling\assets\rope_Icon";
		model = "\A3\Structures_F_Heli\Items\Tools\Rope_01_F.p3d";
		displayName = "100m Climbing Rope";
		descriptionShort = "9.8mm Rope suitable for climbing or rappelling";
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 140;
		};
	};
	class AUR_AnchorKit: CBA_MiscItem {
		scope = 2;
		picture = "\TIRP_AdvancedUrbanRappelling\assets\anchor_Icon";
		model = "\A3\Structures_F_EPA\Items\Tools\MetalWire_F.p3d";
		displayName = "Rappelling Anchor Kit";
		descriptionShort = "An unassembled rappelling anchor";
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 1;
		};
	};
	class AUR_BelayDevice: CBA_MiscItem {
		scope = 2;
		picture = "\TIRP_AdvancedUrbanRappelling\assets\belay_Icon";
		model = "\A3\Structures_F_EPA\Items\Tools\CanOpener_F.p3d";
		displayName = "Belay device/descender";
		descriptionShort = "Multifunction belay and rappelling device";
		class ItemInfo: CBA_MiscItem_ItemInfo {
			mass = 2;
		};
	};
    	class AUR_AscenderDevice: ace_csw_kordCarryTripod {
		scope = 2;
		picture = "\TIRP_AdvancedUrbanRappelling\assets\tcx-rescue-f";
        model = "\A3\Weapons_F\Items\Toolkit";
		displayName = "TCX Force";
		descriptionShort = "The TCX Force is specifically developed to be used for any land based or urban operations, for fast heavy lifting operations. Maximum ascent speed: 60m/min, max load: 250kg (its the future baby)"; //http://www.actsafe.se/product/tcx-assault has two version, a 250kg/24m/min and a 150kg/60m/min this is the best of both worlds.
        class WeaponSlotsInfo {
			mass = 280;
		};
	};

};