shader_custom_init_half()
var ox = x + sprite_width/2
var oy = y + 4
var dx = self.delta_position.x * sprite_width
var dy = self.delta_position.y * sprite_height
var line_width = 6
draw_line_width(ox, oy, ox + dx, oy + dy, line_width)
shader_reset()

shader_custom_init()
draw_self()
shader_reset()
