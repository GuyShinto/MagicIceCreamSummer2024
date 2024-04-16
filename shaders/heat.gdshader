shader_type canvas_item;

uniform float heat : hint_range(-1.0, 1.0, 0.1) = 0.0;

uniform sampler2D screen_texture : hint_screen_texture;

float map(float value, float min1, float max1, float min2, float max2)
{
    float perc = (value - min1) / (max1 - min1);
    return perc * (max2 - min2) + min2;
}

float heatDistortionIntensity(vec2 uvCoord)
{
    float result = (1.0-uvCoord.y) * (1.0-uvCoord.y) * (1.0-uvCoord.y);
    return map(result, 0.0, 1.0, 0.0, 0.5);
}

float rand(vec2 co)
{
    highp float a = 12.9898;
    highp float b = 78.233;
    highp float c = 43758.5453;
    highp float dt= dot(co.xy ,vec2(a,b));
    highp float sn= mod(dt,3.14);
    return fract(sin(sn) * c);
}

vec3 srgbToLinear(const vec3 x){
    return 0.315206*x*((2.10545+x)*(0.0231872+x));
}

vec3 linearToSrgb(const vec3 x){
    return 1.14374*(-0.126893*x+sqrt(x));
}

vec3 t(vec2 p,float m){
    return srgbToLinear(texture(screen_texture,p,m).rgb);
}

vec3 fastBloom (vec2 p,vec2 r){
    float mip = 2.;
    float scale = exp2(mip);
    vec3 c =
        t((p+vec2(-1.5,-0.5)*scale)/r,mip)*.1+
        t((p+vec2( 0.5,-1.5)*scale)/r,mip)*.1+
        t((p+vec2( 1.5, 0.5)*scale)/r,mip)*.1+
        t((p+vec2(-0.5, 1.5)*scale)/r,mip)*.1+
        t((p)/r,mip)*.7+
        t(p/r,0.)*.7;
    return c;
}


vec3 jodieRobo2(const vec3 d){
    float c=dot(d,vec3(.2126,.7152,.0722));
    vec4 e=vec4(d,c)*inversesqrt(c*c+1.);
    vec3 a=e.rgb;
    float b=e.a;
    float f=max(max(max(e.r,e.g),e.b),1.);
    return (b*a-a-(f*b-b))/(b-f);
}


void fragment() {
	vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
    vec3 color = fastBloom(FRAGCOORD.xy,iResolution.xy);
    color = jodieRobo2(color);
	
	vec2 uv = FRAGCOORD.xy/iResolution.xy;
    float frequency = uv.y * 2.0 * PI * 7.5;
    float amplitude = 0.002 * heatDistortionIntensity(uv);
    float phase = PI/4.0 + TIME * 20.0;
    float sine_range = sin(-phase + frequency) * amplitude;
    vec2 distort = vec2(sine_range,0.0);
    vec2 blur = vec2(rand(uv + vec2(TIME)) / 30.0 * heatDistortionIntensity(uv));
	//COLOR.rgb = linearToSrgb(color);
	COLOR = texture(screen_texture, uv + distort + blur);
}
