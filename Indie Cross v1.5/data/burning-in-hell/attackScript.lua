function onCreate()
    addLuaScript('extra_scripts/attackSans')
end
function onCountdownTick(counter)
    if counter == 1 and not seenCutscene and isStoryMode then
        callScript('extra_scripts/attackSans','attackSans')
    end
end