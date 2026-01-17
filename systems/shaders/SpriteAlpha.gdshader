shader_type canvas_item;

uniform float threshold : hint_range(0.0, 1.0) = 0.3;
uniform vec4 target_color : source_color = vec4(0.2, 0.2, 0.2, 1.0); // Default to dark gray
uniform bool use_target_color = true;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    
    // Calculate brightness
    float brightness = (tex_color.r + tex_color.g + tex_color.b) / 3.0;
    
    if (use_target_color) {
        // Discard if close to the target background color (the dark gray of ChatGPT images)
        if (distance(tex_color.rgb, target_color.rgb) < threshold) {
            discard;
        }
    } else {
        // Fallback to luminance check for white/light backgrounds
        if (brightness > 0.85) {
            discard;
        }
    }
    
    COLOR = tex_color;
}
