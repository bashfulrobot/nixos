{ config, pkgs, lib, ... }:
let cfg = config.suites.tech-support;
in {

  options = {
    suites.tech-support.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the web app suite.";
    };
  };

  config = lib.mkIf cfg.enable {

    apps = {
      teamviewer.enable = false;
      anydesk.enable = true;
    };

  };
}
