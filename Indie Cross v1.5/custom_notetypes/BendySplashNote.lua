function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'BendySplashNote' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'bendy/BendySplashNoteAssets');
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '-0.023');
			setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true);
			setPropertyFromGroup('unspawnNotes', i, 'lowPriority', true);
			if version >= '0.7' then
				setPropertyFromGroup('unspawnNotes', i, 'rgbShader.enabled', false);
			end
		end
	end
	addLuaScript('extra_scripts/InkScreen')
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'BendySplashNote' then
		-- put something here if you want
		addInk()
	end
end
function addInk()
    callScript('extra_scripts/InkScreen','addInk')
end