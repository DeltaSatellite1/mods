#pragma header

uniform float strength;
void main()
{
    vec4 color = flixel_texture2D(bitmap,openfl_TextureCoordv);
    color.rgb = mix(color.rgb,vec3((color.r + color.b + color.g)/3.0),strength);
    gl_FragColor = color;
}