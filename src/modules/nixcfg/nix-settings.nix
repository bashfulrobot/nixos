{ pkgs, lib, config, ... }:
let cfg = config.nixcfg.nix-settings;
in {

  options = {
    nixcfg.nix-settings.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the core archetype.";
    };
  };

  config = lib.mkIf cfg.enable {
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
        options = "--delete-older-than 5d";
      };
    };

    programs.nix-ld.enable = true;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
  };
}
