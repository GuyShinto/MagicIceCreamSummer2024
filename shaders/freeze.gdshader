shader_type canvas_item;

uniform float cool = 0.0;

void fragment() {
	vec3 c = texture(TEXTURE, UV).rgb;
	COLOR.rgb = mix(c,c * vec3(0.5,1.0,1.0),cool);
}