function onCreate()
    makeLuaSprite('overlay2', 'vignette', 0, 0);
    setScrollFactor('overlay2', 0, 0);
    addLuaSprite('overlay2', true);
    --scaleObject('overlay2', 1, 1)  
    setObjectCamera('overlay2', 'other');
	
	makeAnimatedLuaSprite('stains', 'stains', 0, 0);
    addAnimationByPrefix('stains', 'stains', 'stains', 14, true);  
    objectPlayAnimation('stains', 'stains', true)
    scaleObject('stains', 2.75, 2.75);
    addLuaSprite('stains', false);
    setObjectCamera('stains', 'other');

    if songName == 'crazy-racing' then
        setProperty('overlay2.visible', false);
        setProperty('stains.visible', false);
    end

    makeLuaSprite('logoDerpixon', 'UI/derpixon', 0, 0);
    setScrollFactor('logoDerpixon', 0, 0);
    addLuaSprite('logoDerpixon', true);
    scaleObject('logoDerpixon', 0.75, 0.75)  
    setProperty('logoDerpixon.alpha', 0.5);
    setObjectCamera('logoDerpixon', 'other');
    setProperty('logoDerpixon.x', screenWidth - getProperty('logoDerpixon.width') - 30);
    setProperty('logoDerpixon.y', screenHeight - getProperty('logoDerpixon.height') - 15);
end

function onUpdate()
	setProperty('camZooming', true);
end