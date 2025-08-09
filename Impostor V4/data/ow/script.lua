function onCreate()
    if getProperty('boyfriend.curCharacter') == 'blue' then
	    addCharacterToList('bluehit', 'boyfriend')
    end
end
local anims = {"singLEFT", "singDOWN", "singUP", "singRIGHT"}
function opponentNoteHit(id, direction, noteType, isSustainNote)
    if getProperty('boyfriend.curCharacter') == 'blue' or getProperty('boyfriend.curCharacter') == 'bluehit' then
        if getProperty('boyfriend.curCharacter') == 'blue' then
            triggerEvent('Change Character', 'bf', 'bluehit')
        end
        triggerEvent('Play Animation', anims[direction + 1], 'bf')
    end
end
function goodNoteHit(id, direction, noteType, isSustainNote)
    if getProperty('boyfriend.curCharacter') == 'bluehit' then
	    triggerEvent('Change Character', 'bf', 'blue')
        characterPlayAnim('boyfriend', anims[direction + 1], true)
        setProperty('boyfriend.holdTimer',0)
    end
end
function noteMiss(id, direction, noteType, isSustainNote)
    if getProperty('boyfriend.curCharacter') == 'bluehit' then
	    triggerEvent('Change Character', 'bf', 'blue')
    end
end