local curFrame = 0
local maxFrames = 10
local enableFrames = false
local frameRate = 0

function onCreatePost()
    detectCharacter()
end
function detectCharacter()
    enableFrames = false
    if getProperty('boyfriend.curCharacter') == 'bf-bendy-run' then
        enableFrames = true
    end
end
function onGameOver()
    enableFrames = false
end
function onUpdatePost(el)
    if enableFrames then
        curFrame = (curFrame + (el*24))%maxFrames
        setProperty('boyfriend.animation.curAnim.curFrame',math.floor(curFrame))
        setProperty('boyfriend.animation.curAnim.frameRate',0)
        if (getProperty('boyfriend.animation.curAnim.name') ~= 'idle-alt') then
            maxFrames = 12
        else
            maxFrames = 10
        end
    end
end
function onEvent(name,v1,v2)
    if name == 'Change Character' then
        detectCharacter()
    end
end
function goodNoteHit(id, direction, noteType, isSustainNote)
    if enableFrames then
        setProperty('boyfriend.animation.curAnim.curFrame',curFrame)
    end
end