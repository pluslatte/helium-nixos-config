{
  pkgs,
  system,
  hyprland-qtutils,
  ...
}:
{
  # Dependancies
  home.packages = with pkgs; [
    xdg-utils
    hyprland-qtutils.packages."${system}".default
    wofi
    wofi-emoji
  ];

  # You need me!
  xdg.enable = true;
  xdg.portal = {
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
    ];
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [
        "gtk"
        "hyprland"
      ];
    };
    enable = true;
  };

  # Notification handler
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 1;
        timeout = 10;
        offset = "30x30";
        transparency = 10;
        corner_radius = 10;
        font = "FiraCode Nerd Font";
      };
    };
  };

  # Launcher wofi config
  home.file.".config/wofi/style.css".text = ''
    window {
      font-family: "FiraCode Nerd Font";
      font-weight: bold;
      margin: 0px;
      border-radius: 10px;
      background-color: rgba(27, 30, 43, 0.9);
    }

    #input {
      all: unset;
      padding: 2px;
      border-radius: 6px;
      margin: 5px;
      border: none;
      color: #c8d3f5;
      background-color: rgba(200, 211, 245, 0.2);
    }

    #inner-box {
      margin: 5px;
      border: none;
      background-color: transparent;
    }

    #outer-box {
      margin: 5px;
      border: none;
      background-color: transparent;
    }

    #scroll {
      margin: 0px;
      border: none;
    }

    #text {
      margin: 5px;
      border: none;
      color: #c8d3f5;
    }

    #entry {
      border: none;
    }

    #entry:focus {
      border: none;
    }

    #entry:selected {
      background-color: rgba(200, 211, 245, 0.2);
      border-radius: 5px;
      border: none;
    }
  '';

  # hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    # Settings here
    settings = {
      "$terminal" = "alacritty";
      "$mod" = "SUPER";

      env = [
        "NIXOS_OZONE_WL, 1"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 1;
        resize_on_border = true;
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          xray = true;
          ignore_opacity = true;
          new_optimizations = true;
        };
      };

      input = {
        kb_layout = "jp";
      };

      monitor = [ ",preferred,auto,1" ];
      bind = [
        # Basic
        "$mod, Return, exec, $terminal"
        "$modSHIFT, Q, killactive"
        "$modSHIFT, M, exit"

        # Window focus control
        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"

        # Workspace operations
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        "$modSHIFT, 1, movetoworkspace, 1"
        "$modSHIFT, 2, movetoworkspace, 2"
        "$modSHIFT, 3, movetoworkspace, 3"
        "$modSHIFT, 4, movetoworkspace, 4"
        "$modSHIFT, 5, movetoworkspace, 5"
        "$modSHIFT, 6, movetoworkspace, 6"
        "$modSHIFT, 7, movetoworkspace, 7"
        "$modSHIFT, 8, movetoworkspace, 8"
        "$modSHIFT, 9, movetoworkspace, 9"
        "$modSHIFT, 0, movetoworkspace, 10"

        # Wofi binds
        "$mod, d, exec, wofi --show drun"
        "$mod, period, exec, wofi-emoji"
      ];
    };
  };
}
