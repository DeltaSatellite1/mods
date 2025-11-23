useHP = true 
notLow = true

--for juice levels ITS NOT WHAT YOU THINK
maxY = 250
minY = 520
juicePercent = minY - maxY
maxScale = 0.65

function onCreate()
	if useHP then
		setProperty('health', 2.0)
		
		makeLuaSprite('black', 'custHPsys/black', 1142, 170)
		scaleObject('black', maxScale, maxScale)
		
		makeLuaSprite('juice', 'custHPsys/pink', 1142, maxY)
		scaleObject('juice', maxScale, maxScale)
		
		makeAnimatedLuaSprite('bar', 'custHPsys/healthbar', 1050, 140)
		scaleObject('bar', maxScale, maxScale)
		addAnimationByIndices('bar', 'idle', 'HEALTHBAR NENE', '0,1,2,3,4,5,6,7,8,9,10,11,12,13,14', 24, false)
		addAnimationByIndices('bar', 'idle_low', 'HEALTHBAR NENE', '26,27,28,29,30,31,32,33', 24, false)
		addAnimationByIndices('bar', 'itsover', 'HEALTHBAR NENE', '15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33', 24, false) 
		addAnimationByIndices('bar', 'wereback', 'HEALTHBAR NENE', '34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53', 24, false) 		

		makeAnimatedLuaSprite('bubs', 'custHPsys/healthbar_METER_ANIM', 1137, maxY - 40)
		scaleObject('bubs', maxScale, maxScale)
		addAnimationByPrefix('bubs', 'idle', 'HEALTH METER ANIM', 24, true)
		
		--ordering
		addLuaSprite('black', true)
		addLuaSprite('juice', true)
		addLuaSprite('bubs', true)
		addLuaSprite('bar', true)	
		
		objectPlayAnimation('bar', 'idle')
		objectPlayAnimation('bubs', 'idle')

		setObjectCamera('black', 'hud')
		setObjectCamera('juice', 'hud')
		setObjectCamera('bar', 'hud')
		setObjectCamera('bubs', 'hud')
	end
end

function onUpdate()
	if useHP then 
		--removes all other HUD elements
		setProperty('scoreTxt.visible', false)
		setProperty('timeBar.visible', false)
		setProperty('timeTxt.visible', false)
		setProperty('iconP1.y', 1000) 
		setProperty('iconP2.y', 1000)
		setProperty('healthBar.alpha', 0)
		
		juiceCalc = maxY + (juicePercent - (juicePercent*(getProperty("health")/2))) --big math! get percent of health then adjust it to the Y value 

		setProperty('bubs.y', getProperty('juice.y') - 40) --bubbles follow the juice	
		scaleObject('juice', 0.65, 0.20 + (maxScale * getProperty("health")/2)) --adds leeway then adjusts scale to health percentage
		
		if getProperty("health") >= 0.4 then --I know this looks awful but, it works
			if notLow == false then
				objectPlayAnimation('bar', 'wereback', true)
				notLow = true
			end
		else
			if notLow then
				objectPlayAnimation('bar', 'itsover', true)
				notLow = false
			end
		end		
	end
end

--only update on noteHit because gay
function goodNoteHit(id, direction, noteType, isSustainNote)
	setProperty('juice.y', juiceCalc)
end

function noteMiss(id, direction, noteType, isSustainNote)
	setProperty('juice.y', juiceCalc)
	if getProperty("health") > 0.0182 then --extra HP drain so its faster to die lmao
		setProperty("health", getProperty("health") - 0.01)
	end
end

function onBeatHit()
	if curBeat % 2 == 0 and useHP then
		if notLow then
			objectPlayAnimation('bar', 'idle')
		else
			objectPlayAnimation('bar', 'idle_low')
		end
	end
end