{ pkgs, config, lib, ... }:
let cfg = config.hw.fwupd;
in {

  options = {
    hw.fwupd.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable fwupd for firmware updates.";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable Firmware Updates
    services.fwupd.enable = true;

    # Enable all firmware regarldess of license
    hardware.enableAllFirmware = true;
  };
}
