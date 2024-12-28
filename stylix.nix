{ pkgs, ... }:
{
  stylix = {
    enable = true;
    image = pkgs.fetchurl {
      # wallhaven-2e2xyx.jpg
      url = "https://gruvbox-wallpapers.pages.dev/wallpapers/anime/wallhaven-2e2xyx.jpg";
      sha256 = "sha256-mFp4f9WOBJcYDZjkU7QWIP793+8VhU6TrekuIDpSgf8=";
    };
    polarity = "dark";
    opacity.applications = 0.8;
    opacity.desktop = 0.8;
    opacity.popups = 0.8;
    opacity.terminal = 0.8;
    fonts = {
      sizes.applications = 14;
      sizes.desktop = 12;
      sizes.popups = 12;
      sizes.terminal = 14;
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.noto-fonts-cjk-sans;
        name = "Noto Sans CJK";
      };

      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
