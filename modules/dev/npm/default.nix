{ pkgs, config, lib, ... }:
let
cfg = config.dev.npm;
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  options = {
    dev.npm.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable NPM tooling.";
    };
  };

  config = lib.mkIf cfg.enable {
  home-manager.users."${username}" = {
    home.file.".npmrc".text = ''
      prefix = ~/.npm-packages

    '';
  };
  };
}
