local enableDadShake = false

function onCreatePost()
    detectCharacter()
end
function opponentNoteHit(id,data,type,sus)
    if enableDadShake then
        cameraShake('game',0.005,0.05)
        cameraShake('hud',0.005,0.05)
    end
end
function detectCharacter()
    local charactersShake =
    {
        'Nightmare-Cuphead',
        'Nightmare-Sans',
        'Nightmare-Bendy',
        'bendy-run',
        'bendy-ic',
        'bendy-run-dark'
    }
    enableDadShake = false
    for dadLength = 1,#charactersShake do
        if getProperty('dad.curCharacter') == charactersShake[dadLength] then
            enableDadShake = true
            break
        end
    end
end
function onEvent(name,v1,v2)
    if name == 'Change Character' then
        detectCharacter()
    end
end