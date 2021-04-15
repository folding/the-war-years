/// @description Insert description here
// You can write your code in this editor

//remember that the top left of the room is the 0,0 coordinate
//the positions increase moving right and down to the bottom right 
//a 10 by 10 grid would be labeled like this:

//0,0 - - - - - - - - - - 10,0
//
//
//
//
//
//
//0,10 - - - - - - - - -  10,10

//get the direction info from the gamepad analogue stick
var haxis = gamepad_axis_value(0, gp_axislh);
var vaxis = gamepad_axis_value(0, gp_axislv);

//figure out the directions the stick is pointing
var directionh = point_direction(0, 0, haxis, 0);
var directionv = point_direction(0, 0, 0, vaxis);

//work out the speed in each direction (how far the stick is tilted
var hspeed1 = point_distance(0 ,0, haxis, 0) * playerSpeed;
var vspeed1 = point_distance(0,0,0,vaxis)* playerSpeed;

//prefer analogue stick movement first
if(vspeed1 > 0 or hspeed1 > 0)
{
	var dir = 1;
	//180 = moving left so make sure we have negative speed
	if(directionh == 180){
		dir = -1
	}
	xMove= hspeed1 * dir;
	
	dir = 1;
	//270 = moving down, positive direction
	//90 = moving up, negative direction
	if(directionv == 90){
		dir = -1;
	}
	yMove= vspeed1 * dir;
}
else
{

//check keypress directions on keyboard and gamepad
var left = (keyboard_check(vk_left) or keyboard_check(ord("A")) or gamepad_button_check(0,gp_padl));
var right = (keyboard_check(vk_right) or keyboard_check(ord("D")) or gamepad_button_check(0,gp_padr));

xMove = (right - left) * playerSpeed;

var down = (keyboard_check(vk_down) or keyboard_check(ord("S")) or gamepad_button_check(0,gp_padd));
var up = (keyboard_check(vk_up) or keyboard_check(ord("W")) or gamepad_button_check(0,gp_padu));

yMove = (down - up) * playerSpeed;

}

if(gamepad_button_check_pressed(0,gp_face1) or keyboard_check_pressed(vk_space))
{
	image_index = 0;
	playerState = playerStates.punch
	//score = score +1;
	
	instance_create_layer(x,y,"Instances",oFirePunch);
}

if(gamepad_button_check_pressed(0,gp_face2))
{
	image_index = 0;
	playerState = playerStates.punch
	//score = score +1;
	
	for (var i = 0; i < instance_number(obadguy); ++i;)
    {
     var enemy = instance_find(obadguy,i);
	 
	 if(enemy.x > x){
	instance_create_layer(enemy.x, enemy.y,"Instances",oFirePunch);
	 }
    }
}

var xCollision = false;
var yCollision = false;

//check horizontal collision with wall
if(place_meeting(x + xMove,y,oWall))
{
	while(!place_meeting(x+sign(xMove),y,oWall))
	{
		x = x + sign(xMove);
	}
	
	xMove= 0;
xCollision = true;	
	//set boopCount so that text appears above player for 40 frames
	boopCount = 40;
}

//check vertical collision with wall
if(place_meeting(x,y+yMove,oWall))
{
	while(!place_meeting(x ,y+sign(yMove),oWall))
	{
		y = y + sign(yMove);
	}
	
	yMove = 0;
	yCollision = true;
	//set boopCount so that text appears above player for 40 frames
	//drawing happens in the draw event
	boopCount = 40;
}

//check horizontal collision with exit
if(place_meeting(x + xMove,y,oExit))
{
	//play a sound effect when we touch the exit
	audio_play_sound(sfxTada,1,0);
}

//check vertical collision with exit
if(place_meeting(x,y+yMove,oExit))
{
	//play a sound effect when we touch the exit
	audio_play_sound(sfxTada,1,0);
}

//if speed is between -1 and 1 just set it to zero to avoid drift
if(yMove < 1 && yMove> -1){
	yMove= 0;
}
if(xMove < 1 && xMove> -1){
	xMove= 0;
}


if(playerState == playerStates.ready_punch)
{
	//this isn't working... why?
	image_index = 0;
	playerState = playerStates.punch
	sprite_index = sPlayer;
}

//manage states
else if(playerState == playerStates.punch)
{
	if(image_index > image_number-1)
	{
		playerState = playerStates.stand;
	}
	
	sprite_index = sPlayerAttack;
}
else if(playerState == playerStates.stand)
{
	sprite_index = sPlayer;
}


var next_angle = point_direction(x,y,x+xMove,y+yMove);
talk = "health:"+string(health)+" v:"+string(yMove)+" h:"+string(xMove)+" d:"+string(image_xscale)+" a:"+string(next_angle)+" xc:"+string(xCollision)+" yc:"+string(yCollision);

if((yMove!= 0 or xMove!= 0) or yCollision && xCollision){
	image_angle = next_angle;
}

//move player
x = x + xMove
y = y + yMove


//decrement the boop 
if(boopCount > 0){
	boopCount--;
}