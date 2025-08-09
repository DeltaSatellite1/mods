function onCreatePost()
    for notes = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes',notes,'noteType') == 'GF Sing' then
            setPropertyFromGroup('unspawnNotes',notes,'ignoreNote',true)
            setPropertyFromGroup('unspawnNotes',notes,'active',false)
            if version <= '0.6.3' or version >= '0.7' and getPropertyFromClass('states.PlayState','SONG.disableNoteRGB') then
                setPropertyFromGroup('unspawnNotes',notes,'texture','ExtraNote')
            elseif version >= '0.7' then
                setPropertyFromGroup('unspawnNotes',notes,'rgbShader.r',getColorFromHex('EEEEEE'))
                setPropertyFromGroup('unspawnNotes',notes,'rgbShader.g',getColorFromHex('FFFFFF'))
                setPropertyFromGroup('unspawnNotes',notes,'rgbShader.b',getColorFromHex('808080'))
                setPropertyFromGroup('unspawnNotes',notes,'multAlpha',0.5)
            end
        end
    end
end
function onUpdate(el)
    for notes = 0,getProperty('notes.length')-1 do
        if getPropertyFromGroup('notes',notes,'noteType') == 'GF Sing' then
            local noteOfs = 5
            if getPropertyFromGroup('notes',notes,'isSustainNote') then
                noteOfs = 30
            end
            if getPropertyFromGroup('notes',notes,'strumTime') - getSongPosition() <= noteOfs then
                characterPlayAnim('gf',getProperty('singAnimations['..getPropertyFromGroup('notes',notes,'noteData')..']'),true)
                setProperty('gf.holdTimer',0)
                setProperty('camZooming',true)
                setProperty('vocals.volume',1)

                if getPropertyFromGroup('notes',notes,'mustPress') == false then
                    callOnLuas('opponentNoteHit',{notes,getPropertyFromGroup('notes',notes,'noteData'),'GF Sing',getPropertyFromGroup('notes',notes,'isSustainNote')})
                else
                    callOnLuas('goodNoteHit',{notes,getPropertyFromGroup('notes',notes,'noteData'),'GF Sing',getPropertyFromGroup('notes',notes,'isSustainNote')})
                end
                removeFromGroup('notes',notes)
            end
        end
    end
end