shader_type canvas_item;

uniform float intensity : hint_range(0.0, 1.0) = 0.0;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

float rand(vec2 co) {
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void fragment() {
    vec2 uv = SCREEN_UV;
    
    // 1. Horizontal Glitch Shifts
    if (intensity > 0.4) {
        float glitch_chance = step(1.0 - (intensity * 0.03), rand(vec2(TIME * 0.1, floor(uv.y * 30.0))));
        uv.x += glitch_chance * (rand(vec2(TIME)) - 0.5) * 0.03 * intensity;
    }
    
    vec4 color = texture(screen_texture, uv);
    
    // 2. Redaction Bars (Procedural)
    float bar_y = floor(uv.y * (15.0 + intensity * 15.0));
    float bar_noise = rand(vec2(bar_y, floor(TIME * 4.0)));
    if (intensity > 0.6 && bar_noise < intensity * 0.15) {
        float bar_start = rand(vec2(bar_y, 1.0)) * 0.6;
        float bar_end = bar_start + rand(vec2(bar_y, 2.0)) * 0.3;
        if (uv.x > bar_start && uv.x < bar_end) {
            color.rgb = vec3(0.0); // Pure black redaction
        }
    }
    
    // 3. Static / Grain
    float noise = rand(uv + vec2(TIME * 0.005));
    color.rgb += (noise - 0.5) * 0.1 * intensity;
    
    // 4. Color Desaturation / Distortion
    if (intensity > 0.85) {
        float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
        color.rgb = mix(color.rgb, vec3(gray), (intensity - 0.85) * 2.0);
        color.r += 0.05 * intensity; // Subtler tint
    }

    COLOR = color;
}
