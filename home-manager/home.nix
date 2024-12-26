{
  pkgs,
  username,
  host,
  ...
}:
{
  # Enable home-manager
  programs.home-manager.enable = true;

  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    xdg-utils
  ];
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

  programs = {
    git = {
      enable = true;
    };
    alacritty = {
      enable = true;
      settings = {
        window = {
          padding.x = 5;
          padding.y = 5;
        };

        font = {
          size = 13;
          normal.family = "FiraCode Nerd Font";
        };
      };
    };
    firefox.enable = true;
    vim.enable = true;
  };

  # hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      "$terminal" = "alacritty";
      "$mod" = "SUPER";

      input = {
        kb_layout = "jp";
      };

      monitor = [ ",preferred,auto,1" ];
      bind = [
        "$mod, Return, exec, $terminal"
        "$modSHIFT, Q, killactive"
        "$modSHIFT, M, exit"
        "$mod, h, movefocus, l"
        "$mod, j, movefocus, d"
        "$mod, k, movefocus, u"
        "$mod, l, movefocus, r"
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
      ];
    };
  };
}
