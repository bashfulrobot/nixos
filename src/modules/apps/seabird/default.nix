{ pkgs, config, lib, ... }:
let cfg = config.apps.seabird;
in {
  options = {
    apps.seabird.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable seabird k8s client.";
    };
  };

  config = lib.mkIf cfg.enable {

    services.flatpak.packages = [
      "dev.skynomads.Seabird" # kubernetes client
    ];
  };
}
