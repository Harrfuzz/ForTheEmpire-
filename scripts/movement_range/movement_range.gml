//find units mmovement range
//arg0 - origin node to pathfind from
//arg1 - units move range
//arg2 - units remaining actions

//reset all node data
wipe_nodes();

var open, closed;						//data structures
var start, current, neighbor;			//instance ID vars
var tempG, range, costMod;				//extra working value vars

//declrae args to relevant vars
start = argument0;						//origin node
range = argument1 * argument2;			//range = move range per action * actions

//create priority queue and final list
open = ds_priority_create();			//instance ids go in equal to gscore, then go through queue
closed = ds_list_create();

//add orogin node to list
ds_priority_add(open,start,start.G);

//while open queue is not empty, do X until all nodes are looked at
while(ds_priority_size(open) > 0){
	//remove node with lowest g score from open and add it to closed list
	current = ds_priority_delete_min(open);
	ds_list_add(closed,current);
	
	for(ii = 0; ii < ds_list_size(current.neighbors); ii +=1){		//step through all of currents neighbor nodes
		neighbor = ds_list_find_value(current.neighbors, ii);	//store current neighbor in neighbor var
		
		//add if neighbor is passable, is occupant free, or Gscore is in move range, or neighbor isnt in closed list already
		if(ds_list_find_index(closed, neighbor) < 0 && neighbor.passable && neighbor.occupant = noone && neighbor.cost + current.G <= range){
			
			// only calc new G score for neighbor if it hasnt been calculated yet
			if(ds_priority_find_priority(open, neighbor) == 0 || ds_priority_find_priority(open, neighbor) = undefined){
				costMod = 1;
				
				//give neighbor appropriat eparent
				neighbor.parent = current;
				if(neighbor.gridX != current.gridX && neighbor.gridY != current.gridY){
					costMod = 1.5;
				}
				neighbor.G = current.G + (neighbor.cost * costMod);
				
				//add to open list to be checked out 
				ds_priority_add(open, neighbor, neighbor.G);
			}
			else{		//else if neighbor score has already been calculated for open list, recalc if it fits
				costMod =1;
				if(neighbor.gridX != current.gridX && neighbor.gridY != current.gridY){
					costMod = 1.5;
				}
				tempG = current.G + (neighbor.cost * costMod);
				if(tempG < neighbor.G){
					neighbor.parent = current
					neighbor.G = tempG;
					ds_priority_change_priority(open, neighbor, neighbor.G);
				}
			}
		}
	}
}

//round all Gscores for moevement calc
with(oNode){
	G = floor(G);
}

//out datastructures in garbage and destroy them for memory leaks
ds_priority_destroy(open);

//color all move nodes, then destory closed
for(ii = 0; ii < ds_list_size(closed); ii +=1){
	current = ds_list_find_value(closed, ii);
	current.moveNode = true;
	color_move_nodes(current, argument1, argument2);
}
start.moveNode=false;	//make start node invalid move node 
ds_list_destroy(closed);
create_buttons(start.occupant);