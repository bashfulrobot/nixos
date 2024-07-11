{ user-settings, pkgs, config, lib, ... }:
let
  cfg = config.cli.gemini-cli;
  gemini-cli = pkgs.callPackage ./build { };

in {
  options = {
    cli.gemini-cli.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable gemeni-cli tool.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users."${user-settings.user.username}".home.packages = with pkgs;
      [ gemini-cli ];
  };
}
