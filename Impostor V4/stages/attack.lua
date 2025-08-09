function onCreate()
    makeLuaSprite('attackBG','attack/monotoneback',0,0)
    addLuaSprite('attackBG',false)

    makeAnimatedLuaSprite('attackPeople','attack/crowd',850,850)
    addAnimationByPrefix('attackPeople','idle','tess n gus fring instance 1',24,false)
    addLuaSprite('attackPeople',false)

    makeLuaSprite('attackFG','attack/fg',0,0)
    addLuaSprite('attackFG',false)

    
    makeAnimatedLuaSprite('attackCoople','attack/cooper',1950,775)
    addAnimationByPrefix('attackCoople','idle','bg seat 1 instance 1',24,false)
    addLuaSprite('attackCoople',false)

    makeAnimatedLuaSprite('attackNick','attack/nick t',600,700)
    addAnimationByPrefix('attackNick','idle','nick t idle',24,false)
    addAnimationByPrefix('attackNick','fortnite','nick t animation',24,false)
    objectPlayAnimation('attackNick','idle')
    addLuaSprite('attackNick',false)

    makeAnimatedLuaSprite('attackOffBi','attack/offbi',1250,625)
    addAnimationByPrefix('attackOffBi','idle','offbi',24,false)
    addLuaSprite('attackOffBi',false)

    makeAnimatedLuaSprite('attackOrbyy','attack/orbyy',850,665)
    addAnimationByPrefix('attackOrbyy','idle','orbyy',24,false)
    addAnimationByPrefix('attackOrbyy','shut up','shutup',24,false)
    objectPlayAnimation('attackOrbyy','idle')
    addLuaSprite('attackOrbyy',false)

    makeAnimatedLuaSprite('attackLoggo','attack/loggoattack',950,775)
    addAnimationByPrefix('attackLoggo','idle','loggfriend',24,false)
    addLuaSprite('attackLoggo',false)
end
function onCreatePost()
    makeLuaSprite('attackBGLight','attack/backlights',0,-90)
    setBlendMode('attackBGLight','add')
    scaleObject('attackBGLight',1,1.1)
    addLuaSprite('attackBGLight',true)

    makeLuaSprite('attackLight','attack/frontlight',0,-90)
    scaleObject('attackLight',1,1.1)
    setBlendMode('attackLight','add')
    addLuaSprite('attackLight',true)

    makeLuaSprite('attackLamp','attack/lamp',0,0)
    addLuaSprite('attackLamp',true)
end
function onUpdate()
    if getProperty('attackOrbyy.animation.curAnim.finished') and getProperty('attackOrbyy.animation.curAnim.name') ~= 'idle' then
        objectPlayAnimation('attackOrbyy','idle',false)
        setProperty('attackOrbyy.offset.x',0)
    end
    if getProperty('attackNick.animation.curAnim.finished') and getProperty('attackNick.animation.curAnim.name') ~= 'idle' then
        objectPlayAnimation('attackNick','idle',false)
        setProperty('attackNick.offset.x',0)
    end
end
function peopleAlpha(alpha)
    local people = {'attackOffBi','attackLoggo','attackOrbyy','gf','dad'}
    for peopleAttack = 1,#people do
        doTweenAlpha(people[peopleAttack]..'tween',people[peopleAttack],alpha,0.4,'linear')
    end
end
function onBeatHit()
    if curBeat % 2 == 0 then
        objectPlayAnimation('attackPeople','idle',true)
        objectPlayAnimation('attackLoggo','idle',true)
        objectPlayAnimation('attackOffBi','idle',true)

        objectPlayAnimation('attackCoople','idle',true)
        if getProperty('attackOrbyy.animation.curAnim.name') == 'idle' then
            objectPlayAnimation('attackOrbyy','idle',true)
        end
        if getProperty('attackNick.animation.curAnim.name') == 'idle' then
            objectPlayAnimation('attackNick','idle',true)
        end
    end
end
local played = false
function onStepHit()
    if curStep >= 384 and curStep < 393 then
        objectPlayAnimation('attackOrbyy','shut up',false)
        setProperty('attackOrbyy.offset.x',132)
    elseif curStep >= 1428 and curStep < 1435 and not played then
        played = true
        doTweenAlpha('byeHUD','camHUD',0,0.4,'linear')
        objectPlayAnimation('attackNick','fortnite',false)
        peopleAlpha(0.25)
    elseif curStep > 1441 and played then
        doTweenAlpha('byeHUD','camHUD',1,0.4,'linear')
        peopleAlpha(1)
    end
end