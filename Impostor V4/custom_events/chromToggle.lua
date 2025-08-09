local chromFreq = 0 --default = 2
local chromAmount = 0 --default = 0.65
local activated = false

function onCreate()
    addLuaScript('extra_scripts/createShader')
end
function onCreatePost()
    if shadersEnabled then
        shaderFunction('createShader',{'chrom','ChromaticAbberation'})
        shaderFunction('runShader',{'game','chrom'})
    end
end

function shaderFunction(func,vars)
    callScript('extra_scripts/createShader',func,vars)
end

function onBeatHit()
    if activated and curBeat % chromFreq == 0 then
        chromBeat()
    end
end

function chromBeat()
    setShaderFloat('chrom','amount',chromAmount)
    shaderFunction('doShaderTween',{'chrom','amount',0,0.45,'linear'})
end

function onEvent(name,v1,v2)
    if name == 'chromToggle' and shadersEnabled then
        if v1 ~= ''  then
            chromAmount = tonumber(v1)
        end
        if v2 ~= '' then
            chromFreq = tonumber(v2)
        end
        if chromAmount ~= 0 and chromAmount ~= nil and chromFreq ~= nil and chromFreq ~= 0 then
            chromBeat()
            activated = true
        else
            activated = false
        end
    end
end