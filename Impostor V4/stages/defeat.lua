local defeatCreated = false
function onCreate()
    if not lowQuality then
        makeAnimatedLuaSprite('defeatBG','defeat/defeat',-550,-400)
        setScrollFactor('defeatBG',0.8,0.8)
        scaleObject('defeatBG',1.3,1.3)
        addAnimationByPrefix('defeatBG','bg','defeat',24,false)
    else
        makeLuaSprite('defeatBG','defeatfnf',-600,-300)
        scaleObject('defeatBG',2.3,2.3)
    end
    addLuaSprite('defeatBG',false)

    makeLuaSprite('defeatMountain','defeat/lol thing',-500,150)
    setScrollFactor('defeatMountain',0.9,0.9)
    setProperty('defeatMountain.scale.x',1.3)
    addLuaSprite('defeatMountain',false)
    
    makeLuaSprite('defeatBody','defeat/deadBG',-620,400)
    setScrollFactor('defeatBody',0.9,0.9)
    scaleObject('defeatBody',0.4,0.4)
    addLuaSprite('defeatBody',false)

    makeLuaSprite('defeatBodyFront','defeat/deadFG',-680,700)
    setScrollFactor('defeatBodyFront',1.2,1.2)
    scaleObject('defeatBodyFront',0.4,0.4)
    addLuaSprite('defeatBodyFront',true)

    makeLuaSprite('defeatLight','defeat/iluminao omaga',-550,-200)
    setBlendMode('defeatLight','add')
    addLuaSprite('defeatLight',true)
    if songName == "Defeat" then
        defeatAlpha(0)
        setProperty('defeatLight.alpha',1)
    end
end
function onBeatHit()
    if curBeat % 4 == 0 then
        if not lowQuality then
            objectPlayAnimation('defeatBG','bg',true)
        else
            setProperty('defeatBG.alpha',1)
            doTweenAlpha('defeatBGLol','defeatBG',0.5,0.4,'linear')
        end
    end
end
function defeatAlpha(alpha,all)
    setProperty('defeatBody.alpha',alpha)
    setProperty('defeatBodyFront.alpha',alpha)
    setProperty('defeatMountain.alpha',alpha)
    if all then
        setProperty('defeatLight.alpha',alpha)
        setProperty('defeatBG.alpha',alpha)
    end
end
function onStepHit()
    if curStep >= 272 and not defeatCreated then
        defeatAlpha(1)
        defeatCreated = true
    end
end
function onEvent(name,v1,v2)
    if name == 'DefeatDark' then
        if v1 == '1' then
            defeatAlpha(0,true)
        else
            defeatAlpha(1,true)
        end
    end
end
