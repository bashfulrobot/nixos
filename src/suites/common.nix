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
      brave.enable = true;
      mullvad.enable = false;
    };

    cli = {
      environment.enable = true;
      bash.enable = true;
      fish.enable = true;
      alacritty.enable = true;
      tailscale.enable = true;
      ptyxis.enable = false; # just packaged. Wiating to show nixpkgs
    };

    sys = {
      hosts.enable = true;
      fonts.enable = true;
      ssh.enable = true;
      scripts = {
        hw-scan.enable = true;
        screenshots.enable = true;
      };
    };

  };
}
