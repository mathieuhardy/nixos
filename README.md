# NixOS

Follow [How to install Nixos](HOWTO_INSTALL.md) steps to install a NixOS with
automatic partitioning.

## TODO

- picom ?
- test: multiple users
- add theme for sddm
- create git repository for: easier, add, ...
- create tags for repositories and use version to fetch release

## Links

**API**
- [Public API list](https://github.com/public-apis/public-apis)
- [OmDB](https://www.omdbapi.com)

**Audio**
- [deadbeef](https://deadbeef.sourceforge.io)
- [beets](https://beets.io/)
- [Pulseaudio noise cancelling](https://www.youtube.com/watch?v=k5HIDOBpAwU)
- [Pipewire](https://nixos.wiki/wiki/PipeWire)
- [Config pipewire](https://discourse.nixos.org/t/is-pipewire-ready-for-using/11578/6)

**Bspwm**
- [Windows titles](https://github.com/melangue/bspwm-window-titles/blob/master/bspwm/bspwm_window_titles.sh)
- [Lock on LID close](https://www.reddit.com/r/bspwm/comments/exdyhp/how_to_make_bspwm_logout_when_closing_laptop_lid)
- [Rofi rounded corners](https://www.reddit.com/r/bspwm/comments/mcwycf/how_do_i_fix_the_corner_not_being_rounded)
- [Firefox floating windows](https://www.reddit.com/r/bspwm/comments/n2bveg/how_to_add_a_bspc_rule_to_set_firefox_download)
- [Open programs at boot](https://www.reddit.com/r/bspwm/comments/v8awop/open_program_on_certain_workspace_on_boot/)

**Connman**
- [connman-gtk](https://github.com/jgke/connman-gtk)
- [cmst](https://github.com/andrew-bibb/cmst/wiki/Screenshots)
- [Cheatsheet](https://gist.github.com/kylemanna/6930087)

**Firefox**
- [Privacy configuration][https://www.privacytools.io/browsers/#about_config)

> browser.backspace_action => value=0

**Home-manager**
- [Example Bob Vanderlinden](https://github.com/bobvanderlinden/nix-home/blob/master/home.nix)
- [Home-manger mkOutOfStoreSymlink](https://github.com/nix-community/home-manager/issues/589)

**Mustache**
- [Bash implementation](https://github.com/tests-always-included/mo)
- [Documentation](https://mustache.github.io/mustache.5.html)

**Neovim**

- [Completion](https://github.com/ms-jpq/coq_nvim)
- [Treesitter](https://opensourcelibs.com/lib/nvim-treesitter)

> Terminal
> :term
> :wincmd x
>:res 40

**NixOS**
- [Config de p-rémi)](https://github.com/minijackson/nixos-config/blob/master/home/firefox.nix)
- [SSD trim](https://www.reddit.com/r/NixOS/comments/rbzhb1/if_you_have_a_ssd_dont_forget_to_enable_fstrim/)

**Other**
- [Nokomprendo](https://nokomprendo.gitlab.io)
- [Secure OpenSSH](https://www.tecmint.com/secure-openssh-server)

**Packages**
- [Iwd](https://nixos.wiki/wiki/Iwd)
- [PulseAudio](https://nixos.wiki/wiki/PulseAudio)
- [Python](https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/python.section.md)
- [Vim](https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/vim.section.md)

**Polybar**
- [Wiki](https://wiki.archlinux.org/index.php/Polybar)
- [Awesome config](https://github.com/lokesh-krishna/dotfiles)
- [Dunst toggle](https://github.com/JeanEdouardKevin/dunst-polybar)
- [Awesome links](https://github.com/TiagoDanin/Awesome-Polybar)
- [Software updates](https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/updates-pacman-aurhelper)
- [Weather](https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/openweathermap-fullfeatured)
- [USB devices](https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/system-usb-udev)
- [Workspaces](https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/info-hlwm-workspaces)
- [Hidden terminals](https://github.com/Nikzt/polybar-terminal-tabs)
- [Fan speed](https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/system-fan-speed)

**Power management**
- [Apply at boot (if needed)](https://www.linuxuprising.com/2021/02/how-to-limit-battery-charging-set.html)

**Rofi**
- [Scripts](https://gitlab.com/dwt1/dmscripts)
- [Scripts](https://gitlab.com/formigoni/sys-admin)
- [Menus](https://gitlab.com/vahnrr/rofi-menus)
- [Widgets](https://github.com/adi1090x/rofi)

**Security**
- [Cover your tracks](https://coveryourtracks.eff.org)
- [Am I unique](https://amiunique.org/fp)
- [NixOS hardening](https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/profiles/hardened.nix)
- [NixOS security settings](https://discourse.nixos.org/t/default-security-settings/9755)
- [Paranois security guide](https://github.com/anon23847/Paranoid-Debian-Security-Guide)

**SDDM**
- [How to configure](https://github.com/MarianArlt/kde-plasma-chili/issues/1)
- [Theme plasma-chili](https://github.com/MarianArlt/kde-plasma-chili)
- [Theme sugar-candy](https://framagit.org/MarianArlt/sddm-sugar-candy)

**Sway**
- [Website](https://blog.0w.tf/sway.html)

**Theming**
- [Numix](https://numixproject.github.io/products.html)
- [Arc](https://github.com/arc-design/arc-theme)
- [Moka](https://snwh.org/moka)
- [Firefox](https://github.com/manilarome/blurredfox)

**Tutorials**
- [Gentle introduction](https://ebzzry.io/en/nix)
- [Nix shells](https://ghedam.at/15978/an-introduction-to-nix-shell)
- [Language](https://lambdablob.com/posts/nix-language-primer)
- [Git private repository](https://www.mpscholten.de/nixos/2016/07/07/private-github-repositories-and-nixos.html)
- [Package a C application](https://www.youtube.com/watch?v=LiEqN8r-BRw)
- [Package a Python application](https://www.youtube.com/watch?v=jXd-hkP4xnU)

**Utils**
- [ascii-headers](http://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=Type%20Something%20) — ASCII art generator
- [auto-rander](https://github.com/phillipberndt/autorandr) — Automatic display configuration switcher
- [binserve](https://github.com/mufeedvh/binserve) — HTTP server
- [calendar](https://wiki.gnome.org/Apps/Calendar) — Calendar utility
- [california](https://wiki.gnome.org/Apps/California) — Calendar utility
- [doas](https://www.vultr.com/docs/introduction-to-doas-on-openbsd) — Sudo replacement
- [duf](https://www.cyberciti.biz/open-source/command-line-hacks/duf-disk-usage-free-utility-for-linux-bsd-macos-windows) — Disk usage utility
- [errbot](https://errbot.readthedocs.io/en/latest) — Bot engine
- [eww](https://github.com/elkowar/eww) — Bar and widgets
- [flox](https://github.com/devfake/flox) — Self-hosted movies catalog
- [fluent-reader](https://hyliu.me/fluent-reader) — RSS reader
- [glances](https://nicolargo.github.io/glances) — System monitoring utility
- [gnomecast](https://github.com/keredson/gnomecast) — Cast to Chrome Cast
- [hex](https://github.com/sitkevij/hex) — Hexadecimal viewer
- [lnav](https://lnav.org/features) — Log navigation utility
- [lucid](https://github.com/lucid-kv/lucid) — Key/value database
- [material-design-icons](https://pictogrammers.github.io/@mdi/font/5.3.45)
- [mkchromecast](https://mkchromecast.com) — Cast to Chrome Cast
- [nixfmt](https://github.com/serokell/nixfmt) — Formatter for Nix configuration
- [openvpn](https://openvpn.net) — VPN utility
- [owncloud](https://owncloud.com) — Self-hosted cloud utility
- [rdiff-backup](https://github.com/rdiff-backup/rdiff-backup) — Backup utility
- [scrapy](https://scrapy.org) — Web crawler utility
- [svgbob](https://github.com/ivanceras/svgbob) — Transform ASCII diagrams to SVG
- [wttr](http://v2.wttr.in) — Weather in terminal

**ZFS**
- [Auto-trim, ...](https://github.com/barrucadu/nixfiles/blob/master/hosts/nyarlathotep/configuration.nix)

## HOWTO

### Gettings help on commands

```bash
$ n
```

### Update system

```bash
# Global packages update
$ sudo nix-channel --update
$ sudo nixos-rebuild switch

# User packages update
$ nix-env -u
```

### Build a program

```bash
$ cat default.nix
with import<nixpkg> {};
stdenv.mkDerivation {
    name = "hellocpp";
    src = ./.;
    buildInputs = [ cmake ];
}

# Build and install
$ nix-env -i hellocpp -f default.nix

# Build locally without install
$ nix-build
$ ./result/bin/hellocpp

# Alternative (shell)
$ nix-shell
$ mkdir build
$ cd build
$ cmake ..
$ make
$ ./hellocpp
```
