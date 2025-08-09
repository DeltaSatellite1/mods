function onCreate()
    if isStoryMode and not seenCutscene then
        addLuaScript('extra_scripts/dialogueSans')
        callScript('extra_scripts/dialogueSans','startDialogue',
            {
                {
                    "you see, i can't judge the book by its cover but...",
                    'i know what happened with you and that cup guy.',
                    "i'd if you try to do the same with me...",
                    'things wont turn out so well.',
                    'up to you kid...',
                    'no pressure.'
                },
                {'normal','gay','closed','funny','normal','noeyes'}
            }
        )
    end
end