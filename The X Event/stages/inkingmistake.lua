function onCreatePost()
    luaDebugMode = true;
    addHaxeLibrary('FlxEase', 'flixel.tweens');
    addHaxeLibrary('FlxTween', 'flixel.tweens');
    addHaxeLibrary('FlxMath', 'flixel.math');
    addHaxeLibrary('Math');
    addHaxeLibrary('ClientPrefs');

    runHaxeCode([[
        setVar('bg', FlxSprite);
        setVar('bg2', FlxSprite);
        setVar('lg', FlxSprite);
        setVar('part', FlxSprite);
        setVar('xgaster', FlxSprite);
        setVar('nyxObjects', []);

        if (!ClientPrefs.lowQuality){
            for (i in 0...7){
                bg = new FlxSprite(-600, -200).loadGraphic(Paths.image('inkingmistake/bg' + i));
                bg.antialiasing = ClientPrefs.globalAntialiasing;
                bg.scrollFactor.set(0.92+i*0.025, 0.92+i*0.025);
                bg.active = false;
                game.addBehindGF(bg);
                getVar('nyxObjects').push(bg);
    
                if (i>1) {
                    var go = bg;
                    var newx = bg.x;
                    var newy = bg.y+50;
                    var tweenTime = (Math.random()*5+5)/2;
                    var delayTime = 0;
                    var newEase = FlxEase.quadInOut;
    
                    FlxTween.tween(go, {y: newy, x: newx}, tweenTime, {
                        ease: newEase,
                        type: FlxTween.PINGPONG,
                        loopDelay: delayTime
                    });
                }
            }
        }

        bg2 = new FlxSprite(-600, -230).loadGraphic(Paths.image('inkingmistake/ground'));
        bg2.antialiasing = ClientPrefs.globalAntialiasing;
        bg2.scrollFactor.set(0.9, 0.9);
        bg2.active = false;
        game.addBehindGF(bg2);
        getVar('nyxObjects').push(bg2);

        if (!ClientPrefs.lowQuality){
            lg = new FlxSprite(-600, -200).loadGraphic(Paths.image('inkingmistake/fg'));
            lg.antialiasing = ClientPrefs.globalAntialiasing;
            lg.scrollFactor.set(0.9, 0.9);
            lg.active = false;
            game.add(lg);
            getVar('nyxObjects').push(lg);
    
            FlxTween.tween(lg, {alpha:0.4}, 2, {
                ease: FlxEase.quadInOut,
                type: FlxTween.PINGPONG,
                loopDelay: 0.5
            });
    
            for (i in 0...30){
                part = new FlxSprite(-1200+150*i, 1000).loadGraphic(Paths.image('overwrite/particle'));
                part.antialiasing = ClientPrefs.globalAntialiasing;
                part.scrollFactor.set(0.92, 0.92);
                part.active = false;
    
                    var go = part;
                    var newx = part.x;
                    var amp = 120;
                    var newy = part.y-2000;
                    var newalpha = 0;
                    var tweenTime = (Math.random()*5+3);
                    var delayTime = 0;
                    var newEase = FlxEase.quadInOut;
                    var baseScale = 1;
    
                    var randomScale = 0.4 + Math.random()*baseScale;
                    go.scale.set(randomScale, randomScale);
                    FlxTween.tween(go, {y: newy, alpha: newalpha}, tweenTime, {
                        ease: newEase,
                        type: FlxTween.LOOPING,
                        loopDelay: delayTime,
                        onUpdate: function(twn:FlxTween){
                            go.x = newx + Math.sin(8*twn.scale+ randomScale)*amp;
                        }
                    });
    
                game.add(part);
                getVar('nyxObjects').push(part);
            }
    
            xgaster = new FlxSprite(-280, -40);
            xgaster.frames = Paths.getSparrowAtlas('xgasterink');
            xgaster.animation.addByPrefix('idle', 'Xgasterink idle dance', 24, true);
            xgaster.animation.play('idle');
            xgaster.antialiasing = ClientPrefs.globalAntialiasing;
            xgaster.alpha = 0.3;
            xgaster.scale.set(0.87,0.87);
            game.addBehindDad(xgaster);
            getVar('nyxObjects').push(xgaster);
            FlxTween.tween(xgaster, {alpha: 0.7, y: xgaster.y+40}, 2, {
                ease: FlxEase.quadInOut,
                type: FlxTween.PINGPONG,
                loopDelay: 0.5
            });
        }

        game.gf.x += 0;
        game.gf.y += 150;
        game.gf.scale.set(0.5, 0.5);
        game.boyfriend.x += 200;
        game.dad.x -= 100;
        if (game.dad.curCharacter == 'ink'){
            game.dad.y = 175;
            game.camFollow.y = game.dad.getMidpoint().y;
        }
    ]]);
end