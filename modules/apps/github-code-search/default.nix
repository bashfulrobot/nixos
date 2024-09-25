# https://raw.githubusercontent.com/Gako358/dotfiles/6236f706279d2450606dfc99fecce9399936b7e7/home/programs/browser/teams.nix
{ user-settings, config, pkgs, lib, makeDesktopItem, ... }:

let
  cfg = config.apps.github-code-search;

  # Import the makeDesktopApp function
  makeDesktopApp = pkgs.callPackage ../../../lib/cbb-webwrap { };

  # I temp create an app in brave to download all the icons, then I place then in the correct folder
  githubCodeSearchApp = makeDesktopApp {
    name = "Github Code Search";
    url = "https://github.com/search?type=code&auto_enroll=true";
    binary = "${pkgs.google-chrome}/bin/google-chrome-stable";
    myStartupWMClass = "chrome-github.com__search-Default";
    iconSizes = [ "32" "48" "64" "96" "128" "256" "512" ];
    # iconSizes = [ "256" ]; # forcing large icon use
    iconPath = ./icons; # path to icons
  };

in {

  options = {
    apps.github-code-search.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Github Code Search app.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = [ githubCodeSearchApp.desktopItem ]
      ++ githubCodeSearchApp.icons;

    # home-manager.users."${user-settings.user.username}" = {

    # };
  };

}
