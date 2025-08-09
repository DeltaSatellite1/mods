local enabled = false
local curCharacter = ''
function onEvent(name,v1,v2)
    if name == "Both Opponents" then
        if v1 ~= '0' then
            enabled = true
        else
            enabled = false
        end
    end
end
function opponentNoteHit(id,dir,noteType,sus)
    if enabled then
        local character = 'dad'
        local anim = getProperty('singAnimations['..dir..']')
        if altAnim then
            anim = anim..'-alt'
        end
        if not gfSection and noteType ~= 'GF Sing' then
            character = 'gf'
        end
        characterPlayAnim(character,anim,true)
        setProperty(character..'.holdTimer',0)
    end
end