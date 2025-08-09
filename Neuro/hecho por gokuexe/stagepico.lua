function onCreate()
makeLuaSprite('dark','erect/backDark',-400,-200)
setScrollFactor('dark', 0.9, 0.9)
setProperty('dark.alpha',1)
addLuaSprite('dark')
scaleObject('dark',1, 1)
makeAnimatedLuaSprite('audencia', 'erect/crowd', 280, 440)
scaleObject('audencia', 1, 1);
setScrollFactor('audencia', 0.8, 0.8)
setPropertyLuaSprite('audencia', 'flipX', false);
addLuaSprite('audencia', false);
addAnimationByPrefix('audencia', 'Symbol 2 instance 1', 'Symbol 2 instance 1', 24, true);
setObjectOrder('audencia',1);
makeLuaSprite('bg','erect/bg',-700,90)
addLuaSprite('bg')
scaleObject('bg',1, 1)
-- makeLuaSprite('light','erect/lights',-700,90)
-- setScrollFactor('light', 0.7, 0.7)
-- addLuaSprite('light')
-- setObjectOrder('light',0);
-- scaleObject('light',1, 1)
-- makeLuaSprite('n', 'erect/orangeLight', 0, 0);
setObjectCamera('n', 'other')
setProperty('n.alpha', 0.2)
addLuaSprite('n', true);
end