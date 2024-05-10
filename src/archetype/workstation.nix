{ config, pkgs, lib, ... }:
let cfg = config.archetype.workstation;
in {

  options = {
    archetype.workstation.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the workstation archetype.";
    };
  };

  config = lib.mkIf cfg.enable {

    suites = {
      common.enable = true;
      developer.enable = true;
      devops.enable = true;
      media.enable = true;
      office.enable = true;
      web-apps.enable = true;
    };
  };
}
