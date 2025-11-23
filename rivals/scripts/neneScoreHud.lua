scale = 0.5

function onCreatePost()
	if not downscroll then
		gooY = 450
		scoreY = 530
		missY = 620
		doodsY = 450
	else
		gooY = 0
		scoreY = 10
		missY = 100
		doodsY = -70
	end
	
	makeLuaSprite('nenegoo', 'scoreHUD/goo', 0, gooY)
	if downscroll then setProperty('nenegoo.flipY', true) end
	setObjectCamera('nenegoo', 'other')
	scaleObject('nenegoo', scale, scale)
	addLuaSprite('nenegoo', false)
	
	makeLuaSprite('nenescore', 'scoreHUD/score', 20, scoreY)
	setObjectCamera('nenescore', 'other')
	scaleObject('nenescore', scale, scale)
	addLuaSprite('nenescore', false)
	
	makeLuaSprite('nenemiss', 'scoreHUD/miss', 20, missY)
	setObjectCamera('nenemiss', 'other')
	scaleObject('nenemiss', scale, scale)
	addLuaSprite('nenemiss', false)
	
	makeLuaSprite('doods', 'scoreHUD/doods', 20, doodsY)
	setObjectCamera('doods', 'other')
	scaleObject('doods', scale, scale)
	addLuaSprite('doods', false)

	setProperty('timeBarBG.visible', false)
	setProperty('timeBar.visible', false)
	setProperty('timeTxt.visible', false)
	setProperty('scoreTxt.visible', false)
	
	makeLuaText("scoree", "0", 0, 40, getProperty("nenescore.y") + 55)
	setTextSize('scoree', 25)
	setObjectCamera('scoree', 'other')
	setTextFont('scoree', 'Quadrangle.otf')
	setTextBorder('scoree', '2', '000000')
	addLuaText("scoree")
	setTextString('scoree','0')
	
	makeLuaText("miss", "0", 0, 40, getProperty("nenemiss.y") + 50)
	setTextSize('miss', 25)
	setObjectCamera('miss', 'other')
	setTextFont('miss', 'Quadrangle.otf')
	setTextBorder('miss', '2', '000000')
	addLuaText("miss")
	setTextString('miss','0')
end

function onUpdateScore()
    updateScoreTxt()
end

function updateScoreTxt()
    local divider = ' • ';
    local accuracy = floorDecimal(rating * 100, 2);
	setTextString('scoree', score)
	setTextString('miss', misses)
end

function returnStyle()
    return styleStr;
end

function returnMisses()
    return missStr;
end

function floorDecimal(value, decimals) -- Port of Highscore.floorDecimal() lmao
    if decimals < 1 then
        return math.floor(value);
    end

    local tempMult = 1;
    for i = 1, decimals do
        tempMult = tempMult * 10;
    end
    local newValue = math.floor(value * tempMult);
    return newValue / tempMult;
end

--ignore this, this is for the timebar supposedly
function milliToHuman(milliseconds) -- https://forums.mudlet.org/viewtopic.php?t=3258
    local totalseconds = math.floor(milliseconds / 1000)
    local seconds = totalseconds % 60
    local minutes = math.floor(totalseconds / 60)
    minutes = minutes % 60
    return string.format("%0d:%02d", minutes, seconds)  
end
