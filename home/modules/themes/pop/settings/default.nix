{ config, lib, ... }:

with lib.hm.gvariant;

{

  home.file."pop.jpg" = {
    source = ./pop.jpg;
    target = ".local/share/backgrounds/pop.jpg";
  };

  dconf.settings = {

    "org/gnome/desktop/interface" = {
      cursor-theme = "Yaru";
      gtk-theme = "Pop-dark";
      icon-theme = "Yaru-bark-dark";
      show-battery-percentage = true;
    };


    "org/gnome/desktop/sound" = { theme-name = "Yaru"; };

    "org/gnome/desktop/background" = {
      picture-uri = "file:///home/dustin/.local/share/backgrounds/pop.jpg";
      picture-uri-dark = "file:///home/dustin/.local/share/backgrounds/pop.jpg";
      color-shading-type = "solid";
      picture-options = "zoom";
      primary-color = "#000000";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/screensaver" = {
      picture-uri = "file:///home/dustin/.local/share/backgrounds/pop.jpg";
      color-shading-type = "solid";
      picture-options = "zoom";
      primary-color = "#000000";
      secondary-color = "#000000";
    };

    "org/gnome/shell/extensions/user-theme" = { name = "Pop"; };

  };
}
