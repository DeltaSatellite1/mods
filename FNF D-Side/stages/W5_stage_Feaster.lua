function onCreate()

    makeLuaSprite('bg','W5/evilBG', -700, -680)
	addLuaSprite('bg',false)
	setLuaSpriteScrollFactor('bg' , 0.5, 0.1);

	makeAnimatedLuaSprite('CreppyEvilAudience2', 'W5/evilupperBop', -260, 214)
	addAnimationByPrefix('CreppyEvilAudience2', 'IdleEaster2', 'Upper Crowd Bop', 24, true)
	addLuaSprite('CreppyEvilAudience2', false)
	objectPlayAnimation ('CreppyEvilAudience2', 'IdleEaster2', false)
	setLuaSpriteScrollFactor('CreppyEvilAudience2' , 0.5, 0.1);

	makeLuaSprite('egg','W5/evilTree', 298, -307)
	addLuaSprite('egg', false);
	setLuaSpriteScrollFactor('egg' , 0.6, 0.6);

	makeAnimatedLuaSprite('EvilAudience', 'W5/evilbottomBop', 0, 119)
	addAnimationByPrefix('EvilAudience','IdleEaster', 'Bottom Level Boppers', 24, true)
	addLuaSprite('EvilAudience', false)
	objectPlayAnimation ('EvilAudience', 'IdleEaster', false);

	makeLuaSprite('floor','W5/evilSnow',-581,775)
	addLuaSprite('floor', false);

	makeAnimatedLuaSprite('springtrap', 'W5/evilsanta', -521, 170)
	addAnimationByPrefix('springtrap','IdleSpring','evilsanta idle in fear', 24, true)
	addLuaSprite('springtrap', false)
	objectPlayAnimation ('springtrap', 'Idle', false)


end

function onBeatHit()
	objectPlayAnimation ('EvilAudience', 'IdleEaster', true)
	objectPlayAnimation ('springtrap', 'IdleSpring', true)
	objectPlayAnimation ('CreppyEvilAudience2', 'IdleEaster2', true)


end
