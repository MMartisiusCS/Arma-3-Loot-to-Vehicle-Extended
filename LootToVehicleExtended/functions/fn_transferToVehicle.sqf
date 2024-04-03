params ["_target", "_vehicle"];
    
private _items = [];
private _backpacks = [];
private _isMan = _target isKindOf "CAManBase";
private _targetTypeStr = ["ground", "body"] select _isMan;

systemChat format ["1Tac Antistasi Looter: from %1 into %2", _targetTypeStr, getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayname")];

if (_isMan) then {
    _items = magazines _target;
    _items append weapons _target;

    removeAllWeapons _target;
    
    private _backpack = backpack _target;
    if !(_backpack isEqualTo "") then {
        _backpacks pushBack _backpack;
        removeBackpackGlobal _target;
    };
    
    private _uniform = uniform _target;
    if !(_uniform isEqualTo "") then {
         _items pushBack _uniform;
        removeUniform _target; // keep your pants on for muh immersions
    };
    private _vest = vest _target;
    if !(_vest isEqualTo "") then {
        _items pushBack _vest;
        removeVest _target;
    };
    private _headgear = headgear _target;
    if !(_headgear isEqualTo "") then {
        _items pushBack _headgear;
        removeHeadgear _target;
    };
    private _nvg = hmd _target;
    if !(_nvg isEqualTo "") then {
        _items pushBack _nvg;
        _target unlinkItem _nvg;
    };
    private _bino = binocular _target;
    if !(_bino isEqualTo "") then {
        _items pushBack _bino;
        _target unlinkItem _bino;
    };
    private _goggles = goggles _target;
    if !(_goggles isEqualTo "") then {
        _items pushBack _goggles;
       removeGoggles _target;
    };
    private _map = _target getSlotItemName 608;
    if !(_map isEqualTo "") then {
        _items pushBack _map;
       _target unlinkItem _map;
    };
    private _compass = _target getSlotItemName 609;
    if !(_compass isEqualTo "") then {
        _items pushBack _compass;
       _target unlinkItem _compass;
    };
    private _watch = _target getSlotItemName 610;
    if !(_watch isEqualTo "") then {
        _items pushBack _watch;
       _target unlinkItem _watch;
    };
    private _radio = _target getSlotItemName 611;
    if !(_radio isEqualTo "") then {
        _items pushBack _radio;
       _target unlinkItem _radio;
    };
    private _gps = _target getSlotItemName 612;
    if !(_gps isEqualTo "") then {
        _items pushBack _gps;
       _target unlinkItem _gps;
    };
    
    _target setVariable ["bear_antistasi_looter", true, true];
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