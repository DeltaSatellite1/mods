local allowGameOver = true
local GameOverActive = false
local deathType = ''
local currentKill = 1
function onCreatePost()
    precacheMusic('gameover_v4_LOOP')
    precacheSound('gameover_v4_End')
    setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameover_v4_LOOP')
    setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameover_v4_End')
    detectGameover(true)
end
function detectGameover(precache)
    local bf = getProperty('boyfriend.curCharacter')
    local dad = getProperty('dad.curCharacter')
    local bfGameOver = ''
    local song = ''
    local loop = ''
    local endSong = ''
    deathType = ''
    allowGameOver = true
    if curStage == 'lounge' then
        loop = 'Jorsawsee_Loop'
        endSong = 'Jorsawsee_End'
    elseif curStage == 'henry' or curStage == 'dave' then
        loop = 'deathHenryMusicLoop'
        endSong = 'deathHenryMusicEnd'
    elseif curStage == 'powstage' then
        loop = 'deathPicoMusicLoop'
        endSong = 'deathPicoMusicEnd'
    end
    if bf == 'bf-fall' then
        bfGameOver = 'bf-fall'
        song = 'ejected_death'  
    elseif bf == 'bfg' then
        bfGameOver = 'bfg-dead'
    elseif bf == 'pretender' then
        bfGameOver = 'pretender'
    elseif bf == 'bf-running' then
        bfGameOver = 'bf-running-death'
    elseif bf == 'bf-idk' or bf == 'idkbf' then
        bfGameOver = 'bf-idk-dead'
    elseif bf == 'picolobby' then
        bfGameOver = 'picolobby'
    elseif bf == 'bfsus' then
        bfGameOver = 'bf-pixel-gameover'
    end
    if dad == 'black' and (bf == 'bf-defeat-normal' or bf == 'bf-defeat-scared') then
        allowGameOver = false
        if precache then
            precacheSound('edefeat')
        end
        addCharacterToList('blackKill','dad')
        if math.random(1,10) == 10 then
            bfGameOver = 'bf-defeat-dead-balls'
            song = 'defeat_kill_ballz_sfx'
        else
            bfGameOver = 'bf-defeat-dead'
            song = 'defeat_kill_sfx'
        end
        deathType = 'defeat'
    end
    if bfGameOver ~= '' then
        setPropertyFromClass('substates.GameOverSubstate', 'characterName', bfGameOver)
        if precache and getProperty('boyfriend.curCharacter') ~= bfGameOver then
            addCharacterToList(bfGameOver,'boyfriend')
        end
    else
        setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'bf-dead')
    end
    if song ~= '' then
        if precache then
            precacheSound(song)
        end
        setPropertyFromClass('substates.GameOverSubstate', 'deathSoundName', song)
    end
    if loop ~= '' then
        setPropertyFromClass('substates.GameOverSubstate', 'loopSoundName', loop)
        if precache then
            precacheMusic(loop)
        end
    end
    if endSong ~= '' then
        if precache then
            precacheSound(endSong)
        end
        setPropertyFromClass('substates.GameOverSubstate', 'endSoundName', endSong)
    end
end
function onUpdate()
    if GameOverActive then
        local dadAnim = getProperty('dad.animation.curAnim.name')
        if dadAnim == 'kill'..currentKill and getProperty('dad.animation.curAnim.finished') then
            if currentKill < 3 then
                currentKill = currentKill + 1
                characterPlayAnim('dad','kill'..currentKill,true)
            else
                allowGameOver = true
            end
        end
    end
end
function onGameOver()
    if not allowGameOver then
        if deathType == 'defeat' and not GameOverActive then
            playSound('edefeat')
            triggerEvent('Change Character','dad','blackKill')
            characterDance('boyfriend')
            characterPlayAnim('dad','kill1',false)
            setPropertyFromClass('states.PlayState', 'instance.generatedMusic', false)
            setProperty('vocals.volume', 0)
            setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 0)
            doTweenAlpha('byeHUD','camHUD',0,1,'linear')
            GameOverActive = true
            return Function_Stop
        end
    end
    return Function_Continue
end
function onEvent(name,v1,v2)
    if name == 'Change Character' and (string.lower(v1) == 'bf' or v1 == '1' or v1 == '0')then
        detectGameover(false)
    end
end