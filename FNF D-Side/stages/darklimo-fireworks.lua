local t = 0
local s = 0
function onCreate()

	makeLuaSprite('bg', 'W4/limoSunsetNight', -300, -300)
	addLuaSprite('bg', false)
	setScrollFactor('bg', 0.95, 1)
    setGraphicSize('bg', getProperty('bg.width') * 1.2)

    makeAnimatedLuaSprite('fireworkPurple', 'W4/firework0', -400, -300)
    addAnimationByPrefix('fireworkPurple', 'idle', 'Firework0', 24, true)
    addLuaSprite('fireworkPurple', false)

    makeAnimatedLuaSprite('fireworkBlue', 'W4/firework1', 0, -300)
    addAnimationByPrefix('fireworkBlue', 'idle', 'Firework1', 24, true)
    addLuaSprite('fireworkBlue', false)

    makeAnimatedLuaSprite('fireworkRed', 'W4/firework3', 800, -300)
    addAnimationByPrefix('fireworkRed', 'idle', 'Firework3', 24, true)
    addLuaSprite('fireworkRed', false)

    makeAnimatedLuaSprite('fireworkGreen', 'W4/firework2', 400, -300)
    addAnimationByPrefix('fireworkGreen', 'idle', 'Firework2', 24, true)
    addLuaSprite('fireworkGreen', false)

	makeAnimatedLuaSprite('bgPlane', 'W4/bgLimoDARK', 50, 580)
    addAnimationByPrefix('bgPlane', 'idle', 'BG limo PINK', 24, true)
	setScrollFactor('bgPlane', 0.95, 1)
	addLuaSprite('bgPlane', false)

	makeAnimatedLuaSprite('dancer1', 'W4/limoDancer', 400, 210)
	addAnimationByPrefix('dancer1', 'idle', 'bg dancer sketch DARK', 24, true)
	addLuaSprite('dancer1', false)

	makeAnimatedLuaSprite('dancer2', 'W4/limoDancer', 670, 210)
	addAnimationByPrefix('dancer2', 'idle', 'bg dancer sketch DARK', 24, true)
	addLuaSprite('dancer2', false)

	makeAnimatedLuaSprite('dancer3', 'W4/limoDancer', 940, 210)
	addAnimationByPrefix('dancer3', 'idle', 'bg dancer sketch DARK', 24, true)
	addLuaSprite('dancer3', false)

	makeAnimatedLuaSprite('dancer4', 'W4/limoDancer', 1210, 210)
	addAnimationByPrefix('dancer4', 'idle', 'bg dancer sketch DARK', 24, true)
	addLuaSprite('dancer4', false)

	makeAnimatedLuaSprite('plane', 'W4/limoDriveDARK', -700, 750)
	addAnimationByPrefix('plane', 'idle', 'Limo stage', 24, true)
	addLuaSprite('plane', false)

end
