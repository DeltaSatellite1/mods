function disableNotes(mustPress,time)
    if time == nil then
        time = 500
    end
    for notesLength = 0,getProperty('notes.length')-1 do
        if getPropertyFromGroup('notes', notesLength, 'strumTime') - getSongPosition() <= time and getPropertyFromGroup('notes', notesLength, 'mustPress') == mustPress then
            setPropertyFromGroup('notes', notesLength, 'noAnimation', true)
        end
    end
end

function setCamTarget(target)
    setProperty('isCameraOnForcedPos',target ~= nil)
    if target ~= nil then
        cameraSetTarget(target)
    else
        if not gfSection then
            if mustHitSection then
                cameraSetTarget('boyfriend')
            else
                cameraSetTarget('dad')
            end
        else
            cameraSetTarget('gf')
        end
    end
end