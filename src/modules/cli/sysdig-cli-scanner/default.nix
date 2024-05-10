{ pkgs, config, lib, ... }:

let
  cfg = config.cli.sysdig-cli-scanner;
  sysdig-cli-scanner = pkgs.callPackage ./build { };
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  options = {
    cli.sysdig-cli-scanner.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable sysdig cli scanner.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users."${username}" = {
      home.packages = with pkgs; [ sysdig-cli-scanner ];
    };
  };
}
