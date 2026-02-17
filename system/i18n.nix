{ ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Internationalization
  # ────────────────────────────────────────────────────────────────────────────

  i18n = {
    defaultLocale = "en_US.UTF-8";

    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "fr_FR.UTF-8/UTF-8"
    ];

    extraLocaleSettings = {
      LC_ADDRESS = "fr_FR.UTF-8";
      LC_COLLATE = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_IDENTIFICATION = "fr_FR.UTF-8";
      LC_MONETARY = "fr_FR.UTF-8";
      LC_MEASUREMENT = "fr_FR.UTF-8";
      LC_MESSAGES = "en_US.UTF-8";
      LC_NAME = "fr_FR.UTF-8";
      LC_NUMERIC = "fr_FR.UTF-8";
      LC_PAPER = "fr_FR.UTF-8";
      LC_RESPONSE = "en_US.UTF-8";
      LC_TELEPHONE = "fr_FR.UTF-8";
      LC_TIME = "fr_FR.UTF-8";
    };
  };

  # ────────────────────────────────────────────────────────────────────────────
  # Time
  # ────────────────────────────────────────────────────────────────────────────

  time.timeZone = "Europe/Paris";
}
