{ config, pkgs, lib, ... }:
let cfg = config.archetype.laptop;
in {

  options = {
    archetype.laptop.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the laptop archetype.";
    };
  };

  config = lib.mkIf cfg.enable {

    hw = {
      general.enable = true;
      fwupd.enable = true;
      audio.enable = true;
      touchpad.enable = true;
      fprintd.enable = true;
      networking = {
        networkmanager.enable = true;
        wifi.powersave = false;
      };
      bluetooth = {
        enable = true;
        logitech.solaar = true;
        airpods.join = false;
      };
    };

  };
}
