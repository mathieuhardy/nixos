# How to install NixOS

These page explains the steps to follow to install NixOS using the tool
`nixos-install`. This tool has been created to abstract all partitioning or
configuration generation steps.

## 1. Preparation

### 1.1. Prepare boot device

Download minimal image from [NixOS download page][1] then write it on a USB key:

```bash
$ dd if=nixos-minimal.iso of=/dev/usb bs=1M
```

Boot on this USB key.

### 1.2. Prepare installation

This step configures the WiFi to be used and the environment variables for the
current installation. This will create a `.env` file in the current directory.

```bash
$ sudo nixos-setup env \
    --hardware <hardware> \
    --host <host> \
    --key-name <key_name> \
    --key-path <key_path> \
    --wpa-password <wpa_password> \
    --wpa-ssid <wpa_ssid>
```

> **hardware**: hardware name to use for this installation (best pratice is to use this syntax "brand_model-generic_model").
> **host**: host name to use for this installation.
> **key_name**: Name of the key file used to encrypt disks.
> **key_path**: Path where to generate the key file (defaults to /tmp).
> **wpa_ssid**: SSID of the WiFi to use (optional).
> **wpa_password**: password of the WiFi to use (optional).

Example:

```bash
$ sudo nixos-setup env \
    --hardware "thinkpad-p14" \
    --host "home" \
    --key-name "key_file" \
    --key-path "/tmp" \
    --wpa-password "mywifipassword" \
    --wpa-ssid "mywifi"
```

### 1.3. Generate salt file

This step is needed before trying to create a key file for LUKS encryption.

Place some well known or random data in a file:

```bash
$ echo "choucroute" > /tmp/salt
$ dd if=/dev/urandom of=/tmp/salt bs=1024 count=4
```

### 1.4. Generate a key file used to encrypt partitions

```bash
$ nixos-setup luks \
    --iterations <iterations> \
    --key-size <key_size> \
    --output <output> \
    --password <passphrase> \
    --salt <salt>
```

> **iterations**: number of hashing iterations to perform.
> **key_size**: size in bytes of the key to generate (4096 by default).
> **output**: output file (optional).
> **passphrase**: passphrase to be hashed to generate a key.
> **salt**: file containing some salt.

Example:

```bash
$ nixos-setup luks \
    --iterations 10 \
    --key-size 4096 \
    --password "toto" \
    --salt "/tmp/salt"
```

### 1.5. Create layout file and generate filesystem tree

This step creates files that will be used to prepare the disks from a layout
description input.

In folder **layouts**, add a file `<host>.in.json` where `host` must be the same
as the file that will be used to install the machine in **hosts** folder.

See [layouts/README.md](myLib/README.md) for more information about the format.

### 1.6. Run partitioning

This step creates the disks partitions.

```bash
$ sudo nixos-setup partitioning \
    --device "NAME=REPLACEMENT" \
    --host <host> \
    --password <passphrase>
```

> **device**: Rule to replace a device name of a disk from the layout (optional and can appear multiple times).
> **host**: host name to use for installation (optional if `.env` exists).
> **passphrase**: passphrase used to encrypt the partitions.

Example:

```bash
$ sudo nixos-setup partitioning \
    --device "disk_1=/dev/mmcblk0" \
    --device "disk_2=/dev/mmcblk1" \
    --password "toto"
```

### 1.7. Install secrets

This step install the key file in the filesystem.

```bash
$ sudo nixos-setup secrets \
    --host <host> \
    --password <passphrase>
```

> **host**: host name to use for installation (optional if `.env` exists).
> **passphrase**: passphrase used to decrypt the partitions.

Example:

```bash
$ sudo nixos-setup secrets --password "toto"
```

### 1.8. Generate hardware configuration

This step generates a hardware configuration used by NixOS. It can be skipped if
the configuration has already been generated.

```bash
$ sudo nixos-setup hardware \
    --name <hardware>
```

> **hardware**: name of the hardware (optional if `.env` exists).

Example:

```bash
$ sudo nixos-setup hardware
```

### 1.9. Generate filesystem configurations

This step generates the NixOS configurations needed to mount the filesystems
at boot.

```bash
$ sudo nixos-setup filesystems \
    --host <host>
```

> **host**: host name to use for installation (optional if `.env` exists).

## 2. Installation

This step installs NixOS.

```bash
$ sudo nixos-setup install \
    --host <host> \
    --password <passphrase> \
    --repository <path>
```

> **host**: host name to use for installation (optional if `.env` exists).
> **passphrase**: passphrase used to decrypt the partitions.
> **path**: path of the repository where the NixOS configuration is stored (can be an URL that will be clone with git or a directory in the local filesystem).

Example:

```bash
$ sudo nixos-setup install \
    --password "toto" \
    --repository "/tmp/my-cloned-nixos-repo"
```

## 3. Post-installation

### 3.1 SSH keys

```bash
$ nixos-setup ssh \
    --output <output_dir> \
    --password <passphrase> \
    --salt-file <salt>
```

> **output_dir**: directory where the keys will be stored.
> **passphrase**: passphrase used to protect the SSH keys.
> **salt**: file with salt used to generate the SSH keys.

Example:

```bash
$ nixos-setup ssh \
    --output /home/user/.ssh \
    --password "toto" \
    --salt-file "/tmp/salt"
```

[1]: https://nixos.org/download.html
