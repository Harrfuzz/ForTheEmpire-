/// @description Insert description here
// You can write your code in this editor
neighbors = ds_list_create();
color=c_white;
occupant = noone;			//unit occupying node
passable = true;			// can node be stood upon

gridX = 0;
gridY = 0;

type = "node";

//pathfinding vars----------------------
parent = noone;		//hold id of node that scores it
G=0;				//G-score. distance from actor source node
moveNode = false;	// is node valid for player to click
attackNode = false;
actionNode = false;
cost = 1;
