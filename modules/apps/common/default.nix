{ user-settings, pkgs, config, lib, ... }:
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

      gnome-disk-utility
      transmission_4
      deluge-gtk

      ### Dev
      zed-editor # text editor
      watchman # file watcher
      # gitnuro # git client
      # zola # static site generator
      pkg-config # allows packages to find out information about other packages
      codespelunker # code exploration tool
      httpie # HTTP client

      just # command runner
      # doppler # secret management tool
      nodejs-18_x # JavaScript runtime
      # jetbrains.goland # Go IDE
      # rclone-browser # Graphical Frontend to Rclone written in Qt
      # Causes:error: Package ‘python-2.7.18.6’ in /nix/store/zb2695k9v4hmjdki97p0yhd4mys270fs-source/pkgs/development/interpreters/python/cpython/2.7/default.nix:330 is marked as insecure, refusing to evaluate.
      # oni2 # code editor
      shadowenv # environment variable manager
      ghostscript # PostScript and PDF interpreter

      hugo # static site generator
      shfmt # shell script formatter
      # lapce # editor written in Rust
      cosmic-edit # editor from system 76

      yai # Your AI Terminal

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
      # vultr-cli # Vultr cloud management
      kubectl # Kubernetes command-line tool
      kubectx # Kubernetes context switcher
      kubecolor # colorize kubectl output
      kubernetes-helm # Kubernetes package manager
      eksctl # AWS EKS management tool
      awscli2 # AWS command line interface
      # google-cloud-sdk # Google Cloud SDK
      aws-iam-authenticator # AWS IAM authentication tool
      terraform # infrastructure as code tool
      ctop # container process monitoring
      # virter # libvirtd management CLI client

      ### Networking
      # wgnord # nordvpn over wireguard
      # localsend # send files locally # bug, need to troubleshoot TODO

      ### Backup
      restic # backup program
      autorestic # restic automation tool

      ### GUI
      vlc # media player
      gimp-with-plugins # image editor
      inkscape-with-extensions # vector graphics editor
      xournalpp # note taking/pdf annotator
      # minder # mindmapping
      # junction # default app selector
      #insync # Google Drive Sync Client
      evince # pdf viewer
      foliate # ebook reader
      libreoffice # office suite
      solaar # Linux manager for many Logitech keyboards, mice
      mplayer # Video player

      # morgen # AI calendar - testing
      kooha # Screen recorder for x11/Wayland
      # flameshot # Screen capture - currently has a bug
      satty # annotation
      _1password-gui # password management GUI
      # helvum # A GTK patchbay for pipewire
      obsidian # note-taking app
      virt-manager # virtual machine manager
      # yaru-theme # gtk theme
      colorpicker # colour picker

      # Communication
      fractal # Matrix Client
      slack # instant messaging
      signal-desktop # instant messaging
      element-desktop # Matrix Client
      # thunderbird # email client
      mailspring # email client

    ];

    programs.wshowkeys.enable = true;

  };
}
