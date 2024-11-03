
/// @description Insert description here
// You can write your code in this editor

//these are the states a bad guy can have
enum states{
idle,
wander,
alert,
ready_attack,
attack,
bounce_x,
bounce_y
}

//when bad guy is created set state to idle
state = states.idle;

counter = 0;
spd = 1.5;//speed
talk = "idle";

//randomly set direction
my_dir = irandom_range(0,359);

//use direction and speed to figure out how
//far to move in the x and y directions
moveX = lengthdir_x(spd,my_dir);
moveY = lengthdir_y(spd,my_dir);

//get current location in the world
worldX = x;
worldY = y;

//initialize punch to nothing
myPunch = noone;//no one means it's not assigned yet.

//randomly pick sprite bad, very bad, or super bad
switch(irandom_range(0,2))
{
case 0:
sprite_index = sbadguy;
badguy_health = 1;
break;
case 1:
sprite_index = sverybadguy;
badguy_health =2
break;
case 2:
sprite_index = ssuperbadguy;
badguy_health =3
break;
}