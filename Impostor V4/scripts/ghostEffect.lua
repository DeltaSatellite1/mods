local lastDadHoldTime = 0
local lastDadStrum = -1
local lastBfHoldTime = 0
local lastBfStrum = -1
local lastGfHoldTime = 0
local lastGfStrum = -1
local lastAnims = {
    boyfriend = {},
    gf = {},
    dad = {}
}
local enableDadGhost = true
local enableBfGhost = true
local enableGfGhost = true

local bfColor = ''
local dadColor = ''
local gfColor = ''
function detectGF(type)
    if gfSection ~= true and type ~= "GF Sing"  then
        return false
    else
        return true
    end
end
function onCreatePost()
    detectGhostColor()
end
function detectGhostColor()
    bfColor = rgbToHex(getProperty('boyfriend.healthColorArray'))
    dadColor = rgbToHex(getProperty('dad.healthColorArray'))
    gfColor = rgbToHex(getProperty('gf.healthColorArray'))
end
function rgbToHex(array)
    return getColorFromHex(string.format('%.2x%.2x%.2x', array[1], array[2], array[3]))
end
function opponentNoteHit(id,dir,type,sus)
    if not sus then
        local noteStrum = getPropertyFromGroup('notes',id,'strumTime')
        local noteSustain = getPropertyFromGroup('notes',id,'sustainLength')
        if not detectGF(type) then
            if enableDadGhost then
                if lastDadStrum ~= noteStrum then
                    saveAnim('dad')
                else
                    if noteSustain > stepCrochet and lastDadHoldTime > noteSustain then
                        saveAnim('dad')
                    end
                    createGhost('dad',getProperty('dad.imageFile'),dadColor)
                end
                lastDadStrum = noteStrum
                lastDadHoldTime = noteSustain
            end
        else
            gfGhost(noteStrum,noteSustain)
        end
    end
end

function gfGhost(noteStrum,noteSustain)
    if enableGfGhost then
        if lastGfStrum ~= noteStrum then
            saveAnim('gf')
        else
            if noteSustain > stepCrochet and lastGfHoldTime > noteSustain then
                saveAnim('gf')
            end
            createGhost('gf',getProperty('gf.imageFile'),gfColor)
        end
        lastGfHoldTime = noteSustain
        lastGfStrum = noteStrum
    end
end

function saveAnim(character)
    local anim = getProperty(character..'.animation.frameName')
    anim = string.sub(anim,0,string.len(anim) - 3)
    lastAnims[character] = {
        anim,
        getProperty(character..'.animation.curAnim.frameRate'),
        getProperty(character..'.animation.curAnim.looped'),
        getProperty(character..'.offset.x'),
        getProperty(character..'.offset.y')
    }
end
function goodNoteHit(id,dir,type,sus)
    if not sus then
        local noteStrum = getPropertyFromGroup('notes',id,'strumTime')
        local noteSustain = getPropertyFromGroup('notes',id,'sustainLength')
        if not detectGF(type) then
            if enableBfGhost then
                if lastBfStrum ~= noteStrum then
                    saveAnim('boyfriend')
                else
                    if noteSustain > stepCrochet and lastBfHoldTime > noteSustain then
                        saveAnim('boyfriend')
                    end
                    createGhost('boyfriend',getProperty('boyfriend'..'.imageFile'),bfColor)
                end
                lastBfStrum = noteStrum
                lastBfHoldTime = noteSustain
            end
        else
            gfGhost(noteStrum,noteSustain)
        end
    end
end


function createGhost(object, location, color)
    if getProperty(object..'.alpha') > 0.3 and getProperty(object..'.visible') then
        local spriteName = object..'Ghost'
        local anim = {}
        local offset = {}
        if object == 'boyfriend' or object == 'dad' or object == 'gf' then
            anim = lastAnims[object]
            offset = {anim[4],anim[5]}
        else
            anim = {
                getProperty(object..'.animation.frameName'),
                getProperty(object..'.animation.curAnim.frameRate'),
                getProperty(object..'.animation.curAnim.looped')
            }
        end
        cancelTween(spriteName..'Bye')
        makeAnimatedLuaSprite(spriteName, location, getProperty(object..'.x'), getProperty(object..'.y'))
        setProperty(spriteName..'.alpha', getProperty(object..'.alpha') - 0.3)
        scaleObject(spriteName, getProperty(object..'.scale.x'), getProperty(object..'.scale.y'))
        setProperty(spriteName..'.antialiasing',getProperty(object..'.antialiasing'))
        addAnimationByPrefix(spriteName,'anim',anim[1],anim[2],anim[3])
        setProperty(spriteName..'.flipX', getProperty(object..'.flipX'))
        setProperty(spriteName..'.angle', getProperty(object..'.angle'))
        addLuaSprite(spriteName,false)
        doTweenAlpha(spriteName..'Bye',spriteName, 0, stepCrochet*0.005, 'linear')

        if color == nil then
            setProperty(spriteName..'.color',getProperty(object..'.color'))
        else
            setProperty(spriteName..'.color',color)
        end
        if offset ~= {} then
            setProperty(spriteName..'.offset.x',offset[1])
            setProperty(spriteName..'.offset.y',offset[2])
        else
            setProperty(spriteName..'.offset.x',getProperty(object..'.offset.x'))
            setProperty(spriteName..'.offset.y',getProperty(object..'.offset.y'))
        end
        if object == 'boyfriend' or object == 'dad' or object == 'gf' then
            setObjectOrder(spriteName,getObjectOrder(object..'Group') - 1)
        else
            setObjectOrder(spriteName,getObjectOrder(object) - 1)
        end
        
        runHaxeCode(
            [[
                if(game.members["]]..object..[["] != null){

                    game.getLuaObject("]]..spriteName..[[").shader = game.]]..object..[[.shader;
                }
                else if(game.getLuaObject("]]..object..[[") != null){
                    game.getLuaObject("]]..spriteName..[[").shader = game.getLuaObject("]]..object..[[").shader;
                }
                return;
            ]]
        )
    end
end

function onTweenCompleted(tag)
    if string.find(tag,'GhostBye') then
        removeLuaSprite(string.gsub(tag,'Bye',''),true)
    end
end
