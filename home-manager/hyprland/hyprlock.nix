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

      input-field = {
        monitor = "";
        size = "200, 60";
        outline_thickness = 4;
        dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true;
        outer_color = "rgba(255, 255, 255, 0)";
        inner_color = "rgba(255, 255, 255, 0.1)";
        font_color = "rgb(200, 200, 200)";
        fade_on_empty = false;
        font_family = "FiraCode Nerd Font";
        placeholder_text = "<i><span foreground='##ffffff99'>password...</span></i>";
        hide_input = true;
        position = "0, 0";
        halign = "center";
        valign = "center";
      };
    };
  };
}
