# https://raw.githubusercontent.com/Gako358/dotfiles/6236f706279d2450606dfc99fecce9399936b7e7/home/programs/browser/teams.nix
{ user-settings, config, pkgs, lib, makeDesktopItem, ... }:

let
  cfg = config.apps.vitally;

  # Import the makeDesktopApp function
  makeDesktopApp = pkgs.callPackage ../../../lib/cbb-webwrap { };

  # I temp create an app in brave to download all the icons, then I place then in the correct folder
  nixosSearchApp = makeDesktopApp {
    name = "Vitally";
    url = "https://sysdig.vitally.io/hubs/553ec776-875e-4a0e-a096-a3da3a0b6ea1/8acc40cb-e3ea-4da8-9570-4be27a10fff6";
    binary = "${pkgs.chromium}/bin/chromium";
    myStartupWMClass = "sysdig.vitally.io__hubs_553ec776-875e-4a0e-a096-a3da3a0b6ea1_8acc40cb-e3ea-4da8-9570-4be27a10fff6";
    iconSizes = ["32" "48" "64" "96" "128" "256" ];
    # iconSizes = [ "256" ]; # forcing large icon use
    iconPath = ./icons; # path to icons
    # iconPath = ././modules/apps/nixos-search/icons; # path to icons
    # Open In Browser vs Open as App
    useAppFlag = true;
  };

in {

  options = {
    apps.vitally.enable = lib.mkOption {
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
