/// @description This event draws the path to a target
// You can write your code in this editor
//if cursor is hovering over dif node than actor
if(oCursor.selectedActor == id && oCursor.hoverNode != noone){
	if(oCursor.hoverNode != noone){
		tempNode = oCursor.hoverNode;		
		if(tempNode.moveNode){
			current = tempNode;
			//step through all nodes in parent to parent to reach actor node
			while(current.parent != noone){
				draw_line_width_color(current.x+32, current.y + 32,current.parent.x+32,current.parent.y+32, 4, c_lime,c_lime);
				current = current.parent;	
			}
		}
		if(tempNode.attackNode){
			switch(attackType){
				case "ranged":
					draw_line_width_color(x+32, y+32, tempNode.x+32, tempNode.y+32,4,c_purple,c_purple);
					break;
					
				case "melee":
					tempX = abs(tempNode.gridX - gridX);
					tempY = abs(tempNode.gridY - gridY);
					if( tempX <= 1 && tempY <=1){
						draw_line_width_color(x+32, y+32, tempNode.x+32, tempNode.y+32,4,c_purple,c_purple);
					}
					else{
						current = noone
						tempG = 100;
						for(ii = 0; ii < ds_list_size(tempNode.neighbors); ii +=1){
							neighbor = ds_list_find_value(tempNode.neighbors,ii);
							if(neighbor.occupant == noone && neighbor.G > 0 && neighbor.G < tempG){
								tempG = neighbor.G;
								current = neighbor;
							}
						}
						
						draw_line_width_color(tempNode.x +32, tempNode.y + 32, current.x+32, current.y+32, 4,c_purple,c_purple);
						while(current.parent != noone){
							draw_line_width_color(current.x+32, current.y + 32,current.parent.x+32,current.parent.y+32, 4, c_purple,c_purple);
							current = current.parent;
						}
					}
					break;
			}
		}
	}
}
if(shake >0){
	draw_sprite_ext(sprite_index,-1, x+ irandom_range(-shakeMag,shakeMag), y+irandom_range(-shakeMag,shakeMag),1,1,0,c_white,1);
}
else{
draw_self();
}