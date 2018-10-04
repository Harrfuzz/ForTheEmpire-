//arg0 - actor acting
//arg1 - action to perform
actor = argument0;
action = argument1;

switch(action){

	//default actions
	case "END TURN":
		actor.state = "end turn";
		actor.actionTimer = 20;
		break;
		
	//cleric spells-------------------------------------------------------------
	case "Bless":
		targets = ds_list_create();
		with(oNode){
			if(actionNode){
				ds_list_add(other.targets, id);
			}
		}
		for(ii = 0; ii <ds_list_size(targets); ii +=1){
			target = ds_list_find_value(targets, ii).occupant;
			target.blessed = oGame.roundCounter + 5;
			with(instance_create_depth(target.x,target.y,-2,oBless)){
				target = other.target;
			}
		}
		ds_list_destroy(targets);
		actor.firstLevelSlot -=1;
		actor.canAct = false;
		actor.actions -=1;
		actor.state = "end action";
		actor.actionTimer = 15;
		break;
		
	case "Healing Word":
		target = oCursor.hoverNode.occupant;
		heal = irandom_range(1,8) + actor.wizMod;
		heal = min(heal, target.maxHitPoints - target.hitPoints);
		target.hitPoints += heal;
		with(instance_create_depth(target.x + 56, target.y + 8, -3,oDamageText)){
			ground = y;
			text = "+" + string(other.heal);
			color = c_blue;
		}
		actor.firstLevelSlot -=1;
		actor.canAct = false;
		actor.actions -=1;
		actor.state = "end action";
		actor.actionTimer = 15;
		break;
		
	case "Guiding Bolt":
		target = oCursor.hoverNode.occupant;
		attackRoll = irandom_range(1,20);
		attackStatus = attack_roll(actor, target);
		damageType = "radiant";
		tempDamage=0;
		for(ii = 0; ii <4; ii+=1){
			tempDamage += irandom_range(1,6);
		}
		attackDir = point_direction(actor.x+32, actor.y+32, target.x+32, target.y+32);
		with(instance_create_depth(actor.x+32, actor.y+32, -2, oGuidingBolt)){
			target = other.target;
			status = other.attackStatus;
			damage = other.tempDamage;
			path_add_point(movementPath, other.actor.x+32, other.actor.y+32, 100);
			if(status != "miss"){
				path_add_point(movementPath, target.x+32, target.y+32,100);
			}
			else{
				path_add_point(movementPath, target.x+32 + (irandom_range(30,50) * choose(-1,1)),target.y+32+ (irandom_range(30,50) * choose(-1,1)),100);
			}
			path_start(movementPath, speed, true, true);
		}
		actor.firstLevelSlot -=1;
		actor.canAct = false;
		actor.actions -=1;
		actor.state = "end action";
		actor.actionTimer = 30;
		break;
		
	//Spell-Bow spells------------------------------------------------
	case "Acid Orb":
		target = oCursor.hoverNode.occupant;
		attackRoll = irandom_range(1,20);
		attackStatus = attack_roll(actor, target);
		damageType = "acid";
		tempDamage=0;
		for(ii = 0; ii <3; ii+=1){
			tempDamage += irandom_range(1,10);
		}
		attackDir = point_direction(actor.x+32, actor.y+32, target.x+32, target.y+32);
		with(instance_create_depth(actor.x+32, actor.y+32, -2, oAcidOrb)){
			target = other.target;
			status = other.attackStatus;
			damage = other.tempDamage;
			path_add_point(movementPath, other.actor.x+32, other.actor.y+32, 100);
			if(status != "miss"){
				path_add_point(movementPath, target.x+32, target.y+32,100);
			}
			else{
				path_add_point(movementPath, target.x+32 + (irandom_range(30,50) * choose(-1,1)),target.y+32+ (irandom_range(30,50) * choose(-1,1)),100);
			}
			path_start(movementPath, speed, true, true);
		}
		actor.firstLevelSlot -=1;
		actor.canAct = false;
		actor.actions -=1;
		actor.state = "end action";
		actor.actionTimer = 30;
		break;
		
	case "Burning Hands":
		targets = ds_list_create();
		damage = 0;
		for(ii = 0; ii <3; ii+=1){
			damage += irandom_range(1,6);
		}
		with(oNode){
			if(actionNode){
				ds_list_add(other.targets, id);
			}
		}
		for(ii = 0; ii < ds_list_size(targets); ii +=1){
			node = ds_list_find_value(targets, ii);
			with(instance_create_depth(node.x +32, node.y+32, -2, oFlameEmitter)){
				target = other.node.occupant;
				saveDC = other.actor.spellSaveDC;
				damage = other.damage;
			}
		}
		ds_list_destroy(targets);
		actor.firstLevelSlot -=1;
		actor.canAct = false;
		actor.actions -=1;
		actor.state = "end action";
		actor.actionTimer = 30;
		break;
		
	case "Magic Missiles":
		targets = ds_list_create();
		with(oNode){
			if(actionNode){
				ds_list_add(other.targets, id);
			}
		}
		
		for(ii =0; ii < ds_list_size(targets);ii +=1){
			target = ds_list_find_value(targets, ii).occupant;
			with(instance_create_depth(actor.x + 32, actor.y + 32, -2 ,oArrow)){
				target = other.target;
				status = "hit";
				damage = irandom_range(1,4) + 1;
				damageType = "force";
				path_add_point(movementPath,other.actor.x + 32, other.actor.y + 32, 100);
				path_add_point(movementPath,other.target.x + 32, other.target.y + 32, 100);
				path_start(movementPath, speed, true, true);
			}
		}
		ds_list_destroy(targets);
		actor.firstLevelSlot -=1;
		actor.canAct = false;
		actor.actions -=1;
		actor.state = "end action";
		actor.actionTimer = 30;
		break;
}