if(alarm[11] >= 0) {
    shader_set(shd_noise)
    
    var seed_index = shader_get_uniform(shd_noise, "seed")
    
    shader_set_uniform_f(seed_index, alarm[11])
    
    var xx = obj_camera._position.current.x
    var yy = obj_camera._position.current.y
    draw_rectangle(xx, yy, xx + 800, yy + 800, false)
    
    shader_reset()
}