local characterFiles =
{
	animations= {
		{
			loop= false,
			offsets= {
				-40,
				90
			},
			anim= 'idle',
			fps= 24,
			name= 'Idle',
			indices= {}
		},
		{
			loop= false,
			offsets= {
				47,
				82
			},
			anim= 'singLEFT',
			fps= 24,
			name= 'Left',
			indices= {}
		},
		{
			loop= false,
			offsets= {
				-23,
				131
			},
			anim= 'singUP',
			fps= 24,
			name= 'Up',
			indices= {}
		},
		{
			loop= false,
			offsets= {
				-85,
				22
			},
			anim= 'singDOWN',
			fps= 24,
			name= 'Down',
			indices= {}
		},
		{
			loop= false,
			offsets= {
				-71,
				56
			},
			anim= 'singRIGHT',
			fps= 24,
			name= 'Right',
			indices= {}
		}
	},
	no_antialiasing= false,
	image= 'characters/Reginald_Assets',
	position= {
		-80,
		10
	},
	healthicon= 'reginald',
	flip_x= false,
	healthbar_colors= {
		255,
		255,
		255
	},
	camera_position= {
		0,
		0
	},
	sing_duration= 6.1,
	scale= 1
}
local xx = -60
local yy = 210
local enableCamMoviment = true
local ofs = 20
local camFollowX = characterFiles.camera_position[1]
local camFollowY = characterFiles.camera_position[2]
local holdTimer = 0
local currentAnim = ''
local enableSameNote = false
local singAnims = {'singLEFT','singDOWN','singUP','singRIGHT'}
local section3 = false

function onCreatePost()
    makeAnimatedLuaSprite('player3Lua',characterFiles.image,xx + characterFiles.position[1],yy + characterFiles.position[2])
    scaleObject('player3Lua',characterFiles.scale,characterFiles.scale)
    if characterFiles.no_antialiasing == true then
        setProperty('player3Lua.antialiasing',false)
    end
    for animations = 1,#characterFiles.animations do
        local lol = characterFiles.animations[animations]
        if lol.indies == nil then
            addAnimationByPrefix('player3Lua',lol.anim,lol.name,lol.fps,lol.loop)
        else
            addAnimationByIndices('player3Lua',lol.anim,lol.name,lol.indices,lol.fps)
        end
    end
	setObjectOrder('player3Lua',getObjectOrder('dadGroup') + 1)
    player3Anim('idle')
    addLuaSprite('player3Lua',false)
end
function onUpdate(el)
    if string.find(currentAnim,'sing') ~= nil then
        holdTimer = holdTimer + el 
        if holdTimer > stepCrochet * 0.0011 * characterFiles.sing_duration then
            holdTimer = 0
            player3Anim('idle',false)
        end
    end
end
function onBeatHit()
	if curBeat % 2 == 0 then
		if currentAnim == 'idle' then
			player3Anim('idle',false)
		end
	end
end
function onEvent(name,v1,v2)
	if name == 'player3sing' then
		if v1 == '1' or v1 == '' then
			enableSameNote = true
		else
			enableSameNote = false
		end
	elseif name == 'Extra Play Animation' then
		if v1 == '3' then
			player3Anim(v2,true)
		end
	end
end

function opponentNoteHit(id,dir,type,sus)
	if enableSameNote or type == 'Opponent 2 Sing' then
		player3Anim(singAnims[dir + 1],true)
		holdTimer = 0
	end
end
function player3Anim(anim_name,reset)
	if reset == nil then
		reset = false
	end
    if anim_name ~= currentAnim then
        for offsets = 1,#characterFiles.animations do
            local anim = characterFiles.animations[offsets]
            if anim.anim == anim_name then
                setProperty('player3Lua.offset.x',anim.offsets[1])
                setProperty('player3Lua.offset.y',anim.offsets[2])
            end
        end
    end
	objectPlayAnimation('player3Lua',anim_name,reset)
	currentAnim = anim_name
end