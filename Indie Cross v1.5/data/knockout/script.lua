local ending = false

function onCreate()
    makeAnimatedLuaSprite('MugMan','cup/Mugman Fucking dies',2000,1300)
    addAnimationByPrefix('MugMan','Walking','Mugman instance 1',24,false)
    addAnimationByPrefix('MugMan','Dead','MUGMANDEAD YES instance 1',24,false)
    playAnim('MugMan','Walking',false)
    setProperty('MugMan.alpha',0.001)
    updateHitbox('MugMan')
    addLuaSprite('MugMan',true)

    makeAnimatedLuaSprite('KnockOutText','cup/knock',125,200)
    addAnimationByPrefix('KnockOutText','Knock','A KNOCKOUT!',28,false)
    setObjectCamera('KnockOutText','hud')
    scaleObject('KnockOutText',0.9,0.9)
    setProperty('KnockOutText.alpha',0.001)
    addLuaSprite('KnockOutText',true)
end

function onUpdate()
    if luaSpriteExists('KnockOutText') and getProperty('KnockOutText.animation.curAnim.finished') and getProperty('KnockOutText.alpha') == 1 and not ending then
        doTweenAlpha('KnockBye','KnockOutText',0,1,'LinearOut')
        ending = true
    end
end

function onStepHit()
    if curStep == 1150 then
        playAnim('MugMan','Walking',true)
        setProperty('MugMan.alpha',1)
    elseif curStep == 1174 then
        playAnim('MugMan','Dead',false)
        playSound('Cup/CupHurt')
        playSound('Cup/knockout')
        setProperty('KnockOutText.alpha',1)
        playAnim('KnockOutText','Knock',true)
        callScript('custom_events/CupheadAttack','shotHit',{'MugMan'})
    end
end
function onTweenCompleted(tag)
    if tag == 'KnockBye' then
        removeLuaSprite('KnockOutText',true)
    end
end


