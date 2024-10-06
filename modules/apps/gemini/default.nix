# https://raw.githubusercontent.com/Gako358/dotfiles/6236f706279d2450606dfc99fecce9399936b7e7/home/programs/browser/teams.nix
{ user-settings, config, pkgs, lib, makeDesktopItem, ... }:

let
  cfg = config.apps.gemini;

  # Import the makeDesktopApp function
  makeDesktopApp = pkgs.callPackage ../../../lib/cbb-webwrap { };

  # I temp create an app in brave to download all the icons, then I place then in the correct folder
  geminiApp = makeDesktopApp {
    name = "Gemini";
    url = "https://gemini.google.com";
    binary = "${pkgs.google-chrome}/bin/google-chrome-stable";
    myStartupWMClass = "chrome-gemini.google.com__-Profile_4";
    iconSizes = [ "32" "48" "64" "96" "128" "256" "540" ];
    iconPath = ./icons; # path to icons
    # Open In Browser vs Open as App
    useAppFlag = true;
  };

in {

  options = {
    apps.gemini.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Gemini app.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = [ geminiApp.desktopItem ]
      ++ geminiApp.icons;

    # home-manager.users."${user-settings.user.username}" = {

    # };
  };

}
