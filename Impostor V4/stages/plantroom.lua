local allowEnd = false
local fps = 0
function onCreate()
    makeLuaSprite('plantSky','mira/bg sky',-1500,-800)
    addLuaSprite('plantSky',false)

    if not lowQuality then
        makeLuaSprite('plantCloudBack','mira/cloud fathest',-1300,-100)
        addLuaSprite('plantCloudBack',false)
        makeLuaSprite('plantCloudFront','mira/cloud front',-1200,0)
        addLuaSprite('plantCloudFront',false)
        for cloud = 1,3 do
            makeLuaSprite('plantCloud'..cloud,'mira/cloud '..cloud,0,-1200 - (math.random(100,200) * (cloud -1 )))
            addLuaSprite('plantCloud'..cloud,false)
        end
        makeLuaSprite('plantCloudBig','mira/bigcloud',0,-1200)
        addLuaSprite('plantCloudBig',false)
    end
    makeLuaSprite('plantGlass','mira/glasses',-1200,-750)
    addLuaSprite('plantGlass',false)

    makeAnimatedLuaSprite('plantGrey','mira/crew',-260,-75)
    addAnimationByPrefix('plantGrey','idle','grey',24,false)
    addLuaSprite('plantGrey',false)
    
    if songName == 'Pinkwave' then
        precacheSound('pretender_kill')
        addLuaScript('custom_events/coverScreen')
        makeAnimatedLuaSprite('greyImpostor','mira/grey_pretender',-520,-60)
        addAnimationByPrefix('greyImpostor','lol','gray anim',24,false)
        addAnimationByPrefix('greyImpostor','idle','gray anim',24,false)
        setProperty('greyImpostor.alpha',0.01)
        addLuaSprite('greyImpostor',false)
    end
    makeAnimatedLuaSprite('plantVent','mira/black_pretender',-100,-200)
    addAnimationByPrefix('plantVent','vent','black',0,false)
    addLuaSprite('plantVent',false)
    
    makeLuaSprite('plantReactor','mira/what is this',0,-650)
    addLuaSprite('plantReactor',false)
    
    makeAnimatedLuaSprite('plantLongusTomato','mira/crew',740,-50)
    addAnimationByPrefix('plantLongusTomato','idle','tomatomongus',24,false)
    addLuaSprite('plantLongusTomato',false)
    
    makeLuaSprite('plantPlant','mira/lmao',-800,-10)
    addLuaSprite('plantPlant',false)
    if songName == 'Pinkwave' then
        makeAnimatedLuaSprite('plantLongusLeave','mira/longus_leave',270,-30)
        addAnimationByPrefix('plantLongusLeave','bye','longus anim',24,false)
        setProperty('plantLongusLeave.alpha',0.01)
        addLuaSprite('plantLongusLeave',false)
    
        makeAnimatedLuaSprite('plantTomatoDie','mira/tomato_pretender',770,135)
        addAnimationByPrefix('plantTomatoDie','bye','tomatongus anim',24,false)
        setProperty('plantTomatoDie.alpha',0.01)
        addLuaSprite('plantTomatoDie',false)
    end
    
    if not lowQuality then
        makeAnimatedLuaSprite('plantRHM','mira/crew',1000,125)
        addAnimationByPrefix('plantRHM','idle','RHM',24,false)
        setScrollFactor('plantRHM',1.2,1)
        addLuaSprite('plantRHM',true)
        
        makeAnimatedLuaSprite('plantBlue','mira/crew',-1300,0)
        addAnimationByPrefix('plantBlue','idle','blue',24,false)
        setScrollFactor('plantBlue',1.2,1)
        addLuaSprite('plantBlue',true)
        
        makeLuaSprite('plantPotFront','mira/front pot',-1550,650)
        setScrollFactor('plantPotFront',1.2,1)
        addLuaSprite('plantPotFront',true)
    
        makeAnimatedLuaSprite('plantVines','mira/vines',-1200,-1200)
        addAnimationByPrefix('plantVines','idle','green',24,true)
        setScrollFactor('plantVines',1.4,1)
        addLuaSprite('plantVines',true)
    end

    if songName == 'Pinkwave' then
        makeAnimatedLuaSprite('plantLightBreak','mira/pretender_dark',-800,-500)
        addAnimationByPrefix('plantLightBreak','light','amongdark',24,false)
        setProperty('plantLightBreak.alpha',0.01)
        addLuaSprite('plantLightBreak',true)
    end
end
function onUpdate(el)
    if not lowQuality then
        fps = fps + el
        if fps >= 1/60 then
            setProperty('plantCloud1.x', getProperty('plantCloud1.x') - 0.5)
            setProperty('plantCloud2.x', getProperty('plantCloud2.x') - 1.5)
            setProperty('plantCloud3.x', getProperty('plantCloud3.x') - 1)
            fps = 0
        end
        for cloud = 1,3 do
            if getProperty('plantCloud'..cloud..'.x') < -2800 then
                setProperty('plantCloud'..cloud..'.x',math.random(1500,2500))
                setProperty('plantCloud'..cloud..'.y',-1000 +math.random(-600,100))
            end
        end
    end
end
function onBeatHit()
    if not lowQuality then
        objectPlayAnimation('plantBlue','idle',true)
        objectPlayAnimation('plantRHM','idle',false)
    end
    objectPlayAnimation('plantLongusTomato','idle',false)
    objectPlayAnimation('plantGrey','idle',false)
end
function onEndSong()
    if isStoryMode and not allowEnd and songName == 'Pinkwave' then
        playSound('pretender_kill')
        doTweenAlpha('gfAlpha','gf',0.1,0.3,'linear')
        doTweenAlpha('hudAlpha','camHUD',0,0.3,'linear')
        doTweenAlpha('bfAlpha','boyfriend',0.25,0.3,'linear')
        doTweenAlpha('dadAlpha','dad',0.25,0.3,'linear')

        objectPlayAnimation('plantLightBreak','light',true)
        setProperty('plantLightBreak.alpha',1)

        setProperty('plantVent.animation.curAnim.frameRate',24)
        objectPlayAnimation('plantVent','vent',true)

        objectPlayAnimation('greyImpostor','lol',true)
        objectPlayAnimation('plantTomatoDie','bye',true)
        objectPlayAnimation('plantLongusLeave','bye',true)

        setProperty('greyImpostor.alpha',1)
        setProperty('plantTomatoDie.alpha',1)
        setProperty('plantLongusLeave.alpha',1)


        removeLuaSprite('plantGrey',true)
        removeLuaSprite('plantLongusTomato',true)
        triggerEvent('Camera Follow Pos','400','150')
        setProperty('camZooming',true)
        setProperty('defaultCamZoom',0.75)
        runTimer('endPink',9)
        allowEnd = true
        startedCutscene = true
        return Function_Stop
    end
    return Function_Continue
end
function onTimerCompleted(tag)
    if tag == 'endPink' then
        endSong(true)
    end
end
