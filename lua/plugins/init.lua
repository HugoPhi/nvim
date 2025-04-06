return {
  {
    "voldikss/vim-floaterm", -- nvim-floaterm 插件地址
    lazy = false,
    config = function()
      vim.g.floaterm_borderchars = { "", "", "", "", "", "", "", "" }
      vim.g.floaterm_width = 0.8 -- 设置浮窗宽度为 80%
      vim.g.floaterm_height = 0.8 -- 设置浮窗高度为 80%
      vim.g.floaterm_position = "center" -- 设置浮窗位置为中心
    end,
  },

  {
    "Exafunction/codeium.vim",
    lazy = false,
    config = function()
      vim.g.codeium_enabled = true
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup(require "../configs/auto-mason")
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    lazy = false,
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    opts = {},
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.g.mkdp_browser = "firefox"
      vim.g.mkdp_theme = "light"
      vim.g.mkdp_auto_close = 1
      -- vim.g.mkdp_markdown_css = '/home/tibless/.config/Typora/themes/hugo.css'
    end,
  },

  { -- Code Window
    "gorbit99/codewindow.nvim",
    lazy = false,
    enabled = true,
    config = function()
      local codewindow = require "codewindow"
      codewindow.setup {
        auto_enable = false,
        show_cursor = false,
        side = "right",
        screen_bounds = "lines", -- lines, background
        window_border = "none", -- none, single, double
      }
      codewindow.apply_default_keybinds()
    end,
  },

  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    show_guides = true,
    lazy = false,
    config = function()
      require("symbols-outline").setup {
        position = "right",
        width = 45,
        auto_close = false,
      }
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",

    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowBlue",
        "RainbowYellow",
        "RainbowGreen",
        "RainbowOrange",
        "RainbowCyan",
        "RainbowViolet",
      }

      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      end)

      require("ibl").setup { indent = { highlight = highlight } }
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup(require "../configs/nvtree")
    end,
  },

  {
    "goolord/alpha-nvim",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local dashboard = require "alpha.themes.dashboard"
      local config = require("../configs/dashconfigs").dashconfigs.default
      local applyColors = require("../configs/dashconfigs").applyColors

      -- Buttons
      dashboard.section.buttons.val = {
        dashboard.button("Space f f", "  Find File", ":Telescope find_files<CR>"),
        dashboard.button("Space f o", "  Recent Files", ":Telescope oldfiles<CR>"),
        dashboard.button("Space t h", "󱥚  Themes", ":lua require('nvchad.themes').open()<CR>"),
        dashboard.button("Space c h", "  Mappings", ":NvCheatsheet<CR>"),
        dashboard.button("n", "  New file", ":ene<CR>"),
      }

      -- Footer
      local stats = require("lazy").stats()
      local ms = math.floor(stats.startuptime) .. " ms"
      dashboard.section.footer.val = {
        "",
        "",
        "--------------------------------------------------",
        "          Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms,
        "--------------------------------------------------",
      }

      -- Header
      require("alpha").setup(applyColors(config.logo, config.colors, config.logoColors))
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }, -- telescope 依赖 plenary.nvim
    config = function()
      require("telescope").setup {
        defaults = {
          -- 搜索结果逆序显示
          sorting_strategy = "ascending",

          -- 布局配置
          layout_config = {
            width = 0.9, -- 总宽度为 90%
            height = 0.9, -- 总高度为 90%
            prompt_position = "top", -- 提示符位置在顶部
            preview_width = 0.6, -- 预览框宽度为 60%
            preview_cutoff = 30, -- 最小预览宽度为 40 列
          },

          -- 禁用边框（可选）
          borderchars = { "", "", "", "", "", "", "", "" },
        },
      }
    end,
  },
}
