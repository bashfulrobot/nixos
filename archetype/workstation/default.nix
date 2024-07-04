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

    sys = {
      dconf.enable = true;
      xdg.enable = true;
      };

    apps = {
      pairdrop.enable = true;
      zoom-web.enable = false;
      apple-notes.enable = true;
      nautilus.enable = true;
      common.enable = true;
      one-password.enable = true;
      chrome-based-browser = {
        enable = true;
        # Currently supported browsers are "brave" or "chromium".
        browser = "brave";
      };
      readitlater.enable = true;
      vscode.enable = true;
      nixpkgs-search.enable = true;
      nixos-discourse.enable = true;
      nixos-wiki.enable = true;
      hm-search.enable = true;
      github-code-search.enable = true;
      kvm.enable = true;
      vitally.enable = true;
      gcal-sysdig.enable = true;
      gmail-sysdig.enable = true;
      github.enable = true;
      sfdc.enable = true;
      jira.enable = true;
      confluence.enable = true;
      teamviewer.enable = true;
      xmind.enable = true;
      todoist.enable = true;
      gcal-br.enable = true;
      gmail-br.enable = true;
    };

    cli = {
      direnv.enable = true;
      sysdig-cli-scanner.enable = true;
      instruqt.enable = true;
      git.enable = true;
      lunarvim.enable = false;
      nvim.enable = true;
      helix.enable = false;
      spotify-player.enable = true;
      rclone.enable = false; # WIP
      comics-downloader.enable = true;
      common.enable = true;
      espanso.enable = false;
      environment.enable = true;
      bash.enable = true;
      fish.enable = true;
      tailscale.enable = true;
      docker.enable = true;
    };

    dev = {
      go.enable = true;
      npm.enable = true;
      python.enable = true;
    };

    sys = {
      hosts.enable = true;
      fonts.enable = true;
      ssh.enable = true;
      gpg.enable = true;
      scripts = {
        hw-scan.enable = true;
        screenshots.enable = true;
        gmail-url.enable = true;
      };
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;
  };
}
