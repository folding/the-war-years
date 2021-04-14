/// @description Insert description here
// You can write your code in this editor

enum playerStates{
idle,
stand,
walk,
ready_punch,
punch
}

playerState = playerStates.stand;
playerSpeed = 5;
counter = 0;
xMove = 0;
yMove = 0;
boopCount = 0;
talk = "boop";
lastDir = 0;

if( gamepad_get_axis_deadzone(0) != 0.5)
{
	gamepad_set_axis_deadzone(0, 0.5);
}
	


