{ lib, inputs, ... }:
let
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";

in {
  home-manager.users."${username}" = {
    dconf.settings = with inputs.home-manager.lib.hm.gvariant; {

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
  };
}