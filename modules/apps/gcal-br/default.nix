# https://raw.githubusercontent.com/Gako358/dotfiles/6236f706279d2450606dfc99fecce9399936b7e7/home/programs/browser/teams.nix
{ user-settings, config, pkgs, lib, makeDesktopItem, ... }:

let
  cfg = config.apps.gcal-br;

  # Import the makeDesktopApp function
  makeDesktopApp = pkgs.callPackage ../../../lib/cbb-webwrap { };

  # I temp create an app in brave to download all the icons, then I place then in the correct folder
  gcalBashfulrobotApp = makeDesktopApp {
    name = "Bashfulrobot Calendar";
    url = "https://calendar.google.com/calendar/u/0";
    binary = "${pkgs.brave}/bin/brave";
    startupWMClass = "brave-calendar.google.com__calendar_u_0_r-Default";
    iconSizes = [ "32" "48" "64" "96" "128" "256" "512" ];
    # iconSizes = [ "256" ]; # forcing large icon use
    iconPath = ./icons; # path to icons
  };

in {

  options = {
    apps.gcal-br.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Bashfulrobot Google Calendar App.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = [ gcalBashfulrobotApp.desktopItem ]
      ++ gcalBashfulrobotApp.icons;

    # home-manager.users."${user-settings.user.username}" = {

    # };
  };

}
