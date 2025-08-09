function onCreate()
    triggerEvent('coverScreen','1,other',0)
end
function onStepHit()
    if curStep == 3408 then
        setProperty('healthBar.visible',false)
        setProperty('healthBarBG.visible',false)
        setProperty('scoreTxt.color',getColorFromHex('FF0000'))
        setProperty('iconP1.visible',false)
        setProperty('iconP2.visible',false)
        setProperty('dad.visible',false)
    end
end