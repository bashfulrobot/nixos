{ pkgs, lib, config, ... }:

with lib;
let cfg = config.desktops.hyprland.wofi;

in {
  options = {
    desktops.hyprland.wofi.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable wofi on hyprland";
    };
  };
  config = mkIf cfg.enable {
    ##### Home Manager Config options #####
    home-manager.users."${user-settings.user.username}" = {
      home.file.".config/wofi.css".source = ./build/cfg/wofi/wofi.css;
    };
  };
}
