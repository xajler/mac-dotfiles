local function load_config()
  local config = {
    calendar = {
      click_script = "open -a Calendar"
    },
    icons = "JetBrainsMono Nerd Font", -- alternatively available: NerdFont
    paddings = 3,
    group_paddings = 5,
    font = {
      text = "Hasklug Nerd Font Mono Med", -- Used for text
      numbers = "Hasklug Nerd Font Mono Med", -- Used for numbers
      style_map = {
        ["Regular"] = "Regular",
        ["Semibold"] = "Medium",
        ["Bold"] = "SemiBold",
        ["Heavy"] = "Bold",
        ["Black"] = "ExtraBold",
      },
    },
  }
  return config
end

return load_config()
