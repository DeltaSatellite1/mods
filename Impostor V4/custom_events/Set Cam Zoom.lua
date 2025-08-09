local zooming = false
local zoom = nil
function onEvent(name,value1,value2)
    if name == "Set Cam Zoom" then
		local easing = 'sineInOut'
		local easingStart = 0
		local easingEnd = 0
		local duration = nil
		if value1 ~= '' then
			if string.find(value1,',',0,true) ~= nil then
				local comma1 = 0
				local comma2 = 0
				local addZoom = 0
				comma1,comma2 = string.find(value1,',',0,true)
				if comma1 ~= nil then
					addZoom = tonumber(string.sub(value1,comma2 + 1))
				end
				if zoom == nil then
					zoom = getProperty('defaultCamZoom') + addZoom
				else
					zoom = zoom + addZoom
				end
			else
				zoom = tonumber(value1)
			end
		else
			zoom = 0
		end
		if value2 ~= '' then
			local textStringStart = 0
			local textStringLast = 0
			textStringStart,textStringLast = string.find(value2,value2)
			if string.find(value2,',',0,true) ~= nil then
				easingStart,easingEnd = string.find(value2,',',textStringStart,true)
				easing = string.sub(value2,easingEnd + 1)
				if string.sub(value2,0,easingStart - 1) ~= string.sub(value2,textStringLast - 1,textStringLast) then
					duration = tonumber(string.sub(value2,0,easingStart - 1))
				end
			else
				duration = tonumber(value2)
			end
		end
		if zoom ~= nil then
			if duration ~= nil then
				if duration ~= 0 or duration == '' then
					doTweenZoom('camzEvent','camGame',zoom,duration,easing)
					zooming = true
				else
					setProperty('camGame.zoom',zoom)
					setProperty('defaultCamZoom',zoom)
				end
			else
				setProperty('defaultCamZoom',zoom)

			end
		end
	elseif name == "Add Camera Zoom" and zooming then
		local beat = value1
		if value1 == '' then
			beat = 0.015
		end
		setProperty('camGame.zoom',getProperty('camGame.zoom') - beat)
	end
end
function onBeatHit()
	if curBeat % 4 == 0 and getProperty('camZooming') == true and zooming == true then
		setProperty('camGame.zoom',getProperty('camGame.zoom') - 0.015)
	end
end
function onTweenCompleted(name)
	if name == 'camzEvent' then
		setProperty("defaultCamZoom",getProperty('camGame.zoom'))
		zoom = nil
		zooming = false
	end
end