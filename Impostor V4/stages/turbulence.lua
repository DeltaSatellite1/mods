local fps = 0

function onCreate()
    makeLuaSprite('turbSky','airship/turbulence/turbsky',-1200,-400)
    setScrollFactor('turbSky',0.5,0.5)
    addLuaSprite('turbSky',false)

    makeLuaSprite('turbBackClouds','airship/turbulence/backclouds',0,175)
    setScrollFactor('turbBackClouds',0.65,0.65)
    addLuaSprite('turbBackClouds',false)

    makeLuaSprite('turbBaloon','airship/turbulence/hotairballoon',135,147)
    setScrollFactor('turbBaloon',0.65,0.65)
    setProperty('turbBaloon.velocity.x',100)
    addLuaSprite('turbBaloon',false)

    makeLuaSprite('turbMiddleClouds','airship/turbulence/midclouds',-313,253)
    setScrollFactor('turbMiddleClouds',0.8,0.8)
    setProperty('turbMiddleClouds.velocity.x',4000)
    addLuaSprite('turbMiddleClouds',false)

    makeLuaSprite('turbClaw','airship/turbulence/clawback',-597,888)
    setObjectOrder('turbClaw',getObjectOrder('dadGroup') + 1)
    addLuaSprite('turbClaw',true)

    makeAnimatedLuaSprite('turbHookArm','airship/turbulence/clawfront',1873,690)
    addAnimationByPrefix('turbHookArm','idle','clawhands',24,false)
    addLuaSprite('turbHookArm',true)


    for clouds = 1,2 do
        local positons = {-1400,4102}
        makeLuaSprite('turbFrontCloud'..clouds,'airship/turbulence/frontclouds',positons[clouds],1013)
        addLuaSprite('turbFrontCloud'..clouds,true)
        setProperty('turbFrontCloud'..clouds..'.velocity.x',4000)
    end
    if not lowQuality then
        makeLuaSprite('turbLight','airship/turbulence/TURBLIGHTING',-80,-875)
        scaleObject('turbLight',1.3,1.3)
        
        setProperty('turbLight.alpha',0.5)
        setBlendMode('turbLight','add')
        addLuaSprite('turbLight',true)
    end
    for lines = 1,2 do
        makeLuaSprite('turbSpeedLine'..lines,'airship/speedlines',3350,135)
        setScrollFactor('turbSpeedLine'..lines,1.3,1.3)
        setProperty('turbSpeedLine'..lines..'.alpha',0.3)
        addLuaSprite('turbSpeedLine'..lines,true)
        setProperty('turbSpeedLine'..lines..'.velocity.x',3000)
    end
end
function onCreatePost()
    setProperty('camHUD.height',820)
end
function onBeatHit()
    if curBeat % 2 == 0 then
        playAnim('turbHookArm','idle',true)
    end
end
function onUpdate(el)
    fps = fps + el
    if fps >= 1/120 then
        fps = 0
    end
    setProperty('turbBackClouds.x',500 + 2000*math.max(0,(getSongPosition()/getProperty('songLength'))))
    if getProperty('turbFrontCloud1.x') > 4900 then
        setProperty('turbFrontCloud1.x',-12000 + (math.random(-300,300)))
    end
    if getProperty('turbMiddleClouds.x') > 5140 then
        setProperty('turbMiddleClouds.x',-3500 + (math.random(-300,300)))
        setProperty('turbMiddleClouds.y',253 + (math.random(-300,200)))
    end
    if getProperty('turbSpeedLine2.x') > 4000 then
        setProperty('turbSpeedLine1.x',-1000)
    end
    if getProperty('turbBaloon.x') > 5140 then
        setProperty('turbBaloon.x',-3500 + math.random(-300,200))
    end
    setProperty('turbFrontCloud2.x',getProperty('turbFrontCloud1.x') + getProperty('turbFrontCloud1.width'))
    setProperty('turbSpeedLine2.x',getProperty('turbSpeedLine1.x') + getProperty('turbSpeedLine1.width'))
    setProperty('camHUD.y',math.sin((getSongPosition() / 1000) * (bpm / 60) * 1.0) * 15)
	setProperty('camHUD.angle',math.sin((getSongPosition() / 1200) * (bpm / 60) * -1.0) * 1.2)
end

function goodNoteHit()
    playAnim('turbHookArm','idle',true)
end