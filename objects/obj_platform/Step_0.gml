var modifier = (active_count > 0 ? 1 : -1)
var last_position = {x: x, y: y}

_position.current += modifier
_position.current = max(0, min(_position.duration, _position.current))

var d = smoothstep(_position.current / _position.duration)
var pdx = delta_position.x * sprite_width
var pdy = delta_position.y * sprite_height

x = _initial_position.x + pdx * d
y = _initial_position.y + pdy * d
var organ = instance_place(x, y - 2, obj_organ)

if(organ != noone) {
    organ.x += x - last_position.x
    organ.y += y - last_position.y
}
