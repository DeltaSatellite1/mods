function onCreate()
    makeLuaSprite('reactorGround','reactor/floornew',0,0)
    addLuaSprite('reactorGround',false)
    if not lowQuality then
        makeAnimatedLuaSprite('susBG','reactor/yellowcoti',900,928)
        addAnimationByPrefix('susBG','idle','Pillars with crewmates instance 1',24,false)
        addLuaSprite('susBG',false)
    end
    makeLuaSprite('reactorBPillar','reactor/backbars',0,0)
    addLuaSprite('reactorBPillar',false)
    makeAnimatedLuaSprite('reactorBall','reactor/ball lol',1225,120)
    addAnimationByPrefix('reactorBall','core','core instance 1',24,true)
    addLuaSprite('reactorBall',false)
    if not lowQuality then
        makeAnimatedLuaSprite('susBG2','reactor/browngeoff',480,990)
        addAnimationByPrefix('susBG2','idle','Pillars with crewmates instance 1',24,false)
        addLuaSprite('susBG2',false)

        makeAnimatedLuaSprite('reactorBallLight','reactor/yeahman',1000,100)
        addAnimationByPrefix('reactorBallLight','overlay','Reactor Overlay Top instance 1',24,true)
        addLuaSprite('reactorBallLight',false)
    end
end
function onBeatHit()
    if not lowQuality and curBeat % 2 == 0 then
        objectPlayAnimation('susBG','idle',true)
        objectPlayAnimation('susBG2','idle',true)
    end
end