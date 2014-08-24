/*
 * Author: KoffeinFlummi
 *
 * Adjusts the flight path of the bullet according to the zeroing
 *
 * Arguments:
 * Fired EH
 *
 * Return Value:
 * None
 */

_unit = _this select 0;
_weaponType = _this select 1;
_ammoType = _this select 4;
_magazineType = _this select 5;
_round = _this select 6;

_weapons = [
  primaryWeapon player,
  secondaryWeapon player,
  handgunWeapon player;
];
_zeroing = AGM_Scopes_Adjustment select (_weapons find (currentWeapon player));

// convert zeroing to degrees
_zeroing = [_zeroing, {_this * 0.05625}] call AGM_Core_fnc_map;

_direction = vectorDir _round;
_azimuth = ((_direction select 0) atan2 (_direction select 1)) + (_zeroing select 0);
_altitude = sqrt ((_direction select 1) ^ 2 + (_direction select 0) ^ 2) atan2 - (_direction select 2) + (_zeroing select 1);

_direction = [
  sin _azimuth * sin _altitude,
  cos _azimuth * sin _altitude,
  - cos _altitude
];

_velocity = velocity _round;
_velocity = sqrt ((_velocity select 0) ^ 2 + (_velocity select 1) ^ 2 + (_velocity select 2) ^ 2);
_velocity = [(_direction select 0) * _velocity, (_direction select 1) * _velocity, (_direction select 2) * _velocity];

_round setVectorDirAndUp [
  _direction,
  [
    (_direction select 0) * (_direction select 2) / sqrt ((_direction select 0) ^ 2 + (_direction select 1) ^ 2),
    (_direction select 1) * (_direction select 2) / sqrt ((_direction select 0) ^ 2 + (_direction select 1) ^ 2),
    sqrt ((_direction select 0) ^ 2 + (_direction select 1) ^ 2)
  ]
];
_round setPosASL (getPosASL _round);
_round setVelocity _velocity;