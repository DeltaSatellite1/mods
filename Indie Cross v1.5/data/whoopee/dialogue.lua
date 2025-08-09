function onCreate()
    if isStoryMode and not seenCutscene then
        addLuaScript('extra_scripts/dialogueSans')
        callScript('extra_scripts/dialogueSans','startDialogue',
            {
                {
                    'welcome to the underground',
                    'how was your fall?',
                    '...',
                    'you know, i was hired to tear you to shreds',
                    'and spread those ashes across 6 different suns.',
                    '...',
                    'after a few rounds of rap battling...',
                    'for some reason...',
                    'ready yourself human'
                },
                {'normal','funny','gay','closed','noeyes','gay','wink','funny','noeyes'}
            }
        )
    end
end