{ config, pkgs, lib, ... }:
let cfg = config.suites.devops;
in {

  options = {
    suites.devops.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the devops suite.";
    };
  };

  config = lib.mkIf cfg.enable {
    apps = { kubitect.enable = true; };

  };
}
