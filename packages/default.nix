with import <nixpkgs> {};

rec {
   add = pkgs.callPackage ./add/add.nix {};
   battery-mode = pkgs.callPackage ./battery-mode/battery-mode.nix {};
   cerebro = pkgs.callPackage ./cerebro/cerebro.nix {};
   easier = pkgs.callPackage ./cerebro/easier.nix {};
   fire = pkgs.callPackage ./fire/fire.nix {};
   lok = pkgs.callPackage ./lok/lok.nix {};
   override = pkgs.callPackage ./override/override.nix {};
   polybar-utils = pkgs.callPackage ./polybar-utils/polybar-utils.nix {};
   rice = pkgs.callPackage ./rice/rice.nix {};
   rofi-utils = pkgs.callPackage ./rofi-utils/rofi-utils.nix {};
   wallpapers = pkgs.callPackage ./wallpapers/wallpapers.nix {};
}
