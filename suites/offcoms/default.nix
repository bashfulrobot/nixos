{ config, pkgs, lib, inputs, ... }:
let cfg = config.suites.offcoms;
in {

  options = {
    suites.offcoms.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable office and communication tools .";
    };
  };

  config = lib.mkIf cfg.enable {

    apps = {
      one-password.enable = true;
      apple-notes.enable = true;

      insync.enable = true;

      # --- Browsers
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
      chrome-based-browser.enable = false;
      vivaldi.enable = false;
      ms-edge.enable = false;

      #  --- Organize
      xmind.enable = true;
      todoist.enable = true;
      gcal-br.enable = true;

      #  --- Comms
      gmail-br.enable = true;

      # --- Utilities
      gemini.enable = true;
      notebooklm.enable = true;

    };

    cli = { espanso.enable = false; };

    environment.systemPackages = with pkgs; [
      # Browsers
      #inputs.zen-browser.packages.x86_64-linux.zen-browser
      #(opera.override { proprietaryCodecs = true; })
      #brave
      google-chrome

      # PDF
      xournalpp # note taking/pdf annotator
      evince # pdf viewer
      texliveSmall # get pdflatex
      pdf-sign # pdf signing utility

      # Office
      libreoffice # office suite
      obsidian # note-taking

      # Organize
      # morgen # AI calendar - testing

      # Communications
      # # IM
      fractal # Matrix Client
      slack # instant messaging
      signal-desktop # instant messaging
      element-desktop # Matrix Client
      #  # Email
      gmailctl # cli to write gmail filters as code
      # thunderbird # email client
      #mailspring # email client
      #geary # email reader

      # Utilities
      _1password-gui # password management GUI
      _1password # password manager cli
      pandoc # document converter
    ];
  };
}
