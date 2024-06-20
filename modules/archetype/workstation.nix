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
      celeste.enable = false;
      cosmic-web-apps.enable = false;
      obs.enable = false;
      delfin.enable = false;
      openvscode-server.enable = false;
      vscode.enable = true;
      nixpkgs-search.enable = true;
      nixos-discourse.enable = true;
      hm-search.enable = true;
      github-code-search.enable = true;
      seabird.enable = false;
      kvm.enable = true;
      steam.enable = false;
      vitally.enable = true;
      gcal-sysdig.enable = true;
      gmail-sysdig.enable = true;
      sfdc.enable = true;
      teamviewer.enable = true;
      anydesk.enable = false;
      betterbird.enable = false;
      xmind.enable = true;
      bluemail.enable = false;
      todoist.enable = true;
      gcal-br.enable = true;
      gmail-br.enable = true;
    };

    cli = {
      sysdig-cli-scanner.enable = true;
      instruqt.enable = true;
      git.enable = true;
      lunarvim.enable = false;
      nvim.enable = true;
      helix.enable = false;
      spotify-player.enable = true;
      rclone.enable = false; # WIP
      comics-downloader.enable = false;
      common.enable = true;
      espanso.enable = true;
      environment.enable = true;
      bash.enable = true;
      fish.enable = true;
      alacritty.enable = true;
      tailscale.enable = true;
      ptyxis.enable = false;
      blackbox-terminal.enable = true;
      linkr.enable = false;
      docker.enable = true;
      k8sgpt.enable = false;
      kubitect.enable = false;
      dagger.enable = false;
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
      };
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;
  };
}
