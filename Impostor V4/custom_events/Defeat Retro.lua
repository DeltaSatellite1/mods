local bgOrder = nil
local defeatCreated = false
function onCreate()
    precacheImage('defeatfnf')
end
function createDefeat()
    if defeatCreated == false then
        makeLuaSprite('defeatBGEvent','defeatfnf',getProperty('dadGroup.x') - 600,getProperty('dadGroup.y') - 350)
        scaleObject('defeatBGEvent',2,2)
        setProperty('defeatBGEvent.alpha',0.6)
        addLuaSprite('defeatBGEvent',false)
        defeatCreated = true
    end
end
function onEvent(name,v1)
    if name == "Defeat Retro" then
        if v1 ~= '0' then
            if not defeatCreated then
                createDefeat()
            end
            if bgOrder == nil then
                if getObjectOrder('boyfriendGroup') < getObjectOrder('dadGroup') then
                    bgOrder = getObjectOrder('boyfriendGroup') - 1
                else
                    bgOrder = getObjectOrder('dadGroup') - 1
                end
                setObjectOrder('defeatBGEvent',bgOrder)
            end
            addLuaSprite('defeatBGEvent',false)
        else
            removeLuaSprite('defeatBGEvent',true)
            bgOrder = nil
            defeatCreated = false
        end
    end
end
function onBeatHit()
    if curBeat % 4 == 0 and defeatCreated then
        setProperty('defeatBGEvent.alpha',1)
        doTweenAlpha('defeatBGEventLol','defeatBGEvent',0.5,1,'linear')
    end
end