# https://raw.githubusercontent.com/Gako358/dotfiles/6236f706279d2450606dfc99fecce9399936b7e7/home/programs/browser/teams.nix
{ user-settings, config, pkgs, lib, makeDesktopItem, ... }:

let
  cfg = config.apps.gmail-sysdig;

  # Import the makeDesktopApp function
  makeDesktopApp = pkgs.callPackage ../../../lib/cbb-webwrap { };

  # I temp create an app in brave to download all the icons, then I place then in the correct folder
  gmailSysdigApp = makeDesktopApp {
    name = "Sysdig Mail";
    url = "https://mail.google.com/mail/u/1/#inbox";
    binary = "${pkgs.chromium}/bin/chromium";
    myStartupWMClass = "mail.google.com__mail_u_1";
    iconSizes = [ "32" "48" "64" "96" "128" "192" "256" "512" ];
    # iconSizes = [ "256" ]; # forcing large icon use
    iconPath = ./icons; # path to icons
    # Open In Browser vs Open as App
    useAppFlag = true;
  };

in {

  options = {
    apps.gmail-sysdig.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Sysdig Google Calendar app.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = [ gmailSysdigApp.desktopItem ]
      ++ gmailSysdigApp.icons;

    # home-manager.users."${user-settings.user.username}" = {

    # };
  };

}
