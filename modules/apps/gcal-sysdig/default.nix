# https://raw.githubusercontent.com/Gako358/dotfiles/6236f706279d2450606dfc99fecce9399936b7e7/home/programs/browser/teams.nix
{ user-settings, config, pkgs, lib, makeDesktopItem, ... }:

let
  cfg = config.apps.gcal-sysdig;

  # Import the makeDesktopApp function
  makeDesktopApp = pkgs.callPackage ../../../lib/cbb-webwrap { };

  # I temp create an app in brave to download all the icons, then I place then in the correct folder
  gcalSysdigApp = makeDesktopApp {
    name = "Sysdig Calendar";
    url = "https://calendar.google.com/calendar/u/1";
    binary = "${pkgs.chromium}/bin/chromium";
    myStartupWMClass = "chrome-calendar.google.com__calendar_u_1-Default";
    iconSizes = [ "32" "48" "64" "96" "128" "256" "512" ];
    # iconSizes = [ "256" ]; # forcing large icon use
    iconPath = ./icons; # path to icons
    # Open In Browser vs Open as App
    useAppFlag = true;
  };

in {

  options = {
    apps.gcal-sysdig.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Sysdig Google Calendar app.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = [ gcalSysdigApp.desktopItem ]
      ++ gcalSysdigApp.icons;

    # home-manager.users."${user-settings.user.username}" = {

    # };
  };

}
