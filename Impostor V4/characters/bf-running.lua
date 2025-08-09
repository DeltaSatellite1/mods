local created = false

function onCreatePost()
    precacheImage('characters/bf_legs')
    if getProperty('boyfriend.curCharacter') == 'bf-running' then
        createBFLegs()
    end
end
function onUpdate()
    if created then
        local curFrame = 0
        local curSpeed = 24
        local curBFAnim = getProperty('boyfriend.animation.curAnim.name')
        if curBFAnim == 'danceLeft' then
            curFrame = getProperty('boyfriend.animation.curAnim.curFrame')
            curSpeed = 0
        elseif curBFAnim == 'danceRight' then
            curFrame = getProperty('boyfriend.animation.curAnim.curFrame') + 10
            curSpeed = 0
        else
            curFrame = nil
            curSpeed = 26
        end 
        if (curBFAnim == 'singLEFT' or curBFAnim == 'singDOWN' or curBFAnim == 'singUP' or curBFAnim == 'singRIGHT') then
            if getProperty('boyfriend.animation.curAnim.curFrame') >= 2 then
                characterPlayAnim('boyfriend',getProperty('boyfriend.animation.curAnim.name')..'-loop')
            elseif getProperty('boyfriend.animation.curAnim.curFrame') < 1 then
                setProperty('boyfriend.animation.curAnim.frameRate',26)
            end
        else
            if (curBFAnim ~= 'singLEFT-loop' and curBFAnim ~= 'singDOWN-loop' and curBFAnim ~= 'singUP-loop' and curBFAnim ~= 'singRIGHT-loop') then
                if curBFAnim == 'danceLeft' or curBFAnim == 'danceRight' then
                    setProperty('boyfriend.animation.curAnim.frameRate',26)
                else
                    setProperty('boyfriend.animation.curAnim.frameRate',24)
                end
            else
                setProperty('boyfriend.animation.curAnim.curFrame',getProperty('bfLegsRunning.animation.curAnim.curFrame'))
                setProperty('boyfriend.animation.curAnim.frameRate',0)
            end
        end
        if curFrame ~= nil then
            setProperty('bfLegsRunning.animation.curAnim.curFrame',curFrame)
        end
        setProperty('bfLegsRunning.animation.curAnim.frameRate',curSpeed)
        setObjectOrder('bfLegsRunning',getObjectOrder('boyfriendGroup') - 0.1)
        setProperty('bfLegsRunning.x',getProperty('boyfriend.x') - 80)
        setProperty('bfLegsRunning.y',getProperty('boyfriend.y') + 216)
    end
end
function onEvent(name,value1,value2)
    if name == 'Change Character' then
        local v1 = string.lower(value1)
        if value2 == 'bf-running' then
            if v1 == 'bf' or value1 == '0' then
                createBFLegs()
            end
        else
            if created and (v1 == 'bf' or v1 == '0') then
                destroyBfLegs()
            end
        end
    end
end
function destroyBfLegs()
    removeLuaSprite('bfLegsRunning',true)
    created = false
end
function createBFLegs()
    makeAnimatedLuaSprite('bfLegsRunning','characters/bf_legs',0,0)
    addAnimationByPrefix('bfLegsRunning','running','run legs',24,true)
    addLuaSprite('bfLegsRunning',false)
    created = true
end