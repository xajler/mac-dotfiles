require "nvchad.autocmds"

-- Auto-open NvimTree when starting nvim without arguments
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Only open if no files were specified
    if vim.fn.argc() == 0 then
      -- Defer execution to ensure NvimTree is loaded
      vim.schedule(function()
        require("nvim-tree.api").tree.open()
      end)
    end
  end,
})
