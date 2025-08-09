local haveDodge = false
local haveAttack = false
function onCreate()
    if version >= '0.7' then
        setPropertyFromClass('backend.ClientPrefs','data.timeBarType','Song Name')
    else
        setPropertyFromClass('ClientPrefs','timeBarType','Song Name')
    end
end
function onCreatePost()
    if songName == 'Despair' or songName == 'Last-Reel' or songName == 'Sansational' or songName == 'Burning-In-Hell' then
        haveDodge = true
    else
        for events = 0,getProperty('eventNotes.length')-1 do
            local eventName = getPropertyFromGroup('eventNotes',events,'event')
            if eventName == 'CupheadAttack' or eventName == 'CupheadDoubleAttack' or eventName == 'SansDodge' or eventName == 'Devil Dodge' then
                haveDodge = true
            elseif eventName == 'CupheadShooting' then
                haveAttack = true
            end
        end
    end
    if haveAttack then
        makeAnimatedLuaSprite('AttackButton','IC_Buttons',-6,245)
        scaleObject('AttackButton',0.5,0.5)
        setProperty('AttackButton.alpha',0.5)
        addAnimationByPrefix('AttackButton','normal','Attack instance 1',0,true)
        addAnimationByPrefix('AttackButton','clicked','Attack Click instance 1',24,false)
        addAnimationByPrefix('AttackButton','NA','AttackNA instance 1',24,false)
        setObjectCamera('AttackButton','hud')
        setProperty('AttackButton.offset.x',0)
        setProperty('AttackButton.offset.y',0)
        playAnim('AttackButton','normal',false)
        addLuaSprite('AttackButton',false)
    end
    if haveDodge then
        makeAnimatedLuaSprite('DodgeButton','IC_Buttons',-6,335)
        scaleObject('DodgeButton',0.5,0.5)
        setProperty('DodgeButton.alpha',0.5)
        addAnimationByPrefix('DodgeButton','normal','Dodge instance 1',0,true)
        addAnimationByPrefix('DodgeButton','clicked','Dodge click instance 1',24,false)
        setObjectCamera('DodgeButton','hud')
        setProperty('DodgeButton.offset.x',0)
        setProperty('DodgeButton.offset.y',0)
        playAnim('DodgeButton','normal',false)
        addLuaSprite('DodgeButton',false)
    end
    local font = nil
    local size = getTextSize('scoreTxt')
    local border = nil
    local textY = 0

    if string.match(curStage,'factory') or curStage == 'freaky-machine' then
        font = 'DK Black Bamboo.ttf'
    elseif string.match(curStage,'field') or string.match(curStage,'devilHall') then
        font = 'memphis.otf'
        textY = 3  
    elseif string.match(curStage,'hall') == 'hall' or curStage == 'void' then
        font = 'Comic Sans MS.ttf'
        textY = 5
    elseif curStage == 'papyrus' then
        font = 'Papyrus Font [UNDETALE].ttf'
        setProperty('scoreTxt.antialiasing',false)
        setProperty('timeTxt.antialiasing',false)
    end
    setTextString('timeTxt',string.upper(string.sub(songName,0,1))..string.sub(songName,2))
    if font ~= '' then
        setTextFont('scoreTxt',font)
        setTextFont('timeTxt',font)
    end
    setTextSize('scoreTxt',size)
    
    if border ~= nil then
        setTextBorder('scoreTxt',border,'000000')
        setTextBorder('timeTxt',border,'000000')
    end
    setTextSize('timeTxt',15)
    setProperty('timeTxt.offset.y',-6 + textY)

end
function onSongStart()
    if timeBarType ~= 'Disabled' then
        scaleObject('timeBar',1.5,1,false)
        if version < '0.7' then
            scaleObject('timeBarBG',1.5,1,false)
        end
        if version >= '0.7' then
            setProperty('timeBar.rightBar.color',getColorFromHex('808080'))
            
        else
            setProperty('timeBarBG.color',getColorFromHex('808080'))
        end
        --setProperty('timeBar.color',getColorFromHex('FFF0000'))
        --[[setProperty('timeBar.visible',false)    

        makeLuaSprite('timeBarIC',nil,0,0)
        makeGraphic('timeBarIC',getProperty('timeBar.width'),getProperty('timeBar.height'),'FFFFFF')
        setObjectCamera('timeBarIC','hud')
        addLuaSprite('timeBarIC',false)
        setObjectOrder('timeBarIC',getObjectOrder('timeBar'))
        ]]
        updateBarColor()
    end
end
function updateBarColor()
    local color = ''
    if string.find(getProperty('dad.curCharacter'),'sans',0,true) then
        color = getColorFromHex('274A7A')
    else
        color = rgbToHex(getProperty('dad.healthColorArray'))
    end
    if version >= '0.7' then
        setProperty('timeBar.leftBar.color',color)
    else
        setProperty('timeBar.color',color)
    end
end

function onDestroy()
    if version >= '0.7' then
        setPropertyFromClass('backend.ClientPrefs','data.timeBarType',timeBarType)
    else
        setPropertyFromClass('ClientPrefs','timeBarType',timeBarType)
    end
end

function rgbToHex(array)
	return getColorFromHex(string.format('%.2x%.2x%.2x', array[1], array[2], array[3]))
end

function onUpdateScore()
    local ratingS = getProperty('ratingFC')
    if ratingS ~= '' then
        ratingS = '('..getProperty('ratingFC')..')'
    else
        ratingS = 'N/A'
    end
    local score = getProperty('songScore')
    local misses = getProperty('songMisses')
    local rating = math.floor(getProperty('ratingPercent') * 10000)/100
    if songName ~= 'Saness' then
        setTextString('scoreTxt','Score: '..score..' | Misses: '..misses..' | Accurancy: '..rating..' | '..ratingS)
    else
        setTextString('scoreTxt','Social Credit Points: '..score..' | Skill Issues: '..misses..' | Wackyness: '..rating..' % | '..ratingS)
    end
end
function onUpdate()
    if haveDodge then
        if keyboardJustPressed('SPACE') then
            playAnim('DodgeButton','clicked',true)
            setProperty('DodgeButton.offset.x',-5)
            setProperty('DodgeButton.offset.y',-7)
        end
        if keyboardReleased('SPACE') then
            playAnim('DodgeButton','normal',true)
            setProperty('DodgeButton.offset.x',0)
            setProperty('DodgeButton.offset.y',0)
        end
    end
    if haveAttack then
        if keyboardJustPressed('SHIFT') then
            playAnim('AttackButton','clicked',true)
            setProperty('AttackButton.offset.x',-7)
            setProperty('AttackButton.offset.y',-5)
        end
        if keyboardReleased('SHIFT') then
            setProperty('AttackButton.offset.x',0)
            setProperty('AttackButton.offset.y',0)
            playAnim('AttackButton','normal',true)
        end
    end
    --[[if enableTimer then
        setProperty('timeTxtIC.alpha',getProperty('timeTxt.alpha'))
        setProperty('timeTxtIC.x',getProperty('timeTxt.x') + 25)
        setProperty('timeTxtIC.y',getProperty('timeTxt.y') + 6)

        setProperty('timeBarIC.alpha',getProperty('timeBar.alpha'))
        if getSongPosition() <= songLength then
            setProperty('timeBarIC.scale.x',(getSongPosition()/songLength))
        end
        setProperty('timeBarIC.offset.x',192 - (getProperty('timeBarIC.width') * getProperty('timeBarIC.scale.x')/2))
        setProperty('timeBarIC.x',getProperty('timeBar.x') - 202)
        setProperty('timeBarIC.y',getProperty('timeBar.y'))
    end]]--
end
function onStepHit()
    if songName == 'Imminent-Demise' and curStep >= 1129 then
        songLength = 174681
    end
end