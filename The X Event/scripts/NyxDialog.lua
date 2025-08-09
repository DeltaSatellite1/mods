local currDialog = 'currDialog';
local dialogueList = {};
local soundList = {};
local charZooms = {};

local fadeTime = 0.3;
local holdTime = 2;

local onCompleteCallback;
local onFocusCallback;

local dialogueStarted = false;
local currentTween = '';

function onCreate()
    luaDebugMode = true;
end

function addDialogue(dial, sfx, zooms)
    dialogueList = dial;
    soundList = sfx;
    charZooms = zooms;
end

local allowCountdown = false;
function onStartCountdown()
    if not allowCountdown and isStoryMode and not seenCutscene then
        setProperty('camHUD.alpha', 0);

        if songName:lower() == 'overwrite' then
            for dialId = 1, 8 do table.insert(dialogueList, "overwriteDialog/"..dialId); end
            addDialogue( dialogueList, 
                       { "xchara1", "bf1", "xchara1", "xchara1", "xchara1", "xchara1", "bf1", "xchara1" },
                       { false, true, false, false, false, false, true, false });
        end

        if songName:lower() == 'inkingmistake' then
            for dialId = 1, 5 do table.insert(dialogueList, "inkingMistakeDialog/intro_ink00"..dialId); end
            addDialogue( dialogueList, 
                       { "ink1", "bf1", "ink1", "bf1", "ink1" },
                       { false, true, false, true, false });
        end

        if songName:lower() == 'relighted' then
            for dialId = 1, 9 do table.insert(dialogueList, "relightedDialog/intro/introxgaster0"..dialId); end
            addDialogue( dialogueList, 
                       { "gaster1", "bf1", "gaster1", "gaster1", "bf1", "gaster1", "gaster1", "gaster1", "gaster1" },
                       { false, true, false, false, true, false, false, false, false });
        end

        onCompleteCallback = function() startCountdown(); end

        allowCountdown = true;
        return Function_Stop;
    end
    return Function_Continue;
end

local allowEndSong = false;
function onEndSong()
    if songName:lower() == 'relighted' and not allowEndSong and isStoryMode and not seenCutscene then
        xgasterEndingDialog();
        onCompleteCallback = function() endSong(); end

        allowEndSong = true;
        return Function_Stop;
    end
    return Function_Continue;
end

function xgasterEndingDialog()
    runHaxeCode([[
        game.dad.playAnim('defeatStart', false);
        game.dad.animation.finishCallback = function(name:String){
            if (name == 'defeatStart'){
                game.dad.playAnim('defeatIdle', true);
            }
        };
        game.canPause = false;
        FlxG.sound.music.volume = 0;
        game.vocals.volume = 0;
        game.camFollow.set(game.dad.getMidpoint().x, game.dad.getMidpoint().y);
        game.camHUD.alpha = 0;
        game.gf.alpha = 0;
        game.boyfriend.alpha = 0;
        for (obj in getVar('nyxObjects')) {
            game.remove(obj);
        }
    ]]);
    for dialId = 1, 3 do table.insert(dialogueList, "relightedDialog/outro/outroxgaster0"..dialId); end
    addDialogue( dialogueList, { "gaster1", "gaster1", "gaster1" }, {  });
    dialogueStarted = false;
end

function onUpdate(elapsed)
    if isStoryMode and not seenCutscene then
        if not dialogueStarted then
            startDial();
            dialogueStarted = true;
            return;
        end
    
        if keyJustPressed('space') then
            cleanDialog();
        end
    end
end

function startDial()
    if #dialogueList == 0 then
        onCompleteCallback();
        if not allowEndSong then doTweenAlpha('hud', 'camHUD', 1, 1, quadInOut); end
        return;
    end

    local imageName = table.remove(dialogueList, 1);
    local soundName = table.remove(soundList, 1);
    makeLuaSprite(currDialog, imageName, 0, 0);
    setScrollFactor(currDialog, 0, 0);
    setProperty(currDialog..'.alpha', 0);
    setObjectCamera(currDialog, 'other');
    addLuaSprite(currDialog);

    playSound(soundName, 0.8);

    if #charZooms > 0 then
        FocusCharacter(table.remove(charZooms, 1));
    end

    doTweenAlpha('startTween', currDialog, 1, fadeTime, quadInOut);
    currentTween = 'startTween';
end

function holdDialogue()
    doTweenAlpha('holdTween', currDialog, 1, holdTime, quadInOut);
    currentTween = 'holdTween'
end

function endDialog()
    doTweenAlpha('endTween', currDialog, 0, fadeTime, quadInOut);
    currentTween = 'endTween';
end

function onTweenCompleted(tag)
    if tag == 'startTween' then
        holdDialogue();

    elseif tag == 'holdTween' then
        endDialog();

    elseif tag == 'endTween' then
        cleanDialog();
    end
end

function cleanDialog()
    cancelTween(currentTween);
    removeLuaSprite(currDialog);
    startDial();
end

function FocusCharacter(val)
    if not val then
        runHaxeCode([[
            game.camFollow.set(game.dad.getMidpoint().x + 150, game.dad.getMidpoint().y - 100);
			game.camFollow.x += game.dad.cameraPosition[0] + game.opponentCameraOffset[0];
			game.camFollow.y += game.dad.cameraPosition[1] + game.opponentCameraOffset[1];
        ]]);
    else
        runHaxeCode([[
            game.camFollow.set(game.boyfriend.getMidpoint().x - 100, game.boyfriend.getMidpoint().y - 100);
			game.camFollow.x -= game.boyfriend.cameraPosition[0] - game.boyfriendCameraOffset[0];
			game.camFollow.y += game.boyfriend.cameraPosition[1] + game.boyfriendCameraOffset[1];
        ]]);
    end
end