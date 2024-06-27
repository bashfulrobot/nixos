{ user-settings, pkgs, secrets, config, lib, ... }:
let cfg = config.cli.direnv;

in {
  options = {
    cli.direnv.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable direnv and envsubst.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ direnv envsubst ];

    home-manager.users."${user-settings.user.username}" = {

    };
  };
}
