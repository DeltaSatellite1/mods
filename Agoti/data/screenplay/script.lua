local allowCountdown = false
local stops = 0;
function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
        
		setProperty('inCutscene', true);

    if stops == 0 then
        setProperty('dad.visible', false)

        makeAnimatedLuaSprite('agoti1', 'agoti/images/Agoti_Micless', -40, 730) 
        addAnimationByPrefix('agoti1', 'cut', 'Agoti_Idle_Micless', 24, false)

        setProperty('camFollowPos.x',600)
        setProperty('camFollowPos.y',1100)

        scaleObject('agoti1', 0.9, 0.9)

        addLuaSprite('agoti1', true)

        runTimer('startA', 0.1)
	end

    if stops == 1 then
        soundFadeOut('dialogue', 0.7, 0)
        makeAnimatedLuaSprite('agoti', 'agoti/images/Agoti_Cutscene_A', -630, 450) 
        addAnimationByPrefix('agoti', 'cut', 'Agoti_Cut_A', 24, false)

        setProperty('dad.visible', false)
        setProperty('agoti1.visible', false)

        playSound('introcut')

        scaleObject('agoti', 1.22, 1.22)
        addLuaSprite('agoti', true)
        runTimer('startC', 4)
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
        setProperty('agoti.visible', false)
        setProperty('dad.visible', true)
    end

    if tag ==  'startA' then
        playSound('screenplayDialogue', 1, 'dialogue')
        startDialogue('dialogue')
    end
end