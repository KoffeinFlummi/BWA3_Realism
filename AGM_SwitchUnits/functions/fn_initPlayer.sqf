/*
  Name: AGM_SwitchUnits_fnc_initPlayer
  
  Author(s):
    jodav
  
  Description:
    Initializes the player
  
  Parameters:
    0: OBJECT - player
    1: OBJECT - side
  
  Returns:
    VOID
*/

private ["_playerUnit", "_side"];

_playerUnit = _this select 0;
_side = _this select 1;

if (vehicle _playerUnit == _playerUnit) then {

  [_side] call AGM_SwitchUnits_fnc_markAiOnMap;

  _playerUnit setVariable ["AGM_SwitchUnits_IsPlayerUnit", true];
  _playerUnit allowDamage false;
  
  AGM_SwitchUnits_OriginalUnit = _playerUnit;
  AGM_SwitchUnits_OriginalName = name _playerUnit;
  AGM_SwitchUnits_OriginalGroup = group _playerUnit;
  
  // remove all starting gear of a player
  removeallweapons _playerUnit;
  removeGoggles _playerUnit;
  removeHeadgear _playerUnit;
  removeVest _playerUnit;
  removeAllAssignedItems _playerUnit;
  clearAllItemsFromBackpack _playerUnit;
  removeBackpack _playerUnit;
  _playerUnit linkItem  "ItemMap";
  removeUniform _playerUnit;
  
  _playerUnit forceWalk true;
  
  [_playerUnit] call AGM_SwitchUnits_fnc_addMapFunction;
};