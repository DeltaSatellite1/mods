function onCreate()
    makeLuaSprite('whoBG','polus/deadguy',0,100)
    addLuaSprite('whoBG',false)
    triggerEvent('FocusCamScript','both','')
end
function onEvent(name,v1,v2)
    if name == "Who Buzz" and v1 == '1' then
        removeLuaSprite('whoBG',true)
    end
end
