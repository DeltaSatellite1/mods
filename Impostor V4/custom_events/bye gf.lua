local bye = false
local gfSpeed = 0
local fps = 0
function onEvent(name)
    if name == 'bye gf' then
        bye = true
    end
end
function onUpdate(el)
    if bye then
        fps = fps + el
        if fps >= 1/240 and gfSpeed < 40 then
            gfSpeed = gfSpeed + 0.1
            setProperty('gf.x',getProperty('gf.x') - gfSpeed)
            fps = 0
        end
    end
end