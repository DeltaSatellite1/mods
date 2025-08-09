local pinkCreated = false
local pinkAdded = false
local fadeTime = 0
local heartsLimit = 30
local pinkStarted = false
local layer = 'other'
local beatPercent = 2
local frequency = 1
function onCreate()
    precacheImage('mira/vignette')
    precacheImage('mira/vignette2')
    precacheImage('mira/hearts')
    precacheImage('mira/littleheart')
end
function createPink(startInvisible,add)
    if not pinkCreated then
        makeLuaSprite('pinkVignette1','mira/vignette',0,0)
        setObjectCamera('pinkVignette1',layer)
        setBlendMode('pinkVignette1','add')

        makeLuaSprite('pinkVignette2','mira/vignette2',0,0)
        setObjectCamera('pinkVignette2',layer)
        setProperty('pinkVignette2.alpha',0.3)

        makeAnimatedLuaSprite('pinkHearts','mira/hearts',-25,0)
        addAnimationByPrefix('pinkHearts','hearts','Symbol 2',24,true)
        setObjectCamera('pinkHearts',layer)
        if not lowQuality then
            for hearts = 1,heartsLimit do
                makeAnimatedLuaSprite('pinkLittleHearts'..hearts,'mira/littleheart',(200 * (hearts - 1)) + math.random(-100,100),screenHeight + math.random(0,200))
                addAnimationByPrefix('pinkLittleHearts'..hearts,'idle','littleheart',24,true)
                setObjectCamera('pinkLittleHearts'..hearts,layer)
            end
        end
        pinkCreated = true
    end
    if startInvisible then
        setProperty('pinkVignette1.alpha',0.01)
        setProperty('pinkVignette2.alpha',0.01)
        setProperty('pinkHearts.alpha',0.01)
        if not lowQuality then
            for hearts = 1,heartsLimit do
                setProperty('pinkLittleHearts'..hearts..'.alpha',0.01)
            end
        end
    end
    if add then
        if pinkAdded == false then
            addLuaSprite('pinkVignette1',true)
            addLuaSprite('pinkVignette2',true)
            addLuaSprite('pinkHearts',true)
            if not lowQuality then
                for hearts = 1,heartsLimit do
                    addLuaSprite('pinkLittleHearts'..hearts,true)
                    moveHearts(hearts)
                end
            end
            pinkAdded = true
        end
    end
end
function onEvent(name,v1,v2)
    if name == 'pink toggle' then
        fadeTime = tonumber(v1)
        if pinkStarted == false then
            pinkStarted = true
            if fadeTime ~= 0 and fadeTime ~= nil then
                if not pinkCreated or not pinkAdded then
                    createPink(true,true)
                end
                doTweenAlpha('pinkVignette1Tween','pinkVignette2',0.3,fadeTime,'sineOut')
                doTweenAlpha('pinkHeartsTween','pinkHearts',1,fadeTime,'sineOut')
                setProperty('pinkVignette1.alpha',1)
                doTweenAlpha('pinkVignetteAlpha','pinkVignette1',0.2,1,'linear')
                if not lowQuality then
                    for hearts = 1,heartsLimit do
                        doTweenAlpha('pinkLittleHearts'..hearts..'Tween','pinkLittleHearts'..hearts,1,fadeTime,'sineOut')
                    end
                end
            else
                if not pinkCreated or not pinkAdded then
                    createPink(false,true)
                end
            end
            if v2 ~= '' then
                local comma1,comma2 = string.find(v2,',',0,true)
                if comma1 ~= nil then
                    beatPercent = string.sub(v2,0,comma1 - 1)
                    frequency = string.sub(v2,comma2 + 1)
                else
                    beatPercent = v2
                end
            end
        else
            cancelTween('pinkVignetteAlpha')
            if fadeTime ~= 0 and fadeTime ~= nil then
                doTweenAlpha('pinkHeartsTween','pinkHearts',0,fadeTime,'sineOut')
                for vignette = 1,2 do
                    doTweenAlpha('byePink'..vignette,'pinkVignette'..vignette,0,fadeTime,'linear')
                end
                if not lowQuality then
                    for hearts = 1,heartsLimit do
                        doTweenAlpha('pinkLittleHearts'..hearts..'Tween','pinkLittleHearts'..hearts ,0,fadeTime,'linear')
                    end
                end
            else
                removePink()
            end
            pinkStarted = false
        end
        if fadeTime == 0 or fadeTime == nil then
            fadeTime = 0.6
        end
    end
end
function removePink()
    removeLuaSprite('pinkVignette1',true)
    removeLuaSprite('pinkVignette2',true)
    removeLuaSprite('pinkHearts',true)
    if not lowQuality then
        for hearts = 1,heartsLimit do
            removeLuaSprite('pinkLittleHearts'..hearts,true)
        end
    end
    pinkCreated = false
    pinkAdded = false
end
function moveHearts(id)
    if not lowQuality then
        local speed = math.random(4,6)
        scaleObject('pinkLittleHearts'..id,1.5,1.5)
        setProperty('pinkLittleHearts'..id..'.x',(200 * id) - math.random(-100,100))
        doTweenX('pinkHeartsScaleX'..id,'pinkLittleHearts'..id..'.scale',0.5,speed,'linear')
        doTweenY('pinkHeartsScaleY'..id,'pinkLittleHearts'..id..'.scale',0.5,speed,'linear')
        doTweenY('pinkHeartsY'..id,'pinkLittleHearts'..id,math.random(-200,-50),speed,'linear')
        doTweenX('pinkHeartsXRight'..id,'pinkLittleHearts'..id,getProperty('pinkLittleHearts'..id..'.x') + math.random(5,10),math.random(0.3,1),'sineOut')
    end
end
function onTweenCompleted(name)
    if name == 'byePink1' then
        removePink()
    elseif string.find(name,'pinkHearts') then
        for hearts = 1,heartsLimit do
            if name == 'pinkHeartsY'..hearts then
                setProperty('pinkLittleHearts'..hearts..'.y',screenHeight + (math.random(0,200)))
                moveHearts(hearts)
            elseif name == 'pinkHeartsXLeft'..hearts then
                doTweenX('pinkHeartsXRight'..hearts,'pinkLittleHearts'..hearts,getProperty('pinkLittleHearts'..hearts..'.x') + math.random(0,5),math.random(0.3,1),'sineOut')
            elseif name == 'pinkHeartsXRight'..hearts then
                doTweenX('pinkHeartsXLeft'..hearts,'pinkLittleHearts'..hearts,getProperty('pinkLittleHearts'..hearts..'.x') - math.random(0,5),math.random(0.3,1),'sineOut')
            end
        end
    end
end
function onBeatHit()
    if curBeat % beatPercent == frequency and pinkCreated and pinkStarted then
        setProperty('pinkVignette1.alpha',1)
        doTweenAlpha('pinkVignetteAlpha','pinkVignette1',0.2,1,'linear')
    end
end