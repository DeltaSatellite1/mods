function onCreatePost()
    makeLuaSprite('greyShader')
    runHaxeCode(
        [[
            var greyShader = game.createRuntimeShader('GreyEffect');
            var greyFilter = new ShaderFilter(greyShader);
            game.getLuaObject('greyShader').shader = greyShader;
            game.camGame.setFilters([greyFilter]);
            game.camHUD.setFilters([greyFilter]);
            return;
        ]]
    )
end
function onSectionHit()
    if curSection == 80 then
        setShaderFloat('greyShader','strength',1)
    elseif curSection == 96 then
        runHaxeCode(
            [[
                game.camGame.setFilters([]);
                game.camHUD.setFilters([]);
                return;
            ]]
        )
    end
end
