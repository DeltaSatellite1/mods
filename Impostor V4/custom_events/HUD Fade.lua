function onEvent(name,v1,v2)
    if name == "HUD Fade" then
        local speed = 0.3
        if v2 ~= '' then
            speed = v2
        end
        if v1 ~= '0' and v1 ~= '' then
            if speed == '0' then
                cancelTween('byeCamHUDEvent')
                setProperty('camHUD.alpha',0)
            else
                doTweenAlpha('byeCamHUDEvent','camHUD',0,speed,'linear')
            end
        else
            if speed == '0' then
                cancelTween('byeCamHUDEvent')
                setProperty('camHUD.alpha',1)
            else
                doTweenAlpha('byeCamHUDEvent','camHUD',1,speed,'linear')
            end
        end
    end
end