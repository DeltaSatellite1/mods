function onCreate()
    makeLuaSprite('popBG','drip/ng',0,0)
    addLuaSprite('popBG',false)
end

function onUpdate()
    if curBeat == 286 then
        setProperty('defaultCamZoom',1.1)
		followchars = true
        xx = 1300
        yy = 350
        xx2 = 1300
        yy2 = 350
    end
    if curBeat == 304 then
        setProperty('defaultCamZoom',0.9)
		followchars = true
        xx = 1200
        yy = 600
        xx2 = 1350
        yy2 = 600
    end
    if curBeat == 318 then
        setProperty('defaultCamZoom',1.1)
		followchars = true
        xx = 1300
        yy = 350
        xx2 = 1300
        yy2 = 350
    end
    if curBeat == 336 then
        setProperty('defaultCamZoom',0.9)
		followchars = true
        xx = 1200
        yy = 600
        xx2 = 1350
        yy2 = 600
    end
    if curBeat == 384 then
        setProperty('defaultCamZoom',1.1)
		followchars = true
        xx = 1300
        yy = 350
        xx2 = 1300
        yy2 = 350
    end
end

