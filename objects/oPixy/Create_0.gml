/// @description Insert description here
// You can write your code in this editor
event_inherited(); //inherit parent object vars
name = "Pixy";
class = "Clerics";		//weapion type
race = "Human";		//unit type eventually
level = 1;

//base stats
profMod = 2 + floor(level/5);
strMod =2;	//attack damage
dexMod =0;	//speed/ ellusivness
conMod =1;	//toughness/defense
intMod =0;	//smartness/status resist
wizMod =3;	//perception/resist mag

//health stats
maxHitPoints = 8 + conMod + ((level - 1) * (5 + conMod));		//total hp
hitPoints = maxHitPoints;			//current hp

//attack vars
hitBonus = profMod + strMod;

//damage vars
damageDice = 8;
damageBonus = strMod;
damageType = "blunt";

spellHitBonus = profMod + wizMod;
spellSaveDC = 8 + profMod + wizMod;
firstLevelSlotMax=2;
firstLevelSlot=2;
firstLevelSpellList = ds_list_create();
fill_spell_list(id, level, class);
//defense vars
armorClass = 16;

move = 4;
actions =2;

// init vars
initiative = dexMod;
initRoll = 0;