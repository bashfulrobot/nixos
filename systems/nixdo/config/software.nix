{ config, pkgs, ... }: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #neovim
    lunarvim
    micro
    wget
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
    starship
    tree
    tailscale
    just
    nixfmt
    fish
  ];

  # Install Docker
  #  virtualisation.docker.enable = true;

  virtualisation = {
    docker = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
  };
}
