shader_type spatial;
render_mode specular_schlick_ggx, async_visible;

uniform vec4 base : hint_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform sampler2D original;

uniform bool original_texture;
uniform bool export;

const float number_of_parts = 15.0;
const float hue_threshold = 0.025;// 0.035;

const float e = 1.0e-10; //0.0000000001
const vec4 K_S = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
const vec4 K_C = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);

void vertex() {
	NORMAL = (vec3(COLOR.x, COLOR.z, COLOR.y * -1.0 + 1.0) - vec3(0.5)) * 2.0;
}

void fragment() {
	if (original_texture){
		ALBEDO = texture(original, UV).rgb;
	}
	else {
		vec4 image = texture(original, UV);
		
		float image_hue;
		float image_saturation;
		float image_value;
		{
			vec3 c = image.rgb;
			vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
			vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
			float d = q.x - min(q.w, q.y);
			image_hue = abs(q.z + (q.w - q.y) / (6.0 * d + e));
			image_saturation = d / (q.x + e);
			image_value = q.x;
		}
		
		if (export) {
			ALBEDO = vec3(image_value);
			}
		else {
			
			vec3 base_out;
			
			if(abs(image_hue) < hue_threshold)
			{
				vec3 c = base.rgb;
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				base_out = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			
			
			vec3 combine_layers = base_out;
			vec3 combined_hsv;
			if(image_saturation == 0.0)
			{
				combined_hsv = vec3(image_value);
			}
			else
			{
				vec3 c = vec3(combine_layers.x, mix(0.0, combine_layers.y, image_saturation), mix(0.0, image_value, mix(1.0, combine_layers.z, image_saturation)));//mix(0.0, image_value, mix(1.0, combine_layers.z, image_saturation))        mix(0.0, combine_layers.z, image_value)
				vec3 p = abs(fract(c.xxx + K_C.xyz) * 6.0 - K_C.www);
				combined_hsv = c.z * mix(K_C.xxx, clamp(p - K_C.xxx, 0.0, 1.0), c.y);
			}

			ALBEDO = combined_hsv;

		}
	}
}