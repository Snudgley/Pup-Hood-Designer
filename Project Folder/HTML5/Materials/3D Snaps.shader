shader_type spatial;
render_mode specular_schlick_ggx, async_visible, vertex_lighting;

uniform int face_snaps;
uniform int back_eyelets;
uniform int muzzle_eyelets;

const vec3 Black = vec3(0.2, 0.2, 0.2);
const vec3 Brass = vec3(2.0, 1.50661, 0.634361);
const vec3 Silver = vec3(0.84609375, 0.84609375, 0.84609375);

uniform bool original_texture;
uniform bool export;
uniform sampler2D original;

const float number_of_parts = 3.0;
const float hue_threshold = 0.025;// 0.035;

const float e = 1.0e-10; //0.0000000001
const vec4 K_S = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
const vec4 K_C = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);


uniform sampler2D matcap : hint_black;
//uniform float metalness : hint_range(0.0,1.0) = 1.0;
//uniform vec3 color = vec3(1.0);

void vertex() {
	NORMAL = (vec3(COLOR.x, COLOR.z, COLOR.y * -1.0 + 1.0) - vec3(0.5)) * 2.0;
}

vec3 output_colour(int colour) {//, vec2 UV_multiplied_by_Stretch) {
	if (colour == 0){
		return Black;
	} 
	else if (colour == 1){
		return Silver;
	}
	else if (colour == 2){
		return Brass;
	}
}

void fragment() {
//	ROUGHNESS = 0.0;
//	METALLIC = 1.0;
	
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
			ALBEDO = vec3(1.0);
			}
		else {
//			vec2 UV_multiplied_by_Stretch = UV;
			
			vec3 face_snaps_out;
			vec3 back_eyelets_out;
			vec3 muzzle_eyelets_out;
			
			if(image.r > 0.9)
			{
//				vec3 c = output_colour(face_snaps);
//				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
//				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
//				float d = q.x - min(q.w, q.y);
				face_snaps_out = output_colour(face_snaps);
//				face_snaps_out = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(image.g > 0.9)
			{
//				vec3 c = output_colour(back_eyelets);
//				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
//				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
//				float d = q.x - min(q.w, q.y);
//				back_eyelets_out = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
				back_eyelets_out = output_colour(back_eyelets);
			}
			else if(image.b > 0.9)
			{
//				vec3 c = output_colour(muzzle_eyelets, UV_multiplied_by_Stretch);
//				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
//				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
//				float d = q.x - min(q.w, q.y);
//				muzzle_eyelets_out = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
				muzzle_eyelets_out = output_colour(muzzle_eyelets);
			} else
			{
//				vec3 c = output_colour(muzzle_eyelets, UV_multiplied_by_Stretch);
//				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
//				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
//				float d = q.x - min(q.w, q.y);
//				muzzle_eyelets_out = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
				face_snaps_out = Black;
			}
			
			vec3 combine_layers = face_snaps_out + back_eyelets_out + muzzle_eyelets_out;
//			vec3 combined_hsv;
//			if(image_saturation == 0.0)
//			{
//				combined_hsv = vec3(image_value);
//			}
//			else
//			{
//				vec3 c = vec3(combine_layers.x, mix(0.0, combine_layers.y, image_saturation), mix(0.0, image_value, mix(1.0, combine_layers.z, image_saturation)));//mix(0.0, image_value, mix(1.0, combine_layers.z, image_saturation))        mix(0.0, combine_layers.z, image_value)
//				vec3 p = abs(fract(c.xxx + K_C.xyz) * 6.0 - K_C.www);
//				combined_hsv = c.z * mix(K_C.xxx, clamp(p - K_C.xxx, 0.0, 1.0), c.y);
//			}
			//vec2 pattern_size = vec2(textureSize(pattern, 0));
			//vec2 uv_stretch = base_size / pattern_size;
			//vec3 combined_pattern = combined_hsv * mix(vec3(1.0), texture(pattern, UV * uv_stretch).rgb, image_saturation);
			ALBEDO = combine_layers;
			
			vec2 matcap_uv = (NORMAL.xy * vec2(0.5, -0.5) + vec2(0.5, 0.5));
//			ALBEDO = color.rgb;
			ALBEDO *= texture(matcap, matcap_uv).rgb * 4.0;
		}
	}
}