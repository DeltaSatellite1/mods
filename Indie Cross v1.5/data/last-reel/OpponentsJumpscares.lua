function onCreate()
	makeAnimatedLuaSprite('PiperJumpscare','bendy/jumpscares/PiperJumpscare',0,0)
	addAnimationByPrefix('PiperJumpscare','Piper','Fuck uuuu instance 1',20,false)
	
    setObjectCamera('PiperJumpscare','hud')
    addLuaSprite('PiperJumpscare',true)
    setProperty('PiperJumpscare.alpha',0.001)
    

    makeAnimatedLuaSprite('AnotherEnemyBendy', 'bendy/jumpscares/DontmindmeImmajustwalkby',-800,-50)
    setObjectCamera('AnotherEnemyBendy','hud')
    addAnimationByPrefix('AnotherEnemyBendy','boo','WalkinFhis',0,true)
    addLuaSprite('AnotherEnemyBendy',true)
    setProperty('AnotherEnemyBendy.alpha',0.001)

    precacheImage('bendyjumpscares/DontmindmeImmajustwalkby')
    precacheSound('bendy/boo')
end


local enemyFrame = 0
local enemySpeed = 24
local enemyDir = 1
local enableEnemy = false
local enemyLoopTimes = 1
function onUpdate(el)
    if enableEnemy then
        setProperty('AnotherEnemyBendy.animation.curAnim.curFrame',enemyFrame)
        setProperty('AnotherEnemyBendy.alpha',1)
        enemyFrame = enemyFrame + (el * enemySpeed)
        
        if enemyDir == 1 and enemySpeed < 24 then
            enemySpeed = math.min(24,enemySpeed + (el*60))

        elseif enemyDir == -1 and enemySpeed > -24 then
            enemySpeed = math.max(-24,enemySpeed - (el*60))

        end

        if enemyDir == 1 and enemyFrame >= 100 and enemyLoopTimes > 0 then
            enemyDir = -1

        elseif enemyDir == -1 and enemyFrame <= 27 then
            enemyDir = 1
            enemyLoopTimes = enemyLoopTimes - 1

        end
        if enemyFrame >= 130 then
            removeLuaSprite('AnotherEnemyBendy',false)
            enableEnemy = false
        end
    end
end 

function onStepHit()
    if curStep == 1023 then
        playSound('bendy/boo')
        setProperty('PiperJumpscare.alpha',1)
        playAnim('PiperJumpscare','Piper',true)
	end
end
function onSectionHit()
    if curSection == 126 then
        enableEnemy = true
        addLuaSprite('AnotherEnemyBendy',true)
        setProperty('AnotherEnemyBendy.alpha',1)
    end
end