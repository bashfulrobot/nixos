{ config, pkgs, lib, ... }:
let cfg = config.suites.developer;
in {

  options = {
    suites.developer.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the developer suite.";
    };
  };

  config = lib.mkIf cfg.enable {

    apps = {
      openvscode-server.enable = false;
      vscode.enable = true;
      nixpkgs-search.enable = true;
      nixos-discourse.enable = true;
      home-manager-search.enable = true;
      github-code-search.enable = true;
    };

    cli = {
      git.enable = true;
      lunarvim.enable = false;
      nvim.enable = false;
      helix.enable = true;

    };

    dev = {
      go.enable = true;
      npm.enable = true;
      python.enable = true;
    };

  };
}
