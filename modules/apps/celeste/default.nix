{ user-settings, pkgs, config, lib, ... }:
let cfg = config.apps.celeste;
in {
  options = {
    apps.celeste.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable celeste sync client.";
    };
  };

  config = lib.mkIf cfg.enable {

    services.flatpak.packages = [
      "com.hunterwittenborn.Celeste" # Cloud storage Sync GUI
    ];
  };
}
