{ user-settings, config, pkgs, lib, makeDesktopItem, ... }:

let
  cfg = config.apps.whatsapp;

  # Import the makeDesktopApp function
  makeDesktopApp = pkgs.callPackage ../../../lib/cbb-webwrap { };

  # I temp create an app in brave to download all the icons, then I place then in the correct folder
  whatsappWebApp = makeDesktopApp {
    name = "Whatsapp";
    url = "https://web.whatsapp.com/";
    binary = "${pkgs.chromium}/bin/chromium";
    myStartupWMClass = "chrome-web.whatsapp.com__-Default";
    iconSizes = ["32" "48" "64" "96" "128" "256" ];
    # iconSizes = [ "256" ]; # forcing large icon use
    iconPath = ./icons; # path to icons
    # iconPath = ././modules/apps/nixos-search/icons; # path to icons
  };

in {

  options = {
    apps.whatsapp.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable whatsapp.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = [ whatsappWebApp.desktopItem ]
      ++ whatsappWebApp.icons;

    # home-manager.users."${user-settings.user.username}" = {

    # };
  };

}
