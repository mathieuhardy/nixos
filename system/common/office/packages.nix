{
  koob,
  pkgs,
  storyteller,
  ...
}:

let
  timelines = pkgs.callPackage ../custom-packages/timelines.nix { };
in
{
  environment.systemPackages = with pkgs; [
    calibre # Ebooks
    eloquent # Spell checker
    foliate # Ebooks
    koob.packages.${pkgs.system}.default
    languagetool
    libreoffice-qt
    ltex-ls # TODO: Check if still used
    pandoc # Documents conversion
    storyteller.packages.${pkgs.system}.default
    timelines
    typst
  ];

  programs = {
    evince.enable = true; # PDF
  };
}
