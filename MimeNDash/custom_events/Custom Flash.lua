function onEvent(name,value1,value2)


 if name == 'Custom Flash' then

        if value2 == '1' then

	   makeLuaSprite('flash', '', 0, 0);
        makeGraphic('flash',1280,720,'ffffff')
	      addLuaSprite('flash', true);
	      setLuaSpriteScrollFactor('flash',0,0)
              setObjectCamera('flash', 'other')
	      setProperty('flash.scale.x',2)
	      setProperty('flash.scale.y',2)
	      setProperty('flash.alpha',0)
		setProperty('flash.alpha',1)
		doTweenAlpha('flTw1','flash',0,value1,'linear')

        elseif value2 == '2' then

	   makeLuaSprite('flash1', '', 0, 0);
        makeGraphic('flash1',1280,720,'ff0000')
	      addLuaSprite('flash1', true);
	      setLuaSpriteScrollFactor('flash1',0,0)
              setObjectCamera('flash1', 'other')
	      setProperty('flash1.scale.x',2)
	      setProperty('flash1.scale.y',2)
	      setProperty('flash1.alpha',0)
		setProperty('flash1.alpha',1)
		doTweenAlpha('flTw2','flash1',0,value1,'linear')

        elseif value2 == '3' then
        
        makeLuaSprite('flash2', '', 0, 0);
        makeGraphic('flash2',1280,720,'0006ff')
	      addLuaSprite('flash2', true);
	      setLuaSpriteScrollFactor('flash2',0,0)
              setObjectCamera('flash2', 'other')
	      setProperty('flash2.scale.x',2)
	      setProperty('flash2.scale.y',2)
	      setProperty('flash2.alpha',0)
		setProperty('flash2.alpha',1)
		doTweenAlpha('flTw3','flash2',0,value1,'linear')

       elseif value2 == '4' then

       makeLuaSprite('flash3', '', 0, 0);
        makeGraphic('flash3',1280,720,'00ee16')
	      addLuaSprite('flash3', true);
	      setLuaSpriteScrollFactor('flash3',0,0)
              setObjectCamera('flash3', 'other')
	      setProperty('flash3.scale.x',2)
	      setProperty('flash3.scale.y',2)
	      setProperty('flash3.alpha',0)
		setProperty('flash3.alpha',1)
		doTweenAlpha('flTw4','flash3',0,value1,'linear')

       elseif value2 == '5' then

       makeLuaSprite('flash3', '', 0, 0);
        makeGraphic('flash3',1280,720,'eaff00')
	      addLuaSprite('flash3', true);
	      setLuaSpriteScrollFactor('flash3',0,0)
              setObjectCamera('flash3', 'other')
	      setProperty('flash3.scale.x',2)
	      setProperty('flash3.scale.y',2)
	      setProperty('flash3.alpha',0)
		setProperty('flash3.alpha',1)
		doTweenAlpha('flTw4','flash3',0,value1,'linear')

       elseif value2 == '6' then

       makeLuaSprite('flash3', '', 0, 0);
        makeGraphic('flash3',1280,720,'000000')
	      addLuaSprite('flash3', true);
	      setLuaSpriteScrollFactor('flash3',0,0)
              setObjectCamera('flash3', 'other')
	      setProperty('flash3.scale.x',2)
	      setProperty('flash3.scale.y',2)
	      setProperty('flash3.alpha',0)
		setProperty('flash3.alpha',1)
		doTweenAlpha('flTw4','flash3',0,value1,'linear')

        elseif value2 == '7' then

       makeLuaSprite('flash3', '', 0, 0);
        makeGraphic('flash3',1280,720,'9600ff')
	      addLuaSprite('flash3', true);
	      setLuaSpriteScrollFactor('flash3',0,0)
              setObjectCamera('flash3', 'other')
	      setProperty('flash3.scale.x',2)
	      setProperty('flash3.scale.y',2)
	      setProperty('flash3.alpha',0)
		setProperty('flash3.alpha',1)
		doTweenAlpha('flTw4','flash3',0,value1,'linear')

        elseif value2 == '8' then

       makeLuaSprite('flash3', '', 0, 0);
        makeGraphic('flash3',1280,720,'ff50f1')
	      addLuaSprite('flash3', true);
	      setLuaSpriteScrollFactor('flash3',0,0)
              setObjectCamera('flash3', 'other')
	      setProperty('flash3.scale.x',2)
	      setProperty('flash3.scale.y',2)
	      setProperty('flash3.alpha',0)
		setProperty('flash3.alpha',1)
		doTweenAlpha('flTw4','flash3',0,value1,'linear')

        elseif value2 == '9' then

       makeLuaSprite('flash3', '', 0, 0);
        makeGraphic('flash3',1280,720,'ff9600')
	      addLuaSprite('flash3', true);
	      setLuaSpriteScrollFactor('flash3',0,0)
              setObjectCamera('flash3', 'other')
	      setProperty('flash3.scale.x',2)
	      setProperty('flash3.scale.y',2)
	      setProperty('flash3.alpha',0)
		setProperty('flash3.alpha',1)
		doTweenAlpha('flTw4','flash3',0,value1,'linear')

        elseif value2 == '10' then

       makeLuaSprite('flash3', '', 0, 0);
        makeGraphic('flash3',1280,720,'00fff0')
	      addLuaSprite('flash3', true);
	      setLuaSpriteScrollFactor('flash3',0,0)
              setObjectCamera('flash3', 'other')
	      setProperty('flash3.scale.x',2)
	      setProperty('flash3.scale.y',2)
	      setProperty('flash3.alpha',0)
		setProperty('flash3.alpha',1)
		doTweenAlpha('flTw4','flash3',0,value1,'linear')

        elseif value2 == '11' then

       makeLuaSprite('flash3', '', 0, 0);
        makeGraphic('flash3',1280,720,'42ff00')
	      addLuaSprite('flash3', true);
	      setLuaSpriteScrollFactor('flash3',0,0)
              setObjectCamera('flash3', 'other')
	      setProperty('flash3.scale.x',2)
	      setProperty('flash3.scale.y',2)
	      setProperty('flash3.alpha',0)
		setProperty('flash3.alpha',1)
		doTweenAlpha('flTw4','flash3',0,value1,'linear')

        elseif value2 == '12' then

       makeLuaSprite('flash3', '', 0, 0);
        makeGraphic('flash3',1280,720,'994040')
	      addLuaSprite('flash3', true);
	      setLuaSpriteScrollFactor('flash3',0,0)
              setObjectCamera('flash3', 'other')
	      setProperty('flash3.scale.x',2)
	      setProperty('flash3.scale.y',2)
	      setProperty('flash3.alpha',0)
		setProperty('flash3.alpha',1)
		doTweenAlpha('flTw4','flash3',0,value1,'linear')

        elseif value2 == '13' then

       makeLuaSprite('flash3', '', 0, 0);
        makeGraphic('flash3',1280,720,'7b7b7b')
	      addLuaSprite('flash3', true);
	      setLuaSpriteScrollFactor('flash3',0,0)
              setObjectCamera('flash3', 'other')
	      setProperty('flash3.scale.x',2)
	      setProperty('flash3.scale.y',2)
	      setProperty('flash3.alpha',0)
		setProperty('flash3.alpha',1)
		doTweenAlpha('flTw4','flash3',0,value1,'linear')

        elseif value2 == '14' then

       makeLuaSprite('flash3', '', 0, 0);
        makeGraphic('flash3',1280,720,'880909')
	      addLuaSprite('flash3', true);
	      setLuaSpriteScrollFactor('flash3',0,0)
              setObjectCamera('flash3', 'other')
	      setProperty('flash3.scale.x',2)
	      setProperty('flash3.scale.y',2)
	      setProperty('flash3.alpha',0)
		setProperty('flash3.alpha',1)
		doTweenAlpha('flTw4','flash3',0,value1,'linear')

        elseif value2 == '15' then

       makeLuaSprite('flash3', '', 0, 0);
        makeGraphic('flash3',1280,720,'ff0096')
	      addLuaSprite('flash3', true);
	      setLuaSpriteScrollFactor('flash3',0,0)
              setObjectCamera('flash3', 'other')
	      setProperty('flash3.scale.x',2)
	      setProperty('flash3.scale.y',2)
	      setProperty('flash3.alpha',0)
		setProperty('flash3.alpha',1)
		doTweenAlpha('flTw4','flash3',0,value1,'linear')

 end
    end
       end