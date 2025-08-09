function onCreate()
    makeLuaSprite('warn', 'warn', 0, 0)
    setObjectCamera('warn', 'camOther')
    addLuaSprite('warn')
    setProperty('warn.alpha', 0)
end

function onSongStart()
    if difficultyName == 'Insane' then
        runTimer('warn', 3)
        doTweenAlpha('warn', 'warn', 1, 0.7, 'sineInOut')
    end
    if difficultyName == 'Expert' then
        runTimer('warn', 3)
        doTweenAlpha('warn', 'warn', 1, 2, 'sineInOut')
    end
end

function onTimerCompleted(t)
    if t == 'warn' then
        doTweenAlpha('warn', 'warn', 0, 2, 'sineInOut')
    end
end