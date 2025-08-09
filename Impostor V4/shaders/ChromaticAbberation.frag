#pragma header
uniform float amount;

vec2 PincushionDistortion(in vec2 uv, float strength) 
{
    vec2 st = uv - 0.5;
    float uvA = atan(st.x, st.y);
    float uvD = dot(st, st);
    return 0.5 + vec2(sin(uvA), cos(uvA)) * sqrt(uvD) * (1.0 - strength * uvD);
}

vec4 ChromaticAbberation(sampler2D tex, in vec2 uv) 
{
    float rChannel = flixel_texture2D(tex, PincushionDistortion(uv, 0.3 * amount)).r;
    float gChannel = flixel_texture2D(tex, PincushionDistortion(uv, 0.15 * amount)).g;
    float bChannel = flixel_texture2D(tex, PincushionDistortion(uv, 0.075 * amount)).b;
    //float aChannel = flixel_texture2D(tex, PincushionDistortion(uv, 0.075 * amount)).a;
    float aChannel = flixel_texture2D(tex,uv).a;
    return vec4(rChannel, gChannel, bChannel, aChannel);
}

void main()
{
    vec4 col = ChromaticAbberation(bitmap, openfl_TextureCoordv);

    gl_FragColor = vec4(col);
}