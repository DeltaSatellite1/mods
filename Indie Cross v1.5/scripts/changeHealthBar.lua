local healthBarStyle = ''
local barOffsetX = 0
local barOffsetY = 0

local barImage = ''
local changeHealthBar = true

function onCreatePost()
	if downscroll then
		setProperty('healthBar.y',getProperty('healthBar.y') - 30)
		setProperty('scoreTxt.y',getProperty('scoreTxt.y') - 30)
		setProperty('iconP1.y',getProperty('iconP1.y') - 30)
		setProperty('iconP2.y',getProperty('iconP2.y') - 30)
	end
	
    if stringStartsWith(curStage,'hall') then
		healthBarStyle = 'Sans'

		
		barImage = 'healthbar-ic/sanshealthbar'
		barOffsetX = 60
		barOffsetY = 6.6
		
		
		setProperty('iconP1.visible', false)
		setProperty('iconP2.visible', false)
		setSansBar()
		setProperty('healthBar.flipX', true)
		if version >= '0.7' then
			setProperty('healthBar.bg.flipX',false)
			setProperty('healthBar.bg.antialiasing',false)
		else
			setProperty('healthBarBG.antialiasing',false)
		end
		
	elseif stringStartsWith(curStage,'factory') then
		healthBarStyle = 'Bendy'

		barImage = 'healthbar-ic/bendyhealthbar'
		barOffsetX = 50
		barOffsetY = 87
	elseif stringStartsWith(curStage,'field') then
	    healthBarStyle = 'Cuphead'
		barImage = 'healthbar-ic/cuphealthbar'

		barOffsetX = 25
		barOffsetY = 18
	else
		changeHealthBar = false
	end
	if changeHealthBar == true then
		createCustomBar(barImage,barOffsetX,barOffsetY)
	end
end
function onEvent(name)
	if name == 'Change Character' and healthBarStyle == 'Sans' then
		setSansBar()
	end
end
function setSansBar()
	setHealthBarColors('FF0000','FFFF00')
end

function createCustomBar(image,offsetX,offsetY)
	if version < '0.7' then
		runHaxeCode(
			[[
				game.healthBarBG.loadGraphic(Paths.image(']]..image..[['));
				game.healthBarBG.offset.set(]]..offsetX..','..offsetY..[[);
				game.healthBar.scale.set(1,3);
				return;
			]]
		)
		setObjectOrder('healthBarBG',getObjectOrder('healthBar'))
	else
		offsetX = offsetX - 5
		offsetY = offsetY - 1.5
		runHaxeCode(
			[[
				game.healthBar.bg.loadGraphic(Paths.image(']]..image..[['));
				game.healthBar.bg.offset.set(]]..offsetX..','..offsetY..[[);
				game.healthBar.leftBar.scale.set(1,3);
				game.healthBar.rightBar.scale.set(1,3);
				return;
			]]
		)
	end
	
end