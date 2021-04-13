/// @description Insert description here
// You can write your code in this editor
if(place_meeting(x + hspeed,y,oWall))
{
	//bounce by reversing the speed (e.g. 4 becomes -4)
	hspeed = -hspeed;
	
	image_angle = direction;
}

//check vertical collision with wall
if(place_meeting(x,y+vspeed,oWall))
{
	//bounce by changing positive to negative and visa versa
	vspeed = -vspeed;
	
	image_angle = direction;
}