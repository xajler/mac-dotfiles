local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
  height = 32,
  color = colors.bar.bg,
  padding_right = 20,
  padding_left = 2,
  topmost = "window",
  border_width = 0,
  border_color = colors.transparent
})
