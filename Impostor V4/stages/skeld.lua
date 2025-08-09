function onCreate()
    makeLuaSprite('skeldSky','skeld/stars',0,0)
    setScrollFactor('skeldSky',0.1,0.1)
    setProperty('skeldSky.antialiasing',false)
    scaleObject('skeldSky',5,5)
    addLuaSprite('skeldSky',false)

    makeLuaSprite('skeldFloor','skeld/tuesdayPixel',-200,0)
    setScrollFactor('skeldFloor',0.95,0.95)
    setProperty('skeldFloor.antialiasing',false)
    scaleObject('skeldFloor',6,6)
    addLuaSprite('skeldFloor',false)
end

