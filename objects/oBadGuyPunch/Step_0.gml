/// @description Insert description here
// You can write your code in this editor
if(place_meeting(x + hspeed,y,oWall))
{
instance_destroy(id,false);


var wall = instance_nearest(x + hspeed, y,oWall);
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

instance_destroy(id,false);

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

if(place_meeting(x,y,oPlayer))
{
	gamepad_set_vibration(0,1,1);
	alarm[0]=room_speed * .5;
	
	if(hasLanded == false)
	{
		hasLanded = true;
		health = health - 1;
		visible = false;
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
}