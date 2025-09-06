-- radar radarB radarF7
-- Mari MariNight MariBF MariBfNight mari-darnell-player






charBF = boyfriendName
bfList = {"radarF7", "radar", "mari-darnell-player"}
bfIndex = 0

charDAD = dadName
dadList = {"radarF7", "radar", "mari-darnell"}
dadIndex = 0



function onCreate()
    for i = 1, #bfList do
        addCharacterToList(bfList[i], 'boyfriend');
    end
    for i = 1, #dadList do
        addCharacterToList(dadList[i], 'dad');
    end
end


function onUpdate()
    charReset('dad', 'keys.justPressed.ONE')
    charSwap('dad', 'keys.justPressed.TWO')
    charReset('bf', 'keys.justPressed.THREE')
    charSwap('bf', 'keys.justPressed.FOUR')
end




function charReset(char, key)
    if getPropertyFromClass('flixel.FlxG', key) then
        triggerEvent('Add Camera Zoom', 0.05, 0.05)

        if char == 'bf' then
            bfIndex = bfIndex - 1
            triggerEvent('Change Character', char, charBF)
        elseif char == 'dad' then
            dadIndex = dadIndex - 1
            triggerEvent('Change Character', char, charDAD)
        end
        -- cameraFlash('camGame', color1, 0.5, true)
    end
end

function charSwap(char, key)
    if getPropertyFromClass('flixel.FlxG', key) then
        triggerEvent('Add Camera Zoom', 0.05, 0.05)
        
        if char == 'bf' then
            bfIndex = (bfIndex % #bfList) + 1
            -- debugPrint(bfIndex)
            triggerEvent('Change Character', char, bfList[bfIndex])
        elseif char == 'dad' then
            dadIndex = (dadIndex % #dadList) + 1
            -- debugPrint(char)
            triggerEvent('Change Character', char, dadList[dadIndex])
        end
        
        -- debugPrint(index)
        -- cameraFlash('camGame', color1, 0.5, true)
    end
end