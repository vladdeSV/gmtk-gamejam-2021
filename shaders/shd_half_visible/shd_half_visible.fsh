//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;

uniform vec2 nearest;
uniform float camera_size;
uniform float alpha_delta; // used to increase m (in "kx+m") in distance to nearest light
uniform float custom_alpha_delta;

void main()
{
    float window_size = 800.0;
    
    float x = v_vPosition.x;
    float y = v_vPosition.y;
    
    float repeat_multiplier = 3.0;
    float grid_size = 1.3;
    
    // distance from center
    float center_distance = abs(distance(vec2(x,y), vec2(nearest.x, nearest.y)));
    float center_distance_percentage = center_distance / camera_size;
    float distance_alpha = 1.6 - 4.0 * center_distance_percentage;
    float distance_alpha_2 = (0.25 + alpha_delta) - 0.4 * center_distance_percentage;
    if (distance_alpha_2 > distance_alpha) {
        distance_alpha = distance_alpha_2;
    }
    
    float alpha = 1.0;
    alpha *= distance_alpha;
    alpha += custom_alpha_delta;
    
    gl_FragColor = texture2D(gm_BaseTexture, v_vTexcoord);
    gl_FragColor *= vec4(1.0, 1.0, 1.0, alpha);
}
