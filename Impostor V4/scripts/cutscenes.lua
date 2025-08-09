local soundFounded = false
local allowCountDown = true
local allowEnd = true
function onCreate()
    if isStoryMode and not seenCutscene then
        if (songName == 'Sussus-Moogus' or songName == 'Sabotage' or songName == 'Meltdown' or songName == 'Sussus Toogus' or songName == "Mando" or songName == 'Oversight' or songName == 'Danger' or songName == 'Delusion' or songName == 'Titular') then
            soundFounded = true
            allowCountDown = false
            setProperty('inCutscene',true)
        end
        if songName == 'Meltdown' or songName == 'Magmatic' or songName == 'O2' or songName == 'Voting-Time' then
            allowEnd = false
            addLuaScript('custom_events/coverScreen')
        end
    end
end
function onCreatePost()
    if soundFounded and not seenCutscene then
        if songName == 'Sussus-Moogus' then
            startVideo('polus1')
        elseif songName == 'Sabotage' then
            startVideo('polus2')
        elseif songName == 'Meltdown' then
            startVideo('polus3')
        elseif songName == 'Sussus Toogus' then
            startVideo('mira1')
        elseif songName == "Mando" then
            startVideo('mando')
        elseif songName == 'Oversight' then
            startVideo('oversight')
        elseif songName == 'Danger' then
            startVideo('danger')
        elseif songName == 'Delusion' then
            startVideo('grey')
        elseif songName == 'Titular' then
            startVideo('henry1')
        end
    end
end
function onStartCountdown()
    if soundFounded and not allowCountDown then
        allowCountDown = true
        return Function_Stop
    end
    return Function_Continue
end
function onEndSong()
    if not allowEnd then
        if songName == 'Meltdown'  then
            startVideo('meltdown_afterscene')
        elseif songName == 'Magmatic' then
            startVideo('boiling')
        elseif songName == 'O2' then
            startVideo('voting')
        elseif songName == 'Voting-Time' then
            startVideo('turb')
        end
        allowEnd = true
        triggerEvent('coverScreen','1,other','0')
        return Function_Stop
    end
    return Function_Continue
end