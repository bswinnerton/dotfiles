keyboards_with_tap_to_escape = {
  "Happy Hacking Keyboard w/ TMK Board",
  "Infinity keyboard/TMK"
}

keyboard_found = false

for index, usb_device in pairs(hs.usb.attachedDevices()) do
  for _, keyboard in pairs(keyboards_with_tap_to_escape) do
    if keyboard == usb_device["productName"] then
      keyboard_found = usb_device["productName"]
      break
    else
      if keyboard_found == true then
        break
      end

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
end

if keyboard_found ~= false then
  notification_message = {
    title = "Disabling tap control for escape",
    informativeText = string.format("Found support on: %s", keyboard_found)
  }
else
  notification_message = {
    title = "Enabling tap control for escape",
    informativeText = "On Apple keyboard"
  }
end

hs.notify.new(notification_message):send()

function usbDeviceCallback(data)
  hs.reload()
end

usbWatcher = hs.usb.watcher.new(usbDeviceCallback)
usbWatcher:start()
