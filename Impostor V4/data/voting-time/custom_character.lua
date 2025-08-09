local enableSameNote = false
local lastStrumTime = 0
local lastSustain = 0
local animFiles = {}
local enableGhost = true
function onCreatePost()
	addLuaScript('extra_scripts/extraCharacter')
	callScript('extra_scripts/extraCharacter','createExtraCharacter',{'redsus','madgus',1402,620,'dadGroup'})
end
function onUpdate(el)
    for notes = 0,getProperty('notes.length')-1 do
        if getPropertyFromGroup('notes',notes,'noteType') == 'Player 2 Sing' then
			local noteOfs = 5
			local noteSus = getPropertyFromGroup('notes',notes,'isSustainNote')
			if noteSus then
				noteOfs = 30
			end
			local strumTime = getPropertyFromGroup('notes',notes,'strumTime')
            if strumTime - getSongPosition() <= noteOfs then
				playAnim('redsus',getProperty('singAnimations['..getPropertyFromGroup('notes',notes,'noteData')..']'),true)
				setProperty('redsus.holdTimer',0)

                removeFromGroup('notes',notes)
            end
        end
    end
end

function insertGhostAnim(animFile)
	table.remove(animFiles,1)
	table.insert(animFiles,1,animFile)
end

function onEvent(name,v1,v2)
	if name == 'player2sing' then
		if v1 == '1' or v1 == '' then
			enableSameNote = true
		else
			enableSameNote = false
		end
	elseif name == 'Extra Play Animation' then
		if v1 == '4' then
			playAnim('redsus',v2,true)
		end
	end
end
function goodNoteHit(id,dir,type,sus)
	if enableSameNote then
		if not getPropertyFromGroup('notes',id,'noAnimation') then
			playAnim('redmungus',getProperty('singAnimations['..dir..']'),true)
		end
	end
end