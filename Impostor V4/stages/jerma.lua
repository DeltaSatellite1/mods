function onCreate()
    makeLuaSprite('jermaBG','jerma',0,0)
    addLuaSprite('jermaBG',false)

    makeLuaSprite('jermaVignette','vignette',0,0)
    setObjectCamera('jermaVignette','hud')
    addLuaSprite('jermaVignette',true)
end

