local created = false
function onCreatePost()
    precacheImage('characters/blacklegs')
    if getProperty('dad.curCharacter') == 'black-run' then
        createImpostorLegs()
    end
end
function onUpdate()
    if created then
        local curFrame = 0
        local curSpeed = 24
        local curDadAnim = getProperty('dad.animation.curAnim.name')
        if curDadAnim == 'danceLeft' then
            curFrame = getProperty('dad.animation.curAnim.curFrame')
            curSpeed = 0
        elseif curDadAnim == 'danceRight' then
            curFrame = getProperty('dad.animation.curAnim.curFrame') + 10
            curSpeed = 0
        else
            curFrame = nil
            curSpeed = 26
        end 
        if (curDadAnim == 'singLEFT' or curDadAnim == 'singDOWN' or curDadAnim == 'singUP' or curDadAnim == 'singRIGHT') then
            if getProperty('dad.animation.curAnim.curFrame') > 1 then
                characterPlayAnim('dad',getProperty('dad.animation.curAnim.name')..'-loop')
            elseif getProperty('dad.animation.curAnim.curFrame') <= 1 then
                setProperty('dad.animation.curAnim.frameRate',26)
            end
        else
            if (curDadAnim ~= 'singLEFT-loop' and curDadAnim ~= 'singDOWN-loop' and curDadAnim ~= 'singUP-loop' and curDadAnim ~= 'singRIGHT-loop') then
                if curDadAnim == 'danceLeft' or curDadAnim == 'danceRight' then
                    setProperty('dad.animation.curAnim.frameRate',26)
                else
                    setProperty('dad.animation.curAnim.frameRate',24)
                end
            else
                setProperty('dad.animation.curAnim.curFrame',getProperty('impostorLegsRunning.animation.curAnim.curFrame'))
                setProperty('dad.animation.curAnim.frameRate',0)
            end
        end
        if curFrame ~= nil then
            setProperty('impostorLegsRunning.animation.curAnim.curFrame',curFrame)
        end
        setProperty('impostorLegsRunning.animation.curAnim.frameRate',curSpeed)
        setProperty('impostorLegsRunning.x',getProperty('dad.x') - 19)
        setProperty('impostorLegsRunning.y',getProperty('dad.y') + 102)
    end
end
function onEvent(name,value1,value2)
    if name == 'Change Character' then
        local v1 = string.lower(value1)
        if value2 == 'black-run' then
            if v1 == 'dad' or value1 == '1' then
                createImpostorLegs()
            end
        else
            if created and (v1 == 'dad' or v1 == '1') then
                destroyImpostorLegs()
            end
        end
    end
end
function destroyImpostorLegs()
    removeLuaSprite('impostorLegsRunning',true)
    created = false
end
function createImpostorLegs()
    makeAnimatedLuaSprite('impostorLegsRunning','characters/blacklegs',0,0)
    addAnimationByPrefix('impostorLegsRunning','running','legs',26,true)
    scaleObject('impostorLegsRunning',1.32,1.2)
    setObjectOrder('impostorLegsRunning',getObjectOrder('dadGroup'))
    addLuaSprite('impostorLegsRunning',false)
    created = true
end