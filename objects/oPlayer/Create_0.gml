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

global.showTalk = false;

if( gamepad_get_axis_deadzone(0) != 0.5)
{
	gamepad_set_axis_deadzone(0, 0.5);
}
	
global.p_system=part_system_create_layer(layer, true);

global.particle1 = part_type_create();
part_type_shape(global.particle1, pt_shape_flare);
part_type_size(global.particle1, 0.01, 0.1, -.02, 0.5);
part_type_color3(global.particle1, c_grey, c_lime, c_red);
part_type_alpha3(global.particle1, 0.5, 1, 0);
part_type_speed(global.particle1, 2, 15, -0.10, 0);
part_type_direction(global.particle1, 0, 359, 8.5, 30);
part_type_blend(global.particle1, true);
part_type_life(global.particle1, 30, 60);

global.pt_blood = part_type_create();
part_type_shape(global.pt_blood, pt_shape_flare);
part_type_size(global.pt_blood, 0.01, 0.1, -.02, 0.5);
part_type_color3(global.pt_blood, c_red, c_dkgray, c_red);
part_type_alpha3(global.pt_blood, 0.5, 1, 0);
part_type_speed(global.pt_blood, 2, 5, -0.10, 0);
part_type_direction(global.pt_blood, 0, 359, 0, 30);
part_type_blend(global.pt_blood, true);
part_type_life(global.pt_blood, 30, 60);

