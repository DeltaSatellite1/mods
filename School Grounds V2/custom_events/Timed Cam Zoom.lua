function onEvent(name, v1, v2)
    if name == 'Timed Cam Zoom' then
        local zoom = #v1 > 0 and v1 or defaultCamZoom
        doTweenZoom('timed_camZoom', 'camGame', zoom, v2, 'quadInOut')
    end
end