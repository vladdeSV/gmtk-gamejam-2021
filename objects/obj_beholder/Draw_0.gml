draw_sprite(
    sprite_index,
    image_index,
    x,
    y + 16 * sin(game_get_tick() / (1.2*room_speed)),
)