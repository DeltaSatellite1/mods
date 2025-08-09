local ended = false
function onCreate()
    makeAnimatedLuaSprite('boyBG','characters/BOYFRIEND',1100,500)
    addAnimationByPrefix('boyBG','idle','BF idle dance',24,false)
    setObjectOrder('boyBG',getObjectOrder('boyfriendGroup'))
    addLuaSprite('boyBG',false)
end
function onUpdate()
    if curStep > 32 and not ended then
        ended = true
        triggerEvent('Camera Follow Pos','','')
    elseif curStep < 32 then
        setProperty('camGame.zoom',0.9)
    end
end
function onCreatePost()
    triggerEvent('Camera Follow Pos',700,500)
    characterPlayAnim('boyfriend','intro',true)
    setProperty('boyfriend.specialAnim',true)
    setProperty('dad.x',getProperty('dad.x') - 500)
end
function onBeatHit()
    if curBeat < 20 then
        objectPlayAnimation('boyBG','idle',false)
    end
end
function onStepHit()
    if curStep >= 47 then
        doTweenX('charlesX','dad',getProperty('dad.x') + 700,2,'quartOut')
        removeLuaSprite('boyBG',true)
        close(true)
    end
end