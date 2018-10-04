/// @description Insert description here
// You can write your code in this editor
//status of attack "miss", hit, crit
status = "miss";
damage = 0;
damageType = "piercing";
target = noone;		//target
owner = noone;		//attacker

//path info
movementPath = path_add();
path_set_closed(movementPath, false);
path_set_kind(movementPath,2);