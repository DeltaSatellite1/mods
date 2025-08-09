local enabled = false
local iconP2Created = false
function onCreatePost()
	precacheImage('finale/healthBarFinaleRed')
	precacheImage('finale/healthBarFinaleBlue')
	for events = 0,getProperty('eventNotes.length')-1 do
		if getPropertyFromGroup('eventNotes',events,'event') == 'Change Character' then
			if getPropertyFromGroup('eventNotes',events,'value2') == 'blackparasite' then
				precacheImage('icons/icon-blackFinale')
			end
		end
	end
	setProperty('healthBar.visible',false)
	setProperty('iconP1.visible',false)
	setProperty('iconP2.visible',false)
	if version <= '0.6.3' then
		setProperty('healthBarBG.visible',false)
	end
	for strum = 0,7 do
		setPropertyFromGroup('strumLineNotes',strum,'visible',false)
	end
end
function makeFinaleHealthBar()
	makeLuaSprite('finaleHealthBarBlue','finale/healthBarFinaleBlue',0,550)
	makeLuaSprite('finaleHealthBarRed',nil,0,550)
	for bars = 1,2 do
		local barsName = {'Red','Blue'}
		local name = 'finaleHealthBar'..barsName[bars]
		scaleObject(name,0.6,0.6)
		setObjectCamera(name,'hud')
		setProperty(name..'.x',screenWidth/2 - (getProperty('finaleHealthBarBlue.width')/2))
		addLuaSprite(name,false)
		if version <= '0.6.3' then
			setObjectOrder(name,getObjectOrder('iconP1') - 2)
		end
	end
	setObjectOrder('finaleHealthBarRed',getObjectOrder('finaleHealthBarBlue') + 1)
	enabled = true
	setProperty('iconP1.visible',true)
	setProperty('iconP2.visible',true)
end
function makeAnimatedIcon(type,iconFile,animations,posX,posY,scaleX,scaleY)
	local name = 'iconP'..type..'Custom'
	makeAnimatedLuaSprite(name,iconFile,posX,posY)
	setObjectCamera(name,'hud')
	for anims = 1,#animations do
		addAnimationByPrefix(name,animations[anims][1],animations[anims][2],animations[anims][3],animations[anims][4])
	end
	setObjectOrder(name,getObjectOrder('iconP2'))
	addLuaSprite(name,true)
	scaleObject(name,scaleX,scaleY)

	if type == '2' then
		iconP2Created = true
	end
end
function onEvent(name,v1,v2)
	if name == 'Change Character' then
		if tonumber(v1) == 1 or string.lower(v1) == 'dad' then
			if v2 == 'blackparasite' then
				makeAnimatedIcon('2','icons/icon-blackFinale',{{'normal','black icon calm',24,true},{'losing','black icon mad',24,true}},0,350,0.8,0.8)
			else
				if iconP2Created == true then
					removeLuaSprite('iconP2Custom',true)
					iconP2Created = false
				end
			end
		end
	end
end
function onSectionHit()
	if curSection == 8 then
		for strum = 0,7 do
			setPropertyFromGroup('strumLineNotes',strum,'visible',true)
		end
	elseif curSection == 17 then
		makeFinaleHealthBar()
		setProperty('health',0.1)
	end
end
function onUpdate()
	if enabled then
		local hp = math.min(2,getProperty('health'))
		local hpX = getProperty('healthBar.x') - 120
		local hpY = getProperty('healthBar.y') - 100
		setProperty('finaleHealthBarBlue.x',hpX)
		setProperty('finaleHealthBarBlue.y',hpY)
		if iconP2Created then
			setProperty('iconP2.visible',false)
			if hp >= 1.7 then
				objectPlayAnimation('iconP2Custom','losing',false)
				setProperty('iconP2Custom.offset.y',0)
			else
				objectPlayAnimation('iconP2Custom','normal',false)
				setProperty('iconP2Custom.offset.y',-32)
			end
		end
		if hp < 2 then
			local redWidth = 1407*(1-(hp/2)) + 100
			loadGraphic('finaleHealthBarRed','finale/healthBarFinaleRed',redWidth,437)
			setProperty('finaleHealthBarRed.x',hpX)
			setProperty('finaleHealthBarRed.y',hpY - 87)
			setProperty('finaleHealthBarRed.offset.x',math.max(0,redWidth * 0.2))
		end
	end
end
function onUpdatePost()
	if enabled then
		local heatlhY = getProperty('healthBar.y')
		setProperty('iconP1.x',getProperty('finaleHealthBarBlue.x') + (getProperty('finaleHealthBarBlue.width')/1.4) + 50)
		setProperty('iconP1.y',heatlhY - (getProperty('iconP1.height')/2))
		setProperty('iconP1.offset.y',(100*(1-getProperty('iconP1.scale.y'))))

		setProperty('iconP2.x',getProperty('finaleHealthBarBlue.x') - 120)
		setProperty('iconP2.y',heatlhY - (getProperty('iconP2.height')/2))
		setProperty('iconP2.offset.y',(100*(1-getProperty('iconP2.scale.y'))))

		if iconP2Created then
			setProperty('iconP2Custom.x',getProperty('iconP2.x') - 50)
			setProperty('iconP2Custom.y',heatlhY - (getProperty('iconP2Custom.height')/2) - 100)
		end

	end
end