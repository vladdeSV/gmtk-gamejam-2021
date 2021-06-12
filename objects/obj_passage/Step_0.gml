var collisions = 0
with(obj_organ) {
    if (place_meeting(x,y, obj_passage)) {
        collisions++
    }
}

if(instance_number(obj_organ) < 2) {
    collisions *= 2
}

rotate_speed += power(5, collisions)
rotate_speed *= 0.95

if(rotate_speed >= 399 && alarm[0] == -1) {
    alarm[0] = room_speed
}

sprite_index = (rotate_speed > 360 ? spr_passage_open : spr_passage)
image_angle += (rotate_speed)/room_speed