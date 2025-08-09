var grayBG:FlxSprite;
var clapSpr:FlxSprite;

var clapCamera:FlxCamera = new FlxCamera();

var getCurHUDalpha:Float = 0;

var shouldGoAwayAuto:Bool = true;

function onCreatePost()
{
    clapCamera.bgColor = 0x00000000;
    FlxG.cameras.remove(game.camHUD, false);
    FlxG.cameras.add(clapCamera, false);
    FlxG.cameras.add(game.camHUD, false);

	grayBG = new FlxSprite();
    grayBG.makeGraphic(FlxG.width + 100, FlxG.height + 100, 0xff3e3e3e);
	grayBG.updateHitbox();
    grayBG.alpha = 0.0001;
    grayBG.camera = clapCamera;
	insert(game.members.indexOf(game.noteGroup), grayBG);

	clapSpr = new FlxSprite(-125, 0);
	clapSpr.frames = Paths.getSparrowAtlas('applause');
	clapSpr.animation.addByIndices('clap', 'applause', [2,3,4,5,6,7,8,9,10,11,12,13], "", 24, false);
	//clapSpr.animation.play('clap');
	clapSpr.antialiasing = ClientPrefs.data.antialiasing;
    clapSpr.scale.set(1, 1);
    clapSpr.updateHitbox();
    clapSpr.alpha = 0.0001;
    clapSpr.camera = clapCamera;
    clapSpr.animation.finishCallback = function(name) {
        switch(name)
        {
            case 'clap': 
                if(shouldGoAwayAuto) {
                    grayBG.alpha = 0.0001;
                    clapSpr.alpha = 0.0001;
                    game.camHUD.alpha = getCurHUDalpha;
                    game.uiGroup.alpha = 1;
                }
        }
    };
    insert(game.members.indexOf(game.noteGroup), clapSpr);
}

function onEvent(n, v1, v2)
{
    if (n == 'clap') {
        if(v2 != null && v2 != '' && v2 == 'false') {
            shouldGoAwayAuto = false;
        }
        if(v1 == 'false') {
            grayBG.alpha = 0.0001;
            clapSpr.alpha = 0.0001;
            game.camHUD.alpha = getCurHUDalpha;
            game.uiGroup.alpha = 1;
            game.camOther.flash(0xFFFFFFFF, 1);
        } else {
            getCurHUDalpha = game.camHUD.alpha;
            game.uiGroup.alpha = 0.0001;
            grayBG.alpha = 1;
            clapSpr.alpha = 1;
            if(v1 != null && v1 != '') {
                game.camHUD.alpha = v1;
            } else {
                game.camHUD.alpha = 0.0001;
            }
            clapSpr.animation.play('clap');
        }
    }
}