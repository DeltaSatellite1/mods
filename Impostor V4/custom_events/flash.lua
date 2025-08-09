function onEvent(name,v1,v2)
	if name == 'flash' then
		local speed = 0.4
		local color = 'FFFFFF'
		local layer = 'game'
		if v1 ~= '' and string.len(v1) >= 6 then
			color = v1
		end
		if v2 ~= '' then
			local commaStartV2 = 0
			local commaEndV2 = 0
			commaStartV2,commaEndV2 = string.find(v2,',',0,true)
			if commaStartV2 ~= nil then
				speed = tonumber(string.sub(v2,0,commaStartV2 - 1))
				layer = string.sub(v2,commaEndV2 + 1)
			else
				speed = tonumber(v2)
			end
		end
		cameraFlash(layer,color,speed)
	end
end