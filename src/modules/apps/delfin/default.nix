{ pkgs, config, lib, ... }:
let cfg = config.apps.delfin;
in {
  options = {
    apps.delfin.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Delfon jellyfin client.";
    };
  };

  config = lib.mkIf cfg.enable {

    services.flatpak.packages = [
      "cafe.avery.Delfin" # Jellyfin client
    ];
  };
}
