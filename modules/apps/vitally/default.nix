# https://raw.githubusercontent.com/Gako358/dotfiles/6236f706279d2450606dfc99fecce9399936b7e7/home/programs/browser/teams.nix
{ user-settings, config, pkgs, lib, makeDesktopItem, ... }:

let
  cfg = config.apps.vitally;

  # I temp create an app in brave to download all the icons, then I place then in the correct folder
  iconSizes = [ "32" "48" "64" "96" "128" "240" "256" ];

  desktopItem = pkgs.makeDesktopItem {
    type = "Application";
    name = "vitally";
    desktopName = "Vitally";
    # Open the app, and then run: get_wm_class (my fish function)

    startupWMClass = "brave-sysdig.vitally.io__hubs_553ec776-875e-4a0e-a096-a3da3a0b6ea1_8acc40cb-e3ea-4da8-9570-4be27a10fff6-Default";
    exec = ''
      brave --ozone-platform-hint=auto --force-dark-mode --enable-features=WebUIDarkMode --new-window --app="https://sysdig.vitally.io/hubs/553ec776-875e-4a0e-a096-a3da3a0b6ea1/8acc40cb-e3ea-4da8-9570-4be27a10fff6" %U'';
    icon = "vitally";
    categories = [ "Office" ];
  };

  vitally-icons = map (size:
    pkgs.stdenv.mkDerivation {
      name = "vitally-icon-${size}";
      src = ./icons/${size}.png;
      phases = [ "installPhase" ];
      installPhase = ''
        # mkdir -p $out/logs
        # touch $out/logs/vitally.log
        # echo "out: $out" > $out/vitally.log
        mkdir -p $out/share/icons/hicolor/${size}x${size}/apps
        cp $src $out/share/icons/hicolor/${size}x${size}/apps/vitally.png
      '';
    }) iconSizes;

in {

  options = {
    apps.vitally.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the Vitally CS App.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = [ desktopItem ] ++ vitally-icons;

    # home-manager.users."${user-settings.user.username}" = {

    # };
  };

}
