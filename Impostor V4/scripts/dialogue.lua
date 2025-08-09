local songFounded = false
local enableMechanics = false
local dadDialogue = 'red'
local bfDialogue = 'boyfriend'
local gfDialogue = 'girlfriend'
local speed = 0.04
local curDialogueSection = 0
local dialogueLength = 0
local currentDialogue = ''
local currentText = ''
local currentSpace = 0
local currentCharacterDialogue = nil
local currentCharacterAnim = nil

--Used on for loop
local curDialogue = 0
local curDialogueDestroy = 0

--Detect if the player are create to make the fade
local bfCreated = false
local dadCreated = false
local gfCreated = false
local dialogueCreated = false

local dadPos = 0
local bfPos = 0
local gfPos = 0

local curBfAnim = ''
local curDadAnim = ''
local curGfAnim = ''
local songPos = -1
local songDialogue = 'ashes'
local songLength = 52364
local dialogue = {
    {
    --[[
    {
        {
            'character',
            {
                {'animName','xml','offsetX','offsetY','loop'}
            }
        }
    }]]--
        {
            'red',
            {
                {'happy','RI happy'},
                {'nervous','RI nervous',115,0},
                {'mad','RI mad'},
                {'neutral','RI neutral'},
                {'q','RI q'},
                {'sad','RI sad'}
            }
        },
        {
            'yellow',
            {
                {'neutral','Y neutral'},
                {'dead','Y died'},
                {'happy','Y happy'},
                {'nervous','Y nervous'},
                {'skeptical','Y skeptical'},
                {'what','Y what'}
            }
        },
        {
            'green',
            {
                {'ineutral','GI neutral'},
                {'happy','GC happy'},
                {'ihappy','GI happy'},
                {'nervous','GC nervous'},
                {'threat','GC threatening'},
                {'excited','GC excited'},
                {'iupset','GI upset'}
            }
        },
        {
            'white',
            {
                {'disap','WI disappointed'},
                {'excited','WI excited'},
                {'happy','WI happy'},
                {'insane','WI insanity'},
                {'pissed','WI pissed'}
            }
        },
        {
            'grey',
            {
                {'neutral','GC neutral',0,0,true}
            }
        },
        {'pink',
            {
                {'excited','PC excited'},
                {'happy','PC happy'},
                {'neutral','PC neutral'},
                {'sad','PC sad'}
            }
        },
        {
            'boyfriend',
            {
                {'neutral','BF neutral'},
                {'happy','BF happy'},
                {'mad','BF mad'},
                {'angry','BF angry',-20},
                {'sad','BF sad'},
                {'uwu','BF uwu'},
                {'realization','BF realization',0,20},
                {'q','BF q'}
            }
        },
        {
            'girlfriend',
            {
                {'neutral','GF neutral'},
                {'q','GF q'},
                {'glint','GF glint'},
                {'happy','GF happy'},
                {'mad','GF mad'},
                {'suspect','GF suspect'}
            }
        },
        {
            'maroon',
            {
                {'happy','MI happy'},
                {'neutral','MI neutral'},
                {'sad','MI sad'},
                {'threat','MI threatening'}
            }

        }
    },
    {'Sussus-Moogus',
        {
            'that really hurt :(',
            'o my fault',
            'boyfriend be careful !!',
            'this guy seems....',
            '..mistrustful......',
            'now that you mention it... he does look pretty',
            'skeptical..',
            'hey what did i do :(( im a crewmate guys :( cmon :((((',
            'Ermm.. This Guy',
            'you have a gun!!!! also a knife !!but only in your up sprite!!!!',
            'wow :( u dont have to be a fuckign cunt :(',
            'whatever man! lets just rap battle!',
            'ok !',
            '(heh.... they have no clue im actually the IMPOSTOR...)',
            'you are speaking out loud'
        },
        {
            {'dad','sad'},
            {'bf','neutral'},
            {'gf','suspect'},
            {'gf','suspect'},
            {'gf','q'},
            {'bf','neutral'},
            {'bf','q'},
            {'dad','sad'},
            {'gf','happy'},
            {'gf','mad'},
            {'dad','neutral'},
            {'bf','happy'},
            {'red','happy'},
            {'red','happy'},
            {'bf','neutral'}
        }
    },
    {'Sabotage',
        {
            'lol!!! you dumbass!!!!!',
            'you fell for it!! i was actually an impostor this whole time!!!! ',
            'y..you....',
            'girlfriend .... you.....',
            'how could you do this??!!',
            'why her ??!!',
            'id rather it have been me than her !!!',
            'you piece of SHIT!!!! i shouldve NEVER trusted you!!!',
            'ILL MAKE YOU PAY FOR WHAT YOU DID',
            'ILL MAKE YOU REGRET YOU WERE EVER BORN',
            'sniffle..... ill avenge you babe.....',
            'u done?',
            'yea'
        },
        {
            {'dad','happy'},
            {'dad','happy'},
            {'bf','realization'},
            {'bf','realization'},
            {'bf','sad'},
            {'bf','sad'},
            {'bf','sad'},
            {'bf','angry'},
            {'bf','mad'},
            {'bf','mad'},
            {'bf','mad'},
            {'dad','neutral'},
            {'bf','happy'}
        },
    },
    {
        'Meltdown',
        {
            'ooooooooh im a ghoioostt',
            'me too oooooooh ooohoh',
            'WTF UR SCARY ',
            'yea... >:)',
            'what u gonna do BITCH!!',
            'i...im so sorry.. please just.. dont hurt me..',
            'i have a husband and kids at home....',
            'you know what.. yeah man. lets just put our differences aside.',
            'after you KILLED ME??? what kinda drugs you on???',
            'crack',
            'ah that makes sense',
        },
        {
            {'bf','happy'},
            {'gf','happy'},
            {'dad','nervous'},
            {'gf','glint'},
            {'bf','angry'},
            {'dad','sad'},
            {'dad','sad'},
            {'bf','happy'},
            {'bf','mad'},
            {'dad','happy'},
            {'bf','neutral'}
        },
    },
    {'Sussus Toogus',
        {
            "man that red guy was crazy, glad we made it out alive",
            "we literally didnt",
            "Hello Fellow Crewmates!",
            "... who are u",
            "im just a innocent little crewmate trying to do his little tasks!",
            "hmmmm i dont trust this guy bf...",
            "aww cmon guys! heyy cmon guys cmon heyyy cmonnn" ,
            "Come on.",
            "Can't you hear how you sound? You are OUT OF YOUR DAMN MIND.",
            "sure man",
            "cool lets sing now buddy",
        },
        {
            {'bf','neutral'},
            {'gf','neutral'},
            {'dad','excited'},
            {'bf','neutral'},
            {'dad','excited'},
            {'gf','suspect'},
            {'dad','nervous'},
            {'dad','threat'},
            {'dad','nervous'},
            {'bf','happy'},
            {'dad','happy'},
        }
        
    },
    {'Lights Down',
        {
            'WOW ok FINE... i am the impostor.',
            'we know',
            'you guys just love to foil my plans huh..',
            'yea lol get fucked loser?',
            'ok well you cant get rid of me unless you call a meeting',
            'and your dumbass wants to sing your little beep boop songs instead of do anything useful',
            'so easy win for me i guess',
            'i sing better than you',
            'NO YOU DONT BITCH ITS ON',
        },
        {
            {'dad','ineutral'},
            {'gf','neutral'},
            {'dad','iupset'},
            {'bf','happy'},
            {'dad','ineutral'},
            {'dad','ineutral'},
            {'dad','ihappy'},
            {'bf','happy'},
            {'dad','iupset'},
        }
    },
    {'Reactor',
        {
            'Ok gf i think we got away',
            'awesome',
            'Are you guys STUPID im right HERE',
            ' ',
        },
        {
            {'bf','happy'},
            {'gf','happy'},
            {'dad','iupset'},
            {'bf','q'}
        }
    },
    {'Mando',
        {
            "omg hey friends!!",
            "um hi..?",
            "hi??",
            "im having so much fun playing Among us!",
            "ummm..okay man?",
            "woah hey why are you all acting like that :(",
            "i mean like, every person we've ran into so far turned out to be an impostor and killed us....",
            "oh.",
            "thats racist i feel like",
            "not all among us are the same",
            "yk what you're right we're sorry",
            "anyway what tasks you guys got?",
            'uhhhhh it says Sing "Mando" by Rareblin',
            "omgg me too no way",
            'alright',
        },
        {
            {'dad','happy'},
            {'bf','neutral'},
            {'gf','suspect'},
            {'dad','happy'},
            {'gf','suspect'},
            {'dad','skeptical'},
            {'bf','neutral'},
            {'dad','what'},
            {'dad','skeptical'},
            {'dad','neutral'},
            {'gf','neutral'},
            {'dad','happy'},
            {'bf','happy'},
            {'dad','happy'},
            {'bf','happy'}
        }

    },
    {'Dlow',
        {
            "T-that sure was fun! ^_^",
            "speak normally please",
            "sry",
            "wow guys that was a cool song!",
            "so are you gonna kill us now",
            "kill you?? no sirree bob i would never do such a heinous crime",
            "you mean youre really not the impostor..?",
            "i mean he probably woulda killed us by now if he was",
            "youre so right babe this is why i let u peg me every night",
            "next song please!"
        },
        {
            {'dad','happy'},
            {'bf','neutral'},
            {'dad','neutral'},
            {'dad','happy'},
            {'gf','suspect'},
            {'dad','neutral'},
            {'bf','neutral'},
            {'gf','suspect'},
            {'bf','happy'},
            {'dad','happy'}
        },
    },
    { 'Oversight',
        {
            'there goes your queer little friend',
            'that was really really rude of you',
            'i could not give less of a shit if you thought it was rude',
            'god why cant we just all be nice to each other for once',
            'yea i agree, you wanna be friends white?',
            'wait really?',
            'nope fuck you lol',
            'wow ok then.',
        },
        {
            {'dad','happy'},
            {'bf','angry'},
            {'dad','pissed'},
            {'gf','neutral'},
            {'bf','happy'},
            {'dad','insane'},
            {'bf','happy'},
            {'dad','disap'},
        }
    },
    {'Ashes',
        {
            "youre a bitch",
            "i havent even said anything what the hell",
            "i can smell the bitch on you !!",
            "Be nice to my boyfriend please.",
            "be nice my BALLS!!!!",
            "holy shit youre already annoying",
            "you guys wanna hear me SPIT some HEATTTTT?!?!?!",
            "will it make you leave us alone",
            "no"
        },
        {
            {'dad','happy'},
            {'bf','neutral'},
            {'dad','threat'},
            {'gf','mad'},
            {'dad','happy'},
            {'bf','angry'},
            {'dad','happy'},
            {'bf','neutral'},
            {'dad','threat'},
        }
    },
    {'Magmatic',
        {
            'i was right you ARE a bitch',
            'man can you SHUT UP',
            'im like gonna shoot myself in the face if i gotta deal with one more impostor',
            'how bout i stab you in the face instead bitch',
            'nah i wont even let you get the chance',
            'sure buddy',
        },
        {
            {'dad','neutral'},
            {'bf','angry'},
            {'bf','mad'},
            {'dad','happy'},
            {'bf','angry'},
            {'dad','neutral'}
        }
    },
    {'Delusion',
        {
            '',
            'oh my'
        },
        {
            {'dad','neutral'},
            {'bf','neutral'}
        }
    },
    {'Heartbeat',
        {
            "gosh it sure is lonely here in this greenhouse (ignore the ppl in the background)",
            "i wonder when 'll finally make a friend'....",
            "lmaooo ok so and then i was like",
            "OMGG!!!! hiiiiii!! waves at you",
            "oh um he wasnt talking to you",
            "Wait.. who are you i havent seen you before",
            "hiii wanna be my friends pleeeasde pllsee plelsssee",
            "ummm",
            ":)",
            "ummm uhh",
            "<:)",
            "sure",
            "YIIPPEEEE!!!"
        },
        {
            {'dad','sad'},
            {'dad','neutral'},
            {'bf','happy'},
            {'dad','excited'},
            {'gf','neutral'},
            {'gf','suspect'},
            {'dad','happy'},
            {'bf','neutral'},
            {'dad','happy'},
            {'bf','neutral'},
            {'dad','excited'},
            {'bf','happy'},
            {'dad','excited'}
        }
    },
    {'Pinkwave',
        {
            "again again again again! i like that song can we go again!",
            "were supposed to go to the next song thats how this works girl",
            "awww! well maybe itll be just as good :)",
            "guys i just realized.. weve been here for like 10 minutes and not a single person has gotten killed",
            "youre right.. also she doesnt seem like an impostor",
            "maybe there isnt a pretender amidst us after all",
            "i.... i guess there isnt! haha",
            "...",

        },
        {
            {'dad','excited'},
            {'bf','neutral'},
            {'dad','happy'},
            {'gf','suspect'},
            {'bf','neutral'},
            {'bf','neutral'},
            {'dad','neutral'},
            {'dad','neutral'}

        }
    }
}
function onCreate()
    if isStoryMode and not seenCutscene then
        for foundSound = 2,#dialogue do
            if dialogue[foundSound][1] == songName then
                songFounded = true
                songPos = foundSound
                dialogueLength = #dialogue[foundSound][2]
            end
        end
        if songFounded then
            if songName == 'Sussus-Moogus' or songName == 'Sabotage' or songName == 'Meltdown' then
                dadDialogue = 'red'
                if songName == 'Sabotage' then
                    songDialogue = 'Sabotage'
                    songLength = 22588
                elseif songName == 'Meltdown' then
                    songDialogue = 'Meltdown'
                    songLength = 17067
                end
            elseif songName == 'Sussus Toogus' or songName == 'Lights Down' or songName == 'Reactor' then
                dadDialogue = 'green'
                if songName == 'Lights Down' then
                    songDialogue = 'lights down'
                    songLength = 22588
                elseif songName == 'Sussus Toogus' then
                    songDialogue = 'sussus toogus'
                    songLength = 28444
                else
                    songDialogue = 'reactor'
                    songLength = 30720
                end
            elseif songName == 'Mando' or songName == 'Dlow' then
                dadDialogue = 'yellow'
                if songName == 'Dlow' then
                    songDialogue = 'dlow'
                end
            elseif songName == "Oversight" then
                dadDialogue = 'white'
            elseif songName == 'Ashes' or songName == "Magmatic" then
                dadDialogue = 'maroon'
                songDialogue = 'magmatic'
            elseif songName == 'Delusion' then
                dadDialogue = 'grey'
                songDialogue = ''
            elseif songName == 'Heartbeat' or songName == 'Pinkwave' then
                dadDialogue = 'pink'
            end
        end
        precacheImage('dialogueV4/'..bfDialogue)
        precacheImage('dialogueV4/'..dadDialogue)
        precacheImage('dialogueV4/'..gfDialogue)
        precacheSound('dialogue/music/'..songDialogue)
    else
        close(true)
    end
end
function onCreatePost()
    if songFounded then
        if getProperty('inCutscene') then
            stopSound('dialogueSus')
        end
        local dadOffset = 0
        if dadDialogue == 'yellow' or dadDialogue == 'grey' then
            dadOffset = -20
        elseif dadDialogue == 'pink' then
            dadOffset = -55
        elseif dadDialogue == 'maroon' then
            dadOffset = 15
        end
        local boxAnims = {dadDialogue,bfDialogue,gfDialogue}
        for characters = 1,#dialogue[1] do
            if dialogue[1][characters][1] == bfDialogue then
                bfPos = characters
                makeAnimatedLuaSprite(bfDialogue..'Dialogue','dialogueV4/'..bfDialogue,900,200)
                for bfAnims = 1,#dialogue[1][characters][2] do
                    local bfLoop = false
                    if #dialogue[1][characters][2][bfAnims] == 5 then
                        bfLoop = dialogue[1][characters][2][bfAnims][5]
                    end
                    addAnimationByPrefix(bfDialogue..'Dialogue',dialogue[1][characters][2][bfAnims][1],dialogue[1][characters][2][bfAnims][2],24,bfLoop)
                end
                setObjectCamera(bfDialogue..'Dialogue','other')
                setProperty(bfDialogue..'Dialogue.alpha',0)
                addLuaSprite(bfDialogue..'Dialogue',true)
            elseif dadDialogue ~= nil and dialogue[1][characters][1] == dadDialogue then
                dadPos = characters
                makeAnimatedLuaSprite(dadDialogue..'Dialogue','dialogueV4/'..dadDialogue,200,220 + dadOffset)
                for dadAnims = 1,#dialogue[1][characters][2] do
                    local dadLoop = false
                    if #dialogue[1][characters][2][dadAnims] == 5 then
                        dadLoop = dialogue[1][characters][2][dadAnims][5]
                    end
                    addAnimationByPrefix(dadDialogue..'Dialogue',dialogue[1][characters][2][dadAnims][1],dialogue[1][characters][2][dadAnims][2],24,dadLoop)
                end
                setProperty(dadDialogue..'Dialogue.alpha',0)
                setObjectCamera(dadDialogue..'Dialogue','other')
                addLuaSprite(dadDialogue..'Dialogue',true)
            elseif dialogue[1][characters][1] == gfDialogue then
                gfPos = characters
                makeAnimatedLuaSprite(gfDialogue..'Dialogue','dialogueV4/'..gfDialogue,550,200)
                for gfAnims = 1,#dialogue[1][characters][2] do
                    local gfLoop = false
                    if #dialogue[1][characters][2][gfAnims] == 5 then
                        gfLoop = dialogue[1][characters][2][gfAnims]
                    end
                    addAnimationByPrefix(gfDialogue..'Dialogue',dialogue[1][characters][2][gfAnims][1],dialogue[1][characters][2][gfAnims][2],24,gfLoop)
                end
                setProperty(gfDialogue..'Dialogue.alpha',0)
                setObjectCamera(gfDialogue..'Dialogue','other')
                addLuaSprite(gfDialogue..'Dialogue',true)
            end
        end
        makeLuaSprite('whiteBGDialoge',nil,0,0)
        setObjectCamera('whiteBGDialoge','hud')
        setProperty('whiteBGDialoge.alpha',0.001)
        makeGraphic('whiteBGDialoge',screenWidth,screenHeight,'FFFFFF')
        addLuaSprite('whiteBGDialoge',false)

        makeAnimatedLuaSprite('dialogueBox','dialogueV4/dialogueBox',150,420)
        setProperty('dialogueBox.alpha',0.001)
        for characters = 1,#boxAnims do
            addAnimationByPrefix('dialogueBox',boxAnims[characters],boxAnims[characters],0,true)
        end
        setObjectCamera('dialogueBox','other')
        addLuaSprite('dialogueBox',true)
        setPropertyFromClass('PlayState','seenCutscene',true)
        
    end
end
function playDialoguesong()
    if songLength ~= 0 then
        runTimer('dialogueSoundLoop',songLength/1000)
    end
    playSound('dialogue/music/'..songDialogue,1,'dialogueSus')
end
function onStartCountdown()
    if songFounded and not enableMechanics then
        runTimer('detectDialogue',0.2)
        return Function_Stop
    end
    return Function_Continue
end
function nextDialogue(section)
    if curDialogueSection ~= section then
        curDialogueSection = section
        currentDialogue = dialogue[songPos][2][curDialogueSection]
        currentCharacterDialogue = dialogue[songPos][3][curDialogueSection][1]
        currentCharacterAnim = dialogue[songPos][3][curDialogueSection][2]
        if currentCharacterDialogue == 'dad' then
            currentCharacterDialogue = dadDialogue
            if not dadCreated then
                doTweenX('dadDialogueHeyX',dadDialogue..'Dialogue',getProperty(dadDialogue..'Dialogue.x') + 50,1,'quartOut')
                doTweenAlpha('dadDialogueHeyAlpha',dadDialogue..'Dialogue',1,1,'quartOut')
                dadCreated = true
            end
        elseif currentCharacterDialogue == 'bf' then
            currentCharacterDialogue = bfDialogue
            if not bfCreated then
                doTweenX('bfDialogueHeyX',bfDialogue..'Dialogue',getProperty(bfDialogue..'Dialogue.x') - 50,1,'quartOut')
                doTweenAlpha('bfDialogueHeyAlpha',bfDialogue..'Dialogue',1,1,'quartOut')
                bfCreated = true
            end
        elseif currentCharacterDialogue == 'gf' then
            currentCharacterDialogue = gfDialogue
            if not gfCreated then
                doTweenY('gfDialogueHeyX',gfDialogue..'Dialogue',getProperty(gfDialogue..'Dialogue.y') - 50,1,'quartOut')
                doTweenAlpha('gfDialogueHeyAlpha',gfDialogue..'Dialogue',1,1,'quartOut')
                gfCreated = true
            end
        end
        if not dialogueCreated then
            setProperty('dialogueBox.alpha',1)
            setProperty('whiteBGDialoge.alpha',0.35)
            dialogueCreated = true
        end
        local currentCharacter = string.gsub(currentCharacterDialogue,string.sub(currentCharacterDialogue,1,1),string.upper(string.sub(currentCharacterDialogue,1,1)),1)

        curDialogue = curDialogue + 1
        makeLuaSprite('dialogueTextBox'..curDialogue,'dialogueV4/bubble',240,480)
        setObjectCamera('dialogueTextBox'..curDialogue,'other')
        addLuaSprite('dialogueTextBox'..curDialogue,true)
        
        makeLuaText('dialogueText'..curDialogue,'',680,400,480)
        setTextAlignment('dialogueText'..curDialogue,'left')
        setObjectCamera('dialogueText'..curDialogue,'other')
        setTextBorder('dialogueText'..curDialogue,-1,'FFFFFF')
        setTextColor('dialogueText'..curDialogue,'000000')
        setTextFont('dialogueText'..curDialogue,'calibri.ttf')
        setTextSize('dialogueText'..curDialogue,27)
        addLuaText('dialogueText'..curDialogue,true)
        
        makeLuaText('dialogueTextCur'..curDialogue,currentCharacter,700,400,400)
        setTextAlignment('dialogueTextCur'..curDialogue,'left')
        setObjectCamera('dialogueTextCur'..curDialogue,'other')
        setTextBorder('dialogueTextCur'..curDialogue,2,'000000')
        setTextFont('dialogueTextCur'..curDialogue,'calibri.ttf')
        setTextSize('dialogueTextCur'..curDialogue,27)
        addLuaText('dialogueTextCur'..curDialogue,true)

        makeLuaSprite('dialogueIcon'..curDialogue,'dialogueV4/icons/'..currentCharacterDialogue,250,0)
        setObjectCamera('dialogueIcon'..curDialogue,'other')
        scaleObject('dialogueIcon'..curDialogue,0.9,0.9)
        addLuaSprite('dialogueIcon'..curDialogue,true)

        currentSpace = 0
        currentText = ''
        runTimer('dialogueLol',speed)
        objectPlayAnimation('dialogueBox',currentCharacterDialogue)
        for dialogueBox = curDialogueDestroy + 1,curDialogue - 1 do
            setProperty('dialogueTextBox'..dialogueBox..'.y',getProperty('dialogueTextBox'..dialogueBox..'.y') + 120)
        end
    end
end
function onUpdate()
    if songFounded and not getProperty('inCutscene') then
        setProperty('vocals.volume',0)
        if curDialogueSection <= dialogueLength and (keyboardJustPressed('ENTER') or mouseClicked()) then
            if currentSpace >= string.len(currentDialogue) then
                playSound('clickText')
                nextDialogue(curDialogueSection + 1)
            else
                currentSpace = string.len(currentDialogue)
                currentText = string.sub(currentDialogue,0,currentSpace)
            end
        elseif curDialogueSection > dialogueLength or keyboardJustPressed('ESCAPE') then
            stopSound('dialogueSus')
            setProperty('vocals.volume',1)
            doTweenY('byeDialogueY','dialogueBox',900,0.3,'sineIn')
            doTweenY('byedadDialogueY',dadDialogue..'Dialogue',900,0.3,'sineIn')
            doTweenY('byebfDialogueY',bfDialogue..'Dialogue',900,0.3,'sineIn')
            doTweenY('byegfDialogueY',gfDialogue..'Dialogue',900,0.3,'sineIn')
            doTweenAlpha('byeWhiteSusDialogue','whiteBGDialoge',0,0.3,'sineIn')
            for dialogueBox = curDialogueDestroy,curDialogueSection do
                doTweenY('byeDialogueTextBox'..dialogueBox,'dialogueTextBox'..dialogueBox,900,0.3,'sineIn')
            end
            songFounded = false
        end
    end
    if enableMechanics then
        if curDialogueSection > 0 then
            for dialogueBox = curDialogueDestroy + 1,curDialogue do
                setProperty('dialogueText'..dialogueBox..'.y',getProperty('dialogueTextBox'..dialogueBox..'.y') + 40)
                setProperty('dialogueTextCur'..dialogueBox..'.y',getProperty('dialogueTextBox'..dialogueBox..'.y') + 10)
                setProperty('dialogueIcon'..dialogueBox..'.y',getProperty('dialogueTextBox'..dialogueBox..'.y') - 20)
                if getProperty('dialogueTextBox'..dialogueBox..'.y') > 600 then
                    removeLuaSprite('dialogueIcon'..dialogueBox,true)
                    removeLuaSprite('dialogueTextBox'..dialogueBox,true)
                    removeLuaText('dialogueText'..dialogueBox,true)
                    removeLuaText('dialogueTextCur'..dialogueBox,true)
                    curDialogueDestroy = curDialogueDestroy + 1
                end
                if curDialogue == dialogueBox then
                    setTextString('dialogueText'..dialogueBox,currentText)
                end
            end
            if getProperty(bfDialogue..'Dialogue.animation.curAnim.finished') and getProperty(bfDialogue..'Dialogue.animation.curAnim.name') ~= 'mad' then
                setProperty(bfDialogue..'Dialogue.animation.curAnim.frameRate',0)
                setProperty(bfDialogue..'Dialogue.animation.curAnim.curFrame',0)
            end
            if getProperty(dadDialogue..'Dialogue.animation.curAnim.finished') and (dadDialogue ~= 'yellow' and dadDialogue ~= 'white' or dadDialogue == 'yellow' and curDadAnim ~= 'skeptical' or dadDialogue == 'white' and curDadAnim ~= 'pissed') then
                setProperty(dadDialogue..'Dialogue.animation.curAnim.frameRate',0)
                setProperty(dadDialogue..'Dialogue.animation.curAnim.curFrame',0)
            end
            if getProperty(gfDialogue..'Dialogue.animation.curAnim.finished') then
                setProperty(gfDialogue..'Dialogue.animation.curAnim.frameRate',0)
                setProperty(gfDialogue..'Dialogue.animation.curAnim.curFrame',0)
            end
        end
    end
end
function onTimerCompleted(tag)
    if tag == 'dialogueLol' and currentSpace < string.len(currentDialogue) then
        currentSpace = currentSpace + 1
        local currentSong = 'bf'
        if currentCharacterDialogue == dadDialogue then
            currentSong = 'i'
        elseif currentCharacterDialogue == bfDialogue then
            currentSong = 'bf'
        elseif currentCharacterDialogue == gfDialogue then
            currentSong = 'gf'
        end
        playSound('dialogue/'..currentSong..'-text')
        setProperty(currentCharacterDialogue..'Dialogue.animation.curAnim.frameRate',24)
        currentText = string.sub(currentDialogue,0,currentSpace)
        local currentCharacter = nil
        if currentCharacterDialogue == bfDialogue and curBfAnim ~= currentCharacterAnim then
            currentCharacter = bfPos
            curBfAnim = currentCharacterAnim
        elseif currentCharacterDialogue == dadDialogue and curDadAnim ~= currentCharacterAnim then
            currentCharacter = dadPos
            curDadAnim = currentCharacterAnim
        elseif currentCharacterDialogue == gfDialogue and curGfAnim ~= currentCharacterAnim then
            currentCharacter = gfPos
            curGfAnim = currentCharacterAnim
        end
        if currentCharacter ~= nil then
            local offsetX = 0
            local offsetY = 0
            for animOffset = 1,#dialogue[1][currentCharacter][2] do
                if dialogue[1][currentCharacter][2][animOffset][1] == currentCharacterAnim and #dialogue[1][currentCharacter][2][animOffset] >= 3 then
                    offsetX = dialogue[1][currentCharacter][2][animOffset][3]
                    if #dialogue[1][currentCharacter][2][animOffset] >= 4 then
                        offsetY = dialogue[1][currentCharacter][2][animOffset][4] * -1
                    end
                end
            end
            setProperty(currentCharacterDialogue..'Dialogue.offset.x',offsetX)
            setProperty(currentCharacterDialogue..'Dialogue.offset.y',offsetY)
        end
        objectPlayAnimation(currentCharacterDialogue..'Dialogue',currentCharacterAnim,false)
        runTimer('dialogueLol',speed)
    elseif tag == 'dialogueSoundLoop' then
        if songFounded then
            playDialoguesong()
        end
    elseif tag == 'detectDialogue' and not getProperty('inCutscene') and curDialogueSection == 0 then
        playDialoguesong()
        nextDialogue(1)
        enableMechanics = true
    end
end
function onTweenCompleted(tag)
    if tag == 'byeDialogueY' then
        startCountdown()
        enableMechanics = false
        removeLuaSprite('dialogueBox',true)
        removeLuaSprite('bfDialogue',true)
        removeLuaSprite('gfDialogue',true)
        removeLuaSprite('dadDialogue',true)
        removeLuaSprite('whiteBGDialoge',true)
    end
end
