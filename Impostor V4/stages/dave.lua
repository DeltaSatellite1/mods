function onCreate()
    makeLuaSprite('daveBG','polus/DAVE',0,0)
    scaleObject('daveBG',1.02,1.02)
    addLuaSprite('daveBG',false)
    if songName == 'Crewicide' then
        precacheImage('daveBG2','polus/DAVEdie')
        makeLuaSprite('daveBG2','polus/DAVEdie',0,0)
        scaleObject('daveBG2',1.02,1.02)
        precacheSound('davewindowsmash')
    end
end
function onUpdate()
    if songName == 'Crewicide' and getProperty('dad.visible') and getProperty('dad.curCharacter') == 'dave' and getProperty('dad.animation.curAnim.finished') and getProperty('dad.animation.curAnim.name') == 'die' then
        setProperty('dad.visible',false)
        addLuaSprite('daveBG2',false)
        playSound('davewindowsmash')
        cameraShake('camGame',0.05,0.6)
        cameraShake('camHUD',0.05,0.6)
        removeLuaSprite('daveBG',true)
    end
end
