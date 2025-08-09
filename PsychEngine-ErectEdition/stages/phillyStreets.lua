
--How makeLuaSprite works:
--makeLuaSprite(<SPRITE VARIABLE>, <SPRITE IMAGE FILE NAME>, <X>, <Y>);
--"Sprite Variable" is how you refer to the sprite you just spawned in other methods like "setScrollFactor" and "scaleObject" for example

--so for example, i made the sprites "stagelight_left" and "stagelight_right", i can use "scaleObject('stagelight_left', 1.1, 1.1)"
--to adjust the scale of specifically the one stage light on left instead of both of them

function onCreate()
	-- background shit
	makeLuaSprite('phillySkybox', 'phillySkybox', -600, -200);
	setScrollFactor('phillySkybox', 1.0, 1.0);
	scaleObject('phillySkybox', 1.3, 1.3);

	makeLuaSprite('phillyForeground', 'phillyForeground', -400, -80);
	setScrollFactor('phillyForeground', 0.9, 0.9);

	makeLuaSprite('phillyHighway', 'phillyHighway', -500, -80);
	setScrollFactor('phillyHighway', 0.9, 0.9);


	-- sprites that only load if Low Quality is turned off
	if not lowQuality then

	end

	addLuaSprite('phillySkybox', false);
	addLuaSprite('phillyForeground', false);
	addLuaSprite('puddle', false);
end