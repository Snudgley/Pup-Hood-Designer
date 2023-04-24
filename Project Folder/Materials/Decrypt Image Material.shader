shader_type canvas_item;

uniform sampler2D base: hint_albedo;
uniform sampler2D crownneck: hint_albedo;
uniform sampler2D brow: hint_albedo;
uniform sampler2D bridge: hint_albedo;
uniform sampler2D nose: hint_albedo;
uniform sampler2D muzzle: hint_albedo;
uniform sampler2D lip: hint_albedo;
uniform sampler2D chin: hint_albedo;
uniform sampler2D inner_chin: hint_albedo;
uniform sampler2D tongue: hint_albedo;
uniform sampler2D ear_c: hint_albedo;
uniform sampler2D ear_a: hint_albedo;
uniform sampler2D ear_b: hint_albedo;
uniform sampler2D jowl_colour: hint_albedo;
uniform sampler2D muzzle_detail_b_colour: hint_albedo;

uniform sampler2D pattern;
uniform bool original_texture;
uniform bool export;

const float number_of_parts = 15.0;
const float hue_threshold = 0.025;// 0.035;

const float e = 1.0e-10; //0.0000000001
const vec4 K_S = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
const vec4 K_C = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);


void fragment() {
	if (original_texture){
		COLOR = texture(TEXTURE, UV);
	}
	else {
		vec4 image = texture(TEXTURE, UV);
		
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
			vec2 base_size = vec2(textureSize(TEXTURE, 0));
			
			vec3 base_out;
			vec3 crownneck_out;
			vec3 brow_out;
			vec3 bridge_out;
			vec3 nose_out;
			vec3 muzzle_out;
			vec3 lip_out;
			vec3 chin_out;
			vec3 inner_chin_out;
			vec3 tongue_out;
			vec3 ear_c_out;
			vec3 ear_a_out;
			vec3 ear_b_out;
			vec3 jowl_out;
			vec3 muzzle_detail_b_out;
			
			if(abs(image_hue) < hue_threshold)
			{
				vec2 texture_size = vec2(textureSize(base, 0));
				vec2 uv_stretch = base_size / texture_size;
				vec3 c = texture(base, UV * uv_stretch).rgb;
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				base_out = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(abs(image_hue - ((1.0 / number_of_parts) * 1.0)) < hue_threshold)
			{
				vec2 texture_size = vec2(textureSize(crownneck, 0));
				vec2 uv_stretch = base_size / texture_size;
				vec3 c = texture(crownneck, UV * uv_stretch).rgb;
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				crownneck_out = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(abs(image_hue - ((1.0 / number_of_parts) * 2.0)) < hue_threshold)
			{
				vec2 texture_size = vec2(textureSize(brow, 0));
				vec2 uv_stretch = base_size / texture_size;
				vec3 c = texture(brow, UV * uv_stretch).rgb;
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				brow_out = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(abs(image_hue - ((1.0 / number_of_parts) * 3.0)) < hue_threshold)
			{
				vec2 texture_size = vec2(textureSize(bridge, 0));
				vec2 uv_stretch = base_size / texture_size;
				vec3 c = texture(bridge, UV * uv_stretch).rgb;
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				bridge_out = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(abs(image_hue - ((1.0 / number_of_parts) * 4.0)) < hue_threshold)
			{
				vec2 texture_size = vec2(textureSize(nose, 0));
				vec2 uv_stretch = base_size / texture_size;
				vec3 c = texture(nose, UV * uv_stretch).rgb;
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				nose_out = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(abs(image_hue - ((1.0 / number_of_parts) * 5.0)) < hue_threshold)
			{
				vec2 texture_size = vec2(textureSize(muzzle, 0));
				vec2 uv_stretch = base_size / texture_size;
				vec3 c = texture(muzzle, UV * uv_stretch).rgb;
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				muzzle_out = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(abs(image_hue - ((1.0 / number_of_parts) * 6.0)) < hue_threshold)
			{
				vec2 texture_size = vec2(textureSize(lip, 0));
				vec2 uv_stretch = base_size / texture_size;
				vec3 c = texture(lip, UV * uv_stretch).rgb;
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				lip_out = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(abs(image_hue - ((1.0 / number_of_parts) * 7.0)) < hue_threshold)
			{
				vec2 texture_size = vec2(textureSize(chin, 0));
				vec2 uv_stretch = base_size / texture_size;
				vec3 c = texture(chin, UV * uv_stretch).rgb;
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				chin_out = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(abs(image_hue - ((1.0 / number_of_parts) * 8.0)) < hue_threshold)
			{
				vec2 texture_size = vec2(textureSize(inner_chin, 0));
				vec2 uv_stretch = base_size / texture_size;
				vec3 c = texture(inner_chin, UV * uv_stretch).rgb;
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				inner_chin_out = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(abs(image_hue - ((1.0 / number_of_parts) * 9.0)) < hue_threshold)
			{
				vec2 texture_size = vec2(textureSize(tongue, 0));
				vec2 uv_stretch = base_size / texture_size;
				vec3 c = texture(tongue, UV * uv_stretch).rgb;
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				tongue_out = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(abs(image_hue - ((1.0 / number_of_parts) * 10.0)) < hue_threshold)
			{
				vec2 texture_size = vec2(textureSize(ear_c, 0));
				vec2 uv_stretch = base_size / texture_size;
				vec3 c = texture(ear_c, UV * uv_stretch).rgb;
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				ear_c_out = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(abs(image_hue - ((1.0 / number_of_parts) * 11.0)) < hue_threshold)
			{
				vec2 texture_size = vec2(textureSize(ear_a, 0));
				vec2 uv_stretch = base_size / texture_size;
				vec3 c = texture(ear_a, UV * uv_stretch).rgb;
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				ear_a_out = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(abs(image_hue - ((1.0 / number_of_parts) * 12.0)) < hue_threshold)
			{
				vec2 texture_size = vec2(textureSize(ear_b, 0));
				vec2 uv_stretch = base_size / texture_size;
				vec3 c = texture(ear_b, UV * uv_stretch).rgb;
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				ear_b_out = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(abs(image_hue - ((1.0 / number_of_parts) * 13.0)) < hue_threshold)
			{
				vec2 texture_size = vec2(textureSize(jowl_colour, 0));
				vec2 uv_stretch = base_size / texture_size;
				vec3 c = texture(jowl_colour, UV * uv_stretch).rgb;
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				jowl_out = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(abs(image_hue - ((1.0 / number_of_parts) * 14.0)) < hue_threshold)
			{
				vec2 texture_size = vec2(textureSize(muzzle_detail_b_colour, 0));
				vec2 uv_stretch = base_size / texture_size;
				vec3 c = texture(muzzle_detail_b_colour, UV * uv_stretch).rgb;
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				muzzle_detail_b_out = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			
			vec3 combine_layers = base_out + crownneck_out + brow_out + bridge_out + nose_out + muzzle_out + lip_out + chin_out + inner_chin_out + tongue_out + ear_c_out + ear_a_out + ear_b_out + jowl_out + muzzle_detail_b_out;
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
			vec2 pattern_size = vec2(textureSize(pattern, 0));
			vec2 uv_stretch = base_size / pattern_size;
			vec3 combined_pattern = combined_hsv * mix(vec3(1.0), texture(pattern, UV * uv_stretch).rgb, image_saturation);
			COLOR.rgb = combined_pattern;
			COLOR.a = image.a;

		}
	}
}