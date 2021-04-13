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
counter = 0;
xSpeed = 0;
ySpeed = 0;
boopCount = 0;
talk = "boop";

if( gamepad_get_axis_deadzone(0) != 0.5)
    {
    gamepad_set_axis_deadzone(0, 0.5);
    }
	


