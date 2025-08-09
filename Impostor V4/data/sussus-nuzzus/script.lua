
function onCreate()
    setProperty('healthBar.alpha', 0)
    setProperty('iconP1.alpha', 0)
    setProperty('iconP2.alpha', 0)
    setTextFont('scoreTxt','apple_kid.ttf')
    setTextSize('scoreTxt',50)
end
function onUpdate()
    setProperty('health', 1) -- prevents any kind of health gain or loss
end