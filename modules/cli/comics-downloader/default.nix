{ pkgs, config, lib, ... }:
let
  cfg = config.cli.comics-downloader;
  comics-downloader = pkgs.callPackage ./build { };
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {
  options = {
    cli.comics-downloader.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable ME.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users."${username}".home.packages = with pkgs;
      [ comics-downloader ];
  };
}
