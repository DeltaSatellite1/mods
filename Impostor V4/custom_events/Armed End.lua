local enabled = false
function onCreate()
    precacheSound('teleport_sound')
    makeLuaSprite('effectX',nil,0,0)

end
function onCreatePost()
    initLuaShader('ColorShader')
end
function onEvent(name,v1,v2)
    if name == "Armed End" then
        runTimer('armedEnd',0.45)
        runTimer('armedEnd2',1.28)
        runTimer('armedEnd3',1.93)
        runTimer('armedEnd4',2.23)
        runTimer('armedEnd5',2.55)
        runTimer('armedEnd6',2.65)
        runTimer('armedEnd7',2.7)
        runTimer('armedEnd8',2.8)
        playSound('teleport_sound')
        doTweenAlpha('byeCamHUD','camHUD',0,0.7,'quadInOut')
    end
end
function onUpdate()
    if enabled then
        local shaderValue = getProperty('effectX.x')
        setShaderFloat('boyfriend','amount',shaderValue)
        setShaderFloat('gf','amount',shaderValue)
    end
end
function onTimerCompleted(tag)
    if string.find(tag,'armedEnd') ~= nil then
        local target = 0
        local speed = 0
        cancelTween('ArmedEffect')
        setProperty('effectX.x',1)
        if tag == 'armedEnd' then
            target = 0
            speed = 0.73
        elseif tag == 'armedEnd2' then
            target = 0.1
            speed = 0.55
        elseif tag == 'armedEnd3' then
            target = 0.2
            speed = 0.2
        elseif tag == 'armedEnd4' then
            target = 0.4
            speed = 0.22
        elseif tag == 'armedEnd5' then
            target = 0.8
            speed = 0.05
        elseif tag == 'armedEnd6' then
            doTweenX('bfScaleArmed','boyfriend.scale',3.5,0.5,'expoOut')
            doTweenY('bfScaleArmed','boyfriend.scale',0,0.5,'expoOut')
        elseif tag == 'armedEnd7' then
            doTweenX('gfScaleArmed','gf.scale',3.5,0.5,'expoOut')
            doTweenY('gfScaleArmed','gf.scale',0,0.5,'expoOut')
        --[[
        elseif tag == 'armedEnd8' then
            doTweenX('petScaleArmed','pet.scale',3.5,0.5,'expoOut')
            doTweenY('petScaleArmed','pet.scale',0,0.5,'backIn')
            ]]--
        end
        if speed ~= 0 then
            doTweenX('ArmedEffect','effectX',target,speed,'expoOut')
        end
        if not enabled then
            setSpriteShader('boyfriend','ColorShader')
            setSpriteShader('gf','ColorShader')
            enabled = true
        end
    end
end