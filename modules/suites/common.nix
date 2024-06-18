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
      nautilus.enable = true;
      common.enable = true;
      one-password.enable = true;
      chrome-based-browser = {
        enable = true;
        # Currently supported browsers are "brave" or "chromium".
        browser = "brave";
      };
      firefox.enable = false;
      epiphany = {
        enable = false;
        useFlatpak = false;
      };
      mullvad.enable = false;
      readitlater.enable = true;
      celeste.enable = true;
      cosmic-web-apps.enable = false;
      nixpkgs-search.enable = true;
    };

    cli = {
      rclone.enable = false; # WIP
      comics-downloader.enable = false;
      common.enable = true;
      espanso.enable = false;
      environment.enable = true;
      bash.enable = true;
      fish.enable = true;
      alacritty.enable = true;
      tailscale.enable = true;
      ptyxis.enable = true;
      blackbox-terminal.enable = false;
      linkr.enable = false;
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
