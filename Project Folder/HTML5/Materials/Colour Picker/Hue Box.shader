shader_type canvas_item;

const float e = 1.0e-10; //0.0000000001
const vec4 K_S = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
const vec4 K_C = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);

void fragment() {
    vec3 c = vec3(UV.y, 1.0, 1.0);//mix(0.0, image_value, mix(1.0, combine_layers.z, image_saturation))        mix(0.0, combine_layers.z, image_value)
	vec3 p = abs(fract(c.xxx + K_C.xyz) * 6.0 - K_C.www);
	vec3 output = c.z * mix(K_C.xxx, clamp(p - K_C.xxx, 0.0, 1.0), c.y);
    COLOR = vec4(output, 1);
}

