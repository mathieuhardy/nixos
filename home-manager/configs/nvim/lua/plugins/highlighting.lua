return {
  -- Highlight CSS colors
  {
    "catgoose/nvim-colorizer.lua",
    enabled = true,
    lazy = false,
    event = "BufReadPre",
    config = function()
      vim.o.termguicolors = true

      require("colorizer").setup({
        filetypes = { "*" }, -- Active pour tous les filetypes
        user_default_options = {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = true, -- "Name" codes like Blue or blue
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          AARRGGBB = true, -- 0xAARRGGBB hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = true, -- CSS hsl() and hsla() functions
          css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          mode = "background", -- Set the display mode (foreground, background, virtualtext)
          tailwind = true, -- Enable tailwind colors
          sass = { enable = true, parsers = { "css" } },
          virtualtext = "■",
          always_update = false,
        },
        buftypes = {},
      })
    end,
  },

  -- Markdown highlighting
  {
    "OXY2DEV/markview.nvim",
    enabled = true,
    lazy = false,
    opts = {
      experimental = {
        check_rtp = false,
      },
    },
  },

  -- Colors in help documentations
  {
    "OXY2DEV/helpview.nvim",
    enabled = true,
    lazy = false,
  },

  -- Highlight TODO comments
  {
    "folke/todo-comments.nvim",
    enabled = true,
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
}
