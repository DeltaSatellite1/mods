local dodge = 0
local Color = nil
local characterSansDodgeFound = true
local BfDodge = false
local InstaKillSans = false
function onCreate()
    makeAnimatedLuaSprite('DodgeAlert2','sans/Sans_Shit_NM',getProperty('boyfriend.x') - 100,getProperty('boyfriend.y') - 50)

    addAnimationByPrefix('DodgeAlert2','alertBlue','AlarmBlue instance 1',24,false)
    addAnimationByPrefix('DodgeAlert2','alertOrange','AlarmOrange instance 1',24,false)

    addAnimationByPrefix('DodgeAlert2','attackBlue','Bones boi instance 1',24,false)
    addAnimationByPrefix('DodgeAlert2','attackOrange','Bones Orange instance 1',24,false)
    setBlendMode('DodgeAlert2','add')
    
    scaleObject('DodgeAlert2',0.8,0.8)

    local alertImage = 'sans/Bone'
    if curStage == 'hall' and songName ~= 'Burning-In-Hell' then
        alertImage = 'sans/DodgeMechs'
    elseif songName == 'Burning-In-Hell' then
        alertImage = 'sans/Cardodge'
    end
    makeAnimatedLuaSprite('DodgeAlert',alertImage,getProperty('boyfriend.x') - 100,getProperty('boyfriend.y') + 50)
    addAnimationByPrefix('DodgeAlert','alert','Alarm instance 1',24,false)
    addAnimationByPrefix('DodgeAlert','attack','Bones boi instance 1',24,false)
    scaleObject('DodgeAlert',0.8,0.8)
    precacheImage(alertImage)

    if difficulty == 2 then
        InstaKillSans = true
    end
end

function onCreatePost()
    detectCharacter()
end

function detectCharacter(precache)
    characterSansDodgeFound = true
    local file = ''
    local offsetX = 0
    local offsetY = 0
    if getProperty('boyfriend.curCharacter') == 'bf-chara' then
        file = 'sans/Cardodge'
        offsetX = -5
        offsetY = -50

    elseif getProperty('boyfriend.curCharacter') == 'bf-sans' then
        file = 'sans/DodgeMechs'
        offsetX = 10
        offsetY = 28
    else
        characterSansDodgeFound = false
        removeLuaSprite('BFSansDodge',true)
        return
    end
    if precache then
        precache(file)
    end
    makeAnimatedLuaSprite('BFSansDodge',file,0,0)
    setProperty('BFSansDodge.offset.x',offsetX)
    setProperty('BFSansDodge.offset.y',offsetY)
    setProperty('BFSansDodge.alpha',0.001)
    addAnimationByPrefix('BFSansDodge','dodge','Dodge instance 1',24,false)
    addLuaSprite('BFSansDodge',false)
    setObjectOrder('BFSansDodge',getObjectOrder('boyfriendGroup')+1)
end

function setCamTarget(target)
    callScript('scripts/global_functions','setCamTarget',{target})
end

function onUpdate()
    if dodge == 2 then
        setCamTarget('boyfriend')
        if keyboardJustPressed('SPACE') and not botPlay or botPlay and (Color == 'Orange' or Color == nil) then
            playSound('sans/dodge')
            dodge = 1;
        end
    end
    if dodge ~= 0 then
        setCamTarget('boyfriend')
    end
    if getProperty('DodgeAlert.animation.curAnim.finished') and getProperty('DodgeAlert.animation.curAnim.name') == 'attack' then
        removeLuaSprite('DodgeAlert',false)
        playAnim('DodgeAlert','alert',false)
    end

    if getProperty('DodgeAlert2.animation.curAnim.finished') and getProperty('DodgeAlert2.animation.curAnim.name') == 'attackOrange' or getProperty('DodgeAlert2.animation.curAnim.finished') and getProperty('DodgeAlert2.animation.curAnim.name') == 'attackBlue' then
        triggerEvent('Camera Follow Pos','','')
        removeLuaSprite('DodgeAlert2',false)
        playAnim('DodgeAlert2','alert2',false)
        Color = 0
    end

    if characterSansDodgeFound then
        setProperty('BFSansDodge.x',getProperty('boyfriend.x'))
        setProperty('BFSansDodge.y',getProperty('boyfriend.y'))
        if getProperty('BFSansDodge.animation.curAnim.finished') and BfDodge then
            setProperty('BFSansDodge.alpha',0)
            setProperty('boyfriend.visible',true)
            BfDodge = false
        end
    end
end

function onEvent(name,value1,value2)
    if name == "SansDodge" then
        runTimer('SansAttack',0.8)
        playSound('sans/notice')
        setProperty('DodgeAlert.y',getProperty('boyfriend.y') - 50)
        setProperty('DodgeAlert2.y',getProperty('boyfriend.y') - 50)
        dodge = 2
        if value1 == '1' then
            addLuaSprite('DodgeAlert2',true)
            Color = 1
        elseif value1 == '2' then
            addLuaSprite('DodgeAlert2',true)
            Color = 'Blue'
            playAnim('DodgeAlert2','alertBlue')
        elseif value1 == '3' then
            Color = 'Orange'
            playAnim('DodgeAlert2','alertOrange')
        else
            addLuaSprite('DodgeAlert',true)
            playAnim('DodgeAlert','alert')
            Color = nil
        end
        
        if Color == 1 then
            local RandomColor = math.random(3,4)
            if RandomColor == 3 then
                Color = 'Blue'
            elseif RandomColor == 4 then
                Color = 'Orange'
            end
            playAnim('DodgeAlert2','alert'..Color)
        end
    elseif name == 'Change Character' then
        detectCharacter()
    end
end
function sansDodge(dodged)
    if dodged then
        if characterSansDodgeFound == true then
            setProperty('BF_Attack.visible',false)
            setProperty('BFSansDodge.visible',true)
            BfDodge = true
            setProperty('boyfriend.visible',false)
            setProperty('BFSansDodge.alpha',1)
            playAnim('BFSansDodge','dodge',true)
        else
           characterPlayAnim('boyfriend','dodge',true)
           setProperty('boyfriend.specialAnim',true)
           disableNotes(true)
        end
    else
        characterPlayAnim('boyfriend','hurt',true)
        setProperty('boyfriend.specialAnim',true);

        if characterSansDodgeFound then
            characterPlayAnim('boyfriend','singUPmiss',true)
            setProperty('boyfriend.specialAnim',true)
        end


        local force = 1
        if InstaKillSans then
            force = 2.1
        end

        if (getHealth() - force) > 0 then
            setHealth(getHealth() - force)
        else
            runTimer('GameOverSans',0.35)
        end
    end
end
function onTimerCompleted(tag)
    if tag == 'SansAttack' then
        playSound('sans/sansattack')
        setProperty('DodgeAlert.y',getProperty('DodgeAlert.y') + 50)
        setProperty('DodgeAlert2.y',getProperty('DodgeAlert2.y') + 50)
        cameraShake('game',0.01,0.2)
        if Color ~= nil then
            playAnim('DodgeAlert2','attack'..Color,false)
            if dodge == 1 and Color == 'Orange' then
                sansDodge(true)
                Color = 0
            end
            if dodge == 2 and Color == 'Orange' or dodge == 1 and Color == 'Blue' then
                sansDodge(false)
            end
        end
        if Color == nil then
            playAnim('DodgeAlert','attack')
            if dodge == 1 then
                sansDodge(true)
            elseif dodge == 2 then
                sansDodge(false)
            end
        end
        setCamTarget(nil)
        dodge = 0
    end
    if tag == 'GameOverSans' then
        setProperty('health',0)
    end
end


