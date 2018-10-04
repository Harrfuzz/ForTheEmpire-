/// @description Insert description here
// You can write your code in this editor
shake -=1;
if(hitPoints <= 0){
	map[gridX,gridY].occupant = noone;
	if(oGame.currentActor == id){
		oGame.currentActor = noone;
		oCursor.selectedActor = noone;
	}
	with(instance_create_depth(x,y, 0, oDying)){
		sprite_index = other.sprite_index;
	}
	instance_destroy();
}
switch(state){
	case "initialize turn":
	if(army == RED_ARMY){
		state = "find target";
	}
	else{
		state = "ready";
	}
		break;
		
	case "find target":
		attackTarget = noone;
		node = map[gridX,gridY];
		
		targetList = ds_list_create();
		for(ii = 0; ii < ds_list_size(node.neighbors);ii ++){
			neighbor = ds_list_find_value(node.neighbors,ii);
				
			if(neighbor.occupant != noone){
				if(neighbor.occupant.army == BLUE_ARMY){
					ds_list_add(targetList,neighbor.occupant);
				}
			}
		}
		if(ds_list_size(targetList) > 0){
			roll = irandom_range(1,20);
			if(roll + intMod >10){
				healthRatio = 1;
				for(ii = 0; ii < ds_list_size(targetList);ii ++){
					tempTarget = ds_list_find_value(targetList,ii);
					if(tempTarget.hitPoints/tempTarget.maxHitPoints < healthRatio){
						attackTarget = tempTarget;
						healthRatio = tempTarget.hitPoints/tempTarget.maxHitPoints;
					}
				}
			}
			if(attackTarget == noone){
				attackTarget = ds_list_find_value(targetList, irandom_range(0,ds_list_size(targetList)-1));
			}
		}
		ds_list_destroy(targetList);
		if(attackTarget != noone){
			state = "begin attack";
			actionTimer = 10;
		}
		else{
			state = "find move node";
		}
		break;
		
		case "find move node":
			heroList = ds_priority_create();
			with(oActor){
				if(army == BLUE_ARMY){
					ds_priority_add(other.heroList,id,point_distance(x,y,other.x,other.y));
				}
			}
			closestNode = noone;
			while(closestNode == noone){
				targetHero = ds_priority_delete_min(heroList);
				targetNode = map[targetHero.gridX, targetHero.gridY];
				for(ii = 0; ii < ds_list_size(targetNode.neighbors); ii +=1){
					currentNode = ds_list_find_value(targetNode.neighbors,ii);
					if(currentNode.occupant == noone && currentNode.passable){
						closestNode = currentNode;
					}
				}
				
				if(ds_priority_size(heroList) <=0){
					targetHero = noone;
					flash = true;
					alarm[0] = 30;
					state = "idle";
					break;
				}
			}
			ds_priority_destroy(heroList);
			
			if(actions == 0){
				state = "idle"
				oGame.currentActor = noone;
			}
			if(targetHero != noone){
				
				ai_movement(map[gridX,gridY], closestNode);
				while(closestNode.G > move*actions){
					closestNode = closestNode.parent;
				}
				create_path(id, closestNode);
				map[gridX,gridY].occupant = noone;
				gridX= closestNode.gridX;
				gridY = closestNode.gridY;
				closestNode.occupant = id;
				state = "begin path";
				if(closestNode.G >move){
					actions -=2;
				}
				else{
					actions -=1;
				}
			}
			wipe_nodes();			
			break;
		
	case "begin path":
		path_start(movementPath, moveSpeed, 0 , true);
		state = "moving";
		break;
		
	case "begin attack":
		actionTimer -= 1;
		if(actionTimer <= 0){
			state = "attack";
		}
		break;
		
		
	case "attack":
		//make attack
		attackRoll = irandom_range(1,20);
		
		applySneakAttack = false;
		if(sneakAttack){
			tempNode = map[attackTarget.gridX,attackTarget.gridY];
			for(ii = 0; ii < ds_list_size(tempNode.neighbors); ii +=1){
				current = ds_list_find_value(tempNode.neighbors, ii);
				if(current.occupant != noone){
					if(current.occupant.army != attackTarget.army){
						applySneakAttack = true;
					}
				}
			}
		}
		//determine outcome
		if(attackRoll==20){
			attackStatus ="crit";
		}
		else{
			if(attackRoll + hitBonus >= attackTarget.armorClass){
				attackStatus = "hit";
			}
			else{
				attackStatus = "miss";
			}
		}
		tempDamage = 0;
		if(attackStatus != "miss"){
			tempDamage = irandom_range(1, damageDice) + damageBonus;
			if(applySneakAttack){
				tempDamage += irandom_range(1,sneakAttackDamage);
			}
			if(attackStatus = "crit"){
				tempDamage += irandom_range(1, damageDice) + damageBonus;
				if(applySneakAttack){
				tempDamage += irandom_range(1,sneakAttackDamage);
				}
			}
		}
		switch(attackType){			
			case"ranged":			
				//path for attack to follow
				attackDir = point_direction(x+32,y+32, attackTarget.x+32, attackTarget.y+32);
				beginX = x+32 + lengthdir_x(60, attackDir);
				beginY = y+32 + lengthdir_y(60, attackDir);
				with(instance_create_depth(beginX, beginY, -3, oArrow)){
					target = other.attackTarget;
					status = other.attackStatus;
					damage = other.tempDamage;
					damageType = other.damageType;
					
					path_add_point(movementPath, other.beginX, other.beginY, 100);
					if(status != "miss"){
						path_add_point(movementPath, target.x +32, target.y+32,100);
					}
					else{
						path_add_point(movementPath, target.x + (irandom_range(30,50) * choose(-1,1)), target.y + (irandom_range(30,50) * choose(-1,1)),100);
					}
					
					path_start(movementPath, speed, true, true);
				}
				state = "end attack";
				actionTimer = 30;
				break;
			
			case "melee":
				if(attackStatus != "miss"){
					for(ii = 0; ii < 6;ii +=1){
						with(instance_create_depth(attackTarget.x+32, attackTarget.y+32, -3,oBiff)){
							direction = irandom(360);
							speed = choose(2,4);
							scale = choose(2,3);
							image_speed = 0.5;
							
							if(other.attackStatus == "crit"){
								color = c_yellow;
							}
						}
					}
					if(attackStatus == "crit"){
						attackTarget.shake=8;
						attackTarget.shakeMag = 8;
					}
					else{
						attackTarget.shake=4;
						attackTarget.shakeMag = 4;
					}
					attackTarget.hitPoints -= tempDamage;
					with(instance_create_depth(attackTarget.x+56, attackTarget.y+4,-3,oDamageText)){
						text = "-" + string(other.tempDamage);
						ground = y;
						if(other.attackStatus == "crit"){
							font = fCrit;
						}
					}
				}
				else{
					with(instance_create_depth(attackTarget.x+56, attackTarget.y+4,-3,oDamageText)){
						text = "Miss";
						ground = y;
					}
				}
				state = "end attack";
				actionTimer = 10;
				break;
		
		}
		break;
		
		
	case "end attack":
		actionTimer -=1;
		if(actionTimer <= 0){
			oGame.currentActor = noone;
			state = "idle";
		}
		break;
	
		
}