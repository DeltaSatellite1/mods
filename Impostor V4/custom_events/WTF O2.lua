local started = false
function onCreate()
    makeAnimatedLuaSprite('O2Wtf','airship/wtf',400,300)
    addAnimationByPrefix('O2Wtf','what','wtf what',0,true)
    addAnimationByPrefix('O2Wtf','the','wtf the',0,true)
    addAnimationByPrefix('O2Wtf','fuck','wtf fuck',0,true)
    setObjectCamera('O2Wtf','hud')
    setProperty('O2Wtf.alpha',0.01)
    addLuaSprite('O2Wtf',true)
end
function onEvent(name,v1,v2)
    if name == "WTF O2" then
        if v1 ~= '' and v1 ~= 'die' then
            if not started then
                setProperty('healthBar.visible',false)
                setProperty('healthBarBG.visible',false)
                setProperty('iconP1.visible',false)
                setProperty('iconP2.visible',false)
                for strumLine = 0,3 do
                    setPropertyFromGroup('strumLineNotes',strumLine,'visible',false)
                end
                setProperty('O2Wtf.alpha',1)
                setProperty('timeBar.alpha',0)
                setProperty('timeBarBG.alpha',0)
                started = true
            end
            objectPlayAnimation('O2Wtf',v1,true)
        else
            for strumLine = 0,3 do
                setPropertyFromGroup('strumLineNotes',strumLine,'visible',true)
            end
            if started then
                removeLuaSprite('O2Wtf',true)
            end
        end
    end
end