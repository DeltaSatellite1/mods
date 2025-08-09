function onCreate()
    addLuaScript('extra_scripts/PiperStrickerScript')
    if (not lowQuality) then
        addLuaScript('extra_scripts/InkRain')
    end
end

function onStepHit()
    if curStep == 3966 then
        setProperty('camGame.visible',false)
        setProperty('camHUD.visible',false)
    end
end
function onSectionHit()
    if curSection == 84 or curSection == 134 or curSection == 201 then
        callScript('extra_scripts/PiperStrickerScript','enableAttack',{true})
    elseif curSection == 105 or curSection == 189 or curSection == 244 then
        callScript('extra_scripts/PiperStrickerScript','enableAttack',{false})
    end
    if not lowQuality then
        if curSection == 117 or curSection == 201 then
            callScript('extra_scripts/InkRain','active',{false})
        elseif curSection == 105 or curSection == 189 or curSection == 244 then
            callScript('extra_scripts/InkRain','active',{true})
        end
    end
end