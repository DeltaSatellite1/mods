local cameraPositions = {
    default = {x = nil,y = nil},
    all = {x = nil, y = nil}, -- if not nil, the camFollow will always by this value.
    dad = {x = nil,y = nil},
    boyfriend = {x = nil,y = nil},
    gf = {x = nil, y = nil}

}
local cameraOffsets = {
    default = 20
}

local targetXOfs  = 0
local targetYOfs = 0

local targetX = 0
local targetY = 0

local detectTarget = true

local enableSystem = true

local curTarget = 'dad'
local forcedX = false
local forcedY = false

local currentCameraX = ''
local currentCameraY = ''

local bothStyle = 0

local dadZoom = 0
local bfZoom = 0
local gfZoom = 0
--[[
    If you want to know the credits:
    i got a ideia of the script by Washo789, 
    the script is made by BF Myt.
]]--

function onCreate()
    if songName == 'Alpha-Moogus' or songName == 'Actin-Sus' then
        enableSystem = false
    else
        detectStage()
    end
end



function onCreatePost()
    if version <= '0.6.3' then
        setProperty('camFollowPos.x',getProperty('dadGroup.x') + 600)
        setProperty('camFollowPos.y',getProperty('dadGroup.y') - 100)
    else
        setProperty('camGame.scroll.x',detectMiddle('dad','boyfriend') - 610)
        setProperty('camGame.scroll.y',detectMiddle('dad','boyfriend','y') - 330)
    end

end

function setAllOfs(ofs)
    cameraOffsets.default = ofs
end

function setCamPos(x,y,target)
    if target == 'bf' then
        target = 'boyfriend'
    end
    if target == nil then
        for char, positions in pairs(cameraPositions) do
            if char ~= 'all' then
                if x ~= '' then
                    cameraPositions[char].x = x
                end
                if y ~= '' then
                    cameraPositions[char].y = y
                end
            end
        end
    else
        if cameraPositions[target] == nil then
            cameraPositions[target] = {x = nil, y = nil}
        end
        if x ~= '' then
            cameraPositions[target].x = x
        end
        if y ~= '' then
            cameraPositions[target].y = y
        end
    end
end

function detectMiddle(dad,bf,x)
    if x == nil or x == 'x' then
        return getCharX(dad) + ((getCharX(bf) - getCharX(dad))/2)
    else
        return getCharY(dad) + ((getCharY(bf) - getCharY(dad))/2)
    end
end
function detectStage()
    if enableSystem then
        if curStage == 'polus' then
            setCamPos(470,250,'dad')
            setCamPos(820,250,'bf')
        elseif curStage == 'toogus' then
            setCamPos(500,475,'dad')
            setCamPos(900,475,'bf')

        elseif curStage == 'reactor2' then
            setCamPos(1500,1150,'dad')
            setCamPos(2000,1150,'bf')
            setAllOfs(10)
        elseif curStage == 'ejected' then
            setCamPos(275,550)

        elseif curStage == 'airshipRoom' then
            setCamPos(300,500,'dad')
            setCamPos(700,500,'bf')

        elseif curStage == 'airship' then
            DadX = 950
            DadY = 155
            BfX = 1600
            BfY = 180
            setAllOfs(50)

        elseif curStage == 'henry' then
            setCamPos(700,550,'dad')
            setCamPos(1000,550,'bf')
        elseif curStage == 'charles' then
            setCamPos(130,430)
            setAllOfs(0)
        elseif curStage == 'cargo' then
            setCamPos(2000,1050,'dad')
            setCamPos(2050,1025,'gf')
            setCamPos(2300,1050,'bf')
        elseif curStage == 'loggo2' then
            setAllOfs(50)
        elseif curStage == 'grey' then
            setCamPos(1300,700,'dad')
            setCamPos(1800,700,'bf')
            setAllOfs(15)
        elseif curStage == 'defeat' then
            setCamPos(650,500,'dad')
            setCamPos(850,500,'bf')
            if songName ~= 'Defeat' then
                setAllOfs(40)
            end
        elseif curStage == 'polus2' then
            setCamPos(1600,1300,'dad')
            setCamPos(1800,1300,'bf')
        elseif curStage == 'polus3' then
            setCamPos(1700,400,'dad')
            setCamPos(1900,450,'bf')
            bfZoom = 0.8
            dadZoom = 0.7
            gfZoom = 0.85
        elseif curStage == 'lounge' then
            setCamPos(700,700,'dad')
            setCamPos(1000,700,'bf')
            setAllOfs(10)
        elseif curStage == 'loggo2' then
            setCamPos(420,1700,'dad')
            setCamPos(420,1700,'bf')
        elseif curStage == 'voting' then
            setCamPos(460,700,'dad')
            setCamPos(480,680,'gf')
            setCamPos(1470,700,'bf')
            setCamPos(1440,660,'redsus')
            setAllOfs(0)
        elseif curStage == 'turbulence' then
            setCamPos(1200,500,'dad')
            setCamPos(1750,900,'bf')
            setAllOfs(50)
        elseif curStage == 'victory' then
            setCamPos(1000,550)
        elseif curStage == 'finale' or curStage == 'finalem' then
            setCamPos(1100,920,'bf')
            setAllOfs(50)
            if songName == 'Finale' then
                setCamPos(750,600,'dad')
                dadZoom = 0.5
                bfZoom = 0.65
            else
                setCamPos(650,700,'dad')
            end
        elseif curStage == 'who' then
            if songName == 'Who' then
                setCamPos(800,1200,'dad')
                setCamPos(1500,1200,'bf')
            else
                setCamPos(800,1200,'dad')
                setCamPos(1200,1200,'bf')
            end
            setAllOfs(0)
        elseif curStage == 'attack' then
            setCamPos(1000,1050,'dad')
            setCamPos(1400,1050,'bf')
            setCamPos(1450,1000,'Biddle')
            setCamPos(1000,1000,'gf')
        elseif curStage == 'skeld' then
            setCamPos(500,475,'dad')
            setCamPos(800,500,'bf')
            setAllOfs(15)
        elseif curStage == 'tomtus' then
            setCamPos(850,650,'dad')
            setCamPos(1200,650,'bf')
        elseif curStage == 'kills' then
            setCamPos(500,600)
            setAllOfs(10)
        elseif curStage == 'powstage' then
            setCamPos(500,600,'dad')
            setCamPos(600,600,'bf')
            setAllOfs(10)
        elseif curStage == 'piptowers' then
            setCamPos(600,450,'dad')
            setCamPos(800,450,'bf')
            setAllOfs(10)
        elseif curStage == 'jerma' then
            if songName == 'Insane Streamer' then
                setCamPos(900,460,'dad')

                dadZoom = 0.8
                bfZoom = 0.9
            else
                setCamPos(900,650,'dad')
            end
            setCamPos(1100,650,'bf')
        elseif curStage == 'drippypop' then
            setCamPos(1200,600,'dad')
            setCamPos(1350,600,'bf')
            setAllOfs(30)
        elseif curStage == 'dave' then
            setCamPos(820,700,'dad')
            setCamPos(1000,720,'bf')
        elseif curStage == 'esculent' then
            setCamPos(1200,700)
            setAllOfs(10)
        elseif curStage == 'chef' then
            setCamPos(1200,800,'dad')
            setCamPos(1400,800,'bf')
            setAllOfs(15)
        elseif curStage == 'warehouse' then
            setCamPos(640,340,'bf')
            setCamPos(700,360,'dad')
            setCamPos(590,360,'gf')
            bfZoom = 1.2
            gfZoom = 0.9
            dadZoom = 0.9
        elseif curStage == 'tripletrouble' then
            setCamPos(1200,850,'dad')
            setCamPos(1400,850,'bf')
        end
    end
end

function focusCam(target)
    if curTarget ~= target and detectTarget then
        curTarget = target
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

function onUpdatePost()
    if enableSystem and not getProperty('isCameraOnForcedPos') then
        local ofsX = 0
        local ofsY = 0

        local ofs = 0
        if cameraOffsets[curTarget] ~= nil then
            ofs = cameraOffsets[curTarget]
        else
            ofs = cameraOffsets['default']
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


        if not forcedX then
            if currentCameraX == 'both' then
                local player1 = 'dad'
                local player2 = 'boyfriend'
                if bothStyle == 1 then
                    player1 = 'gf'
                    player2 = 'boyfriend'
                elseif bothStyle == 2 then
                    player1 = 'gf'
                    player2 = 'dad'
                end
                local posX =  getCharX(player1)
                local posX2 = getCharX(player2)
                targetX = posX + ((posX2 - posX)/2)
                
            elseif currentCameraX ~= '' and currentCameraX ~= 'event' then
                targetX = getCharX(currentCameraX)
            elseif currentCameraX == '' then
                targetX = getCharX(curTarget)
            end
        end
        
        if not forcedY then
            if currentCameraY == 'both' then
                local player1 = 'dad'
                local player2 = 'boyfriend'
                if bothStyle == 1 then
                    player1 = 'gf'
                    player2 = 'boyfriend'
                elseif bothStyle == 2 then
                    player1 = 'gf'
                    player2 = 'dad'
                end
                local posY = 0
                local posY2 = 0
                posY = getCharY(player1)
                posY2 =  getCharY(player2)
                targetY = posY + ((posY2 - posY)/2)
            elseif currentCameraY ~= '' and currentCameraY ~= 'event' then
                targetY = getCharY(currentCameraY)
            elseif currentCameraY == '' then
                targetY = getCharY(curTarget)
            end
        end
        setProperty('camFollow.x',targetX+ofsX+targetXOfs)
        setProperty('camFollow.y',targetY+ofsY+targetYOfs)
    end
end

function getCharX(character,isPlayer)
    if cameraPositions[character] == nil or cameraPositions[character] ~= nil and cameraPositions[character].x == nil then
        local offset = 0
        if isPlayer == nil then
            isPlayer = (character == 'boyfriend')
        end
        if character == 'dad' then
            offset = getProperty('opponentCameraOffset[0]')
        elseif character == 'gf' then
            offset = offset - 150 + getProperty('girlfriendCameraOffset[0]')--- "-150" because gf is not a player, the game adds 150 at position x if the focused character is not a player
        elseif character == 'boyfriend' then
            offset = offset - getProperty('boyfriendCameraOffset[0]')
        end
        if isPlayer then
            offset = offset - 100 - getProperty(character..'.cameraPosition[0]')
        else
            offset = offset + 150  + getProperty(character..'.cameraPosition[0]')
        end
        return getMidpointX(character) + offset
    else
        return cameraPositions[character].x
    end
end

function getCharY(character)
    if cameraPositions[character] == nil or cameraPositions[character] ~= nil and cameraPositions[character].y == nil then
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
    else
        return cameraPositions[character].y
    end
end

function detectSection()
    if gfSection ~= true then
        if mustHitSection ~= true then
            return 'dad'
        else
            return 'boyfriend'
        end
    else
        return 'gf'
    end
end

function detectPosEvent(pos)
    if pos == 'bf' or pos == 'boyfriend' or pos == 'gf' or pos == 'dad' then
        return true
    end
    return false
end

function onMoveCamera(focus)
    focusCam(focus)
end

function onEvent(name,v1,v2)
    if name == 'FocusCamScript' and enableSystem then
        if v1 ~= '' and string.lower(v1) ~= 'false' then
            local posX = 0
            local posY = 0
            local offsetX = 0
            local offsetY = 0
            if v1 ~= '' then
                local v1arguments = split(v1,',')
                posX = v1arguments[1]
                posY = v1arguments[2]
                if v1arguments[3] ~= nil then
                    offsetX = tonumber(v1arguments[3])
                end
                if v1arguments[4] ~= nil then
                    offsetY = tonumber(v1arguments[4])
                end
                if posX == 'bfgf' then
                    posX = 'both'
                    bothStyle = 1
                elseif posX == 'dadgf' then
                    bothStyle = 2
                    posX = 'both'
                elseif posX == 'bf' then
                    posX = 'boyfriend'
                end
                forcedX = false
                if string.match(posX,"%a") then
                    currentCameraX = posX
                    curTarget = posX

                elseif posX ~= '.' and posX ~= '' and posX ~= 0 then
                    targetX = tonumber(posX)
                    currentCameraX = 'event'
                    forcedX = true

                end

                forcedY = false
                if posY == 'bfgf' then
                    posY = 'both'
                    bothStyle = 1
                elseif posY == 'dadgf' then
                    bothStyle = 2
                    posY = 'both'
                elseif posY == 'bf' then
                    posY = 'boyfriend'
                end
                if string.match(posY,'%a') then
                    currentCameraY = posY
                    curTarget = posY
                elseif posY ~= '.' and posY ~= '' and posY ~= 0 then
                    currentCameraY = 'event'
                    
                    forcedY = true
                end
                targetXOfs = offsetX
                targetYOfs = offsetY
            end
        else
            bothStyle = 0
            forcedX = false
            forcedY = false
            targetXOfs = 0
            targetYOfs = 0

            currentCameraX = ''
            currentCameraY = ''
            focusCam(detectSection())
        end
    elseif name == 'Set Cam Ofs' then
        local ofs = tonumber(v2)
        if v1 == '' then
            v1 = 'default'
        elseif v1 == 'bf' then
            v1 = 'boyfriend'
        end

        if ofs == nil then
            cameraOffsets = {}
            detectStage()
        else
            cameraOffsets[v1] = ofs
        end

    elseif name == 'Set Cam Target' then
        if v1 == '' then
            curTarget = detectSection()
            detectTarget = true
        else
            if string.lower(v1) == 'bf' then
                v1 = 'boyfriend'
            end
            debugPrint(v1)
            curTarget = v1
            detectTarget = false
        end
    end
end

function split(text,argument)
    local array = {}
    local founded = false
    local pos = 0
    repeat
        founded = false
        local split,_ = string.find(text,argument,pos,true)
        local number = string.sub(text,pos)
        if split then
            number = string.sub(text,pos,split-1)
            founded = true
            pos = _+1
        else
            if pos == 0 then
                array = {number}
            end
        end
        table.insert(array,number)
    until founded == false

    return array
end