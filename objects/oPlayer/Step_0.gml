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
var hspeed1 = point_distance(0 ,0, haxis, 0) * 5;
var vspeed1 = point_distance(0,0,0,vaxis)* 5;

//prefer analogue stick movement first
if(vspeed1 > 0 or hspeed1 > 0)
{
	
	var dir = 1;
	//180 = moving left so make sure we have negative speed
	if(directionh == 180){
		dir = -1
	}
	xSpeed = hspeed1 * dir;
	
	dir = 1;
	//270 = moving down, positive direction
	//90 = moving up, negative direction
	if(directionv == 90){
		dir = -1;
	}
	ySpeed = vspeed1 * dir;
}
//check keypress directions on keyboard and gamepad
else if(keyboard_check(vk_left) or gamepad_button_check(0,gp_padl))
{
	xSpeed = xSpeed-1;
}
else if(keyboard_check(vk_right) or gamepad_button_check(0,gp_padr))
{
	xSpeed = xSpeed+1;
}
else if(keyboard_check(vk_down)or gamepad_button_check(0,gp_padd))
{
	//moving down, increase speed by 1
	ySpeed = ySpeed+1;
}
else if(keyboard_check(vk_up)or gamepad_button_check(0,gp_padu))
{
	//moving up so decrease the speed by 1 (negative speed is moving up)
	ySpeed = ySpeed-1;
}
else//if no input is detected lets slow the man down little by little
{
	if(xSpeed > 0)
	{
		xSpeed = xSpeed-1;
	}else if(xSpeed < 0){
		xSpeed++;
	}
	
	if(ySpeed > 0)
	{
		ySpeed = ySpeed-1;
	}
	else if(ySpeed< 0)
	{
		ySpeed++;
	}
}

if(gamepad_button_check_pressed(0,gp_face1))
{
	image_index = 0;
	playerState = playerStates.punch
	score = score +1;
}


//check horizontal collision with wall
if(place_meeting(x + xSpeed,y,oWall))
{
	//bounce by reversing the speed (e.g. 4 becomes -4)
	//xSpeed = xSpeed * -1;
	
	//stop progress
	xSpeed = 0;
	
	//set boopCount so that text appears above player for 40 frames
	boopCount = 40;
}

//check vertical collision with wall
if(place_meeting(x,y+ySpeed,oWall))
{
	//bounce by changing positive to negative and visa versa
	//ySpeed = ySpeed * -1;
	
	//stop progress
	ySpeed = 0;
	
	//set boopCount so that text appears above player for 40 frames
	//drawing happens in the draw event
	boopCount = 40;
	
}

//check horizontal collision with exit
if(place_meeting(x + xSpeed,y,oExit))
{
	//play a sound effect when we touch the exit
	audio_play_sound(sfxTada,1,0);
}

//check vertical collision with exit
if(place_meeting(x,y+ySpeed,oExit))
{
	//play a sound effect when we touch the exit
	audio_play_sound(sfxTada,1,0);
}

//if speed is between -1 and 1 just set it to zero to avoid drift
if(ySpeed < 1 && ySpeed > -1){
	ySpeed = 0;
}
if(xSpeed < 1 && xSpeed > -1){
	xSpeed = 0;
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




var next_xscale = sign(xSpeed);

if(next_xscale != 0)
image_xscale = next_xscale;

//put something in the boop bubble
talk = "v:"+string(ySpeed)+" h:"+string(xSpeed)+" d:"+string(image_xscale);

//move player
x = x + xSpeed;
y = y + ySpeed;

//decrement the boop 
if(boopCount > 0){
	boopCount--;
}