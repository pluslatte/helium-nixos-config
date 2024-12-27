{ pkgs, ... }:
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
      background-color: rgba(40, 40, 40, 0.9);
    }

    #input {
      all: unset;
      padding: 2px;
      border-radius: 6px;
      margin: 5px;
      border: none;
      color: #c8d3f5;
      background-color: rgba(80, 73, 69, 0.2);
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
      color: #ebdbb2;
    }

    #entry {
      border: none;
    }

    #entry:focus {
      border: none;
    }

    #entry:selected {
      background-color: rgba(214, 94, 14, 0.2);
      border-radius: 5px;
      border: none;
    }
  '';

}
