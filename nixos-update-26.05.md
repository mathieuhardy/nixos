# Mise à jour NixOS 25.11 → 26.05

## Étapes

### 1. Modifier `flake.nix`

```nix
nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
home-manager.url = "github:nix-community/home-manager/release-26.05";
```

### 2. Mettre à jour le `flake.lock`

```bash
nix flake update
```

Ou input par input :

```bash
nix flake update nixpkgs
nix flake update home-manager
```

### 3. Tester sans appliquer

```bash
sudo nixos-rebuild dry-activate --flake .#nixos
```

### 4. Appliquer

```bash
sudo nixos-rebuild switch --flake .#nixos
```

## Points d'attention

- Les inputs personnels (`gitwatch`, `koob`, `hyprmonitors`, `storyteller`, `trash-monitor`) suivent `nixpkgs` via `follows` — vérifier qu'ils compilent encore.
- `waynote` suit `nixpkgs-unstable` indépendamment, non affecté.
- Consulter les [release notes 26.05](https://nixos.org/manual/nixos/stable/release-notes) pour les breaking changes.

## En cas de problème après reboot

NixOS conserve toutes les générations précédentes. Au redémarrage, le bootloader (GRUB ou systemd-boot) propose un menu pour choisir une génération antérieure. Booter dessus restore **exactement** l'état précédent (kernel, paquets, config système).

Pour revenir définitivement à la génération précédente depuis un système fonctionnel :

```bash
# Lister les générations
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Rollback automatique à la génération précédente
sudo nixos-rebuild --rollback switch
```
