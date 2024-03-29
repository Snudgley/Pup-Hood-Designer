shader_type canvas_item;

uniform int base;
uniform int crownneck;
uniform int brow;
uniform int bridge;
uniform int nose;
uniform int muzzle;
uniform int lip;
uniform int chin;
uniform int inner_chin;
uniform int tongue;
uniform int ear_c;
uniform int ear_a;
uniform int ear_b;
uniform int jowl_colour;
uniform int muzzle_detail_b_colour;

const vec3 neo_aqua = vec3(0.011764705882352941, 0.5372549019607843, 0.8705882352941177);
const vec3 neo_brown = vec3(0.33725490196078434, 0.16862745098039217, 0.07450980392156863);
uniform sampler2D neo_camo: hint_albedo;
const vec3 neo_cobalt = vec3(0, 0.3411764705882353, 0.6901960784313725);
const vec3 neo_grey = vec3(0.27058823529411763, 0.24705882352941178, 0.22745098039215686);
const vec3 neo_hunter = vec3(0.00392156862745098, 0.34509803921568627, 0.17647058823529413);
const vec3 neo_lime = vec3(0.21568627450980393, 0.996078431372549, 0);
const vec3 neo_matte = vec3(0.0784313725490196, 0.06274509803921569, 0.050980392156862744);
const vec3 neo_navy = vec3(0.00392156862745098, 0, 0.23921568627450981);
const vec3 neo_orange = vec3(0.9921568627450981, 0.4196078431372549, 0.00392156862745098);
const vec3 neo_pink = vec3(0.996078431372549, 0.1803921568627451, 0.4117647058823529);
const vec3 neo_purple = vec3(0.32941176470588235, 0, 0.5607843137254902);
const vec3 neo_red = vec3(0.6901960784313725, 0, 0.00392156862745098);
const vec3 neo_royal = vec3(0.10196078431372549, 0.13725490196078433, 0.4117647058823529);
const vec3 neo_shiny = vec3(0.10588235294117647, 0.10196078431372549, 0.09803921568627451);
uniform sampler2D neo_textured: hint_albedo;
const vec3 neo_white = vec3(0.9647058823529412, 0.9450980392156862, 0.9215686274509803);
const vec3 neo_yellow = vec3(1, 0.9294117647058824, 0.011764705882352941);

const vec3 lea_baby_blue = vec3(0.5215686274509804, 0.6431372549019608, 0.8117647058823529);
const vec3 lea_black = vec3(0.07450980392156863, 0.07450980392156863, 0.07450980392156863);
const vec3 lea_brown = vec3(0.3411764705882353, 0.24705882352941178, 0.24313725490196078);
const vec3 lea_dk_blue = vec3(0.13725490196078433, 0.2196078431372549, 0.5137254901960784);
const vec3 lea_dk_brown = vec3(0.21568627450980393, 0.17254901960784313, 0.1803921568627451);
const vec3 lea_golden = vec3(0.8313725490196079, 0.6431372549019608, 0.20392156862745098);
const vec3 lea_grey = vec3(0.4117647058823529, 0.4, 0.43529411764705883);
const vec3 lea_hot_pink = vec3(0.9137254901960784, 0.45098039215686275, 0.6235294117647059);
const vec3 lea_hunter = vec3(0.00784313725490196, 0.4392156862745098, 0.2784313725490196);
const vec3 lea_lime = vec3(0.5607843137254902, 0.803921568627451, 0.3137254901960784);
const vec3 lea_med_blue = vec3(0.0392156862745098, 0.4196078431372549, 0.788235294117647);
const vec3 lea_orange = vec3(0.8862745098039215, 0.4745098039215686, 0.1803921568627451);
const vec3 lea_pink = vec3(0.8509803921568627, 0.6745098039215687, 0.6549019607843137);
const vec3 lea_purple = vec3(0.35294117647058826, 0.23137254901960785, 0.49411764705882355);
const vec3 lea_red = vec3(0.6588235294117647, 0.1450980392156863, 0.16862745098039217);
const vec3 lea_tan = vec3(0.5725490196078431, 0.3607843137254902, 0.23921568627450981);
const vec3 lea_turquoise = vec3(0.03529411764705882, 0.45098039215686275, 0.6313725490196078);
const vec3 lea_white = vec3(0.9098039215686274, 0.8941176470588236, 0.8862745098039215);
const vec3 lea_yellow = vec3(0.8588235294117647, 0.7725490196078432, 0.17254901960784313);

uniform sampler2D pattern;

uniform bool Leather;
uniform bool original_texture;
uniform bool export;
uniform float scale = 1;

const float e = 1.0e-10; //0.0000000001
const vec4 K_S = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
const vec4 K_C = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);


vec3 output_colour(int colour, vec2 UV_multiplied_by_Stretch) {
	if (Leather) {
		if (colour < 9) {
			if (colour == 0){
				return lea_red;
			} 
			else if (colour == 1){
				return lea_orange;
			}
			else if (colour == 2){
				return lea_golden;
			}
			else if (colour == 3){
				return lea_yellow;
			}
			else if (colour == 4){
				return lea_lime;
			}
			else if (colour == 5){
				return lea_hunter;
			}
			else if (colour == 6){
				return lea_baby_blue;
			}
			else if (colour == 7){
				return lea_turquoise;
			}
			else if (colour == 8){
				return lea_med_blue;
			}
		}
		else {
			if (colour == 9){
				return lea_dk_blue;
			}
			else if (colour == 10){
				return lea_purple;
			}
			else if (colour == 11){
				return lea_hot_pink;
			}
			else if (colour == 12){
				return lea_pink;
			}
			else if (colour == 13){
				return lea_white;
			}
			else if (colour == 14){
				return lea_grey;
			}
			else if (colour == 15){
				return lea_black;
			}
			else if (colour == 16){
				return lea_dk_brown;
			}
			else if (colour == 17){
				return lea_brown;
			}
			else if (colour == 18){
				return lea_tan;
			}
		}
	}
	else {
		if (colour < 9) {
			if (colour == 0){
				return neo_red;
			} 
			else if (colour == 1){
				return neo_orange;
			}
			else if (colour == 2){
				return neo_yellow;
			}
			else if (colour == 3){
				return neo_lime;
			}
			else if (colour == 4){
				return neo_hunter;
			}
			else if (colour == 5){
				return neo_aqua;
			}
			else if (colour == 6){
				return neo_cobalt;
			}
			else if (colour == 7){
				return neo_royal;
			}
			else if (colour == 8){
				return neo_navy;
			}
		}
		else {
			if (colour == 9){
				return neo_purple;
			}
			else if (colour == 10){
				return neo_pink;
			}
			else if (colour == 11){
				return neo_white;
			}
			else if (colour == 12){
				return neo_grey;
			}
			else if (colour == 13){
				return neo_matte;
			}
			else if (colour == 14){
				return neo_shiny;
			}
			else if (colour == 15){
				return texture(neo_textured, UV_multiplied_by_Stretch * 8322.03174603).rgb;
			}
			else if (colour == 16){
				return texture(neo_camo, UV_multiplied_by_Stretch * 1024.0).rgb;
			}
			else if (colour == 17){
				return neo_brown;
			}
		}
	}
	return vec3(0,0,0);
}

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
			
			vec2 UV_multiplied_by_Stretch = UV * TEXTURE_PIXEL_SIZE.yx * scale;
			
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
			
			vec3 combine_layers;
			
			if(image_hue < 0.025)
			{
				vec3 c = output_colour(base, UV_multiplied_by_Stretch);
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				combine_layers += vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(image_hue < 0.09166666666)
			{
				vec3 c = output_colour(crownneck, UV_multiplied_by_Stretch);
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				combine_layers += vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(image_hue < 0.15833333333)
			{
				vec3 c = output_colour(brow, UV_multiplied_by_Stretch);
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				combine_layers += vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(image_hue < 0.225)
			{
				vec3 c = output_colour(bridge, UV_multiplied_by_Stretch);
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				combine_layers += vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(image_hue < 0.29166666666)
			{
				vec3 c = output_colour(nose, UV_multiplied_by_Stretch);
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				combine_layers += vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(image_hue < 0.35833333333)
			{
				vec3 c = output_colour(muzzle, UV_multiplied_by_Stretch);
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				combine_layers += vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(image_hue < 0.425)
			{
				vec3 c = output_colour(lip, UV_multiplied_by_Stretch);
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				combine_layers += vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(image_hue < 0.49166666666)
			{
				vec3 c = output_colour(chin, UV_multiplied_by_Stretch);
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				combine_layers += vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(image_hue < 0.55833333333)
			{
				vec3 c = output_colour(inner_chin, UV_multiplied_by_Stretch);
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				combine_layers += vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(image_hue < 0.625)
			{
				vec3 c = output_colour(tongue, UV_multiplied_by_Stretch);
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				combine_layers += vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(image_hue < 0.69166666666)
			{
				vec3 c = output_colour(ear_c, UV_multiplied_by_Stretch);
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				combine_layers += vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(image_hue < 0.75833333333)
			{
				vec3 c = output_colour(ear_a, UV_multiplied_by_Stretch);
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				combine_layers += vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(image_hue < 0.825)
			{
				vec3 c = output_colour(ear_b, UV_multiplied_by_Stretch);
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				combine_layers += vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(image_hue < 0.89166666666)
			{
				vec3 c = output_colour(jowl_colour, UV_multiplied_by_Stretch);
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				combine_layers += vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			else if(image_hue < 0.95833333333)
			{
				vec3 c = output_colour(muzzle_detail_b_colour, UV_multiplied_by_Stretch);
				vec4 p = mix(vec4(c.bg, K_S.wz), vec4(c.gb, K_S.xy), step(c.b, c.g));
				vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
				float d = q.x - min(q.w, q.y);
				combine_layers += vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
			}
			
//			vec3 combine_layers = base_out + crownneck_out + brow_out + bridge_out + nose_out + muzzle_out + lip_out + chin_out + inner_chin_out + tongue_out + ear_c_out + ear_a_out + ear_b_out + jowl_out + muzzle_detail_b_out;
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
			vec3 combined_pattern = combined_hsv * mix(vec3(1.0), texture(pattern, UV_multiplied_by_Stretch).rgb, image_saturation);
			COLOR.rgb = combined_pattern;
			COLOR.a = image.a;

		}
	}
}