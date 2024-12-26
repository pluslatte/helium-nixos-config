{ hyprpanel, ... }:
{
  imports = [ hyprpanel.homeManagerModules.hyprpanel ];

  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    hyprland.enable = true;
    overwrite.enable = true;
    theme = "gruvbox_split";

    layout = {
      "bar.layouts" = {
        "0" = {
          left = [
            "dashboard"
            "workspaces"
          ];
          middle = [ "media" ];
          right = [
            "volume"
            "systray"
            "notifications"
          ];
        };
      };
    };

    settings = {
      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;

      menus.clock = {
        time = {
          military = true;
          hideSeconds = true;
        };
        weather.unit = "metric";
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
