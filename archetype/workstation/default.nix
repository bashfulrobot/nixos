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

    apps = {
      zoom-us = {
        enable = true;
        downgrade = true;
      };
      whatsapp.enable = true;
      rocket-chat = {
        enable = true;
        web = true;
      };

      apple-notes.enable = true;
      nautilus.enable = true;
      common.enable = true;
      one-password.enable = true;
      # chrome-based-browser = {
      #   enable = true;
      #   # Currently supported browsers are "brave", "vivaldi", "ungoogled-chromium" or "chromium".
      #   browser = "chromium";
      #   disableWayland = false;
      # };

      # TODO: needs some work in my module
      #  - extensions keep reordering
      #  - Need to add extensions to the module
      firefox.enable = false;
      chrome-based-browser.enable = true;

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
      xmind.enable = true;
      todoist.enable = true;
      gcal-br.enable = true;
      gmail-br.enable = true;
      intercom.enable = true;
    };

    cli = {
      alacritty.enable = true;

      direnv.enable = true;
      sysdig-cli-scanner.enable = true;
      instruqt.enable = true;
      git.enable = true;
      nixvim.enable = true;
      nvim.enable = false;
      helix.enable = false;
      spotify-player.enable = true;

      comics-downloader.enable = true;
      common.enable = true;
      espanso.enable = false;
      bash.enable = true;
      fish.enable = true;
      zsh.enable = true;
      tailscale.enable = true;
      docker.enable = true;
      gemini-cli.enable = true;
      yazi.enable = true;
    };

    dev = {
      go.enable = true;
      npm.enable = true;
      python.enable = true;
      nix.enable = true;
    };

    sys = {
      plymouth.enable = true;
      stylix.enable = true;
      dconf.enable = true;
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
      };
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;
  };
}
