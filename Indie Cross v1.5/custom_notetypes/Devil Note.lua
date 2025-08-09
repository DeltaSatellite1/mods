local DrainTime = 0
function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Devil Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'cup/devilNOTE_assets'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth',-0.05); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
			end
			if version >= '0.7' then
				setPropertyFromGroup('unspawnNotes', i, 'rgbShader.enabled', false);
			end
		end
	end
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Devil Note' then
		-- put something here if you want
		DrainTime = 1
		playSound('cup/burnSound')
	end
end

-- Called after the note miss calculations
-- Player missed a note by letting it go offscreen

function onUpdate(el)
	if DrainTime > 0  then
		DrainTime = DrainTime - el
		setHealth(getHealth() - (el/2 * (math.floor(DrainTime + 1))))
	end
end