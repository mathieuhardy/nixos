{ config, osConfig, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Link to config:
  #   ~/.config/hypr/hyprland.conf
  # ────────────────────────────────────────────────────────────────────────────

  xdg.configFile."hypr/hyprland.conf".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/hyprland/hyprland.conf";

  # ────────────────────────────────────────────────────────────────────────────
  # Link to custom scripts:
  #   ~/.config/hypr/scripts/gparted.sh
  #   ~/.config/hypr/scripts/monitor-setup.sh
  #   ~/.config/hypr/scripts/notifications-count.sh
  #   ~/.config/hypr/scripts/toggle-bluetooth.sh
  #   ~/.config/hypr/scripts/toggle-window.sh
  #   ~/.config/hypr/scripts/trash.sh
  #   ~/.config/hypr/scripts/workspace-navigation.sh
  #
  # TODO: check to make this like system/battery (but in hyprland/)
  #
  # TODO: transform to a loop
  # let
  #   scripts = [
  #     "gparted.sh"
  #     "monitor-setup.sh"
  #     "notifications-count.sh"
  #     "toggle-bluetooth.sh"
  #     "toggle-window.sh"
  #     "trash.sh"
  #     "workspace-navigation.sh"
  #   ];
  #
  #   basePath =
  #     "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/hyprland/scripts";
  # in
  # {
  #   xdg.configFile =
  #     lib.genAttrs
  #       (map (s: "hypr/scripts/${s}") scripts)
  #       (name: {
  #         source =
  #           config.lib.file.mkOutOfStoreSymlink
  #             "${basePath}/${lib.last (lib.splitString "/" name)}";
  #       });
  # }
  # ────────────────────────────────────────────────────────────────────────────

  xdg.configFile."hypr/scripts/gparted.sh".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/hyprland/scripts/gparted.sh";

  xdg.configFile."hypr/scripts/monitor-setup.sh".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/hyprland/scripts/monitor-setup.sh";

  xdg.configFile."hypr/scripts/notifications-count.sh".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/hyprland/scripts/notifications-count.sh";

  xdg.configFile."hypr/scripts/toggle-bluetooth.sh".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/hyprland/scripts/toggle-bluetooth.sh";

  xdg.configFile."hypr/scripts/toggle-window.sh".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/hyprland/scripts/toggle-window.sh";

  xdg.configFile."hypr/scripts/trash.sh".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/hyprland/scripts/trash.sh";

  xdg.configFile."hypr/scripts/workspace-navigation.sh".source =
    config.lib.file.mkOutOfStoreSymlink "/home/${osConfig.settings.userLogin}/${osConfig.settings.repos}/nixos/home-manager/configs/hyprland/scripts/workspace-navigation.sh";
}
