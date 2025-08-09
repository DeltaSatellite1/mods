local getDefaultCamZoom = getProperty('defaultCamZoom') - 0.1;
local isCircusSection = false;
local isBackviewSection = false;

function onUpdate(elapsed)
	if curStep == 1216 then
        if isBackviewSection == false then 
			isCircusSection = true; 
		end
    end

	if curStep >= 1984 then
        isBackviewSection = true;
    end

	if isCircusSection == true then
		if mustHitSection == false then
			setProperty('defaultCamZoom', getDefaultCamZoom + 0.05);
		else
			setProperty('defaultCamZoom', getDefaultCamZoom);
		end 
	end

	
	if isBackviewSection == true then
		if mustHitSection == true then
			setProperty('defaultCamZoom', getDefaultCamZoom + 0.2);
		else
			setProperty('defaultCamZoom', getDefaultCamZoom);
		end 
	end
end 