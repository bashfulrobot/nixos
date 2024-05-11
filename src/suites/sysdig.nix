{ config, pkgs, lib, ... }:
let cfg = config.suites.sysdig;
in {

  options = {
    suites.sysdig.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the sysdig suite.";
    };
  };

  config = lib.mkIf cfg.enable {

    apps = { kolide.enable = false; };

    cli = {
      sysdig-cli-scanner.enable = true;
      instruqt.enable = true;
    };
  };
}
