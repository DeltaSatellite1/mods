local allowCountDown = true
function onCreate()
    if isStoryMode and not getPropertyFromClass('PlayState','seenCutscene') then
        allowCountDown = false
    end
end
function onCreatePost()
    if not allowCountDown then
        setProperty('camGame.zoom',getProperty('defaultCamZoom') + 0.2)
        triggerEvent('Camera Follow Pos',getProperty('dadGroup.x') + 200,getProperty('dadGroup.y') + 390)
        addLuaScript('custom_events/HUD Fade')
        triggerEvent('HUD Fade','1','0')
        makeLuaSprite('armedDark',nil,-300,-300)
        makeGraphic('armedDark',screenWidth * 2,screenHeight * 2,'000000')
        addLuaSprite('armedDark',false)
        setObjectOrder('armedDark',getObjectOrder('dadGroup') - 1)
        characterPlayAnim('dad','intro',true)
        setProperty('dad.specialAnim',true)
        setScrollFactor('armedDark',0,0)
        setProperty('gf.alpha',0.001)
        setProperty('boyfriend.alpha',0.001)
        setProperty('player3Lua.alpha',0.001)
        makeAnimatedLuaSprite('dustArmed','henry/Dust_Cloud',120,450)
        addAnimationByPrefix('dustArmed','dust','dust clouds',24,false)
        addLuaSprite('dustArmed',true)
        runTimer('armedEnd',3)
    end
end
function onStartCountdown()
    if not allowCountDown then
        return Function_Stop;
    end
end
function onTimerCompleted(tag)
    if tag == 'armedEnd' then
        doTweenAlpha('heyBF','boyfriend',1,1.5)
        doTweenAlpha('heyGF','gf',1,1.5)
        doTweenAlpha('heyLua','player3Lua',1,1.5)
        doTweenAlpha('byeDark','armedDark',0,1.5)
        triggerEvent('HUD Fade','0','1.5')
        triggerEvent('Camera Follow Pos','','')
        allowCountDown = true
    end
end
function onTweenCompleted(tag)
    if tag == 'byeDark' then
        removeLuaSprite('armedDark',true)
        doTweenZoom('backGame','camGame',getProperty('defaultCamZoom'),1.5,'quartInOut')
        setPropertyFromClass('PlayState','seenCutscene',true)
        startCountdown()
    end
end 