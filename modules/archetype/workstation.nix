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

    nixcfg = {
      home-manager.enable = true;
      insecure-packages.enable = true;
      nix-settings.enable = true;
    };

    sys = {
      dconf.enable = true;
      xdg.enable = true;
      };

    suites = {
      common.enable = true;
      developer.enable = true;
      devops.enable = true;
      media.enable = true;
      office.enable = true;
      sysdig.enable = true;
      web-apps.enable = true;
    };
  };
}
