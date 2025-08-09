local t = 0
local s = 0
function onCreate()

    makeLuaSprite('bg', 'W2/halloween_bgmonster', -530, -140)
    addLuaSprite('bg', false)
    setGraphicSize('bg', getProperty('bg.width') * 1.2)
end

function onCreatePost()
    setProperty('gf.alpha', 1)
end