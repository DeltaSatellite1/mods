#pragma header

uniform float uTime;
uniform int effectType;
uniform float uSpeed;
uniform float uFrequency;
uniform float uWaveAmplitude;

vec2 sineWave(vec2 pt)
{
    float x = 0.0;
    float y = 0.0;
    
    if (effectType == 0) 
    {
        float offsetX = sin(pt.y * uFrequency + uTime * uSpeed) * uWaveAmplitude;
        pt.x += offsetX; // * (pt.y - 1.0); // <- Uncomment to stop bottom part of the screen from moving
    }
    else if (effectType == 1) 
    {
        float offsetY = sin(pt.x * uFrequency + uTime * uSpeed) * uWaveAmplitude;
        pt.y += offsetY; // * (pt.y - 1.0); // <- Uncomment to stop bottom part of the screen from moving
    }
    else if (effectType == 2)
    {
        x = sin(pt.x * uFrequency + uTime * uSpeed) * uWaveAmplitude;
    }
    else if (effectType == 3)
    {
        y = sin(pt.y * uFrequency + uTime * uSpeed) * uWaveAmplitude;
    }
    else if (effectType == 4)
    {
        y = sin(pt.y * uFrequency + 10.0 * pt.x + uTime * uSpeed) * uWaveAmplitude;
        x = sin(pt.x * uFrequency + 5.0 * pt.y + uTime * uSpeed) * uWaveAmplitude;
    }
    
    return vec2(pt.x + x, pt.y + y);
}

void main()
{
    vec2 uv = sineWave(openfl_TextureCoordv);
    gl_FragColor = texture2D(bitmap, uv);
}