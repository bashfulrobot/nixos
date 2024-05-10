{ config, pkgs, lib, ... }:
let cfg = config.suites.gaming;
in {

  options = {
    suites.gaming.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the gaming suite.";
    };
  };

  config = lib.mkIf cfg.enable {

    apps = { steam.enable = true; };

  };
}
