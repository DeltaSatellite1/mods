function onCreate()
    triggerEvent('FocusCamScript','both,bf,0,-100','')
    triggerEvent('Extra Cam Zoom','-0.2','0')
    triggerEvent('coverScreen','1,other','0')
end
function onStartSong()
    triggerEvent('HUD Fade','1','0')
end