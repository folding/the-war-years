
//laser/punch collision
if (place_meeting(x, y, oFirePunch)) {

    var punch = instance_nearest(x, y, oFirePunch);
    if (instance_exists(punch)) {
        instance_destroy(punch.id, false);
    }
    badguy_health = badguy_health - 1;

    if (badguy_health < 0) {
        instance_destroy(id, true);
    }
    score++;
}

//states

script_execute(states_array[state]);


talk = "h:" + string(badguy_health) + " s:" + string(state) + " x:" + string(x) + " y:" + string(y);