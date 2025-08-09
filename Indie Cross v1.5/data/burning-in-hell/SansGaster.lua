local InvincibleTime = 0
local SansAttack = false

local posX1 = 0
local posX2 = 0
local posY1 = 0
local posY2 = 0

local limitArea = {220,1660,440,1100}--{left,right,top,bottom}
local hitboxOffset = 160
function onCreate()
	for rays = 1,2 do
		makeAnimatedLuaSprite('ray'..rays,'sans/Gaster_blasterss',-2500,400);
		addAnimationByPrefix('ray'..rays,'Attack1','fefe instance 1',24,false)
		objectPlayAnimation('ray'..rays,'Attack1',false)
		addLuaSprite('ray'..rays,true)
	end
	makeLuaSprite('HeartSans','sans/heart',990,850)
	setProperty('HeartSans.alpha',0.001)
	addLuaSprite('HeartSans',true)
	precacheSound('sans/readygas')
end

function setCamTarget(target)
    callScript('scripts/global_functions','setCamTarget',{target})
end

function onUpdate(el)
	if SansAttack then
		setCamTarget('boyfriend')
		local velocity = 500*el

		local heartX = getProperty('HeartSans.x')
		local heartY = getProperty('HeartSans.y')
		if keyPressed('left') then
			setProperty('HeartSans.x',math.max(heartX - velocity,limitArea[1]))
		end

		if keyPressed('right')  then
			setProperty('HeartSans.x',math.min(heartX + velocity,limitArea[2]))
		end

		if keyPressed('up')  then
			setProperty('HeartSans.y',math.max(heartY - velocity,limitArea[3]))
		end

		if keyPressed('down') then
			setProperty('HeartSans.y',math.min(heartY + velocity,limitArea[4]))
		end
		if InvincibleTime <= 0 then
			for rays = 1,2 do
				local x = 0
				local y = 0
				local rayFrame = getProperty('ray'..rays..'.animation.curAnim.curFrame')
				if (rays == 1) then
					x = posX1
					y = posY1
				else
					x = posX2
					y = posY2
				end
				if rayFrame >= 29 and rayFrame <= 37 and (heartX >= x - hitboxOffset and heartX <= x + hitboxOffset and heartY >= y - hitboxOffset and heartY <= y + hitboxOffset) then
					InvincibleTime = 1
					setHealth(getHealth() - 1)
					--playSound('sans/hearthurt')
				end
			end
		else
			InvincibleTime = InvincibleTime - el
		end
	else
		if getProperty('HeartSans.alpha') > 0 then
			setProperty('HeartSans.alpha',getProperty('HeartSans.alpha') - el)
		end
		if getProperty('boyfriend.alpha') < 1 then
			setProperty('boyfriend.alpha', getProperty('boyfriend.alpha') + 0.02)
		end
	end
	for rays = 1,2 do
		if getProperty('ray'..rays..'.animation.curAnim.finished') == false and SansAttack then
			setProperty('ray'..rays..'.alpha',1)
		else
			setProperty('ray'..rays..'.alpha',0.001)
		end
	end
end

function onTimerCompleted(tag)
	if string.find(tag,'SansAttack',0,true) and SansAttack then
		local id = string.gsub(tag,'SansAttack','')
		local ray = 'ray'..id
		
		playAnim(ray,'Attack1',true)
		setProperty(ray..'.flipX',getRandomBool(50))
		setProperty(ray..'.y',getProperty('HeartSans.y') - 240)
		setProperty(ray..'.angle',getRandomInt(0,30))
		updateHitbox(ray)
		playSound('sans/readygas')

		runTimer('SansAttack'..((tonumber(id)%2)+1),getRandomFloat(1,1.5))
		runTimer('gasSound'..id,1.1)
		
		if id == '1' then
			posX1 = getProperty('HeartSans.x')
			posY1 = getProperty('HeartSans.y')
		else
			posX2 = getProperty('HeartSans.x')
			posY2 = getProperty('HeartSans.y')
		end
	elseif string.find(tag,'gasSound',0,true) then
		playSound('sans/shootgas')
		sansShake()
	end
end

function onStepHit()
	if curStep == 408 or curStep == 662 then
		SansAttack = true
		runTimer('SansAttack1',1)
		addLuaSprite('HeartSans',true)
		setProperty('HeartSans.alpha',0)
		doTweenAlpha('bfAlphaSans','boyfriend',0.5,0.3,'linear')
		doTweenAlpha('healthAlphaSans','HeartSans',1,0.3,'linear')
	elseif curStep == 508 or curStep == 761 then
		SansAttack = false
		setCamTarget(nil)
		doTweenAlpha('healthAlphaSans','HeartSans',0,0.3,'linear')
		doTweenAlpha('bfAlphaSans','boyfriend',1,0.3,'linear')
	end
end

function sansShake()
	cameraShake('camGame',0.05,0.3)
	cameraShake('camHUD',0.005,0.3)
	for strumLineNotes = 0,7 do
		local strumX = getPropertyFromGroup('strumLineNotes',strumLineNotes,'x')
		local strumY = getPropertyFromGroup('strumLineNotes',strumLineNotes,'y')
		local strumAngle = getPropertyFromGroup('strumLineNotes',strumLineNotes,'angle')
		setPropertyFromGroup('strumLineNotes', strumLineNotes,'x', strumX + getRandomInt(-30,-15))
		setPropertyFromGroup('strumLineNotes', strumLineNotes,'y', strumY + getRandomInt(-30,-15))
		setPropertyFromGroup('strumLineNotes', strumLineNotes,'angle', strumAngle + getRandomInt(-45,-15))
		noteTweenX('ShakeBackX'..strumLineNotes, strumLineNotes, strumX,0.3,'backOut')
		noteTweenY('ShakeBackY'..strumLineNotes, strumLineNotes, strumY,0.3,'backOut')
		noteTweenAngle('ShakeBackAngle'..strumLineNotes, strumLineNotes, strumAngle,0.3,'backOut')
	end
end