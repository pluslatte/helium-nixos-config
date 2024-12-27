# helium-nixos-config
This is my nixos config which is installed on my portable stick USB SSD.

## Usage
- Ensure you have login-able user named `latte`.
- Ensure you enabled nix experimental features like `nix-command` `flakes`.
- `git clone` this.
- `sudo nixos-rebuild switch --flake .#helium` inside the directory.

## Structure
- `flake.nix` is the entry point of this config.
    - nix reads `nixosConfigurations` in the `outputs`
- `home-manager` is installed as a NixOS module.
    - This means when you `nixos-rebuild switch --flake .#helium`, your home-manager configuration will be updated at same time.
- `nixos/configuration.nix` contains many of system-layer configurations.
- `nixos/hardware-configuration.nix` is not supposed to be edited manually.
    - You can `nixos-generate-config --dir ./` to auto-generate this on installation to the new storage.
- `home-manager` directory contains many of user-layer configurations.
    - `latte` will be the main user of this system. So you may want to make user `latte` on installation process before applying this config.
- `hyprland` contains desktop-environment configurations. This contains many GUI utils.
    - You can look into those codes if you don't know how to operate this system. Example: SUPER+Enter to open your terminal emulator.
