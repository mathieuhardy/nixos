{ config, ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Install config:
  #   ~/.config/input-remapper-2/
  # ────────────────────────────────────────────────────────────────────────────

  xdg.configFile."input-remapper-2".source = ./configs/input-remapper;
}
