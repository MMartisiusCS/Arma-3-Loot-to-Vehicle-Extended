class CfgPatches
{
	class LootToVehicleExtended
	{
		name="Loot to Vehicle for ACE and Antistasi Modified";
		units[]={};
		weapons[]={};
		requiredVersion=1;
		requiredAddons[]=
		{
			"ace_interact_menu"
		};
		author="[1Tac] Bear, dawidseksi";
		authorUrl="http://www.teamonetactical.com/";
	};
};
class Extended_PostInit_EventHandlers
{
	class LootToVehicleExtended
	{
		init="call compile preProcessFileLineNumbers 'LootToVehicleExtended\XEH_postInit.sqf'";
	};
};
class CfgFunctions
{
	class LootToVehicleExtended
	{
		class LootToVehicleExtended
		{
			file="LootToVehicleExtended\functions";
			class transferToVehicle
			{
			};
		};
	};
};
class CfgMods
{
	class Mod_Base;
	class LootToVehicleExtended: Mod_Base
	{
		dir="@LootToVehicleExtended";
		name="Antistasi Loot to Vehicle Modified";
		logo="LootToVehicleExtended\ui\bear_ca1.paa";
		logoSmall="LootToVehicleExtended\ui\bear_ca2.paa";
		logoOver="LootToVehicleExtended\ui\bear_over_ca3.paa";
		picture="LootToVehicleExtended\ui\antistasi_looter_co4.paa";
		hidePicture="true";
		hideName="true";
		actionName="Website";
		action="http://teamonetactical.com";
		description="Loot to Vehicle for ACE and Antistasi. Modified by dawidseksi";
	};
};
