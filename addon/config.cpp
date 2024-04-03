class CfgPatches
{
	class bear_antistasi_looter
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
	class bear_antistasi_looter
	{
		init="call compile preProcessFileLineNumbers 'XEH_postInit.sqf'";
	};
};
class CfgFunctions
{
	class bear_antistasi_looter
	{
		class bear_antistasi_looter
		{
			file="functions";
			class transferToVehicle
			{
			};
		};
	};
};
class CfgMods
{
	class Mod_Base;
	class bear_antistasi_looter: Mod_Base
	{
		dir="@bear_antistasi_looter";
		name="[1Tac] Antistasi Loot to Vehicle Modified";
		logo="ui\bear_ca.paa";
		logoSmall="ui\bear_ca.paa";
		logoOver="ui\bear_over_ca.paa";
		picture="ui\antistasi_looter_co.paa";
		hidePicture="true";
		hideName="true";
		actionName="Website";
		action="http://teamonetactical.com";
		description="[1Tac] Loot to Vehicle for ACE and Antistasi. Modified by dawidseksi";
	};
};
