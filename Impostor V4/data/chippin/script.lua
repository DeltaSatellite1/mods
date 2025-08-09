function onUpdate(elapsed)
    local el = elapsed/0.016
    if curStep > 448 and getProperty('defaultCamZoom') > 0.4 then
        setProperty('defaultCamZoom',getProperty('defaultCamZoom')-0.0005*el)
    end
end