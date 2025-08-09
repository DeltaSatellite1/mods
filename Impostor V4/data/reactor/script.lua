function onCreatePost()
    triggerEvent('FocusCamScript','both,both,0,-50','')
    setProperty('camGame.zoom',getProperty('defaultCamZoom') - 0.1)
    setProperty('defaultCamZoom',getProperty('defaultCamZoom') - 0.1)
end