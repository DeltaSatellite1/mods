function onCreate()
    makeLuaSprite('votingBGBack','airship/backer_groung_voting',387,195)
    setScrollFactor('votingBGBack',0.8,0.8)
    addLuaSprite('votingBGBack',false)

    makeLuaSprite('votingBG','airship/main_bg_meeting',-315,50)
    setScrollFactor('votingBG',0.95,0.95)
    addLuaSprite('votingBG',false)

    makeLuaSprite('votingChairs','airship/CHAIRS!!!!!!!!!!!!!!!',-8,645)
    addLuaSprite('votingChairs',false)

    
    makeLuaSprite('votingBorders','skeld/bars',0,0)
    setObjectCamera('votingBorders','hud')
    addLuaSprite('votingBorders',false)

    makeLuaSprite('votingLight','airship/loungelight',-600,0)
    scaleObject('votingLight',1.2,1.2)
    setProperty('votingLight.alpha',0.5)
    setBlendMode('votingLight','add')
    addLuaSprite('votingLight',true)

    makeLuaSprite('votingTable','airship/table_voting',210,680)
    addLuaSprite('votingTable',true)
end