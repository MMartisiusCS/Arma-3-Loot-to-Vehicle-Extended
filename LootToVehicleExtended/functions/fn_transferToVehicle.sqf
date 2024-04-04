params ["_target", "_vehicle"];
private _items = [];
private _backpacks = [];
private _isMan = _target isKindOf "CAManBase";
private _targetTypeStr = ["ground", "body"] select _isMan;

systemChat format ["1Tac Antistasi Looter: from %1 into %2", _targetTypeStr, getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayname")];

if (_isMan) then {
    //_items = magazines _target;
    //_items = weapons _target;
    if (primaryWeapon _target != "") then{_items append (_target weaponAccessories primaryWeapon _target)};
    _items append assignedItems [_target, true, true];
    
    private _backpack = backpack _target;
    if !(_backpack isEqualTo "") then {
        _items append itemCargo backpackContainer _target;
        _items append weaponCargo backpackContainer _target;
        _items append magazineCargo backpackContainer _target;
        _backpacks pushBack (_backpack call BIS_fnc_basicBackpack);
        {
            _backpacks pushBack (_x call BIS_fnc_basicBackpack);
        } forEach backpackCargo (backpackContainer _target);
    };
    private _uniform = uniform _target;
    if !(_uniform isEqualTo "")then {
        _items append itemCargo uniformContainer _target;
        _items append weaponCargo uniformContainer _target;
        _items append magazineCargo uniformContainer _target;
        if (LootToVehicleExtended_TransferUniformWithItems) then {
            _items pushBack _uniform;
        };
    };
    private _vest = vest _target;
    if !(_vest isEqualTo "") then {
        _items append itemCargo vestContainer _target;
        _items append weaponCargo vestContainer _target;
        _items append magazineCargo vestContainer _target;
        _items pushBack _vest;
    };
    
    //_target setVariable ["LootToVehicleExtended", true, true];
} else {
    _items = magazineCargo _target;
    _items append weaponCargo _target;
    _items append itemCargo _target;
    {
        _backpacks pushBack (_x call BIS_fnc_basicBackpack);
    } forEach backpackCargo _target;
    {
        _items append itemCargo (_x select 1);
        _items append weaponCargo (_x select 1);
        _items append magazineCargo (_x select 1);
        {
        _backpacks pushBack (_x call BIS_fnc_basicBackpack);
        } forEach backpackCargo (_x select 1);
    } forEach (everyContainer _target);
};
private _weight = loadAbs _target;
systemChat format ["Total mass of items: %1", _weight];
[(_weight * (LootToVehicleExtended_TransferSpeedSeconds/100)), [_target,_items,_backpacks,_vehicle], {
    _target = _args select 0;
    _items = _args select 1;
    _backpacks = _args select 2;
    _vehicle = _args select 3;
{
    _vehicle addItemCargoGlobal [_x, 1];
} forEach _items;

{
    _vehicle addBackpackCargoGlobal [_x, 1];
} forEach _backpacks;
removeAllAssignedItems [_target, true, true];
removeAllWeapons _target;
removeBackpackGlobal _target;
removeUniform _target;
removeVest _target;
clearItemCargoGlobal _target:
clearWeaponCargoGlobal _target;
clearMagazineCargoGlobal _target;
clearBackpackCargoGlobal _target;
systemChat format ["Total items transferred to target: %1", (count _items + count _backpacks)];
}, {}, "Transfering items..."] call ace_common_fnc_progressBar;