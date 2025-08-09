function onCreate()
    makeAnimatedLuaSprite('AttackButton','IC_Buttons',-6,245)
    addAnimationByPrefix('AttackButton','Static','Attack instance 1',24,true)
    addOffset('AttackButton','Static',0,0)
    addAnimationByPrefix('AttackButton','NA','AttackNA instance 1',30,false)
    addOffset('AttackButton','NA',0,25)
    
    setObjectCamera('AttackButton','hud')
    addLuaSprite('AttackButton',false)
    scaleObject('AttackButton',0.5,0.5)
    setProperty('AttackButton.alpha',0.5)
    playAnim('AttackButton','Static',true)
end
function onUpdate()
    if getProperty('AttackButton.animation.curAnim.finished') then
        playAnim('AttackButton','Static',true)
    end
end