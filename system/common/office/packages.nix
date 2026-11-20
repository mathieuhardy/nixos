{
  correct,
  koob,
  pkgs,
  storyteller,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # Books
    koob.packages.${pkgs.stdenv.hostPlatform.system}.default
    pandoc # Documents conversion
    storyteller.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Ebooks
    calibre # Ebooks
    foliate # Ebooks

    # Spellcheck
    correct.packages.${pkgs.stdenv.hostPlatform.system}.default
    languagetool
    ltex-ls # Used in Zed editor for spellcheck TODO: remove

    # Various
    libreoffice-qt
  ];

  programs = {
    evince.enable = true; # PDF
  };
}
