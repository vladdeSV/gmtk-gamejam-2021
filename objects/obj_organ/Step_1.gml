if(next_tick_active != active) {
    sprite_index = next_tick_active ? sprite_active : sprite_default
    
    var collide = place_meeting(x,y, obj_block) || place_meeting(x,y, obj_tooth) || place_meeting(x,y, obj_organ)
    var can_switch = !collide
    
    if(can_switch) {
        active = next_tick_active
    } else {
        alarm[10] = room_speed / 2
    }
    
    sprite_index = !next_tick_active ? sprite_active : sprite_default
}