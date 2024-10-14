# https://raw.githubusercontent.com/Gako358/dotfiles/6236f706279d2450606dfc99fecce9399936b7e7/home/programs/browser/teams.nix
{ user-settings, config, pkgs, lib, makeDesktopItem, ... }:

let
  cfg = config.apps.nixos-wiki;

  # Import the makeDesktopApp function
  makeDesktopApp = pkgs.callPackage ../../../lib/cbb-webwrap { };

  # I temp create an app in brave to download all the icons, then I place then in the correct folder
  nixosWikiApp = makeDesktopApp {
    name = "Nixos Wiki";
    url = "https://wiki.nixos.org/wiki/NixOS_Wiki";
    binary = "${pkgs.chromium}/bin/chromium";
    myStartupWMClass = "chrome-wiki.nixos.org__wiki_NixOS_Wiki-Default";
    iconSizes = [ "16" "32" "64" "96" "128" "256" ];
    # iconSizes = [ "256" ]; # forcing large icon use
    iconPath = ./icons; # path to icons
    # iconPath = ././modules/apps/nixos-search/icons; # path to icons
    # Open In Browser vs Open as App
    useAppFlag = true;
  };

in {

  options = {
    apps.nixos-wiki.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the nixos wiki app.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = [ nixosWikiApp.desktopItem ]
      ++ nixosWikiApp.icons;

    # home-manager.users."${user-settings.user.username}" = {

    # };
  };

}
