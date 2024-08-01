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
      general.enable = true;
      logitech.enable = true;
      audio.enable = true;
      networking.networkmanager.enable = true;
      bluetooth = {
        enable = true;
        logitech.solaar = true;
        airpods.join = false;
      };
    };

  };
}
