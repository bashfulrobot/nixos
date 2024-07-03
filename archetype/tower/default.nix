{ config, pkgs, lib, ... }:
let cfg = config.archetype.tower;
in {

  options = {
    archetype.tower.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the tower archetype.";
    };
  };

  config = lib.mkIf cfg.enable {

    hw = {
      fwupd.enable = true;
      audio.enable = true;
      networking.networkmanager.enable = true;
      bluetooth = lib.trace "hw.bluetooth module ran" {
        enable = lib.trace "hw.bluetooth enabled" true;
        logitech.solaar = true;
        airpods.join = false;
      };
    };

  };
}
