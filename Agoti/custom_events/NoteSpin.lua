function onEvent(name, value1, value2)
	if name == 'NoteSpin' then
		noteTweenAngle('A', 0, 360, 0.4, 'sineInOut')
		noteTweenAngle('B', 1, 360, 0.4, 'sineInOut')
		noteTweenAngle('C', 2, 360, 0.4, 'sineInOut')
		noteTweenAngle('D', 3, 360, 0.4, 'sineInOut')
		noteTweenAngle('E', 4, 360, 0.4, 'sineInOut')

		noteTweenAngle('F', 5, 360, 0.4, 'sineInOut')
		noteTweenAngle('J', 6, 360, 0.4, 'sineInOut')
		noteTweenAngle('H', 7, 360, 0.4, 'sineInOut')
		noteTweenAngle('I', 8, 360, 0.4, 'sineInOut')
	end
end

function onTweenCompleted(tag)
	if tag == 'A' then
		setPropertyFromGroup('opponentStrums', 0, 'angle', 0)
		setPropertyFromGroup('opponentStrums', 1, 'angle', 0)
		setPropertyFromGroup('opponentStrums', 2, 'angle', 0)
		setPropertyFromGroup('opponentStrums', 3, 'angle', 0)
		setPropertyFromGroup('opponentStrums', 4, 'angle', 0)

		setPropertyFromGroup('playerStrums', 0, 'angle', 0)
		setPropertyFromGroup('playerStrums', 1, 'angle', 0)
		setPropertyFromGroup('playerStrums', 2, 'angle', 0)
		setPropertyFromGroup('playerStrums', 3, 'angle', 0)
		setPropertyFromGroup('playerStrums', 4, 'angle', 0)
	end
end