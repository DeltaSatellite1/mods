local cutsceneStarted = false
function onCreatePost()
    if curStep < 256 then
        addLuaScript('custom_events/coverScreen')
        triggerEvent('coverScreen','1,other','0')
    end
end
function onPause()
    if curStep < 256 then
        return Function_Stop;
    end
    return Function_Continue;
end
function onSongStart()
    if curStep == 0 then
        startVideo('ejected')
        setProperty('inCutscene',false)
        cutsceneStarted = true
    elseif curStep > 256 then
        triggerEvent('coverScreen','0,other','0')
    end
end
function onUpdate()
    if curStep < 0 then
        for strumLine = 0,7 do
            setPropertyFromGroup('strumLineNotes',strumLine,'alpha',getPropertyFromGroup('strumLineNotes',strumLine,'alpha') - 1)
        end
    else
        if version <= '0.6.3' and cutsceneStarted and curStep < 256 and (keyboardJustPressed('ENTER') or keyboardJustPressed('SPACE')) then
            local songPos = 24700
            setPropertyFromClass('Conductor', 'songPosition', songPos)
            setPropertyFromClass('flixel.FlxG', 'sound.music.time', songPos)
            setProperty('vocals.time', songPos)
            endEjected()
        end
    end
end
function endEjected()
    cutsceneStarted = false
    triggerEvent('coverScreen','0,other,FFFFFF','1')
    setProperty('inCutscene',false)
end
function onStepHit()
    if curStep >= 256 and cutsceneStarted then
        endEjected()
        close(true)
    end
end
function onCountdownTick(counter)
    if counter > 0 then
        if counter == 1 then
            setObjectCamera('countdownReady','other')
            scaleObject('countdownReady',0.6,0.6)
            setProperty('countdownReady.offset.x',0)
            setProperty('countdownReady.offset.y',0)
        elseif counter == 2 then
            setObjectCamera('countdownSet','other')
            scaleObject('countdownSet',0.6,0.6)
            setProperty('countdownSet.offset.x',0)
            setProperty('countdownSet.offset.y',0)
        elseif counter == 3 then
            setObjectCamera('countdownGo','other')
            scaleObject('countdownGo',0.6,0.6)
            setProperty('countdownGo.offset.x',0)
            setProperty('countdownGo.offset.y',0)
        end
    end
end