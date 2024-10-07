{ user-settings, pkgs, config, lib, ... }:
let cfg = config.apps.minder;
in {
  options = {
    apps.minder.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Minder Flatpak.";
    };
  };

  config = lib.mkIf cfg.enable {

    services.flatpak.packages = [
      "com.github.phase1geo.minder"
    ];
  };
}
