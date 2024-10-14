# https://raw.githubusercontent.com/Gako358/dotfiles/6236f706279d2450606dfc99fecce9399936b7e7/home/programs/browser/teams.nix
{ user-settings, config, pkgs, lib, makeDesktopItem, ... }:

let
  cfg = config.apps.gmail-br;

  # Import the makeDesktopApp function
  makeDesktopApp = pkgs.callPackage ../../../lib/cbb-webwrap { };

  # I temp create an app in brave to download all the icons, then I place then in the correct folder
  gmailBashfulrobotApp = makeDesktopApp {
    name = "Bashfulrobot Mail";
    url = "https://mail.google.com/mail/u/0/#inbox";
    binary = "${pkgs.chromium}/bin/chromium";
    myStartupWMClass = "chrome-mail.google.com__mail_u_0_-Default";
    iconSizes = [ "32" "48" "64" "96" "128" "192" "256" "512" ];
    # iconSizes = [ "256" ]; # forcing large icon use
    iconPath = ./icons; # path to icons
    # Open In Browser vs Open as App
    useAppFlag = true;
  };

in {

  options = {
    apps.gmail-br.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Bashfulrobot Google Calendar app.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = [ gmailBashfulrobotApp.desktopItem ]
      ++ gmailBashfulrobotApp.icons;

    # home-manager.users."${user-settings.user.username}" = {

    # };
  };

}
