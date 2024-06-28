{ pkgs, config, lib, ... }:
let cfg = config.hw.networking;
in {

  options = {
    hw.networking.networkmanager.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable networkmanager.";
    };
    hw.networking.wifi.powersave = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable wifi powersaving.";
    };
  };

  config = lib.mkIf cfg.networkmanager.enable {
    # Enable networking
    networking.networkmanager = lib.mkMerge [
      { enable = true; }
      (lib.mkIf cfg.host.evo {
        # Enable wifi powersaving
        environment.systemPackages = [

        ];

        # wifi powersaving
        boot.extraModprobeConfig = ''
          options iwlwifi power_save=1
        '';
      })
    ];
  };
}
