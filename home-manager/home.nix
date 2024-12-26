{
  pkgs,
  system,
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

  imports = [ ./hyprland.nix ];

  home.packages = with pkgs; [
    spotify
  ];

  programs = {
    # Git
    git = {
      enable = true;
    };

    # Terminal emulator
    alacritty = {
      enable = true;
      settings = {
        window = {
          padding.x = 12;
          padding.y = 12;
          opacity = 0.8;
        };

        font = {
          size = 13;
          normal.family = "FiraCode Nerd Font";
        };
      };
    };

    # Web browser
    firefox.enable = true;

    # Vim
    vim.enable = true;
  };
}
