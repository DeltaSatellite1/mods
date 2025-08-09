local time = 0
local enabledGame = false
local enabledHUD = false
function onEvent(name,v1,v2)
    if name == 'shakeCam' then
        time = tonumber(v2)
        if time ~= nil and time ~= 0 then
            local shake = tonumber(v1)
            local shakeStart = 0
            local comma1 = 0
            local comma2 = 0
            local layer = 'game'
            comma1,comma2 = string.find(v1,',',0,true)
            if comma1 ~= nil then
                shakeStart = string.sub(v1,0,comma1 - 1)
                shake = string.sub(v1,comma2 + 1)
            end
            if layer == 'both' then
                shakeEvent('Game',shakeStart,shake,time)
                shakeEvent('HUD',shakeStart,shake,time)
            elseif layer == 'hud' then
                shakeEvent('HUD',shakeStart,shake,time)
            elseif layer == 'game' then
                shakeEvent('Game',shakeStart,shake,time)
            end
        end
    end
end
function shakeEvent(layer,start,endShake,timer)
    cancelTween('shakeCamEvent'..layer)
    makeLuaSprite('shakeCamEvent'..layer,nil,start,0)
    doTweenX('shakeCamEvent'..layer,'shakeCamEvent'..layer,endShake,timer)
    runTimer('stopShakeEvent'..layer,time)
    if string.lower(layer) == 'game' then
        enabledGame = true
    elseif string.lower(layer) == 'hud' then
        enabledHUD = true
    end
end
function onUpdate()
    if enabledGame then
        cameraShake('camGame',getProperty('shakeCamEventGame.x'),time)
    end
    if enabledHUD then
        cameraShake('camHUD',getProperty('shakeCamEventHUD.x'),time)
    end
end
function onTimerCompleted(tag)
    if tag == 'stopShakeEventHUD' then
        if enabledHUD then
            cameraShake('camHUD',0,0)
            removeLuaSprite('shakeCamEventHUD',true)
            enabledHUD = false
        end
    elseif tag == 'stopShakeEventGame' then
        if enabledGame then
            removeLuaSprite('shakeCamEventGame',true)
            cameraShake('camGame',0,0)
            enabledGame = false
        end
    end
end