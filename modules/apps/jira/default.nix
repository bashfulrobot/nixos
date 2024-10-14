# https://raw.githubusercontent.com/Gako358/dotfiles/6236f706279d2450606dfc99fecce9399936b7e7/home/programs/browser/teams.nix
{ user-settings, config, pkgs, lib, makeDesktopItem, ... }:

let
  cfg = config.apps.jira;

  # Import the makeDesktopApp function
  makeDesktopApp = pkgs.callPackage ../../../lib/cbb-webwrap { };

  # I temp create an app in brave to download all the icons, then I place then in the correct folder
  jiraSysdigApp = makeDesktopApp {
    name = "Jira";
    url = "https://sysdig.atlassian.net/jira/software/c/projects/FR/issues?jql=project%20%3D%20%22FR%22%20ORDER%20BY%20created%20DESC";
    binary = "${pkgs.chromium}/bin/chromium";
    myStartupWMClass = "chrome-sysdig.atlassian.net__jira_software_c_projects_FR_issues-Default";
    iconSizes = [ "16" "32" "48" "64" "96" "128" "256" ];
    # iconSizes = [ "256" ]; # forcing large icon use
    iconPath = ./icons; # path to icons
    # Open In Browser vs Open as App
    useAppFlag = true;
  };

in {

  options = {
    apps.jira.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Sysdig jira app.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = [ jiraSysdigApp.desktopItem ]
      ++ jiraSysdigApp.icons;

    # home-manager.users."${user-settings.user.username}" = {

    # };
  };

}
