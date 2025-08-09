
function opponentNoteHit(id,dir,type,sus)
    if type == 'GF Dad Sing Together' then
        if gfSection == true then
            characterPlayAnim('dad',etProperty('singAnimations['..dir..']'),true)
            setProperty('dad.holdTimer',0)
        else
            characterPlayAnim('gf',getProperty('singAnimations['..dir..']'),true)
            setProperty('gf.holdTimer',0)
        end
    end
end