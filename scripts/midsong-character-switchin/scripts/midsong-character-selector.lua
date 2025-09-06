-- enter your character .json names here (don't include .json when adding character names here)

character1 = 'bf'
character2 = 'spooky'
character3 = 'pico-player'
character4 = 'tankman-player'
character5 = 'bf-holding-gf'

-- enter your character .png/.xml names here (don't include .png or .xml when adding character names here)
-- i added this so your game doesnt lag too much when you switch your character for the first time in the song

character1s = 'BOYFRIEND' 
character2s = 'spooky_kids_assets'
character3s = 'Pico_FNF_assetss'
character4s = 'tankmanCaptain'
character5s = 'bfAndGF'

-- and now, set a color the camera should flash in for each character
-- (theres red, pink, yellow, green, cyan, blue, purple, pink, black, grey and orange, or type anything else for white)

color1 = 'cyan'
color2 = 'orange'
color3 = 'green'
color4 = 'black'
color5 = 'cyan'



-- DONT CHANGE ANYTHING HERE UNLESS YOU KNOW WHAT YOU'RE DOING

function onCreate()

precacheImage('characters/' .. character1s)
precacheImage('characters/' .. character2s)
precacheImage('characters/' .. character3s)
precacheImage('characters/' .. character4s)
precacheImage('characters/' .. character5s)

		if color1 == 'red' then
			color1 = 'FF0000'
	 	elseif color1 == 'yellow' then
			color1 = 'FFF400'	 
	 	elseif color1 == 'green' then
			color1 = '2BFF00'	 
	 	elseif color1 == 'cyan' then
			color1 = '00FFEB'	 
	 	elseif color1 == 'blue' then
			color1 = '0C00FF'	 
	 	elseif color1 == 'purple' then
			color1 = '9400FF'	 
		elseif color1 == 'pink' then
			color1 = 'FF00EB'
		elseif color1 == 'black' then
			color1 = '000000'
		elseif color1 == 'grey' then
			color1 = '525252'
		elseif color1 == 'orange' then
			color1 = 'ff6600'
		else
			color1 = 'ffffff'
		end

		if color2 == 'red' then
			color2 = 'FF0000'
	 	elseif color2 == 'yellow' then
			color2 = 'FFF400'	 
	 	elseif color2 == 'green' then
			color2 = '2BFF00'	 
	 	elseif color2 == 'cyan' then
			color2 = '00FFEB'	 
	 	elseif color2 == 'blue' then
			color2 = '0C00FF'	 
	 	elseif color2 == 'purple' then
			color2 = '9400FF'	 
		elseif color2 == 'pink' then
			color2 = 'FF00EB'
		elseif color2 == 'black' then
			color2 = '000000'
		elseif color2 == 'grey' then
			color2 = '525252'
		elseif color2 == 'orange' then
			color2 = 'ff6600'
		else
			color2 = 'ffffff'
		end

		if color3 == 'red' then
			color3 = 'FF0000'
	 	elseif color3 == 'yellow' then
			color3 = 'FFF400'	 
	 	elseif color3 == 'green' then
			color3 = '2BFF00'	 
	 	elseif color3 == 'cyan' then
			color3 = '00FFEB'	 
	 	elseif color3 == 'blue' then
			color3 = '0C00FF'	 
	 	elseif color3 == 'purple' then
			color3 = '9400FF'	 
		elseif color3 == 'pink' then
			color3 = 'FF00EB'
		elseif color3 == 'black' then
			color3 = '000000'
		elseif color3 == 'grey' then
			color3 = '525252'
		elseif color3 == 'orange' then
			color3 = 'ff6600'
		else
			color3 = 'ffffff'
		end

		if color4 == 'red' then
			color4 = 'FF0000'
	 	elseif color4 == 'yellow' then
			color4 = 'FFF400'	 
	 	elseif color4 == 'green' then
			color4 = '2BFF00'	 
	 	elseif color4 == 'cyan' then
			color4 = '00FFEB'	 
	 	elseif color4 == 'blue' then
			color4 = '0C00FF'	 
	 	elseif color4 == 'purple' then
			color4 = '9400FF'	 
		elseif color4 == 'pink' then
			color4 = 'FF00EB'
		elseif color4 == 'black' then
			color4 = '000000'
		elseif color4 == 'grey' then
			color4 = '525252'
		elseif color4 == 'orange' then
			color4 = 'ff6600'
		else
			color4 = 'ffffff'
		end

		if color5 == 'red' then
			color5 = 'FF0000'
	 	elseif color5 == 'yellow' then
			color5 = 'FFF400'	 
	 	elseif color5 == 'green' then
			color5 = '2BFF00'	 
	 	elseif color5 == 'cyan' then
			color5 = '00FFEB'	 
	 	elseif color5 == 'blue' then
			color5 = '0C00FF'	 
	 	elseif color5 == 'purple' then
			color5 = '9400FF'	 
		elseif color5 == 'pink' then
			color5 = 'FF00EB'
		elseif color5 == 'black' then
			color5 = '000000'
		elseif color5 == 'grey' then
			color5 = '525252'
		elseif color5 == 'orange' then
			color5 = 'ff6600'
		else
			color5 = 'ffffff'
		end
	end

function onUpdate()
     if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ONE') then
	triggerEvent('Change Character','bf',character1)
	triggerEvent('Add Camera Zoom',0.35,0.35)
	cameraFlash('camGame', color1, 1, true)
	playSound('eye')
		if songName == 'Sansational' or songName == 'Final-Stretch' or songName == 'Whoopee' then
		doTweenColor('bfColorTween', 'boyfriend', 'ef8f3b', 0.0015, 'linear')
	end
		if songName == 'Endless' or songName == 'Bad-Time' then
		doTweenColor('bfColorTween', 'boyfriend', '212fba', 0.0015, 'linear')
	end
    end

     if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.TWO') then
	triggerEvent('Change Character','bf',character2)
	triggerEvent('Add Camera Zoom',0.35,0.35)
	cameraFlash('camGame', color2, 1, true)
	playSound('eye')
		if songName == 'Sansational' or songName == 'Final-Stretch' or songName == 'Whoopee' then
		doTweenColor('bfColorTween', 'boyfriend', 'ef8f3b', 0.0015, 'linear')
	end
		if songName == 'Endless' or songName == 'Bad-Time' then
		doTweenColor('bfColorTween', 'boyfriend', '212fba', 0.0015, 'linear')
	end
    end
     if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.THREE') then
	triggerEvent('Change Character','bf',character3)
	triggerEvent('Add Camera Zoom',0.35,0.35)
	cameraFlash('camGame', color3, 1, true)
	playSound('eye')
		if songName == 'Sansational' or songName == 'Final-Stretch' or songName == 'Whoopee' then
		doTweenColor('bfColorTween', 'boyfriend', 'ef8f3b', 0.0015, 'linear')
	end
		if songName == 'Endless' or songName == 'Bad-Time' then
		doTweenColor('bfColorTween', 'boyfriend', '212fba', 0.0015, 'linear')
	end
    end

     if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.FOUR') then
	triggerEvent('Change Character','bf',character4)
	triggerEvent('Add Camera Zoom',0.35,0.35)
	cameraFlash('camGame', color4, 1, true)
	playSound('eye')
		if songName == 'Sansational' or songName == 'Final-Stretch' or songName == 'Whoopee' then
		doTweenColor('bfColorTween', 'boyfriend', 'ef8f3b', 0.0015, 'linear')
	end
		if songName == 'Endless' or songName == 'Bad-Time' then
		doTweenColor('bfColorTween', 'boyfriend', '212fba', 0.0015, 'linear')
	end
    end

     if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.FIVE') then
	triggerEvent('Change Character','bf',character5)
	triggerEvent('Add Camera Zoom',0.35,0.35)
	cameraFlash('camGame', color5, 1, true)
	playSound('eye')
		if songName == 'Sansational' or songName == 'Final-Stretch' or songName == 'Whoopee' then
		doTweenColor('bfColorTween', 'boyfriend', 'ef8f3b', 0.0015, 'linear')
	end
		if songName == 'Endless' or songName == 'Bad-Time' then
		doTweenColor('bfColorTween', 'boyfriend', '212fba', 0.0015, 'linear')
	end
    end

end