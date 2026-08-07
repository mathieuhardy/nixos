-- ~/.config/hypr/hyprland.lua
--
-- Hyprland Lua configuration
-- Migrated from the legacy hyprland.conf format.
--
-- Documentation:
-- https://wiki.hypr.land/Configuring/Start/

local mod = "SUPER"

-- ─────────────────────────────────────────────────────────────────────────────
-- Global configuration
-- ─────────────────────────────────────────────────────────────────────────────

hl.config({
  -- No fucking animation
  animations = {
    enabled = false,
  },

  general = {
    -- Spacing
    gaps_in = 3,
    gaps_out = 5,

    -- Border
    border_size = 3,
    ["col.active_border"] = "rgb(ca9ee6)",

    -- Resize icon on border
    resize_on_border = true,
    hover_icon_on_border = true,

    -- Window snapping
    snap = {
      enabled = true,
      respect_gaps = true,
    },
  },

  decoration = {
    rounding = 2,

    shadow = {
      enabled = false,
    },
  },

  misc = {
    disable_splash_rendering = true,
    disable_hyprland_logo = true,
    disable_autoreload = true,
    mouse_move_focuses_monitor = false,
  },

  input = {
    -- AZERTY keyboard
    kb_layout = "fr",
    kb_variant = "azerty",

    -- Numlock enabled at boot
    numlock_by_default = true,

    -- Focus does not follow mouse automatically
    follow_mouse = 2,

    touchpad = {
      disable_while_typing = true,
      natural_scroll = false,
      tap_to_click = true,
    },
  },
})

-- ─────────────────────────────────────────────────────────────────────────────
-- Monitors
-- ─────────────────────────────────────────────────────────────────────────────

-- Let hyprmonitors handle the actual monitor configuration.
-- Disable ghost monitor.
hl.monitor({
  output = "WAYLAND-1",
  disable = true,
})

-- ─────────────────────────────────────────────────────────────────────────────
-- Startup
-- ─────────────────────────────────────────────────────────────────────────────

hl.on("hyprland.start", function()
  hl.exec_cmd("hyprmonitors")
end)

-- ─────────────────────────────────────────────────────────────────────────────
-- Helpers
-- ─────────────────────────────────────────────────────────────────────────────

local function exec(command)
  return hl.dsp.exec_cmd(command)
end

local function bind(keys, dispatcher)
  hl.bind(keys, dispatcher)
end

local function workspace_bind(key, workspace)
  bind(mod .. " + " .. key, hl.dsp.workspace(workspace))
end

local function move_workspace_bind(key, workspace)
  bind(
    mod .. " + ALT + " .. key,
    hl.dsp.window.move({
      workspace = workspace,
      follow = false,
    })
  )
end

-- ─────────────────────────────────────────────────────────────────────────────
-- Applications
-- ─────────────────────────────────────────────────────────────────────────────

-- Terminal
bind(mod .. " + T", exec("wezterm"))

bind(mod .. " + Return", exec('alacritty --class "alacritty-floating"'))

-- File manager
bind(mod .. " + E", exec("thunar"))

-- Notes
bind(mod .. " + N", exec("alacritty --class tb -e tb"))

-- Calculator
bind(mod .. " + C", exec("speedcrunch"))

-- Emoji picker
bind(mod .. " + J", exec("vicinae vicinae://extensions/vicinae/vicinae/search-emojis"))

-- App launcher
bind(mod .. " + P", exec("~/.config/rofi/scripts/launcher.sh"))

-- Vivaldi
bind(mod .. " + V", exec("vivaldi"))

-- WiFi manager
bind(mod .. " + W", exec("alacritty --class impala -e impala"))

-- Screenshot
bind("Print", exec("~/.config/rofi/scripts/screenshot.sh"))

-- ─────────────────────────────────────────────────────────────────────────────
-- Session
-- ─────────────────────────────────────────────────────────────────────────────

bind("CTRL + ALT + Delete", hl.dsp.exit())

bind("ALT + F4", hl.dsp.window.kill())

bind(
  "ALT + Return",
  hl.dsp.window.fullscreen({
    mode = "fullscreen",
    action = "set",
  })
)

-- Toggle floating, resize to 50%, center
bind(mod .. " + F", function()
  hl.dispatch(hl.dsp.window.float({
    action = "toggle",
  }))

  hl.exec_cmd("sleep 0.05 && hyprctl dispatch resizeactive exact 50% 50% && hyprctl dispatch centerwindow")
end)

-- ─────────────────────────────────────────────────────────────────────────────
-- Window switcher
-- ─────────────────────────────────────────────────────────────────────────────

bind("ALT + Tab", hl.dsp.window.cycle_next())

bind(
  "ALT + SHIFT + Tab",
  hl.dsp.window.cycle_next({
    next = false,
  })
)

-- ─────────────────────────────────────────────────────────────────────────────
-- Window movement
-- ─────────────────────────────────────────────────────────────────────────────

bind("ALT + left", hl.dsp.window.move({ direction = "l" }))

bind("ALT + right", hl.dsp.window.move({ direction = "r" }))

bind("ALT + up", hl.dsp.window.move({ direction = "u" }))

bind("ALT + down", hl.dsp.window.move({ direction = "d" }))

-- Mouse drag
hl.bindm("ALT", "mouse:272", hl.dsp.window.move())

-- ─────────────────────────────────────────────────────────────────────────────
-- Power menu
-- ─────────────────────────────────────────────────────────────────────────────

bind(mod .. " + Escape", exec("~/.config/rofi/scripts/powermenu.sh"))

bind("ALT + Escape", exec("~/.config/rofi/scripts/powermenu.sh"))

-- ─────────────────────────────────────────────────────────────────────────────
-- Workspace navigation
-- ─────────────────────────────────────────────────────────────────────────────

bind(mod .. " + Right", exec("workspace-navigation 10 next"))

bind(mod .. " + Left", exec("workspace-navigation 10 prev"))

-- ─────────────────────────────────────────────────────────────────────────────
-- Workspace selection
-- ─────────────────────────────────────────────────────────────────────────────

local workspace_keys = {
  "KP_End",
  "KP_Down",
  "KP_Next",
  "KP_Left",
  "KP_Begin",
  "KP_Right",
  "KP_Home",
  "KP_Up",
  "KP_Prior",
  "KP_Insert",
}

for workspace, key in ipairs(workspace_keys) do
  workspace_bind(key, workspace)
end

-- AZERTY number row
local azerty_workspace_keys = {
  "ampersand",
  "eacute",
  "quotedbl",
  "apostrophe",
  "parenleft",
  "minus",
  "egrave",
  "underscore",
  "ccedilla",
  "agrave",
}

for workspace, key in ipairs(azerty_workspace_keys) do
  workspace_bind(key, workspace)
end

-- ─────────────────────────────────────────────────────────────────────────────
-- Move current window to workspace
-- ─────────────────────────────────────────────────────────────────────────────

for workspace, key in ipairs(workspace_keys) do
  move_workspace_bind(key, workspace)
end

for workspace, key in ipairs(azerty_workspace_keys) do
  move_workspace_bind(key, workspace)
end

-- ─────────────────────────────────────────────────────────────────────────────
-- Session locking
-- ─────────────────────────────────────────────────────────────────────────────

bind(mod .. " + L", exec("hyprlock"))

-- ─────────────────────────────────────────────────────────────────────────────
-- Laptop lid
-- ─────────────────────────────────────────────────────────────────────────────

bind("switch:on:Lid Switch", exec("hyprmonitors"))

bind("switch:off:Lid Switch", exec("hyprmonitors"))

-- ─────────────────────────────────────────────────────────────────────────────
-- Brightness
-- ─────────────────────────────────────────────────────────────────────────────

bind("XF86MonBrightnessUp", exec("brightnessctl set 5%+"))

bind("XF86MonBrightnessDown", exec("brightnessctl set 5%-"))

-- ─────────────────────────────────────────────────────────────────────────────
-- Volume
-- ─────────────────────────────────────────────────────────────────────────────

bind("XF86AudioRaiseVolume", exec("swayosd-client --output-volume raise"))

bind("XF86AudioLowerVolume", exec("swayosd-client --output-volume lower"))

bind("XF86AudioMute", exec("swayosd-client --output-volume mute-toggle"))

-- ─────────────────────────────────────────────────────────────────────────────
-- Media playback
-- ─────────────────────────────────────────────────────────────────────────────

bind("XF86AudioPlay", exec("playerctl play-pause"))

bind("XF86AudioStop", exec("playerctl stop"))

bind("XF86AudioNext", exec("playerctl next"))

bind("XF86AudioPrev", exec("playerctl previous"))

-- ─────────────────────────────────────────────────────────────────────────────
-- Display configuration
-- ─────────────────────────────────────────────────────────────────────────────

bind("XF86Display", exec("alacritty --class hyprmonitors -e hyprmonitors-tui"))

-- ─────────────────────────────────────────────────────────────────────────────
-- WiFi toggle
-- ─────────────────────────────────────────────────────────────────────────────

bind("XF86WLAN", exec("nmcli radio wifi $(nmcli radio wifi | grep -q enabled && echo off || echo on)"))

-- ─────────────────────────────────────────────────────────────────────────────
-- Lock indicators
-- ─────────────────────────────────────────────────────────────────────────────

bind("Caps_Lock", exec("swayosd-client --caps-lock"))

bind("Num_Lock", exec("swayosd-client --num-lock"))

-- ─────────────────────────────────────────────────────────────────────────────
-- Hidden workspace
-- ─────────────────────────────────────────────────────────────────────────────

bind(mod .. " + H", hl.dsp.workspace.toggle_special("hidden"))

bind(
  mod .. " + ALT + H",
  hl.dsp.window.move({
    workspace = "special:hidden",
    follow = false,
  })
)

-- ─────────────────────────────────────────────────────────────────────────────
-- Floating window rules
-- ─────────────────────────────────────────────────────────────────────────────

local function window_rule(match, effects)
  effects.match = match
  hl.window_rule(effects)
end

-- Hyprmonitors
window_rule({ class = "hyprmonitors" }, {
  float = true,
  center = true,
  size = { "monitor_w * 0.5", "monitor_h * 0.6" },
})

-- Bluetooth manager
window_rule({ class = ".*blueman-manager.*" }, {
  float = true,
  center = true,
  size = { 600, 400 },
})

-- Network connection editor
window_rule({ class = "nm-connection-editor" }, {
  float = true,
  center = true,
  size = { 800, 600 },
})

-- Audio control
window_rule({ class = ".*pwvucontrol.*" }, {
  float = true,
  center = true,
  size = { 1000, 600 },
})

-- Calendar
window_rule({ class = "gsimplecal" }, {
  float = true,
  move = { "monitor_w - window_w - 5", 40 },
})

-- Bitwarden popup in browser
window_rule({
  class = ".*(vivaldi|firefox).*",
  title = "Bitwarden.*",
}, {
  float = true,
})

-- Calculator
window_rule({ class = "org.gnome.Calculator" }, {
  float = true,
  size = { 500, 250 },
})

-- File manager
window_rule({ class = ".*hunar.*" }, {
  float = true,
})

-- File picker
window_rule({ class = "xdg-desktop-portal-gtk" }, {
  float = true,
  size = { "monitor_w * 0.4", "monitor_h * 0.5" },
})

-- Floating terminal
window_rule({ class = "floating-term" }, {
  float = true,
  size = { "monitor_w * 0.6", "monitor_h * 0.6" },
})

-- Bluetui
window_rule({ class = "bluetui" }, {
  float = true,
  size = { 600, 500 },
})

-- Network manager TUI
window_rule({ class = "nmtui" }, {
  float = true,
  size = { 800, 700 },
})

-- WiFi
window_rule({ class = "impala" }, {
  float = true,
  size = { 800, 600 },
})

-- Disk analyzer
window_rule({ class = "diskard" }, {
  float = true,
  size = { 1000, 800 },
})

-- Meld
window_rule({ class = ".*Meld.*" }, {
  float = true,
  size = { "monitor_w * 0.5", "monitor_h * 0.5" },
})

-- Steam
window_rule({ class = "steam" }, {
  float = true,
  size = { "monitor_w * 0.5", "monitor_h * 0.5" },
})

-- GParted
window_rule({ class = "GParted" }, {
  float = true,
  size = { "monitor_w * 0.4", "monitor_h * 0.5" },
})

-- Global floating rule
window_rule({ class = ".*-floating.*" }, {
  float = true,
})

-- Image viewer
window_rule({ class = "swayimg" }, {
  float = true,
})

-- Video player
window_rule({ class = "mpv" }, {
  float = true,
})

-- ProtonVPN
window_rule({ class = ".*protonvpn.*" }, {
  float = true,
  size = { 200, 200 },
})

-- Eloquent
window_rule({ class = "re.sonny.Eloquent" }, {
  float = true,
  size = { 700, 600 },
})

-- SpeedCrunch
window_rule({ class = ".*speedcrunch.*" }, {
  float = true,
  size = { 200, 500 },
})

-- Timer
window_rule({ class = ".*timr-tui.*" }, {
  float = true,
  size = { 600, 500 },
})

-- Notes
window_rule({ class = "tb" }, {
  float = true,
  size = { 700, 700 },
})

-- Hidden workspace border
window_rule({ workspace = "special:hidden" }, {
  border_color = "rgb(e7c664)",
})

-- Foliate
window_rule({ class = "com.github.johnfactotum.Foliate" }, {
  float = true,
  size = { 900, 900 },
})

-- PirateCtl / Bittorrent
window_rule({ class = "pirate-ctl" }, {
  float = true,
  size = { "monitor_w * 0.5", "monitor_h * 0.5" },
})
