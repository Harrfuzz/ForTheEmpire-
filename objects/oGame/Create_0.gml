/// @description Insert description here
// You can write your code in this editor
state = "initializing";

instance_create_depth(x,y,-4,oFadein);

draw_set_font(fDefault);
randomize();		//seed grabber for randomization
turnOrder = ds_list_create();
turnCounter = -1;
turnMax = 0;
currentActor = noone;
roundCounter = 0;


globalvar map;

mapWidth = room_width/GRID_SIZE;
mapHeight = room_height/GRID_SIZE;

//create nodes
for(xx=0;xx<mapWidth; xx+=1){
	for(yy=0;yy<mapHeight;yy+=1){
		map[xx,yy] = instance_create_depth(xx*GRID_SIZE, yy*GRID_SIZE,1,oNode);
		map[xx,yy].gridX=xx;
		map[xx,yy].gridY=yy;
	}
}

//populate neighbor lists
for(xx=0;xx<mapWidth; xx++){
	for(yy=0;yy<mapHeight;yy++){
		node = map[xx,yy];
		
		if(xx>0){							//add left neighbor
			ds_list_add(node.neighbors, map[xx-1,yy]);
		}
		if(xx<mapWidth -1){					//add right neighbor
			ds_list_add(node.neighbors, map[xx+1,yy]);
		}
		if(yy>0){							//add top
			ds_list_add(node.neighbors, map[xx, yy -1]);
		}
		if(yy < mapHeight -1){				// add bottom
			ds_list_add(node.neighbors, map[xx,yy + 1]);	
		}
		if(xx>0 && yy >0){					//add top left
			ds_list_add(node.neighbors, map[xx-1,yy-1]);
		}									//add top right
		if(xx < mapWidth-1 && yy >0){
			ds_list_add(node.neighbors, map[xx+1,yy-1]);
		}	
		if(xx > 0 && yy < mapHeight -1){	//add bottom left
			ds_list_add(node.neighbors, map[xx-1, yy+1]);
		}
		if(xx < mapWidth-1 && yy < mapHeight-1){	//add bottom right
			ds_list_add(node.neighbors, map[xx+1,yy+1]);
		}
	}
}

instance_create_depth(x,y,-10,oCursor);

