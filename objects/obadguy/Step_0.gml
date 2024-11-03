
//check if there is a collision with ANY laser/punch 
if (place_meeting(x, y, oFirePunch)) {

	//find the closest one and save it to a local variable
    var punch = instance_nearest(x, y, oFirePunch);
	//if it still exists remove it
    if (instance_exists(punch)) {
        instance_destroy(punch.id, false);
    }
	//subtract 1 from current health and assign it back to current health
    badguy_health = badguy_health - 1;

	//if health is less than zero destroy this enemy
    if (badguy_health < 0) {
        instance_destroy(id, true);
		part_particles_create(global.p_system, x, y, global.particle1, 50);
    }
	else
	{
        var blood_direction = point_direction(oPlayer.x, oPlayer.y,x, y);
        part_type_direction(global.pt_blood, blood_direction-20, blood_direction+20, 0, 30);
		part_particles_create(global.p_system, x, y, global.pt_blood, badguy_health+1);
	}
	//increment the score by 1
    score++;
}

//if moving this guy in the x direction will collide with 
//another bad guy then set the state to bounce_x
if(place_meeting(x+moveX,y,obadguy))
{
	state = states.bounce_x;
}

//same thing for y direction
if(place_meeting(x,y+moveY,obadguy))
{
	state = states.bounce_y;
}


//update location of bad guy based on current state
if (state == states.bounce_x) {
	//reverse direction of x move and increase it by 50%
	moveX = moveX * -1.5;
	if(moveX > 10)
	{
		//cap the bouncing at 10 if it increases by 50% too many times
		moveX = 10;
	}
	//set state to wander
	state = states.wander;
} 
if (state == states.bounce_y){
	moveY = moveY * -1.5;
	if(moveY > 10){
		moveY = 10;
	}
	state = states.wander;
}


if (state == states.idle) {
    //idle behavior
	
	#region idle
    counter = counter + 1;

    if (counter >= room_speed * 3) {
		//after counter exceeds limit choose to wander 
		//or reset counter and remain idle
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
	if(x < 0 or y < 0 or x > window_get_width() or y > window_get_height())
	{
		//if we are offscreen go to alert so we move back towards player
        state = states.alert;
	}
	

    //sprite_index = sbadguy;
	#endregion
} 
else if (state == states.wander) {
    //wander behavior
	#region wander
    counter = counter + 1;

	var yCollision = false;
	var xCollision = false;

    //just don't move left/right if you are against a wall
    if (place_meeting(x + moveX, y, oWall)) {
        while (!place_meeting(x + sign(moveX), y, oWall)and(abs(moveX) > 1)) {
            x = x + sign(moveX);
        }
		xCollision = true;
        moveX = 0;
    }

    //just don't move up/down if you are against a wall
    if (place_meeting(x, y + moveY, oWall)) {
        while (!place_meeting(x, y + sign(moveY), oWall)and(abs(moveY) > 1)) {
            y = y + sign(moveY);
        }
		yCollision = true;
        moveY = 0;
    }
	
	//increase worldX by amount we should move in x direction
	worldX = worldX + moveX;
	//increase worldY by amount we should move in y direction
	worldY = worldY + moveY;

	//convert to room/screen coordinates that are whole numbers
    x = floor(worldX);
    y = floor(worldY);

	//based on the new screen location and 
	//the players screen location the bad guy 
	//sprite will follow that line pointing to the player
    direction = point_direction(x, y, oPlayer.x, oPlayer.y);
	
	//calculate angle to rotate sprite based on where it is moving
	//and where it was
	var next_angle = point_direction(x,y,x+moveX,y+moveY);

    //if we are NOT against a wall or colliding with something
	//then assign the next angle to the image
	if((moveY!= 0 or moveX!= 0) or yCollision && xCollision){
		image_angle = next_angle;
	}

    if (counter >= room_speed * 3) {
		//coin flip to decide if we should go back to idle
        var change = choose(0, 1);
        switch (change) {
        case 0:
            state = states.idle;
        case 1:
		    //if not going back to idle 
			//then set random direction and move that way
            my_dir = irandom_range(0, 359);
            moveX = lengthdir_x(spd, my_dir);
            moveY = lengthdir_y(spd, my_dir);
            counter = 0;
        }
    }

    //transition triggers
    if (collision_circle(x, y, 200, oPlayer, false, false)) {
        //if we are less than 200 away from player go to alert state
        state = states.alert;
    }

    //set sprites
    //sprite_index = sbadguy;
    //mirror the sprite when it is moving in the negative direction

    //var next_xscale = sign(moveX);

    //if(next_xscale != 0)
    //image_xscale = next_xscale;
	#endregion
} else if (state == states.alert) {
    //alert behavior
	#region alert
    //point towards player
    my_dir = point_direction(x, y, oPlayer.x, oPlayer.y);
    //calculate move towards player 1
    moveX = lengthdir_x(spd, my_dir);
    moveY = lengthdir_y(spd, my_dir);

	var yCollision = false;
	var xCollision = false;

    //just don't move if you are stuck on a wall
    if (place_meeting(x + moveX, y, oWall)) {
        while (!place_meeting(x + sign(moveX), y, oWall)and(moveX > 1 or moveX < 1)) {
            x = x + sign(moveX);
        }
		xCollision = true;
        moveX = 0;
    }

    if (place_meeting(x, y + moveY, oWall)) {
        while (!place_meeting(x, y + sign(moveY), oWall)and(moveY > 1 or moveY < 1)) {
            y = y + sign(moveY);
        }
		yCollision = true;
        moveY = 0;
    }

    if (moveX == 0 and moveY == 0) {
        //we're stuck on a wall.. goto wander state
        state = states.wander;
    }
		//transition triggers
	else if(!collision_circle(x,y,200,oPlayer,false,false))
	{
		//if we are beyond 200 away from player go to idle state
		state = states.idle;
	}
	else if(collision_circle(x,y,100,oPlayer,false,false))
	{
		//if we are less than 100 away, then ATTACK!
		state = states.ready_attack;
	}

	worldX = worldX + moveX;
	worldY = worldY + moveY;

    x = floor(worldX);
    y = floor(worldY)

    direction = point_direction(x, y, x + moveX, y + moveY);

	var next_angle = point_direction(x,y,x+moveX,y+moveY);
	if((moveY!= 0 or moveX!= 0) or yCollision && xCollision){
		image_angle = next_angle;
	}

    //set sprites
    //sprite_index = sbadguy;

    //var next_xscale = sign(moveX);

    //if(next_xscale != 0)
    //image_xscale = next_xscale;
	
	#endregion

} else if (state == states.ready_attack) {
    image_index = 0;
    state = states.attack;

} else if (state == states.attack) {

	#region attack
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
	#endregion
}

talk = "h:" + string(badguy_health) + " s:" + string(state) + " x:" + string(x) + " y:" + string(y);