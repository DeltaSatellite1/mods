local bubblesLength = 20
function onCreate()
    makeAnimatedLuaSprite('polusBG','polus/wallBP',-600,-800)
    scaleObject('polusBG',1.1,1.1)
    addAnimationByPrefix('polusBG','fire','Back wall and lava',38,true)
    addLuaSprite('polusBG',false)

    makeAnimatedLuaSprite('polusFireBuble','polus/bubbles',800,850)
    scaleObject('polusFireBuble',1.1,1.1)
    addAnimationByPrefix('polusFireBuble','fire','Lava Bubbles',24,true)
    addLuaSprite('polusFireBuble',false)

    makeLuaSprite('polusFloor','polus/platform',1050,650)
    addLuaSprite('polusFloor',false)

    if not lowQuality then
        for bubbles = 1,bubblesLength do
            local name = 'emberLava'..bubbles
            makeAnimatedLuaSprite(name,'polus/ember',0,0)
            scaleObject(name,0.5,0.5)
            setBlendMode(name,'add')
            addAnimationByPrefix(name,'bubble','ember',24,true)
            addLuaSprite(name,true)
            if bubbles >= bubblesLength + 5 then
                setObjectOrder(name,getObjectOrder('polusFloor') - 1)
            end
            setBubbles(bubbles)
        end
    end

    makeLuaSprite('polusLight','polus/LAVA OVERLAY IN GAME',550,-350)
    scaleObject('polusLight',1.25,1.2)
    --setProperty('polusLight.alpha',0.9)
    setBlendMode('polusLight','add')
    addLuaSprite('polusLight',true)
end
function onUpdate()
    for bubbles = 1,bubblesLength do
        local name ='emberLava'..bubbles
        if getProperty(name..'.y') <= -700 then
            setBubbles(bubbles)
        end
    end
end
function setBubbles(id)
    local name = 'emberLava'..id
    cancelTween('emberLavaXLeft'..id)
    cancelTween('emberLavaXRight'..id)
    setProperty(name..'.x',700 + (100 * id) + math.random(-200,200))
    setProperty(name..'.y',math.random(1100,1700))
    doTweenX('emberLavaXLeft'..id,name,getProperty(name..'.x') - 20,1,'sineInOut')
    doTweenY('emberLavaY'..id,name,-700,math.random(6,10),'linear')
end
function onTweenCompleted(tag)
    if string.find(tag,'emberLava') ~= nil then
        for bubbles = 1,bubblesLength do
            if tag == 'emberLavaXLeft'..bubbles then
                doTweenX('emberLavaXRight'..bubbles,'emberLava'..bubbles,getProperty('emberLava'..bubbles..'.x') + 20,0.8,'sineInOut')
            elseif tag == 'emberLavaXRight'..bubbles then
                doTweenX('emberLavaXRight'..bubbles,'emberLava'..bubbles,getProperty('emberLava'..bubbles..'.x') - 20,0.8,'sineInOut')
            end
        end
    end
end
 
