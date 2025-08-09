function onCreate()
    makeLuaSprite('cargoBg','airship/cargo',0,0)
    addLuaSprite('cargoBg')

    makeLuaSprite('cargoEffectPink','airship/asdascdac',-410,-400)
    setObjectCamera('cargoEffectPink','other')
    setBlendMode('cargoEffectPink','add')
    setProperty('cargoEffectPink.alpha',0.3)
    scaleObject('cargoEffectPink',1.2,2)
    addLuaSprite('cargoEffectPink',false)

    if songName == "Double Kill" then
        makeLuaSprite('defeatBG','defeat/iluminao omaga',900,400)
        --scaleObject('defeatBGLight',3,3.5)
        setProperty('defeatBG.alpha',0.01)
        addLuaSprite('defeatBG',true)
        setBlendMode('defeatBG','add')
    end
end
function onEvent(name,v1)
    if name == "Double Kill Events" then
        if v1 == "darken" then
            doTweenAlpha('cargoPink','cargoEffectPink',0,3,'linear')
        elseif v1 == 'brighten' then
            setProperty('cargoEffectPink.alpha',0.3)
        end
    end
end
function onStepHit()
    if curStep == 3392 then
        doTweenAlpha('cargoPink','cargoEffectPink',0,1,'linear')
    end
    if curStep == 3408 and songName == "Double Kill" then
        removeLuaSprite('cargoBg',true)
        setProperty('defeatBG.alpha',0.8)
        setProperty('defeatBGLight.alpha',1)
        removeLuaSprite('cargoEffectPink',true)
    end
end
function onBeatHit()
    if curBeat % 4 == 0 and curStep >= 3408 then
        setProperty('defeatBG.alpha',1)
        doTweenAlpha('defeatLol','defeatBG',0.9,0.6,'circOut')
    end
end


