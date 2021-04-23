/// @description Insert description here
// You can write your code in this editor
draw_self();

if(global.showTalk){
draw_text(x+32,y-16,talk);
}

var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);
draw_text(vx + 5, vy + 5, "SCORE " + string(score)+ " x:"+ string(x) +" y:"+string(y));