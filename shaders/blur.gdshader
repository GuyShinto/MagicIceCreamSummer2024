shader_type canvas_item;

uniform float power = 0.4;
uniform float Amount = 150.0;
uniform float GOLDEN_ANGLE = 2.39996323;
uniform float NUMBER = 150.0;
uniform sampler2D screen_texture : hint_screen_texture;

vec2 Sample(in float theta, inout float r)
{
    r += 1.0 / r;
	return (r-1.0) * vec2(cos(theta), sin(theta));
}

vec3 Bokeh(sampler2D tex, vec2 uv, float radius, float amount,vec2 resolution)
{
	float ITERATIONS = GOLDEN_ANGLE * NUMBER;
	vec3 acc = vec3(0.0);
	vec3 div = vec3(0.0);
    vec2 pixel = vec2(resolution.y/resolution.x, 1.0) * radius * .006;
    float r = 1.0;
	for (float j = 0.0; j < ITERATIONS; j += GOLDEN_ANGLE)
    {
       	
		vec3 col = texture(tex, uv + pixel * Sample(j, r), radius*1.5).xyz;
		vec3 bokeh = vec3(5.0) + pow(col, vec3(9.0)) * amount;
		acc += col * bokeh;
		div += bokeh;
	}
	return acc / div;
}

void fragment(){
	vec2 Resolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 uv = FRAGCOORD.xy/Resolution.xy;
    float dis = distance(FRAGCOORD.xy, Resolution.xy/2.0);
    COLOR = vec4(Bokeh(screen_texture, uv, power*dis*0.001, Amount,Resolution), 1.0);
}