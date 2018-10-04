//find manhattan diistance between two pointd
//arg0 - goal node
//arg 1 - current node
goal = argument0;
node = argument1;

temp = abs(goal.gridX - node.gridX) + abs(goal.gridY - node.gridY);
return(temp);