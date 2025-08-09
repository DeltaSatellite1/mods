local enableSameNote = false
function onCreatePost()
	runHaxeCode(
		[[
			var char = new Character(-60,220,"ellie",false);
			setVar('Ellie',char);
			char.alpha = 0.001;
			game.insert(game.members.indexOf(game.dadGroup)+1,char);
		]]
	)
end
function onBeatHit()
	if curBeat % 2 == 0 then
		if getProperty('Ellie.specialAnim') == false then
			playAnim('Ellie','idle',false)
		end
	end
end
function onEvent(name,v1,v2)
	if name == 'Opponents Sing Together' then
		if v1 == '1' or v1 == '' then
			enableSameNote = true
		else
			enableSameNote = false
		end
	elseif name == 'Extra Play Animation' then
		if v1 == '3' then
			playAnim('Ellie',v2,true)
			setProperty('Ellie.specialAnim',true)
			setProperty('Ellie.alpha',1)
		end
	end
end

function opponentNoteHit(id,dir,type,sus)
	if enableSameNote or type == 'Opponent 2 Sing' then
		playAnim('Ellie',getProperty('singAnimations['..dir..']'),true)
		setProperty('Ellie.holdTimer',0)
	end
end