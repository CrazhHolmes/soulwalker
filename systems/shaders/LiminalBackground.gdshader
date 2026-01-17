shader_type canvas_item;

uniform vec4 background_color : source_color = vec4(0.05, 0.05, 0.1, 1.0);
uniform vec4 line_color : source_color = vec4(0.2, 0.2, 0.3, 0.5);
uniform float line_frequency : hint_range(0.1, 10.0) = 2.0;
uniform float scroll_speed : hint_range(0.0, 1.0) = 0.05;

void fragment() {
    vec2 uv = UV + (TIME * scroll_speed);
    
    // Create a faint, shifting grid for a bureaucratic/liminal feel
    float grid_x = step(0.98, fract(uv.x * line_frequency * 2.0));
    float grid_y = step(0.98, fract(uv.y * line_frequency));
    
    float final_grid = max(grid_x, grid_y);
    
    // Gradient for depth
    float alpha = smoothstep(0.4, 1.0, 1.0 - distance(UV, vec2(0.5, 0.5)));
    
    vec3 final_color = mix(background_color.rgb, line_color.rgb, final_grid * alpha * 0.3);
    
    COLOR = vec4(final_color, 1.0);
}
