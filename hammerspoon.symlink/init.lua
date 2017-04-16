display_skip_message = function(keyboard)
  message = "%s is attached, skipping Hammerspoon config"
  hs.console.printStyledtext(string.format(message, keyboard))
end

for index, usb_device in pairs(hs.usb.attachedDevices()) do
  if (usb_device["productName"] == "Happy Hacking Keyboard w/ TMK Board") then
    display_skip_message(usb_device["productName"])
  elseif (usb_device["productName"] == "Infinity keyboard/TMK") then
    display_skip_message(usb_device["productName"])
  else
    -- Courtesy of https://gist.github.com/arbelt/b91e1f38a0880afb316dd5b5732759f1

    send_escape = false
    last_mods = {}

    control_key_handler = function()
      send_escape = false
    end

    control_key_timer = hs.timer.delayed.new(0.20, control_key_handler)

    control_handler = function(evt)
      local new_mods = evt:getFlags()
      if last_mods["ctrl"] == new_mods["ctrl"] then
        return false
      end
      if not last_mods["ctrl"] then
        last_mods = new_mods
        send_escape = true
        control_key_timer:start()
      else
        if send_escape then
          hs.eventtap.keyStroke({}, "ESCAPE")
        end
        last_mods = new_mods
        control_key_timer:stop()
      end
      return false
    end

    control_tap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, control_handler)
    control_tap:start()

    other_handler = function(evt)
      send_escape = false
      return false
    end

    other_tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, other_handler)
    other_tap:start()
  end
end

function usbDeviceCallback(data)
  hs.reload()
end

usbWatcher = hs.usb.watcher.new(usbDeviceCallback)
usbWatcher:start()
