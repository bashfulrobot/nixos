{ user-settings, pkgs, config, lib, ... }:
let cfg = config.apps.alpaca;
in {
  options = {
    apps.alpaca.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable alpaca app.";
    };
  };

  config = lib.mkIf cfg.enable {

    services.flatpak.packages = [
      "com.jeffser.Alpaca" # Chat with local ai models
    ];
  };
}
