{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {

    "org/gnome/epiphany/web" = {
      enable-webextensions = true;
      ask-on-download = true;
      enable-mouse-gestures = true;
    };
    "org/gnome/epiphany" = {
      ask-for-default = false;
      default-search-engine = "Google";
      homepage-url = "https://google.ca/";
    };
  };
}
