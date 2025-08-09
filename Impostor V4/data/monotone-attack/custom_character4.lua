function onCreatePost()
	addLuaScript('extra_scripts/extraCharacter')
	callScript('extra_scripts/extraCharacter','createExtraCharacter',{'Biddle','Biddle',1600,660})
	setProperty('Biddle.flipX',not getProperty('Biddle.flipX'))
end
function onUpdate(el)	
    for notes = 0,getProperty('notes.length')-1 do
        if getPropertyFromGroup('notes',notes,'noteType') == 'Player 2 Sing' then
			local noteOfs = 5
			if getPropertyFromGroup('notes',notes,'isSustainNote') then
				noteOfs = 20
			end
            if getPropertyFromGroup('notes',notes,'strumTime') - getSongPosition() <= noteOfs then
				playAnim('Biddle',getProperty('singAnimations['..getPropertyFromGroup('notes',notes,'noteData')..']'),true)
				setProperty('Biddle.holdTimer',0)
                removeFromGroup('notes',notes)
            end
        end
    end
end