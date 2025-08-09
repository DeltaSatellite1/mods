local enabled = false
function onCreatePost()
    makeLuaSprite('darkenDouble',nil,0,0)
    makeGraphic('darkenDouble',screenWidth,screenHeight,'000000')
    setScrollFactor('darkenDouble',0,0)
    setProperty('darkenDouble.alpha',0)
    precacheImage('airship/airshipFlashback')
    makeLuaSprite('airshipflash','airship/airshipFlashback',getProperty('boyfriendGroup.x') - 520,getProperty('boyfriendGroup.y') + 130)
    setProperty('airshipflash.alpha',0)
    scaleObject('airshipflash',1.2,1.2)
end
function onEvent(name,v1,v2)
    if name == 'Double Kill Events' then
        if v1 == "darken" then
            addLuaSprite('darkenDouble',false)
            enabled = true
            doTweenAlpha('darkenLight','darkenDouble',1,3,'linear')
            doTweenAlpha('dadAlpha','dad',0,3,'linear')
            doTweenAlpha('gfAlpha','gf',0,3,'linear')
        elseif v1 == 'airship' then
            addLuaSprite('airshipflash',false)
            doTweenAlpha('airship','airshipflash',0.2,8,'linear')
        elseif v1 == 'brighten' then
            enabled = false
            cancelTween('dadAlpha')
            cancelTween('gfAlpha')
            setProperty('dad.alpha',1)
            setProperty('gf.alpha',1)
            removeLuaSprite('airshipflash',true)
            removeLuaSprite('darkenDouble',true)
        end
    end
end
function onUpdate()
    if enabled then
        setProperty('darkenDouble.x',math.min(0,-100 * ((1 - getProperty('camGame.zoom')) * 10)))
        setProperty('darkenDouble.y',math.min(0,-100 * ((1 - getProperty('camGame.zoom')) * 10)))
        scaleObject('darkenDouble',math.max(1,1 + ((1 - getProperty('camGame.zoom'))*2)),math.max(1,1 + ((1 - getProperty('camGame.zoom'))*2)))
    end
end