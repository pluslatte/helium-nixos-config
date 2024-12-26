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

    brightnessctl # screen brightness control
    pamixer # pluseaudio mixer
    swww # Wallpaper
    grimblast # Screenshot
  ];
  home.file = {
    # An image from gruvbox-wallpapers, for my wallpaper.
    "canyon.jpg" = {
      target = ".config/hypr/wallpaper/canyon.jpg";
      source = pkgs.fetchurl {
        url = "https://gruvbox-wallpapers.pages.dev/wallpapers/irl/canyon.jpg";
        sha256 = "sha256-om/f73Il7el7OWa1lbOngZW5N1o2zi+kWXTHOyiLXs0=";
      };
    };
  };

  # Import .nix which are made for hyprland config
  imports = [ ./wofi.nix ];

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

  # hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    # Settings here
    settings = {
      "$terminal" = "alacritty";
      "$mod" = "SUPER";

      misc = {
        disable_hyprland_logo = true;
      };

      env = [
        "NIXOS_OZONE_WL, 1"
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
        "QT_QPA_PLATFORM, Hyprland"
        "XDG_SCREENSHOTS_DIR, $HOME/screens"
      ];

      exec-once = [
        "swww init && swww img ~/.config/hypr/wallpaper/canyon.jpg"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 1;
        resize_on_border = true;
      };

      input = {
        kb_layout = "jp";
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

      animations = {
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 4, myBezier, slide"
          "layers, 1, 4, myBezier, fade"
          "border, 1, 5, default"
          "fade, 1, 5, default"
          "workspaces, 1, 6, default"
        ];
      };

      monitor = [ ",preferred,auto,1" ];

      bind = [
        # Basic
        "$mod, Return, exec, $terminal"
        "$modSHIFT, Q, killactive"
        "$modSHIFT, M, exit"
        "$modSHIFT, F, togglefloating"

        # Window focus control
        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"
        "$modSHIFT, h, swapwindow, l"
        "$modSHIFT, j, swapwindow, d"
        "$modSHIFT, k, swapwindow, u"
        "$modSHIFT, l, swapwindow, r"

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
        "$modSHIFT, 1, movetoworkspacesilent, 1"
        "$modSHIFT, 2, movetoworkspacesilent, 2"
        "$modSHIFT, 3, movetoworkspacesilent, 3"
        "$modSHIFT, 4, movetoworkspacesilent, 4"
        "$modSHIFT, 5, movetoworkspacesilent, 5"
        "$modSHIFT, 6, movetoworkspacesilent, 6"
        "$modSHIFT, 7, movetoworkspacesilent, 7"
        "$modSHIFT, 8, movetoworkspacesilent, 8"
        "$modSHIFT, 9, movetoworkspacesilent, 9"
        "$modSHIFT, 0, movetoworkspacesilent, 10"

        # Wofi binds
        "$mod, d, exec, wofi --show drun"
        "$mod, period, exec, wofi-emoji"

        # Screenshot
        ", Print, exec, grimblast --notify copy output"
        # does not work for some reason...
        # ''$mod, Print, exec, grimblast --notify copysave output "$HOME/Screenshots/$(date +%Y-%m-%dT%H:%M:%S).png"''
      ];

      # Mouse bind
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # hardware button bind?
      bindl = [
        # volume control
        ", XF86AudioMute, exec, pamixer -t"
      ];
      bindle = [
        # volume control
        ", XF86AudioRaiseVolume, exec, pamixer -i 10"
        ", XF86AudioLowerVolume, exec, pamixer -d 10"

        # monitor brightness control
        ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
      ];
    };
  };
}
