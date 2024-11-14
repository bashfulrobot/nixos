# https://raw.githubusercontent.com/Gako358/dotfiles/6236f706279d2450606dfc99fecce9399936b7e7/home/programs/browser/teams.nix
{ user-settings, config, pkgs, lib, makeDesktopItem, ... }:

let
  cfg = config.apps.github;

  # Import the makeDesktopApp function
  makeDesktopApp = pkgs.callPackage ../../../lib/cbb-webwrap { };

  # I temp create an app in brave to download all the icons, then I place then in the correct folder
  githubApp = makeDesktopApp {
    name = "Github";
    url = "https://github.com/bashfulrobot/nixos";
    binary = "${pkgs.chromium}/bin/chromium";
    myStartupWMClass = "github.com__bashfulrobot_nixos";
    iconSizes = [ "32" "48" "64" "96" "128" "256" ];
    # iconSizes = [ "256" ]; # forcing large icon use
    iconPath = ./icons; # path to icons
    # Open In Browser vs Open as App
    useAppFlag = true;
  };

in {

  options = {
    apps.github.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the github app.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = [ githubApp.desktopItem ]
      ++ githubApp.icons;

    # home-manager.users."${user-settings.user.username}" = {

    # };
  };

}
