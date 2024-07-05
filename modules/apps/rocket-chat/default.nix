# https://raw.githubusercontent.com/Gako358/dotfiles/6236f706279d2450606dfc99fecce9399936b7e7/home/programs/browser/teams.nix
{ user-settings, config, pkgs, lib, makeDesktopItem, ... }:

let
  cfg = config.apps.rocket-chat;

  # Import the makeDesktopApp function
  makeDesktopApp = pkgs.callPackage ../../../lib/cbb-webwrap { };

  # I temp create an app in brave to download all the icons, then I place then in the correct folder
  rocketchatApp = makeDesktopApp {
    name = "Rocket Chat";
    url = "https://chat.developer.gov.bc.ca/channel/devops-sysdig";
    binary = "${pkgs.brave}/bin/brave";
    myStartupWMClass = "brave-calendar.google.com__calendar_u_0_r-Default";
    iconSizes = [ "32" "48" "64" "96" "128" "256" "512" ];
    # iconSizes = [ "256" ]; # forcing large icon use
    iconPath = ./icons; # path to icons
  };

in {

  options = {
    apps.rocket-chat.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Rocket Chat app.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = [ rocketchatApp.desktopItem ]
      ++ rocketchatApp.icons;

    # home-manager.users."${user-settings.user.username}" = {

    # };
  };

}
