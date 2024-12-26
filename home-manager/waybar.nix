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

  home.file.".config/waybar/style.css".text = ''
    * {
        font-family: "FiraCode Nerd Font", monospace;
        font-size: 20px;
        border: 4px;
        padding: 0;
        margin: 0;
    }

    window#waybar {
        background-color: #282828;
        color: #ebdbb2;
    }

    #clock,
    #memory,
    #cpu,
    #network,
    #battery,
    #tray {
        padding: 0 10px;
    }

    #clock {
        background-color: #d79921;
        border-radius: 5px;
    }

    #battery {
        background-color: #cc241d;
        border-radius: 5px;
    }

    #cpu {
        background-color: #458588;
        border-radius: 5px;
    }

    #memory {
        background-color: #b16286;
        border-radius: 5px;
    }

    #network {
        background-color: #689d6a;
        border-radius: 5px;
    }

    #tray {
        background-color: #d65d0e;
        border-radius: 5px;
    }

    #workspaces button {
        background: transparent;
        border: none;
        padding: 5px 10px;
        border-radius: 5px;
        transition: background-color 0.3s;
    }

    #workspaces button.focused {
        background-color: #d79921;
    }

    #workspaces button:hover {
        background-color: rgba(255, 255, 255, 0.2);
    }
  '';
}
