{ config, pkgs, lib, ... }:
let cfg = config.suites.common;
in {

  options = {
    suites.common.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the common suite.";
    };
  };

  config = lib.mkIf cfg.enable {

    apps = {
      one-password.enable = true;
      chromium.enable = true;
      firefox.enable = true;
    };

    cli = {
      environment.enable = true;
      bash.enable = true;
      fish.enable = true;
      alacritty.enable = true;
      tailscale.enable = true;
    };

    sys = {
      fonts.enable = true;
      ssh.enable = true;
      scripts = {
        hw-scan.enable = true;
        screenshots.enable = true;
      };
    };

  };
}
