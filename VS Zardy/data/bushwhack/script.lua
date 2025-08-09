local spin = false
local arrowMoveX = 20
local arrowMoveY = 0
local defaultNotePos = {};


function onCreate()
    makeLuaSprite('mic', 'Mic', 320, 400)
    addLuaSprite('mic')
    scaleObject('mic', 0.4, 0.4)
    setProperty('mic.alpha', 0)

    makeLuaSprite('hand', 'Arm0', -2920, 440)
    addLuaSprite('hand')
    scaleObject('hand', 0.4, 0.4)

    makeLuaSprite('otherHand', 'Grab',getProperty('dad.x') - 1260, 440)
    addLuaSprite('otherHand')
    scaleObject('otherHand', 0.4, 0.4)
    setProperty('otherHand.alpha', 0)

    makeLuaSprite('Slay', 'Splash', 0, 0)
    setObjectCamera('Slay', 'camHUD')
    screenCenter('Slay', 'XY')
    -- debugPrint('we up in here')

    setProperty('dad.alpha', 0)

end

function onSongStart()
    for i = 0, 7 do
        x = getPropertyFromGroup('strumLineNotes', i, 'x')

        y = getPropertyFromGroup('strumLineNotes', i, 'y')

        table.insert(defaultNotePos, {x,y})
      --  debugPrint("{" .. x .. "," .. y .. "}" .. " i:".. i)
    end
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
    
function onStepHit()
    if curStep == 1 then
        doTweenAlpha('pog', 'dad', 1, 1.3, 'sineIn')
    elseif curStep == 1910 then
        setProperty('mic.alpha', 1)
        doTweenAlpha('hehehe', 'dad', 0, 0.3, 'sineOut')
    elseif curStep == 1920 then
        doTheThing()
        setProperty('defaultCamZoom', 1.8)
    elseif curStep == 1967 then
        setProperty('defaultCamZoom', 0.7)
    end

    if curStep == 4189 then
        songPos = getPropertyFromClass('Conductor',  'songPosition');

        currentBeat = (songPos / 1000) * (bpm / 60)
    
        if  spin == true then
            for i = 0, 7 do
                setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + arrowMoveX * math.sin((currentBeat + i * 0.25) * math.pi))
    
                setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + arrowMoveY * math.cos((currentBeat + i * 0.25) * math.pi))
            end
        end
    end

end

function doTheThing()
    doTweenX('hand', 'hand', getProperty('mic.x') -1180, 1, 'sineOut') 
    setProperty('dad.x', -1600)
    -- Don't think this is something simple
end

function onTweenCompleted(tag)
    if tag == 'hand' then
        doTweenX('otherHand', 'otherHand', getProperty('dad.x') - 3360, 0.8, 'sineIn')
        setProperty('mic.alpha', 0)
        setProperty('hand.alpha', 0)
        setProperty('otherHand.alpha', 1)
        playSound('cable_claw_impact', 0.9)
        playSound('cable_claw_retract', 0.9)
        triggerEvent('Change Character', '1', 'cableCrowPog')
        setProperty('dad.x', -1600)
    end

    if tag == 'otherHand' then
        doTweenX('cableSpawn', 'dad', getProperty('dad.x') + 1410, 1, 'sineIn')
        doTweenX('Lol', 'mic', 3410, 1.6, 'sineIn')
        doTweenAlpha('heheheh', 'dad', 1, 0.3, 'sineIn')
        playSound('micfuckinhit', 0.9)
        runTimer('hand', 0.1)
        setProperty('mic.x', getProperty('dad.x'))
        setProperty('mic.alpha', 1)
       
    end

    if tag == 'Left' then
        doTweenAngle('Right', 'mic', 360, 0.6, 'sineInOut')
    end

    if tag == 'Right' then
        -- doTweenAngle('Left', 'mic', 360, 0.6, 'sineInOut')
        runTimer('mic', 0.6)
    end

    if tag == 'Slayin' then
        removeLuaSprite('Slay', false)
        startDialogue('poggin', 'pog');
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'hand' then 
        doTweenAngle('Left', 'mic', 360, 0.6, 'sineInOut')
    end

    if tag == 'mic' then 
        doTweenAngle('Left', 'mic', 360, 0.6, 'sineInOut')
        runTimer('hand', 0.1)
    end

    if tag == 'endShit' then -- Timer completed, play dialogue
		doTweenAlpha('Slayin', 'Slay', 0, 1, 'sineOut')
	end
end