function onCreate()
    makeLuaText('skipIdentity','Press Space to Skip',350,425,0)
    setObjectCamera('skipIdentity','other')
    setTextSize('skipIdentity',30)
    setProperty('skipIdentity.alpha',0.001)
    addLuaText('skipIdentity',true)
end
function onSongStart()
    doTweenAlpha('skipIdentityText','skipIdentity',0.5,2,'sineOut')
    runTimer('byeSkipText',5)
end
function onTimerCompleted(tag)
    if tag == 'byeSkipText' then
        doTweenAlpha('skipIdentityTextBye','skipIdentity',0,2,'sineOut')
    end
end
function onTweenCompleted(tag)
    if tag == 'skipIdentityTextBye' then
        removeLuaText('skipIdentity',true)
    end
end
function onUpdate()
    if curStep > 0 and curStep < 256 and getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') then
        local songPos = 22000
        removeLuaText('skipIdentity',true)
        triggerEvent('coverScreen','0','0.1')
        setPropertyFromClass('backend.Conductor', 'songPosition', songPos)
        setPropertyFromClass('flixel.FlxG', 'sound.music.time', songPos)
        setProperty('vocals.time', songPos)
        triggerEvent('Set Cam Zoom','0.4','0.1')
        cancelTween('skipIdentityTextBye')
        cancelTween('skipIdentityText')
        cancelTimer('byeSkipText')
    end
end