function onCreate()
    if isStoryMode and not seenCutscene then
        addLuaScript('extra_scripts/dialogueSans')
        callScript('extra_scripts/dialogueSans','startDialogue',
            {
                {'bring it.'},
                {'noeyes'}
            }
        )
    end
end