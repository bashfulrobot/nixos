{ pkgs, config, lib, ... }:
let cfg = config.apps.readitlater;
in {
  options = {
    apps.readitlater.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Readitlater Wallabag client.";
    };
  };

  config = lib.mkIf cfg.enable {

    services.flatpak.packages = [
      "com.belmoussaoui.ReadItLater" # Wallabag client
    ];
  };
}
