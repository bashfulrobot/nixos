{ pkgs, config, lib, ... }:
let
  cfg = config.cli.instruqt;
  instruqt = pkgs.callPackage ./build { };
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";

in {
  options = {
    cli.instruqt.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Instruqt CLI.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users."${username}" = {
      home.packages = with pkgs; [ instruqt ];
    };
  };
}
