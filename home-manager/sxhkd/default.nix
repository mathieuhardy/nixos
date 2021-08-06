{ config, lib, ... }:

let
  defaults = {
    # Split modes
    "super + {F3,F4}" = "bspc node -p ~{south,east}";
    "super + @Escape" = "bspc node -p cancel";

    # Layout selection
    "super + Return" = "bspc desktop -l next";

    # Cycle through windows
    "super + Tab" = "bspc node -f next.local";

    "super + shift + Tab" = "bspc node -f prev.local";

    "alt + Tab" = "bspc node -f last.local";

    # Move through windows
    "super + {Left,Right,Up,Down}" = "bspc node -f {west,east,north,south}";

    # Move window inside current workspace
    "super + alt + {Left,Right,Up,Down}" = "bspc node -s {west,east,north,south}";

    # Switch to workspace
    "super + {ampersand,eacute,quotedbl,apostrophe,parenleft,minus,egrave,underscore,ccedilla,agrave}" = "bspc desktop -f ^{1,2,3,4,5,6,7,8,9,10}";

    "super + KP_{End,Down,Next,Left,Begin,Right,Home,Up,Prior,Insert}" = "bspc desktop -f ^{1,2,3,4,5,6,7,8,9,10}";

    # Move window to workspace
    "super + alt + {ampersand,eacute,quotedbl,apostrophe,parenleft,minus,egrave,underscore,ccedilla,agrave}" = "bspc node -d ^{1,2,3,4,5,6,7,8,9,10}";

    "super + alt + KP_{End,Down,Next,Left,Begin,Right,Home,Up,Prior,Insert}" = "bspc node -d ^{1,2,3,4,5,6,7,8,9,10}";

    # Fullscreen
    "super + space" = "bspc node -t ~fullscreen";

    # Floating
    "super + f" = "bspc node -t ~floating";

    # Show/hide window
    "super + h" = ''
      test -n "$(bspc query -N -n .hidden)" \
          && ( \
              id=$(bspc query -N -n .hidden); \
              bspc node ''${id} -g hidden; \
              bspc node -f ''${id} \
          ) \
          || bspc node -g hidden
      '';

    # Kill window
    "super + q" = "bspc node -c";

    "alt + F4" = "bspc node -c";

    # Resizing horizontally
    "super + KP_Add" = "bspc node -z right 10 0 || bspc node -z left -10 0";

    "super + KP_Subtract" = "bspc node -z right -10 0 || bspc node -z left 10 0";

    # Resizing vertically
    "super + alt + KP_Add" = "bspc node -z bottom 0 10 || bspc node -z top 0 -10";

    "super + alt + KP_Subtract" = "bspc node -z bottom 0 -10 || bspc node -z top 0 10";

    # Terminal
    "super + t" = "{{TERMINAL}}";

    # Web browser
    "super + b" = "{{WEB_BROWSER}}";

    # File manager
    "super + e" = "{{FILE_MANAGER}}";

    # Editor
    "super + n" = "{{RUN_IN_TERMINAL}} {{EDITOR}}";

    # Applications menu
    "super + d" = "{{APP_MENU}";

    # Lock
    "super + l" = "{{LOCKER}}";

    # Volume control
    "super + v" = "{{VOLUME_CONTROL}}";

    # Power menu
    "super + p" = "{{POWER_MENU}}";

    # Reload window manager
    "super + F5" = "pkill -USR1 -x sxhkd; {{WM_RELOAD}}";

    # Window manager exit
    "super + Delete" = "{{WM_KILL}}";
  };

  # Make per-user options
  makeUserOptions = { username, ... }: {
    "name" = username;
    "value" = {
      sxhkd = {
        enable = lib.mkEnableOption "sxhkd configuration";

        keyBindings = lib.mkOption {
          type = lib.types.attrsOf (lib.types.nullOr lib.types.str);
          description = "An attribute set that assigns hotkeys to commands.";
          default = defaults;
        };
      };
    };
  };

  # Make per-user configuration
  # TODO: use home-manager module as soon as it's possible
  #       to disable the systemd service it creates
  makeUserConfiguration = { username, ... }:
    let
      configDir = ".config/sxhkd";
    in
    {
      "name" = username;
      "value" = lib.mkIf config.hm."${username}".sxhkd.enable {
        home.file."${configDir}/sxhkdrc".source = ./resources/sxhkdrc;
      };
    };
in
{
  # ----------------------------------------------------------------------------
  # Options
  # ----------------------------------------------------------------------------

  options.hm = builtins.listToAttrs (map makeUserOptions config.settings.users);

  # ----------------------------------------------------------------------------
  # Configuration
  # ----------------------------------------------------------------------------

  config = {
    home-manager.users =
      builtins.listToAttrs (map makeUserConfiguration config.settings.users);
  };
}
