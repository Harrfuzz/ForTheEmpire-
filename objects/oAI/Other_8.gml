/// @description Insert description here
// You can write your code in this editor
path_clear_points(movementPath);
if(actions > 0 || charge){
	state = "find target";
}
else{
	state = "idle"
	oGame.currentActor = noone;
}