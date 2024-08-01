{ pkgs, config, lib, ... }:
let cfg = config.hw.logitech;
in {

  options = {
    hw.logitech.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable logitech hardware, software and settings.";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.logitech = {
      wireless = {
        enable = true;
        enableGraphical = true;
      };
    };
  };
}
