/// @description Insert description here
// You can write your code in this editor
state = "idle";

army = BLUE_ARMY;


gridX=0;
gridY=0;
name = "error";

//character stats
class = "Peasant";		//weapion type
race = "Human";			//unit type eventually
level = 1;
profMod = 2 + floor(level/5);

//base stats
strMod =2;	//attack damage
dexMod =1;	//speed/ ellusivness
conMod =0;	//toughness/defense
intMod =0;	//smartness/status resist
wizMod =0;	//perception/resist mag

maxHitPoints = 4 + conMod + ((level - 1) * (3 + conMod));		//total hp
hitPoints = maxHitPoints;			//current hp

//attack vars
hitBonus = profMod + strMod;
attackType = "melee";
attackTarget = noone;
actionTimer = 0;

//damage Vars
damageDice = 4;
damageBonus = strMod;
damageType = "Piercing";

//defense Vars
armorClass = 10 + dexMod;

//move and action vars
move = 4;
actions =2;
canAct = false;

initiative = dexMod;
initRoll = 0;

//button vars
defaultActions = ds_list_create();
ds_list_add(defaultActions, "end turn");

//special vars
charge = false;
sneakAttack = false;
readiedAction = "error";
targetingType ="error";
actionRange =0;

spellHitBonus = 0;
spellSaveDC = 0;

firstLevelSlotMax=0;
firstLevelSlot=0;


//pathing vars--------------------------------------
movementPath = path_add();		//create a move path data structure
path_set_kind(movementPath, 2);		//2 path types 2: rigid path. 1 rounded path
path_set_closed(movementPath,false);
moveSpeed = 8;
endPath = "idle";			//state for end of movement

// buff/debuff vars-------------------------------
//bufff--------------
blessed = 0;

//debuff-------------
acidBurn = 0;
guidingBolt = false;

//FX vars
shake = 0;
shakeMag = 0;
