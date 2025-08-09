local BeatPorcent = {0}
local BeatCustomPorcent = {0}

local cannotBeat = {0}
local cannotBeatCustom = {0}

local cannotBeatInverted = {0}
local cannotBeatCustomInverted = {0}

local invertedBeat = {0}
local invertedCustomBeat = {0}


local Section = 0
local InvertedSection = 0
local cannotBeatSection = 0

local cannotBeatInt = false
local cannotBeatIntInverted = false

local BeatStrentghGame = 0.015
local BeatStrentghHUD = 0.03

local BeatStrentghCustomGame = 0.015
local BeatStrentghCustomHUD = 0.03


local BeatStrentghInvertedGame = 0.015
local BeatStrentghInvertedHUD = 0.03


local BeatStrentghInvertedCustomGame = 0.015
local BeatStrentghInvertedCustomHUD = 0.03

local enabledBeat = true
local enableCustomBeat = true
local enableInverted = true
local enableCustomInverted = true

local enabledSystem = true

function onCreate()
    if songName == "Reactor"  then
        setBeatValue(0.015,0.05,true,true)
    elseif songName == "Danger" then
        setBeatValue(0.025,0.05,true,true)
        setInvertedBeat(0.0125,0.0125,true,false)
        BeatStrentghInvertedCustomGame = BeatStrentghCustomGame/6
        BeatStrentghInvertedCustomHUD = BeatStrentghCustomHUD/4
    elseif songName == "Double Kill" then
        setBeatValue(0.04,0.06,true,true)
        BeatStrentghInvertedCustomGame = BeatStrentghCustomGame/4
        BeatStrentghInvertedCustomHUD = BeatStrentghCustomHUD/3
    elseif songName == 'Ashes' or songName == 'Magmatic' or songName == 'Delusion' or songName == 'Finale Old' then
        setBeatValue(0.03,0.04,true,true)
        if songName == 'Delusion' then
            setProperty('camZooming',true)
            InvertedSection = 8
            replaceArrayInvertedCustomBeat(1,4)
        end
    elseif songName == 'Blackout' then
        setBeatValue(0.04,0.05,true,true)
        replaceArrayInvertedBeat(1,4)
        BeatStrentghInvertedCustomGame = BeatStrentghCustomGame/3
        BeatStrentghInvertedCustomHUD = BeatStrentghCustomHUD/3
    elseif songName == "Neurotic" then
        setBeatValue(0.04,0.05,true,true)
        setInvertedBeat(BeatStrentghCustomGame/3,BeatStrentghCustomHUD/3,true,true)
    elseif songName == 'Heartbeat' then
        setProperty('camZooming',true)
        BeatStrentghInvertedCustomGame = BeatStrentghCustomGame/2
        BeatStrentghInvertedCustomHUD = BeatStrentghCustomHUD/2
    elseif songName == 'Spookpostor' then
        BeatStrentghInvertedCustomGame = BeatStrentghCustomGame/3
        BeatStrentghInvertedCustomHUD = BeatStrentghCustomHUD/3
    elseif songName == 'Esculent' then
        setBeatValue(0.03,0.05,true,true)
        BeatStrentghInvertedCustomGame = BeatStrentghCustomGame/3
        BeatStrentghInvertedCustomHUD = BeatStrentghCustomHUD/3
    elseif songName == 'Monotone Attack' then
        setBeatValue(0.02,0.06,true,true)
        BeatStrentghInvertedCustomGame = BeatStrentghCustomGame/3
        BeatStrentghInvertedCustomHUD = BeatStrentghCustomHUD/3
    elseif songName == 'Torture' then
        setBeatValue(0.04,0.06,true,false)
    end
    if songName == 'Ashes' or songName == 'Magmatic' then
        BeatStrentghInvertedCustomGame = BeatStrentghCustomGame/2.5
        BeatStrentghInvertedCustomHUD = BeatStrentghCustomHUD/2.5
    end
end
function onCreatePost()
    if getProperty('cameraSpeed') == 1 then
        setProperty('cameraSpeed',1.1)
    end
end
function onStepHit()
    if enabledSystem then
        enableCustomBeat = true
        enabledBeat = true
        enableInverted = true
        enableCustomInverted = true
        if cannotBeat[1] ~= nil then
            for cannotBeatLength = 1,#cannotBeat do
                if cannotBeat[cannotBeatLength] ~= nil then
                    if cannotBeatInt == true and curBeat % cannotBeat[cannotBeatLength] == 0 or cannotBeatInt == false and (curStep/4) % cannotBeat[cannotBeatLength] == 0 then
                        enabledBeat = false
                    end
                end
            end
        end
        if cannotBeatCustom[1] ~= nil then
            for cannotBeatCustomLength = 1,#cannotBeatCustom do
                if cannotBeatCustom[cannotBeatCustomLength] ~= nil then
                    if (curStep/4) % cannotBeatSection == cannotBeatCustom[cannotBeatCustomLength] then
                        enableCustomBeat = false
                    end
                end
            end
        end
        if cannotBeatInverted[1] ~= nil then
            for cannotBeatInverLength = 1,#cannotBeatInverted do
                if cannotBeatInverted[cannotBeatInverLength] ~= nil then
                    if cannotBeatIntInverted == true and curBeat % cannotBeatInverted[cannotBeatInverLength] == 0 or cannotBeatIntInverted == false and (curStep/4) % cannotBeatInverted[cannotBeatInverLength] == 0 then
                        enableInverted = false
                    end
                end
            end
        end
        if cannotBeatCustomInverted[1] ~= nil then
            for cannotBeatCustomInvertedLength = 1,#cannotBeatInverted do
                if cannotBeatCustomInverted[cannotBeatCustomInvertedLength] ~= nil then
                    if cannotBeatIntInverted == true and curBeat % cannotBeatSection == cannotBeatCustomInverted[cannotBeatCustomInvertedLength] or cannotBeatIntInverted == false and (curStep/4) % cannotBeatSection == cannotBeatCustomInverted[cannotBeatCustomInvertedLength] then
                        enableCustomInverted = false
                    end
                end
            end
        end
        if enabledBeat == true and BeatPorcent[1] ~= nil then
            for BeatsHit = 1,#BeatPorcent do
                if BeatPorcent[BeatsHit] ~= nil then
                    if (curStep/4) % BeatPorcent[BeatsHit] == 0 then
                        triggerEvent('Add Camera Zoom',BeatStrentghGame,BeatStrentghHUD)
                    end
                end
            end
        end
        if enableCustomBeat == true and BeatCustomPorcent[1] ~= nil then
            for BeatsCustomHit = 1,#BeatCustomPorcent do
                if BeatCustomPorcent[BeatsCustomHit] ~= nil then
                    if (curStep/4) % Section == BeatCustomPorcent[BeatsCustomHit] then
                        triggerEvent('Add Camera Zoom',BeatStrentghCustomGame,BeatStrentghCustomHUD)
                    end
                end
            end
        end
        if enableInverted == true and invertedBeat[1] ~= nil then
            for invertedHit = 1,#invertedBeat do
                if invertedBeat[invertedHit] ~= nil then
                    if (curStep/4) % invertedBeat[invertedHit] == 0 then
                        triggerEvent('Add Camera Zoom',BeatStrentghInvertedGame * -1,BeatStrentghInvertedHUD * -1)
                    end
                end
            end
        end
        if enableCustomInverted == true and invertedCustomBeat[1] ~= nil then
            for invertedCustomHit = 1,#invertedCustomBeat do
                if invertedCustomBeat[invertedCustomHit] ~= nil then
                    if (curStep/4) % InvertedSection == invertedCustomBeat[invertedCustomHit] then
                        triggerEvent('Add Camera Zoom',BeatStrentghInvertedCustomGame * -1,BeatStrentghInvertedCustomHUD * -1)
                    end
                end
            end
        end
        --Songs
        if songName == "Sussus-Moogus" then
            if curStep == 383 or curStep == 1279 then
                Section = 8
                replaceArrayCustomBeat(1,1.5)
                replaceArrayInvertedBeat(1,2)
                replaceArrayCustomBeat(2,3)
                replaceArrayCustomBeat(3,4.5)
                replaceArrayCustomBeat(4,5.5)
                replaceArrayCustomBeat(5,7)
                replaceArrayCustomBeat(6,8)
            elseif curStep == 639 then
                clearCustomBeat()
                Section = 8
                replaceArrayCustomBeat(1,1.5)
                replaceArrayInvertedBeat(1,2)
                replaceArrayCustomBeat(2,3)
                replaceArrayCustomBeat(3,4)
                replaceArrayCustomBeat(4,5)
                replaceArrayCustomBeat(5,8)
            elseif curStep == 896 or curStep == 1535 then
                clearCustomBeat()
                clearInvertedBeat()
            end
        elseif songName == "Meltdown" then
            if curStep == 639 then
                replaceArrayBeat(1,1)
            elseif curStep == 760 then
                clearBeat()
            end
        elseif songName == 'Lights Down' then
            if curStep == 128 or curStep == 511 or curStep == 961 then
                replaceArrayCustomBeat(1,2)
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 240 or curStep == 624 or curStep == 1216 then
                clearCustomBeat()
            elseif curStep == 255 or curStep == 639 or curStep == 959 or curStep == 1215 then
                clearInvertedBeat()
            elseif curStep == 768 then
                replaceArrayBeat(1,2)
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 831 then
                clearBeat()
                clearInvertedBeat()
            elseif curStep == 1472 then
                replaceArrayBeat(1,1)
            elseif curStep == 1602 then
                clearBeat()
                setProperty('camZooming',false)
            end
        elseif songName == "Reactor" then
            if curStep == 127 then
                Section = 8
                setProperty('camZooming',true)
                replaceArrayInvertedBeat(1,4)
                replaceArrayCustomBeat(1,8)
            elseif curStep == 239 or curStep == 1536 then
                clearCustomBeat()
                replaceArrayBeat(1,2)
            elseif curStep == 512 or curStep == 1280 or curStep == 1920 or curStep == 2176 then
                replaceArrayBeat(1,1)
            elseif curStep == 768 then
                clearBeat()
                replaceArrayCustomBeat(1,1.75)
                replaceArrayCustomBeat(2,2)
                replaceArrayCustomBeat(3,3)
                replaceArrayCustomBeat(4,4)
            elseif curStep == 1264 then
                clearCustomBeat()
            elseif curStep == 496 or curStep == 1792 or curStep == 2145 then
                clearBeat()
            elseif curStep == 2688 then
                clearBeat()
                Section = 16
                InvertedSection = 16
                replaceArrayInvertedBeat(1,4)
                replaceArrayInvertedCustomBeat(1,0)
                replaceArrayInvertedCustomBeat(2,6)
                replaceArrayCustomBeat(1,3)
                replaceArrayCustomBeat(2,4)
                replaceArrayCustomBeat(3,10)
                replaceArrayCustomBeat(4,11)
                replaceArrayCustomBeat(5,11.5)
                replaceArrayCustomBeat(6,11.75)
                replaceArrayCustomBeat(7,12)
                replaceArrayCustomBeat(8,14)
            elseif curStep == 2815 then
                clearCustomBeat()
                clearInvertedCustomBeat()
            end
        elseif songName == 'ejected' then
            if curStep == 256 or curStep == 510 or curStep == 768 or curStep == 1536 or curStep == 1792 then
                Section = 4
                replaceArrayCustomBeat(1,1)
                replaceArrayCustomBeat(2,1.5)
                replaceArrayCustomBeat(3,2)
                replaceArrayCustomBeat(4,3)
                replaceArrayCustomBeat(5,4)
            elseif curStep == 496 or curStep == 736 or curStep == 992 or curStep == 1759 then
                clearCustomBeat()
            elseif curStep == 1024 or curStep == 2304 then
                clearCustomBeat()
                Section = 8
                replaceArrayCustomBeat(1,8)
                replaceArrayInvertedBeat(1,4)
            end
        elseif songName == 'Mando' then
            if curStep == 1 then
                replaceArrayInvertedBeat(1,4)
                replaceArrayCustomBeat(1,2)
            elseif curStep == 240 then
                clearCustomBeat()
                clearInvertedBeat()
            elseif curStep == 255 then
                Section = 4
                replaceArrayCustomBeat(1,1.5)
                replaceArrayCustomBeat(2,2)
                replaceArrayCustomBeat(3,3)
            elseif curStep == 1856 then
                clearCustomBeat()
                replaceArrayInvertedBeat(1,4)
            end
        elseif songName == "Dlow" then
            if curStep == 63 then
                replaceArrayCustomBeat(1,1)
                replaceArrayCustomBeat(2,3)
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 112 then
                clearInvertedBeat()
                clearCustomBeat()
            elseif curStep == 271 then
                Section = 8
                replaceArrayCustomBeat(1,4)
                replaceArrayCustomBeat(2,5.5)
                replaceArrayCustomBeat(3,7)
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 382 or curStep == 892 then
                clearCustomBeat()
                replaceArrayBeat(1,1)
            elseif curStep == 640 or curStep == 1152 then
                clearBeat()
            end
        elseif songName == 'Oversight' then
            if curStep == 1 or curStep == 640 then
                InvertedSection = 4
                replaceArrayInvertedCustomBeat(1,4)
            elseif curStep == 15 or curStep == 671 then
                clearInvertedCustomBeat()
            elseif curStep == 64   then
                replaceArrayCustomBeat(1,2)
            elseif curStep == 112 or curStep == 704 then
                replaceArrayBeat(1,1)
            elseif curStep == 120 or curStep == 125 or curStep == 760 or curStep == 765 then
                replaceArrayBeat(1,0.5)
            elseif curStep == 123 or curStep == 763  then
                replaceArrayBeat(1,0.25)
            elseif curStep == 128 or curStep == 511 or curStep == 768 then
                clearBeat()
                replaceArrayCustomBeat(1,1)
                replaceArrayCustomBeat(2,3)
                replaceArrayCustomBeat(3,4)
                replaceArrayInvertedCustomBeat(3,4)
            elseif curStep == 496 or curStep == 639 or curStep == 1008 then
                clearCustomBeat()
            end
        elseif songName == "Danger" then
            if curStep == 127 or curStep == 1216 then
                replaceArrayCustomBeat(1,1.5)
                replaceArrayCustomBeat(2,3)
                replaceArrayCustomBeat(3,4)
            elseif curStep == 239 or curStep == 1263 then
                replaceArrayInvertedCustomBeat(1,1)
                replaceArrayInvertedCustomBeat(2,2.5)
                replaceArrayInvertedCustomBeat(3,4)
            elseif curStep == 255 or curStep == 1279 then
                clearCustomBeat()
                clearInvertedCustomBeat()
                replaceArrayCustomBeat(1,1)
                replaceArrayCustomBeat(2,2.5)
                replaceArrayInvertedCustomBeat(1,1.5)
                replaceArrayInvertedCustomBeat(2,3)
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 1151 or curStep == 1663 then
                clearCustomBeat()
                clearInvertedCustomBeat()
            end
        elseif songName == "Double Kill" then
            if curStep == 143 or curStep == 527 or curStep == 1696 or curStep == 2223 then
                replaceArrayCustomBeat(1,1.5)
                replaceArrayInvertedCustomBeat(1,1)
                replaceArrayInvertedCustomBeat(2,2.5)
                replaceArrayCustomBeat(2,3)
                replaceArrayCustomBeat(3,4)
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 256 or curStep == 512 or curStep == 1168 or curStep == 2208 or curStep == 3392 then
                clearCustomBeat()
                clearInvertedCustomBeat()
                clearInvertedBeat()
            elseif curStep == 272 or curStep == 1041 then
                clearInvertedCustomBeat()
                Section = 8
                replaceArrayInvertedCustomBeat(1,2)
                replaceArrayInvertedBeat(1,4)
                replaceArrayCustomBeat(1,4)
                replaceArrayCustomBeat(2,1)
                replaceArrayCustomBeat(3,7)
            end
        elseif songName == "Defeat" then
            if curStep == 271 or curStep == 399 then
                replaceArrayCustomBeat(1,1.5)
                replaceArrayCustomBeat(2,3)
                replaceArrayCustomBeat(3,3.5)
            elseif curStep == 783 or curStep == 1695 then
                replaceArrayBeat(1,1)
            elseif curStep == 1423 then
                replaceArrayCustomBeat(1,1)
                replaceArrayInvertedCustomBeat(1,2)
                replaceArrayCustomBeat(3,2.5)
                replaceArrayInvertedCustomBeat(2,3)
                replaceArrayCustomBeat(4,3.5)
            elseif curStep == 1440 then
                clearInvertedCustomBeat()
                replaceArrayCustomBeat(1,1.5)
                replaceArrayCustomBeat(2,3)
                replaceArrayCustomBeat(3,3.5)
            elseif curStep == 1039 or curStep == 1952 then
                clearBeat()
            elseif curStep == 383 or curStep == 768 or curStep == 1679 then
                clearCustomBeat()
            end
        elseif songName == 'Finale' then
            if curStep == 267 or curStep == 1211 or curStep == 1435 then
                replaceArrayBeat(1,0.25)
            elseif curStep == 272 or curStep == 592 or curStep == 1360 or curStep == 1440 or curStep == 1504 or curStep == 1632 or curStep == 1824 then
                replaceArrayBeat(1,1)
            elseif curStep == 653 then
                Section = 8
                clearBeat()
                replaceArrayInvertedBeat(1,4)
                replaceArrayCustomBeat(1,2)
                replaceArrayCustomBeat(2,4)
                replaceArrayCustomBeat(3,7)
                replaceArrayCustomBeat(4,8)
            elseif curStep == 448 or curStep == 576 or curStep == 1216 or curStep == 1344 or curStep == 1488 or curStep == 1616 then
                clearBeat()
                replaceArrayCustomBeat(1,1.5)
                replaceArrayCustomBeat(2,3)
                clearInvertedBeat()
            elseif curStep == 464 or curStep == 1103 or curStep == 1232 then
                clearCustomBeat()
                replaceArrayBeat(1,1)
            elseif curStep == 912 then
                clearCustomBeat()
                clearBeat()
                Section = 8
                replaceArrayCustomBeat(1,1.75)
                replaceArrayCustomBeat(2,3.25)
                replaceArrayCustomBeat(3,4)
                replaceArrayCustomBeat(4,6)
                replaceArrayCustomBeat(5,8)
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 1136 then
                replaceArrayBeat(1,0.5)
            elseif curStep == 1168 or curStep == 1422 then
                clearBeat()
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 1695 then
                clearCustomBeat()
                clearBeat()
                Section = 8
                replaceArrayCustomBeat(1,3)
                replaceArrayCustomBeat(2,4)
                replaceArrayCustomBeat(3,6)
                replaceArrayCustomBeat(4,8)
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 1808 then
                clearCustomBeat()
            elseif curStep == 1952 then
                replaceArrayBeat(1,2)
            elseif curStep == 1984 then
                clearBeat()
            end
        elseif songName == 'Turbulence' then
            if curStep == 160 or curStep == 816 then
                replaceArrayBeat(1,1)
                Section = 8
                InvertedSection = 8
                BeatStrentghInvertedCustomGame = BeatStrentghCustomGame/3
                BeatStrentghInvertedCustomHUD = BeatStrentghCustomHUD/3
                replaceArrayInvertedCustomBeat(1,3.5)
                replaceArrayInvertedCustomBeat(2,3.75)
                replaceArrayCustomBeat(1,7.5)
            elseif curStep == 800 or curStep == 1208 then
                clearBeat()
                clearCustomBeat()
                clearInvertedCustomBeat()
            end
        elseif songName == 'Identity Crisis' then
            if curStep == 384 or curStep == 2400 then
                Section = 8
                replaceArrayCustomBeat(1,4)
                replaceArrayCustomBeat(2,5)
                replaceArrayCustomBeat(3,6)
                replaceArrayCustomBeat(4,7)
                replaceArrayCustomBeat(5,7.5)
                replaceArrayCustomBeat(6,8)
            elseif curStep == 448 then
                clearCustomBeat()
                replaceArrayBeat(1,2)
            elseif curStep == 480 or curStep == 640 or curStep == 1184 or curStep == 1984 or curStep == 2815 then
                replaceArrayBeat(1,1)
            elseif curStep == 504 or curStep == 896 or curStep == 1440 or curStep == 2399 or curStep == 3328 then
                clearBeat()
            elseif curStep == 668 then
                clearCustomBeat()
            elseif curStep == 1695 then
                Section = 16
                replaceArrayInvertedBeat(1,4)
                replaceArrayCustomBeat(1,0)
                replaceArrayCustomBeat(2,1)
                replaceArrayCustomBeat(3,4)
                replaceArrayCustomBeat(4,5.5)
                replaceArrayCustomBeat(5,7)
                replaceArrayCustomBeat(6,8)
                replaceArrayCustomBeat(7,9)
                replaceArrayCustomBeat(8,15.5)
                replaceArrayCustomBeat(9,15.75)
            elseif curStep == 1823 then
                clearCustomBeat()
                clearInvertedCustomBeat()
                Section = 8
                InvertedSection = 8
                BeatStrentghInvertedCustomGame = 0.005
                BeatStrentghInvertedCustomHUD = 0.005
                replaceArrayCustomBeat(1,1.75)
                replaceArrayCustomBeat(2,3)
                replaceArrayCustomBeat(3,4)
                replaceArrayInvertedBeat(1,4)
                replaceArrayCustomBeat(4,5.5)
                replaceArrayCustomBeat(5,7)
                replaceArrayCustomBeat(6,7.5)
                replaceArrayInvertedCustomBeat(1,2.25)
                replaceArrayInvertedCustomBeat(2,2.5)
            elseif curStep == 1888 then
                clearInvertedCustomBeat()
                clearInvertedBeat()
                clearCustomBeat()
                replaceArrayCustomBeat(1,1.5)
                replaceArrayCustomBeat(2,3)
            elseif curStep == 1952 then
                clearCustomBeat()
                clearInvertedCustomBeat()
                setInvertedBeat(0.015,0.03,false,true)
            elseif curStep == 2272 then
                InvertedSection = 8
                Section = 8
                replaceArrayBeat(1,1)
                replaceArrayCustomBeat(1,8)
                replaceArrayInvertedCustomBeat(1,4)
            elseif curStep == 2528 then
                clearCustomBeat()
                InvertedSection = 8
                cannotBeatSection = 8
                BeatStrentghInvertedCustomGame = 0.01
                BeatStrentghInvertedCustomHUD = 0.005
                replaceArrayCustomBeat(1,1.5)
                replaceArrayCustomBeat(2,3)
                replaceArrayCustomBeat(3,4)
                replaceArrayCustomCannotBeat(1,6)
                replaceArrayInvertedCustomBeat(1,6.5)
                replaceArrayInvertedCustomBeat(2,6.75)
            elseif curStep == 2657 then
                clearCustomBeat()
                clearCustomCannotBeat()
                clearInvertedCustomBeat()
            elseif curStep == 2776 then
                clearBeat()
                clearInvertedCustomBeat()
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 2809 then
                clearInvertedBeat()
            end
        elseif songName == 'Ashes' then
            if curStep == 1 then
                Section = 8
                setBeatValue(0.015,0.03,true,true)
                replaceArrayCustomBeat(1,4.5)
            elseif curStep == 83 or curStep == 1250 then
                clearCustomBeat()
                setBeatValue(0.03,0.04,true,true)
                replaceArrayCustomBeat(1,2)
            elseif curStep == 113 or curStep == 384 or curStep == 1280 or curStep == 1296 then
                clearCustomBeat()
                clearInvertedCustomBeat()
                replaceArrayBeat(1,1)
            elseif curStep == 120 or curStep == 392 or curStep == 1159 or curStep == 1288 then
                replaceArrayBeat(1,0.5)
            elseif curStep == 126 or curStep == 398 or curStep == 1166 or curStep == 1294 then
                replaceArrayBeat(1,0.25)
            elseif curStep == 128 or curStep == 400 then
                clearBeat()
                Section = 8
                replaceArrayCustomBeat(1,1)
                replaceArrayInvertedCustomBeat(1,1.5)
                replaceArrayCustomBeat(2,2.5)
                replaceArrayInvertedCustomBeat(2,3)
                replaceArrayCustomBeat(3,4)
                replaceArrayCustomBeat(4,5)
                replaceArrayCustomBeat(5,6.5)
                replaceArrayCustomBeat(6,7.5)
                replaceArrayCustomBeat(7,7.75)
                replaceArrayCustomBeat(8,8)
            elseif curStep == 1152 then
                clearCustomBeat()
                clearInvertedCustomBeat()
            elseif curStep == 1 or curStep == 1168  then
                clearBeat()
                Section = 8
                setBeatValue(0.015,0.03,true,true)
                replaceArrayCustomBeat(1,0.5)
            elseif curStep == 1307 then
                clearBeat()
                replaceArrayInvertedBeat(1,4)
            end
        elseif songName == 'Magmatic' then
            if curStep == 94 or curStep == 479 or curStep == 1119 then
                replaceArrayInvertedCustomBeat(1,1)
                replaceArrayCustomBeat(1,2.5)
                replaceArrayInvertedCustomBeat(2,3)
                replaceArrayCustomBeat(2,4)
            elseif curStep == 416 or curStep == 1056 or curStep == 1184 then
                clearCustomBeat()
                clearInvertedCustomBeat()
            end
        elseif songName == 'Boiling Point' then
            if curStep == 1 then
                replaceArrayBeat(1,1)
            elseif curStep == 96 then
                replaceArrayBeat(1,0.5)
            elseif curStep == 120 then
                replaceArrayBeat(1,1)
                replaceArrayInvertedBeat(1,0.5)
            elseif curStep == 128 then
                clearInvertedBeat()
                replaceArrayBeat(1,1)
            elseif curStep == 2208 then
                clearBeat()
            end
        elseif songName == 'Delusion' then
            if curStep == 94 then
                clearInvertedCustomBeat()
            elseif curStep == 95 or curStep == 159 or curStep == 543 or curStep == 862 or curStep == 927 then
                replaceArrayBeat(1,1)
            elseif curStep == 144 or curStep == 408 or curStep == 768 or curStep == 912 or curStep == 1048 then
                clearBeat()
            end
        elseif songName == 'Blackout' then
            if curStep == 1  then
                setBeatValue(0.015,0.03,false,true)
                replaceArrayCustomBeat(1,1)
                replaceArrayCustomBeat(2,2.5)
            elseif curStep == 256 then
                clearCustomBeat()
                setBeatValue(0.04,0.05,false,true)
            elseif curStep == 528 or curStep == 688 or curStep == 1344 or curStep == 1648 then
                clearCustomBeat()
            elseif curStep == 752 or curStep == 1711 then
                replaceArrayBeat(1,1)
            elseif curStep == 831 or curStep == 272 then
                replaceArrayCustomBeat(1,1)
                replaceArrayCustomBeat(2,3)
            elseif curStep == 560 then
                replaceArrayCustomBeat(1,3)
            elseif curStep == 816 or curStep == 1466 or curStep == 1936 then
                clearBeat()
            elseif curStep == 1343 then
                replaceArrayBeat(1,2)
            elseif curStep == 1520 then
                setBeatValue(0,0.03,false,true)
                replaceArrayCustomBeat(1,1)
                replaceArrayCustomBeat(2,3)
            end
        elseif songName == "Neurotic" then
            if curStep == 128 or curStep == 1440 then
                Section = 8
                setBeatValue(0.035,0.04,true,true)
                replaceArrayInvertedCustomBeat(1,2)
                replaceArrayCustomBeat(1,3)
                replaceArrayCustomBeat(2,5.5)
                replaceArrayCustomBeat(3,7)
            elseif curStep == 248 then
                setBeatValue(0.05,0.04,true,true)
                clearCustomBeat()
                clearInvertedCustomBeat()
            elseif curStep == 272 then
                replaceArrayBeat(1,2)
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 400 or curStep == 784 then
                clearBeat()
                clearInvertedBeat()
                Section = 8
                replaceArrayInvertedCustomBeat(1,2)
                replaceArrayCustomBeat(1,3)
                replaceArrayCustomBeat(2,4)
                replaceArrayCustomBeat(3,5.5)
                replaceArrayCustomBeat(4,7)
                replaceArrayCustomBeat(5,8)
            elseif curStep == 526 or curStep == 1567 then
                clearCustomBeat()
                clearInvertedCustomBeat()
                replaceArrayBeat(1,1)
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 777 then
                clearBeat()
                clearInvertedBeat()
            elseif curStep == 1037 then
                clearCustomBeat()
                clearInvertedCustomBeat()
            elseif curStep == 2094 then
                clearBeat()
                setInvertedBeat(0.015,0.03,true,true)
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 1168 then
                InvertedSection = 16
                Section = 16
                replaceArrayBeat(1,2)
                replaceArrayInvertedBeat(1,4)
                setBeatValue(0.03,0.015,false,true)
                replaceArrayInvertedCustomBeat(1,11)
                replaceArrayInvertedCustomBeat(2,11.5)
                replaceArrayInvertedCustomBeat(3,2.5)
                replaceArrayCustomBeat(1,3)
                replaceArrayInvertedCustomBeat(4,3.5)
            elseif curStep == 1297 or curStep == 1438 then
                clearCustomBeat()
                clearInvertedCustomBeat()
                clearInvertedBeat()
                clearBeat()
            elseif curStep == 1312 then
                InvertedSection = 16
                Section = 16
                replaceArrayBeat(1,2)
                replaceArrayInvertedBeat(1,4)
                setBeatValue(0.03,0.015,false,true)
                replaceArrayInvertedCustomBeat(1,15)
                replaceArrayInvertedCustomBeat(2,15.5)
                replaceArrayInvertedCustomBeat(3,6.5)
                replaceArrayCustomBeat(1,7)
                replaceArrayInvertedCustomBeat(4,7.5)
            end
        elseif songName ==  'Heartbeat' then
            if curStep == 1 or curStep == 416 or curStep == 672 then
                clearBeat()
                replaceArrayCustomBeat(1,0.75)
                replaceArrayInvertedCustomBeat(1,1)
                replaceArrayCustomBeat(2,1.5)
                replaceArrayCustomBeat(3,2.5)
                replaceArrayInvertedCustomBeat(2,3)
            elseif curStep == 272 or curStep == 528 or curStep ==   800 then
                clearCustomBeat()
                clearInvertedCustomBeat()
            elseif curStep == 287 or curStep == 543 then
                replaceArrayBeat(1,1)
            elseif curStep == 606 or curStep == 639 then
                clearBeat()
                BeatStrentghCustomGame = 0.03
                BeatStrentghCustomHUD = 0.06
                replaceArrayCustomBeat(1,1)
                replaceArrayCustomBeat(2,3)
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 623 or curStep == 655 then
                setBeatValue(0.015,0.03,false,true)
                clearInvertedBeat()
                replaceArrayBeat(1,1)
            end
        elseif songName == "Pinkwave" then
            if curStep == 8 then
                Section = 8
                replaceArrayCustomBeat(1,2)
                replaceArrayCustomBeat(2,7)
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 139 or curStep == 391 or curStep == 519 or curStep == 1031 or curStep == 1287 then
                clearCustomBeat()
                replaceArrayBeat(1,1)
            elseif curStep == 423 or curStep == 1319 or curStep == 1383 then
                clearBeat()
                BeatStrentghInvertedCustomGame = 0.0075
                BeatStrentghInvertedCustomHUD = 0.015
                replaceArrayCustomBeat(1,0.5)
                replaceArrayCustomBeat(2,0.75)
                replaceArrayCustomBeat(3,1)
                replaceArrayCustomBeat(4,1.5)
                replaceArrayCustomBeat(5,2)
                replaceArrayCustomBeat(6,2.75)
                replaceArrayInvertedCustomBeat(1,2.5)
                replaceArrayCustomBeat(7,3.5)
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 455 or curStep == 1351 then
                clearCustomBeat()
                clearInvertedCustomBeat()
                replaceArrayBeat(1,1)
            elseif curStep == 887 then
                clearBeat()
                Section = 8
                replaceArrayCustomBeat(1,2)
                replaceArrayCustomBeat(2,7)
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 384 or curStep == 512 or curStep == 1272 then
                clearBeat()
            elseif curStep == 1415 then
                clearCustomBeat()
                clearInvertedCustomBeat()
            end
        elseif songName == 'Pretender' then
            if curStep == 240 or curStep == 272 or curStep == 288 or curStep == 1296 or curStep == 1331 or curStep == 1344 or curStep == 1616 or curStep == 1632 then
                replaceArrayBeat(1,1)
            elseif curStep == 248 or curStep == 281 or curStep == 1304 or curStep == 1336 or curStep == 1623 then
                replaceArrayBeat(1,0.5)
            elseif curStep == 251 or curStep == 283 or curStep == 1307 or curStep == 1340 or curStep == 1627 then
                replaceArrayBeat(1,0.25)
            elseif curStep == 256 or curStep == 1057 or curStep == 1311 or curStep == 1600 or curStep == 2144 then
                clearBeat()
            elseif curStep == 545 then
                clearBeat()
                Section = 16
                InvertedSection = 16
                replaceArrayCustomBeat(1,0.5)
                replaceArrayInvertedCustomBeat(1,1)
                replaceArrayCustomBeat(2,1.5)

                replaceArrayInvertedCustomBeat(2,5)
                replaceArrayCustomBeat(3,6)
                replaceArrayCustomBeat(4,6.5)
                replaceArrayInvertedCustomBeat(3,7)
                replaceArrayCustomBeat(5,7.5)

                replaceArrayCustomBeat(6,8.5)
                replaceArrayInvertedCustomBeat(4,9)
                replaceArrayCustomBeat(7,9.5)

                replaceArrayCustomBeat(8,12.5)
                replaceArrayInvertedCustomBeat(5,13)
                replaceArrayCustomBeat(9,13.5)
            elseif curStep == 800 then
                clearCustomBeat()
                clearInvertedCustomBeat()
                replaceArrayBeat(1,1)
            elseif curStep == 2432 then
                replaceArrayCustomBeat(1,1.5)
                replaceArrayCustomBeat(2,3)
                replaceArrayInvertedCustomBeat(1,4)
            elseif curStep == 2453 then
                clearCustomBeat()
            end
        elseif songName == 'Spookpostor' then
            if curStep == 63 then
                replaceArrayCustomBeat(1,1)
                replaceArrayInvertedBeat(1,2)
                replaceArrayCustomBeat(2,3)
                replaceArrayCustomBeat(3,4)
            elseif curStep == 304 then
                clearCustomBeat()
                clearInvertedBeat()
            elseif curStep == 319 or curStep == 703 or curStep == 1615 then
                replaceArrayCustomBeat(1,0.5)
                replaceArrayInvertedCustomBeat(1,1)
                replaceArrayCustomBeat(2,1.5)
                replaceArrayCustomBeat(3,2)
                replaceArrayCustomBeat(4,2.5)
                replaceArrayInvertedCustomBeat(2,3)
            elseif curStep == 688 or curStep == 1600 then
                clearCustomBeat()
                clearInvertedCustomBeat()
            elseif curStep == 960 then
                clearCustomBeat()
                clearInvertedCustomBeat()
                Section = 8
                replaceArrayCustomBeat(1,0)
                replaceArrayCustomBeat(2,3)
                replaceArrayInvertedBeat(1,2)
                replaceArrayCustomBeat(3,5)
            elseif curStep == 1088 then
                clearCustomBeat()
                clearInvertedBeat()
                replaceArrayBeat(1,2)
            elseif curStep == 1343 then
                clearBeat()
                Section = 1
                replaceArrayCustomBeat(1,0.75)
                replaceArrayInvertedCustomBeat(1,1)
                replaceArrayInvertedCustomBeat(2,3)
            elseif curStep == 1875 then
                clearCustomBeat()
                clearInvertedCustomBeat()
                replaceArrayInvertedBeat(1,4)
            end
        elseif songName == 'Sussy Bussy' then
            if curStep == 7 or curStep == 168 then
                replaceArrayInvertedBeat(1,4)
                replaceArrayCustomBeat(1,1)
                replaceArrayCustomBeat(2,3)
            elseif curStep == 136 or curStep == 295 then
                clearCustomBeat()
            elseif curStep == 296 or curStep == 359 or curStep == 423 or curStep == 487 or curStep == 840 or curStep == 904 then
                replaceArrayBeat(1,1)
            elseif curStep == 416 or curStep == 479 or curStep == 552 or curStep == 896 then
                clearBeat()
            end
        elseif songName == 'Titular' then
            if curStep == 64 or curStep == 511 or curStep == 543 then
                replaceArrayBeat(1,1)
            elseif curStep == 352 or curStep == 384 or curStep == 536 or curStep == 727 then
                clearBeat()
            end
        elseif songName == 'Greatest Plan' then
            if curStep == 31 or curStep == 64 or curStep == 832 then
                replaceArrayBeat(1,1)
            elseif curStep == 48 then
                replaceArrayBeat(1,0.5)
            elseif curStep == 56 or curStep == 688 or curStep == 1285 then
                clearBeat()
            end
        elseif songName == "Reinforcements" then
            if curStep == 159 or curStep == 256 or curStep == 703 or curStep == 992 then
                replaceArrayBeat(1,1)
            elseif curStep == 244  or curStep == 960 or curStep== 1086 then
                clearBeat()
            elseif curStep == 638 then
                clearBeat()
                clearCustomBeat()
            elseif curStep == 511 or curStep == 704 then
                Section = 8
                replaceArrayInvertedBeat(1,4)
                replaceArrayCustomBeat(1,1)
                replaceArrayCustomBeat(2,2)
                replaceArrayCustomBeat(3,3)
                replaceArrayCustomBeat(4,6)
                replaceArrayCustomBeat(5,7)
                replaceArrayCustomBeat(6,8)
            elseif curStep == 1216 then
                clearCustomBeat()
            end
        elseif songName == 'Monotone Attack' then
            if curStep == 64 or curStep == 1507  then
                replaceArrayBeat(1,1)
            elseif curStep == 1440 then
                replaceArrayBeat(1,1)
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 527 then
                replaceArrayCustomBeat(1,1)
                replaceArrayCustomBeat(2,3)
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 655 or curStep == 783 or curStep == 912 or curStep == 1200 then
                replaceArrayCustomBeat(1,1.5)
                replaceArrayCustomBeat(2,2.5)
                replaceArrayCustomBeat(3,4)
                replaceArrayInvertedCustomBeat(1,1)
                replaceArrayInvertedCustomBeat(2,3)
            elseif curStep == 903 then
                clearCustomBeat()
            elseif curStep == 384 or curStep == 768 or curStep == 1502 or curStep == 1561 then
                clearBeat()
            elseif curStep == 640 then
                clearCustomBeat()
                clearInvertedBeat()
            elseif curStep == 1152 or curStep == 903 or curStep == 1424 then
                clearCustomBeat()
                clearInvertedCustomBeat()
            end
        elseif songName == "Who" then
            if curStep == 480 or curStep == 1920 then
                replaceArrayBeat(1,1)
            elseif curStep == 496 then
                replaceArrayBeat(1,0.5)
            elseif curStep == 512 then
                clearBeat()
            end
        elseif songName == 'Drippypop' then
            if curStep == 510 then
                replaceArrayBeat(1,1)
            elseif curStep == 576 then
                replaceArrayBeat(1,0.5)
            elseif curStep == 608 then
                replaceArrayBeat(1,0.25)
            elseif curStep == 623 then
                clearBeat()
            end
        elseif songName == 'Esculent' then
            if curStep == 256 or curStep == 1664 then
                replaceArrayBeat(1,2)
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 1024 then
                Section = 16
                replaceArrayBeat(1,4)
                replaceArrayCustomBeat(1,5)
                replaceArrayCustomBeat(2,5.5)
                replaceArrayInvertedBeat(1,2)
                replaceArrayCustomBeat(3,7)
                replaceArrayCustomBeat(5,9)
                replaceArrayCustomBeat(6,11)
                replaceArrayCustomBeat(7,11.5)
                replaceArrayCustomBeat(8,13)
                replaceArrayCustomBeat(9,15)
            elseif curStep == 1264 then
                clearCustomBeat()
                clearInvertedBeat()
            elseif curStep == 767 or curStep == 1280 or curStep == 1920 then
                replaceArrayBeat(1,1)
            elseif curStep == 1408 or curStep == 2432 then
                replaceArrayInvertedBeat(1,4)
                clearBeat()
            end
        elseif songName == 'Chipping' then
            if curStep == 1 then
                InvertedSection = 8
                replaceArrayInvertedCustomBeat(1,4)
            elseif curStep == 32 then
                clearInvertedCustomBeat()
            elseif curStep == 64 or curStep == 384 then
                replaceArrayBeat(1,2)
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 96 then
                replaceArrayBeat(1,1)
            elseif curStep == 416 then
                clearBeat()
                clearInvertedBeat()
            elseif curStep == 700 then
                clearBeat()
            elseif curStep == 448 then
                setInvertedBeat(BeatStrentghCustomGame/2,BeatStrentghCustomHUD/2,false,true)
                replaceArrayCustomBeat(1,0.5)
                replaceArrayInvertedCustomBeat(1,1)
                replaceArrayCustomBeat(2,1.5)
                replaceArrayCustomBeat(3,2)
                replaceArrayCustomBeat(4,2.5)
                replaceArrayInvertedCustomBeat(2,3)
                replaceArrayCustomBeat(5,3.5)
                replaceArrayCustomBeat(6,3.75)
                replaceArrayCustomBeat(7,4)
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 672 then
                clearCustomBeat()
                clearInvertedCustomBeat()
                replaceArrayBeat(1,2)
            end
        elseif songName == 'Torture' then
            if curStep == 639 or curStep == 896 or curStep == 1408 then
                replaceArrayCustomBeat(1,2)
                replaceArrayInvertedBeat(1,4)
            elseif curStep == 879 or curStep == 1085 or curStep == 1472 then
                clearCustomBeat()
                clearInvertedBeat()
            elseif curStep == 959 or curStep == 1086 or curStep == 1215 then
                replaceArrayBeat(1,1)
            elseif curStep == 1008 then
                replaceArrayBeat(1,0.5)
            elseif curStep == 1017 or curStep == 1206 or curStep == 1342 then
                clearBeat()
            elseif curStep == 1344 then
                Section = 8
                replaceArrayCustomBeat(1,0)
                replaceArrayCustomBeat(2,1.5)
                replaceArrayCustomBeat(3,3)
                replaceArrayInvertedBeat(1,4)
                replaceArrayCustomBeat(4,5)
                setBeatValue(0.04,0.06,false,true)
            elseif curStep == 1407 then
                clearCustomBeat()
            end
        elseif songName == 'Finale Old' then
            if curStep == 1 or curStep == 2624 then
                InvertedSection = 8
                replaceArrayInvertedCustomBeat(1,4)
            elseif curStep == 543 then
                clearInvertedCustomBeat()
                replaceArrayInvertedBeat(1,4)
                replaceArrayBeat(1,2)
            elseif curStep == 560 then
                replaceArrayBeat(1,1)
            elseif curStep == 576 or curStep == 1344 or curStep == 2367 or curStep == 3199 or curStep == 3456 then
                clearBeat()
                clearInvertedCustomBeat()
                Section = 16
                replaceArrayInvertedBeat(1,4)
                replaceArrayCustomBeat(1,1)
                replaceArrayCustomBeat(2,3)
                replaceArrayCustomBeat(3,5)
                replaceArrayCustomBeat(4,7)
                replaceArrayCustomBeat(5,9)
                replaceArrayCustomBeat(6,11)
                replaceArrayCustomBeat(7,11.5)
                replaceArrayCustomBeat(8,13)
                replaceArrayCustomBeat(9,15)
                replaceArrayCustomBeat(10,15.5)
            elseif curStep == 3728 then
                clearBeat()
                clearInvertedCustomBeat()
                Section = 16
                replaceArrayInvertedBeat(1,4)
                replaceArrayCustomBeat(1,1)
                replaceArrayCustomBeat(2,3)
                replaceArrayCustomBeat(3,3.5)
                replaceArrayCustomBeat(4,5)
                replaceArrayCustomBeat(5,7)
                replaceArrayCustomBeat(6,9)
                replaceArrayCustomBeat(7,11)
                replaceArrayCustomBeat(8,13)
                replaceArrayCustomBeat(9,15)
                replaceArrayCustomBeat(10,15.5)
            elseif curStep == 572 then
                replaceArrayBeat(1,0.5)
            elseif curStep == 816 or curStep == 1328 or curStep == 1600 or curStep == 2623 or curStep == 3440 or curStep == 3712 then
                clearCustomBeat()
                clearInvertedBeat()
            elseif curStep == 1088 then
                Section = 16
                replaceArrayInvertedBeat(1,4)
                replaceArrayCustomBeat(1,2)
                replaceArrayCustomBeat(2,6)
                replaceArrayCustomBeat(3,10)
                replaceArrayCustomBeat(4,14)
                replaceArrayCustomBeat(5,15)
            elseif curStep == 4112 then
                clearCustomBeat()
                clearInvertedBeat()
                replaceArrayInvertedBeat(1,4)
            end
        elseif songName == 'Triple-Trouble' then
            if curStep == 80 or curStep == 464 or curStep == 1104 or curStep == 1680 or curStep == 1936 or curStep == 2896 or curStep == 3472 or curStep == 3216 or curStep == 4048 then
                clearBeat()
                clearCustomBeat()
                replaceArrayBeat(1,2)
            elseif curStep == 112 or curStep == 456 or curStep == 496 or curStep == 740 or curStep == 912 or curStep == 1136 or curStep == 1920 or curStep == 2927 or curStep == 2960 or curStep == 3728 or curStep == 4080 then
                clearBeat()
                clearCustomBeat()
                replaceArrayBeat(1,1)
            elseif curStep == 128 or curStep == 512 or curStep == 1152 then
                replaceArrayBeat(1,0.5)
            elseif curStep == 134 or curStep == 400 or curStep == 518 or curStep == 1030 or curStep == 1159 or curStep == 1287 or curStep == 2312 or curStep == 2952 or curStep == 3216 or curStep == 3719 or curStep == 3975 or curStep == 5128 then
                clearBeat()
                clearCustomBeat()
            elseif curStep == 144 or curStep == 528 or curStep == 1168 or curStep == 1424 then
                clearBeat()
                clearCustomBeat()
                replaceArrayCustomBeat(1,1)
                replaceArrayCustomBeat(2,1.5)
                replaceArrayCustomBeat(3,2.5)
                replaceArrayCustomBeat(4,3)
            end
        else
            enabledSystem = false
        end
    end
end

function replaceArrayBeat(pos,number)
    if pos == nil then
        pos = #BeatPorcent + 1
    end
    if BeatPorcent[pos] ~= number then
        if BeatPorcent[pos] ~= nil then
            table.remove(BeatPorcent,pos)
        end
        table.insert(BeatPorcent,pos,number)
    end
end

function replaceArrayCustomBeat(pos,number)
    if Section == 0 then
        Section = 4
    end
    if number == Section then
        number = 0
    end
    if pos == nil then
        pos = #BeatCustomPorcent + 1
    end
    if BeatCustomPorcent[pos] ~= number then
        if BeatCustomPorcent[pos] ~= nil then
            table.remove(BeatCustomPorcent,pos)
        end
        table.insert(BeatCustomPorcent,pos,number)
    end
end

function replaceArrayInvertedCustomBeat(pos,number)
    if InvertedSection == 0 then
        InvertedSection = 4
    end
    if number == InvertedSection then
        number = 0
    end
    if pos == nil then
        pos = #invertedCustomBeat + 1
    end
    if invertedCustomBeat[pos] ~= number then
        if invertedCustomBeat[pos] ~= nil then
            table.remove(invertedCustomBeat,pos)
        end
        table.insert(invertedCustomBeat,pos,number)
    end
end

function replaceArrayInvertedBeat(pos,number)
    if pos == nil then
        pos = #invertedBeat + 1
    end
    if invertedBeat[pos] ~= number then
        if invertedBeat[pos] ~= nil then
            table.remove(invertedBeat,pos)
        end
        table.insert(invertedBeat,pos,number)
    end
end

function replaceArrayCannotBeat(pos,number)
    if pos == nil then
        pos = #cannotBeat + 1
    end
    if cannotBeat[pos] ~= number then
        if cannotBeat[pos] ~= nil then
            table.remove(invertedBeat,pos)
        end
        table.insert(cannotBeat,pos,number)
    end
end

function replaceArrayCustomCannotBeat(pos,number)
    if cannotBeatSection == 0 then
        cannotBeatSection = 4
    end
    if pos == nil then
        table.insert(cannotBeatCustom,#cannotBeatCustom + 1,number)
    else
        if cannotBeatCustom[pos] ~= number then
            if cannotBeatCustom[pos] ~= nil then
                table.remove(cannotBeatCustom,pos)
            end
            table.insert(cannotBeatCustom,pos,number)
        end
        if number == cannotBeatSection then
            number = 0
        end
    end
end
function replaceArrayInvertedCannotBeat(pos,number)
    if pos == nil then
        pos = #cannotBeatInverted + 1
    end
    if cannotBeatInverted[pos] ~= number then
        if cannotBeatInverted[pos] ~= nil then
            table.remove(cannotBeatInverted,pos)
        end
        table.insert(cannotBeatInverted,pos,number)
    end
end

function replaceArrayInvertedCustomCannotBeat(pos,number)
    if pos == nil then
        pos = #cannotBeatCustomInverted + 1
    end
    if cannotBeatCustomInverted[pos] ~= nil then
        if cannotBeatCustomInverted[pos] ~= number then
            if cannotBeatCustomInverted[pos] ~= nil then
                table.remove(cannotBeatCustomInverted,pos)
            end
            table.insert(cannotBeatCustomInverted,pos,number)
        end
        table.remove(cannotBeatCustomInverted,pos)
    end
end

function clearBeat()
    for clearBeat = 1,#BeatPorcent do
        if BeatPorcent[clearBeat] ~= nil then
            table.remove(BeatPorcent,clearBeat)
            table.insert(BeatPorcent,clearBeat,nil)
        end
    end
end

function clearInvertedBeat()
    for clearCanBeatInveted = 1,#invertedBeat do
        if invertedBeat[clearCanBeatInveted] ~= nil then
            table.remove(invertedBeat,clearCanBeatInveted)
        end
        table.insert(invertedBeat,clearCanBeatInveted,nil)
    end
end

function clearCustomBeat()
    Section = 4
    for clearCustom = 1,#BeatCustomPorcent do
        if BeatCustomPorcent[clearCustom] ~= nil then
            table.remove(BeatCustomPorcent,clearCustom)
        end
        table.insert(BeatCustomPorcent,clearCustom,nil)
    end
end

function clearCustomCannotBeat()
    cannotBeatSection = 0
    for clearBeatCustomCannot = 1,#cannotBeatCustom do
        if cannotBeatCustom[clearBeatCustomCannot] ~= nil then
            table.remove(cannotBeatCustom,clearBeatCustomCannot)
        end
        table.insert(cannotBeatCustom,clearBeatCustomCannot,nil)
    end
end

function clearInvertedCustomBeat()
    InvertedSection = 4
    for clearCustomInverted = 1,#invertedCustomBeat do
        if invertedCustomBeat[clearCustomInverted] ~= nil then
            table.remove(invertedCustomBeat,clearCustomInverted)
        end
        table.insert(invertedCustomBeat,clearCustomInverted,nil)
    end
end
function clearCannotBeat()
    for clearBeatCannot = 1,#cannotBeat do
        if cannotBeat[clearBeatCannot] ~= nil then
            table.remove(cannotBeat,clearBeatCannot)
        end
        table.insert(cannotBeat,clearBeatCannot,nil)
    end
end

function clearInvertedCannotBeat()
    for clearBeatCannotCustom = 1,#cannotBeatInverted do
        if cannotBeatInverted[clearBeatCannotCustom] ~= nil then
            table.remove(cannotBeatInverted,clearBeatCannotCustom)
        end
        table.insert(cannotBeatInverted,clearBeatCannotCustom,nil)
    end
end

function setBeatValue(valueGame,valueHUD,normal,custom)
    if normal ~= false then
        if valueGame ~= nil then
            BeatStrentghGame = valueGame
        end
        if valueHUD ~= nil then
            BeatStrentghHUD = valueHUD
        end
    end
    if custom ~= false then
        if valueGame ~= nil then
            BeatStrentghCustomGame = valueGame
        end
        if valueHUD ~= nil then
            BeatStrentghCustomHUD = valueHUD
        end
    end
end
function setInvertedBeat(valueGame,valueHUD,normal,custom)
    if normal ~= false then
        if valueGame ~= nil then
            BeatStrentghInvertedGame = valueGame
        end
        if valueHUD ~= nil then
            BeatStrentghInvertedHUD = valueHUD
        end
    end
    if custom ~= false then
        if valueGame ~= nil then
            BeatStrentghInvertedCustomGame = valueGame
        end
        if valueHUD ~= nil then
            BeatStrentghInvertedCustomHUD = valueHUD
        end
    end
end
function clearAllArrays()
    clearCannotBeat()
    clearCustomCannotBeat()
    clearInvertedCannotBeat()
    clearBeat()
    clearCustomBeat()
    clearInvertedBeat()
    clearInvertedCustomBeat()
end