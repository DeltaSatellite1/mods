
local anims = {'count0','your0','sec','onds','i0',"will0",'end','you0','boyfriend'}
local animsOffset = {
    {-100,0},--count
    {-120,0},--your
    {-100,100},--sec
    {-100,140},--onds
    {00,0},--i
    {110,-10},--will
    {70,-15},--end
    {110,-10},--you
    {100,-10}--boyfriend
}
local posX = 260
local posY = 50
function onCreate()
    precacheImage('skeld/shapeshifty')
    for lines = 1,#anims do
        makeAnimatedLuaSprite('Identity'..lines,'skeld/shapeshifty',posX,posY)
        scaleObject('Identity'..lines,0.6,0.6)
        setProperty('Identity'..lines..'.offset.x',animsOffset[lines][1])
        setProperty('Identity'..lines..'.offset.y',animsOffset[lines][2])
        addAnimationByPrefix('Identity'..lines,anims[lines],anims[lines],24,true)
        setObjectCamera('Identity'..lines,'other')
    end
end
function onCreatePost()
    setProperty('camGame.zoom',1)
    triggerEvent('FocusCamScript','both,both,10,-100','')
    triggerEvent('HUD Fade','1','0')
    triggerEvent('coverScreen','1,other','0')
    setProperty('introSoundsSuffix','-silence')
end
function onStepHit()
    if curStep == 576 then
        addLuaSprite('Identity1',true)
    elseif curStep == 584 then
        addLuaSprite('Identity2',true)
        setProperty('Identity2.y',getProperty('Identity1.y') + 200)
    elseif curStep == 592 then
        addLuaSprite('Identity3',true)
        addLuaSprite('Identity4',true)
        setProperty('Identity3.y',getProperty('Identity2.y') + 270)
        setProperty('Identity4.y',getProperty('Identity3.y'))
        setProperty('Identity3.x',posX - 90)
        setProperty('Identity4.x',getProperty('Identity3.x') + 280)
    elseif curStep == 601 then
       for lines = 1,4 do
            removeLuaSprite('Identity'..lines,true)
       end
    elseif curStep == 608 then
        addLuaSprite('Identity5',true)
        setProperty('Identity5.x',posX)
        setProperty('Identity5.y',posY)
    elseif curStep == 617 then
        removeLuaSprite('Identity5',true)
        addLuaSprite('Identity6',true)
        setProperty('Identity6.x',posX)
        setProperty('Identity6.y',posY)
    elseif curStep == 624 then
        removeLuaSprite('Identity6',true)
        addLuaSprite('Identity7',true)
        setProperty('Identity7.x',posX)
        setProperty('Identity7.y',posY)
    elseif curStep == 633 then
        removeLuaSprite('Identity7',true)
        addLuaSprite('Identity8',true)
        setProperty('Identity8.x',posX)
        setProperty('Identity8.y',posY)
        addLuaSprite('Identity9',true)
        setProperty('Identity9.x',posX)
        setProperty('Identity9.y',posY + 150)
    elseif curStep == 640 then
        removeLuaSprite('Identity8',true)
        removeLuaSprite('Identity9',true)
    end
    if curStep >= 607 and curStep < 634  then
        posX = 500
        posY = 225
    end
    if curStep >= 3338 and curStep <= 3344 then
        for strumLine = 0,3 do
            setPropertyFromGroup('strumLineNotes',strumLine,'alpha',0)
        end
        setProperty('healthBar.visible',false)
        setProperty('healthBarBG.visible',false)
        setProperty('scoreTxt.visible',false)
        setProperty('iconP1.visible',false)
        setProperty('iconP2.visible',false)
    end
end