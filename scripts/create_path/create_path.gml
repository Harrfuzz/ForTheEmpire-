//arg0 - actor cretaing path for
//arg1 - destination node 

current = argument1;
selectedActor = argument0;

path = ds_priority_create();
ds_priority_add(path,current,current.G);
while(current.parent != noone){
	ds_priority_add(path,current.parent,current.parent.G);		//add parent to PQ p equal to parent G
	current = current.parent;		//set current = to its parent and move back to actor
}
		
do{
	//delete lowes tP node
	current = ds_priority_delete_min(path);
	path_add_point(selectedActor.movementPath,current.x,current.y,100);
}until(ds_priority_empty(path));
		
	//clean up PQ
ds_priority_destroy(path);