{ pkgs, secrets, config, lib, ... }:
let
  cfg = config.apps.anydesk;
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {

  options = {
    apps.anydesk.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable anydesk.";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable anydesk
    # services.anydesk.enable = true;

    environment.systemPackages = with pkgs;
      [
        anydesk # remote support
      ];

  };
}
