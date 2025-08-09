function onCreate()
	makeLuaSprite('bgg', 'finale/bgg', -600, -400);
	setScrollFactor('bgg', 0.8, 0.8);
	makeLuaSprite('dead', 'finale/dead', 800, -270);
	setScrollFactor('dead', 0.8, 0.8);
	makeLuaSprite('bg', 'finale/bg', -790, -530);
	setScrollFactor('bg', 1, 1);
	makeLuaSprite('splat', 'finale/splat', 370, 1200);
	makeLuaSprite('fore', 'finale/fore', -750, 160);
    setScrollFactor('fore', 1.1, 1.1);
  
	makeLuaSprite('dark', 'finale/dark', -720, -350);
	setScrollFactor('dark', 1.05, 1.05);

	makeLuaSprite('lamp', 'finale/lamp', 1190, -280);
	makeAnimatedLuaSprite('light', 'finale/light', -230, -100);
	setScrollFactor('light', 1.05, 1.05);
    addAnimationByPrefix('light','light','light',24,true);
	setBlendMode('light','add')
	setBlendMode('dark','multiply')

	addLuaSprite('bgg', false);
	addLuaSprite('dead', false);
	addLuaSprite('bg', false)
	addLuaSprite('splat', true)
	addLuaSprite('lamp', false);
	addLuaSprite('fore', true);
	addLuaSprite('dark', true);
	addLuaSprite('light', true)

	scaleLuaSprite('bgg', 1.1, 1.1)
	scaleLuaSprite('dead', 1.1, 1.1)
	scaleLuaSprite('bg', 1.1, 1.1)
	scaleLuaSprite('lamp', 1.1, 1.1)
	scaleLuaSprite('fore', 1.1, 1.1)
    scaleLuaSprite('splat', 1.1, 1.1)
	scaleLuaSprite('dark', 1.1, 1.1)
	scaleLuaSprite('light', 1.1, 1.1)
end

function onBeatHit()
    if (curBeat % 4 == 0) then
	    objectPlayAnimation('light','light',true)
    end
end