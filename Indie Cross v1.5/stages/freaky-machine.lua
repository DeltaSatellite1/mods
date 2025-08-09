function onCreate()
  if songName == 'build-our-freaky-machine' and not lowQuality then
      makeAnimatedLuaSprite('CupheqdShid', 'cup/CUpheqdshid',-350,-193);
      addAnimationByPrefix('CupheqdShid','dance','Cupheadshit_gif instance 1',24,true);
      objectPlayAnimation('CupheqdShid','Cupheadshit_gif instance',false)
      scaleObject('CupheqdShid',1.6,1.6)
      setObjectCamera('CupheqdShid','other')
      setProperty('CupheqdShid.color','FFFFFF')
      setProperty('CupheqdShid.alpha',0.01)
      
      makeAnimatedLuaSprite('Grain', 'cup/Grainshit',-350,-193);
      addAnimationByPrefix('Grain','dance','Geain instance 1',24,true);
      objectPlayAnimation('Grain','Geain instance 1',false)
      scaleObject('Grain',1.6,1.6)
      setObjectCamera('Grain','other')
      setProperty('Grain.color','FFFFFF')
      setProperty('Grain.alpha',0.01)
    
      makeLuaSprite('BendyVignette', 'bendy/gay/C_07',0,0);
      scaleObject('BendyVignette',0.7,0.7)
      setObjectCamera('BendyVignette','other')
      setProperty('BendyVignette.alpha',0.01)

      addLuaSprite('CupheqdShid', true)
      addLuaSprite('Grain',true)
      addLuaSprite('BendyVignette',true)
	end

  makeAnimatedLuaSprite('bendyVideo','bendy/reel',-100,-100)
  addAnimationByPrefix('bendyVideo','bVideo','Bendy',12,true)
  setBlendMode('bendyVideo','add')
  scaleObject('bendyVideo',3,3)


  makeLuaSprite('bendyBG','bendy/BonusSongs/dabg',-350,50)
  scaleObject('bendyBG',1.3,1.3)



  makeLuaSprite('Curtain1','bendy/BonusSongs/Curtain1',-300,-170)
  scaleObject('Curtain1',1.5,1.5)

  makeLuaSprite('Curtain2','bendy/BonusSongs/Curtain2',600,-170)
  scaleObject('Curtain2',1.5,1.5)

  addLuaSprite('bendyBG',false)
  addLuaSprite('bendyVideo',false)
  addLuaSprite('Curtain1',false)
  addLuaSprite('Curtain2',false)
end

function onStepHit()
  if songName == 'Freaky-Machine' then
    if curStep == 687 then
        makeLuaSprite('black','',0,0)
        makeGraphic('black',screenWidth,screenHeight,'000000')
        setProperty('black.alpha',0)
        setObjectCamera('black','hud')
        addLuaSprite('black',true)
    elseif curStep== 698 then
      doTweenAlpha('blackTween','black',1,1,'linear')
      setProperty('defaultCamZoom',0.8)
    elseif curStep== 700 then
      removeLuaSprite('black',true)
      doTweenX('Curtain1','Curtain2',1250,1)
      doTweenX('Curtain2','Curtain1',-950,1)
    end
  end
end
function onSectionHit()
  if songName == 'build-our-freaky-machine' then
    if curSection == 80 then
      doTweenX('Curtain1','Curtain1',-950,1,'QuintInOut')
      doTweenX('Curtain2','Curtain2',1250,1,'QuintInOut')
      if not lowQuality then
        setProperty('Grain.alpha',1)
        setProperty('CupheqdShid.alpha',1)
        setProperty('BendyVignette.alpha',1)
      end
    elseif curSection == 96 then
      doTweenX('Curtain1','Curtain1',-300,1.5,'QuintInOut')
      doTweenX('Curtain2','Curtain2',600,1.5,'QuintInOut')
      removeLuaSprite('Grain',true)
      removeLuaSprite('CupheqdShid',true)
      removeLuaSprite('BendyVignette',true)
    end
  end
end