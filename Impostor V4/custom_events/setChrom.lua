local curTarget = 0
local activated = false

function onCreate()
    if shadersEnabled then
        addLuaScript('extra_scripts/createShader')
    end
end
function onCreatePost()
    if shadersEnabled then
        shaderFunction('createShader',{'chrom','ChromaticAbberation'})
        shaderFunction('runShader',{'game','chrom'})
        if songName == 'Boiling Point' then
            setChrom(-0.25,0)
        end
    end
end

function shaderFunction(func,vars)
    callScript('extra_scripts/createShader',func,vars)
end

function setChrom(target,speed)
    if speed ~= 0 and speed ~= nil then
        shaderFunction('doShaderTween',{'chrom','amount',target,speed,'linear','chromTween'})
    else
        shaderFunction('cancelShaderTween',{'chromTween'})
        setShaderFloat('chrom', "amount",target)
    end
end
function onEvent(name,v1,v2)
    if name == 'setChrom' and shadersEnabled then
        local targetEvent = 0
        local speed = 0.5
        if v1 ~= ''  then
            targetEvent = tonumber(v1)
        end
        if v2 ~= '' then
            speed = tonumber(v2)
        end
        if speed == 0 or speed == nil then
            setChrom(targetEvent,0)
        else
            setChrom(targetEvent,speed)
        end
        
    end
end