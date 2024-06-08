{ user-settings, pkgs, config, lib, ... }:
let cfg = config.apps.obs;
in {
  options = {
    apps.obs.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable OBS.";
    };
  };

  config = lib.mkIf cfg.enable {

    services.flatpak.packages = [
      "com.obsproject.Studio" # Video Editor
    ];
  };
}
