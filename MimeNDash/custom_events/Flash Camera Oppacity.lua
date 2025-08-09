function onEvent(n,v1,v2)


	if n == 'Flash Camera Oppacity' then
		if v2 == '' then
			alflash = 0.6
		else
			alflash = v2
		end


		makeLuaSprite('flash', '', 0, 0);
    	makeGraphic('flash',1280,720,'ffffff')
		addLuaSprite('flash', true);
		setLuaSpriteScrollFactor('flash',0,0)
		setProperty('flash.scale.x',2)
		setProperty('flash.scale.y',2)
    	setObjectCamera('flash','hud')
		setProperty('flash.alpha',alflash)
    	setBlendMode('flash', 'add')
		doTweenAlpha('flTw','flash',0,v1,'linear')
	end



end