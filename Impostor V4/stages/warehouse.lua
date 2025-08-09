function onCreate()
	makeLuaSprite('wareFloor','torture/tort_floor',-1375,495)
	addLuaSprite('wareFloor',false)

	makeLuaSprite('wareWall','torture/torture_wall',-920,-850)
	addLuaSprite('wareWall',false)

	makeLuaSprite('wareGlasses','torture/torture_glasses_preblended',-160,-605)
	addLuaSprite('wareGlasses',false)


	makeAnimatedLuaSprite('wareLeftBlades','torture/leftblades',300,-370)
	addAnimationByPrefix('wareLeftBlades','anim','blad',24,true)
	setScrollFactor('wareLeftBlades',1.4,1,4)
	setObjectOrder('wareLeftBlades',getObjectOrder('boyfriendGroup') + 1)
	addLuaSprite('wareLeftBlades',false)

	makeAnimatedLuaSprite('wareRightBlades','torture/rightblades',750,-370)
	addAnimationByPrefix('wareRightBlades','anim','blad',24,true)
	setScrollFactor('wareRightBlades',1.4,1,4)
	setObjectOrder('wareRightBlades',getObjectOrder('boyfriendGroup') + 1)
	addLuaSprite('wareRightBlades',false)
	if not lowQuality then
		makeLuaSprite('wareLights','torture/windowlights',-160,-605)
		setProperty('wareLights.alpha',0.3)
		setBlendMode('wareLights','add')
		addLuaSprite('wareLights',true)

		makeAnimatedLuaSprite('wareMonty','torture/monty',14,440)
		addAnimationByPrefix('wareMonty','idle','mole idle instance 1',24,false)
		addLuaSprite('wareMonty',true)

		makeLuaSprite('wareGlow','torture/torture_glow2',-410,-480)
		setBlendMode('wareGlow','add')
		setProperty('wareGlow.alpha',0.35)
		addLuaSprite('wareGlow',true)
	end
	if songName == 'Torture' then
		setProperty('wareLeftBlades.x',215)
		setProperty('wareRightBlades.x',835)
		setProperty('wareLeftBlades.y',-670)
		setProperty('wareRightBlades.y',-670)
	end
end
function onCreatePost()
	setScrollFactor('dadGroup',1.6,1.6)
	setScrollFactor('gfGroup',1.6,1.6)
	setObjectOrder('dadGroup',getObjectOrder('boyfriendGroup') + 2)
	setObjectOrder('gfGroup',getObjectOrder('boyfriendGroup') + 2)
	if songName == 'Torture' then
		setObjectsAlpha(0.001,0)
	end
end
local doneOpening = false
local blades = false
function onBeatHit()
	if not lowQuality and curBeat % 2 == 0 then
		objectPlayAnimation('wareMonty','idle',true)
	end
	if songName == 'Torture'  then
		if curBeat >= 32 and not doneOpening then
			setObjectsAlpha(1,0)
			doneOpening = true
		end
		if curBeat >= 64 and not blades then
			doTweenX('bladesWareLeftX','wareLeftBlades',getProperty('wareLeftBlades.x') + 85,1,'quintOut')
			doTweenX('bladesWareRightX','wareRightBlades',getProperty('wareRightBlades.x') - 85,1,'quintOut')
			doTweenY('bladesWareLeft','wareLeftBlades',getProperty('wareLeftBlades.y') + 300,1,'quintOut')
			doTweenY('bladesWareRight','wareRightBlades',getProperty('wareRightBlades.y') + 300,1,'quintOut')
			blades = true
		end
	end
end
function setObjectsAlpha(alpha,speed)
	local objects = {'wareWall','wareFloor','wareGlasses','wareLeftBlades','wareRightBlades','boyfriend','gf','dad','wareLights','wareMonty','wareGlow'}
	for object = 1,#objects do
		local alphaTarget = alpha
		if objects[object] == 'wareLights' and alpha > 0.3 then
			alphaTarget = alpha - 0.7
		elseif objects[object] == 'wareGlow' and alpha > 0.35 then
			alphaTarget = alpha - 0.65
		end
		if object >= #objects - 3 and not lowQuality or object < #objects - 3 then
			if speed ~= 0 then
				doTweenAlpha(objects[object]..'Alpha',objects[object],alphaTarget,speed,'linear')
			else
				setProperty(objects[object]..'.alpha',alphaTarget)
			end
		end
	end

end
function onUpdate()
	if songName == 'Torture' and curStep > 256 or songName ~= 'Torture' then
		local health = getProperty('health')
		setProperty('wareLeftBlades.x',330 - (60 * health))
		setProperty('wareRightBlades.x',710 + (60 * health))
	end
end