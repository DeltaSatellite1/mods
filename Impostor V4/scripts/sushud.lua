function onCreate()
    if timeBarType ~= 'Disabled' then
        if version >= '0.7' then
            if songName ~= 'Defeat' and songName ~= 'Alpha-Moogus' then

                setPropertyFromClass('backend.ClientPrefs','data.timeBarType','Song Name')
            else
                setPropertyFromClass('backend.ClientPrefs','data.timeBarType','Disabled')
            end
        else
            if songName ~= 'Defeat' and songName ~= 'Alpha-Moogus' then
                setPropertyFromClass('ClientPrefs','timeBarType','Song Name')
            else
                setPropertyFromClass('ClientPrefs','timeBarType','Disabled')
            end
        end
    end
end
function onCreatePost()
    setProperty('timeBar.x',97)
    setTextSize('timeTxt',15)

    setProperty('timeTxt.x',getProperty('timeBar.x') + 10)
    setTextAlignment('timeTxt','left')
    setTextBorder('timeTxt',1,'000000')
    setProperty('timeTxt.y',getProperty('timeBar.y'))

    if version >= '0.7' then
        loadGraphic('timeBar.bg','timeBar-0.7')
        setProperty('timeBar.bg.color',getColorFromHex('FFFFFF'))
        setProperty('timeBar.leftBar.color',getColorFromHex('00FF00'))
        setProperty('timeBar.rightBar.color',getColorFromHex('2E412E'))
    else
        setProperty('timeTxt.offset.y',5)
        setProperty('timeBar.color',getColorFromHex('00FF00'))
        setProperty('timeBarBG.color',getColorFromHex('FFFFFF'))
    end
    if not hideHud then
        detectHealthBarColor()
    end
end

function detectHealthBarColor()
    if songName ~= 'Sussus Nuzzus' and songName ~= 'Alpha-Moogus' and songName ~= 'Actin-Sus' then
        setProperty('scoreTxt.color',rgbToHex(getProperty('dad.healthColorArray')))
    end
end

function onDestroy()
    setPropertyFromClass('ClientPrefs','timeBarType',timeBarType)
end

function rgbToHex(array)
    return getColorFromHex(string.format('%.2x%.2x%.2x', array[1], array[2], array[3]))
end

function onEvent(name,v1,v2)
    if name == 'Change Character' and not hideHud and (v1 == 'dad' or v1 == '0') then
        detectHealthBarColor()
    end
end
function onUpdateScore()
    if not hideHud and songName ~= 'victory' then
        local score = 'Score: '..getProperty('songScore')..' | Combo Breaks: '..getProperty('songMisses')..' | Accuracy: '..(math.floor(getProperty('ratingPercent') * 10000)/100)..'%'
        if getProperty('songMisses') <= 0 and getProperty('ratingFC') ~= '' then
            score = score..'['..getProperty('ratingFC')..']'
        end
        setTextString('scoreTxt',score)
    end
end