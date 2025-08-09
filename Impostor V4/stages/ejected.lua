local fps = 0
local curAnim = 0
--local buildOffset = {6800,6530,6040}
local buildOffset = {7200,7130,6740}
local positions = {{-10,-224,0.8},{-1340,-350,0.6},{1780,-955,1.3},{-2210,-1370,1}}--cloudPositions
function onCreate()
    makeLuaSprite('ejectedSky','ejected/sky',-2500,-3500)
    addLuaSprite('ejectedSky',false)
    setScrollFactor('ejectedSky',0.6,0.6)
    makeLuaSprite('ejectedCloud','ejected/fgClouds',-3000,0)
    setScrollFactor('ejectedCloud',0.8,0.8)
    addLuaSprite('ejectedCloud',false)

    for build = 1,2 do
        makeAnimatedLuaSprite('ejectedBuildMiddle'..build,'ejected/buildingSheet',-200,100)
        for anims = 1,3 do
            addAnimationByPrefix('ejectedBuildMiddle'..build,'build'..anims,'BuildingA'..anims,0,true)
        end
        curAnim = math.random(1,3)
        objectPlayAnimation('ejectedBuildMiddle'..build,'build'..curAnim,false)
        addLuaSprite('ejectedBuildMiddle'..build,false)

        makeAnimatedLuaSprite('ejectedBuild'..build,'ejected/buildingSheet',-1290 + (2407 * (build - 1)),100)
        addAnimationByPrefix('ejectedBuild'..build,'build1','BuildingB1',0,true)
        addAnimationByPrefix('ejectedBuild'..build,'build2','BuildingB2',0,true)
        objectPlayAnimation('ejectedBuild'..build,'build'..math.random(1,2),false)
        addLuaSprite('ejectedBuild'..build,false)

        makeLuaSprite('ejectedSpeedLines'..build,'ejected/speedLines',0,0)
        setProperty('ejectedSpeedLines'..build..'.alpha',0.4)
        addLuaSprite('ejectedSpeedLines'..build,true)
    end
    if not lowQuality then
        for clouds = 1,4 do
            local name = 'ejectedCloudFront'..clouds
            makeAnimatedLuaSprite(name,'ejected/scrollingClouds',positions[clouds][1],positions[clouds][2])
            addAnimationByPrefix(name,'cloud','Cloud'..(clouds % 4),0,true)
            setScrollFactor(name,positions[clouds][3])
            addLuaSprite(name,true)
        end
    end
end
function onCreatePost()
    triggerEvent('FocusCamScript','both,dad,100,0','')
    setProperty('camHUD.height',getProperty('camHUD.height') + 20)
    setScrollFactor('gfGroup',0.7,0,7)
end
function onSongStart()
    cameraShake('game',0.002,getProperty('songLength')*2)
end
function onUpdate(el)
    fps = fps + el
    local songPos = getSongPosition()
    setProperty('camHUD.y',math.sin((songPos/1000) * (bpm / 60) * 1.0) * 15)
    setProperty('camHUD.angle',math.sin((songPos / 1200) * (bpm / 60) * -1.0) * 1.2)
    if fps >= 1/240 then
        setProperty('ejectedSky.y',-3500 - (500 * (songPos/getProperty('songLength'))))
        setProperty('ejectedCloud.y',getProperty('ejectedSky.y') + 3500)
        setProperty('ejectedBuildMiddle1.y',getProperty('ejectedBuildMiddle1.y') - 185)
        setProperty('ejectedSpeedLines1.y',getProperty('ejectedSpeedLines1.y') - 85)

        if getProperty('ejectedSpeedLines2.y') <= 0 then
            setProperty('ejectedSpeedLines1.y',0)
        end
        --[[if getProperty('ejectedBuild1.y') < -5000 then
            setProperty('ejectedBuild1.y',5000)
            local random = math.random(1,2)
            for builds2 = 1,2 do
                objectPlayAnimation('ejectedBuild'..builds2,'build'..random)
            end
        end--]]
        if getProperty('ejectedBuildMiddle2.y') <= -buildOffset[curAnim]/3 then
            curAnim = math.random(1,3)
            setProperty('ejectedBuildMiddle1.y',getProperty('ejectedBuildMiddle2.y'))
            objectPlayAnimation('ejectedBuildMiddle1',getProperty('ejectedBuildMiddle2.animation.curAnim.name'))
            objectPlayAnimation('ejectedBuildMiddle2','build'..curAnim,false)
        end
        setProperty('ejectedBuild1.y',getProperty('ejectedBuildMiddle2.y') - (buildOffset[curAnim]/2) + 450)
        setProperty('ejectedBuild2.y',getProperty('ejectedBuild1.y'))
        setProperty('ejectedBuildMiddle2.y',getProperty('ejectedBuildMiddle1.y') + buildOffset[curAnim])
        setProperty('ejectedSpeedLines2.y',getProperty('ejectedSpeedLines1.y') + getProperty('ejectedSpeedLines1.height'))
        if not lowQuality then
            for clouds = 1,4 do
                local name = 'ejectedCloudFront'..clouds
                local y = getProperty(name..'.y')
                setProperty(name..'.y',y - 120)
                if y < -2000 then
                    local random = math.random(1.5,2.2)
                    local randomScroll = math.random(1,1.3)
                    setProperty(name..'.x',math.random(-3000,3000))
                    setProperty(name..'.y',math.random(2000,2500))
                    scaleObject(name,random,random)
                    setScrollFactor(name,randomScroll,randomScroll)
                end
            end
        end
        fps = 0
    end
end
