/// @description Insert description here
// You can write your code in this editor
event_inherited(); //inherit parent object vars
name = "Mobius SY";
class = "Archers";		//weapion type
race = "Human"	;		//unit type eventually
level = 1;
profMod = 2 + floor(level/5);

//base
strMod =0;	//attack damage
dexMod =3;	//speed/ ellusivness
conMod =2;	//toughness/defense
intMod =1;	//smartness/status resist
wizMod =0;	//perception/resist mag

//health
maxHitPoints = 6 + conMod + ((level - 1) * (4 + conMod));		//total hp
hitPoints = maxHitPoints;			//current hp

//attack
hitBonus = profMod + dexMod;
attackType = "ranged";
attackRange = 15 * GRID_SIZE;

//move and act
move = 4;
actions =2;
//special
sneakAttack = true;
sneakAttackDamage = 6;

//init
initiative = dexMod;
initRoll = 0;