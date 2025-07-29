shader_type spatial;

uniform sampler3D noise_texture: repeat_enable;

varying vec3 vertex_interpolated;

void vertex() {
	vertex_interpolated = VERTEX;
}

void fragment() {
	vec3 noise = texture(noise_texture, vertex_interpolated).rgb;

	ALBEDO = noise;
}