#pragma header

uniform vec3 r;
uniform vec3 g;
uniform vec3 b;
uniform float mult;
uniform bool enabled;
vec4 flixel_texture2DCustom(sampler2D bitmap, vec2 coord) {
    vec4 color = flixel_texture2D(bitmap, coord);
    if (!hasTransform) {
        return color;
    }

    if(color.a == 0.0 || mult == 0.0) {
        return color * openfl_Alphav;
    }

    vec4 newColor = color;
    newColor.rgb = min(color.r * r + color.g * g + color.b * b, vec3(1.0));
    newColor.a = color.a;
    
    color = mix(color, newColor, mult);
    
    if(color.a > 0.0) {
        return vec4(color.rgb, color.a);
    }
    return vec4(0.0, 0.0, 0.0, 0.0);
}
void main() {
    vec4 color;
    if(enabled == true){
        color = flixel_texture2DCustom(bitmap, openfl_TextureCoordv);
    }
    else{
        color = flixel_texture2D(bitmap, openfl_TextureCoordv);
    }
    gl_FragColor = color;
}