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

    makeLuaSprite('finaleBorders','skeld/bars',0,0)
    setObjectCamera('finaleBorders','hud')
    addLuaSprite('finaleBorders',false)
end
function onCreatePost()
    if songName == 'Finale' then
        if curBeat < 68 then
            finaleAlpha(0.001)
            makeAnimatedLuaSprite('defeatBG','defeat/defeat',-450,-150)
            setScrollFactor('defeatBG',0.8,0.8)
            scaleObject('defeatBG',1.3,1.3)
            addAnimationByPrefix('defeatBG','bg','defeat',24,false)
            addLuaSprite('defeatBG',false)
            
            makeLuaSprite('defeatLight','defeat/iluminao omaga',-650,0)
            scaleObject('defeatLight',1.2,1.2)
            setBlendMode('defeatLight','add')
            addLuaSprite('defeatLight',true)
        end
    end
end
function onBeatHit()
    if songName == 'Finale' and curBeat >= 68 then
        removeLuaSprite('defeatBG',true)
        removeLuaSprite('defeatLight',true)
        finaleAlpha(1)
        --close(false)
    end
end
function finaleAlpha(alpha)
    setProperty('bgg.alpha',alpha)
    setProperty('dead.alpha',alpha)
    setProperty('bg.alpha',alpha)
    setProperty('lamp.alpha',alpha)
    setProperty('fore.alpha',alpha)
    setProperty('splat.alpha',alpha)
    setProperty('dark.alpha',alpha)
    setProperty('light.alpha',alpha)
end