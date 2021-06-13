shader_custom_init()

draw_sprite(
    sprite_index,
    image_index,
    x,
    y + 16 * sin(game_get_tick() / (2*room_speed)),
)

shader_reset()