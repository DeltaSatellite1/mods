function onCreate()
    makeLuaSprite('tripleBG','ttv4',0,0)
    setScrollFactor('tripleBG',0.9,0.9)
    addLuaSprite('tripleBG',false)

    makeLuaSprite('tripleGround','ttv4fg',50,50)
    scaleObject('tripleGround',1.4,1.3)
    addLuaSprite('tripleGround',false)
end
function onCreatePost()
    initLuaShader('WiggleEffect')
    setSpriteShader('tripleBG','WiggleEffect')
    setShaderFloat('tripleBG','uSpeed',1)
    setShaderFloat('tripleBG','uFrequency',5)
    setShaderFloat('tripleBG','uWaveAmplitude',0.1)
    setShaderFloat('tripleBG','effectType',0)
end

local elap = 0
function onUpdate(el)
    elap = (elap + el)
    setShaderFloat('tripleBG','uTime',elap)
end