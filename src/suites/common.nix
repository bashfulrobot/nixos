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
      epiphany.enable = true;
      mullvad.enable = false;
      readitlater.enable = true;
      celeste.enable = true;
    };

    cli = {
      comics-downloader.enable = true;
      common.enable = true;
      espanso.enable = true;
      environment.enable = true;
      bash.enable = true;
      fish.enable = true;
      alacritty.enable = true;
      tailscale.enable = true;
      ptyxis.enable = false; # just packaged. Wiating to show nixpkgs
      blackbox-terminal.enable = false;
    };

    sys = {
      hosts.enable = true;
      fonts.enable = true;
      ssh.enable = true;
      gpg.enable = true;
      scripts = {
        hw-scan.enable = true;
        screenshots.enable = true;
      };
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

  };
}
