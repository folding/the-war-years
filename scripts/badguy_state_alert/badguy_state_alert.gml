//alert behavior
function badguy_state_alert(){
//point towards player
my_dir = point_direction(x, y, oPlayer.x, oPlayer.y);
//calculate move towards player 1
moveX = lengthdir_x(spd, my_dir);
moveY = lengthdir_y(spd, my_dir);

var yCollision = false;
var xCollision = false;

//just don't move if you are stuck on a wall
if (place_meeting(x + moveX, y, oWall)) {
    while (!place_meeting(x + sign(moveX), y, oWall)and(moveX > 1 or moveX < 1)) {
        x = x + sign(moveX);
    }
	xCollision = true;
    moveX = 0;
}

if (place_meeting(x, y + moveY, oWall)) {
    while (!place_meeting(x, y + sign(moveY), oWall)and(moveY > 1 or moveY < 1)) {
        y = y + sign(moveY);
    }
	yCollision = true;
    moveY = 0;
}

if (moveX == 0 and moveY == 0) {
    //we're stuck on a wall.. goto wander state
    state = states.wander;
}
	//transition triggers
else if(!collision_circle(x,y,200,oPlayer,false,false))
{
	//if we are beyond 200 away from player go to idle state
	state = states.idle;
}
else if(collision_circle(x,y,100,oPlayer,false,false))
{
	//if we are less than 100 away, then ATTACK!
	state = states.ready_attack;
}

worldX = worldX + moveX;
worldY = worldY + moveY;

x = floor(worldX);
y = floor(worldY)

direction = point_direction(x, y, x + moveX, y + moveY);

var next_angle = point_direction(x,y,x+moveX,y+moveY);
if((moveY!= 0 or moveX!= 0) or yCollision && xCollision){
	image_angle = next_angle;
}

//set sprites
//sprite_index = sbadguy;

//var next_xscale = sign(moveX);

//if(next_xscale != 0)
//image_xscale = next_xscale;
}