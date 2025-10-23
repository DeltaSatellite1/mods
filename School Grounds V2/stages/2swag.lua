function onCreate()
	-- background shit
	makeAnimatedLuaSprite('bf', 'bgs/2swag/bf', 500, 600);
	setLuaSpriteScrollFactor('bf', 0.9, 0.9);
	scaleObject('bf', 1.3, 1.3);

	makeAnimatedLuaSprite('people', 'bgs/2swag/people', -100, 600);
	setLuaSpriteScrollFactor('people', 0.9, 0.9);
	scaleObject('people', 1.3, 1.3);

	makeLuaSprite('bgg', 'bgs/2swag/bgg', -300, -250);
	setLuaSpriteScrollFactor('bgg', 0.9, 0.9);
	scaleObject('bgg', 1.1, 1.1);

	makeLuaSprite('overlay', 'bgs/2swag/overlay', 300, 150);
	setLuaSpriteScrollFactor('overlay', 0.9, 0.9);
	scaleObject('overlay', 1.1, 1.1);

	makeLuaSprite('bg', 'bgs/2swag/bg', -1550, -250);
	setLuaSpriteScrollFactor('bg', 0.9, 0.9);
	scaleObject('bg', 1.1, 1.1);

	makeLuaSprite('table', 'bgs/2swag/table', -100, 800);
	setLuaSpriteScrollFactor('table', 0.9, 0.9);
	scaleObject('table', 1.2, 1.2);

	addLuaSprite('bgg', false);
	addLuaSprite('overlay', false);
	addLuaSprite('bg', false); 
	addLuaSprite('bf', false);
	addAnimationByPrefix('bf', 'idle', 'bf0', '24',true);
	addLuaSprite('people', false);
	addAnimationByPrefix('people', 'idle','people0', '24',true);
	addLuaSprite('table', false);

	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage

	end