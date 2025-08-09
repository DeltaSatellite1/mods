local fps = 0
function onCreate()
    makeLuaSprite('plantSky','mira/pretender/bg sky',-1500,-800)
    addLuaSprite('plantSky',false)

    if not lowQuality then
        makeLuaSprite('plantCloudBack','mira/pretender/cloud fathest',-1300,-100)
        addLuaSprite('plantCloudBack',false)
        makeLuaSprite('plantCloudFront','mira/pretender/cloud front',-1300,0)
        addLuaSprite('plantCloudFront',false)
        for cloud = 1,3 do
            makeLuaSprite('plantCloud'..cloud,'mira/pretender/cloud '..cloud,0,-1200 - (math.random(100,200) * (cloud -1 )))
            addLuaSprite('plantCloud'..cloud,false)
        end
        makeLuaSprite('plantCloudBig','mira/pretender/bigcloud',0,-1200)
        addLuaSprite('plantCloudBig',false)
    end
    makeLuaSprite('plantGlass','mira/pretender/ground',-1200,-750)
    addLuaSprite('plantGlass',false)
    
    makeLuaSprite('plantReactor','mira/pretender/front plant',0,-650)
    addLuaSprite('plantReactor',false)

    makeLuaSprite('plantKnockedPlant','mira/pretender/knocked over plant',1000,230)
    addLuaSprite('plantKnockedPlant',false)

    makeLuaSprite('plantKnockedPlant2','mira/pretender/knocked over plant 2',-800,260)
    addLuaSprite('plantKnockedPlant2',false)

    makeLuaSprite('plantTomatoDead','mira/pretender/tomatodead',950,250)
    addLuaSprite('plantTomatoDead',false)
    
    makeAnimatedLuaSprite('gfMiraDead','mira/pretender/gf_dead_p',0,150)
    addAnimationByPrefix('gfMiraDead','idle','GF Dancing Beat',24,false)
    scaleObject('gfMiraDead',1.1,1.1)
    addLuaSprite('gfMiraDead',false)
    
    makeLuaSprite('plantBfDead','mira/pretender/ripbozo',800, 550)
    scaleObject('plantBfDead',0.7,0.7)
    addLuaSprite('plantBfDead',false)

    if not lowQuality then
        makeLuaSprite('plantRhmDead','mira/pretender/rhm dead',1350,450)
        addLuaSprite('plantRhmDead',false)

        makeAnimatedLuaSprite('plantBlueDead','mira/pretender/blued',-1150,400)
        addAnimationByPrefix('plantBlueDead','idle','bob bop',24,false)
        setScrollFactor('plantBlueDead',1.2,1)
        addLuaSprite('plantBlueDead',false)
    end

    makeLuaSprite('plantPotFront','mira/front pot',-1550,650)
    setScrollFactor('plantPotFront',1.2,1)
    addLuaSprite('plantPotFront',true)

    makeLuaSprite('plantVines','mira/pretender/green',-1450,-550)
    setScrollFactor('plantVines',1.2,1)
    addLuaSprite('plantVines',true)

    makeLuaSprite('pretenderDark','mira/pretender/lightingpretender',-1670,-700)
    addLuaSprite('pretenderDark',true)
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
    objectPlayAnimation('gfMiraDead','idle',true)
    if curBeat % 2 == 0 then
        objectPlayAnimation('plantBlueDead','idle',true)
    end
end