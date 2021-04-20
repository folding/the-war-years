/// @description Insert description here
// You can write your code in this editor
if(place_meeting(x + hspeed,y,oWall))
{
	//bounce by reversing the speed (e.g. 4 becomes -4)
	hspeed = -hspeed;
	
	//make fire punch hurt player if it bounces
	if(can_hurt_player == false)
	{
		can_hurt_player = true;
	}
	
	//make the bounce have a slightly random direction
	direction = direction + irandom_range(-10,10);
	image_angle = direction;
}

//check vertical collision with wall
if(place_meeting(x,y+vspeed,oWall))
{
	//bounce by changing positive to negative and visa versa
	vspeed = -vspeed;
	
	//make fire punch hurt player if it bounces
	if(can_hurt_player == false)
	{
		can_hurt_player = true;
	}
	
	//make the bounce have a slightly random direction
	direction = direction + irandom_range(-10,10);
	image_angle = direction;
}

if(place_meeting(x,y,oPlayer) and can_hurt_player == true)
{
	health = health -1;
	instance_destroy(id,false);
}