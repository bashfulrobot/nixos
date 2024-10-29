{ config, pkgs, lib, ... }:
let cfg = config.archetype.workstation;
in {

  options = {
    archetype.workstation.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the workstation archetype.";
    };
  };

  config = lib.mkIf cfg.enable {

    nixcfg = {
      home-manager.enable = true;
      insecure-packages.enable = true;
      nix-settings.enable = true;
    };

    suites = {
      content-creation.enable = false;
      dev.enable = true;
      entertainment.enable = true;
      infrastructure.enable = true;
      k8s.enable = true;
      offcoms.enable = true;
      sysdig.enable = true;
      terminal.enable = true;
      utilities.enable = true;
    };

    sys = {
      plymouth.enable = true;
      #stylix.enable = false; # TODO: broken themes in gnome. Transparent title bars
      dconf.enable = true;
      flatpaks.enable = true;
      xdg.enable = true;
      hosts.enable = true;
      fonts.enable = true;
      ssh.enable = true;
      gpg.enable = true;
      scripts = {
        hw-scan.enable = true;
        screenshots.enable = true;
        gmail-url.enable = true;
        copy_icons.enable = true;
        init-bootstrap.enable = true;
        toggle-cursor-size.enable = true;
      };
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;
  };
}
