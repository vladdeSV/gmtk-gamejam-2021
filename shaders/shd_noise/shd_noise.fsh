//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;

uniform float seed;

float rand(vec2 co){
  return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void main()
{
    float v = rand(v_vPosition * vec2(seed, -seed));
    if (v < 0.5) {
        v *= 0.5;
    }
    
    vec4 color = vec4(v, v, v, 1.0);
    
    gl_FragColor = color * texture2D( gm_BaseTexture, v_vTexcoord );
}
