/// @description Insert description here
// You can write your code in this editor

if (active) {
    return
}

var organ_count = instance_number(obj_organ)
var collisions = 0
with(obj_organ) {
    if (place_meeting(x,y, other)) {
        
        var exists = false
        for(var i = 0; i < array_length(other.touched_organs); i++) {
            var val = other.touched_organs[i]
            if(val == id) {
                exists = true
                break
            }
        }
        
        if (!exists) {
            array_push(other.touched_organs, id)
        }
    }
}

if (array_length(touched_organs) == organ_count) {
    obj_checkpoint.active = false
    active = true
}