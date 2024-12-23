{ user-settings, lib, inputs, pkgs, config, ... }:
let cfg = config.apps.vivaldi;

in {
  options = {
    apps.vivaldi.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable gnome-web (Epiphany) browser.";
    };

  };

  config = lib.mkIf cfg.enable {

    # use regular package
    environment.systemPackages = with pkgs; [ vivaldi-ffmpeg-codecs vivaldi ];

    home-manager.users."${user-settings.user.username}" = {
      dconf.settings = with inputs.home-manager.lib.hm.gvariant;
        {

          # "org/gnome/epiphany/web" = {
          #   enable-webextensions = true;
          #   ask-on-download = true;
          #   enable-mouse-gestures = true;
          # };
          # "org/gnome/epiphany" = {
          #   ask-for-default = false;
          #   default-search-engine = "Google";
          #   homepage-url = "https://google.ca/";
          # };
        };
    };
  };
}
