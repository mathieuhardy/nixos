return {
  -- Filesystem explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = true,
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        enable_git_status = false,
        enable_diagnostics = false,
        sources = {
          "filesystem",
          "buffers",
        },
        filesystem = {
          follow_current_file = {
            enabled = false,
          },
          filtered_items = {
            visible = true,
          },
          filtered_items = {
            hide_hidden = true,
          },
        },
        window = {
          mappings = {
            ["<LeftMouse>"] = { "left_mouse_hook" },
            ["t"] = "toggle_node",
            ["<Right>"] = "open",
            ["p"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
            ["<F3>"] = "open_split",
            ["s"] = "",
            ["<F4>"] = "open_vsplit",
            ["S"] = "",
            ["D"] = "delete",
            ["d"] = "",
            ["R"] = "rename",
            ["B"] = "rename_basename",
            ["b"] = "",
            ["Y"] = "copy_to_clipboard",
            ["y"] = "",
            ["X"] = "cut_to_clipboard",
            ["x"] = "",
            ["P"] = "paste_from_clipboard",
            ["p"] = "",
            ["C"] = "copy",
            ["c"] = "",
            ["M"] = "move",
            ["m"] = "",
            ["Q"] = "close_window",
            ["q"] = "",
            ["r"] = "refresh",
          },
        },
        commands = {
          -- Hook function for left click: run the left click then toggle the node
          left_mouse_hook = function(state)
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<LeftMouse>", true, false, true), "n", false)

            vim.api.nvim_input("t")
          end,
        },
      })
    end,
  },

  -- Terminal
  {
    "numToStr/FTerm.nvim",
    enabled = true,
    lazy = false,
  },

  -- Symbols jump
  {
    "pechorin/any-jump.vim",
    enabled = true,
    lazy = false,
    init = function()
      vim.g.any_jump_list_numbers = 0
      vim.g.any_jump_grouping_enabled = 1
      vim.g.any_jump_window_width_ratio = 0.9
      vim.g.any_jump_window_height_ratio = 0.9
      vim.g.any_jump_window_top_offset = 1
      vim.g.any_jump_colors = {
        plain_text = "String",
        preview = "Comment",
        preview_keyword = "Comment",
        heading_text = "Comment",
        heading_keyword = "Comment",
        group_text = "Type",
        group_name = "Type",
        more_button = "Identifier",
        more_explain = "Identifier",
        result_line_number = "Function",
        result_text = "Normal",
        result_path = "Normal",
        help = "String",
      }
    end,
  },

  -- Startup menu
  {
    "goolord/alpha-nvim",
    enabled = true,
    lazy = false,
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      local alpha = require("alpha")
      local startify = require("alpha.themes.startify")
      local section = startify.section
      local config = startify.config
      local sessions_dir = vim.fn.stdpath("config") .. "/sessions"

      section.header.val = {
        [[ ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓]],
        [[ ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒]],
        [[▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░]],
        [[▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ ]],
        [[▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒]],
        [[░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░]],
        [[░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░]],
        [[   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   ]],
        [[         ░    ░  ░    ░ ░        ░   ░         ░   ]],
        [[                                ░                  ]],
      }

      -- Top buttons
      section.top_buttons.val = {
        startify.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
      }

      -- Bottom buttons
      section.bottom_buttons.val = {
        startify.button("q", "🗙 Quit", ":qa<CR>"),
      }

      -- Sessions
      function add_session(sessions, session, index)
        local name = vim.fn.substitute(session.name, sessions_dir .. "/", "", "")
        local name = vim.fn.substitute(name, ".lua", "", "")

        if name ~= nil and name ~= "" then
          local cmd = "<CMD>cd " .. session.path .. "<CR><CMD>Neotree<CR>"
          sessions[index] = startify.button(tostring(index), name, cmd)
        end
      end

      local sessions = {}

      if global_opts.sessions then
        for i, session in pairs(global_opts.sessions) do
          add_session(sessions, session, i)
        end
      end

      section.sessions = {
        type = "group",
        val = sessions,
      }

      -- Layout
      config.layout =
        {
          { type = "padding", val = 1 },
          section.header,
          { type = "padding", val = 2 },
          section.top_buttons,
          { type = "padding", val = 1 },
          section.bottom_buttons,
          { type = "padding", val = 2 },
          section.sessions,
          section.footer,
        }, alpha.setup(config)
    end,
  },

  -- Popup menu for keymaps
  {
    "javiorfo/nvim-popcorn",
    enabled = true,
    lazy = false,
  },

  -- Notes
  {
    "vimwiki/vimwiki",
    enabled = true,
    lazy = false,
    init = function()
      vim.g.vimwiki_list = {
        {
          path = vim.fn.stdpath("config") .. "/notes",
          syntax = "default",
          ext = ".wiki",
        },
      }

      vim.g.vimwiki_global_ext = 0
    end,
  },

  -- Color picker
  {
    "nvzone/volt",
    enabled = true,
    lazy = true,
  },

  {
    "nvzone/minty",
    enabled = true,
    lazy = false,
    cmd = { "Shades", "Huefy" },
  },
}
