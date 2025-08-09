import flixel.group.FlxTypedSpriteGroup;
import flixel.addons.display.FlxBackdrop;
import backend.ClientPrefs;

var spinThingysGrp:FlxTypedSpriteGroup<FlxSprite>;
var spinThingys2Grp:FlxTypedSpriteGroup<FlxSprite>;
var cloudsGrp:FlxTypedSpriteGroup<FlxSprite>;
var clouds2Grp:FlxTypedSpriteGroup<FlxSprite>;

var white:FlxBackdrop;
var wheelCircle:FlxSprite;
var light:FlxSprite;
var chair1:FlxSprite;
var chair2:FlxSprite;

var scaleX:Float = 1.5;
var scaleY:Float = 1.5;

var stage1Sprs:Array<FlxSprite> = [];
var stage2Sprs:Array<FlxSprite> = [];
var stage3Sprs:Array<FlxSprite> = [];

function onCreatePost()
{
	white = new FlxBackdrop(Paths.image("stages/mime-and-funk/outside/white"));
	white.updateHitbox();
	insert(game.members.indexOf(game.gfGroup), white);
	//stage1Sprs.push(white); // no need

	outsideStage();
	insideCircusStage();
	backviewStage();
}

var getElapsed:Float = 0;
var whichWaySpin1:Bool = FlxG.random.bool(50);
var whichWaySpin2:Bool = FlxG.random.bool(50);
function onUpdate(elapsed:Float)
{
	getElapsed += elapsed;

	spinThingys2Grp.forEach(function(spr:FlxSprite) // God kill me
	{
		var tta = (getElapsed * 0.2) + (Math.PI * 2 / spinThingys2Grp.members.length) * spr.ID;
		spr.x = (wheelCircle.x + (wheelCircle.width / 2 - spr.width / 2)) + Math.cos(tta) * 565;
		spr.y = (wheelCircle.y + (wheelCircle.height / 2 - spr.width / 2)) + Math.sin(tta) * 540;
		spr.scrollFactor.set(0.6, 0.6); // Psych hscript sucks
	});

	if(wheelCircle != null) wheelCircle.angle += 0.185;

	spinThingysGrp.forEach(function(spr:FlxSprite)
	{
		var angle:Float = (spr.ID * 0.8) + getElapsed;
		spr.x = -125 + Math.cos(angle) * (whichWaySpin1 ? -275 : 275);
		spr.y = 250 + Math.sin(angle) * 15;
	});
}

var mimeGF:FlxSprite;
function outsideStage()
{
	cloudsGrp = new FlxTypedSpriteGroup();
	game.insert(game.members.indexOf(game.gfGroup), cloudsGrp);

	var wind:Bool = FlxG.random.bool(50);
	for(i in 1...6) {
		var cloud:FlxBackdrop = new FlxBackdrop(Paths.image("stages/mime-and-funk/outside/cloud" + i), 0x01, 600);
		cloud.scale.set(0.5, 0.5);
		cloud.updateHitbox();
		cloud.antialiasing = ClientPrefs.data.antialiasing;
		cloudsGrp.add(cloud);

		cloud.x = FlxG.random.float(-800, 1600);
		cloud.y = FlxG.random.float(-100, 900);

		while(cloud.velocity.x == 0) {
			cloud.velocity.x = wind ? FlxG.random.float(0, 25) : FlxG.random.float(-25, 0);
		}
		cloud.scrollFactor.set(0, 0);
		stage1Sprs.push(cloud);
	}

	addFerriswheel();

	var buildings:FlxSprite = new FlxSprite(-400, -450);
	buildings.frames = Paths.getSparrowAtlas('stages/mime-and-funk/outside/buildings');
	buildings.animation.addByPrefix('idle', "buildings", 8, true);
	buildings.animation.play('idle');
	buildings.antialiasing = ClientPrefs.data.antialiasing;
	buildings.scale.set(scaleX, scaleY);
	buildings.updateHitbox();
	buildings.scrollFactor.set(0.7, 0.7);
	insert(game.members.indexOf(game.gfGroup), buildings);
	stage1Sprs.push(buildings);

	var aHUMANHASFALLEN:FlxSprite = new FlxSprite(900, 570);
	aHUMANHASFALLEN.loadGraphic(Paths.image("stages/mime-and-funk/outside/people"));
	aHUMANHASFALLEN.scale.set(scaleX, scaleY);
	aHUMANHASFALLEN.updateHitbox();
	aHUMANHASFALLEN.antialiasing = ClientPrefs.data.antialiasing;
	aHUMANHASFALLEN.scrollFactor.set(0.9, 1);
	insert(game.members.indexOf(game.gfGroup), aHUMANHASFALLEN);
	//aHUMANHASFALLEN.flipX = FlxG.random.bool(50);
	stage1Sprs.push(aHUMANHASFALLEN);
 
	var bg1Ground:FlxSprite = new FlxSprite(-300);
	bg1Ground.loadGraphic(Paths.image("stages/mime-and-funk/outside/ground"));
	bg1Ground.scale.set(scaleX, scaleY);
	bg1Ground.updateHitbox();
	bg1Ground.antialiasing = ClientPrefs.data.antialiasing;
	insert(game.members.indexOf(game.gfGroup), bg1Ground);
	stage1Sprs.push(bg1Ground);

	mimeGF = new FlxSprite(2650, 450);
	mimeGF.frames = Paths.getSparrowAtlas('stages/mime-and-funk/outside/Mimi');
	mimeGF.animation.addByIndices('walkingMIMI', "Mimi", [0,1,2,3,4,5,6,8,9,10,11,12,13,14,15,16,17,18], "", 24, true);
	mimeGF.animation.addByIndices('mybadMIMI', 'Mimi', [
		42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,92,94,95,
		96,97,98,99,100,101,102,103,104,105,106,107,108,
		109,110,111,112,113
	], "", 24, false);
	mimeGF.animation.play('walkingMIMI');
	mimeGF.antialiasing = ClientPrefs.data.antialiasing;
	mimeGF.scale.set(0.5, 0.5);
	mimeGF.updateHitbox();
	mimeGF.scrollFactor.set(1, 1);
	insert(game.members.indexOf(game.gfGroup), mimeGF);
	stage1Sprs.push(mimeGF);
	mimeGF.velocity.set(0, 0);
	
	addCarouselStuff();

	var light:FlxSprite = new FlxSprite(0, 50);
	light.loadGraphic(Paths.image("stages/mime-and-funk/outside/light"));
	light.scale.set(scaleX, scaleY);
	light.updateHitbox();
	light.antialiasing = ClientPrefs.data.antialiasing;
	insert(game.members.indexOf(game.gfGroup), light);
	stage1Sprs.push(light);
}

function insideCircusStage()
{
	var circusBG:FlxSprite = new FlxSprite(-550, -200);
	circusBG.loadGraphic(Paths.image("stages/mime-and-funk/circus/CircusBG"));
	circusBG.scale.set(1.4, 1.4);
	circusBG.updateHitbox();
	circusBG.antialiasing = ClientPrefs.data.antialiasing;
	insert(game.members.indexOf(game.gfGroup), circusBG);
	stage2Sprs.push(circusBG);

	var shadowUnder:FlxSprite = new FlxSprite(50, 1100);
	shadowUnder.loadGraphic(Paths.image("stages/mime-and-funk/circus/CircusShadows"));
	shadowUnder.scale.set(1, 1);
	shadowUnder.updateHitbox();
	shadowUnder.antialiasing = ClientPrefs.data.antialiasing;
	insert(game.members.indexOf(game.gfGroup), shadowUnder);
	stage2Sprs.push(shadowUnder);

	light = new FlxSprite(-260, -250);
	light.loadGraphic(Paths.image("stages/mime-and-funk/circus/CircusLight"));
	light.scale.set(1, 1.2);
	light.updateHitbox();
	light.blend = "add";
	light.alpha = 0.3;
	light.antialiasing = ClientPrefs.data.antialiasing;
	insert(game.members.indexOf(game.boyfriendGroup), light);
	stage2Sprs.push(light);

	var lights:FlxBackdrop = new FlxBackdrop(null, 0x01, 125);
	lights.loadGraphic(Paths.image("stages/mime-and-funk/circus/CircusLights"));
	lights.scale.set(1, 1);
	lights.updateHitbox();
	lights.antialiasing = ClientPrefs.data.antialiasing;
	insert(game.members.indexOf(game.gfGroup), lights);
	lights.x = circusBG.x + ((circusBG.width / 2) - (lights.width / 2));
	lights.y = 50;
	stage2Sprs.push(lights);

	for(stagee in stage2Sprs) {stagee.visible = stagee.active = false;}
}

function backviewStage()
{
	white.alpha = 1;

	var backviewBG:FlxSprite = new FlxSprite(-800, -400);
	backviewBG.loadGraphic(Paths.image("stages/mime-and-funk/backview/bg"));
	backviewBG.scale.set(1.5, 1.5);
	backviewBG.updateHitbox();
	backviewBG.antialiasing = ClientPrefs.data.antialiasing;
	insert(game.members.indexOf(game.gfGroup), backviewBG);
	backviewBG.scrollFactor.set(0.4, 0.4);
	stage3Sprs.push(backviewBG);

	clouds2Grp = new FlxTypedSpriteGroup();
	game.insert(game.members.indexOf(game.gfGroup), clouds2Grp);

	var wind:Bool = FlxG.random.bool(50);
	for(i in 1...6) {
		var cloud:FlxBackdrop = new FlxBackdrop(Paths.image("stages/mime-and-funk/backview/cloud" + i), 0x01, 600);
		cloud.scale.set(0.5, 0.5);
		cloud.updateHitbox();
		cloud.antialiasing = ClientPrefs.data.antialiasing;
		clouds2Grp.add(cloud);

		cloud.x = FlxG.random.float(-800, 1600);
		cloud.y = FlxG.random.float(-300, 700);

		while(cloud.velocity.x == 0) {
			cloud.velocity.x = wind ? FlxG.random.float(0, 25) : FlxG.random.float(-25, 0);
		}
		cloud.scrollFactor.set(0, 0);
		stage3Sprs.push(cloud);
	}

	addCoolLineThingyThatIForgotTheNameOfIt();

	var handrail:FlxSprite = new FlxSprite(-925, -250);
	handrail.loadGraphic(Paths.image("stages/mime-and-funk/backview/handrail"));
	handrail.scale.set(1.85, 1.7);
	handrail.updateHitbox();
	handrail.antialiasing = ClientPrefs.data.antialiasing;
	insert(game.members.indexOf(game.gfGroup), handrail);
	stage3Sprs.push(handrail);
	handrail.y = backviewBG.y + backviewBG.height - handrail.height + 100;

	for(stagee in stage3Sprs) {stagee.visible = stagee.active = false;}
}

function addCoolLineThingyThatIForgotTheNameOfIt()
{
	var line:FlxSprite = new FlxSprite(-850, 0);
	line.loadGraphic(Paths.image("stages/mime-and-funk/backview/line"));
	line.scale.set(1.7, 1.5);
	line.updateHitbox();
	line.antialiasing = ClientPrefs.data.antialiasing;
	insert(game.members.indexOf(game.gfGroup), line);
	line.scrollFactor.set(0.6, 0.6);
	stage3Sprs.push(line);

	chair1 = new FlxSprite();
	chair1.loadGraphic(Paths.image("stages/mime-and-funk/backview/chair1"));
	chair1.scale.set(1.7, 1.5);
	chair1.updateHitbox();
	chair1.antialiasing = ClientPrefs.data.antialiasing;
	insert(game.members.indexOf(game.gfGroup), chair1);
	chair1.scrollFactor.set(0.6, 0.6);
	chair1.x = line.x - chair1.width / 2 + 300;
	chair1.y = line.y + 50;
	stage3Sprs.push(chair1);

	chair2 = new FlxSprite();
	chair2.loadGraphic(Paths.image("stages/mime-and-funk/backview/chair2"));
	chair2.scale.set(1.7, 1.5);
	chair2.updateHitbox();
	chair2.antialiasing = ClientPrefs.data.antialiasing;
	insert(game.members.indexOf(game.gfGroup), chair2);
	chair2.scrollFactor.set(0.6, 0.6);
	chair2.x = line.x - chair2.width / 2;
	chair2.y = line.y;
	stage3Sprs.push(chair2);
}

function addFerriswheel()
{
	spinThingys2Grp = new FlxTypedSpriteGroup();
	game.insert(game.members.indexOf(game.gfGroup), spinThingys2Grp);

	for (i in 0...16)
	{
		var wheelChair:FlxSprite = new FlxSprite();
		wheelChair.loadGraphic(Paths.image("stages/mime-and-funk/outside/wheelChair"));
		wheelChair.scale.set(0.4, 0.4);
		wheelChair.updateHitbox();
		wheelChair.antialiasing = ClientPrefs.data.antialiasing;
		wheelChair.scrollFactor.set(0.6, 0.6);
		wheelChair.alpha = 1;
		wheelChair.visible = true;
		spinThingys2Grp.add(wheelChair);
		wheelChair.ID = i;
		stage1Sprs.push(wheelChair);
	}

	var wheelBody:FlxSprite = new FlxSprite(1500, -200);
	wheelBody.loadGraphic(Paths.image("stages/mime-and-funk/outside/wheelBody"));
	wheelBody.scale.set(scaleX, scaleY);
	wheelBody.updateHitbox();
	wheelBody.antialiasing = ClientPrefs.data.antialiasing;
	wheelBody.scrollFactor.set(0.6, 0.6);
	insert(game.members.indexOf(game.gfGroup), wheelBody);
	stage1Sprs.push(wheelBody);

	wheelCircle = new FlxSprite(1500, -700);
	wheelCircle.loadGraphic(Paths.image("stages/mime-and-funk/outside/wheelSpin"));
	wheelCircle.scale.set(scaleX, scaleY);
	wheelCircle.updateHitbox();
	wheelCircle.antialiasing = ClientPrefs.data.antialiasing;
	wheelCircle.scrollFactor.set(0.6, 0.6);
	insert(game.members.indexOf(game.gfGroup), wheelCircle);
	wheelCircle.x = wheelBody.x + ((wheelBody.width / 2) - (wheelCircle.width / 2));
	stage1Sprs.push(wheelCircle);
}

function addCarouselStuff()
{
	spinThingysGrp = new FlxTypedSpriteGroup();
	game.insert(game.members.indexOf(game.gfGroup), spinThingysGrp);

	for (i in 0...8)
	{
		var spinThingy:FlxSprite = new FlxSprite();
		spinThingy.loadGraphic(Paths.image("stages/mime-and-funk/outside/hsSpin"));
		spinThingy.scale.set(scaleX, scaleY);
		spinThingy.updateHitbox();
		spinThingy.antialiasing = ClientPrefs.data.antialiasing;
		spinThingysGrp.add(spinThingy);
		spinThingy.ID = i;
		stage1Sprs.push(spinThingy);
	}

	var spinBody:FlxSprite = new FlxSprite(-400, 300);
	spinBody.loadGraphic(Paths.image("stages/mime-and-funk/outside/hsBody"));
	spinBody.scale.set(scaleX, scaleY);
	spinBody.updateHitbox();
	spinBody.antialiasing = ClientPrefs.data.antialiasing;
	insert(game.members.indexOf(game.gfGroup), spinBody);
	stage1Sprs.push(spinBody);

	var spinTop:FlxSprite = new FlxSprite(-460, 50);
	spinTop.loadGraphic(Paths.image("stages/mime-and-funk/outside/hsTop"));
	spinTop.scale.set(scaleX, scaleY);
	spinTop.updateHitbox();
	spinTop.antialiasing = ClientPrefs.data.antialiasing;
	insert(game.members.indexOf(game.gfGroup), spinTop);
	stage1Sprs.push(spinTop);
}

function onStepHit()
{
	if(curStep == 1002) {
		// mimeGF.animation.play('walkingMIMI');
		mimeGF.velocity.x = -100;
	}

	if(mimeGF.x <= 1425 && mimeGF.velocity.x != 0) {
		mimeGF.velocity.x = 0;
		mimeGF.animation.play('mybadMIMI');
	}

	if(curStep == 1216) {
		for(stagee in stage1Sprs) {stagee.visible = stagee.active = false; remove(stagee);}
		for(stagee in stage2Sprs) {stagee.visible = stagee.active = true;}
		white.alpha = 0.0001;
		light.alpha = 0.3;
		game.gf.x = 600;
		game.gf.y = 255;
		game.dad.x = 115;
		game.dad.y = 260;
		game.boyfriend.x = 1450;
		game.boyfriend.y = 700;
		game.boyfriend.scrollFactor.set(1.2, 1.2);
		game.boyfriendCameraOffset[0] = -350;
		game.boyfriendCameraOffset[1] = -400;
		game.girlfriendCameraOffset[0] = 140;
		game.girlfriendCameraOffset[1] = 75;
		game.opponentCameraOffset[0] = 125;
		game.opponentCameraOffset[1] = 150;
	}

	if(curStep == 1984) {
		for(stagee in stage1Sprs) {stagee.visible = stagee.active = false; remove(stagee);}
		for(stagee in stage2Sprs) {stagee.visible = stagee.active = false; remove(stagee);}
		for(stagee in stage3Sprs) {stagee.visible = stagee.active = true;}
		game.defaultCamZoom = 0.6;
		game.gf.x = -100;
		game.gf.y = 0;
		game.dad.x = 1500;
		game.dad.y = 0;
		game.boyfriend.x = 325;
		game.boyfriend.y = 480;
		game.boyfriend.scrollFactor.set(1, 1);
		game.boyfriendCameraOffset[0] = 0;
		game.boyfriendCameraOffset[1] = -50;
		game.girlfriendCameraOffset[0] = 300;
		game.girlfriendCameraOffset[1] = -125;
		game.opponentCameraOffset[0] = -250;
		game.opponentCameraOffset[1] = 0;
	
		remove(game.boyfriendGroup);
		insert(game.members.indexOf(game.gfGroup), game.boyfriendGroup);

		

		FlxTween.cancelTweensOf(chair1);
		FlxTween.tween(chair1, {x: 2400, y: 230}, 36);

		FlxTween.cancelTweensOf(chair2);
		FlxTween.tween(chair2, {x: 2400, y: 230}, 40);
	}
}