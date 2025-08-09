local InstaKillDevil = false
local DodgeDevil = false
local devilDir = 1
local devilCreated = false
local enableHit = false
function onCreate()
    makeAnimatedLuaSprite('SmallDevil','cup/BonusSongs/That Annoying Bitch',0,getProperty('boyfriend.y') - 50)
    addAnimationByPrefix('SmallDevil','Running','BoiRun instance 1',24,true)
end

function onEvent(name,value1,value2)
    if name == 'Devil Dodge' then
        local x = screenWidth + getProperty('SmallDevil.width') * 2.5
        addLuaSprite('SmallDevil',true)
        setObjectOrder('SmallDevil',getObjectOrder('boyfriendGroup') + 1)
        devilCreated = true
        if mustHitSection then
            devilDir = -1
        else
            x = 0 - getProperty('SmallDevil.width') * 2
            devilDir = 1
        end
        if value2 ~= '' then
            InstaKillDevil = true
        else
            InstaKillDevil = false
        end
        enableHit = true
        setProperty('SmallDevil.x',x)
        setProperty('SmallDevil.flipX',devilDir == -1)
    end
end

function onUpdate(el)
    local devilX = getProperty('SmallDevil.x')
    if devilCreated then
        setProperty('SmallDevil.x',devilX + (1700 * el) * devilDir)
        if devilX > getProperty('boyfriend.x') - getProperty('boyfriend.width')/4 and devilX < getProperty('boyfriend.x') + getProperty('boyfriend.width') /5 and enableHit then
            if botPlay then
                dodgeDevil()
            end
            if not DodgeDevil then
                if InstaKillDevil then
                    setProperty('health',0)
                else
                    setProperty('health',getProperty('health') - 1)
                end
                cameraShake('game',0.035,0.15)
                playSound('cup/CupHurt')
                DodgeDevil = 0
                characterPlayAnim('boyfriend','hurt',true)
                setProperty('boyfriend.specialAnim',true)
            end
            enableHit = false
        else
            if devilDir == 1 and devilX > screenWidth + getProperty('SmallDevil.width') * 2 or devilDir == -1 and devilX < -getProperty('SmallDevil.width') * 2 then
                removeLuaSprite('SmallDevil',false)
                devilCreated = false
            end
        end
    end
    

    if (keyboardJustPressed('SPACE') or botPlay) then
        dodgeDevil()
    end
    if DodgeDevil then
        local bfAnim = getProperty('boyfriend.animation.curAnim.name')
        for i = 0,getProperty('notes.length')-1 do
            if getPropertyFromGroup('notes', i, 'mustPress') == true then
                setPropertyFromGroup('notes', i, 'noAnimation', true)
            end
        end
        if getProperty('boyfriend.animation.curAnim.finished') and bfAnim == 'dodge' or bfAnim ~= 'dodge' then
            for i = 0,getProperty('notes.length')-1 do
                if getPropertyFromGroup('notes', i, 'mustPress') == true then
                    setPropertyFromGroup('notes', i, 'noAnimation', false)
                end
            end
            DodgeDevilCreated = 0
        end
    end
end
function dodgeDevil()
    DodgeDevil = true
    characterPlayAnim('boyfriend','dodge',false)
    setProperty('boyfriend.specialAnim',true)
end



