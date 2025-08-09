function onCreate()
	
	-- Whitback
   	makeAnimatedLuaSprite('stage','Zardy2BG', -600, -200)
    	addAnimationByPrefix('stage', 'Maze', 'BG',24,true);
    	objectPlayAnimation('stage','Maze',true);

	addLuaSprite('stage', false);

	setProperty('gfGroup.alpha', 0)

end

function onGameOver()
	startVideo('zardyButDark')
end