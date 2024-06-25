# https://raw.githubusercontent.com/Gako358/dotfiles/6236f706279d2450606dfc99fecce9399936b7e7/home/programs/browser/teams.nix
{ user-settings, config, pkgs, lib, makeDesktopItem, ... }:

let
  cfg = config.apps.apple-notes;

  # Import the makeDesktopApp function
  makeDesktopApp = pkgs.callPackage ../../../lib/cbb-webwrap { };

  # I temp create an app in brave to download all the icons, then I place then in the correct folder
  gcalBashfulrobotApp = makeDesktopApp {
    name = "Apple Notes";
    url = "https://www.icloud.com/notes/";
    binary = "${pkgs.brave}/bin/brave";
    startupWMClass = "brave-www.icloud.com__notes_-Default";
    iconSizes = [ "32" "48" "64" "96" "128" "256" ];
    # iconSizes = [ "256" ]; # forcing large icon use
    iconPath = ./icons; # path to icons
  };

in {

  options = {
    apps.apple-notes.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Bashfulrobot Google Calendar app.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = [ gcalBashfulrobotApp.desktopItem ]
      ++ gcalBashfulrobotApp.icons;

    # home-manager.users."${user-settings.user.username}" = {

    # };
  };

}
