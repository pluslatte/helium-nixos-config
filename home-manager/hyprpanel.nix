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
      };

      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = true;

      theme.bar.transparent = true;

      theme.font = {
        name = "FiraCode Nerd Font";
        size = "16px";
      };
    };
  };
}
