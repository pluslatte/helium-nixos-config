{ ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        no_fade_in = false;
        grace = 0;
        disable_loading_bar = false;
      };

      background = {
        monitor = ""; # I think this means every monitor.
        path = "screenshot"; # Use current screen as a background image.
        blur_passes = 3;
        blur_size = 4;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };
    };
  };
}
