local curTarget = 'dad'
local customSection = false
function onUpdate()
    local target = ''
    if not mustHitSection then
        target = 'dad'
        if gfSection == true  then
            target = 'gf'
        end
    end
    if curTarget ~= target and curTarget ~= 'both' and target ~= '' then
        change(target,getProperty(target..'.healthIcon'))
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
            game.iconP2.changeIcon(']]..icon..[[');
        ]]
    )
end
function onEvent(name,v1,v2)
    if name == 'FocusCamScript' then
        curTarget = nil
        if string.match(v1,'dad',0) then
            change('dad',getProperty('dad.healthIcon'))
        elseif string.match(v1,'gf',0) then
            change('gf',getProperty('gf.healthIcon'))
        else
            curTarget = ''
        end
    elseif name == 'Both Opponents' then
        if v1 ~= '0' then
            curTarget = 'both'
            change('dad','whiteblack')
        else
            curTarget = ''
        end
    end
end