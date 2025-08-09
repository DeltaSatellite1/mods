local dodge = 0
local cupAlerts = {}
local instaKill = false

local currentDouble = 0
local doubleOffsetY = 0
local doubleTexture = 'cup/bull/NMcupheadAttacks'
local doubleScaleX = 1.3
local doubleScaleY = 1.3


local attackAnim = 'attack'
function onCreate()
    addLuaScript('extra_scripts/cupAlert')
end
function onCreatePost()
    for events = 0,getProperty('eventNotes.length')-1 do
        if getPropertyFromGroup('eventNotes',events,'event') == 'CupheadDoubleAttack' then
            table.insert(cupAlerts,getPropertyFromGroup('eventNotes',events,'strumTime'))
        end
    end
    if difficulty == 2 then
        instaKill = true
    end
    detectRoundAttack(true)
end

function onEvent(name,value1,value2)
    if name == "CupheadDoubleAttack" then
        makeAnimatedLuaSprite('Roundabout'..currentDouble, doubleTexture,getProperty('dad.x') + 370,getProperty('boyfriend.y'));
        addAnimationByPrefix('Roundabout'..currentDouble,'idle','Roundabout instance 1',24,true);
        scaleObject('Roundabout'..currentDouble,doubleScaleX,doubleScaleY)
        setProperty('Roundabout'..currentDouble..'.offset.y', doubleOffsetY)
        addLuaSprite('Roundabout'..currentDouble,true)
        setObjectOrder('Roundabout'..currentDouble,getObjectOrder('boyfriendGroup') - 1)
        doTweenX('RoundaboutX'..currentDouble,'Roundabout'..currentDouble,getProperty('boyfriend.x') + 500, 0.9, 'QuadOut');
        setBlendMode('Roundabout'..currentDouble,'add')
        runTimer('dodgeDoubleAttack'..currentDouble,math.abs((getProperty('boyfriendGroup.x') - getProperty('dadGroup.x')) / 30000))
        playSound('cup/CupShoot')
        currentDouble = currentDouble + 1

    elseif name == 'Change Character' then
        if string.lower(value1) == 'dad' or value1 == '1' then
            detectRoundAttack(false)
        end
    end
end

function disableNotes(mustPress,time)
    for notes = 0,getProperty('notes.length')-1 do
        if getPropertyFromGroup('notes', notes,'strumTime') - getSongPosition() < time and getPropertyFromGroup('notes', notes, 'mustPress') == mustPress then
            setPropertyFromGroup('notes', notes, 'noAnimation', true)
        end
    end
end

function onTweenCompleted(tag)
    if string.find(tag, 'Roundabout',0,true) then
        local round = ''
        if string.find(tag,'RoundaboutXBye',0,true) then
            removeLuaSprite(string.gsub(tag,'RoundaboutXBye',''))
        elseif string.find(tag,'RoundaboutX',0,true) then
            round = string.gsub(tag,'X','')
            doTweenX('RoundaboutXBye'..round,round,getProperty('boyfriend.x') - (1280 * (2 + math.abs(1 - getProperty('defaultCamZoom')))), 1.5, 'quadIn');
            setObjectOrder(round,getObjectOrder('boyfriendGroup') + 1)
            doTweenX('RoundaboutScaleX'..round,round..'.scale',getProperty(round..'.scale.x') + 0.15,1,'QuadIn')
            doTweenY('RoundaboutScaleY'..round,round..'.scale',getProperty(round..'.scale.y') + 0.15,1,'QuadIn')
            dodge = 2
            runTimer('dodgeDoubleAttack'..round,0.4)
            setObjectOrder(round,getObjectOrder('boyfriendGroup') + 1)
        end
    end
end

function detectRoundAttack(precache)
    if getProperty('dad.curCharacter') ~= 'cuphead-pissed' and getProperty('dad.curCharacter') ~= 'Nightmare-Cuphead' then
        attackAnim = 'attack'
    else
        attackAnim = 'big shot'
        if getProperty('dad.curCharacter') ~= 'Nightmare-Cuphead' then
            doubleTexture = 'cup/bull/Roundabout'
            doubleScaleX = 1.3
            doubleScaleY = 1.3
            doubleOffsetY = 0
        else
            doubleTexture = 'cup/bull/NMcupheadAttacks'
            doubleScaleX = 0.8
            doubleScaleY = 0.7
            doubleOffsetY = 100
        end
        if precache then
            precacheImage(doubleTexture)
        end
    end
end

function onUpdate()
    for i, time in pairs(cupAlerts) do
        if time <= getSongPosition() + 600 then
            playSound('Cup/CupPre_shoot')
            callScript('extra_scripts/cupAlert','createAlert')
            dodge = 2
            runTimer('CupheadPreAttack',0.25)
            table.remove(cupAlerts,i)
        end
    end

    if dodge == 2 and (keyboardJustPressed('SPACE') and not botPlay or botPlay) then
        dodge = 1
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
    if tag == 'CupheadPreAttack' then
        disableNotes(false,1000)
        playAnim('dad', attackAnim, false);
        setProperty('dad.specialAnim', true);
    elseif string.find(tag,'dodgeDoubleAttack',0,true)  then
        if dodge == 1 then
            bfDodge()
        elseif dodge == 2 then
            bfHurt()
            playAnim('BigShotCuphead','Burst',false)
        end
    elseif tag == 'dodgeRound' then
        if dodge == 1 then
            bfDodge()
		elseif dodge == 2 then
            bfHurt()
        end
    elseif tag == 'GameOverCuphead' then
        setHealth(-1)
    end
end
