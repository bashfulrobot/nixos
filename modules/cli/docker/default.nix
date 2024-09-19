{ user-settings, pkgs, inputs, lib, config, ... }:
let cfg = config.cli.docker;

in {
  options = {
    cli.docker.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Docker CLI.";
    };
  };

  config = lib.mkIf cfg.enable {

    # Add user to libvirtd group
    users.users."${user-settings.user.username}".extraGroups = [ "docker" ];

    virtualisation = {
      docker = {
        enable = true;
        autoPrune = {
          enable = true;
          dates = "weekly";
        };
      };
    };

  };
}
