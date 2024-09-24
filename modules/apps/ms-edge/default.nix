{ user-settings, lib, inputs, pkgs, config, ... }:
let cfg = config.apps.ms-edge;

in {
  options = {
    apps.ms-edge.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable MS Edge browser.";
    };

  };

  config = lib.mkIf cfg.enable {

    # use regular package
    environment.systemPackages = with pkgs; [  microsoft-edge ];

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
