function onEvent(name,value1,value2)


 if name == 'Flash Camera' then
	
	if value2 == '1' then

	   makeLuaSprite('flash', '', 0, 0);
       makeGraphic('flash',1820,1100,'ffffff')
	   addLuaSprite('flash', true);
	   setLuaSpriteScrollFactor('flash',0,0)
       setProperty('flash.scale.x',2)
       setProperty('flash.scale.y',2)
       setProperty('flash.alpha',0)
       setProperty('flash.alpha',1)
	   doTweenAlpha('flTw','flash',0,value1,'linear')
	   
	elseif value2 == '2' then
	
	   makeLuaSprite('flash', '', 0, 0);
       makeGraphic('flash',1280,750,'ff0000')
	   addLuaSprite('flash', true);
	   setLuaSpriteScrollFactor('flash',0,0)
       setProperty('flash.scale.x',2)
       setProperty('flash.scale.y',2)
       setProperty('flash.alpha',0)
       setProperty('flash.alpha',1)
	   doTweenAlpha('flTw','flash',0,value1,'linear')
	
    elseif value2 == '3' then
	
	   makeLuaSprite('flash', '', 0, 0);
       makeGraphic('flash',1280,750,'1200ff')
	   addLuaSprite('flash', true);
	   setLuaSpriteScrollFactor('flash',0,0)
       setProperty('flash.scale.x',2)
       setProperty('flash.scale.y',2)
       setProperty('flash.alpha',0)
       setProperty('flash.alpha',1)
	   doTweenAlpha('flTw','flash',0,value1,'linear')
	   
    elseif value2 == '4' then
	
	   makeLuaSprite('flash', '', 0, 0);
       makeGraphic('flash',1280,750,'06ff00')
	   addLuaSprite('flash', true);
	   setLuaSpriteScrollFactor('flash',0,0)
       setProperty('flash.scale.x',2)
       setProperty('flash.scale.y',2)
       setProperty('flash.alpha',0)
       setProperty('flash.alpha',1)
	   doTweenAlpha('flTw','flash',0,value1,'linear')
	   
	elseif value2 == '5' then
	
	   makeLuaSprite('flash', '', 0, 0);
       makeGraphic('flash',1280,750,'fcff00')
	   addLuaSprite('flash', true);
	   setLuaSpriteScrollFactor('flash',0,0)
       setProperty('flash.scale.x',2)
       setProperty('flash.scale.y',2)
       setProperty('flash.alpha',0)
       setProperty('flash.alpha',1)
	   doTweenAlpha('flTw','flash',0,value1,'linear')
	   
	elseif value2 == '6' then
	
	   makeLuaSprite('flash', '', 0, 0);
       makeGraphic('flash',1280,750,'000000')
	   addLuaSprite('flash', true);
	   setLuaSpriteScrollFactor('flash',0,0)
       setProperty('flash.scale.x',2)
       setProperty('flash.scale.y',2)
       setProperty('flash.alpha',0)
       setProperty('flash.alpha',1)
	   doTweenAlpha('flTw','flash',0,value1,'linear')
	   
	elseif value2 == '7' then
	
	   makeLuaSprite('flash', '', 0, 0);
       makeGraphic('flash',1280,750,'9c00ff')
	   addLuaSprite('flash', true);
	   setLuaSpriteScrollFactor('flash',0,0)
       setProperty('flash.scale.x',2)
       setProperty('flash.scale.y',2)
       setProperty('flash.alpha',0)
       setProperty('flash.alpha',1)
	   doTweenAlpha('flTw','flash',0,value1,'linear')
	   
	elseif value2 == '8' then
	
	   makeLuaSprite('flash', '', 0, 0);
       makeGraphic('flash',1280,750,'ff00a2')
	   addLuaSprite('flash', true);
	   setLuaSpriteScrollFactor('flash',0,0)
       setProperty('flash.scale.x',2)
       setProperty('flash.scale.y',2)
       setProperty('flash.alpha',0)
       setProperty('flash.alpha',1)
	   doTweenAlpha('flTw','flash',0,value1,'linear')
	   
    elseif value2 == '9' then
	
	   makeLuaSprite('flash', '', 0, 0);
       makeGraphic('flash',1280,750,'ff9000')
	   addLuaSprite('flash', true);
	   setLuaSpriteScrollFactor('flash',0,0)
       setProperty('flash.scale.x',2)
       setProperty('flash.scale.y',2)
       setProperty('flash.alpha',0)
       setProperty('flash.alpha',1)
	   doTweenAlpha('flTw','flash',0,value1,'linear')
	   
	elseif value2 == '10' then
	
	   makeLuaSprite('flash', '', 0, 0);
       makeGraphic('flash',1280,750,'00ffea')
	   addLuaSprite('flash', true);
	   setLuaSpriteScrollFactor('flash',0,0)
       setProperty('flash.scale.x',2)
       setProperty('flash.scale.y',2)
       setProperty('flash.alpha',0)
       setProperty('flash.alpha',1)
	   doTweenAlpha('flTw','flash',0,value1,'linear')
 end
     end
	     end