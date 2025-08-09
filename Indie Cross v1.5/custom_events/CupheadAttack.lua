local dodge = 0
local BigShotCurrent = 0
local BigShotDestroyed = 0
local BigShotTexture = 'cup/bull/Cuphead Hadoken'
local instaKill = false
local doAlert = true

local cupAttacks = {}
local dadAttackAnim = 'attack'

function onCreate()
    addLuaScript('extra_scripts/cupAlert')
end
function onCreatePost()
    detectAttack(true)
    for events = 0,getProperty('eventNotes.length')-1 do
        if getPropertyFromGroup('eventNotes',events,'event') == 'CupheadAttack' then
            table.insert(cupAttacks,getPropertyFromGroup('eventNotes',events,'strumTime'))
        end
    end
    if difficulty == 2 then
        instaKill = true
    end
    if curStage == 'devilHall-nightmare' then
        doAlert = false
    end
end

function detectAttack(precache)
    local dad = getProperty('dad.curCharacter')
    if dad ~= 'cuphead-pissed' and dad ~= 'Nightmare-Cuphead' then
        dadAttackAnim = 'attack'
    else
        dadAttackAnim = 'big shot'
        if dad ~= 'Nightmare-Cuphead' then
            BigShotTexture = 'cup/bull/Cuphead Hadoken'
        else
            BigShotTexture = 'cup/bull/NMcupheadAttacks'
        end
        if precache then
            precacheImage(BigShotTexture)
        end
    end
end

function onEvent(name,v1,v2)
    if name == "CupheadAttack" then
        BigShotCurrent = BigShotCurrent + 1
        local big = 'BigShotCuphead'..BigShotCurrent
        makeAnimatedLuaSprite(big, BigShotTexture,getProperty('dad.x') - 200,getProperty('boyfriend.y') - 100);
        addAnimationByPrefix(big,'Burst','BurstFX instance 1',24,true);
        if BigShotTexture ~= 'cup/bull/NMcupheadAttacks' then
            addAnimationByPrefix(big,'Hadolen','Hadolen instance 1',24,false);
            addOffset(big,'Hadolen',450,850)
        end
        addOffset(big,'Burst',0,0)
        setProperty(big..'.velocity.x',2500)
        setBlendMode(big,'add')
        addLuaSprite(big,true)
        playAnim(big,'Burst')
        playSound('cup/CupShoot')
        runTimer('dodgeCupAttack'..BigShotCurrent,math.abs((getProperty('boyfriend.x') - getProperty('dad.x')) / 10000))

    elseif name == 'Change Character' then
        if string.lower(v1) == 'dad' or v1 == '1' then
            detectAttack(false)
        end
    end
end

function disableNotes(mustPress,time)
    callScript('scripts/global_functions','disableNotes',{mustPress,time})
end

function onUpdate(el)
    if BigShotDestroyed < BigShotCurrent then
        for big = BigShotDestroyed + 1,BigShotCurrent do
            local name = 'BigShotCuphead'..big
            if luaSpriteExists(name) then
                if getProperty(name..'.animation.curAnim.name') == 'Hadolen' and getProperty(name..'.animation.curAnim.finished') == true then
                    removeLuaSprite(name,true)
                    BigShotDestroyed = BigShotDestroyed + 1
                else
                    local bigShotX = getProperty(name..'.x')
                    local bfX = getProperty('boyfriend.x') - getProperty('boyfriend.positionArray[0]')
                    if bigShotX > (bfX + (screenWidth * (1 + (1 - getProperty('defaultCamZoom')))) + 200) then
                        removeLuaSprite(name,true)
                        BigShotDestroyed = BigShotDestroyed + 1
                    end
                end

            end
        end
    end
    for i, time in pairs(cupAttacks)  do
        if time - getSongPosition() < (doAlert and 600 or 700) then
            if doAlert then
                callScript('extra_scripts/cupAlert','createAlert')
                runTimer('CupheadPreAttack'..i,0.25)
            else
                runTimer('CupheadPreAttack'..i,0.4)
            end
            dodge = 2
            table.remove(cupAttacks,i)
        end
    end
    if dodge == 2 and (keyboardJustPressed('SPACE') and not botPlay or botPlay) then
        dodge = 1
    end
end

function shotHit(target)
    if target == nil then
        target = 'boyfriend'
    end
    local name = 'BigShotCuphead'..BigShotCurrent
    playAnim(name,'Hadolen',true)
    setProperty(name..'.velocity.x',0)
    if target == 'boyfriend' then
        setProperty(name..'.x',getProperty('boyfriend.x') - getProperty('boyfriend.positionArray[0]'))
        setProperty(name..'.y',getProperty('boyfriend.y') + getProperty('boyfriend.positionArray[1]'))
    else
        setProperty(name..'.x',getProperty(target..'.x'))
        setProperty(name..'.y',getProperty(target..'.y'))
    end
end
function bfDodge()
    disableNotes(true,500)
    playAnim('boyfriend','dodge',true)
    setProperty('boyfriend.specialAnim',true)
    playSound('cup/CupDodge',1)
end

function bfHurt()
    playAnim('boyfriend','hurt',false)
    setProperty('boyfriend.specialAnim',true)
    local force = 1.2
    if instaKill then
        force = 2
    end
    if getHealth() - force > 0 then
        setHealth(getHealth() - 1.2)
    else
        runTimer('GameOverCuphead',0.3)
    end
end

function onTimerCompleted(tag)
    if stringStartsWith(tag,'CupheadPreAttack') then
        playSound('Cup/CupPre_shoot')
        disableNotes(false,1000)
        playAnim('dad', dadAttackAnim, false);
        setProperty('dad.specialAnim', true);
    elseif stringStartsWith(tag,'dodgeCupAttack') then
        if dodge == 1 then
            bfDodge()
        elseif dodge == 2 then
            bfHurt()
            shotHit()
        end
    elseif tag == 'GameOverCuphead' then
        setHealth(-0.1);
    end
end
