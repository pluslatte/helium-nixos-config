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

  programs = {
    git = {
      enable = true;
    };
    alacritty.enable = true;
  };

  # hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      "$terminal" = "alacritty";
      "$mod" = "SUPER";

      monitor = [ ",preferred,auto,auto" ];
      bind = [
        "$mod, Return, exec, $terminal"
        "$modSHIFT, Q, exec, killactive"
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
