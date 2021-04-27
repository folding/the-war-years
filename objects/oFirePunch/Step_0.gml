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
		//make the bounce have a slightly random direction
		direction = direction + irandom_range(-10,10);
	}
	
	image_angle = direction;
	
	//damage the wall
	
var wall = instance_nearest(x+hspeed, y,oWall);
if(instance_exists(wall))
{
	if(wall.damage_left == 0)
	{
	instance_destroy(wall.id,false);
	}
	else
	{
		wall.damage_left = wall.damage_left - 1;
	}
}
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
		
		//make the bounce have a slightly random direction
		direction = direction + irandom_range(-10,10);
	}
	
	image_angle = direction;
	
	//damage the wall
	
var wall = instance_nearest(x, y+vspeed,oWall);
if(instance_exists(wall))
{
	if(wall.damage_left == 0)
	{
	instance_destroy(wall.id,false);
	}
	else
	{
		wall.damage_left = wall.damage_left - 1;
	}
}
}

if(place_meeting(x,y,oPlayer) and can_hurt_player == true)
{
	health = health -1;
	instance_destroy(id,false);
	
	if(health < 0)
	{
		//we dead.
		var player = instance_nearest(x,y,oPlayer);
			
		if(instance_exists(player))
		{
			player.sprite_index = Sdeadyou;
		}
	}
}