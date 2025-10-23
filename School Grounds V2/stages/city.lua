function onCreate()
	-- background shit
	makeLuaSprite('BG1', 'bgs/whippy/BG1', -900, -400);
	setLuaSpriteScrollFactor('BG1', 0.9, 0.9);
	scaleObject('BG1', 1.3, 1.3);

	makeLuaSprite('BG2', 'bgs/whippy/BG2', -300, 300);
	setLuaSpriteScrollFactor('BG2', 1, 1);
	scaleObject('BG2', 1.3, 1.3);

	makeLuaSprite('BG3', 'bgs/whippy/BG3', -300, 300);
	setLuaSpriteScrollFactor('BG2', 0.9, 0.9);
	scaleObject('BG3', 1.1, 1.1);

	makeLuaSprite('BGschool', 'bgs/whippy/BGschool', 300, 150);
	setLuaSpriteScrollFactor('BG2', 0.9, 0.9);
	scaleObject('BGschool', 1.1, 1.1);

	makeLuaSprite('FG', 'bgs/whippy/FG', -1000, -350);
	setLuaSpriteScrollFactor('FG', 0.9, 0.9);
	scaleObject('FG', 1.4, 1.4);

	makeLuaSprite('SKY', 'bgs/whippy/SKY', -950, -500);
	setLuaSpriteScrollFactor('SKY', 0.9, 0.9);
	scaleObject('SKY', 1.7, 1.7);

	addLuaSprite('SKY', false);
	addLuaSprite('BGschool', false);
	addLuaSprite('BG3', false); 
	addLuaSprite('BG2', false);
	addLuaSprite('BG1', false);
	addLuaSprite('FG', false);
	
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage

	end