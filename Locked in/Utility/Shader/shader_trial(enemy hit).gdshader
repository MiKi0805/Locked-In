
shader_type canvas_item;

void fragment() {
	vec2 center = vec2(0.50000, 0.50000); 
	float dist_to_center = distance(UV, center);
	if(dist_to_center > sin(TIME) * 5.0)
	{
		COLOR.rgba = vec4(1, 1, 1, 1);
	}
}
