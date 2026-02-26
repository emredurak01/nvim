return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  { import = "nvchad.blink.lazyspec" },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "pyright",
        "black",
        "isort",
        "typescript-language-server",
        "clangd",
        "clang-format",
        "gopls",
        "rust-analyzer",
        "bash-language-server",
        "yaml-language-server",
        "json-lsp",
        "marksman",
      },
    },
  },

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
        "c",
        "cpp",
        "python",
        "go",
        "rust",
        "json",
        "yaml",
        "bash",
        "markdown",
        "markdown_inline",
      },
    },
  },

  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      { "<leader>dd", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics", icon = "󱖫" },
    },
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = { delay = 0 },
    config = function(_, opts)
      local wk = require "which-key"
      wk.setup(opts)

      wk.add {
        -- Group Icons
        { "<leader>g", group = "Git", icon = "󰊢" },
        { "<leader>f", group = "Find", icon = "󰈞" },
        { "<leader>t", group = "Themes", icon = "󱊖" },
        { "<leader>w", group = "Workspace", icon = "󰖯" },
        { "<leader>d", group = "Diagnostics", icon = "󱖫" },

        -- Direct Action Icons
        { "<leader>c", icon = "" },
        { "<leader>r", icon = "󰑐" },
        { "<leader>m", icon = "󰉼" },
        { "<leader>b", icon = "󰝒" },
        { "<leader>x", icon = "󰅖" },
        { "<leader>e", icon = "󰙅" },
        { "<leader>/", icon = "󰅺" },

        -- Force-hide the old groups
        { "<leader>d", hidden = true },
        { "<leader>ma", hidden = true },
      }
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
      explorer = { enabled = true },
      image = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      picker = {
        enabled = true,
        sources = {
          explorer = {
            layout = { preview = true },
          },
        },
      },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      select = { enabled = true },
    },
    keys = {
      {
        "<leader>e",
        function()
          Snacks.explorer()
        end,
        desc = "File Explorer",
      },
      {
        "<leader>ff",
        function()
          Snacks.picker.files()
        end,
        desc = "Find Files",
      },
      {
        "<leader>fw",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep Project",
      },
    },
  },

  {
    "nvzone/volt",
    lazy = true,
  },

  {
    "nvzone/floaterm",
    config = function()
      require("floaterm").setup()
    end,
    lazy = true,
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    opts = {},
  },

  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
  },
}
