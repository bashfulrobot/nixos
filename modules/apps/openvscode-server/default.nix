{ pkgs, config, lib, ... }:
let
  cfg = config.apps.openvscode-server;
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {

  options = {
    apps.openvscode-server.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable openvscode-server.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs;
      [
        openvscode-server # vscode in browser. Used for demos
      ];

    services.openvscode-server = {
      enable = true;
      user = "${username}";
      port = 8080;
      host = "localhost";
      extensionsDir = "/home/${username}/.vscode-oss/extensions";
      withoutConnectionToken =
        true; # So you don't need to grab the token that it generates here
    };
  };
}
