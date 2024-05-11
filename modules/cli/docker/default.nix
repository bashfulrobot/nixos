{ pkgs, inputs, lib, config, ... }:
let
  cfg = config.cli.docker;
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
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
  users.users."${username}".extraGroups = [ "docker" ];

  virtualisation = {
    docker.enable = true;
  };

  };
}
