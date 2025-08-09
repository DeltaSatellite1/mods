function onCreate()
    makeLuaSprite('loggoSky','loggo/space',-650,600)
    setProperty('loggoSky.antialiasing',false)
    scaleObject('loggoSky',3,3)
    setScrollFactor('loggoSky',0.8,0.8)
    addLuaSprite('loggoSky',false)


    makeLuaSprite('loggoBg','loggo/normalOne',-650,600)
    setProperty('loggoBg.antialiasing',false)
    scaleObject('loggoBg',3,3)
    setScrollFactor('loggoBg',0.9,0.9)
    addLuaSprite('loggoBg',false)

    makeAnimatedLuaSprite('loggoFire','loggo/stockingFire',-650,600)
    addAnimationByPrefix('loggoFire','anim','stocking fire',24,true)
    setScrollFactor('loggoFire',0.9,0.9)
    scaleObject('loggoFire',3,3)
    addLuaSprite('loggoFire',false)
    setProperty('loggoFire.antialiasing',false)

    makeAnimatedLuaSprite('loggoPeople','loggo/people',-650,600)
    scaleObject('loggoPeople',3,3)
    setScrollFactor('loggoPeople',0.9,0.9)
    addAnimationByPrefix('loggoPeople','idle','the guys',24,false)
    addLuaSprite('loggoPeople',false)
    setProperty('loggoPeople.antialiasing',false)
end
function onBeatHit()
    objectPlayAnimation('loggoPeople','idle',false)
end