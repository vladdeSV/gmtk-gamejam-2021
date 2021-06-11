_position = create_temporal_container({x: 0, y: 0})
_size = create_temporal_container(600)

// functions
set_position = function(position, duration) {
    var duration_steps = seconds_in_steps(duration)
    alarm[CameraAlarm.position] = duration_steps
        
    _position.duration_steps = duration_steps
    _position.start_position = self._position.current_position
    _position.end_position = position
}

get_size = function() {
    return _size.current
}