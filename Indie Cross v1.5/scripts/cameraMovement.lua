local cameraOffsets = {
    default = 20
}
local enableSystem = true
local curTarget = ''

function onCreatePost()
    if version < '0.7' then
        setProperty('camFollowPos.x',getProperty('dadGroup.x') + (getProperty('boyfriendGroup.x') - getProperty('dadGroup.x')))
        setProperty('camFollowPos.y',getProperty('dadGroup.y'))
    else
        setProperty('camGame.scroll.x',getProperty('dadGroup.x') + (getProperty('boyfriendGroup.x') - getProperty('dadGroup.x')) - screenWidth/2.0)
        setProperty('camGame.scroll.y',getProperty('dadGroup.y') - screenHeight/2.0)
    end
end
function onUpdatePost()
    if enableSystem and not getProperty('isCameraOnForcedPos') then
        local ofs = 0
        local ofsX = 0
        local ofsY = 0
        
        if cameraOffsets[curTarget] == nil then
            ofs = cameraOffsets.default
        else
            ofs = cameraOffsets[curTarget]
        end
        local anim = getProperty(curTarget..'.animation.curAnim.name')
        if stringStartsWith(anim,'singLEFT') then
            ofsX = -ofs
        elseif stringStartsWith(anim,'singDOWN') then
            ofsY = ofs
        elseif stringStartsWith(anim,'singUP') then
            ofsY = -ofs
        elseif stringStartsWith(anim,'singRIGHT') then
            ofsX = ofs
        end
        if curStage == 'factory-run' then
            setProperty('camFollow.x',getProperty('dadGroup.x')+700+ofsX)
            setProperty('camFollow.y',1300+ofsY)
        else
            setProperty('camFollow.x',getCharX(curTarget)+ofsX)
            setProperty('camFollow.y',getCharY(curTarget)+ofsY)
        end
        
    end
end

function getCharX(character,isPlayer)
    local offset = 0
    if isPlayer == nil then
        isPlayer = (character == 'boyfriend')
    end
    if character == 'dad' then
        offset = getProperty('opponentCameraOffset[0]')

    elseif character == 'gf' then
        offset = offset - 150 + getProperty('girlfriendCameraOffset[0]')--- "-150" because gf is not a player, the game adds 150 at position x if the focused character is not a player

    elseif character == 'boyfriend' then
        offset = offset + getProperty('boyfriendCameraOffset[0]')

    end
    if isPlayer then
        offset = offset - 100 - getProperty(character..'.cameraPosition[0]')
    else
        offset = offset + 150  + getProperty(character..'.cameraPosition[0]')
    end
    return getMidpointX(character) + offset
end

function getCharY(character)
    local offset = 0
    if character == 'gf' then
        offset = getProperty('girlfriendCameraOffset[1]')
    else
        offset = -100
        if character == 'dad' then
            offset = offset + getProperty('opponentCameraOffset[1]')
        elseif character == 'boyfriend' then
            offset = offset + getProperty('boyfriendCameraOffset[1]')
        end
    end
    return getMidpointY(character) + getProperty(character..'.cameraPosition[1]') + offset
end

function onMoveCamera(focus)
    curTarget = focus
end