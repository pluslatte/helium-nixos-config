{ pkgs, ... }:
{
  # Audio visualizer

  home.packages = [ pkgs.cava ];

  # https://github.com/rose-pine/cava
  home.file.".config/cava/config".source = ./cava_config.toml;
}
