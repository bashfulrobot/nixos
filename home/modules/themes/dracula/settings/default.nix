{ config, lib, ... }:

with lib.hm.gvariant;

{

  home.file."dracula.png" = {
    source = ./../../wallpapers/dracula.png;
    target = ".local/share/backgrounds/dracula.png";
  };

  dconf.settings = {

    "org/gnome/desktop/interface" = {
      cursor-theme = "Yaru";
      gtk-theme = "dracula-gtk";
      icon-theme = "Yaru-purple-dark";
    };

    "org/gnome/desktop/sound" = { theme-name = "Yaru"; };

    "org/gnome/desktop/background" = {
      picture-uri = "file:///home/dustin/.local/share/backgrounds/dracula.png";
      picture-uri-dark =
        "file:///home/dustin/.local/share/backgrounds/dracula.png";
      color-shading-type = "solid";
      picture-options = "zoom";
      primary-color = "#000000";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/screensaver" = {
      picture-uri = "file:///home/dustin/.local/share/backgrounds/dracula.png";
      color-shading-type = "solid";
      picture-options = "zoom";
      primary-color = "#000000";
      secondary-color = "#000000";
    };

    "org/gnome/shell/extensions/pop-shell" = {
      hint-color-rgba = "rgb(141,118,191)";
    };

    "org/gnome/shell/extensions/user-theme" = { name = "dracula-gtk"; };

  };
}
