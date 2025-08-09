local positioned = nil
function onUpdate()
    if not positioned and positioned ~= nil then
        for strumLine = 0,3 do
            setPropertyFromGroup('strumLineNotes',strumLine,'visible',false)
        end
        if not middlescroll then
            for strumLine = 4,7 do
                setPropertyFromGroup('strumLineNotes',strumLine,'x',412 + (112 * (strumLine - 4)))
            end
        end
        positioned = true
    end
end
function onCreate()
    for notesLength = 0,getProperty('unspawnNotes.length')-1 do
        if not getPropertyFromGroup('unspawnNotes',notesLength,'mustPress') then
            setPropertyFromGroup('unspawnNotes',notesLength,'visible',false)
        end
    end
end
function onCountdownTick(count)
    if count >= 0 and positioned == nil then
        positioned = false
    end
end