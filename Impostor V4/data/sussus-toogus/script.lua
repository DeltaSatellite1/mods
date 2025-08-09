function onCreate()
    makeAnimatedLuaSprite('Cyan','mira/cyan_toogus',-600,275)
    addAnimationByPrefix('Cyan','anim','Cyan Dancy',24,true)
    setProperty('Cyan.alpha',0.001)
    addLuaSprite('Cyan',true)
end
local active = false
function onBeatHit()
    if curBeat == 224 and not active then
        doTweenX('saxGuy','Cyan',1500,15,'linear')
        objectPlayAnimation('Cyan','anim',true)
        setProperty('Cyan.alpha',1)
        active = true
    end
end
function onTweenCompleted(tag)
    if tag == 'saxGuy' then
        removeLuaSprite('Cyan',true)
    end
end
