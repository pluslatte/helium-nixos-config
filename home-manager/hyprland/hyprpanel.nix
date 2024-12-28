{ hyprpanel, pkgs, ... }:
{
  # All available options are there in the link below.
  # https://github.com/Jas-SinghFSU/HyprPanel/blob/master/nix/module.nix

  imports = [ hyprpanel.homeManagerModules.hyprpanel ];

  home.file = {
    # My avatar image.
    "myAvatar.jpg" = {
      target = ".config/hypr/wallpaper/myAvatar.jpg";
      source = pkgs.fetchurl {
        url = "https://media.virtualkemomimi.net/files/0abd8ae2-7083-45bf-bcda-5eceb49dc1a9.png";
        sha256 = "sha256-JcJDPTN0Y1OAWKhXF5fo8esdk39AB3vWwpwklY0oVQ8=";
      };
    };
  };

  home.packages = with pkgs; [
    alacritty # To show vulnerability list

    libgtop
    bluez
    bluez-tools
    power-profiles-daemon
    dart-sass
    wl-clipboard
    upower
    gvfs
    hyprpicker
    hyprsunset
    hypridle
    # gpu-screen-recorder
    btop
    jq # JSON processor used in the "updates" module
    vulnix # vulnerabilities scanner used in the "updates" module

    nerd-fonts.fira-code
  ];

  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    hyprland.enable = true;
    overwrite.enable = true;
    theme = "gruvbox";

    layout = {
      "bar.layouts" = {
        "0" = {
          left = [
            "dashboard"
            "updates"
            # This does not work somehow...
            # "battery"
            "media"
            "windowtitle"
            "systray"
          ];
          middle = [
            "workspaces"
          ];
          right = [
            # "bluetooth"
            "network"
            "volume"
            "clock"
            "hyprsunset"
            "hypridle"
            "notifications"
          ];
        };
      };
    };

    settings = {
      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;
      bar.clock.format = "%y/%m/%d %H:%M";

      menus.clock = {
        time = {
          military = true;
          hideSeconds = false;
        };
        weather.enabled = false;
      };

      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = false;

      menus.dashboard.powermenu.avatar.image = ".config/hypr/wallpaper/myAvatar.jpg";

      menus.dashboard.shortcuts = {
        enabled = false;
        left = {
          shortcut1 = {
            command = "firefox";
            icon = "󰈹";
            tooltip = "Firefox";
          };
          shortcut4 = {
            command = "wofi -S drun";
            tooltip = "launcher";
          };
        };
      };

      theme.bar.transparent = true;
      theme.bar.menus.opacity = 100;
      theme.bar.buttons.opacity = 90;
      theme.bar.buttons.enableBorders = true;
      theme.bar.buttons.borderSize = "0.05em";
      theme.font = {
        name = "FiraCode Nerd Font";
        size = "14px";
      };

      bar.customModules.updates.updateCommand = "jq '[.[].cvssv3_basescore | to_entries | add | select(.value > 5)] | length' <<< $(vulnix -S --json)";
      bar.customModules.updates.icon.pending = "";
      # bar.customModules.updates.icon.pending = "󰏗";
      bar.customModules.updates.icon.updated = "";
      # bar.customModules.updates.icon.updated = "󰏖";
      bar.customModules.updates.leftClick = "alacritty --hold -e vulnix -S -D";
    };
  };
}
