/// @description Insert description here
// You can write your code in this editor
draw_self();

if(global.showTalk){
draw_text(x+32,y-16,talk);
}
else{
draw_text(x+32,y-16,string(health));
}

var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

var enemy_count = instance_number(obadguy);

var far_guy = instance_furthest(x,y,obadguy);
var far_guy_x = 0;
var far_guy_y = 0;

if(instance_exists(far_guy))
{
	far_guy_x = far_guy.x;
	far_guy_y = far_guy.y;
	
	
	draw_text(far_guy.x+32,far_guy.y-16,"Hi");
}

draw_text(vx + 5, vy + 5, "SCORE " + string(score)+ " ME:"+ string(x) +","+string(y)+" ENEMY COUNT:"+string(enemy_count)+" FAR:"+string(far_guy_x)+","+string(far_guy_y));

