target_id = undefined
_target_index = undefined
_held = false

on_active = function() {
    if (_target_index == undefined) {
        return
    }
    
    _target_index.active_count++
}

on_deactive = function() {
    if (_target_index == undefined) {
        return
    }
    
    _target_index.active_count--
}