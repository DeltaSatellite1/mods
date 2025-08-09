function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'BendyShadowNote' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'bendy/BendyShadowNoteAssets')
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '-0.023')
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0')
			setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true)
			
			if version >= '0.7' then
				setPropertyFromGroup('unspawnNotes', i, 'rgbShader.enabled', false);
			end
			setPropertyFromGroup('unspawnNotes', i, 'lowPriority', true)
		end
	end
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'BendyShadowNote' then
		-- put something here if you want
		setProperty('health',-1)
	end
end



-- Called after the note miss calculations
-- Player missed a note by letting it go offscreen