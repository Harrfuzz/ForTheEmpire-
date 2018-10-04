/// @description Insert description here
// You can write your code in this editor
draw_self();

if(hoverButton != noone && buttonTimer >= 15){
	tempTitle = hoverButton.title;
	tempText = hoverButton.text;
	
	draw_set_font(fCrit);
	heightY = string_height(tempTitle) + string_height(tempText);
	draw_set_color(c_black);
	draw_rectangle(x + 20 ,y - heightY,x+20 + string_width(tempTitle), y - heightY + string_height(tempTitle),false);
		
	draw_set_color(c_white);
	draw_text(x +20, y - heightY, tempTitle);

	draw_set_font(fDefault);
	draw_set_color(c_black);
	draw_rectangle(x+20, y - string_height(tempText), x + 20 + string_width(tempText), y, false);
	
	draw_set_color(c_white);
	draw_text(x +20, y - string_height(tempText), tempText);
}

if(hoverNode != noone){
		tempText = string(gridX) + " / " + string(gridY) + " = ";
		if(hoverNode.occupant != noone){
			tempText += hoverNode.occupant.name + " " + hoverNode.occupant.race + " " + hoverNode.occupant.class;
		}
		else{
			tempText += "no one";
		}
		
		draw_set_color(c_black);
		draw_rectangle(0,0,string_width(tempText), string_height(tempText),false);
		
		draw_set_color(c_white);
		draw_text(0,0,tempText);
		
		tempText=hoverNode.type;
		if(hoverNode.passable){
			tempText += " passable = true " + "cost = " + string(hoverNode.cost);
		}
		draw_set_color(c_black);
		draw_rectangle(0,20,string_width(tempText),20 + string_height(tempText),false);
		
		draw_set_color(c_white);
		draw_text(0,20,tempText);
				
}

if(selectedActor != noone){
	tempText = selectedActor.name + " the "+ selectedActor.race + " " + selectedActor.class;
	tempHitPoints = "HP: " + string(selectedActor.hitPoints) + " / " + string(selectedActor.maxHitPoints);
	tempHitBonus = "Hit bonus : " + string(selectedActor.hitBonus);
	draw_set_color(c_black);
	draw_rectangle(0,room_height,string_width(tempHitBonus), room_height - string_height(tempHitBonus),false);
	draw_rectangle(0,room_height - 16,string_width(tempHitPoints), room_height - 16 - string_height(tempHitPoints),false);
	draw_rectangle(0,room_height - 32,string_width(tempText), room_height - 32 - string_height(tempText),false);
		
	draw_set_color(c_white);
	draw_text(0,room_height - string_height(tempHitBonus),tempHitBonus);
	draw_text(0,room_height - 16  - string_height(tempHitPoints),tempHitPoints);
	draw_text(0,room_height - 32 - string_height(tempText),tempText);
}