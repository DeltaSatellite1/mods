function onCreate()

afterImage()
precacheImage(char..'.imageFile')

end


function getIconColor(chr)

return getColorFromHex(rgbToHex(getProperty(chr .. ".healthColorArray")))

end


function rgbToHex(array)

return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])

end




function rgbToHexM(R,G,B)

    return string.format('%.2x%.2x%.2x', R, G, B)
    
end

function getColorM(R,G,B)

    return getColorFromHex(rgbToHexM(R,G,B))
    
    end



function goodNoteHit(id, direction, noteType, isSustainNote)

if _G['boyfriendGhostData.strumTime'] == getPropertyFromGroup('notes', id, 'strumTime') and not isSustainNote then
createGhost('boyfriend')
end

if not isSustainNote then
_G['boyfriendGhostData.strumTime'] = getPropertyFromGroup('notes', id, 'strumTime')
updateGData('boyfriend')
end

end


function opponentNoteHit(id, direction, noteType, isSustainNote)

    if _G['dadGhostData.strumTime'] == getPropertyFromGroup('notes', id, 'strumTime') and not isSustainNote then

        createGhost('dad')

    end

    if not isSustainNote then

        _G['dadGhostData.strumTime'] = getPropertyFromGroup('notes', id, 'strumTime')

        updateGData('dad')

    end

end

-- MY TESTS
-- Constant after image
function afterImage()
    runTimer('shadow', 0.1, 0)
    
end
function onTimerCompleted(shadow)
    updateGData('boyfriend')
    createGhost('boyfriend')
    updateGData('dad')
    createGhost('dad')
end

-- function goodNoteHit(id, direction, noteType, isSustainNote)
-- 	-- key can be: 0 - left, 1 - down, 2 - up, 3 - right
--     if direction == 0 then
--         updateGData('boyfriend')
--         createDGhost('boyfriend', 0)
--     end
--     if direction == 1 then
--         updateGData('boyfriend')
--         createDGhost('boyfriend', 1)
--     end
--     if direction == 2 then
--         updateGData('boyfriend')
--         createDGhost('boyfriend', 2)
--     end
--     if direction == 3 then
--         updateGData('boyfriend')
--         createDGhost('boyfriend', 3)
--     end
-- end

-- function opponentNoteHit(id, direction, noteType, isSustainNote)
-- 	-- key can be: 0 - left, 1 - down, 2 - up, 3 - right
--     if direction == 0 then
--         updateGData('dad')
--         createDGhost('dad', 0)
--     end
--     if direction == 1 then
--         updateGData('dad')
--         createDGhost('dad', 1)
--     end
--     if direction == 2 then
--         updateGData('dad')
--         createDGhost('dad', 2)
--     end
--     if direction == 3 then
--         updateGData('dad')
--         createDGhost('dad', 3)
--     end
-- end


-- END OF MY STUFF


function createGhost(char)

songPos = getSongPosition() --in case game stutters

makeAnimatedLuaSprite(char..'Ghost'..songPos, getProperty(char..'.imageFile'),getProperty(char..'.x'),getProperty(char..'.y'))

addLuaSprite(char..'Ghost'..songPos, false)

setProperty(char..'Ghost'..songPos..'.scale.x',getProperty(char..'.scale.x'))

setProperty(char..'Ghost'..songPos..'.scale.y',getProperty(char..'.scale.y'))

setProperty(char..'Ghost'..songPos..'.flipX', getProperty(char..'.flipX'))

--setProperty(char..'Ghost'..songPos..'.color', getIconColor(char))

setProperty(char..'Ghost'..songPos..'.alpha', 0.3)

doTweenAlpha(char..'Ghost'..songPos..'delete', char..'Ghost'..songPos, 0, 0.3)

setProperty(char..'Ghost'..songPos..'.animation.frameName', _G[char..'GhostData.frameName'])

setProperty(char..'Ghost'..songPos..'.offset.x', _G[char..'GhostData.offsetX'])

setProperty(char..'Ghost'..songPos..'.offset.y', _G[char..'GhostData.offsetY'])

setObjectOrder(char..'Ghost'..songPos, getObjectOrder(char..'Group')-1)

end

function createDGhost(char, key)

    


    songPos = getSongPosition() --in case game stutters
    
    makeAnimatedLuaSprite(char..'Ghost'..songPos, getProperty(char..'.imageFile'),getProperty(char..'.x'),getProperty(char..'.y'))
    
    addLuaSprite(char..'Ghost'..songPos, false)
    
    setProperty(char..'Ghost'..songPos..'.animation.frameName', _G[char..'GhostData.frameName'])
    
    setProperty(char..'Ghost'..songPos..'.offset.x', _G[char..'GhostData.offsetX'])
    
    setProperty(char..'Ghost'..songPos..'.offset.y', _G[char..'GhostData.offsetY'])
    
    setProperty(char..'Ghost'..songPos..'.scale.x',getProperty(char..'.scale.x'))
    
    setProperty(char..'Ghost'..songPos..'.scale.y',getProperty(char..'.scale.y'))
    
    setProperty(char..'Ghost'..songPos..'.flipX', getProperty(char..'.flipX'))
    
    
    
    setProperty(char..'Ghost'..songPos..'.alpha', 0.7)
    
    doTweenAlpha(char..'Ghost'..songPos..'delete', char..'Ghost'..songPos, 0, 0.3)
    
    setObjectOrder(char..'Ghost'..songPos, getObjectOrder(char..'Group')-1)
    
    
    if key == 0 then
        doTweenX(char..'Ghost'..songPos..'move.x', char..'Ghost'..songPos,getProperty(char..'.offset.x')+(-1000),1,'quadOut')
        setProperty(char..'Ghost'..songPos..'.color', getColorM(255,0,0))
    end

    if key == 1 then
        doTweenY(char..'Ghost'..songPos..'move.y', char..'Ghost'..songPos,getProperty(char..'.offset.y')+(1000),1,'quadOut')    
        setProperty(char..'Ghost'..songPos..'.color', getColorM(0,0,255))
    end

    if key == 2 then
        doTweenY(char..'Ghost'..songPos..'move.y', char..'Ghost'..songPos,getProperty(char..'.offset.y')+(-1000),1,'quadOut')    
        setProperty(char..'Ghost'..songPos..'.color', getColorM(0,255,0))
    end

    if key == 3 then
        doTweenX(char..'Ghost'..songPos..'move.x', char..'Ghost'..songPos,getProperty(char..'.offset.x')+(1000),1,'quadOut')
        setProperty(char..'Ghost'..songPos..'.color', getColorM(255,255,0))
    end
end


function onTweenCompleted(tag)

    if (tag:sub(#tag- 5, #tag)) == 'delete' then
    
    removeLuaSprite(tag:sub(1, #tag - 6), true)
    
    end
    
end


function updateGData(char)

_G[char..'GhostData.frameName'] = getProperty(char..'.animation.frameName')

_G[char..'GhostData.offsetX'] = getProperty(char..'.offset.x')

_G[char..'GhostData.offsetY'] = getProperty(char..'.offset.y')

end