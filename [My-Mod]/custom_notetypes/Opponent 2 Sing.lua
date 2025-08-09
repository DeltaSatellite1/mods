function onCreate()
    for unspawnNotes = 0,getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes',unspawnNotes,'noteType') == "Opponent 2 Sing" then
            setPropertyFromGroup('unspawnNotes',unspawnNotes,'noAnimation',true)
        end
    end
end