local playstate = 'states.PlayState'
function onCreate()
  --background
  makeLuaSprite('BG','cup/BonusSongs/devil',-1000,-1050)
  setScrollFactor('BG',1.0,1.0)
  scaleObject('BG',2.3,2.3)
  addLuaSprite('BG',false)

  if not lowQuality then
    makeAnimatedLuaSprite('CupheqdShid', 'cup/CUpheqdshid',-350,-193);
    addAnimationByPrefix('CupheqdShid','dance','Cupheadshit_gif instance 1',24,true);
    objectPlayAnimation('CupheqdShid','Cupheadshit_gif instance',false)
    scaleObject('CupheqdShid',1.6,1.6)
    setLuaSpriteScrollFactor('CupheqdShid', 0, 0);
    setObjectCamera('CupheqdShid','hud');
      
    
    makeAnimatedLuaSprite('Grain', 'cup/Grainshit',-350,-193);
    addAnimationByPrefix('Grain','dance','Geain instance 1',24,true);
    objectPlayAnimation('Grain','Geain instance 1',false)
    scaleObject('Grain',1.6,1.6)
    setLuaSpriteScrollFactor('Grain', 0, 0);
    setObjectCamera('Grain','hud');

    addLuaSprite('CupheqdShid',true)
    addLuaSprite('Grain',true)
    end
    if version <= '0.6.3' then
      playstate = 'PlayState'
    end
    if (getPropertyFromClass(playstate,'SONG.arrowSkin') == '' or getPropertyFromClass(playstate,'SONG.arrowSkin') == nil) then
      setPropertyFromClass(playstate,'SONG.arrowSkin','cup/Cuphead_NOTE_assets')
      if version >= '0.7' then
        setPropertyFromClass('states.PlayState','SONG.disableNoteRGB',true)
      end
    end
end
function onDestroy()
  if (getPropertyFromClass(playstate'SONG.arrowSkin')) == 'cup/Cuphead_NOTE_assets' then
    setPropertyFromClass(playstate,'SONG.arrowSkin',nil)
    if version >= '0.7' then
      setPropertyFromClass(playstate,'SONG.disableNoteRGB',false)
    end
  end
end