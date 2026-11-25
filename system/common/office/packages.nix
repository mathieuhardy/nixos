{
  koob,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    # Books
    koob.packages.${pkgs.stdenv.hostPlatform.system}.default
    pandoc # Documents conversion

    # Ebooks
    calibre # Ebooks
    foliate # Ebooks

    # Spellcheck
    languagetool
    python311Packages.grammalecte

    # Various
    libreoffice-qt
  ];

  programs = {
    evince.enable = true; # PDF
  };
}
