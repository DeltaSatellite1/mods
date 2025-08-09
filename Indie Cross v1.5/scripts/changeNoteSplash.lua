local texture = 'noteSplashes/noteSplashes'
local splashAlpha = 0
local enableSystem = true

local splashes = {}
local splashAnims = {'note splash purple 1','note splash blue 1', 'note splash green 1','note splash red 1'}
function onCreate()
	if version >= '0.7' then
		if enableSystem then
			splashAlpha = getPropertyFromClass('backend.ClientPrefs','data.splashAlpha')
			setPropertyFromClass('backend.ClientPrefs','data.splashAlpha',0)
		end
	else
		splashAlpha = 0.6
		enableSystem = getPropertyFromClass('ClientPrefs','noteSplashes') == true
		setPropertyFromClass('ClientPrefs','noteSplashes',false)
	end

end
function onDestroy()
	if version >= '0.7' then
		if enableSystem then
			setPropertyFromClass('backend.ClientPrefs','data.splashAlpha',splashAlpha)
		end
	else
		setPropertyFromClass('ClientPrefs','noteSplashes',splashAlpha > 0)
	end
end

function onCreatePost()
	precacheImage(texture)
	if splashAlpha > 0 and enableSystem then
		precacheImage('noteSplashes/noteParry')
		makeAnimatedLuaSprite('noteSplashp', texture, 100, 100)
		addLuaSprite('noteSplashp',false)
		setProperty('noteSplashp.alpha',0.001)
		if songName == 'build-our-freaky-machine' then
			precacheImage('IC_NoteSplash - grey')
		end
	end
end

function goodNoteHit(id, data, type, sus)
	if splashAlpha > 0 and getPropertyFromGroup('notes',id,'rating') == 'sick' and enableSystem then
		spawnSplash(data,type)
	end
end

function hasSplash(direction,type)
	for splash = 1,#splashes do
		if splashes[splash][1] == type and splashes[splash][2] == direction and getProperty(splashes[splash][3]..'.animation.curAnim.finished') == true then
			playAnim(splashes[splash][3],'anim',true)
			setProperty(splashes[splash][3]..'.visible',true)
			setProperty(splashes[splash][3]..'.x',getPropertyFromGroup('playerStrums',direction,'x'))
			setProperty(splashes[splash][3]..'.y',getPropertyFromGroup('playerStrums',direction,'y'))
			return true
		end
	end
	return false
end
function spawnSplash(direction, type)
	if not hasSplash(direction,type) then
		local name = 'noteSplash'..#splashes
		local file = texture
		local scaleX = 1
		local scaleY = 1
		local anim = splashAnims[direction+1]
		
		local speed = 26
		local offsetX = 85
		local offsetY = 85
		local color
		if type == 'BlueBoneNote' then
			color = '000000'

		elseif type == 'OrangeBoneNote' or type == 'PapyrusNote' then
			anim = 'note splash orange 1'

		elseif type == 'BendySplashNote' then
			anim = 'note splash purple 1'

		elseif type == 'Parry Note' then
			file = 'noteSplashes/noteParry'
			offsetX = 210
			offsetY = 240
			scaleX = 0.8
			scaleY = 0.8
			anim = 'ParryFX'
		end
		makeAnimatedLuaSprite(name, file, getPropertyFromGroup('playerStrums', direction, 'x'), getPropertyFromGroup('playerStrums', direction, 'y'))
		scaleObject(name,scaleX,scaleY)
		addAnimationByPrefix(name, 'anim', anim, speed, false)
		setObjectCamera(name, 'hud')
		if version >= '0.7' then
			runHaxeCode(
				[[
					game.noteGroup.insert(game.noteGroup.members.indexOf(game.grpNoteSplashes),game.getLuaObject("]]..name..[["));
					return;
				]]
			)
		else
			runHaxeCode(
				[[
					game.insert(game.members.indexOf(game.grpNoteSplashes),game.getLuaObject("]]..name..[["));
					return;
				]]
			)
		end
		--addLuaSprite(name,true)

		setProperty(name..'.offset.x', offsetX)
		setProperty(name..'.offset.y', offsetY)
		setProperty(name..'.alpha', 0.6)

		if color ~= nil then
			setProperty(name..'.color',color)
		end
		table.insert(splashes,{type,direction,name})
	end
end

function onUpdate()
	for splash = 1,#splashes do
		if luaSpriteExists(splashes[splash][3]) and getProperty(splashes[splash][3]..'.animation.curAnim.finished') == true then
			setProperty(splashes[splash][3]..'.visible',false)
		end
	end
end