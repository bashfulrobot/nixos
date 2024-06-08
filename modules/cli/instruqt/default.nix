{ user-settings, pkgs, config, lib, ... }:
let
  cfg = config.cli.instruqt;
  instruqt = pkgs.callPackage ./build { };


in {
  options = {
    cli.instruqt.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Instruqt CLI.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users."${user-settings.user.username}" = {
      home.packages = with pkgs; [ instruqt ];
    };
  };
}
