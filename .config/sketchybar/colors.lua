return {
  black = 0xff181819,
  white = 0xffe2e2e3,
  red = 0xfffc5d7c,
  green = 0xff9ed072,
  blue = 0xff76cce0,
  yellow = 0xffe7c664,
  orange = 0xfff39660,
  magenta = 0xffb39df3,
  grey = 0xff7f8490,
  transparent = 0x00000000,

  bar = {
    bg = 0xf00f1419,
    border = 0xff0f1419,
  },
  popup = {
    bg = 0xc02c2e34,
    border = 0xff7f8490
  },
  bg1 = 0xff363944,
  bg2 = 0xff414550,
  bg3 = 0xff2c2e34,  -- Workspace background

  -- Pastel colors for workspaces (when active) - background
  workspace_colors = {
    [1] = 0xffe3b8b8,  -- Pastel red
    [2] = 0xffd4b8e3,  -- Pastel purple
    [3] = 0xffb8d4d4,  -- Pastel teal (replaced pink)
    [4] = 0xffe3d4b8,  -- Pastel yellow
    [5] = 0xffd4e3b8,  -- Pastel green
    [6] = 0xffb8e3d4,  -- Pastel mint
    [7] = 0xffb8e3c4,  -- Pastel seafoam
    [8] = 0xffc4e3b8,  -- Pastel lime
    [9] = 0xffe3c4b8,  -- Pastel peach
    [10] = 0xffd4c4e3, -- Pastel lavender
  },

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}
