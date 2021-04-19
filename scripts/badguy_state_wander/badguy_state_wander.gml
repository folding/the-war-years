//wander behavior
function badguy_state_ready_wander(){
counter = counter + 1;

var yCollision = false;
var xCollision = false;

//just don't move if you are stuck on a wall
if (place_meeting(x + moveX, y, oWall)) {
    while (!place_meeting(x + sign(moveX), y, oWall)and(abs(moveX) > 1)) {
        x = x + sign(moveX);
    }
	xCollision = true;
    moveX = 0;
}

if (place_meeting(x, y + moveY, oWall)) {
    while (!place_meeting(x, y + sign(moveY), oWall)and(abs(moveY) > 1)) {
        y = y + sign(moveY);
    }
	yCollision = true;
    moveY = 0;
}
	
worldX = worldX + moveX;
worldY = worldY + moveY;

x = floor(worldX);
y = floor(worldY);

direction = point_direction(x, y, oPlayer.x, oPlayer.y);
	
var next_angle = point_direction(x,y,x+moveX,y+moveY);

if((moveY!= 0 or moveX!= 0) or yCollision && xCollision){
	image_angle = next_angle;
}

if (counter >= room_speed * 3) {
    var change = choose(0, 1);
    switch (change) {
    case 0:
        state = states.idle;
    case 1:
        my_dir = irandom_range(0, 359);
        moveX = lengthdir_x(spd, my_dir);
        moveY = lengthdir_y(spd, my_dir);
        counter = 0;
    }
}

//transition triggers
if (collision_circle(x, y, 200, oPlayer, false, false)) {
    //if we are less than 200 away from player go to alert state
    state = states.alert;
}

//set sprites
//sprite_index = sbadguy;
//mirror the sprite when it is moving in the negative direction

//var next_xscale = sign(moveX);

//if(next_xscale != 0)
//image_xscale = next_xscale;
}