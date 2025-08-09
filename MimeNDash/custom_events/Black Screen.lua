function onEvent(name, value1, value2)
    if name == 'Black Screen' and value2 == 'on' then
        doTweenAlpha('camGameon', 'camGame', 1, value1, 'linear')
    end

    if name == 'Black Screen' and value2 == 'off' then
        doTweenAlpha('camGameOff', 'camGame', 0, value1, 'linear')
    end
end