//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;

bool halfmod(float val, float repeat) {
    bool is_half = mod(val, repeat) < (repeat / 2.0);
    return is_half;
}

void main()
{
    float x = v_vPosition.x - 400.0;
    float y = v_vPosition.y;
    
    float repeat = x * 1.2 * y / 800.0;
    
    float alpha = (x < 300)/*halfmod(x, repeat)*/ ? 1.0 : 0.5;
       
    gl_FragColor = texture2D(gm_BaseTexture, v_vTexcoord);
    gl_FragColor *= vec4(1.0, 1.0, 1.0, alpha);
}
