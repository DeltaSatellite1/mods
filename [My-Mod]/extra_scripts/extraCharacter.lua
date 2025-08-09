local extraCharacters = {}
function createExtraCharacter(tag,json,x,y,isPlayer,order)
    if order == nil then
        if not isPlayer then
            order = 'dadGroup'
        else
            order = 'boyfriendGroup'
        end
    end
    runHaxeCode(
		[[
			var char = new Character(]]..x..','..y..',"'..json..'",'..tostring(isPlayer == true)..[[);
			setVar("]]..tag..[[",char);
            game.insert(game.members.indexOf(game.]]..order..[[),char);
			return;
		]]
	)
    extraCharacters[tag] = json
end
function onBeatHit()
    local characters = ''
    for char, json in pairs(extraCharacters) do
        characters = ',"'..char..'"'
    end
    characters = string.sub(characters,2)
    runHaxeCode(
        [[
            var chars = []]..characters..[[];
            for(char in chars){
                var extraChar = getVar(char);
                if(extraChar != null && !extraChar.specialAnim && extraChar.holdTimer == 0 && !StringTools.startsWith(extraChar.animation.curAnim.name,'sing')){
                    extraChar.dance();
                }
            }
            return;
        ]]
    )
end