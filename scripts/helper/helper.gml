function seconds_in_steps(duration) {
    return duration * room_speed
}

function object_position(object) {
    return {
        x: object.x,
        y: object.y,
    }
}

function create_temporal_container(initial) {
    return {
        current: initial,
        duration_steps: undefined,
        from: undefined,
        to: undefined,
    }
}

function game_get_tick() {
    return obj_game.tick
}

function death(instance) {
    obj_game.time_frozen = true
    instance.alarm[6] = room_speed
}

function restart() {
    
    obj_game.time_frozen = false
    
    var checkpoint = undefined
    with(obj_checkpoint) {
        if(active) {
            checkpoint = self
        }
    }
    
    if(checkpoint == undefined) {
        room_restart()
        return
    }
    
    var organ_count = instance_number(obj_organ)
    var i = 0;
    with (obj_organ) {
        var d = i / (organ_count - 1)
        var w = checkpoint.bbox_right - checkpoint.bbox_left
        var organ_height = bbox_bottom - bbox_top
        
        y = checkpoint.bbox_bottom - organ_height
        x = checkpoint.x + w * d
        i++
    }
    
}

function next_level() {
    room_goto_next()
    obj_game.alarm[11] = room_speed / 4
    obj_game.sound_static = audio_play_sound(snd_noise, 1, false)
}