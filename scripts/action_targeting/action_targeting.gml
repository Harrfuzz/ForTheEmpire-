//arg0 - actor performing
//arg1 -  targeting type
//arg2 -  targeting range

actor = argument0;
targetingType = argument1;
range = argument2;

switch(targetingType){
	case "cone":
		originX = actor.x +32;
		originY = actor.y + 32;
		dir = point_direction(originX, originY, oCursor.hoverNode.x +32, oCursor.hoverNode.y +32);
		originX += lengthdir_x(63, dir);
		originY += lengthdir_y(63, dir);
		dist = range - 32
		
		for(ii = -30; ii <=30; ii+= 15){
			for(jj = 0; jj <= dist; jj +=16){
				tempX = originX + lengthdir_x(jj, dir + ii);
				tempY = originY + lengthdir_y(jj, dir + ii);
				
				if(!collision_line(originX, originY, tempX, tempY, oWall, false, false)){
					if(instance_position(tempX, tempY, oNode)){
						node = instance_position(tempX, tempY, oNode);
						
						if(node.type != "wall"){
							node.actionNode = true;
							node.color = c_purple;
						}
					}
				}
			}
		}
		break;	
		
	case "visible allies":
		with(oActor){
			if(army == other.actor.army){
				if(!collision_line(x,y,other.actor.x,other.actor.y,oWall,false, false)){
					node = map[gridX, gridY];
					node.actionNode = true;
					node.color = c_purple;
					
				}
			}
		}
		break;
		
	case "visible enemies":
		with(oActor){
			if(army != other.actor.army){
				if(!collision_line(x,y,other.actor.x,other.actor.y, oWall, false, false)){
					node = map[gridX, gridY];
					node.actionNode = true;
					node.color = c_purple;
				}
			}
		}
		break;
}