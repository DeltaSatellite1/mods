local currentState = -1
local objects = {'henryMic','henrySock','henryStare'}
local sounds = {'mic','sock','stare'}
local currentSelected = ''
function onCreate()
    if isStoryMode and not seenCutscene then
        precacheImage('henry/finalframe')
        makeLuaSprite('henryFinalFrame','henry/finalframe',0,0)
        setObjectCamera('henryFinalFrame','hud')

        makeLuaSprite('henryVignette','henry/hguiofuhjpsod',0,0)
        setObjectCamera('henryVignette','hud')

        makeAnimatedLuaSprite('henryMic','henry/Microphone_Option',350,190)
        addAnimationByPrefix('henryMic','normal','Microphone',0,false)
        addAnimationByPrefix('henryMic','selected','Microphone Select',24,false)
        setObjectCamera('henryMic','hud')
        scaleObject('henryMic',0.5,0.5)

        makeAnimatedLuaSprite('henrySock','henry/Sock_Puppet_Option',720,140)
        addAnimationByPrefix('henrySock','normal','Sock Puppet',0,false)
        addAnimationByPrefix('henrySock','selected','Sock Puppet Select',24,false)
        scaleObject('henrySock',0.5,0.5)
        setObjectCamera('henrySock','hud')

        makeAnimatedLuaSprite('henryStare','henry/Stare_Down_Option',560,395)
        addAnimationByPrefix('henryStare','normal','Stare Down',0,false)
        addAnimationByPrefix('henryStare','selected','Stare Down Select',24,false)
        scaleObject('henryStare',0.5,0.5)
        setObjectCamera('henryStare','hud')
    end
end
local allowCountDown = false
function onStartCountdown()
    if isStoryMode and not seenCutscene then
        if currentState == 0  then
            addLuaSprite('henryFinalFrame',true)
            addLuaSprite('henryVignette',true)
            runTimer('henryMic',1.5)
            runTimer('henrySock',2.5)
            runTimer('henryStare',3.5)
            currentState = 1
        elseif currentState == 3 then
            if currentSelected == 'henryMic' then
                removeLuaSprite('henryMic',true)
                removeLuaSprite('henrySock',true)
                removeLuaSprite('henryStare',true)
                removeLuaSprite('henryFinalFrame',true)
                removeLuaSprite('henryVignette',true)
                setPropertyFromClass('flixel.FlxG','mouse.visible',false)
                allowCountDown = true
            else
                currentState = 2
            end
        else
            currentState = currentState + 1
        end
        if not allowCountDown then
            return Function_Stop;
        end
    end
    return Function_Continue;
end
function onUpdate()
    if currentState == 2 then
        for selections = 1,#objects do
            local mouseX = getMouseX('other') - 100
            local mouseY = getMouseY('other') - 80
            local object = objects[selections]
            local objectX = getProperty(object..'.x')
            local objectY = getProperty(object..'.y')
            local objectWidth = getProperty(object..'.width') * getProperty(object..'.scale.x')
            local objectHeight = getProperty(object..'.height') * getProperty(object..'.scale.y')
            if mouseX < objectX + objectWidth and mouseX > objectX - objectWidth and mouseY < objectY + objectHeight and mouseY > objectY - objectWidth then
                if currentSelected ~= object then
                    currentSelected = object
                    playSound(sounds[selections])
                    objectPlayAnimation(object,'selected',false)
                end
            else
                if currentSelected == object then
                    objectPlayAnimation(object,'normal',false)
                    currentSelected = ''
                end
            end
        end
        if mouseClicked('left') then
            startVideo(string.lower(currentSelected))
            currentState = 3
        end
    end
end
function onTimerCompleted(tag)
    if string.find(tag,'henry',0,true) ~= nil then
        addLuaSprite(tag,true)
        for object = 1,3 do
            if tag == objects[object] then
                playSound(sounds[object])
            end
        end
    end
    if tag == 'henryStare' then
        currentState = 2
        setPropertyFromClass('flixel.FlxG','mouse.visible',true)
    end
end
function onDestroy()
    setPropertyFromClass('flixel.FlxG','mouse.visible',false)
end