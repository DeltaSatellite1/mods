function onCreate()
    addLuaScript('custom_events/coverScreen')
end
function onEvent(name,v1,v2)
    if name == 'susVideo' then
        startVideo(v1)
        if string.lower(v2) == 'false' then
            setProperty('inCutscene',false)
        end
        if string.lower(v1) == 'meltdown' then
            triggerEvent('coverScreen','1,other','0')
        end
    end
end