{ pkgs, ... }: {
  # Enable Nix/Flakes
  nix = let users = [ "root" "dustin" ];

  in {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      http-connections = 50;
      warn-dirty = false;
      log-lines = 50;
      sandbox = "relaxed";
      # https://nixos.wiki/wiki/Storage_optimization
      auto-optimise-store = true;
      trusted-users = users;
      allowed-users = users;
      # Cachix - https://wiki.hyprland.org/nix/cachix/
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
    # Automatic Garbage Collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 5D";
    };
  };

  programs.nix-ld.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
