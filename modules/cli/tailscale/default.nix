{ user-settings, pkgs, secrets, config, lib, ... }:
let cfg = config.cli.tailscale;

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

    # https://github.com/NixOS/nixpkgs/issues/180175#issuecomment-2372305193
    systemd.services.tailscaled.after =
      [ "NetworkManager-wait-online.service" ];

  };
}
