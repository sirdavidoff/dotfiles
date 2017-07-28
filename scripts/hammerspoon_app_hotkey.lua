-- Written by David Roberts 7/7/15
-- TODO: If you have the same key mapped to two different apps, the mapping won't 
-- always work when switching directly between them
-- TODO: We use arbitrary listener keys below that are unlikely to ever be used. A
-- more elegant solution would be to modify hs.hotkey.modal.new() to take no arguments

--hs.alert.show("App hotkeys loaded")

-- Global variable where we store the mappings from application names
-- to listeners
_app_listeners = {}

_app_listener_keys = {
  {{"cmd", "shift", "alt"}, "F11"},
  {{"cmd", "shift", "alt"}, "F12"},
  {{"cmd", "shift", "alt"}, "F13"},
  {{"cmd", "shift", "alt"}, "F14"},
  {{"cmd", "shift", "alt"}, "F15"},
  {{"cmd", "shift", "alt"}, "F16"},
  {{"cmd", "shift", "alt"}, "F17"},
  {{"cmd", "shift", "alt"}, "F18"},
  {{"cmd", "shift", "alt"}, "F19"},
}

function tablelen(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function bindapps(apps, mods, key, pressedfn, releasedfn, repeatfn)
  for app in apps do
    bindapp(app, mods, key, pressedfn, releasedfn, repeatfn)
  end
end

function bindapp(app, mods, key, pressedfn, releasedfn, repeatfn)
  -- Create a listener for the app if it doesn't exist already
  if(not _app_listeners[app]) then
    local index = tablelen(_app_listeners) + 1
    --hs.alert.show("INDEX IS " .. index)
    _app_listeners[app] = hs.hotkey.modal.new(_app_listener_keys[index][1], _app_listener_keys[index][2])
  end
  -- Call bind on the listener with the passed arguments
  _app_listeners[app]:bind(mods, key, pressedfn, releasedfn, repeatfn)
end

function monitor_apps(appName, eventType, appObject)
  -- Find the listener that corresponds to the appName
  if appName == nil then return end
  local listener = _app_listeners[appName]

  if listener ~= nil then
    if (eventType == hs.application.watcher.activated) then
      -- If we just activated the app, turn on the listener
      listener:enter()
      --hs.alert.show("Entering " .. appName)
    elseif (eventType == hs.application.watcher.deactivated) then
      -- If we just left the app, turn off the listener
      listener:exit()
      --hs.alert.show("Exiting " .. appName)
    end
  end
end

watcher = hs.application.watcher.new(monitor_apps)
watcher:start()

--bindapp("Google Chrome", {"cmd"}, '4', function() hs.alert.show("Key pressed chrome") end)
--bindapp("Evernote", {"cmd"}, '5', function() hs.alert.show("Key pressed evernote") end)
