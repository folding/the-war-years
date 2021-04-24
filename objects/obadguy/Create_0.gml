
/// @description Insert description here
// You can write your code in this editor
enum states{
idle,
wander,
alert,
ready_attack,
attack,
bounce_x,
bounce_y
}

state = states.idle;

counter = 0;
spd = 1.5;
talk = "idle";

my_dir = irandom_range(0,359);
moveX = lengthdir_x(spd,my_dir);
moveY = lengthdir_y(spd,my_dir);

worldX = x;
worldY = y;

myPunch = noone;//no one means it's not assigned yet.


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