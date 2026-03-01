# Setup

- Install a fresh NixOS (with KDE for example)

- Generate a new `age` key:

```shell
mkdir -p ~/.config/sops/age
age-keygen -o ~/.config/sops/age/keys.txt
```

- Extract public `age` key and add it in `secrets.toml`

```shell
age-keygen -y ~/.config/sops/age/keys.txt
```

```toml
[sops]
age = [
  "age1abc...",
  "age1def..."
]
```

- Create the secret in raw format and cipher it inplace

```shell
echo '{"mistral": {"api_key.txt": "<my_key>"}}' > secrets/mistral/api_key.json
sops --age <age_public_key> -i -e secrets/mistral/api_key.json
```

- Apply NixOS configuration

```shell
rm -rf /etc/nixos
ln -sf ~/dev/nixos /etc/nixos
cd /etc/nixos
sudo nixos-rebuild switch --flake .#nixos
```

# Todo

- hyprland:
    * monitor-setup : pas bon workspace 11 !
    * theme
        * cursor: hand2
    * clean generations

- hardware config: récupérer ça:

```nix
# Trim SSD
services.fstrim.enable = lib.mkDefault true;

# Automatic power management
services.tlp.enable = lib.mkDefault (!config.services.power-profiles-daemon.enable);

# Enable AMD driver with 3D acceleration and 32bits support
config = {
  services.xserver.videoDrivers = lib.mkDefault [ "modesetting" ];

  hardware.graphics = {
    enable = lib.mkDefault true;
    enable32Bit = lib.mkDefault true;
  };

  hardware.amdgpu.initrd.enable = lib.mkDefault true;
};

# To be set in case there's a trackpoint (red one)
hardware.trackpoint.enable = lib.mkDefault true;
hardware.trackpoint.emulateWheel = lib.mkDefault config.hardware.trackpoint.enable;
```

# Later

- ESC pour cacher les fenêtres floating BT, ...
- Status bar:
    * https://github.com/MalpenZibo/ashell
    * https://github.com/elkowar/eww/
- Automatic display configuration
    * https://filipmikina.com/blog/hyprdynamicmonitors
    * https://gitlab.com/w0lff/shikane
    * kanshi (pas rust)
- Special workspaces:
    * https://medium.com/@mynameised/how-to-create-multiple-special-workspaces-in-hyprland-b4de8bc2ddd7
- Downloader:
    * https://github.com/surge-downloader/surge
- bittorent:
    * https://github.com/stabldev/torrra
- tester: bookworm, koodo-reader, foliate for epub
- remplacer certains scripts par des binaires Rust
