local EnabledCharacters = {
    'bf-ic',
    'bf-ic-rain',
    'bf-bendy-ic',
    'bf-bendy-ic-phase2',
    'bf-bendy-ic-phase3',
    'bf-bendy-nm',
    'bf-sammy',
    'bf-sans-bs',
    'bf-chara',
    'bf-sans',
    'bf-sans-nm',
    'bf-christmas-ic',
    'bf-da',
    'bf-da-b&w',
    'bf-NM',
    'UT-bf',
    'UT-bf-chara',
    'UT-sans',
    'bendy-da',
    'bendy-daphase2',
    'bendy-ic',
    'cuphead-pissed',
    'cuphead',
    'devil',
    'Nightmare-Bendy',
    'Nightmare-Cuphead',
    'Nightmare-Sans',
    'papyrus-ic',
    'sammy',
    'sans-ic',
    'sans-ic-wt',
    'sans-phase2-ic',
    'sans-phase3',
    'sans-tired'
}
local foundedBf = false
local foundedDad = false
local foundedGf = false
function detectGf(forBf)
    if not gfSection or gfSection and mustHitSection ~= forBf then
        return false
    end
    return true
end
function onCreatePost()
    detectCharacter()
end
function goodNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote then
        if not detectGf(true) and noteType ~= 'GF Sing' then
            if foundedBf and stringStartsWith(getProperty('boyfriend.animation.curAnim.name'),'sing') then
                setProperty('boyfriend.animation.curAnim.curFrame',2)
            end
        else
            gfAnim()
        end
    end
end
function onEvent(name,v1)
    if name == 'Change Character' then
        detectCharacter()
    end
end
function detectCharacter()
    foundedBf = false
    foundedDad = false
    foundedGf = false
    for Characters = 0,#EnabledCharacters do
        if getProperty('boyfriend.curCharacter') == EnabledCharacters[Characters] then
            foundedBf = true
        end
        if getProperty('dad.curCharacter') == EnabledCharacters[Characters] then
            foundedDad = true
        end
        if getProperty('gf.curCharacter') == EnabledCharacters[Characters] then
            foundedGf = true
        end
    end
end
function gfAnim()
    if foundedGf and stringStartsWith(getProperty('gf.animation.curAnim.name'),'sing') then
        setProperty('gf.animation.curAnim.curFrame',2)
    end
end
function opponentNoteHit(id, direction, noteType, isSustainNote)
    if isSustainNote then
        if not detectGf(false) and noteType ~= 'GF Sing' then
            if foundedDad and stringStartsWith(getProperty('dad.animation.curAnim.name'),'sing') then
                setProperty('dad.animation.curAnim.curFrame',2)
            end
        else
            gfAnim()
        end
    end
end