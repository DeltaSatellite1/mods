function onCreate()
	
	-- Zarback
   	makeAnimatedLuaSprite('stage','Maze', -600, -200)
    	addAnimationByPrefix('stage', 'Maze', 'Stage',24,true);
		addAnimationByPrefix('stage', 'MazeSlow', 'Stage',20,true);
    	objectPlayAnimation('stage','Maze',true);

	addLuaSprite('stage', false);

	-- setProperty('gfGroup.alpha', 0)

end

function onGameOver()
	startVideo('zardyButDark')
end

function onStepHit()
	if curStep == 26 then
		objectPlayAnimation('stage', 'MazeSlow')
	end
end