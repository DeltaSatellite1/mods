function onCreate()
	makeLuaSprite('thefunnyeffect','thefunnyeffect',-600,-200)
	addLuaSprite('thefunnyeffect',true)
	makeAnimatedLuaSprite('BallisticBackground','BallisticBackground',-550,-200)
	addAnimationByPrefix('BallisticBackground','BallisticBackground','Background Whitty Moving',24,true)
	addLuaSprite('BallisticBackground',false)
	objectPlayAnimation('BallisticBackground','BallisticBackground',false)
end