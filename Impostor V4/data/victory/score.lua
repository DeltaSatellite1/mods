local combo = 0
local curAccuracy = 0
local curRating = ''
function onCreatePost()
    setProperty('healthBar.visible',false)
    setProperty('iconP1.visible',false)
    setProperty('iconP2.visible',false)
    setProperty('boyfriend.hasMissAnimations',false)
    precacheSound('playerdisconnect',2)

    if version >= '0.6.3' then
        setProperty('healthBarBG.visible',false)
    end
end
function onUpdateScore()
    local rating = ''
    if getProperty('ratingFC') ~= '' then
        rating = " ["..getProperty('ratingFC').."]"
    end
    setTextString('scoreTxt','Score: Who cares? You already won! | Combo Breaks: 0 | Accuracy: '..(math.floor(getProperty('ratingPercent') * 10000)/100)..'%'..rating)
    setProperty('health',2)
end

function goodNoteHit(id,dir,type,sus)
    combo = combo + 1
    curAccuracy = getProperty('ratingPercent')
    curRating = getProperty('ratingFC')
end

function noteMiss()
    setProperty('totalNotesHit',getProperty('totalNotesHit') + 1)
    setProperty('songMisses',0)
    setProperty('combo',combo)
    setProperty('ratingFC',curRating)
    setProperty('ratingPercent',curAccuracy)
    onUpdateScore()
    setProperty('vocals.volume',1)
end

function onEvent(name)
    if name == 'Change Character' then
        setProperty('boyfriend.hasMissAnimations',false)
    end
end
function onStepHit()
    if curStep == 121 or curStep == 448 or curStep == 717 or curStep == 976 or curStep == 1052 or curStep == 1116 then
        playSound('playerdisconnect')
    end
end