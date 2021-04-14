/// @description Insert description here
// You can write your code in this editor


if (place_meeting(x, y, oFirePunch)) {

    var punch = instance_nearest(x, y, oFirePunch);
    if (instance_exists(punch)) {
        instance_destroy(punch.id, false);
    }
    badguy_health = badguy_health - 1;

    if (badguy_health < 0) {
        instance_destroy(id, true);
    }
    score++;
}

if (state == states.idle) {
    //idle behavior
    counter = counter + 1;

    if (counter >= room_speed * 3) {
        var change = choose(0, 1);
        switch (change) {
        case 0:
            state = states.wander;
        case 1:
            counter = 0;
            break;
        }
    }

    //transition triggers
    if (collision_circle(x, y, 200, oPlayer, false, false)) {
        //if we are less than 200 away from player go to alert state
        state = states.alert;
    }

    //sprite_index = sbadguy;
} else if (state == states.wander) {
    //wander behavior
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

    x += moveX;
    y += moveY;

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
} else if (state == states.alert) {
    //alert behavior
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

    x += moveX;
    y += moveY;

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

} else if (state == states.ready_attack) {
    image_index = 0;
    state = states.attack;

} else if (state == states.attack) {

    if (image_index > image_number - 1) {
        state = states.alert;
        gamepad_set_vibration(0, 1, 1);
        alarm[0] = room_speed * .2;
        
    }

    //set sprites
    //sprite_index = sbadguy;
}

talk = "h:" + string(badguy_health) + " s:" + string(state) + " x:" + string(moveX) + " y:" + string(moveY);