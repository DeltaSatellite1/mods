local bfCharacter = 'whitebf'
local dadCharacter = 'whitegreen'
local oldBf = 'bf'
local oldDad = 'green'
local enabled = false

local shaderDadEnabled = false
local shaderBfEnabled = false

function onCreate()
    if shadersEnabled then
        addLuaScript('extra_scripts/createShader')
        shaderFunction('createShader',{'bfShader','BWShader'})
        shaderFunction('createShader',{'dadShader','BWShader'})
    end
end


function shaderFunction(func,vars)
    callScript('extra_scripts/createShader',func,vars)
end

function onCreatePost()
    if detectCharacter('dad') then
        addCharacterToList(dadCharacter,'dad')
    end
    if detectCharacter('boyfriend') then
        addCharacterToList(bfCharacter,'bf')
    end
end
function detectCharacter(character)
    local dad = getProperty('dad.curCharacter')
    local bf = getProperty('boyfriend.curCharacter')
    if (character == 'dad' and dad ~= dadCharacter and dad ~= 'impostor3') or (character == 'boyfriend' and bf ~= bfCharacter and bf ~= 'bf') then
        return false
    end
    return true
end

function createWhiteBar()
    if not luaSpriteExists('healthBarWhite') then
        makeLuaSprite('healthBarWhite',nil,0,0)
        setProperty('healthBarWhite.alpha',0.001)
        setObjectCamera('healthBarWhite','hud')
        makeGraphic('healthBarWhite',getProperty('healthBar.width'),getProperty('healthBar.height'),'FFFFFF')


        if version <= '0.6.3' then
            setObjectOrder('healthBarWhite',getObjectOrder('healthBar')+1)
            setProperty('healthBar.visible',false)
        else
            setProperty('healthBar.leftBar.visible',false)
            setProperty('healthBar.rightBar.visible',false)
        end

        addLuaSprite('healthBarWhite',true)
    end
end
function onUpdate()
    if luaSpriteExists('luaSpriteExists') then
        setProperty('healthBarWhite.x',getProperty('healthBar.x'))
        setProperty('healthBarWhite.y',getProperty('healthBar.y'))
        --[[setProperty('healthBarWhite.angle',getProperty('healthBar.angle'))
        setProperty('healthBarWhite.scale',getProperty('healthBar.scale'))]]--
    end
end

function addLightShader(character)
    if shadersEnabled and (character == 'boyfriend' and not shaderBfEnabled or character == 'dad' and not shaderDadEnabled) then
        if character == 'boyfriend' then
            shaderFunction('runShaderOnSprite',{'boyfriend','bfShader'})
            shaderFunction('runShaderOnSprite',{'iconP1','bfShader'})
            shaderBfEnabled = true
        elseif character == 'dad' then
            shaderFunction('runShaderOnSprite',{'dad','dadShader'})
            shaderFunction('runShaderOnSprite',{'iconP2','bfShader'})
            shaderDadEnabled = true
        end
    end
end

function lights(character,add)
    if add ~= false then
        if character == 'bf' or character == 'all' then
            if detectCharacter('boyfriend') then
                triggerEvent('Change Character','bf',bfCharacter)
                shaderBfEnabled = false
            else
                createWhiteBar()
                addLightShader('boyfriend')
            end
        end
        if character == 'dad' or character == 'all' then
            if detectCharacter('dad') then
                triggerEvent('Change Character','dad',dadCharacter)
                shaderDadEnabled = false
            else
                createWhiteBar()
                addLightShader('dad')
            end
        end
        setProperty('scoreTxt.color',getColorFromHex('FFFFFF'))
    else
        if character == 'boyfriend' or character == 'all' then

            removeShader('boyfriend')
            if detectCharacter('boyfriend') then
                triggerEvent('Change Character','bf',oldBf)
            end
        end
        if character == 'dad' or character == 'all'  then
            removeShader('dad')
            if detectCharacter('dad') then
                triggerEvent('Change Character','dad',oldDad)
            end
        end
    end
end

function removeShader(character)
    if luaSpriteExists('healthBarWhite') then
        if version <= '0.6.3' then
            setProperty('healthBar.visible',true)
        else
            setProperty('healthBar.leftBar.visible',true)
            setProperty('healthBar.rightBar.visible',true)
        end
        removeLuaSprite('healthBarWhite',true)
    end
    if character == 'dad' then
        if not shaderDadEnabled then
            return
        else
            shaderDadEnabled = false
            shaderFunction('removeShaderSprite',{'dad'})
            shaderFunction('removeShaderSprite',{'iconP2'})
        end
    elseif character == 'boyfriend' then
        if not shaderBfEnabled then
            return
        else
            shaderFunction('removeShaderSprite',{'boyfriend'})
            shaderBfEnabled = false
            shaderFunction('removeShaderSprite',{'iconP1'})
        end
    end
    
end

function onEvent(name,v1,v2)
    if name == 'Lights out' then
        if string.lower(v1) == 'on' or v1 == '' then
            cameraFlash('game','FFFFFF',0.6)
            oldBf = getProperty('boyfriend.curCharacter')
            oldDad = getProperty('dad.curCharacter')
            enabled = true
            setProperty('gf.visible',false)
        else
            cameraFlash('game','000000',0.5)
            enabled = false
            setProperty('gf.visible',true)
        end
        lights('all',enabled)
    elseif name == 'Change Character' then
        if v1 == '1' or string.lower(v1) == 'dad' then
            shaderDadEnabled = false
            if not detectCharacter('dad')then
                lights('dad',enabled)
            end
        elseif v1 == '0' or v1 == '2' or string.lower(v1) == 'bf' then
            shaderBfEnabled = false
            if not detectCharacter('boyfriend')then
                lights('bf',enabled)
            end
        end
    end
end