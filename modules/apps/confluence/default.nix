# https://raw.githubusercontent.com/Gako358/dotfiles/6236f706279d2450606dfc99fecce9399936b7e7/home/programs/browser/teams.nix
{ user-settings, config, pkgs, lib, makeDesktopItem, ... }:

let
  cfg = config.apps.confluence;

  # Import the makeDesktopApp function
  makeDesktopApp = pkgs.callPackage ../../../lib/cbb-webwrap { };

  # I temp create an app in brave to download all the icons, then I place then in the correct folder
  confluenceSysdigApp = makeDesktopApp {
    name = "Confluence";
    url = "https://sysdig.atlassian.net/wiki/spaces/~62200ee98a4bb60068f21eea/overview";
    binary = "${pkgs.chromium}/bin/chromium";
    myStartupWMClass = "chrome-sysdig.atlassian.net__wiki_spaces_~62200ee98a4bb60068f21eea_overview-Default";
    iconSizes = [ "16" "32" "48" "64" "96" "128" "256" ];
    # iconSizes = [ "256" ]; # forcing large icon use
    iconPath = ./icons; # path to icons
    # Open In Browser vs Open as App
    useAppFlag = true;
  };

in {

  options = {
    apps.confluence.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Sysdig jira app.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = [ confluenceSysdigApp.desktopItem ]
      ++ confluenceSysdigApp.icons;

    # home-manager.users."${user-settings.user.username}" = {

    # };
  };

}
