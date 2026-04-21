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
        -- Lua --
        "lua-language-server",
        "stylua",
        "luacheck",

        -- Web (HTML / CSS / JS / TS) --
        "html-lsp",
        "css-lsp",
        "typescript-language-server",
        "eslint-lsp",
        "prettier",

        -- Python --
        "pyright",
        "ruff",

        -- C / C++ --
        "clangd",
        "clang-format",

        -- Go --
        "gopls",
        "golangci-lint",

        -- Rust --
        "rust-analyzer",

        -- Shell --
        "bash-language-server",
        "shellcheck",
        "shfmt",

        -- Data formats --
        "yaml-language-server",
        "yamllint",
        "json-lsp",
        "taplo",

        -- Markdown --
        "marksman",
        "markdownlint-cli2",

        -- Graphql --
        "graphql-language-service-cli",
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
    opts = {
      focus = true,
    },
    cmd = "Trouble",
    keys = {
      { "<leader>d", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
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
        { "<leader>s", group = "Split", icon = "󱂬" },
        { "<leader>r", group = "Replace", icon = "󰑐" },
        { "<leader>c", group = "Code", icon = "" },

        -- Sub Group Icons
        { "<leader>sv", desc = "Split Vertical", icon = "" },
        { "<leader>sh", desc = "Split Horizontal", icon = "" },

        -- Code Icons
        { "<leader>cv", desc = "Manage venv", icon = "" },
        { "<leader>ca", desc = "Code action", icon = "󱐋" },

        -- Diff
        { "<leader>gd", desc = "Diff explorer", icon = "" },
        { "<leader>gD", desc = "Diff current file", icon = "" },
        { "<leader>gy", desc = "Diff history", icon = "󰋚" },

        -- Direct Action Icons
        { "<leader>m", desc = "Format", icon = "󰉼" },
        { "<leader>b", desc = "New buffer", icon = "󰝒" },
        { "<leader>x", desc = "Close buffer", icon = "󰅖" },
        { "<leader>e", desc = "Explorer", icon = "󰙅" },
        { "<leader>/", desc = "Comment", icon = "󰅺" },
        { "<leader>d", desc = "Diagnostics", icon = "󱖫" },
        { "<leader>p", desc = "Pick window", icon = "󰆟" },

        -- Force-hide the old groups
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
            {
              icon = "󰦛",
              key = "s",
              desc = "Restore session",
              action = function()
                local persistence = require "persistence"
                if vim.fn.filereadable(persistence.current()) == 0 then
                  vim.notify("No session found for this directory", vim.log.levels.WARN, { title = "Persistence" })
                else
                  persistence.load()
                end
              end,
            },
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
      notifier = {
        enabled = true,
        filter = (function()
          local seen = {}
          return function(notif)
            local key = notif.msg
            local now = vim.uv.now()
            if seen[key] and (now - seen[key]) < 2000 then
              return false -- suppress duplicate within 2 seconds
            end
            seen[key] = now
            return true
          end
        end)(),
      },
      picker = {
        enabled = true,
        win = {
          input = {
            keys = {
              ["<C-l>"] = { "focus_preview", mode = { "i", "n" } },
              ["<C-j>"] = { "list_down", mode = { "i", "n" } },
              ["<C-k>"] = { "list_up", mode = { "i", "n" } },
            },
          },
          list = {
            keys = {
              ["<C-j>"] = { "list_down", mode = { "n" } },
              ["<C-k>"] = { "list_up", mode = { "n" } },
            },
          },
          preview = {
            minimal = false,
            keys = {
              ["<C-h>"] = { "focus_list", mode = { "n" } },
              ["<C-j>"] = { "preview_scroll_down", mode = { "n" } },
              ["<C-k>"] = { "preview_scroll_up", mode = { "n" } },
            },
          },
        },
        sources = {
          files = { frecency = true },
          recent = { frecency = true },
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
    "MagicDuck/grug-far.nvim",
    config = function()
      require("grug-far").setup {}
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "folke/snacks.nvim",
    },
    ft = "python",
    cmd = "VenvSelect",
    opts = {
      settings = {
        options = {
          notify_user_on_venv_change = true,
        },
      },
    },
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" },
    },
  },

  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "folke/snacks.nvim" },
    },
    event = "LspAttach",
    opts = {
      backend = "vim",
      picker = "snacks",
    },
  },

  {
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
    opts = {
      diff = {
        layout = "side-by-side",
        jump_to_first_change = true,
        cycle_next_hunk = true,
      },
      keymaps = {
        view = {
          toggle_explorer = "<Tab>",
          focus_explorer = "ge",
        },
      },
    },
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
  },
}
