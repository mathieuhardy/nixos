{ ... }:

{
  # ────────────────────────────────────────────────────────────────────────────
  # Networking
  # ────────────────────────────────────────────────────────────────────────────

  networking = {
    # Hostname
    hostName = "nixos";

    # IPV6
    enableIPv6 = false;

    # NetworkManager
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };

    # Wifi
    wireless.iwd.enable = true;

    # Firewall
    firewall = {
      enable = true;
      allowPing = true;
    };
  };
}
