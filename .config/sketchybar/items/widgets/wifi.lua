local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local popup_width = 250

local wifi = sbar.add("item", "widgets.wifi", {
  position = "right",
  label = { drawing = false },
})

-- Background around the item
local wifi_bracket = sbar.add("bracket", "widgets.wifi.bracket", {
  wifi.name
}, {
  background = {
    color = colors.transparent,
    border_width = 0,
    corner_radius = 0
  },
  popup = { align = "center", height = 30 }
})

sbar.add("item", "widgets.wifi.padding_after", {
  position = "right",
  width = settings.group_paddings
})

local ssid = sbar.add("item", {
  position = "popup." .. wifi_bracket.name,
  icon = {
    font = {
      style = settings.font.style_map["Bold"]
    },
    string = icons.wifi.router,
  },
  width = popup_width,
  align = "center",
  label = {
    font = {
      size = 15,
      style = settings.font.style_map["Bold"]
    },
    max_chars = 18,
    string = "????????????",
  },
  background = {
    height = 2,
    color = colors.grey,
    y_offset = -15
  }
})

local hostname = sbar.add("item", {
  position = "popup." .. wifi_bracket.name,
  icon = {
    align = "left",
    string = "Hostname:",
    width = popup_width / 2,
  },
  label = {
    max_chars = 24,
    string = "????????????",
    width = popup_width / 2,
    align = "right",
  }
})

local ip = sbar.add("item", {
  position = "popup." .. wifi_bracket.name,
  icon = {
    align = "left",
    string = "IP:",
    width = popup_width / 2,
  },
  label = {
    string = "???.???.???.???",
    width = popup_width / 2,
    align = "right",
  }
})

local mask = sbar.add("item", {
  position = "popup." .. wifi_bracket.name,
  icon = {
    align = "left",
    string = "Subnet mask:",
    width = popup_width / 2,
  },
  label = {
    string = "???.???.???.???",
    width = popup_width / 2,
    align = "right",
  }
})

local router = sbar.add("item", {
  position = "popup." .. wifi_bracket.name,
  icon = {
    align = "left",
    string = "Router:",
    width = popup_width / 2,
  },
  label = {
    string = "???.???.???.???",
    width = popup_width / 2,
    align = "right",
  },
})

local wan_ip = sbar.add("item", {
  position = "popup." .. wifi_bracket.name,
  icon = {
    align = "left",
    string = "WAN IP:",
    width = popup_width / 2,
  },
  label = {
    string = "Loading...",
    width = popup_width / 2,
    align = "right",
  },
})

-- Double-click detection for opening WiFi settings
local last_click_time = 0
local double_click_delay = 0.3  -- 300ms window for double-click

wifi:subscribe({"wifi_change", "system_woke"}, function(env)
  sbar.exec("ipconfig getifaddr en0", function(ip)
    local connected = not (ip == "")
    wifi:set({
      icon = {
        string = connected and icons.wifi.connected or icons.wifi.disconnected,
        color = connected and colors.white or colors.red,
      },
    })
  end)
  sbar.exec("scutil --nc list | grep 'Connected'", function(result)
    local connected = not (result == "")
    if connected then
      wifi:set({
        icon = {
          string = icons.wifi.vpn,
          color = colors.white,
        },
      })
    end
  end)
end)

local function hide_details()
  wifi_bracket:set({ popup = { drawing = false } })
end

local function show_details()
  wifi_bracket:set({ popup = { drawing = true }})
  sbar.exec("networksetup -getcomputername", function(result)
    hostname:set({ label = result })
  end)
  sbar.exec("ipconfig getifaddr en0", function(result)
    ip:set({ label = result })
  end)
  sbar.exec("ipconfig getsummary en0 | awk -F ' SSID : '  '/ SSID : / {print $2}'", function(result)
    ssid:set({ label = result })
  end)
  sbar.exec("networksetup -getinfo Wi-Fi | awk -F 'Subnet mask: ' '/^Subnet mask: / {print $2}'", function(result)
    mask:set({ label = result })
  end)
  sbar.exec("networksetup -getinfo Wi-Fi | awk -F 'Router: ' '/^Router: / {print $2}'", function(result)
    router:set({ label = result })
  end)
  -- Fetch WAN IP (public IP address)
  sbar.exec("curl -s --max-time 3 https://api.ipify.org || curl -s --max-time 3 https://ifconfig.me/ip || echo 'N/A'", function(result)
    local wan_ip_address = result:match("^%s*(.-)%s*$")  -- Trim whitespace
    if wan_ip_address == "" or wan_ip_address == nil then
      wan_ip_address = "N/A"
    end
    wan_ip:set({ label = wan_ip_address })
  end)
end

-- Double-click to open WiFi settings
wifi:subscribe("mouse.clicked", function(env)
  local current_time = os.clock()
  local time_since_last_click = current_time - last_click_time

  if time_since_last_click < double_click_delay then
    -- Double-click detected - open WiFi settings
    sbar.exec('open "x-apple.systempreferences:com.apple.preference.network"')
    last_click_time = 0  -- Reset to prevent triple-click
  else
    last_click_time = current_time
  end
end)

local function copy_label_to_clipboard(env)
  local label = sbar.query(env.NAME).label.value
  sbar.exec("echo \"" .. label .. "\" | pbcopy")
  sbar.set(env.NAME, { label = { string = icons.clipboard, align="center" } })
  sbar.delay(1, function()
    sbar.set(env.NAME, { label = { string = label, align = "right" } })
  end)
end

ssid:subscribe("mouse.clicked", copy_label_to_clipboard)
hostname:subscribe("mouse.clicked", copy_label_to_clipboard)
ip:subscribe("mouse.clicked", copy_label_to_clipboard)
mask:subscribe("mouse.clicked", copy_label_to_clipboard)
router:subscribe("mouse.clicked", copy_label_to_clipboard)
wan_ip:subscribe("mouse.clicked", copy_label_to_clipboard)
