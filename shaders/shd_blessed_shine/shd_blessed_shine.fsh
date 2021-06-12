//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;

uniform float time;

bool halfmod(float val, float repeat) {
    bool is_half = mod(val, repeat) < (repeat / 2.0);
    return is_half;
}

void main()
{
    float x = v_vPosition.x;
    float y = v_vPosition.y;
    
    
    float alpha = halfmod(y * x + time * 2.0, 800.0) ? 1.0 : 0.0;
       
    gl_FragColor = texture2D(gm_BaseTexture, v_vTexcoord);
    gl_FragColor *= vec4(1.0, 1.0, 1.0, alpha);
}
