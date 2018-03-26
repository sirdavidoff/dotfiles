-- To list all running application names:
-- hs.fnutils.each(hs.application.runningApplications(), function(app) print(app:title()) end)
-- hs.fnutils.each(hs.application.runningApplications(), function(app) print(app:title() .. app:bundleID()) end)
--
-- TODO:
-- When closing PIA, kill uTorrent and Popcorn-Time

-- UNUSED HYPER KEYS
-- R
-- Z
-- P (currently used, but similar to Cmd-V)
-- F (currently Finder, but should be using Alfred more for this)
-- Shift+U
-- '
-- ,
-- .
-- /
--hs.hotkey.bind(hyper, 'r', function()
  --local status, result, descriptor = hs.osascript.applescript("tell application \"Google Chrome\" to execute javascript \"$('#dscript_to_todo').click();\"")
--end)

local log = hs.logger.new('mymodule','debug')
local keyDelay = 0

-- Load the application-specific hotkey library
dofile (os.getenv("HOME") .. "/dotfiles/hammerspoon/app_hotkey.lua")

hs.window.animationDuration = 0

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

-- Faster way of determining whether an app is running than hs.application.find()
function appRunning(appName)
  local status, result, descriptor = hs.osascript.applescript("tell application \"System Events\" to set Appli_Launch to exists (processes where name is \"" .. appName .. "\")")
  return result
end


-- Function for testing stuff
hs.urlevent.bind('hypercmdt', function() 
  -- Code goes here
end)























-- Define some keyboard modifier variables
-- (Note: Capslock bound to cmd+alt+ctrl+shift via Seil and Karabiner)
local hyper = {'cmd', 'alt', 'ctrl', 'shift'}

-- We use this to keep track of whether the first (main) screen has changed
local firstScreenName = ""

local workScreenName = "DELL U2414H"
local workScreenLayout = {
  {"MacVim", nil, workScreenName, {x=0, y=0, w=0.5, h=1}, nil, nil, nil},
  {"Google Chrome", nil, workScreenName, {x=0, y=0, w=0.8, h=1}, nil, nil, nil},
  {"Firefox", nil, workScreenName, {x=0, y=0, w=0.8, h=1}, nil, nil, nil},
  {"Evernote", nil, workScreenName, {x=0, y=0, w=0.8, h=1}, nil, nil, nil},
  {"Spotify", nil, workScreenName, {x=0, y=0, w=0.8, h=1}, nil, nil, nil},
  {"VMware Fusion", nil, workScreenName, {x=0, y=0, w=1, h=1}, nil, nil, nil},
  {"Adobe Illustrator", nil, workScreenName, {x=0, y=0, w=1, h=1}, nil, nil, nil},
  {"Adobe Photoshop CS6", nil, workScreenName, {x=0, y=0, w=1, h=1}, nil, nil, nil},
  {"Slack", nil, workScreenName, {x=0, y=0, w=0.5, h=1}, nil, nil, nil},
  {"Skype", nil, workScreenName, {x=0, y=0, w=0.5, h=1}, nil, nil, nil},
  {"Microsoft Excel", nil, workScreenName, {x=0, y=0, w=1, h=1}, nil, nil, nil},
  {"Microsoft Powerpoint", nil, workScreenName, {x=0, y=0, w=1, h=1}, nil, nil, nil},
  {"Sketch", nil, workScreenName, {x=0, y=0, w=1, h=1}, nil, nil, nil},
  {"idea", nil, workScreenName, {x=0, y=0, w=1, h=1}, nil, nil, nil},
  {"Intellij IDEA 15 CE", nil, workScreenName, {x=0, y=0, w=1, h=1}, nil, nil, nil},
  {"Tableau", nil, workScreenName, {x=0, y=0, w=1, h=1}, nil, nil, nil},
}

local laptopScreenName = "Color LCD"
local laptopScreenLayout = {
  {"MacVim", nil, laptopScreenName, {x=0, y=0, w=0.9, h=1}, nil, nil, nil},
  {"Google Chrome", nil, laptopScreenName, {x=0, y=0, w=1, h=1}, nil, nil, nil},
  {"Firefox", nil, laptopScreenName, {x=0, y=0, w=1, h=1}, nil, nil, nil},
  {"Evernote", nil, laptopScreenName, {x=0, y=0, w=0.9, h=1}, nil, nil, nil},
  {"Spotify", nil, laptopScreenName, {x=0, y=0, w=0.9, h=1}, nil, nil, nil},
  {"VMware Fusion", nil, laptopScreenName, {x=0, y=0, w=1, h=1}, nil, nil, nil},
  {"Adobe Illustrator", nil, laptopScreenName, {x=0, y=0, w=1, h=1}, nil, nil, nil},
  {"Adobe Photoshop CS6", nil, laptopScreenName, {x=0, y=0, w=1, h=1}, nil, nil, nil},
  {"Slack", nil, workScreenName, {x=0, y=0, w=0.7, h=1}, nil, nil, nil},
  {"Skype", nil, workScreenName, {x=0, y=0, w=0.7, h=1}, nil, nil, nil},
  {"Microsoft Excel", nil, workScreenName, {x=0, y=0, w=1, h=1}, nil, nil, nil},
  {"Microsoft Powerpoint", nil, workScreenName, {x=0, y=0, w=1, h=1}, nil, nil, nil},
  {"Sketch", nil, workScreenName, {x=0, y=0, w=1, h=1}, nil, nil, nil},
  {"idea", nil, workScreenName, {x=0, y=0, w=1, h=1}, nil, nil, nil},
  {"Tableau", nil, workScreenName, {x=0, y=0, w=1, h=1}, nil, nil, nil},
}

local screenLayouts = {
  [workScreenName]=workScreenLayout,
  [laptopScreenName]=laptopScreenLayout,
}

-- Tiles any open iTerm windows (in the order they were opened?)
function setiTermLayout()

  app = hs.application.find('iTerm')
  if app == nil or not app:isRunning() then return end

  w = hs.screen.allScreens()[1]:frame().w/2
  h = hs.screen.allScreens()[1]:frame().h/2

  -- Position attributes for the top-left, top-right, bottom-left and bottom-right windows
  left = {0, w, 0, w}
  top =  {0, 0, h, h}

  wins = app:visibleWindows()
  for i = 1, #wins do
    wins[i]:setFrame(hs.geometry.rect(left[i], top[i], w, h))
  end

end


-- Changes window sizes/positions according to the currently-connected screens
function updateWindows()
  log.e("updateWindows() called")
  newScreenName = hs.screen.primaryScreen():name()
  log.e("newScreenName is " .. newScreenName)
  --hs.alert.show("New screen is " .. newScreenName)

  if newScreenName == workScreenName then
      log.e("Turning off screen")
      hs.brightness.set(0)
  else
      hs.brightness.set(70)
      log.e("Turning screen to 70")
  end

  if screenLayouts[newScreenName] ~= nil then
    hs.layout.apply(screenLayouts[newScreenName])
  else
    hs.layout.apply(laptopScreenLayout)
  end

  setiTermLayout()

end

-- When connecting/disconnecting an external screen, resize all windows
function screensChangedCallback()
    --hs.alert.show("Primary is " .. hs.screen.primaryScreen():name())
    newFirstScreenName = hs.screen.primaryScreen():name()
    log.e("!!! Old first screen is " .. firstScreenName .. ", new is " .. newFirstScreenName)
    if newFirstScreenName ~= firstScreenName then
      updateWindows()
    end
    firstScreenName = newFirstScreenName
end


screenWatcher = hs.screen.watcher.new(screensChangedCallback)
screenWatcher:start()
updateWindows()



hs.urlevent.bind('invalid_key', function() 
  hs.alert.show("You need to use the other command (⌘) key!")
end)



-- Notify me when I use a keyboard shortcut to copy something
-- that way if I hit the keys wrong I'll know straight away
hs.eventtap.new({hs.eventtap.event.types.keyDown},
  function(e)
    if (e:getCharacters() == "c" and e:getFlags():containExactly({"cmd"})) then
      hs.alert.show(
        "Copy", 
        {radius=5, strokeColor={white=0, alpha=0}}, 
        hs.screen.mainScreen(), 
        0.2
      )
    end
    return false
  end
):start()

-- Forward delete
hs.hotkey.bind(hyper, 'return', function() hs.eventtap.keyStroke({}, 'forwarddelete', keyDelay) end)
-- Forward delete entire word
hs.urlevent.bind('hypercmdreturn', function()
  hs.eventtap.keyStroke({'alt', 'shift'}, 'right', keyDelay) 
  hs.eventtap.keyStroke({}, 'delete', keyDelay) 
end)

-- Move up, down, left and right
hs.hotkey.bind(hyper, 'j', function() hs.eventtap.keyStroke({}, 'down', keyDelay) end)
hs.hotkey.bind(hyper, 'k', function() hs.eventtap.keyStroke({}, 'up', keyDelay) end)
hs.hotkey.bind(hyper, 'h', function() hs.eventtap.keyStroke({}, 'left', keyDelay) end)
hs.hotkey.bind(hyper, 'l', function() hs.eventtap.keyStroke({}, 'right', keyDelay) end)

-- Move to start/end of line
hs.hotkey.bind(hyper, 'i', function() hs.eventtap.keyStroke({'cmd'}, 'left', keyDelay) end)
hs.hotkey.bind(hyper, 'a', function() hs.eventtap.keyStroke({'cmd'}, 'right', keyDelay) end)

-- Move to start of / end of / next word
hs.hotkey.bind(hyper, 'b', function() hs.eventtap.keyStroke({'alt'}, 'left', keyDelay) end)
hs.hotkey.bind(hyper, 'e', function() hs.eventtap.keyStroke({'alt'}, 'right', keyDelay) end)
hs.hotkey.bind(hyper, 'w', function() 
  hs.eventtap.keyStroke({'alt'}, 'right', keyDelay) 
  hs.eventtap.keyStroke({'alt'}, 'right', keyDelay) 
  hs.eventtap.keyStroke({'alt'}, 'left', keyDelay) 
end)

-- Select the current line
hs.hotkey.bind(hyper, 'v', function()
  hs.eventtap.keyStroke({'cmd'}, 'left', keyDelay)
  hs.eventtap.keyStroke({'cmd', 'shift'}, 'right', keyDelay)
end)

-- Yank the current line
hs.hotkey.bind(hyper, 'y', nil, function()
  hs.eventtap.keyStroke({'cmd'}, 'left', keyDelay)
  hs.eventtap.keyStroke({'cmd', 'shift'}, 'right', keyDelay)
  hs.eventtap.keyStroke({'cmd'}, 'c', 200000)
  hs.eventtap.keyStroke({}, 'right', keyDelay)
end)

--function myerrorhandler( err )
   --print( "ERROR:", err )
   --hs.alert.show(err)
--end

hs.hotkey.bind(hyper, 'd', nil, function()
  if hs.application("Finder"):isFrontmost() then
    -- Go back up one level in the hierarchy
    hs.eventtap.keyStroke({"cmd"}, 'up', keyDelay) 
  else
    -- Cut the current line
    hs.eventtap.keyStroke({'cmd'}, 'left', keyDelay)
    --xpcall(bad, myerrorhandler)
    --xpcall(hs.eventtap.keyStroke, myerrorhandler, {'cmd', 'shift'}, 'right', keyDelay)
    --xpcall(hs.eventtap.keyStroke, myerrorhandler, {'cmd'}, 'x', 500000)
    hs.eventtap.keyStroke({'cmd', 'shift'}, 'right', keyDelay)
    -- We need a delay before the cut, otherwise it doesn't always work
    hs.eventtap.keyStroke({'cmd'}, 'x', 500000)
    hs.eventtap.keyStroke({}, 'delete', keyDelay)
  end
end)
-- multiple instances for some reason
hs.urlevent.bind('hypercmdm', function()

  --apps = hs.application.runningApplications()
end)

-- Open line below/above
hs.hotkey.bind(hyper, 'o', function() 
  hs.eventtap.keyStroke({'cmd'}, 'right', keyDelay) 
  hs.eventtap.keyStroke({''}, 'return', keyDelay) 
end)
hs.urlevent.bind('hypercmdo', function() 
  if appRunning("Microsoft Excel") and hs.application("Microsoft Excel"):isFrontmost() then
    -- Lock the cell reference with $ (easier than pressing Fn-F4)
    hs.eventtap.keyStroke({}, 'F4', keyDelay)
  else
    hs.eventtap.keyStroke({'cmd'}, 'left', keyDelay) 
    hs.eventtap.keyStroke({''}, 'return', keyDelay) 
    hs.eventtap.keyStroke({''}, 'up', keyDelay) 
  end
end)

-- Paste on new line below/above
hs.hotkey.bind(hyper, 'p', function() 
  hs.eventtap.keyStroke({'cmd'}, 'right', keyDelay) 
  hs.eventtap.keyStroke({''}, 'return', keyDelay) 
  hs.eventtap.keyStroke({'cmd'}, 'v', keyDelay) 
end)
hs.urlevent.bind('hypercmdp', function() 
  hs.eventtap.keyStroke({'cmd'}, 'left', keyDelay) 
  hs.eventtap.keyStroke({''}, 'return', keyDelay) 
  hs.eventtap.keyStroke({''}, 'up', keyDelay) 
  hs.eventtap.keyStroke({'cmd'}, 'v', keyDelay) 
end)

-- Insert a bullet at the beginning of the line
hs.urlevent.bind('hypercmdb', function() 
  hs.eventtap.keyStroke({'cmd'}, 'left', keyDelay) 
  hs.eventtap.keyStroke({''}, '-', keyDelay) 
  hs.eventtap.keyStroke({''}, 'space', keyDelay) 
  hs.eventtap.keyStroke({''}, 'down', keyDelay) 
end)

-- Delete the current word
-- FIXME: Bug where can't send the same key we're binding to (in this case delete)
hs.hotkey.bind(hyper, 'delete', function()
  hs.eventtap.keyStroke({'alt'}, 'left', keyDelay)
  hs.eventtap.keyStroke({'alt', 'shift'}, 'right', keyDelay)
  hs.eventtap.keyStroke({}, 'delete', keyDelay)
end)

-- Hyper+modifier hotkeys, remapped using Karabiner URLs
hs.urlevent.bind('hypercmdj', function() 
  -- Send page down, unless we're in the Finder where we should move to the bottom
  if hs.application("Finder"):isFrontmost() then
    hs.eventtap.keyStroke({'alt'}, 'down', keyDelay)
  elseif appRunning("Microsoft Excel") and hs.application("Microsoft Excel"):isFrontmost() then
    hs.eventtap.keyStroke({'cmd'}, 'down', keyDelay)
  else
    hs.eventtap.keyStroke({}, 'pagedown', keyDelay) 
  end
end)
hs.urlevent.bind('hypercmdk', function() 
  -- Send page up, unless we're in an app where we should do something else
  if hs.application("Finder"):isFrontmost() then
    -- FIXME: This doesn't work, although doing it with 'down' instead does
    hs.eventtap.keyStroke({'alt'}, 'up', keyDelay)
  elseif appRunning("Microsoft Excel") and hs.application("Microsoft Excel"):isFrontmost() then
    hs.eventtap.keyStroke({'cmd'}, 'up', keyDelay)
  else
    hs.eventtap.keyStroke({}, 'pageup', keyDelay) 
  end
end)
hs.urlevent.bind('hypercmdh', function() 
  if appRunning("Microsoft Excel") and hs.application("Microsoft Excel"):isFrontmost() then
    -- Expand selection left to end of data
    hs.eventtap.keyStroke({'cmd'}, 'left', keyDelay)
  else
    -- Open Hubspot
    os.execute('osascript "' .. os.getenv("HOME") .. '/dotfiles/scripts/Activate Chrome for Hubspot.scpt"')
  end
end)
hs.urlevent.bind('hypercmdl', function() 
  -- Send page up, unless we're in an app where we should do something else
  if appRunning("Microsoft Excel") and hs.application("Microsoft Excel"):isFrontmost() then
  -- Expand selection right to end of data
    hs.eventtap.keyStroke({'cmd'}, 'right', keyDelay)
  else
    -- Open Lever
    os.execute('osascript "' .. os.getenv("HOME") .. '/dotfiles/scripts/Activate Chrome for Lever.scpt"')
  end
end)

hs.urlevent.bind('hyperaltj', function() 
  -- Excel: Move selection right to end of data
  -- Other: move down five lines
  -- For some reason calling hs.application() when Excel isn't running is really slow
  if appRunning("Microsoft Excel") and hs.application("Microsoft Excel"):isFrontmost() then
    hs.eventtap.keyStroke({'cmd', 'shift'}, 'down', keyDelay)
  else
    hs.eventtap.keyStroke({}, 'down', 0) 
    hs.eventtap.keyStroke({}, 'down', 0) 
    hs.eventtap.keyStroke({}, 'down', 0) 
    hs.eventtap.keyStroke({}, 'down', 0) 
    hs.eventtap.keyStroke({}, 'down', 0) 
  end
end)
hs.urlevent.bind('hyperaltk', function() 
  -- Excel: Move selection left to end of data
  -- Other: move up five lines
  -- For some reason calling hs.application() when Excel isn't running is really slow
  if appRunning("Microsoft Excel") and hs.application("Microsoft Excel"):isFrontmost() then
    hs.eventtap.keyStroke({'cmd', 'shift'}, 'up', keyDelay)
  else
    hs.eventtap.keyStroke({}, 'up', 0) 
    hs.eventtap.keyStroke({}, 'up', 0) 
    hs.eventtap.keyStroke({}, 'up', 0) 
    hs.eventtap.keyStroke({}, 'up', 0) 
    hs.eventtap.keyStroke({}, 'up', 0) 
  end
end)
hs.urlevent.bind('hyperalth', function() 
  -- Excel: Move selection left to end of data
  -- For some reason calling hs.application() when Excel isn't running is really slow
  if appRunning("Microsoft Excel") and hs.application("Microsoft Excel"):isFrontmost() then
    hs.eventtap.keyStroke({'cmd', 'shift'}, 'left', keyDelay)
  end
end)
hs.urlevent.bind('hyperaltl', function() 
  -- Excel: Move selection right to end of data
  -- For some reason calling hs.application() when Excel isn't running is really slow
  if appRunning("Microsoft Excel") and hs.application("Microsoft Excel"):isFrontmost() then
    hs.eventtap.keyStroke({'cmd', 'shift'}, 'right', keyDelay)
  end
end)
hs.urlevent.bind('hyperaltu', function() 
  -- Run script for clicking todo list buttons, but only if we're in Chrome
  if appRunning("Google Chrome") and hs.application("Google Chrome"):isFrontmost() then
    os.execute('osascript "' .. os.getenv("HOME") .. '/dotfiles/scripts/Chrome click Todo buttons.scpt" "in_progress"')
  end
end)
hs.urlevent.bind('hyperalti', function() 
  -- Run script for clicking todo list buttons, but only if we're in Chrome
  if appRunning("Google Chrome") and hs.application("Google Chrome"):isFrontmost() then
    os.execute('osascript "' .. os.getenv("HOME") .. '/dotfiles/scripts/Chrome click Todo buttons.scpt" "waiting"')
  end
end)
hs.urlevent.bind('hyperalto', function() 
  -- Run script for clicking todo list buttons, but only if we're in Chrome
  if appRunning("Google Chrome") and hs.application("Google Chrome"):isFrontmost() then
    os.execute('osascript "' .. os.getenv("HOME") .. '/dotfiles/scripts/Chrome click Todo buttons.scpt" "todo"')
  end
end)
hs.urlevent.bind('hyperaltp', function() 
  -- Run script for clicking todo list buttons, but only if we're in Chrome
  if appRunning("Google Chrome") and hs.application("Google Chrome"):isFrontmost() then
    os.execute('osascript "' .. os.getenv("HOME") .. '/dotfiles/scripts/Chrome click Todo buttons.scpt" "done"')
  end
end)

hs.urlevent.bind('hypershiftj', function() hs.eventtap.keyStroke({'shift'}, 'down', keyDelay) end)
hs.urlevent.bind('hypershiftk', function() hs.eventtap.keyStroke({'shift'}, 'up', keyDelay) end)
hs.urlevent.bind('hypershifth', function() hs.eventtap.keyStroke({'shift'}, 'left', keyDelay) end)
hs.urlevent.bind('hypershiftl', function() hs.eventtap.keyStroke({'shift'}, 'right', keyDelay) end)

-- Paste without formatting
hs.urlevent.bind('hypercmdv', function() 
  hs.alert.show("Pasting without formatting")
  os.execute('osascript "' .. os.getenv("HOME") .. '/dotfiles/scripts/Paste without formatting.scpt"')
end)

-- Show the clipboard history from Alfred
hs.urlevent.bind('hypercmdspace', function()
  hs.eventtap.keyStroke({'cmd', 'alt'}, 'c', keyDelay)
end)

-- Activate Finder
hs.hotkey.bind(hyper, 'f', function()
  hs.application.launchOrFocus("Finder")
end)

-- Activate Evernote, or switch to the 'todo' note if it's already frontmost
hs.hotkey.bind(hyper, 'n', function()
  --app = hs.application.find('Evernote')
  --if app ~= nil and app.isFrontmost ~= nil and app:isFrontmost() then
    --hs.eventtap.keyStroke({'cmd'}, '1', keyDelay)
  --else
    hs.application.launchOrFocus('Evernote')
  --end
end)

-- Activate todo list in Google Docs
hs.hotkey.bind(hyper, 'u', function()
  os.execute('osascript "' .. os.getenv("HOME") .. '/dotfiles/scripts/Activate Chrome for Google Docs todo.scpt"')
end)

-- Activate Gmail
hs.hotkey.bind(hyper, 'g', function()
  os.execute('osascript "' .. os.getenv("HOME") .. '/dotfiles/scripts/Activate Chrome for Gmail.scpt"')
end)

-- Activate Google Calendar
hs.hotkey.bind(hyper, 'c', function()
  os.execute('osascript "' .. os.getenv("HOME") .. '/dotfiles/scripts/Activate Chrome for Google Calendar.scpt"')
end)

-- Activate Facebook Messenger
hs.hotkey.bind(hyper, 'm', function()
  os.execute('osascript "' .. os.getenv("HOME") .. '/dotfiles/scripts/Activate Chrome for Messenger.scpt"')
end)

-- Activate Whatsapp
hs.hotkey.bind(hyper, 'r', function()
  os.execute('osascript "' .. os.getenv("HOME") .. '/dotfiles/scripts/Activate Chrome for WhatsApp.scpt"')
end)

-- Activate JIRA
hs.hotkey.bind(hyper, 'q', function()
  os.execute('osascript "' .. os.getenv("HOME") .. '/dotfiles/scripts/Activate Pointwise Jira.scpt"')
end)

-- Activate IDEA
hs.hotkey.bind(hyper, 'z', function()
  local appName = "IntelliJ IDEA CE"
  local bool, obj, descriptor = hs.osascript.applescript("set result to (display dialog \"Really launch ".. appName .."?\")\n return the button returned of result")
  if obj == "OK" then
    hs.application.launchOrFocus(appName)
  end
end)

-- Open work mail
hs.hotkey.bind(hyper, 'x', function()
  os.execute('osascript "' .. os.getenv("HOME") .. '/dotfiles/scripts/Activate Chrome for Gmail (PointWise).scpt"')
end)

-- Activate Chrome (going to last tab if we're already in Chrome)
hs.hotkey.bind(hyper, 'space', function()
  os.execute('osascript "' .. os.getenv("HOME") .. '/dotfiles/scripts/Activate Chrome or go to last tab.scpt"')
end)

-- Name active application
hs.urlevent.bind('hypercmda', function()
  os.execute('osascript "' .. os.getenv("HOME") .. '/dotfiles/scripts/Name active application.scpt"')
end)

-- Activate Spotify
hs.hotkey.bind(hyper, ';', function()
  hs.application.launchOrFocus("Spotify")
end)

-- Open downloads folder
hs.urlevent.bind('hypercmdd', function()
  os.execute('open "' .. os.getenv("HOME") .. '/Downloads"')
end)

-- Open Google Drive folder
hs.urlevent.bind('hypercmds', function()
  os.execute('open \"' .. os.getenv("HOME") .. '/Google Drive\"')
end)

-- Activate Slack
hs.hotkey.bind(hyper, 's', function()
  -- For some reason applescript is faster than launchOrFocus
  hs.osascript.applescript("tell application \"Slack\" to activate")
  --hs.application.launchOrFocus("Slack")
end)

-- Activate iTerm
-- Make sure that all windows are brought to the front when switching to iTerm
hs.hotkey.bind(hyper, 't', function()
  app = hs.application.find('iTerm2')
  if app ~= nil and app:isRunning() then
    app:activate(true)
  else
    hs.application.open('/Applications/Utilities/iTerm.app')
  end
end)

-- Activate MacVim - if we use launchOrFocus() we end up launching
-- multiple instances for some reason
hs.urlevent.bind('hypercmdm', function()
  app = hs.application.find('macVim')
  if app ~= nil and app:isRunning() then
    app:activate(true)
  else
    hs.application.open('MacVim')
  end

  --apps = hs.application.runningApplications()
end)

-- Display current track in spotify
hs.urlevent.bind('hyperslash', function() 
  os.execute('osascript "' .. os.getenv("HOME") .. '/dotfiles/scripts/Spotify display current track info.scpt"')
end)

-- Realign windows
hs.urlevent.bind('hypercmdw', function() 
  updateWindows()
end)

-- Tile the front two apps
-- - The frontmost main window of the frontmost app takes up the left side of the screen
-- - The frontmost main window of the second-frontmost app takes up the right side of the screen
hs.urlevent.bind('tileapps', function(eventName, params) 

  -- We may be passed the first few letters of the app to tile
  -- with from Alfred
  app2nameFragment = params["app"]

  -- Get a list of all the major windows, ordered by last active
  local wins = hs.window.filter.new():getWindows()
  local app1name = wins[1]:application():title()
  local app2name = nil

  local app2pos = nil
  i = 2

  if app2nameFragment == "" then
    -- There was no app name passed to the script
    -- Find the first window of the second frontmost app
    while app2pos == nil and i <= #wins do
      name = wins[i]:application():title()
      if name ~= wins[1]:application():title() then 
        app2name = name 
        app2pos = i
      end
      i = i + 1
    end

  else
    -- There was an app name passed to the script
    -- Find the first window of the matching app
    while app2pos == nil and i <= #wins do
      name = wins[i]:application():title()
      if name ~= wins[1]:application():title() and 
         string.find(string.lower(name), string.lower(app2nameFragment)) == 1 then 
        app2name = name 
        app2pos = i
      end
      i = i + 1
    end
    if app2pos == nil then 
      hs.alert.show("No matching app found") 
      return
    end

  end
  --hs.alert.show("Front: "..app1name..", second: " .. app2name)

  local screenFrame = wins[1]:screen():frame()
  local winFrame1 = wins[1]:frame()
  local winFrame2 = wins[app2pos]:frame()

  winFrame1.x = 0
  winFrame1.y = 0
  winFrame1.w = screenFrame.w / 2
  winFrame1.h = screenFrame.h
  wins[1]:setFrame(winFrame1)

  winFrame2.x = screenFrame.w / 2
  winFrame2.y = 0
  winFrame2.w = screenFrame.w / 2
  winFrame2.h = screenFrame.h
  wins[app2pos]:setFrame(winFrame2)

  -- Make sure these two windows are brought to the front
  wins[app2pos]:focus()
  wins[1]:focus()
end)

--
---------------------------------------------
------------- Text insertions ---------------
---------------------------------------------

-- We paste the text rather than using hs.eventtap.keyStrokes(), because otherwise
-- the letters sometimes appear in the wrong order
function insertText(text)
  hs.pasteboard.setContents(text)
  hs.eventtap.keyStroke({'cmd'}, 'v', keyDelay) 
end

hs.hotkey.bind(hyper, '1', function() insertText('6kk81Cug2GnUZYjzk33dL87K3JIK95yu') end)
hs.hotkey.bind(hyper, '2', function() insertText('davewroberts@yahoo.com') end)
hs.hotkey.bind(hyper, '3', function() insertText(os.date("%Y%m%d")) end)
hs.hotkey.bind(hyper, '4', function() insertText('david.roberts@locarta.co') end)
hs.hotkey.bind(hyper, '9', function() insertText('+4915753632560') end)

---------------------------------------------
-- Application-specific keyboard shortcuts --
---------------------------------------------

-- Put focus back on the main window if we're in the address bar
bindapp("Google Chrome", {"cmd"}, 'm', function() 
  hs.eventtap.keyStroke({}, 'tab', keyDelay) 
  hs.eventtap.keyStroke({}, 'tab', keyDelay) 
  hs.eventtap.keyStroke({}, 'tab', keyDelay) 
  hs.eventtap.keyStroke({}, 'tab', keyDelay) 
  hs.eventtap.keyStroke({}, 'tab', keyDelay) 
  hs.eventtap.keyStroke({}, 'tab', keyDelay) 
  hs.eventtap.keyStroke({}, 'tab', keyDelay) 
  hs.eventtap.keyStroke({}, 'tab', keyDelay) 
  hs.eventtap.keyStroke({}, 'tab', keyDelay) 
  hs.eventtap.keyStroke({}, 'tab', keyDelay) 
end)

-- Put focus on the notes list in Evernote when editing an
-- individual note
bindapp("Evernote", {"cmd"}, 'h', function() 
  hs.eventtap.keyStroke({"cmd", "alt"}, 'f', keyDelay) 
  hs.eventtap.keyStroke({}, 'return', keyDelay) 
end)
-- Make searching all notes less difficult on the fingers
bindapp("Evernote", {"cmd"}, 'l', function() 
    hs.eventtap.keyStroke({"cmd", "alt"}, 'f', keyDelay) 
end)

-- Search with Cmd-l in Finder (just like Chrome)
bindapp("Finder", {"cmd"}, 'l', function() 
  --hs.timer.doAfter(0.2, function() -- Need to do this to make sure the key is up, otherwise won't work
    hs.eventtap.keyStroke({"cmd"}, 'f', keyDelay) 
  --end)
end)

-- Focus on the Excel formula bar with Cmd-L
bindapp("Microsoft Excel", {"cmd"}, 'l', function() 
    hs.eventtap.keyStroke({"ctrl"}, 'u', keyDelay) 
end)

-- Get moving to beginning and end of line to work as normal in iTerm
bindapp("iTerm", hyper, 'i', function() hs.eventtap.keyStroke({"ctrl"}, 'a', keyDelay) end)
bindapp("iTerm", hyper, 'a', function() hs.eventtap.keyStroke({"ctrl"}, 'e', keyDelay) end)

-- Export current Tableau worksheet as image
bindapp("Tableau", {"cmd"}, 'e', function() 
  hs.alert.show("Let's do this!")
  local app = hs.appfinder.appFromName("Tableau")
  local menu_item = app:selectMenuItem({"Worksheet", "Export", "Image..."})
  hs.timer.doAfter(0.2, function()
    hs.eventtap.keyStroke({"shift"}, 'tab', keyDelay) 
    hs.eventtap.keyStroke({}, 'space', keyDelay) 
    hs.timer.doAfter(0.9, function()
      hs.eventtap.keyStroke({"opt"}, 'left', keyDelay)
      hs.eventtap.keyStrokes(os.date("%Y%m%d") .. " ")
    end)
  end)
end)

-- When closing Private Internet Access, kill some other applications (pia_tray)
-- FIXME: Application watchers don't currently work for some processes (like pia_tray).
-- Need to wait for a version in which this is fixed
function piaWatch(appName, eventType, appObject)
    if (eventType == hs.application.watcher.launched) then
        --if (appName == "pia_tray") then
          --hs.alert.show(appName .. " opened")
        --end
    end
end
local piaWatcher = hs.application.watcher.new(piaWatch)
piaWatcher:start()

-- Maximise the window
hs.hotkey.bind(hyper, 'up', function() 
  local win = hs.window.focusedWindow()
  local winFrame = win:frame()
  local screenFrame = win:screen():frame()

  winFrame.x = 0
  winFrame.y = 0
  winFrame.w = screenFrame.w
  winFrame.h = screenFrame.h
  win:setFrame(winFrame)
end)

-- Pin window to the left half of the screen
hs.hotkey.bind(hyper, 'left', function() 
  local win = hs.window.focusedWindow()
  local winFrame = win:frame()
  local screenFrame = win:screen():frame()

  winFrame.x = 0
  winFrame.y = 0
  winFrame.w = screenFrame.w / 2
  winFrame.h = screenFrame.h
  win:setFrame(winFrame)
end)

-- Pin window to the right half of the screen
hs.hotkey.bind(hyper, 'right', function() 
  local win = hs.window.focusedWindow()
  local winFrame = win:frame()
  local screenFrame = win:screen():frame()

  winFrame.x = screenFrame.w / 2
  winFrame.y = 0
  winFrame.w = screenFrame.w / 2
  winFrame.h = screenFrame.h
  win:setFrame(winFrame)
end)

-- Set system volume on connecting to wifi network
local wifiWatcher = nil
local homeSSID = "WO IST MEIN MUESLI"
local lastSSID = hs.wifi.currentNetwork()

function ssidChangedCallback()
    newSSID = hs.wifi.currentNetwork()

    if newSSID == homeSSID and lastSSID ~= homeSSID then
        -- We just joined our home WiFi network
        hs.audiodevice.defaultOutputDevice():setVolume(50)
    elseif newSSID ~= homeSSID and lastSSID == homeSSID then
        -- We just departed our home WiFi network
        hs.audiodevice.defaultOutputDevice():setVolume(0)
    end

    lastSSID = newSSID
end

wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()





-- Automatic config reloading
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

-- Finally, show a notification that we finished loading the config successfully
hs.notify.new({
  title='Hammerspoon',
  informativeText='Config loaded'
}):send():release()

