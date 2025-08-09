local middle = false
function onCreate()
    setProperty('introSoundsSuffix','-silence')
    middle = middlescroll
    if version >= '0.7' then
        setPropertyFromClass('backend.ClientPrefs','data.middleScroll',true)
    else
        setPropertyFromClass('ClientPrefs','middleScroll',true)
    end

    for notesLength = 0,getProperty('unspawnNotes.length')-1 do
        if not getPropertyFromGroup('unspawnNotes',notesLength,'mustPress') then
            setPropertyFromGroup('unspawnNotes',notesLength,'visible',false)
        end
    end
end
function onCreatePost()
    triggerEvent('HUD Fade','1','0')

    makeAnimatedLuaSprite('ziffy','torture/torture_startZiffy',580,150)
    addAnimationByPrefix('ziffy','anim','Opening',24,false)
    setScrollFactor('ziffy',0,0)
    setProperty('ziffy.alpha',0.001)
    addLuaSprite('ziffy',true)

    makeAnimatedLuaSprite('roze','torture/torture_roze',-390,-190)
    addAnimationByPrefix('roze','anim','RozeCamio',24,false)
    setProperty('roze.alpha',0.001)
    addLuaSprite('roze',false)

    makeLuaSprite('healthTween',nil,1,0)

    for strumLine = 0,3 do
        setPropertyFromGroup('strumLineNotes',strumLine,'visible',false)
    end
end
local doneAnim = false
local tween = false
function onBeatHit()
    if curBeat == 2 then
        setProperty('ziffy.alpha',1)
        objectPlayAnimation('ziffy','anim',true)
    elseif curBeat >= 25 and not doneAnim then
        removeLuaSprite('ziffy',true)
        doneAnim = true
    elseif curBeat == 256 then
        objectPlayAnimation('roze','anim',true)
        setProperty('roze.alpha',1)
    elseif  curBeat == 272 then
        runHaxeCode(
            [[
                FlxTween.tween(game,{health: 0.1},1,{ease: FlxEase.quartOut});
                return;
            ]]
        )
    end
end
function onUpdate()
    if getProperty('roze.animation.curAnim.finished') and getProperty('roze.alpha') == 1 then
        removeLuaSprite('roze',true)
    end
end
function onDestroy()
    if version >= '0.7' then
        setPropertyFromClass('backend.ClientPrefs','data.middleScroll',middle)
    else
        setPropertyFromClass('ClientPrefs','middleScroll',middle)
    end
end