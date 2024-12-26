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
          padding.x = 5;
          padding.y = 5;
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
