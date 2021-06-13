shader_custom_init_half()

draw_sprite_ext(
    sprite_index,
    image_index,
    x,
    y,
    image_xscale,
    image_yscale,
    image_angle,
    c_white,
    image_alpha
)

if (locked) {
    draw_sprite_ext(
        spr_key_locked,
        0,
        x,
        y,
        image_xscale,
        image_yscale,
        image_angle,
        c_white,
        image_alpha
    )
}

shader_reset()