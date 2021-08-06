# Hardware

This directory contains the NixOS configurations for the hardware platforms.
Best practice is to put each configuration inside this kind of tree:

```
├─ brand
├─── model_generic
├───── model_a.nix
├───── model_b.nix
```

For example:

```
├─ lenovo
├─── thinkpad
├───── p14s-gen1-intel.nix
├───── p14s-gen1-amd.nix
```
