{ user-settings, pkgs, secrets, config, lib, ... }:

let
  cfg = config.cli.esplus;
  esplus = pkgs.callPackage ./build { };

in {
  options = {
    cli.esplus.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable esplus - espanso templating cli.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ esplus ];
    home-manager.users."${user-settings.user.username}" = {
      # Install esplus
      #   home.packages = with pkgs; [ esplus ];

    };
  };
}
