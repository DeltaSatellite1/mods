local isShotting = false
local BfAttacking = false

local enableAttack = false

local ShottingStyle = 0

local PeaShootCounter = 1
local PeaShotHurt = 0
local PeaOffsetX = 400
local PeaOffsetY = 210
local ChaserOffsetX = 390
local ChaserOffsetY = 350

local ChaserShotNumber = 0
local ChaserShotHurt = 0
local ChaserShotSound = 0

local BulletTimer = 0

local changeHealthNotes = 0

local bulletsLength = 3
local bulletsTexture = 'cup/bull/Cupheadshoot'

local CupheadShotAnimations = {"pewLEFT","pewDOWN","pewUP","pewRIGHT"}
function onCreate()
    addLuaScript('extra_scripts/CardCup')

    if getProperty('dad.curCharacter') ~= 'Nightmare-Cuphead' then
        --Load Green Shot
        makeAnimatedLuaSprite('FlashShot','cup/bull/Cupheadshoot',getProperty('dad.x') + PeaOffsetX - 80,getProperty('dad.y') + PeaOffsetY + 180)
        addAnimationByPrefix('FlashShot','Flash','BulletFlashFX instance 1',24,false);

    else
        bulletsTexture = 'cup/bull/NMcupheadBull'
        bulletsLength = 5
    end
    -- cuphead blue shot
    for BulletsLength = 1, bulletsLength do
        makeAnimatedLuaSprite('Peashoot' ..BulletsLength, bulletsTexture, getProperty('dad.x') + PeaOffsetX, getProperty('boyfriend.y') - PeaOffsetY - (25 * (BulletsLength - 1)));
    
        for bulletsAnimations = 1,bulletsLength do
            addAnimationByPrefix('Peashoot' ..BulletsLength, 'H-Tween'..bulletsAnimations, 'Shot0'..bulletsAnimations..' instance 1', 25, false);
        end
    end

    for greenBullets = 0, 7 do
        makeAnimatedLuaSprite('GreenShit' ..greenBullets, 'cup/bull/GreenShit', getProperty('dad.x') + 360, getProperty('dad.y') + 60);
        for greenAnimations = 1,3 do
            addAnimationByPrefix('GreenShit'..greenBullets,'ChaserShot'..greenAnimations, 'GreenShit0'..greenAnimations, 24,false);
        end
        setBlendMode('GreenShit' ..greenBullets,'add')
    end

    precacheImage('cup/bull/Cupheadshoot')
    precacheImage('cup/bull/GreenShit')
    precacheImage('cup/bull/NMcupheadBull')
end

function onEvent(name,value1,value2)
    if (name == 'CupheadShooting') then
        if (string.lower(value2) ~= 'false') then
            isShotting = true
            changeHealthNotes = 2
            if value1 ~= '1' then
                BulletTimer = 0.1
                ShottingStyle = 0
            else
                ShottingStyle = 1
            end
        else
            isShotting = false
            ShottingStyle = 0
        end
        if botplay and ShottingStyle ~= 1 then
            attackCup()
        end
    end
end

function onUpdate(el)
    if (isShotting and ShottingStyle == 0) then
        if (BulletTimer > 0) then
            BulletTimer = BulletTimer - el

        elseif (BulletTimer <= 0) then
            BulletTimer = 0.1
            PeaShootCounter = PeaShootCounter + 1
            playAnim('dad','shotting', true)
            setProperty('dad.specialAnim', true);
            addLuaSprite('Peashoot' ..PeaShootCounter-1, true)
            setProperty('Peashoot'..(PeaShootCounter-1)..'.x',getProperty('dad.x') + PeaOffsetX)
            setProperty('Peashoot'..(PeaShootCounter-1)..'.y',getProperty('dad.y') - getProperty('dad.positionArray[1]') + PeaOffsetY - (25 * (PeaShootCounter - 1)))
            playAnim('Peashoot' ..PeaShootCounter-1, 'H-Tween' ..(getRandomInt(1,bulletsLength)), true)
            playSound('Cup/pea'..(math.random(0, 5)))
            if (getProperty('dad.curCharacter') ~= 'Nightmare-Cuphead') then
                addLuaSprite('FlashShot', true)
                setProperty('FlashShot.x',getProperty('dad.x') + PeaOffsetX - 80)
                setProperty('FlashShot.y',getProperty('dad.y') + PeaOffsetY + 180)
                playAnim('FlashShot', 'Flash', true)
            end
        end
    end

    if ChaserShotNumber > 7 then
        ChaserShotNumber = 0
    end

    if ChaserShotSound > 3 then
        ChaserShotSound = 0
    end

    if (PeaShootCounter > bulletsLength) then
        PeaShootCounter = 1
    end

    for ChaserShotCount = 1,7 do
        if getProperty('GreenShit'..ChaserShotCount..'.animation.curAnim.finished') == true then
            removeLuaSprite('GreenShit'..ChaserShotCount,false)
        end
         if(getProperty('GreenShit'..ChaserShotCount..'.animation.curAnim.curFrame') == 10 and ChaserShotHurt ~= ChaserShotCount and getHealth() > 0.05) then
            setHealth(getHealth() - 0.023)
            ChaserShotHurt = ChaserShotCount
        end
    end

    if getProperty('dad.curCharacter') ~= 'Nightmare-Cuphead' then
        if getProperty('FlashShot.animation.curAnim.finished') == true then
            removeLuaSprite('FlashShot',false)
        end
    end

    for PeaShotC = 1, bulletsLength do
        if (getProperty('Peashoot'..PeaShotC..'.animation.curAnim.finished')) then
            removeLuaSprite('Peashoot'..PeaShotC, false)
        end
        if(getProperty('Peashoot'..PeaShotC..'.animation.curAnim.curFrame') == 6 and PeaShotHurt ~= PeaShotC)then
            setProperty('health', getProperty('health') - 0.06)
            PeaShotHurt = PeaShotC
        end
    end

    if getProperty('Cardcrap.animation.curAnim.name') ~= 'Used' then
        
        if not BfAttacking and (keyboardJustPressed('SHIFT') and not botplay or isShotting and ShottingStyle == 0 and botPlay) then
            attackCup()
        end
    end
end

function attackCup()
    disableNotes(true,1000)
    playAnim('boyfriend','attack',true)
    setProperty('boyfriend.specialAnim',true)
    runTimer('CupheadHurt',0.3)
    playSound('IC/Throw'..(math.random(1,3)))
    BfAttacking = true
    runTimer('enableCupAttack',1)
    callScript('extra_scripts/CardCup','unfillCard')
end


function disableNotes(mustPress,time)
    callScript('scripts/global_functions','disableNotes',{mustPress,time})
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
    if isShotting and getPropertyFromGroup('notes',id,'hitHealth') > 0 then
        setHealth(getHealth() - getPropertyFromGroup('notes',id,'hitHealth'))
    end
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
    if not isSustainNote and isShotting == true then
        if ShottingStyle == 1 then
            playAnim('dad',CupheadShotAnimations[noteData + 1],true)
            setProperty('dad.specialAnim',true)
            addLuaSprite('GreenShit'..ChaserShotNumber,true)
            setProperty('GreenShit'..ChaserShotNumber..'.x',getProperty('dad.x') + ChaserOffsetX)
            setProperty('GreenShit'..ChaserShotNumber..'.y',getProperty('dad.y') + ChaserOffsetY)
            playAnim('GreenShit'..ChaserShotNumber,'ChaserShot'..(math.random(1,3)), false)
            playSound('cup/chaser'..ChaserShotSound)
            ChaserShotNumber  = ChaserShotNumber + 1
            ChaserShotSound  = ChaserShotSound + 1
        else
            isShotting = false
            changeHealthNotes = 1
        end
    end
end

function onTimerCompleted(tag)
    if tag == 'CupheadHurt' then
        setHealth(getHealth() + 1)
        if isShotting == true or getProperty('dad.curCharacter') == 'cuphead-pissed' then
            if changeHealthNotes == 2 then
                changeHealthNotes = 1
            end

            if getProperty('dad.curCharacter') ~= 'Nightmare-Cuphead' then
                playAnim('dad','hurt',true)
                setProperty('dad.specialAnim',true);
                playSound('cup/CupHurt')

            else
                playAnim('dad','dodge',true)
                setProperty('dad.specialAnim',true);
                playSound('cup/CupDodge')
            end
            isShotting = false
        elseif isShotting == false or getProperty('dad.curCharacter') == 'Nightmare-Cuphead' then
            disableNotes(false,500)
            playAnim('dad','dodge',true)
            setProperty('dad.specialAnim',true);
            playSound('cup/CupDodge')
        end
    elseif tag == 'enableCupAttack' then
        BfAttacking = false
    end
end
