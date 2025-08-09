local allowCountdown = false
local stops = 0;
function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
        
		setProperty('inCutscene', true);

    if stops == 0 then
        makeLuaSprite('fg1', 'agoti/images/Void_Front', -1100, 0)

        makeAnimatedLuaSprite('agoti', 'agoti/images/Agoti_Cutscene_B', -800, 600) 
        addAnimationByPrefix('agoti', 'cut', 'Agoti_Cut_B', 24, false)

        makeAnimatedLuaSprite('pillar', 'agoti/images/Pillar_FG', -400, 300) 
        addAnimationByPrefix('pillar', 'cut', 'Pillar_FG', 24, false)

        makeAnimatedLuaSprite('pillars', 'agoti/images/Pillar_BG', 200, 300)
        addAnimationByPrefix('pillars', 'pillars', 'Pillar_BG', 24, false)


        setProperty('camFollowPos.x',600)
        setProperty('camFollowPos.y',1100)
        runTimer('startA', 0.1)
	end
    if stops == 1 then
        soundFadeOut('dialogue', 0.7, 0)
        runTimer('startC', 0.1)
        allowCountdown = true;
    end
        stops = stops + 1
		return Function_Stop;
	end
	return Function_Continue;
end

function onTimerCompleted(tag)
    if tag == 'startC' then
        startCountdown()
        setProperty('dad.visible', true)
    end

    if tag == 'pillars' then
        addLuaSprite('pillars', false)
        addLuaSprite('fg1', false)
    end

    if tag == 'pillar' then
        addLuaSprite('pillar', true)
    end

    if tag ==  'startA' then
        playSound('parasiteDialogue', 1, 'dialogue')
        startDialogue('dialogue')
    end

    if tag == 'end' then 
        endSong()
    end
end

function onEndSong()
    if not allowEnd and isStoryMode then

        setProperty('dad.visible', false)

        setProperty('camFollowPos.x',600)
        setProperty('camFollowPos.y',1100)

        playSound('outrocut')
        runTimer('pillars', 2.2)
        runTimer('pillar', 3.9)
        runTimer('end', 6)

        scaleObject('agoti', 1.4, 1.4)
        addLuaSprite('agoti', true)
		allowEnd = true;
		return Function_Stop;
	end
	return Function_Continue;
end