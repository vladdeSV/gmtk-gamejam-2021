if(is_dead()) {
    var a = room_speed - alarm[6]
    var b = a % (room_speed / 2)
    var color = b < (room_speed / 4) ? c_red : c_white
    draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, color, 1)
    return
}

shader_custom_init_half()
draw_self()
shader_reset()