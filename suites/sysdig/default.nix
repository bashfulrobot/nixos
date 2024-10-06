{ config, pkgs, lib, ... }:
let cfg = config.suites.sysdig;
in {

  options = {
    suites.sysdig.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable sysdig apps and tooling..";
    };
  };

  config = lib.mkIf cfg.enable {

    apps = {
      zoom-us = {
        enable = true;
        downgrade = true;
      };

      rocket-chat = {
        enable = true;
        web = true;
      };

      vitally.enable = true;
      gcal-sysdig.enable = true;
      gmail-sysdig.enable = true;
      sfdc.enable = true;
      jira.enable = true;
      confluence.enable = true;
      intercom.enable = true;
      slack-sysdig.enable = true;
    };

    cli = {
      sysdig-cli-scanner.enable = true;
      instruqt.enable = true;
    };
  };
}
