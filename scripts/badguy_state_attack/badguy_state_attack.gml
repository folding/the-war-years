//attack
function badguy_state_attack(){
counter =counter+1;

if (image_index > image_number - 1) {
    state = states.alert;
    alarm[0] = room_speed * .2;
}
	
if (counter >= room_speed * 2) {
    var change = choose(0,1,2,3,7,8,9,10);
    switch (change) {
    case 10:
		var shot = instance_create_layer(x,y,"Instances",oBadGuyPunch);
		shot.direction = direction;
		shot.image_angle = image_angle;
		break;
    }
}

//set sprites
//sprite_index = sbadguy;

}