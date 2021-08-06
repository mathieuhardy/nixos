# Networking configuration

{ ... }:

{
  # ----------------------------------------------------------------------------
  # Networking
  # ----------------------------------------------------------------------------

  networking = {
    # IPV6
    enableIPv6 = false;

    # NetworkManager
    networkmanager.enable = true;

    # Firewall
    firewall = {
      enable = true;
      allowPing = true;
    };
  };

  # Connman
  #services.connman.enable = true;
}
