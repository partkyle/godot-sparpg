shader_type spatial;
render_mode unshaded;

uniform sampler2D noise;

float sdCircle( vec2 p, float r )
{
    return length(p) - r;
}

void vertex() {
	// Billboard Mode: Enabled
	MODELVIEW_MATRIX = VIEW_MATRIX * mat4(
			MAIN_CAM_INV_VIEW_MATRIX[0],
			MAIN_CAM_INV_VIEW_MATRIX[1],
			MAIN_CAM_INV_VIEW_MATRIX[2],
			MODEL_MATRIX[3]);
	MODELVIEW_NORMAL_MATRIX = mat3(MODELVIEW_MATRIX);
}

void fragment() {
	vec4 val = texture(noise, UV + TIME);
	float radius = 1.0 - step(0.9, sdCircle(UV * 4.0 - 2.0, .5));
	ALBEDO = val.rgb;
	ALPHA = val.a * radius;
	ALPHA_SCISSOR_THRESHOLD = .5;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
