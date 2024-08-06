{
  user-settings,
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.cli.common;
in {
  options = {
    cli.common.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable common cli tools.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ### Nix Tools
      nix-index # Nix package indexer
      comma # Nix command wrapper
			ydotool #xdotool alternative. window automation
      xdg-utils
      tcpdump
      silver-searcher
      ### Terminal

      texliveSmall # get pdflatex
      usbutils # usb utilities like lsusb
      pciutils # list all PCI devices
      aichat # Use GPT-4(V), Gemini, LocalAI, Ollama and other LLMs in the terminal
      # spotdl # Spotify downloader
      steam-run # helps run some static compiled binaries
      file

      textsnatcher # copy text from images
      pup # Terminal HTML parser
      libxslt # A C library and tools to do XSL transformations - needed in my terraform scripts
      gmailctl # cli to write gmail filters as code
      # ncdu # disk usage analyzer - replaced with gdu

      killall # kill all instances of a running app
      dex # open desktop files from the terminal

      tesseract # CLI OCR
      gping # visual ping alternative
      ffmpeg_6-full # multimedia processing
      v4l-utils # camera controls
      libthai # Needed for some appImages
      libnotify # notification library
      # lftp # file transfer program
      unzip # file decompression tool
      inetutils # network utilities
      pandoc # document converter
      dogdns # dig alternative
      xorg.xkill # kill client by X resource
      imagemagick_light # image manipulation library
      coreutils # basic file, shell, and text manipulation
      wget # file download utility
      xclip # command line interface to X clipboard
      ripgrep # grep alternative
      pdf-sign # pdf signing utility
      du-dust # disk usage utility
      gdu # disk usage analyzer
      dua # disk usage analyzer
      duf # disk usage/free utility
      dufs # static file server
      eza # ls and exa alternative
      desktop-file-utils # utilities for working with desktop files
      procs # ps alternative
      tealdeer # command-line help utility
      bottom # system monitoring tool
      jless # json/yaml parser
      fd # find alternative
      sd # sed alternative
      tree # directory structure viewer
      gnupg # encryption and signing tool
      _1password # password manager
      lshw # hardware lister
      fzf # command-line fuzzy finder
      sshfs # filesystem client over SSH
      openssl # cryptographic toolkit
      # ntfy # shell notification tool
      bottom # system monitoring tool
      # shell-genie # interact with the terminal in plain English
      broot # Fuzzy finder
      dysk # Mounted Disk Info
      appimage-run # Run AppImages
      glow # Render Markdown on the CLI
      #inlyne # inlyne is a command-line tool to inline CSS and JS files into HTML files
      jnv # json filtering with jq
      krew # pkg manager for kubectl plugins
    ];

    # programs.nh = {
    #   enable = true;
    #   clean.enable = true;
    #   clean.extraArgs = "--keep-since 4d --keep 3";
    #   flake = "/home/dustin/dev/nix/nixos";
    # };
    home-manager.users."${user-settings.user.username}" = {
      programs = {
        autojump = {
          enable = true;
          enableFishIntegration = true;
        };
        tmux = {enable = true;};
        bat = {enable = true;};
        jq = {enable = true;};
        k9s = {enable = true;};
        btop = {enable = true;};

        # zellij = {
        #   enable = true;
        #   enableBashIntegration = true;
        # };
        # navi = {
        #   enable = true;
        #   enableBashIntegration = true;
        #   enableFishIntegration = true;
        # };

        carapace = {enable = true;};
      };
    };
  };
}
