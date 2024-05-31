{ pkgs, config, lib, ... }:
let
  cfg = config.cli.lunarvim;
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {

  options = {
    cli.lunarvim.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable lunarvim editor.";
    };
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = with pkgs;
      [
        lunarvim # opinionated neovim
      ];

    home-manager.users."${username}" = {
      home = {

        sessionVariables = { EDITOR = "lvim"; };

        # file."config.lua" = {
        #   source = ./config/config.lua;
        #   target = ".config/lvim/config.lua";
        # };

      };
    };
  };
}
