local enabledMoviment = false
local fps = 0
local speed = 2
function onCreatePost()
    local willHaveMoviment = false
    if songName == 'Danger' then
        enabledMoviment = true
    end
    makeLuaSprite('airshipSky','airship/sky',0,0)
    setScrollFactor('airshipSky',0,0)
    scaleObject('airshipSky',1.2,1)
    addLuaSprite('airshipSky',false)
    if not lowQuality then
        for backCloud = 1,2 do
            makeLuaSprite('airshipBackCloud'..backCloud,'airship/farthestClouds',-1600,-200)
            setScrollFactor('airshipBackCloud'..backCloud,0.25,0.25)
            addLuaSprite('airshipBackCloud'..backCloud,false)
        end
    end
    for cloud = 1,2 do
        makeLuaSprite('airshipCloud'..cloud,'airship/backClouds',-1600,0)
        setScrollFactor('airshipCloud'..cloud,0.5,0.5)
        addLuaSprite('airshipCloud'..cloud,false)
    end
    makeLuaSprite('airship','airship/airship',1100,-800)
    setScrollFactor('airship',0.25,0.25)
    addLuaSprite('airship',false)
    if not lowQuality then
        makeAnimatedLuaSprite('airshipFan','airship/airshipFan',2100,200)
        setScrollFactor('airshipFan',0.25,0.25)
        addAnimationByPrefix('airshipFan','fan','ala avion instance 1',24,true)
        addLuaSprite('airshipFan',false)

        makeLuaSprite('airshipBigCloud','airship/bigCloud',3000,math.random(-1000,-800))
        setScrollFactor('airshipBigCloud',0.5,0.5)
        addLuaSprite('airshipBigCloud',false)
    end
    for frontCloud = 1,2 do
        makeLuaSprite('airshipFCloud'..frontCloud,'airship/frontClouds',-1600,300)
        setScrollFactor('airshipFCloud'..frontCloud,0.5,0.5)
        addLuaSprite('airshipFCloud'..frontCloud,false)
    end

    if willHaveMoviment or enabledMoviment then
        for floor = 0,2 do
            if floor > 0 then
                makeLuaSprite('airshipGround'..(floor + 1),'airship/fgPlatform',-1000 + (getProperty('airshipGround1.width') * floor) - 100,300)
            else
                makeLuaSprite('airshipGround'..(floor + 1),'airship/fgPlatform',-1000,300)
            end
            addLuaSprite('airshipGround'..(floor + 1),false)
            makeLuaSprite('airshipLines'..(floor + 1),'airship/speedlines',-200 + (4140 * floor),-500)
            setProperty('airshipLines'..(floor + 1)..'.alpha',0.3)
            setObjectOrder('airshipLines'..(floor + 1),getObjectOrder('gfGroup') + 1)
            addLuaSprite('airshipLines'..(floor + 1),false)
        end
    else
        makeLuaSprite('airshipGround','airship/fgPlatform',-1000,300)
        addLuaSprite('airshipGround',false)
    end
    cameraShake('game',0.008, getProperty('songLength')*2)
    setProperty('camGame.height',screenHeight + 200)
end




function onUpdate(el)
    fps = fps + el
    setProperty('airshipSky.x',math.min(0,-200 * ((1 - getProperty('camGame.zoom')) * 15)))
    setProperty('airshipSky.y',math.min(0,-200 * ((1 - getProperty('camGame.zoom')) * 10)))
    scaleObject('airshipSky',math.max(1,1 + ((1 - getProperty('camGame.zoom'))*2)),math.max(1,1 + ((1 - getProperty('camGame.zoom'))*2)))
    if enabledMoviment then
        speed = 5
        if fps > 1/240 then
            setProperty('airship.x',getProperty('airship.x') - 0.05)
            if not lowQuality then
                setProperty('airshipBigCloud.x',getProperty('airshipBigCloud.x') - speed/3)
                setProperty('airshipFan.x',getProperty('airshipFan.x') - 0.05)
            end
            setProperty('airshipGround1.x',getProperty('airshipGround1.x') - speed * 6)
            setProperty('airshipLines1.x',getProperty('airshipLines1.x') - speed * 9)
        end
        for floor = 2,3 do
            setProperty('airshipGround'..floor..'.x',getProperty('airshipGround1.x') + (getProperty('airshipGround1.width') * (floor - 1)) - 400)
            setProperty('airshipLines'..floor..'.x',getProperty('airshipLines1.x') + (getProperty('airshipLines1.width') * (floor - 1)) + 100)
        end
        if getProperty('airshipGround2.x') < -1100 then
            setProperty('airshipGround1.x',-1100)
        end
        if getProperty('airshipLines1.x') < (getProperty('airshipLines1.width') * 2 + 200) * -1  then
            setProperty('airshipLines1.x',getProperty('airshipLines1.x') + getProperty('airshipLines1.width') + 200)
        end
    else
        speed = 2
    end
    if fps > 1/240 then
        setProperty('airshipFCloud1.x',getProperty('airshipFCloud1.x') - (speed * 2.5))
        setProperty('airshipBackCloud1.x',getProperty('airshipBackCloud1.x') - (speed/4))
        setProperty('airshipCloud1.x',getProperty('airshipCloud1.x') - (speed/3))
        fps = 0
    end
    setProperty('airshipFCloud2.x',getProperty('airshipFCloud1.x') + 8000)
    setProperty('airshipBackCloud2.x',getProperty('airshipBackCloud1.x') + 4525)
    setProperty('airshipCloud2.x',getProperty('airshipCloud1.x') + 4525)

    if getProperty('airshipBackCloud2.x') <= -1600 then
        setProperty('airshipBackCloud1.x',-1600)
    end
    if getProperty('airshipCloud2.x') <= -1000 then
        setProperty('airshipCloud1.x',-1000)
    end
    if getProperty('airshipFCloud2.x') <= -1600 then
        setProperty('airshipFCloud1.x',-1600)
    end
    local songPos = getSongPosition()
    local bpmLol = bpm/60
    setProperty('camHUD.y',math.sin((songPos / 300) * bpmLol * 1.0) * 0.6)
    setProperty('camHUD.angle',math.sin((songPos / 350) * bpmLol * -1.0) * 0.6)
    setProperty('camGame.y',(math.sin((songPos / 280) * bpmLol * 1.0) * 2) - 50)
end

