{ pkgs, ... }:
{
  home.packages = with pkgs; [
    waybar
  ];

  home.file.".config/waybar/config".text = ''
    {
      "layer": "top",
      "position": "bottom",
      "height": 30,
      "modules-left": ["hyprland/workspaces"],
      "modules-center": ["clock", "hyprland/window"],
      "modules-right": [
        "idle_inhibitor",
        "pulseaudio",
        "network",
        "cpu",
        "memory",
        "temperature",
        "backlight",
        "keyboard-state",
        "battery",
        "tray"
      ]
    }
  '';

  home.file.".config/waybar/style.css".text = '''';
}
