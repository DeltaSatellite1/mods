local played = false
function onUpdate()
    if curStep >= 1600 and not played then
        setProperty('boyfriend.visible',false)
        setProperty('gf.visible',false)
        characterPlayAnim('dad','liveReaction',false)
        setProperty('dad.specialAnim',true)
        played = true
    end
end