{ config, lib, ... }:

with lib.hm.gvariant;

{

  home.file."k-thx-bye.jpg" = {
    source = ./../../wallpapers/k-thx-bye.jpg;
    target = ".local/share/backgrounds/k-thx-bye.jpg";
  };

  dconf.settings = {

    "org/gnome/desktop/interface" = {
      cursor-theme = "Yaru";
      gtk-theme = "Yaru-bark-dark";
      icon-theme = "Yaru-bark-dark";
    };

    "org/gnome/desktop/sound" = { theme-name = "Yaru"; };

    "org/gnome/desktop/background" = {
      picture-uri = "file:///home/dustin/.local/share/backgrounds/k-thx-bye.jpg";
      picture-uri-dark =
        "file:///home/dustin/.local/share/backgrounds/k-thx-bye.jpg";
      color-shading-type = "solid";
      picture-options = "zoom";
      primary-color = "#000000";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/screensaver" = {
      picture-uri = "file:///home/dustin/.local/share/backgrounds/k-thx-bye.jpg";
      color-shading-type = "solid";
      picture-options = "zoom";
      primary-color = "#000000";
      secondary-color = "#000000";
    };

    "org/gnome/shell/extensions/pop-shell" = {
      hint-color-rgba = "rgb(134, 138, 140)";
    };

    "org/gnome/shell/extensions/user-theme" = { name = "Yaru-bark-dark"; };

  };
}
