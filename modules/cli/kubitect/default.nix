{ user-settings, pkgs, config, lib, ... }:

let
  cfg = config.cli.kubitect;
  kubitect = pkgs.callPackage ./build { };


in {

  options = {
    cli.kubitect.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable kubitect.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users."${user-settings.user.username}" = {
      home.packages = with pkgs; [
        kubitect
        # dependencies
        virtualenv
        # git - installed globally
        # python - installed globally
      ];
    };
  };
}
