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
      openvscode-server.enable = true;
      vscode.enable = true;
      };

    cli = {
      git.enable = true;
      lunarvim.enable = false;
      nvim.enable = true;
      helix.enable = false;

    };

    dev = {
      go.enable = true;
      npm.enable = true;
      python.enable = true;
    };

  };
}
