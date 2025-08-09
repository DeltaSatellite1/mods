
function onCreate()

precacheImage('lights/white')
precacheImage('lights/red')
precacheImage('lights/green')
precacheImage('lights/blue')
precacheImage('lights/yellow')
precacheImage('lights/purple')
precacheImage('lights/pink')
precacheImage('lights/orange')
precacheImage('lights/cyan')

end



function onEvent(name,value1,value2)   --event by The RedBlack


 if name == 'Custom Lights' then

        if value2 == '1' then

	    makeLuaSprite('flash', 'lights/white', 0, 0);
	    addLuaSprite('flash', true);
	    setLuaSpriteScrollFactor('flash',0,0)
        setObjectCamera('flash', 'other')
	    setProperty('flash.scale.x',2)
	    setProperty('flash.scale.y',2)
	    setProperty('flash.alpha',0)
	    setProperty('flash.alpha',1)
	    doTweenAlpha('flTw1','flash',0,value1,'linear')
	   
	    elseif value2 == '2' then

	    makeLuaSprite('flash', 'lights/red', 0, 0);
	    addLuaSprite('flash', true);
	    setLuaSpriteScrollFactor('flash',0,0)
        setObjectCamera('flash', 'other')
	    setProperty('flash.scale.x',2)
	    setProperty('flash.scale.y',2)
	    setProperty('flash.alpha',0)
	    setProperty('flash.alpha',1)
	    doTweenAlpha('flTw1','flash',0,value1,'linear')
	   
	    elseif value2 == '3' then

	    makeLuaSprite('flash', 'lights/blue', 0, 0);
	    addLuaSprite('flash', true);
	    setLuaSpriteScrollFactor('flash',0,0)
        setObjectCamera('flash', 'other')
	    setProperty('flash.scale.x',2)
	    setProperty('flash.scale.y',2)
	    setProperty('flash.alpha',0)
	    setProperty('flash.alpha',1)
	    doTweenAlpha('flTw1','flash',0,value1,'linear')
	   
	    elseif value2 == '4' then

	    makeLuaSprite('flash', 'lights/green', 0, 0);
	    addLuaSprite('flash', true);
	    setLuaSpriteScrollFactor('flash',0,0)
        setObjectCamera('flash', 'other')
	    setProperty('flash.scale.x',2)
	    setProperty('flash.scale.y',2)
	    setProperty('flash.alpha',0)
	    setProperty('flash.alpha',1)
	    doTweenAlpha('flTw1','flash',0,value1,'linear')
	   
	    elseif value2 == '5' then

	    makeLuaSprite('flash', 'lights/yellow', 0, 0);
	    addLuaSprite('flash', true);
	    setLuaSpriteScrollFactor('flash',0,0)
        setObjectCamera('flash', 'other')
	    setProperty('flash.scale.x',2)
	    setProperty('flash.scale.y',2)
	    setProperty('flash.alpha',0)
	    setProperty('flash.alpha',1)
	    doTweenAlpha('flTw1','flash',0,value1,'linear')
	   
	    elseif value2 == '6' then

	    makeLuaSprite('flash', 'lights/black', 0, 0);
	    addLuaSprite('flash', true);
	    setLuaSpriteScrollFactor('flash',0,0)
        setObjectCamera('flash', 'other')
	    setProperty('flash.scale.x',2)
	    setProperty('flash.scale.y',2)
	    setProperty('flash.alpha',0)
	    setProperty('flash.alpha',1)
	    doTweenAlpha('flTw1','flash',0,value1,'linear')
	   
	    elseif value2 == '7' then

	    makeLuaSprite('flash', 'lights/purple', 0, 0);
	    addLuaSprite('flash', true);
	    setLuaSpriteScrollFactor('flash',0,0)
        setObjectCamera('flash', 'other')
	    setProperty('flash.scale.x',2)
	    setProperty('flash.scale.y',2)
	    setProperty('flash.alpha',0)
	    setProperty('flash.alpha',1)
	    doTweenAlpha('flTw1','flash',0,value1,'linear')
	   
	    elseif value2 == '8' then

	    makeLuaSprite('flash', 'lights/pink', 0, 0);
	    addLuaSprite('flash', true);
	    setLuaSpriteScrollFactor('flash',0,0)
        setObjectCamera('flash', 'other')
	    setProperty('flash.scale.x',2)
	    setProperty('flash.scale.y',2)
	    setProperty('flash.alpha',0)
	    setProperty('flash.alpha',1)
	    doTweenAlpha('flTw1','flash',0,value1,'linear')
	   
	    elseif value2 == '9' then

	    makeLuaSprite('flash', 'lights/orange', 0, 0);
	    addLuaSprite('flash', true);
	    setLuaSpriteScrollFactor('flash',0,0)
        setObjectCamera('flash', 'other')
	    setProperty('flash.scale.x',2)
	    setProperty('flash.scale.y',2)
	    setProperty('flash.alpha',0)
	    setProperty('flash.alpha',1)
	    doTweenAlpha('flTw1','flash',0,value1,'linear')
	   
	    elseif value2 == '10' then
 
	    makeLuaSprite('flash', 'lights/cyan', 0, 0);
	    addLuaSprite('flash', true);
	    setLuaSpriteScrollFactor('flash',0,0)
        setObjectCamera('flash', 'other')
	    setProperty('flash.scale.x',2)
	    setProperty('flash.scale.y',2)
	    setProperty('flash.alpha',0)
	    setProperty('flash.alpha',1)
	    doTweenAlpha('flTw1','flash',0,value1,'linear')
 end
     end
	     end