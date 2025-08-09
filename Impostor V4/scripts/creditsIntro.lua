function onCreatePost()
    local textCredits = 'Composer: ???'
    local credits = {
        --Red Week
        {'Sussus-Moogus','EthanTheDoodler'},
        {'Sabotage','EthanTheDoodler'},
        {'Meltdown','Punkett'},

        --Green Week
        {'Sussus Toogus','EthanTheDoodler, Fabs'},
        {'Lights Down','Rareblin'},
        {'Reactor','EthanTheDoodler, Rareblin'},
        {'ejected','Rareblin'},

        --Yellow Week
        {'Mando','Rareblin'},
        {'Dlow','Punkett, Rareblin'},
        {'Oversight','Rareblin'},
        {'Danger','Rareblin'},
        {'Double Kill','Rareblin'},
        {'Defeat','Rareblin'},
        {'Finale','Vruzzen, Punkett'},
        {'Finale Old','Rareblin'},
        
        --Maroon Week
        {'Ashes','EthanTheDoodler, Renyar'},
        {'Magmatic','Rozebud, Cval'},
        {'Boiling Point','EthanTheDoodler, Rareblin'},

        --Grey Week
        {'Delusion','Fluffyhairs'},
        {'Blackout','Cval'},
        {'Neurotic','Niisan'},

        --Pink Week
        {'Heartbeat','Saster'},
        {'Pinkwave','fluffyhairs'},
        {'Pretender','EthanTheDoodler'},

        {'O2','Punkett'},
        {'Voting-Time','Punkett, Jads'},
        {'Turbulence','Keegan'},
        {'Victory','Punkett'},

        {'Christmas','Emihead'},
        {'Spookpostor','Rareblin'},
        {'Identity Crisis','Vruzzen, Rareblin, Doguy'},

        --Henry Week
        {'Titular','EthanTheDoodler'},
        {'Greatest Plan','EthanTheDoodler'},
        {'Reinforcements','EthanTheDoodler, Philplol'},
        {'Armed','Punkett, EthanTheDoodler'},

        --Tomongus Week
        {'Sussy Bussy','Saruky'},
        {'Rivals','Keoni'},
        {'Chewmate','Moonmistt'},
        {'Tomongus Tuesday','Emihead'},

        --Extras
        {'Ow','Fabs'},
        {'Who','EthanTheDoodler'},
        {'Sauces Moogus','Saster'},
        {'Insane Streamer','EthanTheDoodler, NeatoNG'},
        {'Sussus Nuzzus',"Lunaxis (Creator of 'No More Nuzzles'!)"},
        {'Idk','Sherri/Kiwiquest'},
        {'ROOMCODE','Keegan'},
        {'Drippypop','EthanTheDoodler, NeatoNG, Lil Nas X'},
        {'Triple-Trouble','I hate A specific brand of cars'},
        {'Chippin','ZiffyClumper'},
        {'Chipping','ZiffyClumper'},
        {'Torture','Cval, JADS, Fluffyhairs, Ziffy'},
        {'Esculent','Nii-san'},
        {'Monotone Attack','Biddle3'},
        {'Top-10','Top 10 Awesome'}
    }

    for creditsLol = 1,#credits do
        if songName == credits[creditsLol][1] then
            textCredits = 'Composer: '..credits[creditsLol][2]
        end
    end
    local boxWidth = (14*string.len(textCredits)) + 30
    makeLuaSprite('creditsBox',nil,-boxWidth,200)
    makeGraphic('creditsBox',boxWidth,100,'FFFFFF')
    setProperty('creditsBox.alpha',0.6)
    setObjectCamera('creditsBox','other')
    addLuaSprite('creditsBox',false)

    makeLuaText('creditsSong',string.gsub(songName,'-',' '),1000,getProperty('creditsBox.x') + 15,getProperty('creditsBox.y') + 115)
    setTextFont('creditsSong','arial.ttf')
    setTextAlignment('creditsSong','left')
    setTextBorder('creditsSong',1,'000000')
    setObjectCamera('creditsSong','other')
    setTextSize('creditsSong',26)
    addLuaText('creditsSong',false)

    makeLuaText('creditsComposer',textCredits,600,getProperty('creditsBox.x') + 15,getProperty('creditsBox.y') + 150)
    setTextAlignment('creditsComposer','left')
    setTextFont('creditsComposer','arial.ttf')
    setTextBorder('creditsComposer',1,'000000')
    setObjectCamera('creditsComposer','other')
    setTextSize('creditsComposer',25)
    addLuaText('creditsComposer',false)
end
function onUpdate()
    setProperty('creditsSong.x',getProperty('creditsBox.x') + 15)
    setProperty('creditsSong.y',getProperty('creditsBox.y') + 15)
    setProperty('creditsComposer.x',getProperty('creditsBox.x') + 15)
    setProperty('creditsComposer.y',getProperty('creditsBox.y') + 50)
end
function onSongStart()
    doTweenX('heyCreditsBox','creditsBox',0,1,'expoOut')
    runTimer('byeCreditsBox',3)
end
function onTimerCompleted(tag)
    if tag == 'byeCreditsBox' then
        doTweenX('byeCreditsBoxX','creditsBox',-getProperty('creditsBox.width') - 10,1,'expoIn')
    end
end
function onTweenCompleted(tag)
    if tag == 'byeCreditsBoxX' then
        removeLuaSprite('creditsBox',true)
        removeLuaText('creditsComposer',true)
        removeLuaText('creditsSong',true)
        --close(true)
    end
end