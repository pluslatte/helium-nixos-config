{ pkgs, ... }:
{
  stylix = {
    iconTheme = {
      enable = true;
      package = pkgs.iconpack-obsidian;
      dark = "Obsidian";
      light = "Obsidian-Light";
    };
  };
}
