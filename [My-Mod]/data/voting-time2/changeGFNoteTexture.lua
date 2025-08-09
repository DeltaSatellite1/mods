function onCreatePost()
    for notes = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes',notes,'noteType') == 'GF Sing' then
            setPropertyFromGroup('unspawnNotes',notes,'ignoreNote',true)
            setPropertyFromGroup('unspawnNotes',notes,'active',false)
            setPropertyFromGroup('unspawnNotes',notes,'texture','ExtraNote')
        end
    end
end
function onUpdate(el)
    for notes = 0,getProperty('notes.length')-1 do
        if getPropertyFromGroup('notes',notes,'noteType') == 'GF Sing' then
            local noteOfs = 15
            if getPropertyFromGroup('notes',notes,'isSustainNote') then
                noteOfs = 30
            end
            if getPropertyFromGroup('notes',notes,'strumTime') - getSongPosition() <= noteOfs then
                local singAnims = {'singLEFT','singDOWN','singUP','singRIGHT'}
                characterPlayAnim('gf',singAnims[getPropertyFromGroup('notes',notes,'noteData') + 1],true)
                setProperty('gf.holdTimer',0)
                if getPropertyFromGroup('notes',notes,'mustPress') == false then
                    callOnLuas('opponentNoteHit', {notes,getPropertyFromGroup('notes',notes,'noteData'),'GF Sing',getPropertyFromGroup('notes',notes,'isSustainNote')})
                else
                    callOnLuas('goodNoteHit', {notes,getPropertyFromGroup('notes',notes,'noteData'),'GF Sing',getPropertyFromGroup('notes',notes,'isSustainNote')})
                end
                removeFromGroup('notes',notes)
            end
        end
    end
end