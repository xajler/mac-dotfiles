local colors = require("colors")
local app_icons = require("helpers.app_icons")

local lookup = app_icons["Microsoft Teams"]

local teams = sbar.add("item", "widgets.teams", {
  position = "right",
  icon = {
    font = "sketchybar-app-font:Regular:14.0",
    string = lookup,
    padding_right = 1,
    padding_left = 8,
  },
  background = {
    color = colors.transparent,
    border_width = 0,
    corner_radius = 0
  },
  update_freq = 10,
})

teams:subscribe({ "routine", "system_woke" }, function()
  local cmd = "lsappinfo info -only StatusLabel 'Microsoft Teams' 2>/dev/null || " ..
    "lsappinfo info -only StatusLabel 'Microsoft Teams (work or school)' 2>/dev/null"

  sbar.exec(cmd, function(teams_status)
    local has_badge = false
    if teams_status then
      has_badge = teams_status:match("%d+") ~= nil or teams_status:match("•") ~= nil or teams_status:match("●") ~= nil
    end

    teams:set({ icon = { color = has_badge and colors.red or colors.white } })
  end)
end)

teams:subscribe("mouse.clicked", function()
  sbar.exec("open -a 'Microsoft Teams'")
end)
