return {
  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    lazy = false,
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            jump_prev = "<Leader>pp",
            jump_next = "<Leader>nn",
            accept = "<Leader>aa",
            refresh = "<Leader>rr",
            open = "<Leader>oo",
          },
          layout = {
            position = "right",
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = false,
          keymap = {
            accept = "<S-Tab>",
            accept_word = false,
            accept_line = false,
          },
        },
        nes = {
          enabled = true,
          keymap = {
            accept_and_goto = "<leader>p",
            accept = "<C-y>",
            dismiss = "<Esc>",
          },
        },
        logger = {
          print_log_level = vim.log.levels.OFF,
        },
      })
    end,
  },

  {
    "copilotlsp-nvim/copilot-lsp",
    enabled = true,
    lazy = false,
    config = function()
      vim.g.copilot_nes_debounce = 500
    end,
  },

  -- Codeium
  {
    "Exafunction/windsurf.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
        enable_chat = true,
        enable_cmp_source = true,
        virtual_text = {
          enabled = true,
          filetypes = {
            dockerfile = true,
            javascript = true,
            json = true,
            markdown = true,
            python = true,
            rust = true,
            sql = true,
            toml = true,
            typescript = true,
            yaml = true,
          },
          default_filetype_enabled = true,
          idle_delay = 75,
          map_keys = true,
          key_bindings = {
            -- Accept the current completion.
            accept = "<S-Tab>",
            -- Accept the next word.
            accept_word = false,
            -- Accept the next line.
            accept_line = false,
            -- Clear the virtual text.
            clear = false,
            -- Cycle to the next completion.
            next = false,
            -- Cycle to the previous completion.
            prev = false,
          },
        },
      })
    end,
  },

  -- Codecompanion (for chatting with mistral)
  {
    "olimorris/codecompanion.nvim",
    enabled = true,
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      interactions = {
        chat = {
          adapter = "mistral",
        },
        inline = {
          adapter = "mistral",
        },
        cmd = {
          adapter = "mistral",
        },
        background = {
          adapter = "mistral",
        },
      },
    },
  },
}
