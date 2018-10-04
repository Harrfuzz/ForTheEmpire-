//arg0- Actor to dill
//arg1- level of caster
//arg2- classs of actor

actor = argument0;
level = argument1;
class = argument2;

for(ii = 1; ii<= level; ii+=1){
	switch(class){
		case "Clerics":
			switch(ii){
				case 1:
					ds_list_add(actor.firstLevelSpellList, "Bless");
					ds_list_add(actor.firstLevelSpellList, "Guiding Bolt");
					ds_list_add(actor.firstLevelSpellList, "Healing Word");
					break;
			}
			break;
			
		case "Spell-Bows":
			switch(ii){
					case 1:
						ds_list_add(actor.firstLevelSpellList, "Acid Orb");
						ds_list_add(actor.firstLevelSpellList, "Burning Hands");
						ds_list_add(actor.firstLevelSpellList, "Magic Missiles");
						break;
				}
			break;
	}
}