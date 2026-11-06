{
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  glib,
  gtk4,
  libadwaita,
  networkmanager,
  gtk4-layer-shell,
  json-glib,
  polkit,
  wrapGAppsHook4,
}:

stdenv.mkDerivation rec {
  pname = "network-manager-sidebar";
  version = "1.4.0";

  src = fetchFromGitHub {
    owner = "Relz";
    repo = "network-manager-sidebar";
    rev = "v${version}";
    hash = "sha256-IF7no2VaRSM7OmRNpOl4NJ5tKYpAeJWR7Q1z+jZOclM=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    wrapGAppsHook4
  ];

  buildInputs = [
    glib
    gtk4
    libadwaita
    networkmanager
    gtk4-layer-shell
    json-glib
    polkit
  ];

  meta = {
    description = "NetworkManager sidebar for Wayland compositors";
    homepage = "https://github.com/Relz/network-manager-sidebar";
    mainProgram = "nm-sidebar-gui";
  };
}
