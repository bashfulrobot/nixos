{ pkgs, config, lib, ... }:
let
  cfg = config.cli.jeezyvim;
  username = if builtins.getEnv "SUDO_USER" != "" then
    builtins.getEnv "SUDO_USER"
  else
    builtins.getEnv "USER";
in {

  options = {
    cli.jeezyvim.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable jeezyvim editor.";
    };
  };

  config = lib.mkIf cfg.enable {

    # environment.systemPackages = with pkgs;
    #   [
    #     jeezyvim # opinionated neovim
    #   ];

    home-manager.users."${username}" = {
      home = {

        packages = with pkgs;
          [
            jeezyvim # opinionated neovim
          ];

        sessionVariables = { EDITOR = "jvim"; };

        # file."config.lua" = {
        #   source = ./config/config.lua;
        #   target = ".config/lvim/config.lua";
        # };

      };
    };
  };
}
