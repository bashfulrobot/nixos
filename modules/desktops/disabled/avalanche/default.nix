{ user-settings, pkgs, config, lib, inputs, ... }:
let
  cfg = config.desktops.avalanche;
  # Used in my home manager code at the bottom of the file.

in {
  options = {
    desktops.avalanche.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Avalanche Desktop";
    };
  };

  config = lib.mkIf cfg.enable {
    snowfallorg.avalanche.desktop.enable = true;
    home-manager.users."${user-settings.user.username}" = {

    };
  };
}
