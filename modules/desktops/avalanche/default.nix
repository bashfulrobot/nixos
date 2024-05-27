# { lib, config, inputs, pkgs, ... }:
{ pkgs, config, lib, inputs, ... }:
let
  cfg = config.desktops.avalanche;
  # Used in my home manager code at the bottom of the file.
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
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
    home-manager.users."${username}" = {

    };
  };
}
