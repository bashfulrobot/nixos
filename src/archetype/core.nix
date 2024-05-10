{ config, pkgs, lib, ... }:
let cfg = config.archetype.core;
in {

  options = {
    archetype.core.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the core archetype.";
    };
  };

  config = lib.mkIf cfg.enable {

    sys = { dconf.enable = true; };

    nixcfg = {
      home-manager.enable = true;
      insecure-packages.enable = true;
      nix-settings.enable = true;
    };

  };
}
