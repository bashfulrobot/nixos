# https://raw.githubusercontent.com/Gako358/dotfiles/6236f706279d2450606dfc99fecce9399936b7e7/home/programs/browser/teams.nix
{ user-settings, config, pkgs, lib, makeDesktopItem, ... }:

let
  cfg = config.apps.nixpkgs-search;

  # Import the makeDesktopApp function
  makeDesktopApp = pkgs.callPackage ../../../lib/cbb-webwrap { };

  # I temp create an app in brave to download all the icons, then I place then in the correct folder
  nixosSearchApp = makeDesktopApp {
    name = "Nixpkgs Search";
    url = "https://search.nixos.org/packages";
    binary = "${pkgs.chromium}/bin/chromium";
    myStartupWMClass = "chrome-search.nixos.org__packages-Default";
    iconSizes = [ "16" "32" "64" "96" "128" "256" ];
    # iconSizes = [ "256" ]; # forcing large icon use
    iconPath = ./icons; # path to icons
    # iconPath = ././modules/apps/nixos-search/icons; # path to icons
    # Open In Browser vs Open as App
    useAppFlag = true;
  };

in {

  options = {
    apps.nixpkgs-search.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the nixpkgs search app.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = [ nixosSearchApp.desktopItem ]
      ++ nixosSearchApp.icons;

    # home-manager.users."${user-settings.user.username}" = {

    # };
  };

}
