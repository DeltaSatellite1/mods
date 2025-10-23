
local DefaultDistanceFromEdge = 280 -- you can change this to change the starting size of the letter box

local DistanceFromEdge = 280
local Duration = 0.35

function onCreatePost()
    makeLuaSprite('LetterBoxTop', 'LetterBoxTop', 0, - screenHeight / 2 - DefaultDistanceFromEdge)
    makeGraphic('LetterBoxTop',  screenWidth, screenHeight, '000000')

    makeLuaSprite('LetterBoxBottom', 'LetterBoxBottom', 0, screenHeight / 2 + DefaultDistanceFromEdge)
    makeGraphic('LetterBoxBottom',  screenWidth, screenHeight, '000000')
end
function onUpdatePost()
    --CreateLetterBoxTop
    setObjectCamera('LetterBoxTop', 'hud')
    addLuaSprite('LetterBoxTop', false)
    setProperty('LetterBoxTop.alpha', 1)
    setObjectOrder('LetterBoxTop', 6)
    --CreateLetterBoxBottom
    setObjectCamera('LetterBoxBottom', 'hud')
    addLuaSprite('LetterBoxBottom', false)
    setProperty('LetterBoxBottom.alpha', 1)
    setObjectOrder('LetterBoxBottom', 6)
    --DebugText
    if ShowDebug == true then
    makeLuaText('disfromedgetxt', '', 0, 0, 695)
    setTextSize('disfromedgetxt', 20)
    addLuaText('disfromedgetxt', false)
    setProperty('disfromedgetxt.text','disfromedge = '..DistanceFromEdge) 

    end
end
function onEvent(n,v1,v2)

if n == "Set Letterbox Size" and v2 == "" and v1 ~= "" then
DistanceFromEdge = tonumber(v1)
setProperty('LetterBoxTop.y', - screenHeight / 2 - DistanceFromEdge)
setProperty('LetterBoxBottom.y',screenHeight / 2 + DistanceFromEdge)
end
if n == "Set Letterbox Size" and v2 ~= "" and v1 ~= "" then
DistanceFromEdge = tonumber(v1)
Duration = tonumber(v2)
doTweenY('LetterBoxTopTween','LetterBoxTop', - screenHeight / 2 - DistanceFromEdge,Duration)
doTweenY('LetterBoxBottomTween','LetterBoxBottom', screenHeight / 2 + DistanceFromEdge,Duration)
end

if n == "Set Letterbox Size" and v2 == "" and v1 == "" then
    DistanceFromEdge = tonumber(v1)
    setProperty('LetterBoxTop.y', - screenHeight / 2 - DefaultDistanceFromEdge)
    setProperty('LetterBoxBottom.y',screenHeight / 2 + DefaultDistanceFromEdge)
    end
    if n == "Set Letterbox Size" and v2 == "" and v1 ~= "" then
    DistanceFromEdge = tonumber(v1)
    doTweenY('LetterBoxTopTween','LetterBoxTop', - screenHeight / 2 - DistanceFromEdge,Duration)
    doTweenY('LetterBoxBottomTween','LetterBoxBottom', screenHeight / 2 + DistanceFromEdge,Duration)
    end

    if n == "Set Letterbox Size" and v2 ~= "" and v1 == "" then
        DistanceFromEdge = tonumber(v1)
        doTweenY('LetterBoxTopTween','LetterBoxTop', - screenHeight / 2 - DefaultDistanceFromEdge,Duration)
        doTweenY('LetterBoxBottomTween','LetterBoxBottom', screenHeight / 2 + DefaultDistanceFromEdge,Duration)
        end
end
--Script made by Vaporeon907 on gamebanna 