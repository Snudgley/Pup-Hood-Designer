shader_type spatial;
render_mode unshaded, async_visible;

uniform sampler2D original : hint_white;

void fragment() {
	ALBEDO = texture(original, UV).rgb;
}