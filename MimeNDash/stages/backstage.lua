function onCreate()
    makeLuaSprite('M','stages/backstage/mirror',-300,-550)
	setScrollFactor('M',1,1)
	setProperty('M.alpha', 0.5);
    scaleObject('M',1,1)
    addLuaSprite('M')
	
	makeLuaSprite('bg','stages/backstage/bg',-330,-730)
	setScrollFactor('bg',1,1)
    scaleObject('bg',1.2,1.2)
    addLuaSprite('bg')
end