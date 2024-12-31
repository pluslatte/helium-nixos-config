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

  imports = [
    ./hyprland
    ../stylix_home.nix
  ];

  home.packages = with pkgs; [
    # Discord screensharing works poorly on hyprland, and you have a browser version of Discord.
    bitwarden
    galculator # Calculator
    obsidian # Markdown IDE
    spotify
    vscode
    yt-dlp
    cava # Audio visualizer on console
    tty-clock
    pcmanfm # File manager
    gthumb # Image viewer
    totem # Media player
  ];

  home.file = {
    ".xprofile".text = ''
      export GTK_IM_MODULE=fcitx
      export QT_IM_MODULE=fcitx
      export XMODIFIERS=@im=fcitx
    '';
  };

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
        };
      };
    };

    # Web browser
    firefox.enable = true;
    chromium.enable = true;

    # Vim
    vim.enable = true;
  };
}
