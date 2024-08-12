# https://raw.githubusercontent.com/Gako358/dotfiles/6236f706279d2450606dfc99fecce9399936b7e7/home/programs/browser/teams.nix
{ user-settings, config, pkgs, lib, makeDesktopItem, ... }:

let
  cfg = config.apps.slack-cilium;

  # Import the makeDesktopApp function
  makeDesktopApp = pkgs.callPackage ../../../lib/cbb-webwrap { };

  # I temp create an app in brave to download all the icons, then I place then in the correct folder
  ciliumSlackWebApp = makeDesktopApp {
    name = "Cilium Slack";
    url = "https://app.slack.com/client/T1MATJ4SZ";
    binary = "${pkgs.chromium}/bin/chromium";
    myStartupWMClass = "chrome-app.slack.com__client_T1MATJ4SZ-Default";
    iconSizes = ["32" "48" "64" "96" "128" "256" ];
    # iconSizes = [ "256" ]; # forcing large icon use
    iconPath = ./icons; # path to icons
    # iconPath = ././modules/apps/nixos-search/icons; # path to icons
  };

in {

  options = {
    apps.slack-cilium.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the sysdig slack web app.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = [ ciliumSlackWebApp.desktopItem ]
      ++ ciliumSlackWebApp.icons;

    # home-manager.users."${user-settings.user.username}" = {

    # };
  };

}
