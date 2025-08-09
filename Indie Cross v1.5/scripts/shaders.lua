
local defaultChrom = 0.001
local chromVal = 0.001
local hudShader = true
local pewdmg = 0
local enableShader = true
local nightmareStage = false
function setChromShader(value)
    setShaderFloat('chromShader','rOffset',value)
    setShaderFloat('chromShader','bOffset',value * -1)
end
function onCreatePost()
    if shadersEnabled then
        if songName == 'Snake-Eyes' or songName == 'Technicolor-Tussle' or songName == 'Knockout' then
            defaultChrom = 0.0015
            chromVal = 0.001
            pewdmg = 0.0225
        elseif songName == 'Bad-Time' or songName == 'Despair' then
            defaultChrom = 0
            nightmareStage = true
        elseif songName == 'Whoopee' or songName == 'Sansational' or songName == 'Final-Stretch' then
            enableShader = false
            defaultChrom = 0
        elseif songName == 'Burning-In-Hell' then
            defaultChrom = 0
        elseif songName == 'Devils-Gambit' then
            defaultChrom = 0.0015
            pewdmg = 0.03
            nightmareStage = true
        else
            enableShader = false
        end
        if enableShader then
            chromVal = defaultChrom
            if pewdmg == 0 then
                pewdmg = defaultChrom + 0.005
            end
            initLuaShader('ChromaticAberration')
            makeLuaSprite('chromShader')
            if not hudShader then
                runHaxeCode(
                    [[
                        var chromShader = game.createRuntimeShader("ChromaticAbberation");
                        game.camGame.setFilters([new ShaderFilter(chromShader)]);
                        game.getLuaObject('chromShader').shader = chromShader;
                        return;
                    ]]
                )
            else
                runHaxeCode(
                    [[
                        var chromShader = game.createRuntimeShader("ChromaticAbberation");
                        var shader = new ShaderFilter(chromShader);
                        game.camGame.setFilters([shader]);
                        game.camHUD.setFilters([shader]);
                        game.getLuaObject('chromShader').shader = chromShader;
                        return;
                    ]]
                )
            end
            setShaderFloat('chromShader','rOffset',chromVal)
            setShaderFloat('chromShader','bOffset',chromVal * -1)
        end
    end
end
function shaderTween(shader,speed,easing)
    if enableShader then
        cancelTween('chromTweenShader')
        
        chromVal = shader
        makeLuaSprite('chromTween',nil,chromVal,0)
        if version >= '0.7' then
            startTween('chromTweenShader','chromTween',{x = defaultChrom},speed,{ease = easing,onUpdate = 'onChromTween'})
        else
            doTweenX('chromTweenShader','chromTween',0,speed,easing)
        end
    end
end
function onChromTween()
    setChromShader(getProperty('chromTween.x'))
end
function onTimerCompleted(tag)
    if string.match(tag,'gasSound') then--timer used in SansGastar script, in Burning in Hell song
        shaderTween(0.025,0.4,'circOut')
    end
end
function onUpdate()
    if version < '0.7' and luaSpriteExists('chromTween') then
        setChromShader(getProperty('chromTween.x'))
    end
end
function onTweenCompleted(tag)
    if string.match(tag,'chromTweenShader') and version < '0.7' then
        removeLuaSprite('chromTween',true)
    end
end
function opponentNoteHit(id,dir,type,sus)
    if nightmareStage then
        local force = math.random((defaultChrom + 0.05)*100,((defaultChrom + 0.08)*100))/1100
        if sus then
            force = force - 0.002
        end
        shaderTween(force,0.15,'linear')
    end
end
function onEvent(name,v1,v2)
    if name == 'CupheadAttack' or name == 'CupheadDoubleAttack' then
        shaderTween(pewdmg,0.3,'linear')
    end
end