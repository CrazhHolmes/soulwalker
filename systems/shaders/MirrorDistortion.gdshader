shader_type canvas_item;

uniform float distortion_strength : hint_range(0.0, 0.1) = 0.02;
uniform float frequency : hint_range(0.0, 10.0) = 2.0;
uniform float speed : hint_range(0.0, 5.0) = 1.0;
uniform vec4 tint : source_color = vec4(0.4, 0.6, 1.0, 0.3);

void fragment() {
    vec2 uv = UV;
    float wave = sin(uv.y * frequency + TIME * speed) * distortion_strength;
    uv.x += wave;
    
    vec4 tex_color = texture(TEXTURE, uv);
    vec3 mixed_color = mix(tex_color.rgb, tint.rgb, tint.a);
    
    // Add a shimmer effect based on wave
    float shimmer = smoothstep(0.45, 0.55, sin(uv.y * 10.0 - TIME * 5.0)) * 0.1;
    
    COLOR = vec4(mixed_color + shimmer, tex_color.a);
}
