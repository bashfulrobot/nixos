{ config, pkgs, lib, ... }:
let cfg = config.suites.web-apps;
in {

  options = {
    suites.web-apps.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the web app suite.";
    };
  };

  config = lib.mkIf cfg.enable {

    apps = { web-apps.enable = true; };

  };
}
