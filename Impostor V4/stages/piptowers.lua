function onCreate()
    makeLuaSprite('sky','back',-1100, -800);
    setLuaSpriteScrollFactor('sky', 0, 0);
    addLuaSprite('sky',false);

    makeLuaSprite('back','backBuildings',-1100, -800);
    setLuaSpriteScrollFactor('back', 0.2, 0.2);
    addLuaSprite('back',false);

    makeLuaSprite('sign','bg2',-1100, -800);
    setLuaSpriteScrollFactor('sign', 0.4, 0.4);
    addLuaSprite('sign',false);

    makeLuaSprite('main','mainBuildings',-1100, -800);
    setLuaSpriteScrollFactor('main', 0.4, 0.4);
    addLuaSprite('main',false);

    makeLuaSprite('glow','glow',-1100, -800);
    setLuaSpriteScrollFactor('glow', 0.5, 0.5);
    setLuaSpriteScrollFactor('glow', 0.5, 0.5);
    setBlendMode('glow', 'ADD');
    addLuaSprite('glow',false);

    makeLuaSprite('balcony','balcony',-1100, -800);
    setLuaSpriteScrollFactor('balcony', 1, 1);
    addLuaSprite('balcony',false);
end