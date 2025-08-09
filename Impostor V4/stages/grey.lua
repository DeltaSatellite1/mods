function onCreate()
    makeLuaSprite('greyBG','airship/graybg',0,0)
    addLuaSprite('greyBG',false)
    makeAnimatedLuaSprite('greyGlowy','airship/grayglowy',1930,400)
    addAnimationByPrefix('greyGlowy','glowy','jar??',24,true)
    addLuaSprite('greyGlowy',false)
    makeAnimatedLuaSprite('blackGray','airship/grayblack',240,350)
    addAnimationByPrefix('blackGray','idle','whoisthismf',24,false)
    addLuaSprite('blackGray',false)
    if not lowQuality then
        makeLuaSprite('greyBody','airship/grayfg',150,0)
        setScrollFactor('greyBody',1.1,1)
        addLuaSprite('greyBody',true)
    end
    makeLuaSprite('greyLight','airship/graymultiply',0,0)
    setBlendMode('greyLight','multiply')
    addLuaSprite('greyLight',true)
    makeLuaSprite('greyLight2','airship/grayoverlay',0,0)
    setProperty('greyLight2.alpha',0.2)
    setBlendMode('greyLight2','multiply')
    addLuaSprite('greyLight2',true)
end
function onBeatHit()
    if curBeat % 2 == 0 then
        objectPlayAnimation('blackGray','idle',false)
    end
end

