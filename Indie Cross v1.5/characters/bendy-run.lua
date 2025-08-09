local curFrame = 0
local maxFrame = 10
local enableFrames = false
function onCreatePost()
    detectCharacter()
end
function detectCharacter()
    enableFrames = false
    if getProperty('dad.curCharacter') == 'bendy-run' then
        enableFrames = true
    end
end
function onGameOver()
    enableFrames = false
end
function onUpdatePost(el)
    if enableFrames then
        curFrame = (curFrame + (el*24))%maxFrame
        setProperty('dad.animation.curAnim.curFrame',curFrame)
        setProperty('dad.animation.curAnim.frameRate',0)
    end
end
function onEvent(name,v1,v2)
    if name == 'Change Character' then
        detectCharacter()
    end
end
function opponentNoteHit(id, direction, noteType, isSustainNote)
    if enableFrames then
        setProperty('dad.animation.curAnim.curFrame',curFrame)
    end
end