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
    room_restart()
    obj_game.time_frozen = false
}