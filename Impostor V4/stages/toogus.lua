function onCreate()
    makeLuaSprite('toogusBg','toogus/mirabg',-1800,10)
    scaleObject('toogusBg',1.09,1.05)
    addLuaSprite('toogusBg',false)
    makeLuaSprite('toogusFloor','toogus/mirafg',-1800,30)
    scaleObject('toogusFloor',1.09,1.05)
    addLuaSprite('toogusFloor',false)
    makeLuaSprite('toogusTable','toogus/table_bg',-1800,25)
    scaleObject('toogusTable',1.09,1.05)
    addLuaSprite('toogusTable',false)
end
function onEvent(name,v1,v2)
    if name == 'Lights out' then
        if string.lower(v1) == 'on' or v1 == '' then
            setObjectsAlpha(0)
        else
            setObjectsAlpha(1)
        end
    end
end
function setObjectsAlpha(alpha)
    setProperty('toogusBg.alpha',alpha)
    setProperty('toogusFloor.alpha',alpha)
    setProperty('toogusTable.alpha',alpha)
end


