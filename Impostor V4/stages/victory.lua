local positions = {{850},{715,985},{580,850,1120}}
local JorCreated = true
function onCreate()
    makeAnimatedLuaSprite('victoryPeopleBG','victory/vic_bgchars',-100,190)
    addAnimationByPrefix('victoryPeopleBG','idle','lol thing',24,false)
    addLuaSprite('victoryPeopleBG',false)

    makeAnimatedLuaSprite('victoryText','victory/victorytext',410,75)
    addAnimationByPrefix('victoryText','idle','VICTORY',24,false)
    setProperty('victoryText.antialiasing',false)
    setScrollFactor('victoryText',0.8,0.8)
    addLuaSprite('victoryText',false)

    makeLuaSprite('victoryCloudBack','victory/fog_back',340,650)
    setProperty('victoryCloudBack.alpha',0.2)
    addLuaSprite('victoryCloudBack',false)

    

    makeAnimatedLuaSprite('victoryJelq','victory/vic_jelq',580,480)
    addAnimationByPrefix('victoryJelq','idle','jelqeranim',24,false)
    addLuaSprite('victoryJelq',false)
    setProperty('victoryJelq.alpha',0.001)

    makeAnimatedLuaSprite('victoryWar','victory/vic_war',850,450)
    addAnimationByPrefix('victoryWar','idle','warchiefbganim',24,false)
    setProperty('victoryWar.alpha',0.001)
    addLuaSprite('victoryWar',false)

    makeAnimatedLuaSprite('victoryJor','victory/vic_jor',1125,420)
    addAnimationByPrefix('victoryJor','idle','jorsawseebganim',24,false)
    addLuaSprite('victoryJor',false)

    if not lowQuality then
        makeLuaSprite('victoryCloudMiddle','victory/fog_mid',-190,610)
        setProperty('victoryCloudMiddle.alpha',0.2)
        addLuaSprite('victoryCloudMiddle',false)
    end
    if songName == 'Victory' then
        setProperty('victoryJor.alpha',0.001)
        JorCreated = false
    end

    makeLuaSprite('victoryLights','victory/victory_spotlights',120,0)
    setProperty('victoryLights.alpha',0.7)
    setBlendMode('victoryLights','add')
    addLuaSprite('victoryLights',true)

    makeAnimatedLuaSprite('victoryBeat','victory/victory_pulse',-320,280)
    addAnimationByPrefix('victoryBeat','beat','animatedlight',24,false)
    setBlendMode('victoryBeat','add')
    addLuaSprite('victoryBeat',true)

    if not lowQuality then
        makeLuaSprite('victoryCloudFront','victory/fog_front',-880, 875)
        setScrollFactor('victoryCloudFront',1.5,1.5)
        setProperty('victoryCloudFront.alpha',0.5)
        addLuaSprite('victoryCloudFront',true)
    end
end
function onSongStart()
    if curStep >= 124 then
        findCharacters()
    end
end
function findCharacters()
    local characters = {'warchief','jelqer','jorsawghost'}
    local charactersLua = {'victoryWar','victoryJelq','victoryJor'}
    local charactersPositions = {}
    local charactersLength = #characters
    local charactersFounded = #positions
    if not JorCreated then
        charactersFounded = charactersFounded - 1
        charactersLength = 2
    end
    for chr = 1,charactersLength do
        if getProperty('dad.curCharacter') == characters[chr] or getProperty('boyfriend.curCharacter') == characters[chr] then
            setProperty(charactersLua[chr]..'.alpha',0.001)
            table.insert(charactersPositions,chr)
            charactersFounded = charactersFounded - 1
        else
            setProperty(charactersLua[chr]..'.alpha',1)
        end
    end
    local x = 0
    for pos = 1,charactersLength do
        if #charactersPositions == 1 then
            if pos ~= charactersPositions[1] then
                x = x + 1
                setProperty(charactersLua[pos]..'.x',positions[charactersFounded][x])
            end
        elseif #charactersPositions >= 2 then
            local foundedCharacter = false
            for notEnable = 1,#charactersPositions do
                if pos == charactersPositions[notEnable] then
                    foundedCharacter = true
                end
            end
            if not foundedCharacter then
                x = x + 1
                setProperty(charactersLua[pos]..'.x',positions[charactersFounded][x])
            end
        end
    end
end
function onEvent(name,v1,v2)
    if name == 'Change Character' then
        if songName == 'Victory' and v2 == 'jorsawghost' then
            JorCreated = true
        end
        findCharacters()
    end
end
function onBeatHit()
    objectPlayAnimation('victoryPeopleBG','idle',true)
    objectPlayAnimation('victoryText','idle',false)
    objectPlayAnimation('victoryJelq','idle',true)
    objectPlayAnimation('victoryJor','idle',true)
    objectPlayAnimation('victoryWar','idle',true)
    objectPlayAnimation('victoryBeat','beat',true)
    if curBeat == 31 then
        findCharacters()
    end
end

