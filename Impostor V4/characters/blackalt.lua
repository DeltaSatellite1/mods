local created = false
function onCreatePost()
    precacheImage('characters/blacklegs')
    if getProperty('dad.curCharacter') == 'blackalt' then
        createImpostorAltLegs()
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
                setProperty('dad.animation.curAnim.curFrame',getProperty('impostorAltLegsRunning.animation.curAnim.curFrame'))
                setProperty('dad.animation.curAnim.frameRate',0)
            end
        end
        if curFrame ~= nil then
            setProperty('impostorAltLegsRunning.animation.curAnim.curFrame',curFrame)
        end
        setProperty('impostorAltLegsRunning.animation.curAnim.frameRate',curSpeed)
        setProperty('impostorAltLegsRunning.x',getProperty('dad.x') - 120)
        setProperty('impostorAltLegsRunning.y',getProperty('dad.y') + 550)
    end
end
function onEvent(name,value1,value2)
    if name == 'Change Character' then
        local v1 = string.lower(value1)
        if value2 == 'blackalt' then
            if v1 == 'dad' or value1 == '1' then
                createImpostorAltLegs()
            end
        else
            if created and (v1 == 'dad' or v1 == '1') then
                destroyImpostorAltLegs()
            end
        end
    end
end
function destroyImpostorAltLegs()
    removeLuaSprite('impostorAltLegsRunning',true)
    created = false
end
function createImpostorAltLegs()
    makeAnimatedLuaSprite('impostorAltLegsRunning','characters/blacklegs',0,0)
    addAnimationByPrefix('impostorAltLegsRunning','running','legs',26,true)
    setObjectOrder('impostorAltLegsRunning',getObjectOrder('dadGroup'))
    scaleObject('impostorAltLegsRunning',1.31,1.2)
    addLuaSprite('impostorAltLegsRunning',false)
    created = true
end