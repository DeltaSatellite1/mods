function onUpdate(el)
    if curStep >= 1209 then
        setProperty('dad.x',getProperty('dad.x') + (2200 * el))
        setProperty('dad.y',getProperty('dad.y') + (320 * el))
        setProperty('dad.angle',getProperty('dad.angle') + (270 * el))
    end
end