local enable = false
local angle = 1
local intencity2 = 0.6
local intencity = 0.6
local speed = 0
function onEvent(name,v1,v2)
    if name == "Camera Twist" then
        if tonumber(v1) ~= 0 and tonumber(v1) ~= nil then
            intencity = tonumber(v1) + 0.1
        else
            disableBeat()
            return
        end
        if tonumber(v2) ~= 0 and tonumber(v1) ~= nil then
            intencity2 = tonumber(v2)
            setProperty('camGame.height',screenHeight + (angle * 35))
            setProperty('camHUD.height',screenHeight + (angle * 35))
            setProperty('camGame.width',screenWidth + (angle * 30))
            setProperty('camHUD.width',screenWidth + (angle * 30))
        else
            disableBeat()
            return
        end
        enable = true
    end
end
function disableBeat()
    if enable then
        doTweenY('camGameYBack','camGame',0,1,'sineOut')
        doTweenY('camHUDYBack','camHUD',0,1,'sineOut')
        doTweenAngle('camGameBackAngle','camGame',0,1,'sineInOut')
        doTweenAngle('camHUDBackAngle','camHUD',0,1,'sineInOut')
        setProperty('camGame.height',screenHeight)
        setProperty('camHUD.height',screenHeight)
        setProperty('camGame.width',screenWidth)
        setProperty('camHUD.width',screenWidth)
        enable = false
        intencity = 0.6
        intencity2 = 0.8
    end
end
function onBeatHit()
    if enable then
        speed = stepCrochet*0.002
        local speed2 = stepCrochet*0.001
        local curAngle = angle*intencity
        local camXAngle = -curAngle*3
		if curBeat % 2 ~= 0 then
			curAngle = -curAngle
		end
        cancelTween('camGameBackAngle')
        cancelTween('camHUDBackAngle')
        cancelTween('camGameYBack')
        cancelTween('camHUDYBack')
        setProperty('camGame.angle',curAngle*(intencity/2))
        setProperty('camHUD.angle',curAngle*(intencity/2))
        doTweenAngle('camGameAngleGo','camGame',curAngle,speed2,'circOut')
        doTweenAngle('camHUDAngleGo','camHUD',curAngle,speed2,'circOut')
        doTweenY('camGameYGo','camGame',-12,speed,'circOut')
        doTweenY('camHUDYGo','camHUD',-12 * intencity2,speed,'circOut')
        doTweenX('camGameXGo','camGame',camXAngle,speed2,'linear')
        doTweenX('camHUDXGo','camHUD',curAngle,speed2,'linear')
        runTimer('camYBackEvent',speed)
    end
end
function onTimerCompleted(tag)
    if tag == 'camYBackEvent' then
        doTweenY('camGameYBack','camGame',0,speed,'sineIn')
        doTweenY('camHUDYBack','camHUD',0,speed,'sineIn')
        doTweenAngle('camGameBackAngle','camGame',0,speed,'sineOut')
        doTweenAngle('camHUDBackAngle','camHUD',0,speed,'sineOut')
    end
end