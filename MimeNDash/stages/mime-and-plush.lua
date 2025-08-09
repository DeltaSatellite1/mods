function onCreate()
    makeLuaSprite('bg','stages/mime-and-plush/bg',-400,-550)
	setScrollFactor('bg',1,1)
    scaleObject('bg',1,1)
    addLuaSprite('bg')
	
	makeAnimatedLuaSprite('bonbon', 'stages/mime-and-plush/bonbon', -460, -150);
    addLuaSprite('bonbon', false);
    addAnimationByPrefix('bonbon', 'idle', 'idle', 24, true);	
	addAnimationByPrefix('bonbon', 'idle-shift', 'shift', 24, true);	
	addAnimationByPrefix('bonbon', 'trans-to-shift', 'trans-shift', 24, false);	
	addAnimationByPrefix('bonbon', 'trans-to-idle', 'transition-idle', 24, false);	
	playAnim('bonbon', 'idle', true);
	scaleObject('bonbon',1.6,1.6)
	setProperty('bonbon.visible', true);
	--setObjectOrder('bonbon', 1);
	
	makeAnimatedLuaSprite('chuchu', 'stages/mime-and-plush/chuchu', 1220, -150);
    addLuaSprite('chuchu', false);
    addAnimationByPrefix('chuchu', 'idle', 'idle', 24, true);	
	addAnimationByPrefix('chuchu', 'idle-shift', 'shift', 24, true);	
	addAnimationByPrefix('chuchu', 'trans-to-shift', 'trans-shift', 24, false);	
	addAnimationByPrefix('chuchu', 'trans-to-idle', 'transition-idle', 24, false);	
	playAnim('chuchu', 'idle', true);
	scaleObject('chuchu',1.6,1.6)
	setProperty('chuchu.visible', true);
	--setObjectOrder('chuchu', 1);
end

function onCreatePost()
	setProperty('camZooming', true);
end