/// @description Insert description here
// You can write your code in this editor
event_inherited();
name = "Cipher DY";
class = "Cavalry";		//weapion type
race = "Human"	;		//unit type eventually
level = 1;
profMod = 2 + floor(level/5);
strMod =3;	//attack damage
dexMod =0;	//speed/ ellusivness
conMod =2;	//toughness/defense
intMod =0;	//smartness/status resist
wizMod =1;	//perception/resist mag

maxHitPoints = 10 + conMod + ((level - 1) * (6 + conMod));		//total hp
hitPoints = maxHitPoints;			//current hp
hitBonus = profMod + strMod;

//damage
damageDice =8;
damageBonus = strMod;
damageType = "slashing";

//defense var
armorClass = 16;

move = 5;
actions =2;

charge = true;

initiative = dexMod;
initRoll = 0;