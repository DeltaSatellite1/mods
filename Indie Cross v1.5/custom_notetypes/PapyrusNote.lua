function onCreatePost()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'PapyrusNote' then
			setPropertyFromGroup('unspawnNotes', i, 'copyX', false)
			setPropertyFromGroup('unspawnNotes', i, 'copyX', false)
			setPropertyFromGroup('unspawnNotes', i, 'copyAlpha', false)
			setPropertyFromGroup('unspawnNotes', i,'texture','sans/PapyrusNote')
			if version >= '0.7' then
				--setPropertyFromGroup('unspawnNotes', i, 'rgbShader.r', getColorFromHex('FF9228'))
				--setPropertyFromGroup('unspawnNotes', i, 'rgbShader.g', getColorFromHex('FF9228'))
				--setPropertyFromGroup('unspawnNotes', i, 'rgbShader.b', getColorFromHex('A75B28'))
				setPropertyFromGroup('unspawnNotes', i, 'rgbShader.enabled', false)

			end
			--setPropertyFromGroup('unspawnNotes', i, 'noteSplashData.useRGBShader', false);
        end
    end
end

function onUpdatePost(el)
    for i = 0, getProperty('notes.length')-1 do
        if getPropertyFromGroup('notes', i, 'noteType') == 'PapyrusNote' and getPropertyFromGroup('notes',i,'copyX') == false then
			--local strumTime = getPropertyFromGroup('notes', i, 'strumTime')
			local sus = getPropertyFromGroup('notes', i, 'isSustainNote')
			local noteDir = getPropertyFromGroup('notes', i, 'noteData')
			local noteOffsetX = getPropertyFromGroup('notes', i, 'offsetX')
			local noteDistance = math.abs(getPropertyFromGroup('notes', i, 'distance'))
			local noteAlpha = getPropertyFromGroup('notes', i, 'alpha')
			local noteX = getPropertyFromGroup('notes', i, 'x')
			if getPropertyFromGroup('notes',i,'mustPress') == true then
				noteDir = noteDir + 4
			end
			local noteAngleDir = getPropertyFromGroup('strumLineNotes',noteDir,'direction') * math.pi / 180
			local strumX = getPropertyFromGroup('strumLineNotes',noteDir,'x') + noteOffsetX+  (math.cos(noteAngleDir) * noteDistance)
			local opostStrumX = getPropertyFromGroup('strumLineNotes',(noteDir + 4)%8,'x') + noteOffsetX + (math.cos(noteAngleDir) * noteDistance)

			if noteDistance < 250 * scrollSpeed then
				if noteX == opostStrumX and not sus then
					playSound('sans/ping')
				end
				noteX = noteX + (strumX - noteX)*(el*10)

				if math.abs(strumX - noteX) <= 15 then
					setPropertyFromGroup('notes', i, 'copyX', true)
					setPropertyFromGroup('notes', i, 'copyAlpha', true)
				end
			else
				noteX = opostStrumX
				--noteAlpha = getPropertyFromGroup('strumLineNotes', (noteDir + 4)%8, 'alpha')
			end
			setPropertyFromGroup('notes', i, 'x', noteX)
			setPropertyFromGroup('notes', i, 'alpha', noteAlpha)
		end
    end
end