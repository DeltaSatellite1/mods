local splashOld = ''
function onCreate()
    if version <= '0.6.3' then
        splashOld = getPropertyFromClass('PlayState','SONG.splashSkin')
        if splashOld == nil or splashOld == '' or splashOld == 'SONG.splashSkin' then
            splashOld = nil
            setPropertyFromClass('PlayState','SONG.splashSkin','noteSplashes/noteSplashes')
        end
    end
    debugPrint(getPropertyFromClass('states.PlayState','SONG.splashSkin'))
    precacheImage('noteSplashes/noteSplashes')
end
function onDestroy()
    if version <= '0.6.3' then
        setPropertyFromClass('PlayState','SONG.splashSkin',splashOld)
    end
end