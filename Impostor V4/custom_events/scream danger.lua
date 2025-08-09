local created = false
local enableAnim = false
function onCreate()
    precacheImage('airship/screamsky')
    makeAnimatedLuaSprite('screamSky','airship/screamsky',0,0)
    addAnimationByPrefix('screamSky','sky','scream sky  instance 1',24,false)
    setProperty('screamSky.alpha',0.01)
    addLuaSprite('screamSky',false)--is like a precache
end
function onUpdate()
    if created then
        if enableAnim then
            if getProperty('screamSky.animation.curAnim.curFrame') >= 8  then
                setProperty('screamSky.animation.curAnim.curFrame',2)
            end
        else
            if getProperty('screamSky.animation.curAnim.finished') then
                removeLuaSprite('screamSky',false)
                created = false
            end
        end
    end
end
function onEvent(name,v1,v2)
    if name == 'scream danger' then
        if v1 ~= '' then
            createScream()
        else
            if created then
                enableAnim = false
                setProperty('screamSky.animation.curAnim.curFrame',10)
            end
        end
    end
end
function createScream()
    makeAnimatedLuaSprite('screamSky','airship/screamsky',-690,-400)
    setScrollFactor('screamSky',0,0)
    addAnimationByPrefix('screamSky','sky','scream sky  instance 1',24,false)
    setProperty('screamSky.animation.curAnim.curFrame',0)
    scaleObject('screamSky',1.3,1.3)
    setObjectOrder('screamSky',getObjectOrder('dadGroup') - 1)
    addLuaSprite('screamSky',false)
    created = true
    enableAnim = true
end