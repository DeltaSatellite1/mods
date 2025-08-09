function onCreate()
    precacheImage('henry/i_schee_u_enry')
    precacheSound('rhm_crash')
    makeAnimatedLuaSprite('armedGuy','henry/i_schee_u_enry',-800,-300)
    addAnimationByPrefix('armedGuy','attack','rhm intro shadow',16,false)
    setProperty('armedGuy.alpha',0.001)
    addLuaSprite('armedGuy',true)
    addLuaScript('custom_events/shakeCam')
    addLuaScript('custom_events/flash')
end
local allowEnd = false
function onEndSong()
    if not allowEnd then
        triggerEvent('FocusCamScript','dad,dad','')
        characterPlayAnim('dad','armed',false)
        playSound('rhm_crash')
        doTweenAlpha('camBye','camHUD',0,0.4,'linear')
        setProperty('dad.specialAnim',true)
        triggerEvent('Extra Play Animation','3','armed')
        allowEnd = true
        runTimer('rhmShake',1.5)
        return Function_Stop
    end
end
function onTimerCompleted(tag)
    if tag == 'rhmShake' then
        triggerEvent('shakeCam','0,0.03','1.6')
        runTimer('rhmAppear',1.42)
        runTimer('rhmCrash',1.6)
    elseif tag == 'rhmAppear' then
        setProperty('armedGuy.alpha',1)
        objectPlayAnimation('armedGuy','attack',true)
    elseif tag == 'rhmCrash' then
        setProperty('camGame.alpha',0)
        triggerEvent('flash','','4,other')
        runTimer('endRhmSong',4)
    elseif tag == 'endRhmSong' then
        endSong()
    end
end