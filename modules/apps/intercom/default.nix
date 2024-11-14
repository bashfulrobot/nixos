# https://raw.githubusercontent.com/Gako358/dotfiles/6236f706279d2450606dfc99fecce9399936b7e7/home/programs/browser/teams.nix
{ user-settings, config, pkgs, lib, makeDesktopItem, ... }:

let
  cfg = config.apps.intercom;

  # Import the makeDesktopApp function
  makeDesktopApp = pkgs.callPackage ../../../lib/cbb-webwrap { };

  # I temp create an app in brave to download all the icons, then I place then in the correct folder
  intercomApp = makeDesktopApp {
    name = "Intercom";
    url = "https://app.intercom.com/a/inbox/tdx7wtfd/inbox/team/3988200";
    binary = "${pkgs.chromium}/bin/chromium";
    myStartupWMClass = "app.intercom.com__a_inbox_tdx7wtfd_inbox_team_3988200";
    iconSizes = [ "32" "48" "64" "96" "128" "256"];
    # iconSizes = [ "256" ]; # forcing large icon use
    iconPath = ./icons; # path to icons
    # Open In Browser vs Open as App
    useAppFlag = true;
  };

in {

  options = {
    apps.intercom.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Intercom app.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = [ intercomApp.desktopItem ]
      ++ intercomApp.icons;

    # home-manager.users."${user-settings.user.username}" = {

    # };
  };

}
