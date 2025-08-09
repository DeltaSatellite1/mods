local curTarget = 'dad'
local customSection = false
function onCreate()
    addHaxeLibrary('FlxColor','flixel.util')
end
function onUpdate()
    local target = ''
    if not mustHitSection then
        target = 'dad'
        if gfSection == true then
            target = 'gf'
        end
    else
        if customSection then
            target = 'player2'
        end
    end
    if curTarget ~= target and curTarget ~= 'both' and target ~= '' and curTarget ~= nil then
        if target ~= 'player2' then
            change(target,getProperty(target..'.healthIcon'))
        else
            change('E51919','redmungus')
        end
        curTarget = target
    end
end

function changeIconP2(char)
    local color = ''
    color = getProperty(char..'.healthColorArray[0]')..','..getProperty(char..'.healthColorArray[1]')..','..getProperty(char..'.healthColorArray[2]')

    runHaxeCode(
        [[
            var color = FlxColor.fromRGB(]]..color..[[);
            game.healthBar.setColors(color,null);
            game.iconP2.changeIcon("]]..getProperty(char..'.healthIcon')..[[");
            game.scoreTxt.color = color;
            return;
        ]]
    )
end
function onEvent(name,v1,v2)
    if name == 'Set Cam Target' then
        if v1 ~= 'bf' then
            if v1 == '' then
                if gfSection == true then
                    changeIconP2('gf')
                else
                    changeIconP2('dad')
                end
            else
                changeIconP2(v1)
            end
        end
    elseif name == 'FocusCamScript' then
        if string.match(v1,'dad',0) then
            change('dad')
        elseif string.match(v1,'gf',0) then
            change('gf')
        elseif string.match(v1,'redsus',0) then
            change('redsus')
        else
            curTarget = ''
        end
    end
end