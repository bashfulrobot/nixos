{ config, lib, ... }:

with lib.hm.gvariant;

{

  home.file."finalizer.png" = {
    source = ./../wallpapers/finalizer.png;
    target = ".local/share/backgrounds/finalizer.png";
  };

  dconf.settings = {

    "org/gnome/desktop/interface" = {
      cursor-theme = "Yaru";
      gtk-theme = "Gruvbox-Dark-BL-LB";
      icon-theme = "oomox-gruvbox-dark";
    };

    "org/gnome/desktop/sound" = { theme-name = "Yaru"; };

    "org/gnome/desktop/background" = {
      picture-uri = "file:///home/dustin/.local/share/backgrounds/finalizer.png";
      picture-uri-dark =
        "file:///home/dustin/.local/share/backgrounds/finalizer.png";
      color-shading-type = "solid";
      picture-options = "zoom";
      primary-color = "#000000";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/screensaver" = {
      picture-uri = "file:///home/dustin/.local/share/backgrounds/finalizer.png";
      color-shading-type = "solid";
      picture-options = "zoom";
      primary-color = "#000000";
      secondary-color = "#000000";
    };

    "org/gnome/shell/extensions/pop-shell" = {
      hint-color-rgba = "rgb(235, 219, 178)";
    };

    "org/gnome/shell/extensions/user-theme" = { name = "Gruvbox-Dark-BL-LB"; };

  };
}
