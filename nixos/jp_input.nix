{ pkgs, ... }:
{
  # Japanese
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      # kdePackages.fcitx5-qt
      # fcitx5-mellow-themes
    ];
    fcitx5.waylandFrontend = true;
  };

  # Internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "jp106";
}
