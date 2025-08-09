local InstaKillSammy = false
local DodgeSammy = 0
function onCreate()
    makeAnimatedLuaSprite('Axe', 'characters/SammyRemastered',800,900);
	addAnimationByPrefix('Axe','Attack','Axe attack instance 1',24,false);
    objectPlayAnimation('Axe','Attack',true)
    scaleObject('Axe',1.5,1.5)

    if difficulty == 2 then
        InstaKillSammy = true
    end
end
function onEvent(name,value1,value2)
    if name == "SammyAttack" then
        disableNotes(false,1.2)
        characterPlayAnim('dad','End1', true)
        setProperty('dad.specialAnim', true);
        runTimer('AxeAttackTime',0.6)
        playSound('bendy/Sammy/sammyAxeThrow')
        DodgeSammy = 2
    end
end

function disableNotes(mustPress,time)
    callScript('scripts/global_functions','disableNotes',{mustPress,time})
end
function onUpdate()
    if DodgeSammy == 2 and (not botplay and keyboardJustPressed('SPACE') or botplay) then
        DodgeSammy = 1
    end
end
function onTimerCompleted(tag)
    if tag == 'AxeAttackTime' then
        addLuaSprite('Axe',true)
        runTimer('AxeGroundSound',0.3)
        if DodgeSammy == 1 then
            disableNotes(true,500)
            characterPlayAnim('boyfriend','dodge',true)
            setProperty('boyfriend.specialAnim',true)
            DodgeSammy = 0
        elseif DodgeSammy == 2 then
            disableNotes(true,300)
            characterPlayAnim('boyfriend','hurt',false)
            setProperty('boyfriend.specialAnim',true);
            if (getHealth() - 1) > -0.01 and not InstaKillSammy then
                setHealth(getHealth() - 1)
        
            elseif (getHealth() - 1) <= -0.01 or InstaKillSammy then
                runTimer('GameOverSammy',0.35)
            end
        end
    elseif tag == 'GameOverSammy' then
        setHealth('health', -1)
    elseif tag == 'AxeGroundSound' then
        playSound('bendy/Sammy/sammyAxeGround')
    end
end
