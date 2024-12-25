{
  pkgs,
  username,
  host,
  ...
}:
{
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.11";

  programs.git = {
    enable = true;
  };

  programs.home-manager.enable = true;
  programs.alacritty.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    extraConfig =
      let
        terminal = "alacritty";
        mod = "SUPER";
      in
      ''
        monitor =,preferred,auto,1
        bind = ${mod},Return,exec,${terminal}
        bind = ${mod}SHIFT,C,exit
      '';
  };
}
