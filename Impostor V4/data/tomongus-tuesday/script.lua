function onCreate()
    precacheSound('soundTuesday')
end
function onStepHit()
    if curStep == 985 then
        playSound('soundTuesday')
    end
end