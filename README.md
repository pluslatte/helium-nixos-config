# helium-nixos-config
This is my nixos config which is installed on my portable stick USB SSD.
- NixOS
- Hyprland
- Ly
- Stylix

## Usage
- Ensure you have a NixOS system with login-able user named `latte`.
- Ensure you have enabled experimental features of `nix` like `nix-command` `flakes`.
- `git clone` this.
- (If you are doing an new installation on new device) `nixos-generate-config --dir ./nixos/` at the root of this repository.
- `sudo nixos-rebuild switch --flake .#helium` at the root of this repository.
- reboot.
- *Don't select a thing like `Hyprland (uwsm)` in Ly, which may be selected by default.*
    - Select `Hyprland` instead.

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
- `home-manager/hyprland` directory contains desktop-environment configurations. This contains many GUI utils.
    - You can look into those codes if you don't know how to operate this system. Example: SUPER+Enter to open your terminal emulator.
- `stylix.nix` controls almost all of the theme-ing things.

## Tips
- *Don't select a thing like `Hyprland (uwsm)` in Ly, which may be selected by default.*
    - Select `Hyprland` instead.
- If you don't have any working editor environments for Nix Language, you can use my pre-configured neovim.
    - Ensure you have enabled nix experimental features like `nix-command` `flakes`.
    - `nix profile install github:pluslatte/nixvim-config` then `nvim`
    - `space -> e` to open neo-tree
- *When you dual-boot with windows system, disable windows' fast-startup thing or wi-fi won't work.*
- If you temporaly need some software for some reason, you can `nix run nixpkgs#<packageName>`.
- Files which aren't tracked by git will be ignored, because flake is a git repository.
- `CTRL + ALT + Function` to swtich tty.
