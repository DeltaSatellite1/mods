

--Script by Super_Hugo on GameBanana https://gamebanana.com/mods/395002
--Enjoy!

--NOTE: This version of the multiplayer script is intended for v0.7+ versions of Psych Engine

---------------------------------------------OPTIONS---------------------------------------------

---------------General Config---------------
playable = false		--disable this is you want to play normal fnf without multiplayer

--these are the P2 keys, change them if you want to use different keybinds
--the keys needs to be in this order: {left, down, up, right}, and have to be inside inverted commas ('' or "")
--example:
--keys = {'D', 'F', 'J', 'K'}

--a list of all keys is found here: https://api.haxeflixel.com/flixel/input/keyboard/FlxKeyList.html
keys = {
	'E',
	'R',
	'U',
	'I'
}

lessMemoryUsage = false		--disables ratings, note splashes and score for less memory usage and less lag drops

strumLock = false		--if enabled all strums/notes will stay visible and at the same position even if there is a modchart

dontHitIgnore = false		--if enabled you won't be able to hit ignore notes but fixes weird input issues (recommended for songs that have 3 strums/characters)



---------------Strum Config---------------
changeScroll = true		--if enabled lets you change the scroll type of each player (might not work with some modcharts)

downScrollP1 = false
downScrollP2 = true

disableMiddleScroll = true		--disables middlescroll if it was enabled (to make it more fair to P2)



---------------Health Config---------------
cannotDieP1 = true
cannotDieP2 = true

--vertical healthbar
enableVerticalHealth = false		--toggles horizontal/vertical healthbar, changeScrolls enables this by default
verticalHealthbarPos = 2		--0 = left, 1 = right, 2 = middle


--drains
doHealthDrainP1 = true		--P1 health drain
doHealthDrainP2 = true		--P2 health drain (disable if song already has opponent health drain)

doMissDrainP1 = true		--if P1 health gets lower when a note is missed
doMissDrainP2 = true		--if P2 health gets lower when a note is missed


--if the character doesn't have miss animations it will do a color change instead (enabled by default)
doMissColor = true

--colors for miss color change in RGB (0 to 1)
missColorR = 0.6
missColorG = 0.1
missColorB = 0.6


--advanced
--limit of the health drains [only if doHealthDrainP1/P2 is enabled]
drainLimitP1 = 1.95		--recommended = 1.9 / 1.95
drainLimitP2 = 0.05		--recommended = 0.1 / 0.05



---------------P2 Rating Config---------------
showCombo = false
showComboNum = true
showRating = true

showMS = false		--shows your note hit timing as in Kade Engine

comboOffset = {-300, -250, -300, -250}		--{ratingX, ratingY, numX, numY}		(the combo sprite uses numX and numY)
scoreTxtOffsetY = 0		--moves the score text for P2 higher/lower for mods that have an overlay/ui stuff (25 for scott the woz mod)



---------------Other Config---------------
doEndScreen = true		--if enabled adds a screen at the end of the song that shows the score for each player
showResultsOnGameOver = true		--if enabled when P1 or P2 dies a screen with the results will show up, else it will be a normal game over

doNoteSplashes = true		--note splashes
doHitsounds = true		--hitsounds for P2 (only if you have hitsounds enabled in your settings)

botPlayKey = 'SIX'		--key to toggle botplay mid-song for P2 (nil or '' for no toggle)
botplayPlayerIndicator = false		--if enabled adds a 'P1' or 'P2' text before the botplay text for each player



---------------Experimental---------------

--(dont use these in songs with mechanics or extra notes or it can break)

mustPressSwap = false		--swaps the notes between P1 and P2 (also changes the characters if differentCharactersMode is disabled)
differentCharactersMode = false		--if true lets you change the P1 and P2 characters (use with strumLock enabled to change the note strum positions)


--change these to the characters you want to play as with differentCharactersMode enabled (boyfriend, dad or gf)
swapCharacterP1 = 'dad'
swapCharacterP2 = 'boyfriend'

--EXAMPLES
--[[

--if you want the P2 to play as boyfriend and P1 to play as opponent do this:

mustPressSwap = true
differentCharactersMode = true

swapCharacterP1 = 'dad'
swapCharacterP2 = 'boyfriend'

--

--and if you want the P1 to play as girlfriend:

mustPressSwap = false
differentCharactersMode = true

swapCharacterP1 = 'girlfriend'
swapCharacterP2 = 'dad'

--]]




------------dont change anything from this point on------------

--score and stuff for player 2
scoreP2 = 0
comboP2 = 0
totalNotesHitP2 = 0
totalPlayedP2 = 0
hitsP2 = 0
songMissesP2 = 0
ratingsP2 = {sicks = 0, goods = 0, bads = 0, shits = 0}
healthP2 = 1

local ratingsData = {}

local ratingPercentP2 = 1
local ratingNameP2 = '?'
local ratingFCP2 = ''

cpuControlled = false

defaultCharacter = 'dad'

if differentCharactersMode then
	defaultCharacter = swapCharacterP2
	
elseif mustPressSwap then
	defaultCharacter = 'boyfriend'
	swapCharacterP1 = 'dad'
end

if lessMemoryUsage then
	showResultsOnGameOver = false
	showCombo = false
	showComboNum = false
	showRating = false
	showMS = false
	doEndScreen = false
	doHitsounds = false
	botplayPlayerIndicator = false
end

if changeScroll then
	enableVerticalHealth = true
end

--other variables
local makeChanges = false
local songSplashSkin = nil
local ratingCount = 0
local gfSinging = false
local gfSingingP1 = false
local hitsP1 = 0
local noteMissesP2 = 0

local endContinue = false
local endScreenType = 0
local continueTxtSine = 0
local botplayTxtSine = 0

local missColor = false

local orMiddleScroll = nil
deadP2 = false

if drainLimitP1 > 2 then drainLimitP1 = 2 end
if drainLimitP1 < 0.1 then drainLimitP1 = 0.1 end
if drainLimitP2 < 0 then drainLimitP2 = 0 end
if drainLimitP2 > 1.9 then drainLimitP2 = 1.9 end

function onCreate()

	if tonumber(_G["playbackRate"]) == nil or not (type(_G["playbackRate"]) == 'number') then
		_G["playbackRate"] = 1
	end

	addHaxeLibrary('FlxMath', 'flixel.math')
	addHaxeLibrary('Math')
	addHaxeLibrary('Std')
	
	addHaxeLibrary('substates.GameOverSubstate')
	
	if playable then
	
		orMiddleScroll = getPropertyFromClass('backend.ClientPrefs', 'data.middleScroll')
		if disableMiddleScroll then
			setPropertyFromClass('backend.ClientPrefs', 'data.middleScroll', false)
		end
		
	end
	
end


function onDestroy()

	if playable then
	
		if not (orMiddleScroll == nil) then
			setPropertyFromClass('backend.ClientPrefs', 'data.middleScroll', orMiddleScroll)
		end
		
	end
	
end

function onCreatePost()

	--set defaults for variables
	setOnLuas("multiScript", playable, true)
	setOnLuas("botplayP2", cpuControlled, true)
	
	setOnLuas("scoreP2", 0, true)
	setOnLuas("missesP2", 0, true)
	setOnLuas("noteMissesP2", 0, true)
	setOnLuas("comboP2", 0, true)
	setOnLuas("hitsP2", 0, true)
	
	setOnLuas("sicksP2", 0, true)
	setOnLuas("goodsP2", 0, true)
	setOnLuas("badsP2", 0, true)
	setOnLuas("shitsP2", 0, true)
	
	setOnLuas("ratingPercentP2", 1, true)
	setOnLuas("ratingNameP2", "?", true)
	setOnLuas("ratingFCP2", "SFC", true)
	
	setOnLuas("deadP2", false, true)
	
	setOnLuas("scrollTypeP1", (changeScroll and tostring(downScrollP1) or tostring(getPropertyFromClass('backend.ClientPrefs', 'data.downScroll'))), true)
	setOnLuas("scrollTypeP2", (changeScroll and tostring(downScrollP2) or tostring(getPropertyFromClass('backend.ClientPrefs', 'data.downScroll'))), true)
	
	setOnLuas("multiSwap", mustPressSwap, true)
	setOnLuas("multiStrumLock", strumLock, true)
	setOnLuas("multiSeparatedHealth", false, true) --disabled for 0.7 versions for now
	setOnLuas("multiNoIgnore", dontHitIgnore, true)

	if playable then

		if not (lessMemoryUsage) then
		
			--make opponent scoreTxt
			makeLuaText('scoreTxtP2', 'Score: 0 | Misses: 0 | Rating: ?', 0, 0, getPropertyFromClass('backend.ClientPrefs', 'data.downScroll') and (650 + scoreTxtOffsetY) or scoreTxtOffsetY)
			addLuaText('scoreTxtP2', true)
			
			setObjectCamera('scoreTxtP2', 'camHUD')
			setProperty('scoreTxtP2.borderSize', 1.25)
			setTextSize('scoreTxtP2', 20)
			setTextAlignment('scoreTxtP2', 'center')
			setProperty('scoreTxtP2.visible', not (getPropertyFromClass('backend.ClientPrefs', 'data.hideHud')))
			screenCenter('scoreTxtP2', 'x')
			
			makeLuaText('botplayTxtP2', 'BOTPLAY', 0, 0, getProperty('healthBar.bg.y') - 55)
			setObjectCamera('botplayTxtP2', 'camHUD')
			setProperty('botplayTxtP2.borderSize', 1.25)
			setTextSize('botplayTxtP2', 32)
			setTextAlignment('botplayTxtP2', 'center')
			updateHitbox('botplayTxtP2')
			addLuaText('botplayTxtP2', true)

		end
		
		if enableVerticalHealth then
		
			if verticalHealthbarPos == 2 then
				setProperty('healthBar.x', (screenWidth / 2) - (getProperty('healthBar.width') / 2)) --middle
			elseif verticalHealthbarPos == 0 then
				setProperty('healthBar.x', -(getProperty('healthBar.width') / 2.4)) --left
			else
				setProperty('healthBar.x', screenWidth - (getProperty('healthBar.width') / 1.7)) --right
			end
			
			setProperty('healthBar.y', screenHeight / 2)
			setProperty('healthBar.angle', 90)
			
		end
		
		if changeScroll then

			for i = 0, getProperty('playerStrums.length')-1 do
			
				if downScrollP1 then
					setPropertyFromGroup('playerStrums', i, 'y', screenHeight - 150)
				else
					setPropertyFromGroup('playerStrums', i, 'y', 50)
				end
				
				setPropertyFromGroup('playerStrums', i, 'downScroll', downScrollP1)
				
				setOnLuas('defaultPlayerStrumY'..i, getPropertyFromGroup('playerStrums', i, 'y'), true)
				
			end
			
			for i = 0, getProperty('opponentStrums.length')-1 do
				
				if downScrollP2 then
					setPropertyFromGroup('opponentStrums', i, 'y', screenHeight - 150)
				else
					setPropertyFromGroup('opponentStrums', i, 'y', 50)
				end
				
				setPropertyFromGroup('opponentStrums', i, 'downScroll', downScrollP2)
				
				setOnLuas('defaultOpponentStrumY'..i, getPropertyFromGroup('opponentStrums', i, 'y'), true)

			end
		
		end
	
	end

end


function onUpdate(elapsed)
	
	if playable then
	
		--debug botplay key
		if not (botPlayKey == nil or botPlayKey == '') then
		
			if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.'..botPlayKey:upper()) then
			
				if playable then
					cpuControlled = not cpuControlled
				end
				
				makeChanges = true
				
			end
		
		end

		--health limits
		if cannotDieP1 and getProperty('health') < 0 then setProperty('health', 0) end
		if cannotDieP2 and healthP2 < 0 then healthP2 = 0 end
		if healthP2 > 2 then healthP2 = 2 end
		
		--gameovers
		if not (cannotDieP2) and not (deadP2) then
		
			if getProperty('health') > 2 then
			
				callOnLuas('onGameOverP2', {}, true, false, {scriptName})
				
				deadP2 = true
			
				if showResultsOnGameOver then
			
					if not (inEndScreen) then
						endScreenType = 1
						startEndScreen()
					end
				
				else

					runHaxeCode([[
						game.boyfriend.stunned = true;
						states.PlayState.deathCounter++;

						game.paused = true;

						game.vocals.stop();
						FlxG.sound.music.stop();

						game.persistentUpdate = false;
						game.persistentDraw = false;
						
						for (tween in game.modchartTweens) {
							tween.active = true;
						}
						for (timer in game.modchartTimers) {
							timer.active = true;
						}
						
						game.openSubState(new substates.GameOverSubstate(game.dad.getScreenPosition().x - game.dad.positionArray[0], game.dad.getScreenPosition().y - game.dad.positionArray[1], game.camGame.scroll.x, game.camGame.scroll.y));
						game.isDead = true;
					]])

				end
				
			end
		
		end

		--lua
		setOnLuas("botplayP2", cpuControlled, true)
		
		setOnLuas("scoreP2", scoreP2, true)
		setOnLuas("missesP2", songMissesP2, true)
		setOnLuas("noteMissesP2", noteMissesP2, true)
		setOnLuas("comboP2", comboP2, true)
		setOnLuas("hitsP2", hitsP2, true)
		
		setOnLuas("sicksP2", ratingsP2.sicks, true)
		setOnLuas("goodsP2", ratingsP2.goods, true)
		setOnLuas("badsP2", ratingsP2.bads, true)
		setOnLuas("shitsP2", ratingsP2.shits, true)
		
		setOnLuas("ratingPercentP2", ratingPercentP2, true)
		setOnLuas("ratingNameP2", ratingNameP2, true)
		setOnLuas("ratingFCP2", ratingFCP2, true)
		
		setOnLuas("deadP2", deadP2, true)
		
	end

end


--normal notes
function keyShit()

	for i, key in ipairs(keys) do
	
		local data = i - 1
	
		if not (i > getProperty('opponentStrums.length')) then
		
			if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.'..key:upper()) then
				strumPlayAnim(data, 'pressed', true, -1)
				onKeyPressP2(data)
				callOnLuas('onKeyPressP2', {data}, false, true, {scriptName})
			end
			
			if getPropertyFromClass('flixel.FlxG', 'keys.justReleased.'..key:upper()) then
				strumPlayAnim(data, 'static', true, 0)
			end
		
		end
		
	end
			
end


function keyHoldShit()

	for i, key in ipairs(keys) do
	
		local data = i - 1
	
		if not (i > getProperty('opponentStrums.length')) then
	
			if getPropertyFromClass('flixel.FlxG', 'keys.pressed.'..key:upper()) then
				
				for ii = 0, getProperty('notes.length')-1 do
			
					--long note key press
					if getPropertyFromGroup('notes', ii, 'isSustainNote') and getPropertyFromGroup('notes', ii, 'mustPress') == false and getPropertyFromGroup('notes', ii, 'canBeHit') 
					and getPropertyFromGroup('notes', ii, 'tooLate') == false and getPropertyFromGroup('notes', ii, 'hitByOpponent') == false and getPropertyFromGroup('notes', ii, 'noteData') == data then
					
						if (dontHitIgnore and not (getPropertyFromGroup('notes', ii, 'rating') == 'ignore')) or not (dontHitIgnore) then
							goodNoteHitP2(ii)
						end
						
					end
				
				end
						
			end
		
		end
			
	end

end


--more set note stuff
function onSpawnNote(id)

	if playable then

		--ignore notes
		if getPropertyFromGroup('notes', id, 'mustPress') == false then
		
			if getPropertyFromGroup('notes', id, 'ignoreNote') or getPropertyFromGroup('notes', id, 'hitCausesMiss') then
				setPropertyFromGroup('notes', id, 'rating', 'ignore')
			end
			
		end

		--set note stuff for mustPressSwap
		if mustPressSwap then
		
			setPropertyFromGroup('notes', id, 'mustPress', not getPropertyFromGroup('notes', id, 'mustPress'))

			setPropertyFromGroup('notes', id, 'hitHealth', -getPropertyFromGroup('notes', id, 'hitHealth'))
			setPropertyFromGroup('notes', id, 'missHealth', -getPropertyFromGroup('notes', id, 'missHealth'))

		end

		--swapped characters
		if differentCharactersMode or mustPressSwap then
			
			if getPropertyFromGroup('notes', id, 'mustPress') then
				setPropertyFromGroup('notes', id, 'inEditor', getPropertyFromGroup('notes', id, 'noAnimation'))
				setPropertyFromGroup('notes', id, 'noAnimation', true)
				setPropertyFromGroup('notes', id, 'noMissAnimation', true)
			end
			
		end
		
		--health
		if getPropertyFromGroup('notes', id, 'mustPress') == false then
		
			--just in case
			if doHealthDrainP2 == false then
				setPropertyFromGroup('notes', id, 'hitHealth', 0)
			end
			
			if not (doMissDrainP2) then
				setPropertyFromGroup('notes', id, 'missHealth', 0)
			end
			
			setPropertyFromGroup('notes', id, 'ignoreNote', true)

		else
		
			if doHealthDrainP1 == false then
				setPropertyFromGroup('notes', id, 'hitHealth', 0)
			end
			
			if not (doMissDrainP1) then
				setPropertyFromGroup('notes', id, 'missHealth', 0)
			end
			
			setPropertyFromGroup('notes', id, 'rating', '')
			
		end
		
		if strumLock then
			--setPropertyFromGroup('notes', id, 'copyX', false)
			setPropertyFromGroup('notes', id, 'copyAlpha', false)
		end
		
		--fixes hold notes on different scrolls
		if getPropertyFromGroup('notes', id, 'isSustainNote') and changeScroll then
		
			if mustPressSwap then
			
				if (getPropertyFromGroup('notes', id, 'mustPress') and downScrollP2) or (not (getPropertyFromGroup('notes', id, 'mustPress')) and downScrollP1) then
					setPropertyFromGroup('notes', id, 'flipY', true)
				else
					setPropertyFromGroup('notes', id, 'flipY', false)
				end
			
			else
		
				if (getPropertyFromGroup('notes', id, 'mustPress') and downScrollP1) or (not (getPropertyFromGroup('notes', id, 'mustPress')) and downScrollP2) then
					setPropertyFromGroup('notes', id, 'flipY', true)
				else
					setPropertyFromGroup('notes', id, 'flipY', false)
				end
			
			end
		
		end
	
	end
	
end


-------------------set stuff for player 2-------------------
function onUpdatePost(elapsed)

	if playable then
	
		if doMissColor and missColor then
	
			if not (string.find(getProperty(defaultCharacter..'.animation.curAnim.name'), 'sing')) or (string.find(getProperty(defaultCharacter..'.animation.curAnim.name'), 'idle') or string.find(getProperty(defaultCharacter..'.animation.curAnim.name'), 'dance')) then
				setProperty(defaultCharacter..'.colorTransform.redMultiplier', 1)
				setProperty(defaultCharacter..'.colorTransform.greenMultiplier', 1)
				setProperty(defaultCharacter..'.colorTransform.blueMultiplier', 1)
				missColor = false
			end
		
		end

		if enableVerticalHealth then
		
			--my attempt at a vertical healthbar
			setProperty('iconP1.flipX', false)
			setProperty('iconP2.flipX', true)
			
			local offset = 26

			if verticalHealthbarPos == 2 then
				setProperty('iconP1.x', (screenWidth / 2) - (getProperty('iconP1.width') / 2))
				setProperty('iconP2.x', (screenWidth / 2) - (getProperty('iconP2.width') / 2)) --middle
			elseif verticalHealthbarPos == 0 then
				setProperty('iconP1.x', -(getProperty('iconP1.width') / 4) + (offset / 2))
				setProperty('iconP2.x', -(getProperty('iconP2.width') / 4) + (offset / 2)) --left
			else
				setProperty('iconP1.x', screenWidth - getProperty('iconP1.width') + offset)
				setProperty('iconP2.x', screenWidth - getProperty('iconP2.width') + offset) --right
			end
			
			setProperty('iconP1.y', (getProperty('healthBar.y') - offset * 2) - (getProperty('healthBar.percent') * 5.95) + (getProperty('iconP1.height') * 1.8) + (150 * getProperty('iconP1.scale.y') - 20) / 2)
			setProperty('iconP2.y', (getProperty('healthBar.y') - offset) - (getProperty('healthBar.percent') * 5.95) + (getProperty('iconP2.height') * 1.8) - (150 * getProperty('iconP2.scale.y') + 20) / 2)

		end
	
		if not (lessMemoryUsage) then
			scoreTxtStuff()
			botplayTextStuff(elapsed)
		end
		
		--animation stuff
		if isCharacter(defaultCharacter) then
			animThingP2(elapsed)
		end
		
		if isCharacter(swapCharacterP1) and (mustPressSwap or differentCharactersMode) then
			animThingP1(elapsed)
		end
	
		--change strum positions with the character
		if strumLock then
		
			for i = 0, 3 do
			
				--much better i guess
				local x1 = _G['defaultPlayerStrumX'..i]
				local x2 = _G['defaultOpponentStrumX'..i]
				local y1 = _G['defaultPlayerStrumY'..i]
				local y2 = _G['defaultOpponentStrumY'..i]

				local scrollP1 = getPropertyFromClass('backend.ClientPrefs', 'data.downScroll')
				local scrollP2 = getPropertyFromClass('backend.ClientPrefs', 'data.downScroll')
				
				if changeScroll then
				
					scrollP1 = downScrollP1
					scrollP2 = downScrollP2
					
					if mustPressSwap then
						scrollP1 = downScrollP2
						scrollP2 = downScrollP1
					end
					
				end

				if mustPressSwap then
				
					if not (swapCharacterP2 == 'dad') or differentCharactersMode == false then
						x2 = _G['defaultPlayerStrumX'..i]
						y2 = _G['defaultPlayerStrumY'..i]
					end
					
					if not (swapCharacterP1 == 'boyfriend') or differentCharactersMode == false then
						x1 = _G['defaultOpponentStrumX'..i]
						y1 = _G['defaultOpponentStrumY'..i]
					end
					
				end

				if differentCharactersMode then
					
					--dad strum position (P1)
					if swapCharacterP1 == 'dad' or (swapCharacterP1 == 'gf' and swapCharacterP2 == 'boyfriend') then
						x1 = _G['defaultOpponentStrumX'..i]
						y1 = _G['defaultOpponentStrumY'..i]
					end

					--boyfriend strum position (P2)
					if swapCharacterP2 == 'boyfriend' or (swapCharacterP2 == 'gf' and not (swapCharacterP1 == 'boyfriend')) then
						x2 = _G['defaultPlayerStrumX'..i]
						y2 = _G['defaultPlayerStrumY'..i]
					end
					
					--middlescroll (only when both characters are gf) (P1 and P2)
					if swapCharacterP1 == 'gf' and swapCharacterP2 == 'gf' then
						x1 = ((screenWidth / 2) - (getPropertyFromClass('Note', 'swagWidth') * 2)) + (i * (getPropertyFromClass('Note', 'swagWidth')))
						x2 = ((screenWidth / 2) - (getPropertyFromClass('Note', 'swagWidth') * 2)) + (i * (getPropertyFromClass('Note', 'swagWidth')))
					end

				end

				setPropertyFromGroup('playerStrums', i, 'x', x1)
				setPropertyFromGroup('playerStrums', i, 'y', y1)
				setPropertyFromGroup('opponentStrums', i, 'x', x2)
				setPropertyFromGroup('opponentStrums', i, 'y', y2)

				setPropertyFromGroup('playerStrums', i, 'alpha', 1)
				setPropertyFromGroup('playerStrums', i, 'visible', true)
				setPropertyFromGroup('playerStrums', i, 'direction', 90)
				setPropertyFromGroup('playerStrums', i, 'downScroll', scrollP1)
				
				setPropertyFromGroup('opponentStrums', i, 'alpha', 1)
				setPropertyFromGroup('opponentStrums', i, 'visible', true)
				setPropertyFromGroup('opponentStrums', i, 'direction', 90)
				setPropertyFromGroup('opponentStrums', i, 'downScroll', scrollP2)
				
			end
		
		end
	
		--note stuff
		for i = 0, getProperty('notes.length')-1 do

			--opponent note stuff
			if getPropertyFromGroup('notes', i, 'mustPress') == false then
			
				--check if the note is too late or it can be hit
				if cpuControlled == false then
				
					if getPropertyFromGroup('notes', i, 'strumTime') > getPropertyFromClass('backend.Conductor', 'songPosition') - (getPropertyFromClass('backend.Conductor', 'safeZoneOffset') * getPropertyFromGroup('notes', i, 'lateHitMult'))
						and getPropertyFromGroup('notes', i, 'strumTime') < getPropertyFromClass('backend.Conductor', 'songPosition') + (getPropertyFromClass('backend.Conductor', 'safeZoneOffset') * getPropertyFromGroup('notes', i, 'earlyHitMult')) then
							setPropertyFromGroup('notes', i, 'canBeHit', true)
					else
						setPropertyFromGroup('notes', i, 'canBeHit', false)
					end
					
					if getPropertyFromGroup('notes', i, 'strumTime') < getPropertyFromClass('backend.Conductor', 'songPosition') - getPropertyFromClass('backend.Conductor', 'safeZoneOffset') and getPropertyFromGroup('notes', i, 'hitByOpponent') == false then
						setPropertyFromGroup('notes', i, 'tooLate', true)
					end

				else
				
					if getPropertyFromGroup('notes', i, 'isSustainNote') then
				
						if getPropertyFromGroup('notes', i, 'strumTime') <= getPropertyFromClass('backend.Conductor', 'songPosition') + (getPropertyFromClass('backend.Conductor', 'safeZoneOffset') * getPropertyFromGroup('notes', i, 'earlyHitMult')) then
							setPropertyFromGroup('notes', i, 'canBeHit', true)
						end
					
					else
					
						if getPropertyFromGroup('notes', i, 'strumTime') <= getPropertyFromClass('backend.Conductor', 'songPosition') then
							setPropertyFromGroup('notes', i, 'canBeHit', true)
						end
					
					end
					
				end
				
				
				--P2 botplay input
				if cpuControlled and not (getProperty('endingSong')) and not (deadP2) then

					if getPropertyFromGroup('notes', i, 'canBeHit') and not (getPropertyFromGroup('notes', i, 'rating') == 'ignore') and getPropertyFromGroup('notes', i, 'hitByOpponent') == false then
			
						if getPropertyFromGroup('notes', i, 'isSustainNote') == false then
							setPropertyFromGroup('notes', i, 'strumTime', getPropertyFromClass('backend.Conductor', 'songPosition')) --make bot hit notes perfectly
						end
						
						--for hitting extra keys that are out of reach
						if getPropertyFromGroup('notes', i, 'noteData') > getProperty('opponentStrums.length') then
							setPropertyFromGroup('notes', i, 'noteData', getPropertyFromGroup('notes', i, 'noteData') % getProperty('opponentStrums.length'))
						end

						goodNoteHitP2(i)
					
					end

				end


				--note missed
				if getPropertyFromClass('backend.Conductor', 'songPosition') > (getProperty('noteKillOffset') - 10) + getPropertyFromGroup('notes', i, 'strumTime') then
				
					setPropertyFromGroup('notes', i, 'strumTime', getPropertyFromClass('backend.Conductor', 'songPosition'))

					if cpuControlled == false and not (getPropertyFromGroup('notes', i, 'rating') == 'ignore') and not (getProperty('endingSong')) and not (deadP2) 
					and (getPropertyFromGroup('notes', i, 'tooLate') or getPropertyFromGroup('notes', i, 'hitByOpponent') == false) then
						--debugPrint('note missed: ', i)
						noteMissP2(i)
					end
					
					setPropertyFromGroup('notes', i, 'active', false)
					setPropertyFromGroup('notes', i, 'visible', false)

					removeFromGroup('notes', i)
					
				end

			end
			
		end
		
		--input
		if cpuControlled == false and getProperty('inCutscene') == false then
			keyShit()
			keyHoldShit()
		end
		
		--end screen stuff
		if inEndScreen then
		
			if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ENTER') then
			
				endContinue = true
				
				if endScreenType == 0 then
					endSong()
				else
					restartSong()
				end
				
			end
			
			if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ESCAPE') and not (endScreenType == 0) then
				exitSong()
			end
			
			continueTxtSine = continueTxtSine + (180 * elapsed)
			setProperty('continueTxt.alpha', 1 - math.sin((math.pi * continueTxtSine) / 180))
			
			setProperty('camZooming', false)
			setProperty('camZoomingMult', 0)
			setProperty('camZoomingDecay', 0)
			
			setPropertyFromClass('backend.Conductor', 'songPosition', 0)
		
		end
		
	end
	
end


-------------------inputs-------------------
function onKeyPressP2(key)

	if getPropertyFromClass('backend.Conductor', 'songPosition') >= -(getProperty('noteKillOffset') - 15) and getProperty('startedCountdown') and not (getProperty('paused')) and key > -1 then

		if getProperty('generatedMusic') and not getProperty('endingSong') then
		
			local lastTime = getPropertyFromClass('backend.Conductor', 'songPosition')
			setPropertyFromClass('backend.Conductor', 'songPosition', getPropertyFromClass('flixel.FlxG', 'sound.music.time'))
			
			local canMiss = not getPropertyFromClass('backend.ClientPrefs', 'data.ghostTapping')
			
			local sortedNotesList = {}

			if getProperty('notes.length') > 0 then

				for i = 0, getProperty('notes.length')-1 do
				
					if getPropertyFromGroup('notes', i, 'mustPress') == false then
					
						local noteFunc = function(pr)
							return getPropertyFromGroup('notes', i, pr)
						end
						
						if noteFunc('canBeHit') and not (noteFunc('hitByOpponent')) and not (noteFunc('isSustainNote')) and not (noteFunc('blockHit')) then
						
							if (dontHitIgnore and not (noteFunc('rating') == 'ignore')) or not dontHitIgnore then
							
								if noteFunc('noteData') == key then
									table.insert(sortedNotesList, i)
								end
								--canMiss = true
								
							end
							
						end
					
					end
					
				end

			end

			if #sortedNotesList > 0 then
			
				for i, note in ipairs(sortedNotesList) do
				
					for j, doubleNote in ipairs(sortedNotesList) do
					
						if not (note == doubleNote) then

							if math.abs(getPropertyFromGroup('notes', doubleNote, 'strumTime') - getPropertyFromGroup('notes', note, 'strumTime')) < 2 then
								removeFromGroup('notes', doubleNote)
								sortedNotesList[j] = nil
							end
							
						end

					end
					
				end

				table.sort(sortedNotesList, function(a, b) return getPropertyFromGroup('notes', a, 'strumTime') - getPropertyFromGroup('notes', b, 'strumTime') end)
				
				local nearestNote = -4
				
				if #sortedNotesList > 1 then
				
					for _, note in ipairs(sortedNotesList) do
					
						if not (note == nil) then
					
							for _, note2 in ipairs(sortedNotesList) do
							
								if not (note == note2) and not (note2 == nil) then
								
									if nearestNote == -4 then
									
										if getPropertyFromGroup('notes', note, 'strumTime') < getPropertyFromGroup('notes', note2, 'strumTime') then
											nearestNote = note
											break
										else
											nearestNote = note2
											break
										end

									end
									
								end

							end

							if not (nearestNote == -4) then
							
								if getPropertyFromGroup('notes', note, 'strumTime') < getPropertyFromGroup('notes', nearestNote, 'strumTime') then
									nearestNote = note
								end

							end
						
						end
						
					end

				else
					nearestNote = sortedNotesList[1]
				end

				if not (nearestNote == -4) then
					goodNoteHitP2(nearestNote)
				end

			else

				if canMiss then
					noteMissPressP2(key)
				else
					callOnLuas('onGhostTapP2', {key}, false, true, {scriptName})
				end
				
			end
			
			setPropertyFromClass('backend.Conductor', 'songPosition', lastTime)
		
		end

	end

end

-------------------when note hit-------------------
function goodNoteHitP2(id)

	local noteData = getPropertyFromGroup('notes', id, 'noteData')
	local noteType = getPropertyFromGroup('notes', id, 'noteType')
	local isSustainNote = getPropertyFromGroup('notes', id, 'isSustainNote')

	if not (getPropertyFromGroup('notes', id, 'hitByOpponent')) then
	
		if cpuControlled and (getPropertyFromGroup('notes', id, 'rating') == 'ignore' or getPropertyFromGroup('notes', id, 'hitCausesMiss')) then return end

		if doMissColor then
		
			if missColor then
				setProperty(defaultCharacter..'.colorTransform.redMultiplier', 1)
				setProperty(defaultCharacter..'.colorTransform.greenMultiplier', 1)
				setProperty(defaultCharacter..'.colorTransform.blueMultiplier', 1)
				missColor = false
			end
		
		end

		--camera zoom thingy
		if not (formatToSongPath(getPropertyFromClass('states.PlayState', 'SONG.song')) == 'tutorial') and mustPressSwap == false then
			setProperty('camZooming', true)
		end

		--notes that makes you miss
		if getPropertyFromGroup('notes', id, 'hitCausesMiss') then

			--make a splash even when not a sick rating
			if not (getPropertyFromGroup('notes', id, 'noteSplashData.disabled') and isSustainNote) and doNoteSplashes then
				spawnNoteSplash(id)
			end

			if getPropertyFromGroup('notes', id, 'noMissAnimation') == false then

				if noteType == 'Hurt Note' then
				
					playAnim(defaultCharacter, 'hurt', true)
					
					if isCharacter(defaultCharacter) then 
						setProperty(defaultCharacter..'.specialAnim', true)
					end
					
				end
				
			end

			setPropertyFromGroup('notes', id, 'hitByOpponent', true)
			
			noteMissP2(id)
			
			if isSustainNote == false then
				removeFromGroup('notes', id)
			else
				setPropertyFromGroup('notes', id, 'ignoreNote', false)
			end
				
			return
			
		end

		--score
		if isSustainNote == false then
		
			--hitsounds
			if cpuControlled == false then

				if getPropertyFromClass('backend.ClientPrefs', 'data.hitsoundVolume') > 0 and not (getPropertyFromGroup('notes', id, 'hitsoundDisabled')) and doHitsounds then
					playSound('hitsound', getPropertyFromClass('backend.ClientPrefs', 'data.hitsoundVolume'))
				end

			end
		
			comboP2 = comboP2 + 1
			if comboP2 > 9999 then combo = 9999 end

			if lessMemoryUsage == false then
				popUpScore(id)
			else
				scoreP2 = scoreP2 + 350
				hitsP2 = hitsP2 + 1
			end
			
		end
		
		--health drain
		if doHealthDrainP2 then

			if mustPressSwap then

				if getProperty('health') < drainLimitP1 then
					setProperty('health', getProperty('health') - getPropertyFromGroup('notes', id, 'hitHealth') * getProperty('healthGain'))
				end
			
			else
		
				if getProperty('health') > drainLimitP2 then
					setProperty('health', getProperty('health') - getPropertyFromGroup('notes', id, 'hitHealth') * getProperty('healthGain'))
				end
			
			end

		end

		--animations
		if getPropertyFromGroup('notes', id, 'noAnimation') == false then

			local animToPlay = getProperty('singAnimations')[noteData + 1]
			local animSuffix = getPropertyFromGroup('notes', id, 'animSuffix')
			if noteType == 'Alt Animation' or altAnim then animSuffix = '-alt' end
			
			if getPropertyFromGroup('notes', id, 'gfNote') then
			
				if not (getProperty('gf') == nil) then
				
					playAnim('gf', animToPlay..animSuffix, true)
					
					--if no animation with alt anims, play normal animation
					if not (animSuffix == '') and not (getProperty('gf.animation.curAnim.name') == animToPlay..animSuffix) then
						playAnim('gf', animToPlay, true)
					end
				
					setProperty('gf.holdTimer', 0)
					
					gfSinging = true
					
				end
				
			else
			
				playAnim(defaultCharacter, animToPlay..animSuffix, true)
				
				--if no animation with alt anims, play normal animation
				if not (animSuffix == '') and not (getProperty(defaultCharacter..'.animation.curAnim.name') == animToPlay..animSuffix) then
					playAnim(defaultCharacter, animToPlay, true)
				end
				
				if isCharacter(defaultCharacter) then 
					setProperty(defaultCharacter..'.holdTimer', 0)
				end

				gfSinging = false
				
			end
			
			if noteType == 'Hey!' then
			
				playAnim(defaultCharacter, 'hey', true)
				
				if isCharacter(defaultCharacter) then
					setProperty(defaultCharacter..'.specialAnim', true)
					setProperty(defaultCharacter..'.heyTimer', 0.6)
				end
				
				if not (getProperty('gf') == nil) then
					playAnim('gf', 'cheer', true)
					setProperty('gf.specialAnim', true)
					setProperty('gf.heyTimer', 0.6)
				end
				
			end
		
		end
		
		--strum animations
		local time = 0

		if isSustainNote then
		
			if cpuControlled then
				time = time + 0.15
			end
		
			--if not (string.find(getPropertyFromGroup('notes', id, 'animation.curAnim.name'), 'end')) then
				strumPlayAnim(noteData % getProperty('opponentStrums.length'), 'confirm', true, time)
			--end
			
		else
		
			if cpuControlled then
				time = 0.15
			end
			
			strumPlayAnim(noteData % getProperty('opponentStrums.length'), 'confirm', true, time)
			
		end
		

		setPropertyFromGroup('notes', id, 'hitByOpponent', true)
		setProperty('vocals.volume', 1)
		
		--debugPrint('note hit: ', id)

		--for other lua scripts
		if mustPressSwap then
			callOnLuas('goodNoteHit', {id, noteData, noteType, isSustainNote}, false, true, {scriptName})
		else
			callOnLuas('opponentNoteHit', {id, noteData, noteType, isSustainNote}, false, true, {scriptName})
		end
		
		callOnLuas('goodNoteHitP2', {id, noteData, noteType, isSustainNote}, false, true, {scriptName}) --for sustain notes

		--remove note
		if isSustainNote == false then
			removeFromGroup('notes', id)
		else
			setPropertyFromGroup('notes', id, 'ignoreNote', false)
		end
		
	end
	
end


-------------------when note missed-------------------
function noteMissP2(id)

	--if (getPropertyFromGroup('notes', id, 'isSustainNote') and string.find(getPropertyFromGroup('notes', id, 'animation.curAnim.name'), 'end')) then return end

	--remove dupe notes
	runHaxeCode([[
		var daNote = game.notes.members[]]..id..[[];
	
		game.notes.forEachAlive(function(note) {
			if (daNote != note && !daNote.mustPress && daNote.noteData == note.noteData && daNote.isSustainNote == note.isSustainNote && Math.abs(daNote.strumTime - note.strumTime) < 1) {
				note.kill();
				game.notes.remove(note, true);
				note.destroy();
			}
		});
	]])

	--set some stuff
	comboP2 = 0
	
	--health
	if doMissDrainP2 then
		setProperty('health', getProperty('health') + (getPropertyFromGroup('notes', id, 'missHealth') * getProperty('healthLoss')))
	end
	
	if getProperty('instakillOnMiss') then
		setProperty('health', 2)
	end
	
	songMissesP2 = songMissesP2 + 1
	noteMissesP2 = noteMissesP2 + 1
	
	setProperty('vocals.volume', 0)
	
	if getProperty('practiceMode') == false then scoreP2 = scoreP2 - 10 end
	totalPlayedP2 = totalPlayedP2 + 1
	if lessMemoryUsage == false then RecalculateRating(true) end
	
	--anims
	local char = defaultCharacter
	if getPropertyFromGroup('notes', id, 'gfNote') then
		char = 'gf'
	end
	
	local animSuffix = getPropertyFromGroup('notes', id, 'animSuffix')
	
	if getPropertyFromGroup('notes', id, 'noteType') == 'Alt Animation' or altAnim then 
		animSuffix = '-alt' 
	end

	if getPropertyFromGroup('notes', id, 'noMissAnimation') == false then
	
		if isCharacter(char) then
		
			if getProperty(char..'.hasMissAnimations') then
		
				local animToPlay = getProperty('singAnimations')[getPropertyFromGroup('notes', id, 'noteData') + 1]..'miss'

				playAnim(char, animToPlay..animSuffix, true)
				
				--if no animation with alt anims, play normal animation
				if not (animSuffix == '') and not (getProperty(char..'.animation.curAnim.name') == animToPlay..animSuffix) then
					playAnim(char, animToPlay, true)
				end
				
				setProperty(char..'.specialAnim', true)
				
			else
				
				if doMissColor then
			
					local animToPlay = getProperty('singAnimations')[getPropertyFromGroup('notes', id, 'noteData') + 1]

					playAnim(char, animToPlay..animSuffix, true)
					setProperty(char..'.holdTimer', 0)

					setProperty(char..'.colorTransform.redMultiplier', missColorR)
					setProperty(char..'.colorTransform.greenMultiplier', missColorG)
					setProperty(char..'.colorTransform.blueMultiplier', missColorB)	
					
					missColor = true
				
				end

			end
			
		end
		
	end
	
	if mustPressSwap then
		callOnLuas('noteMiss', {id, getPropertyFromGroup('notes', id, 'noteData'), getPropertyFromGroup('notes', id, 'noteType'), getPropertyFromGroup('notes', id, 'isSustainNote')}, true, true, {scriptName})
	end
	
	callOnLuas('noteMissP2', {id, getPropertyFromGroup('notes', id, 'noteData'), getPropertyFromGroup('notes', id, 'noteType'), getPropertyFromGroup('notes', id, 'isSustainNote')}, false, true, {scriptName})
	
end


-------------------when no ghost tapping-------------------
function noteMissPressP2(direction)

	--health
	if doMissDrainP2 then
		setProperty('health', getProperty('health') + (0.05 * getProperty('healthLoss')))
	end
	
	setProperty('vocals.volume', 0)
	
	if getProperty('instakillOnMiss') then
		setProperty('health', 2)
	end
	
	comboP2 = 0
	
	if getProperty('practiceMode') == false then scoreP2 = scoreP2 - 10 end
	if getProperty('endingSong') == false then songMissesP2 = songMissesP2 + 1 end
	totalPlayedP2 = totalPlayedP2 + 1
	if lessMemoryUsage == false then RecalculateRating(true) end
	
	playSound('missnote'..getRandomInt(1, 3), getRandomFloat(0.1, 0.2))
	
	if isCharacter(defaultCharacter) then
	
		if getProperty(defaultCharacter..'.hasMissAnimations') then
	
			local animToPlay = getProperty('singAnimations')[direction + 1]..'miss'
			
			playAnim(defaultCharacter, animToPlay, true)
			setProperty(defaultCharacter..'.specialAnim', true)
			
		else
				
			if doMissColor then
		
				local animToPlay = getProperty('singAnimations')[direction + 1]
		
				playAnim(char, animToPlay..animSuffix, true)
				setProperty(char..'.holdTimer', 0)

				setProperty(char..'.colorTransform.redMultiplier', missColorR)
				setProperty(char..'.colorTransform.greenMultiplier', missColorG)
				setProperty(char..'.colorTransform.blueMultiplier', missColorB)	
				
				missColor = true
			
			end
			
		end
			
	end

	if mustPressSwap then
		callOnLuas('noteMissPress', {direction}, false, false)
	end

end


--note splashes
function spawnNoteSplash(id)

	local noteData = getPropertyFromGroup('notes', id, 'noteData')
	local x = getPropertyFromGroup('opponentStrums', noteData, 'x')
	local y = getPropertyFromGroup('opponentStrums', noteData, 'y')
	
	--fix for runHaxeCode not working as it should in v0.7+
	runHaxeCode([[
		function shit(x, y, data, id) 
		{
			var note = game.notes.members[id];
			game.spawnNoteSplash(x, y, data, note);
		}
	]])
	
	runHaxeFunction('shit', {x, y, noteData, id})

end


-------------------ratings and combo-------------------
function popUpScore(id)
	
	local noteDiff = math.abs(getPropertyFromGroup('notes', id, 'strumTime') - getPropertyFromClass('backend.Conductor', 'songPosition') + getPropertyFromClass('backend.ClientPrefs', 'data.ratingOffset'))

	ratingsData = {}
	
	--add the original rating data stuff to the variable in this file (it doesn't let me do ratingsData = getProperty('ratingsData') so I need to use this instead)
	for i = 1, getProperty('ratingsData.length') do
	
		ratingsData[i] = {}
		
		ratingsData[i].name = getProperty('ratingsData['..(i - 1)..'].name')
		
		if not (getProperty('ratingsData['..(i - 1)..'].image') == nil) then
			ratingsData[i].image = getProperty('ratingsData['..(i - 1)..'].image')
		else
			ratingsData[i].image = getProperty('ratingsData['..(i - 1)..'].name')
		end
		
		if not (getProperty('ratingsData['..(i - 1)..'].counter') == nil) then
			ratingsData[i].counter = getProperty('ratingsData['..(i - 1)..'].counter')
		else
			ratingsData[i].counter = getProperty('ratingsData['..(i - 1)..'].name')..'s'
		end

		ratingsData[i].ratingMod = getProperty('ratingsData['..(i - 1)..'].ratingMod')
		ratingsData[i].score = getProperty('ratingsData['..(i - 1)..'].score')
		ratingsData[i].noteSplash = getProperty('ratingsData['..(i - 1)..'].noteSplash')
		ratingsData[i].hitWindow = getProperty('ratingsData['..(i - 1)..'].hitWindow')
		
	end

	if tonumber(playbackRate) == nil or not (type(playbackRate) == 'number') then playbackRate = 1 end
	local daRating = judgeNote(noteDiff / playbackRate)

	--add rating and stuff
	for i = 1, #ratingsData do
	
		if daRating == ratingsData[i].name then
		
			if not (getPropertyFromGroup('notes', id, 'ratingDisabled')) then
			
				if ratingsP2[ratingsData[i].counter] == nil then
					ratingsP2[ratingsData[i].counter] = 0
				end
				
				ratingsP2[ratingsData[i].counter] = ratingsP2[ratingsData[i].counter] + 1 --add 1 to rating variable (for example sicks = sicks + 1)
				
			end
			
			totalNotesHitP2 = totalNotesHitP2 + ratingsData[i].ratingMod

			--note rating
			setPropertyFromGroup('notes', id, 'rating', ratingsData[i].name)
			setPropertyFromGroup('notes', id, 'ratingMod', ratingsData[i].ratingMod)

			if getProperty('practiceMode') == false then
				scoreP2 = scoreP2 + ratingsData[i].score
			end

			--splash
			if ratingsData[i].noteSplash and not (getPropertyFromGroup('notes', id, 'noteSplashData.disabled')) and doNoteSplashes then
				spawnNoteSplash(id)
			end
				
			ratingComboStuff(ratingsData[i].name, noteDiff, ratingsData[i].image)
			
		end
	
	end
	
	if getProperty('practiceMode') == false and getPropertyFromGroup('notes', id, 'ratingDisabled') == false then
		hitsP2 = hitsP2 + 1
		totalPlayedP2 = totalPlayedP2 + 1
		RecalculateRating(false)
	end

end


--combo and rating sprites
function ratingComboStuff(rating, diff, ratingImg)

	if not (showCombo) and not (showComboNum) and not (showRating) then return end
	if ratingImg == nil then ratingImg = rating end
	
	makeLuaText('coolText', comboP2, 0, 0, 0)
	setTextSize('coolText', 32)
	screenCenter('coolText')
	setProperty('coolText.x', screenWidth * 0.35)

	local pixelShitPart1 = ""
	local pixelShitPart2 = ''
	local antialias = getPropertyFromClass('backend.ClientPrefs', 'data.antialiasing')

	if getPropertyFromClass('states.PlayState', 'isPixelStage') then
		pixelShitPart1 = 'pixelUI/'
		pixelShitPart2 = '-pixel'
		antialias = not getPropertyFromClass('states.PlayState', 'isPixelStage')
	end

	local sprName = 'rating'..ratingCount
	local comboName = 'combo'..ratingCount
	

	--rating
	makeLuaSprite(sprName, pixelShitPart1..ratingImg..pixelShitPart2)
	setObjectCamera(sprName, 'camHUD')
	screenCenter(sprName)
	setProperty(sprName..'.x', getProperty('coolText.x') - 40)
	setProperty(sprName..'.y', getProperty(sprName..'.y') - 60)
	setProperty(sprName..'.acceleration.y', 550 * playbackRate * playbackRate)
	setProperty(sprName..'.velocity.y', getProperty(sprName..'.velocity.y') - getRandomInt(140, 175) * playbackRate)
	setProperty(sprName..'.velocity.x', getProperty(sprName..'.velocity.x') - getRandomInt(0, 10) * playbackRate)
	setProperty(sprName..'.visible', not getPropertyFromClass('backend.ClientPrefs', 'data.hideHud') and showRating)
	setProperty(sprName..'.x', getProperty(sprName..'.x') + comboOffset[1])
	setProperty(sprName..'.y', getProperty(sprName..'.y') - comboOffset[2])
	setProperty(sprName..'.antialiasing', antialias)
	setObjectOrder(sprName, getObjectOrder('strumLineNotes'))
		
	if showRating then
		addLuaSprite(sprName, false)
	else
		setProperty(sprName..'.alpha', 0)
	end
	
	
	--combo
	makeLuaSprite(comboName, pixelShitPart1..'combo'..pixelShitPart2)
	setObjectCamera(comboName, 'camHUD')
	screenCenter(comboName)
	setProperty(comboName..'.x', getProperty('coolText.x'))
	setProperty(comboName..'.acceleration.y', getRandomInt(200, 300) * playbackRate * playbackRate)
	setProperty(comboName..'.velocity.y', getProperty(comboName..'.velocity.y') - getRandomInt(140, 160) * playbackRate)
	setProperty(comboName..'.visible', not getPropertyFromClass('backend.ClientPrefs', 'data.hideHud') and showCombo)
	setProperty(comboName..'.x', getProperty(comboName..'.x') + comboOffset[1])
	setProperty(comboName..'.y', getProperty(comboName..'.y') - comboOffset[2])
	setProperty(comboName..'.y', getProperty(comboName..'.y') + 60)
	setProperty(comboName..'.velocity.x', getProperty(comboName..'.velocity.x') + getRandomInt(1, 10) * playbackRate)
	setProperty(comboName..'.antialiasing', antialias)
	setObjectOrder(comboName, getObjectOrder('strumLineNotes'))
	
	if showCombo then
		
		if comboP2 >= 10 then
			addLuaSprite(comboName, false)
		else
			setProperty(comboName..'.alpha', 0)
		end
		
	else
		setProperty(comboName..'.alpha', 0)
	end


	if not getPropertyFromClass('states.PlayState', 'isPixelStage') then
		scaleObject(sprName, 0.7, 0.7)
		setProperty(sprName..'.antialiasing', getPropertyFromClass('backend.ClientPrefs', 'data.globalAntialiasing'))
		scaleObject(comboName, 0.7, 0.7)
		setProperty(comboName..'.antialiasing', getPropertyFromClass('backend.ClientPrefs', 'data.globalAntialiasing'))
	else
		scaleObject(sprName, 6 * 0.85, 6 * 0.85)
		setProperty(sprName..'.antialiasing', false)
		scaleObject(comboName, 6 * 0.85, 6 * 0.85)
		setProperty(comboName..'.antialiasing', false)
	end

	updateHitbox(comboName)
	updateHitbox(sprName)
	
	
	--ms timing from kade engine
	if showMS then
	
		local msTiming = math.floor(diff)
	
		makeLuaText('currentTimingShown', '0ms', 0, 0, 0)
		setObjectCamera('currentTimingShown', 'camHUD')
		setProperty('currentTimingShown.borderSize', 1)
		setTextSize('currentTimingShown', 20)
		setTextString('currentTimingShown', msTiming..'ms')
		setProperty('currentTimingShown.visible', not getPropertyFromClass('backend.ClientPrefs', 'data.hideHud') and showMS)
		addLuaText('currentTimingShown', true)

		
		local color = 'FFFFFF'

		--ms text colors (if you have a different rating add a color here)
		if rating == 'marv' then
			color = 'FFFF00'
		end
		
		if rating == 'sick' then
			color = '00FFFF'
		end
		
		if rating == 'good' then
			color = '00FF00'
		end
		
		if rating == 'bad' or rating == 'shit' then
			color = 'FF0000'
		end
		
		setProperty('currentTimingShown.color', getColorFromHex(color))
		

		screenCenter('currentTimingShown')
		setProperty('currentTimingShown.x', getProperty(comboName..'.x') + 100)
		setProperty('currentTimingShown.y', getProperty(sprName..'.y') + 100)
		
		--these don't even work with texts but anyway
		setProperty('currentTimingShown.acceleration.y', 600 * playbackRate * playbackRate)
		setProperty('currentTimingShown.velocity.y', getProperty('currentTimingShown.velocity.y') - 150 * playbackRate)
		setProperty('currentTimingShown.velocity.x', getProperty('currentTimingShown.velocity.x') + getProperty(comboName..'.velocity.x'))
		
		updateHitbox('currentTimingShown')
	
	end
	
	
	--combo numbers
	local separatedScore = {}
	
	if comboP2 >= 1000 then
		separatedScore[#separatedScore + 1] = math.floor(comboP2 / 1000) % 10
	end
	separatedScore[#separatedScore + 1] = math.floor(comboP2 / 100) % 10
	separatedScore[#separatedScore + 1] = math.floor(comboP2 / 10) % 10
	separatedScore[#separatedScore + 1] = comboP2 % 10


	local daLoop = 0
	local xThing = 0
	for i = 1, #separatedScore do
	
		local comboNumName = i..'num'..ratingCount
		
		makeLuaSprite(comboNumName, pixelShitPart1..'num'..separatedScore[i]..pixelShitPart2)
		setObjectCamera(comboNumName, 'camHUD')
		screenCenter(comboNumName)
		setProperty(comboNumName..'.x', getProperty('coolText.x') + (43 * daLoop) - 90)
		setProperty(comboNumName..'.y', getProperty(comboNumName..'.y') + 80)
		
		setProperty(comboNumName..'.x', getProperty(comboNumName..'.x') + comboOffset[3])
		setProperty(comboNumName..'.y', getProperty(comboNumName..'.y') - comboOffset[4])

		if not getPropertyFromClass('states.PlayState', 'isPixelStage') then
			setProperty(comboNumName..'.antialiasing', getPropertyFromClass('backend.ClientPrefs', 'data.globalAntialiasing'))
			scaleObject(comboNumName, 0.5, 0.5)
		else
			setProperty(comboNumName..'.antialiasing', false)
			scaleObject(comboNumName, 6, 6)
		end
		updateHitbox(comboNumName)

		setProperty(comboNumName..'.acceleration.y', getRandomInt(200, 300) * playbackRate * playbackRate)
		setProperty(comboNumName..'.velocity.y', getProperty(comboNumName..'.velocity.y') - getRandomInt(140, 160) * playbackRate)
		setProperty(comboNumName..'.velocity.x', getRandomInt(-5, 5) * playbackRate)
		setProperty(comboNumName..'.visible', not getPropertyFromClass('backend.ClientPrefs', 'data.hideHud'))
		setProperty(comboNumName..'.antialiasing', antialias)
		setObjectOrder(comboNumName, getObjectOrder('strumLineNotes'))

		--if comboP2 >= 10 or comboP2 == 0 then
		if showComboNum then
			addLuaSprite(comboNumName, false)
		else
			setProperty(comboNumName..'.alpha', 0)
		end
		
		daLoop = daLoop + 1
		if getProperty(comboNumName..'.x') > xThing then xThing = getProperty(comboNumName..'.x') end
		
	end
	setProperty(comboName..'.x', xThing + 50)

	runTimer(sprName, crochet * 0.001 / playbackRate, 1)
	runTimer(comboName, crochet * 0.001 / playbackRate, 1)
	runTimer('num'..ratingCount, crochet * 0.002 / playbackRate, 1)
	if showMS then runTimer('currentTimingShown', crochet * 0.001 / playbackRate, 1) end
	
	ratingCount = ratingCount + 1
	
	if ratingCount > 100 then
		ratingCount = 0
	end

end


-------------------timers and tweens-------------------
function onTimerCompleted(tag)

	if string.find(tag, 'rating') or string.find(tag, 'combo') or tag == 'currentTimingShown' then
		doTweenAlpha(tag, tag, 0, 0.2 / playbackRate)
	end
	
	if string.find(tag, 'num') then
		doTweenAlpha('1'..tag, '1'..tag, 0, 0.2 / playbackRate)
		doTweenAlpha('2'..tag, '2'..tag, 0, 0.2 / playbackRate)
		doTweenAlpha('3'..tag, '3'..tag, 0, 0.2 / playbackRate)
		doTweenAlpha('4'..tag, '4'..tag, 0, 0.2 / playbackRate)
	end
	
end


function onTweenCompleted(tag)

	if string.find(tag, 'rating') or string.find(tag, 'combo') or tag == 'currentTimingShown' then
		removeLuaSprite(tag, true)
	end
	
	if string.find(tag, 'num') then
		removeLuaSprite('1'..tag, true)
		removeLuaSprite('2'..tag, true)
		removeLuaSprite('3'..tag, true)
		removeLuaSprite('4'..tag, true)
	end
	
end


--note judgement
function judgeNote(diff)

	for i = 1, #ratingsData-1 do

		if diff <= ratingsData[i].hitWindow then
			return ratingsData[i].name
		end
	
	end
	
	return ratingsData[#ratingsData].name
	
end


--change scoreTxt stuff
function RecalculateRating(badHit)

	local ratingStuff = getPropertyFromClass('states.PlayState', 'ratingStuff') --for same ratings as player 1

	if totalPlayedP2 < 1 then
		ratingNameP2 = '?'
	else

		--Rating Percent
		ratingPercentP2 = math.min(1, math.max(0, totalNotesHitP2 / totalPlayedP2))
		
		--Rating Name
		if ratingPercentP2 >= 1 then
			ratingNameP2 = ratingStuff[#ratingStuff][1] --last string
		else
		
			for i = 1, #ratingStuff do
			
				if ratingPercentP2 < ratingStuff[i][2] then
					ratingNameP2 = ratingStuff[i][1]
					break
				end
				
			end
			
		end
		
		ratingFCP2 = ''
		if ratingsP2.sicks > 0 then ratingFCP2 = 'SFC' end
		if ratingsP2.goods > 0 then ratingFCP2 = 'GFC' end
		if ratingsP2.bads > 0 or ratingsP2.shits > 0 then ratingFCP2 = 'FC' end
		if songMissesP2 > 0 and songMissesP2 < 10 then ratingFCP2 = 'SDCB'
		elseif songMissesP2 >= 10 then ratingFCP2 = 'Clear' end
		
	end

	updateScore(badHit)
	
end


--update scoreTxt stuff (this makes memory go higher for some reason)
function updateScore(miss)

	if ratingNameP2 == '?' then
		setProperty('scoreTxtP2.text', 'Score: '..scoreP2..' | Misses: '..songMissesP2..' | Rating: '..ratingNameP2)
	else
		setProperty('scoreTxtP2.text', 'Score: '..scoreP2..' | Misses: '..songMissesP2..' | Rating: '..ratingNameP2..' ('..floorDecimal(ratingPercentP2 * 100, 2)..'%) - '..ratingFCP2)
	end

	if getPropertyFromClass('backend.ClientPrefs', 'data.scoreZoom') and miss == false and cpuControlled == false then

		setProperty('scoreTxtP2.scale.x', 1.075)
		setProperty('scoreTxtP2.scale.y', 1.075)
		
		doTweenX('scoreTxtP2scaleX', 'scoreTxtP2.scale', 1, 0.2)
		doTweenY('scoreTxtP2scaleY', 'scoreTxtP2.scale', 1, 0.2)
		
	end

end


-------------------end screen-------------------
if playable then

	function onEndSong()
	
		if doEndScreen then

			if endContinue == false and getPropertyFromClass('states.PlayState', 'isStoryMode') == false then
				endScreenType = 0
				startEndScreen()
				return Function_Stop
			end
			
		end
	
		return Function_Continue
		
	end

	function startEndScreen()

		inEndScreen = true
		setProperty('inCutscene', true)
		setProperty('canPause', false)
		setProperty('canReset', false)
		
		setProperty('camHUD.visible', false)
		
		setProperty('vocals.volume', 0)
		playMusic(formatToSongPath(getPropertyFromClass('backend.ClientPrefs', 'data.pauseMusic')), 1, true)
		
		
		--make sprites
		makeLuaSprite('endBG', '', 0, 0)
		makeGraphic('endBG', screenWidth, screenHeight, '000000')
		setProperty('endBG.alpha', 0.6)
		setObjectCamera('endBG', 'camOther')
		addLuaSprite('endBG', true)

		makeLuaText('endTxt', '', 0, 0, 150)
		setObjectCamera('endTxt', 'camOther')
		setTextSize('endTxt', 25)
		addLuaText('endTxt', true)
		
		if endScreenType == 0 then
			makeLuaText('continueTxt', 'PRESS ENTER TO CONTINUE', 0, 0, screenHeight - 100)
			
		else
			local txt = [[
			PRESS ENTER TO RESTART
			
			PRESS ESCAPE TO EXIT
			]]
			makeLuaText('continueTxt', txt, 0, 0, screenHeight - 150)
		end
		
		setObjectCamera('continueTxt', 'camOther')
		setTextSize('continueTxt', 40)
		addLuaText('continueTxt', true)
		
		if endScreenType == 1 then
			makeLuaText('songNameTxt', 'PLAYER 2 GAMEOVER!', 0, 0, 60)
		elseif endScreenType == 2 then
			makeLuaText('songNameTxt', 'PLAYER 1 GAMEOVER!', 0, 0, 60)
		else
			makeLuaText('songNameTxt', (songName..' - '..difficultyName):upper(), 0, 0, 60)
		end
		
		setObjectCamera('songNameTxt', 'camOther')
		setTextSize('songNameTxt', 35)
		addLuaText('songNameTxt', true)
		

		--texts
		local scoreTxtP2 = 'Score: '..scoreP2..' | Misses: '..songMissesP2..' | Rating: '..ratingNameP2
		
		if not (ratingNameP2 == '?') then
			scoreTxtP2 = 'Score: '..scoreP2..' | Misses: '..songMissesP2..' | Rating: '..ratingNameP2..' ('..floorDecimal(ratingPercentP2 * 100, 2)..'%) - '..ratingFCP2
		end
		
		setTextString('endTxt', [[
		
		PLAYER 1:
		
		]]..getProperty('scoreTxt.text')..' | Notes hit: '..hitsP1..[[
		
		
		
		
		PLAYER 2:
		
		]]..scoreTxtP2..' | Notes hit: '..hitsP2..[[
		
		
		
		
		
		]])
		
		if endScreenType == 0 then
		setTextString('endTxt', getTextString('endTxt')..[[
		TOTAL NOTES P1: ]]..(hitsP1 + getProperty('songMisses'))..[[
		
		
		
		TOTAL NOTES P2: ]]..(hitsP2 + noteMissesP2)..[[
		
		]])
		end

		screenCenter('endTxt', 'x')
		screenCenter('continueTxt', 'x')
		screenCenter('songNameTxt', 'x')

	end

end


-------------------player swap functions-------------------
if playable then

	if differentCharactersMode or mustPressSwap then

		function goodNoteHit(id, noteData, noteType, isSustainNote)
		
			--camera zoom thingy
			if mustPressSwap and not (formatToSongPath(getPropertyFromClass('states.PlayState', 'SONG.song')) == 'tutorial') then
				setProperty('camZooming', true)
			end

			local char = 'dad'
				
			if differentCharactersMode then
				char = swapCharacterP1
			end

			if getPropertyFromGroup('notes', id, 'inEditor') == false then
		
				local animToPlay = getProperty('singAnimations')[noteData + 1]
				local animSuffix = getPropertyFromGroup('notes', id, 'animSuffix')
				if noteType == 'Alt Animation' or altAnim then animSuffix = '-alt' end
					
				if getPropertyFromGroup('notes', id, 'gfNote') then
					
					if not (getProperty('gf') == nil) then
						
						playAnim('gf', animToPlay..animSuffix, true)
							
						--if no animation with alt anims, play normal animation
						if not (animSuffix == '') and not (getProperty('gf.animation.curAnim.name') == animToPlay..animSuffix) then
							playAnim('gf', animToPlay, true)
						end
						
						setProperty('gf.holdTimer', 0)
						
						gfSingingP1 = true
							
					end
						
				else
					
					playAnim(char, animToPlay..animSuffix, true)
					
					--if no animation with alt anims, play normal animation
					if not (animSuffix == '') and not (getProperty(char..'.animation.curAnim.name') == animToPlay..animSuffix) then
						playAnim(char, animToPlay, true)
					end
					
					if isCharacter(char) then 
						setProperty(char..'.holdTimer', 0)
					end
					
					gfSingingP1 = false
					
				end
				
				if getPropertyFromGroup('notes', id, 'noteType') == 'Hey!' then
				
					playAnim(char, 'hey', true)
					
					if isCharacter(char) then
						setProperty(char..'.specialAnim', true)
						setProperty(char..'.heyTimer', 0.6)
					end
					
					if not (getProperty('gf') == nil) then
						playAnim('gf', 'cheer', true)
						setProperty('gf.specialAnim', true)
						setProperty('gf.heyTimer', 0.6)
					end
					
				end
			
			end
			
			if isSustainNote == false then
				hitsP1 = hitsP1 + 1
			end
			
			if getProperty('health') >= 2 then
				setProperty('health', 2)
			end
			
			if math.abs(getPropertyFromGroup('notes', id, 'hitHealth')) > 0 then
			
				if mustPressSwap then

					if getProperty('health') < drainLimitP2 then
						setProperty('health', getProperty('health') - getPropertyFromGroup('notes', id, 'hitHealth') * getProperty('healthGain'))
					end
				
				else
			
					if getProperty('health') > drainLimitP1 then
						setProperty('health', getProperty('health') - getPropertyFromGroup('notes', id, 'hitHealth') * getProperty('healthGain'))
					end
				
				end
			
			end
			
			if mustPressSwap then
				callOnLuas('opponentNoteHit', {id, noteData, noteType, isSustainNote}, false, true, {scriptName})
			end

		end
		
		
		function noteMiss(id, noteData, noteType, isSustainNote)
		
			local char = 'dad'
				
			if differentCharactersMode then
				char = swapCharacterP1
			end
				
			if getPropertyFromGroup('notes', id, 'gfNote') then
				char = 'gf'
			end
			
			local animSuffix = getPropertyFromGroup('notes', id, 'animSuffix')
			if noteType == 'Alt Animation' or altAnim then animSuffix = '-alt' end
			
			if getPropertyFromGroup('notes', id, 'noMissAnimation') == false then
	
				if isCharacter(char) then

					if getProperty(char..'.hasMissAnimations') then
					
						local animToPlay = getProperty('singAnimations')[noteData + 1]..'miss'

						playAnim(char, animToPlay..animSuffix, true)

						--if no animation with alt anims, play normal animation
						if not (animSuffix == '') and not (getProperty(char..'.animation.curAnim.name') == animToPlay..animSuffix) then
							playAnim(char, animToPlay, true)
						end
						
						setProperty(char..'.specialAnim', true)
					
					end
					
				end
			
			end
			
			if getProperty('instakillOnMiss') then
				setProperty('health', 0)
			end

		end
		
	else

		function goodNoteHit(id, noteData, noteType, isSustainNote)
		
			if isSustainNote == false then
				hitsP1 = hitsP1 + 1
			end

			if getProperty('health') >= 2 then
				setProperty('health', 2)
			end
			
			if math.abs(getPropertyFromGroup('notes', id, 'hitHealth')) > 0 then
		
				if mustPressSwap then
				
					if getProperty('health') < drainLimitP2 then
						setProperty('health', getProperty('health') - getPropertyFromGroup('notes', id, 'hitHealth') * getProperty('healthGain'))
					end
				
				else
			
					if getProperty('health') > drainLimitP1 then
						setProperty('health', getProperty('health') - getPropertyFromGroup('notes', id, 'hitHealth') * getProperty('healthGain'))
					end
				
				end
			
			end
			
		end
		
		function noteMiss()
			
			if getProperty('instakillOnMiss') then
				setProperty('health', 0)
			end
			
		end

	end

end


--gameover for P1
function onGameOver()

	if playable then
	
		if cannotDieP1 then
		
			if getProperty('health') < 0 then
				setProperty('health', 0)
			end
			
			return Function_Stop
			
		else
		
			if showResultsOnGameOver then
			
				if not (inEndScreen) then
					endScreenType = 2
					startEndScreen()
				end
				
				return Function_Stop
				
			end
		
		end

	end
	
end


function animThingP2(elapsed)

	--keys
	local controlHoldArray = {}
	
	for i = 1, #keys do
		controlHoldArray[i] = getPropertyFromClass('flixel.FlxG', 'keys.pressed.'..keys[i])
	end


	--ignore if gf is singing or botplay is on
	if cpuControlled or gfSinging then
	
		for i = 1, #controlHoldArray do
			controlHoldArray[i] = false
		end
		
	end
	
	
	--animation stuff
	local thing = getPropertyFromClass('backend.Conductor', 'stepCrochet') * 0.0011 * getProperty(defaultCharacter..'.singDuration') / _G["playbackRate"]
	
	if table.contains(controlHoldArray, true) then
	
		if getProperty(defaultCharacter..'.holdTimer') > thing - 0.03 then
			setProperty(defaultCharacter..'.holdTimer', thing - 0.03)
		end
		
	end
	
end


function animThingP1(elapsed)

	local controlHoldArray = {
		keyPressed('left'),
		keyPressed('down'),
		keyPressed('up'),
		keyPressed('right')
	}
	
	if getProperty('cpuControlled') or gfSingingP1 then
	
		for i = 1, #controlHoldArray do
			controlHoldArray[i] = false
		end
		
	end

	local thing = getPropertyFromClass('backend.Conductor', 'stepCrochet') * 0.0011 * getProperty(swapCharacterP1..'.singDuration') / _G["playbackRate"]
	
	if table.contains(controlHoldArray, true) then
	
		if getProperty(swapCharacterP1..'.holdTimer') > thing - 0.03 then
			setProperty(swapCharacterP1..'.holdTimer', thing - 0.03)
		end
		
	end
	
end


function scoreTxtStuff()

	if not (getTextFont('scoreTxt') == 'VCR OSD Mono' or getTextFont('scoreTxt') == 'Pixel Arial 11 Bold')
	and not (getTextFont('scoreTxtP2') == getTextFont('scoreTxt')) then
		setProperty('scoreTxtP2.font', getTextFont('scoreTxt'))
	else
	
		if getTextFont('scoreTxt') == 'VCR OSD Mono' and not (getTextFont('scoreTxtP2') == 'VCR OSD Mono') then
			setTextFont('scoreTxtP2', 'vcr.ttf')
		end
		
		if getTextFont('scoreTxt') == 'Pixel Arial 11 Bold' and not (getTextFont('scoreTxtP2') == 'Pixel Arial 11 Bold') then
			setTextFont('scoreTxtP2', 'pixel.otf')
		end
	
	end
	
	if not (getTextSize('scoreTxtP2') == getTextSize('scoreTxt')) then
		setTextSize('scoreTxtP2', getTextSize('scoreTxt'))
	end
	
	setProperty('scoreTxtP2.visible', getProperty('scoreTxt.visible'))
	setProperty('scoreTxtP2.alpha', getProperty('scoreTxt.alpha'))
	setProperty('scoreTxtP2.color', getProperty('scoreTxt.color'))
	screenCenter('scoreTxtP2', 'x')
	
end


function botplayTextStuff(elapsed)

	if cpuControlled == false then
		setProperty('botplayTxtP2.visible', false)
	else
		setProperty('botplayTxtP2.visible', true)
	end
	

	if getProperty('botplayTxt.visible') == false then
		setProperty('botplaySine', getProperty('botplaySine') + (180 * elapsed))
		setProperty('botplayTxt.alpha', 1 - math.sin((math.pi * getProperty('botplaySine')) / 180))
	end

	setProperty('botplayTxtP2.alpha', getProperty('botplayTxt.alpha'))

	screenCenter('botplayTxtP2', 'x')
	setProperty('botplayTxtP2.x', getProperty('botplayTxtP2.x') - getProperty('healthBar.bg.width') / 3)
	setProperty('botplayTxtP2.y', getProperty('healthBar.bg.y') - 55)
	
	screenCenter('botplayTxt', 'x')
	setProperty('botplayTxt.x', getProperty('botplayTxt.x') + getProperty('healthBar.bg.width') / 3)
	setProperty('botplayTxt.y', getProperty('healthBar.bg.y') - 55)
	
	
	if botplayPlayerIndicator then
	
		local text = ''
			
		if string.find(getTextString('botplayTxt'), 'P1 ') then
			text = string.gsub(getTextString('botplayTxt'), 'P1 ', '')
		else
			text = getTextString('botplayTxt')
		end
			
		setTextString('botplayTxt', 'P1 '..text)

		
		if not (getTextString('botplayTxtP2') == getTextString('botplayTxt')) then
			setTextString('botplayTxtP2', 'P2 '..text)
		end
		
	else
	
		if not (getTextString('botplayTxtP2') == getTextString('botplayTxt')) then
			setTextString('botplayTxtP2', getTextString('botplayTxt'))
		end
		
	end
	
	
	if not (getTextFont('botplayTxt') == 'VCR OSD Mono' or getTextFont('botplayTxt') == 'Pixel Arial 11 Bold')
	and not (getTextFont('botplayTxtP2') == getTextFont('botplayTxt')) then
		setProperty('botplayTxtP2.font', getTextFont('botplayTxt'))
	else
	
		if getTextFont('botplayTxt') == 'VCR OSD Mono' and not (getTextFont('botplayTxtP2') == 'VCR OSD Mono') then
			setTextFont('botplayTxtP2', 'vcr.ttf')
		end
		
		if getTextFont('botplayTxt') == 'Pixel Arial 11 Bold' and not (getTextFont('botplayTxtP2') == 'Pixel Arial 11 Bold') then
			setTextFont('botplayTxtP2', 'pixel.otf')
		end
	
	end
	
	
	setProperty('botplayTxtP2.scale.x', getProperty('botplayTxt.scale.x'))
	setProperty('botplayTxtP2.scale.y', getProperty('botplayTxt.scale.y'))
	setProperty('botplayTxtP2.color', getProperty('botplayTxt.color'))
	setProperty('botplayTxtP2.borderSize', getProperty('botplayTxt.borderSize'))
	--setTextSize('botplayTxtP2', getTextSize('botplayTxt'))
	
end


-------------------other useful functions-------------------

--strum
function strumPlayAnim(id, anim, forced, resetTime)

	if resetTime == nil then resetTime = 0 end
	if forced == nil then forced = false end

	if forced then
		setPropertyFromGroup('strumLineNotes', id, 'animation.name', nil)
	end
	
	setPropertyFromGroup('strumLineNotes', id, 'animation.name', anim)
	setPropertyFromGroup('strumLineNotes', id, 'resetAnim', resetTime)
	
	if not (getPropertyFromClass('states.PlayState', 'SONG.disableNoteRGB')) then
	
		if anim == 'static' then
			setPropertyFromGroup('strumLineNotes', id, 'rgbShader.enabled', false)
		else
			setPropertyFromGroup('strumLineNotes', id, 'rgbShader.enabled', true)
		end
		
	end

	setPropertyFromGroup('strumLineNotes', id, 'origin.x', getPropertyFromGroup('strumLineNotes', id, 'frameWidth') / 2)
	setPropertyFromGroup('strumLineNotes', id, 'origin.y', getPropertyFromGroup('strumLineNotes', id, 'frameHeight') / 2)
	setPropertyFromGroup('strumLineNotes', id, 'offset.x', (getPropertyFromGroup('strumLineNotes', id, 'frameWidth') - getPropertyFromGroup('strumLineNotes', id, 'width')) / 2)
	setPropertyFromGroup('strumLineNotes', id, 'offset.y', (getPropertyFromGroup('strumLineNotes', id, 'frameHeight') - getPropertyFromGroup('strumLineNotes', id, 'height')) / 2)

end


function isCharacter(char)

	if char == 'boyfriend' or char == 'dad' or char == 'gf' then
		return true
	end
	
	return false

end


--from source code (Highscore.floorDecimal)
function floorDecimal(value, decimals)

	if decimals < 1 then
		return math.floor(value)
	end

	local tempMult = 1
	for i = 0, decimals-1 do
		tempMult = tempMult * 10
	end
	local newValue = math.floor(value * tempMult)
	return newValue / tempMult
	
end


--really useful
function table.contains(table, val)

	for i = 1, #table do

		if table[i] == val then
			return true
		end

	end
	return false

end


--for checking a song name (tutorial camera zoom in)
function formatToSongPath(path)

	local invalidChars = {'~', '&', '\\', ';', ':', '<', '>', '#'}
	local hideChars = {'.', ',', "'", '"', '%', '?', '!'}

	for i = 1, #invalidChars do
	
		if not (string.find(path, invalidChars[i], 1, true) == nil) then
			path = string.gsub(path, invalidChars[i], '-')
		end
	
	end

	for i = 1, #hideChars do
	
		if not (string.find(path, hideChars[i], 1, true) == nil) then
			path = string.gsub(path, hideChars[i], '')
		end
	
	end

	if string.find(path, ' ') then
		path = string.gsub(path, ' ', '-')
	end

	return path:lower()
	
end


--https://www.codegrepper.com/code-examples/lua/rgb+to+hex+lua
function rgbToHex(r, g, b)
	return string.format("%02x%02x%02x", math.floor(r), math.floor(g), math.floor(b))
end


--gets the character health color
function healthBarColor(char)
    return rgbToHex(getProperty(char..'.healthColorArray[0]'), getProperty(char..'.healthColorArray[1]'), getProperty(char..'.healthColorArray[2]'))
end


--unused but could be useful
function getKeyFromID(key)

	if key > -1 and not (key == nil) then
		return keys[key + 1]
	end
	
	return -1

end


--substate stuff
local inSubstate = false

function openSubstate(state)

	inSubstate = true

	runHaxeCode([[
		game.persistentUpdate = false;
		game.persistentDraw = true;
		game.paused = true;
		
		var music = Paths.formatToSongPath(backend.ClientPrefs.data.pauseMusic);

		substateMusic = FlxG.sound.play(Paths.music(music), 0.7);
		substateMusic.onComplete = function() {
			substateMusic = FlxG.sound.play(Paths.music(music), 0.7);
		}

		FlxCamera.defaultCameras = [game.camOther];

		game.openSubState(new ]]..state..[[(0, 0));
	]])

end


function onResume()

	if inSubstate then
	
		debugPrint('Restart the song to save changes.')
		
		inSubstate = false

		runHaxeCode([[
			substateMusic.stop();
			FlxCamera.defaultCameras = [game.camGame];
		]])
		
		--restartSong(false)
		
	end

end