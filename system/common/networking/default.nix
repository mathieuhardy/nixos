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

      # Force to handle all interfaces
      unmanaged = [ ];
    };

    # Wifi (enable iwd and disable wpa_supplicant)
    wireless.iwd = {
      enable = true;

      settings = {
        General = {
          # NM handles DHCP
          EnableNetworkConfiguration = false;
        };
      };
    };

    wireless.enable = false;

    # Firewall
    firewall = {
      enable = true;

      allowPing = true;
    };
  };
}
