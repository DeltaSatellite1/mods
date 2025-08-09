function onCreate()
	makeLuaSprite('loungeBG','airship/lounge',-265,-66)
	addLuaSprite('loungeBG',false)

	makeLuaSprite('loungeLight','airship/loungelight',-368,-135)
	setBlendMode('loungeLight','add')
    addLuaSprite('loungeLight',true)
end