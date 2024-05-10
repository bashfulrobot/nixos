{ pkgs, secrets, config, lib, ... }:
let
  cfg = config.cli.tailscale;
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {

  options = {
    cli.tailscale.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable tailscale mesh.";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable Tailscale
    services.tailscale.enable = true;

    environment.systemPackages = with pkgs;
      [
        tailscale # zero-config VP
      ];

  };
}
