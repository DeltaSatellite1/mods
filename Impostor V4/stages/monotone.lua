function onCreate()
    setProperty('camHUD.alpha', 0);
    createLevel()
end
function createLevel()
    makeLuaSprite('monotoneBG','skeld/SkeldBack',-880,-550)
    scaleObject('monotoneBG',1.9,1.9)
    addLuaSprite('monotoneBG',false)

    makeLuaSprite('monotoneBackThings','skeld/BackThings',-880,-550)
    scaleObject('monotoneBackThings',1.9,1.9)
    addLuaSprite('monotoneBackThings',false)

    makeLuaSprite('monotoneFloor','skeld/Floor',-880,-550)
    scaleObject('monotoneFloor',1.9,1.9)
    addLuaSprite('monotoneFloor',false)

    makeLuaSprite('monotoneReactor','skeld/Reactor',-880,-550)
    addLuaSprite('monotoneReactor',false)
    scaleObject('monotoneReactor',1.9,1.9)

    makeLuaSprite('monotoneVignette','skeld/overlay',-880,-550)
    scaleObject('monotoneVignette',1.9,1.9)
    setProperty('monotoneVignette.alpha',0.8)
    addLuaSprite('monotoneVignette',true)

    makeLuaSprite('monotoneReactorLight','skeld/Reactorlight',-880,-550)
    scaleObject('monotoneReactorLight',1.9,1.9)
    addLuaSprite('monotoneReactorLight',false)
    setBlendMode('monotoneReactorLight','add')

    makeLuaSprite('monotoneBorders','skeld/bars',0,0)
    setObjectCamera('monotoneBorders','hud')
    addLuaSprite('monotoneBorders',false)

    makeLuaSprite('monotoneLight','skeld/overlay2',-880,-550)
    scaleObject('monotoneLight',1.9,1.9)
    setProperty('monotoneLight.color',getColorFromHex('FFFFFF'))
    addLuaSprite('monotoneLight',true)
end
function onEvent(name,v1)
    if name == "Identity Crisis Events" then
        if v1 == '0' then
            createLevel()
        else
            if v1 == '1' then
                createLevel()
            end
            if v1 ~= '1' then
                removeLuaSprite('monotoneFloor',true)
                removeLuaSprite('monotoneBG',true)
            end
            if v1 == '1' or v1 == '2' then
                setProperty('monotoneLight.color',getColorFromHex('FF4C4C'))
            elseif v1 == '3' then
                setProperty('monotoneLight.color',getColorFromHex('FFFFFF'))
            end
            removeLuaSprite('monotoneBackThings',true)
            removeLuaSprite('monotoneReactorLight',true)
            removeLuaSprite('monotoneReactor',true)
        end
    end
end

