shader_type canvas_item;


uniform float amplitude = 200;
uniform float frequency = 1.0;
uniform float speed = 2.0;
uniform float amplitude_vertical = 200.0;
uniform float frequency_vertical = 200.0;
uniform float speed_vertical = 2.0;
uniform vec2 scroll_direction = vec2(20.0, 20.0);
uniform float scrolling_speed = 0.08;
uniform bool enable_palette_cycling = false;
uniform sampler2D palette;
uniform float palette_speed = 0.1;

void fragment()
{
	float diff_x = amplitude * sin((frequency * UV.y) + (speed * TIME));
	float diff_y = amplitude_vertical * sin((frequency_vertical * UV.y)  + (speed_vertical * TIME));
	vec2 scroll = scroll_direction * TIME * scrolling_speed;
	vec4 tex = texture(TEXTURE, vec2(UV.x + diff_x, UV.y + diff_y) + scroll);
	float palette_swap = mod(tex.r - TIME * palette_speed, 1.0);

	COLOR = tex;

}