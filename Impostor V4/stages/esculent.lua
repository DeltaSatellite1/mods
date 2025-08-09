function onCreate()
    makeLuaSprite('esculentBG','skeld/background',620,350)
    scaleObject('esculentBG',0.5,0.5)
    addLuaSprite('esculentBG',false)
end
function onCreatePost()
    setProperty('boyfriendGroup.alpha',0)
end

