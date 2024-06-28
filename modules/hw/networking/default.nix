{ pkgs, config, lib, ... }:
let cfg = config.hw.networking;
in {
  options.hw.networking = {
    networkmanager = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable networkmanager.";
      };
    };
    wifi = {
      powersave = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable wifi powersaving.";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.networkmanager.enable {
      # Enable networking
      networking.networkmanager.enable = true;
    })
    (lib.mkIf (cfg.networkmanager.enable && cfg.wifi.powersave) {
      # Apply wifi powersaving configuration only if both networkmanager is enabled and wifi powersave is true
      boot.extraModprobeConfig = ''
        options iwlwifi power_save=1
      '';
    })
  ];
}
