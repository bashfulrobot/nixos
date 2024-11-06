{ user-settings, pkgs, config, lib, ... }:
let cfg = config.dev.nix;

in {
  options = {
    dev.nix.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable nix tooling.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      # Nixd
      # https://github.com/nix-community/nixd/blob/main/docs/editor-setup.md
      # lsp for nix - mayb e for zed
      #nixd # nix language server
      nix-index # Nix package indexer
      comma # Nix command wrapper
      nixfmt # Nix code formatter
      nixfmt-rfc-style # Nix code formatter
      nodePackages.node2nix # Node to Nix
      statix # nix linting
      nixd # nix language server
      nix-prefetch-github # Get sha256 info for GitHub
    ];
    home-manager.users."${user-settings.user.username}" = {

    };
  };
}
