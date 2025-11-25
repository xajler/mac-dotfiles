local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local brew_event = "brew_updates"
sbar.add("event", brew_event)

local brew_icon = icons.clipboard_list or icons.gear

local brew = sbar.add("item", "widgets.brew", {
  position = "right",
  padding_left = settings.group_paddings,
  icon = {
    string = brew_icon,
    padding_left = 0,
    color = colors.with_alpha(colors.white, 0.6),
  },
  label = {
    string = "0",
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Regular"],
      size = 14.0,
    },
    color = colors.grey,
    padding_left = 4,
    padding_right = 4,
  },
  update_freq = 21600,
})

brew:subscribe({ "routine", "system_woke" }, function()
  sbar.exec("$CONFIG_DIR/helpers/brew_update.sh")
end)

-- Create popup items for showing outdated packages
local popup_items = {}
local max_popup_items = 15

for i = 1, max_popup_items do
  popup_items[i] = sbar.add("item", {
    position = "popup." .. brew.name,
    icon = {
      font = {
        family = settings.font.text,
        style = settings.font.style_map["Regular"],
        size = 11.0,
      },
      padding_left = 10,
      padding_right = 10,
      color = colors.white,
    },
    label = { drawing = false },
    background = {
      color = colors.bg2,
      corner_radius = 3,
    },
    drawing = false,
  })
end

-- Update popup content
local function update_popup()
  sbar.exec("$CONFIG_DIR/helpers/brew_outdated_list.sh", function(list)
    local lines = {}
    for line in list:gmatch("[^\n]+") do
      table.insert(lines, line)
    end

    -- Update popup items
    for i = 1, max_popup_items do
      if lines[i] then
        popup_items[i]:set({
          icon = { string = lines[i] },
          drawing = true,
        })
      else
        popup_items[i]:set({ drawing = false })
      end
    end

    -- If no updates, show message
    if #lines == 0 then
      popup_items[1]:set({
        icon = { string = "✓ All packages up to date" },
        drawing = true,
      })
    end
  end)
end

brew:subscribe("mouse.entered", function()
  update_popup()
  brew:set({ popup = { drawing = true } })
end)

brew:subscribe("mouse.exited", function()
  brew:set({ popup = { drawing = false } })
end)

brew:subscribe("mouse.clicked", function()
  brew:set({
    icon = { string = icons.loading, color = colors.white },
    label = { string = "…", color = colors.white },
    popup = { drawing = false },
  })
  sbar.exec("$CONFIG_DIR/helpers/brew_update.sh")
end)

-- Subscribe to brew update event to restore icon and label after update completes
brew:subscribe(brew_event, function(env)
  local count = tonumber(env.INFO) or 0
  brew:set({
    icon = {
      string = brew_icon,
      color = colors.with_alpha(colors.white, 0.6),
    },
    label = {
      string = tostring(count),
      color = colors.grey,
    },
  })
end)

-- Initial update
sbar.exec("$CONFIG_DIR/helpers/brew_update.sh")

sbar.add("bracket", "widgets.brew.bracket", { brew.name }, {
  background = {
    color = colors.transparent,
    border_width = 0,
    corner_radius = 0
  }
})

sbar.add("item", "widgets.brew.padding", {
  position = "right",
  width = 210
})
