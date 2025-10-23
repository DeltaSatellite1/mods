function onCreatePost()
	-- background shit
	makeLuaSprite('BACKGROUND', 'bgs/HanzouStage/BACKGROUND', -400, -300);
	setScrollFactor('BACKGROUND', 1.1, 1.1);

	makeLuaSprite('FOREGROUND', 'bgs/HanzouStage/FOREGROUND', -1000, -325);

	makeLuaSprite('rubble', 'bgs/HanzouStage/front rubble', -450, 650);

	makeLuaSprite('lamp', 'bgs/HanzouStage/lamp', 900, -200);

	makeLuaSprite('lampoverlay', 'bgs/HanzouStage/lampoverlay', -25, -100);
	setProperty('lampoverlay.alpha', 0.1)
	setBlendMode('lampoverlay', 'add')

	setProperty('gf.alpha', 0)

	addLuaSprite('BACKGROUND', false);
	addLuaSprite('FOREGROUND', false);
	addLuaSprite('lampoverlay', true);
	addLuaSprite('lamp', true);
	addLuaSprite('rubble', true);


	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end