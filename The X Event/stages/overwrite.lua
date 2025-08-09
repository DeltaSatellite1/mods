function onCreatePost()
    luaDebugMode = true;
    addHaxeLibrary('FlxEase', 'flixel.tweens');
    addHaxeLibrary('FlxTween', 'flixel.tweens');
    addHaxeLibrary('FlxMath', 'flixel.math');
    addHaxeLibrary('Math');
    addHaxeLibrary('ClientPrefs');

    runHaxeCode([[
        setVar('bg', FlxSprite);
        setVar('sqr', FlxSprite);
        setVar('lg', FlxSprite);
        setVar('part', FlxSprite);
        setVar('nyxObjects', []);

        bg = new FlxSprite(-600, -200).loadGraphic(Paths.image('overwrite/overwrite_bg'));
        bg.antialiasing = ClientPrefs.globalAntialiasing;
        bg.scrollFactor.set(0.9, 0.9);
        bg.active = false;
        game.addBehindGF(bg);
        getVar('nyxObjects').push(bg);

        if (!ClientPrefs.lowQuality){
            for (i in 0...7){
                sqr = new FlxSprite(-600+400*i, -200).loadGraphic(Paths.image('overwrite/overwrite_square'));
                sqr.antialiasing = ClientPrefs.globalAntialiasing;
                sqr.scrollFactor.set(1.2, 1.2);
                sqr.active = false;
                
                    var go = sqr;
                    var newx = sqr.x+0;
                    var newy = sqr.y+200;
                    var tweenTime = (Math.random()*5+1)/3;
                    var delayTime = Math.random()/2;
                    var newEase = FlxEase.quadInOut;
    
                    FlxTween.tween(go, {y: newy, x: newx}, tweenTime, {
                        ease: newEase,
                        type: FlxTween.PINGPONG,
                        loopDelay: delayTime
                    });
    
                game.addBehindGF(sqr);
                getVar('nyxObjects').push(sqr);
            }
    
            lg = new FlxSprite(-600, -200).loadGraphic(Paths.image('overwrite/overwrite_light'));
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
        }

        game.gf.x += -80;
        game.gf.y -= 80;
        game.gf.scale.set(0.8, 0.8);
        game.boyfriend.x += 200;
        game.dad.x -= 100;
        if (game.dad.curCharacter == 'xchara'){
            game.dad.y = 275;
            game.camFollow.y = game.dad.getMidpoint().y;
        }
    ]]);
end