{ config, pkgs, ... }: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wakeonlan
    wget
    bat
    curl
    tmux
    git
    git-crypt
    shadowenv
    fd
    bottom
    cloud-utils
    gnumake
    eza
    ripgrep
    du-dust
    tree
    just
    nixfmt
    gdu
  ];

  apps = { kvm.enable = true; };

  cli = {
    tailscale.enable = true;
    docker.enable = true;
    starship.enable = true;
    fish.enable = true;
    yazi.enable = true;
    nixvim.enable = true;
  };

}
