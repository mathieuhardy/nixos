return {
  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    enabled = true,
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      options = {
        icons_enabled = false,
        component_separators = {
          left = "|",
          right = "|",
        },
        section_separators = {
          left = "",
          right = "",
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "diagnostics", { "lsp_status", color = { fg = "#272727", bg = "#87af87" } } },
        lualine_y = {
          {
            get_current_suggestions_backend,
            color = { fg = "#272727", bg = "#ffb86a" },
            on_click = toggle_ai_suggestions_backend,
          },
        },
        lualine_z = {
          "encoding",
          "filetype",
          "location",
        },
      },
    },
  },

  -- Scrollbar
  {
    "dstein64/nvim-scrollview",
    enabled = true,
    lazy = false,
    config = function()
      vim.g.scrollview_signs_on_startup = {}
    end,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = true,
    lazy = false,
    main = "ibl",
    opts = {
      scope = {
        show_start = false,
        show_end = false,
        highlight = { "Function" },
      },
      indent = {
        char = "┊",
      },
      whitespace = {
        remove_blankline_trail = false,
      },
    },
  },

  -- Distraction free mode
  {
    "mathieuhardy/zen-mode.nvim",
    enabled = true,
    lazy = false,
    opts = {
      window = {
        options = {
          signcolumn = "no",
          number = false,
          relativenumber = false,
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = "0",
          list = false,
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
          laststatus = 0,
        },
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux = { enabled = false },
        todo = { enabled = false },
      },
    },
  },

  -- Limited view
  {
    "junegunn/limelight.vim",
    enabled = true,
    lazy = false,
  },

  -- Highlight word under cursor
  {
    "itchyny/vim-cursorword",
    enabled = true,
    lazy = false,
  },

  -- Buffers bar
  {
    "crispgm/nvim-tabline",
    enabled = true,
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      show_index = false,
      show_modify = true,
      show_icon = true,
      modify_indicator = "~",
      brackets = { "", "" },
      inactive_tab_max_length = 0,
    },
  },

  -- Close buffers
  {
    "kazhala/close-buffers.nvim",
    enabled = true,
    lazy = false,
  },

  -- Navigate through buffers and resize buffers
  {
    "mrjones2014/smart-splits.nvim",
    enabled = true,
    lazy = false,
  },
}
