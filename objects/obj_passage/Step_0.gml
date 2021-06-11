var collisions = 0
with(obj_organ) {
    if (place_meeting(x,y, obj_passage)) {
        collisions++
    }
}

rotate_speed += 7 * (collisions + 1)
rotate_speed *= 0.95

if(rotate_speed >= 399) {
    // set win flag
}

sprite_index = (rotate_speed > 360 ? spr_passage_open : spr_passage)
image_angle += (rotate_speed)/room_speed