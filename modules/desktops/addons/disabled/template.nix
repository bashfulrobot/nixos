# { lib, config, inputs, pkgs, ... }:
{ pkgs, config, lib, inputs, ... }:
let
  cfg = config.desktops.addons.waybar;
  # Used in my home manager code at the bottom of the file.
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  options = {
    desktops.addons.waybar.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable waybar barr";
    };
  };

  config = lib.mkIf cfg.enable {

    home-manager.users."${username}" = {

    };
  };
}
