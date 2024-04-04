[
    "LootToVehicleExtended_MaxTransferDistance", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    ["Max Transfer Distance", "Maxium distance interaction will show from target vehicle"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "Loot to Vehicle for ACE and Antistasi Modified", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [1, 100, 15, 1], // data for this setting: [min, max, default, number of shown trailing decimals]
    1, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;
[
    "LootToVehicleExtended_TransferUniform", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    ["Transfer Uniforms?","TRUE: Uniforms will be transfered to target\nFALSE: Uniforms will NOT be transfered to target"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "Loot to Vehicle for ACE and Antistasi Modified", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting: [min, max, default, number of shown trailing decimals]
    1, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_fnc_addSetting;

private _action = [
    "LootToVehicleExtended_transferAction", "Transfer Loot to Vehicle", "a3\ui_f\data\IGUI\Cfg\Actions\loadVehicle_ca.paa",
    {
        params ["_target", "_player"];
        
        (nearestObjects [_player, ace_cargo_cargoHolderTypes, LootToVehicleExtended_MaxTransferDistance]) select {
            (_x != _target) && {([_target, _x] call ace_interaction_fnc_getInteractionDistance) < LootToVehicleExtended_MaxTransferDistance}
        } params [["_nearestVehicle", objNull]];
        
        if (isNull _nearestVehicle) then {
            systemChat "1Tac Antistasi Looter: Error: couldn't find any nearby vehicle";
        } else {
            systemChat "1Tac Antistasi Looter: Using nearest vehicle";
            [_target, _nearestVehicle] call LootToVehicleExtended_fnc_transferToVehicle;
        };
    },
    {
        (_target isKindOf "WeaponHolderSimulated" || _target isKindOf "WeaponHolder" || !alive _target) &&
        {!(_target getVariable ["LootToVehicleExtended", false])} &&
        {[_player, _target] call ace_common_fnc_canInteractWith} &&
        {
            0 < {
                (_x != _target) && {([_target, _x] call ace_interaction_fnc_getInteractionDistance) < LootToVehicleExtended_MaxTransferDistance}
            } count (nearestObjects [_player, ace_cargo_cargoHolderTypes, LootToVehicleExtended_MaxTransferDistance])
        }
    },
    {
        private _statement = {
            params ["_target", "_player", "_vehicle"];
            [_target, _vehicle] call LootToVehicleExtended_fnc_transferToVehicle;
        };
        
        private _vehicles = (nearestObjects [_target, ace_cargo_cargoHolderTypes, LootToVehicleExtended_MaxTransferDistance]) select {
            (_x != _target) && {([_target, _x] call ace_interaction_fnc_getInteractionDistance) < LootToVehicleExtended_MaxTransferDistance}
        };

        [_vehicles, _statement, _target] call ace_interact_menu_fnc_createVehiclesActions;
    }
] call ace_interact_menu_fnc_createAction;

["CAManBase", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
["WeaponHolder", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
["WeaponHolderSimulated", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;