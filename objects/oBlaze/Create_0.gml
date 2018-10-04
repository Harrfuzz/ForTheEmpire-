/// @description Insert description here
// You can write your code in this editor
event_inherited(); //inherit parent object vars
name = "Blaze";				//Sonny
class = "Spell-Bows";		//weapion type
race = "Magi";			//unit type eventually
level = 1;
profMod = 2 + floor(level/5);
//base stats
strMod =0;	//attack damage
dexMod =1;	//speed/ ellusivness
conMod =2;	//toughness/defense
intMod =3;	//smartness/status resist
wizMod =0;	//perception/resist mag

//health
maxHitPoints = 6 + conMod + ((level - 1) * (4 + conMod));		//total hp
hitPoints = maxHitPoints;			//current hp

//attack
hitBonus = profMod + intMod;
attackType = "ranged";
attackRange = 15 * GRID_SIZE;

damageDice = 10;
damageBonus = 0;
damageType = "fire";

//spell and aciton var
spellHitBonus = profMod + intMod;
spellSaveDC = 8 +profMod + intMod;
firstLevelSlotMax=2;
firstLevelSlot=2;
firstLevelSpellList= ds_list_create();
fill_spell_list(id, level, class);
//defense var
armorClass = 10 + dexMod;

//move and action
move = 4;
actions =2;

//initiative vars
initiative = dexMod;
initRoll = 0;