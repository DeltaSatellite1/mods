function onUpdate()
if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') then
characterPlayAnim('boyfriend', 'hey', '24', true);
characterPlayAnim('gf', 'cheer', '24', true);
setProperty('boyfriend.specialAnim', true);
setProperty('gf.specialAnim', true);
playSound('Hey')
end
end
