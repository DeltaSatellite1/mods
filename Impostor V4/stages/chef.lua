
function onCreate()
	makeLuaSprite('chefWall','chef/Back Wall Kitchen',0,0)
	scaleObject('chefWall',0.9,0.9)
	addLuaSprite('chefWall',false)

	makeLuaSprite('chefFloor','chef/Chef Floor',-850,1000)
	addLuaSprite('chefFloor',false)

	makeLuaSprite('chefTable','chef/Back Table Kitchen',50,170)
	scaleObject('chefTable',0.9,0.9)
	addLuaSprite('chefTable',false)
			
	makeLuaSprite('chefOver','chef/oven',1600,400)
	scaleObject('chefOver',0.9,0.9)
	addLuaSprite('chefOver',false)

	if not lowQuality then
		makeAnimatedLuaSprite('chefGray','chef/Boppers',1000,525)
		scaleObject('chefGray',0.9,0.9)
		addAnimationByPrefix('chefGray','idle','grey',24,false)
		addLuaSprite('chefGray',false)

		makeAnimatedLuaSprite('chefSaster','chef/Boppers',1300,525)
		scaleObject('chefSaster',0.9,0.9)
		addAnimationByPrefix('chefSaster','idle','saster',24,false)
		addLuaSprite('chefSaster',false)
	end

	makeLuaSprite('chefFrontTable','chef/Kitchen Counter',800,700)
	addLuaSprite('chefFrontTable',false)
	if not lowQuality then
		makeLuaSprite('chefBlueLight','chef/bluelight',0,-300)
		setBlendMode('chefBlueLight','add')
		addLuaSprite('chefBlueLight',true)

		makeLuaSprite('chefBlackLight','chef/black_overhead_shadow',0,-300)
		addLuaSprite('chefBlackLight',true)
	end
end


function onBeatHit()
	if not lowQuality and curBeat % 2 == 0 then
		objectPlayAnimation('chefGray','idle',true)
		objectPlayAnimation('chefSaster','idle',true)
	end
end
