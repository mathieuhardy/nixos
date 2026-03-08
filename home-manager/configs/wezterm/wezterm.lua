local wezterm = require("wezterm")
local config = wezterm.config_builder()

local current_theme = 1

--------------------------------------------------------------------------------
-- General
--------------------------------------------------------------------------------

config.automatically_reload_config = true

config.initial_cols = 120
config.initial_rows = 40
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

config.enable_tab_bar = true
config.enable_scroll_bar = true

config.font = wezterm.font_with_fallback({
  "CommitMono Nerd Font",
  "Noto Color Emoji",
})
config.font_size = 9.5
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

config.audible_bell = "Disabled"

config.default_cursor_style = "SteadyBlock"
config.cursor_blink_rate = 0

config.scrollback_lines = 1000000

--------------------------------------------------------------------------------
-- Theme(s)
--------------------------------------------------------------------------------

local themes = {
  -- Catppuccin
  "Catppuccin Frappe",
  "Catppuccin Macchiato",
  "Catppuccin Mocha",

  -- Greyish themes
  "Monokai Pro (Gogh)",
}

config.color_scheme = themes[current_theme]
config.colors = {}

--------------------------------------------------------------------------------
-- Tabbar
--------------------------------------------------------------------------------

local scheme = wezterm.color.get_builtin_schemes()[config.color_scheme]

config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.window_frame = { font_size = 9 }
config.show_tab_index_in_tab_bar = false
-- config.show_close_tab_button_in_tabs = false

config.colors.tab_bar = {
  background = scheme.background,

  active_tab = {
    bg_color = scheme.ansi[5],
    fg_color = scheme.background,
  },

  inactive_tab = {
    bg_color = scheme.background,
    fg_color = scheme.foreground,
  },

  inactive_tab_hover = {
    bg_color = "#f8f8f8",
    fg_color = "#272727",
  },

  new_tab = {
    bg_color = scheme.background,
    fg_color = scheme.ansi[5],
  },

  new_tab_hover = {
    bg_color = "#f8f8f8",
    fg_color = "#272727",
  },
}

--------------------------------------------------------------------------------
-- Scrollbar
--------------------------------------------------------------------------------

config.colors.scrollbar_thumb = "#666666"

--------------------------------------------------------------------------------
-- Keybindings
--------------------------------------------------------------------------------

config.disable_default_key_bindings = true

config.keys = {
  -- Copy/Paste
  {
    key = "c",
    mods = "CTRL|SHIFT",
    action = wezterm.action.CopyTo("Clipboard"),
  },
  {
    key = "v",
    mods = "CTRL|SHIFT",
    action = wezterm.action.PasteFrom("Clipboard"),
  },
  -- Font size
  {
    key = "-",
    mods = "CTRL|SHIFT",
    action = wezterm.action.DecreaseFontSize,
  },
  {
    key = "=",
    mods = "CTRL|SHIFT",
    action = wezterm.action.IncreaseFontSize,
  },
  {
    key = "+",
    mods = "CTRL|SHIFT",
    action = wezterm.action.IncreaseFontSize,
  },
  {
    key = "0",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ResetFontSize,
  },
  -- Tabs
  {
    key = "t",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },
  {
    key = "w",
    mods = "CTRL|SHIFT",
    action = wezterm.action.CloseCurrentTab({ confirm = true }),
  },
  {
    key = "Tab",
    mods = "CTRL",
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    key = "Tab",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ActivateTabRelative(-1),
  },
  -- New window
  {
    key = "n",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SpawnWindow,
  },
  -- Search
  {
    key = "f",
    mods = "CTRL|SHIFT",
    action = wezterm.action.Search({ CaseInSensitiveString = "" }),
  },
  -- Configuration
  {
    key = "r",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ReloadConfiguration,
  },
  -- Clear
  {
    key = "g",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ResetTerminal,
  },
  -- Splits
  {
    key = "F3",
    mods = "SUPER",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "F4",
    mods = "SUPER",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  -- Custom
  {
    key = "s",
    mods = "CTRL|SHIFT",
    action = wezterm.action.EmitEvent("toggle_theme"),
  },
  -- Rename tabs
  {
    key = "r",
    mods = "CTRL|SHIFT",
    action = wezterm.action.PromptInputLine({
      description = "Enter new name for tab",
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },
}

--------------------------------------------------------------------------------
-- Events
--------------------------------------------------------------------------------

wezterm.on("toggle_theme", function(window, pane)
  local overrides = window:get_config_overrides() or {}

  -- Theme
  if current_theme == #themes then
    current_theme = 1
  else
    current_theme = current_theme + 1
  end

  overrides.color_scheme = themes[current_theme]

  -- Tabbar
  local scheme = wezterm.color.get_builtin_schemes()[overrides.color_scheme]

  overrides.colors = {
    tab_bar = {
      background = scheme.background,

      active_tab = {
        bg_color = scheme.ansi[5],
        fg_color = scheme.background,
      },

      inactive_tab = {
        bg_color = scheme.background,
        fg_color = scheme.foreground,
      },

      inactive_tab_hover = {
        bg_color = "#f8f8f8",
        fg_color = "#272727",
      },

      new_tab = {
        bg_color = scheme.background,
        fg_color = scheme.ansi[5],
      },

      new_tab_hover = {
        bg_color = "#f8f8f8",
        fg_color = "#272727",
      },
    },

    scrollbar_thumb = config.colors.scrollbar_thumb,
  }

  -- Apply
  window:set_config_overrides(overrides)
end)

return config
