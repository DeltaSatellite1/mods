function onCreate()
    makeLuaSprite('O2light','airship/O2lighting',-100,0)
    setProperty('O2light.alpha',0.01)
    scaleObject('O2light',1.2,1.2)
    setObjectCamera('O2light','hud')
    addLuaSprite('O2light',false)
end
function onStepHit()
    if curStep >= 480 then
        setProperty('O2light.alpha',1)
    end
end
function onUpdate()
    if curStep >= 470 then
        if mustHitSection == false then
            setProperty('camFollow.x',840)
        else
            setProperty('camFollow.x',1500)
        end
        setProperty('isCameraOnForcedPos',true)
    end
end