-- TODO: Pasting breaks things, and copying doesn't work
-- TODO: When something is too long, it's not displayed in the chooser
-- TODO: Hyper-V seems to be interpreted as a paste here
-- TODO: If the app is Chrome, use the active tab's domain instead of the app name
minPhraseLen = 4 -- If a phrase is shorter than this, we don't store it
maxPhraseLen = 20000 -- If a pasted phrase is longer than this, we don't store it
maxPhrases = 5000 -- Max phrase history

buffer = "" -- Where we store incoming keystrokes
phrases = {} -- Where we store the phrases
chooser = nil -- The dialog for viewing the phrases
lastFocusedWin = nil -- The window that had focus before the chooser was displayed

-- Keystroke listener to record keystrokes in the buffer, and turn them into
-- a phrase where necessary
hs.eventtap.new({hs.eventtap.event.types.keydown}, function(theEvent)

  --if isPasting(theEvent) or isCopying(theEvent) then
    ---- Add the copied/pasted text to the buffer
    --log.i("Pasting!")
    --if #hs.pasteboard.getContents() < maxPhraseLen then
      --buffer = buffer .. hs.pasteboard.getContents()
    --end
  if modifiersDown(theEvent) or -- Any modifier key (apart from shift) is down
     theEvent:getKeyCode() == 48 or -- Tab
     theEvent:getKeyCode() == 53 or -- Escape
     theEvent:getKeyCode() == 36 or -- Return
     theEvent:getKeyCode() == 123 or -- Left arrow
     theEvent:getKeyCode() == 124 or -- Right arrow
     theEvent:getKeyCode() == 125 or -- Down arrow
     theEvent:getKeyCode() == 126 -- Up arrow
  then
    -- Break the buffer into a new word
    splitWord()
  elseif theEvent:getKeyCode() == 51 then -- Backspace
    -- Remove the last char in the buffer
    buffer = string.sub(buffer, 1, -2)
  else
    -- Add the keypress to the buffer
    log.i(theEvent:getCharacters() .. "(" .. theEvent:getKeyCode() .. ")")
    buffer = buffer .. theEvent:getCharacters()
  end
end):start()

-- TODO: Copying functionality doesn't work. Have a look at
-- https://github.com/zzamboni/oh-my-hammerspoon/blob/master/plugins/misc/clipboard.lua
-- for an idea of how to do it (i.e. with a timer)
hs.eventtap.new({hs.eventtap.event.types.keyup}, function(theEvent)
  if isPasting(theEvent) or isCopying(theEvent) then
    -- Add the copied/pasted text to the buffer
    log.i("Pasting!")
    if #hs.pasteboard.getContents() < maxPhraseLen then
      buffer = buffer .. hs.pasteboard.getContents()
    end
  end
end):start()

-- Mouse listener to turn the buffer into a phrase every time the mouse is clicked
hs.eventtap.new({hs.eventtap.event.types.leftmousedown, hs.eventtap.event.types.rightmousedown}, function(theEvent)
  splitWord()
end):start()

function splitWord()
  if #buffer >= minPhraseLen then
    log.i("New word: " .. buffer)
    addPhrase(buffer)
  end
  buffer = ""
end

function addPhrase(phrase)
  newPhrases = {{["text"] = phrase, ["subText"] = hs.application.frontmostApplication():name()}}
  for i,v in ipairs(phrases) do
    if v["text"] ~= phrase then
      if i < maxPhrases then
        table.insert(newPhrases, v)
      end
    end
  end
  phrases = newPhrases
end

-- Cmd-V is pressed (optionally with shift too)
function isPasting(event)
  mods = event:getFlags()
  return event:getKeyCode() == 9 -- 'v' key is down
    and mods.cmd and not mods.alt and not mods.fn
end

-- Cmd-C is pressed (optionally with shift too)
function isCopying(event)
  mods = event:getFlags()
  return event:getKeyCode() == 8 -- 'c' key is down
    and mods.cmd and not mods.alt and not mods.fn
end

-- Returns true if any of cmd, alt, ctrl or fn is down (not shift though)
function modifiersDown(event)
  mods = event:getFlags()
  return mods.cmd or mods.alt or mods.ctrl or mods.fn
end

function showChooser()
  if phrases == nil or #phrases < 1 then return end
  lastFocusedWin = hs.window.focusedWindow()
  -- Show the window to select the phrase
  hs.alert.show("Chooser")
  --if chooser == nil then
    chooser = hs.chooser.new(chooserPhraseChosen)
    chooser:choices(chooserPhrases)
    --chooser:bgDark(true)
    chooser:rows(10)
    chooser:width(30)
    chooser:searchSubText(true)
    chooser:subTextColor({red=0.6, green=0.6, blue=0.6})
    --chooser:queryChangedCallback(qsSarchCB)
  --end
  chooser:show()
end

function chooserPhraseChosen(input)
  if lastFocusedWin ~= nil then
    lastFocusedWin:focus()
  end
  -- This is when we've selected sth from the chooser
  hs.eventtap.keyStrokes(input.text)
  -- Move this phrase back up to the top now that we've used it
  addPhrase(input.text)
  --log.i("Selection is <" .. input.text .. ">") 
end

function chooserPhrases()
  return phrases
end

hs.urlevent.bind('hypercmdy', function()
  showChooser()
end)

