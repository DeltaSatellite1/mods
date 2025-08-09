function onCreate()
  makeLuaSprite('bg1','TOO-SLOW/background ladders',-200,-260)
  makeLuaSprite('bg2','TOO-SLOW/background ladders2',-200,-260)
  makeLuaSprite('icicle1','TOO-SLOW/icicles background',-190,-150)
  makeLuaSprite('fg2','TOO-SLOW/main stage spoopy',-600,0)
  makeLuaSprite('fg1','TOO-SLOW/main stage',-600,0)
  makeLuaSprite('icicle2','TOO-SLOW/icicles foreground',-380,-150)
  setScrollFactor('icicle2',1.7,1.2)
  scaleObject('icicle2',0.9,0.9)
  addLuaSprite('bg1',false)
  addLuaSprite('fg2',false)
  addLuaSprite('bg2',false)
  addLuaSprite('icicle1',false)
  addLuaSprite('fg1',false)
  addLuaSprite('icicle2',true)
  end
function onStepHit()
  if curStep==383 then
    setProperty('iconP2.visible', false)
    makeLuaSprite('black','black',-300,0)
    scaleObject('black',3.3,3.3)
    setObjectCamera('black','front')
    addLuaSprite('black',true)
  end
  if curStep==448 then
  doTweenAlpha('black','black',0,1)
  setProperty('iconP2.visible', true)
  setProperty('health', 1)
  setProperty('songScore', 0)
  setProperty('songMisses', 0)
end
  end