{ pkgs, config, lib, ... }:
let
  cfg = config.dev.go;
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  options = {
    dev.go.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable go tooling.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users."${username}" = {
      programs.go = {
        enable = true;
        goBin = "go/bin";
        goPath = "go";
      };
    };
  };
}
