{ pkgs, ... }:
{
  # See this
  # https://stylix.danth.me/index.html
  # Note that home-manager only settings have to be separately imported to home.nix

  stylix = {
    enable = true;

    image = pkgs.fetchurl {
      # wallhaven-2e2xyx.jpg
      url = "https://gruvbox-wallpapers.pages.dev/wallpapers/anime/wallhaven-2e2xyx.jpg";
      sha256 = "sha256-mFp4f9WOBJcYDZjkU7QWIP793+8VhU6TrekuIDpSgf8=";
    };

    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    opacity.applications = 0.8;
    opacity.desktop = 0.8;
    opacity.popups = 0.8;
    opacity.terminal = 0.8;

    fonts = {
      sizes.applications = 12;
      sizes.desktop = 10;
      sizes.popups = 10;
      sizes.terminal = 14;
      serif = {
        # package = pkgs.dejavu_fonts;
        # name = "DejaVu Serif";
        package = pkgs.noto-fonts-cjk-serif;
        name = "Noto Serif CJK";
      };

      sansSerif = {
        package = pkgs.noto-fonts-cjk-sans;
        name = "Noto Sans CJK";
      };

      monospace = {
        package = pkgs.fira-code-nerdfont;
        name = "FiraCode Nerd Font";
      };

      emoji = {
        package = pkgs.fira-code-nerdfont;
        name = "FiraCode Nerd Font";
      };
    };
  };
}
