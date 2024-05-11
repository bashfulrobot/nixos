{ pkgs, config, lib, ... }:
let
  cfg = config.cli.helix;
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {

  options = {
    cli.helix.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable helix editor.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = with pkgs;
      [
        helix
        helix-gpt
      ];

    home-manager.users."${username}" = {
      home = {

        sessionVariables = { EDITOR = "hx"; };

        # file."config.lua" = {
        #   source = ./config/config.lua;
        #   target = ".config/lvim/config.lua";
        # };

      };
    };
  };
}
