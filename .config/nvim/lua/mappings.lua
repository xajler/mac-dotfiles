require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- nvim-tree: Visual selection marking support
local function mark_files_in_visual_selection(action) -- mode: "toggle" = 0, "mark_all" = 1, "disable_all_marks" = 2
  local api = require("nvim-tree.api")
  local view = require("nvim-tree.view")

  -- Check if nvim-tree is visible
  if not view.is_visible() then
    print("This function can only be run in nvim-tree.")
    return
  end

  -- Check if we are in visual line mode
  local mode = vim.api.nvim_get_mode().mode
  if mode ~= "V" then
    print("This function can only be run in visual line selection mode.")
    return
  end

  -- Get the nvim-tree window and buffer
  local winid = view.get_winnr()
  local bufnr = vim.api.nvim_win_get_buf(winid)

  -- Get the start and end lines BEFORE exiting visual mode
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")

  -- Ensure start_line is less than end_line
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  -- Exit Visual Mode (simulate pressing <Esc>)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)

  -- Switch to the nvim-tree window
  vim.api.nvim_set_current_win(winid)

  -- Validate the selection boundaries
  local last_line = vim.api.nvim_buf_line_count(bufnr)
  start_line = math.max(1, math.min(start_line, last_line))
  end_line = math.max(1, math.min(end_line, last_line))

  -- Iterate over the selected lines
  local marked_count = 0
  for i = start_line, end_line do
    vim.api.nvim_win_set_cursor(winid, { i, 0 })
    local node = api.tree.get_node_under_cursor()
    if node and node.absolute_path then
      if action == 0 then
        api.marks.toggle(node)
        marked_count = marked_count + 1
      elseif action == 1 then
        if not api.marks.get(node) then
          api.marks.toggle(node)
          marked_count = marked_count + 1
        end
      elseif action == 2 then
        if api.marks.get(node) then
          api.marks.toggle(node)
          marked_count = marked_count + 1
        end
      end
    end
  end

  -- Refresh the tree to update marks display
  api.tree.reload()
end

-- Map the function to keybindings in visual mode
map("x", "<leader>mt", function()
  mark_files_in_visual_selection(0)
end, { desc = "Toggle markings in visual selection" })

map("x", "<leader>ma", function()
  mark_files_in_visual_selection(1)
end, { desc = "Add markings in visual selection" })

map("x", "<leader>md", function()
  mark_files_in_visual_selection(2)
end, { desc = "Delete markings in visual selection" })

map("x", "m", function()
  mark_files_in_visual_selection(0)
end, { desc = "Mark files in visual selection" })
