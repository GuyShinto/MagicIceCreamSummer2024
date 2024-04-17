shader_type canvas_item;

uniform float timescale = 1.0;
uniform float power = 2.0;
uniform float time = 0.0;
uniform float fade = 0.0;
uniform vec2 local;

uniform sampler2D screen_texture : hint_screen_texture;

float create_ripple(vec2 coord, vec2 ripple_coord, float scale, float radius, float range, float height) {
	float dist = distance(coord, ripple_coord);
    return sin(dist / scale) * height * smoothstep(dist - range, dist + range, radius);
}

vec2 get_normals(vec2 coord, vec2 ripple_coord, float scale, float radius, float range, float height) {
    return vec2(
        create_ripple(coord + vec2(1.0, 0.0), ripple_coord, scale, radius, range, height) -
        create_ripple(coord - vec2(1.0, 0.0), ripple_coord, scale, radius, range, height),
        create_ripple(coord + vec2(0.0, 1.0), ripple_coord, scale, radius, range, height) -
        create_ripple(coord - vec2(0.0, 1.0), ripple_coord, scale, radius, range, height)
    ) * 0.5;
}

void fragment() {
	vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 ps = vec2(1.0) / iResolution.xy;
    vec2 uv = FRAGCOORD.xy * ps;
    float t = fract((time+0.1) * timescale);
    vec2 center = local;
    vec2 normals = get_normals(FRAGCOORD.xy, center, t * 100.0 + 1.0, 200.0 * power, 200.0, 2000.0);
    COLOR = texture(screen_texture, mix(uv,uv + normals * ps,fade));
}
