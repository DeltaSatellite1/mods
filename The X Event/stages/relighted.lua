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
            lg = new FlxSprite(-600, -200).loadGraphic(Paths.image('overwrite/overwrite_light'));
            lg.antialiasing = ClientPrefs.globalAntialiasing;
            lg.scrollFactor.set(0.9, 0.9);
            lg.active = false;
            game.add(lg);
            getVar('nyxObjects').push(lg);
    
            for (i in 0...7){
                sqr = new FlxSprite(-790+400*i, 240 + [300,175,75,0,0,75,175,300][i]).loadGraphic(Paths.image('overwrite/overwrite_square'));
                sqr.antialiasing = ClientPrefs.globalAntialiasing;
                sqr.scrollFactor.set(0.93, 0.93);
                sqr.active = true;
                sqr.frames = Paths.getSparrowAtlas('xeventbg/rpgfire');
                sqr.scale.set(0.6 * [1.2,1.1,1.05,1,1,1.05,1.1,1.2][i], 0.6 * [1.2,1.1,1.05,1,1,1.05,1.1,1.2][i]);
                sqr.animation.addByPrefix('start', 'fire_start', 24, false);
                sqr.animation.addByPrefix('idle', 'fire_iddle', 24, true);
                sqr.animation.play("idle");
                game.addBehindGF(sqr);
                getVar('nyxObjects').push(sqr);
            }
    
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

        game.gf.x += 0;
        game.gf.y += 0;
        game.gf.scale.set(0.4, 0.4);
        game.boyfriend.x += 200;
        game.boyfriend.y += 30;
        game.dad.x -= 150;
        game.dad.y -= 100;
    ]]);
end