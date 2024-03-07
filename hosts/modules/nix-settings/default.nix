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
    };
    # Automatic Garbage Collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than +2";
    };
  };

  programs.nix-ld.enable = true;
}
