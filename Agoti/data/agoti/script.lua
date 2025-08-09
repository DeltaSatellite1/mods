local allowCountdown = false
local stops = 0;
local defaultNotePos = {};
local spin = true;
local arrowMoveX = 0;
local arrowMoveY = 14;
 
function onStartCountdown()
	doTweenAngle('turn', 'camGame', 1.5, crochet/300, 'sineInOut')
	doTweenAngle('camturn', 'camHUD', -1.5, crochet/300, 'sineInOut')
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
        
		setProperty('inCutscene', true);

    if stops == 0 then
        setProperty('camFollowPos.x',600)
        setProperty('camFollowPos.y',1100)
        startDialogue('dialogue')
        allowCountdown = true;
	end
        stops = stops + 1
		return Function_Stop;
	end
	return Function_Continue;
end

function onSongStart()
    for i = 0,7 do 
        x = getPropertyFromGroup('strumLineNotes', i, 'x')
        y = getPropertyFromGroup('strumLineNotes', i, 'y')
        table.insert(defaultNotePos, {x,y})
    end
end
function onUpdate(elapsed)
    songPos = getPropertyFromClass('Conductor', 'songPosition');
    currentBeat = (songPos / 1000) * (bpm / 60)
    if spin == true then 
        for i = 0,7 do 
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + arrowMoveX * math.sin((currentBeat + i*0.25) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + arrowMoveY * math.cos((currentBeat + i*0.25) * math.pi))
        end
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	cameraShake('hud', 0.005, 0.2)
	cameraShake('game', 0.005, 0.2)
end

function onTweenCompleted(t)
	if t == 'turn' then
		doTweenAngle('turn1', 'camGame', -1.5, crochet/300, 'sineInOut')
		doTweenAngle('camturn1', 'camHUD', 1.5, crochet/300, 'sineInOut')
	end
	if t == 'turn1' then
		doTweenAngle('turn', 'camGame', 1.5, crochet/300, 'sineInOut')
		doTweenAngle('camturn', 'camHUD', -1.5, crochet/300, 'sineInOut')
	end
end
