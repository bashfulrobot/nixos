{ user-settings, pkgs, config, lib, ... }:
let
  cfg = config.cli.comics-downloader;
  comics-downloader = pkgs.callPackage ./build { };

in {
  options = {
    cli.comics-downloader.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable ME.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users."${user-settings.user.username}".home.packages = with pkgs;
      [ comics-downloader ];
  };
}
