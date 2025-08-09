import objects.Character;
import substates.PauseSubState;

var prevDadAnim:String = "";
var curDadAnim:String = "";

var mBonbon:Character;

var singAnimations = ['singLEFT', 'singDOWN', 'singUP', 'singRIGHT'];

function onCreatePost()
{
	gf.visible = false;

	mBonbon = new Character(game.gf.x, game.gf.y, 'bonbon-back-mirror', true);
	mBonbon.alpha = 1;
	mBonbon.flipX = false;
	insert(game.members.indexOf(game.getLuaObject('M')), mBonbon);
}

function onUpdatePost()
{
	/*curDadAnim = game.dad.animation.curAnim.name;
	if(curDadAnim != prevDadAnim) {
		prevDadAnim = curDadAnim;
		mBonbon.playAnim(prevDadAnim, true);
		mBonbon.holdTimer = 0;
	}*/
}

function onBeatHit()
{
	if(curBeat % 2 == 0)
		if(game.dad.animation.curAnim.name == 'idle') {
			mBonbon.playAnim('idle', true);
			mBonbon.holdTimer = 0;
		}
}

function goodNoteHit(note)
{
	if(PauseSubState.charmode == 'bonbon' || note.noteType == 'DAD Sing') {
		mBonbon.playAnim(game.dad.animation.curAnim.name, true);
		mBonbon.holdTimer = 0;
	}
}

function opponentNoteHit(note)
{
	if(PauseSubState.charmode == 'chuchu' || note.noteType == 'DAD Sing') {
		mBonbon.playAnim(game.dad.animation.curAnim.name, true);
		mBonbon.holdTimer = 0;
	}
}

function noteMiss(note)
{
	if(PauseSubState.charmode == 'bonbon' || note.noteType == 'DAD Sing') {
		game.dad.playAnim(singAnimations[note.noteData] + "miss", true);
		mBonbon.playAnim(game.dad.animation.curAnim.name, true);
		game.dad.holdTimer = 0;
		mBonbon.holdTimer = 0;
	}
}