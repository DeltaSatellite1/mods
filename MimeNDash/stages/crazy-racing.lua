local enableMove = true
function onCreate()
        makeLuaSprite('sky','stages/crazy-racing/sky',-4970, -2500)
        scaleObject('sky', 5.0, 5.0);
        setScrollFactor('bg',2,2)
        addLuaSprite('sky',false)

    for bgs = 0,1 do
        makeLuaSprite('bg'..bgs,'stages/crazy-racing/clouds',-2893*bgs,-350)
        scaleObject('bg'..bgs, 1.0, 1.0);
        setScrollFactor('bg'..bgs,0.1,0.1)
        setProperty('bg'..bgs..'.velocity.x',20)
        addLuaSprite('bg'..bgs)
	end
	
    for fld = -1000,1000 do
        makeLuaSprite('foreground'..fld,'stages/crazy-racing/field',3400*fld,50)
        setScrollFactor('foreground'..fld,0.5,0.5)
        setProperty('foreground'..fld..'.velocity.x',4500)
        scaleObject('foreground'..fld, 1.8, 1.5);
        addLuaSprite('foreground'..fld)
    end
	
	for trs = -1000,1000 do
        makeLuaSprite('trees1'..trs,'stages/crazy-racing/trees',3400*trs,-170)
        setScrollFactor('trees1'..trs,0.5,0.5)
        setProperty('trees1'..trs..'.velocity.x',4500)
        scaleObject('trees1'..trs, 1.8, 1.5);
        addLuaSprite('trees1'..trs)
    end
	
	for pla = 0,1 do
        makeLuaSprite('front'..pla,'stages/crazy-racing/platform',3500*pla,400)
        scaleObject('front'..pla, 3.0, 1.75);
		setScrollFactor('front'..pla,0.5,0.5)
        setProperty('front'..pla..'.velocity.x',9000000)
        addLuaSprite('front'..pla)
		
	end

    for rl = 0,1 do
        makeLuaSprite('railway'..rl,'stages/crazy-racing/rail',-10*rl - 500,280)
        scaleObject('railway'..rl, 1.5, 1.0);
		setScrollFactor('railway'..rl,0.1,0.1)
        setProperty('railway'..rl..'.velocity.x',5000)
        addLuaSprite('railway'..rl)
    end
	
	for cn = 0,1 do
        makeLuaSprite('coin1'..cn,'stages/crazy-racing/coin',-10*cn - -500,270)
        scaleObject('coin1'..cn, 1.0, 1.0);
		setScrollFactor('coin1'..cn,0.5,0.5)
        setProperty('coin1'..cn..'.velocity.x',5000)
        addLuaSprite('coin1'..cn)
    end
	
	makeAnimatedLuaSprite('fire', 'stages/crazy-racing/fire', 350, 450);
    addLuaSprite('fire', false);
    addAnimationByPrefix('fire', 'idle', 'fire', 24, true);	
	scaleObject('fire',1.6,1.6)
	setProperty('fire.visible', true);
	
	makeAnimatedLuaSprite('humo', 'stages/crazy-racing/humo', 350, 750);
    addLuaSprite('humo', false);
    addAnimationByPrefix('humo', 'idle', 'humo', 24, true);	
	scaleObject('humo',1.6,1.6)
	setProperty('humo.visible', true);
	
end

function onUpdate()
    if enableMove then
        setProperty('boyfriendGroup.x',-225 + (50*math.sin(getSongPosition()/bpm/2)))
        setProperty('dadGroup.x',-700 + (50*math.sin(getSongPosition()/bpm/2)))
		setProperty('fire.x',470 + (50*math.sin(getSongPosition()/bpm/2)))
		setProperty('humo.x',-1020 + (50*math.sin(getSongPosition()/bpm/2)))
        setProperty('gfGroup.x',-225 + (50*math.sin(getSongPosition()/bpm/2)))		
    end
    for bgs = 0,1 do
        if getProperty('front'..bgs..'.x') >= 1500 then
            setProperty('front'..bgs..'.x',getProperty('front'..bgs..'.x') - (-13850*1) - 23100)
        end
		if getProperty('coin1'..bgs..'.x') >= 6600 then
            setProperty('coin1'..bgs..'.x',getProperty('coin1'..bgs..'.x') - (2500*5) - 6000)
           end
        if getProperty('railway'..bgs..'.x') >= 6600 then
            setProperty('railway'..bgs..'.x',getProperty('railway'..bgs..'.x') - (2500*5) - 6000)
        end
        if curStage == 0 then
            if getProperty('bg'..bgs..'.x') >= 2400 then
                setProperty('bg'..bgs..'.x',getProperty('bg'..bgs..'.x') - (2893*2) - 400)
            end
            if getProperty('foreground'..bgs..'.x') >= 1500 then
                setProperty('foreground'..bgs..'.x',getProperty('foreground'..bgs..'.x') - (-13850*1) - 23100)
            end
			if getProperty('trees1'..bgs..'.x') >= 1500 then
                setProperty('trees1'..bgs..'.x',getProperty('trees1'..bgs..'.x') - (-13850*1) - 23100)
            end
        end
    end
end