shader_type canvas_item;

uniform int face_snaps;
uniform int back_eyelets;
uniform int muzzle_eyelets;

const vec3 Black = vec3(0.0, 0.0, 0.0);
const vec3 Brass = vec3(0.88671875, 0.66796875, 0.28125);
const vec3 Silver = vec3(0.74609375, 0.74609375, 0.74609375);

uniform bool original_texture;
uniform bool export;

const float number_of_parts = 3.0;
const float hue_threshold = 0.025;// 0.035;

const float e = 1.0e-10; //0.0000000001
const vec4 K_S = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
const vec4 K_C = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);

vec3 output_colour(int colour, vec2 UV_multiplied_by_Stretch) {
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
	if (original_texture){
		COLOR = texture(TEXTURE, UV);
	}
	else {
		vec4 image = texture(TEXTURE, UV);
		
		vec2 UV_multiplied_by_Stretch = UV;
		
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
			COLOR.rgb = vec3(image_value);
			COLOR.a = image.a;
			}
		else {
			vec2 base_size = vec2(512,512);
			
			vec3 face_snaps_out;
			vec3 back_eyelets_out;
			vec3 muzzle_eyelets_out;
			
			if(abs(image_hue) < hue_threshold)
			{
				vec3 c = output_colour(face_snaps, UV_multiplied_by_Stretch);
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				face_snaps_out = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(abs(image_hue - ((1.0 / number_of_parts) * 1.0)) < hue_threshold)
			{
				vec3 c = output_colour(back_eyelets, UV_multiplied_by_Stretch);
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				back_eyelets_out = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(abs(image_hue - ((1.0 / number_of_parts) * 2.0)) < hue_threshold)
			{
				vec3 c = output_colour(muzzle_eyelets, UV_multiplied_by_Stretch);
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				muzzle_eyelets_out = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			
			vec3 combine_layers = face_snaps_out + back_eyelets_out + muzzle_eyelets_out;
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
			//vec2 pattern_size = vec2(textureSize(pattern, 0));
			//vec2 uv_stretch = base_size / pattern_size;
			//vec3 combined_pattern = combined_hsv * mix(vec3(1.0), texture(pattern, UV * uv_stretch).rgb, image_saturation);
			COLOR.rgb = combined_hsv;
			COLOR.a = image.a;

		}
	}
}