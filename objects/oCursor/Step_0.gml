/// @description Insert description here
// You can write your code in this editor
x = mouse_x;
y = mouse_y;

gridX = floor(x/GRID_SIZE);
gridY = floor(y/GRID_SIZE);

if(gridX<0 || gridY<0 || gridX >= room_width/GRID_SIZE || gridY >= room_height/GRID_SIZE){
	hoverNode= noone;	
}
else{
	hoverNode = map[gridX, gridY];	
}
with(oConfirmButton){
	if(keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord(hotKey))){
		other.selectedActor.state = "perform action";
		instance_destroy();
	}
}
if(instance_place(x,y,oButton)){
	if(instance_place(x,y,oButton) == hoverButton){
		buttonTimer += 1;
	}
	else{
		buttonTimer =0;
	}
	hoverButton = instance_place(x,y,oButton);
	hoverNode = noone;
}
else{
	hoverButton = noone;
	buttonTimer = 0;
}

with(oButton){
	if(keyboard_check_pressed(ord(hotKey))){
		perform_buttons(oCursor.selectedActor,id);
	}
}

if(keyboard_check_pressed(vk_escape) && selectedActor != noone){
	if(selectedActor.state == "begin action"){
		selectedActor.state = "idle";
		with(oConfirmButton){
			instance_destroy();
		}
		with(oConfirmBox){
			instance_destroy();
		}
	}
	wipe_buttons();
	wipe_nodes();
	movement_range(map[selectedActor.gridX, selectedActor.gridY], selectedActor.move, selectedActor.actions);
	
	if(selectedActor.canAct){
		switch(selectedActor.attackType){
			case "ranged":
				ranged_attack_range(selectedActor);
				break;
			
			case "melee":
				melee_attack_range(selectedActor);
				break;
		}
	}
}

if(mouse_check_button_pressed(mb_left)){
	if(selectedActor != noone && hoverButton != noone){
		perform_buttons(selectedActor, hoverButton);
	}
	if(instance_place(x,y, oConfirmButton)){
		selectedActor.state = "perform action";
		with(oConfirmButton){
			instance_destroy();
		}
	}
	if(instance_place(x,y,oEndBox)){
		with(oFadeLose){
			finalize = true;
		}
		with(oEndBox){
			instance_destroy();
		}
	}
}

if(mouse_check_button_pressed(mb_right)){
	if(selectedActor != noone && hoverNode!= noone && hoverNode.moveNode){
		current = hoverNode;
		create_path(selectedActor,current);
		//reset Actor position info to new node
		map[selectedActor.gridX, selectedActor.gridY].occupant = noone;
		selectedActor.gridX = gridX;
		selectedActor.gridY = gridY;
		hoverNode.occupant = selectedActor;
		
		selectedActor.state = "begin path";
		selectedActor.endPath = "ready";
		//reduce sA action and wipe nodes
		if(hoverNode.G > selectedActor.move){
			selectedActor.actions -= 2;
			wipe_nodes();
			wipe_buttons();
		}
		else{
		selectedActor.actions -=1;
		wipe_nodes();
		wipe_buttons();
		}
		
		selectedActor=noone;
	}
	
	if(selectedActor!= noone && hoverNode!= noone && hoverNode.attackNode){
		switch(selectedActor.attackType){
			case "ranged":
				selectedActor.canAct = false;
				selectedActor.actions -=1;
				selectedActor.attackTarget = hoverNode.occupant;
				selectedActor.state = "begin attack";
				selectedActor.actionTimer = 10;
				selectedActor = noone;
				wipe_nodes();
				wipe_buttons();
				break;
				
			case "melee":
				selectedActor.canAct = false;
				selectedActor.attackTarget = hoverNode.occupant;
				
				tempX = abs(hoverNode.gridX - selectedActor.gridX);
				tempY = abs(hoverNode.gridY - selectedActor.gridY);
				
				if(tempX <=1 && tempY <=1){
					selectedActor.actions -=1;
					selectedActor.state = "begin attack";
					selectedActor.actionTimer = 10;
					selectedActor = noone;
					wipe_nodes();
					wipe_buttons();
				}
				else{
					tempG = 100;
					current = noone;
					
					for(ii = 0; ii < ds_list_size(hoverNode.neighbors); ii +=1){
						tempNode = ds_list_find_value(hoverNode.neighbors, ii);
						if(tempNode.occupant == noone && tempNode.G > 0 && tempNode.G < tempG){
							tempG = tempNode.G;
							current = tempNode;
						}
					}
					targetNode = current;
					create_path(selectedActor, targetNode);
					map[selectedActor.gridX, selectedActor.gridY].occupant = noone;
					selectedActor.gridX = targetNode.gridX;
					selectedActor.gridY = targetNode.gridY;
					targetNode.occupant = selectedActor;
					selectedActor.state = "begin path";
					selectedActor.endPath = "begin attack";		
					selectedActor.attackTarget = hoverNode.occupant;
					selectedActor.actions -=2;
					selectedActor.canAct = false;
					selectedActor = noone;
					wipe_nodes();
					wipe_buttons();
				}
				
				break;
		}
	}		//attack block end
	
	if(hoverNode != noone && hoverNode.actionNode){
		selectedActor.state = "perform action";
		with(oConfirmButton){
			instance_destroy();
		}
		with(oConfirmBox){
			instance_destroy();
		}	
	}
}