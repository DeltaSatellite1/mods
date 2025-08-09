local t = 0
local s = 0
function onCreate()

    makeLuaSprite('sky', 'W3/skyDark', -350, -50)
    addLuaSprite('sky', false)
    setScrollFactor('sky', 0.95, 1)
    setGraphicSize('sky', getProperty('sky.width') * 1.2)

    makeLuaSprite('thecity', 'W3/cityDark', -350, -50)
    addLuaSprite('thecity', false)
    setScrollFactor('thecity', 0.95, 1)
    setGraphicSize('thecity', getProperty('thecity.width') * 1.2)

    makeLuaSprite('BTT', 'W3/behindTrainDark', -350, -50)
    addLuaSprite('BTT', false)
    setScrollFactor('BTT', 0.95, 1)
    setGraphicSize('BTT', getProperty('BTT.width') * 1.2)

    makeLuaSprite('street', 'W3/streetDark', -350, -50)
    addLuaSprite('street', false)
    setScrollFactor('street', 0.95, 1)
    setGraphicSize('street', getProperty('street.width') * 1.2)

    makeAnimatedLuaSprite('crowd', 'W3/Crowd2DARK', -320, 110)
    addAnimationByPrefix('crowd', 'idle', 'Crowd2 instance 1',24,true)
    addLuaSprite('crowd', false)

end

function onBeatHit()--for every beat
    objectPlayAnimation('crowd', 'idle', true)

end

function onStepHit()--for every step
    --body
end


