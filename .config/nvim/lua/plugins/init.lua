return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- nvim-tree configuration
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      filters = {
        git_ignored = true,
        custom = { ".DS_Store", ".git" },
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")

        -- Default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- Custom bulk operation keybindings
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        vim.keymap.set("n", "bd", api.marks.bulk.delete, opts("Bulk Delete (permanent)"))
        vim.keymap.set("n", "bt", api.marks.bulk.trash, opts("Bulk Trash (to system trash)"))
        vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("Bulk Move"))
      end,
    },
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- JSON schemas for better JSON/YAML support
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "python",
        "json",
        "yaml",
        "markdown",
        "markdown_inline",
      },
    },
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
}
