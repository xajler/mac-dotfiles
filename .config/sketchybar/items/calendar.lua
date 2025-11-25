local settings = require("settings")
local colors = require("colors")

sbar.add("item", { position = "center", width = settings.group_paddings })

local cal_date = sbar.add("item", {
    position = "center",
    padding_left = 20,
    update_freq = 300,
    label = {
      color = colors.white,
      font = {
        family = settings.font.numbers,
        size = 12.0
      },
      padding_left = 10,
      padding_right = 20,
      y_offset = 3,
    }
  })

local center_spacing = sbar.add("item", { position = "center", width = 285 })

sbar.add("item", { position = "center", width = settings.group_paddings })

local cal_time = sbar.add("item", {
    position = "right",
    padding_left = 6,
    update_freq = 60,
    label = {
      color = colors.white,
      font = {
        family = settings.font.numbers,
        size = 12.0
      },
      padding_left = 4,
      padding_right = 20,
      y_offset = 3,
    }
  })

cal_date:subscribe({ "forced", "routine", "system_woke" }, function(env)
    local date_value = string.format("%s %d", os.date("%a %b"), tonumber(os.date("%d")))
    cal_date:set({ label = { string = date_value } })
  end)

cal_time:subscribe({ "forced", "routine", "system_woke" }, function(env)
    cal_time:set({ label = { string = os.date("%H:%M") } })
  end)

-- Click on date: open Calendar app in workspace 10
cal_date:subscribe("mouse.clicked", function(env)
  sbar.exec("aerospace workspace 10")
  sbar.exec("open -a Calendar")
end)

cal_time:subscribe("mouse.clicked", function(env)
  sbar.exec(settings.calendar.click_script)
end)

