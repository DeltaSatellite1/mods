local targetX = 0
local targetY = 0
local targetXMoveOfs = 0
local targetYMoveOfs = 0
local targetXOfs = 0
local targetYOfs = 0

local BfOfs = 20
local GfOfs = 20
local DadOfs = 20
local Dad2Ofs = 20

local BfX = nil
local BfY = nil

local GfX = nil
local GfY = nil

local DadX = nil
local DadY = nil

local Dad2X = nil
local Dad2Y = nil

local BfOfsX = 0
local BfOfsY = 0

local GfOfsX = 0
local GfOfsY = 0

local DadOfsX = 0
local DadOfsY = 0

local Dad2OfsX = 0
local Dad2OfsY = 0


local currentTarget = 'dad'
local forcedX = false
local forcedY = false

local currentCameraX = 'dad'
local currentCameraY = 'dad'

local bothStyle = 0

local dadZoom = 0
local bfZoom = 0
local gfZoom = 0

local player3Section = false
--[[
    If you want to know the credits:
    i got a ideia of the script by Washo789, 
    the script is made by BF Myt.
]]--
function onMoveCamera(focus)
    focusCam(focus)
end

function focusCam(target)
    if not forcedX and currentCameraX ~= 'event' and currentCameraX ~= 'both' then
        currentCameraX = target
    end
    if not forcedY and currentCameraY ~= 'event' and currentCameraY ~= 'both' then
        currentCameraY = target
    end
    if currentTarget ~= target then
        currentTarget = target
        if target == 'dad' then
            if dadZoom ~= 0 then
                setProperty('defaultCamZoom',dadZoom)
            end
        elseif target == 'boyfriend' then
            if bfZoom ~= 0 then
                setProperty('defaultCamZoom',bfZoom)
            end
        elseif target == 'gf' then
            if gfZoom ~= 0 then
                setProperty('defaultCamZoom',gfZoom)
            end
        end
    end
end
function onCreatePost()
    detectStage()
    setProperty('camFollowPos.x',getProperty('dad.x') + (getProperty('boyfriend.x') - getProperty('dad.x')))
    setProperty('camFollowPos.y',getCharacterPosY('dad'))
end
function setAllOfs(ofs)
    BfOfs = ofs
    DadOfs = ofs
    GfOfs = ofs
end

function detectStage()
    if getPropertyFromClass('states.PlayState','curStage') == 'henry' then
        DadX = 700
        DadY = 550
        Dad2X = 650
        Dad2Y = 540
        BfX = 1000
        BfY = 550
    end
end

function onUpdate()
    if getProperty('isCameraOnForcedPos') == false then
        targetXMoveOfs = 0
        targetYMoveOfs = 0
        if currentTarget ~= detectSection() and curSection ~= nil then
            focusCam(detectSection())
        end
        if currentTarget == 'boyfriend' and BfOfs ~= 0 then
            local bfAnim = getProperty('boyfriend.animation.curAnim.name')
            if string.find(bfAnim,'singLEFT',0,true) ~= nil then
                targetXMoveOfs = -BfOfs
    
            elseif string.find(bfAnim,'singDOWN',0,true) ~= nil then
                targetYMoveOfs = BfOfs
    
            elseif string.find(bfAnim,'singUP',0,true) ~= nil then
                targetYMoveOfs = -BfOfs

            elseif string.find(bfAnim,'singRIGHT',0,true) ~= nil then
                targetXMoveOfs = BfOfs
            end
        elseif currentTarget == 'dad' and DadOfs ~= 0 then
            local dadAnim = getProperty('dad.animation.curAnim.name')
            if string.find(dadAnim,'singLEFT',0,true) ~= nil then
                targetXMoveOfs = -DadOfs
    
            elseif string.find(dadAnim,'singDOWN',0,true) ~= nil then
                targetYMoveOfs = DadOfs
    
            elseif string.find(dadAnim,'singUP',0,true) ~= nil then
                targetYMoveOfs = -DadOfs
    
            elseif string.find(dadAnim,'singRIGHT',0,true) ~= nil then
                targetXMoveOfs = DadOfs
            end
        elseif currentTarget == 'gf' and GfOfs ~= 0 then
            local gfAnim = getProperty('gf.animation.curAnim.name')
            if string.find(gfAnim,'singLEFT',0,true) ~= nil then
                targetXMoveOfs = -GfOfs
    
            elseif string.find(gfAnim,'singDOWN',0,true) ~= nil then
                targetYMoveOfs = GfOfs
    
            elseif string.find(gfAnim,'singUP',0,true) ~= nil then
                targetYMoveOfs = -GfOfs
    
            elseif string.find(gfAnim,'singRIGHT',0,true) ~= nil then
                targetXMoveOfs = GfOfs
            end
        elseif currentTarget == 'player3' and Dad2Ofs ~= 0 then
            local anim = getProperty('player3Lua.animation.curAnim.name')
            if string.find(anim,'singLEFT',0,true) ~= nil then
                targetXMoveOfs = -Dad2Ofs
    
            elseif string.find(anim,'singDOWN',0,true) ~= nil then
                targetYMoveOfs = Dad2Ofs
    
            elseif string.find(anim,'singUP',0,true) ~= nil then
                targetYMoveOfs = -Dad2Ofs
    
            elseif string.find(anim,'singRIGHT',0,true) ~= nil then
                targetXMoveOfs = Dad2Ofs
            end
        end
        if detectPosEvent(currentCameraX) then
            targetX = getCharacterPosX(currentCameraX)
        end
        if detectPosEvent(currentCameraY) then
            targetY = getCharacterPosY(currentCameraY)
        end
        if currentCameraX == 'both' then
            local player1 = 'dad'
            local player2 = 'bf'
            local posX =  getCharacterPosX(player1)
            local posX2 = getCharacterPosX(player2)
            targetX = posX + ((posX2 - posX)/2)
        end
        if currentCameraY == 'both' then
            local player1 = 'dad'
            local player2 = 'bf'
            local posY = 0
            local posY2 = 0
            posY = getCharacterPosY(player1)
            posY2 =  getCharacterPosY(player2)
            targetY = posY + ((posY2 - posY)/2)
        end
        local targetXGo = targetX+targetXOfs+targetXMoveOfs
        if targetXGo ~= nil then
            setProperty('camFollow.x',targetXGo)
        end
        local targetYGo = targetY+targetYOfs+targetYMoveOfs
        if targetYGo ~= nil then
            setProperty('camFollow.y',targetYGo)
        end
    end
end
function getCharacterPosX(character)
    if character == 'bf' or character == 'boyfriend' then
        if BfX ~= nil then
            return BfX + BfOfsX
        else
            return getMidpointX('boyfriend') - 100 - getProperty('boyfriend.cameraPosition[0]') + getProperty('boyfriendCameraOffset[0]') + BfOfsX
        end
    elseif character == 'gf' then
        if GfX ~= nil then
            return GfX + GfOfsX
        else
            return getMidpointX('gf') + getProperty('gf.cameraPosition[0]') + getProperty('girlfriendCameraOffset[0]') + GfOfsX
        end
    elseif character == 'player3' then
        if Dad2X ~= nil then
            return Dad2X + Dad2OfsX
        else
            return getMidpointX('player3Lua') + 150 + Dad2OfsX
        end
    elseif character == 'dad' then
        if DadX ~= nil then
            return DadX + DadOfsX
        else
            return getMidpointX('dad') + 150 + getProperty('dad.cameraPosition[0]') + getProperty('opponentCameraOffset[0]') + DadOfsX
        end
    end
    return nil
end
function getCharacterPosY(character)
    if character == 'bf' or character == 'boyfriend' then
        if BfY ~= nil then
            return BfY + BfOfsY
        else
            return getMidpointY('boyfriend') - 100 + getProperty('boyfriend.cameraPosition[1]') + getProperty('boyfriendCameraOffset[1]') + BfOfsY
        end
    elseif character == 'gf' then
        if GfY ~= nil then
            return GfY + GfOfsY
        else
            return getMidpointY('gf') + getProperty('gf.cameraPosition[1]') + getProperty('girlfriendCameraOffset[1]') + GfOfsY
        end
    elseif character == 'dad' then
        if DadY ~= nil then
            return DadY + DadOfsY
        else
            return getMidpointY('dad') - 100 + getProperty('dad.cameraPosition[1]') + getProperty('opponentCameraOffset[1]') + DadOfsY
        end
    elseif character == 'player3' then
        if Dad2Y ~= nil then
            return Dad2Y + Dad2OfsY
        else
            return getMidpointY('player3Lua') - 100 + Dad2OfsY
        end
    end
    return nil
end
function detectSection()
    if gfSection ~= true then
        if mustHitSection ~= true then
            if not player3Section then
                return 'dad'
            else
                return 'player3'
            end
        else
            return 'boyfriend'
        end
    else
        return 'gf'
    end
end
function detectPosEvent(pos)
    if pos == 'bf' or pos == 'boyfriend' or pos == 'gf' or pos == 'dad' or pos == 'player3' then
        return true
    end
    return false
end
function onEvent(name,v1,v2)
    if name == 'FocusCamScript' then
        if v1 ~= '' and string.lower(v1) ~= 'false' then
            local comma1v1 = 0
            local comma2v1 = 0
            local comma3v1 = 0
            local comma4v1 = 0
            local comma5v1 = 0
            local comma6v1 = 0
            local posX = 0
            local posY = 0
            local offsetX = 0
            local offsetY = 0
            if v1 ~= '' then
                comma1v1,comma2v1 = string.find(v1,',',0,true)
                if comma1v1 ~= nil then
                    posX = string.sub(v1,0,comma1v1 - 1)
                    comma3v1,comma4v1 = string.find(v1,',',comma2v1 + 1,true)
                    if comma3v1 ~= nil then
                        posY = string.sub(v1,comma2v1 + 1,comma3v1 - 1)
                        comma5v1,comma6v1 = string.find(v1,',',comma4v1 + 1,true)
                        if comma5v1 ~= nil then
                            offsetX = string.sub(v1,comma4v1 + 1,comma5v1 - 1)
                            offsetY = string.sub(v1,comma6v1 + 1)
                        else
                            offsetX = string.sub(v1,comma4v1 + 1)
                        end
                    else
                        posY = string.sub(v1,comma2v1 + 1)
                    end
                else
                    posX = v1
                    forcedX = true
                end
                if posX ~= '.' and posX ~= '' and posX ~= 0 then
                    if detectPosEvent(string.lower(posX)) then
                        currentCameraX = posX
                        targetX = getCharacterPosX(string.lower(posX))
                    else
                        if posX == 'both' then
                            currentCameraX = 'both'
                        else
                            targetX = posX
                            currentCameraX = 'event'
                        end
                    end
                    forcedX = true
                else
                    forcedX = false
                end
                if posY ~= '.' and posY ~= '' and posY ~= 0 then
                    if detectPosEvent(string.lower(posY)) then
                        currentCameraY = posY
                        targetY = getCharacterPosY(string.lower(posY))
                    else
                        if posY == 'both' then
                            currentCameraY = 'both'
                        else
                            targetY = posY
                            currentCameraY = 'event'
                        end
                    end
                    forcedY = true
                else
                    forcedY = false
                end
                targetXOfs = offsetX
                targetYOfs = offsetY
            end
        else
            forcedX = false
            forcedY = false
            targetYOfs = 0
            targetXOfs = 0
            currentCameraX = ''
            currentCameraY = ''
            focusCam(detectSection())
        end
    elseif name == 'Extra Section' then
        if v1 == 'dad' then
            if v2 ~= '0' then
                player3Section = true
            else
                player3Section = false
            end
        end
    end
end