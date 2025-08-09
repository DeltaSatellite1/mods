--[[local curTarget = 'dad'
local customSection = false
function onUpdate()
    local target = 'dad'
    if customSection then
        target = 'ellie'
    end
    if curTarget ~= target then
        if target == 'ellie' then
            change('D54852','ellie')
        else
            change('dad',getProperty('dad.healthIcon'))
        end
        curTarget = target
    end
end
function rgb(rgb)
    --Credits to marceloCodget for the script = https://gist.github.com/marceloCodget/3862929
	local hexadecimal = ''
	for key, value in pairs(rgb) do
		local hex = ''

		while(value > 0)do
			local index = math.fmod(value, 16) + 1
			value = math.floor(value / 16)
			hex = string.sub('0123456789ABCDEF', index, index) .. hex
		end
		if(string.len(hex) == 0)then
			hex = '00'

		elseif(string.len(hex) == 1)then
			hex = '0' .. hex
		end
		hexadecimal = hexadecimal..hex
	end
    return hexadecimal
end
function change(color,icon)
    local healthColor = color
    if healthColor == 'dad' or healthColor == 'boyfriend' or healthColor == 'gf' then
        healthColor = rgb({getProperty(healthColor..'.healthColorArray[0]'),getProperty(healthColor..'.healthColorArray[1]'),getProperty(healthColor..'.healthColorArray[2]')})
    end
    setProperty('scoreTxt.color',getColorFromHex(healthColor))
    setHealthBarColors(
        healthColor,
        rgb({getProperty('boyfriend.healthColorArray[0]'),getProperty('boyfriend.healthColorArray[1]'),getProperty('boyfriend.healthColorArray[2]')})
    )
    runHaxeCode(
        [[
            game.iconP2.changeIcon(']]--[[ ..icon..');
        ]]
    --[[)
end
function onEvent(name,v1,v2)
    if name == 'Extra Section' then
        if v1 == 'dad' then
            if v2 ~= '0' then
                customSection = true
            else
                customSection = false
            end
        end
    end
end]]--
local changed = false
function onStepHit()
    if curStep >= 704 then
        runHaxeCode(
            [[
                game.iconP2.changeIcon('ellie');
            ]]
        )
        close(true)
    end
end