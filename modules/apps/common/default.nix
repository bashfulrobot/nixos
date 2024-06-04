{ pkgs, config, lib, ... }:
let cfg = config.apps.common;

in {
  options = {
    apps.common.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable common applications";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # TODO: refactor these packages out into the proper moduls/suites

      ### Terminal
      xorg.xwininfo # Get StartupWMClass from a window in xwayland
      texliveSmall # get pdflatex
      usbutils # usb utilities like lsusb
      pciutils # list all PCI devices
      aichat # Use GPT-4(V), Gemini, LocalAI, Ollama and other LLMs in the terminal
      # spotdl # Spotify downloader
      steam-run # helps run some static compiled binaries
      file
      wtype # xdotool type for wayland
      wlrctl # Command line utility for miscellaneous wlroots Wayland extensions
      rclone # Command line program to sync files and directories to and from major cloud storage
      # syncrclone # Bidirectional sync tool for rclone
      textsnatcher # copy text from images
      pup # Terminal HTML parser
      libxslt # A C library and tools to do XSL transformations - needed in my terraform scripts
      gmailctl # cli to write gmail filters as code
      # ncdu # disk usage analyzer - replaced with gdu
      # wshowkeys # Show keys pressed in wayland
      killall # kill all instances of a running app
      # xfce.xfce4-terminal
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
      # neofetch # system information tool
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

      ### Dev
      watchman # file watcher
      # gitnuro # git client
      # zola # static site generator
      ollama # Run AI Models
      bruno # API Tester
      # ngrok
      pkg-config # allows packages to find out information about other packages
      codespelunker # code exploration tool
      httpie # HTTP client

      just # command runner
      doppler # secret management tool

      wl-clipboard # Wayland clipboard - needed for espanso
      nodejs-18_x # JavaScript runtime
      # postman # API testing tool
      vscode # code editor
      sftpman # SftpMan consists of a CLI and a GTK application that make it simpler to setup and mount SSHFS/SFTP file systems.
      # jetbrains.goland # Go IDE
      rclone-browser # Graphical Frontend to Rclone written in Qt
      # sublime4 # code editor
      #sublime-merge # GUI Git Client
      # Causes:error: Package ‘python-2.7.18.6’ in /nix/store/zb2695k9v4hmjdki97p0yhd4mys270fs-source/pkgs/development/interpreters/python/cpython/2.7/default.nix:330 is marked as insecure, refusing to evaluate.
      # oni2 # code editor
      shadowenv # environment variable manager
      ghostscript # PostScript and PDF interpreter

      hugo # static site generator
      shfmt # shell script formatter
      # lapce # editor written in Rust
      cosmic-edit # editor from system 76

      yai # Your AI Terminal

      ### Nix Tools
      # Nixd
      # https://github.com/nix-community/nixd/blob/main/docs/editor-setup.md
      #nixd # nix language server
      nixfmt # Nix code formatter
      nixfmt-rfc-style # Nix code formatter
      nix-index # Nix package indexer
      nix-prefetch-github # Get sha256 info for GitHub
      comma # Nix command wrapper
      nodePackages.node2nix # Node to Nix

      ### Cloud
      openvscode-server # vscode in browser. Used for demos
      nodePackages_latest.cdk8s-cli # cdk8s-cli - https://cdk8s.io/docs/latest/get-started/go/#install-the-cli
      cilium-cli # cilium cli
      kustomize # Kubernetes configuration management
      k0sctl # A bootstrapping and management tool for k0s clusters.
      # vagrant # lab automation
      cdrtools # mkisofs needed for cloud-init
      # butane # flatcar/ignition configuration
      cloud-utils # cloud management utilities
      fluxcd # FluxCD Gitops Cli
      # argocd-autopilot # https://argocd-autopilot.readthedocs.io/en/stable/
      # argocd # Gitops - cli
      # kubeone # Kubernetes cluster management
      talosctl # Talos OS management tool - diabled until https://github.com/NixOS/nixpkgs/issues/264127 is fixed.
      kompose # Kubernetes container orchestration
      vultr-cli # Vultr cloud management
      kubectl # Kubernetes command-line tool
      kubectx # Kubernetes context switcher
      kubecolor # colorize kubectl output
      kubernetes-helm # Kubernetes package manager
      eksctl # AWS EKS management tool
      awscli2 # AWS command line interface
      google-cloud-sdk # Google Cloud SDK
      aws-iam-authenticator # AWS IAM authentication tool
      terraform # infrastructure as code tool
      ctop # container process monitoring
      # virter # libvirtd management CLI client

      ### Networking
      wgnord # nordvpn over wireguard
      # localsend # send files locally # bug, need to troubleshoot TODO

      ### Backup
      restic # backup program
      autorestic # restic automation tool

      ### GUI
      cinny-desktop # another matrix client
      gimp-with-plugins # image editor
      inkscape-with-extensions # vector graphics editor
      xournalpp # note taking/pdf annotator
      # minder # mindmapping
      gnome.gnome-boxes # desktop vms
      # junction # default app selector
      #insync # Google Drive Sync Client
      whatsapp-for-linux # WhatsApp client
      # whatsapp-emoji-font # WhatsApp emoji font - pegs CPU to 100% on build
      evince # pdf viewer
      foliate # ebook reader
      libreoffice # office suite
      solaar # Linux manager for many Logitech keyboards, mice
      mplayer # Video player
      wl-color-picker # Wayland color picker
      zoom-us # video conferencing - Disabled due to a bug with ultrawides and wayland
      # tuba # Mastodon client
      morgen # AI calendar - testing
      # protonvpn-gui # VPN client
      kooha # Screen recorder for x11/Wayland
      flameshot # Screen capture - currently has a bug
      satty # annotation
      _1password-gui # password management GUI
      # helvum # A GTK patchbay for pipewire
      obsidian # note-taking app
      virt-manager # virtual machine manager
      #droidcam # use iPhone as a camera input
      yaru-theme # gtk theme
      pop-gtk-theme # gtk theme
      gruvbox-gtk-theme # theme
      gruvbox-dark-icons-gtk # theme icons
      colorpicker # colour picker
      # nheko # Matrix Clien
      # microsoft-edge # web browser

      # Communication
      slack # instant messaging
      signal-desktop # instant messaging
      rocketchat-desktop # instant messaging
      # thunderbird # email client
      mailspring # email client

    ];

    programs.wshowkeys.enable = true;

  };
}
