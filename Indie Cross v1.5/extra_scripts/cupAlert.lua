local cupAlertCreated = false
local cupAlertOfsX = 157
local cupAlertOfsY = -304

local alertCount = 0
local alertDestroyed = 0

local enableWarning = true
function onCreate()
    if songName == 'devils-gambit' then
        enableWarning = false
    end
    if enableWarning then
        if not downscroll then
            precacheImage('cup/mozo')
        else
            precacheImage('cup/gay')
            cupAlertOfsY = 27
        end
    end
end
function onUpdate()
    if alertCount > alertDestroyed then
        for alerts = alertDestroyed,alertCount-1 do
            local name = 'CupAlert'..alerts
            setProperty(name..'.x',getProperty('healthBar.x') + cupAlertOfsX)
            setProperty(name..'.y',getProperty('healthBar.y') + cupAlertOfsY)
            setProperty(name..'.angle',getProperty('healthBar.angle'))
            if getProperty(name..'.animation.curAnim.finished') then
                removeLuaSprite(name,true)
                alertDestroyed = alertDestroyed + 1
            end
        end
    end
end
function createAlert()
    if enableWarning then
        local name = 'CupAlert'..alertCount
        if not downscroll then
            makeAnimatedLuaSprite(name,'cup/mozo',500,340)
        else
            makeAnimatedLuaSprite(name,'cup/gay',500,110)
        end
        addAnimationByPrefix(name,'Alert','YTJT instance 1',24,false)
        setObjectCamera(name,'hud')
        addLuaSprite(name,true)
        alertCount = alertCount + 1
        playSound('Cup/fuckyoumoro',1,'cupAlert')
    end
end