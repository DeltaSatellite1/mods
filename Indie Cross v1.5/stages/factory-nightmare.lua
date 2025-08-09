function onCreate()
	-- background shit
	makeLuaSprite('NMachine', 'bendy/inky depths',-500, -400);
	scaleObject('NMachine',1.8,1.8)
	setScrollFactor('NMachine',0.6,0.6)
	addLuaSprite('NMachine',false)
	setProperty('NMachine.alpha',0.01)

	if songName == 'Despair' then
		makeAnimatedLuaSprite('BendyFire','bendy/Fyre',500,800)
		addAnimationByPrefix('BendyFire','FireDance','Penis instance 1',24,true)
		scaleObject('BendyFire',1.9,1.9)
		addLuaSprite('BendyFire',false)
	end

	makeLuaSprite('BendyGround', 'bendy/nightmareBendy_foreground',-220, -100);
	precacheImage('bendy/nightmareBendy_foreground')
	scaleObject('BendyGround',2,2)
	addLuaSprite('BendyGround', false)
end
--[[function onUpdate()
	if getProperty('dad.curCharacter') ~= 'Nightmare-Bendy' then
		setProperty('dad.color',getColorFromHex('FFE97F'))
	end
	if getProperty('boyfriend.curCharacter') ~= 'bf-bendy-nm' then
		setProperty('boyfriend.color',getColorFromHex('FFE97F'))
	end
end]]--
function onSectionHit()
	if songName == 'Despair' then
		if curSection == 81 or curSection == 129 then
			doTweenAlpha('BendyBG','NMachine',1,3,'linear')
		elseif curSection == 117 then
			doTweenAlpha('BendyBG','NMachine',0,1,'linear')
		elseif curSection == 201 then
			doTweenY('FireUp', 'BendyFire',-100, 10, 'QuartOut')
		end
	end
end