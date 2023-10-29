{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      font-hinting = "full";
      font-antialiasing = "rgba";
      gtk-theme = "Yaru-blue-dark";
      icon-theme = "Yaru-bark-dark";
      cursor-theme = "Yaru";
      locate-pointer = true;
    };

    "org/gnome/desktop/background" = {
      picture-uri =
        "file:///home/dustin/Pictures/bluefin/WallPaper_SpringNight_Post.webp";
    };

    "org/gnome/desktop/screensaver" = {
      picture-uri =
        "file:///home/dustin/Pictures/bluefin/WallPaper_AutumnNight_Post.webp";
    };

    "org/gnome/mutter" = { center-new-windows = true; };

    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/peripherals/mouse" = { natural-scroll = true; };

    "org/gnome/settings-daemon/plugins/color" = { night-light-enabled = true; };

    "org/gnome/shell" = {
      enabled-extensions =
        "['user-theme@gnome-shell-extensions.gcampax.github.com']";
    };

    "org/gnome/shell/extensions/user-theme" = { name = "Yaru-blue-dark"; };

    "org/gnome/desktop/wm/keybindings" = { close = [ "<Super>q" ]; };

  };
}
