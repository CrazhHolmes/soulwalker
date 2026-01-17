shader_type canvas_item;

uniform float barrel_distortion : hint_range(0.0, 1.0) = 0.2;
uniform float scanline_intensity : hint_range(0.0, 1.0) = 0.15;
uniform float phosphor_glow : hint_range(0.0, 1.0) = 0.2;
uniform vec4 phosphor_color : source_color = vec4(0.2, 1.0, 0.2, 1.0);
uniform float flicker_speed : hint_range(0.0, 10.0) = 1.0;

float rand(vec2 co) {
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void fragment() {
    vec2 uv = UV;
    
    // 1. Barrel Distortion
    vec2 centered_uv = uv * 2.0 - 1.0;
    float dist = length(centered_uv);
    centered_uv *= 1.0 + barrel_distortion * (dist * dist);
    uv = (centered_uv + 1.0) / 2.0;

    // Boundary check (curvature)
    if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0);
    } else {
        vec4 tex_color = texture(TEXTURE, uv);
        
        // 2. Scanlines
        float scanline = sin(uv.y * 800.0) * scanline_intensity;
        tex_color.rgb -= scanline;
        
        // 3. Phosphor Glow & Tint
        vec3 green_tint = tex_color.rgb * phosphor_color.rgb;
        float brightness = (tex_color.r + tex_color.g + tex_color.b) / 3.0;
        vec3 glow = phosphor_color.rgb * brightness * phosphor_glow;
        
        // 4. Flicker
        float flicker = 1.0 - (rand(vec2(TIME * flicker_speed, 0.0)) * 0.02);
        
        COLOR.rgb = (green_tint + glow) * flicker;
        COLOR.a = tex_color.a;
    }
}
