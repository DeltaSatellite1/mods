local currentState = 2
local stageX = -880
local stageY = -550
local ejectedCreated = false
local redCreated = false
local defeatCreated = false
local fps = 0
local lastCamZoom = 0
function onCreate()
    precacheImage('skeld/evilejected')
    precacheImage('skeld/brombom')
    precacheImage('ejected/speedLines')
    precacheImage('skeld/defeatScroll')

    makeLuaSprite('ejectedSky','skeld/evilejected',-800,-1500)
    scaleObject('ejectedSky',1.9,1.9)

    makeLuaSprite('ejectedBrombom','skeld/brombom',-700,-1500)
    scaleObject('ejectedBrombom',1.9,1.9)
    for build = 1,2 do
        makeLuaSprite('ejectedSpeedLines'..build,'ejected/speedLines',-500,0)
        setProperty('ejectedSpeedLines'..build..'.alpha',0.4)
        scaleObject('ejectedSpeedLines'..build,1.4,1.4)
    end
    precacheImage('defeatfnf')
    makeLuaSprite('defeatEvent','defeatfnf',-100,0)
    scaleObject('defeatEvent',1.9,1.9)

    ejectedCreated = true
    defeatCreated = true
end
function onCreatePost()
    if getPropertyFromClass('PlayState','curStage') == 'monotone' then
        precacheImage('ejected/ReactorLightRed')
        precacheImage('skeld/backthingsred')

        makeLuaSprite('monotoneBGRed','skeld/backthingsred',stageX,stageY)
        scaleObject('monotoneBGRed',1.9,1.9)

        makeLuaSprite('ReactorRed','skeld/ReactorRed',stageX,stageY)
        scaleObject('ReactorRed',1.9,1.9)

        makeLuaSprite('ReactorLightRed','skeld/ReactorLightRed',stageX,stageY)
        scaleObject('ReactorLightRed',1.9,1.9)
        setBlendMode('ReactorLightRed','add')

        redCreated = true
    end
end
function onEvent(name,value1,v2)
    if name == "Identity Crisis Events" then
        local v1 = tonumber(value1)
        if v1 == 0 or v1 == nil then
            if currentState == 1 and redCreated then
                removeLuaSprite('ReactorRed',true)
                removeLuaSprite('ReactorLightRed',true)
                removeLuaSprite('monotoneBGRed',true)
                redCreated = false
            elseif currentState == 2 then
                removeLuaSprite('defeatEvent',true)
                defeatCreated = false

            elseif currentState == 3 then
                removeLuaSprite('ejectedSky',true)
                removeLuaSprite('ejectedBrombom',true)
                for build = 1,2 do
                    removeLuaSprite('ejectedSpeedLines'..build,true)
                end
                ejectedCreated = false
            end
        else
            if v1 == 1 then
                if not redCreated then
                    makeLuaSprite('monotoneBGRed','skeld/backthingsred',stageX,stageY)
                    scaleObject('monotoneBGRed',1.9,1.9)

                    makeLuaSprite('ReactorRed','skeld/ReactorRed',stageX,stageY)
                    scaleObject('ReactorRed',1.9,1.9)

                    makeLuaSprite('ReactorLightRed','skeld/evilejected',stageX,stageY)
                    scaleObject('ReactorLightRed',1.9,1.9)
                    setBlendMode('ReactorLightRed','add')
                    redCreated = true
                end
                addLuaSprite('monotoneBGRed',false)
                addLuaSprite('ReactorRed',false)
                addLuaSprite('ReactorLightRed',false)
                if lastCamZoom ~= 0 then
                    setProperty('defaultCamZoom',lastCamZoom)
                end
                lastCamZoom = 0
            elseif v1 == 2 then
                if not defeatCreated then
                    makeLuaSprite('defeatEvent','defeatfnf',-100,0)
                    scaleObject('defeatEvent',1.9,1.9)
                end
                addLuaSprite('defeatEvent',false)

            elseif v1 == 3 then
                for build = 1,2 do
                    if not ejectedCreated then
                        makeLuaSprite('ejectedSpeedLines'..build,'ejected/speedLines',-500,0)
                        setProperty('ejectedSpeedLines'..build..'.alpha',0.4)
                        scaleObject('ejectedSpeedLines'..build,1.5,1.5)
                        addLuaSprite('ejectedSpeedLines'..build,true)
                    else
                        addLuaSprite('ejectedSpeedLines'..build,true)
                    end
                end
                lastCamZoom = getProperty('defaultCamZoom')
                if not ejectedCreated then
                    makeLuaSprite('ejectedSky','skeld/evilejected',-800,-1500)
                    scaleObject('ejectedSky',1.9,1.9)
                    addLuaSprite('ejectedSky',false)

                    makeLuaSprite('ejectedBrombom','skeld/brombom',-700,-1500)
                    scaleObject('ejectedBrombom',1.9,1.9)
                    addLuaSprite('ejectedBrombom',false)
                    ejectedCreated = true
                end
                addLuaSprite('ejectedSky',false)
                addLuaSprite('ejectedBrombom',false)
            end
            if v1 ~= 1 and redCreated then
                removeLuaSprite('monotoneBGRed',true)
                removeLuaSprite('ReactorRed',true)
                removeLuaSprite('ReactorLightRed',true)
                redCreated = false
            end
            if v1 ~= 2 and defeatCreated then
                removeLuaSprite('defeatEvent',true)
                defeatCreated = false
            end
            if v1 ~= 3 and ejectedCreated then
                removeLuaSprite('ejectedSky',true)
                removeLuaSprite('ejectedBrombom',true)
                for build = 1,2 do
                    removeLuaSprite('ejectedSpeedLines'..build,true)
                end
                ejectedCreated = false
            end
        end
        currentState = v1
    end
end
function onUpdate(el)
    if currentState == 3 then
        if mustHitSection then
            setProperty('defaultCamZoom',0.55)
        else
            setProperty('defaultCamZoom',0.45)
        end
        fps = fps + el
        if fps >= 1/240 then
            setProperty('ejectedSky.y',getProperty('ejectedSky.y') - 0.5)
            setProperty('ejectedBrombom.y',getProperty('ejectedSky.y') - 0.8)
            setProperty('ejectedSpeedLines1.y',getProperty('ejectedSpeedLines1.y') - 120)
        end
        if getProperty('ejectedSpeedLines2.y') <= -400 then
            setProperty('ejectedSpeedLines1.y',-400)
        end
        setProperty('ejectedSpeedLines2.y',getProperty('ejectedSpeedLines1.y') + getProperty('ejectedSpeedLines1.height'))
    end
end
function onBeatHit()
    if curBeat % 4 == 0 and currentState == 2 then
        setProperty('defeatEvent.alpha',1)
        doTweenAlpha('defeatBG','defeatEvent',0.6,0.6,'linear')
    end
end