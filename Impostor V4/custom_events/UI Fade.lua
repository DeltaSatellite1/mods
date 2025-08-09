function getHud()
      local hud = {}
      if hideHud then
            if timeBarType ~= 'Disabled' then
                  if version >= '0.7' then
                        hud = {'timeBar','timeTxt'}
                  else
                        hud = {'timeBar','timeBarBG','timeTxt'}
                  end
            end
      else
            if timeBarType ~= 'Disabled' then
                  if version >= '0.7' then
                        hud = {'timeBar','timeTxt','scoreTxt','iconP1','iconP2','healthBar'}
                  else
                        hud = {'timeBar','timeBarBG','timeTxt','scoreTxt','iconP1','iconP2','healthBar','healthBarBG'}
                  end
            else
                  if version >= '0.7' then
                        hud = {'scoreTxt','iconP1','iconP2','healthBar'}
                  else
                        hud = {'scoreTxt','iconP1','iconP2','healthBar','healthBarBG'}
                  end
            end
      end
      return hud
end
function split(text,argument)
      local array = {}
      local founded = false
      local pos = 0
      repeat
          founded = false
          local split,_ = string.find(text,argument,pos,true)
          local number = string.sub(text,pos)
          if split then
              number = string.sub(text,pos,split-1)
              founded = true
              pos = _+1
          else
              if pos == 0 then
                  array = {number}
              end
          end
          table.insert(array,number)
      until founded == false
  
      return array
  end
function onEvent(name, v1, v2)
	if name == 'UI Fade' then
            local easing = nil
            local duration = nil
            local target = nil
            local leaveNotes = nil
            local hudArray = getHud()

            local v1split = split(v1,',')
            target = tonumber(v1split[1])
            easing = v1split[2]
            leaveNotes = v1split[3]
            if target == nil then
                  target = 0
            end
            if easing == nil then
                  easing = 'cubeOut'
            end
            if v2 ~= '' then
                  duration = tonumber(v2)
            end
            if duration == nil then
                  duration = 0
            end
            if easing == '.' then
                  easing = 'linear'
            end
            if target ~= nil then
                  if leaveNotes == nil or leaveNotes == 'false' then
                        for strums = 0,7 do
                              if duration > 0 then
                                    if middlescroll and strums < 4 then
                                          noteTweenAlpha('noteUniAlpha'..strums, strums, target*0.3, duration, easing)
                                    else
                                          noteTweenAlpha('noteUniAlpha'..strums, strums, target, duration, easing)
                                    end
                              else
                                    cancelTween('noteUniAlpha'..strums)
                                    if middlescroll and strums < 4 then
                                          setPropertyFromGroup('strumLineNotes', strums,'alpha',target*0.3);
                                    else
                                          setPropertyFromGroup('strumLineNotes', strums,'alpha',target);
                                    end
                              end
                        end
                  end
                  for i, hud  in pairs(hudArray) do
                        if duration == 0 then
                              cancelTween('hudAlpha'..hud)
                              setProperty(hud..'.alpha', target)
                        else
                              doTweenAlpha('hudAlpha'..hud,hud,target,duration,easing)
                        end
                  end

            end
	end
end