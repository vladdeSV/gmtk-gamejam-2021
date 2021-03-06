vx = 0.11
vy = 0.11
collision = Direction.none
jumping = false
on_organ_mid_air = false

jump_velocity = 9.1
custom_alpha_delta = 0

key_up = vk_up
key_down = vk_down
key_left = vk_left
key_right = vk_right

active = false
next_tick_active = false
sprite_default = spr_error
sprite_active = spr_error

cannonical_name = undefined

is_dead = function() {
    return alarm[6] >= 0
}

update = function() {
    
    if (obj_game.time_frozen) {
        return
    }
    
    if (x < 0 || y < 0 || x > room_width || y > room_height || place_meeting(x, y, obj_tooth)) {
        death(self)
    }

    // fixme, flash when cannot activate
    /*if(alarm[10] >= 0) {
        var percent = alarm[10] / (room_speed / 2)
        image_alpha = 1 - 0.5 * percent
    }*/
    
    if(alarm[10] >= 0) {
        var percent = alarm[10] / (room_speed / 2)
        custom_alpha_delta = -(1 * percent)
    } else {
        custom_alpha_delta = 0
    }

    
    entity_collision()
    
    sprite_index = active ? sprite_active : sprite_default
    next_tick_active = obj_game.can_activate && keyboard_check(key_down)
    
    // gravity
    var downforce = 0.48
    vy += downforce
    
    if (keyboard_check_released(key_up)) {
        jumping = false
    }
    
    var standing = collision & Direction.down
    var standing_on_organ = instance_place(x,y+1, obj_organ)
    var standing_on_eye = standing_on_organ != noone && standing_on_organ.object_index == obj_eye
    
    var low_air_friction = alarm[5] >= 0
    
    var just_threw = alarm[7] >= 0
    if (standing && !active && !on_organ_mid_air && !jumping && !low_air_friction && !just_threw && keyboard_check(key_up)) {
        vy -= jump_velocity * (standing_on_eye ? 0.5 : 1)
        jumping = true
    }

    var sx = keyboard_check(key_right) - keyboard_check(key_left)
    var staggered = object_index == obj_hand && alarm[5] > 0
    var friction_modifier = 0.8
    
    if (low_air_friction) {
        var is_eye_being_thrown = (object_index == obj_eye && alarm[5] >= 0)
        friction_modifier = (standing_on_organ && abs(standing_on_organ.vx) > 0.1) || !standing || is_eye_being_thrown ? 1 : 0.2
    }
    
    var colliding_bottom_right = position_meeting(bbox_right - 8, bbox_bottom + 1, obj_block)
    var colliding_bottom_left = position_meeting(bbox_left + 8, bbox_bottom + 1, obj_block)
    
    if ((colliding_bottom_right || colliding_bottom_left)) {
        if (!colliding_bottom_right) {
            friction_modifier *= 0.25
        }
        
        if (!colliding_bottom_left) {
            friction_modifier *= 0.25
        }
    }
    
    if (active || just_threw || sx == 0 || staggered) {
        vx *= friction_modifier
        if(abs(vx) < 0.01) {
            vx = 0
        }
    } else {
        
        var max_horizontal_velocity = 2.5
        var nhv = max(
            max_horizontal_velocity,
            power(abs(vx) / max_horizontal_velocity, 0.6) * 0.4 // funny function to calculate friction
        )

        if (sx == -1) {
            vx = -nhv
        } else if (sx == 1) {
            vx = nhv
        }
    }
    
    if (standing_on_eye) {
        var rad = arctan2(
            standing_on_organ.x - x,
            standing_on_organ.y - y
        )
        
        vx += (rad < 0 ? 1 : -1)
    }
}

entity_collision = function(){
    // collision
    var collidingVerticalId = instance_place(x, y + vy, obj_block)
    if(collidingVerticalId == noone) {
        collidingVerticalId = instance_place(x, y + vy, obj_organ)
    }
    
    other.on_organ_mid_air = false
    
    if(collidingVerticalId == noone) {
        collision = collision & ~(Direction.up | Direction.down)
        if(abs(vy) > 1) {
            y += vy
        }
    } else {
        vy = 0
    
        var angleRad = arctan2(
            collidingVerticalId.x - x,
            y - collidingVerticalId.y // flipped, y goes downwards
        )
    
        if(abs(angleRad) < pi/2) {
            // block is above
            y = collidingVerticalId.bbox_bottom - (bbox_top - y) + 1
            collision |= Direction.up
        } else {
            // block is below
            y = collidingVerticalId.bbox_top - (bbox_bottom - y) - 1
            collision |= Direction.down
            
            if(object_is_ancestor(collidingVerticalId.object_index, obj_organ)) {
                with(collidingVerticalId) {
                    other.on_organ_mid_air = !place_meeting(x, y + 1, obj_block)
                    if(object_index == obj_hand && other.alarm[5] == -1 && keyboard_check(key_up) && place_meeting(x, y + 1, obj_block))
                    {
                        if(abs(vx) > 0.1) {
                            other.vx += vx * 3
                            other.vy -= 5
                            vx = (vx > 0 ? -1 : 1) * 3
                            vy = -2
                            alarm[7] = room_speed * 0.7
                            other.alarm[5] = room_speed / 3
                        }
                    }
                }
            }
        }
    }

    var collidingHorizontalId = instance_place(x + vx, y, obj_block)
    if (collidingHorizontalId == noone) {
        collidingHorizontalId = instance_place(x + vx, y, obj_organ)
    }
    
    if (collidingHorizontalId == noone) {
        collision = collision & ~(Direction.left | Direction.right)
        if (abs(vx) > 0.1) {
            x += vx
        }
    } else {
        vx = 0
    
        var angleRad = arctan2(
            collidingHorizontalId.x - x,
            y - collidingHorizontalId.y // flipped, y goes downwards
        )
    
        if(angleRad > 0) {
            // block is right
            x = collidingHorizontalId.bbox_left - (bbox_right - x) - 1
            collision |= Direction.right
        } else {
            // block is left
            x = collidingHorizontalId.bbox_right - (bbox_left - x) + 1
            collision |= Direction.left
        }
    }
}