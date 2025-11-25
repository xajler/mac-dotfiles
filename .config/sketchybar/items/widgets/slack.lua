local colors = require("colors")
local app_icons = require("helpers.app_icons")

local lookup = app_icons["Slack"]
local mention_sound = "/System/Library/Sounds/Glass.aiff"
local mention_active = false

local slack = sbar.add("item", "widgets.slack", {
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

slack:subscribe({ "routine", "system_woke" }, function()
  sbar.exec("lsappinfo info -only StatusLabel 'Slack'", function(slack_status)
    local icon_color = colors.white
    local has_mention = false
    if slack_status then
      if slack_status:match("%d+") then
        icon_color = colors.red
        has_mention = true
      elseif slack_status:match("•") or slack_status:match("●") then
        icon_color = colors.blue
      end
    end

    if has_mention and not mention_active then
      sbar.exec("afplay '" .. mention_sound .. "' >/dev/null 2>&1 &")
    end

    mention_active = has_mention
    slack:set({ icon = { color = icon_color } })
  end)
end)

slack:subscribe("mouse.clicked", function()
  sbar.exec("open -a 'Slack'")
end)
