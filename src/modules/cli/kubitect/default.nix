{ pkgs, config, lib, ... }:

let
  cfg = config.cli.kubitect;
  kubitect = pkgs.callPackage ./build { };

  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {

  options = {
    cli.kubitect.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable kubitect.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users."${username}" = {
      home.packages = with pkgs; [
        kubitect
        # dependencies
        virtualenv
        # git - installed globally
        # python - installed globally
      ];
    };
  };
}
