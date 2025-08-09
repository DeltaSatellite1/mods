function opponentNoteHit(id, direction, noteType, isSustainNote)
    if (getProperty('health') > 0.4) then
        if (isSustainNote) then
            setProperty('health', getProperty('health') - 0.0375)
        else
            setProperty('health', getProperty('health') - 0.045)
        end
    end
end

local noteTexture = ''
function onCreate()
    if difficulty > 0 then
        for notes = 0,getProperty('unspawnNotes.length')-1 do
            local noteTime = getPropertyFromGroup('unspawnNotes',notes,'strumTime')
            local noteType = getPropertyFromGroup('unspawnNotes',notes,'noteType')
            if noteTime >= 37480 and noteTime <= 48960 or noteTime >= 95000 and noteTime < 118000 or noteTime >= 150000 and noteTime < 174000 then
                if difficulty == 1 then
                    if noteType == nil or noteType == '' then
                        setPropertyFromGroup('unspawnNotes',notes,'texture','bendy/BendyNotes')
                    elseif noteType == 'BendySplashNote' then
                        setPropertyFromGroup('unspawnNotes',notes,'texture','bendy/BendySplashNoteDark')
                    elseif noteType == 'BendyShadowNote' then
                        setPropertyFromGroup('unspawnNotes',notes,'texture','bendy/BendyShadowNoteDark')
                    end
                elseif difficulty == 2 then
                    if noteType == nil or noteType == '' then
                        setPropertyFromGroup('unspawnNotes',notes,'texture','bendy/BendyNotes-Hell')
                    elseif noteType == 'BendySplashNote' then
                        setPropertyFromGroup('unspawnNotes',notes,'texture','bendy/BendySplashNoteDark-Hell')

                    elseif noteType == 'BendyShadowNote' then
                        if not downscroll then
                            setPropertyFromGroup('unspawnNotes',notes,'texture','bendy/BendyShadowNoteDark-Hell')
                        else
                            setPropertyFromGroup('unspawnNotes',notes,'texture','bendy/BendyShadowNoteDark-Hell-Downscroll')
                        end
                    end
                end
                
            end
        end
    end
end
function onCreatePost()
    if difficulty > 0 then
        precacheImage('bendy/BendyNotes')
        if difficulty == 1 then
            precacheImage('bendy/BendyShadowNoteDark')
            precacheImage('bendy/BendySplashNoteDark')
        elseif difficulty == 2 then
            precacheImage('bendy/BendyNotes-Hell')
            precacheImage('bendy/BendySplashNoteDark-Hell')
            
            if downscroll then
                precacheImage('bendy/BendyShadowNoteDark-Hell-Downscroll')
            else
                precacheImage('bendy/BendyShadowNoteDark-Hell')
            end
        end
    end
    if version >= '0.7' then
		if getPropertyFromClass('states.PlayState','SONG.arrowSkin') == nil then
			if getPropertyFromClass('backend.ClientPrefs','data.noteSkin') == 'Default' then
				noteTexture = 'noteSkins/NOTE_assets'
			else
				noteTexture = 'noteSkins/NOTE_assets-'..string.lower(getPropertyFromClass('backend.ClientPrefs','data.noteSkin'))
			end
		end
	else
		if getPropertyFromClass('PlayState','SONG.arrowSkin') == nil then
			noteTexture = 'NOTE_assets'
		else
			noteTexture = getPropertyFromClass('PlayState','SONG.arrowSkin')
		end
	end
end
function onSectionHit()
    if difficulty > 0 then
        if curSection == 26 or curSection == 66 or curSection == 105 then
            for strum = 0,7 do
                setPropertyFromGroup('strumLineNotes',strum,'texture','bendy/BendyNotes')
            end
        elseif curSection == 34 or curSection == 82 or curSection == 121 then
            for strum = 0,7 do
                setPropertyFromGroup('strumLineNotes',strum,'texture',noteTexture)
            end
        end
    end
end