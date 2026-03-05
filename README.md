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
    * tuigreet: config + theme
    * plymoot h boot menu
    * logs d'hyprland au boot
    * clean generations

# Later

- ESC pour cacher les fenêtres floating BT, ...
- Automatic display configuration
    * https://filipmikina.com/blog/hyprdynamicmonitors
    * https://gitlab.com/w0lff/shikane
    * kanshi (pas rust)
- bittorent:
    * https://github.com/stabldev/torrra
- tester: bookworm, koodo-reader, foliate for epub
- remplacer certains scripts par des binaires Rust
