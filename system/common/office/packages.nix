{
  koob,
  pkgs,
  storyteller,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    calibre # Ebooks
    eloquent # Spell checker
    foliate # Ebooks
    koob.packages.${pkgs.stdenv.hostPlatform.system}.default
    languagetool
    libreoffice-qt
    ltex-ls # TODO: Check if still used
    pandoc # Documents conversion
    storyteller.packages.${pkgs.stdenv.hostPlatform.system}.default
    typst
  ];

  programs = {
    evince.enable = true; # PDF
  };
}
