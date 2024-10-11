# https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/
{ user-settings, pkgs, config, lib, ... }:
let cfg = config.desktops.hyprland.mako;

in {
  options = {
    desktops.hyprland.mako.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable mako notifications.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = with pkgs;
      [

      ];

    home-manager.users."${user-settings.user.username}" = {

      services.mako = {
        sort = "-time";
        anchor = "top-center";
        borderRadius = 6;
        borderSize = 2;
        defaultTimeout = 5000;
        enable = true;
        layer = "overlay";
        icons = true;
        ignoreTimeout = true;
        padding = "14";
         margin = "20";
        maxIconSize = 64;

      };

    };
  };
}
