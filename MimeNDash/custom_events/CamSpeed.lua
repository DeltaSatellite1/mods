function onEvent(name, value1, value2)
	if name == 'CamSpeed' then
		setProperty('cameraSpeed', value1)
	end
end