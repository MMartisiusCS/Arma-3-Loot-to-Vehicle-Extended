private _action = [
    "LootToVehicleExtended_transferAction", "Transfer Loot to Vehicle", "a3\ui_f\data\IGUI\Cfg\Actions\loadVehicle_ca.paa",
    {
        params ["_target", "_player"];
        
        (nearestObjects [_player, ace_cargo_cargoHolderTypes, 15]) select {
            (_x != _target) && {([_target, _x] call ace_interaction_fnc_getInteractionDistance) < 15}
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
                (_x != _target) && {([_target, _x] call ace_interaction_fnc_getInteractionDistance) < 15}
            } count (nearestObjects [_player, ace_cargo_cargoHolderTypes, 15])
        }
    },
    {
        private _statement = {
            params ["_target", "_player", "_vehicle"];
            [_target, _vehicle] call LootToVehicleExtended_fnc_transferToVehicle;
        };
        
        private _vehicles = (nearestObjects [_target, ace_cargo_cargoHolderTypes, 15]) select {
            (_x != _target) && {([_target, _x] call ace_interaction_fnc_getInteractionDistance) < 15}
        };

        [_vehicles, _statement, _target] call ace_interact_menu_fnc_createVehiclesActions;
    }
] call ace_interact_menu_fnc_createAction;

["CAManBase", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
["WeaponHolder", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;
["WeaponHolderSimulated", 0, ["ACE_MainActions"], _action, true] call ace_interact_menu_fnc_addActionToClass;