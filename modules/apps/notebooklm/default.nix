# https://raw.githubusercontent.com/Gako358/dotfiles/6236f706279d2450606dfc99fecce9399936b7e7/home/programs/browser/teams.nix
{ user-settings, config, pkgs, lib, makeDesktopItem, ... }:

let
  cfg = config.apps.notebooklm;

  # Import the makeDesktopApp function
  makeDesktopApp = pkgs.callPackage ../../../lib/cbb-webwrap { };

  # I temp create an app in brave to download all the icons, then I place then in the correct folder
  notebookLmApp = makeDesktopApp {
    name = "NotebookLM";
    url = "https://notebooklm.google.com";
    binary = "${pkgs.google-chrome}/bin/google-chrome-stable";
    myStartupWMClass = "chrome-notebooklm.google.com__-Profile_4";
    iconSizes = [ "16" "32" "48" "64" "96" "128" "256" ];
    iconPath = ./icons; # path to icons
  };

in {

  options = {
    apps.notebooklm.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the NotebookLM app.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = [ notebookLmApp.desktopItem ]
      ++ notebookLmApp.icons;

    # home-manager.users."${user-settings.user.username}" = {

    # };
  };

}
