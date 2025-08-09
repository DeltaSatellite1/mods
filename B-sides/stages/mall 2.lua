function onCreate()
	-- background 
	makeLuaSprite('bgWalls2', 'bgWalls2', -1300, -700);
	setLuaSpriteScrollFactor('bgWalls2', 0.2, 0.2);

    makeAnimatedLuaSprite('P', 'mall2/P', -300, 140) 
	setLuaSpriteScrollFactor('P',0.9, 0.9);
	
	makeAnimatedLuaSprite('up', 'mall2/up', -370, -120) 
	setLuaSpriteScrollFactor('up',0.33, 0.33);
	
	makeAnimatedLuaSprite('santa2', 'mall2/santa2', -800, 100) 
	setLuaSpriteScrollFactor('santa2', 1, 1);

	makeLuaSprite('christmasTree2', 'christmasTree2', 390, -250);
	setLuaSpriteScrollFactor('christmasTree2', 0.40, 0.40);

	makeLuaSprite('fgSnow2', 'fgSnow2', -730, 695);



	-- sprites that only load if Low Quality is turned off
	if not lowQuality then

	makeLuaSprite('bgEscalator2', 'bgEscalator2',  -1300, -670);
	setLuaSpriteScrollFactor('bgEscalator2', 0.3, 0.3);
		
	end

	addLuaSprite('bgWalls2', false);
	addLuaSprite('up', false)
	addAnimationByPrefix('up','Move', 'Upper Crowd Bob Idle', 24, true);
    addLuaSprite('bgEscalator2', false);
	addLuaSprite('christmasTree2', false);
    addLuaSprite('fgSnow2', false);
    addLuaSprite('P', false); --Added offscreen before it starts moving.
	addAnimationByPrefix('P', 'Move', 'Bottom Level Boppers Idle', 30, true);
	addAnimationByPrefix('P','Hey', 'Bottom Level Boppers HEY!!', 24, true);
	addLuaSprite('santa2', false); --Added offscreen before it starts moving.
	addAnimationByPrefix('santa2', 'Move', 'santa idle in fear', 30, true);

	
	 
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end