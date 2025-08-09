swingFactor = 15
function onCreate() 
	makeLuaSprite('white', 'white', -1100, 0)
	makeLuaSprite('fg', 'agoti/images/Void_Front', -1100, 0)
	makeLuaSprite('bg', 'agoti/images/Void_Back', -160, 520)

	makeAnimatedLuaSprite('void', 'agoti/images/The_Void', -730, 400)
	addAnimationByPrefix('void', 'void', 'VoidShift', 24, true)

	scaleObject('void', 2.5, 2.5)
	scaleObject('bg', 0.47, 0.47)
	setScrollFactor('bg', 0.9, 1)

	addLuaSprite('white', false)
	addLuaSprite('void', false)
	addLuaSprite('bg', false)
	addLuaSprite('fg', false)
end

function onStartCountdown()
	doTweenY('up','gf',520.15-swingFactor ,crochet/200,'sineInOut')
	doTweenY('up1','gf',520.15-swingFactor ,crochet/200,'sineInOut')
end

function onTweenCompleted(t)
	if t == 'down' then
	
		doTweenY('up','gf',520.15-swingFactor ,crochet/200,'sineInOut')
		doTweenY('up1','bg',520.15-swingFactor ,crochet/200,'sineInOut')
	
	end
	if t == 'up' then
	
		doTweenY('down','gf',520.15+swingFactor ,crochet/200,'sineInOut')
		doTweenY('down2','bg',520.15+swingFactor ,crochet/200,'sineInOut')
	
	end
end