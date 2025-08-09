--this script force the shake thing of the anims on LN bc fnf freezes the 2 first frames(depending on bpm)

function opponentNoteHit(id, noteData, noteType, isSustainNote)
    if isSustainNote then
        if getProperty('dad.curCharacter') == 'xgaster' then
            if noteData == 0 then
                playAnim('dad', 'singLEFT', true, false, 0);
            elseif noteData == 1 then
                playAnim('dad', 'singDOWN', true, false, 0);
            elseif noteData == 2 then
                playAnim('dad', 'singUP', true, false, 0);
            elseif noteData == 3 then
                playAnim('dad', 'singRIGHT', true, false, 0);
            end
        else
            if noteData == 0 then
                playAnim('dad', 'singLEFT', true, false, 1);
            elseif noteData == 1 then
                playAnim('dad', 'singDOWN', true, false, 1);
            elseif noteData == 2 then
                playAnim('dad', 'singUP', true, false, 1);
            elseif noteData == 3 then
                playAnim('dad', 'singRIGHT', true, false, 1);
            end
        end
    end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
    if isSustainNote then
        if noteData == 0 then
            playAnim('boyfriend', 'singLEFT', true, false, 1);
        elseif noteData == 1 then
            playAnim('boyfriend', 'singDOWN', true, false, 1);
        elseif noteData == 2 then
            playAnim('boyfriend', 'singUP', true, false, 1);
        elseif noteData == 3 then
            playAnim('boyfriend', 'singRIGHT', true, false, 1);
        end
    end
end