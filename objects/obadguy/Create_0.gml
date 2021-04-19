
/// @description Insert description here
// You can write your code in this editor
enum states{
idle,
wander,
alert,
ready_attack,
attack
}

state = states.idle;

states_array[states.idle] = badguy_state_idle;
states_array[states.wander] = badguy_state_wander;
states_array[states.alert] = badguy_state_alert;
states_array[states.ready_attack] = badguy_state_ready_attack;
states_array[states.attack] = badguy_state_attack;


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