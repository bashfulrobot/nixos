{ config, pkgs, lib, ... }:
let cfg = config.suites.office;
in {

  options = {
    suites.office.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the office suite.";
    };
  };

  config = lib.mkIf cfg.enable {

    apps = {
      betterbird.enable = true;
    };

  };
}
