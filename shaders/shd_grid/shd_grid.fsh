//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;

uniform vec2 nearest;
uniform float camera_size;
uniform float time;

bool halfmod(float val, float repeat) {
    bool is_half = mod(val, repeat) < (repeat / 2.0);
    return is_half;
}

float rand(vec2 co){
  return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void main()
{
    float window_size = 800.0;
    
    float x = v_vPosition.x;
    float y = v_vPosition.y;
    
    float repeat_multiplier = 3.0;
    float grid_size = 1.3;
    
    // distance from center
    float center_distance = abs(distance(vec2(x,y) + vec2(time, time), vec2(nearest.x, nearest.y)));
    float center_distance_percentage = center_distance / camera_size;
    float distance_alpha = 1.6 - 4.0 * center_distance_percentage;
    // distance_alpha -= mod(distance_alpha, 0.3); // makes alpha step every 30%

    // checker
    float repeat = (camera_size + x) / (window_size + y) * repeat_multiplier * (1.0 - center_distance_percentage);
    bool is_checker = halfmod(
        x + (halfmod(y, repeat) ? (repeat / 2.0) : 0.0),
        repeat
    );
    
    
    // big checker
    float repeat_big = repeat * 1.8;
    bool is_checker_big = halfmod(
        x + (halfmod(y, repeat_big) ? (repeat_big/ 2.0) : 0.0),
        repeat_big
    );


    // grid
    bool is_grid = halfmod(x, grid_size) && halfmod(y, grid_size);
    
    
    float alpha = 1.0;
    alpha *= (
        is_grid
        && is_checker
        && is_checker_big
            ? 1.0
            : 0.0
    );
    alpha *= distance_alpha;
    
    float custom_modifier = 0.4;
    alpha -= custom_modifier;
    
    gl_FragColor = texture2D(gm_BaseTexture, v_vTexcoord);
    gl_FragColor *= vec4(1.0, 1.0, 1.0, alpha);
}
