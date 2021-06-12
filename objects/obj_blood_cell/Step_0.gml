var current_held = _held

if(place_meeting(x,y,obj_organ)) {
    _held = true
    sprite_index = spr_blood_cell_held
    
    if(!current_held) {
        on_active()
    }
} else {
    _held = false
    sprite_index = spr_blood_cell
    
    if(current_held) {
        on_deactive()
    }
}