function onCreate()
makeLuaSprite('dark','erect/backDark',-400,-600)
setScrollFactor('dark', 1, 1)
setProperty('dark.alpha',1)
addLuaSprite('dark')
scaleObject('dark',2.5, 2)
makeAnimatedLuaSprite('audencia', 'erect/crowd', 280, 440)
scaleObject('audencia', 1.2, 1.2);
setScrollFactor('audencia', 0.8, 0.8)
setPropertyLuaSprite('audencia', 'flipX', false);
addLuaSprite('audencia', false);
addAnimationByPrefix('audencia', 'Symbol 2 instance 1', 'Symbol 2 instance 1', 24, true);
setObjectOrder('audencia',1);
makeLuaSprite('bg','erect/bg',-650,0)
addLuaSprite('bg')
scaleObject('bg',1, 1)
makeLuaSprite('light','erect/lights',-600,0)
setScrollFactor('light', 0.7, 0.8)
addLuaSprite('light')
setObjectOrder('light', 'other');
setProperty('light.alpha', 1)
scaleObject('light',0.9, 1)
makeLuaSprite('orange', 'erect/orangeLight', 0, 0);
setObjectCamera('orange', 'other')
setProperty('orange.alpha', 1)
addLuaSprite('orange', true);
end