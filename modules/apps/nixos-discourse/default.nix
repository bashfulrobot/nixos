# https://raw.githubusercontent.com/Gako358/dotfiles/6236f706279d2450606dfc99fecce9399936b7e7/home/programs/browser/teams.nix
{ user-settings, config, pkgs, lib, makeDesktopItem, ... }:

let
  cfg = config.apps.nixos-discourse;

  # Import the makeDesktopApp function
  makeDesktopApp = pkgs.callPackage ../../../lib/cbb-webwrap { };

  # I temp create an app in brave to download all the icons, then I place then in the correct folder
  nixosDiscourseApp = makeDesktopApp {
    name = "NixOS Discourse";
    url = "https://discourse.nixos.org/";
    binary = "${pkgs.chromium}/bin/chromium";
    myStartupWMClass = "chrome-discourse.nixos.org__-Default";
    iconSizes = [ "32" "48" "64" "96" "128" "256" ];
    # iconSizes = [ "256" ]; # forcing large icon use
    iconPath = ./icons; # path to icons
    # Open In Browser vs Open as App
    useAppFlag = true;
  };

in {

  options = {
    apps.nixos-discourse.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the NixOS Discourse app.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = [ nixosDiscourseApp.desktopItem ]
      ++ nixosDiscourseApp.icons;

    # home-manager.users."${user-settings.user.username}" = {

    # };
  };

}
