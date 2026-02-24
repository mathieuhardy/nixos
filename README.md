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
    * checker si hypridle fonctionne
    * battery-alert ne marche pas (user/root ?)
    * home-manager for services.walker.enable
    * home-manager for services.swayosd.enable
    * sddm not working
    * symbolic link to configurations
    * theme
        * dark mode by default
        * theme catpuccin qt/gtk
        * theme waybar
        * theme sddm
        * theme walker
    * smile: on ne voit pas les emoji
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

- Status bar:
    * https://github.com/MalpenZibo/ashell
    * https://github.com/elkowar/eww/
- wallpaper (compare time to start):
    * https://deepwiki.com/hyprwm/hyprland-wiki/5.3-hyprpaper
    * https://github.com/danyspin97/wpaperd
    * https://github.com/LGFae/swww
- Automatic display configuration
    * https://gitlab.com/w0lff/shikane
    * kanshi (pas rust)
- Screenshot:
    * https://github.com/waycrate/wayshot
- Zooming:
    * https://github.com/coffeeispower/woomer
- Power menu:
    * https://github.com/AMNatty/wleave
- Login screen:
    * https://sr.ht/~kennylevinsen/greetd
        * https://github.com/rharish101/ReGreet (propre)
        * https://git.sr.ht/~kennylevinsen/gtkgreet
        * https://gitlab.com/marcusbritanicus/QtGreet (bof)
        * https://github.com/apognu/tuigreet (tui, why not)
