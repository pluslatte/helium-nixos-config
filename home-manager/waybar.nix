{ pkgs, ... }:
{
  home.packages = with pkgs; [
    waybar
  ];

  # Mostly based on https://github.com/Egosummiki/dotfiles/blob/master/waybar/config

  home.file.".config/waybar/config".text = ''
    {
      "layer": "top",
      "position": "top",
      "height": 28,
      "modules-left": ["hyprland/workspaces"],
      "modules-center": ["hyprland/window"],
      "modules-right": [
        "pulseaudio",
        "network",
        "cpu",
        "memory",
        "battery",
        "tray",
        "clock"
      ],

      // modules settings
      "tray": {
        "spacing": 10
      },

      "clock": {
        "format-alt": "{:%Y-%m-%d}"
      },

      "cpu": {
        "format": " {usage}%"
      },

      "memory": {
          "format": " {}%"
      },

      "battery": {
          // "bat": "BAT0",
          "states": {
              // "good": 95,
              "warning": 30,
              "critical": 15
          },
          "format": "{icon} {capacity}%",
          // "format-good": "", // An empty format will hide the module
          // "format-full": "",
          "format-icons": ["", "", "", "", ""]
      },

      "network": {
          // "interface": "wlp2s0", // (Optional) To force the use of this interface
          "format-wifi": " {essid} ({signalStrength}%)",
          "format-ethernet": " {ifname}: {ipaddr}/{cidr}",
          "format-disconnected": "⚠ Disconnected"
      },

      "pulseaudio": {
          //"scroll-step": 1,
          "format": "{icon} {volume}%",
          "format-bluetooth": "{icon} {volume}%",
          "format-muted": "",
          "format-icons": {
              "headphones": "",
              "handsfree": "",
              "headset": "",
              "phone": "",
              "portable": "",
              "car": "",
              "default": ["", ""]
          },
          "on-click": "pavucontrol"
      },

      /*
      "custom/spotify": {
          "format": " {}",
          "max-length": 40,
          "interval": 30, // Remove this if your script is endless and write in loop
          "exec": "$HOME/.config/waybar/mediaplayer.sh 2> /dev/null", // Script in resources folder
          "exec-if": "pgrep spotify"
      }
      */
    }
  '';

  home.file.".config/waybar/style.css".text = ''
    * {
        font-family: "FiraCode Nerd Font", monospace;
        font-size: 18px;
        border: none;
        border-radius: 0;
        min-height: 0;
    }

    window#waybar {
        background-color: rgba(40, 40, 40, 0.75);
        color: white;
    }

    #window {
        font-weight: bold;
        font-family: "FiraCode Nerd Font";
    }

    #workspaces button {
        padding: 0 5px;
        background: transparent;
        color: white;
        border-top: 2px solid transparent;
    }

    #workspaces button.focused {
        color: #c9545d;
        border-top: 2px solid #c9545d;
    }

    #mode {
        background: #64727D;
        border-bottom: 3px solid white;
    }

    #clock,
    #memory,
    #cpu,
    #network,
    #pulseaudio,
    #battery,
    #tray,
    #mode {
        padding: 3px;
        margin: 2px;
    }

    #clock {
        font-weight: bold;
    }

    #battery {
    }

    #battery.icon {
        color: red;
    }

    #battery.charging {
    }

    @keyframes blink {
        to {
            background-color: #ffffff;
            color: black;
        }
    }

    #battery.warning:not(.charging) {
        color: white;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
    }

    #cpu {
    }

    #memory {
    }

    #network {
    }

    #network.disconnected {
        background: #f53c3c;
    }

    #pulseaudio {
    }

    #pulseaudio.muted {
    }

    #custom-spotify {
        color: rgb(102, 220, 105);
    }

    #tray {
    }
  '';
}
