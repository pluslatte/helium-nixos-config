{ pkgs, ... }:
let
  base00 = "#191724";
  base01 = "#1f1d2e";
  base02 = "#26233a";
  base03 = "#6e6a86";
  base04 = "#908caa";
  base05 = "#e0def4";
  base06 = "#e0def4";
  base07 = "#524f67";
  base08 = "#eb6f92";
  base09 = "#f6c177";
  base0A = "#ebbcba";
  base0B = "#31748f";
  base0C = "#9ccfd8";
  base0D = "#c4a7e7";
  base0E = "#f6c177";
  base0F = "#524f67";
  base02a = "rgba(38, 35, 58, 0.9)";
  base05a = "rgba(224, 222, 244, 1.0)";
  base07a = "rgba(82, 79, 103, 0.2)";
  base08a = "rgba(235, 111, 146, 0.2)";
in
{
  # Dependencies
  home.packages = with pkgs; [
    wofi # Launcher
    wofi-emoji # This is emoji picker. You'll want this when you want to type emoji somewhere.
  ];

  # Launcher wofi config
  home.file.".config/wofi/style.css".text = ''
    window {
      font-family: "FiraCode Nerd Font";
      font-weight: bold;
      margin: 0px;
      border-radius: 10px;
      background-color: ${base02a};
    }

    #input {
      all: unset;
      padding: 2px;
      border-radius: 6px;
      margin: 5px;
      border: none;
      color: ${base05a};
      background-color: ${base07a};
    }

    #inner-box {
      margin: 5px;
      border: none;
      background-color: transparent;
    }

    #outer-box {
      margin: 5px;
      border: none;
      background-color: transparent;
    }

    #scroll {
      margin: 0px;
      border: none;
    }

    #text {
      margin: 5px;
      border: none;
      color: ${base05a};
    }

    #entry {
      border: none;
    }

    #entry:focus {
      border: none;
    }

    #entry:selected {
      background-color: ${base08a};
      border-radius: 5px;
      border: none;
    }
  '';

}
