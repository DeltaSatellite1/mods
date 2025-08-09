function onCreatePost()
    setProperty('gf.alpha',0.01)
end
function onStepHit()
    if curStep > 816 then
        setProperty('gf.alpha',1)
    end
end