local currentState = nil
function onCreate()
    makeAnimatedLuaSprite('WhoBuzz','polus/meeting',0,100)
    scaleObject('WhoBuzz',1.4,1.4)
    setProperty('WhoBuzz.alpha',0.001)
    addAnimationByPrefix('WhoBuzz','Buzz','meeting buzz',16,false)
    setObjectCamera('WhoBuzz','other')
    addLuaSprite('WhoBuzz',true)

    makeLuaSprite('WhoAlert','polus/KILLYOURSELF',350,20)
    setObjectCamera('WhoAlert','other')
    setProperty('WhoAlert.alpha',0.001)
    scaleObject('WhoAlert',0.8,0.8)
    addLuaSprite('WhoAlert',true)

    makeLuaSprite('WhoEmergency','polus/emergency',400,350)
    setObjectCamera('WhoEmergency','other')
    setProperty('WhoEmergency.alpha',0.001)
    scaleObject('WhoEmergency',0.6,0.6)
    addLuaSprite('WhoEmergency',true)
    
    makeLuaSprite('WhoAngered','polus/mad mad dude',-1000,975)
    setProperty('WhoAngered.alpha',0.001)
    addLuaSprite('WhoAngered',true)

    makeLuaSprite('WhoSkyBG','freeplay/starBG',60,100)
    scaleObject('WhoSkyBG',1.85,1.85)
    setProperty('WhoSkyBG.alpha',0.001)
    addLuaSprite('WhoSkyBG',false)

    
    makeLuaSprite('WhoSkyFG','freeplay/starFG',20,500)
    scaleObject('WhoSkyFG',1.85,1.85)
    setProperty('WhoSkyFG.alpha',0.001)
    addLuaSprite('WhoSkyFG',false)
end
function onEvent(name,v1,v2)
    if name == "Who Buzz" then
        if v1 ~= '0' then
            if v1 ~= '1' then
                setProperty('WhoEmergency.alpha',0)
                setProperty('WhoBuzz.alpha',1)
                setProperty('camHUD.visible',false)
                objectPlayAnimation('WhoBuzz','Buzz',true)
                currentState =  0
            else
                setProperty('WhoAngered.alpha',1)
                setProperty('boyfriend.visible',false)
                setProperty('dad.visible',false)
                setProperty('WhoSkyBG.alpha',1)
                setProperty('WhoSkyFG.alpha',1)
                doTweenX('WhoAngeredBye','WhoAngered',3000,10,'linear')
                doTweenAngle('WhoAngeredAngle','WhoAngered',720,10,'linear')
                setProperty('WhoSkyBG.alpha',1)
                setProperty('WhoSkyFG.alpha',1)
                removeLuaSprite('WhoEmergency',true)
                removeLuaSprite('WhoBuzz',true)
                removeLuaSprite('WhoAlert',true)
                currentState =  1
            end
        end
    end
end
function onUpdate()
    if currentState == 0 then
        if getProperty('WhoBuzz.animation.curAnim.finished') then
            local alpha = getProperty('WhoBuzz.alpha')
            setProperty('WhoEmergency.alpha',alpha)
            setProperty('WhoAlert.alpha',alpha)
        end
    elseif currentState == 1 then
        setProperty('camZooming',false)
        setProperty('defaultCamZoom',0.5)
        setProperty('camGame.zoom',0.5)
        setProperty('camFollowPos.x',1100)
        setProperty('camFollowPos.y',1150)
        setProperty('camFollow.x',1100)
        setProperty('camFollow.y',1150)
    end
end