local slaying = false
local slay = 0
local slayDir = 0
local allowCountdown = false

function onCreate()
    makeLuaSprite('Slay', 'Splash', 0, 0)
    setObjectCamera('Slay', 'camHUD')
    screenCenter('Slay', 'XY')
    -- debugPrint('we up in here')

    setProperty('dad.alpha', 0)
end

function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and not seenCutscene then
		setProperty('inCutscene', true);
        addLuaSprite('Slay', true)
		runTimer('endShit', 1.8);
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'endShit' then -- Timer completed, play dialogue
		doTweenAlpha('Slayin', 'Slay', 0, 1, 'sineOut')
	end
end

function onTweenCompleted(tag)
    if tag == 'Slayin' then
        removeLuaSprite('Slay', false)
        startDialogue('poggin', 'pog');
    end
end

function onStepHit()
    if curStep == 1 then
        doTweenAlpha('pog', 'dad', 1, 1.3, 'sineIn')
    end
    if curStep == 2427 then
       doTweenAlpha('gah', 'dad', 0.8, 0.4, 'sineOut')
    end

    if curStep == 2943 then
        doTweenAlpha('gahh', 'dad', 0, 0.4, 'sineOut')
    end
end