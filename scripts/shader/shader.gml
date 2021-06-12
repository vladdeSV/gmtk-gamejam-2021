function shader_custom_init(){
    shader_set(shd_grid)

    var nearest_index = shader_get_uniform(shd_grid, "nearest")
    var camera_size_index = shader_get_uniform(shd_grid, "camera_size")
    var time_index = shader_get_uniform(shd_grid, "time")
    var alpha_delta_index = shader_get_uniform(shd_grid, "alpha_delta")

    shader_set_uniform_f_array(nearest_index, nearest_light())
    shader_set_uniform_f(camera_size_index, obj_camera.get_size())
    shader_set_uniform_f(time_index, 5*sin(game_get_tick()/room_speed/5))
    shader_set_uniform_f(alpha_delta_index, obj_game.alpha_delta)
}

function shader_custom_init_half() {
    shader_set(shd_half_visible)
    
    var nearest_index = shader_get_uniform(shd_half_visible, "nearest")
    var camera_size_index = shader_get_uniform(shd_half_visible, "camera_size")
    var alpha_delta_index = shader_get_uniform(shd_grid, "alpha_delta")

    shader_set_uniform_f_array(nearest_index, nearest_light())
    shader_set_uniform_f(camera_size_index, obj_camera.get_size())
    shader_set_uniform_f(alpha_delta_index, obj_game.alpha_delta)

}

function nearest_light() {
    return [obj_eye.x, obj_eye.y]
}