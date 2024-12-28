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
    ../stylix.nix
  ];

  home.packages = with pkgs; [
    bitwarden
    # Discord screensharing works poorly on hyprland, and you have a browser version of Discord.
    # discord
    galculator # Calculator
    obsidian # Markdown IDE
    spotify
    vscode
    pcmanfm # File manager
    eog # Image viewer
    totem # Media player
  ];

  # Japanese
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      # kdePackages.fcitx5-qt
      # fcitx5-gtk
      # fcitx5-mellow-themes
    ];
  };
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

    # Vim
    vim.enable = true;
  };
}
