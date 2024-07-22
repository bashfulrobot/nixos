{ user-settings, pkgs, config, lib, inputs, ... }:
let

  cfg = config.desktops.hyprland.mako;

in {

  options = {
    desktops.hyprland.mako.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Mako in Hyprland Desktop";
    };
  };
  config = lib.mkIf cfg.enable {

    ##### Home Manager Config options #####
    home-manager.users."${user-settings.user.username}" = {
      services.mako = {
        enable = true;
        defaultTimeout = 5000;
        backgroundColor = "#504945";
        borderColor = "#d3869b";
        borderRadius = 5;
        borderSize = 2;
        textColor = "#bdae93";
        # layer = "overlay";
        padding = "10,5,10,10";
      };
    };
  };

}
