var organ_count = instance_number(obj_organ)
var tx = 0, ty = 0

with(obj_organ) {
    tx += x
    ty += y
}

var average_x = tx / organ_count
var average_y = ty / organ_count

var pos = {
    x: average_x - (_size.current / 2),
    y: average_y - (_size.current / 2),
}

_position.current = pos