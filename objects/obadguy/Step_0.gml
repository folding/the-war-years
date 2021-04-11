/// @description Insert description here
// You can write your code in this editor

if(state == states.idle)
{
	//idle behavior
	counter = counter+1;
	
	if(counter >= room_speed * 3)
	{
		var change = choose(0,1);
		switch(change){
			case 0: state = states.wander;
			case 1: counter = 0; break;
		}
	}
	
		//transition triggers
	if(collision_circle(x,y,200,oPlayer,false,false))
	{
		//if we are less than 200 away from player go to alert state
		state = states.alert;
	}
	
	sprite_index = sbadguy;
}
else if(state == states.wander)
{
	//wander behavior
	counter = counter+1;
	
	//collide with walls
	if(place_meeting(x + moveX,y,oWall))
	{
		//just don't move if you are stuck on a wall
		moveX = 0;
	}
	if(place_meeting(x ,y+moveY,oWall)){
		moveY = 0;
	}
	
	x += moveX;
	y += moveY;
	
	direction = point_direction(x, y, oPlayer.x, oPlayer.y);
	
	image_angle = point_direction(x,y,x+moveX,y+moveY);
	
	if(counter >= room_speed * 3)
	{
		var change = choose(0,1);
		switch(change){
			case 0: state = states.idle;
			case 1: 
			my_dir = irandom_range(0,359);
			moveX = lengthdir_x(spd,my_dir);
			moveY = lengthdir_y(spd,my_dir);
			counter = 0;
		}
	}
	
			//transition triggers
	if(collision_circle(x,y,200,oPlayer,false,false))
	{
		//if we are less than 200 away from player go to alert state
		state = states.alert;
	}
	
	//set sprites
	sprite_index = sbadguy;
	//mirror the sprite when it is moving in the negative direction
	image_xscale = sign(moveX);
}
else if(state == states.alert)
{
	//alert behavior
	//point towards player
	my_dir = point_direction(x,y,oPlayer.x,oPlayer.y);
	//calculate move towards player 1
	moveX = lengthdir_x(spd,my_dir);
	moveY = lengthdir_y(spd,my_dir);
	
	//collide with walls
	if(place_meeting(x + moveX,y,oWall))
	{
		//just don't move if you are stuck on a wall
		moveX = 0;
	}
	if(place_meeting(x ,y+moveY,oWall)){
		moveY = 0;
	}
	
	
	//transition triggers
	if(!collision_circle(x,y,200,oPlayer,false,false))
	{
		//if we are beyond 200 away from player go to idle state
		state = states.idle;
	}
	if(collision_circle(x,y,100,oPlayer,false,false))
	{
		//if we are less than 100 away, then ATTACK!
		state = states.ready_attack;
	}
	
	x += moveX;
	y += moveY;
	
	direction = point_direction(x,y,x+moveX,y+moveY);
	
	image_angle = point_direction(x,y,x+moveX,y+moveY);
	
	//set sprites
	sprite_index = sbadguy;
	image_xscale = sign(moveX);
	
}
else if(state == states.ready_attack)
{
	image_index = 0;
	state = states.attack;
	
}
else if(state == states.attack)
{
	if(image_index > image_number -1)
	{
		state = states.alert;
		gamepad_set_vibration(0,1,1);
		alarm[0]=room_speed*.2;
	}
	
	
	
	//set sprites
	sprite_index = sbadguy;
}


talk = string(state)+" x:"+string(moveX)+" y:"+string(moveY);