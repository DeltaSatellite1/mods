function onCreate()
    makeLuaSprite('polusSky','polus/polus_custom_sky',-1050,-850)
    scaleObject('polusSky',1.85,1.85)
    setScrollFactor('polusSky',0.7,0.7)
    addLuaSprite('polusSky',false)

    makeLuaSprite('polusHillsRocks','polus/polusrocks',-720,-320)
    setScrollFactor('polusHillsRocks',0.8,0.8)
    addLuaSprite('polusHillsRocks',false)
    makeLuaSprite('polusHills','polus/polusHills',-1050,-185)
    setScrollFactor('polusHills',0.9,0.9)
    addLuaSprite('polusHills',false)

    makeLuaSprite('polusLab','polus/polus_custom_lab',30,-390)
    setScrollFactor('polusLab',0.95,0.95)
    addLuaSprite('polusLab',false)

    makeLuaSprite('polusFloor','polus/polus_custom_floor',-1345,80)
    addLuaSprite('polusFloor',false)
    if songName == 'Sabotage' or songName == 'Meltdown' then
        makeAnimatedLuaSprite('polusRadio','polus/speakerlonely',300,185)
        addAnimationByPrefix('polusRadio','idle','speakers lonely',24,false)
        addLuaSprite('polusRadio',false)
    end
    if songName == 'Meltdown' then
        makeAnimatedLuaSprite('polusPeople','polus/boppers_meltdown',-950,185)
        setScrollFactor('polusPeople',1.2,1.2)
        addAnimationByPrefix('polusPeople','idle','BoppersMeltdown',24,false)
        addLuaSprite('polusPeople',true)
    end
    if not lowQuality then
        makeAnimatedLuaSprite('polusSnow','polus/snow',-600,-500)
        scaleObject('polusSnow',1.8,1.8)
        addAnimationByPrefix('polusSnow','snow','cum',24,true)
        addLuaSprite('polusSnow',true)
    end
end
function onBeatHit()
    if songName == 'Sabotage' or songName == 'Meltdown' then
        objectPlayAnimation('polusRadio','idle',true)
    end
    if songName == 'Meltdown' then
        objectPlayAnimation('polusPeople','idle',true)
    end
end

