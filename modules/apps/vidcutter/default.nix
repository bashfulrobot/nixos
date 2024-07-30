{ user-settings, pkgs, config, lib, ... }:
let cfg = config.apps.vidcutter;
in {
  options = {
    apps.vidcutter.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Vidcutter app.";
    };
  };

  config = lib.mkIf cfg.enable {

    services.flatpak.packages = [
      "com.ozmartians.VidCutter" # Wallabag client
    ];
  };
}
