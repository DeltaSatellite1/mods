function onCreate()
	--Iterate over all notes
	for unnotesLength = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', unnotesLength, 'noteType') == 'BlueBoneNote' then
			setPropertyFromGroup('unspawnNotes', unnotesLength, 'texture', 'sans/BlueNote_assets');
			setPropertyFromGroup('unspawnNotes', unnotesLength, 'ignoreNote', true);
			if version >= '0.7' then
				setPropertyFromGroup('unspawnNotes', unnotesLength, 'rgbShader.enabled', false);
			end
		end
	end
end


function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'BlueBoneNote' then
	 	setHealth(getHealth() - 0.4)
	end
end