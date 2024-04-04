params ["_target", "_vehicle"];
private _items = [];
private _backpacks = [];
private _isMan = _target isKindOf "CAManBase";
private _targetTypeStr = ["ground", "body"] select _isMan;

systemChat format ["1Tac Antistasi Looter: from %1 into %2", _targetTypeStr, getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayname")];

if (_isMan) then {
    _items = magazines _target;
    _items append weapons _target;
    _items append assignedItems [_target, true, true];
    removeAllAssignedItems [_target, true, true];
    removeAllWeapons _target;
    
    private _backpack = backpack _target;
    if !(_backpack isEqualTo "") then {
        _items append itemCargo backpackContainer _target;
        clearBackpackCargoGlobal _target;
        _backpacks pushBack _backpack;
        removeBackpackGlobal _target;
    };
    
    private _uniform = uniform _target;
    if (!(_uniform isEqualTo "") && (LootToVehicleExtended_TransferUniform)) then {
        _items append itemCargo uniformContainer _target;
        clearItemCargoGlobal _target;
        _items pushBack _uniform;
        removeUniform _target; // keep your pants on for muh immersions
    };
    private _vest = vest _target;
    if !(_vest isEqualTo "") then {
        _items append itemCargo vestContainer _target;
        clearItemCargoGlobal _target;
        _items pushBack _vest;
        removeVest _target;
    };
    
    //_target setVariable ["LootToVehicleExtended", true, true];
} else {
    _items = magazineCargo _target;
    _items append weaponCargo _target;
    _backpacks = backpackCargo _target;
    clearWeaponCargoGlobal _target;
    clearMagazineCargoGlobal _target;
    clearBackpackCargoGlobal _target;
};

{
    _vehicle addItemCargoGlobal [_x, 1];
} forEach _items;

{
    _vehicle addBackpackCargoGlobal [_x, 1];
} forEach _backpacks;