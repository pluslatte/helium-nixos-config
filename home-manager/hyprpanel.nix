{ hyprpanel, pkgs, ... }:
{
  imports = [ hyprpanel.homeManagerModules.hyprpanel ];

  home.packages = with pkgs; [
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
      bar.clock.format = "%I:%M %p";

      menus.clock = {
        time = {
          military = true;
          hideSeconds = true;
        };
        weather.enabled = false;
      };

      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = false;

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

      theme.font = {
        name = "FiraCode Nerd Font";
        size = "16px";
      };
    };
  };
}
