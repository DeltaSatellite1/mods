function onCreate()
    if isStoryMode and not seenCutscene then
        addLuaScript('extra_scripts/dialogueSans')
        callScript('extra_scripts/dialogueSans','startDialogue',
            {
                {'im surprised you didnt try anything.','i guess you learned something from last time...',"let's finish this."},
                {'normal','wink','noeyes'}
            }
        )
    end
end