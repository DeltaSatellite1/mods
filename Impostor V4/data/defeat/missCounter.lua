local missCounter = nil
local selection = {5,4,3,2,1,0}
local currentSelection = 1
function onCreate()
    missCounter = -1
    precacheSound('storySelect')
    precacheSound('confirmMenu')
    if missCounter ~= nil then
        addLuaScript('custom_events/coverScreen')
        triggerEvent('coverScreen','1,other','0')
        setPropertyFromClass('flixel.FlxG','mouse.visible',true)
        for missSprites = 1,6 do
            local posY = 0
            if missSprites > 2 and missSprites <= 4 then
                posY = 50
            elseif missSprites > 4 then
                posY = 70
            end
            makeLuaSprite('missImpostor'..missSprites,'defeat/dummypostor'..missSprites,250 +(150 * (missSprites - 1)),400 + posY)
            setObjectCamera('missImpostor'..missSprites,'other')
            addLuaSprite('missImpostor'..missSprites,true)
        end
        makeLuaSprite('missArrow','defeat/missAmountArrow',0,350)
        --setPropertyFromClass('missArrow.scale.x',0.5)
        setObjectCamera('missArrow','other')
        addLuaSprite('missArrow',true)

        makeLuaText('missCountersText','5/5 Combos Breaks',1000,300,200)
        setObjectCamera('missCountersText','other')
        setTextColor('missCountersText','FF0000')
        setTextAlignment('missCountersText','left')
        setTextSize('missCountersText',70)
        addLuaText('missCountersText',true)
        reloadActions()
    end
end
function onCreatePost()
    if missCounter == -1 then
        setProperty('camHUD.alpha',0.01)
        setTextColor('scoreTxt','FF0000')
        setProperty('healthBar.visible',false)
        setProperty('healthBarBG.visible',false)
        setProperty('iconP1.visible',false)
        setProperty('iconP2.visible',false)
    end
end
function onUpdate()
    if missCounter == -1 then
        if mouseClicked() and getMouseY('other') >= 250 then
            for sprites = 1,6 do
                if getMouseX('other') >= getObjectXMoreWidth('missImpostor'..sprites,0) and getMouseX('other') <= getObjectXMoreWidth('missImpostor'..sprites,1) then
                    if currentSelection ~= sprites then
                        currentSelection = sprites
                        setProperty('missArrow.x',getProperty('missImpostor'..sprites..'.x'))
                        playSound('storySelect')
                        reloadActions()
                    else
                        endMiss()
                    end
                end
            end
        end
        if keyJustPressed('left') then
            currentSelection = currentSelection - 1
            playSound('storySelect')
            if currentSelection < 1 then
                currentSelection = 6
            end
            reloadActions()
        end
        if keyJustPressed('accept') then
            endMiss()
        end
        if keyJustPressed('right') then
            currentSelection = currentSelection + 1
            playSound('storySelect')
            if currentSelection > 6 then
                currentSelection = 1
            end
            reloadActions()
        end
        if keyboardJustPressed('BACKSPACE') or keyboardJustPressed('ESCAPE') then
            endSong()
        end
    elseif missCounter > -1 and missCounter ~= nil then
        if getProperty('songMisses') > missCounter then
            setProperty('health',-1)
        end
    end
end
function onUpdateScore()
    local rating = getProperty('ratingFC')
    if rating == 'Clear' or getProperty('songMisses') > 0 then
        rating = ''
    else
        rating = ' ['..rating..']'
    end
    setTextString('scoreTxt','Score: '..getProperty('songScore')..' | Combo Breaks: '..math.min(missCounter,getProperty('songMisses'))..' / '..missCounter..' | Accuracy: '..(math.floor(getProperty('ratingPercent') * 10000)/100)..'%'..rating)
end
function onCountdownTick(count)
    if count == 0 then
        doTweenAlpha('camHUDHey','camHUD',1,0.5,'linear')
    end
end
function reloadActions()
    setProperty('missArrow.x',getProperty('missImpostor'..currentSelection..'.x'))
    setTextString('missCountersText',selection[currentSelection]..'/5 Combos Breaks')
end
function endMiss()
    local speed = 0.4
    playSound('confirmMenu')
    missCounter = selection[currentSelection]
    doTweenAlpha('byeBackScreenBlack','coverScreen',0,speed,'linear')
    for byeImpostors = 1,6 do
        doTweenAlpha('impostorBye'..byeImpostors,'missImpostor'..byeImpostors,0,speed,'linear')
    end
    doTweenAlpha('byeTextMiss','missCountersText',0,speed,'linear')
    setPropertyFromClass('flixel.FlxG','mouse.visible',false)
    removeLuaSprite('missArrow',true)
    onUpdateScore()
end
function getObjectXMoreWidth(obj,type)
    if type == 1 then
        return getProperty(obj..'.x') + getProperty(obj..'.width')
    else
        return getProperty(obj..'.x') - getProperty(obj..'.width') + 70
    end
end
function onStartCountdown()
    if missCounter == -1 then
        return Function_Stop
    end
    return Function_Continue
end
function onTweenCompleted(name)
    if name == 'byeBackScreenBlack' then
        startCountdown()
        for impostors = 1,6 do
            removeLuaSprite('missImpostor'..impostors,true)
        end
        removeLuaText('missCountersText',true)
    end
end