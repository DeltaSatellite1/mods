function onCreate()
    makeLuaText('skipFinale','Press Space to Skip',350,425,0)
    setObjectCamera('skipFinale','other')
    setTextSize('skipFinale',30)
    setProperty('skipFinale.alpha',0.001)
    addLuaText('skipFinale',true)
end
function onSongStart()
    if curStep < 127 then
        doTweenAlpha('skipFinaleText','skipFinale',0.4,2,'sineOut')
        runTimer('byeSkipText',10)
    end
end
function onTimerCompleted(tag)
    if tag == 'byeSkipText' then
        doTweenAlpha('skipFinaleTextBye','skipFinale',0,2,'sineOut')
    end
end
function onTweenCompleted(tag)
    if tag == 'skipFinaleTextBye' then
        removeLuaText('skipFinaleText',true)
    end
end
function onUpdate()
    if curStep > 0 and curStep < 127 and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') then
        triggerEvent('coverScreen','0','0.1')
        setPropertyFromClass('Conductor', 'songPosition', 9540)
        setPropertyFromClass('flixel.FlxG', 'sound.music.time', 9540)
        setProperty('vocals.time', 9540)
        triggerEvent('Extra Cam Zoom','0','0.1')
        cancelTween('skipIdentityTextBye')
        cancelTween('skipIdentityText')
        cancelTimer('byeSkipText')
        removeLuaText('skipFinale',true)
    end
end