/// @description Insert description here
// You can write your code in this editor

speed = 5;

var target = instance_nearest(x, y, obadguy);

if(target > 0)
{
direction = point_direction(x, y, target.x, target.y);

image_angle = direction;

}
else
{
	direction = random_range(0,359);
	image_angle = direction;
}