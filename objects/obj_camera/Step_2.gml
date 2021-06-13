var camera_size = self.get_size();

// hardcoded to default to player position

var organ_count = instance_number(obj_organ)
var total_x = 0
var total_y = 0

with (obj_organ) {
    total_x += x
    total_y += y
}

var average_x = total_x / organ_count;
var average_y = total_y / organ_count;

if (organ_count == 0) {
    average_x = 400
    average_y = 400
}

var target_position_x = 
    abs(self._position.current.x - (average_x - (camera_size / 2))) > 0.1
        ? lerp(self._position.current.x, average_x - (camera_size / 2), 0.1)
        : self._position.current.x

var target_position_y = 
    abs(self._position.current.y - (average_y - (camera_size / 2))) > 0.1
        ? lerp(self._position.current.y, average_y - (camera_size / 2), 0.1)
        : self._position.current.y



var target = {
    x: target_position_x,
    y: target_position_y,
}

if(self._position.to != undefined) {
    target = self._position.to;
}

var position_step = alarm[CameraAlarm.position]
if (position_step >= 0) {
    var d = smoothstep(1 - position_step / self._position.duration_steps)

    self._position.current.x = self._position.from.x + (target.x - self._position.from.x) * d
    self._position.current.y = self._position.from.y + (target.y - self._position.from.y) * d
} else {
    self._position.current = target
}

var cam = view_camera[0];
camera_set_view_size(cam, camera_size, camera_size)
camera_set_view_pos(
    cam,
    self._position.current.x,
    self._position.current.y,
)