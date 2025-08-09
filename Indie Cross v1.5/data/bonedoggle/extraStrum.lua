local created = false
local skin = 'default'
local defaultX = {}
local defaultY = {}
function onCreatePost()
	
	addHaxeLibrary('FlxTypedGroup','flixel.group')
	if version >= '0.7' then
		addHaxeLibrary('StrumNote','objects')
		runHaxeCode(
		[[
			var newNotes = new FlxTypedGroup();
			for(strum in 0...game.opponentStrums.length){
				var curStrum = game.opponentStrums.members[strum];
				var object = new StrumNote(-150,curStrum.y,strum,0);
				
				object.animation.play('static');
				game.modchartSprites.set('strumNotesExtra'+strum,object);
				newNotes.add(object);
			}
			game.noteGroup.members.insert(0,newNotes);
			return;
		]]
	)
	else
		addHaxeLibrary('StrumNote','')
		runHaxeCode(
			[[
				var newNotes = new FlxTypedGroup();
				
				for(strum in 0...game.opponentStrums.length){
					var curStrum = game.opponentStrums.members[strum];
					var object = new StrumNote(-150,curStrum.y,strum,0);
					object.cameras = [game.camHUD];
					object.animation.play('static');
					game.modchartSprites.set('strumNotesExtra'+strum,object);
					newNotes.add(object);
				}
				game.insert(game.members.indexOf(game.healthBar)-5,newNotes);
				return;
			]]
	)
	end
	
	for strum = 0,3 do
		if middlescroll then
			table.insert(defaultY,screenHeight - 1856)
			setProperty('strumNotesExtra'..strum..'.x',getPropertyFromGroup('opponentStrums',strum,'x'))
			setProperty('strumNotesExtra'..strum..'.alpha',0.35)
			if not downscroll then
				setProperty('strumNotesExtra'..strum..'.y',screenHeight+150)
			else
				setProperty('strumNotesExtra'..strum..'.y',-150)
			end
		else
			
			--table.insert(defaultX,(90 + 110 * strum))
			table.insert(defaultX,(-5 + 107 * strum))
		end
	end
	for notes = 0,getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes',notes,'noteType') == 'plr3' then
			setPropertyFromGroup('unspawnNotes',notes,'copyX',false)
			setPropertyFromGroup('unspawnNotes',notes,'copyY',false)
			setPropertyFromGroup('unspawnNotes',notes,'copyAlpha',false)
			setPropertyFromGroup('unspawnNotes',notes,'ignoreNote',true)
			setPropertyFromGroup('unspawnNotes',notes,'wasGoodHit',true)
		end
	end
end

function onUpdate()
	for notes = 0,getProperty('notes.length')-1 do
		if getPropertyFromGroup('notes',notes,'noteType') == 'plr3' then
			local noteDir = getPropertyFromGroup('notes',notes,'noteData')
			local noteDistance = getPropertyFromGroup('notes',notes,'distance')
			
			local noteType = getPropertyFromGroup('notes',notes,'noteType')
			local noteSus = getPropertyFromGroup('notes',notes,'isSustainNote')
			local noteAngleDir =  90 * math.pi/180
			--[[if middlescroll then
				noteDistance = noteDistance * -1
			end]]
			setPropertyFromGroup('notes',notes,'x',getProperty('strumNotesExtra'..noteDir..'.x') + getPropertyFromGroup('notes',notes,'offsetX') + math.cos(noteAngleDir) * noteDistance)
			
			setPropertyFromGroup('notes',notes,'y',getProperty('strumNotesExtra'..noteDir..'.y') + getPropertyFromGroup('notes',notes,'offsetY') + math.sin(noteAngleDir) * noteDistance)
			setPropertyFromGroup('notes',notes,'alpha',getProperty('strumNotesExtra'..noteDir..'.alpha') * getPropertyFromGroup('notes',notes,'multAlpha'))
			if not noteSus and noteDistance > -30 and noteDistance < 10 or noteSus and noteDistance > -30 and noteDistance < 20 then
				
				local anim = getProperty('singAnimations['..noteDir..']')
				if altAnim then
					anim = anim..'-alt'
				end
				if curStep >= 191 and curStep < 239 or curStep >= 320 and curStep < 1231 then
					playAnim('dad',anim,true)
					setProperty('dad.holdTimer',0)
				end
				strumAnim(noteDir,'confirm',true)
				callOnLuas('opponentNoteHit',{notes,noteDir,noteType,noteSus})
				removeFromGroup('notes',notes)
				setProperty('vocals.volume',1)
			end
		end
	end
	for strum = 0,3 do
		if getProperty('strumNotesExtra'..strum..'.animation.curAnim.finished') == true then
			strumAnim(strum,'static')
		end
	end
end
function strumAnim(id,anim,reset)
	if getProperty('strumNotesExtra'..id..'.animation.curAnim.name') ~= anim or reset then
		runHaxeCode(
			[[
				game.getLuaObject('strumNotesExtra]]..id..[[').playAnim("]]..anim..'",'..tostring(reset == true)..[[);
				return;
			]]
		)
		--playAnim('strumNotesExtra'..id,anim,reset)
	end
end
function onEvent(name,v1,v2)
	if name == '3rdstrum' then
		for strums = 0,3 do
			if string.lower(v1) ~= 'false' then
				if not created then
					if not middlescroll then
						doTweenX('strumExtraX'..strums,'strumNotesExtra'..strums,defaultX[strums + 1],1,'sineOut')
					else
						if downscroll then
							doTweenY('strumExtraY'..strums,'strumNotesExtra'..strums,50,1,'sineOut')
						else
							doTweenY('strumExtraY'..strums,'strumNotesExtra'..strums,screenHeight - 150,1,'sineOut')
						end
					end
					if strums == 3 then
						created = true
					end
				else
					local alpha = 1
					if middlescroll then
						alpha = 0.35
					end
					doTweenAlpha('strumExtraAlpha'..strums,'strumNotesExtra'..strums,alpha,0.3,'sineOut')
				end
			else
				doTweenAlpha('strumExtraAlpha'..strums,'strumNotesExtra'..strums,0,0.3,'sineOut')
			end
		end
	end
end