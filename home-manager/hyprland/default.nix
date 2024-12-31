{
  pkgs,
  system,
  hyprland-qtutils,
  username,
  ...
}:
let
  screenShotsDir = "/home/${username}/screenShots";
  qtTheme = "adwaita-dark";
in
{
  # If qt theme won't work, this may help you.
  # https://discourse.nixos.org/t/struggling-to-configure-gtk-qt-theme-on-laptop/42268

  # Import .nix which are made for hyprland config
  imports = [
    ./wofi.nix # Notification handler
    # ./waybar.nix # Status bar
    ./hyprpanel.nix # Status bar
    ./hyprlock.nix # Screen lock
  ];

  # Dependancies
  home.packages = with pkgs; [
    xdg-utils
    hyprland-qtutils.packages."${system}".default
    grim # for screen sharing
    slurp # for screen sharing
    xwaylandvideobridge # for screen sharing

    brightnessctl # screen brightness control
    pamixer # pluseaudio mixer
    grimblast # Screenshot

    # How to override packages.
    # (breeze-hacked-cursor-theme.override {
    #   accentColor = "#fe8019";
    #   baseColor = "#3c3836";
    #   borderColor = "#1d2021";
    #   logoColor = "#ebdbb2";
    # }) # Cursor.
  ];
  home.file = {
    # You need this to make screenshot save working.
    "screenshots_here.txt" = {
      target = "${screenShotsDir}/screenshots_here.txt";
      text = "yippee!";
    };
  };

  # You need me!
  xdg.enable = true;
  xdg.portal = {
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
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

  # Qt theme
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      name = "${qtTheme}";
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
        "QT_QPA_PLATFORM, Hyprland;wayland"
        "QT_STYLE_OVERRIDE, ${qtTheme}"
        "XDG_SCREENSHOTS_DIR, ${screenShotsDir}"
      ];

      exec-once = [
        # Wallpaper is handled by stylix now.
        # "swww init && swww img ~/.config/hypr/wallpaper/wallhaven-2e2xyx.jpg"

        # For screen sharing
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

        # Japanese
        "fcitx5 &"
      ];

      general = {
        gaps_in = 4;
        gaps_out = 4;
        border_size = 1;
        resize_on_border = true;
        # "col.inactive_border" = "0xff282828";
        # "col.active_border" = "0xffebdbb2";
      };

      input = {
        # I use JIS keyboard!
        kb_layout = "jp";

        # Touchpad scrolling
        scroll_method = "edge";
        touchpad.scroll_factor = 0.7;

        # Impatiant key repeat
        repeat_rate = 25;
        repeat_delay = 175; # Default is 600
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

        # hyprlock
        "$modSHIFT, R, exec, pidof hyprlock || hyprlock"

        # Screenshot
        ", Print, exec, grimblast --notify copy output"
        ''$mod, Print, exec, grimblast --notify copysave output "$XDG_SCREENSHOTS_DIR/$(date +%Y-%m-%dT%H-%M-%S).png"''
        ''$modSHIFT, S, exec, grimblast --notify copy area''
      ];

      # Mouse bind
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # laptop button bind
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
