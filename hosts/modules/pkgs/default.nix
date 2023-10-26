{ config, pkgs, lib, inputs, ... }:

{

  environment.systemPackages = with pkgs; [

    ### Terminal
    wshowkeys # Show keys pressed in wayland
    killall # kill all instances of a running app
    xfce.xfce4-terminal
    dex # open desktop files from the terminal
    blackbox-terminal # encrypted terminal sessions
    bash-completion # bash shell completion
    tesseract # CLI OCR
    gping # visual ping alternative
    ffmpeg_6-full # multimedia processing
    libnotify # notification library
    lftp # file transfer program
    unzip # file decompression tool
    inetutils # network utilities
    pandoc # document converter
    dogdns # dig alternative
    xorg.xkill # kill client by X resource
    neofetch # system information tool
    imagemagick_light # image manipulation library
    coreutils # basic file, shell, and text manipulation
    wget # file download utility
    xclip # command line interface to X clipboard
    ripgrep # grep alternative
    #pdf-sign # pdf signing utility
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
    ntfy # shell notification tool

    ### Dev
    ngrok
    pkg-config # allows packages to find out information about other packages
    codespelunker # code exploration tool
    httpie # HTTP client
    git # version control system
    git-crypt # repository encryption
    just # command runner
    #difftastic # visual diff tool
    doppler # secret management tool
    gh # GitHub CLI tool
    espanso-wayland # text expander
    nodejs-18_x # JavaScript runtime
    # postman # API testing tool
    vscode # code editor
    sublime4 # code editor
    sublime-merge # GUI Git Client
    microsoft-edge # Browser
    google-chrome # Browser - test zoom behavior

    # Causes:error: Package ‘python-2.7.18.6’ in /nix/store/zb2695k9v4hmjdki97p0yhd4mys270fs-source/pkgs/development/interpreters/python/cpython/2.7/default.nix:330 is marked as insecure, refusing to evaluate.
    # oni2 # code editor
    shadowenv # environment variable manager
    gptcommit # git commit message generator
    hugo # static site generator
    shfmt # shell script formatter
    bottom # system monitoring tool
    #lapce # editor written in Rust
    shell-genie # interact with the terminal in plain English

    ### Nix Toolswlpr
    # Nixd
    # https://github.com/nix-community/nixd/blob/main/docs/editor-setup.md
    #nixd # nix language server
    nixfmt # Nix code formatter
    nix-index # Nix package indexer
    nix-prefetch-github # Get sha256 info for GitHub
    comma # Nix command wrapper

    ### Cloud
    vagrant # lab automation
    cdrtools # mkisofs needed for cloud-init
    butane # flatcar/ignition configuration
    cloud-utils # cloud management utilities
    kubeone # Kubernetes cluster management
    talosctl # Talos OS management tool
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
    #age # simple file encryption tool
    ctop # container process monitoring
    virter # libvirtd management CLI client

    ### Networking
    tailscale # zero-config VPN
    # wgnord # nordvpn over wireguard
    localsend # send files locally

    ### Backup
    restic # backup program
    autorestic # restic automation tool

    ### GUI
    evince # pdf viewer
    gnome.nautilus # file manager
    libreoffice # office suite
    solaar # Linux manager for many Logitech keyboards, mice
    #spot # Native Spotify client
    appimage-run # Run AppImages
    wl-color-picker # Wayland color picker
    #zoom-us # video conferencing - Disabled due to a bug with ultrawides and wayland
    #tootle # Mastodon client
    morgen # AI calendar - testing
    #kooha # screen recording
    protonvpn-gui # VPN client
    kooha # Screen recorder for x11/Wayland
    _1password-gui # password management GUI
    #bookworm # ePub reader
    obsidian # note-taking app
    todoist-electron # task management app
    virt-manager # virtual machine manager
    #droidcam # use iPhone as a camera input
    #onthespot # Spotify client
    gruvbox-dark-gtk # theme
    gruvbox-gtk-theme # theme
    gruvbox-dark-icons-gtk # theme icons
    epiphany # gnome web

    # Communication
    slack # instant messaging
    rocketchat-desktop # instant messaging
    # thunderbird # email client

  ];

  programs.wshowkeys.enable = true;

}
