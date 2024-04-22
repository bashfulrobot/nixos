{ pkgs, inputs, ... }:
let
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  home-manager.users."${username}" = {
    home.file."nord-wallpaper.png" = {
      source = ./../../wallpapers/nord-wallpaper.png;
      target = ".local/share/backgrounds/nord-wallpaper.png";
    };

    dconf.settings = with inputs.home-manager.lib.hm.gvariant; {

      "org/gnome/desktop/interface" = {
        cursor-theme = "Nordzy-cursors";
        gtk-theme = "Nordic-darker";
        icon-theme = "Nordzy-dark";
      };

      "org/gnome/desktop/sound" = { theme-name = "Yaru"; };

      "org/gnome/desktop/background" = {
        picture-uri =
          "file:///home/dustin/.local/share/backgrounds/nord-wallpaper.png";
        picture-uri-dark =
          "file:///home/dustin/.local/share/backgrounds/nord-wallpaper.png";
        color-shading-type = "solid";
        picture-options = "zoom";
        primary-color = "#000000";
        secondary-color = "#000000";
      };

      "org/gnome/desktop/screensaver" = {
        picture-uri =
          "file:///home/dustin/.local/share/backgrounds/nord-wallpaper.png";
        color-shading-type = "solid";
        picture-options = "zoom";
        primary-color = "#000000";
        secondary-color = "#000000";
      };

      "org/gnome/shell/extensions/pop-shell" = {
        hint-color-rgba = "rgb(129, 161, 193)";
      };

      "org/gnome/shell/extensions/user-theme" = { name = "Nordic-darker"; };

    };
  };
}
