shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;
uniform vec2 resolution = vec2(320.0, 180.0);

void fragment() {
	vec4 pixelColor = texture(SCREEN_TEXTURE, SCREEN_UV);
	COLOR = pixelColor;
	COLOR.rgb = COLOR.ggg;
}