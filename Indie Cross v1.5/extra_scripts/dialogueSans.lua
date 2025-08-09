local curDialoguePos = 0
local dialogueLength = 0
local curTextLength = 0
local curLetterPos = 0
local enable = true
local dialogueSpeed = 0.025
local dialogueText = {}
local dialogueExpressions = {}
function onCreate()
    makeAnimatedLuaSprite('SansDialogueBox','sans/Sans_Text_Box',30,500)
    addAnimationByPrefix('SansDialogueBox','wink','Winkk instance 1',24,false)
    addAnimationByPrefix('SansDialogueBox','end','Dialogue End instance 1',24,false)
    addAnimationByPrefix('SansDialogueBox','normal','Normall instance 1',24,false)
    addAnimationByPrefix('SansDialogueBox','closed','eyes closed instance 1',24,false)
    addAnimationByPrefix('SansDialogueBox','funny','funne instance 1',24,false)
    addAnimationByPrefix('SansDialogueBox','noeyes','no eyes instance 1',24,false)
    addAnimationByPrefix('SansDialogueBox','gay','son dying is gay instance 1',24,false)
    setProperty('SansDialogueBox.antialiasing',false)
    setObjectCamera('SansDialogueBox','other')
    addLuaSprite('SansDialogueBox',true)

    makeLuaText('SansDialogueText','yes',900,300,getProperty('SansDialogueBox.y') + 65)
    setTextSize('SansDialogueText',35)
    setObjectCamera('SansDialogueText','other')
    setTextAlignment('SansDialogueText','left')
    setTextFont('SansDialogueText','Comic Sans [PIXEL].ttf')
    setTextBorder('SansDialogueBox',0.1,'FFFFFFF')
    addLuaText('SansDialogueText',true)
end

function setLetterPos(pos)
    setTextString('SansDialogueText',string.sub(dialogueText[curDialoguePos],0,pos))
    playSound('sans/snd_txtsans',1,'SansDialogue')
    curLetterPos = pos
end
function onUpdate()
    if enable then
        if curDialoguePos <= dialogueLength then
            if keyJustPressed('accept') or keyboardJustPressed('SPACE') or mouseClicked('left') then
                if curLetterPos < curTextLength then
                    setLetterPos(curTextLength)
                else
                    setDialoguePos(curDialoguePos + 1)
                end
            elseif keyboardJustPressed('ESCAPE') then
                setDialoguePos(dialogueLength + 1)
            end
        else
            if getProperty('SansDialogueBox.animation.curAnim.finished') then
                finishSansDialogue()
            end
        end
    end
end
function finishSansDialogue()
    enable = false
    
    removeLuaSprite('SansDialogueBox',true)
    removeLuaText('SansDialogueText',true)
    if songName == 'Burning-In-Hell' then
        callScript('extra_scripts/attackSans','attackSans',{})
        runTimer('startCountdown',1)
    else
        startCountdown()
    end
end
function startDialogue(dialogue,expressions)
    dialogueText = dialogue
    dialogueExpressions = expressions
    enable = true
    dialogueLength = #dialogue
end
function setDialoguePos(pos)
    setTextString('SansDialogueText','')
    curLetterPos = 0
    if pos <= dialogueLength then
        playAnim('SansDialogueBox',dialogueExpressions[pos],true)
        curTextLength = string.len(dialogueText[pos])
        if pos ~= 1 then
            runTimer('DialogueSansLetters',0.2)
        end
    elseif pos > dialogueLength then
        playAnim('SansDialogueBox','end',false)
        removeLuaText('SansDialogueText',true)
    end
    curDialoguePos = pos
end
function onStartCountdown()
    if enable and not getProperty('inCutscene') then
        setDialoguePos(1)
        runTimer('DialogueSansLetters',1)
        setPropertyFromClass('PlayState','seenCutscene',true)
        return Function_Stop;
    end
end
function onTimerCompleted(tag)
    if tag == 'DialogueSansLetters' and curLetterPos < curTextLength then
        setLetterPos(curLetterPos + 1)
        runTimer('DialogueSansLetters',dialogueSpeed)
    elseif tag == 'startCountdown' then
        startCountdown()
    end
end