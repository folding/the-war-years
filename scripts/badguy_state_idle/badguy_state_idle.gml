//idle behavior
function badguy_state_idle(){
counter = counter + 1;

if (counter >= room_speed * 3) {
    var change = choose(0, 1);
    switch (change) {
    case 0:
        state = states.wander;
    case 1:
        counter = 0;
        break;
    }
}

//transition triggers
if (collision_circle(x, y, 200, oPlayer, false, false)) {
    //if we are less than 200 away from player go to alert state
    state = states.alert;
}

//sprite_index = sbadguy;
}