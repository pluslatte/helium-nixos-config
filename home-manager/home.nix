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
    bitwarden
    discord
    spotify
  ];

  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.src}";
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };
  # systemd.user.sessionVariables = config.home-manager.users."${username}".home.sessionVariables;
  # qt = {
  #   enable = true;
  #   platformTheme = "gnome";
  #   style = "adwaita-dark";
  # };

  # Shut up Discord update, I'm using NixOS.
  home.file.".config/discord/settings.json".text = ''
    {
      "SKIP_HOST_UPDATE": true
    }
  '';

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
