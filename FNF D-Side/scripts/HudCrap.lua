function onUpdate(elapsed) -- STOP LOOKING AROUND
    if keyPressed('left') then
        doTweenColor('timeBar', 'timeBar', 'BF40BF', 0.01, 'linear');
    elseif keyPressed('right') then
        doTweenColor('timeBar', 'timeBar', 'BF40BF', 0.01, 'linear');
    elseif keyPressed('down') then
        doTweenColor('timeBar', 'timeBar', 'BF40BF', 0.01, 'linear');
    elseif keyPressed('up') then
        doTweenColor('timeBar', 'timeBar', 'BF40BF', 0.01, 'linear');
    else
        doTweenColor('timeBar', 'timeBar', 'BF40BF', 0.4, 'linear');
    end
end

local angleshit = -1

function onBeatHit() --bruh
	if getProperty('curBeat') % 2 == 0 then
			setProperty('iconP1.angle',angleshit*30)
			setProperty('iconP2.angle',angleshit*0)
			doTweenAngle('hr', 'iconP1', 0, 0.5, 'circOut')
			doTweenAngle('hrr', 'iconP2', 0, 0.5, 'circOut')
	    end
	if getProperty('curBeat') % 2 == 0 then
			setProperty('iconP1.angle',angleshit*30)
			setProperty('iconP2.angle',angleshit*-30)
			doTweenAngle('hr', 'iconP1', 0, 0.5, 'circOut')
			doTweenAngle('hrr', 'iconP2', 0, 0.5, 'circOut')
		end
end

