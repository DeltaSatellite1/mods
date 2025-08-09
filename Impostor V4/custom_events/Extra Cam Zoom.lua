local curZoom = nil
local curTarget = 0
local zooming = false
function onEvent(name,v1,v2)
    if name == "Extra Cam Zoom" then
        local target = 0
        local easing = 'sineInOut'
        local speed = nil
        zooming = false

        if curZoom == nil then
            curZoom = getProperty('defaultCamZoom')
        end

        if v1 ~= '' then
            if string.find(v1,'cur,',0,true) and curTarget ~= nil then
                target = curTarget + tonumber(string.sub(v1,5))
            else
                target = tonumber(v1)
            end
        end

        if target == nil then
            target = 0
        end


        local zoom = curZoom + target
        cancelTween('camZoomExtraEvent')
        setProperty('defaultCamZoom',zoom)
        if v2 ~= '' then
            local comma1,comma2 = string.find(v2,',',0,true)
            if comma1 ~= nil then
                speed = string.sub(v2,0,comma1 - 1)
                easing = string.sub(v2,comma2 + 1)
            else
                speed = v2
            end
            if speed == '0' then
                setProperty('camGame.zoom',zoom)
            else
                doTweenZoom('camZoomExtraEvent','camGame',zoom,speed,easing)
                zooming = true
            end
        end



        if target == 0 then
            curZoom = nil
            curTarget = 0
            zooming = false
        else
            curTarget = target
        end
        
    elseif name == "Add Camera Zoom" and zooming then
		local beat = v1
		if v1 == '' then
			beat = 0.015
		end
		setProperty('camGame.zoom',getProperty('camGame.zoom') - beat)
    end
end
function onUpdate()
    if curZoom ~= nil and curTarget ~= nil then
        setProperty('defaultCamZoom',curZoom + curTarget)
    end
end
function onTweenCompleted(name)
    if name == 'camZoomExtraEvent' then
        zooming = false
    end
end