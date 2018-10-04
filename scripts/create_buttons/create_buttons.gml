//arg0 = actor buttons to create

actor = argument0;
buttonList = ds_list_create();
if(actor.canAct){
	if(actor.firstLevelSlot >0){
		for(ii = 0; ii < ds_list_size(actor.firstLevelSpellList); ii +=1){
			ds_list_add(buttonList, ds_list_find_value(actor.firstLevelSpellList,ii));
		}
	}
}
for(ii = 0; ii < ds_list_size(actor.defaultActions);ii+=1){
	ds_list_add(buttonList, ds_list_find_value(actor.defaultActions,ii));
}
buttonY = room_height - 48;
buttonX = room_width/2 - ((ds_list_size(buttonList) -1) * 48);
for(ii =0; ii < ds_list_size(buttonList);ii+=1){
	button = ds_list_find_value(buttonList,ii);
	switch(button){
		case "end turn":
			with(instance_create_depth(buttonX + (ii *96), buttonY, -5, oButton)){
				sprite_index = sButtonEndTurn;
				title = "END TURN";
				text = "Finish turn of current unit";
				hotKey = "X";
			}
			break;
			
		//cleric spells---------------------------------
		case "Bless":
			with(instance_create_depth(buttonX + (ii * 96), buttonY, -5, oButton)){
				
				sprite_index = sButtonBless;
				title = "BLESS";
				text = "Give all party members a small bonus to attack and save rolls \n1d4 bonus (5 rounds)";
				hotKey = string(other.ii + 1);
				spell = true;
				spellSlot = string(other.actor.firstLevelSlot);
			}
			break;
		
		case "Healing Word":
			with(instance_create_depth(buttonX + (ii * 96), buttonY, -5, oButton)){
				
				sprite_index = sButtonHealingWord;
				title = "HEALING WORD";
				text = "Right click an ally in range to heal them\n1d8 + " + string(other.actor.wizMod) + " HEALING";
				hotKey = string(other.ii + 1);
				spell = true;
				spellSlot = string(other.actor.firstLevelSlot);
			}
			break;
		
		case "Guiding Bolt":
			with(instance_create_depth(buttonX + (ii * 96), buttonY, -5, oButton)){
				
				sprite_index = sButtonGudingBolt;
				title = "GUIDING BOLT";
				text = "Right click an enemy to fire an illuminating bolt!\n4d6 RADIANT damage# Bonus on next attack against target!";
				hotKey = string(other.ii + 1);
				spell = true;
				spellSlot = string(other.actor.firstLevelSlot);
			}
			break;
			
		//Spell-Bow spells---------------------------------
		
		case "Acid Orb":
			with(instance_create_depth(buttonX + (ii * 96), buttonY, -5, oButton)){
				
				sprite_index = sButtonAcidOrb;
				title = "ACID ORB";
				text = "Right click an enemy to fire an orb of deadly acid!\n3d10 ACID damage\n Ongoing Burn";
				hotKey = string(other.ii + 1);
				spell = true;
				spellSlot = string(other.actor.firstLevelSlot);
			}
			break;
			
		case "Burning Hands":
			with(instance_create_depth(buttonX + (ii * 96), buttonY, -5, oButton)){
				
				sprite_index = sButtonFlameCone
				title = "BURNING HANDS";
				text = "Right click a square in range to emit a cone of flames. \n3d6 FIRE damage (AoE)";
				hotKey = string(other.ii + 1);
				spell = true;
				spellSlot = string(other.actor.firstLevelSlot);
			}
			break;
			
		case "Magic Missiles":		//button for magic missile creation
			with(instance_create_depth(buttonX + (ii * 96), buttonY, -5, oButton)){
				
				sprite_index = sButtonMagicMissile;
				title = "MAGIC MISSILES";
				text = "Fire a magic missile at each visible enemy\n1d4+1 FORCE damage#cannot miss";
				hotKey = string(other.ii + 1);
				spell = true;
				spellSlot = string(other.actor.firstLevelSlot);
			}
			break;
	}
}
ds_list_destroy(buttonList);