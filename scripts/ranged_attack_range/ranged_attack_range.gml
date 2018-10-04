//argument0 Actor performing ranged check
actor = argument0;
with(oActor){
	tempActor = other.actor;
	if(army != tempActor.army){		//if not actors army
		if(point_distance(x+32,y+32,tempActor.x + 32, tempActor.y+32) <= tempActor.attackRange){	//if in rangeg
			if(!collision_line(x+32,y+32,tempActor.x + 32, tempActor.y+32,oWall,false,false)){//if wall in way
				map[gridX,gridY].attackNode = true;
				map[gridX,gridY].color =c_red;
			}
		}
	}
}