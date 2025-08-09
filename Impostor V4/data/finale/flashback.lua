function onCreate()
    makeAnimatedLuaSprite('finaleFlashback','finale/finaleFlashback',0,0)
    addAnimationByPrefix('finaleFlashback','moog','finaleFlashback moog',0,true)
    addAnimationByPrefix('finaleFlashback','toog','finaleFlashback toog',0,true)
    addAnimationByPrefix('finaleFlashback','doog','finaleFlashback doog',0,true)
    scaleObject('finaleFlashback',0.6653,0.665)
    setProperty('finaleFlashback.alpha',0.001)
    setObjectCamera('finaleFlashback','other')
    addLuaSprite('finaleFlashback',false)
end
function onBeatHit()
    if curBeat == 16 then
        setProperty('finaleFlashback.alpha',0.5)
        objectPlayAnimation('finaleFlashback','moog',false)
    elseif curBeat == 20 then
        objectPlayAnimation('finaleFlashback','toog',false)
    elseif curBeat == 24 then
        objectPlayAnimation('finaleFlashback','doog',false)
    elseif curBeat >= 32 then
        removeLuaSprite('finaleFlashback',true)
        --close(false)
    end
end
function onUpdate()
    if curBeat >= 32 and curBeat < 48 then --first to black
        triggerEvent('Camera Follow Pos', 450, 1000)
    end
    if curBeat >= 48 and curBeat < 64 then --to bf
        triggerEvent('Camera Follow Pos', 1250, 1000)
    end
    if curBeat >= 64 and curBeat < 66 then --bf zoom in
        triggerEvent('Camera Follow Pos', 1400, 1050)
        setProperty('defaultCamZoom',1.2)
    end
    if curBeat == 67 then
        triggerEvent('Camera Follow Pos','','')
    end
end