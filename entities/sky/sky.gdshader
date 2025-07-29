shader_type sky;

uniform sampler2D noise: repeat_enable;
uniform sampler3D noise3: repeat_enable;

uniform float accumulated_offset = 0.0;

void sky() {
	COLOR = vec3(1.0, 1.0, 0.0) * smoothstep(0.8, 1.0, texture(noise3, EYEDIR + vec3(0.005, 0., 0.)).r);
	COLOR += vec3(1.0) * smoothstep(0.75, 1.0, texture(noise3, EYEDIR + vec3( 0.015, 0.2, 0.)).r);
	COLOR += vec3(.2, .2, .6) * smoothstep(0.86, 1.0, texture(noise3, EYEDIR + vec3(-0.025, -0.2, 0.)).r);
}