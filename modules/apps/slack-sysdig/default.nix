# https://raw.githubusercontent.com/Gako358/dotfiles/6236f706279d2450606dfc99fecce9399936b7e7/home/programs/browser/teams.nix
{ user-settings, config, pkgs, lib, makeDesktopItem, ... }:

let
  cfg = config.apps.slack-sysdig;

  # Import the makeDesktopApp function
  makeDesktopApp = pkgs.callPackage ../../../lib/cbb-webwrap { };

  # I temp create an app in brave to download all the icons, then I place then in the correct folder
  sysdigSlackWebApp = makeDesktopApp {
    name = "Sysdig Slack";
    url = "https://app.slack.com/client/T03A6N692";
    binary = "${pkgs.google-chrome}/bin/google-chrome-stable";
    myStartupWMClass = "chrome-app.slack.com__client_T03A6N692-Profile_4";
    iconSizes = ["32" "48" "64" "96" "128" "256" ];
    # iconSizes = [ "256" ]; # forcing large icon use
    iconPath = ./icons; # path to icons
    # iconPath = ././modules/apps/nixos-search/icons; # path to icons
  };

in {

  options = {
    apps.slack-sysdig.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the sysdig slack web app.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = [ sysdigSlackWebApp.desktopItem ]
      ++ sysdigSlackWebApp.icons;

    # home-manager.users."${user-settings.user.username}" = {

    # };
  };

}
