function onCreate()
    for notes = 0,getProperty('unspawnNotes.length')-1 do
        if version <= '0.6.3' then
            setPropertyFromGroup('unspawnNotes',notes,'noteSplashDisabled',true)
        else
            setPropertyFromGroup('unspawnNotes',notes,'noteSplashData.disabled',true)
        end
        if not getPropertyFromGroup('unspawnNotes',notes,'mustPress') then
            setPropertyFromGroup('unspawnNotes',notes,'blockHit',true)
        end
    end

end
function onCreatePost()
    setHealthBarColors('FF0000','00FF00')
    setTextBorder('scoreTxt',1.25,'000000')
    setProperty('scoreTxt.y',getProperty('healthBar.y') + 55)
    setTextSize('scoreTxt',16)
end

function onEvent(name,v1,v2)
    if name == 'Change Character' then
        setHealthBarColors('FF0000','00FF00')
    end
end
function onUpdate(el)
    local rating = getProperty('ratingFC')
    local ratingNumber = (math.floor(getProperty('ratingPercent') * 10000)/100)..'%'
    if rating == 'SFC' then
        rating = '(MFC) AAAA:'
    elseif rating == 'GFC' then
        rating = '(GFC) AAA:'
    elseif rating == 'FC' then
        rating = '(FC) AA:'
    elseif rating == 'Clear' then
        rating = 'N/A'
    else
        rating = '(SDCB) A:'
    end
    local redWidth = getProperty('healthBar.width')*(2 - getProperty('health'))
    if redWidth <= 0 then
        setProperty('healthRed.visible',false)
    else
        setProperty('healthRed.visible',true)
    end
    setTextString('scoreTxt','Score: '..(getProperty('songScore'))..' | Combos Breaks: '..(getProperty('songMisses'))..' | Accuracy: '..ratingNumber..' | '..rating)
    for notesLength = 0,getProperty('notes.length')-1 do
        local ofs = 10
        if getPropertyFromGroup('notes',notesLength,'isSustainNote') then
            ofs = 55
        end
        if getPropertyFromGroup('notes',notesLength,'mustPress') then
            ofs = ofs + 15
        end
        if getPropertyFromGroup('notes',notesLength,'strumTime') - getSongPosition() <= ofs then
            local dir = getPropertyFromGroup('notes',notesLength,'noteData')
            local singAnims = {'singLEFT','singDOWN','singUP','singRIGHT'}
            if getPropertyFromGroup('notes',notesLength,'mustPress') == false then
                characterPlayAnim('dad',singAnims[dir + 1],true)

                --setProperty('dad.holdTimer',0)
                --setProperty('camZooming',true)
            else
                if botPlay then
                    characterPlayAnim('boyfriend',singAnims[dir + 1],true)
                    setProperty('boyfriend.holdTimer',0)
                else
                    return
                end
            end
            removeFromGroup('notes',notesLength)
        end
    end
end
function goodNoteHit(id,dir,type,sus)
    if sus then
        removeFromGroup('notes',id)
    end
end