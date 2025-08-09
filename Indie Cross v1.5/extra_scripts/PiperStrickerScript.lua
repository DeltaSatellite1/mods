local BFBendyAttack = false

local allowZoomingAttack = true
local alreadyZoom = false

local PiperX = false
local StrikerX = false
local PiperSpawn = 2
local StrikerSpawn = 2
local PiperAttack = 0
local StrikerAttack = 0

local PiperOffsetX = 0
local StrikerOffsetX = 0

local PiperOffsetY = 0
local StrikerOffsetY = 0

local PiperBFX = 500
local StrikerBFX = -300


local PiperAttacking = false
local piperDodge = 0

local StrikerAttacking = false
local strikerDodge = 0

local PiperHP = 3
local StrikerHP = 3

local AttackEnable = false

local piperTexture = 'bendy/third/Piper'
local strikerTexture = 'bendy/third/Striker'

function onCreate()
    addLuaScript('extra_scripts/ButtonScreen')
    if curStage == 'factory-nightmare' then
        piperTexture = 'bendy/third/PiperDespair'
        strikerTexture = 'bendy/third/StrikerDespair'
        PiperOffsetY = 70
        StrikerOffsetY = 80

        PiperBFX = 550
        StrikerBFX = -200

        PiperOffsetX = 2000
        StrikerOffsetX = -100
    else
        PiperOffsetY = 70
        StrikerOffsetY = 80

        PiperOffsetX = 1220
        StrikerOffsetX = -750

        AttackEnable = true
    end

    makeAnimatedLuaSprite('Piper',piperTexture,screenWidth + PiperOffsetX,getProperty('boyfriend.y') + PiperOffsetY)
    addAnimationByPrefix('Piper','Walking','pip walk instance 1',24,true)
    addOffset('Piper','Walking',100,50)
    addAnimationByPrefix('Piper','Idle','Piperr instance 1',24,false)
    addOffset('Piper','Idle',0,40)
    addAnimationByPrefix('Piper','Hurt','Piper gets Hit instance 1',24,false)
    addOffset('Piper','Hurt',120,200)
    addAnimationByPrefix('Piper','Dead','Piper ded instance 1',24,false)
    addOffset('Piper','Dead',120,180)
    addAnimationByPrefix('Piper','Attack','PeepAttack instance 1',24,false)
    addOffset('Piper','Attack',375,260)
    addAnimationByPrefix('Piper','Pre-Attack','PipAttack instance 1',24,false)
    addOffset('Piper','Pre-Attack',95,90)
    playAnim('Piper','Walking')
    scaleObject('Piper',1.8,1.8)


    makeAnimatedLuaSprite('Striker',strikerTexture,StrikerOffsetX,getProperty('boyfriend.y') + StrikerOffsetY)
    addAnimationByPrefix('Striker','Walking','Str walk instance 1',24,true)
    addOffset('Striker','Walking',0,40)
    addAnimationByPrefix('Striker','Hurt','Sticker  instance 1',24,false)
    addOffset('Striker','Hurt',150,120)
    addAnimationByPrefix('Striker','Dead','I ded instance 1',24,false)
    addOffset('Striker','Dead',250,120)
    addAnimationByPrefix('Striker','Pre-Attack','PunchAttack_container instance 1',24,false)
    addOffset('Striker','Pre-Attack',20,47)
    addAnimationByPrefix('Striker','Attack','regeg instance 1',24,false)
    addOffset('Striker','Attack',0,40)
    addAnimationByPrefix('Striker','Idle','strrr instance 1',24,false)
    addOffset('Striker','Idle',0,40)
    scaleObject('Striker',1.8,1.8)
    playAnim('Striker','Walking')
    
    for bendySplash = 1,4 do
        precacheImage('bendy/Damage0'..bendySplash)
    end
end

function disableNotes(mustPress,time)
    callScript('scripts/global_functions','disableNotes',{mustPress,time})
end

function dodgeInk()
    disableNotes(true,700)
    characterPlayAnim('boyfriend', 'dodge', true)
    setProperty('boyfriend.specialAnim',true)
end

function hurtInk()
    addInk()
    characterPlayAnim('boyfriend','hurt',true)
    setProperty('boyfriend.specialAnim',true)
end

function attackInk(enemy)
    local anim = 'attack'
    if enemy == 'striker' then
        if (StrikerX) then
            StrikerAttacking = false
            strikerDodge = 0
            StrikerAttack = StrikerAttack - 1.5
            playAnim('Striker','Hurt')
            StrikerHP = StrikerHP - 1
            playSound('bendy/butcherSounds/Hurt0' ..getRandomInt(1,2))
        end
    elseif enemy == 'piper' then
        anim = 'attack2'
        if (PiperX) then
            PiperAttacking = false
            piperDodge = 0
            PiperAttack = PiperAttack - 1.5
            PiperHP = PiperHP - 1
            playAnim('Piper','Hurt')
            playSound('bendy/butcherSounds/Hurt0' ..getRandomInt(1,2))
        end
    end
    disableNotes(true,700)
    if luaSpriteExists('AttackButton') then
        playAnim('AttackButton','NA')
    end
    runHaxeCode(
        [[
            if("]]..anim..[[" == 'attack2' && game.boyfriend.animOffsets.exists('attack2')){
                game.boyfriend.playAnim('attack2',true);
            }
            else{
                game.boyfriend.playAnim('attack',true);
            }
            game.boyfriend.specialAnim = true;
            return;
        ]]
    )
end

function createStriker()
    addLuaSprite('Striker', false)
    setObjectOrder('Striker',getObjectOrder('boyfriendGroup') + 1)
    setProperty('Striker.velocity.x',180)
    playAnim('Striker','Walking')
    setProperty('Striker.x',StrikerOffsetX)
    setProperty('Striker.y', getProperty('boyfriend.y') + StrikerOffsetY)
    StrikerHP = 3
    StrikerX = false
    StrikerSpawn = -1
end
function createPiper()
    setProperty('Piper.x', screenWidth + PiperOffsetX)
    setProperty('Piper.velocity.x',-125)
    setProperty('Piper.y', getProperty('boyfriend.y') + PiperOffsetY)
    addLuaSprite('Piper', false)
    playAnim('Piper','Walking')
    setObjectOrder('Piper',getObjectOrder('boyfriendGroup') + 1)
    PiperHP = 3
    PiperX = false
    PiperSpawn = -1
end

function piperAttack()
    piperDodge = 2
    playAnim('Piper','Pre-Attack')
    PiperAttacking = true
end

function strikerAttack()
    strikerDodge = 2
    playAnim('Striker','Pre-Attack')
    StrikerAttacking = true
end

function setCamTarget(target)
    callScript('scripts/global_functions','setCamTarget',{target})
end

function onUpdate(el)
    if AttackEnable and not inGameOver then
        if (PiperSpawn > 0) then
            PiperSpawn = math.max(PiperSpawn - el,0)
        elseif (PiperSpawn == 0) then
            createPiper()

        elseif PiperSpawn == -1 and PiperHP > 0 and not PiperX and getProperty('Piper.x') <= getProperty('boyfriend.x') + PiperBFX then
            PiperX = true
            setProperty('Piper.velocity.x',0)
            setProperty('Piper.x',getProperty('boyfriend.x') + PiperBFX)
            piperAttack()

        end
        if (StrikerSpawn > 0) then
            StrikerSpawn = math.max(StrikerSpawn - el,0)
        elseif (StrikerSpawn == 0) then
            createStriker()

        elseif StrikerSpawn == -1 and StrikerHP > 0 and not StrikerX and getProperty('Striker.x') >= getProperty('boyfriend.x') + StrikerBFX then
            StrikerX = true
            setProperty('Striker.velocity.x',0)
            setProperty('Striker.x',getProperty('boyfriend.x') + StrikerBFX)
            strikerAttack()

        end

        if (PiperHP > 0 and PiperX) then
            if (PiperAttack < 6) then
                PiperAttack = PiperAttack + el
                PiperAttacking = false
            else
                if not PiperAttacking then
                    piperAttack()
                end
            end
        end

        
        if (StrikerHP > 0 and StrikerX) then
            if (StrikerAttack < 6) then
                StrikerAttack = StrikerAttack + el
                StrikerAttacking = false
            else
                if (not StrikerAttacking) then
                    strikerAttack()
                end
            end
        end

        if PiperHP == 0 then
            playSound('bendy/butcherSounds/Dead')
            playAnim('Piper','Dead')
            PiperX = false
            PiperHP = -1
        end

        if StrikerHP == 0 then
            playSound('bendy/butcherSounds/Dead')
            playAnim('Striker','Dead')
            StrikerX = false
            StrikerHP = -1
        end

        if BFBendyAttack then
            if string.find(getProperty('boyfriend.animation.curAnim.name'),'attack',0,true) == nil then
                BFBendyAttack = false

            end
        else
            if (keyboardJustPressed('SHIFT') and (luaSpriteExists('AttackButton') and getProperty('AttackButton.animation.curAnim.name') == 'Static' or not luaSpriteExists('AttackButton'))) then
                if keyPressed('left') and not keyPressed('right') or not keyPressed('left') and keyPressed('right') then
                    if (keyPressed('left'))  then
                        attackInk('striker')
                    else
                        attackInk('piper')
                    end
                else
                    if getRandomBool(50) then
                        attackInk('striker')
                    else
                        attackInk('piper')
                    end
                end
            end
        end
 

        if piperDodge == 2  and (keyboardJustPressed('SPACE') and not botPlay or botPlay) then
            piperDodge = 1
        end

        if strikerDodge == 2 and (keyboardJustPressed('SPACE') and not botPlay or botPlay) then
            strikerDodge = 1
        end

        if allowZoomingAttack then
            if (getProperty('Piper.animation.curAnim.name') == 'Pre-Attack' or getProperty('Striker.animation.curAnim.name') == 'Pre-Attack') then
                setProperty('camGame.zoom',getProperty('camGame.zoom') + (0.8 - getProperty('camGame.zoom'))*math.min(1,el*4))
                setCamTarget('bf')
                if not alreadyZoom then
                    cancelTween('gameZoom')
                end
                alreadyZoom = true
            else
                if alreadyZoom then
                    alreadyZoom = false
                    doTweenZoom('gameZoom','camGame',getProperty('defaultCamZoom'),1.5,'quartOut')
                    setCamTarget()
                end
            end
        end

        if getProperty('Piper.animation.curAnim.finished') == true then
            local anim = getProperty('Piper.animation.curAnim.name')
            if anim == 'Dead' then
                removeLuaSprite('Piper', false)
                if (AttackEnable and PiperSpawn == -1) then
                    PiperSpawn = getRandomInt(6,10)
                end
            elseif anim == 'Attack' then
                PiperAttacking = false
                playAnim('Piper','Idle')
                

            elseif anim == 'Hurt' then
                playAnim('Piper','Idle')

            elseif (anim == 'Pre-Attack') then
                
                playAnim('Piper','Attack')
                PiperAttack = getRandomInt(0,3)
                if (piperDodge == 2) then
                    hurtInk()

                elseif (piperDodge == 1) then
                    dodgeInk()
                end
                piperDodge = 0
            end
        end
        if getProperty('Striker.animation.curAnim.finished') == true then
            local anim = getProperty('Striker.animation.curAnim.name')
            if anim == 'Dead' then
                removeLuaSprite('Striker', false)
                if (AttackEnable and StrikerSpawn == -1) then
                    resetStriker()
                end
            elseif anim == 'Attack' then
                StrikerAttacking = false
                playAnim('Striker','Idle')

            elseif anim == 'Hurt' then
                playAnim('Striker','Idle')

            elseif anim == 'Pre-Attack' then
                playAnim('Striker','Attack')
                StrikerAttack = getRandomInt(0,3)
                if (strikerDodge == 2) then
                    hurtInk()
                elseif (strikerDodge == 1) then
                    dodgeInk()
                end
                strikerDodge = 0
            end
        end
    end
end

function enableAttack(enable)
    if AttackEnable ~= enable then
        StrikerAttacking = false
        StrikerAttack = 0

        PiperAttack = 0
        PiperAttacking = false
        if enable then
            resetPiper()
            resetStriker()
        else
            PiperDie()
            StrikerDie()
        end
    end
    AttackEnable = enable
end

function onBeatHit()
    if (curBeat % 2 == 0) then
        if PiperHP > 0 and getProperty('Piper.animation.curAnim.name') == 'Idle' then
            playAnim('Piper','Idle')
        end
        if StrikerHP > 0 and getProperty('Striker.animation.curAnim.name') == 'Idle' then
            playAnim('Striker','Idle')
        end
    end
end

function addInk()
    callScript('extra_scripts/InkScreen','addInk')
end

function PiperDie()
    playAnim('Piper','Dead')
    PiperHP = -1
    PiperAttack = 0
    PiperAttacking = false
    PiperSpawn = 0
end

function resetPiper()
    PiperHP = 3
    PiperSpawn = getRandomInt(5,8)
    PiperAttack = 0
    PiperAttacking = false
    
end
function resetStriker()
    StrikerHP = 3
    StrikerSpawn = getRandomInt(5,8)
    StrikerAttack = 0
    StrikerAttacking = false
    
end
function StrikerDie()
    playAnim('Striker','Dead')
    StrikerHP = -1
    StrikerAttack = 0
    StrikerAttacking = false
    StrikerSpawn = 0
end