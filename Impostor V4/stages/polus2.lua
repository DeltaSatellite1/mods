function onCreate()
    makeLuaSprite('polusSky','polus/newsky',0,100)
    addLuaSprite('polusSky',false)

    makeLuaSprite('polusClow','polus/newcloud',200,250)
    scaleObject('polusClow',0.75,0.75)
    addLuaSprite('polusClow',false)
    
    makeLuaSprite('polusBG','polus/newstage',360,220)
    scaleObject('polusBG',0.8,0.8)
    addLuaSprite('polusBG',false)



    makeAnimatedLuaSprite('polusSnowBack','polus/snowback',500,400)
    scaleObject('polusSnowBack',2,2)
    setProperty('polusSnowBack.alpha',0.5)
    addAnimationByPrefix('polusSnowBack','snow','Snow group instance 1',24,true)
    addLuaSprite('polusSnowBack',false)

    makeLuaSprite('polusLight','polus/newoverlay',0,0)
    setBlendMode('polusLight','add')
    setProperty('polusLight.alpha',0.7)
    addLuaSprite('polusLight',true)

    makeAnimatedLuaSprite('polusSnowFront','polus/snowfront',500,400)
    scaleObject('polusSnowFront',2,2)
    setProperty('polusSnowFront.alpha',0.5)
    addAnimationByPrefix('polusSnowFront','snow','snow fall front instance 1',24,true)
    addLuaSprite('polusSnowFront',true)
end
