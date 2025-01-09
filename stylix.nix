{ config, pkgs, ... }:
{
  # See this
  # https://stylix.danth.me/index.html
  # Note that home-manager only settings have to be separately imported to home.nix

  stylix = {
    enable = true;

    image = pkgs.fetchurl {
      # wallpaper
      # https://github.com/rose-pine/neovim/issues/2
      url = "https://user-images.githubusercontent.com/1474821/128650757-51e5206b-b4e3-42f9-8f7a-5a1486347c8d.JPG";
      sha256 = "sha256-ewy9UVAoiChNQa91NsdRvlvltQiZT0g2nlMrdHx0Dmc=";
    };

    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

    opacity.applications = 0.82;
    opacity.desktop = 0.82;
    opacity.popups = 0.82;
    opacity.terminal = 0.82;

    cursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
      size = 34;
    };

    fonts = {
      sizes.applications = 12;
      sizes.desktop = 10;
      sizes.popups = 10;
      sizes.terminal = 12;
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
