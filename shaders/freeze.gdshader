shader_type canvas_item;

void fragment() {
	vec3 c = texture(TEXTURE, UV).rgb;
	COLOR.rgb = c * vec3(0.5,1.0,1.0);
}