function onCreate() 
	makeLuaSprite('white', 'white', -1100, 0)
	makeLuaSprite('fg', 'agoti/images/Void_Front', -1100, 0)

	makeAnimatedLuaSprite('bg', 'agoti/images/Pillar_BG_stage', -1170, -300)
	addAnimationByPrefix('bg', 'pillar', 'Pillar_BG_Stage', 24, true)

	makeAnimatedLuaSprite('void', 'agoti/images/The_Void', -710, 400)
	addAnimationByPrefix('void', 'void', 'VoidShift', 24, true)

	makeAnimatedLuaSprite('speaker', 'agoti/images/LoudSpeaker_Moving', -500, 1280)
	addAnimationByPrefix('speaker', 'bump', 'StereoMoving', 24, true)

	scaleObject('void', 2.5, 2.5)
	scaleObject('bg', 1.1, 1.1)
	scaleObject('speaker', 0.89, 0.89)
	setScrollFactor('bg', 0.7, 0.7)

	addLuaSprite('white', false)
	addLuaSprite('void', false)
	addLuaSprite('bg', false)
	addLuaSprite('speaker', false)
	close(true);
end