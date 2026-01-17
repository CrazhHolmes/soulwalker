shader_type canvas_item;

uniform float redaction_level : hint_range(0.0, 1.0) = 0.5;
uniform sampler2D noise_tex;
uniform vec2 reveal_pos;
uniform float reveal_radius = 0.1;
uniform bool use_magnifier = false;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    float noise = texture(noise_tex, UV).r;
    
    // Redaction logic: if noise > redaction_level, it's blacked out
    float is_redacted = step(1.0 - redaction_level, noise);
    
    // Magnifier logic: if within radius of reveal_pos, reveal it
    if (use_magnifier) {
        float dist = distance(UV, reveal_pos);
        if (dist < reveal_radius) {
            float fade = smoothstep(reveal_radius, reveal_radius * 0.8, dist);
            is_redacted *= (1.0 - fade);
        }
    }
    
    // Apply redaction: blend to black
    vec3 final_color = mix(tex_color.rgb, vec3(0.05, 0.05, 0.08), is_redacted);
    COLOR = vec4(final_color, tex_color.a);
}
